// GET  /api/admin/discount-codes — list with times_used
// POST /api/admin/discount-codes — create a new code
//
// Backs the admin Discount Codes panel. Replaces the previous Stripe-
// based coupons admin (Stripe coupons API still works for legacy
// codes, but the new system is what the panel writes to).

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

// ── GET — list all codes + their times_used count ───────────────────
//
// times_used comes from subscribers.promo_code (every redemption
// stamps the code there). Postgres can do the LEFT JOIN COUNT in one
// query, but PostgREST's surface doesn't expose raw SQL easily —
// we run two queries and zip them client-side, which is fine for a
// list that'll never grow past hundreds of codes.

export async function GET() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()

  const [{ data: codes, error: codesErr }, { data: usages, error: usagesErr }] =
    await Promise.all([
      service
        .from('discount_codes')
        .select('id, code, plan_types, percent_off, duration_months, expires_at, requires_credit_card, active, max_redemptions, created_at, created_by')
        .order('created_at', { ascending: false }),
      service
        .from('subscribers')
        .select('promo_code')
        .not('promo_code', 'is', null),
    ])

  if (codesErr) {
    console.error('[discount-codes GET] codes load failed:', JSON.stringify(codesErr))
    return NextResponse.json({ error: 'Failed to load codes' }, { status: 500 })
  }
  if (usagesErr) {
    // Non-fatal — we can still show the codes without usage counts.
    console.warn('[discount-codes GET] usage join skipped:', JSON.stringify(usagesErr))
  }

  // Tally usages by UPPER(code) — codes are stored uppercase but
  // subscribers.promo_code captures whatever the user typed (which
  // we upper-case before persisting, but be defensive).
  const usageByCode = new Map<string, number>()
  for (const u of usages ?? []) {
    const k = (u.promo_code ?? '').toUpperCase()
    if (!k) continue
    usageByCode.set(k, (usageByCode.get(k) ?? 0) + 1)
  }

  const enriched = (codes ?? []).map((c) => ({
    ...c,
    times_used: usageByCode.get(c.code.toUpperCase()) ?? 0,
  }))

  return NextResponse.json({ codes: enriched })
}

// ── POST — create a new code ────────────────────────────────────────

// Plan keys this code can apply to. Constrained at the API layer so a
// typo in the admin form can't write garbage into the array.
const KNOWN_PLAN_KEYS = ['monthly'] as const

const CreateSchema = z.object({
  code: z.string().trim().min(1).max(64).regex(/^[A-Za-z0-9_-]+$/, 'Letters, numbers, dashes, underscores only'),
  plan_types: z.array(z.enum(KNOWN_PLAN_KEYS)).min(1, 'Pick at least one plan'),
  percent_off: z.number().min(0).max(100),
  duration_months: z.number().int().min(1).max(120),
  expires_at: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'YYYY-MM-DD'),
  requires_credit_card: z.boolean().default(true),
  max_redemptions: z.number().int().min(1).nullable().optional(),
})

export async function POST(req: NextRequest) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user || !isAdminEmail(user.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const parsed = CreateSchema.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json(
      { error: parsed.error.issues[0]?.message ?? 'Invalid body' },
      { status: 400 }
    )
  }

  const service = createServiceClient()
  const code = parsed.data.code.toUpperCase()

  // Refuse duplicates (case-insensitive) up front so we can return a
  // friendly 409 instead of a raw Postgres unique_violation message.
  const { data: existing } = await service
    .from('discount_codes')
    .select('id')
    .ilike('code', code)
    .maybeSingle()
  if (existing) {
    return NextResponse.json({ error: `Code ${code} already exists.` }, { status: 409 })
  }

  const { data: inserted, error } = await service
    .from('discount_codes')
    .insert({
      code,
      plan_types: parsed.data.plan_types,
      percent_off: parsed.data.percent_off,
      duration_months: parsed.data.duration_months,
      expires_at: parsed.data.expires_at,
      requires_credit_card: parsed.data.requires_credit_card,
      max_redemptions: parsed.data.max_redemptions ?? null,
      created_by: user.email ?? null,
    })
    .select('id, code')
    .single()

  if (error) {
    console.error('[discount-codes POST] insert error:', JSON.stringify(error))
    // 23505 = unique violation (in case our pre-check raced)
    if ((error as { code?: string }).code === '23505') {
      return NextResponse.json({ error: `Code ${code} already exists.` }, { status: 409 })
    }
    return NextResponse.json({ error: 'Failed to create code' }, { status: 500 })
  }

  return NextResponse.json({ code: inserted })
}
