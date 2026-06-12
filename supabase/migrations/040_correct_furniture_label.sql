-- Correct display label while preserving the existing slug used by watches/deals.
UPDATE categories
SET label = 'Furniture'
WHERE slug = 'furnature';
