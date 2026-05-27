// Shared promo-code validation. Used by both the public validate
// endpoint (GET /api/checkout/validate-code) and the redemption path
// (POST /api/billing/create-subscription). Single source of truth so
// the client preview and the server-side enforcement can't drift.

import type { SupabaseClient } from '@supabase/supabase-js'
import { type BillingPlan, listPriceCentsForPlan } from '@/lib/stripe'

export type DiscountCodeRow = {
  id: string
  code: string
  plan_types: string[]
  percent_off: number
  duration_months: number
  expires_at: string  // YYYY-MM-DD
  requires_credit_card: boolean
  active: boolean
  max_redemptions: number | null
}

export type ValidationOk = {
  valid: true
  row: DiscountCodeRow
  percent_off: number
  requires_credit_card: boolean
  duration_months: number
  list_price_cents: number
  discounted_amount_cents: number
  message: string
}

export type ValidationFail = {
  valid: false
  message: string
}

export type ValidationResult = ValidationOk | ValidationFail

// Centralised lookup + rule evaluation. Reads:
//   1. The code exists (case-insensitive match)
//   2. active = true
//   3. expires_at >= today
//   4. plan is in plan_types
//   5. (optional) max_redemptions hasn't been hit yet — counted via
//      subscribers.promo_code = code
//
// Returns a tagged-union result so callers don't have to repeat the
// "valid + reason" branching.
export async function validateDiscountCode(
  service: SupabaseClient,
  rawCode: string,
  plan: BillingPlan,
): Promise<ValidationResult> {
  const code = rawCode.trim().toUpperCase()
  if (!code) return { valid: false, message: 'Enter a code.' }

  // ilike with the literal works for case-insensitive lookup on the
  // codes table (we store uppercase anyway, but defense in depth).
  const { data: row, error } = await service
    .from('discount_codes')
    .select('id, code, plan_types, percent_off, duration_months, expires_at, requires_credit_card, active, max_redemptions')
    .ilike('code', code)
    .maybeSingle()

  if (error) {
    console.error('[validateDiscountCode] lookup error:', JSON.stringify(error))
    return { valid: false, message: 'Could not validate code.' }
  }
  if (!row) {
    return { valid: false, message: 'That code isn’t valid.' }
  }
  if (!row.active) {
    return { valid: false, message: 'That code is no longer active.' }
  }
  // YYYY-MM-DD direct compare works because of ISO string ordering.
  const today = new Date().toISOString().slice(0, 10)
  if (row.expires_at < today) {
    return { valid: false, message: 'That code has expired.' }
  }
  if (!row.plan_types.includes(plan)) {
    return { valid: false, message: 'That code can’t be used on this plan.' }
  }

  // Max redemptions: optional cap. We count current redemptions via
  // subscribers.promo_code so it stays accurate without a separate
  // counter column (which would race under concurrent redemptions).
  if (row.max_redemptions != null) {
    const { count } = await service
      .from('subscribers')
      .select('id', { count: 'exact', head: true })
      .ilike('promo_code', code)
    if (count != null && count >= row.max_redemptions) {
      return { valid: false, message: 'That code has reached its redemption limit.' }
    }
  }

  const listPriceCents = listPriceCentsForPlan(plan)
  const discountedAmountCents = Math.round(
    listPriceCents * (1 - row.percent_off / 100),
  )

  // requires_credit_card is fully derivable from percent_off in the
  // current implementation, so we override the row's stored value
  // here rather than trust it:
  //   percent_off >= 100 → no card collected, comp branch ($0 totals
  //                        can't pass through Stripe anyway)
  //   percent_off <  100 → card required, charge the discounted
  //                        amount through Stripe
  // Why we override rather than trust the row: the admin used to be
  // able to uncheck "Require credit card" for a partial-discount
  // code, which silently turned an "89% off" code into "100% free
  // for the duration" because the comp branch doesn't look at
  // percent_off at all. Forcing the relationship here heals existing
  // bad rows automatically. A real free-trial-converts-to-paid flow
  // would need stripe trial_period_days; that's a separate feature.
  const isFree = row.percent_off >= 100
  const effectiveRequiresCard = !isFree

  const monthsLabel = row.duration_months === 1
    ? '1 month'
    : `${row.duration_months} months`
  const message = isFree
    ? `${monthsLabel} free — no credit card required`
    : `${row.percent_off}% off for ${monthsLabel}`

  return {
    valid: true,
    row,
    percent_off: row.percent_off,
    requires_credit_card: effectiveRequiresCard,
    duration_months: row.duration_months,
    list_price_cents: listPriceCents,
    discounted_amount_cents: discountedAmountCents,
    message,
  }
}
