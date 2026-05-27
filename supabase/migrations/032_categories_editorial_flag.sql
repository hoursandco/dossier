-- Editorial / "vibe" flag for categories.
--
-- Background: some categories are LLM-derivable from email content
-- (Skincare, Womens Apparel, Athleisure) and some are editorial only
-- (Mall Stores, Boutique, Luxury, Heritage / Legacy — the "vibes"
-- you can't derive from a single deal's text). We were unioning all
-- of stores.categories into deal.categories at ingest, which meant
-- a Best Buy Roomba deal got tagged athleisure just because Best Buy's
-- store row had athleisure in its list. Polluted every section.
--
-- This flag lets the ingest cron be selective: when looking up a
-- store's category list for the per-deal union, only slugs flagged
-- is_editorial=true get added. Content slugs (LLM territory) are
-- left alone. The cron change lives in app/api/cron/ingest/route.ts.
--
-- Default false so existing rows stay non-editorial unless the seed
-- explicitly marks them otherwise.

ALTER TABLE categories
  ADD COLUMN IF NOT EXISTS is_editorial BOOLEAN NOT NULL DEFAULT FALSE;

CREATE INDEX IF NOT EXISTS categories_is_editorial_idx
  ON categories(is_editorial)
  WHERE is_editorial = TRUE;
