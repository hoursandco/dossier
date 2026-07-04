-- 054_brand_relationships_on_stores.sql
--
-- Fold brand_relationship_reviews (migration 044) into columns on stores,
-- continuing the content-model consolidation (050-052).
--
--   parent_store_id      This store is a child brand of another store
--                        (PINK → Victoria's Secret). Watching/searching
--                        the parent includes the child; the child stays
--                        specific. One-way, matching the old
--                        decision='parent_child'.
--   alias_of_store_id    This store row is the same brand as another row
--                        under a different name (Altra Running → Altra).
--                        Matches expand both ways, matching the old
--                        decision='equivalent'. The pointed-at row is the
--                        canonical one.
--   unrelated_store_ids  Alias-audit dismissals ("these two are distinct
--                        brands — stop suggesting them"). Stored on the
--                        lexicographically-smaller store id of the pair,
--                        mirroring orderedStorePair() in the app.
--
-- Safe to apply BEFORE the code deploy: purely additive. The drop of
-- brand_relationship_reviews lives in migration 055 (post-deploy only).

ALTER TABLE stores
  ADD COLUMN IF NOT EXISTS parent_store_id uuid REFERENCES stores(id) ON DELETE SET NULL;
ALTER TABLE stores
  ADD COLUMN IF NOT EXISTS alias_of_store_id uuid REFERENCES stores(id) ON DELETE SET NULL;
ALTER TABLE stores
  ADD COLUMN IF NOT EXISTS unrelated_store_ids uuid[] NOT NULL DEFAULT '{}';

CREATE INDEX IF NOT EXISTS stores_parent_store_idx
  ON stores(parent_store_id) WHERE parent_store_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS stores_alias_of_store_idx
  ON stores(alias_of_store_id) WHERE alias_of_store_id IS NOT NULL;

-- ── Backfill from brand_relationship_reviews ──────────────────────────

-- parent_child: the child row points at its parent.
UPDATE stores s
SET parent_store_id = r.parent_store_id
FROM brand_relationship_reviews r
WHERE r.decision = 'parent_child'
  AND r.child_store_id = s.id;

-- equivalent: store_a_id is always the lexicographically-smaller id (the
-- review endpoint orders the pair before writing), so treat it as the
-- canonical row and point store_b at it.
UPDATE stores s
SET alias_of_store_id = r.store_a_id
FROM brand_relationship_reviews r
WHERE r.decision = 'equivalent'
  AND r.store_b_id = s.id;

-- unrelated: aggregate each store_a's dismissed partners into its array.
UPDATE stores s
SET unrelated_store_ids = sub.ids
FROM (
  SELECT store_a_id, array_agg(DISTINCT store_b_id) AS ids
  FROM brand_relationship_reviews
  WHERE decision = 'unrelated'
  GROUP BY store_a_id
) sub
WHERE s.id = sub.store_a_id;
