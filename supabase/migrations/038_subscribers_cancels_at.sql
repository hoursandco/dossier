-- Track when a paid subscription is scheduled to cancel.
--
-- When a customer hits "Cancel" in Stripe's billing portal (or we
-- call subscriptions.update with cancel_at_period_end=true via the
-- unsubscribe endpoint), Stripe flags the sub as scheduled-to-
-- cancel but doesn't actually delete it until current_period_end.
-- They keep paid features until then.
--
-- The customer.subscription.updated webhook fires when this happens.
-- We capture the scheduled-cancellation timestamp here so the UI
-- can show "cancels MMM D" in the SIGNED IN banner — otherwise a
-- returning user would see "Personal Shopper" with no hint that
-- they're already heading out, and panic when the access expires.
--
-- Stripe surfaces this as subscription.cancel_at (Unix seconds when
-- cancel_at_period_end=true; null when the sub is renewing
-- normally). The webhook converts to ISO + writes here.
--
-- Cleared (NULL) on customer.subscription.deleted when the sub
-- actually expires, OR if the user undoes the cancel via the portal
-- (Stripe flips cancel_at back to null and we mirror it).

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS cancels_at TIMESTAMPTZ;
