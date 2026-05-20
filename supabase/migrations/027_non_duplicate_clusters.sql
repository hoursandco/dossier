-- 027_non_duplicate_clusters.sql
--
-- Persistent dismissals for the Duplicate Stores · Review panel.
--
-- The duplicates endpoint groups stores by their normalized apex
-- domain. That heuristic produces real duplicates (two rows of "J.Crew"
-- both pointing at jcrew.com) but also FALSE POSITIVES when a parent
-- domain hosts multiple distinct brand subdomains (Gap Inc.'s
-- oldnavy.gap.com, bananarepublic.gap.com, etc. all collapse to
-- gap.com but are clearly different brands).
--
-- This table tracks "admin has reviewed this cluster and confirmed
-- these are not duplicates." The duplicates endpoint filters out any
-- cluster whose normalized_website is here.
--
-- To resurface a dismissed cluster (if you change your mind), simply:
--   DELETE FROM non_duplicate_clusters WHERE normalized_website = '...'
--
-- Hard to imagine a use case for that, but it's a one-line escape hatch.

CREATE TABLE IF NOT EXISTS non_duplicate_clusters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  normalized_website text UNIQUE NOT NULL,
  dismissed_at timestamptz NOT NULL DEFAULT now(),
  dismissed_by_email text
);

ALTER TABLE non_duplicate_clusters ENABLE ROW LEVEL SECURITY;
ALTER TABLE non_duplicate_clusters FORCE ROW LEVEL SECURITY;
