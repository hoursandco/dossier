-- 025_deals_categories_gin.sql
--
-- GIN index on deals.categories (TEXT[]) so per-subscriber filtering
-- can run as a Postgres array-overlap operator instead of pulling every
-- recent deal into the app and filtering in JS.
--
-- After this index lands, the watchlist-send query in lib/watchlistSend.ts
-- can do:
--
--     .select('*')
--     .gte('created_at', sinceIso)
--     .overlaps('categories', subscriberCategorySlugs)
--
-- The `&&` operator (what .overlaps() compiles to) is GIN-friendly:
-- planner uses the index for any-element-matches lookups, scales with
-- match selectivity rather than total deal count.

CREATE INDEX IF NOT EXISTS deals_categories_gin_idx
  ON deals USING GIN (categories);
