// GET /api/stores/watch-counts
//
// Aggregate metric for the public /stores browse page. Returns two
// maps keyed by store_id:
//
//   total — cumulative count of subscribers watching that store.
//           Drives "sort by most-watched."
//
//   week  — count of subscriber_stores rows created in the last 7
//           days. Drives the "Popular this week" callout — captures
//           current momentum rather than all-time leaders.
//
// Public endpoint (no auth). Aggregate counts only — never returns
// subscriber identities. Cached 5 minutes since these counts don't
// change minute-by-minute and the browse page is read-heavy.

import { NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const revalidate = 300 // 5 min server-side cache

export async function GET() {
  const service = createServiceClient()

  // Pull ONLY the store_id + created_at columns — that's all we need
  // for both aggregations. Should be a quick scan even at scale.
  const { data: rows, error } = await service
    .from('subscriber_stores')
    .select('store_id, created_at')

  if (error) {
    // subscriber_stores table missing (pre-migration-028) — return
    // empty maps so the browse page still renders without exploding.
    const code = (error as { code?: string }).code
    if (code === '42P01' || code === 'PGRST205') {
      return NextResponse.json({ total: {}, week: {} })
    }
    console.error('[stores/watch-counts] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to load counts' }, { status: 500 })
  }

  const sevenDaysAgo = Date.now() - 7 * 24 * 60 * 60 * 1000
  const total: Record<string, number> = {}
  const week: Record<string, number> = {}

  for (const r of rows ?? []) {
    const sid = r.store_id as string
    if (!sid) continue
    total[sid] = (total[sid] ?? 0) + 1
    const createdMs = new Date(r.created_at as string).getTime()
    if (createdMs >= sevenDaysAgo) {
      week[sid] = (week[sid] ?? 0) + 1
    }
  }

  return NextResponse.json({ total, week })
}
