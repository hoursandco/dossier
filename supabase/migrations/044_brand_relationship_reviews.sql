-- Admin-reviewed relationships between two store records.
--
-- Decisions:
--   unrelated    Distinct brands; hide this pair from the alias audit.
--   parent_child Directional family relationship. Searching/watching the
--                parent includes the child, while the child stays specific.
--   equivalent   Two records/names represent the same brand; match both ways.

CREATE TABLE IF NOT EXISTS brand_relationship_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_a_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  store_b_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  decision TEXT NOT NULL CHECK (decision IN ('unrelated', 'parent_child', 'equivalent')),
  parent_store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  child_store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
  reviewed_by_email TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT brand_relationship_distinct_stores CHECK (store_a_id <> store_b_id),
  CONSTRAINT brand_relationship_direction CHECK (
    (
      decision = 'parent_child'
      AND parent_store_id IS NOT NULL
      AND child_store_id IS NOT NULL
      AND parent_store_id <> child_store_id
      AND parent_store_id IN (store_a_id, store_b_id)
      AND child_store_id IN (store_a_id, store_b_id)
    )
    OR (
      decision IN ('unrelated', 'equivalent')
      AND parent_store_id IS NULL
      AND child_store_id IS NULL
    )
  ),
  UNIQUE (store_a_id, store_b_id)
);

CREATE INDEX IF NOT EXISTS brand_relationship_parent_idx
  ON brand_relationship_reviews(parent_store_id)
  WHERE decision = 'parent_child';

CREATE INDEX IF NOT EXISTS brand_relationship_child_idx
  ON brand_relationship_reviews(child_store_id)
  WHERE decision = 'parent_child';

ALTER TABLE brand_relationship_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE brand_relationship_reviews FORCE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION update_brand_relationship_reviews_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS brand_relationship_reviews_updated_at_trigger
  ON brand_relationship_reviews;
CREATE TRIGGER brand_relationship_reviews_updated_at_trigger
  BEFORE UPDATE ON brand_relationship_reviews
  FOR EACH ROW
  EXECUTE FUNCTION update_brand_relationship_reviews_updated_at();
