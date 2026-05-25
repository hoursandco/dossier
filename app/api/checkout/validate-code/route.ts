// GET /api/checkout/validate-code?code=X&plan_type=Y
//
// Public endpoint — no auth required. Returns whether a promo code is
// valid for a given plan, what the discounted total would be, and a
// human-readable preview message the UI can show under the input.
//
// The server-side redemption path (POST /api/billing/create-
// subscription) re-runs the same validateDiscountCode() helper from
// scratch — never trust a quoted total round-tripped through the
// client.

import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { validateDiscountCode } from '@/lib/discountCodes'
import type { BillingPlan } from '@/lib/stripe'

export const dynamic = 'force-dynamic'

const KNOWN_PLANS = new Set<BillingPlan>(['monthly'])

export async function GET(req: NextRequest) {
  const url = new URL(req.url)
  const code = (url.searchParams.get('code') ?? '').trim()
  const planRaw = (url.searchParams.get('plan_type') ?? '').trim() as BillingPlan

  if (!code) {
    return NextResponse.json(
      { valid: false, message: 'Enter a code.' },
      { status: 200 },
    )
  }
  if (!KNOWN_PLANS.has(planRaw)) {
    return NextResponse.json(
      { valid: false, message: 'Unknown plan.' },
      { status: 200 },
    )
  }

  const service = createServiceClient()
  const result = await validateDiscountCode(service, code, planRaw)

  if (!result.valid) {
    // Always return 200 with valid:false so the client can branch on
    // the JSON shape without parsing status codes. (Same pattern Stripe
    // uses for promotion-code validity.)
    return NextResponse.json(result, { status: 200 })
  }

  return NextResponse.json({
    valid: true,
    code: result.row.code,
    percent_off: result.percent_off,
    requires_credit_card: result.requires_credit_card,
    duration_months: result.duration_months,
    list_price_cents: result.list_price_cents,
    discounted_amount_cents: result.discounted_amount_cents,
    message: result.message,
  })
}
