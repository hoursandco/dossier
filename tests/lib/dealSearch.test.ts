import { describe, expect, it } from 'vitest'
import {
  dealMatchesAnySearchTerm,
  dealMatchesSearchTerm,
  expandCategorySearchTerms,
} from '@/lib/dealSearch'

const deal = {
  retailer: 'Bath & Body Works',
  description: 'Save 40% on select body care, hand soaps, and scented candles.',
  keywords: ['body wash', 'hand soaps', 'scented candles', 'body lotion'],
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

  it('matches product text from the description and keywords', () => {
    expect(dealMatchesSearchTerm(deal, 'body care')).toBe(true)
    expect(dealMatchesSearchTerm(deal, 'lotion')).toBe(true)
  })

  it('matches watch sub_type-style item terms against keywords only', () => {
    const keywordsOnly = {
      includeRetailer: false,
      includeDescription: false,
      includeCategories: false,
    }
    expect(dealMatchesSearchTerm(deal, 'body lotion', keywordsOnly)).toBe(true)
    expect(dealMatchesSearchTerm(deal, 'hand soap', keywordsOnly)).toBe(true)
    // Category and description hits don't count in keywords-only mode.
    expect(dealMatchesSearchTerm(deal, 'skincare', keywordsOnly)).toBe(false)
    expect(dealMatchesSearchTerm(deal, 'body care', keywordsOnly)).toBe(false)
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

  it('expands category aliases and labels to canonical slugs', () => {
    const categories = [
      { slug: 'skincare', label: 'Skincare', search_terms: ['skin care'] },
      { slug: 'tech-electronics', label: 'Tech & Electronics', search_terms: ['electronics', 'tech'] },
    ]
    expect(expandCategorySearchTerms(['skin care'], categories)).toContain('skincare')
    expect(expandCategorySearchTerms(['Tech and Electronics'], categories)).toContain('tech-electronics')
    expect(expandCategorySearchTerms(['electronics'], categories)).toContain('tech-electronics')
    // Unrelated terms pass through unchanged.
    expect(expandCategorySearchTerms(['jeans'], categories)).toEqual(['jeans'])
  })

  it('finds skincare-tagged deals for the alias "skin care" after expansion', () => {
    const categories = [{ slug: 'skincare', label: 'Skincare', search_terms: ['skin care'] }]
    const expanded = expandCategorySearchTerms(['skin care'], categories)
    expect(dealMatchesAnySearchTerm(deal, expanded, {
      includeRetailer: false,
      includeDescription: false,
    })).toBe(true)
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
