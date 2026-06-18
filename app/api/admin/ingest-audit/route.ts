import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const db = createServiceClient()
  const requestedRunId = request.nextUrl.searchParams.get('run_id')
  const outcome = request.nextUrl.searchParams.get('outcome')
  const decision = request.nextUrl.searchParams.get('decision')

  const { data: runs, error: runsError } = await db
    .from('ingest_runs')
    .select('id, mode, lookback_hours, requested_limit, reprocess, started_at, completed_at, emails_fetched, emails_selected, emails_deferred, deals_extracted, deals_inserted, status, error')
    .order('started_at', { ascending: false })
    .limit(30)

  if (runsError) {
    return NextResponse.json({
      error: 'Ingest audit tables are not available yet.',
      setup_required: true,
      detail: runsError.message,
    }, { status: 503 })
  }

  const runId = requestedRunId || runs?.[0]?.id || null
  if (!runId) {
    return NextResponse.json({ runs: [], run_id: null, emails: [], candidates: [] })
  }

  let emailsQuery = db
    .from('ingest_email_audit')
    .select('id, run_id, email_id, uid, sender, subject, received_at, body_sparse, web_version_used, image_count, extraction_method, extracted_count, inserted_count, rejected_count, duplicate_count, outcome, outcome_detail, processing_ms, created_at')
    .eq('run_id', runId)
    .order('uid', { ascending: true })
    .limit(500)
  if (outcome) emailsQuery = emailsQuery.eq('outcome', outcome)

  let candidatesQuery = db
    .from('ingest_deal_candidates')
    .select('id, email_audit_id, email_id, retailer, description, percent_off, deal_type, promo_code, expiration_date, categories, keywords, deal_subtype, decision, reason, deal_id, created_at')
    .eq('run_id', runId)
    .order('created_at', { ascending: true })
    .limit(1000)
  if (decision) candidatesQuery = candidatesQuery.eq('decision', decision)

  const [
    { data: emails, error: emailsError },
    { data: candidates, error: candidatesError },
  ] = await Promise.all([emailsQuery, candidatesQuery])

  if (emailsError || candidatesError) {
    return NextResponse.json({
      error: 'Could not load ingest audit details.',
      detail: emailsError?.message || candidatesError?.message,
    }, { status: 500 })
  }

  return NextResponse.json({
    runs: runs ?? [],
    run_id: runId,
    emails: emails ?? [],
    candidates: candidates ?? [],
  })
}
