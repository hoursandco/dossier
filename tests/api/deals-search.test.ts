import { afterEach, describe, expect, it, vi } from 'vitest'
import { NextRequest } from 'next/server'
import { mockSupabase } from './test-helpers'

afterEach(() => {
  vi.resetModules()
  vi.clearAllMocks()
})

const recentDeals = [
  {
    id: 'deal-1',
    retailer: 'Bath & Body Works',
    description: 'Save on select body care and hand soaps.',
    percent_off: 40,
    deal_type: 'percent-off',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com',
    affiliate_link: null,
    categories: [],
    keywords: ['hand soaps'],
    deal_subtype: 'body lotion',
    week_of: '2026-06-18',
    created_at: '2026-06-18T12:00:00Z',
    source_email_link: null,
  },
  {
    id: 'deal-noisy-description',
    retailer: 'Everything Store',
    description: 'Save during our hand soap inspired summer event.',
    percent_off: 30,
    deal_type: 'percent-off',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com/noisy',
    affiliate_link: null,
    categories: [],
    keywords: ['summer sale'],
    deal_subtype: null,
    week_of: '2026-06-18',
    created_at: '2026-06-18T12:00:00Z',
    source_email_link: null,
  },
  {
    id: 'deal-restaurant-category',
    retailer: 'Some Grill',
    description: 'Buy one entree, get one free with any drink purchase.',
    percent_off: null,
    deal_type: 'bogo-half',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com/somegrill',
    affiliate_link: null,
    categories: ['restaurant'],
    keywords: ['bogo entree', 'kids eat free'],
    deal_subtype: null,
    week_of: '2026-06-18',
    created_at: '2026-06-18T12:00:00Z',
    source_email_link: null,
  },
  {
    id: 'deal-unrelated-category',
    retailer: 'Gadget World',
    description: 'Save on headphones and chargers.',
    percent_off: 20,
    deal_type: 'percent-off',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com/gadgetworld',
    affiliate_link: null,
    categories: ['electronics'],
    keywords: ['headphones', 'chargers'],
    deal_subtype: null,
    week_of: '2026-06-18',
    created_at: '2026-06-18T12:00:00Z',
    source_email_link: null,
  },
  {
    id: 'deal-generic-offer',
    retailer: 'LOFT Outlet',
    description: 'Extra 15% off purchases of $75 or more.',
    percent_off: 15,
    deal_type: 'percent-off',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com/loft-outlet',
    affiliate_link: null,
    categories: [],
    keywords: ['discount', 'offer'],
    deal_subtype: null,
    week_of: '2026-06-18',
    created_at: '2026-06-18T12:00:00Z',
    source_email_link: null,
  },
  {
    id: 'deal-generic-deals',
    retailer: 'Spencer\'s',
    description: 'Score fan favorites for $5 each in clearance.',
    percent_off: null,
    deal_type: 'price-point',
    promo_code: null,
    expiration_date: null,
    original_link: 'https://example.com/spencers',
    affiliate_link: null,
    categories: [],
    keywords: ['clearance', 'deals'],
    deal_subtype: null,
    week_of: '2026-06-18',
    created_at: '2026-06-18T12:00:00Z',
    source_email_link: null,
  },
]

describe('GET /api/deals/search', () => {
  it('matches non-exact product terms without matching loose description text', async () => {
    await mockSupabase(null, {
      deals: { data: recentDeals, error: null },
      item_keyword_reviews: [
        { data: [], error: null },
      ],
      stores: [
        { data: [{ name: 'Bath & Body Works', website: 'https://bathandbodyworks.com', price_tier: '$$' }], error: null },
      ],
    })
    const { GET } = await import('@/app/api/deals/search/route')

    const productResponse = await GET(new NextRequest('http://localhost/api/deals/search?keyword=hand%20soap'))
    const body = await productResponse.json()

    expect(body).toMatchObject({ deals: [{ id: 'deal-1' }] })
    expect(body.deals.map((deal: { id: string }) => deal.id)).not.toContain('deal-noisy-description')
  })

  it('surfaces deals matched only by category, without pulling in unrelated categories', async () => {
    await mockSupabase(null, {
      deals: { data: recentDeals, error: null },
      item_keyword_reviews: [
        { data: [], error: null },
      ],
      stores: [
        { data: [], error: null },
      ],
    })
    const { GET } = await import('@/app/api/deals/search/route')

    const response = await GET(new NextRequest('http://localhost/api/deals/search?keyword=restaurant'))
    const body = await response.json()
    const ids = body.deals.map((deal: { id: string }) => deal.id)

    expect(ids).toContain('deal-restaurant-category')
    expect(ids).not.toContain('deal-unrelated-category')
  })

  it('does not match generic promo keywords inside longer restaurant queries', async () => {
    await mockSupabase(null, {
      deals: [
        { data: recentDeals, error: null },
        { data: recentDeals, error: null },
      ],
      item_keyword_reviews: [
        { data: [], error: null },
        { data: [], error: null },
      ],
      stores: [
        { data: [], error: null },
      ],
    })
    const { GET } = await import('@/app/api/deals/search/route')

    const dealResponse = await GET(new NextRequest('http://localhost/api/deals/search?keyword=restaurant%20deal'))
    const offerResponse = await GET(new NextRequest('http://localhost/api/deals/search?keyword=restaurant%20offer'))
    const dealBody = await dealResponse.json()
    const offerBody = await offerResponse.json()

    expect(dealBody.deals.map((deal: { id: string }) => deal.id)).not.toContain('deal-generic-deals')
    expect(offerBody.deals.map((deal: { id: string }) => deal.id)).not.toContain('deal-generic-offer')
  })

  it('matches an alternate extracted retailer name when a brand is selected', async () => {
    const altraDeal = {
      ...recentDeals[0],
      id: 'deal-altra',
      retailer: 'Altra Running',
      description: 'Save on running shoes.',
      keywords: ['running shoes'],
    }
    await mockSupabase(null, {
      stores: [
        { data: [{ id: 'store-altra', name: 'Altra' }], error: null },
        { data: [{ name: 'Altra', website: 'https://altrarunning.com', price_tier: '$$' }], error: null },
      ],
      brand_relationship_reviews: { data: [], error: null },
      deals: { data: [altraDeal], error: null },
    })
    const { GET } = await import('@/app/api/deals/search/route')

    const response = await GET(new NextRequest('http://localhost/api/deals/search?retailer=Altra'))

    await expect(response.json()).resolves.toMatchObject({ deals: [{ id: 'deal-altra' }] })
  })
})
