// POST /api/admin/deals/repair-links
//
// One-shot repair pass. Walks every deal whose original_link is the
// "google.com/search?q=..." fallback we used when the LLM didn't extract
// a link from the email body, and replaces it with the matching store's
// website. Deals from brands not in the stores table are left as-is.
//
// Idempotent: safe to re-run after adding more stores to the directory.
// Admin-gated.

import { NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'
export const maxDuration = 60

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

  // Pull every deal with the Google-search fallback link.
  const { data: badDeals, error: dealsErr } = await service
    .from('deals')
    .select('id, retailer, original_link')
    .like('original_link', 'https://google.com/search?q=%')

  if (dealsErr) {
    return NextResponse.json({ error: 'Failed to load deals', detail: dealsErr.message }, { status: 500 })
  }
  if (!badDeals || badDeals.length === 0) {
    return NextResponse.json({ repaired: 0, message: 'No deals with Google fallback links' })
  }

  // Build retailer→website lookup from stores.
  const { data: stores, error: storesErr } = await service
    .from('stores')
    .select('name, website')
  if (storesErr) {
    return NextResponse.json({ error: 'Failed to load stores', detail: storesErr.message }, { status: 500 })
  }
  const websiteByName = new Map<string, string>()
  for (const s of stores ?? []) {
    if (!s.name || !s.website) continue
    websiteByName.set(normalizeRetailer(s.name), s.website)
  }

  // Batch the updates per retailer rather than per row — most retailers
  // have many deals and we'd rather do one UPDATE per brand than N.
  const updatesByRetailer = new Map<string, string>()
  let matched = 0
  let unmatched = 0
  for (const d of badDeals) {
    const site = websiteByName.get(normalizeRetailer(d.retailer))
    if (site) {
      updatesByRetailer.set(d.retailer, site)
      matched++
    } else {
      unmatched++
    }
  }

  let repaired = 0
  for (const [retailer, website] of updatesByRetailer) {
    const { error: updErr, count } = await service
      .from('deals')
      .update({ original_link: website }, { count: 'exact' })
      .eq('retailer', retailer)
      .like('original_link', 'https://google.com/search?q=%')
    if (updErr) {
      console.error(`[repair-links] update failed for ${retailer}:`, JSON.stringify(updErr))
      continue
    }
    repaired += count ?? 0
  }

  return NextResponse.json({
    total_bad_deals: badDeals.length,
    matched_to_store: matched,
    unmatched_brands: unmatched,
    rows_repaired: repaired,
    retailers_updated: updatesByRetailer.size,
  })
}
