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

// Dedup key for the send-time collapse below. Gemini is more verbose
// than gpt-4o-mini and will happily extract every mention of a
// free-shipping offer as a separate "deal" (FP Movement standard
// shipping, FP app express shipping, FP Movement standard shipping
// "limited time"…). Those are the same promotion to a reader, so
// collapse them. The key intentionally ignores description — that's
// what was causing the dupes to slip past makeDealKey's hashing.
//
// We DO keep percent_off and promo_code in the key so a 30%-off coupon
// and a 50%-off coupon at the same retailer remain distinct, and so
// two percent-off deals with different codes (e.g. SAVE30 vs APP30)
// both show up.
function dedupKey(d: Deal): string {
  const retailer = normName(d.retailer ?? '')
  const type = d.deal_type ?? 'unknown'
  const pct = d.percent_off ?? 0
  const code = (d.promo_code ?? '').trim().toUpperCase()
  // For "no-quantifier" types like free-shipping, free-item, flash-sale,
  // bogo-*, loyalty: there's nothing meaningful to distinguish two
  // deals with the same retailer + type beyond the promo code, so they
  // collapse aggressively. Percent-based types keep percent in the key.
  const noQuantifier = new Set([
    'free-shipping', 'free-item', 'flash-sale',
    'bogo-free', 'bogo-half', 'loyalty', 'stackable',
  ])
  if (noQuantifier.has(type)) {
    return `${retailer}::${type}::${code}`
  }
  return `${retailer}::${type}::${pct}::${code}`
}

// Collapse near-duplicate deals: keep the newest per dedup key.
// Applied once to the pool so every per-watch section sees the
// deduped set.
function dedupeDeals(deals: Deal[]): Deal[] {
  // Sort newest-first so the first occurrence we keep is the freshest.
  const sorted = [...deals].sort((a, b) => {
    const at = a.created_at ? new Date(a.created_at).getTime() : 0
    const bt = b.created_at ? new Date(b.created_at).getTime() : 0
    return bt - at
  })
  const seen = new Set<string>()
  const out: Deal[] = []
  for (const d of sorted) {
    const k = dedupKey(d)
    if (seen.has(k)) continue
    seen.add(k)
    out.push(d)
  }
  return out
}

// Deal types that survive the min_discount_pct filter regardless of
// their stated percent_off. Non-percent deals (free shipping, BOGO,
// flash sale, free item) are still real deals — the user just hasn't
// said "I only want N% off" about *them*. Filtering them out would
// surprise the user.
const NON_PERCENT_DEAL_TYPES = new Set<string>([
  'free-shipping', 'free-item', 'flash-sale', 'bogo-free', 'bogo-half',
  'loyalty', 'stackable',
])

// Default-suppressed deal types — extracted and stored in the DB but
// NOT shown in the email by default. These types are abundant and
// individually low-value; surfacing each as a full deal block was
// drowning the percent-off deals readers actually care about.
//   - free-shipping : ditto
//   - free-item     : almost always "gift with purchase" / sample
//                     drops; better as a brand-list summary
// Future: opt-in toggles in Personal Shopper Filters will let paid
// users surface these back as a compact brand-list section at the
// bottom of the email. For now they're silently dropped.
const DEFAULT_SUPPRESSED_DEAL_TYPES = new Set<string>([
  'free-shipping', 'free-item',
])
// Description-keyword catch for GWP that the LLM tagged as a different
// type (e.g. flash-sale).
const GWP_DESCRIPTION_RE = /\bgift\s+with\s+purchase\b/i

