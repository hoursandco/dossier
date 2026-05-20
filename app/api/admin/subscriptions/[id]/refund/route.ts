// POST /api/admin/subscriptions/[id]/refund
//
// Refund a subscriber's most recent invoice (or a partial amount of it).
// Body: { amount_cents?: number, reason?: 'duplicate' | 'fraudulent' | 'requested_by_customer' }
//
// Lookup chain:
//   1. Pull latest invoice for the subscriber's stripe_customer_id
//   2. Resolve the payment_intent on that invoice
//   3. stripe.refunds.create({ payment_intent, amount?, reason? })
//
// We refund against the payment_intent (not the charge) because that's
// the Payment Intents-era pattern and works regardless of how the
// charge was created. amount_cents omitted → full refund of the
// remaining unrefunded balance.
//
// Does NOT auto-comp or cancel the subscription — those are independent
// admin actions. Pure money-back.

import { NextRequest, NextResponse } from 'next/server'
import type Stripe from 'stripe'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'

export const dynamic = 'force-dynamic'
export const maxDuration = 30

const Body = z.object({
  amount_cents: z.number().int().positive().optional(),
  reason: z
    .enum(['duplicate', 'fraudulent', 'requested_by_customer'])
    .optional(),
})

export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  // Admin gate
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  const adminEmail = process.env.ADMIN_EMAIL
  if (!adminEmail || !user || user.email !== adminEmail) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const parsed = Body.safeParse(await req.json().catch(() => ({})))
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid body', details: parsed.error.issues }, { status: 400 })
  }

  const service = createServiceClient()
  const { data: subscriber } = await service
    .from('subscribers')
    .select('id, email, stripe_customer_id')
    .eq('id', id)
    .single()

  if (!subscriber) {
    return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
  }
  if (!subscriber.stripe_customer_id) {
    return NextResponse.json(
      { error: 'No Stripe customer on this subscriber' },
      { status: 400 }
    )
  }

  const stripe = getStripe()

  try {
    // Most recent paid invoice for this customer.
    const invoices = await stripe.invoices.list({
      customer: subscriber.stripe_customer_id,
      status: 'paid',
      limit: 1,
    })
    const invoice = invoices.data[0]
    if (!invoice) {
      return NextResponse.json(
        { error: 'No paid invoices found for this customer' },
        { status: 404 }
      )
    }

    // Pull the payment_intent — could be string ID or expanded object.
    // Use a string-or-object accessor so we don't have to expand.
    const piRaw = (invoice as Stripe.Invoice & { payment_intent?: string | Stripe.PaymentIntent | null })
      .payment_intent
    const paymentIntentId =
      typeof piRaw === 'string' ? piRaw : piRaw?.id ?? null

    if (!paymentIntentId) {
      return NextResponse.json(
        { error: 'No payment intent on the latest invoice — cannot refund' },
        { status: 400 }
      )
    }

    const refund = await stripe.refunds.create({
      payment_intent: paymentIntentId,
      ...(parsed.data.amount_cents ? { amount: parsed.data.amount_cents } : {}),
      ...(parsed.data.reason ? { reason: parsed.data.reason } : {}),
      metadata: {
        subscriber_id: subscriber.id,
        triggered_by: 'admin',
        admin_email: user.email ?? '',
      },
    })

    return NextResponse.json({
      success: true,
      refund_id: refund.id,
      amount_refunded: refund.amount,
      currency: refund.currency,
      status: refund.status,
      invoice_id: invoice.id,
    })
  } catch (err) {
    console.error('[admin sub refund] stripe error:', err)
    return NextResponse.json(
      { error: err instanceof Error ? err.message : 'Refund failed' },
      { status: 500 }
    )
  }
}
