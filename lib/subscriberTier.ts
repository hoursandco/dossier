// Single source of truth for "is this subscriber paid?"
//
// Two independent signals make a subscriber paid:
//   1. tier = 'paid' (Stripe-managed — webhook flips it)
//   2. is_comped = true (admin-managed — flipped from /admin)
//
// Always call isPaidSubscriber() instead of checking tier directly.
// That way, comping a subscriber unlocks every paid feature uniformly
// and we never have to remember to add `|| is_comped` at each gate.

export interface SubscriberTierish {
  tier?: string | null
  is_comped?: boolean | null
}

export function isPaidSubscriber(s: SubscriberTierish | null | undefined): boolean {
  if (!s) return false
  return s.tier === 'paid' || s.is_comped === true
}
