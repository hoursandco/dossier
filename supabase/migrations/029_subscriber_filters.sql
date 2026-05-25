-- Paid-tier global filters on the subscriber level.
--
-- Two columns that apply across the subscriber's entire watchlist —
-- not per-watch (per-watch overrides live on subscriber_watches via
-- the unused min_discount + min_price_tier columns).
--
--   min_discount_pct       — only include deals with percent_off >=
--                            this value. Free-shipping / BOGO / free-
--                            item / flash-sale deals (which have no
--                            stated percent_off) pass through
--                            regardless. NULL = no minimum.
--
--   allowed_price_tiers    — only include deals whose retailer's
--                            spend tier is in this array. Empty array
--                            or NULL = no filter (all tiers allowed).
--                            Values are the literal tier strings:
--                            '$', '$$', '$$$', '$$$$'.
--
-- Both columns default to NULL/empty, so existing subscribers see
-- zero behavior change until they actively set a filter. The columns
-- are permissive at the DB layer (no CHECK constraints); free-tier
-- gating is enforced at the app layer so we can loosen it without a
-- schema migration if we ever want to expose these to all tiers.

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS min_discount_pct SMALLINT;

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS allowed_price_tiers TEXT[];

ALTER TABLE subscribers
  ADD CONSTRAINT subscribers_min_discount_pct_range
  CHECK (min_discount_pct IS NULL OR (min_discount_pct >= 1 AND min_discount_pct <= 99));
