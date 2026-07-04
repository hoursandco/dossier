// Brand family relationships, stored as columns on stores (migration 054):
//
//   parent_store_id      directional family — watching/searching the parent
//                        includes the child; the child stays specific.
//   alias_of_store_id    same brand under another name — matches expand in
//                        both directions. The pointed-at row is canonical.
//   unrelated_store_ids  alias-audit dismissals, held on the
//                        lexicographically-smaller store id of the pair.

export type BrandRelationshipDecision = 'unrelated' | 'parent_child' | 'equivalent'

export type RelationshipStore = {
  id: string
  name: string
  parent_store_id?: string | null
  alias_of_store_id?: string | null
}

// Alternate names the ingest model may extract for a single store record.
// These are equivalent in both directions and do not require duplicate rows
// in stores merely to represent a trading name or expanded brand name.
const CURATED_BRAND_ALIAS_GROUPS = [
  ['Altra', 'Altra Running'],
] as const

function normalizeBrandName(value: string): string {
  return value.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export function brandNamesIncludingAliases(names: Iterable<string>): string[] {
  const expanded = new Set(names)
  const normalizedTargets = new Set([...expanded].map(normalizeBrandName))

  for (const group of CURATED_BRAND_ALIAS_GROUPS) {
    if (!group.some((name) => normalizedTargets.has(normalizeBrandName(name)))) continue
    for (const name of group) expanded.add(name)
  }

  return [...expanded]
}

export function orderedStorePair(leftId: string, rightId: string): [string, string] {
  return leftId.localeCompare(rightId) <= 0 ? [leftId, rightId] : [rightId, leftId]
}

/** Store IDs whose deals should match a search/watch for targetStoreId. */
export function relatedStoreIdsForTarget(
  targetStoreId: string,
  stores: RelationshipStore[],
): Set<string> {
  const ids = new Set([targetStoreId])
  for (const store of stores) {
    if (store.id === targetStoreId && store.alias_of_store_id) {
      ids.add(store.alias_of_store_id)
    }
    if (store.alias_of_store_id === targetStoreId) ids.add(store.id)
    if (store.parent_store_id === targetStoreId) ids.add(store.id)
  }
  return ids
}

export function relatedBrandNamesForTarget(
  targetStoreId: string,
  stores: RelationshipStore[],
): string[] {
  const ids = relatedStoreIdsForTarget(targetStoreId, stores)
  return brandNamesIncludingAliases(
    stores.filter((store) => ids.has(store.id)).map((store) => store.name),
  )
}
