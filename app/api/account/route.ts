// GET   /api/account  — authenticated subscriber summary (email, tier,
//                       billing-account flag, weekly email opt-in)
// PATCH /api/account  — update the weekly_email_enabled toggle
//
// Replaces the digest-era /api/preferences (which read fields that no
// longer exist on subscribers).

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()
  const { data: subscriber } = await service
    .from('subscribers')
    .select('id, tier, subscription_status, stripe_customer_id, weekly_email_enabled, min_discount_pct, allowed_price_tiers, comp_expires_at')
    .eq('email', user.email)
    .single()

  // Self-heal expired comps. A comped subscriber whose
  // comp_expires_at has passed gets quietly flipped back to free here
  // so we don't need a cron. Cheap: single read on every /api/account
  // hit; the index on comp_expires_at makes the in-line UPDATE a
  // single-row primary-key write.
  let effectiveTier = subscriber?.tier ?? 'free'
  let effectiveStatus = subscriber?.subscription_status ?? null
  let effectiveCompExpiresAt = subscriber?.comp_expires_at ?? null
  if (
    subscriber?.subscription_status === 'comped' &&
    subscriber.comp_expires_at &&
    new Date(subscriber.comp_expires_at) < new Date()
  ) {
    await service
      .from('subscribers')
      .update({
        tier: 'free',
        subscription_status: null,
        comp_expires_at: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', subscriber.id)
    effectiveTier = 'free'
    effectiveStatus = null
    effectiveCompExpiresAt = null
  }

  return NextResponse.json({
    email: user.email,
    tier: effectiveTier,
    subscription_status: effectiveStatus,
    has_billing_account: !!subscriber?.stripe_customer_id,
    weekly_email_enabled: subscriber?.weekly_email_enabled ?? true,
    // Paid-tier global filters (added in migration 029). Both null/
    // empty by default = no filtering applied at send time.
    min_discount_pct: subscriber?.min_discount_pct ?? null,
    allowed_price_tiers: subscriber?.allowed_price_tiers ?? [],
    // Comp expiry surfaced so the UI can show "Free access until …"
    // for comped users. Null for everyone else (paying, free, etc.).
    comp_expires_at: effectiveCompExpiresAt,
  })
}

// PATCH body — every field is optional so the same endpoint can
// service the watchlist toggle, the price-tier filter, and the
// min-discount filter without separate routes. Each PATCH only
// updates the fields that are present.
const TIER_VALUES = ['$', '$$', '$$$', '$$$$'] as const
const PatchSchema = z.object({
  weekly_email_enabled: z.boolean().optional(),
  min_discount_pct: z.number().int().min(1).max(99).nullable().optional(),
  allowed_price_tiers: z.array(z.enum(TIER_VALUES)).optional(),
})

export async function PATCH(request: NextRequest) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const parsed = PatchSchema.safeParse(await request.json())
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid body' }, { status: 400 })
  }

  const service = createServiceClient()

  // Paid-tier guard: free users can't write to the filter fields.
  // The UI gates them behind a lock, but defense-in-depth — a hand-
  // crafted PATCH from a free account would otherwise silently set
  // the filters and they'd apply on send.
  const wantsFilterChange =
    parsed.data.min_discount_pct !== undefined ||
    parsed.data.allowed_price_tiers !== undefined
  if (wantsFilterChange) {
    const { data: sub } = await service
      .from('subscribers')
      .select('tier, subscription_status')
      .eq('email', user.email)
      .single()
    const isPaid =
      sub?.tier === 'paid' &&
      ['active', 'trialing'].includes(sub.subscription_status ?? '')
    if (!isPaid) {
      return NextResponse.json(
        { error: 'Personal Shopper required for filters.' },
        { status: 403 }
      )
    }
  }

  // Build the update payload only from the keys that were sent. Avoids
  // overwriting unrelated fields with `undefined` (Postgres treats
  // undefined as a real value and would null out the existing row).
  const update: Record<string, unknown> = {
    updated_at: new Date().toISOString(),
  }
  if (parsed.data.weekly_email_enabled !== undefined) {
    update.weekly_email_enabled = parsed.data.weekly_email_enabled
  }
  if (parsed.data.min_discount_pct !== undefined) {
    update.min_discount_pct = parsed.data.min_discount_pct
  }
  if (parsed.data.allowed_price_tiers !== undefined) {
    update.allowed_price_tiers = parsed.data.allowed_price_tiers
  }

  const { error } = await service
    .from('subscribers')
    .update(update)
    .eq('email', user.email)

  if (error) {
    console.error('[account PATCH] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to update' }, { status: 500 })
  }

  return NextResponse.json({ success: true })
}
