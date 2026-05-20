-- Per-watch minimum-discount modifier.
--
-- Subscriber can set "only deals with N% off or more" on a watch.
-- Combined with min_price_tier + sub_type, this narrows the watch to
-- exactly what they care about.
--
-- Values: NULL (no threshold), or 20 / 30 / 40 / 50 / 60. Stored as a
-- smallint so the DB rejects garbage. Free-tier subscribers can't set
-- modifiers (enforced at the app layer; the column itself is
-- permissive in case we ever loosen the rule).

ALTER TABLE subscriber_watches
  ADD COLUMN IF NOT EXISTS min_discount SMALLINT;

ALTER TABLE subscriber_watches
  ADD CONSTRAINT subscriber_watches_min_discount_range
  CHECK (min_discount IS NULL OR (min_discount >= 1 AND min_discount <= 99));
