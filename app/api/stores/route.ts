// Public brand directory.
//
// Returns every store EXCEPT 'declined' rows. /suggest uses this to
// power its autofill — and the autofill needs to know about pending +
// no_email stores too, so it can tell the user "we have that brand in
// our directory but no email yet" or "we checked, they don't have a
// promo list, sorry." Only 'declined' is hidden — those should not
// even surface as autofill matches.

import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { normalizeRetailerWebsite } from '@/lib/domainNormalize'

export const dynamic = 'force-dynamic'

export interface StoreRow {
  id: string
  name: string
  website: string
  categories: string[]
  price_tier: string | null
  age_group: string | null
  date_added: string
  status: string
  is_active: boolean
}

function normalizeStoreName(name: string): string {
  return name.toLowerCase().replace(/[^a-z0-9]/g, '')
}

function dedupeStores<T extends StoreRow>(stores: T[]): T[] {
  const byKey = new Map<string, T>()

  for (const store of stores) {
    const website = normalizeRetailerWebsite(store.website)
    const name = normalizeStoreName(store.name)
    const key = website && name ? `${website}::${name}` : store.id
    const existing = byKey.get(key)
    if (!existing) {
      byKey.set(key, store)
      continue
    }

    const existingCategoryCount = existing.categories?.length ?? 0
    const storeCategoryCount = store.categories?.length ?? 0
    if (storeCategoryCount > existingCategoryCount) {
      byKey.set(key, store)
      continue
    }

    const existingDate = existing.date_added ? new Date(existing.date_added).getTime() : 0
    const storeDate = store.date_added ? new Date(store.date_added).getTime() : 0
    if (storeCategoryCount === existingCategoryCount && storeDate > existingDate) {
      byKey.set(key, store)
    }
  }

  return Array.from(byKey.values()).sort((a, b) => a.name.localeCompare(b.name))
}

export async function GET(req: NextRequest) {
  const supabase = createServiceClient()

  // `?confirmed=true` narrows the response to the admin-curated set:
  //   status='active' AND is_active=true
  // Used by the public /stores browse page and the homepage brand
  // picker, where pending / auto_added / no_email rows would surface
  // half-finished brand data. Default (no param) keeps the original
  // behavior for /suggest's autofill (which wants to know about
  // pending + no_email rows so it can say "we have that brand but no
  // email yet").
  const confirmedOnly = req.nextUrl.searchParams.get('confirmed') === 'true'

  // PostgREST caps every request at ~1000 rows regardless of .limit(),
  // and the directory is 1700+. Page through with .range() — otherwise
  // the brand picker / autofill only ever sees the first 1000 stores
  // alphabetically, so everything from ~"S" onward (Zara included) is
  // silently invisible.
  const PAGE_SIZE = 1000

  const primaryPage = (i: number) => {
    const q = supabase
      .from('stores')
      .select(
        'id, name, website, categories, price_tier, age_group, date_added, status, is_active'
      )
      .order('name', { ascending: true })
      .range(i * PAGE_SIZE, (i + 1) * PAGE_SIZE - 1)
    return confirmedOnly
      ? q.eq('status', 'active').eq('is_active', true)
      : q.neq('status', 'declined')
  }

  const page0 = await primaryPage(0)

  if (!page0.error) {
    const all = [...(page0.data ?? [])]
    let lastCount = page0.data?.length ?? 0
    let i = 1
    while (lastCount === PAGE_SIZE && i < 10) {
      const next = await primaryPage(i)
      if (next.error) {
        console.error('[stores] pagination error page', i, JSON.stringify(next.error))
        break
      }
      const rows = next.data ?? []
      all.push(...rows)
      lastCount = rows.length
      i++
    }
    return NextResponse.json({ stores: dedupeStores(all as StoreRow[]) })
  }

  // 42703 = status column missing → migration 019 not applied yet. Fall
  // back to the pre-019 query so the autofill keeps working.
  if ((page0.error as { code?: string }).code === '42703') {
    console.warn('[stores] status column missing — falling back. Run migration 019.')
    const fbPage = (i: number) =>
      supabase
        .from('stores')
        .select('id, name, website, categories, price_tier, age_group, date_added, is_active')
        .eq('is_active', true)
        .order('name', { ascending: true })
        .range(i * PAGE_SIZE, (i + 1) * PAGE_SIZE - 1)
    const all: StoreRow[] = []
    let lastCount = PAGE_SIZE
    let i = 0
    while (lastCount === PAGE_SIZE && i < 10) {
      const fb = await fbPage(i)
      if (fb.error) {
        console.error('[stores] fallback error:', JSON.stringify(fb.error))
        return NextResponse.json({ stores: [], error: 'Failed to load stores' }, { status: 200 })
      }
      const rows = fb.data ?? []
      all.push(...rows.map((s) => ({ ...s, status: 'active' } as StoreRow)))
      lastCount = rows.length
      i++
    }
    return NextResponse.json({ stores: dedupeStores(all) })
  }

  console.error('[stores] lookup error:', JSON.stringify(page0.error))
  return NextResponse.json({ stores: [], error: 'Failed to load stores' }, { status: 200 })
}
