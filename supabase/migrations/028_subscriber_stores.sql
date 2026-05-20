-- 028_subscriber_stores.sql
--
-- Adds individual-store picks alongside the existing category-based
-- watchlist. A subscriber can now "watch" a specific brand (e.g.
-- J.Crew) in addition to a category (e.g. Skincare).
--
-- The free-tier 3-pick limit is enforced ACROSS both tables combined:
--   watches  + store_picks  <= 3   (free tier)
--   unlimited                      (paid / comped tier)
--
-- The watchlist email's deal query also unions both:
--   deals WHERE categories overlap user's category_slugs
--   OR    retailer matches one of user's picked store names
--
-- Also adds last_ondemand_send_at to subscribers so we can enforce
-- the free-tier "1 self-send per week" cap on /api/deals/refresh.
-- The Thursday cron uses last_weekly_email_at (separate field) and
-- still runs for all tiers.

CREATE TABLE IF NOT EXISTS subscriber_stores (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  subscriber_id   uuid NOT NULL REFERENCES subscribers(id) ON DELETE CASCADE,
  store_id        uuid NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  created_at      timestamptz NOT NULL DEFAULT now(),
  UNIQUE (subscriber_id, store_id)
);

CREATE INDEX IF NOT EXISTS subscriber_stores_subscriber_idx
  ON subscriber_stores (subscriber_id);
CREATE INDEX IF NOT EXISTS subscriber_stores_store_idx
  ON subscriber_stores (store_id);

ALTER TABLE subscriber_stores ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriber_stores FORCE ROW LEVEL SECURITY;

-- Self-send rate-limit tracking. Separate from last_weekly_email_at
-- so the Thursday cron and the on-demand button don't share state.
ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS last_ondemand_send_at timestamptz;

CREATE INDEX IF NOT EXISTS subscribers_last_ondemand_send_at_idx
  ON subscribers (last_ondemand_send_at);
