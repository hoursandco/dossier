import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createServiceClient } from '@/lib/supabase/server'

const SubscribeSchema = z.object({
  email: z.string().email(),
  zip_code: z.string().optional(),
  // Optional list of category slugs to pre-populate the subscriber's
  // watchlist with. Sent from the homepage picker when the user picks
  // categories. Existing subscribers can resubmit; duplicates ignored.
  watches: z.array(z.string().min(1)).max(20).optional(),
  // Optional list of store UUIDs — the homepage picker's brand picks.
  // Seeded into subscriber_stores the same way watches seed
  // subscriber_watches, so an anonymous picker submit creates the
  // whole watchlist in one call.
  store_ids: z.array(z.string().uuid()).max(50).optional(),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const parsed = SubscribeSchema.safeParse(body)

    if (!parsed.success) {
      return NextResponse.json({ error: 'Invalid email address' }, { status: 400 })
    }

    const { email, zip_code, watches, store_ids } = parsed.data
    const supabase = createServiceClient()

    // Upsert subscriber
    const { data: subscriber, error: subError } = await supabase
      .from('subscribers')
      .upsert(
        {
          email,
          zip_code: zip_code || null,
          is_active: true,
          updated_at: new Date().toISOString(),
        },
        { onConflict: 'email', ignoreDuplicates: false }
      )
      .select()
      .single()

    if (subError) {
      console.error('Subscribe error:', subError)
      return NextResponse.json({ error: 'Failed to subscribe' }, { status: 500 })
    }

    const subId = subscriber.id

    // Seed watchlist from the signup picker. Filter against the
    // categories table so an attacker can't inject arbitrary slugs.
    if (watches && watches.length > 0) {
      const { data: validCats } = await supabase
        .from('categories')
        .select('slug')
        .in('slug', watches)
        .eq('is_active', true)
      const validSlugs = new Set((validCats ?? []).map((c) => c.slug))
      const watchRows = watches
        .filter((slug) => validSlugs.has(slug))
        .map((slug) => ({ subscriber_id: subId, category_slug: slug }))
      if (watchRows.length > 0) {
        await supabase
          .from('subscriber_watches')
          .upsert(watchRows, {
            onConflict: 'subscriber_id,category_slug,sub_type,gender,min_price_tier',
            ignoreDuplicates: true,
          })
      }
    }

    // Seed store picks from the homepage picker. Validate against the
    // stores table so an attacker can't inject arbitrary UUIDs, and
    // skip 'declined' brands. Best-effort: if subscriber_stores doesn't
    // exist yet (migration 028 not applied) the error is swallowed so
    // signup still succeeds.
    if (store_ids && store_ids.length > 0) {
      const { data: validStores } = await supabase
        .from('stores')
        .select('id')
        .in('id', store_ids)
        .neq('status', 'declined')
      const validStoreIds = new Set((validStores ?? []).map((s) => s.id))
      const storeRows = store_ids
        .filter((id) => validStoreIds.has(id))
        .map((id) => ({ subscriber_id: subId, store_id: id }))
      if (storeRows.length > 0) {
        const { error: storeErr } = await supabase
          .from('subscriber_stores')
          .upsert(storeRows, { onConflict: 'subscriber_id,store_id', ignoreDuplicates: true })
        if (storeErr) {
          console.error('subscribe store-picks error:', JSON.stringify(storeErr))
        }
      }
    }

    return NextResponse.json({ success: true, subscriber_id: subId })
  } catch (err) {
    console.error('Subscribe handler error:', err)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
