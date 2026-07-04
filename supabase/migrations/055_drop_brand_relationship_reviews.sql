-- 055_drop_brand_relationship_reviews.sql
--
-- Phase 2 of folding brand relationships into stores (migration 054).
--
-- ⚠️  APPLY ONLY AFTER the code deploy that reads/writes the new
--     stores.parent_store_id / alias_of_store_id / unrelated_store_ids
--     columns is live. The previous build still queries
--     brand_relationship_reviews from watchlist send, brand search, and
--     the alias-audit tab.

DROP TABLE IF EXISTS brand_relationship_reviews;
DROP FUNCTION IF EXISTS update_brand_relationship_reviews_updated_at();
