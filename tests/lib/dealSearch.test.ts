import { describe, expect, it } from 'vitest'
import { dealMatchesAnySearchTerm, dealMatchesSearchTerm } from '@/lib/dealSearch'

const deal = {
  retailer: 'Bath & Body Works',
  description: 'Save 40% on select body care, hand soaps, and scented candles.',
  deal_subtype: 'body lotion',
  keywords: ['body wash', 'hand soaps', 'scented candles'],
  categories: ['skincare'],
}

describe('deal search matching', () => {
  it('matches a free-typed retailer name', () => {
    expect(dealMatchesSearchTerm(deal, 'Bath and Body Works')).toBe(true)
  })

  it('matches singular and plural keyword variants', () => {
    expect(dealMatchesSearchTerm(deal, 'hand soap')).toBe(true)
    expect(dealMatchesSearchTerm(deal, 'candle')).toBe(true)
  })

  it('matches product text from the description and subtype', () => {
    expect(dealMatchesSearchTerm(deal, 'body care')).toBe(true)
    expect(dealMatchesSearchTerm(deal, 'lotion')).toBe(true)
  })

  it('uses OR logic for multiple search terms', () => {
    expect(dealMatchesAnySearchTerm(deal, ['jeans', 'body wash'])).toBe(true)
  })

  it('can run item searches without matching retailer names or loose descriptions', () => {
    expect(dealMatchesSearchTerm(deal, 'Bath and Body Works', {
      includeRetailer: false,
      includeDescription: false,
    })).toBe(false)
    expect(dealMatchesSearchTerm(deal, 'body care', {
      includeRetailer: false,
      includeDescription: false,
    })).toBe(false)
    expect(dealMatchesSearchTerm(deal, 'hand soap', {
      includeRetailer: false,
      includeDescription: false,
    })).toBe(true)
  })

  it('matches category slugs for category-like item searches', () => {
    expect(dealMatchesSearchTerm(deal, 'skincare')).toBe(true)
  })

  it('does not match unrelated partial words', () => {
    expect(dealMatchesSearchTerm(deal, 'bathroom')).toBe(false)
    expect(dealMatchesSearchTerm(deal, 'shoe')).toBe(false)
  })

  it('does not match generic deal keywords inside a longer user query', () => {
    expect(dealMatchesSearchTerm({
      ...deal,
      keywords: ['deals', 'offer'],
    }, 'restaurant deal', {
      includeRetailer: false,
      includeDescription: false,
      includeCategories: false,
    })).toBe(false)
    expect(dealMatchesSearchTerm({
      ...deal,
      keywords: ['offer'],
    }, 'restaurant offer', {
      includeRetailer: false,
      includeDescription: false,
      includeCategories: false,
    })).toBe(false)
  })
})
