-- Merge duplicate restaurant category slugs into the canonical
-- Restaurants & Grocery content category.

CREATE TEMP TABLE _restaurant_category_slug_merge (
  old_slug text PRIMARY KEY,
  new_slug text NOT NULL
) ON COMMIT DROP;

INSERT INTO _restaurant_category_slug_merge (old_slug, new_slug)
VALUES
  ('restaurant', 'restaurants'),
  ('resturant', 'restaurants'),
  ('resturants', 'restaurants');

INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial)
VALUES ('restaurants', 'Restaurants', 'Restaurants & Grocery', 535, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
SET
  label = EXCLUDED.label,
  group_name = EXCLUDED.group_name,
  sort_order = EXCLUDED.sort_order,
  is_active = EXCLUDED.is_active,
  is_editorial = EXCLUDED.is_editorial;

INSERT INTO subscriber_watches (
  subscriber_id,
  category_slug,
  sub_type,
  gender,
  min_price_tier,
  last_email_sent_at,
  created_at
)
SELECT
  sw.subscriber_id,
  m.new_slug,
  sw.sub_type,
  sw.gender,
  sw.min_price_tier,
  sw.last_email_sent_at,
  sw.created_at
FROM subscriber_watches sw
JOIN _restaurant_category_slug_merge m ON m.old_slug = sw.category_slug
ON CONFLICT (subscriber_id, category_slug, sub_type, gender, min_price_tier) DO NOTHING;

DELETE FROM subscriber_watches sw
USING _restaurant_category_slug_merge m
WHERE sw.category_slug = m.old_slug;

UPDATE deals
SET categories = (
  SELECT ARRAY(
    SELECT DISTINCT mapped_category
    FROM (
      SELECT
      CASE
        WHEN category IN (SELECT old_slug FROM _restaurant_category_slug_merge)
          THEN 'restaurants'
        ELSE category
      END AS mapped_category
      FROM unnest(deals.categories) AS category
    ) normalized
    ORDER BY mapped_category
  )
)
WHERE categories && ARRAY(SELECT old_slug FROM _restaurant_category_slug_merge);

UPDATE stores
SET categories = (
  SELECT ARRAY(
    SELECT DISTINCT mapped_category
    FROM (
      SELECT
      CASE
        WHEN category IN (SELECT old_slug FROM _restaurant_category_slug_merge)
          THEN 'restaurants'
        ELSE category
      END AS mapped_category
      FROM unnest(stores.categories) AS category
    ) normalized
    ORDER BY mapped_category
  )
)
WHERE categories && ARRAY(SELECT old_slug FROM _restaurant_category_slug_merge);

UPDATE ingest_deal_candidates
SET categories = (
  SELECT ARRAY(
    SELECT DISTINCT mapped_category
    FROM (
      SELECT
      CASE
        WHEN category IN (SELECT old_slug FROM _restaurant_category_slug_merge)
          THEN 'restaurants'
        ELSE category
      END AS mapped_category
      FROM unnest(ingest_deal_candidates.categories) AS category
    ) normalized
    ORDER BY mapped_category
  )
)
WHERE categories && ARRAY(SELECT old_slug FROM _restaurant_category_slug_merge);

UPDATE ingest_deal_candidates i
SET raw_candidate = replace(
  replace(
    replace(i.raw_candidate::text, '"restaurant"', '"restaurants"'),
    '"resturant"',
    '"restaurants"'
  ),
  '"resturants"',
  '"restaurants"'
)::jsonb
WHERE i.raw_candidate::text LIKE '%"restaurant"%'
  OR i.raw_candidate::text LIKE '%"resturant"%'
  OR i.raw_candidate::text LIKE '%"resturants"%';

UPDATE email_extraction_jobs j
SET
  production_output = replace(
    replace(
      replace(j.production_output::text, '"restaurant"', '"restaurants"'),
      '"resturant"',
      '"restaurants"'
    ),
    '"resturants"',
    '"restaurants"'
  )::jsonb,
  normalized_output = replace(
    replace(
      replace(j.normalized_output::text, '"restaurant"', '"restaurants"'),
      '"resturant"',
      '"restaurants"'
    ),
    '"resturants"',
    '"restaurants"'
  )::jsonb
WHERE j.production_output::text LIKE '%"restaurant"%'
  OR j.production_output::text LIKE '%"resturant"%'
  OR j.production_output::text LIKE '%"resturants"%'
  OR j.normalized_output::text LIKE '%"restaurant"%'
  OR j.normalized_output::text LIKE '%"resturant"%'
  OR j.normalized_output::text LIKE '%"resturants"%';

UPDATE email_extraction_attempts a
SET normalized_output = replace(
  replace(
    replace(a.normalized_output::text, '"restaurant"', '"restaurants"'),
    '"resturant"',
    '"restaurants"'
  ),
  '"resturants"',
  '"restaurants"'
)::jsonb
WHERE a.normalized_output::text LIKE '%"restaurant"%'
  OR a.normalized_output::text LIKE '%"resturant"%'
  OR a.normalized_output::text LIKE '%"resturants"%';

UPDATE email_extraction_comparisons c
SET
  production_output = replace(
    replace(
      replace(c.production_output::text, '"restaurant"', '"restaurants"'),
      '"resturant"',
      '"restaurants"'
    ),
    '"resturants"',
    '"restaurants"'
  )::jsonb,
  shadow_output = replace(
    replace(
      replace(c.shadow_output::text, '"restaurant"', '"restaurants"'),
      '"resturant"',
      '"restaurants"'
    ),
    '"resturants"',
    '"restaurants"'
  )::jsonb,
  details = replace(
    replace(
      replace(c.details::text, '"restaurant"', '"restaurants"'),
      '"resturant"',
      '"restaurants"'
    ),
    '"resturants"',
    '"restaurants"'
  )::jsonb
WHERE c.production_output::text LIKE '%"restaurant"%'
  OR c.production_output::text LIKE '%"resturant"%'
  OR c.production_output::text LIKE '%"resturants"%'
  OR c.shadow_output::text LIKE '%"restaurant"%'
  OR c.shadow_output::text LIKE '%"resturant"%'
  OR c.shadow_output::text LIKE '%"resturants"%'
  OR c.details::text LIKE '%"restaurant"%'
  OR c.details::text LIKE '%"resturant"%'
  OR c.details::text LIKE '%"resturants"%';

DELETE FROM categories c
USING _restaurant_category_slug_merge m
WHERE c.slug = m.old_slug;