export async function sendWatchlistEmailForSubscriber(
  service: SupabaseClient,
  appUrl: string,
  subscriber: { id: string; email: string },
): Promise<WatchlistSendResult> {
  // ── Load subscriber-level filters (paid feature) ─────────────────────
  // min_discount_pct + allowed_price_tiers were added in migration 029.
  // Falling back to null/empty if the columns aren't there yet — keeps
  // the send path compatible with pre-migration deployments.
  const { data: subRow } = await service
    .from('subscribers')
    .select('tier, subscription_status, min_discount_pct, allowed_price_tiers, include_free_shipping, include_bogo, include_gwp')
    .eq('id', subscriber.id)
    .single()

  // Only honour the filters when the subscriber is actively paid.
  // Defense in depth — the UI gates writes, but if a free user ever
  // had filters set (e.g. they were paid, set filters, downgraded) we
  // ignore them rather than silently apply.
  const isPaid =
    subRow?.tier === 'paid' &&
    ['active', 'trialing'].includes(subRow.subscription_status ?? '')
  const minDiscount = isPaid ? (subRow?.min_discount_pct ?? null) : null
  const allowedTiers = isPaid
    ? new Set<string>((subRow?.allowed_price_tiers ?? []) as string[])
    : new Set<string>()
  const tierFilterActive = allowedTiers.size > 0 && allowedTiers.size < 4

  // Compact-list opt-ins (migration 031). Free users always see
  // false here — the email skips the "Also Today" section entirely
  // for them. Paid users get their saved preferences.
  const includeFreeShipping = isPaid ? !!subRow?.include_free_shipping : false
  const includeBogo = isPaid ? !!subRow?.include_bogo : false
  const includeGwp = isPaid ? !!subRow?.include_gwp : false
  const anyCompactOptIn = includeFreeShipping || includeBogo || includeGwp

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

  // Dedupe across the WHOLE pool — keep suppressed deals in scope so
  // we can pluck them out for the compact-list opt-ins. Main per-watch
  // sections then filter suppressed types back out.
  const dedupedDeals = dedupeDeals(
    (dealRows ?? []).filter((d): d is Deal => !isJunkDeal(d as Deal))
  )

  const { storeTiers, storeUrls, storeSpendTiers } = await fetchStoreData(appUrl)

  // Helper: a deal is "suppressed" if it's a type we don't show in
  // the main per-watch sections by default (free-shipping, free-item)
  // OR if its description hits the GWP keyword (some retailers tag
  // GWP promos as flash-sale or percent-off).
  const isSuppressed = (d: Deal) =>
    DEFAULT_SUPPRESSED_DEAL_TYPES.has(d.deal_type ?? '') ||
    GWP_DESCRIPTION_RE.test(d.description ?? '')

  // Price-tier filter applies to BOTH main and compact pools — a paid
  // user who's locked their tier to $ shouldn't see $$$$ stores in
  // either bucket.
  const passesTierFilter = (d: Deal) => {
    if (!tierFilterActive) return true
    const retailerKey = (d.retailer ?? '').toLowerCase()
    const tier = storeSpendTiers[retailerKey] || storeSpendTiers[normName(d.retailer ?? '')]
    if (tier && !allowedTiers.has(tier)) return false
    return true
  }

  // Apply min-discount filter only to the main pool. Non-percent
  // deals (BOGO/free-item/free-shipping) pass through regardless —
  // they're filtered into the compact pool by isSuppressed instead.
  const allDeals = dedupedDeals.filter((d) => {
    if (isSuppressed(d)) return false
    if (!passesTierFilter(d)) return false
    if (minDiscount != null) {
      const isNonPercent = NON_PERCENT_DEAL_TYPES.has(d.deal_type ?? '')
      if (!isNonPercent) {
        const pct = d.percent_off ?? 0
        if (pct < minDiscount) return false
      }
    }
    return true
  })

  // Compact pool: only the suppressed types, tier-filtered. The
  // email generator further narrows by which opt-ins the subscriber
  // has flipped on, and by matching brands against their watchlist.
  const suppressedDeals = dedupedDeals.filter(
    (d) => isSuppressed(d) && passesTierFilter(d),
  )

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

  // ── Compact "Also Today" lists ──────────────────────────────────────
  // Build the brand lists for each opted-in deal type from the
  // suppressed pool. A deal qualifies if its retailer matches one of
  // the user's category watches OR their store picks. Free users get
  // an empty CompactBuckets (anyCompactOptIn === false skips the
  // entire section in the generator).
  const watchedSlugs = new Set(watches.map((w) => w.category_slug))
  const pickedStoreNorms = new Set(storePicks.map((sp) => normName(sp.name)))
  const matchesUserWatchlist = (d: Deal) => {
    const retailerNorm = normName(d.retailer ?? '')
    if (retailerNorm && pickedStoreNorms.has(retailerNorm)) return true
    const cats = (d.categories ?? []) as string[]
    return cats.some((c) => watchedSlugs.has(c))
  }

  // Collect unique brand names per bucket. We dedupe by normalized
  // retailer name so "J.Crew" and "J. Crew" don't appear twice.
  const collectBrands = (predicate: (d: Deal) => boolean): string[] => {
    if (!anyCompactOptIn) return []
    const seen = new Set<string>()
    const out: string[] = []
    for (const d of suppressedDeals) {
      if (!matchesUserWatchlist(d)) continue
      if (!predicate(d)) continue
      const key = normName(d.retailer ?? '')
      if (!key || seen.has(key)) continue
      seen.add(key)
      out.push(d.retailer ?? '')
    }
    return out.sort((a, b) => a.localeCompare(b))
  }

  const compactBuckets = {
    free_shipping: includeFreeShipping
      ? collectBrands((d) => d.deal_type === 'free-shipping')
      : null,
    bogo: includeBogo
      ? collectBrands((d) => d.deal_type === 'bogo-free' || d.deal_type === 'bogo-half')
      : null,
    gwp: includeGwp
      ? collectBrands((d) =>
          d.deal_type === 'free-item' ||
          GWP_DESCRIPTION_RE.test(d.description ?? '')
        )
      : null,
  }

  const html = generateWatchlistEmail({
    appUrl,
    watchSections,
    storeUrls,
    compactBuckets,
  })

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
