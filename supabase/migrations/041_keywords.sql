-- 041_keywords.sql
--
-- Adds keyword-level search infrastructure.
--
-- 1. deals.keywords (text[]) — product terms extracted from each email
--    by the LLM, e.g. ["sneakers","running shoes","boots"]. GIN-indexed
--    for fast ANY(keywords) lookups.
--
-- 2. keywords table — global vocabulary that self-populates on every
--    deal insert. Powers the autocomplete endpoint (/api/keywords/suggest)
--    sorted by deal_count so the most common terms surface first.

ALTER TABLE deals ADD COLUMN IF NOT EXISTS keywords text[];

CREATE INDEX IF NOT EXISTS deals_keywords_gin
  ON deals USING GIN (keywords);

CREATE TABLE IF NOT EXISTS keywords (
  keyword    text    PRIMARY KEY,
  deal_count integer NOT NULL DEFAULT 1,
  last_seen  date    NOT NULL DEFAULT CURRENT_DATE
);

-- Function used by the ingest pipeline to increment deal_count on conflict
-- rather than resetting it. Accepts an array so we make a single call per deal.
CREATE OR REPLACE FUNCTION upsert_keywords(kws text[])
RETURNS void LANGUAGE sql AS $$
  INSERT INTO keywords (keyword, deal_count, last_seen)
  SELECT lower(trim(kw)), 1, CURRENT_DATE
  FROM unnest(kws) AS kw
  WHERE trim(kw) <> ''
  ON CONFLICT (keyword) DO UPDATE
    SET deal_count = keywords.deal_count + 1,
        last_seen  = CURRENT_DATE;
$$;

-- Seed with common shopping terms so autocomplete works immediately
-- before the ingest pipeline has a chance to self-populate the table.
INSERT INTO keywords (keyword, deal_count, last_seen) VALUES
  ('sneakers',         5,  CURRENT_DATE),
  ('running shoes',    4,  CURRENT_DATE),
  ('boots',            4,  CURRENT_DATE),
  ('sandals',          3,  CURRENT_DATE),
  ('heels',            3,  CURRENT_DATE),
  ('dress',            5,  CURRENT_DATE),
  ('jeans',            6,  CURRENT_DATE),
  ('blouse',           3,  CURRENT_DATE),
  ('cardigan',         3,  CURRENT_DATE),
  ('sweater',          4,  CURRENT_DATE),
  ('jacket',           4,  CURRENT_DATE),
  ('couch',            3,  CURRENT_DATE),
  ('sofa',             3,  CURRENT_DATE),
  ('dining table',     2,  CURRENT_DATE),
  ('mattress',         3,  CURRENT_DATE),
  ('skincare',         5,  CURRENT_DATE),
  ('moisturizer',      3,  CURRENT_DATE),
  ('perfume',          3,  CURRENT_DATE),
  ('foundation',       3,  CURRENT_DATE),
  ('lipstick',         3,  CURRENT_DATE),
  ('sunscreen',        2,  CURRENT_DATE),
  ('laptop',           4,  CURRENT_DATE),
  ('headphones',       4,  CURRENT_DATE),
  ('air fryer',        3,  CURRENT_DATE),
  ('coffee maker',     3,  CURRENT_DATE),
  ('yoga pants',       3,  CURRENT_DATE),
  ('leggings',         4,  CURRENT_DATE),
  ('handbag',          4,  CURRENT_DATE),
  ('backpack',         3,  CURRENT_DATE),
  ('luggage',          3,  CURRENT_DATE)
ON CONFLICT (keyword) DO NOTHING;
