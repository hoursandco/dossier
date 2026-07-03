-- Rename the historical misspelled furniture category slug everywhere.

CREATE TEMP TABLE _category_slug_rename (
  old_slug text NOT NULL,
  new_slug text NOT NULL
) ON COMMIT DROP;

INSERT INTO _category_slug_rename (old_slug, new_slug)
VALUES (concat('furna', 'ture'), 'furniture');

INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial)
SELECT
  r.new_slug,
  c.label,
  c.group_name,
  c.sort_order,
  c.is_active,
  c.is_editorial
FROM categories c
CROSS JOIN _category_slug_rename r
WHERE c.slug = r.old_slug
ON CONFLICT (slug) DO UPDATE
SET
  label = EXCLUDED.label,
  group_name = EXCLUDED.group_name,
  sort_order = EXCLUDED.sort_order,
  is_active = EXCLUDED.is_active,
  is_editorial = EXCLUDED.is_editorial;

INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial)
VALUES ('furniture', 'Furniture', 'Home', 417, TRUE, FALSE)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO retailer_categories (retailer, category_slug, is_primary)
SELECT rc.retailer, r.new_slug, rc.is_primary
FROM retailer_categories rc
CROSS JOIN _category_slug_rename r
WHERE rc.category_slug = r.old_slug
ON CONFLICT (retailer, category_slug) DO NOTHING;

DELETE FROM retailer_categories rc
USING _category_slug_rename r
WHERE rc.category_slug = r.old_slug;

INSERT INTO subscriber_watches (
  subscriber_id,
  category_slug,
  sub_type,
  gender,
  min_price_tier
)
SELECT
  sw.subscriber_id,
  r.new_slug,
  sw.sub_type,
  sw.gender,
  sw.min_price_tier
FROM subscriber_watches sw
CROSS JOIN _category_slug_rename r
WHERE sw.category_slug = r.old_slug
ON CONFLICT (subscriber_id, category_slug, sub_type, gender, min_price_tier) DO NOTHING;

DELETE FROM subscriber_watches sw
USING _category_slug_rename r
WHERE sw.category_slug = r.old_slug;

UPDATE deals
SET categories = (
  SELECT ARRAY(
    SELECT DISTINCT CASE WHEN category = r.old_slug THEN r.new_slug ELSE category END
    FROM unnest(deals.categories) AS category
  )
  FROM _category_slug_rename r
)
WHERE (SELECT old_slug FROM _category_slug_rename) = ANY(categories);

UPDATE stores
SET categories = (
  SELECT ARRAY(
    SELECT DISTINCT CASE WHEN category = r.old_slug THEN r.new_slug ELSE category END
    FROM unnest(stores.categories) AS category
  )
  FROM _category_slug_rename r
)
WHERE (SELECT old_slug FROM _category_slug_rename) = ANY(categories);

UPDATE ingest_deal_candidates
SET categories = (
  SELECT ARRAY(
    SELECT DISTINCT CASE WHEN category = r.old_slug THEN r.new_slug ELSE category END
    FROM unnest(ingest_deal_candidates.categories) AS category
  )
  FROM _category_slug_rename r
)
WHERE (SELECT old_slug FROM _category_slug_rename) = ANY(categories);

UPDATE ingest_deal_candidates i
SET raw_candidate = replace(
  i.raw_candidate::text,
  concat('"', r.old_slug, '"'),
  concat('"', r.new_slug, '"')
)::jsonb
FROM _category_slug_rename r
WHERE i.raw_candidate::text LIKE concat('%"', r.old_slug, '"%');

UPDATE email_extraction_jobs j
SET
  production_output = replace(j.production_output::text, concat('"', r.old_slug, '"'), concat('"', r.new_slug, '"'))::jsonb,
  normalized_output = replace(j.normalized_output::text, concat('"', r.old_slug, '"'), concat('"', r.new_slug, '"'))::jsonb
FROM _category_slug_rename r
WHERE j.production_output::text LIKE concat('%"', r.old_slug, '"%')
  OR j.normalized_output::text LIKE concat('%"', r.old_slug, '"%');

UPDATE email_extraction_attempts a
SET normalized_output = replace(a.normalized_output::text, concat('"', r.old_slug, '"'), concat('"', r.new_slug, '"'))::jsonb
FROM _category_slug_rename r
WHERE a.normalized_output::text LIKE concat('%"', r.old_slug, '"%');

UPDATE email_extraction_comparisons c
SET
  production_output = replace(c.production_output::text, concat('"', r.old_slug, '"'), concat('"', r.new_slug, '"'))::jsonb,
  shadow_output = replace(c.shadow_output::text, concat('"', r.old_slug, '"'), concat('"', r.new_slug, '"'))::jsonb,
  details = replace(c.details::text, concat('"', r.old_slug, '"'), concat('"', r.new_slug, '"'))::jsonb
FROM _category_slug_rename r
WHERE c.production_output::text LIKE concat('%"', r.old_slug, '"%')
  OR c.shadow_output::text LIKE concat('%"', r.old_slug, '"%')
  OR c.details::text LIKE concat('%"', r.old_slug, '"%');

DELETE FROM categories c
USING _category_slug_rename r
WHERE c.slug = r.old_slug;
