import { describe, expect, it } from 'vitest'
import {
  curateItemSuggestions,
  expandItemSearchTerms,
} from '@/lib/itemCuration'

const reviews = [
  { keyword: 'foods', canonical_keyword: 'food', is_hidden: false },
  { keyword: 'food discounts', canonical_keyword: 'food', is_hidden: false },
  { keyword: 'food tasting', canonical_keyword: 'food', is_hidden: false },
  { keyword: 'promotional fluff', canonical_keyword: null, is_hidden: true },
  { keyword: 'eye shadow', canonical_keyword: null, parent_keyword: 'makeup', is_hidden: false },
  { keyword: 'eyeshadow', canonical_keyword: 'eye shadow', parent_keyword: 'makeup', is_hidden: false },
  { keyword: 'skin care', canonical_keyword: 'skincare', is_hidden: false },
]

describe('item curation', () => {
  it('collapses aliases into one autocomplete choice', () => {
    expect(curateItemSuggestions([
      { keyword: 'food', deal_count: 4, type: 'keyword' },
      { keyword: 'foods', deal_count: 2, type: 'keyword' },
      { keyword: 'food discounts', deal_count: 3, type: 'keyword' },
      { keyword: 'food tasting', deal_count: 1, type: 'keyword' },
    ], reviews)).toEqual([
      { keyword: 'food', deal_count: 10, type: 'keyword' },
    ])
  })

  it('hides reviewed noise from autocomplete', () => {
    expect(curateItemSuggestions([
      { keyword: 'promotional fluff', deal_count: 5, type: 'keyword' },
    ], reviews)).toEqual([])
  })

  it('expands a canonical search to every merged alias', () => {
    expect(expandItemSearchTerms(['food'], reviews)).toEqual([
      'food',
      'foods',
      'food discounts',
      'food tasting',
    ])
  })

  it('redirects an alias search through the canonical group', () => {
    expect(expandItemSearchTerms(['foods'], reviews)).toEqual([
      'foods',
      'food',
      'food discounts',
      'food tasting',
    ])
  })

  it('keeps a specific item while including it under a broader item', () => {
    expect(curateItemSuggestions([
      { keyword: 'eye shadow', deal_count: 2, type: 'keyword' },
      { keyword: 'makeup', deal_count: 5, type: 'keyword' },
    ], reviews)).toEqual([
      { keyword: 'eye shadow', deal_count: 2, type: 'keyword' },
      { keyword: 'makeup', deal_count: 5, type: 'keyword' },
    ])
    expect(expandItemSearchTerms(['makeup'], reviews)).toEqual([
      'makeup',
      'eye shadow',
      'eyeshadow',
    ])
  })

  it('merges skin care spelling variants into skincare', () => {
    expect(curateItemSuggestions([
      { keyword: 'skin care', deal_count: 2, type: 'keyword' },
      { keyword: 'skincare', deal_count: 3, type: 'keyword' },
    ], reviews)).toEqual([
      { keyword: 'skincare', deal_count: 5, type: 'keyword' },
    ])
  })
})
