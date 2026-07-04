-- 050_content_model_consolidation.sql
--
-- Phase 1 (additive + backfill) of collapsing the content/data model down
-- to three core tables: categories, stores, deals.
--
--   1. categories.search_terms — alias terms ("skin care") that map a
--      free-typed search onto the canonical slug ("skincare"). Read by
--      /api/deals/search at query time.
--   2. deals.keywords — guaranteed non-null with a '{}' default; existing
--      values lowercased/trimmed/deduped; deal_subtype folded in so item
--      search and watch sub_type matching have one home.
--   3. retailer_categories → stores.categories — the per-retailer content
--      tags move onto the store row itself, matched by normalized name,
--      preserving whatever slugs the store already carries.
--
-- Safe to apply BEFORE the code deploy: nothing is dropped here. The
-- destructive half (drop retailer_categories, drop deals.deal_subtype)
-- lives in migration 051 and must only run AFTER the code that stops
-- referencing them is live.
--
-- subscriber_watches.category_slug and deals.categories are untouched —
-- watchlist matching keeps working through the same slugs. deals.
-- source_email_link is untouched.

-- ── 1. Category search aliases ─────────────────────────────────────────
ALTER TABLE categories
  ADD COLUMN IF NOT EXISTS search_terms text[] NOT NULL DEFAULT '{}';

-- Seed aliases for slugs whose canonical form doesn't fall out of simple
-- normalization (the search layer already handles plurals, "&"/"and", and
-- hyphen/space differences). Merge + dedupe so re-running is safe and any
-- admin-added aliases survive.
UPDATE categories c
SET search_terms = (
  SELECT array_agg(DISTINCT t ORDER BY t)
  FROM unnest(c.search_terms || v.terms) AS t
)
FROM (VALUES
  ('skincare',              ARRAY['skin care']),
  ('hair-care',             ARRAY['haircare']),
  ('bed-bath',              ARRAY['bedding', 'towels', 'sheets']),
  ('eyeglasses-sunglasses', ARRAY['glasses', 'eyewear']),
  ('underwear-intimates',   ARRAY['lingerie', 'intimates']),
  ('outerwear-coats',       ARRAY['coats', 'jackets', 'outerwear']),
  ('pajamas-sleepwear',     ARRAY['pjs', 'pajamas', 'sleepwear']),
  ('tech-electronics',      ARRAY['electronics', 'tech', 'gadgets']),
  ('kitchen-cooking',       ARRAY['cookware', 'kitchenware']),
  ('vitamins-supplements',  ARRAY['supplements', 'vitamins']),
  ('fragrance',             ARRAY['perfume', 'cologne', 'fragrances']),
  ('toys-games',            ARRAY['toys', 'games']),
  ('meal-kits',             ARRAY['meal delivery', 'meal kit']),
  ('wine-alcohol',          ARRAY['liquor', 'spirits', 'beer'])
) AS v(slug, terms)
WHERE c.slug = v.slug;

-- ── 2. deals.keywords: default + normalize + fold deal_subtype in ─────
ALTER TABLE deals ALTER COLUMN keywords SET DEFAULT '{}';

UPDATE deals SET keywords = '{}' WHERE keywords IS NULL;

-- Lowercase, trim, dedupe every keyword and merge the legacy deal_subtype
-- value into the array. COALESCE guards rows whose keywords collapse to
-- nothing (all-blank entries, no subtype).
UPDATE deals d
SET keywords = COALESCE(
  (
    SELECT array_agg(DISTINCT k ORDER BY k)
    FROM (
      SELECT lower(trim(t)) AS k
      FROM unnest(
        d.keywords ||
        CASE WHEN d.deal_subtype IS NOT NULL THEN ARRAY[d.deal_subtype] ELSE ARRAY[]::text[] END
      ) AS t
      WHERE trim(t) <> ''
    ) s
  ),
  '{}'
);

-- ── 3. retailer_categories → stores.categories ────────────────────────
-- Match retailer names to store names the same way the app does: lowercase
-- and strip everything that isn't a letter or digit, so "J.Crew" /
-- "J. Crew" / "jcrew" collapse to one key. Existing stores.categories
-- values (editorial Collections included) are preserved and deduped.
-- retailer_categories rows with no matching store are left behind — they
-- were only ever reachable through a store row, so there's nothing to lose.
WITH rc AS (
  SELECT
    lower(regexp_replace(retailer, '[^a-zA-Z0-9]', '', 'g')) AS norm_name,
    array_agg(DISTINCT category_slug) AS slugs
  FROM retailer_categories
  GROUP BY 1
)
UPDATE stores s
SET categories = (
  SELECT array_agg(DISTINCT c ORDER BY c)
  FROM unnest(COALESCE(s.categories, '{}') || rc.slugs) AS c
)
FROM rc
WHERE lower(regexp_replace(s.name, '[^a-zA-Z0-9]', '', 'g')) = rc.norm_name;
