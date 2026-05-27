-- Content categories rebuild. Replaces the heterogeneous mix of
-- slugs accumulated across migrations 010/015/020 etc with a clean
-- 6-group taxonomy. Editorial vibes (24 slugs from migration 035)
-- are left alone — this migration only touches non-editorial rows.
--
-- WARNING — DESTRUCTIVE: any existing subscriber_watches and
-- retailer_categories rows referencing slugs not in the new list
-- will cascade-delete (FK ON DELETE CASCADE). User confirmed they
-- have no active-subscriber watches to protect.
--
-- Strategy:
--   1) UPSERT all 74 new content categories (group_name + sort_order
--      + is_editorial=false). Overlapping slugs are updated in place;
--      brand-new ones are inserted.
--   2) DELETE every category row that's neither in the new content
--      list nor flagged editorial (the 24 Collections vibes).

-- ── 1. UPSERT new content categories ──────────────────────────────
-- Sort blocks: each group gets a 100-range so future inserts within
-- a group can slot in alphabetically without renumbering.

-- Adventure & Entertainment (100-199, alpha)
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial) VALUES
  ('airlines',           'Airlines & Flights',  'Adventure & Entertainment', 100, TRUE, FALSE),
  ('books',              'Books',               'Adventure & Entertainment', 105, TRUE, FALSE),
  ('event-tickets',      'Event Tickets',       'Adventure & Entertainment', 110, TRUE, FALSE),
  ('hotels-lodging',     'Hotels & Lodging',    'Adventure & Entertainment', 115, TRUE, FALSE),
  ('movie-theaters',     'Movie Theaters',      'Adventure & Entertainment', 120, TRUE, FALSE),
  ('news-media',         'News & Media',        'Adventure & Entertainment', 125, TRUE, FALSE),
  ('rental-cars',        'Rental Cars',         'Adventure & Entertainment', 130, TRUE, FALSE),
  ('rideshare-delivery', 'Rideshare & Delivery','Adventure & Entertainment', 135, TRUE, FALSE),
  ('sporting-gear',      'Sporting Gear',       'Adventure & Entertainment', 140, TRUE, FALSE),
  ('theme-parks',        'Theme Parks',         'Adventure & Entertainment', 145, TRUE, FALSE),
  ('toys-games',         'Toys & Games',        'Adventure & Entertainment', 150, TRUE, FALSE),
  ('travel-booking',     'Travel Booking',      'Adventure & Entertainment', 155, TRUE, FALSE),
  ('travel-gear',        'Travel Gear',         'Adventure & Entertainment', 160, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label, group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order, is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;

-- Clothing & Accessories (200-299, alpha)
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial) VALUES
  ('activewear',            'Activewear',             'Clothing & Accessories', 200, TRUE, FALSE),
  ('athleisure',            'Athleisure',             'Clothing & Accessories', 205, TRUE, FALSE),
  ('baby-clothing',         'Baby Clothing',          'Clothing & Accessories', 210, TRUE, FALSE),
  ('bags',                  'Bags',                   'Clothing & Accessories', 215, TRUE, FALSE),
  ('eyeglasses-sunglasses', 'Eyeglasses & Sunglasses','Clothing & Accessories', 220, TRUE, FALSE),
  ('jewelry',               'Jewelry',                'Clothing & Accessories', 225, TRUE, FALSE),
  ('kids-clothes',          'Kids Clothes',           'Clothing & Accessories', 230, TRUE, FALSE),
  ('maternity',             'Maternity',              'Clothing & Accessories', 235, TRUE, FALSE),
  ('mens-bottoms',          'Mens Bottoms',           'Clothing & Accessories', 240, TRUE, FALSE),
  ('mens-tops',             'Mens Tops',              'Clothing & Accessories', 245, TRUE, FALSE),
  ('officewear',            'Officewear',             'Clothing & Accessories', 250, TRUE, FALSE),
  ('outdoor-apparel',       'Outdoor Apparel',        'Clothing & Accessories', 255, TRUE, FALSE),
  ('outerwear-coats',       'Outerwear & Coats',      'Clothing & Accessories', 260, TRUE, FALSE),
  ('pajamas-sleepwear',     'Pajamas & Sleepwear',    'Clothing & Accessories', 265, TRUE, FALSE),
  ('plus-size',             'Plus Size',              'Clothing & Accessories', 270, TRUE, FALSE),
  ('shoes',                 'Shoes',                  'Clothing & Accessories', 275, TRUE, FALSE),
  ('swimwear',              'Swimwear',               'Clothing & Accessories', 280, TRUE, FALSE),
  ('underwear-intimates',   'Underwear & Intimates',  'Clothing & Accessories', 285, TRUE, FALSE),
  ('womens-bottoms',        'Womens Bottoms',         'Clothing & Accessories', 290, TRUE, FALSE),
  ('womens-tops',           'Womens Tops',            'Clothing & Accessories', 295, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label, group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order, is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;

-- Health & Wellness (300-399, alpha)
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial) VALUES
  ('fitness-equipment',    'Fitness Equipment',     'Health & Wellness', 300, TRUE, FALSE),
  ('fragrance',            'Fragrance & Perfume',   'Health & Wellness', 305, TRUE, FALSE),
  ('hair-care',            'Hair Care',             'Health & Wellness', 310, TRUE, FALSE),
  ('k-beauty',             'K-Beauty',              'Health & Wellness', 315, TRUE, FALSE),
  ('makeup',               'Makeup',                'Health & Wellness', 320, TRUE, FALSE),
  ('skincare',             'Skincare',              'Health & Wellness', 325, TRUE, FALSE),
  ('vitamins-supplements', 'Vitamins & Supplements','Health & Wellness', 330, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label, group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order, is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;

-- Home (400-499, alpha — "Baby Gear" lives here, covers strollers,
-- car seats, monitors, bottles, diapers, cribs, etc.)
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial) VALUES
  ('baby-gear',         'Baby Gear',          'Home', 400, TRUE, FALSE),
  ('bed-bath',          'Bed & Bath',         'Home', 405, TRUE, FALSE),
  ('bedding',           'Bedding',            'Home', 410, TRUE, FALSE),
  ('cleaning',          'Cleaning',           'Home', 415, TRUE, FALSE),
  ('holiday',           'Holiday',            'Home', 418, TRUE, FALSE),
  ('home-decor',        'Home Decor',         'Home', 420, TRUE, FALSE),
  ('kitchen-cooking',   'Kitchen & Cooking',  'Home', 425, TRUE, FALSE),
  ('kitchen-appliances','Kitchen Appliances', 'Home', 430, TRUE, FALSE),
  ('lighting',          'Lighting',           'Home', 435, TRUE, FALSE),
  ('mattress',          'Mattress',           'Home', 440, TRUE, FALSE),
  ('office',            'Office',             'Home', 445, TRUE, FALSE),
  ('organization',      'Organization',       'Home', 450, TRUE, FALSE),
  ('outdoor-furniture', 'Outdoor Furniture',  'Home', 455, TRUE, FALSE),
  ('plants',            'Plants',             'Home', 460, TRUE, FALSE),
  ('rugs',              'Rugs',               'Home', 465, TRUE, FALSE),
  ('wall-art',          'Wall Art & Frames',  'Home', 470, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label, group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order, is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;

-- Restaurants & Grocery (500-599, alpha)
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial) VALUES
  ('baby-food',     'Baby Food',           'Restaurants & Grocery', 500, TRUE, FALSE),
  ('candy',         'Candy',               'Restaurants & Grocery', 505, TRUE, FALSE),
  ('coffee-tea',    'Coffee & Tea',        'Restaurants & Grocery', 510, TRUE, FALSE),
  ('fast-food',     'Fast Food',           'Restaurants & Grocery', 515, TRUE, FALSE),
  ('grocery',       'Grocery & Pantry',    'Restaurants & Grocery', 520, TRUE, FALSE),
  ('meal-kits',     'Meal Delivery & Kits','Restaurants & Grocery', 525, TRUE, FALSE),
  ('pets',          'Pets',                'Restaurants & Grocery', 530, TRUE, FALSE),
  ('restaurants',   'Restaurants',         'Restaurants & Grocery', 535, TRUE, FALSE),
  ('wine-alcohol',  'Wine & Alcohol',      'Restaurants & Grocery', 540, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label, group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order, is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;

-- Tech (600-699, alpha — "Hardware & Tools" dropped per request)
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial) VALUES
  ('audio-instruments', 'Audio & Instruments',         'Tech', 600, TRUE, FALSE),
  ('computer-hardware', 'Computer Hardware',           'Tech', 605, TRUE, FALSE),
  ('home-security',     'Home Security & Automation',  'Tech', 610, TRUE, FALSE),
  ('photography',       'Photography',                 'Tech', 615, TRUE, FALSE),
  ('software-saas',     'Software & SaaS',             'Tech', 620, TRUE, FALSE),
  ('streaming',         'Streaming Services',          'Tech', 625, TRUE, FALSE),
  ('tech-electronics',  'Tech & Electronics',          'Tech', 630, TRUE, FALSE),
  ('tools',             'Tools',                       'Tech', 635, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label, group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order, is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;

-- ── 2. DELETE legacy non-editorial categories ─────────────────────
-- Everything that's neither in the 74 new content slugs above nor
-- flagged is_editorial (the 24 Collections vibes from migration 035)
-- gets cascade-deleted. Watches + retailer_categories rows pointing
-- at those slugs disappear with them.

DELETE FROM categories
WHERE is_editorial = FALSE
  AND slug NOT IN (
    -- Adventure & Entertainment
    'airlines','books','event-tickets','hotels-lodging','movie-theaters',
    'news-media','rental-cars','rideshare-delivery','sporting-gear',
    'theme-parks','toys-games','travel-booking','travel-gear',
    -- Clothing & Accessories
    'activewear','athleisure','baby-clothing','bags','eyeglasses-sunglasses',
    'jewelry','kids-clothes','maternity','mens-bottoms','mens-tops',
    'officewear','outdoor-apparel','outerwear-coats','pajamas-sleepwear',
    'plus-size','shoes','swimwear','underwear-intimates','womens-bottoms',
    'womens-tops',
    -- Health & Wellness
    'fitness-equipment','fragrance','hair-care','k-beauty','makeup',
    'skincare','vitamins-supplements',
    -- Home
    'baby-gear','bed-bath','bedding','cleaning','holiday','home-decor',
    'kitchen-cooking','kitchen-appliances','lighting','mattress','office',
    'organization','outdoor-furniture','plants','rugs','wall-art',
    -- Restaurants & Grocery
    'baby-food','candy','coffee-tea','fast-food','grocery','meal-kits',
    'pets','restaurants','wine-alcohol',
    -- Tech
    'audio-instruments','computer-hardware','home-security','photography',
    'software-saas','streaming','tech-electronics','tools'
  );
