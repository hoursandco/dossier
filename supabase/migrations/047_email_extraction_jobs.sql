-- Durable queue for non-production extraction runs.
--
-- Production ingest still inserts Gemini results directly. These tables keep a
-- minimized email snapshot so shadow providers can be processed out-of-band.

CREATE TABLE IF NOT EXISTS email_extraction_jobs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  source_run_id uuid REFERENCES ingest_runs(id) ON DELETE SET NULL,
  source_email_audit_id uuid REFERENCES ingest_email_audit(id) ON DELETE SET NULL,
  email_id text NOT NULL,
  uid bigint,
  sender text,
  subject text,
  received_at timestamptz,
  cleaned_body text NOT NULL DEFAULT '',
  image_urls text[] NOT NULL DEFAULT '{}',
  prompt_version text NOT NULL,
  provider text NOT NULL,
  model text NOT NULL,
  status text NOT NULL DEFAULT 'pending',
  attempt_count integer NOT NULL DEFAULT 0,
  next_attempt_at timestamptz NOT NULL DEFAULT now(),
  last_error text,
  production_output jsonb,
  normalized_output jsonb,
  locked_at timestamptz,
  locked_by text,
  completed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT email_extraction_jobs_status_check
    CHECK (status IN ('pending', 'processing', 'completed', 'failed'))
);

CREATE UNIQUE INDEX IF NOT EXISTS email_extraction_jobs_unique_snapshot_idx
  ON email_extraction_jobs(email_id, prompt_version, provider, model);
CREATE INDEX IF NOT EXISTS email_extraction_jobs_due_idx
  ON email_extraction_jobs(status, next_attempt_at, created_at)
  WHERE status = 'pending';
CREATE INDEX IF NOT EXISTS email_extraction_jobs_provider_idx
  ON email_extraction_jobs(provider, model, created_at DESC);
CREATE INDEX IF NOT EXISTS email_extraction_jobs_email_idx
  ON email_extraction_jobs(email_id, created_at DESC);

CREATE TABLE IF NOT EXISTS email_extraction_attempts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id uuid NOT NULL REFERENCES email_extraction_jobs(id) ON DELETE CASCADE,
  attempt_number integer NOT NULL,
  provider text NOT NULL,
  model text NOT NULL,
  status text NOT NULL,
  started_at timestamptz NOT NULL DEFAULT now(),
  completed_at timestamptz,
  duration_ms integer,
  retry_after_ms integer,
  error text,
  normalized_output jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT email_extraction_attempts_status_check
    CHECK (status IN ('completed', 'retryable_error', 'failed'))
);

CREATE INDEX IF NOT EXISTS email_extraction_attempts_job_idx
  ON email_extraction_attempts(job_id, attempt_number DESC);
CREATE INDEX IF NOT EXISTS email_extraction_attempts_status_idx
  ON email_extraction_attempts(status, created_at DESC);

CREATE TABLE IF NOT EXISTS email_extraction_comparisons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id uuid NOT NULL REFERENCES email_extraction_jobs(id) ON DELETE CASCADE,
  source_email_audit_id uuid REFERENCES ingest_email_audit(id) ON DELETE SET NULL,
  email_id text NOT NULL,
  prompt_version text NOT NULL,
  production_provider text NOT NULL,
  production_model text NOT NULL,
  shadow_provider text NOT NULL,
  shadow_model text NOT NULL,
  production_output jsonb NOT NULL DEFAULT '{}'::jsonb,
  shadow_output jsonb,
  status text NOT NULL,
  production_schema_valid boolean NOT NULL DEFAULT true,
  shadow_schema_valid boolean NOT NULL DEFAULT false,
  deal_count_match boolean NOT NULL DEFAULT false,
  retailer_agreement boolean NOT NULL DEFAULT false,
  deal_type_agreement boolean NOT NULL DEFAULT false,
  percent_agreement boolean NOT NULL DEFAULT false,
  promo_code_agreement boolean NOT NULL DEFAULT false,
  category_agreement boolean NOT NULL DEFAULT false,
  description_differences jsonb NOT NULL DEFAULT '[]'::jsonb,
  details jsonb NOT NULL DEFAULT '{}'::jsonb,
  error text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT email_extraction_comparisons_status_check
    CHECK (status IN ('match', 'needs_review', 'schema_failed', 'provider_failed'))
);

CREATE UNIQUE INDEX IF NOT EXISTS email_extraction_comparisons_job_idx
  ON email_extraction_comparisons(job_id);
CREATE INDEX IF NOT EXISTS email_extraction_comparisons_audit_idx
  ON email_extraction_comparisons(source_email_audit_id, created_at DESC);
CREATE INDEX IF NOT EXISTS email_extraction_comparisons_status_idx
  ON email_extraction_comparisons(status, created_at DESC);

CREATE OR REPLACE FUNCTION claim_email_extraction_jobs(
  p_limit integer DEFAULT 10,
  p_worker_id text DEFAULT NULL,
  p_provider text DEFAULT NULL
)
RETURNS SETOF email_extraction_jobs
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN QUERY
  WITH due AS (
    SELECT j.id
    FROM email_extraction_jobs j
    WHERE (p_provider IS NULL OR j.provider = p_provider)
      AND (
        (j.status = 'pending' AND j.next_attempt_at <= now())
        OR (j.status = 'processing' AND j.locked_at < now() - interval '30 minutes')
      )
    ORDER BY j.next_attempt_at ASC, j.created_at ASC
    LIMIT GREATEST(1, COALESCE(p_limit, 10))
    FOR UPDATE SKIP LOCKED
  ),
  claimed AS (
    UPDATE email_extraction_jobs j
    SET
      status = 'processing',
      attempt_count = j.attempt_count + 1,
      locked_at = now(),
      locked_by = COALESCE(p_worker_id, gen_random_uuid()::text),
      updated_at = now()
    FROM due
    WHERE j.id = due.id
    RETURNING j.*
  )
  SELECT * FROM claimed;
END;
$$;

ALTER TABLE email_extraction_jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_extraction_jobs FORCE ROW LEVEL SECURITY;
ALTER TABLE email_extraction_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_extraction_attempts FORCE ROW LEVEL SECURITY;
ALTER TABLE email_extraction_comparisons ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_extraction_comparisons FORCE ROW LEVEL SECURITY;
