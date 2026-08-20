import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { fetchPromotionalEmails } from '@/lib/gmail'
import {
  extractDealsFromEmail,
  extractDealsFromEmailImages,
  getRetailerCategories,
  cleanEmailBodyForExtraction,
  createNormalizedExtractionOutput,
  getExtractionSchemaValidity,
  shouldEnqueueOpenRouterShadow,
  EXTRACTION_PROMPT_VERSION,
  PRIMARY_EXTRACTION_PROVIDER,
  SHADOW_EXTRACTION_PROVIDER,
  getPrimaryExtractionModel,
  getOpenRouterExtractionModel,
  ApiCreditExhaustedError,
  ApiRateLimitError,
  ApiSchemaValidationError,
  type CategoryRow,
} from '@/lib/openai'
import {
  getCurrentWeekOf,
  makeDealKey,
  getJunkDealReason,
  isPricePointDescription,
  buildDuplicateDealRefresh,
  mergeSubtypeIntoKeywords,
} from '@/lib/deals'
import { fixRetailerCase } from '@/lib/stores'
import { normalizeRetailerWebsite } from '@/lib/domainNormalize'
import { sendAdminAlert } from '@/lib/resend'
import { format, subHours } from 'date-fns'
import type { Category } from '@/types'
import {
  computeSafeCursorAfterProduction,
  isEmailOlderThanDays,
  selectEmailsForIngest,
} from '@/lib/ingestSelection'
import {
  DEFAULT_EMAIL_IMAGE_URL_LIMIT,
  MAX_EMAIL_IMAGE_URL_LIMIT,
  extractEmailImageUrls,
} from '@/lib/emailImages'
import { isBlockedEmailSender, isBlockedRetailer } from '@/lib/blockedRetailers'

export const dynamic = 'force-dynamic'

export const maxDuration = 300 // 5 minute max

// Extract display name from "Store Name <email@domain.com>" format
function parseSenderName(from: string): string {
  const match = from.match(/^([^<]+)</)
  if (match) return match[1].trim()
  return from.split('@')[0].trim()
}

