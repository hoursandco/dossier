import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'
import { buildBrandAliasCandidates } from '@/lib/brandAliasAudit'
import { orderedStorePair } from '@/lib/brandRelationships'

export const dynamic = 'force-dynamic'
export const maxDuration = 60

export async function GET(request: NextRequest) {
  const startedAt = Date.now()
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const db = createServiceClient()
  const ninetyDaysAgo = new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString()
  const PAGE_SIZE = 1000
  const EVIDENCE_SAMPLE_SIZE = 1000

  const loadStores = async () => {
    const rows: Array<{ id: string; name: string; website: string | null; status: string | null; is_active: boolean }> = []
    for (let page = 0; page < 10; page++) {
      const result = await db.from('stores')
        .select('id, name, website, status, is_active')
        .order('name', { ascending: true })
        .range(page * PAGE_SIZE, (page + 1) * PAGE_SIZE - 1)
      if (result.error) return { rows, error: result.error }
      rows.push(...(result.data ?? []))
      if ((result.data?.length ?? 0) < PAGE_SIZE) break
    }
    return { rows, error: null }
  }

  // Store rows are the authoritative audit scope, so load all of them.
  // Deal and sender rows are supporting evidence only. Sampling the newest
  // 1,000 of each keeps this admin request comfortably below serverless
  // timeouts; the previous version serially paged up to 10,000 rows from
  // both evidence tables before returning anything.
  const [storesResult, dealsResult, scansResult, reviewsResult] = await Promise.all([
    loadStores(),
    db.from('deals')
      .select('retailer, original_link')
      .gte('created_at', ninetyDaysAgo)
      .order('created_at', { ascending: false })
      .limit(EVIDENCE_SAMPLE_SIZE),
    db.from('retailer_scan_log')
      .select('retailer, sender_email')
      .order('emails_processed', { ascending: false })
      .limit(EVIDENCE_SAMPLE_SIZE),
    db.from('brand_relationship_reviews')
      .select('store_a_id, store_b_id, decision, parent_store_id, child_store_id, updated_at')
      .limit(5000),
  ])

  if (storesResult.error) {
    console.error('[alias audit] stores load error:', JSON.stringify(storesResult.error))
    return NextResponse.json({ error: 'Failed to load stores' }, { status: 500 })
  }

  if (dealsResult.error) console.warn('[alias audit] deal evidence unavailable:', JSON.stringify(dealsResult.error))
  if (scansResult.error) console.warn('[alias audit] sender evidence unavailable:', JSON.stringify(scansResult.error))
  const reviewsUnavailable = !!reviewsResult.error
  if (reviewsResult.error) {
    const code = (reviewsResult.error as { code?: string }).code
    if (code !== '42P01' && code !== 'PGRST205') {
      console.warn('[alias audit] reviews unavailable:', JSON.stringify(reviewsResult.error))
    }
  }

  const dealRows = dealsResult.data ?? []
  const scanRows = scansResult.data ?? []
  const reviewsByPair = new Map(
    (reviewsResult.data ?? []).map((review) => [
      orderedStorePair(review.store_a_id, review.store_b_id).join('::'),
      review,
    ]),
  )
  const allCandidates = buildBrandAliasCandidates(storesResult.rows, dealRows, scanRows)
    .map((candidate) => ({
      ...candidate,
      review: reviewsByPair.get(
        orderedStorePair(candidate.left.id, candidate.right.id).join('::'),
      ) ?? null,
    }))

  const page = Math.max(1, Number(request.nextUrl.searchParams.get('page')) || 1)
  const perPage = 10
  const reviewStatus = request.nextUrl.searchParams.get('review_status') ?? 'unreviewed'
  const confidence = request.nextUrl.searchParams.get('confidence') ?? 'all'
  const q = request.nextUrl.searchParams.get('q')?.trim().toLowerCase() ?? ''
  const filteredCandidates = allCandidates.filter((candidate) => {
    if (reviewStatus === 'unreviewed' && candidate.review) return false
    if (reviewStatus === 'reviewed' && !candidate.review) return false
    if (confidence !== 'all' && candidate.confidence !== confidence) return false
    if (q) {
      const haystack = `${candidate.left.name} ${candidate.right.name} ${candidate.evidence.map((item) => item.label).join(' ')}`.toLowerCase()
      if (!haystack.includes(q)) return false
    }
    return true
  })
  const totalPages = Math.max(1, Math.ceil(filteredCandidates.length / perPage))
  const safePage = Math.min(page, totalPages)
  const start = (safePage - 1) * perPage
  const candidates = filteredCandidates.slice(start, start + perPage)

  return NextResponse.json({
    candidates,
    candidate_count: allCandidates.length,
    filtered_count: filteredCandidates.length,
    high_confidence_count: allCandidates.filter((candidate) => candidate.confidence === 'high').length,
    reviewed_count: allCandidates.filter((candidate) => candidate.review).length,
    page: safePage,
    per_page: perPage,
    total_pages: totalPages,
    evidence_window_days: 90,
    stores_reviewed: storesResult.rows.length,
    evidence_rows_reviewed: {
      deals: dealRows.length,
      senders: scanRows.length,
    },
    generated_in_ms: Date.now() - startedAt,
    reviews_available: !reviewsUnavailable,
  })
}
