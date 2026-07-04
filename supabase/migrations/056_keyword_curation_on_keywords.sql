-- 056_keyword_curation_on_keywords.sql
--
-- Fold item_keyword_reviews (migration 045) into the keywords vocabulary
-- table it curates, continuing the table consolidation (050-055).
--
--   canonical_keyword  merge noisy variants into one customer choice
--                      (groceries → grocery)
--   parent_keyword     keep a specific term visible while including it
--                      under a broader search (eye shadow → makeup)
--   is_hidden          suppress a term from autocomplete without deleting
--                      historical deal keywords
--
-- Safe to apply BEFORE the code deploy: purely additive. The drop of
-- item_keyword_reviews lives in migration 058 (post-deploy only).

ALTER TABLE keywords ADD COLUMN IF NOT EXISTS canonical_keyword text;
ALTER TABLE keywords ADD COLUMN IF NOT EXISTS parent_keyword text;
ALTER TABLE keywords ADD COLUMN IF NOT EXISTS is_hidden boolean NOT NULL DEFAULT false;
ALTER TABLE keywords ADD COLUMN IF NOT EXISTS reviewed_by_email text;
ALTER TABLE keywords ADD COLUMN IF NOT EXISTS reviewed_at timestamptz;

-- Partial index so the search/suggest routes can cheaply fetch only the
-- curated slice of a potentially large vocabulary.
CREATE INDEX IF NOT EXISTS keywords_curated_idx
  ON keywords(keyword)
  WHERE canonical_keyword IS NOT NULL
     OR parent_keyword IS NOT NULL
     OR is_hidden;

-- ── Backfill ───────────────────────────────────────────────────────────

-- Curation may exist for terms that never made it into the vocabulary
-- (an alias the admin typed by hand). Create those rows first so the
-- curation UPDATE below has somewhere to land. deal_count=0 keeps them
-- out of autocomplete ranking on their own merits.
INSERT INTO keywords (keyword, deal_count, last_seen)
SELECT lower(trim(r.keyword)), 0, CURRENT_DATE
FROM item_keyword_reviews r
WHERE trim(r.keyword) <> ''
ON CONFLICT (keyword) DO NOTHING;

UPDATE keywords k
SET canonical_keyword = NULLIF(lower(trim(COALESCE(r.canonical_keyword, ''))), ''),
    parent_keyword    = NULLIF(lower(trim(COALESCE(r.parent_keyword, ''))), ''),
    is_hidden         = r.is_hidden,
    reviewed_by_email = r.reviewed_by_email,
    reviewed_at       = r.updated_at
FROM item_keyword_reviews r
WHERE k.keyword = lower(trim(r.keyword));
