import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { fetchPromotionalEmails } from '@/lib/gmail'
import {
  extractDealsFromEmail,
  extractDealsFromEmailImages,
  getRetailerCategories,
  type CategoryRow,
} from '@/lib/openai'
import { getCurrentWeekOf, makeDealKey, isJunkDeal } from '@/lib/deals'
import { fixRetailerCase } from '@/lib/stores'
import { sendAdminAlert } from '@/lib/resend'
import { format, subHours } from 'date-fns'
import type { Category } from '@/types'

export const dynamic = 'force-dynamic'

export const maxDuration = 300 // 5 minute max

// Extract display name from "Store Name <email@domain.com>" format
function parseSenderName(from: string): string {
  const match = from.match(/^([^<]+)</)
  if (match) return match[1].trim()
  return from.split('@')[0].trim()
}

// Extract the apex domain from a sender ("From: Best Buy
// <hello@emails.bestbuy.com>" → "bestbuy.com"). Used as the website
// when auto-creating an unknown store row — stores.website is NOT
// NULL and has a case-insensitive unique index, so we need a stable
// per-brand key. Strips common marketing-email subdomain prefixes
// (mail., emails., news., m., etc.) so different ESP-routing
// subdomains for the same brand collapse to one apex.
function parseSenderDomain(from: string): string | null {
  const m = from.match(/@([a-zA-Z0-9.-]+)/)
  if (!m) return null
  let domain = m[1].toLowerCase().replace(/[>\s]+$/, '')
  domain = domain.replace(
    /^(mail|emails?|e|news|m|t|info|hello|noreply|no-reply|do-not-reply|donotreply|update|updates|sale|sales|promo|promos|promotion|promotions|marketing|hi|inbox|shop|store|account|alerts?|offers?|reply|membership|service|order|orders|support|deals|news)\./,
    '',
  )
  // Bail on anything that doesn't look like a real domain (no dot,
  // single-label, etc.) — better to skip auto-add than seed garbage.
  if (!domain.includes('.') || domain.length < 4) return null
  return domain
}

