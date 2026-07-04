import type { SupabaseClient } from '@supabase/supabase-js'

// stores.categories must only hold canonical slugs from the categories
// table (editorial Collections and content taxonomy alike). Unknown slugs
// are dropped rather than rejected so a stale client can't block a save.
export async function filterToCanonicalCategorySlugs(
  service: SupabaseClient,
  slugs: string[],
): Promise<string[]> {
  const cleaned = Array.from(new Set(slugs.map((s) => s.trim()).filter(Boolean)))
  if (cleaned.length === 0) return []
  const { data, error } = await service
    .from('categories')
    .select('slug')
    .in('slug', cleaned)
  if (error) {
    console.error('[storeCategories] category validation error:', JSON.stringify(error))
    // Fail open — better to save the store with unvalidated tags than to
    // lose the admin's edit because the lookup hiccuped.
    return cleaned
  }
  const valid = new Set((data ?? []).map((row) => row.slug))
  return cleaned.filter((slug) => valid.has(slug))
}
