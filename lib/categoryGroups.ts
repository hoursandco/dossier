// Canonical display order for the category groups. The categories table's
// `group_name` column (migration 015) is the source of truth for which
// group a slug belongs to; this array just controls THE ORDER groups
// render in the picker.
//
// "Collections" is kept here for any admin/internal callers that request
// editorial category rows. The public picker filters those rows out at
// /api/categories so shoppers only see the content taxonomy.

export const CATEGORY_GROUP_ORDER = [
  'Collections',
  'Adventure & Entertainment',
  'Clothing & Accessories',
  'Health & Wellness',
  'Home',
  'Restaurants & Grocery',
  'Tech',
  'Other',
] as const

export const CATEGORY_GROUP_FALLBACK = 'Other'

export interface CategoryWithGroup {
  slug: string
  label: string
  group_name?: string | null
}

/**
 * Group a flat list of categories into ordered sections.
 *
 * Resolution order for each category's group:
 *   1. DB `group_name` if present (admin override)
 *   2. CATEGORY_GROUP_FALLBACK ('Other')
 *
 * Output preserves CATEGORY_GROUP_ORDER for the sections. Within each
 * section the input order is preserved (typically DB sort_order, which
 * is alphabetical by label). Empty groups are omitted.
 */
export function groupCategories<T extends CategoryWithGroup>(
  categories: T[]
): Array<{ name: string; items: T[] }> {
  const byGroup = new Map<string, T[]>()
  for (const c of categories) {
    const name = c.group_name || CATEGORY_GROUP_FALLBACK
    const bucket = byGroup.get(name) ?? []
    bucket.push(c)
    byGroup.set(name, bucket)
  }

  const ordered: Array<{ name: string; items: T[] }> = []
  for (const name of CATEGORY_GROUP_ORDER) {
    const items = byGroup.get(name)
    if (items && items.length > 0) {
      ordered.push({ name, items })
      byGroup.delete(name)
    }
  }
  // Any unexpected group names (e.g. admin added a new group without
  // updating CATEGORY_GROUP_ORDER) — append at the end alphabetically
  // so they're visible rather than silently dropped.
  for (const name of Array.from(byGroup.keys()).sort()) {
    ordered.push({ name, items: byGroup.get(name)! })
  }
  return ordered
}
