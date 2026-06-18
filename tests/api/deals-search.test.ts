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
]

describe('GET /api/deals/search', () => {
  it('matches free-typed brands and non-exact product terms', async () => {
    await mockSupabase(null, {
      deals: [{ data: recentDeals, error: null }, { data: recentDeals, error: null }],
      stores: [
        { data: [{ name: 'Bath & Body Works', website: 'https://bathandbodyworks.com', price_tier: '$$' }], error: null },
        { data: [{ name: 'Bath & Body Works', website: 'https://bathandbodyworks.com', price_tier: '$$' }], error: null },
      ],
    })
    const { GET } = await import('@/app/api/deals/search/route')

    const brandResponse = await GET(new NextRequest('http://localhost/api/deals/search?keyword=Bath%20and%20Body%20Works'))
    const productResponse = await GET(new NextRequest('http://localhost/api/deals/search?keyword=hand%20soap'))

    await expect(brandResponse.json()).resolves.toMatchObject({ deals: [{ id: 'deal-1' }] })
    await expect(productResponse.json()).resolves.toMatchObject({ deals: [{ id: 'deal-1' }] })
  })
})
