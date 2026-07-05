import { describe, it, expect } from 'vitest'
import {
  buildDuplicateDealRefresh,
  mergeSubtypeIntoKeywords,
  rankDeals,
  filterDealsForSubscriber,
  isDealValidForWeek,
  formatSavings,
  getDealLink,
  getJunkDealReason,
  isPricePointDescription,
  formatRedemptionChannel,
} from '@/lib/deals'
import type { Deal } from '@/types'

const baseWeek = new Date('2026-04-21')

function makeDeal(overrides: Partial<Deal> = {}): Deal {
  return {
    id: '1',
    retailer: 'TestStore',
    description: '40% off everything',
    percent_off: 40,
    deal_type: 'percent-off',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com',
    affiliate_link: null,
    categories: ['fashion'],
    gender: ['men', 'women', 'unisex'],
    week_of: '2026-04-21',
    source_email_id: null,
    source_email_link: null,
    redemption_channel: 'online',
    last_seen_at: null,
    is_manual: false,
    created_at: '2026-04-21T00:00:00Z',
    ...overrides,
  }
}

const defaultFilter = {
  minDiscount: 20,
  enabledCategories: ['fashion'],
  enabledDealTypes: ['percent-off', 'bogo-free', 'free-item', 'free-shipping', 'bogo-half', 'flash-sale', 'stackable', 'loyalty', 'up-to', 'price-point', 'amount-off'],
  weekOf: baseWeek,
}

describe('rankDeals', () => {
  it('ranks free-item highest', () => {
    const deals = [
      makeDeal({ deal_type: 'percent-off', percent_off: 50 }),
      makeDeal({ deal_type: 'free-item', percent_off: null }),
    ]
    const ranked = rankDeals(deals)
    expect(ranked[0].deal_type).toBe('free-item')
  })

  it('ranks higher percent-off above lower', () => {
    const deals = [
      makeDeal({ deal_type: 'percent-off', percent_off: 30 }),
      makeDeal({ deal_type: 'percent-off', percent_off: 70 }),
    ]
    const ranked = rankDeals(deals)
    expect(ranked[0].percent_off).toBe(70)
  })

  it('does not mutate original array', () => {
    const deals = [makeDeal({ percent_off: 30 }), makeDeal({ percent_off: 70 })]
    const original = [...deals]
    rankDeals(deals)
    expect(deals[0].percent_off).toBe(original[0].percent_off)
  })
})

describe('formatRedemptionChannel', () => {
  it('formats deal redemption chips and defaults legacy deals to online', () => {
    expect(formatRedemptionChannel('online')).toBe('Online')
    expect(formatRedemptionChannel('in-store')).toBe('In store')
    expect(formatRedemptionChannel('online-and-in-store')).toBe('Online + in store')
    expect(formatRedemptionChannel(null)).toBe('Online')
  })
})

describe('isDealValidForWeek', () => {
  it('passes deals with no expiration', () => {
    const deal = makeDeal({ expiration_date: null })
    expect(isDealValidForWeek(deal, baseWeek)).toBe(true)
  })

  it('passes deals that expire after the send day', () => {
    const deal = makeDeal({ expiration_date: '2026-04-25' })
    expect(isDealValidForWeek(deal, baseWeek)).toBe(true)
  })

  it('rejects deals that expire before the send day', () => {
    const deal = makeDeal({ expiration_date: '2026-04-20' })
    expect(isDealValidForWeek(deal, baseWeek)).toBe(false)
  })
})

