-- Collapse repeated imports of the same brand list.
--
-- The May 27 category refresh accidentally included the brand CSV again.
-- Because the old unique index only checks LOWER(website), rows like
-- https://brand.com and https://www.brand.com can coexist and then flood
-- the Duplicate Stores review queue. This migration removes only exact
-- same-brand repeats under the same normalized website. Different brand
-- names sharing an apex domain remain for human review/dismissal.

CREATE OR REPLACE FUNCTION dd_normalized_store_website(raw text)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  host text;
  parts text[];
  n int;
  last_two text;
BEGIN
  IF raw IS NULL OR btrim(raw) = '' THEN
    RETURN NULL;
  END IF;

  host := lower(btrim(raw));
  host := regexp_replace(host, '^https?://', '');
  host := split_part(host, '/', 1);
  host := split_part(host, '?', 1);
  host := split_part(host, '#', 1);
  host := regexp_replace(host, '^.*@', '');
  host := regexp_replace(host, '^www\.', '');

  LOOP
    EXIT WHEN host !~ '^(email|mail[0-9]?|em|news|newsletter|newsletters|mkt|mktg|marketing|promo|promos|offers|deals|campaigns|crm|engage|connect|noreply|no-reply|reply|send|notify|notifications|alerts|updates|hello|info|contact|support|link|links|track|tracking|click|clicks|t|r|s|e|m|o|p|q|n|f)\.';
    host := regexp_replace(host, '^(email|mail[0-9]?|em|news|newsletter|newsletters|mkt|mktg|marketing|promo|promos|offers|deals|campaigns|crm|engage|connect|noreply|no-reply|reply|send|notify|notifications|alerts|updates|hello|info|contact|support|link|links|track|tracking|click|clicks|t|r|s|e|m|o|p|q|n|f)\.', '');
  END LOOP;

  IF host !~ '^[a-z0-9.-]+\.[a-z]{2,}$' THEN
    RETURN NULL;
  END IF;

  parts := string_to_array(host, '.');
  n := array_length(parts, 1);
  IF n > 2 THEN
    last_two := parts[n - 1] || '.' || parts[n];
    IF last_two IN ('co.uk','co.in','co.jp','co.kr','co.nz','co.za','com.au','com.br','com.mx','com.sg','com.tw','org.uk','ac.uk') THEN
      host := parts[n - 2] || '.' || parts[n - 1] || '.' || parts[n];
    ELSE
      host := parts[n - 1] || '.' || parts[n];
    END IF;
  END IF;

  RETURN 'https://' || host;
END;
$$;

CREATE OR REPLACE FUNCTION dd_normalized_store_name(raw text)
RETURNS text
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT regexp_replace(lower(coalesce(raw, '')), '[^a-z0-9]+', '', 'g');
$$;

CREATE TEMP TABLE _dd_store_import_losers ON COMMIT DROP AS
WITH ranked AS (
  SELECT
    id,
    dd_normalized_store_website(website) AS normalized_website,
    dd_normalized_store_name(name) AS normalized_name,
    first_value(id) OVER (
      PARTITION BY dd_normalized_store_website(website), dd_normalized_store_name(name)
      ORDER BY updated_at DESC NULLS LAST, created_at DESC NULLS LAST, is_active DESC, cardinality(categories) DESC, id
    ) AS keeper_id,
    row_number() OVER (
      PARTITION BY dd_normalized_store_website(website), dd_normalized_store_name(name)
      ORDER BY updated_at DESC NULLS LAST, created_at DESC NULLS LAST, is_active DESC, cardinality(categories) DESC, id
    ) AS rn
  FROM stores
  WHERE dd_normalized_store_website(website) IS NOT NULL
    AND dd_normalized_store_name(name) <> ''
),
losers AS (
  SELECT id AS loser_id, keeper_id
  FROM ranked
  WHERE rn > 1
)
SELECT loser_id, keeper_id
FROM losers;

INSERT INTO subscriber_stores (subscriber_id, store_id, created_at)
SELECT ss.subscriber_id, l.keeper_id, min(ss.created_at)
FROM subscriber_stores ss
JOIN _dd_store_import_losers l ON l.loser_id = ss.store_id
GROUP BY ss.subscriber_id, l.keeper_id
ON CONFLICT (subscriber_id, store_id) DO NOTHING;

DELETE FROM subscriber_stores ss
USING _dd_store_import_losers l
WHERE ss.store_id = l.loser_id;

DELETE FROM stores s
USING _dd_store_import_losers l
WHERE s.id = l.loser_id;
