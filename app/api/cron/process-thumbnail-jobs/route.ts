import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import {
  ApiCreditExhaustedError,
  ApiRateLimitError,
  selectDealThumbnailCrop,
} from '@/lib/openai'
import { createDealThumbnail } from '@/lib/dealImages'

export const dynamic = 'force-dynamic'
export const maxDuration = 300

const DEFAULT_BATCH_LIMIT = 6
const DEFAULT_CONCURRENCY = 1
const MAX_BATCH_LIMIT = 20
const MAX_CONCURRENCY = 3
const MAX_ATTEMPTS = 3

interface DealThumbnailJob {
  id: string
  deal_id: string
  retailer: string
  description: string
  deal_type: string
  categories: string[] | null
  keywords: string[] | null
  image_urls: string[] | null
  attempt_count: number
}

function verifyCronSecret(request: NextRequest): boolean {
  const secret = process.env.CRON_SECRET
  if (!secret) return false
  return request.headers.get('authorization') === `Bearer ${secret}`
}

function boundedInt(value: string | null, fallback: number, max: number): number {
  const parsed = value ? Number(value) : NaN
  if (!Number.isFinite(parsed)) return fallback
  return Math.min(max, Math.max(1, Math.floor(parsed)))
}

function retryDelayMs(attemptCount: number): number {
  return Math.min(60 * 60 * 1000, 60_000 * Math.pow(2, Math.max(0, attemptCount)))
}

async function runWithConcurrency<T, R>(
  items: T[],
  concurrency: number,
  worker: (item: T) => Promise<R>,
): Promise<R[]> {
  const results: R[] = []
  let index = 0
  const next = async (): Promise<void> => {
    while (true) {
      const current = index++
      if (current >= items.length) return
      results[current] = await worker(items[current])
    }
  }
  await Promise.all(
    Array.from({ length: Math.min(concurrency, items.length) }, () => next())
  )
  return results
}

async function processJob(
  supabase: ReturnType<typeof createServiceClient>,
  job: DealThumbnailJob,
): Promise<{ id: string; status: 'completed' | 'pending' | 'failed'; error?: string }> {
  const attemptCount = (job.attempt_count ?? 0) + 1
  const imageUrls = Array.isArray(job.image_urls) ? job.image_urls : []
  if (imageUrls.length === 0) {
    await supabase
      .from('deal_thumbnail_jobs')
      .update({
        status: 'failed',
        attempt_count: attemptCount,
        last_error: 'No image URLs available',
        completed_at: new Date().toISOString(),
        locked_at: null,
        locked_by: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', job.id)
    return { id: job.id, status: 'failed', error: 'No image URLs available' }
  }

  try {
    const selection = await selectDealThumbnailCrop(
      {
        retailer: job.retailer,
        description: job.description,
        deal_type: job.deal_type,
        categories: job.categories ?? [],
        keywords: job.keywords ?? [],
      },
      imageUrls,
    )
    if (!selection) {
      await supabase
        .from('deal_thumbnail_jobs')
        .update({
          status: 'failed',
          attempt_count: attemptCount,
          last_error: 'No acceptable product image selected',
          completed_at: new Date().toISOString(),
          locked_at: null,
          locked_by: null,
          updated_at: new Date().toISOString(),
        })
        .eq('id', job.id)
      return { id: job.id, status: 'failed', error: 'No acceptable product image selected' }
    }

    const thumbnail = await createDealThumbnail(supabase, {
      dealId: job.deal_id,
      retailer: job.retailer,
      description: job.description,
      selection,
    })
    if (!thumbnail) {
      throw new Error('Thumbnail crop/upload failed')
    }

    const { error: dealUpdateError } = await supabase
      .from('deals')
      .update(thumbnail)
      .eq('id', job.deal_id)
    if (dealUpdateError) throw new Error(dealUpdateError.message)

    await supabase
      .from('deal_thumbnail_jobs')
      .update({
        status: 'completed',
        attempt_count: attemptCount,
        last_error: null,
        completed_at: new Date().toISOString(),
        locked_at: null,
        locked_by: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', job.id)
    return { id: job.id, status: 'completed' }
  } catch (err) {
    const retryable =
      err instanceof ApiCreditExhaustedError ||
      err instanceof ApiRateLimitError ||
      (err instanceof Error && /rate|timeout|temporar|overload|fetch/i.test(err.message))
    const shouldRetry = retryable && attemptCount < MAX_ATTEMPTS
    const nextAttemptAt = new Date(Date.now() + retryDelayMs(attemptCount)).toISOString()
    const message = err instanceof Error ? err.message : String(err)

    await supabase
      .from('deal_thumbnail_jobs')
      .update({
        status: shouldRetry ? 'pending' : 'failed',
        attempt_count: attemptCount,
        next_attempt_at: shouldRetry ? nextAttemptAt : new Date().toISOString(),
        last_error: message,
        completed_at: shouldRetry ? null : new Date().toISOString(),
        locked_at: null,
        locked_by: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', job.id)
    return { id: job.id, status: shouldRetry ? 'pending' : 'failed', error: message }
  }
}

export async function GET(request: NextRequest) {
  if (!verifyCronSecret(request)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const supabase = createServiceClient()
  const limit = boundedInt(request.nextUrl.searchParams.get('limit'), DEFAULT_BATCH_LIMIT, MAX_BATCH_LIMIT)
  const concurrency = boundedInt(request.nextUrl.searchParams.get('concurrency'), DEFAULT_CONCURRENCY, MAX_CONCURRENCY)
  const workerId = `thumbnail-${Date.now()}-${Math.random().toString(36).slice(2)}`
  const now = new Date().toISOString()
  const staleBefore = new Date(Date.now() - 10 * 60 * 1000).toISOString()

  await supabase
    .from('deal_thumbnail_jobs')
    .update({
      status: 'pending',
      locked_at: null,
      locked_by: null,
      next_attempt_at: now,
      updated_at: now,
      last_error: 'Reset stale processing job',
    })
    .eq('status', 'processing')
    .lt('locked_at', staleBefore)

  const { data: jobs, error: loadError } = await supabase
    .from('deal_thumbnail_jobs')
    .select('id, deal_id, retailer, description, deal_type, categories, keywords, image_urls, attempt_count')
    .eq('status', 'pending')
    .lte('next_attempt_at', now)
    .order('created_at', { ascending: true })
    .limit(limit)

  if (loadError) {
    console.error('[thumbnail-jobs] load error:', JSON.stringify(loadError))
    return NextResponse.json({ error: 'Failed to load thumbnail jobs' }, { status: 500 })
  }

  const pending = (jobs ?? []) as DealThumbnailJob[]
  if (pending.length === 0) {
    return NextResponse.json({ claimed: 0, completed: 0, pending: 0, failed: 0 })
  }

  const ids = pending.map((job) => job.id)
  const { error: claimError } = await supabase
    .from('deal_thumbnail_jobs')
    .update({
      status: 'processing',
      locked_at: now,
      locked_by: workerId,
      updated_at: now,
    })
    .in('id', ids)
    .eq('status', 'pending')
  if (claimError) {
    console.error('[thumbnail-jobs] claim error:', JSON.stringify(claimError))
    return NextResponse.json({ error: 'Failed to claim thumbnail jobs' }, { status: 500 })
  }

  const results = await runWithConcurrency(pending, concurrency, (job) => processJob(supabase, job))
  return NextResponse.json({
    claimed: pending.length,
    completed: results.filter((result) => result.status === 'completed').length,
    pending: results.filter((result) => result.status === 'pending').length,
    failed: results.filter((result) => result.status === 'failed').length,
    results,
  })
}