describe('filterDealsForSubscriber', () => {
  it('returns deals matching enabled categories', () => {
    const deals = [
      makeDeal({ categories: ['fashion'] }),
      makeDeal({ categories: ['tech'] }),
    ]
    const result = filterDealsForSubscriber(deals, 20, ['fashion'], defaultFilter.enabledDealTypes, baseWeek)
    expect(result).toHaveLength(1)
    expect(result[0].categories).toContain('fashion')
  })

  it('filters out deals below min discount', () => {
    const deals = [
      makeDeal({ percent_off: 15 }),
      makeDeal({ percent_off: 25 }),
    ]
    const result = filterDealsForSubscriber(deals, 20, ['fashion'], defaultFilter.enabledDealTypes, baseWeek)
    expect(result).toHaveLength(1)
    expect(result[0].percent_off).toBe(25)
  })

  it('always passes free-item regardless of percent_off', () => {
    const deal = makeDeal({ deal_type: 'free-item', percent_off: null })
    const result = filterDealsForSubscriber([deal], 50, ['fashion'], defaultFilter.enabledDealTypes, baseWeek)
    expect(result).toHaveLength(1)
  })

  it('passes dollar-off coupons regardless of percent_off', () => {
    const deal = makeDeal({
      deal_type: 'amount-off',
      percent_off: null,
      description: "Save $2.50 on any ONE Hellmann's mayonnaise.",
    })
    const result = filterDealsForSubscriber([deal], 50, ['fashion'], defaultFilter.enabledDealTypes, baseWeek)
    expect(result).toHaveLength(1)
  })

  it('filters by gender', () => {
    const deals = [
      makeDeal({ gender: ['men'] }),
      makeDeal({ gender: ['women'] }),
    ]
    const result = filterDealsForSubscriber(deals, 20, ['fashion'], defaultFilter.enabledDealTypes, baseWeek, {
      genderFilter: ['women'],
    })
    expect(result).toHaveLength(1)
    expect(result[0].gender).toContain('women')
  })

  it('filters by retailer in retailer mode', () => {
    const deals = [
      makeDeal({ retailer: 'Nike' }),
      makeDeal({ retailer: 'Adidas' }),
    ]
    const result = filterDealsForSubscriber(deals, 20, ['fashion'], defaultFilter.enabledDealTypes, baseWeek, {
      subscriptionMode: 'retailer',
      selectedRetailers: ['Nike'],
    })
    expect(result).toHaveLength(1)
    expect(result[0].retailer).toBe('Nike')
  })

  it('rejects expired deals', () => {
    const deal = makeDeal({ expiration_date: '2026-04-20' })
    const result = filterDealsForSubscriber([deal], 20, ['fashion'], defaultFilter.enabledDealTypes, baseWeek)
    expect(result).toHaveLength(0)
  })
})

describe('formatSavings', () => {
  it('returns BOGO for bogo-free', () => {
    expect(formatSavings(makeDeal({ deal_type: 'bogo-free', percent_off: null }))).toBe('BOGO')
  })

  it('returns percentage for percent-off', () => {
    expect(formatSavings(makeDeal({ deal_type: 'percent-off', percent_off: 40 }))).toBe('40%')
  })

  it('returns Free for free-item', () => {
    expect(formatSavings(makeDeal({ deal_type: 'free-item', percent_off: null }))).toBe('Free')
  })

  it('returns the dollar amount for amount-off coupons', () => {
    expect(formatSavings(makeDeal({
      deal_type: 'amount-off',
      percent_off: null,
      description: 'Save $2.50 on any ONE Hellmann’s mayonnaise.',
    }))).toBe('$2.50')
  })

  it('labels promoted prices without claiming a discount', () => {
    expect(formatSavings(makeDeal({
      deal_type: 'price-point',
      percent_off: null,
      description: 'Denim shorts starting at $12.99.',
    }))).toBe('Starting At')
    expect(formatSavings(makeDeal({
      deal_type: 'price-point',
      percent_off: null,
      description: 'New York strip steak is on sale for $8.99.',
    }))).toBe('Sale Price')
  })
})

