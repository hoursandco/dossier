// POST /api/admin/deals/purge-broken-links
//
// Companion to /api/admin/deals/repair-links. That endpoint fixes deals
// where we CAN look up the brand's real website in the stores table.
// This one deletes deals where we can't — the historical residue from
// before the ingest started auto-creating store rows.
//
// Scope: rows with original_link LIKE 'https://google.com/search?q=%'
// whose normalized retailer name has no match in stores.name.
//
// These deals are not customer-visible (the watchlist email's 7-day
// lookback excludes anything this old) so deletion is a pure DB-hygiene
// pass. Stores table is untouched.
//
// Idempotent — re-running it on an already-clean DB returns deleted=0.
// Admin-gated.

import { NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'
export const maxDuration = 60

// Same normalization the repair endpoint uses — keeps "J. Crew" and
// "jcrew" matching the same store row.
function normalizeRetailer(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export async function POST() {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()

  // Pull every deal still holding a google-search fallback link.
  const { data: badDeals, error: dealsErr } = await service
    .from('deals')
    .select('id, retailer')
    .like('original_link', 'https://google.com/search?q=%')

  if (dealsErr) {
    return NextResponse.json(
      { error: 'Failed to load deals', detail: dealsErr.message },
      { status: 500 }
    )
  }
  if (!badDeals || badDeals.length === 0) {
    return NextResponse.json({ scanned: 0, deleted: 0, kept: 0 })
  }

  // Build the set of normalized store names for matching.
  const { data: stores, error: storesErr } = await service
    .from('stores')
    .select('name')
  if (storesErr) {
    return NextResponse.json(
      { error: 'Failed to load stores', detail: storesErr.message },
      { status: 500 }
    )
  }
  const knownNames = new Set<string>()
  for (const s of stores ?? []) {
    if (s.name) knownNames.add(normalizeRetailer(s.name))
  }

  // Partition: anything with a matching store is "kept" (repair-links
  // would have fixed it). Anything without is queued for deletion.
  const toDeleteIds: string[] = []
  let kept = 0
  for (const d of badDeals) {
    if (knownNames.has(normalizeRetailer(d.retailer))) {
      kept++
    } else {
      toDeleteIds.push(d.id)
    }
  }

  if (toDeleteIds.length === 0) {
    return NextResponse.json({ scanned: badDeals.length, deleted: 0, kept })
  }

  // Bulk delete in chunks — PostgREST has a URL length limit and
  // 1k+ UUIDs in an .in() filter can overrun it.
  const CHUNK = 200
  let deleted = 0
  for (let i = 0; i < toDeleteIds.length; i += CHUNK) {
    const slice = toDeleteIds.slice(i, i + CHUNK)
    const { error: delErr, count } = await service
      .from('deals')
      .delete({ count: 'exact' })
      .in('id', slice)
    if (delErr) {
      console.error('[purge-broken-links] delete chunk error:', JSON.stringify(delErr))
      return NextResponse.json(
        {
          error: 'Failed mid-delete',
          scanned: badDeals.length,
          deleted_so_far: deleted,
          kept,
        },
        { status: 500 }
      )
    }
    deleted += count ?? 0
  }

  return NextResponse.json({
    scanned: badDeals.length,
    deleted,
    kept,
  })
}
