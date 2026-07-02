import { describe, expect, it } from 'vitest'
import {
  brandNamesIncludingAliases,
  relatedBrandNamesForTarget,
  relatedStoreIdsForTarget,
} from '@/lib/brandRelationships'

const relationships = [
  {
    store_a_id: 'pink',
    store_b_id: 'vs',
    decision: 'parent_child' as const,
    parent_store_id: 'vs',
    child_store_id: 'pink',
  },
  {
    store_a_id: 'jcrew',
    store_b_id: 'j-crew',
    decision: 'equivalent' as const,
    parent_store_id: null,
    child_store_id: null,
  },
]

describe('brand relationship matching', () => {
  it('includes children when the parent is targeted', () => {
    expect([...relatedStoreIdsForTarget('vs', relationships)]).toEqual(['vs', 'pink'])
  })

  it('does not expand a child search back to its parent', () => {
    expect([...relatedStoreIdsForTarget('pink', relationships)]).toEqual(['pink'])
  })

  it('matches equivalent brands in both directions', () => {
    expect(relatedBrandNamesForTarget('jcrew', [
      { id: 'jcrew', name: 'J.Crew' },
      { id: 'j-crew', name: 'J Crew' },
    ], relationships)).toEqual(['J.Crew', 'J Crew'])
  })

  it('expands curated alternate retailer names in both directions', () => {
    expect(brandNamesIncludingAliases(['Altra'])).toEqual(['Altra', 'Altra Running'])
    expect(brandNamesIncludingAliases(['Altra Running'])).toEqual(['Altra Running', 'Altra'])
  })

  it('includes alternate extracted names when resolving a store target', () => {
    expect(relatedBrandNamesForTarget('altra', [
      { id: 'altra', name: 'Altra' },
    ], [])).toEqual(['Altra', 'Altra Running'])
  })
})
