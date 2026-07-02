-- Adds where-to-redeem metadata so deal cards can distinguish online
-- offers from store-only offers.
ALTER TABLE deals
  ADD COLUMN IF NOT EXISTS redemption_channel TEXT
  CHECK (
    redemption_channel IS NULL OR
    redemption_channel IN ('online', 'in-store', 'online-and-in-store')
  );

UPDATE deals
SET redemption_channel = 'online'
WHERE redemption_channel IS NULL;

ALTER TABLE deals
  ALTER COLUMN redemption_channel SET DEFAULT 'online';
