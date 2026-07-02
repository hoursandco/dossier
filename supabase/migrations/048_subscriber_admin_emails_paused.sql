-- Lets admins pause outbound emails to all subscribers without touching
-- individual weekly_email_enabled preferences.
ALTER TABLE subscribers
  ADD COLUMN IF NOT EXISTS admin_emails_paused BOOLEAN NOT NULL DEFAULT false;
