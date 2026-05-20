-- 026_is_comped.sql
--
-- Admin-comped subscribers: paid-tier feature access without going
-- through Stripe. Use cases: friends/family/beta testers, refund-as-comp,
-- VIP access, support credits.
--
-- Design: `is_comped` is an INDEPENDENT signal alongside `tier`. The
-- app's "is this subscriber paid?" check becomes:
--
--     tier = 'paid' OR is_comped = true
--
-- Why not just flip `tier`? Because the Stripe webhook owns `tier` and
-- will keep clobbering it (e.g. webhook flips them back to 'free' when
-- they don't have an active subscription). A separate flag keeps comp
-- state immune to Stripe events.
--
-- Audit signal: if both are set, the subscriber paid AND is comped —
-- rare but possible (you comped someone, then they upgraded for real).
-- Admin UI surfaces both flags so you can see what's going on.

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS is_comped boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS comped_at timestamptz,
  ADD COLUMN IF NOT EXISTS comped_reason text;

-- Index for the admin "show me everyone who's comped" filter.
CREATE INDEX IF NOT EXISTS subscribers_is_comped_idx
  ON subscribers(is_comped) WHERE is_comped = true;
