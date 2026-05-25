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

  // 100%-off codes MUST take the comp branch (no Stripe call).
  // Stripe refuses to create a $0 PaymentIntent — there's nothing to
  // confirm, so no clientSecret comes back and the redemption fails.
  // The admin form prevents creating "100% off + require card" rows
  // going forward, but we also override here so any legacy rows with
  // that configuration redeem correctly. A true "free trial that
  // converts to paid" flow would need stripe trial_period_days, not
  // a 100% coupon — out of scope for the current promo system.
  const isFree = row.percent_off >= 100
  const effectiveRequiresCard = isFree ? false : row.requires_credit_card

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
