import { NextRequest, NextResponse } from 'next/server'
import type Stripe from 'stripe'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe, priceIdForPlan } from '@/lib/stripe'

const Body = z.object({
  plan: z.enum(['monthly', 'annual']),
  // Optional promo code typed by the user during checkout. Validated
  // against Stripe's promotionCodes API; invalid codes return 400 so
  // the user sees the error before payment. Trimmed + upper-cased
  // because Stripe codes are case-sensitive but humans aren't.
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
      .select('id, email, stripe_customer_id, stripe_subscription_id, subscription_status, tier')
      .eq('email', user.email)
      .single()

    if (subErr || !subscriber) {
      console.error('[create-subscription] subscriber lookup failed', { email: user.email, error: subErr })
      return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
    }

    // Reject if already on an active paid subscription — manage via portal instead.
    if (
      subscriber.tier === 'paid' &&
      ['active', 'trialing'].includes(subscriber.subscription_status ?? '')
    ) {
      return NextResponse.json(
        { error: 'Already subscribed. Use the billing portal to change plan.' },
        { status: 409 }
      )
    }

    const stripe = getStripe()

    // Validate promo code (if supplied). Look it up by the code string
    // — Stripe.promotionCodes.list returns the matching active code or
    // an empty array. We surface invalid/expired codes as a 400 BEFORE
    // creating the subscription so the user can correct the typo.
    let promotionCodeId: string | undefined
    if (parsed.data.promo_code) {
      const search = await stripe.promotionCodes.list({
        code: parsed.data.promo_code,
        active: true,
        limit: 1,
      })
      const pc = search.data[0]
      if (!pc) {
        return NextResponse.json(
          { error: 'Promo code not valid or expired.' },
          { status: 400 }
        )
      }
      promotionCodeId = pc.id
    }

    // Get or create Stripe Customer.
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

    // Create incomplete subscription — payment is collected client-side via Elements.
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
        ...(parsed.data.promo_code ? { promo_code_typed: parsed.data.promo_code } : {}),
      },
      // Apply the validated promotion code (if any). Stripe will
      // compute the discount automatically based on the coupon
      // attached to this promotion code.
      ...(promotionCodeId
        ? { discounts: [{ promotion_code: promotionCodeId }] }
        : {}),
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

    return NextResponse.json({
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