// Extract and normalize the sender website from "From: Best Buy
// <hello@emails.bestbuy.com>" → "https://bestbuy.com". Used as the
// website when auto-creating an unknown store row. The shared normalizer
// strips common marketing/newsletter subdomains and reduces deep sender
// hosts to the apex when it can.
function parseSenderWebsite(from: string): string | null {
  const m = from.match(/@([a-zA-Z0-9.-]+)/)
  if (!m) return null
  return normalizeRetailerWebsite(m[1])
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
// the primary extraction provider's tokens-per-minute cap.
const INGEST_CONCURRENCY = Math.max(
  1,
  Number(process.env.INGEST_CONCURRENCY) || 2
)

const INGEST_BACKFILL_CONCURRENCY = Math.max(
  1,
  Number(process.env.INGEST_BACKFILL_CONCURRENCY) || 1
)

// Hard cap on emails processed per run. Vercel's serverless function limit is
// 5 minutes; a fresh inbox with weeks of accumulated subs can have hundreds of
// promo emails in the 24-hour IMAP window. Capping per-run lets each invocation
// finish reliably — the hourly cron clears the backlog in a handful of runs.
// Tunable via INGEST_MAX_PER_RUN env var. Cursor runs drain oldest-first:
// only a contiguous processed UID range may be committed, otherwise older
// deferred messages are silently lost.
const INGEST_MAX_PER_RUN = Math.max(
  1,
  Number(process.env.INGEST_MAX_PER_RUN) || 20
)

const INGEST_BACKFILL_MAX_PER_RUN = Math.max(
  1,
  Number(process.env.INGEST_BACKFILL_MAX_PER_RUN) || 10
)

const INGEST_STALE_RUN_MS = Math.max(
  5 * 60 * 1000,
  Number(process.env.INGEST_STALE_RUN_MS) || 6 * 60 * 1000,
)

const INGEST_MAX_EMAIL_AGE_DAYS = Math.max(
  1,
  Number(process.env.INGEST_MAX_EMAIL_AGE_DAYS) || 1,
)

const INGEST_MAX_IMAGE_URLS = Math.max(
  1,
  Math.min(
    MAX_EMAIL_IMAGE_URL_LIMIT,
    Number(process.env.INGEST_MAX_IMAGE_URLS) || DEFAULT_EMAIL_IMAGE_URL_LIMIT,
  ),
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

function shouldScanImagesForDollarCoupons(
  source: string,
  extracted: Array<{ deal_type?: string | null }>,
): boolean {
  if (extracted.some((deal) => deal.deal_type === 'amount-off')) return false
  return /\b(e-?coupons?|digital\s+(deals?|coupons?)|add\s+coupon|clip\s+coupon|view\s+coupons?|save\s+\$\d+(?:\.\d{2})?)\b/i.test(source)
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

async function enqueueOpenRouterShadowJob(
  supabase: ReturnType<typeof createServiceClient>,
  input: {
    auditRunId: string | null
    emailAuditId: string | null
    email: {
      id: string
      uid: number
      from: string
      subject: string
      date: string
    }
    cleanedBody: string
    imageUrls: string[]
    productionOutput: ReturnType<typeof createNormalizedExtractionOutput>
  },
): Promise<boolean> {
  if (!shouldEnqueueOpenRouterShadow()) return false

  const receivedAt = input.email.date ? new Date(input.email.date) : null
  const model = getOpenRouterExtractionModel()
  const { error } = await supabase
    .from('email_extraction_jobs')
    .upsert({
      source_run_id: input.auditRunId,
      source_email_audit_id: input.emailAuditId,
      email_id: input.email.id,
      uid: input.email.uid,
      sender: input.email.from,
      subject: input.email.subject,
      received_at: receivedAt && !Number.isNaN(receivedAt.getTime())
        ? receivedAt.toISOString()
        : null,
      cleaned_body: input.cleanedBody,
      image_urls: input.imageUrls,
      prompt_version: EXTRACTION_PROMPT_VERSION,
      provider: SHADOW_EXTRACTION_PROVIDER,
      model,
      status: 'pending',
      next_attempt_at: new Date().toISOString(),
      last_error: null,
      production_output: input.productionOutput,
      normalized_output: null,
      completed_at: null,
      locked_at: null,
      locked_by: null,
    }, {
      onConflict: 'email_id,prompt_version,provider,model',
      ignoreDuplicates: true,
    })

  if (error) {
    console.error('[ingest] OpenRouter shadow enqueue error:', JSON.stringify(error))
    return false
  }
  return true
}

// Queue-based worker pool. Unlike batched Promise.all, a new task starts the
// moment any worker frees up — no head-of-line blocking when one email's
// OpenAI call is slow.
async function runWithConcurrency<T>(
  items: T[],
  concurrency: number,
  worker: (item: T) => Promise<void>,
  options?: {
    shouldAbort?: () => boolean
    // Returns the unix-ms timestamp that all workers should wait until
    // before picking up their next item (used to throttle after rate limits).
    getPauseUntil?: () => number
  },
): Promise<void> {
  let index = 0
  const next = async (): Promise<void> => {
    while (true) {
      if (options?.shouldAbort?.()) return
      const pauseUntil = options?.getPauseUntil?.() ?? 0
      if (pauseUntil > Date.now()) {
        const waitMs = pauseUntil - Date.now()
        console.log(`[ingest] rate-limit pause: waiting ${Math.round(waitMs / 1000)}s`)
        await new Promise((r) => setTimeout(r, waitMs))
      }
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
  const defaultLimit = forceDateWindow ? INGEST_BACKFILL_MAX_PER_RUN : INGEST_MAX_PER_RUN
  const requestedLimit = limitParam ? Number(limitParam) : defaultLimit
  const perRunLimit = Number.isFinite(requestedLimit)
    ? Math.min(500, Math.max(1, Math.floor(requestedLimit)))
    : defaultLimit
  const effectiveConcurrency = forceDateWindow ? INGEST_BACKFILL_CONCURRENCY : INGEST_CONCURRENCY
  const reprocess = request.nextUrl.searchParams.get('reprocess') === '1'
  const offsetParam = Number(request.nextUrl.searchParams.get('offset') ?? 0)
  const backfillOffset = Number.isFinite(offsetParam)
    ? Math.max(0, Math.floor(offsetParam))
    : 0
  // ?dryRun=true — runs the full pipeline (IMAP fetch + LLM extraction +
  // brand detection) but skips every DB write. Returns a JSON summary of
  // what would have been inserted. Safe to run against the live inbox.
  const dryRun = request.nextUrl.searchParams.get('dryRun') === 'true'
  if (dryRun) console.log('[ingest] DRY RUN — no DB writes will occur')

  // Fallback date window. Only used if the IMAP UID cursor is missing
  // (very first run) or invalidated by a UIDVALIDITY change. Steady-state
  // hourly runs never look at this — they pick up at `UID > last_uid`.
  const since = subHours(new Date(), lookbackHours)
  let auditRunId: string | null = null
  let apiCreditExhausted = false
  let rateLimitPauseUntil = 0

  try {
    const staleStartedBefore = new Date(Date.now() - INGEST_STALE_RUN_MS).toISOString()
    await supabase
      .from('ingest_runs')
      .update({
        status: 'timed_out',
        completed_at: new Date().toISOString(),
        error: 'Marked stale before starting a newer ingest run',
      })
      .eq('status', 'running')
      .lt('started_at', staleStartedBefore)

    const { data: activeRun, error: activeRunError } = await supabase
      .from('ingest_runs')
      .select('id, started_at, mode, requested_limit')
      .eq('status', 'running')
      .gte('started_at', staleStartedBefore)
      .order('started_at', { ascending: false })
      .limit(1)
      .maybeSingle()
    if (!activeRunError && activeRun) {
      return NextResponse.json({
        error: 'Ingest already running',
        active_run_id: activeRun.id,
        active_started_at: activeRun.started_at,
        active_mode: activeRun.mode,
        retry_after_seconds: Math.ceil(INGEST_STALE_RUN_MS / 1000),
      }, { status: 409 })
    }

    const { data: auditRun, error: auditRunError } = await supabase
      .from('ingest_runs')
      .insert({
        mode: forceDateWindow ? 'backfill' : 'cursor',
        lookback_hours: lookbackHours,
        requested_limit: perRunLimit,
        reprocess,
      })
      .select('id')
      .single()
    if (auditRunError) {
      console.warn('[ingest] audit unavailable:', auditRunError.message)
    } else {
      auditRunId = auditRun?.id ?? null
    }

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
      forceDateWindow
        ? { forceDateWindow: true }
        : { ...cursor, maxMessages: perRunLimit },
    )
    const emails = fetchResult.messages
    if (auditRunId) {
      await supabase
        .from('ingest_runs')
        .update({ emails_fetched: emails.length })
        .eq('id', auditRunId)
    }
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
      if (auditRunId) {
        await supabase
          .from('ingest_runs')
          .update({ status: 'completed', completed_at: new Date().toISOString() })
          .eq('id', auditRunId)
      }
      return NextResponse.json({ emails: 0, new_deals: 0, audit_run_id: auditRunId })
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
    // against sender-derived websites. Both strip protocol/www and lowercase.
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

    // Content (non-editorial) slugs, used to decide whether a store row
    // still needs LLM category tagging.
    const contentSlugs = new Set(allCategories.map((c) => c.slug))

    // Stores already checked for content categories this run. Avoids
    // duplicate LLM calls when multiple emails come from the same retailer.
    const storeCategoriesChecked = new Set<string>()

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

    // Cursor runs MUST drain UIDs oldest-first. Advancing a cursor after
    // processing newest-first permanently jumped over every older deferred
    // message. Backfills may skip already-processed messages, or deliberately
    // reprocess them for auditing with ?reprocess=1. Offset allows a large
    // date-window audit to be run in deterministic batches.
    const selection = selectEmailsForIngest(emails, {
      limit: perRunLimit,
      forceDateWindow,
      reprocess,
      offset: backfillOffset,
      alreadyProcessedIds,
    })
    const newEmails = selection.selected
    const selectedOffset = selection.selectedOffset
    const deferred = selection.deferred
    console.log(
      `[ingest] cap: ${emails.length} fetched → ${selection.eligibleCount} eligible → ${newEmails.length} processing` +
        (selectedOffset > 0 ? ` (offset ${selectedOffset})` : '') +
        (deferred > 0 ? ` (${deferred} genuinely deferred to next batch)` : '')
    )
    if (auditRunId) {
      await supabase
        .from('ingest_runs')
        .update({
          emails_selected: newEmails.length,
          emails_deferred: deferred,
        })
        .eq('id', auditRunId)
    }

    // Build a set of already-seen deal keys this week so we never insert
    // the same sale twice even if 3 emails announce it
    const { data: existingDealsThisWeek } = await supabase
      .from('deals')
      .select('id, retailer, deal_type, percent_off, promo_code, description, categories, keywords, redemption_channel')
      .eq('week_of', weekOfStr)

    const existingDealByKey = new Map(
      (existingDealsThisWeek || []).map((d) => [
        makeDealKey(d),
        {
          id: d.id as string,
          categories: (d.categories ?? []) as string[],
          keywords: (d.keywords ?? []) as string[],
          redemption_channel: (d.redemption_channel ?? null) as string | null,
        },
      ])
    )
    const seenDealKeys = new Set(existingDealByKey.keys())

    let newDeals = 0
    let extractedCandidates = 0
    let emailsWithDeals = 0
    let emailsWithNoDeals = 0
    let emailsSkippedStale = 0
    const processedEmailIds: string[] = []
    // Track per-email UIDs so we can advance the IMAP cursor only as far as
    // we've successfully processed. If one email fails mid-run, the cursor
    // stays low enough that the next run will retry it.
    const processedUids: number[] = []
    const failedUids: number[] = []
    // Dry-run accumulators — populated when ?dryRun=true, ignored otherwise.
    const dryRunWouldAutoAdd: Array<{ name: string; domain: string; from: string }> = []
    const dryRunWouldInsertDeals: Array<{ retailer: string; deal_type: string; description: string }> = []

    async function activatePendingStore(retailer: string, storeMatch: StoreMatch): Promise<void> {
      // Pending stores came from the directory seed and are waiting for
      // proof that the brand really sends email. Any ingested non-transactional
      // email is enough proof; don't require a publishable deal.
      if (storeMatch.is_active || storeMatch.status !== 'pending') return
      storeMatch.is_active = true
      storeMatch.status = 'active'
      const { error: actErr } = await supabase
        .from('stores')
        .update({ is_active: true, status: 'active' })
        .eq('id', storeMatch.id)
      if (actErr) {
        console.error(`[ingest] auto-activate error for ${retailer}:`, JSON.stringify(actErr))
      } else {
        console.log(`[ingest] auto-activated pending store: ${retailer}`)
      }
    }

    async function resolveStoreForSender(
      retailer: string,
      email: (typeof newEmails)[number],
      categories: string[] = [],
      allowAutoAdd = true,
    ): Promise<StoreMatch | undefined> {
      const normalizedRetailer = normalizeRetailer(retailer)
      if (!normalizedRetailer) return undefined

      // Look up the brand in the stores table. Priority order:
      //   1. Exact normalized-name match → known store
      //   2. Apex-domain match (storesByDomain) → known store under a
      //      different name. Without this check, a name mismatch would
      //      fall through to auto-add and the upsert would overwrite the
      //      existing active store row (the demotion bug).
      //   3. Neither → genuinely new brand → auto-create with
      //      status='auto_added', is_active=false for admin review.
      let storeMatch = storesByName.get(normalizedRetailer)
      if (storeMatch) {
        await activatePendingStore(retailer, storeMatch)
        return storeMatch
      }

      const senderWebsite = parseSenderWebsite(email.from)
      const domain = senderWebsite ? normalizeStoreDomain(senderWebsite) : null

      // Step 2: domain pre-check — if this sender's apex domain already
      // exists in the directory under any name, use that store record and
      // skip the auto-add entirely. This prevents demoting active stores.
      if (domain) {
        const domainMatch = storesByDomain.get(domain)
        if (domainMatch) {
          storeMatch = domainMatch
          storesByName.set(normalizedRetailer, storeMatch)
          console.log(`[ingest] domain match (name drift): ${retailer} → ${domain}`)
          await activatePendingStore(retailer, storeMatch)
          return storeMatch
        }
      }

      if (!allowAutoAdd) return undefined

      if (!domain) {
        console.log(`[ingest] auto-add skipped (no parseable domain): ${retailer} from=${email.from}`)
        return undefined
      }

      if (dryRun) {
        console.log(`[DRY RUN] would auto-add: ${retailer} (${senderWebsite}) from=${email.from}`)
        dryRunWouldAutoAdd.push({ name: retailer, domain: senderWebsite ?? domain, from: email.from })
        return undefined
      }

      // ignoreDuplicates: true — if the domain already exists under
      // any status, do nothing. Never overwrite an existing store row.
      // Race-safe: concurrent workers hitting the same unknown domain
      // both try to insert; the second one silently skips.
      const { data: inserted, error: insertErr } = await supabase
        .from('stores')
        .upsert(
          {
            name: retailer,
            website: senderWebsite,
            status: 'auto_added',
            is_active: false,
            categories,
          },
          { onConflict: 'website', ignoreDuplicates: true },
        )
        .select('id, name, categories, is_active, status')
        .maybeSingle()
      if (insertErr) {
        console.error(`[ingest] auto-add error for ${retailer} (${senderWebsite}):`, JSON.stringify(insertErr))
        return undefined
      }
      if (!inserted) return undefined

      console.log(`[ingest] auto-added store for review: ${retailer} (${senderWebsite})`)
      storeMatch = {
        id: inserted.id,
        categories: Array.isArray(inserted.categories) ? inserted.categories : [],
        is_active: inserted.is_active,
        status: inserted.status ?? 'auto_added',
      }
      storesByName.set(normalizedRetailer, storeMatch)
      storesByDomain.set(domain, storeMatch)
      return storeMatch
    }

    async function startEmailAudit(email: (typeof newEmails)[number]): Promise<string | null> {
      if (!auditRunId) return null
      const receivedAt = email.date ? new Date(email.date) : null
      const { data, error } = await supabase
        .from('ingest_email_audit')
        .insert({
          run_id: auditRunId,
          email_id: email.id,
          uid: email.uid,
          sender: email.from,
          subject: email.subject,
          received_at: receivedAt && !Number.isNaN(receivedAt.getTime())
            ? receivedAt.toISOString()
            : null,
          body_sparse: isBodySparse(email.body),
          outcome: 'processing',
        })
        .select('id')
        .single()
      if (error) {
        console.error('[ingest] email audit insert error:', JSON.stringify(error))
        return null
      }
      return data?.id ?? null
    }

    async function finishEmailAudit(
      emailAuditId: string | null,
      values: Record<string, unknown>,
    ): Promise<void> {
      if (!emailAuditId) return
      const { error } = await supabase
        .from('ingest_email_audit')
        .update(values)
        .eq('id', emailAuditId)
      if (error) console.error('[ingest] email audit update error:', JSON.stringify(error))
    }

    async function auditCandidate(
      emailAuditId: string | null,
      emailId: string,
      deal: Record<string, unknown>,
      decision: string,
      reason: string | null = null,
      dealId: string | null = null,
    ): Promise<void> {
      if (!auditRunId) return
      const { error } = await supabase
        .from('ingest_deal_candidates')
        .insert({
          run_id: auditRunId,
          email_audit_id: emailAuditId,
          email_id: emailId,
          retailer: deal.retailer ?? null,
          description: deal.description ?? null,
          percent_off: deal.percent_off ?? null,
          deal_type: deal.deal_type ?? null,
          promo_code: deal.promo_code ?? null,
          expiration_date: deal.expiration_date ?? null,
          categories: deal.categories ?? [],
          keywords: deal.keywords ?? [],
          deal_subtype: deal.deal_subtype ?? null,
          redemption_channel: deal.redemption_channel ?? null,
          decision,
          reason,
          deal_id: dealId,
          raw_candidate: deal,
        })
      if (error) console.error('[ingest] candidate audit error:', JSON.stringify(error))
    }

    async function processEmail(email: (typeof newEmails)[number]): Promise<void> {
      const emailStartedAt = Date.now()
      const emailAuditId = await startEmailAudit(email)

      // Skip emails already processed this week — prevents duplicate deals when
      // a backfill re-run hits the same inbox window and the LLM returns a
      // slightly different description, bypassing the deal-key dedup.
      if (!reprocess && alreadyProcessedIds.has(email.id)) {
        console.log(`[ingest] skip already-processed: ${email.id}`)
        await finishEmailAudit(emailAuditId, {
          outcome: 'already_processed',
          outcome_detail: 'Previously recorded in processed_emails for this week',
          processing_ms: Date.now() - emailStartedAt,
        })
        processedUids.push(email.uid)
        return
      }

      // Block unwanted sources before body parsing, image fetches, or LLM calls.
      if (isBlockedEmailSender(email.from)) {
        console.log(`[ingest] skip blocked sender: ${email.from}`)
        await finishEmailAudit(emailAuditId, {
          outcome: 'blocked_sender_skipped',
          outcome_detail: 'Sender matched the blocked-retailer list',
          processing_ms: Date.now() - emailStartedAt,
        })
        await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
        processedEmailIds.push(email.id)
        processedUids.push(email.uid)
        return
      }

      if (!reprocess && isEmailOlderThanDays(email.date, INGEST_MAX_EMAIL_AGE_DAYS)) {
        console.log(`[ingest] skip stale email (${INGEST_MAX_EMAIL_AGE_DAYS}d cutoff): ${email.id}`)
        await finishEmailAudit(emailAuditId, {
          outcome: 'stale_skipped',
          outcome_detail: `Email received more than ${INGEST_MAX_EMAIL_AGE_DAYS} days ago`,
          processing_ms: Date.now() - emailStartedAt,
        })
        await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
        emailsSkippedStale++
        processedEmailIds.push(email.id)
        processedUids.push(email.uid)
        return
      }

      // Fast-path: skip obviously transactional emails without an OpenAI call
      if (isTransactionalEmail(email.subject)) {
        console.log(`[ingest] skip transactional: "${email.subject}"`)
        await finishEmailAudit(emailAuditId, {
          outcome: 'transactional_skipped',
          outcome_detail: 'Subject matched transactional-email filter',
          processing_ms: Date.now() - emailStartedAt,
        })
        await supabase.from('processed_emails').upsert({ email_id: email.id, week_of: weekOfStr })
        processedEmailIds.push(email.id)
        processedUids.push(email.uid)
        return
      }

      let emailBody = email.body
      const sparseOriginalBody = isBodySparse(email.body)
      let webVersionUsed = false
      let imageCount = 0
      let extractionMethod = 'text'
      let insertedForEmail = 0
      let rejectedForEmail = 0
      let duplicatesForEmail = 0
      let imageUrlsForExtraction: string[] = []
      if (sparseOriginalBody && email.viewInBrowserUrl) {
        console.log(`[ingest] sparse body, fetching web version: ${email.viewInBrowserUrl}`)
        const webHtml = await fetchWebVersion(email.viewInBrowserUrl)
        if (webHtml) {
          emailBody = webHtml
          webVersionUsed = true
          console.log(`[ingest] web version fetched (${webHtml.length} chars)`)
        } else {
          console.log(`[ingest] web version fetch failed, using original body`)
        }
      }

      imageUrlsForExtraction = extractEmailImageUrls(`${email.body}\n${emailBody}`, INGEST_MAX_IMAGE_URLS)
      let extracted = await extractDealsFromEmail(email.from, email.subject, emailBody, allCategories)
      console.log(`[ingest] ${email.from} | subject: ${email.subject} | text extracted: ${extracted.length}`)

      const scanDollarCouponImages = shouldScanImagesForDollarCoupons(
        `${email.subject}\n${email.body}\n${emailBody}`,
        extracted,
      )
      if (sparseOriginalBody || extracted.length === 0 || scanDollarCouponImages) {
        imageCount = imageUrlsForExtraction.length
        if (imageUrlsForExtraction.length > 0) {
          const visionReason = sparseOriginalBody
            ? 'sparse body'
            : extracted.length === 0
              ? 'no text deals'
              : 'digital coupon images'
          console.log(
            `[ingest] vision fallback (${visionReason}): ${imageUrlsForExtraction.length} images`
          )
          const imageExtracted = await extractDealsFromEmailImages(
            email.from,
            email.subject,
            imageUrlsForExtraction,
            allCategories,
          )
          if (imageExtracted.length > 0) {
            extracted = scanDollarCouponImages && extracted.length > 0
              ? [...extracted, ...imageExtracted]
              : imageExtracted
            extractionMethod = scanDollarCouponImages && extracted.length > imageExtracted.length
              ? 'text+vision'
              : 'vision'
            console.log(`[ingest] ${email.from} | subject: ${email.subject} | image extracted: ${extracted.length}`)
          } else {
            console.log(`[ingest] vision fallback found no deals`)
          }
        } else {
          console.log(`[ingest] vision fallback skipped: no usable image URLs`)
        }
      }

      if (!dryRun) {
        const enqueued = await enqueueOpenRouterShadowJob(supabase, {
          auditRunId,
          emailAuditId,
          email,
          cleanedBody: cleanEmailBodyForExtraction(emailBody),
          imageUrls: imageUrlsForExtraction,
          productionOutput: createNormalizedExtractionOutput({
            provider: PRIMARY_EXTRACTION_PROVIDER,
            model: getPrimaryExtractionModel(),
            method: extractionMethod === 'vision' ? 'vision' : 'text',
            deals: extracted,
            schemaValid: getExtractionSchemaValidity(extracted),
          }),
        })
        if (enqueued) {
          console.log(`[ingest] queued OpenRouter shadow extraction for ${email.id}`)
        }
      }

      console.log(`[ingest] ${email.from} | subject: ${email.subject} | extracted: ${extracted.length}`)
      extractedCandidates += extracted.length
      await resolveStoreForSender(fixRetailerCase(parseSenderName(email.from)), email, [], false)
      if (extracted.length > 0) emailsWithDeals++
      else {
        emailsWithNoDeals++
        await resolveStoreForSender(fixRetailerCase(parseSenderName(email.from)), email)
      }

      for (const deal of extracted) {
        // Skip deals with no real value
        if (!deal.description || !deal.retailer) {
          rejectedForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            deal as Record<string, unknown>,
            'rejected_invalid',
            'Missing retailer or description',
          )
          continue
        }

        // Title-case all-lowercase LLM output ("carter's" → "Carter's")
        // without overriding mixed-case extractions
        const retailer = fixRetailerCase(deal.retailer)
        if (isBlockedRetailer(retailer)) {
          console.log(`[ingest] skipping blocked retailer: ${retailer}`)
          rejectedForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            deal as Record<string, unknown>,
            'rejected_junk',
            'Retailer matched the blocked-retailer list',
          )
          continue
        }
        const normalizedDeal = {
          ...deal,
          retailer,
          deal_type:
            !deal.percent_off &&
            !deal.promo_code &&
            isPricePointDescription(deal.description)
              ? 'price-point' as const
              : deal.deal_type,
        }

        const junkReason = getJunkDealReason(normalizedDeal)
        if (junkReason) {
          console.log(`[ingest] skipping junk deal: ${retailer} — "${deal.description.slice(0, 80)}"`)
          rejectedForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            normalizedDeal as Record<string, unknown>,
            'rejected_junk',
            junkReason,
          )
          continue
        }

        const dealKey = makeDealKey(normalizedDeal)

        const storeMatch = await resolveStoreForSender(retailer, email, deal.categories ?? [])

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
        // merge in newly learned categories such as the added furniture slug.
        // This keeps existing deal rows useful without creating duplicate
        // cards for the same promotion.
        const existingDeal = existingDealByKey.get(dealKey)
        if (existingDeal) {
          const { update, metadataChanged } = buildDuplicateDealRefresh(
            existingDeal,
            {
              categories: mergedCategories,
              keywords: deal.keywords,
              deal_subtype: deal.deal_subtype,
              redemption_channel: deal.redemption_channel,
            },
            new Date().toISOString(),
          )
          const { error: updateError } = await supabase
            .from('deals')
            .update(update)
            .eq('id', existingDeal.id)
          if (updateError) {
            console.error('[ingest] duplicate refresh error:', JSON.stringify(updateError))
          } else {
            existingDeal.categories = update.categories
            existingDeal.keywords = update.keywords
            existingDeal.redemption_channel = update.redemption_channel
            if (metadataChanged) {
              console.log(`[ingest] enriched duplicate deal: ${retailer} → keywords=[${update.keywords.join(',')}]`)
            } else {
              console.log(`[ingest] refreshed duplicate deal: ${retailer} ${deal.deal_type} ${deal.percent_off}%`)
            }
          }
          duplicatesForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            { ...normalizedDeal, categories: mergedCategories } as Record<string, unknown>,
            metadataChanged ? 'duplicate_enriched' : 'duplicate_existing',
            metadataChanged ? 'Existing weekly deal enriched with new metadata' : 'Existing weekly deal matched dedup key and refreshed last_seen_at',
            existingDeal.id,
          )
          continue
        }
        if (seenDealKeys.has(dealKey)) {
          console.log(`[ingest] skipping in-run duplicate: ${retailer} ${deal.deal_type} ${deal.percent_off}%`)
          duplicatesForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            { ...normalizedDeal, categories: mergedCategories } as Record<string, unknown>,
            'duplicate_in_run',
            'Another email in this ingest run produced the same deal key',
          )
          continue
        }
        seenDealKeys.add(dealKey)

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
          // The extraction model may still return deal_subtype; it lives on
          // as one more keyword rather than its own column.
          keywords: mergeSubtypeIntoKeywords(deal.keywords, deal.deal_subtype),
          redemption_channel: deal.redemption_channel ?? 'online',
          last_seen_at: new Date().toISOString(),
          week_of: weekOfStr,
          source_email_id: email.id,
          source_email_link: email.viewInBrowserUrl ?? null,
          is_manual: email.isManual,
        }

        // Lazy-fill store content categories: the first time we see a deal
        // from this store in this run, if its row carries no content-
        // category slugs, ask the LLM what the brand sells overall
        // (Walmart → 50+, Boll & Branch → 2) and merge the answer into
        // stores.categories alongside any editorial Collections tags.
        if (!dryRun && storeMatch && !storeCategoriesChecked.has(storeMatch.id)) {
          storeCategoriesChecked.add(storeMatch.id)
          const hasContentCategories = storeMatch.categories.some((c) => contentSlugs.has(c))
          if (!hasContentCategories) {
            const retailerCats = await getRetailerCategories(retailer, allCategories)
            if (retailerCats.length > 0) {
              const mergedStoreCategories = Array.from(
                new Set([...storeMatch.categories, ...retailerCats])
              )
              const { error } = await supabase
                .from('stores')
                .update({ categories: mergedStoreCategories })
                .eq('id', storeMatch.id)
              if (error) {
                console.error('[ingest] store categories upsert error:', JSON.stringify(error))
              } else {
                storeMatch.categories = mergedStoreCategories
                console.log(`[ingest] store categories: ${retailer} → ${retailerCats.join(', ')}`)
              }
            }
          }
        }

        if (dryRun) {
          console.log(`[DRY RUN] would insert deal: ${retailer} — ${deal.deal_type} — ${deal.description?.slice(0, 80)}`)
          dryRunWouldInsertDeals.push({ retailer, deal_type: deal.deal_type, description: deal.description ?? '' })
          newDeals++
          insertedForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            dealRow as Record<string, unknown>,
            'dry_run_would_insert',
          )
          continue
        }

        // Plain insert: the processed_emails table already prevents
        // re-processing the same email, and the in-run seenDealKeys set
        // catches duplicates within a single run. There's no unique
        // constraint on (source_email_id, retailer) on the deals table,
        // so an upsert with that onConflict spec fails with Postgres
        // 42P10 — which silently dropped every deal extracted between
        // 2026-04-30 and 2026-05-07.
        const { data: insertedDeal, error: insertError } = await supabase
          .from('deals')
          .insert(dealRow)
          .select('id')
          .single()
        if (insertError) {
          console.error('Deal insert error:', JSON.stringify(insertError))
          rejectedForEmail++
          await auditCandidate(
            emailAuditId,
            email.id,
            dealRow as Record<string, unknown>,
            'insert_failed',
            insertError.message,
          )
          continue
        }
        newDeals++
        insertedForEmail++
        await auditCandidate(
          emailAuditId,
          email.id,
          dealRow as Record<string, unknown>,
          'inserted',
          null,
          insertedDeal?.id ?? null,
        )

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

      await finishEmailAudit(emailAuditId, {
        web_version_used: webVersionUsed,
        image_count: imageCount,
        extraction_method: extractionMethod,
        extracted_count: extracted.length,
        inserted_count: insertedForEmail,
        rejected_count: rejectedForEmail,
        duplicate_count: duplicatesForEmail,
        outcome: extracted.length === 0
          ? 'no_deals_extracted'
          : insertedForEmail > 0
            ? 'deals_inserted'
            : rejectedForEmail > 0
              ? 'all_candidates_rejected'
              : duplicatesForEmail > 0
                ? 'duplicates_only'
                : 'extracted_no_insert',
        outcome_detail: extracted.length === 0
          ? 'LLM text and vision extraction returned no deal candidates'
          : null,
        processing_ms: Date.now() - emailStartedAt,
      })
    }

    // Concurrency-limited worker pool — N workers run in parallel and pick
    // up the next email as soon as their current one finishes, eliminating
    // the head-of-line blocking of the previous batched approach.
    const tProcessStart = Date.now()
    await runWithConcurrency(newEmails, effectiveConcurrency, async (email) => {
      try {
        await processEmail(email)
      } catch (err) {
        if (err instanceof ApiCreditExhaustedError) {
          apiCreditExhausted = true
          console.error(`[ingest] API credits exhausted — aborting remaining emails`)
        } else if (err instanceof ApiRateLimitError) {
          rateLimitPauseUntil = Date.now() + err.retryAfterMs
          console.warn(
            `[ingest] rate limited — pausing all workers for ${Math.round(err.retryAfterMs / 1000)}s`
          )
        } else if (err instanceof ApiSchemaValidationError) {
          rateLimitPauseUntil = Date.now() + 60_000
          console.warn('[ingest] extraction schema validation failed — leaving email unprocessed for retry')
        } else {
          console.error(`Failed to process email ${email.id}:`, err)
        }
        failedUids.push(email.uid)
        if (auditRunId) {
          await supabase
            .from('ingest_email_audit')
            .update({
              outcome: 'failed',
              outcome_detail: err instanceof Error ? err.message : String(err),
            })
            .eq('run_id', auditRunId)
            .eq('email_id', email.id)
        }
      }
    }, {
      shouldAbort: () => apiCreditExhausted,
      getPauseUntil: () => rateLimitPauseUntil,
    })
    console.log(
      `[ingest] processed ${newEmails.length} emails in ${Date.now() - tProcessStart}ms ` +
        `(${emailsWithDeals} with deals, ${emailsWithNoDeals} empty, ${newDeals} new deals)`
    )

    if (apiCreditExhausted) {
      const skipped = newEmails.length - processedEmailIds.length
      await sendAdminAlert({
        subject: '🚨 Deal Dossier — AI API credits exhausted',
        body: `Primary extraction provider API credits are exhausted. Ingest stopped early at ${new Date().toISOString()}\n\n` +
              `Emails skipped (unprocessed, will retry automatically): ~${skipped}\n\n` +
              `Action required:\n` +
              `1. Add credits at https://aistudio.google.com/\n` +
              `2. Once credits are restored, the next hourly cron will retry unprocessed emails automatically.\n` +
              `   (The cursor was NOT advanced past failed emails — no reprocess flag needed.)\n\n` +
              `Admin: https://dealdossier.io/admin`,
      })
    }

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
      const newLastUid = computeSafeCursorAfterProduction(cursor.afterUid, processedUids, failedUids)
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
      emails_skipped_stale: emailsSkippedStale,
      new_deals: newDeals,
      total_deals_this_week: totalDeals ?? 0,
      mode: forceDateWindow ? 'backfill' : 'cursor',
      lookback_hours: lookbackHours,
      per_run_limit: perRunLimit,
      concurrency: effectiveConcurrency,
      reprocess,
      offset: selectedOffset,
      next_offset: deferred > 0 ? selectedOffset + newEmails.length : null,
      audit_run_id: auditRunId,
      cursor: {
        last_uid: !forceDateWindow && processedUids.length > 0
          ? computeSafeCursorAfterProduction(cursor.afterUid, processedUids, failedUids)
          : cursor.afterUid,
        uid_validity: fetchResult.uidValidity,
      },
    }

    if (dryRun) {
      response.dry_run = true
      response.would_auto_add = dryRunWouldAutoAdd
      response.would_insert_deals = dryRunWouldInsertDeals
    }

    if (auditRunId) {
      await supabase
        .from('ingest_runs')
        .update({
          completed_at: new Date().toISOString(),
          deals_extracted: extractedCandidates,
          deals_inserted: dryRun ? 0 : newDeals,
          status: apiCreditExhausted ? 'credit_exhausted' : failedUids.length > 0 ? 'completed_with_errors' : 'completed',
          error: apiCreditExhausted ? 'Primary extraction provider API credits exhausted' : failedUids.length > 0 ? `${failedUids.length} email(s) failed` : null,
        })
        .eq('id', auditRunId)
    }

    return NextResponse.json(response)
  } catch (err) {
    console.error('Ingest error:', err)
    if (auditRunId) {
      await supabase
        .from('ingest_runs')
        .update({
          completed_at: new Date().toISOString(),
          status: 'failed',
          error: err instanceof Error ? err.message : String(err),
        })
        .eq('id', auditRunId)
    }
    await sendAdminAlert({
      subject: '🚨 Deal Dossier — ingest failed',
      body: `Ingest failed at ${new Date().toISOString()}\n\nError: ${err instanceof Error ? err.message : String(err)}\n\nFix it at: https://dealdossier.io/admin`,
    })
    return NextResponse.json({
      error: 'Ingestion failed',
      detail: err instanceof Error ? err.message : String(err),
    }, { status: 500 })
  }
}
