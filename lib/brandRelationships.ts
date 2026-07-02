export type BrandRelationshipDecision = 'unrelated' | 'parent_child' | 'equivalent'

export type BrandRelationshipRow = {
  store_a_id: string
  store_b_id: string
  decision: BrandRelationshipDecision
  parent_store_id: string | null
  child_store_id: string | null
}

export type RelationshipStore = {
  id: string
  name: string
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
  relationships: BrandRelationshipRow[],
): Set<string> {
  const ids = new Set([targetStoreId])
  for (const relationship of relationships) {
    if (relationship.decision === 'equivalent') {
      if (relationship.store_a_id === targetStoreId) ids.add(relationship.store_b_id)
      if (relationship.store_b_id === targetStoreId) ids.add(relationship.store_a_id)
    }
    if (
      relationship.decision === 'parent_child' &&
      relationship.parent_store_id === targetStoreId &&
      relationship.child_store_id
    ) {
      ids.add(relationship.child_store_id)
    }
  }
  return ids
}

export function relatedBrandNamesForTarget(
  targetStoreId: string,
  stores: RelationshipStore[],
  relationships: BrandRelationshipRow[],
): string[] {
  const ids = relatedStoreIdsForTarget(targetStoreId, relationships)
  return brandNamesIncludingAliases(
    stores.filter((store) => ids.has(store.id)).map((store) => store.name),
  )
}
