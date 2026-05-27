-- stores.age_group: TEXT → TEXT[]
--
-- Original schema modeled age_group as a single tag per brand ("All
-- Ages", "Teen", "30's", etc.). The current store-list CSV models it
-- as a multi-tag per brand — Express targets Teens AND 20's AND 30's,
-- Eloquii targets 30's AND 40's AND 50+. Storing it as TEXT[] mirrors
-- how stores.categories is already modeled (text array, GIN index
-- friendly).
--
-- USING clause: any existing TEXT value gets split on commas into the
-- new array. NULLs and empties become empty arrays. Defensive split
-- because some existing rows had comma-separated values typed into
-- the single TEXT column.

ALTER TABLE stores
  ALTER COLUMN age_group TYPE TEXT[]
  USING (
    CASE
      WHEN age_group IS NULL OR age_group = '' THEN ARRAY[]::TEXT[]
      ELSE string_to_array(trim(age_group), ',')
    END
  );

ALTER TABLE stores
  ALTER COLUMN age_group SET DEFAULT ARRAY[]::TEXT[];

-- Optional GIN index for fast 'where age_group @> ARRAY[...]' filtering
-- in case we ever add an age-targeted filter to the watchlist email.
CREATE INDEX IF NOT EXISTS stores_age_group_gin_idx
  ON stores USING GIN (age_group);
