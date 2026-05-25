-- In-app promo code system.
--
-- Separate from Stripe's promotion_codes API for two reasons:
--   1. Per-charge fees — even $0 transactions count as Stripe account
--      activity and surface in the dashboard. Running 100%-off codes
--      through Stripe creates noise and (depending on tier) fees.
--   2. Friends-and-family / comp accounts — for these we don't want
--      to collect a card at all. Skipping Stripe entirely means the
--      user activates without any payment-method step.
--
-- The two-branch design:
--   - requires_credit_card=true  (partial discount) → existing Stripe
--     Elements flow, but charge the discounted amount. Renews at full
--     price after duration_months.
--   - requires_credit_card=false (100% off / free)  → no Stripe call.
--     Subscriber row gets subscription_status='comped' + a
--     comp_expires_at timestamp. The /api/account self-heal flips
--     them back to free when the timestamp passes — no cron needed.

CREATE TABLE IF NOT EXISTS discount_codes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  -- Stored uppercase. The unique index below is on UPPER(code) so
  -- "launch50", "LAUNCH50", "Launch50" all collide at insert time.
  code TEXT NOT NULL,
  -- Which plan keys this code is valid for. Postgres text[] (not the
  -- spec's JSON) because it gives us cheap array containment queries
  -- (`'monthly' = ANY(plan_types)`) and an easy GIN index later if we
  -- want one. Stored as the literal Plan strings from lib/stripe.ts.
  plan_types TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
  -- 0-100. REAL not SMALLINT so future "12.5% off" works without a
  -- migration.
  percent_off REAL NOT NULL,
  -- How long the discount lasts. After this many months the discount
  -- ends — for credit-card flows, billing renews at full list price;
  -- for comped flows, comp_expires_at fires and access reverts to free.
  duration_months INTEGER NOT NULL,
  -- When the *code itself* becomes unusable for new redemptions.
  -- (Distinct from per-subscription access expiry.)
  expires_at DATE NOT NULL,
  -- The whole point of this system: 0 = no card collected, no Stripe
  -- call at all.
  requires_credit_card BOOLEAN NOT NULL DEFAULT TRUE,
  -- Soft on/off. Lets admin pause a code without deleting it (and
  -- losing the times_used analytics).
  active BOOLEAN NOT NULL DEFAULT TRUE,
  -- Optional cap on total redemptions across all customers. NULL = no cap.
  max_redemptions INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by TEXT,

  CONSTRAINT discount_codes_percent_off_range
    CHECK (percent_off >= 0 AND percent_off <= 100),
  CONSTRAINT discount_codes_duration_months_positive
    CHECK (duration_months >= 1),
  CONSTRAINT discount_codes_max_redemptions_positive
    CHECK (max_redemptions IS NULL OR max_redemptions >= 1)
);

-- Case-insensitive uniqueness. Matches what the validate endpoint
-- does on lookup (UPPER(code) = UPPER($1)).
CREATE UNIQUE INDEX IF NOT EXISTS discount_codes_code_upper_idx
  ON discount_codes(UPPER(code));

-- For "show me all active, non-expired codes" admin views.
CREATE INDEX IF NOT EXISTS discount_codes_active_expires_idx
  ON discount_codes(active, expires_at);

-- ── subscribers extensions ──────────────────────────────────────────
--
-- promo_code   — the code used on the most recent redemption. Lets us
--                LEFT JOIN COUNT for the admin times_used display
--                without a separate redemptions table.
-- comp_expires_at — when a comped (100%-off) subscription's free
--                   access ends. NULL for non-comped subscribers and
--                   for subscribers whose comp has already been
--                   reclaimed.

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS promo_code TEXT;

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS comp_expires_at TIMESTAMPTZ;

-- For the periodic / on-read self-heal that downgrades expired
-- comped subscribers back to free.
CREATE INDEX IF NOT EXISTS subscribers_comp_expires_at_idx
  ON subscribers(comp_expires_at)
  WHERE comp_expires_at IS NOT NULL;

-- For the admin's times_used join: COUNT subscribers grouped by
-- UPPER(promo_code).
CREATE INDEX IF NOT EXISTS subscribers_promo_code_upper_idx
  ON subscribers(UPPER(promo_code))
  WHERE promo_code IS NOT NULL;
