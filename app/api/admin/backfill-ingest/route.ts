// One-off backfill for the Gemini-down window.
//
// During the broken-window period (~May 19 to May 23, 2026), the Gemini
// API was returning 404 for `gemini-2.0-flash` because the model was
// retired for new users. `extractDealsFromEmail` caught the error and
// silently returned [], so every affected email was marked processed
// with zero deals — and the IMAP cursor advanced past them. This
// endpoint re-fetches Gmail by date window (bypassing the cursor),
// finds emails that were marked processed but produced zero deals, and
// re-runs extraction.
//
// Idempotent: relies on the same makeDealKey dedup the cron uses, so
// re-running won't insert duplicate deals.
//
// Delete this file once the recovery is done.
//
// Usage:
//   POST /api/admin/backfill-ingest
//   { "sinceDays": 7, "max": 50 }
//
// Returns: { candidates, processed, new_deals, remaining }
// Call repeatedly until `remaining` is 0.

import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { fetchPromotionalEmails } from '@/lib/gmail'
import { extractDealsFromEmail, type CategoryRow } from '@/lib/openai'
import { getCurrentWeekOf, makeDealKey, isJunkDeal } from '@/lib/deals'
import { fixRetailerCase } from '@/lib/stores'
import { format, subDays } from 'date-fns'
import type { Category } from '@/types'

export const maxDuration = 300

