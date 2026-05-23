// GET /api/admin/subscriptions
//
// Admin-only — returns subscribers with Stripe state attached.
// Powers the "Subscriptions" panel on /admin.
//
// Query params:
//   q       — case-insensitive email substring search (optional)
//   limit   — page size, default 5, max 50
//   offset  — page offset, default 0
//
// Pagination is server-side so we don't enrich Stripe state for the
// entire subscriber base on every page load (1 API call per row).
// At scale that would be slow + chew through Stripe API quotas.
//
// Stripe lookups are best-effort: a missing/invalid customer_id
// surfaces as null fields rather than failing the whole call.

import { NextRequest, NextResponse } from 'next/server'
import type Stripe from 'stripe'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'
export const maxDuration = 60

type SubscriberRow = {
  id: string
  email: string
  tier: string | null
  is_comped: boolean | null
  comped_at: string | null
  comped_reason: string | null
  stripe_customer_id: string | null
  stripe_subscription_id: string | null
  stripe_price_id: string | null
  subscription_status: string | null
  created_at: string
}

async function getStripeView(
  stripe: Stripe,
  subscriptionId: string | null
): Promise<{
  status: string | null
  current_period_end: string | null
  cancel_at_period_end: boolean | null
  amount: number | null
  currency: string | null
  interval: string | null
  latest_invoice_id: string | null
}> {
  if (!subscriptionId) {
    return {
      status: null,
      current_period_end: null,
      cancel_at_period_end: null,
      amount: null,
      currency: null,
      interval: null,
      latest_invoice_id: null,
    }
  }
  try {
    const sub = await stripe.subscriptions.retrieve(subscriptionId)
    // The price+amount come from the first item — we never sell multi-line subs.
    const item = sub.items.data[0]
    const price = item?.price
    const periodEndUnix =
      (item as Stripe.SubscriptionItem & { current_period_end?: number })?.current_period_end ??
      null
    return {
      status: sub.status,
      current_period_end: periodEndUnix
        ? new Date(periodEndUnix * 1000).toISOString()
        : null,
      cancel_at_period_end: sub.cancel_at_period_end,
      amount: price?.unit_amount ?? null,
      currency: price?.currency ?? null,
      interval: price?.recurring?.interval ?? null,
      latest_invoice_id:
        typeof sub.latest_invoice === 'string'
          ? sub.latest_invoice
          : sub.latest_invoice?.id ?? null,
    }
  } catch (err) {
    console.warn(
      `[admin/subscriptions] stripe lookup failed for sub ${subscriptionId}:`,
      err instanceof Error ? err.message : err
    )
    return {
      status: 'lookup_failed',
      current_period_end: null,
      cancel_at_period_end: null,
      amount: null,
      currency: null,
      interval: null,
      latest_invoice_id: null,
    }
  }
}

export async function GET(req: NextRequest) {
  // Admin gate
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  // ── Parse + clamp query params ────────────────────────────────────────
  const url = new URL(req.url)
  const q = (url.searchParams.get('q') ?? '').trim()
  const limit = Math.min(50, Math.max(1, Number(url.searchParams.get('limit')) || 5))
  const offset = Math.max(0, Number(url.searchParams.get('offset')) || 0)
  // PostgREST escapes for ilike — `%` and `_` are wildcards; backslash
  // escapes them. Keeps the search literal so a stray `_` doesn't match
  // unintended characters.
  const safeQ = q ? q.replace(/[\\%_]/g, '\\$&') : null

  const service = createServiceClient()

  // Try the full select with comp fields first; fall back if migration
  // 026 hasn't been applied yet (column won't exist → 42703). That way
  // the panel still works pre-migration — comp actions just won't be
  // available until is_comped exists.
  const FULL_COLS =
    'id, email, tier, is_comped, comped_at, comped_reason, stripe_customer_id, stripe_subscription_id, stripe_price_id, subscription_status, created_at'
  const LEGACY_COLS =
    'id, email, tier, stripe_customer_id, stripe_subscription_id, stripe_price_id, subscription_status, created_at'

  let rows: unknown[] | null = null
  let total = 0

  // First attempt: full schema with is_comped.
  {
    let q = service
      .from('subscribers')
      .select(FULL_COLS, { count: 'exact' })
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1)
    if (safeQ) q = q.ilike('email', `%${safeQ}%`)
    const result = await q
    if (!result.error) {
      rows = result.data
      total = result.count ?? 0
    } else if ((result.error as { code?: string }).code === '42703') {
      // Pre-migration-026 fallback.
      console.warn('[admin/subscriptions] is_comped missing — falling back. Run migration 026.')
      let q2 = service
        .from('subscribers')
        .select(LEGACY_COLS, { count: 'exact' })
        .order('created_at', { ascending: false })
        .range(offset, offset + limit - 1)
      if (safeQ) q2 = q2.ilike('email', `%${safeQ}%`)
      const result2 = await q2
      if (result2.error) {
        console.error('[admin/subscriptions] fallback also failed:', JSON.stringify(result2.error))
        return NextResponse.json({ error: 'Failed to load subscribers' }, { status: 500 })
      }
      rows = (result2.data ?? []).map((r) => ({
        ...r,
        is_comped: false,
        comped_at: null,
        comped_reason: null,
      }))
      total = result2.count ?? 0
    } else {
      console.error('[admin/subscriptions] load error:', JSON.stringify(result.error))
      return NextResponse.json({ error: 'Failed to load subscribers' }, { status: 500 })
    }
  }

  const subscribers = (rows ?? []) as SubscriberRow[]

  // Hit Stripe in parallel — only for the visible page, so cost scales
  // with page size (default 5), not total subscriber count.
  const stripe = getStripe()
  const enriched = await Promise.all(
    subscribers.map(async (s) => ({
      ...s,
      stripe: await getStripeView(stripe, s.stripe_subscription_id),
    }))
  )

  return NextResponse.json({
    subscribers: enriched,
    total,
    limit,
    offset,
    q,
  })
}
