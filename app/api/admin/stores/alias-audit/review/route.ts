import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'
import { orderedStorePair } from '@/lib/brandRelationships'

export const dynamic = 'force-dynamic'

const Body = z.object({
  left_store_id: z.string().uuid(),
  right_store_id: z.string().uuid(),
  decision: z.enum(['unrelated', 'parent_child', 'equivalent']),
  parent_store_id: z.string().uuid().nullable().optional(),
})

type StoreRelRow = {
  id: string
  parent_store_id: string | null
  alias_of_store_id: string | null
  unrelated_store_ids: string[] | null
}

// Brand relationships live as columns on stores (migration 054):
//   parent_child → child.parent_store_id = parent
//   equivalent   → the lexicographically-larger id points at the smaller
//                  via alias_of_store_id (matching the 054 backfill)
//   unrelated    → the smaller id records the pair in unrelated_store_ids
// A new decision for a pair first clears whatever the pair had before, so
// re-reviewing flips cleanly between decisions.
export async function POST(request: NextRequest) {
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const parsed = Body.safeParse(await request.json().catch(() => null))
  if (!parsed.success || parsed.data.left_store_id === parsed.data.right_store_id) {
    return NextResponse.json({ error: 'Invalid review decision' }, { status: 400 })
  }

  const { left_store_id, right_store_id, decision } = parsed.data
  const [storeAId, storeBId] = orderedStorePair(left_store_id, right_store_id)
  let parentStoreId: string | null = null
  let childStoreId: string | null = null

  if (decision === 'parent_child') {
    parentStoreId = parsed.data.parent_store_id ?? null
    if (parentStoreId !== left_store_id && parentStoreId !== right_store_id) {
      return NextResponse.json({ error: 'Choose one of the two brands as parent' }, { status: 400 })
    }
    childStoreId = parentStoreId === left_store_id ? right_store_id : left_store_id
  }

  const service = createServiceClient()
  const { data: storeRows, error: loadError } = await service
    .from('stores')
    .select('id, parent_store_id, alias_of_store_id, unrelated_store_ids')
    .in('id', [storeAId, storeBId])

  if (loadError) {
    const code = (loadError as { code?: string }).code
    if (code === '42703') {
      return NextResponse.json(
        { error: 'Brand relationship columns are not installed yet. Run migration 054.' },
        { status: 503 },
      )
    }
    console.error('[alias audit review] load error:', JSON.stringify(loadError))
    return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
  }

  const rows = (storeRows ?? []) as StoreRelRow[]
  const storeA = rows.find((row) => row.id === storeAId)
  const storeB = rows.find((row) => row.id === storeBId)
  if (!storeA || !storeB) {
    return NextResponse.json({ error: 'Store not found' }, { status: 404 })
  }

  // Start from the pair's slate wiped clean, then layer the new decision on.
  const nextA: StoreRelRow = {
    ...storeA,
    parent_store_id: storeA.parent_store_id === storeBId ? null : storeA.parent_store_id,
    alias_of_store_id: storeA.alias_of_store_id === storeBId ? null : storeA.alias_of_store_id,
    unrelated_store_ids: (storeA.unrelated_store_ids ?? []).filter((id) => id !== storeBId),
  }
  const nextB: StoreRelRow = {
    ...storeB,
    parent_store_id: storeB.parent_store_id === storeAId ? null : storeB.parent_store_id,
    alias_of_store_id: storeB.alias_of_store_id === storeAId ? null : storeB.alias_of_store_id,
    unrelated_store_ids: (storeB.unrelated_store_ids ?? []).filter((id) => id !== storeAId),
  }

  if (decision === 'parent_child') {
    const child = childStoreId === storeAId ? nextA : nextB
    child.parent_store_id = parentStoreId
  } else if (decision === 'equivalent') {
    nextB.alias_of_store_id = storeAId
  } else {
    nextA.unrelated_store_ids = [...(nextA.unrelated_store_ids ?? []), storeBId]
  }

  for (const next of [nextA, nextB]) {
    const { error: updateError } = await service
      .from('stores')
      .update({
        parent_store_id: next.parent_store_id,
        alias_of_store_id: next.alias_of_store_id,
        unrelated_store_ids: next.unrelated_store_ids ?? [],
      })
      .eq('id', next.id)
    if (updateError) {
      console.error('[alias audit review] save error:', JSON.stringify(updateError))
      return NextResponse.json({ error: 'Failed to save review' }, { status: 500 })
    }
  }

  return NextResponse.json({
    review: {
      store_a_id: storeAId,
      store_b_id: storeBId,
      decision,
      parent_store_id: parentStoreId,
      child_store_id: childStoreId,
      updated_at: new Date().toISOString(),
    },
  })
}
