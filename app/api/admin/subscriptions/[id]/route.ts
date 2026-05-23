// PATCH /api/admin/subscriptions/[id]
//
// Per-subscriber admin actions. Body shape:
//   { action: 'comp', reason?: string }       — flip is_comped = true
//   { action: 'uncomp' }                       — flip is_comped = false
//   { action: 'cancel' }                       — Stripe: cancel_at_period_end = true
//   { action: 'reactivate' }                   — Stripe: cancel_at_period_end = false
//
// Comp / uncomp are DB-only — never touch Stripe. Cancel / reactivate
// require a stripe_subscription_id (returns 400 otherwise).
//
// Admin-gated. All actions return the updated row so the client can
// re-render without a refetch.

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'
export const maxDuration = 30

const Body = z.discriminatedUnion('action', [
  z.object({ action: z.literal('comp'), reason: z.string().max(500).optional() }),
  z.object({ action: z.literal('uncomp') }),
  z.object({ action: z.literal('cancel') }),
  z.object({ action: z.literal('reactivate') }),
])

export async function PATCH(
  req: NextRequest,
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

  const parsed = Body.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json(
      { error: 'Invalid body', details: parsed.error.issues },
      { status: 400 }
    )
  }

  const service = createServiceClient()
  const { data: subscriber, error: loadErr } = await service
    .from('subscribers')
    .select('id, email, stripe_subscription_id, tier, is_comped')
    .eq('id', id)
    .single()

  if (loadErr || !subscriber) {
    return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
  }

  // ── COMP ──────────────────────────────────────────────────────────────
  if (parsed.data.action === 'comp') {
    const { error } = await service
      .from('subscribers')
      .update({
        is_comped: true,
        comped_at: new Date().toISOString(),
        comped_reason: parsed.data.reason ?? null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', id)
    if (error) {
      console.error('[admin sub comp] error:', JSON.stringify(error))
      return NextResponse.json({ error: 'Failed to comp' }, { status: 500 })
    }
    return NextResponse.json({ success: true, action: 'comp' })
  }

  // ── UNCOMP ────────────────────────────────────────────────────────────
  if (parsed.data.action === 'uncomp') {
    const { error } = await service
      .from('subscribers')
      .update({
        is_comped: false,
        comped_at: null,
        comped_reason: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', id)
    if (error) {
      console.error('[admin sub uncomp] error:', JSON.stringify(error))
      return NextResponse.json({ error: 'Failed to uncomp' }, { status: 500 })
    }
    return NextResponse.json({ success: true, action: 'uncomp' })
  }

  // ── CANCEL / REACTIVATE — Stripe required ─────────────────────────────
  if (!subscriber.stripe_subscription_id) {
    return NextResponse.json(
      { error: 'No Stripe subscription on this subscriber' },
      { status: 400 }
    )
  }

  const stripe = getStripe()

  if (parsed.data.action === 'cancel') {
    try {
      const updated = await stripe.subscriptions.update(
        subscriber.stripe_subscription_id,
        { cancel_at_period_end: true }
      )
      return NextResponse.json({
        success: true,
        action: 'cancel',
        cancel_at_period_end: updated.cancel_at_period_end,
        // Note: subscription_status in DB stays 'active' until period end;
        // the billing webhook flips it to 'canceled' when Stripe actually
        // cancels the sub.
      })
    } catch (err) {
      console.error('[admin sub cancel] stripe error:', err)
      return NextResponse.json(
        { error: err instanceof Error ? err.message : 'Cancel failed' },
        { status: 500 }
      )
    }
  }

  if (parsed.data.action === 'reactivate') {
    try {
      const updated = await stripe.subscriptions.update(
        subscriber.stripe_subscription_id,
        { cancel_at_period_end: false }
      )
      return NextResponse.json({
        success: true,
        action: 'reactivate',
        cancel_at_period_end: updated.cancel_at_period_end,
      })
    } catch (err) {
      console.error('[admin sub reactivate] stripe error:', err)
      return NextResponse.json(
        { error: err instanceof Error ? err.message : 'Reactivate failed' },
        { status: 500 }
      )
    }
  }

  return NextResponse.json({ error: 'Unknown action' }, { status: 400 })
}

// DELETE /api/admin/subscriptions/[id]
//
// Admin-triggered full delete: removes the subscriber row (cascades
// through watches, sent_emails, etc. via FK ON DELETE) AND the auth
// user. Same destructive scope as /api/account/delete but identified
// by subscriber.id rather than the authed user — admin can nuke any
// subscriber.
//
// Paid subscribers cannot be deleted here. Admins must cancel the
// subscription and issue any refund first, then delete once billing is
// no longer active.
export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const service = createServiceClient()
  const { data: subscriber } = await service
    .from('subscribers')
    .select('id, email, tier, stripe_subscription_id, subscription_status')
    .eq('id', id)
    .single()
  if (!subscriber) {
    return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
  }

  const hasPaidBillingState =
    subscriber.tier === 'paid' ||
    ['active', 'trialing', 'past_due'].includes(subscriber.subscription_status ?? '')

  if (hasPaidBillingState) {
    return NextResponse.json(
      {
        error:
          'Paid subscribers cannot be deleted. Cancel the subscription and issue any refund first, then delete after billing is no longer active.',
      },
      { status: 409 }
    )
  }

  // Hard-delete subscriber row. FK cascades wipe per-user tables.
  const { error: delErr } = await service
    .from('subscribers')
    .delete()
    .eq('id', id)
  if (delErr) {
    console.error('[admin sub DELETE] subscriber row delete error:', JSON.stringify(delErr))
    return NextResponse.json({ error: 'Failed to delete subscriber' }, { status: 500 })
  }

  // Best-effort auth.users delete. Lookup by email — auth.users.id is
  // NOT the same as subscribers.id (they're parallel UUIDs).
  let authDeleted = false
  try {
    const list = await service.auth.admin.listUsers()
    const match = list.data.users.find(
      (u) => u.email?.toLowerCase() === subscriber.email.toLowerCase()
    )
    if (match) {
      const { error: authDelErr } = await service.auth.admin.deleteUser(match.id)
      if (authDelErr) {
        console.error('[admin sub DELETE] auth delete error:', authDelErr)
      } else {
        authDeleted = true
      }
    }
  } catch (err) {
    console.error('[admin sub DELETE] auth lookup error:', err)
  }

  return NextResponse.json({
    success: true,
    auth_deleted: authDeleted,
  })
}
