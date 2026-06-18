-- Full ingest observability.
--
-- Keeps public deals filtered while preserving every email and extracted
-- candidate for admin review. This makes it possible to distinguish Gmail
-- retrieval failures from extraction, filtering, deduplication, and DB errors.

CREATE TABLE IF NOT EXISTS ingest_runs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mode text NOT NULL,
  lookback_hours integer NOT NULL,
  requested_limit integer NOT NULL,
  reprocess boolean NOT NULL DEFAULT false,
  started_at timestamptz NOT NULL DEFAULT now(),
  completed_at timestamptz,
  emails_fetched integer NOT NULL DEFAULT 0,
  emails_selected integer NOT NULL DEFAULT 0,
  emails_deferred integer NOT NULL DEFAULT 0,
  deals_extracted integer NOT NULL DEFAULT 0,
  deals_inserted integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'running',
  error text
);

CREATE TABLE IF NOT EXISTS ingest_email_audit (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  run_id uuid NOT NULL REFERENCES ingest_runs(id) ON DELETE CASCADE,
  email_id text NOT NULL,
  uid bigint,
  sender text,
  subject text,
  received_at timestamptz,
  body_sparse boolean NOT NULL DEFAULT false,
  web_version_used boolean NOT NULL DEFAULT false,
  image_count integer NOT NULL DEFAULT 0,
  extraction_method text,
  extracted_count integer NOT NULL DEFAULT 0,
  inserted_count integer NOT NULL DEFAULT 0,
  rejected_count integer NOT NULL DEFAULT 0,
  duplicate_count integer NOT NULL DEFAULT 0,
  outcome text NOT NULL,
  outcome_detail text,
  processing_ms integer,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(run_id, email_id)
);

CREATE TABLE IF NOT EXISTS ingest_deal_candidates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  run_id uuid NOT NULL REFERENCES ingest_runs(id) ON DELETE CASCADE,
  email_audit_id uuid REFERENCES ingest_email_audit(id) ON DELETE CASCADE,
  email_id text NOT NULL,
  retailer text,
  description text,
  percent_off integer,
  deal_type text,
  promo_code text,
  expiration_date date,
  categories text[] NOT NULL DEFAULT '{}',
  keywords text[] NOT NULL DEFAULT '{}',
  deal_subtype text,
  decision text NOT NULL,
  reason text,
  deal_id uuid REFERENCES deals(id) ON DELETE SET NULL,
  raw_candidate jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS ingest_runs_started_idx
  ON ingest_runs(started_at DESC);
CREATE INDEX IF NOT EXISTS ingest_email_audit_run_idx
  ON ingest_email_audit(run_id, created_at DESC);
CREATE INDEX IF NOT EXISTS ingest_email_audit_outcome_idx
  ON ingest_email_audit(outcome, created_at DESC);
CREATE INDEX IF NOT EXISTS ingest_deal_candidates_run_idx
  ON ingest_deal_candidates(run_id, created_at DESC);
CREATE INDEX IF NOT EXISTS ingest_deal_candidates_decision_idx
  ON ingest_deal_candidates(decision, created_at DESC);

ALTER TABLE ingest_runs ENABLE ROW LEVEL SECURITY;
ALTER TABLE ingest_runs FORCE ROW LEVEL SECURITY;
ALTER TABLE ingest_email_audit ENABLE ROW LEVEL SECURITY;
ALTER TABLE ingest_email_audit FORCE ROW LEVEL SECURITY;
ALTER TABLE ingest_deal_candidates ENABLE ROW LEVEL SECURITY;
ALTER TABLE ingest_deal_candidates FORCE ROW LEVEL SECURITY;
