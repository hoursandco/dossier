import { afterEach, describe, expect, it, vi } from 'vitest'
import { jsonRequest, mockSupabase } from './test-helpers'

afterEach(() => {
  vi.resetModules()
  vi.clearAllMocks()
})

describe('GET /api/account', () => {
  it('returns 401 when not authenticated', async () => {
    await mockSupabase(null)
    const { GET } = await import('@/app/api/account/route')

    const res = await GET()

    expect(res.status).toBe(401)
    await expect(res.json()).resolves.toEqual({ error: 'Unauthorized' })
  })

  it('returns account details for an authenticated subscriber', async () => {
    await mockSupabase(
      { email: 'reader@example.com' },
      {
        subscribers: {
          data: {
            tier: 'paid',
            subscription_status: 'active',
            stripe_customer_id: 'cus_123',
            weekly_email_enabled: false,
          },
          error: null,
        },
      },
    )
    const { GET } = await import('@/app/api/account/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({
      email: 'reader@example.com',
      tier: 'paid',
      subscription_status: 'active',
      has_billing_account: true,
      weekly_email_enabled: false,
    })
  })

  it('returns free defaults for a new authenticated user', async () => {
    await mockSupabase(
      { email: 'new@example.com' },
      { subscribers: { data: null, error: null } },
    )
    const { GET } = await import('@/app/api/account/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toMatchObject({
      email: 'new@example.com',
      tier: 'free',
      subscription_status: null,
      has_billing_account: false,
      weekly_email_enabled: true,
    })
  })
})

describe('PATCH /api/account', () => {
  it('returns 401 when not authenticated', async () => {
    await mockSupabase(null)
    const { PATCH } = await import('@/app/api/account/route')

    const res = await PATCH(jsonRequest('/api/account', { weekly_email_enabled: false }) as never)

    expect(res.status).toBe(401)
  })

  it('updates the weekly email preference for an authenticated user', async () => {
    const { service } = await mockSupabase(
      { email: 'reader@example.com' },
      { subscribers: { data: null, error: null } },
    )
    const { PATCH } = await import('@/app/api/account/route')

    const res = await PATCH(jsonRequest('/api/account', { weekly_email_enabled: false }) as never)

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ success: true })
    const updateQuery = service.queries.subscribers[0]
    expect(updateQuery.update).toHaveBeenCalledWith(
      expect.objectContaining({ weekly_email_enabled: false }),
    )
    expect(updateQuery.eq).toHaveBeenCalledWith('email', 'reader@example.com')
  })

  it('rejects invalid preference bodies with 400', async () => {
    await mockSupabase({ email: 'reader@example.com' })
    const { PATCH } = await import('@/app/api/account/route')

    const res = await PATCH(jsonRequest('/api/account', { weekly_email_enabled: 'nope' }) as never)

    expect(res.status).toBe(400)
    await expect(res.json()).resolves.toEqual({ error: 'Invalid body' })
  })
})

describe('GET /api/stores', () => {
  it('returns the public store directory', async () => {
    await mockSupabase(null, {
      stores: {
        data: [
          {
            id: 'store_1',
            name: 'Zara',
            website: 'https://zara.com',
            categories: ['fashion'],
            status: 'active',
            is_active: true,
          },
        ],
        error: null,
      },
    })
    const { GET } = await import('@/app/api/stores/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({
      stores: [
        expect.objectContaining({
          id: 'store_1',
          name: 'Zara',
          status: 'active',
        }),
      ],
    })
  })

  it('hides declined stores in the Supabase query', async () => {
    const { service } = await mockSupabase(null, {
      stores: { data: [], error: null },
    })
    const { GET } = await import('@/app/api/stores/route')

    await GET()

    expect(service.queries.stores[0].neq).toHaveBeenCalledWith('status', 'declined')
  })
})

describe('POST /api/watches', () => {
  it('returns 401 when not authenticated', async () => {
    await mockSupabase(null)
    const { POST } = await import('@/app/api/watches/route')

    const res = await POST(jsonRequest('/api/watches', { category_slug: 'fashion' }) as never)

    expect(res.status).toBe(401)
  })

  it('returns 403 when a free user is over the watch limit', async () => {
    await mockSupabase(
      { email: 'reader@example.com' },
      {
        subscribers: [
          { data: { id: 'sub_1' }, error: null },
          { data: { tier: 'free' }, error: null },
        ],
        categories: { data: { slug: 'fashion' }, error: null },
        subscriber_watches: { data: null, error: null, count: 3 },
      },
    )
    const { POST } = await import('@/app/api/watches/route')

    const res = await POST(jsonRequest('/api/watches', { category_slug: 'fashion' }) as never)

    expect(res.status).toBe(403)
    await expect(res.json()).resolves.toMatchObject({ upgrade_url: '/pricing' })
  })

  it('creates a watch for a paid subscriber', async () => {
    await mockSupabase(
      { email: 'reader@example.com' },
      {
        subscribers: [
          { data: { id: 'sub_1' }, error: null },
          { data: { tier: 'paid' }, error: null },
        ],
        categories: { data: { slug: 'fashion' }, error: null },
        subscriber_watches: {
          data: {
            id: 'watch_1',
            category_slug: 'fashion',
            sub_type: null,
            created_at: '2026-05-23T00:00:00.000Z',
          },
          error: null,
        },
      },
    )
    const { POST } = await import('@/app/api/watches/route')

    const res = await POST(jsonRequest('/api/watches', { category_slug: 'fashion' }) as never)

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({
      watch: expect.objectContaining({ id: 'watch_1', category_slug: 'fashion' }),
    })
  })
})

describe('POST /api/stores/suggest', () => {
  it('returns 401 when not authenticated', async () => {
    await mockSupabase(null)
    const { POST } = await import('@/app/api/stores/suggest/route')

    const res = await POST(jsonRequest('/api/stores/suggest', { store_name: 'Acme' }) as never)

    expect(res.status).toBe(401)
  })

  it('returns 404 when the authenticated user has no subscriber row', async () => {
    await mockSupabase(
      { email: 'reader@example.com' },
      { subscribers: { data: null, error: null } },
    )
    const { POST } = await import('@/app/api/stores/suggest/route')

    const res = await POST(jsonRequest('/api/stores/suggest', { store_name: 'Acme' }) as never)

    expect(res.status).toBe(404)
    await expect(res.json()).resolves.toEqual({ error: 'Subscriber not found' })
  })

  it('creates a store suggestion for an authenticated subscriber', async () => {
    const { service } = await mockSupabase(
      { email: 'reader@example.com' },
      {
        subscribers: { data: { id: 'sub_1' }, error: null },
        store_suggestions: { data: null, error: null },
      },
    )
    const { POST } = await import('@/app/api/stores/suggest/route')

    const res = await POST(
      jsonRequest('/api/stores/suggest', {
        store_name: ' Acme ',
        website: ' https://acme.example ',
        category: ' Fashion ',
        notes: ' New store ',
      }) as never,
    )

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ success: true })
    expect(service.queries.store_suggestions[0].insert).toHaveBeenCalledWith({
      subscriber_id: 'sub_1',
      store_name: 'Acme',
      website: 'https://acme.example',
      category: 'Fashion',
      notes: 'New store',
    })
  })
})
