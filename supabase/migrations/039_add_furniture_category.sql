-- Add requested Home picker category.
INSERT INTO categories (slug, label, group_name, sort_order, is_active, is_editorial)
VALUES ('furniture', 'Furniture', 'Home', 417, TRUE, FALSE)
ON CONFLICT (slug) DO UPDATE
  SET label=EXCLUDED.label,
      group_name=EXCLUDED.group_name,
      sort_order=EXCLUDED.sort_order,
      is_active=EXCLUDED.is_active,
      is_editorial=EXCLUDED.is_editorial;
