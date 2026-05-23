// DELETE /api/admin/coupons/[id]
//
// "[id]" is the PROMOTION CODE id (promo_...), not the underlying
// coupon id. Stripe's lifecycle:
//   - Promotion codes can be deactivated (active: false) but NOT
//     deleted via the API once they've been redeemed.
//   - Underlying coupons CAN be deleted if no promo codes exist on
//     them, but that's destructive — we don't want to nuke history.
//
// So "delete" here means "deactivate the promo code." It immediately
// stops working at checkout but stays in the dashboard for accounting.

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  // Admin gate
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const stripe = getStripe()
  try {
    const updated = await stripe.promotionCodes.update(id, { active: false })
    return NextResponse.json({ success: true, id: updated.id, active: updated.active })
  } catch (err) {
    console.error('[admin coupons DELETE] stripe error:', err)
    return NextResponse.json(
      { error: err instanceof Error ? err.message : 'Deactivate failed' },
      { status: 500 }
    )
  }
}
