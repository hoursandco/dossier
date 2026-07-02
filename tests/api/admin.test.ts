import { afterEach, describe, expect, it, vi } from 'vitest'
import { jsonRequest, mockSupabase } from './test-helpers'

afterEach(() => {
  vi.unstubAllEnvs()
  vi.resetModules()
  vi.clearAllMocks()
})

describe('Admin gate', () => {
  it('returns false when no user is authenticated', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'admin@example.com')
    await mockSupabase(null)
    const { GET } = await import('@/app/api/admin/check/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ isAdmin: false })
  })

  it('returns false for authenticated non-admin users', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'admin@example.com')
    await mockSupabase({ email: 'reader@example.com' })
    const { GET } = await import('@/app/api/admin/check/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ isAdmin: false })
  })

  it('fails closed when ADMIN_EMAIL is not set', async () => {
    vi.stubEnv('ADMIN_EMAIL', '')
    await mockSupabase({ email: 'admin@example.com' })
    const { GET } = await import('@/app/api/admin/check/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ isAdmin: false })
  })

  it('allows a case-insensitive match from ADMIN_EMAIL', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'owner@example.com, Admin@Example.com ')
    await mockSupabase({ email: 'admin@example.com' })
    const { GET } = await import('@/app/api/admin/check/route')

    const res = await GET()

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ isAdmin: true })
  })
})

describe('POST /api/admin/respond-suggestion', () => {
  it('returns 401 when not authenticated', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'admin@example.com')
    await mockSupabase(null)
    const { POST } = await import('@/app/api/admin/respond-suggestion/route')

    const res = await POST(jsonRequest('/api/admin/respond-suggestion', {}) as never)

    expect(res.status).toBe(401)
  })

  it('returns 401 when authenticated as non-admin', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'admin@example.com')
    await mockSupabase({ email: 'reader@example.com' })
    const { POST } = await import('@/app/api/admin/respond-suggestion/route')

    const res = await POST(jsonRequest('/api/admin/respond-suggestion', {}) as never)

    expect(res.status).toBe(401)
  })

  it('sends an escaped response email and updates the suggestion status for admins', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'admin@example.com')
    vi.stubEnv('RESEND_API_KEY', 'test_resend_key')
    const sendEmail = vi.fn(async (_email: { html: string; to: string }) => ({ id: 'email_1' }))
    vi.doMock('resend', () => ({
      Resend: vi.fn(function Resend() {
        return { emails: { send: sendEmail } }
      }),
    }))
    const { service } = await mockSupabase(
      { email: 'admin@example.com' },
      {
        store_suggestions: [
          {
            data: {
              store_name: '<Best Store>',
              website: 'https://best.example',
              subscriber_id: 'sub_1',
            },
            error: null,
          },
          { data: null, error: null },
        ],
        stores: [
          { data: [], error: null },
          { data: null, error: null },
        ],
        subscribers: { data: { email: 'reader@example.com' }, error: null },
      },
    )
    const { POST } = await import('@/app/api/admin/respond-suggestion/route')

    const res = await POST(
      jsonRequest('/api/admin/respond-suggestion', {
        suggestion_id: 'suggestion_1',
        response_type: 'added',
        note: '<script>alert(1)</script>',
      }) as never,
    )

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ success: true, emailed: true })
    expect(sendEmail).toHaveBeenCalledWith(
      expect.objectContaining({
        to: 'reader@example.com',
        html: expect.stringContaining('&lt;Best Store&gt;'),
      }),
    )
    expect(sendEmail.mock.calls[0][0].html).toContain('&lt;script&gt;alert(1)&lt;/script&gt;')
    expect(sendEmail.mock.calls[0][0].html).not.toContain('<script>alert(1)</script>')
    expect(service.queries.stores[1].insert).toHaveBeenCalledWith({
      name: '<Best Store>',
      website: 'https://best.example',
      categories: [],
      status: 'pending',
      is_active: false,
    })
    expect(service.queries.store_suggestions[1].update).toHaveBeenCalledWith({ status: 'added' })
    expect(service.queries.store_suggestions[1].eq).toHaveBeenCalledWith('id', 'suggestion_1')
  })

  it('returns 400 when suggestion_id or response_type is missing', async () => {
    vi.stubEnv('ADMIN_EMAIL', 'admin@example.com')
    await mockSupabase({ email: 'admin@example.com' })
    const { POST } = await import('@/app/api/admin/respond-suggestion/route')

    const res = await POST(
      jsonRequest('/api/admin/respond-suggestion', { response_type: 'added' }) as never,
    )

    expect(res.status).toBe(400)
    await expect(res.json()).resolves.toEqual({ error: 'Invalid request' })
  })
})
