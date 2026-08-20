-- Groupon is intentionally excluded from Deal Dossier. Retire its directory
-- entry and remove historical deal cards so it cannot surface in results.
UPDATE stores
SET status = 'declined', is_active = FALSE
WHERE lower(regexp_replace(name, '[^a-zA-Z0-9]', '', 'g')) = 'groupon'
   OR lower(website) ~ '(^|//|\.)groupon\.com(/|$)';

DELETE FROM deals
WHERE lower(regexp_replace(retailer, '[^a-zA-Z0-9]', '', 'g')) = 'groupon';
