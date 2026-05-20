-- Three additional categories under the Food & Drink parent group.
-- ON CONFLICT DO NOTHING so re-running the migration is safe.

INSERT INTO categories (slug, label, sort_order, group_name) VALUES
  ('chocolate',        'Chocolate',          62, 'Food & Drink'),
  ('food-and-grocery', 'Food & Grocery',     63, 'Food & Drink'),
  ('meal-delivery',    'Meal Delivery',      64, 'Food & Drink')
ON CONFLICT (slug) DO NOTHING;
