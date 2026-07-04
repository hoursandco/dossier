-- 058_drop_merged_curation_tables.sql
--
-- Phase 2 of the curation-table merges (056 + 057).
--
-- ⚠️  APPLY ONLY AFTER the code deploy that reads keyword curation from
--     the keywords table and duplicate dismissals from
--     stores.unrelated_store_ids is live. The previous build still
--     queries both tables from search, suggest, item-audit, and the
--     duplicate-stores panel.

DROP TABLE IF EXISTS item_keyword_reviews;
DROP FUNCTION IF EXISTS update_item_keyword_reviews_updated_at();

DROP TABLE IF EXISTS non_duplicate_clusters;