// Same transactional regex the cron uses — keep them in sync. Saves a
// Gemini call on emails we'd extract nothing from anyway.
const TRANSACTIONAL_SUBJECT_RE = /\b(order\s+(confirmation|#\s*\d|number|receipt|summary|update)|your\s+(order|receipt|invoice|shipment|package)|has\s+shipped|order\s+shipped|out\s+for\s+delivery|delivery\s+(update|notification|confirmed|exception)|track\s+(your\s+)?(order|package|shipment)|shipping\s+(update|notification|confirmation)|password\s+reset|verify\s+(your\s+)?email|security\s+(alert|code|notice)|account\s+(update|notice|alert|created|activated))\b/i

function normalizeRetailer(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export async function POST(req: NextRequest) {
  // Admin gate
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  const adminEmail = process.env.ADMIN_EMAIL
  if (!user || !adminEmail || user.email !== adminEmail) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const body = await req.json().catch(() => ({})) as { sinceDays?: number; max?: number }
  const sinceDays = Math.min(Math.max(1, body.sinceDays ?? 7), 30)
  const max = Math.min(Math.max(1, body.max ?? 50), 100)

  const supabase = createServiceClient()
  const weekOf = getCurrentWeekOf()
  const weekOfStr = format(weekOf, 'yyyy-MM-dd')
  const sinceDate = subDays(new Date(), sinceDays)

  try {
    // ── 1. Fetch all emails since the date (no cursor, date-window path) ──
    const tFetchStart = Date.now()
    const fetchResult = await fetchPromotionalEmails(sinceDate)
    const allEmails = fetchResult.messages
    console.log(
      `[backfill] IMAP fetch: ${allEmails.length} messages in ${Date.now() - tFetchStart}ms ` +
        `(since ${sinceDate.toISOString()})`
    )

    if (allEmails.length === 0) {
      return NextResponse.json({ candidates: 0, processed: 0, new_deals: 0, remaining: 0 })
    }

    // ── 2. Find candidates: marked processed but zero deals saved ─────────
    const emailIds = allEmails.map((e) => e.id)

    // PostgREST IN-list limit is generous but page just in case (50-email
    // run × maybe a few hundred fetched = single page is fine).
    const { data: processedRows } = await supabase
      .from('processed_emails')
      .select('email_id')
      .in('email_id', emailIds)
    const processedSet = new Set((processedRows ?? []).map((r) => r.email_id))

    const { data: dealRows } = await supabase
      .from('deals')
      .select('source_email_id')
      .in('source_email_id', emailIds)
    const emailIdsWithDeals = new Set((dealRows ?? []).map((r) => r.source_email_id).filter(Boolean))

    // Candidates: processed-but-empty (the Gemini-down case) OR never-processed.
    // We oldest-first so repeated runs steadily drain instead of churning
    // on the same newest batch.
    const candidates = allEmails
      .filter((e) => !emailIdsWithDeals.has(e.id))
      // Sort by date ascending (oldest first). Date.parse handles RFC 822.
      .sort((a, b) => {
        const da = Date.parse(a.date) || 0
        const db = Date.parse(b.date) || 0
        return da - db
      })

    const candidateCount = candidates.length
    const toProcess = candidates.slice(0, max)
    const remaining = Math.max(0, candidateCount - toProcess.length)

    console.log(
      `[backfill] candidates: ${candidateCount} missing deals ` +
        `(of ${allEmails.length} fetched, ${processedSet.size} were processed) ` +
        `→ processing ${toProcess.length} this run`
    )

    if (toProcess.length === 0) {
      return NextResponse.json({
        candidates: 0,
        processed: 0,
        new_deals: 0,
        remaining: 0,
        fetched: allEmails.length,
      })
    }

    // ── 3. Load supporting data: categories + store directory ─────────────
    const { data: categoryRows } = await supabase
      .from('categories')
      .select('slug, label')
      .eq('is_active', true)
      .order('sort_order')
    const allCategories: CategoryRow[] = categoryRows ?? []

    type StoreLoadRow = { id: string; name: string | null; categories: string[] | null }
    const STORE_PAGE = 1000
    const storeRows: StoreLoadRow[] = []
    for (let p = 0; p < 10; p++) {
      const { data: page } = await supabase
        .from('stores')
        .select('id, name, categories')
        .order('name', { ascending: true })
        .range(p * STORE_PAGE, (p + 1) * STORE_PAGE - 1)
      if (!page || page.length === 0) break
      storeRows.push(...(page as StoreLoadRow[]))
      if (page.length < STORE_PAGE) break
    }
    const storeCategoriesByName = new Map<string, string[]>()
    for (const r of storeRows) {
      if (!r.name) continue
      storeCategoriesByName.set(
        normalizeRetailer(r.name),
        Array.isArray(r.categories) ? r.categories : []
      )
    }

    // Seed dedup with the current week's existing deals so re-extraction
    // doesn't insert duplicates of anything that DID land successfully.
    const { data: existingDealsThisWeek } = await supabase
      .from('deals')
      .select('retailer, deal_type, percent_off, promo_code, description')
      .eq('week_of', weekOfStr)
    const seenDealKeys = new Set(
      (existingDealsThisWeek ?? []).map((d) => makeDealKey(d))
    )

    // ── 4. Process candidates (serial — slower but easier on Gemini's
    //      free-tier rate limits than the cron's concurrency=5) ────────────
    let newDeals = 0
    let processedCount = 0
    let emptyCount = 0

    for (const email of toProcess) {
      try {
        // Transactional fast-path
        if (TRANSACTIONAL_SUBJECT_RE.test(email.subject)) {
          await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
          processedCount++
          continue
        }

        const extracted = await extractDealsFromEmail(
          email.from, email.subject, email.body, allCategories
        )
        console.log(
          `[backfill] ${email.from} | "${email.subject.slice(0, 60)}" | extracted: ${extracted.length}`
        )

        if (extracted.length === 0) emptyCount++

        for (const deal of extracted) {
          if (!deal.description || !deal.retailer) continue
          const retailer = fixRetailerCase(deal.retailer)
          const normalized = { ...deal, retailer }

          if (isJunkDeal(normalized)) continue

          const key = makeDealKey(normalized)
          if (seenDealKeys.has(key)) continue
          seenDealKeys.add(key)

          const storeCats = storeCategoriesByName.get(normalizeRetailer(retailer)) ?? []
          const mergedCategories = Array.from(
            new Set([...(deal.categories ?? []), ...storeCats])
          ) as Category[]

          const { error: insertError } = await supabase.from('deals').insert({
            retailer,
            description: deal.description,
            percent_off: deal.percent_off,
            deal_type: deal.deal_type,
            promo_code: deal.promo_code,
            expiration_date: deal.expiration_date,
            original_link: deal.link || `https://google.com/search?q=${encodeURIComponent(retailer)}`,
            affiliate_link: null,
            categories: mergedCategories,
            deal_subtype: deal.deal_subtype ?? null,
            last_seen_at: new Date().toISOString(),
            week_of: weekOfStr,
            source_email_id: email.id,
            source_email_link: email.viewInBrowserUrl ?? null,
            is_manual: email.isManual,
          })
          if (insertError) {
            console.error('[backfill] deal insert error:', JSON.stringify(insertError))
            continue
          }
          newDeals++
        }

        // Upsert processed_emails so we don't re-pick this email next run.
        await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
        processedCount++
      } catch (err) {
        console.error(`[backfill] error on ${email.id}:`, err)
      }
    }

    return NextResponse.json({
      fetched: allEmails.length,
      candidates: candidateCount,
      processed: processedCount,
      empty_after_extract: emptyCount,
      new_deals: newDeals,
      remaining,
      next_step:
        remaining > 0
          ? `Call again to process the next ${Math.min(max, remaining)} candidates.`
          : 'Backfill complete. You can delete this endpoint.',
    })
  } catch (err) {
    console.error('[backfill] error:', err)
    return NextResponse.json(
      { error: err instanceof Error ? err.message : String(err) },
      { status: 500 }
    )
  }
}
