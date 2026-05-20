-- 024_magic_link_throttle.sql
--
-- Lightweight rate-limit log for /api/auth/magic-link sends. Each row
-- records one successful generateLink + email send. The route counts
-- recent rows per email and per IP before honoring a new request.
--
-- Limits enforced in the route (not the DB):
--   * Per email:    5 sends / hour
--   * Per IP:      10 sends / hour
--
-- Service role inserts/reads. RLS on, no policies → anon/authenticated
-- can't even SELECT this table.
--
-- Cleanup: rows older than 24h are pruned opportunistically on insert
-- by the route. No cron required.

CREATE TABLE IF NOT EXISTS magic_link_throttle (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email       text NOT NULL,
  ip          text,
  sent_at     timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS magic_link_throttle_email_sent_idx
  ON magic_link_throttle (email, sent_at DESC);
CREATE INDEX IF NOT EXISTS magic_link_throttle_ip_sent_idx
  ON magic_link_throttle (ip, sent_at DESC);

ALTER TABLE magic_link_throttle ENABLE ROW LEVEL SECURITY;
ALTER TABLE magic_link_throttle FORCE ROW LEVEL SECURITY;
