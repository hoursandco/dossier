// Shared helper for sending a watchlist email to one subscriber.
//
// Used by:
//   - /api/deals/refresh   (on-demand, user-triggered)
//   - /api/cron/weekly     (Thursday cron, all-subscribers)
//
// The watchlist is the union of two things:
//   - category watches (subscriber_watches) — "I'm shopping for Skincare"
//   - store picks       (subscriber_stores) — "I'm watching J.Crew"
// Both produce sections in the email. The empty-watchlist nudge only
// fires when BOTH are empty.
//
// Keeping this in one place means the on-demand and scheduled paths
// can't drift apart.

import { format } from 'date-fns'
import type { Deal } from '@/types'
import type { SupabaseClient } from '@supabase/supabase-js'
import { sendEmail } from '@/lib/resend'
import {
  generateWatchlistEmail,
  generateEmptyWatchlistNudgeEmail,
  type WatchSection,
} from '@/lib/watchlistEmailGenerator'
import { rankDeals, isJunkDeal } from '@/lib/deals'
import { fetchStoreData } from '@/lib/stores'

const LOOKBACK_DAYS = 14
const MAX_DEALS_PER_WATCH = 15

export interface WatchlistSendResult {
  sent: boolean
  reason?: string                 // e.g. 'email_send_failed'
  was_empty_nudge: boolean        // true if subscriber had 0 watches + 0 picks
  watches_count: number           // category watches + store picks
  total_deals: number
  breakdown: Array<{ watch: string; deals: number }>
}

interface WatchRow {
  id: string
  category_slug: string
  sub_type: string | null
  gender: string | null
  min_price_tier: string | null
  category_label: string
}

// Loose retailer/store name match — lowercase, strip non-alphanumerics —
// so "J.Crew" / "J. Crew" / "JCrew" all collapse to the same key.
function normName(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export async function sendWatchlistEmailForSubscriber(
  service: SupabaseClient,
  appUrl: string,
  subscriber: { id: string; email: string },
): Promise<WatchlistSendResult> {
  // ── Load category watches ────────────────────────────────────────────
  const { data: watchRows } = await service
    .from('subscriber_watches')
    .select(`
      id,
      category_slug,
      sub_type,
      gender,
      min_price_tier,
      categories!inner(label)
    `)
    .eq('subscriber_id', subscriber.id)

  const watches: WatchRow[] = (watchRows ?? []).map((w) => {
    const cat = Array.isArray(w.categories) ? w.categories[0] : w.categories
    return {
      id: w.id,
      category_slug: w.category_slug,
      sub_type: w.sub_type,
      gender: w.gender,
      min_price_tier: w.min_price_tier,
      category_label: cat?.label ?? w.category_slug,
    }
  })

  // ── Load store picks ─────────────────────────────────────────────────
  const { data: storeRows, error: storeErr } = await service
    .from('subscriber_stores')
    .select('store_id, stores!inner(id, name)')
    .eq('subscriber_id', subscriber.id)

  if (storeErr) {
    // 42P01 / PGRST205 = subscriber_stores table missing (migration 028
    // not applied). Degrade to category-only rather than crash.
    console.warn('[watchlistSend] store-picks load failed:', JSON.stringify(storeErr))
  }

  type PickedStore = { id: string; name: string }
  const storePicks: PickedStore[] = (storeRows ?? [])
    .map((r) => {
      const s = Array.isArray(r.stores) ? r.stores[0] : r.stores
      return s as PickedStore | undefined
    })
    .filter((s): s is PickedStore => !!s && !!s.name)

  // ── Both empty → send the nudge email ────────────────────────────────
  if (watches.length === 0 && storePicks.length === 0) {
    const html = generateEmptyWatchlistNudgeEmail({ appUrl })
    const result = await sendEmail({
      to: subscriber.email,
      subject: 'Tell us what you’re shopping for',
      html,
    })
    return {
      sent: !!result,
      reason: result ? undefined : 'email_send_failed',
      was_empty_nudge: true,
      watches_count: 0,
      total_deals: 0,
      breakdown: [],
    }
  }

  // ── Pull recent non-expired deals once, filter per-watch in memory ──
  const sinceIso = new Date(Date.now() - LOOKBACK_DAYS * 24 * 60 * 60 * 1000).toISOString()
  const today = format(new Date(), 'yyyy-MM-dd')

  const { data: dealRows } = await service
    .from('deals')
    .select('*')
    .gte('created_at', sinceIso)
    .or(`expiration_date.is.null,expiration_date.gte.${today}`)

  const allDeals = (dealRows ?? []).filter((d): d is Deal => !isJunkDeal(d as Deal))

  const { storeTiers } = await fetchStoreData(appUrl)

  // ── Category sections: deals whose categories include the watch slug ──
  const categorySections: WatchSection[] = watches.map((w) => {
    const matching = allDeals.filter((d) => {
      const cats = (d.categories ?? []) as string[]
      if (!cats.includes(w.category_slug)) return false
      if (w.sub_type && d.deal_subtype !== w.sub_type) return false
      return true
    })
    const ranked = rankDeals(matching, storeTiers).slice(0, MAX_DEALS_PER_WATCH)
    const label = w.sub_type
      ? `${w.category_label} — ${w.sub_type}`
      : w.category_label
    return { label, deals: ranked }
  })

  // ── Store-pick sections: deals whose retailer matches the picked store ─
  const storeSections: WatchSection[] = storePicks.map((sp) => {
    const target = normName(sp.name)
    const matching = allDeals.filter((d) => d.retailer && normName(d.retailer) === target)
    const ranked = rankDeals(matching, storeTiers).slice(0, MAX_DEALS_PER_WATCH)
    return { label: sp.name, deals: ranked }
  })

  const watchSections: WatchSection[] = [...categorySections, ...storeSections]

  const totalDeals = watchSections.reduce((sum, s) => sum + s.deals.length, 0)
  const html = generateWatchlistEmail({ appUrl, watchSections })

  const result = await sendEmail({
    to: subscriber.email,
    subject: totalDeals > 0
      ? `${totalDeals} ${totalDeals === 1 ? 'deal' : 'deals'} for your watchlist`
      : 'Still watching your watchlist',
    html,
  })

  // ── Bump per-watch last_email_sent_at on success ─────────────────────
  // Only category watches carry this column; store picks don't track it.
  if (result && watches.length > 0) {
    const nowIso = new Date().toISOString()
    await service
      .from('subscriber_watches')
      .update({ last_email_sent_at: nowIso })
      .in('id', watches.map((w) => w.id))
  }

  return {
    sent: !!result,
    reason: result ? undefined : 'email_send_failed',
    was_empty_nudge: false,
    watches_count: watches.length + storePicks.length,
    total_deals: totalDeals,
    breakdown: watchSections.map((s) => ({ watch: s.label, deals: s.deals.length })),
  }
}
