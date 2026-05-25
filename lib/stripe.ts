import Stripe from 'stripe'

let _stripe: Stripe | null = null

export function getStripe(): Stripe {
  if (_stripe) return _stripe
  const key = process.env.STRIPE_SECRET_KEY
  if (!key) {
    throw new Error('STRIPE_SECRET_KEY is not configured')
  }
  _stripe = new Stripe(key, {
    apiVersion: '2026-04-22.dahlia',
    typescript: true,
  })
  return _stripe
}

// Only one billing plan now — the $4.99/mo Personal Shopper. The
// $45/year annual was retired. Type left as a union of one literal
// to make it cheap to add additional plans (e.g. an enterprise tier)
// later without re-threading function signatures.
export type BillingPlan = 'monthly'

// Source-of-truth list price (in cents) for plans, used by the
// in-app promo code system to compute discounted totals without a
// Stripe round-trip. Keep this in sync with the price ID in Stripe.
// If we ever change the price, update BOTH this constant AND the
// Stripe price.
const PLAN_LIST_PRICE_CENTS: Record<BillingPlan, number> = {
  monthly: 499,
}

export function listPriceCentsForPlan(plan: BillingPlan): number {
  return PLAN_LIST_PRICE_CENTS[plan]
}

export function priceIdForPlan(plan: BillingPlan): string {
  if (plan === 'monthly') {
    const id = process.env.STRIPE_PRICE_MONTHLY
    if (!id) throw new Error('STRIPE_PRICE_MONTHLY is not configured')
    return id
  }
  throw new Error(`Unknown billing plan: ${plan}`)
}
