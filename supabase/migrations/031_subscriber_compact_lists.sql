-- Paid opt-ins for the bottom-of-email compact brand lists.
--
-- Free-shipping, BOGO, and gift-with-purchase deals are silently
-- suppressed from the watchlist email by default (migration-free
-- send-time filter in lib/watchlistSend.ts). These three columns
-- let a paid subscriber opt back into seeing them — not as full
-- deal blocks per-retailer, but as compact comma-separated brand
-- lists at the bottom of the email under an "Also Today" header.
--
-- Defaults are FALSE so existing subscribers (and free users) see
-- the cleaner email until they actively opt in. UI gates writes
-- behind tier='paid'; an additional server-side guard in
-- /api/account PATCH (already there for the other filters) means a
-- hand-crafted request from a free user is rejected.

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS include_free_shipping BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS include_bogo BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS include_gwp BOOLEAN NOT NULL DEFAULT FALSE;