describe('price-point offers', () => {
  it('recognizes apparel, grocery, and furniture advertised prices', () => {
    expect(isPricePointDescription('Denim shorts starting at $12.99.')).toBe(true)
    expect(isPricePointDescription('Spinach is on sale for $1.98.')).toBe(true)
    expect(isPricePointDescription('Sectional sofa from $799.')).toBe(true)
  })

  it('keeps price-point offers but rejects the same text under another type', () => {
    const description = 'Jack’s pizza is on sale for $2.98.'
    expect(getJunkDealReason({
      retailer: 'Hy-Vee',
      deal_type: 'price-point',
      description,
      percent_off: null,
      promo_code: null,
    })).toBeNull()
    expect(getJunkDealReason({
      retailer: 'Hy-Vee',
      deal_type: 'flash-sale',
      description,
      percent_off: null,
      promo_code: null,
    })).toBe('price listing without a discount')
  })

  it('does not let an unquantified price point satisfy a minimum discount', () => {
    const result = filterDealsForSubscriber(
      [makeDeal({
        deal_type: 'price-point',
        percent_off: null,
        description: 'Denim shorts starting at $12.99.',
      })],
      20,
      ['fashion'],
      defaultFilter.enabledDealTypes,
      baseWeek,
    )
    expect(result).toHaveLength(0)
  })
})

describe('getDealLink', () => {
  it('prefers affiliate_link over original_link', () => {
    const deal = makeDeal({ original_link: 'https://original.com', affiliate_link: 'https://affiliate.com' })
    expect(getDealLink(deal)).toBe('https://affiliate.com')
  })

  it('falls back to original_link when no affiliate', () => {
    const deal = makeDeal({ original_link: 'https://original.com', affiliate_link: null })
    expect(getDealLink(deal)).toBe('https://original.com')
  })
})

describe('mergeSubtypeIntoKeywords', () => {
  it('folds the legacy deal_subtype into a normalized keyword list', () => {
    expect(mergeSubtypeIntoKeywords(['Jeans', ' denim '], ' Skinny Jeans ')).toEqual([
      'jeans', 'denim', 'skinny jeans',
    ])
  })

  it('dedupes a subtype that already exists as a keyword', () => {
    expect(mergeSubtypeIntoKeywords(['moisturizer'], 'Moisturizer')).toEqual(['moisturizer'])
  })

  it('handles missing keywords and subtype', () => {
    expect(mergeSubtypeIntoKeywords(null, null)).toEqual([])
    expect(mergeSubtypeIntoKeywords(undefined, 'air fryer')).toEqual(['air fryer'])
  })
})

describe('buildDuplicateDealRefresh', () => {
  it('refreshes last_seen_at when duplicate metadata is unchanged', () => {
    const seenAt = '2026-07-02T14:20:00.000Z'
    const result = buildDuplicateDealRefresh(
      {
        categories: ['pets'],
        keywords: [],
        redemption_channel: 'online',
      },
      {
        categories: ['pets'],
        keywords: [],
        deal_subtype: null,
        redemption_channel: 'online',
      },
      seenAt,
    )

    expect(result.metadataChanged).toBe(false)
    expect(result.update).toEqual({
      categories: ['pets'],
      keywords: [],
      redemption_channel: 'online',
      last_seen_at: seenAt,
    })
  })

  it('merges new duplicate metadata, folding the incoming subtype into keywords', () => {
    const result = buildDuplicateDealRefresh(
      {
        categories: ['pets'],
        keywords: ['dog food'],
        redemption_channel: null,
      },
      {
        categories: ['pets', 'pet-supplies'],
        keywords: ['Cat Litter'],
        deal_subtype: 'pet supplies',
        redemption_channel: 'online',
      },
      '2026-07-02T14:20:00.000Z',
    )

    expect(result.metadataChanged).toBe(true)
    expect(result.update).toMatchObject({
      categories: ['pets', 'pet-supplies'],
      keywords: ['dog food', 'cat litter', 'pet supplies'],
      redemption_channel: 'online',
    })
  })

  it('does not report a change when the incoming subtype is already a keyword', () => {
    const result = buildDuplicateDealRefresh(
      {
        categories: ['skincare'],
        keywords: ['moisturizer'],
        redemption_channel: 'online',
      },
      {
        categories: ['skincare'],
        keywords: [],
        deal_subtype: 'Moisturizer',
        redemption_channel: 'online',
      },
      '2026-07-02T14:20:00.000Z',
    )

    expect(result.metadataChanged).toBe(false)
    expect(result.update.keywords).toEqual(['moisturizer'])
  })
})
