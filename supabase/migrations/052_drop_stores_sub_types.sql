-- 052_drop_stores_sub_types.sql
--
-- Retire stores.sub_types. It was only ever written (admin form, sheet
-- import) and displayed back in the same form — nothing searched, matched,
-- or rendered it publicly. Item-level terms now live on deals.keywords,
-- and store categorization lives on stores.categories.
--
-- ⚠️  APPLY ONLY AFTER the code deploy that stopped selecting sub_types
--     is live — the previous build includes the column in store SELECTs
--     and would 42703 on the admin list, public directory, and duplicates
--     panel if this runs first.

ALTER TABLE stores DROP COLUMN IF EXISTS sub_types;
