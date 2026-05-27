// POST /api/unsubscribe
//
// Soft-deactivate the subscriber: stop sending deal emails, but
// keep their data so they can resubscribe. Two callers historically:
//   1. The HomePicker danger-zone button (signed-in user, no body)
//   2. The /unsubscribe?token=... one-click email-footer link
//
// For paying subscribers this ALSO schedules a Stripe subscription
// cancellation at period end (cancel_at_period_end=true) so they
// get the rest of what they paid for but no future renewal. Comped
// subscribers just have the comp cleared (no Stripe call needed).
//
// Schema flexibility: email comes from either (a) the request body
// (legacy / token-link path) or (b) the authenticated session
// (HomePicker path). Body wins if both are present.

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'

export const dynamic = 'force-dynamic'

const Schema = z.object({
  email: z.string().email().optional(),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json().catch(() => ({}))
    const parsed = Schema.safeParse(body)
    if (!parsed.success) {
      return NextResponse.json({ error: 'Invalid email' }, { status: 400 })
    }

    // Resolve email: body wins, fall back to session.
    let email = parsed.data.email
    if (!email) {
      const authClient = await createClient()
      const { data: { user } } = await authClient.auth.getUser()
      email = user?.email ?? undefined
    }
    if (!email) {
      return NextResponse.json({ error: 'No email available' }, { status: 400 })
    }

    const service = createServiceClient()
    const { data: subscriber, error: lookupErr } = await service
      .from('subscribers')
      .select('id, stripe_subscription_id, subscription_status, tier')
      .eq('email', email)
      .single()

    if (lookupErr || !subscriber) {
      return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
    }

    // Cancel at period end (cancel_at_period_end=true) rather than
    // immediately — they paid for the rest of the period and should
    // keep paid features until it expires. Stripe's billing portal
    // uses the same pattern. The customer.subscription.updated
    // webhook can flip their tier to free when the period actually
    // ends.
    if (
      subscriber.tier === 'paid' &&
      subscriber.subscription_status !== 'comped' &&
      subscriber.stripe_subscription_id
    ) {
      try {
        const stripe = getStripe()
        await stripe.subscriptions.update(subscriber.stripe_subscription_id, {
          cancel_at_period_end: true,
        })
      } catch (stripeErr) {
        console.error('[unsubscribe] Stripe cancel-at-period-end failed:', stripeErr)
        const msg =
          stripeErr instanceof Error ? stripeErr.message : 'Stripe error'
        return NextResponse.json(
          { error: `Could not cancel your subscription: ${msg}. Try again.` },
          { status: 502 }
        )
      }
    }

    // For comped subscribers: clear the comp grant immediately so
    // they roll back to free without waiting for comp_expires_at.
    const compClear: Record<string, unknown> =
      subscriber.subscription_status === 'comped'
        ? { subscription_status: null, comp_expires_at: null, tier: 'free' }
        : {}

    const { error } = await service
      .from('subscribers')
      .update({
        is_active: false,
        updated_at: new Date().toISOString(),
        ...compClear,
      })
      .eq('id', subscriber.id)

    if (error) {
      console.error('[unsubscribe] DB update failed:', JSON.stringify(error))
      return NextResponse.json({ error: 'Failed to unsubscribe' }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (err) {
    console.error('[unsubscribe] handler error:', err)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
