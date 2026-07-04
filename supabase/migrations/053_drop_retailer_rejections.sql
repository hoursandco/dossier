-- 053_drop_retailer_rejections.sql
--
-- retailer_rejections (migration 010) recorded reasons for rejecting
-- user-submitted brand suggestions so duplicates could be auto-answered.
-- Nothing in the app reads or writes it anymore — the 'declined' status
-- on stores replaced it. Zero code references; safe to drop any time.

DROP TABLE IF EXISTS retailer_rejections;
