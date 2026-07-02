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
  const { data, error } = await service
    .from('brand_relationship_reviews')
    .upsert({
      store_a_id: storeAId,
      store_b_id: storeBId,
      decision,
      parent_store_id: parentStoreId,
      child_store_id: childStoreId,
      reviewed_by_email: user?.email ?? null,
      updated_at: new Date().toISOString(),
    }, { onConflict: 'store_a_id,store_b_id' })
    .select('store_a_id, store_b_id, decision, parent_store_id, child_store_id, updated_at')
    .single()

  if (error) {
    const code = (error as { code?: string }).code
    if (code === '42P01' || code === 'PGRST205') {
      return NextResponse.json(
        { error: 'Brand relationship table is not installed yet. Run migration 044.' },
        { status: 503 },
      )
    }
    console.error('[alias audit review] save error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to save review' }, { status: 500 })
  }

  return NextResponse.json({ review: data })
}
