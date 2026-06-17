-- Add a plain unique constraint on stores.website so that the ingest
-- auto-add upsert (onConflict: 'website') works correctly. Without this
-- Postgres throws 42P10 because ON CONFLICT requires a real constraint,
-- not just a functional/case-insensitive index.
--
-- Drop any existing functional index on lower(website) first to avoid
-- having two overlapping uniqueness guards.
DROP INDEX IF EXISTS stores_website_lower_idx;

ALTER TABLE stores ADD CONSTRAINT stores_website_unique UNIQUE (website);
