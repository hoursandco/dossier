// GET   /api/account  — authenticated subscriber summary (email, tier,
//                       billing-account flag, weekly email opt-in)
// PATCH /api/account  — update the weekly_email_enabled toggle
//
// Replaces the digest-era /api/preferences (which read fields that no
// longer exist on subscribers).

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isPaidSubscriber } from '@/lib/subscriberTier'

export const dynamic = 'force-dynamic'

export async function GET() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()
  // Defensively normalize — Supabase auth lowercases emails but
  // historical subscriber rows or Supabase's own casing can drift,
  // and any whitespace stowaway would silently miss .eq().
  const lookupEmail = user.email.trim().toLowerCase()
  type SubRow = {
    id: string
    tier: string | null
    is_comped: boolean | null
    subscription_status: string | null
    stripe_customer_id: string | null
    weekly_email_enabled: boolean | null
    min_discount_pct: number | null
    allowed_price_tiers: string[] | null
    comp_expires_at: string | null
    include_free_shipping: boolean | null
    include_bogo: boolean | null
    include_gwp: boolean | null
    cancels_at: string | null
    email: string | null
  }
  const cols =
    'id, tier, is_comped, subscription_status, stripe_customer_id, weekly_email_enabled, min_discount_pct, allowed_price_tiers, comp_expires_at, include_free_shipping, include_bogo, include_gwp, cancels_at, email'
  const first = await service
    .from('subscribers')
    .select(cols)
    .ilike('email', lookupEmail)
    .maybeSingle()
  let subscriber: SubRow | null = (first.data as unknown as SubRow) ?? null
  const subErr = first.error

  // Fallback: ilike kept missing for at least one paid user even
  // though the row genuinely matches at the SQL level. Filter at
  // the DB by the local-part of the email (everything before @) so
  // the scan is tiny but covers any whitespace / casing drift on
  // either side. Then pick the exact trim+lowercase match.
  if (!subscriber) {
    const localPart = lookupEmail.split('@')[0]
    const scan = await service
      .from('subscribers')
      .select(cols)
      .ilike('email', `*${localPart}*`)
      .limit(50)
    const rows = ((scan.data as unknown) as SubRow[]) ?? []
    console.warn('[account GET] fallback scan', {
      email: lookupEmail,
      localPart,
      rowsReturned: rows.length,
      error: scan.error ? JSON.stringify(scan.error) : null,
    })
    if (!scan.error) {
      subscriber = rows.find(
        (r) => String(r.email ?? '').trim().toLowerCase() === lookupEmail
      ) ?? null
      if (subscriber) {
        console.warn('[account GET] matched via fallback scan', { email: lookupEmail, id: subscriber.id, dbEmail: subscriber.email })
      }
    }
  }

  if (subErr) {
    console.error('[account GET] subscriber lookup error:', { email: lookupEmail, error: JSON.stringify(subErr) })
  } else if (!subscriber) {
    console.warn('[account GET] no subscriber row matched', { email: lookupEmail })
  }

  // Self-heal expired comps. A comped subscriber whose
  // comp_expires_at has passed gets quietly flipped back to free here
  // so we don't need a cron. Cheap: single read on every /api/account
  // hit; the index on comp_expires_at makes the in-line UPDATE a
  // single-row primary-key write.
  //
  // Also: honor the admin Comp button's is_comped=true signal. That
  // path doesn't touch the `tier` column, so without this OR the user
  // would still see "Inbox Cleaner" in their own UI even though
  // admin shows them as paid.
  let effectiveTier =
    subscriber?.is_comped === true ? 'paid' : (subscriber?.tier ?? 'free')
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

  return NextResponse.json(
    {
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
      // Paid opt-ins for the bottom-of-email compact lists (migration
      // 031). All default false so the API stays back-compat with
      // existing subscribers — they just see the no-extras email.
      include_free_shipping: subscriber?.include_free_shipping ?? false,
      include_bogo: subscriber?.include_bogo ?? false,
      include_gwp: subscriber?.include_gwp ?? false,
      // ISO timestamp when a scheduled Stripe cancellation takes
      // effect. Null when the sub is renewing normally (or for free/
      // comped users). Surfaced in the SIGNED IN banner so users
      // who hit "Cancel" via the portal know exactly when access ends.
      cancels_at: subscriber?.cancels_at ?? null,
    },
    {
      // Hard no-cache so browsers always refetch after a billing
      // change (comp activation, paid checkout, subscription cancel).
      // Without this, the HomePicker banner could stay on "Inbox
      // Cleaner" after a user upgrades.
      headers: { 'Cache-Control': 'no-store, max-age=0' },
    },
  )
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
  // Paid opt-ins (migration 031). Same paid-gating as the discount/
  // tier filters below — free users can flip these in the UI but the
  // server-side guard rejects the PATCH.
  include_free_shipping: z.boolean().optional(),
  include_bogo: z.boolean().optional(),
  include_gwp: z.boolean().optional(),
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
    parsed.data.allowed_price_tiers !== undefined ||
    parsed.data.include_free_shipping !== undefined ||
    parsed.data.include_bogo !== undefined ||
    parsed.data.include_gwp !== undefined
  if (wantsFilterChange) {
    const { data: sub } = await service
      .from('subscribers')
      .select('tier, is_comped')
      .eq('email', user.email)
      .single()
    const isPaid = isPaidSubscriber(sub)
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
  if (parsed.data.include_free_shipping !== undefined) {
    update.include_free_shipping = parsed.data.include_free_shipping
  }
  if (parsed.data.include_bogo !== undefined) {
    update.include_bogo = parsed.data.include_bogo
  }
  if (parsed.data.include_gwp !== undefined) {
    update.include_gwp = parsed.data.include_gwp
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
