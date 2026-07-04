import { describe, expect, it } from 'vitest'
import {
  brandNamesIncludingAliases,
  relatedBrandNamesForTarget,
  relatedStoreIdsForTarget,
} from '@/lib/brandRelationships'

// Relationship columns live on the store rows themselves (migration 054).
const stores = [
  { id: 'vs', name: "Victoria's Secret", parent_store_id: null, alias_of_store_id: null },
  { id: 'pink', name: 'PINK', parent_store_id: 'vs', alias_of_store_id: null },
  { id: 'jcrew', name: 'J.Crew', parent_store_id: null, alias_of_store_id: null },
  { id: 'j-crew', name: 'J Crew', parent_store_id: null, alias_of_store_id: 'jcrew' },
]

describe('brand relationship matching', () => {
  it('includes children when the parent is targeted', () => {
    expect([...relatedStoreIdsForTarget('vs', stores)]).toEqual(['vs', 'pink'])
  })

  it('does not expand a child search back to its parent', () => {
    expect([...relatedStoreIdsForTarget('pink', stores)]).toEqual(['pink'])
  })

  it('matches alias brands in both directions', () => {
    expect(relatedBrandNamesForTarget('jcrew', stores).sort()).toEqual(['J Crew', 'J.Crew'])
    expect(relatedBrandNamesForTarget('j-crew', stores).sort()).toEqual(['J Crew', 'J.Crew'])
  })

  it('expands curated alternate retailer names in both directions', () => {
    expect(brandNamesIncludingAliases(['Altra'])).toEqual(['Altra', 'Altra Running'])
    expect(brandNamesIncludingAliases(['Altra Running'])).toEqual(['Altra Running', 'Altra'])
  })

  it('includes alternate extracted names when resolving a store target', () => {
    expect(relatedBrandNamesForTarget('altra', [
      { id: 'altra', name: 'Altra' },
    ])).toEqual(['Altra', 'Altra Running'])
  })
})
