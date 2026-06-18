import { describe, expect, it } from 'vitest'
import { dealMatchesAnySearchTerm, dealMatchesSearchTerm } from '@/lib/dealSearch'

const deal = {
  retailer: 'Bath & Body Works',
  description: 'Save 40% on select body care, hand soaps, and scented candles.',
  deal_subtype: 'body lotion',
  keywords: ['body wash', 'hand soaps', 'scented candles'],
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

  it('does not match unrelated partial words', () => {
    expect(dealMatchesSearchTerm(deal, 'bathroom')).toBe(false)
    expect(dealMatchesSearchTerm(deal, 'shoe')).toBe(false)
  })
})
