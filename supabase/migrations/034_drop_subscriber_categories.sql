-- Drop the legacy subscriber_categories table.
--
-- Origin: migration 001 (the v1 schema). The original watchlist model
-- was one row per (subscriber, category) — pure categorical interest.
-- Migration 010 replaced it with the richer subscriber_watches table
-- (per-watch sub_type / gender / min_price_tier / min_discount /
-- timestamps), and no current code reads from subscriber_categories.
-- Confirmed via codebase grep: zero non-migration references.
--
-- Dropping it removes one of the three "categories" tables that
-- confused Bre on the Supabase tab — only `categories` (live, the
-- source of truth) and `retailer_categories` (live, auto-populated
-- cache) remain.

DROP TABLE IF EXISTS subscriber_categories;
