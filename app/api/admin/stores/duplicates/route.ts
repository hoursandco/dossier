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
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'
export const maxDuration = 60

type StoreRow = {
  id: string
  name: string
  website: string | null
  status: string | null
  is_active: boolean
  categories: string[] | null
  price_tier: string | null
  date_added: string | null
  created_at: string
  unrelated_store_ids: string[] | null
}

export async function GET() {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()

  // Dismissals ("these rows are genuinely distinct brands") live as
  // pairwise entries in stores.unrelated_store_ids (migration 057) —
  // shared with the alias-audit tab's unrelated decisions.
  const storesRes = await service
    .from('stores')
    .select('id, name, website, status, is_active, categories, price_tier, date_added, created_at, unrelated_store_ids')

  if (storesRes.error) {
    console.error('[admin stores duplicates] load error:', JSON.stringify(storesRes.error))
    return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
  }

  const stores = (storesRes.data ?? []) as StoreRow[]

  // Symmetric pair lookup — a dismissal counts no matter which of the
  // two rows carries it.
  const unrelatedPairs = new Set<string>()
  for (const s of stores) {
    for (const other of s.unrelated_store_ids ?? []) {
      unrelatedPairs.add([s.id, other].sort().join('::'))
    }
  }
  const pairDismissed = (a: string, b: string) =>
    unrelatedPairs.has([a, b].sort().join('::'))

  // Group by normalized website.
  const groups = new Map<string, StoreRow[]>()
  for (const s of stores) {
    const key = normalizeRetailerWebsite(s.website)
    if (!key) continue
    if (!groups.has(key)) groups.set(key, [])
    groups.get(key)!.push(s)
  }

  // Keep only multi-store groups where at least one pair is still
  // unreviewed — a cluster whose every pair has been marked unrelated is
  // dismissed. A new row joining the apex later resurfaces the cluster,
  // since its pairs are unmarked.
  const clusterDismissed = (members: StoreRow[]) => {
    for (let i = 0; i < members.length; i++) {
      for (let j = i + 1; j < members.length; j++) {
        if (!pairDismissed(members[i].id, members[j].id)) return false
      }
    }
    return true
  }

  // Bias each group toward the row most likely to be the "good" one —
  // newest + most categories first — so the panel can default-recommend
  // it. Caller still gets the full list and picks freely.
  const clusters = Array.from(groups.entries())
    .filter(([, members]) => members.length >= 2 && !clusterDismissed(members))
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
