-- 051_drop_retired_content_model.sql
--
-- Phase 2 (destructive) of the content-model consolidation started in
-- migration 050.
--
-- ⚠️  APPLY ONLY AFTER the code deploy that removed every read/write of
--     retailer_categories and deals.deal_subtype is live. Pre-deploy code
--     still selects deals.deal_subtype in the ingest and search routes and
--     reads/writes retailer_categories from the admin store editor —
--     running this early breaks those paths with 42703/42P01 errors.
--
-- Migration 050 already copied the data:
--   - retailer_categories rows were merged into stores.categories
--   - deals.deal_subtype values were folded into deals.keywords
--
-- ingest_deal_candidates.deal_subtype (migration 043) is intentionally
-- kept — it's an audit snapshot of raw LLM output, not part of the
-- content model.

DROP TABLE IF EXISTS retailer_categories;

ALTER TABLE deals DROP COLUMN IF EXISTS deal_subtype;
