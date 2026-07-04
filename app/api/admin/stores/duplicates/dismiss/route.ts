// POST /api/admin/stores/duplicates/dismiss
//
// Persistently marks a duplicate-cluster as "not duplicates" so the
// review panel stops showing it. Every pair of the cluster's current
// members is written into stores.unrelated_store_ids (migration 057) —
// the same storage the alias-audit tab uses for its unrelated
// decisions. A new store row joining the same apex domain later WILL
// resurface the cluster, since its pairs are unmarked.
//
// Body: { store_ids: string[] }  (the cluster's member ids, >= 2)
//
// Idempotent — pairs are deduped into the arrays. Admin-gated.

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'
import { orderedStorePair } from '@/lib/brandRelationships'

export const dynamic = 'force-dynamic'

const Body = z.object({
  store_ids: z.array(z.string().uuid()).min(2).max(50),
})

export async function POST(req: NextRequest) {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!user || !isAdminEmail(user.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const parsed = Body.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid body' }, { status: 400 })
  }

  const storeIds = Array.from(new Set(parsed.data.store_ids))
  if (storeIds.length < 2) {
    return NextResponse.json({ error: 'Need at least two distinct stores' }, { status: 400 })
  }

  const service = createServiceClient()
  const { data: rows, error: loadError } = await service
    .from('stores')
    .select('id, unrelated_store_ids')
    .in('id', storeIds)

  if (loadError) {
    const code = (loadError as { code?: string }).code
    if (code === '42703') {
      return NextResponse.json(
        { error: 'unrelated_store_ids column missing — run migration 054 in Supabase' },
        { status: 500 }
      )
    }
    console.error('[duplicates/dismiss] load error:', JSON.stringify(loadError))
    return NextResponse.json({ error: 'Failed to dismiss' }, { status: 500 })
  }

  const byId = new Map(
    ((rows ?? []) as Array<{ id: string; unrelated_store_ids: string[] | null }>).map(
      (row) => [row.id, new Set(row.unrelated_store_ids ?? [])],
    ),
  )
  if (byId.size !== storeIds.length) {
    return NextResponse.json({ error: 'One or more stores not found' }, { status: 404 })
  }

  // Record each pair once, on the ordered-smaller member.
  const dirty = new Set<string>()
  for (let i = 0; i < storeIds.length; i++) {
    for (let j = i + 1; j < storeIds.length; j++) {
      const [holder, other] = orderedStorePair(storeIds[i], storeIds[j])
      const set = byId.get(holder)!
      if (!set.has(other)) {
        set.add(other)
        dirty.add(holder)
      }
    }
  }

  for (const id of dirty) {
    const { error: updateError } = await service
      .from('stores')
      .update({ unrelated_store_ids: [...byId.get(id)!] })
      .eq('id', id)
    if (updateError) {
      console.error('[duplicates/dismiss] save error:', JSON.stringify(updateError))
      return NextResponse.json({ error: 'Failed to dismiss' }, { status: 500 })
    }
  }

  return NextResponse.json({ success: true })
}
