// POST /api/billing/create-subscription
//
// Two redemption paths:
//
//   PAID (no code / partial-discount code with requires_credit_card=true):
//     - Standard Stripe Elements flow. Create an incomplete subscription
//       at the discounted amount, return a clientSecret, client collects
//       card and confirms via stripe.confirmPayment.
//
//   COMPED (100%-off code with requires_credit_card=false):
//     - Bypass Stripe entirely. Mark the subscriber as comped, set
//       comp_expires_at = now() + duration_months, store the promo_code
//       used. Return { comped: true } so the client skips Elements
//       and shows the activation success state instead.
//
// The split is driven by the validated discount-code row's
// requires_credit_card flag. Server-side re-validates every time —
// the client-side preview from /api/checkout/validate-code is
// advisory only.

import { NextRequest, NextResponse } from 'next/server'
import type Stripe from 'stripe'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe, priceIdForPlan, listPriceCentsForPlan } from '@/lib/stripe'
import { validateDiscountCode } from '@/lib/discountCodes'

export const dynamic = 'force-dynamic'

const Body = z.object({
  plan: z.enum(['monthly']),
  // Optional in-app promo code. Validated server-side against
  // discount_codes via validateDiscountCode().
  promo_code: z.string().trim().min(1).max(64).optional(),
})

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user?.email) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const parsed = Body.safeParse(await request.json())
    if (!parsed.success) {
      return NextResponse.json({ error: 'Invalid plan' }, { status: 400 })
    }

    const service = createServiceClient()
    const { data: subscriber, error: subErr } = await service
      .from('subscribers')
      .select('id, email, stripe_customer_id, stripe_subscription_id, subscription_status, tier, comp_expires_at')
      .eq('email', user.email)
      .single()

    if (subErr || !subscriber) {
      console.error('[create-subscription] subscriber lookup failed', { email: user.email, error: subErr })
      return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
    }

    // Reject if already actively paid or comped — manage via portal /
    // wait for comp to expire instead.
    const compStillActive =
      subscriber.comp_expires_at != null &&
      new Date(subscriber.comp_expires_at) > new Date()
    if (
      subscriber.tier === 'paid' &&
      (['active', 'trialing'].includes(subscriber.subscription_status ?? '') || compStillActive)
    ) {
      return NextResponse.json(
        { error: 'Already subscribed. Use the billing portal to change plan, or wait for your comp to expire.' },
        { status: 409 }
      )
    }

    // ── Validate promo code if supplied ─────────────────────────────
    // validateDiscountCode is shared with /api/checkout/validate-code
    // so the client preview and server-side enforcement can't drift.
    let appliedCode: string | null = null
    let percentOff = 0
    let durationMonths = 1
    let requiresCard = true

    if (parsed.data.promo_code) {
      const result = await validateDiscountCode(
        service,
        parsed.data.promo_code,
        parsed.data.plan,
      )
      if (!result.valid) {
        return NextResponse.json({ error: result.message }, { status: 400 })
      }
      appliedCode = result.row.code
      percentOff = result.percent_off
      durationMonths = result.duration_months
      requiresCard = result.requires_credit_card
    }

    // ── COMPED branch: 100%-off code with requires_credit_card=false ─
    // Never touch Stripe. Mark the subscriber as paid+comped and set
    // an expiry timestamp the /api/account self-heal will respect.
    if (appliedCode && !requiresCard) {
      const expiresAt = new Date()
      expiresAt.setMonth(expiresAt.getMonth() + durationMonths)

      const { error: compErr } = await service
        .from('subscribers')
        .update({
          tier: 'paid',
          subscription_status: 'comped',
          comp_expires_at: expiresAt.toISOString(),
          promo_code: appliedCode,
          updated_at: new Date().toISOString(),
        })
        .eq('id', subscriber.id)

      if (compErr) {
        console.error('[create-subscription] comp activation failed:', JSON.stringify(compErr))
        return NextResponse.json({ error: 'Could not activate free access.' }, { status: 500 })
      }

      return NextResponse.json({
        comped: true,
        promo_code: appliedCode,
        duration_months: durationMonths,
        comp_expires_at: expiresAt.toISOString(),
      })
    }

    // ── PAID branch: standard Stripe Elements flow ───────────────────
    // Either no code, or a code with requires_credit_card=true. For
    // discounted-with-card we set the discounted amount directly via
    // a one-off invoice item adjustment — Stripe applies the same %
    // off without us having to mirror a coupon there.
    const stripe = getStripe()

    let customerId = subscriber.stripe_customer_id as string | null
    if (!customerId) {
      const customer = await stripe.customers.create({
        email: subscriber.email,
        metadata: { subscriber_id: subscriber.id },
      })
      customerId = customer.id
      await service
        .from('subscribers')
        .update({ stripe_customer_id: customerId, updated_at: new Date().toISOString() })
        .eq('id', subscriber.id)
    }

    // For partial discounts we have to make Stripe price the first
    // duration_months invoices at the discounted amount. The simplest
    // way without mirroring our codes into Stripe coupons is to mint
    // a one-off Stripe Coupon on the fly, apply it to the subscription,
    // and let Stripe handle the recurring renewal at full price after.
    let discountForStripe: { coupon: string } | null = null
    if (appliedCode && percentOff > 0 && requiresCard) {
      const listPriceCents = listPriceCentsForPlan(parsed.data.plan)
      const discountedCents = Math.round(listPriceCents * (1 - percentOff / 100))
      const offCents = listPriceCents - discountedCents
      const couponDuration: 'once' | 'forever' | 'repeating' =
        durationMonths === 1 ? 'once' : 'repeating'

      const ephemeral = await stripe.coupons.create({
        amount_off: offCents,
        currency: 'usd',
        duration: couponDuration,
        ...(couponDuration === 'repeating' ? { duration_in_months: durationMonths } : {}),
        name: `In-app: ${appliedCode}`,
        metadata: {
          source: 'in_app_discount_code',
          code: appliedCode,
          subscriber_id: subscriber.id,
        },
      })
      discountForStripe = { coupon: ephemeral.id }
    }

    const subscription = await stripe.subscriptions.create({
      customer: customerId,
      items: [{ price: priceIdForPlan(parsed.data.plan) }],
      payment_behavior: 'default_incomplete',
      payment_settings: {
        save_default_payment_method: 'on_subscription',
        payment_method_types: ['card'],
      },
      expand: ['latest_invoice.confirmation_secret'],
      metadata: {
        subscriber_id: subscriber.id,
        ...(appliedCode ? { promo_code: appliedCode } : {}),
      },
      ...(discountForStripe ? { discounts: [discountForStripe] } : {}),
    })

    const invoice = subscription.latest_invoice as Stripe.Invoice | null
    const clientSecret = invoice?.confirmation_secret?.client_secret

    if (!clientSecret) {
      console.error('[create-subscription] missing confirmation_secret', {
        subscriptionId: subscription.id,
      })
      return NextResponse.json(
        { error: 'Failed to initialize payment' },
        { status: 500 }
      )
    }

    // Stamp the promo_code on the subscriber so it shows up in the
    // admin's times_used count. If payment ultimately fails we'll
    // still have this attribution — fine for analytics; the webhook
    // handler will clean up state on subscription expiry/cancellation.
    if (appliedCode) {
      await service
        .from('subscribers')
        .update({ promo_code: appliedCode, updated_at: new Date().toISOString() })
        .eq('id', subscriber.id)
    }

    return NextResponse.json({
      comped: false,
      subscriptionId: subscription.id,
      clientSecret,
    })
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Unknown error'
    console.error('[create-subscription] handler error:', err)
    return NextResponse.json(
      { error: `Checkout failed: ${message}` },
      { status: 500 }
    )
  }
}
