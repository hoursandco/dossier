// GET  /api/admin/coupons   — list active promotion codes + their coupons
// POST /api/admin/coupons   — create a coupon + promotion code in one go
//
// Stripe model:
//   - Coupon = the discount config (% or $ off, duration, expiry).
//   - PromotionCode = the customer-facing string tied to a Coupon.
//
// We always create them as a pair so admins think in terms of "a coupon
// with a code". List endpoint returns the joined view.
//
// Create body:
//   {
//     code: 'LAUNCH50',                  // customer-facing string, case-insensitive
//     percent_off?: 50,                  // OR amount_off + currency
//     amount_off?: 500,                  // in cents
//     currency?: 'usd',                  // required iff amount_off
//     duration: 'once' | 'repeating' | 'forever',
//     duration_in_months?: 3,            // required iff duration === 'repeating'
//     max_redemptions?: 100,             // null/omitted → unlimited
//     redeem_by?: '2026-12-31T00:00:00Z' // optional expiry
//   }

import { NextRequest, NextResponse } from 'next/server'
import type Stripe from 'stripe'
import { z } from 'zod'
import { createClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'
export const maxDuration = 30

async function adminGate(): Promise<NextResponse | null> {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }
  return null
}

// ── GET ─────────────────────────────────────────────────────────────────
export async function GET() {
  const gate = await adminGate()
  if (gate) return gate

  const stripe = getStripe()
  try {
    // List active promo codes, expanding the underlying coupon so we
    // can show discount details inline. Note: in Stripe SDK 22+ the
    // coupon lives at `promotion.coupon`, not `coupon` at the top level.
    const promos = await stripe.promotionCodes.list({
      limit: 100,
      expand: ['data.promotion.coupon'],
    })

    const rows = promos.data.map((p) => {
      const c = p.promotion.coupon as Stripe.Coupon
      return {
        id: p.id,
        code: p.code,
        active: p.active,
        coupon_id: c.id,
        percent_off: c.percent_off,
        amount_off: c.amount_off,
        currency: c.currency,
        duration: c.duration,
        duration_in_months: c.duration_in_months,
        max_redemptions: p.max_redemptions ?? c.max_redemptions ?? null,
        times_redeemed: p.times_redeemed,
        redeem_by:
          p.expires_at
            ? new Date(p.expires_at * 1000).toISOString()
            : c.redeem_by
            ? new Date(c.redeem_by * 1000).toISOString()
            : null,
        created:
          typeof p.created === 'number'
            ? new Date(p.created * 1000).toISOString()
            : null,
      }
    })

    return NextResponse.json({ coupons: rows })
  } catch (err) {
    console.error('[admin/coupons GET] stripe error:', err)
    return NextResponse.json(
      { error: err instanceof Error ? err.message : 'List failed' },
      { status: 500 }
    )
  }
}

// ── POST ────────────────────────────────────────────────────────────────
const CreateBody = z
  .object({
    code: z.string().trim().min(3).max(40).regex(/^[A-Za-z0-9_-]+$/),
    percent_off: z.number().int().min(1).max(100).optional(),
    amount_off: z.number().int().positive().optional(),
    currency: z.string().length(3).optional(),
    duration: z.enum(['once', 'repeating', 'forever']),
    duration_in_months: z.number().int().min(1).max(36).optional(),
    max_redemptions: z.number().int().positive().optional(),
    redeem_by: z.string().datetime().optional(),
  })
  .refine(
    (d) => (d.percent_off != null) !== (d.amount_off != null),
    { message: 'Specify exactly one of percent_off OR amount_off' }
  )
  .refine(
    (d) => d.amount_off == null || !!d.currency,
    { message: 'currency is required when using amount_off' }
  )
  .refine(
    (d) => d.duration !== 'repeating' || !!d.duration_in_months,
    { message: 'duration_in_months is required when duration is repeating' }
  )

export async function POST(req: NextRequest) {
  const gate = await adminGate()
  if (gate) return gate

  const parsed = CreateBody.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json(
      { error: 'Invalid body', details: parsed.error.issues },
      { status: 400 }
    )
  }

  const stripe = getStripe()

  try {
    // 1) Create the coupon (the underlying discount).
    const coupon = await stripe.coupons.create({
      ...(parsed.data.percent_off ? { percent_off: parsed.data.percent_off } : {}),
      ...(parsed.data.amount_off ? { amount_off: parsed.data.amount_off, currency: parsed.data.currency } : {}),
      duration: parsed.data.duration,
      ...(parsed.data.duration === 'repeating' && parsed.data.duration_in_months
        ? { duration_in_months: parsed.data.duration_in_months }
        : {}),
      ...(parsed.data.max_redemptions
        ? { max_redemptions: parsed.data.max_redemptions }
        : {}),
      ...(parsed.data.redeem_by
        ? { redeem_by: Math.floor(new Date(parsed.data.redeem_by).getTime() / 1000) }
        : {}),
    })

    // 2) Bind a promotion code (the customer-facing string) to it.
    // In Stripe SDK 22+, the coupon goes inside the `promotion` object.
    const promo = await stripe.promotionCodes.create({
      promotion: { coupon: coupon.id, type: 'coupon' },
      code: parsed.data.code.toUpperCase(),
      // max_redemptions on the promo code itself is the user-facing limit;
      // the coupon's own max_redemptions is the underlying ceiling.
      ...(parsed.data.max_redemptions
        ? { max_redemptions: parsed.data.max_redemptions }
        : {}),
      ...(parsed.data.redeem_by
        ? { expires_at: Math.floor(new Date(parsed.data.redeem_by).getTime() / 1000) }
        : {}),
    })

    return NextResponse.json({
      success: true,
      id: promo.id,
      code: promo.code,
      coupon_id: coupon.id,
    })
  } catch (err) {
    console.error('[admin/coupons POST] stripe error:', err)
    return NextResponse.json(
      { error: err instanceof Error ? err.message : 'Create failed' },
      { status: 500 }
    )
  }
}
