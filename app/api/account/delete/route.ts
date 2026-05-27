// DELETE /api/account/delete
//
// Hard-delete the subscriber's entire footprint:
//   1. Cancel any live Stripe subscription IMMEDIATELY (no end-of-
//      period prorating — they're going scorched-earth and shouldn't
//      get billed again).
//   2. Delete the subscribers row (FK cascades to watches, store
//      picks, send history, processed mail markers, etc).
//   3. Delete the Supabase auth user.
//
// If step 1 fails (Stripe API hiccup), we DO NOT proceed to step 2.
// Surfacing an error is better than wiping the row while Stripe keeps
// billing — at least the next click retries the cancellation.

import { NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'

export const dynamic = 'force-dynamic'

export async function DELETE() {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const service = createServiceClient()

    if (!user.email) {
      return NextResponse.json({ error: 'Missing account email' }, { status: 400 })
    }

    const { data: subscriber, error: lookupError } = await service
      .from('subscribers')
      .select('id, stripe_customer_id, stripe_subscription_id, subscription_status, tier')
      .eq('email', user.email)
      .single()

    if (lookupError || !subscriber) {
      console.error('Subscriber lookup error:', lookupError)
      return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
    }

    // ── Step 1: Stripe cancel (if there's an active sub) ──────────────
    //
    // Two branches:
    //   - 'comped' subs aren't real Stripe subs — they're our internal
    //     free-comp grant. No Stripe call needed; just nothing to do.
    //   - Real subs: cancel immediately. We use stripe.subscriptions.
    //     cancel() (NOT update with cancel_at_period_end) because the
    //     user is also wiping their account; there's no period-end
    //     to honor when the data's gone.
    if (
      subscriber.tier === 'paid' &&
      subscriber.subscription_status !== 'comped' &&
      subscriber.stripe_subscription_id
    ) {
      try {
        const stripe = getStripe()
        await stripe.subscriptions.cancel(subscriber.stripe_subscription_id)
      } catch (stripeErr) {
        console.error('[account delete] Stripe cancel failed:', stripeErr)
        // Surface but don't wipe the row — they can retry.
        const msg =
          stripeErr instanceof Error
            ? stripeErr.message
            : 'Stripe cancellation failed'
        return NextResponse.json(
          { error: `Could not cancel your subscription: ${msg}. No data deleted.` },
          { status: 502 }
        )
      }
    }

    // ── Step 2: Wipe DB row ───────────────────────────────────────────
    const { error: subscriberDeleteError } = await service
      .from('subscribers')
      .delete()
      .eq('id', subscriber.id)

    if (subscriberDeleteError) {
      console.error('Delete subscriber error:', JSON.stringify(subscriberDeleteError))
      return NextResponse.json({ error: 'Failed to delete subscriber data' }, { status: 500 })
    }

    // ── Step 3: Delete auth user via admin API ────────────────────────
    const { error } = await service.auth.admin.deleteUser(user.id)
    if (error) {
      console.error('Delete user error:', error)
      return NextResponse.json({ error: 'Failed to delete account' }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (err) {
    console.error('Account delete error:', err)
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
