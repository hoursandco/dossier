-- 057_duplicate_dismissals_on_stores.sql
--
-- Fold non_duplicate_clusters (migration 027) into the
-- stores.unrelated_store_ids column created by migration 054.
--
-- Old model: a dismissed duplicate-cluster was keyed by its normalized
-- apex domain; any store sharing that apex was hidden from the review
-- panel forever. New model: dismissal marks every PAIR of current
-- cluster members as unrelated. A genuinely new store row joining the
-- same apex later WILL resurface the cluster — that's an improvement
-- (a new potential duplicate deserves a fresh look).
--
-- The apex normalization here mirrors lib/domainNormalize.ts closely
-- enough for backfill: strip protocol/path/credentials/www, validate the
-- host shape, and reduce to the registrable apex (respecting common
-- two-part TLDs). Mail-subdomain stripping is skipped because apex
-- reduction already collapses 'email.brand.com' → 'brand.com'.
--
-- Safe to apply BEFORE the code deploy (additive; requires migration 054
-- to have run first). The drop of non_duplicate_clusters lives in
-- migration 058 (post-deploy only).

CREATE OR REPLACE FUNCTION pg_temp.apex_url(website text) RETURNS text AS $$
DECLARE
  host text;
  parts text[];
  n int;
  last_two text;
BEGIN
  IF website IS NULL OR trim(website) = '' THEN RETURN NULL; END IF;
  host := lower(trim(website));
  host := regexp_replace(host, '^https?://', '');
  host := split_part(split_part(split_part(host, '/', 1), '?', 1), '#', 1);
  host := regexp_replace(host, '^.*@', '');
  host := regexp_replace(host, '^www\.', '');
  IF host !~ '^[a-z0-9.-]+\.[a-z]{2,}$' THEN RETURN NULL; END IF;
  parts := string_to_array(host, '.');
  n := array_length(parts, 1);
  IF n > 2 THEN
    last_two := parts[n-1] || '.' || parts[n];
    IF last_two IN ('co.uk','co.in','co.jp','co.kr','co.nz','co.za',
                    'com.au','com.br','com.mx','com.sg','com.tw',
                    'org.uk','ac.uk') THEN
      host := parts[n-2] || '.' || last_two;
    ELSE
      host := last_two;
    END IF;
  END IF;
  RETURN 'https://' || host;
END;
$$ LANGUAGE plpgsql;

-- Mark every pair inside each dismissed cluster as unrelated. The pair is
-- recorded on the store with the smaller id; readers check both
-- directions, so ordering only needs to be consistent, not identical to
-- the app's string ordering.
WITH members AS (
  SELECT n.normalized_website, s.id
  FROM non_duplicate_clusters n
  JOIN stores s ON pg_temp.apex_url(s.website) = n.normalized_website
),
pairs AS (
  SELECT a.id AS holder_id, b.id AS other_id
  FROM members a
  JOIN members b
    ON a.normalized_website = b.normalized_website
   AND a.id < b.id
),
grouped AS (
  SELECT holder_id, array_agg(DISTINCT other_id) AS ids
  FROM pairs
  GROUP BY holder_id
)
UPDATE stores s
SET unrelated_store_ids = (
  SELECT array_agg(DISTINCT u)
  FROM unnest(s.unrelated_store_ids || g.ids) AS u
)
FROM grouped g
WHERE s.id = g.holder_id;
