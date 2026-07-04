// Admin CRUD for the brand directory.
//
// GET    /api/admin/stores      → list all (active + inactive, with search)
// POST   /api/admin/stores      → create
//
// Per-row PATCH and DELETE live under /api/admin/stores/[id].
//
// Admin gate: ADMIN_EMAIL must match the authenticated user. Without an
// admin email set in the environment, every request 401s — fail closed.

import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'
import { filterToCanonicalCategorySlugs } from '@/lib/storeCategories'

export const dynamic = 'force-dynamic'

async function requireAdmin(): Promise<{ ok: true } | { ok: false; res: NextResponse }> {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return { ok: false, res: NextResponse.json({ error: 'Unauthorized' }, { status: 401 }) }
  }
  return { ok: true }
}

export async function GET(request: NextRequest) {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  const url = new URL(request.url)
  const search = url.searchParams.get('q')?.trim() ?? ''
  const status = url.searchParams.get('status')?.trim() ?? ''
  const category = url.searchParams.get('category')?.trim() ?? ''

  const service = createServiceClient()
  const safeSearch = search ? search.replace(/[\\%_]/g, '\\$&') : null

  // PostgREST caps every request at ~1000 rows regardless of .limit(),
  // and the directory is 1700+. Page through with .range() — and apply
  // the status/category filters in SQL — so the admin list (and the
  // auto-added review panel, which filters status=auto_added) see the
  // whole table instead of a silently-truncated, unfiltered first 1000.
  const PAGE_SIZE = 1000
  const SELECT_COLS =
    'id, name, website, categories, price_tier, is_active, status, age_group, affiliate_id, date_added, created_at, updated_at'

  const buildQuery = (pageIndex: number) => {
    let q = service
      .from('stores')
      .select(SELECT_COLS)
      .order('name', { ascending: true })
      .range(pageIndex * PAGE_SIZE, (pageIndex + 1) * PAGE_SIZE - 1)
    if (safeSearch) q = q.ilike('name', `%${safeSearch}%`)
    if (category) q = q.contains('categories', [category])
    if (status) q = q.eq('status', status)
    return q
  }

  const page0 = await buildQuery(0)

  if (!page0.error) {
    const all = [...(page0.data ?? [])]
    let lastCount = page0.data?.length ?? 0
    let pageIndex = 1
    while (lastCount === PAGE_SIZE && pageIndex < 10) {
      const next = await buildQuery(pageIndex)
      if (next.error) {
        console.error('[admin stores] pagination error page', pageIndex, JSON.stringify(next.error))
        break
      }
      const rows = next.data ?? []
      all.push(...rows)
      lastCount = rows.length
      pageIndex++
    }
    return NextResponse.json({ stores: all })
  }

  // 42703 = status column doesn't exist → migration 019 not applied
  // yet. Fall back to the pre-019 query so the admin UI still works.
  if ((page0.error as { code?: string }).code === '42703') {
    console.warn('[admin stores] status column missing — falling back. Run migration 019.')
    let fallbackQuery = service
      .from('stores')
      .select(
        'id, name, website, categories, price_tier, is_active, age_group, affiliate_id, date_added, updated_at'
      )
      .order('name', { ascending: true })
    if (safeSearch) fallbackQuery = fallbackQuery.ilike('name', `%${safeSearch}%`)
    if (category) fallbackQuery = fallbackQuery.contains('categories', [category])
    const fallback = await fallbackQuery
    if (fallback.error) {
      console.error('[admin stores] fallback error:', JSON.stringify(fallback.error))
      return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
    }
    let stores = (fallback.data ?? []).map((s) => ({
      ...s,
      status: s.is_active ? 'active' : 'pending',
    }))
    // Pre-019 has no status column — apply the status filter in memory.
    if (status) stores = stores.filter((s) => s.status === status)
    return NextResponse.json({ stores })
  }

  console.error('[admin stores] list error:', JSON.stringify(page0.error))
  return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
}

interface StoreInput {
  name?: string
  website?: string
  categories?: string[]
  price_tier?: string | null
  is_active?: boolean
  status?: string
  age_group?: string | null
  affiliate_id?: string | null
}

export async function POST(request: NextRequest) {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  let body: StoreInput
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const name = body.name?.trim()
  const website = body.website?.trim()
  if (!name || !website) {
    return NextResponse.json({ error: 'name and website are required' }, { status: 400 })
  }

  const service = createServiceClient()
  const { data, error } = await service
    .from('stores')
    .insert({
      name,
      website,
      categories: await filterToCanonicalCategorySlugs(service, body.categories ?? []),
      price_tier: body.price_tier ?? null,
      // Keep is_active + status in sync. If caller sent status, derive
      // is_active. Else trust whatever's there.
      is_active: body.status ? body.status === 'active' : (body.is_active ?? true),
      status: body.status ?? (body.is_active === false ? 'pending' : 'active'),
      age_group: body.age_group ?? null,
      affiliate_id: body.affiliate_id ?? null,
    })
    .select()
    .single()

  if (error) {
    const code = (error as { code?: string }).code
    if (code === '23505') {
      return NextResponse.json({ error: 'A store with that website already exists' }, { status: 409 })
    }
    console.error('[admin stores] create error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to create store' }, { status: 500 })
  }

  return NextResponse.json({ store: data })
}
