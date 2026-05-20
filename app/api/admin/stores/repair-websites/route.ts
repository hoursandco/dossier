// POST /api/admin/stores/repair-websites?limit=N&offset=N
//
// Walks a slice of stores and runs each `website` through
// normalizeRetailerWebsite. If the normalized form differs from the
// stored value, updates the row.
//
// Why batched: at ~1700+ stores we can't repair them all in one request
// — Vercel kills serverless functions at 5 min (we set maxDuration to
// 300) and even within that window, sequential UPDATEs to Supabase
// would take too long. So:
//
//   - Server: process up to `limit` rows per call with parallel
//     UPDATEs (CONCURRENCY=8). Returns counts + remaining-after-this-batch.
//   - Client: loops, calling this endpoint repeatedly until remaining=0
//     or the batch did zero useful work.
//
// Idempotent — re-running it does nothing once everything's clean.
// Admin-gated. Conflict-safe: if the cleaned URL collides with another
// store's website (unique index), we skip that row and report it.

import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { normalizeRetailerWebsite } from '@/lib/domainNormalize'

export const dynamic = 'force-dynamic'
export const maxDuration = 300

const CONCURRENCY = 8

async function runWithConcurrency<T>(
  items: T[],
  concurrency: number,
  worker: (item: T) => Promise<void>
): Promise<void> {
  let index = 0
  const next = async (): Promise<void> => {
    while (true) {
      const i = index++
      if (i >= items.length) return
      try {
        await worker(items[i])
      } catch (err) {
        console.error(`[repair-websites] worker error on item ${i}:`, err)
      }
    }
  }
  await Promise.all(
    Array.from({ length: Math.min(concurrency, items.length) }, () => next())
  )
}

export async function POST(req: NextRequest) {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  const adminEmail = process.env.ADMIN_EMAIL
  if (!adminEmail || !user || user.email !== adminEmail) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const url = new URL(req.url)
  const limit = Math.max(1, Math.min(500, Number(url.searchParams.get('limit')) || 200))
  const offset = Math.max(0, Number(url.searchParams.get('offset')) || 0)

  const service = createServiceClient()

  // Total count for the "remaining" calculation. Cheap (covered by PK).
  const { count: totalCount, error: countErr } = await service
    .from('stores')
    .select('id', { count: 'exact', head: true })
  if (countErr) {
    console.error('[repair-websites] count error:', JSON.stringify(countErr))
    return NextResponse.json({ error: 'Failed to count stores' }, { status: 500 })
  }
  const total = totalCount ?? 0

  // Stable ordering for pagination — created_at + id breaks ties so
  // the same row never gets visited twice across batches.
  const { data: stores, error } = await service
    .from('stores')
    .select('id, name, website')
    .order('created_at', { ascending: true })
    .order('id', { ascending: true })
    .range(offset, offset + limit - 1)

  if (error) {
    console.error('[repair-websites] load error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
  }
  if (!stores || stores.length === 0) {
    return NextResponse.json({
      scanned: 0,
      repaired: 0,
      conflicts: 0,
      unparseable: 0,
      remaining: 0,
      next_offset: offset,
    })
  }

  let repaired = 0
  let conflicts = 0
  let unparseable = 0
  const conflictExamples: Array<{ name: string; from: string; to: string }> = []
  const unparseableExamples: Array<{ name: string; current: string }> = []

  await runWithConcurrency(stores, CONCURRENCY, async (s) => {
    if (!s.website) return
    const normalized = normalizeRetailerWebsite(s.website)
    if (!normalized) {
      unparseable++
      if (unparseableExamples.length < 10) {
        unparseableExamples.push({ name: s.name, current: s.website })
      }
      return
    }
    if (s.website === normalized) return

    const { error: updErr } = await service
      .from('stores')
      .update({ website: normalized })
      .eq('id', s.id)
    if (updErr) {
      // 23505 = unique constraint on website. Another store already
      // owns the cleaned domain — skip + report.
      const code = (updErr as { code?: string }).code
      if (code === '23505') {
        conflicts++
        if (conflictExamples.length < 10) {
          conflictExamples.push({ name: s.name, from: s.website, to: normalized })
        }
        return
      }
      console.error(`[repair-websites] update error for ${s.name}:`, JSON.stringify(updErr))
      return
    }
    repaired++
  })

  // The next offset = wherever we left off in the ordered table.
  // remaining is how many we haven't visited yet.
  const nextOffset = offset + stores.length
  const remaining = Math.max(0, total - nextOffset)

  return NextResponse.json({
    scanned: stores.length,
    repaired,
    conflicts,
    unparseable,
    remaining,
    next_offset: nextOffset,
    total,
    conflict_examples: conflictExamples,
    unparseable_examples: unparseableExamples,
  })
}
