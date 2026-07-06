-- Thumbnail generation runs outside the main ingest request so deal
-- extraction stays under Vercel's function timeout.
CREATE TABLE IF NOT EXISTS deal_thumbnail_jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  deal_id UUID NOT NULL REFERENCES deals(id) ON DELETE CASCADE,
  retailer TEXT NOT NULL,
  description TEXT NOT NULL,
  deal_type TEXT NOT NULL,
  categories TEXT[] NOT NULL DEFAULT '{}',
  keywords TEXT[] NOT NULL DEFAULT '{}',
  image_urls TEXT[] NOT NULL DEFAULT '{}',
  status TEXT NOT NULL DEFAULT 'pending' CHECK (
    status IN ('pending', 'processing', 'completed', 'failed')
  ),
  attempt_count INTEGER NOT NULL DEFAULT 0,
  next_attempt_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  locked_at TIMESTAMPTZ,
  locked_by TEXT,
  last_error TEXT,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(deal_id)
);

CREATE INDEX IF NOT EXISTS deal_thumbnail_jobs_pending_idx
  ON deal_thumbnail_jobs(status, next_attempt_at, created_at);

ALTER TABLE deal_thumbnail_jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE deal_thumbnail_jobs FORCE ROW LEVEL SECURITY;
