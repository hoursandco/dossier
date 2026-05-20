-- Track whether we've sent a welcome email to each subscriber.
--
-- Used by /api/subscribe to fire a single welcome on genuine first
-- sign-up. Without this column we'd risk re-sending whenever someone
-- re-submits the subscribe form (e.g. on sign-in via the same endpoint
-- or accidental double-submit).
--
-- Nullable: NULL means "no welcome sent yet". A timestamp means
-- "welcomed at this moment". Backfill is intentionally NOT done — every
-- pre-existing subscriber will see welcome_sent_at = NULL, but the
-- subscribe handler also checks `created_at` recency before firing, so
-- legacy users won't get a surprise welcome.

ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS welcome_sent_at TIMESTAMPTZ;
