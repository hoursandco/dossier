-- 023_enable_rls.sql
--
-- Enable Row Level Security on every user-data and system table.
--
-- Threat model: the app ships the Supabase anon key in the browser bundle
-- (NEXT_PUBLIC_SUPABASE_ANON_KEY). Without RLS, any table reachable via
-- PostgREST would be queryable by anyone on the public internet using that
-- key — they could enumerate subscribers, dump store_suggestions, etc.
--
-- Strategy:
--   * Server code routes EVERY data read/write through createServiceClient()
--     (service role key, never exposed). Service role bypasses RLS entirely,
--     so enabling RLS does not break any existing server path.
--   * The browser client (lib/supabase/client.ts) is only used for auth
--     (getUser / setSession). It never queries tables directly, so blocking
--     anon access to data tables is safe.
--   * Private tables get RLS-on with NO policies → effectively deny-all to
--     anon/authenticated roles. Service role still works.
--   * Public-read tables (categories, deals, stores) get an explicit SELECT
--     policy for anon + authenticated so that if the app ever needs to fall
--     back to the browser client for those (or future public pages), it
--     keeps working.
--
-- Idempotent: every block is wrapped in DO $$ / IF EXISTS so re-runs are
-- safe across environments where some tables may or may not exist.

-- ── Helper: enable RLS only if the table exists ─────────────────────────
DO $$
DECLARE
  t text;
  private_tables text[] := ARRAY[
    'subscribers',
    'subscriber_categories',
    'subscriber_deal_types',
    'subscriber_retailers',
    'subscriber_store_preferences',
    'subscriber_watches',
    'store_suggestions',
    'sent_emails',
    'ingest_state',
    'processed_emails',
    'retailer_scan_log',
    'retailer_categories',
    'retailer_rejections'
  ];
  public_tables text[] := ARRAY[
    'categories',
    'deals',
    'stores',
    'editions'
  ];
BEGIN
  -- Private tables: enable RLS, deny-all to anon/authenticated by virtue
  -- of having no policies. Service role bypasses.
  FOREACH t IN ARRAY private_tables LOOP
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = t) THEN
      EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', t);
      EXECUTE format('ALTER TABLE public.%I FORCE ROW LEVEL SECURITY;', t);
    END IF;
  END LOOP;

  -- Public-readable tables: enable RLS, add SELECT-for-everyone policy.
  -- FORCE is intentionally NOT applied to these — table owners (the
  -- migration runner) need to be able to seed without policy juggling.
  FOREACH t IN ARRAY public_tables LOOP
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = t) THEN
      EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', t);
      -- Drop + recreate so this is idempotent.
      EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I;', t || '_public_select', t);
      EXECUTE format(
        'CREATE POLICY %I ON public.%I FOR SELECT TO anon, authenticated USING (true);',
        t || '_public_select', t
      );
    END IF;
  END LOOP;
END $$;

-- ── Verification query (commented — uncomment to audit after running) ──
-- SELECT schemaname, tablename, rowsecurity, forcerowsecurity
--   FROM pg_tables
--   WHERE schemaname = 'public'
--   ORDER BY tablename;