// Normalize a retailer name for fuzzy matching against stores.name.
// Lowercases and strips everything that isn't a letter or digit, so
// "J.Crew", "J. Crew", and "jcrew" all collapse to "jcrew".
function normalizeRetailer(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

// Quickly skip obvious transactional emails before hitting OpenAI.
// These will never contain deals worth publishing.
const TRANSACTIONAL_SUBJECT_RE = /\b(order\s+(confirmation|#\s*\d|number|receipt|summary|update)|your\s+(order|receipt|invoice|shipment|package)|has\s+shipped|order\s+shipped|out\s+for\s+delivery|delivery\s+(update|notification|confirmed|exception)|track\s+(your\s+)?(order|package|shipment)|shipping\s+(update|notification|confirmation)|password\s+reset|verify\s+(your\s+)?email|security\s+(alert|code|notice)|account\s+(update|notice|alert|created|activated))\b/i

function isTransactionalEmail(subject: string): boolean {
  return TRANSACTIONAL_SUBJECT_RE.test(subject)
}

// Process emails concurrently so the cron doesn't time out on large inboxes.
// Tunable via INGEST_CONCURRENCY env var; default 5 keeps us comfortably under
// OpenAI's 200K tokens-per-minute cap on gpt-4o-mini.
const INGEST_CONCURRENCY = Math.max(
  1,
  Number(process.env.INGEST_CONCURRENCY) || 5
)

// Hard cap on emails processed per run. Vercel's serverless function limit is
// 5 minutes; a fresh inbox with weeks of accumulated subs can have hundreds of
// promo emails in the 24-hour IMAP window. Capping per-run lets each invocation
// finish reliably — the hourly cron clears the backlog in a handful of runs.
// Tunable via INGEST_MAX_PER_RUN env var. 60 with concurrency 5 finishes
// well under the 300s maxDuration; combined with newest-first ordering
// it keeps up with steady-state inbox volume between hourly runs.
const INGEST_MAX_PER_RUN = Math.max(
  1,
  Number(process.env.INGEST_MAX_PER_RUN) || 60
)

// Returns true when an email body is mostly images — stripping tags leaves
// fewer than 500 characters of real text. These emails need their hosted
// web version fetched to get actual sale content.
function isBodySparse(html: string): boolean {
  const text = html
    .replace(/<style[^>]*>[\s\S]*?<\/style>/gi, '')
    .replace(/<script[^>]*>[\s\S]*?<\/script>/gi, '')
    .replace(/<[^>]+>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
  return text.length < 500
}

function decodeHtmlAttr(value: string): string {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
}

function parseDimension(value: string | undefined): number | null {
  if (!value) return null
  const match = value.match(/\d+/)
  return match ? Number(match[0]) : null
}

function looksLikePromoImage(url: string, width: number | null, height: number | null): boolean {
  const lower = url.toLowerCase()
  if (!/^https?:\/\//i.test(url)) return false
  if (lower.startsWith('data:') || lower.startsWith('cid:')) return false
  if (/\.(svg|ico)(?:[?#]|$)/i.test(lower)) return false
  if (/(pixel|tracking|beacon|openrate|spacer|blank|transparent|clear\.gif|1x1)/i.test(lower)) {
    return false
  }
  if (width !== null && height !== null) {
    if (width <= 2 || height <= 2) return false
    if (width < 120 && height < 120) return false
  }
  return true
}

function extractEmailImageUrls(html: string): string[] {
  const urls: string[] = []

  const imgRegex = /<img\b[^>]*>/gi
  const attrRegex = /\s(src|data-src|data-original|background|width|height|srcset)=["']([^"']+)["']/gi
  let imgMatch
  while ((imgMatch = imgRegex.exec(html)) !== null) {
    const attrs = new Map<string, string>()
    let attrMatch
    while ((attrMatch = attrRegex.exec(imgMatch[0])) !== null) {
      attrs.set(attrMatch[1].toLowerCase(), decodeHtmlAttr(attrMatch[2]))
    }

    const width = parseDimension(attrs.get('width'))
    const height = parseDimension(attrs.get('height'))
    const candidates = [
      attrs.get('src'),
      attrs.get('data-src'),
      attrs.get('data-original'),
      attrs.get('background'),
    ]

    const srcset = attrs.get('srcset')
    if (srcset) {
      candidates.push(
        ...srcset
          .split(',')
          .map((entry) => entry.trim().split(/\s+/)[0])
      )
    }

    for (const candidate of candidates) {
      if (candidate && looksLikePromoImage(candidate, width, height)) {
        urls.push(candidate)
      }
    }
  }

  const cssUrlRegex = /url\(["']?(https?:\/\/[^"')\s]+)["']?\)/gi
  let cssMatch
  while ((cssMatch = cssUrlRegex.exec(html)) !== null) {
    const url = decodeHtmlAttr(cssMatch[1])
    if (looksLikePromoImage(url, null, null)) urls.push(url)
  }

  return Array.from(new Set(urls)).slice(0, 8)
}

// Fetch the hosted "view in browser" version of an email. Retailers like
// Gap and Bath & Body Works send image-only emails but host a text-rich
// web version at the same URL — this gets us the actual sale copy.
async function fetchWebVersion(url: string): Promise<string | null> {
  try {
    const res = await fetch(url, {
      headers: { 'User-Agent': 'Mozilla/5.0 (compatible; DealDossierBot/1.0)' },
      signal: AbortSignal.timeout(8000),
    })
    if (!res.ok) return null
    const html = await res.text()
    if (html.length < 500) return null
    return html
  } catch {
    return null
  }
}

// Queue-based worker pool. Unlike batched Promise.all, a new task starts the
// moment any worker frees up — no head-of-line blocking when one email's
// OpenAI call is slow.
async function runWithConcurrency<T>(
  items: T[],
  concurrency: number,
  worker: (item: T) => Promise<void>
): Promise<void> {
  let index = 0
  const next = async (): Promise<void> => {
    while (true) {
      const i = index++
      if (i >= items.length) return
      try {
        await worker(items[i])
      } catch (err) {
        console.error(`[ingest] worker error on item ${i}:`, err)
      }
    }
  }
  await Promise.all(
    Array.from({ length: Math.min(concurrency, items.length) }, () => next())
  )
}

function verifyCronSecret(request: NextRequest): boolean {
  const secret = process.env.CRON_SECRET
  if (!secret) return false
  return request.headers.get('authorization') === `Bearer ${secret}`
}

export async function GET(request: NextRequest) {
  if (!verifyCronSecret(request)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const supabase = createServiceClient()
  const weekOf = getCurrentWeekOf()
  const weekOfStr = format(weekOf, 'yyyy-MM-dd')
  const hoursParam = request.nextUrl.searchParams.get('hours')
  const requestedHours = hoursParam ? Number(hoursParam) : 24
  const lookbackHours = Number.isFinite(requestedHours)
    ? Math.min(336, Math.max(1, Math.floor(requestedHours)))
    : 24
  const forceDateWindow =
    request.nextUrl.searchParams.get('backfill') === '1' || hoursParam !== null
  const limitParam = request.nextUrl.searchParams.get('limit')
  const requestedLimit = limitParam ? Number(limitParam) : INGEST_MAX_PER_RUN
  const perRunLimit = Number.isFinite(requestedLimit)
    ? Math.min(500, Math.max(1, Math.floor(requestedLimit)))
    : INGEST_MAX_PER_RUN
  // ?dryRun=true — runs the full pipeline (IMAP fetch + LLM extraction +
  // brand detection) but skips every DB write. Returns a JSON summary of
  // what would have been inserted. Safe to run against the live inbox.
  const dryRun = request.nextUrl.searchParams.get('dryRun') === 'true'
  if (dryRun) console.log('[ingest] DRY RUN — no DB writes will occur')

  // Fallback date window. Only used if the IMAP UID cursor is missing
  // (very first run) or invalidated by a UIDVALIDITY change. Steady-state
  // hourly runs never look at this — they pick up at `UID > last_uid`.
  const since = subHours(new Date(), lookbackHours)

  try {
    // Read the IMAP cursor. {uid_validity, last_uid} from ingest_state.
    // First-ever run: last_uid=0 (the table default), uidValidity unknown
    // → falls back to date window, which is fine.
    const { data: cursorRow } = await supabase
      .from('ingest_state')
      .select('uid_validity, last_uid')
      .eq('id', 'singleton')
      .maybeSingle()

    const cursor = {
      afterUid: Number(cursorRow?.last_uid ?? 0),
      uidValidity: cursorRow?.uid_validity != null
        ? Number(cursorRow.uid_validity)
        : undefined,
    }

    const tFetchStart = Date.now()
    const fetchResult = await fetchPromotionalEmails(
      since,
      forceDateWindow ? { forceDateWindow: true } : cursor,
    )
    const emails = fetchResult.messages
    console.log(
      `[ingest] IMAP fetch: ${emails.length} new messages in ${Date.now() - tFetchStart}ms ` +
        `(mode=${forceDateWindow ? `${lookbackHours}h backfill` : 'cursor'}, cursor: afterUid=${cursor.afterUid}, uidValidity=${cursor.uidValidity ?? 'none'} → maxUid=${fetchResult.maxUid}, uidValidity=${fetchResult.uidValidity})`
    )
    if (emails.length === 0) {
      // Even with zero new messages we advance uid_validity if it changed
      // — keeps the cursor pinned to the right mailbox generation.
      if (!forceDateWindow && fetchResult.uidValidity && fetchResult.uidValidity !== cursor.uidValidity) {
        await supabase
          .from('ingest_state')
          .update({ uid_validity: fetchResult.uidValidity, updated_at: new Date().toISOString() })
          .eq('id', 'singleton')
      }
      return NextResponse.json({ emails: 0, new_deals: 0 })
    }

    // Fetch the active category list once per run so the LLM prompt can be
    // built with the current taxonomy. Adding/removing categories in the
    // DB takes effect on the next ingest run — no code deploy.
    //
    // is_editorial separates content categories (LLM-derivable from
    // email body — Skincare, Womens Apparel) from editorial vibes
    // (Mall Stores, Boutique, Heritage). The LLM is told only the
    // non-editorial slugs (it can't infer vibes from a single email).
    // The store-category union below filters by is_editorial so vibe
    // tags from a brand's store row get added to its deals while
    // content tags do not (avoids the Roomba-in-Athleisure bug we
    // had under the "union everything" approach).
    const { data: categoryRows } = await supabase
      .from('categories')
      .select('slug, label, is_editorial')
      .eq('is_active', true)
      .order('sort_order')
    const allCategoryRows = (categoryRows ?? []) as Array<{ slug: string; label: string; is_editorial?: boolean }>
    // LLM gets non-editorial only — it should never try to tag a
    // deal as 'mall-stores' or 'luxury' from the email body alone.
    const allCategories: CategoryRow[] = allCategoryRows
      .filter((c) => !c.is_editorial)
      .map((c) => ({ slug: c.slug, label: c.label }))
    // The cron's per-deal store-category union filters incoming
    // store.categories against this set — only slugs flagged
    // is_editorial=true survive.
    const editorialSlugs = new Set(
      allCategoryRows.filter((c) => c.is_editorial).map((c) => c.slug),
    )

    // Pull the brand directory once per run and index it by normalized
    // name. When a deal comes in from a known brand, its admin-tagged
    // store.categories get unioned into the deal's category list — so a
    // "winter coats" deal from J.Crew lands under outerwear-and-coats
    // (LLM extraction, deal-specific) AND womens-clothes / mens-clothes
    // (store curation, general brand coverage). Anyone watching any of
    // those slugs sees the deal.
    // Pull ALL stores (active + pending) so we can:
    //   1. Route deals into store-curated categories (active path)
    //   2. Auto-activate pending stores when their first email arrives
    //      (so the directory self-validates — pending = "we suspect they
    //      send promo email" → confirmed when ingest sees one)
    // PostgREST caps each request at ~1000 rows and the directory is
    // 1700+. Page through — otherwise the ingest only "sees" the first
    // 1000 stores, so every brand beyond that looks unknown: it never
    // category-routes them and never auto-activates their pending row.
    type StoreLoadRow = {
      id: string
      name: string | null
      website: string | null
      categories: string[] | null
      is_active: boolean
      status: string | null
    }
    const STORE_PAGE = 1000
    const storeRows: StoreLoadRow[] = []
    for (let p = 0; p < 10; p++) {
      const { data: page, error: pageErr } = await supabase
        .from('stores')
        .select('id, name, website, categories, is_active, status')
        .order('name', { ascending: true })
        .range(p * STORE_PAGE, (p + 1) * STORE_PAGE - 1)
      if (pageErr) {
        console.error('[ingest] store-load page error', p, JSON.stringify(pageErr))
        break
      }
      if (!page || page.length === 0) break
      storeRows.push(...(page as StoreLoadRow[]))
      if (page.length < STORE_PAGE) break
    }
    interface StoreMatch {
      id: string
      categories: string[]
      is_active: boolean
      status: string
    }
    // Normalize a stored website value to a bare apex domain for comparison
    // against the output of parseSenderDomain(). Both strip www. and lowercase.
    function normalizeStoreDomain(website: string): string {
      return website.toLowerCase().replace(/^https?:\/\//, '').replace(/^www\./, '').replace(/\/$/, '').split('/')[0]
    }

    const storesByName = new Map<string, StoreMatch>()
    // Secondary index: apex domain → store. Catches cases where the LLM
    // extracts a slightly different brand name than the stored row but the
    // sender domain is the same (e.g. "Best Buy Electronics" vs "Best Buy"
    // both from bestbuy.com). Without this, the name lookup fails and the
    // auto-add branch would overwrite the active store row — the demotion bug.
    const storesByDomain = new Map<string, StoreMatch>()
    for (const row of storeRows ?? []) {
      if (!row.name) continue
      const match: StoreMatch = {
        id: row.id,
        categories: Array.isArray(row.categories) ? row.categories : [],
        is_active: row.is_active,
        // Older rows from before migration 019 may not have a status —
        // default to 'pending' so they still auto-activate on first deal.
        status: row.status ?? 'pending',
      }
      storesByName.set(normalizeRetailer(row.name), match)
      if (row.website) storesByDomain.set(normalizeStoreDomain(row.website), match)
    }
    const activeCount = Array.from(storesByName.values()).filter((s) => s.is_active).length
    console.log(
      `[ingest] loaded ${storesByName.size} stores (${activeCount} active, ${storesByName.size - activeCount} inactive) for routing + auto-activation`
    )

    // In-memory cache of retailers already known to the retailer_categories
    // table. Avoids duplicate LLM calls within a single run when multiple
    // emails come from the same retailer.
    const retailerCategoriesCache = new Map<string, boolean>()

    // Per-run cap: process NEWEST-UID-first.
    //
    // The mailbox accumulates faster than any single capped run can
    // drain it. Oldest-first meant the cursor crawled through weeks-old
    // expired promos while *today's* deals sat at the back of a
    // 2000-deep queue — so the watchlist emails always showed stale or
    // missing sales. Newest-first processes the freshest emails every
    // run; the cursor then advances to the newest processed UID, which
    // intentionally skips the older backlog. That's correct: those
    // promos are long expired and worthless to ingest.
    const newEmails = emails
      .slice()
      .sort((a, b) => b.uid - a.uid)
      .slice(0, perRunLimit)

    const deferred = emails.length - newEmails.length
    console.log(
      `[ingest] cap: ${emails.length} new → ${newEmails.length} processing this run` +
        (deferred > 0 ? ` (${deferred} deferred to next run)` : '')
    )

    // Pre-load processed email IDs for this week so backfill re-runs skip
    // emails the LLM already saw. Without this, re-running a backfill on the
    // same inbox window re-calls the LLM on the same email and can produce a
    // slightly different description, generating a new dedup key and inserting
    // a duplicate deal (the Charlotte Tilbury triple-card bug).
    const { data: processedEmailRows } = await supabase
      .from('processed_emails')
      .select('email_id')
      .eq('week_of', weekOfStr)
    const alreadyProcessedIds = new Set((processedEmailRows ?? []).map((r) => r.email_id))

    // Build a set of already-seen deal keys this week so we never insert
    // the same sale twice even if 3 emails announce it
    const { data: existingDealsThisWeek } = await supabase
      .from('deals')
      .select('id, retailer, deal_type, percent_off, promo_code, description, categories')
      .eq('week_of', weekOfStr)

    const existingDealByKey = new Map(
      (existingDealsThisWeek || []).map((d) => [
        makeDealKey(d),
        { id: d.id as string, categories: (d.categories ?? []) as string[] },
      ])
    )
    const seenDealKeys = new Set(existingDealByKey.keys())

    let newDeals = 0
    let emailsWithDeals = 0
    let emailsWithNoDeals = 0
    const processedEmailIds: string[] = []
    // Track per-email UIDs so we can advance the IMAP cursor only as far as
    // we've successfully processed. If one email fails mid-run, the cursor
    // stays low enough that the next run will retry it.
    const processedUids: number[] = []
    // Dry-run accumulators — populated when ?dryRun=true, ignored otherwise.
    const dryRunWouldAutoAdd: Array<{ name: string; domain: string; from: string }> = []
    const dryRunWouldInsertDeals: Array<{ retailer: string; deal_type: string; description: string }> = []

    async function processEmail(email: (typeof newEmails)[number]): Promise<void> {
      // Skip emails already processed this week — prevents duplicate deals when
      // a backfill re-run hits the same inbox window and the LLM returns a
      // slightly different description, bypassing the deal-key dedup.
      if (alreadyProcessedIds.has(email.id)) {
        console.log(`[ingest] skip already-processed: ${email.id}`)
        processedUids.push(email.uid)
        return
      }

      // Fast-path: skip obviously transactional emails without an OpenAI call
      if (isTransactionalEmail(email.subject)) {
        console.log(`[ingest] skip transactional: "${email.subject}"`)
        await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
        processedEmailIds.push(email.id)
        processedUids.push(email.uid)
        return
      }

      let emailBody = email.body
      const sparseOriginalBody = isBodySparse(email.body)
      if (sparseOriginalBody && email.viewInBrowserUrl) {
        console.log(`[ingest] sparse body, fetching web version: ${email.viewInBrowserUrl}`)
        const webHtml = await fetchWebVersion(email.viewInBrowserUrl)
        if (webHtml) {
          emailBody = webHtml
          console.log(`[ingest] web version fetched (${webHtml.length} chars)`)
        } else {
          console.log(`[ingest] web version fetch failed, using original body`)
        }
      }

      let extracted = await extractDealsFromEmail(email.from, email.subject, emailBody, allCategories)
      console.log(`[ingest] ${email.from} | subject: ${email.subject} | text extracted: ${extracted.length}`)

      if (sparseOriginalBody || extracted.length === 0) {
        const imageUrls = extractEmailImageUrls(`${email.body}\n${emailBody}`)
        if (imageUrls.length > 0) {
          console.log(
            `[ingest] vision fallback (${sparseOriginalBody ? 'sparse body' : 'no text deals'}): ${imageUrls.length} images`
          )
          const imageExtracted = await extractDealsFromEmailImages(
            email.from,
            email.subject,
            imageUrls,
            allCategories,
          )
          if (imageExtracted.length > 0) {
            extracted = imageExtracted
            console.log(`[ingest] ${email.from} | subject: ${email.subject} | image extracted: ${extracted.length}`)
          } else {
            console.log(`[ingest] vision fallback found no deals`)
          }
        } else {
          console.log(`[ingest] vision fallback skipped: no usable image URLs`)
        }
      }

      console.log(`[ingest] ${email.from} | subject: ${email.subject} | extracted: ${extracted.length}`)
      if (extracted.length > 0) emailsWithDeals++
      else emailsWithNoDeals++

      for (const deal of extracted) {
        // Skip deals with no real value
        if (!deal.description || !deal.retailer) continue

        // Title-case all-lowercase LLM output ("carter's" → "Carter's")
        // without overriding mixed-case extractions
        const retailer = fixRetailerCase(deal.retailer)
        const normalizedDeal = { ...deal, retailer }

        if (isJunkDeal(normalizedDeal)) {
          console.log(`[ingest] skipping junk deal: ${retailer} — "${deal.description.slice(0, 80)}"`)
          continue
        }

        const dealKey = makeDealKey(normalizedDeal)

        // Look up the brand in the stores table. Priority order:
        //   1. Exact normalized-name match → known store
        //   2. Apex-domain match (storesByDomain) → known store under a
        //      different name. Without this check, a name mismatch would
        //      fall through to auto-add and the upsert would overwrite the
        //      existing active store row (the demotion bug).
        //   3. Neither → genuinely new brand → auto-create with
        //      status='auto_added', is_active=false for admin review.
        let storeMatch = storesByName.get(normalizeRetailer(retailer))

        if (!storeMatch) {
          const domain = parseSenderDomain(email.from)

          // Step 2: domain pre-check — if this sender's apex domain already
          // exists in the directory under any name, use that store record and
          // skip the auto-add entirely. This prevents demoting active stores.
          if (domain) {
            const domainMatch = storesByDomain.get(domain)
            if (domainMatch) {
              storeMatch = domainMatch
              console.log(`[ingest] domain match (name drift): ${retailer} → ${domain}`)
            }
          }

          if (!storeMatch) {
            if (domain) {
              if (dryRun) {
                console.log(`[DRY RUN] would auto-add: ${retailer} (${domain}) from=${email.from}`)
                dryRunWouldAutoAdd.push({ name: retailer, domain, from: email.from })
              } else {
                // ignoreDuplicates: true — if the domain already exists under
                // any status, do nothing. Never overwrite an existing store row.
                // Race-safe: concurrent workers hitting the same unknown domain
                // both try to insert; the second one silently skips.
                const { data: inserted, error: insertErr } = await supabase
                  .from('stores')
                  .upsert(
                    {
                      name: retailer,
                      website: domain,
                      status: 'auto_added',
                      is_active: false,
                      categories: deal.categories ?? [],
                    },
                    { onConflict: 'website', ignoreDuplicates: true },
                  )
                  .select('id, name, categories, is_active, status')
                  .maybeSingle()
                if (insertErr) {
                  console.error(`[ingest] auto-add error for ${retailer} (${domain}):`, JSON.stringify(insertErr))
                } else if (inserted) {
                  console.log(`[ingest] auto-added store for review: ${retailer} (${domain})`)
                  storeMatch = {
                    id: inserted.id,
                    categories: Array.isArray(inserted.categories) ? inserted.categories : [],
                    is_active: inserted.is_active,
                    status: inserted.status ?? 'auto_added',
                  }
                  storesByName.set(normalizeRetailer(retailer), storeMatch)
                  storesByDomain.set(domain, storeMatch)
                }
                // inserted === null means the domain already existed and was
                // skipped (ignoreDuplicates: true). That's correct — no action.
              }
            } else {
              console.log(`[ingest] auto-add skipped (no parseable domain): ${retailer} from=${email.from}`)
            }
          }
        }

        // Per-deal categories = LLM tags (content) + editorial vibes
        // from the store row.
        //
        //   Content slugs (Skincare, Womens Apparel, ...) come from
        //   the LLM, which read the email body. They never appear in
        //   editorialSlugs so they pass through untouched.
        //
        //   Editorial vibes (Mall Stores, Boutique, Luxury, Heritage)
        //   come from the store's stores.categories tags, unioned in
        //   here. The LLM can't infer "this brand is a mall store"
        //   from a single email, so editorial tags MUST come from the
        //   store row to be useful for routing.
        //
        // The is_editorial filter prevents the pre-rebuild bug where
        // every Best Buy deal got tagged athleisure just because the
        // Best Buy store row happened to have athleisure in its list.
        const storeCats = storeMatch?.categories ?? []
        const editorialFromStore = storeCats.filter((c) => editorialSlugs.has(c))
        const mergedCategories = Array.from(
          new Set([...(deal.categories ?? []), ...editorialFromStore])
        ) as Category[]
        if (editorialFromStore.length > 0) {
          console.log(
            `[ingest] vibe-routed ${retailer}: LLM=[${(deal.categories ?? []).join(',')}] + vibes=[${editorialFromStore.join(',')}] → [${mergedCategories.join(',')}]`
          )
        }

        // Skip duplicates within this week, but let backfill/reprocessing
        // merge in newly learned categories such as the added furnature slug.
        // This keeps existing deal rows useful without creating duplicate
        // cards for the same promotion.
        const existingDeal = existingDealByKey.get(dealKey)
        if (existingDeal) {
          const nextCategories = Array.from(
            new Set([...(existingDeal.categories ?? []), ...mergedCategories])
          )
          const changed = nextCategories.length !== existingDeal.categories.length
          if (changed) {
            const { error: updateError } = await supabase
              .from('deals')
              .update({
                categories: nextCategories,
                last_seen_at: new Date().toISOString(),
              })
              .eq('id', existingDeal.id)
            if (updateError) {
              console.error('[ingest] duplicate category update error:', JSON.stringify(updateError))
            } else {
              existingDeal.categories = nextCategories
              console.log(`[ingest] updated duplicate categories: ${retailer} → [${nextCategories.join(',')}]`)
            }
          } else {
            console.log(`[ingest] skipping duplicate: ${retailer} ${deal.deal_type} ${deal.percent_off}%`)
          }
          continue
        }
        if (seenDealKeys.has(dealKey)) {
          console.log(`[ingest] skipping in-run duplicate: ${retailer} ${deal.deal_type} ${deal.percent_off}%`)
          continue
        }
        seenDealKeys.add(dealKey)

        // Auto-activate pending stores. Only flip 'pending' — never
        // touch 'no_email', 'declined', or 'auto_added' (the new
        // auto_added rows wait for admin review). Mutate the in-memory
        // record first so subsequent deals from the same brand this
        // run don't re-fire the UPDATE; the DB write is fire-and-forget
        // since it's idempotent.
        if (storeMatch && !storeMatch.is_active && storeMatch.status === 'pending') {
          storeMatch.is_active = true
          storeMatch.status = 'active'
          supabase
            .from('stores')
            .update({ is_active: true, status: 'active' })
            .eq('id', storeMatch.id)
            .then(({ error: actErr }) => {
              if (actErr) {
                console.error(`[ingest] auto-activate error for ${retailer}:`, JSON.stringify(actErr))
              } else {
                console.log(`[ingest] auto-activated pending store: ${retailer}`)
              }
            })
        }

        const dealRow = {
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
          keywords: (deal.keywords ?? []).map((k) => k.toLowerCase()),
          last_seen_at: new Date().toISOString(),
          week_of: weekOfStr,
          source_email_id: email.id,
          source_email_link: email.viewInBrowserUrl ?? null,
          is_manual: email.isManual,
        }

        // Lazy-populate retailer_categories: the first time we see a deal
        // from this retailer in this run, ask the LLM what categories the
        // brand sells overall (Walmart → 50+, Boll & Branch → 2). Cached
        // in-memory for the rest of the run; persisted across runs in the
        // retailer_categories table.
        if (!dryRun && !retailerCategoriesCache.has(retailer)) {
          retailerCategoriesCache.set(retailer, true)
          // Skip the LLM call if the retailer is already known
          const { data: existingMapping } = await supabase
            .from('retailer_categories')
            .select('retailer')
            .eq('retailer', retailer)
            .limit(1)
            .maybeSingle()
          if (!existingMapping) {
            const retailerCats = await getRetailerCategories(retailer, allCategories)
            if (retailerCats.length > 0) {
              const rows = retailerCats.map((slug, i) => ({
                retailer,
                category_slug: slug,
                is_primary: i === 0,
              }))
              const { error } = await supabase
                .from('retailer_categories')
                .upsert(rows, { onConflict: 'retailer,category_slug' })
              if (error) {
                console.error('[ingest] retailer_categories upsert error:', JSON.stringify(error))
              } else {
                console.log(`[ingest] retailer_categories: ${retailer} → ${retailerCats.join(', ')}`)
              }
            }
          }
        }

        if (dryRun) {
          console.log(`[DRY RUN] would insert deal: ${retailer} — ${deal.deal_type} — ${deal.description?.slice(0, 80)}`)
          dryRunWouldInsertDeals.push({ retailer, deal_type: deal.deal_type, description: deal.description ?? '' })
          newDeals++
          continue
        }

        // Plain insert: the processed_emails table already prevents
        // re-processing the same email, and the in-run seenDealKeys set
        // catches duplicates within a single run. There's no unique
        // constraint on (source_email_id, retailer) on the deals table,
        // so an upsert with that onConflict spec fails with Postgres
        // 42P10 — which silently dropped every deal extracted between
        // 2026-04-30 and 2026-05-07.
        const { error: insertError } = await supabase
          .from('deals')
          .insert(dealRow)
        if (insertError) {
          console.error('Deal insert error:', JSON.stringify(insertError))
          continue
        }
        newDeals++

        // Upsert keywords into the global vocabulary table via a Postgres
        // function that properly increments deal_count on conflict (a plain
        // upsert would reset it to 1). Fire-and-forget — never blocks ingestion.
        const kws = dealRow.keywords
        if (kws && kws.length > 0) {
          supabase
            .rpc('upsert_keywords', { kws })
            .then(({ error: kwErr }) => {
              if (kwErr) console.error('[ingest] keywords upsert error:', JSON.stringify(kwErr))
            })
        }
      }

      if (!dryRun) {
        // Log to retailer_scan_log
        const retailerName = extracted.length > 0 && extracted[0].retailer
          ? extracted[0].retailer
          : parseSenderName(email.from)

        const { data: existingLog } = await supabase
          .from('retailer_scan_log')
          .select('id, emails_processed, deals_extracted')
          .eq('week_of', weekOfStr)
          .eq('retailer', retailerName)
          .single()

        if (existingLog) {
          await supabase
            .from('retailer_scan_log')
            .update({
              emails_processed: existingLog.emails_processed + 1,
              deals_extracted: existingLog.deals_extracted + extracted.length,
            })
            .eq('id', existingLog.id)
        } else {
          await supabase
            .from('retailer_scan_log')
            .insert({
              week_of: weekOfStr,
              retailer: retailerName,
              sender_email: email.from,
              emails_processed: 1,
              deals_extracted: extracted.length,
            })
        }

        await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
        processedEmailIds.push(email.id)
        processedUids.push(email.uid)
      }
    }

    // Concurrency-limited worker pool — N workers run in parallel and pick
    // up the next email as soon as their current one finishes, eliminating
    // the head-of-line blocking of the previous batched approach.
    const tProcessStart = Date.now()
    await runWithConcurrency(newEmails, INGEST_CONCURRENCY, async (email) => {
      try {
        await processEmail(email)
      } catch (err) {
        console.error(`Failed to process email ${email.id}:`, err)
      }
    })
    console.log(
      `[ingest] processed ${newEmails.length} emails in ${Date.now() - tProcessStart}ms ` +
        `(${emailsWithDeals} with deals, ${emailsWithNoDeals} empty, ${newDeals} new deals)`
    )

    // Total deals this week — surfaced in the response for debugging.
    // The editions table is gone; homepage + admin stats now compute
    // live from deals + processed_emails (see /api/stats and
    // /api/editions/latest).
    const { count: totalDeals } = await supabase
      .from('deals')
      .select('*', { count: 'exact', head: true })
      .eq('week_of', weekOfStr)

    // Advance the IMAP cursor. We use the max successfully-processed UID
    // (NOT fetchResult.maxUid, which would include emails that errored
    // mid-run). If processedUids is empty for any reason — every email
    // hit an exception — leave the cursor where it was so next run
    // retries. Skipped in dry-run mode (no UIDs are pushed in that path).
    if (!dryRun && !forceDateWindow && processedUids.length > 0) {
      const newLastUid = Math.max(...processedUids)
      const { error: cursorErr } = await supabase
        .from('ingest_state')
        .update({
          last_uid: newLastUid,
          uid_validity: fetchResult.uidValidity,
          updated_at: new Date().toISOString(),
        })
        .eq('id', 'singleton')
      if (cursorErr) {
        console.error('[ingest] cursor update failed:', JSON.stringify(cursorErr))
      } else {
        console.log(
          `[ingest] cursor advanced: last_uid=${newLastUid}, uid_validity=${fetchResult.uidValidity}`
        )
      }
    }

    const response: Record<string, unknown> = {
      emails_fetched: emails.length,
      emails_processed: newEmails.length,
      emails_deferred: deferred,
      emails_with_deals: emailsWithDeals,
      emails_with_no_deals: emailsWithNoDeals,
      new_deals: newDeals,
      total_deals_this_week: totalDeals ?? 0,
      mode: forceDateWindow ? 'backfill' : 'cursor',
      lookback_hours: lookbackHours,
      per_run_limit: perRunLimit,
      cursor: {
        last_uid: processedUids.length > 0 ? Math.max(...processedUids) : cursor.afterUid,
        uid_validity: fetchResult.uidValidity,
      },
    }

    if (dryRun) {
      response.dry_run = true
      response.would_auto_add = dryRunWouldAutoAdd
      response.would_insert_deals = dryRunWouldInsertDeals
    }

    return NextResponse.json(response)
  } catch (err) {
    console.error('Ingest error:', err)
    await sendAdminAlert({
      subject: '🚨 Deal Dossier — ingest failed',
      body: `Ingest failed at ${new Date().toISOString()}\n\nError: ${err instanceof Error ? err.message : String(err)}\n\nFix it at: https://dealdossier.io/admin`,
    })
    return NextResponse.json({ error: 'Ingestion failed' }, { status: 500 })
  }
}
