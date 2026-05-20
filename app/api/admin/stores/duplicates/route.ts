// GET /api/admin/stores/duplicates
//
// Returns clusters of stores whose `website` normalizes to the same
// host. Surfaces the residue from auto-add + manual-add overlaps —
// e.g. ingest auto-created "Brand" from `news.brand.com` while the
// admin had already added "Brand" with `brand.com`, both now point at
// the same apex domain.
//
// Algorithm:
//   1. Pull every store (id, name, website, status, categories, dates).
//   2. Compute each one's normalized website via the shared helper.
//   3. Group rows by normalized URL.
//   4. Return only groups with >= 2 rows. Sort biggest groups first.
//
// Cheap enough at our scale (single SELECT, JS grouping) — no need for
// a SQL GROUP BY pass yet.

import { NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { normalizeRetailerWebsite } from '@/lib/domainNormalize'

export const dynamic = 'force-dynamic'
export const maxDuration = 60

type StoreRow = {
  id: string
  name: string
  website: string | null
  status: string | null
  is_active: boolean
  categories: string[] | null
  sub_types: string[] | null
  price_tier: string | null
  date_added: string | null
  created_at: string
}

export async function GET() {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  const adminEmail = process.env.ADMIN_EMAIL
  if (!adminEmail || !user || user.email !== adminEmail) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()

  // Pull stores + the dismissals list in parallel. Dismissals are
  // admin-flagged false-positive clusters (e.g. Gap Inc.'s sub-brands
  // all collapsing to gap.com but actually being distinct brands).
  // The table may not exist yet pre-migration-027 — treat that as
  // "no dismissals" so the panel keeps working.
  const [storesRes, dismissedRes] = await Promise.all([
    service
      .from('stores')
      .select('id, name, website, status, is_active, categories, sub_types, price_tier, date_added, created_at'),
    service
      .from('non_duplicate_clusters')
      .select('normalized_website'),
  ])

  if (storesRes.error) {
    console.error('[admin stores duplicates] load error:', JSON.stringify(storesRes.error))
    return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
  }

  const stores = (storesRes.data ?? []) as StoreRow[]

  const dismissed = new Set<string>()
  if (!dismissedRes.error) {
    for (const d of dismissedRes.data ?? []) {
      if (d.normalized_website) dismissed.add(d.normalized_website)
    }
  } else {
    // 42P01 (raw Postgres) and PGRST205 (PostgREST wrapper) both mean
    // "table missing" → migration 027 not applied. Quietly proceed
    // with empty dismissals. Other errors get logged.
    const code = (dismissedRes.error as { code?: string }).code
    if (code !== '42P01' && code !== 'PGRST205') {
      console.warn(
        '[admin stores duplicates] dismissals load error (continuing):',
        JSON.stringify(dismissedRes.error)
      )
    }
  }

  // Group by normalized website. Skip groups whose key is dismissed.
  const groups = new Map<string, StoreRow[]>()
  for (const s of stores) {
    const key = normalizeRetailerWebsite(s.website)
    if (!key) continue
    if (dismissed.has(key)) continue
    if (!groups.has(key)) groups.set(key, [])
    groups.get(key)!.push(s)
  }

  // Keep only multi-store groups. Bias each group toward the row most
  // likely to be the "good" one — newest + most categories first —
  // so the panel can default-recommend it. Caller still gets the full
  // list and picks freely.
  const clusters = Array.from(groups.entries())
    .filter(([, members]) => members.length >= 2)
    .map(([normalized, members]) => ({
      normalized_website: normalized,
      members: [...members].sort((a, b) => {
        // Active rows ahead of inactive
        if (a.is_active !== b.is_active) return a.is_active ? -1 : 1
        // More categories ahead of fewer
        const ac = a.categories?.length ?? 0
        const bc = b.categories?.length ?? 0
        if (ac !== bc) return bc - ac
        // Then by created_at ascending (older = more established)
        return new Date(a.created_at).getTime() - new Date(b.created_at).getTime()
      }),
    }))
    // Biggest clusters first so user knocks out high-impact ones first
    .sort((a, b) => b.members.length - a.members.length)

  return NextResponse.json({
    clusters,
    cluster_count: clusters.length,
    affected_rows: clusters.reduce((sum, c) => sum + c.members.length, 0),
  })
}
