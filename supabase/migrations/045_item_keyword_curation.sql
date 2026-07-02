-- Admin curation for the customer-facing item vocabulary.
--
-- canonical_keyword merges noisy variants into one customer choice:
--   groceries -> grocery
--   food discounts -> food
--
-- parent_keyword keeps a specific term visible while also including it under
-- a broader search:
--   eye shadow -> makeup
--
-- is_hidden suppresses a term from autocomplete without deleting historical
-- deal keywords. A merged alias is also collapsed into its canonical label.

CREATE TABLE IF NOT EXISTS item_keyword_reviews (
  keyword TEXT PRIMARY KEY,
  canonical_keyword TEXT,
  parent_keyword TEXT,
  is_hidden BOOLEAN NOT NULL DEFAULT FALSE,
  reviewed_by_email TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT item_keyword_review_not_self_alias CHECK (
    canonical_keyword IS NULL OR lower(trim(canonical_keyword)) <> lower(trim(keyword))
  )
);

ALTER TABLE item_keyword_reviews
  ADD COLUMN IF NOT EXISTS parent_keyword TEXT;

CREATE INDEX IF NOT EXISTS item_keyword_reviews_canonical_idx
  ON item_keyword_reviews(canonical_keyword)
  WHERE canonical_keyword IS NOT NULL;

CREATE INDEX IF NOT EXISTS item_keyword_reviews_parent_idx
  ON item_keyword_reviews(parent_keyword)
  WHERE parent_keyword IS NOT NULL;

ALTER TABLE item_keyword_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE item_keyword_reviews FORCE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION update_item_keyword_reviews_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS item_keyword_reviews_updated_at_trigger
  ON item_keyword_reviews;
CREATE TRIGGER item_keyword_reviews_updated_at_trigger
  BEFORE UPDATE ON item_keyword_reviews
  FOR EACH ROW
  EXECUTE FUNCTION update_item_keyword_reviews_updated_at();

INSERT INTO item_keyword_reviews (keyword, canonical_keyword, parent_keyword, is_hidden)
VALUES
  ('skin care', 'skincare', NULL, FALSE),
  ('food discounts', 'food', NULL, FALSE),
  ('food tasting', 'food', NULL, FALSE),
  ('foods', 'food', NULL, FALSE),
  ('groceries', 'grocery', NULL, FALSE),
  ('eye shadow', NULL, 'makeup', FALSE),
  ('eyeshadow', 'eye shadow', 'makeup', FALSE)
ON CONFLICT (keyword) DO UPDATE
SET canonical_keyword = EXCLUDED.canonical_keyword,
    parent_keyword = EXCLUDED.parent_keyword,
    is_hidden = EXCLUDED.is_hidden;
