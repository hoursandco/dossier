// GET  /api/store-picks  — list signed-in subscriber's picked stores
// POST /api/store-picks  — add a store pick
//   Body: { store_id: uuid }
//
// Counterpart to /api/watches but for individual brands instead of
// categories. The free-tier 3-pick limit is shared across BOTH tables
// (watches + store_picks combined). Paid (or comped) is unlimited.

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isPaidSubscriber } from '@/lib/subscriberTier'
import { countTotalPicks, FREE_PICK_LIMIT } from '@/lib/pickLimits'

export const dynamic = 'force-dynamic'

async function loadSubscriberId(email: string): Promise<string | null> {
  const service = createServiceClient()
  const { data } = await service
    .from('subscribers')
    .select('id')
    .eq('email', email)
    .single()
  return data?.id ?? null
}

export async function GET() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const subscriberId = await loadSubscriberId(user.email)
  if (!subscriberId) {
    return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
  }

  const service = createServiceClient()
  // JOIN stores so the client gets ready-to-render fields (name,
  // website, categories) instead of having to do a second fetch.
  const { data: rows, error } = await service
    .from('subscriber_stores')
    .select(`
      id,
      store_id,
      created_at,
      stores!inner(id, name, website, categories, price_tier)
    `)
    .eq('subscriber_id', subscriberId)
    .order('created_at', { ascending: false })

  if (error) {
    // 42P01 = subscriber_stores table missing → migration 028 not applied.
    // 42703 = column missing in subscribers (rare). Surface clean error.
    const code = (error as { code?: string }).code
    if (code === '42P01' || code === 'PGRST205') {
      console.warn('[store-picks GET] subscriber_stores table missing — returning empty. Run migration 028.')
      return NextResponse.json({ store_picks: [] })
    }
    console.error('[store-picks GET] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to load store picks' }, { status: 500 })
  }

  const picks = (rows ?? []).map((r) => {
    // Supabase returns the joined row as either an object or an
    // array of one depending on the relationship cardinality — handle
    // both so we don't crash on schema-cache quirks.
    type StoreRow = { id: string; name: string; website: string; categories: string[] | null; price_tier: string | null }
    const storeArr = r.stores as StoreRow | StoreRow[]
    const store: StoreRow | undefined = Array.isArray(storeArr) ? storeArr[0] : storeArr
    return {
      id: r.id,
      store_id: r.store_id,
      created_at: r.created_at,
      store_name: store?.name ?? '',
      website: store?.website ?? '',
      categories: store?.categories ?? [],
      price_tier: store?.price_tier ?? null,
    }
  })

  return NextResponse.json({ store_picks: picks })
}

const Body = z.object({
  store_id: z.string().uuid(),
})

export async function POST(req: NextRequest) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const parsed = Body.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid body' }, { status: 400 })
  }

  const subscriberId = await loadSubscriberId(user.email)
  if (!subscriberId) {
    return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
  }

  const service = createServiceClient()

  // Free-tier limit shared across watches + store picks.
  const { data: tierRow } = await service
    .from('subscribers')
    .select('tier, is_comped')
    .eq('id', subscriberId)
    .single()
  const isFreeTier = !isPaidSubscriber(tierRow)
  if (isFreeTier) {
    const total = await countTotalPicks(service, subscriberId)
    if (total >= FREE_PICK_LIMIT) {
      return NextResponse.json(
        {
          error: `Free tier is limited to ${FREE_PICK_LIMIT} total picks across categories and stores. Remove one or upgrade for unlimited.`,
          over_limit: true,
          current_picks: total,
          allowed_picks: FREE_PICK_LIMIT,
          upgrade_url: '/pricing',
        },
        { status: 403 }
      )
    }
  }

  // Verify the store exists + is reachable (not declined). We allow
  // pending/no_email/auto_added so subscribers can opt into brands
  // that aren't fully active yet — first deal triggers auto-activation.
  const { data: store } = await service
    .from('stores')
    .select('id, status')
    .eq('id', parsed.data.store_id)
    .single()
  if (!store || store.status === 'declined') {
    return NextResponse.json({ error: 'Unknown or unavailable store' }, { status: 400 })
  }

  const { data: inserted, error } = await service
    .from('subscriber_stores')
    .insert({
      subscriber_id: subscriberId,
      store_id: parsed.data.store_id,
    })
    .select('id, store_id, created_at')
    .single()

  if (error) {
    // 23505 = unique violation → duplicate pick. Friendly response.
    if ((error as { code?: string }).code === '23505') {
      return NextResponse.json(
        { error: "You're already watching that store." },
        { status: 409 }
      )
    }
    if ((error as { code?: string }).code === '42P01') {
      return NextResponse.json(
        { error: 'subscriber_stores table missing — run migration 028' },
        { status: 500 }
      )
    }
    console.error('[store-picks POST] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to add store pick' }, { status: 500 })
  }

  return NextResponse.json({ store_pick: inserted })
}
