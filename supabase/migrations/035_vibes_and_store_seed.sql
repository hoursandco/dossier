-- Auto-generated from Deal Dossier List - a.csv on 2026-05-27
-- Re-run is safe: ON CONFLICT(LOWER(website)) updates instead of duplicating.

-- ── 24 editorial vibe categories ────────────────────────────
-- group_name='Collections' so the picker renders them in their own drawer.
-- is_editorial=true so the cron unions them into deals; content slugs don't.

INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('women-owned', 'Women-Owned', 1000, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('luxury', 'Luxury', 1001, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('heritage', 'Heritage', 1002, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('direct-to-consumer', 'Direct-to-Consumer', 1003, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('sustainable', 'Sustainable', 1004, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('cruelty-free', 'Cruelty-Free & Vegan', 1005, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('subscription', 'Subscription', 1006, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('mall-stores', 'Mall Stores', 1007, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('big-box', 'Big Box', 1008, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('online-first', 'Online-First', 1009, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('boutique', 'Boutique', 1010, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('department-store', 'Department Stores', 1011, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('b-corp', 'B-Corp', 1012, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('resale', 'Resale', 1013, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('outlet', 'Outlet', 1014, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('small-brand', 'Small Brand', 1015, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('wedding-gifting', 'Wedding & Gifting', 1016, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('entertainment', 'Entertainment', 1017, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('minimalist', 'Minimalist', 1018, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('made-in-usa', 'Made in USA', 1019, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('black-owned', 'Black-Owned', 1020, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('rental', 'Clothing Rental', 1021, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('restaurant', 'Restaurant', 1022, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;
INSERT INTO categories (slug, label, sort_order, is_active, group_name, is_editorial)
VALUES ('western', 'Western', 1023, TRUE, 'Collections', TRUE)
ON CONFLICT (slug) DO UPDATE SET label=EXCLUDED.label, group_name=EXCLUDED.group_name, is_editorial=EXCLUDED.is_editorial, is_active=EXCLUDED.is_active;

-- ── 1,764 store upserts ─────────────────────────────────────
-- Existing rows match on LOWER(website). Fields not in the CSV
-- (sub_types, affiliate_id, is_comped, etc.) are left untouched.

INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('& Daughter', 'https://www.and-daughter.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('& Other Stories', 'https://www.stories.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('&pizza', 'https://andpizza.com', 'no_email', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('11 Honoré', 'https://11honore.com', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('1stDibs', 'https://www.1stdibs.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('20x200', 'https://20x200.com', 'active', TRUE, ARRAY['b-corp','women-owned','small-brand']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('3.1 Phillip Lim', 'https://31philliplim.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('525 America', 'https://www.525america.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('7 For All Mankind', 'https://7forallmankind.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('A.L.C.', 'https://alcltd.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('A.W.A.K.E. Mode', 'https://www.awake-mode.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('a&f Kids', 'https://www.abercrombie.com/shop/us/kids', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','kids']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('A&W', 'https://awrestaurants.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Abercrombie & Fitch', 'https://www.abercrombie.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Academy Sports', 'https://www.academy.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ace Hardware', 'https://www.acehardware.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Acer', 'https://acer.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Acme Tools', 'https://acmetools.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Acne Studios', 'https://www.acnestudios.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Acqua di Parma', 'https://acquadiparma.com', 'no_email', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Act + Acre', 'https://actandacre.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adam Lippes', 'https://adamlippes.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adanola', 'https://adanola.com/en-us', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adidas', 'https://www.adidas.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adina Eden', 'https://www.adinaeden.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adobe', 'https://adobe.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adorama', 'https://adorama.com', 'active', TRUE, ARRAY['direct-to-consumer','small-brand']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Adornia', 'https://adornia.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ADT', 'https://adt.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aerie', 'https://aerie.com', 'active', TRUE, ARRAY['direct-to-consumer','women-owned']::TEXT[], '$$', ARRAY['teens','20s','30s']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aeropostale', 'https://www.aeropostale.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aesop', 'https://www.aesop.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('AGOLDE', 'https://agolde.com', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('AGUA by Agua Bendita', 'https://us.aguabyaguabendita.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Airbnb', 'https://airbnb.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aje', 'https://ajeworld.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alamo Drafthouse', 'https://drafthouse.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alaska Airlines', 'https://www.alaskaair.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Albany Park', 'https://albanypark.com', 'active', TRUE, ARRAY['direct-to-consumer','small-brand']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Albertsons', 'https://www.albertsons.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aldi', 'https://www.aldi.us', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alemais', 'https://alemais.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alex Mill', 'https://www.alexmill.com', 'active', TRUE, ARRAY['minimalist']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alexander McQueen', 'https://alexandermcqueen.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alexander Wang', 'https://alexanderwang.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alice & Olivia', 'https://www.aliceandolivia.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alice Lane', 'https://www.alicelanehome.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alienware', 'https://alienware.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('All For Mimi', 'https://www.allformimi.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('All-Clad', 'https://www.all-clad.com', 'active', TRUE, ARRAY['heritage','made-in-usa']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Allbirds', 'https://www.allbirds.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Allen Edmonds', 'https://allenedmonds.com', 'active', TRUE, ARRAY['heritage','made-in-usa']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('AllModern', 'https://allmodern.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Allure Beauty Box', 'https://beautybox.allure.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Almina Concept', 'https://www.almina-concept.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alo Yoga', 'https://www.aloyoga.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Alohas', 'https://alohas.com/en-us', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Altra', 'https://altrarunning.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Amazon', 'https://www.amazon.com', 'no_email', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Amazon Prime Video', 'https://primevideo.com', 'no_email', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('AMC Theatres', 'https://amctheatres.com', 'no_email', FALSE, ARRAY['entertainment']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('American Airlines', 'https://aa.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('American Eagle Outfitters', 'https://www.ae.com/us/en', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('American Girl', 'https://americangirl.com', 'active', TRUE, ARRAY['heritage','women-owned']::TEXT[], '$$$', ARRAY['kids']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ami Paris', 'https://www.amiparis.com/en-us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Amika', 'https://loveamika.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Amiri', 'https://amiri.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Amorepacific', 'https://us.amorepacific.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ana Luisa', 'https://www.analuisa.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Anastasia Beverly Hills', 'https://anastasiabeverlyhills.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Andie Swim', 'https://andieswim.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Angel Dear', 'https://angeldear.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['kids','baby']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Anine Bing', 'https://www.aninebing.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Anker', 'https://anker.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ann Taylor', 'https://www.anntaylor.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ann Taylor Factory', 'https://www.anntaylor.com/factory', 'active', TRUE, ARRAY['outlet']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Annie''s', 'https://annies.com', 'no_email', FALSE, ARRAY['b-corp']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Anthropic', 'https://anthropic.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Anthropologie', 'https://www.anthropologie.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Apple', 'https://www.apple.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Apple Music', 'https://apple.com/apple-music', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Apple TV+', 'https://tv.apple.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Applebee''s', 'https://www.applebees.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Apt2B', 'https://apt2b.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aquaphor Baby', 'https://aquaphorus.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aquazzura', 'https://aquazzura.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Arby’s', 'https://www.arbys.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Arc''teryx', 'https://arcteryx.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Arena', 'https://arenawaterinstinct.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Arhaus', 'https://www.arhaus.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ariat', 'https://ariat.com', 'active', TRUE, ARRAY['western']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aritzia', 'https://www.aritzia.com/us/en', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ARK Skincare', 'https://arkskincare.com', 'no_email', FALSE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ARKET', 'https://www.arket.com/en-ww', 'active', TRUE, ARRAY['minimalist']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Arlo', 'https://arlo.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Armani', 'https://www.armani.com/en-us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Armoire', 'https://armoire.style', 'active', TRUE, ARRAY['rental']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Article', 'https://www.article.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Artifox', 'https://theartifox.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Artless Forever', 'https://artlessforever.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Asana', 'https://asana.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ashley HomeStore', 'https://ashleyfurniture.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Asics', 'https://asics.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ASOS', 'https://www.asos.com', 'active', TRUE, ARRAY['online-first']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Astley Clarke', 'https://astleyclarke.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ASUS', 'https://asus.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('At Home', 'https://athome.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('At Present', 'https://atpresent.com', 'active', TRUE, ARRAY['wedding-gifting','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Atelier Cologne', 'https://ateliercologne.com', 'no_email', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Athleta', 'https://athleta.gap.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Athletic Brewing', 'https://athleticbrewing.com', 'pending', FALSE, ARRAY['b-corp']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Athletic Greens', 'https://drinkag1.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Atlas Coffee Club', 'https://atlascoffeeclub.com', 'active', TRUE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ATM Anthony Thomas Melillo', 'https://atmcollection.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Atom Tickets', 'https://atomtickets.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Atorie', 'https://atorie.com', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ATP Atelier', 'https://us.atpatelier.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Au Bon Pain', 'https://aubonpain.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Audible', 'https://audible.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Audio-Technica', 'https://audio-technica.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Audo Copenhagen', 'https://us.audocph.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('August', 'https://august.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Augustinus Bader', 'https://augustinusbader.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Auntie Anne’s', 'https://www.auntieannes.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aurate New York', 'https://auratenewyork.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aureum Collective', 'https://aureumcollective.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Automic Gold', 'https://www.automicgold.com', 'active', TRUE, ARRAY['black-owned','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aveda', 'https://aveda.com', 'active', TRUE, ARRAY['cruelty-free','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Aveeno Baby', 'https://aveeno.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Avene', 'https://aveneusa.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Avenue', 'https://avenue.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Avis', 'https://avis.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Avocado Green Mattress', 'https://avocadogreenmattress.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Away', 'https://www.awaytravel.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Axios', 'https://axios.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('B&H Photo Video', 'https://bhphotovideo.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Babaa', 'https://babaa.es', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Babyletto', 'https://babyletto.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BabylissPRO', 'https://babylisspro.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Babyzen', 'https://babyzen.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Backcountry', 'https://backcountry.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bahama Breeze', 'https://www.bahamabreeze.com/home', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Baja Fresh', 'https://bajafresh.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Balenciaga', 'https://balenciaga.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bally', 'https://bally.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Banana Republic', 'https://bananarepublic.gap.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Banana Republic Factory', 'https://bananarepublicfactory.gapfactory.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bandhini Homewear', 'https://www.bandhinihome.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bandier', 'https://bandierstore.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bang & Olufsen', 'https://bang-olufsen.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BareMinerals', 'https://bareminerals.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BarkBox', 'https://barkbox.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Barnes & Noble', 'https://www.barnesandnoble.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Baskin-Robbins', 'https://baskinrobbins.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bath and Body Works', 'https://www.bathandbodyworks.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BaubleBar', 'https://baublebar.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bear Mattress', 'https://bearmattress.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Beats by Dre', 'https://beatsbydre.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Beauty of Joseon', 'https://beautyofjoseon.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Beautycounter', 'https://beautycounter.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bed Bath & Beyond', 'https://www.bedbathandbeyond.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bedding by Buffy', 'https://buffy.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Behr', 'https://behr.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Beis', 'https://beistravel.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Belgian Boys', 'https://www.belgianboys.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Belk', 'https://www.belk.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Belkin', 'https://belkin.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ben & Jerry''s', 'https://benjerry.com', 'active', TRUE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Benefit Cosmetics', 'https://benefitcosmetics.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Benjamin Moore', 'https://benjaminmoore.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bergdorf Goodman', 'https://www.bergdorfgoodman.com', 'active', TRUE, ARRAY['luxury','department-store']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Best Buy', 'https://www.bestbuy.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Best Western', 'https://bestwestern.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Beyond Meat', 'https://beyondmeat.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Beyond Yoga', 'https://beyondyoga.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BHLDN', 'https://bhldn.com', 'pending', FALSE, ARRAY['wedding-gifting','boutique']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Big Fig', 'https://bigfigmattress.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Big Lots', 'https://biglots.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bigelow Tea', 'https://bigelowtea.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Billabong', 'https://billabong.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY['teens','20s','30s']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Biossance', 'https://biossance.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Birch Lane', 'https://birchlane.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Birchbox', 'https://birchbox.com', 'active', TRUE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Birkenstock', 'https://birkenstock.com', 'active', TRUE, ARRAY['heritage','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BJ''s Restaurant', 'https://bjsrestaurants.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BJ’s Wholesale Club', 'https://www.bjs.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Black Angus Steakhouse', 'https://blackangus.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Black Diamond', 'https://blackdiamondequipment.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blaze Pizza', 'https://blazepizza.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bloomberg', 'https://bloomberg.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bloomingdale''s', 'https://www.bloomingdales.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BloomNu', 'https://bloomnu.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bloomscape', 'https://bloomscape.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blue Apron', 'https://blueapron.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blue Bottle Coffee', 'https://bluebottlecoffee.com', 'active', TRUE, ARRAY['b-corp','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blue Buffalo', 'https://bluebuffalo.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blue Diamond', 'https://www.bluediamond.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blue Nile', 'https://bluenile.com', 'active', TRUE, ARRAY['direct-to-consumer','luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blueland', 'https://blueland.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bluemercury', 'https://bluemercury.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Blundstone', 'https://blundstone.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bob Evans', 'https://bobevans.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bob''s Discount Furniture', 'https://mybobs.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bobbi Brown', 'https://bobbibrowncosmetics.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bobbie', 'https://hibobbie.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boden', 'https://us.boden.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boll & Branch', 'https://www.bollandbranch.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bombas', 'https://bombas.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bonefish Grill', 'https://www.bonefishgrill.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bones Coffee', 'https://bonescoffee.com', 'pending', FALSE, ARRAY['small-brand']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bonobos', 'https://bonobos.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boohoo', 'https://boohoo.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Book of the Month', 'https://bookofthemonth.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Booking.com', 'https://booking.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BookOutlet', 'https://bookoutlet.com', 'pending', FALSE, ARRAY['outlet']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bookshop.org', 'https://bookshop.org', 'pending', FALSE, ARRAY['small-brand','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boppy', 'https://boppy.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bosch Tools', 'https://boschtools.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boscov''s', 'https://boscovs.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bose', 'https://www.bose.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bottega Veneta', 'https://www.bottegaveneta.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boucheron', 'https://boucheron.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Box', 'https://box.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boy Smells', 'https://boysmells.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Boyish Jeans', 'https://boyish.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BR Collaborative', 'https://www.brcollaborativenyc.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Branch Basics', 'https://branchbasics.com', 'active', TRUE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brandon Maxwell', 'https://brandonmaxwell.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Breitling', 'https://breitling.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Breville', 'https://breville.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Briggs & Riley', 'https://briggs-riley.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Briggs & Stratton', 'https://briggsandstratton.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brilliant Earth', 'https://brilliantearth.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brio Italian Grille', 'https://brioitalian.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Briogeo', 'https://briogeohair.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bristol Farms', 'https://bristolfarms.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Britax', 'https://us.britax.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brock Collection', 'https://brockcollection.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brooklinen', 'https://www.brooklinen.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brooks Brothers', 'https://brooksbrothers.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brooks Running', 'https://brooksrunning.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Browns Fashion', 'https://brownsfashion.com', 'pending', FALSE, ARRAY['luxury','department-store']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brumate', 'https://brumate.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Brunello Cucinelli', 'https://brunellocucinelli.com', 'pending', FALSE, ARRAY['luxury','heritage']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bubble', 'https://bubbleskincare.com', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bubly', 'https://bubly.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Buca di Beppo', 'https://dineatbuca.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Buck Mason', 'https://www.buckmason.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Budget Car Rental', 'https://budget.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Buffalo Wild Wings', 'https://www.buffalowildwings.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bugaboo', 'https://bugaboo.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Build with Ferguson', 'https://build.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Build-A-Bear Workshop', 'https://buildabear.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bulgari', 'https://bulgari.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bulletproof', 'https://bulletproof.com', 'pending', FALSE, ARRAY['direct-to-consumer','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bulova', 'https://bulova.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Bumble and bumble', 'https://bumbleandbumble.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burberry', 'https://us.burberry.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burger King', 'https://www.bk.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('BurgerFi', 'https://burgerfi.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burlington', 'https://burlington.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burpee', 'https://www.burpee.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burrow', 'https://burrow.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burt''s Bees Baby', 'https://burtsbeesbaby.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Burton', 'https://burton.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ButcherBox', 'https://butcherbox.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Buy Buy Baby', 'https://buybuybaby.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('By Kilian', 'https://bykilian.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('By Terry', 'https://byterry.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ByHeart', 'https://byheart.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Byredo', 'https://www.byredo.com/us_en', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Caitlin Wilson', 'https://caitlinwilson.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('California Pizza Kitchen', 'https://cpk.com', 'pending', FALSE, ARRAY['restaurant']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Calpak', 'https://calpaktravel.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Calvin Klein', 'https://www.calvinklein.us', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY['30s','40s','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CamelBak', 'https://camelbak.com', 'pending', FALSE, ARRAY['direct-to-consumer','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Campbell Soup Company', 'https://www.campbells.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cano Jewelry', 'https://international.canojewelry.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Canon', 'https://usa.canon.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Canopy', 'https://getcanopy.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cantu', 'https://cantubeauty.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Canva', 'https://www.canva.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Capriotti''s', 'https://capriottis.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Captain D''s', 'https://captainds.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Caraway', 'https://carawayhome.com', 'pending', FALSE, ARRAY['sustainable','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carbon38', 'https://carbon38.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carhartt', 'https://carhartt.com', 'active', TRUE, ARRAY['heritage','made-in-usa']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Caribou Coffee', 'https://cariboucoffee.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carl''s Jr.', 'https://carlsjr.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carol''s Daughter', 'https://carolsdaughter.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carolina Herrera', 'https://carolinaherrera.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carrabba’s', 'https://www.carrabbas.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carter''s', 'https://www.carters.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cartier', 'https://cartier.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Carvel', 'https://carvel.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Casetify', 'https://casetify.com', 'pending', FALSE, ARRAY['online-first','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Casio', 'https://casio.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Casper', 'https://casper.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Castlery', 'https://www.castlery.com/us', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Catbird NYC', 'https://www.catbirdnyc.com', 'active', TRUE, ARRAY['boutique','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cato Fashions', 'https://catofashions.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Caudalie', 'https://caudalie.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Causebox', 'https://alltrue.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CAVA', 'https://cava.com', 'active', TRUE, ARRAY['b-corp','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CB Kids', 'https://www.crateandbarrel.com/kids', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CB2', 'https://www.cb2.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cedar Fair', 'https://cedarfair.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Celestial Seasonings', 'https://celestialseasonings.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Celine', 'https://www.celine.com/en-us/home', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Century 21', 'https://c21stores.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CeraVe', 'https://cerave.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ceremonia', 'https://ceremonia.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cettire', 'https://www.cettire.com', 'active', TRUE, ARRAY['online-first','luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chaco', 'https://chacos.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chairish', 'https://www.chairish.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Champion', 'https://champion.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Champs Sports', 'https://champssports.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chanel', 'https://chanel.com/us', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Charley''s Philly Steaks', 'https://charleys.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Charlotte Russe', 'https://charlotterusse.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY['teens','20s']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Charlotte Tilbury', 'https://charlottetilbury.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cheddar''s Scratch Kitchen', 'https://cheddars.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cheetos', 'https://www.cheetos.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chewy', 'https://www.chewy.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chick-fil-A', 'https://www.chick-fil-a.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chico''s', 'https://chicos.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chili’s', 'https://www.chilis.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chipotle', 'https://www.chipotle.com', 'active', TRUE, ARRAY['b-corp']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chippewa Shoes', 'https://chippewaboots.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chloé', 'https://www.chloe.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Chobani', 'http://chobani.com', 'active', TRUE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Choice Hotels', 'https://choicehotels.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Christian Louboutin', 'https://us.christianlouboutin.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Christopher John Rogers', 'https://christopherjohnrogers.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Christy Dawn', 'https://christydawn.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Church & Dwight', 'https://churchdwight.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cider', 'https://shopcider.com', 'active', TRUE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cinemark', 'https://cinemark.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cinnabon', 'https://www.cinnabon.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cinq a Sept', 'https://www.cinqasept.nyc', 'active', TRUE, ARRAY[]::TEXT[], '$$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Citizen', 'https://citizenwatch.com', 'pending', FALSE, ARRAY['luxury','heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Citizens of Humanity', 'https://citizensofhumanity.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Clarks', 'https://www.clarks.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cleancult', 'https://cleancult.com', 'pending', FALSE, ARRAY['sustainable','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ClickUp', 'https://clickup.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Clif Bar', 'https://clifbar.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Clinique', 'https://clinique.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Clorox', 'https://www.clorox.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CO', 'https://co-collections.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coach', 'https://coach.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coach Outlet', 'https://coachoutlet.com', 'pending', FALSE, ARRAY['outlet','luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coca-Cola', 'https://www.coca-cola.com/us/en', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cocokind', 'https://cocokind.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cocoon by Sealy', 'https://cocoonbysealy.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coggles', 'https://coggles.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cold Stone Creamery', 'https://coldstonecreamery.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coldwater Creek', 'https://coldwatercreek.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cole Haan', 'https://colehaan.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Colgate-Palmolive', 'https://www.colgate.com/en-us', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Color Wow', 'https://colorwowhair.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ColourPop', 'https://colourpop.com', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Columbia', 'https://columbia.com', 'active', TRUE, ARRAY['heritage','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Commission NYC', 'https://www.commission.nyc', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Commodity', 'https://commoditygoods.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Common Projects', 'https://commonprojects.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Compartes', 'https://compartes.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Conagra Brands', 'https://www.readyseteat.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Converse', 'https://www.converse.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY['kids','teens']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CookUnity', 'https://cookunity.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coop', 'https://coopsleepgoods.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Copper Beech by the Sea', 'https://copperbeechbythesea.com', 'pending', FALSE, ARRAY['small-brand']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Corkcicle', 'https://corkcicle.com', 'pending', FALSE, ARRAY['direct-to-consumer','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Corner Bakery Cafe', 'https://cornerbakerycafe.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Corsair', 'https://corsair.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('COS', 'https://www.cos.com', 'active', TRUE, ARRAY['luxury','minimalist']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cos Bar', 'https://cosbar.com', 'pending', FALSE, ARRAY['luxury','boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('COSRX', 'https://cosrx.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cost Plus World Market', 'https://worldmarket.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Costa', 'https://costadelmar.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Costa Farms', 'https://costafarms.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Costco', 'https://www.costco.com', 'no_email', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coterie', 'https://coterie.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cotopaxi', 'https://cotopaxi.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Counter Culture Coffee', 'https://counterculturecoffee.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Courant', 'https://staycourant.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Coyuchi', 'https://coyuchi.com', 'pending', FALSE, ARRAY['sustainable','made-in-usa']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cozy Earth', 'https://cozyearth.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CPO Outlets', 'https://cpooutlets.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cracker Barrel', 'https://crackerbarrel.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Craftsman', 'https://craftsman.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crate & Barrel', 'https://www.crateandbarrel.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Credo Beauty', 'https://credobeauty.com', 'active', TRUE, ARRAY['cruelty-free','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Creed', 'https://creedboutique.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crewcuts', 'https://jcrew.com/c/crewcuts', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crocs Inc.', 'https://www.crocs.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crowd Cow', 'https://crowdcow.com', 'pending', FALSE, ARRAY['sustainable','subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crown Affair', 'https://www.crownaffair.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crucial', 'https://crucial.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crumbl Cookies', 'https://crumblcookies.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crumbs Bake Shop', 'https://originalcrumbs.com', 'pending', FALSE, ARRAY['wedding-gifting','small-brand']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Crunchyroll', 'https://crunchyroll.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cub Cadet', 'https://cubcadet.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cuisinart', 'https://cuisinart.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cult Gaia', 'https://cultgaia.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Culver''s', 'https://www.culvers.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Curlsmith', 'https://curlsmith.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cuup', 'https://shopcuup.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cuyana', 'https://cuyana.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('CVS Pharmacy', 'https://www.cvs.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Cybex', 'https://cybex-online.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('D.S. & Durga', 'https://dsanddurga.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dagne Dover', 'https://dagnedover.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Daily Harvest', 'https://dailyharvest.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dairy Queen', 'https://www.dairyqueen.com/en-us', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Damson Madder', 'https://damsonmadder.com/en-us', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Daniel Wellington', 'https://danielwellington.com', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dansko', 'https://dansko.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('David Yurman', 'https://davidyurman.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('David''s Bridal', 'https://davidsbridal.com', 'pending', FALSE, ARRAY['wedding-gifting','boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DAVIDsTEA', 'https://davidstea.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Davines', 'https://davines.com', 'active', TRUE, ARRAY['cruelty-free','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('De''Longhi Group', 'https://www.delonghi.com/en-us', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Death Wish Coffee', 'https://deathwishcoffee.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Deiji Studios', 'https://deijistudios.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Del Taco', 'https://deltaco.com', 'pending', FALSE, ARRAY['restaurant']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dell', 'https://dell.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Delta Air Lines', 'https://delta.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Delvaux', 'https://us.delvaux.com/en', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DeMellier', 'https://demellierlondon.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Denny''s', 'https://dennys.com', 'pending', FALSE, ARRAY['restaurant']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Depop', 'https://www.depop.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Derek Lam 10 Crosby', 'https://dereklam.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Design by Si', 'https://designbysi.se', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Design Within Reach', 'https://www.dwr.com', 'pending', FALSE, ARRAY['luxury','boutique']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DevaCurl', 'https://devacurl.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DeWalt', 'https://dewalt.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Diadora', 'https://www.diadora.com/en/us', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dickies', 'https://dickies.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dieux', 'https://dieuxskin.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DIFF Eyewear', 'https://diffeyewear.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DiGiorno', 'https://www.goodnes.com/digiorno', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dillard''s', 'https://www.dillards.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-15'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dinnerly', 'https://dinnerly.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dior', 'https://www.dior.com/en_us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dippin'' Dots', 'https://dippindots.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Diptyque', 'https://diptyqueparis.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Disney+', 'https://disneyplus.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DISSH', 'https://dissh.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DJI', 'https://dji.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DL1961', 'https://dl1961.com', 'active', TRUE, ARRAY['sustainable','made-in-usa']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DockATot', 'https://dockatot.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DOEN', 'https://www.shopdoen.com', 'pending', FALSE, ARRAY['women-owned','luxury']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dolce & Gabbana', 'https://www.dolcegabbana.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dole', 'https://www.dole.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dollar General', 'https://www.dollargeneral.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dollar Tree', 'https://www.dollartree.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Domino''s Pizza', 'https://dominos.com', 'pending', FALSE, ARRAY['restaurant']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Donni', 'https://shopdonni.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Doona', 'https://doona.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DoorDash', 'https://doordash.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dossier', 'https://dossier.co', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dr. Brown''s', 'https://drbrownsbaby.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dr. Dennis Gross', 'https://drdennisgross.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dr. Jart+', 'https://drjart.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dr. Martens', 'https://drmartens.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DreamCloud', 'https://dreamcloudsleep.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dropbox', 'https://dropbox.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dropps', 'https://dropps.com', 'pending', FALSE, ARRAY['sustainable','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Drunk Elephant', 'https://www.drunkelephant.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Drybar', 'https://www.drybar.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('DSW', 'https://www.dsw.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Duluth Trading Co.', 'https://duluthtrading.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dunkin''', 'https://www.dunkindonuts.com/en', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Dyson', 'https://www.dyson.com', 'active', TRUE, ARRAY['luxury','direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('e.l.f.', 'https://www.elfcosmetics.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Earl of Sandwich', 'https://earlofsandwichusa.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Earth Fare', 'https://www.earthfare.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eastbay', 'https://eastbay.com', 'pending', FALSE, ARRAY['outlet']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eataly', 'https://eataly.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('eBay', 'https://www.ebay.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$', ARRAY['baby','kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ecco', 'https://ecco.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Echo USA', 'https://echo-usa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ecobee', 'https://ecobee.com', 'active', TRUE, ARRAY['sustainable','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eddie Bauer', 'https://www.eddiebauer.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Edible Arrangements', 'https://ediblearrangements.com', 'pending', FALSE, ARRAY['wedding-gifting']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Edikted', 'https://edikted.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eero', 'https://eero.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Effy Jewelry', 'https://effyjewelry.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eggs Up Grill', 'https://eggsupgrill.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eileen Fisher', 'https://www.eileenfisher.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('El Pollo Loco', 'https://elpolloloco.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ello Products', 'https://elloproducts.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ELOQUII', 'https://eloquii.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Elwood', 'https://www.elwoodclothing.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Embrace Pet Insurance', 'https://embracepetinsurance.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('END.', 'https://endclothing.com', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Energizer', 'https://energizer.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Enfamil', 'https://www.enfamil.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Enterprise Rent-A-Car', 'https://enterprise.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Epic Games Store', 'https://store.epicgames.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Equator Coffees', 'https://equatorcoffees.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Equipment', 'https://equipmentfr.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Erewhon', 'https://erewhonmarket.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Esse Studios', 'https://essestudios.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Essentials', 'https://fearofgodessentials.com', 'pending', FALSE, ARRAY['luxury','minimalist']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Essie', 'https://essie.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Estée Lauder', 'https://www.esteelauder.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eterne', 'https://eterne.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ethan Allen', 'https://www.ethanallen.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Etsy', 'https://www.etsy.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eucerin', 'https://eucerinus.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eufy', 'https://eufy.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ever New', 'https://www.evernew.ca', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Evereve', 'https://evereve.com', 'active', TRUE, ARRAY['women-owned','boutique']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Everlane', 'https://www.everlane.com', 'pending', FALSE, ARRAY['direct-to-consumer','sustainable']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Evernote', 'https://evernote.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('EveryPlate', 'https://everyplate.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Everything But Water', 'https://www.everythingbutwater.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-27'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Expedia', 'https://expedia.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Express, Inc.', 'https://www.express.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('EyeBuyDirect', 'https://www.eyebuydirect.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Eyeconic', 'https://www.eyeconic.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FabFitFun', 'https://fabfitfun.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fable', 'https://fablehome.co', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fabletics', 'https://fabletics.com', 'pending', FALSE, ARRAY['women-owned','subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Factor', 'https://factor75.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Faherty', 'https://fahertybrand.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Famous Footwear', 'https://famousfootwear.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fandango', 'https://fandango.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FARFETCH', 'https://www.farfetch.com', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Farm Rio', 'https://www.farmrio.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Farmacy', 'https://farmacybeauty.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FASHIONPHILE', 'https://www.fashionphile.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fatburger', 'https://fatburger.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Favorite Daughter', 'https://www.favoritedaughter.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fear of God', 'https://fearofgod.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fendi', 'https://fendi.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fenty Beauty', 'https://fentybeauty.com', 'pending', FALSE, ARRAY['black-owned','women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ferguson', 'https://ferguson.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ferm Living', 'https://fermliving.com', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ferrell Brand', 'https://ferrellbrand.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Festool', 'https://festoolusa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FFORME', 'https://fforme.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Figma', 'https://figma.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fila', 'https://fila.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Filippa K', 'https://www.filippa-k.com/en-us', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Filson', 'https://filson.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Finish Line', 'https://www.finishline.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Finnish Design Shop', 'https://www.finnishdesignshop.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Firehouse Subs', 'https://firehousesubs.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('First Aid Beauty', 'https://firstaidbeauty.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('First Watch', 'https://firstwatch.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fishwife', 'https://eatfishwife.com', 'active', TRUE, ARRAY['b-corp','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fitbit', 'https://fitbit.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Five Below', 'https://fivebelow.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Five Guys', 'https://fiveguys.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fjällräven', 'https://fjallraven.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Flamingo', 'http://shopflamingo.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Flattered', 'https://us.flattered.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fleming''s Steakhouse', 'https://flemingssteakhouse.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Floor & Decor', 'https://flooranddecor.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Floyd', 'https://floyd.one', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Floyd Home', 'https://floydhome.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fly By Jing', 'https://flybyjing.com', 'no_email', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fogo de Chão', 'https://fogodechao.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Folgers', 'https://folgerscoffee.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Food 4 Less', 'https://food4less.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Food Lion', 'https://foodlion.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Foot Locker', 'https://footlocker.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Foreo', 'https://foreo.com', 'active', TRUE, ARRAY['cruelty-free','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Forever 21', 'https://forever21.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Forward by Elyse Walker', 'https://fwrd.com', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fossil', 'https://www.fossil.com/en-us', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Foundrae', 'https://foundrae.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FRAME', 'https://frame-store.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Framebridge', 'https://framebridge.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FramesDirect', 'https://www.framesdirect.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('France Luxe', 'https://franceluxe.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frank And Oak', 'https://www.frankandoak.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frankies Bikinis', 'https://frankiesbikinis.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fred Meyer', 'https://www.fredmeyer.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frédéric Malle', 'https://fredericmalle.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Free People', 'https://www.freepeople.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Freja New York', 'https://frejanyc.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Freshii', 'https://freshii.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frette', 'https://frette.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frida Baby', 'https://frida.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Friendly''s', 'https://friendlys.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Friends with Frank', 'https://friendswithfrank.com', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frontier Airlines', 'https://flyfrontier.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Frye', 'https://thefryecompany.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FuboTV', 'https://fubo.tv', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Fujifilm', 'https://fujifilm.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Function of Beauty', 'https://functionofbeauty.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Funko', 'https://funko.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('FWRD', 'https://www.fwrd.com', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gabe Gordon', 'https://gabe-gordon.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gabriela Hearst', 'https://www.gabrielahearst.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GameStop', 'https://www.gamestop.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ganni', 'https://www.ganni.com/en-us', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gap', 'https://www.gap.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['baby','kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gap Factory', 'https://www.gapfactory.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$$', ARRAY['baby','kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GapKids', 'https://gap.com/kids', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Garanimals', 'https://garanimals.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gardener''s Supply', 'https://www.gardeners.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Garmentory', 'https://www.garmentory.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Garmin', 'https://garmin.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Garnet Hill', 'https://garnethill.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('General Mills', 'https://www.generalmills.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gerber Childrenswear', 'https://www.gerberchildrenswear.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ghirardelli', 'https://ghirardelli.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Giant Food', 'https://giantfood.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gianvito Rossi', 'https://gianvitorossi.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gilt', 'https://www.gilt.com', 'pending', FALSE, ARRAY['outlet']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GIR', 'https://gir.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Girlfriend Collective', 'https://girlfriend.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Givenchy', 'https://givenchy.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GlassesUSA', 'https://www.glassesusa.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Glossier', 'https://www.glossier.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Glow Recipe', 'https://glowrecipe.com', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GlucGator', 'https://www.glucgator.com', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GOAT', 'https://goat.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gobble', 'https://gobble.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Godiva', 'https://godiva.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Goldbelly', 'https://goldbelly.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Goli Nutrition', 'https://goli.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Good American', 'https://goodamerican.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Goodee', 'https://www.goodeeworld.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Goodles', 'https://www.goodles.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Google Nest', 'https://store.google.com/category/connected_home', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Google Store', 'https://store.google.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Goop Beauty', 'https://goop.com', 'pending', FALSE, ARRAY['women-owned','luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GoPro', 'https://gopro.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gopuff', 'https://gopuff.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gorjana', 'https://gorjana.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Goumi Kids', 'https://goumikids.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Graco Baby', 'https://www.gracobaby.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Grailed', 'https://grailed.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Grainger', 'https://grainger.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Graza', 'https://www.graza.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Great Jones', 'https://greatjones.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Greats', 'https://greats.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Green Chef', 'https://greenchef.com', 'active', TRUE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GreenRow', 'https://www.greenrow.com', 'pending', FALSE, ARRAY['sustainable','boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Greenworks Tools', 'https://greenworkstools.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Groupon', 'https://groupon.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Grove Collaborative', 'https://www.grove.co', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Grovemade', 'https://grovemade.com', 'active', TRUE, ARRAY['sustainable','made-in-usa']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Grubhub', 'https://grubhub.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GT''s Kombucha', 'https://gtslivingfoods.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('GU USA', 'https://www.gu-global.com/us/en', 'active', TRUE, ARRAY['minimalist']::TEXT[], '$$', ARRAY['20s','30s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Gucci', 'https://gucci.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Guess', 'https://www.guess.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('H-E-B', 'https://www.heb.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('H&M', 'https://www2.hm.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Häagen-Dazs', 'https://icecream.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hacci', 'https://www.hacci.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Half Price Books', 'https://www.hpb.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Halo Sleep', 'https://halosleep.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hamilton', 'https://hamiltonwatch.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hanes', 'https://www.hanes.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hanna Andersson', 'https://www.hannaandersson.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hannaford', 'https://hannaford.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hannah Naomi', 'https://hannahnaomi.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Happy Socks', 'https://happysocks.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Harbor Freight', 'https://www.harborfreight.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hardee''s', 'https://hardees.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Harney & Sons', 'https://www.harney.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Harris Teeter', 'https://harristeeter.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Harrods', 'https://harrods.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Harvest & Mill', 'https://harvestandmill.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hasbro', 'https://hasbropulse.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hatch', 'https://hatch.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HAY', 'https://www.hay.com', 'active', TRUE, ARRAY['minimalist']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Health-Ade', 'https://health-ade.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hearts on Fire', 'https://heartsonfire.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Heaven Mayhem', 'https://heavenmayhem.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Helen of Troy', 'https://www.helenoftroy.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Helix Sleep', 'https://helixsleep.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hello Bello', 'https://www.hellobello.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HelloFresh', 'https://hellofresh.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Helly Hansen', 'https://hellyhansen.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Helmut Lang', 'https://www.helmutlang.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['kids','teens','20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Helzberg Diamonds', 'https://helzberg.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hem', 'https://hem.com/en-us', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Henry Rose', 'https://henryrose.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Herbivore', 'https://herbivorebotanicals.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Heretic Parfum', 'https://hereticparfum.com', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Herman Miller', 'https://store.hermanmiller.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hermès', 'https://hermes.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hero Cosmetics', 'https://herocosmetics.us', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Herschel Supply', 'https://herschel.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hertz', 'https://hertz.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hickory Chair', 'https://www.hickorychair.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hill House Home', 'https://hillhousehome.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hill''s Pet Nutrition', 'https://hillspet.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hilton Honors', 'https://hilton.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hint', 'https://drinkhint.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HOKA', 'https://www.hoka.com/en/us', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hollister', 'https://www.hollisterco.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hollywood Feed', 'https://www.hollywoodfeed.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-16'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Home Chef', 'https://homechef.com', 'active', TRUE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HomeGoods', 'https://homegoods.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HomeSense', 'https://homesense.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Honeygrow', 'https://honeygrow.com', 'pending', FALSE, ARRAY['b-corp']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Honeylove', 'https://honeylove.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hooters', 'https://hooters.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hopper', 'https://hopper.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hot Pockets', 'https://www.goodnes.com/hot-pockets', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hot Topic', 'https://hottopic.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hotels.com', 'https://hotels.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hourglass', 'https://hourglasscosmetics.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('House of CB', 'https://www.houseofcb.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('House of Hackney', 'https://houseofhackney.com', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('House of Leon', 'https://houseofleon.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HP', 'https://hp.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Huda Beauty', 'https://hudabeauty.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hudson Grace', 'https://hudsongracesf.com', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hudson Jeans', 'https://hudsonjeans.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Huggies', 'https://www.huggies.com/en-us', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hulu', 'https://hulu.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HUM Nutrition', 'https://humnutrition.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Humble Bundle', 'https://humblebundle.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hungryroot', 'https://hungryroot.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hurley', 'https://hurley.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hush Puppies', 'https://hushpuppies.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Husqvarna', 'https://husqvarna.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hy-Vee', 'https://hy-vee.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hyatt', 'https://hyatt.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Hydro Flask', 'https://hydroflask.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('HyperX', 'https://hyperx.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Iams', 'https://iams.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('IceBreaker', 'https://na.icebreaker.com/en-us', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ichibanmoshi', 'https://ichibanm.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Iconic London', 'https://iconiclondon.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('iGourmet', 'https://igourmet.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('IHG One Rewards', 'https://ihg.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('IHOP', 'https://ihop.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('IKEA', 'https://ikea.com/us', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ILIA Beauty', 'https://iliabeauty.com', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Imperfect Foods', 'https://imperfectfoods.com', 'pending', FALSE, ARRAY['sustainable','subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Impossible Foods', 'https://impossiblefoods.com', 'active', TRUE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('In-N-Out Burger', 'https://www.in-n-out.com', 'no_email', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Indie Lee', 'https://indielee.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Innisfree', 'https://us.innisfree.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Inov-8', 'https://inov-8.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Inside Weather', 'https://insideweather.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Insomnia Cookies', 'https://insomniacookies.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Insta360', 'https://insta360.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Instacart', 'https://instacart.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Instant Brands', 'https://instantbrands.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Intimissimi', 'https://us.intimissimi.com', 'active', TRUE, ARRAY['luxury','mall-stores']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Intimissimi Men''s', 'https://www.intimissimi.com/us/men', 'pending', FALSE, ARRAY['luxury','mall-stores']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-05-02'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ipsy', 'https://ipsy.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('iRobot', 'https://www.irobot.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Isabel Marant', 'https://www.isabelmarant.com/us', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('J Brand', 'https://jbrandjeans.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('J.Crew', 'https://www.jcrew.com', 'active', TRUE, ARRAY['mall-stores','heritage']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('J.Crew Factory', 'https://factory.jcrew.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('J.Jill', 'https://jjill.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jack in the Box', 'https://www.jackinthebox.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jacquemus', 'https://www.jacquemus.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jacquie Aiche', 'https://jacquieaiche.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jamba', 'https://jamba.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('James Allen', 'https://jamesallen.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Janessa Leone', 'https://janessaleone.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Janie and Jack', 'https://janieandjack.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Janji', 'https://runjanji.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jared', 'https://jared.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('JBL', 'https://jbl.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('JCPenney', 'https://www.jcpenney.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$', ARRAY['baby','kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jeni''s Splendid Ice Creams', 'https://jenis.com', 'active', TRUE, ARRAY['b-corp','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jenni Kayne', 'https://www.jennikayne.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jenny Bird', 'https://jenny-bird.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jersey Mike''s Subs', 'https://www.jerseymikes.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('JetBlue', 'https://jetblue.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jil Sander', 'https://www.jilsander.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jimmy Choo', 'https://jimmychoo.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jimmy John’s', 'https://www.jimmyjohns.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('JJ Snack Foods', 'https://www.jjsnack.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jo Malone London', 'https://jomalone.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Joe Coffee', 'https://joecoffeecompany.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Joe''s Crab Shack', 'https://joescrabshack.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Joe''s Jeans', 'https://joesjeans.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('John Deere', 'https://deere.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('John Hardy', 'https://johnhardy.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Johnny Was', 'https://www.johnnywas.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Johnston & Murphy', 'https://johnstonmurphy.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Joie', 'https://joie.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jonathan Adler', 'https://www.jonathanadler.com', 'pending', FALSE, ARRAY['luxury','boutique']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jonathan Simkhai', 'https://jonathansimkhai.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jones Road Beauty', 'https://www.jonesroadbeauty.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Joss & Main', 'https://jossandmain.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Journeys', 'https://journeys.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Joybird', 'https://joybird.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('July', 'https://july.com', 'pending', FALSE, ARRAY['direct-to-consumer','small-brand']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Jungalow', 'https://jungalow.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Juniper Print Shop', 'https://juniperprintshop.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Just Food For Dogs', 'https://justfoodfordogs.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Just Salad', 'https://justsalad.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Justin Shoes', 'https://justinboots.com', 'pending', FALSE, ARRAY['western','heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('K18 Hair', 'https://www.k18hair.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kappa', 'https://kappausa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kate Quinn', 'https://katequinn.com', 'active', TRUE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kate Spade New York', 'https://katespade.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kate Spade Outlet', 'https://katespadeoutlet.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kay Jewelers', 'https://kay.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kayak', 'https://kayak.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KEEN', 'https://keenfootwear.com', 'pending', FALSE, ARRAY['heritage','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kellanova', 'https://www.kellanovaus.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kendra Scott', 'https://kendrascott.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kerastase', 'https://kerastase-usa.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Keurig', 'https://www.keurig.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Keychron', 'https://keychron.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KFC', 'https://www.kfc.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Khaite', 'https://khaite.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KidKraft', 'https://kidkraft.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kidrobot', 'https://kidrobot.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kiehl''s', 'https://kiehls.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kiel James Patrick', 'https://www.kjp.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KIND Snacks', 'https://kindsnacks.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kirkland''s', 'https://kirklands.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KitchenAid', 'https://kitchenaid.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kith', 'https://kith.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KitNipBox', 'https://kitnipbox.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kjaer Weis', 'https://kjaerweis.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Klean Kanteen', 'https://kleankanteen.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Knix', 'https://knix.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Knoll', 'https://www.knoll.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kohl’s', 'https://www.kohls.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$', ARRAY['kids','teens','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kohler', 'https://www.kohler.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Koio', 'https://www.koio.co', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kookai', 'https://www.kookai.com.au', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kopari Beauty', 'https://koparibeauty.com', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kosas', 'https://www.kosas.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kotn', 'https://kotn.com', 'active', TRUE, ARRAY['b-corp','sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kowtow', 'https://kowtowclothing.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kraft Heinz', 'https://www.kraftheinzcompany.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Krewe', 'https://krewe.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Krispy Kreme', 'https://krispykreme.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kroger', 'https://www.kroger.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Krystal', 'https://krystal.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('KVD Beauty', 'https://kvdveganbeauty.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Kyte Baby', 'https://kytebaby.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('L.L.Bean', 'https://www.llbean.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('L''Agence', 'https://lagence.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('L''Oréal', 'https://www.lorealparis.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('L*Space', 'https://lspace.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Colombe', 'https://lacolombe.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Croix', 'https://lacroixwater.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Ligne', 'https://lalignenyc.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Mer', 'https://cremedelamer.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Roche-Posay', 'https://laroche-posay.us', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Sportiva', 'https://sportiva.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La Tienda', 'https://latienda.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('La-Z-Boy', 'https://www.la-z-boy.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lake Champlain Sweet Treats', 'https://lakechamplainchocolates.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lalo', 'https://www.meetlalo.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lancôme', 'https://lancome-usa.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lands'' End', 'https://www.landsend.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lane Bryant', 'https://lanebryant.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Laneige', 'https://laneige.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LaQuan Smith', 'https://laquansmith.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Larabar', 'https://larabar.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Larsson & Jennings', 'https://larssonandjennings.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Laura Mercier', 'https://lauramercier.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lawless', 'https://lawlessbeauty.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Le Creuset', 'https://lecreuset.com', 'pending', FALSE, ARRAY['luxury','heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Le Labo', 'https://lelabofragrances.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Le Pain Quotidien', 'https://lepainquotidien.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Le Tanneur', 'https://www.letanneur.us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LE17SEPTEMBRE', 'https://le17septembre.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lee', 'https://lee.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Leesa', 'https://leesa.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LEGO', 'https://lego.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Leica', 'https://leica-camera.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lele Sadoughi', 'https://leletny.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lemonade', 'https://lemonadela.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lenovo', 'https://lenovo.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LensCrafters', 'https://lenscrafters.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Léon & George', 'https://leonandgeorge.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LESET', 'https://www.leset.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Levain Bakery', 'https://levainbakery.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Levi''s', 'https://www.levi.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LG Electronics', 'https://www.lg.com/us', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Liberty London', 'https://libertylondon.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Libro.fm', 'https://libro.fm', 'pending', FALSE, ARRAY['subscription','small-brand']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lidl US', 'https://lidl.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lindt', 'https://lindtusa.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LinkedIn', 'https://www.linkedin.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Linteloo', 'https://linteloo.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Liquid Death', 'https://liquiddeath.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lisa Yang', 'https://us.lisa-yang.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Litter-Robot', 'https://litter-robot.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Little Caesars', 'https://littlecaesars.com/en-us', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Little Sleepies', 'https://littlesleepies.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Little Tikes', 'https://littletikes.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Live Nation', 'https://livenation.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lively', 'https://wearlively.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Living Proof', 'https://livingproof.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Living Spaces', 'https://livingspaces.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LivingSocial', 'https://livingsocial.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LL Flooring', 'https://llflooring.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Llume Jewelry', 'https://llumejewelry.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lo & Sons', 'https://loandsons.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Local Eclectic', 'https://www.localeclectic.com', 'active', TRUE, ARRAY['women-owned','boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lodge Cast Iron', 'https://lodgecastiron.com', 'pending', FALSE, ARRAY['heritage','made-in-usa']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Loft', 'https://www.loft.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Logitech', 'https://logitech.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Loloi', 'https://loloirugs.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Long John Silver''s', 'https://ljsilvers.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LongHorn Steakhouse', 'https://www.longhornsteakhouse.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Loot Crate', 'https://lootcrate.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lord & Taylor', 'https://lordandtaylor.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Loro Piana', 'https://us.loropiana.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lou & Grey', 'https://www.loft.com/lou-grey/lou-grey-shop-all/cat1880002', 'active', TRUE, ARRAY['mall-stores','minimalist']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-05-02'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lovevery', 'https://lovevery.com', 'pending', FALSE, ARRAY['women-owned','subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lowa', 'https://lowaboots.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lowe''s', 'https://www.lowes.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LTK', 'https://www.shopltk.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lucky Brand', 'https://luckybrand.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LuisaViaRoma', 'https://luisaviaroma.com', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lulu and Georgia', 'https://www.luluandgeorgia.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lululemon', 'https://shop.lululemon.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lulus', 'https://lulus.com', 'pending', FALSE, ARRAY['women-owned','online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lumens', 'https://www.lumens.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lunya', 'https://lunya.co', 'pending', FALSE, ARRAY['women-owned','luxury']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lush', 'https://www.lush.com/us', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lutron', 'https://lutron.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('LXR & Co.', 'https://lxrco.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lyft', 'https://lyft.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lysol', 'https://www.lysol.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Lyst', 'https://lyst.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('M.Gemi', 'https://mgemi.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MAC Cosmetics', 'https://maccosmetics.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Machete', 'https://shopmachete.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Macy''s', 'https://www.macys.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY['baby','kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Made In', 'https://madeincookware.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Madewell', 'https://www.madewell.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Madison Reed', 'https://madison-reed.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maggiano''s Little Italy', 'https://maggianos.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Magic Spoon', 'https://magicspoon.com', 'pending', FALSE, ARRAY['women-owned','subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Magnetic Me', 'https://magneticme.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Magnolia', 'https://magnolia.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Magnolia Bakery', 'https://www.magnoliabakery.com', 'active', TRUE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Magnolia Bakery', 'https://magnoliabakery.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Magnum', 'https://magnumicecream.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maguire', 'https://www.us.maguireshoes.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maiden Home', 'https://www.maidenhome.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maison Francis Kurkdjian', 'https://franciskurkdjian.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maison Louis Marie', 'https://maisonlouismarie.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maison Margiela Replica', 'https://maisonmargiela-fragrances.us', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maisonette', 'https://www.maisonette.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maje', 'https://us.maje.com', 'active', TRUE, ARRAY['luxury','mall-stores']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MAKE Beauty', 'https://www.makebeauty.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Makita', 'https://makitatools.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Malin + Goetz', 'https://www.malinandgoetz.com', 'pending', FALSE, ARRAY['luxury','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mammut', 'https://mammut.com', 'pending', FALSE, ARRAY['sustainable','heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mango', 'https://shop.mango.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ManiMe', 'https://manime.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Manolo Blahnik', 'https://manoloblahnik.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mansur Gavriel', 'https://www.mansurgavriel.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marc Jacobs', 'https://marcjacobs.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marchesa', 'https://marchesa.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marco Bicego', 'https://marcobicego.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marco''s Pizza', 'https://marcos.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Margaux', 'https://margauxny.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maria Tash', 'https://mariatash.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mariano''s', 'https://www.marianos.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marine Layer', 'https://marinelayer.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mario Badescu', 'https://mariobadescu.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marley Spoon', 'https://marleyspoon.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marmot', 'https://marmot.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marni', 'https://marni.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marriott Bonvoy', 'https://marriott.com', 'pending', FALSE, ARRAY['subscription','heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mars Wrigley', 'https://mars.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marsell', 'https://www.marsell.it/en', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marshall', 'https://marshallheadphones.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Marshalls', 'https://marshalls.com', 'pending', FALSE, ARRAY['outlet']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mast Brothers', 'https://mastmarket.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Matches', 'https://www.matchesfashion.com/us', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MATE the Label', 'https://matethelabel.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mateo', 'https://mateonewyork.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Material Kitchen', 'https://materialkitchen.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mattel', 'https://creations.mattel.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Matteo', 'https://matteohome.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mattress Firm', 'https://mattressfirm.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maui Jim', 'https://mauijim.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maurices', 'https://maurices.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Max', 'https://max.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Max Mara', 'https://us.maxmara.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Max-Bone', 'https://www.maxbone.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maxfield LA', 'https://www.maxfieldla.com', 'active', TRUE, ARRAY['luxury','boutique']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maxi-Cosi', 'https://maxicosi.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Maxwell House', 'https://maxwellhouse.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('McAlister''s Deli', 'https://mcalistersdeli.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('McDonald''s', 'https://www.mcdonalds.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('McGee & Co.', 'https://mcgeeandco.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ME+EM', 'https://www.meandem.com/us', 'active', TRUE, ARRAY['women-owned','luxury']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Meijer', 'https://www.meijer.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mejuri', 'https://mejuri.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Melissa & Doug', 'https://melissaanddoug.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Menards', 'https://menards.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mendocino Farms', 'https://mendocinofarms.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mephisto', 'https://mephisto.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mercari', 'https://mercari.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MERIT Beauty', 'https://www.meritbeauty.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Merrell', 'https://merrell.com', 'active', TRUE, ARRAY['heritage','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Meshki', 'https://www.meshki.us', 'pending', FALSE, ARRAY['women-owned','online-first']::TEXT[], '$$', ARRAY['20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Method', 'https://methodhome.com', 'pending', FALSE, ARRAY['sustainable','cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MeUndies', 'https://meundies.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Michael Kors', 'https://michaelkors.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Micro Center', 'https://microcenter.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Microsoft Store', 'https://microsoft.com/store', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mid-Day Squares', 'https://www.middaysquares.com/?&currency=usd', 'pending', FALSE, ARRAY['women-owned','small-brand']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Midori Jewelry', 'https://midorijewelry.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mielle Organics', 'https://mielleorganics.com', 'pending', FALSE, ARRAY['black-owned','women-owned','cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Milk Bar', 'https://milkbarstore.com', 'active', TRUE, ARRAY['boutique','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Milk Makeup', 'https://milkmakeup.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Millie Moon', 'https://milliemoon.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Milwaukee Tool', 'https://milwaukeetool.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mini Boden', 'https://bodenusa.com/mini-boden', 'pending', FALSE, ARRAY['heritage','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Minted', 'https://minted.com', 'active', TRUE, ARRAY['women-owned','wedding-gifting']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Miracle Brand', 'https://www.miraclebrand.co', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-17'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Misen', 'https://misen.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Misfits Market', 'https://misfitsmarket.com', 'active', TRUE, ARRAY['sustainable','subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Misha & Puff', 'https://shop.misha-and-puff.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Missguided', 'https://www.missguided.com/market-us', 'active', TRUE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Missoma', 'https://missoma.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mitchell Gold + Bob Williams', 'https://mgbwhome.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Miu Miu', 'https://miumiu.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mizuno', 'https://mizunousa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mizzen+Main', 'https://mizzenandmain.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mod Pizza', 'https://modpizza.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Moda Operandi', 'https://www.modaoperandi.com', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Moe''s Southwest Grill', 'https://moes.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Moncler', 'https://www.moncler.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Monday.com', 'https://monday.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mondelēz International', 'https://www.snackworks.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Monica + Andy', 'https://www.monicaandandy.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Monica Vinader', 'https://www.monicavinader.com/us', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Monique Lhuillier', 'https://moniquelhuillier.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Monos', 'https://monos.com', 'pending', FALSE, ARRAY['direct-to-consumer','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Moosejaw', 'https://moosejawclothing.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mophie', 'https://mophie.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mori', 'https://babymori.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Morning Brew', 'https://morningbrew.com', 'active', TRUE, ARRAY['subscription','online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Moroccanoil', 'https://moroccanoil.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Morphe', 'https://morphe.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Morton''s', 'https://mortons.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Moscot', 'https://moscot.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mother Denim', 'https://www.motherdenim.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mountain Hardwear', 'https://mountainhardwear.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Movado', 'https://movado.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MR PORTER', 'https://mrporter.com', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mrs. Meyer''s', 'https://mrsmeyers.com', 'pending', FALSE, ARRAY['cruelty-free','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MSI', 'https://msi.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Muji', 'https://www.muji.us', 'pending', FALSE, ARRAY['minimalist']::TEXT[], '$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mulberry', 'https://www.mulberry.com/us', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Murad', 'https://murad.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Murray''s Cheese', 'https://murrayscheese.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mustela', 'https://mustelausa.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('MVMT', 'https://mvmt.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Mytheresa', 'https://www.mytheresa.com/us/en', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Naadam', 'https://naadam.co', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Naf Naf Grill', 'https://nafnafgrill.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nanit', 'https://nanit.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Naot', 'https://naot.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('NARS', 'https://narscosmetics.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nasty Gal', 'https://nastygal.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Native Shoes', 'https://www.nativeshoes.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Native Union', 'https://www.nativeunion.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Natori', 'https://natori.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nature Made', 'https://naturemade.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Navygrey', 'https://navygrey.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nécessaire', 'https://necessaire.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nectar Sleep', 'https://nectarsleep.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Need Supply', 'https://needsupply.com', 'pending', FALSE, ARRAY['luxury','online-first']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Negative Underwear', 'https://negativeunderwear.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Neiman Marcus', 'https://www.neimanmarcus.com', 'active', TRUE, ARRAY['luxury','department-store']::TEXT[], '$$$$', ARRAY['baby','kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nespresso', 'https://nespresso.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nestle', 'https://www.nestle.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Net-A-Porter', 'https://www.net-a-porter.com', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Netflix', 'https://netflix.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Netgear', 'https://netgear.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('New Balance', 'https://www.newbalance.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Newegg', 'https://newegg.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Newell Brands', 'https://www.newellbrands.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Newton Baby', 'https://www.newtonbaby.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nike', 'https://www.nike.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nikon', 'https://nikonusa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ninja Kitchen', 'https://ninjakitchen.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nintendo', 'https://nintendo.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nisolo', 'https://nisolo.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nom Nom', 'https://nomnomnow.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nordgreen', 'https://nordgreen.com', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nordic Knots', 'https://nordicknots.com', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nordstrom', 'https://www.nordstrom.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nordstrom Rack', 'https://www.nordstromrack.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Northern Tool', 'https://www.northerntool.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Norwegian Wool', 'https://norwegianwool.com', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nothing', 'https://us.nothing.tech', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nothing Bundt Cakes', 'https://nothingbundtcakes.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nothing New', 'https://nothingnew.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Notion', 'https://notion.so', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('NudeStix', 'https://nudestix.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('NuFace', 'https://mynuface.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nuna', 'https://nunababy.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Nuuly', 'https://nuuly.com', 'active', TRUE, ARRAY['rental']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Oak + Fort', 'https://oakandfort.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Oakley', 'https://oakley.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Oats Overnight', 'https://oatsovernight.com', 'pending', FALSE, ARRAY['small-brand']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Objkts Jewelry', 'https://objktsjewelry.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Off-White', 'https://off---white.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Officine Universelle Buly', 'https://buly1803.com/en-us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olaplex', 'https://olaplex.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Old Navy', 'https://oldnavy.gap.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olipop', 'https://drinkolipop.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olive & June', 'https://oliveandjune.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olive Garden', 'https://www.olivegarden.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olivia Burton', 'https://oliviaburton.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ollie', 'https://myollie.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olly', 'https://olly.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OluKai', 'https://olukai.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Olympia Coffee', 'https://olympiacoffee.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Omaha Steaks', 'https://omahasteaks.com', 'active', TRUE, ARRAY['subscription']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Omega', 'https://omegawatches.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('On', 'https://www.on.com/en-us', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('One Kings Lane', 'https://onekingslane.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Onia', 'https://onia.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Onsen Towel', 'https://onsentowel.com', 'pending', FALSE, ARRAY['small-brand']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-18'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Onyx Coffee Lab', 'https://onyxcoffeelab.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Open Farm', 'https://openfarmpet.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Open Spaces', 'https://getopenspaces.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OpenAI', 'https://openai.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OpenTable', 'https://opentable.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OPI', 'https://opi.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Orange Julius', 'https://www.orangejulius.com/en-us', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Origins', 'https://origins.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Orly', 'https://orlybeauty.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Oscar de la Renta', 'https://oscardelarenta.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OSEA', 'https://oseamalibu.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OshKosh B''gosh', 'https://www.carters.com/b/oshkosh', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OtterBox', 'https://otterbox.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ouai', 'https://theouai.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Our Place', 'https://fromourplace.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Oura', 'https://ouraring.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Outback Steakhouse', 'https://outback.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Outdoor Research', 'b-corp certified; sustainable', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Outdoor Voices', 'https://outdoorvoices.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Outerknown', 'https://www.outerknown.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Overstock', 'https://www.overstock.com', 'active', TRUE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Owala', 'https://owalalife.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Owlet', 'https://owletcare.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('OXO', 'https://oxo.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('P.F. Chang’s', 'https://www.pfchangs.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pacifica', 'https://pacificabeauty.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PacSun', 'https://www.pacsun.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['kids','teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pact', 'https://wearpact.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Paige', 'https://paige.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pair Eyewear', 'https://paireyewear.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Palm Angels', 'https://www.palmangels.com/en-us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pampers', 'https://www.pampers.com/en-us', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Panda Express', 'https://www.pandaexpress.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pandora', 'https://us.pandora.net', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Panera Bread', 'https://www.panerabread.com', 'active', TRUE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Panerai', 'https://panerai.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Papa Johns', 'https://papajohns.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Papa Murphy''s', 'https://papamurphys.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Parachute Home', 'https://www.parachutehome.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Parade', 'https://yourparade.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Paramount+', 'https://paramountplus.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Parisa Wang', 'https://www.parisawang.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Parke Official', 'https://parkeofficial.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pat McGrath Labs', 'https://patmcgrath.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Patagonia', 'https://www.patagonia.com', 'active', TRUE, ARRAY['sustainable','heritage']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pattern Beauty', 'https://patternbeauty.com', 'active', TRUE, ARRAY['black-owned','women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Paula''s Choice', 'https://paulaschoice.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pavilions', 'https://pavilions.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Peach & Lily', 'https://peachandlily.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Peacock', 'https://peacocktv.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pearle Vision', 'https://pearlevision.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Peche', 'https://shop-peche.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Peet’s Coffee', 'https://www.peets.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pei Wei', 'https://peiwei.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pendleton', 'https://pendleton-usa.com', 'active', TRUE, ARRAY['heritage','made-in-usa']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Penhaligon''s', 'https://penhaligons.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PepsiCo', 'https://www.tastyrewards.com/en-us', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Perdue', 'https://www.perdue.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Perkins', 'https://perkinsrestaurants.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Perplexity', 'https://perplexity.ai', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Persol', 'https://persol.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pet Fairs', 'https://www.petfairs.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-19'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pet Plate', 'https://petplate.com', 'active', TRUE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pet Supermarket', 'https://www.petsupermarket.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-20'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PetCo', 'https://www.petco.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Peter Millar', 'https://petermillar.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Petfood Express', 'https://www.petfood.express', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-22'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Petite Plume', 'https://petite-plume.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PetSmart', 'https://www.petsmart.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-23'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Petticoat Fair', 'http://petticoatfair.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-27'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Philips Hue', 'https://philips-hue.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Phlur', 'https://phlur.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pick Up Stix', 'https://pickupstix.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pier 1', 'https://pier1.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Piggly Wiggly', 'https://pigglywiggly.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PINK', 'https://victoriassecret.com/us/pink', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pipette', 'https://pipettebaby.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pixi Beauty', 'https://pixibeauty.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pizza Hut', 'https://pizzahut.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PlayStation', 'https://playstation.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Poelle', 'https://poelle.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Polaroid', 'https://polaroid.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Polene', 'https://eng.polene-paris.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Politico', 'https://politico.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pomellato', 'https://pomellato.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Poppi', 'https://drinkpoppi.com', 'active', TRUE, ARRAY['sustainable','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Porter Road', 'https://porterroad.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Poshmark', 'https://poshmark.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Post', 'https://www.postconsumerbrands.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Postmates', 'https://postmates.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Potbelly', 'https://potbelly.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pottery Barn', 'https://www.potterybarn.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pottery Barn Kids', 'https://www.potterybarnkids.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pottery Barn Teen', 'https://pbteen.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Powell''s Books', 'https://powells.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Prada', 'https://prada.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pret A Manger', 'https://pret.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pretty Litter', 'https://prettylitter.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('PrettyLittleThing', 'https://prettylittlething.us', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Priceline', 'https://priceline.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Primary', 'https://www.primary.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Princess Polly', 'https://us.princesspolly.com', 'pending', FALSE, ARRAY['women-owned','online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Privé Revaux', 'https://priverevaux.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Procter & Gamble', 'https://www.pggoodeveryday.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Proenza Schouler', 'https://proenzaschouler.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pronovias', 'https://pronovias.com', 'active', TRUE, ARRAY['wedding-gifting','luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Prose', 'https://prose.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Public Goods', 'https://publicgoods.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Public Tokyo', 'https://publictokyo.com/en-us', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Publix', 'https://www.publix.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Puck', 'https://puck.news', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Puma', 'https://us.puma.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY['kids','teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Pureology', 'https://pureology.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Purina', 'https://purina.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Purple', 'https://purple.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Purple Carrot', 'https://purplecarrot.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Qdoba', 'https://qdoba.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quaker Oats', 'https://www.quakeroats.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quay Australia', 'https://quayaustralia.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quest Nutrition', 'https://questnutrition.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quiksilver', 'https://quiksilver.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quince', 'https://www.onequince.com', 'active', TRUE, ARRAY['sustainable','direct-to-consumer']::TEXT[], '$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quince Home', 'https://quince.com/home', 'pending', FALSE, ARRAY['sustainable','direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Quiznos', 'https://quiznos.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rachel Comey', 'https://www.rachelcomey.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Radley London', 'https://www.radleylondon.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rag & Bone', 'https://rag-bone.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rains', 'https://www.rains.com', 'active', TRUE, ARRAY['luxury','sustainable']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Raising Cane''s', 'https://www.raisingcanes.com', 'no_email', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ralph Lauren', 'https://www.ralphlauren.com', 'active', TRUE, ARRAY['luxury','heritage']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ralphs', 'https://ralphs.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rare Beauty', 'https://rarebeauty.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ray-Ban', 'https://ray-ban.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Raymour & Flanigan', 'https://raymourflanigan.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Razer', 'https://razer.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Re/Done', 'https://shopredone.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rebag', 'https://www.rebag.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rebecca Taylor', 'https://www.rebeccataylor.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Recess', 'https://takearecess.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Red Lobster', 'https://www.redlobster.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Red Wing', 'https://redwingshoes.com', 'active', TRUE, ARRAY['heritage','made-in-usa']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Red Wing Heritage', 'https://redwingheritage.com', 'pending', FALSE, ARRAY['heritage','made-in-usa']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Redken', 'https://redken.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Reebok', 'https://reebok.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Reef', 'https://reef.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Reformation', 'https://www.thereformation.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Reformation Wedding', 'https://thereformation.com/weddings', 'pending', FALSE, ARRAY['wedding-gifting','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('REFY Beauty', 'https://us.refybeauty.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Regal Cinemas', 'https://regmovies.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('REI', 'https://www.rei.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Reiss', 'https://www.reiss.com/us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rejina Pyo', 'https://rejinapyo.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rejuvenation', 'https://rejuvenation.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ren Clean Skincare', 'https://renskincare.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Renggli Studio', 'https://rengglistudio.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rent the Runway', 'https://renttherunway.com', 'pending', FALSE, ARRAY['rental']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Restoration Hardware', 'https://rh.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Resy', 'https://resy.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Revival Rugs', 'https://revivalrugs.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Revolve', 'https://www.revolve.com', 'active', TRUE, ARRAY['online-first','luxury']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rhode', 'https://www.rhodeskin.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rhone', 'https://rhone.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Riley Home', 'https://rileyhome.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rimowa', 'https://rimowa.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ring', 'https://ring.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rita''s Italian Ice', 'https://ritasice.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rite Aid', 'https://riteaid.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ritual', 'https://ritual.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('RMS Beauty', 'https://rmsbeauty.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Roaman''s', 'https://roamans.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rockler', 'https://www.rockler.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rohe', 'https://roheframes.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Roku', 'https://roku.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rolex', 'https://rolex.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Romano''s Macaroni Grill', 'https://macaronigrill.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Romwe', 'https://us.romwe.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Room & Board', 'https://roomandboard.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ROOM4044', 'https://room4044.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rose Inc', 'https://www.roseinc.com', 'active', TRUE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ross Dress for Less', 'https://rossstores.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rothy''s', 'https://rothys.com', 'active', TRUE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Roti', 'https://roti.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Round Table Pizza', 'https://roundtablepizza.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Roxy', 'https://roxy.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Royal Canin', 'https://royalcanin.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rubio''s', 'https://rubios.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rue Sophie', 'https://ruesophie.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('rue21', 'https://rue21.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Runway', 'https://runwayml.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Russell Stover', 'https://russellstover.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ruth''s Chris', 'https://ruthschris.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('RVCA', 'https://rvca.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('RXBAR', 'https://rxbar.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Rylee + Cru', 'https://ryleeandcru.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ryobi Tools', 'https://ryobitools.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('S''well', 'https://swell.com', 'active', TRUE, ARRAY['direct-to-consumer','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saatchi Art', 'https://saatchiart.com', 'active', TRUE, ARRAY['online-first']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saatva', 'https://saatva.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sabai', 'https://sabai.design', 'pending', FALSE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Safeway', 'https://www.safeway.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saie', 'https://www.saiehello.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saint Laurent', 'https://ysl.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saje Natural Wellness', 'https://www.saje.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sakara', 'https://sakara.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saks Fifth Avenue', 'https://saksfifthavenue.com', 'pending', FALSE, ARRAY['luxury','department-store']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saks OFF 5TH', 'https://saksoff5th.com', 'pending', FALSE, ARRAY['outlet']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saladworks', 'https://saladworks.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sally Beauty', 'https://www.sallybeautyholdings.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sally Hansen', 'https://sallyhansen.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sally''s Beauty Supply', 'https://sallybeauty.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Salomon', 'https://www.salomon.com/en-us', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Salt & Stone', 'https://www.saltandstone.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Salt & Straw', 'https://saltandstraw.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saltair', 'https://saltair.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saltyface', 'https://saltyface.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Salvatore Ferragamo', 'https://ferragamo.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sam Edelman', 'https://samedelman.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sam’s Club', 'https://www.samsclub.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Samsonite', 'https://samsonite.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Samsung Electronics', 'https://www.samsung.com/us', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SanDisk', 'https://sandisk.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sandro', 'https://us.sandro-paris.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sanuk', 'https://sanuk.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sara Weinstock', 'https://saraweinstock.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sarah Flint', 'https://www.sarahflint.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sargento', 'https://sargento.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Satechi', 'https://satechi.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Saucony', 'https://www.saucony.com/en', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Save A Lot', 'https://savealot.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Scarpa', 'https://scarpa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Schlotzsky''s', 'https://schlotzskys.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Schnucks', 'https://schnucks.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Schoolhouse', 'https://schoolhouse.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Schott NYC', 'https://schottnyc.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Schutz', 'https://schutz-shoes.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Schwarzkopf', 'https://schwarzkopf-us.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Scout & Nimble', 'https://scoutandnimble.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Scribd', 'https://scribd.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Seagate', 'https://seagate.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SeatGeek', 'https://seatgeek.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SeaWorld', 'https://seaworld.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('See Kai Run', 'https://seekairun.com', 'active', TRUE, ARRAY['sustainable','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('See''s Candies', 'https://www.sees.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Seiko', 'https://seikousa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Self-Portrait', 'https://www.self-portrait.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Selfless by Hyram', 'https://selfless.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Selfridges', 'https://selfridges.com', 'pending', FALSE, ARRAY['luxury','department-store']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sennheiser', 'https://sennheiser-hearing.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sephora', 'https://www.sephora.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Serena & Lily', 'https://serenaandlily.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Set Active', 'https://setactive.co', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Seventh Generation', 'https://seventhgeneration.com', 'pending', FALSE, ARRAY['sustainable','cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sezane', 'https://www.sezane.com/us-en', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sferra', 'https://sferra.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shake Shack', 'https://www.shakeshack.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shark Beauty', 'https://sharkbeauty.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SharkNinja', 'https://www.sharkninja.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SheaMoisture', 'https://sheamoisture.com', 'pending', FALSE, ARRAY['cruelty-free','black-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SHEIN', 'https://us.shein.com', 'active', TRUE, ARRAY['online-first']::TEXT[], '$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sherwin-Williams', 'https://sherwin-williams.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shevoke', 'https://shevoke.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shinola Detroit', 'https://shinola.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shipt', 'https://shipt.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shiseido', 'https://shiseido.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shoe Carnival', 'https://www.shoecarnival.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shopbop', 'https://www.shopbop.com', 'active', TRUE, ARRAY['luxury','online-first']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ShopRite', 'https://shoprite.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shopstyle', 'https://shopstyle.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Shure', 'https://shure.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sierra', 'https://sierra.com', 'pending', FALSE, ARRAY['outlet']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Similac', 'https://www.abbottnutrition.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Simple & Dainty', 'https://simpleanddainty.com', 'active', TRUE, ARRAY['women-owned','boutique']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SimpliSafe', 'https://simplisafe.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sisley Paris', 'https://www.sisley-paris.com/en-us', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Six Flags', 'https://sixflags.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SK-II', 'https://sk-ii.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Skagen', 'https://skagen.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Skechers', 'https://skechers.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Skims', 'https://skims.com', 'active', TRUE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SkinCeuticals', 'https://skinceuticals.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Skinfix', 'https://skinfix.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Skylar', 'https://skylar.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Slack', 'https://slack.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sleep Number', 'https://sleepnumber.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sling TV', 'https://sling.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SLVRLAKE Denim', 'https://slvrlake-denim.com', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SmartBuyGlasses', 'https://www.smartbuyglasses.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smashbox', 'https://smashbox.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smashburger', 'https://smashburger.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smeg', 'https://smegusa.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smith Optics', 'https://smithoptics.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smith Teamaker', 'https://smithtea.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smoothie King', 'https://smoothieking.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Smythe', 'https://shopsmythe.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Snake River Farms', 'https://snakeriverfarms.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Snif', 'https://snif.co', 'pending', FALSE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Snoo', 'https://happiestbaby.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Snooze A.M. Eatery', 'https://snoozeeatery.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Snowe', 'https://snowehome.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Snuggle Me Organic', 'https://snugglemeorganic.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Société', 'https://societe.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Society6', 'https://society6.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Soft Services', 'https://softservices.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Soft Surroundings', 'https://softsurroundings.com', 'pending', FALSE, ARRAY['department-store']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Soho Home', 'https://www.sohohome.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Soko Glam', 'https://sokoglam.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sol de Janeiro', 'https://soldejaneiro.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Solawave', 'https://solawave.co', 'active', TRUE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Solid & Striped', 'https://www.solidandstriped.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Solly Baby', 'https://sollybaby.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Solstice Sunglasses', 'https://solsticesunglasses.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Soma', 'https://soma.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Songmont', 'https://songmontofficial.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sonic Drive-In', 'https://sonicdrivein.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sonos', 'https://sonos.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sony', 'https://electronics.sony.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SOREL', 'https://www.sorel.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Southern Tide', 'https://southerntide.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Southwest Airlines', 'https://southwest.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spanx', 'https://spanx.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sparkling Ice', 'https://sparklingice.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Speedo', 'https://us.speedo.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spencer''s', 'https://spencersonline.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sperry', 'https://sperry.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spigen', 'https://spigen.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spindrift', 'https://drinkspindrift.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spinelli Kilcollin', 'https://www.spinellikilcollin.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spirit Airlines', 'https://spirit.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Splits59', 'https://splits59.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Spotify', 'https://spotify.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sprouts Farmers Market', 'https://www.sprouts.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SSENSE', 'https://www.ssense.com/en-us', 'pending', FALSE, ARRAY['online-first','luxury']::TEXT[], '$$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stance', 'https://stance.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stanley', 'https://stanley1913.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stanley Black & Decker', 'https://www.stanleyblackanddecker.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Starbucks', 'https://www.starbucks.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('State of Matter', 'https://stateofmatterapparel.com', 'pending', FALSE, ARRAY['small-brand']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Static Nails', 'https://staticnails.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Staub', 'https://zwilling.com/us/staub', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Steak ''n Shake', 'https://steaknshake.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Steam', 'https://store.steampowered.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('SteelSeries', 'https://steelseries.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stella & Chewy''s', 'https://stellaandchewys.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stella McCartney', 'https://stellamccartney.com', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Step2', 'https://step2.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Steve Madden', 'https://stevemadden.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stihl USA', 'https://stihlusa.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stila', 'https://stilacosmetics.com', 'pending', FALSE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stitch Fix', 'https://stitchfix.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('StockX', 'https://stockx.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stokke', 'https://stokke.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stone & Strand', 'https://stonefruit.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stone Island', 'https://stoneisland.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stop & Shop', 'https://stopandshop.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stouffer''s', 'https://www.goodnes.com/stouffers', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Strand Book Store', 'https://strandbooks.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Strathberry', 'https://us.strathberry.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stride Rite', 'https://striderite.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stuart Weitzman', 'https://stuartweitzman.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('StubHub', 'https://stubhub.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Studio McGee', 'https://studio-mcgee.com', 'pending', FALSE, ARRAY['women-owned','boutique']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stumptown Coffee', 'https://stumptowncoffee.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Stylein', 'https://stylein.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Substack', 'https://substack.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Subway', 'https://subway.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sugarwish', 'https://sugarwish.com', 'pending', FALSE, ARRAY['wedding-gifting']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sulwhasoo', 'https://us.sulwhasoo.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Summer Fridays', 'https://www.summerfridays.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Summersalt', 'https://summersalt.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sun Basket', 'https://sunbasket.com', 'active', TRUE, ARRAY['subscription','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sundance Catalog', 'https://sundancecatalog.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sunday Riley', 'https://sundayriley.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sundays', 'https://sundays-company.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sunglass Hut', 'https://sunglasshut.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sur La Table', 'https://surlatable.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Swatch', 'https://swatch.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sweaty Betty', 'https://sweatybetty.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sweetflexx', 'https://sweetflexx.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Sweetgreen', 'https://www.sweetgreen.com', 'pending', FALSE, ARRAY['b-corp']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('T.J. Maxx', 'https://tjmaxx.tjx.com', 'active', TRUE, ARRAY['outlet']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('T3', 'https://t3micro.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Taco Bell', 'https://www.tacobell.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('TAG Heuer', 'https://tagheuer.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Talbots', 'https://talbots.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Target', 'https://www.target.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tarte', 'https://tartecosmetics.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Taste of the Wild', 'https://tasteofthewildpetfood.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tata Harper', 'https://tataharperskincare.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tatcha', 'https://tatcha.com', 'pending', FALSE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Taylor King', 'https://www.taylorking.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tazo', 'https://tazo.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tea Collection', 'https://www.teacollection.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tecovas', 'https://www.tecovas.com', 'active', TRUE, ARRAY['luxury','heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Telfar', 'https://telfar.net', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tempur Sealy', 'https://www.tempurpedic.com', 'no_email', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tempur-Pedic', 'https://tempurpedic.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tender Greens', 'https://tendergreens.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Teva', 'https://teva.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Texas de Brazil', 'https://texasdebrazil.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Texas Roadhouse', 'https://www.texasroadhouse.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('TGI Fridays', 'https://tgifridays.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Atlantic', 'https://theatlantic.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Body Shop', 'https://us.thebodyshop.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Buckle', 'https://buckle.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Capital Grille', 'https://thecapitalgrille.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Cheesecake Factory', 'https://www.thecheesecakefactory.com', 'active', TRUE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Children''s Place', 'https://www.childrensplace.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Citizenry', 'https://the-citizenry.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Container Store', 'https://www.containerstore.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Emerald Holiday', 'https://theemeraldholiday.com', 'pending', FALSE, ARRAY['wedding-gifting','small-brand']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Farmer''s Dog', 'https://thefarmersdog.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Frankie Shop', 'https://thefrankieshop.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Fresh Market', 'https://www.thefreshmarket.com', 'active', TRUE, ARRAY[]::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Hershey Company', 'https://www.hersheyland.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Home Depot', 'https://www.homedepot.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Honest Company', 'https://www.honest.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The New York Times', 'https://nytimes.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The New Yorker', 'https://newyorker.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The North Face', 'https://thenorthface.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Ordinary', 'https://theordinary.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('THE OUTNET', 'https://www.theoutnet.com/en-us', 'active', TRUE, ARRAY['luxury','outlet']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The RealReal', 'https://www.therealreal.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Republic of Tea', 'https://republicoftea.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Row', 'https://www.therow.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Sill', 'https://thesill.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Skimm', 'https://theskimm.com', 'pending', FALSE, ARRAY['subscription','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Tea Spot', 'https://www.theteaspot.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('The Wall Street Journal', 'https://wsj.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Then I Met You', 'https://thenimetyou.com', 'pending', FALSE, ARRAY['wedding-gifting']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Theo Sweet Treats', 'https://theochocolate.com', 'pending', FALSE, ARRAY['wedding-gifting']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Theory', 'https://www.theory.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Therabody', 'https://www.therabody.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ThirdLove', 'https://thirdlove.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ThredUp', 'https://thredup.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ThriftBooks', 'https://thriftbooks.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Thrive Market', 'https://thrivemarket.com', 'pending', FALSE, ARRAY['subscription','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Thursday Boot Company', 'https://thursdayshoes.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tibi', 'https://www.tibi.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ticketmaster', 'https://ticketmaster.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tidal', 'https://tidal.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tiffany & Co.', 'https://tiffany.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tijn Eyewear', 'https://tijneyewear.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tillamook', 'https://tillamook.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tillys', 'https://tillys.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tim Hortons', 'https://timhortons.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Timex', 'https://timex.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tissot', 'https://tissotwatches.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Title Nine', 'https://titlenine.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Toad&Co', 'https://www.toadandco.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Toast', 'https://us.toa.st', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tock', 'https://exploretock.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tod''s', 'https://tods.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tom Ford', 'https://tomford.com/beauty', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tommy Hilfiger', 'https://usa.tommy.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tommy John', 'https://tommyjohn.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('TOMS', 'https://toms.com', 'active', TRUE, ARRAY['sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tonies', 'https://tonies.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tony Bianco', 'https://tonybianco.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tony''s Chocolonely', 'https://us.tonyschocolonely.com', 'pending', FALSE, ARRAY['b-corp','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Too Faced', 'https://toofaced.com', 'active', TRUE, ARRAY['luxury','cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tool Source', 'https://toolsource.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('ToolNut', 'https://www.toolnut.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Topicals', 'https://mytopicals.com', 'active', TRUE, ARRAY['black-owned','women-owned','cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Topo Athletic', 'https://topoathletic.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Topo Chico', 'https://topochico.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Toro', 'https://toro.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Torrid', 'https://torrid.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tory Burch', 'https://toryburch.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tory Burch Shoes', 'https://toryburch.com/shoes', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Toteme', 'https://toteme.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tovala', 'https://tovala.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tower 28 Beauty', 'https://tower28beauty.com', 'pending', FALSE, ARRAY['women-owned','cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('TP-Link', 'https://tp-link.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tracksmith', 'https://tracksmith.com', 'pending', FALSE, ARRAY['luxury','sustainable']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tractor Supply', 'https://www.tractorsupply.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-24'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Trade Coffee', 'https://drinktrade.com', 'pending', FALSE, ARRAY['women-owned','subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Trader Joe’s', 'https://www.traderjoes.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tradlands', 'https://tradlands.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Travelpro', 'https://travelpro.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Trello', 'https://trello.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Trinny London', 'https://trinnylondon.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tropical Smoothie Cafe', 'https://tropicalsmoothiecafe.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('True & Co.', 'https://trueandco.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('True Food Kitchen', 'https://truefoodkitchen.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('True Religion', 'https://truereligion.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('True Value', 'https://truevalue.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Truly Free', 'https://trulyfreehome.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Trunk Club', 'https://trunkclub.com', 'pending', FALSE, ARRAY['rental']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tuckernuck', 'https://www.tnuck.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tudor', 'https://tudorwatch.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tuft & Needle', 'https://tuftandneedle.com', 'pending', FALSE, ARRAY['women-owned','direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tuft + Paw', 'https://tuftandpaw.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Tumi', 'https://www.tumi.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Turo', 'https://turo.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Turtle Beach', 'https://turtlebeach.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Twinings', 'https://twiningsusa.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Two Days Off', 'https://twodaysoff.com', 'pending', FALSE, ARRAY['wedding-gifting']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('TWP', 'https://twp.com', 'no_email', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('TYR', 'https://tyr.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Uber', 'https://uber.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Uber Eats', 'https://ubereats.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ulla Johnson', 'https://ullajohnson.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Ulta Beauty', 'https://www.ulta.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Umbro', 'https://umbro.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Under Armour', 'https://underarmour.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Unilever', 'https://www.unileverusa.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Uniqlo', 'https://www.uniqlo.com/us/en', 'active', TRUE, ARRAY['minimalist']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('United Airlines', 'https://united.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Universal Orlando', 'https://universalorlando.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Universal Standard', 'https://www.universalstandard.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Universal Yums', 'https://universalyums.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Untuckit', 'https://untuckit.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Uppababy', 'https://uppababy.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Urban Decay', 'https://urbandecay.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Urban Outfitters', 'https://www.urbanoutfitters.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Urban Outfitters Home', 'https://urbanoutfitters.com/home', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Valentino', 'https://valentino.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Van Cleef & Arpels', 'https://vancleefarpels.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vans', 'https://www.vans.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vasque', 'https://vasque.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vegamour', 'https://vegamour.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Veja', 'https://veja-store.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vera Wang', 'https://verawang.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Verb', 'https://verbproducts.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Verellen', 'https://verellen.biz', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Verishop', 'https://verishop.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Veronica Beard', 'https://veronicabeard.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Versace', 'https://versace.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Versed', 'https://versedskin.com', 'pending', FALSE, ARRAY['cruelty-free']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Verve Coffee', 'https://vervecoffee.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vestiaire Collective', 'https://www.vestiairecollective.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vetta', 'https://vettacapsule.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('VF Corporation', 'https://www.vfc.com', 'no_email', FALSE, ARRAY['heritage']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vichy', 'https://vichyusa.com', 'active', TRUE, ARRAY['cruelty-free']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Victoria''s Secret', 'https://victoriassecret.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vince', 'https://www.vince.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vince Camuto', 'https://vincecamuto.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vineyard Vines', 'https://vineyardvines.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vinted', 'https://vinted.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vintner''s Daughter', 'https://vintnersdaughter.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Violette_FR', 'https://www.violettefr.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vionic', 'https://vionicshoes.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vital Choice', 'https://vitalchoice.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vital Proteins', 'https://vitalproteins.com', 'pending', FALSE, ARRAY['b-corp','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vitamin A', 'https://vitaminaswim.com', 'active', TRUE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vitamix', 'https://vitamix.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vivaia', 'https://www.vivaia.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vivid Seats', 'https://vividseats.com', 'pending', FALSE, ARRAY['resale']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vivint', 'https://vivint.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vix', 'https://vixswimwear.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Volcom', 'https://volcom.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Von Maur', 'https://vonmaur.com', 'active', TRUE, ARRAY['department-store']::TEXT[], '$$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vons', 'https://vons.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Voodoo Doughnut', 'https://voodoodoughnut.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vosges Haut-Chocolat', 'https://vosgeschocolate.com', 'pending', FALSE, ARRAY['wedding-gifting']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vrai', 'https://vrai.com', 'active', TRUE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vrbo', 'https://vrbo.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Vuori', 'https://www.vuoriclothing.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$$', ARRAY['teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wacoal', 'https://wacoal-america.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Waffle House', 'https://wafflehouse.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wagamama', 'https://wagamama.us', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Walgreens', 'https://www.walgreens.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Walmart', 'https://www.walmart.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Walt Disney World', 'https://disneyworld.disney.go.com', 'pending', FALSE, ARRAY['entertainment']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wantable', 'https://wantable.com', 'active', TRUE, ARRAY['subscription']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Warby Parker', 'https://www.warbyparker.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wardrobe.NYC', 'https://wardrobe.nyc', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['kids','teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Washington Post', 'https://washingtonpost.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wayfair', 'https://www.wayfair.com', 'active', TRUE, ARRAY['online-first']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Weekend Max Mara', 'https://us.weekendmaxmara.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Weezie', 'https://weezietowels.com', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wegmans', 'https://wegmans.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wella Professionals', 'https://www.wella.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wellness Pets', 'https://wellnesspetfood.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wendy''s', 'https://www.wendys.com', 'active', TRUE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('West Elm', 'https://www.westelm.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Western Digital', 'https://westerndigital.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Westman Atelier', 'https://www.westman-atelier.com', 'pending', FALSE, ARRAY['luxury','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wet Seal', 'https://wetseal.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('What Goes Around Comes Around', 'https://whatgoesaroundnyc.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Whataburger', 'https://www.whataburger.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Whirlpool', 'https://www.whirlpool.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('White + Warren', 'https://www.whiteandwarren.com', 'active', TRUE, ARRAY['luxury','women-owned']::TEXT[], '$$$$', ARRAY['kids','teens','20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('White Castle', 'https://whitecastle.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('White House Black Market', 'https://whitehouseblackmarket.com', 'pending', FALSE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Whole Foods', 'https://www.wholefoodsmarket.com', 'active', TRUE, ARRAY['big-box']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Whoop', 'https://whoop.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wienerschnitzel', 'https://wienerschnitzel.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wild Earth', 'https://wildearth.com', 'pending', FALSE, ARRAY['sustainable','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wild One', 'https://wildone.com', 'pending', FALSE, ARRAY['women-owned','sustainable']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Williams-Sonoma', 'https://www.williams-sonoma.com', 'pending', FALSE, ARRAY['boutique']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('WinCo Foods', 'https://www.wincofoods.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Windsor', 'https://windsorstore.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wing Zone', 'https://wingzone.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wingstop', 'https://wingstop.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Winn-Dixie', 'https://winndixie.com', 'pending', FALSE, ARRAY['big-box']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wolf & Badger', 'https://www.wolfandbadger.com/us', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$$$', ARRAY['20s','30s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wolverine', 'https://wolverine.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Woman Within', 'https://womanwithin.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Woolly Clothing Co', 'https://www.woolly.clothing', 'pending', FALSE, ARRAY['sustainable']::TEXT[], '$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('World Market', 'https://www.worldmarket.com', 'active', TRUE, ARRAY['boutique']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Worx', 'https://worx.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wrangler', 'https://wrangler.com', 'active', TRUE, ARRAY['heritage']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s','50plus']::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wyndham', 'https://wyndhamhotels.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Wyze', 'https://wyze.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Xbox', 'https://xbox.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('XGIMI', 'https://us.xgimi.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yamazaki Home', 'https://yamazakihome.com', 'pending', FALSE, ARRAY['minimalist']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yard House', 'https://yardhouse.com', 'pending', FALSE, ARRAY[]::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Year of Ours', 'https://yearofours.com', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yellow Label Co', 'https://yelabel.co', 'pending', FALSE, ARRAY['women-owned']::TEXT[], '$$$', ARRAY['20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yelp', 'https://yelp.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yesglasses', 'https://www.yesglasses.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yesstyle', 'https://yesstyle.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yeti', 'https://yeti.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yogi Tea', 'https://yogiproducts.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('YOOX', 'https://yoox.com', 'active', TRUE, ARRAY['resale']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yoshinoya', 'https://yoshinoyaamerica.com', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Yoto', 'https://us.yotoplay.com', 'pending', FALSE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Youth To The People', 'https://www.youthtothepeople.com', 'pending', FALSE, ARRAY['cruelty-free','women-owned']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('YouTube TV', 'https://tv.youtube.com', 'pending', FALSE, ARRAY['subscription']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('YSL Beauty', 'https://yslbeautyus.com', 'active', TRUE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zac Posen', 'https://zacposen.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zaful', 'https://zaful.com', 'pending', FALSE, ARRAY['online-first']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zales', 'https://zales.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zappos', 'https://www.zappos.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-30'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zara', 'https://www.zara.com/us', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY['kids','teens','20s','30s','40s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zara Home', 'https://www.zarahome.com/us', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zenni Optical', 'https://www.zennioptical.com', 'active', TRUE, ARRAY['direct-to-consumer']::TEXT[], '$', ARRAY[]::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zimmermann', 'https://www.zimmermann.com', 'pending', FALSE, ARRAY['luxury']::TEXT[], '$$$$', ARRAY['teens','20s']::TEXT[], '2026-04-21'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zingerman''s', 'https://zingermans.com', 'pending', FALSE, ARRAY['heritage']::TEXT[], '$$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zoom', 'https://zoom.us', 'pending', FALSE, ARRAY[]::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();
INSERT INTO stores (name, website, status, is_active, categories, price_tier, age_group, date_added)
VALUES ('Zumiez', 'https://zumiez.com', 'active', TRUE, ARRAY['mall-stores']::TEXT[], '$', ARRAY[]::TEXT[], '2026-05-11'::DATE)
ON CONFLICT (LOWER(website)) DO UPDATE SET
  name=EXCLUDED.name,
  status=EXCLUDED.status,
  is_active=EXCLUDED.is_active,
  categories=EXCLUDED.categories,
  price_tier=EXCLUDED.price_tier,
  age_group=EXCLUDED.age_group,
  date_added=EXCLUDED.date_added,
  updated_at=NOW();

-- Sanity log:
-- unmapped vibes: ['Holiday & Seasonal']
-- unmapped age tags: []
