'use client'

import { useMemo, useState } from 'react'
import { loadStripe, type Stripe } from '@stripe/stripe-js'
import {
  Elements,
  PaymentElement,
  useStripe,
  useElements,
} from '@stripe/react-stripe-js'
import { trackEvent } from '@/lib/analytics'

// Only one plan now — $4.99/mo Personal Shopper. (The $45/year
// annual plan was retired.)
type Plan = 'monthly'

const PLAN_LABEL: Record<Plan, { price: string; period: string; note: string }> = {
  monthly: { price: '$4.99', period: '/month', note: 'Cancel anytime.' },
}

// Shape returned by /api/checkout/validate-code on success. We only
// pick the fields the UI actually needs to render.
type ValidatedPromo = {
  code: string
  percent_off: number
  requires_credit_card: boolean
  duration_months: number
  list_price_cents: number
  discounted_amount_cents: number
  message: string
}

function fmtCents(cents: number): string {
  return `$${(cents / 100).toFixed(2)}`
}

export function UpgradeFlow() {
  const plan: Plan = 'monthly'
  const planInfo = PLAN_LABEL[plan]

  // Promo state — kept at the root level. Validated against the
  // public /api/checkout/validate-code endpoint BEFORE any Stripe
  // interaction, so the user sees the discount preview (or error)
  // up front and only goes to Stripe Elements if a card is required.
  const [promoCode, setPromoCode] = useState('')
  const [applying, setApplying] = useState(false)
  const [applied, setApplied] = useState<ValidatedPromo | null>(null)
  const [promoMsg, setPromoMsg] = useState<string | null>(null)

  // Subscription-creation state
  const [clientSecret, setClientSecret] = useState<string | null>(null)
  const [starting, setStarting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  // Comped success state — set when a 100%-off code with
  // requires_credit_card=false is redeemed. Stripe is never called.
  const [comped, setComped] = useState<{
    code: string
    duration_months: number
    comp_expires_at: string
  } | null>(null)

  const stripePromise = useMemo<Promise<Stripe | null> | null>(() => {
    const key = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY
    if (!key) return null
    return loadStripe(key)
  }, [])

  if (!stripePromise) {
    return (
      <div
        style={{
          border: '1.5px solid var(--ink-15)',
          padding: 24,
          background: 'var(--paper)',
          color: 'var(--ink-70)',
          fontSize: 14,
          lineHeight: 1.55,
        }}
      >
        Billing isn&rsquo;t configured for this environment. Set{' '}
        <code style={{ fontFamily: 'monospace' }}>
          NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY
        </code>{' '}
        and redeploy.
      </div>
    )
  }

  // Validate the typed code against /api/checkout/validate-code. No
  // Stripe interaction — the user sees the verdict instantly. If
  // valid, we lock the input + change the CTA label based on whether
  // a card is required.
  const handleApplyPromo = async () => {
    const trimmed = promoCode.trim()
    if (!trimmed) return
    setApplying(true)
    setPromoMsg(null)
    setError(null)
    try {
      const res = await fetch(
        `/api/checkout/validate-code?code=${encodeURIComponent(trimmed)}&plan_type=${plan}`,
      )
      const data = await res.json()
      if (!data.valid) {
        setPromoMsg(data.message || 'That code isn’t valid.')
        return
      }
      setApplied({
        code: data.code,
        percent_off: data.percent_off,
        requires_credit_card: data.requires_credit_card,
        duration_months: data.duration_months,
        list_price_cents: data.list_price_cents,
        discounted_amount_cents: data.discounted_amount_cents,
        message: data.message,
      })
      setPromoMsg(null)
    } catch {
      setPromoMsg('Network error — try again.')
    } finally {
      setApplying(false)
    }
  }

  const handleRemovePromo = () => {
    setApplied(null)
    setPromoMsg(null)
    setPromoCode('')
  }

  // Start the actual subscription. For comp codes this returns
  // { comped: true } and never creates a Stripe sub. For everything
  // else it creates a Stripe subscription at the discounted amount
  // and returns a clientSecret.
  const handleContinue = async () => {
    setStarting(true)
    setError(null)
    try {
      const res = await fetch('/api/billing/create-subscription', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          plan,
          ...(applied?.code ? { promo_code: applied.code } : {}),
        }),
      })
      const data = await res.json()
      if (!res.ok) {
        setError(data.error || 'Failed to start checkout')
        return
      }
      trackEvent('begin_checkout', { plan, currency: 'USD' })
      if (data.comped) {
        setComped({
          code: data.promo_code,
          duration_months: data.duration_months,
          comp_expires_at: data.comp_expires_at,
        })
        return
      }
      setClientSecret(data.clientSecret)
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Something went wrong')
    } finally {
      setStarting(false)
    }
  }

  // ── Success states (rendered before the form) ─────────────────────

  if (comped) {
    const expires = new Date(comped.comp_expires_at).toLocaleDateString(
      undefined,
      { month: 'long', day: 'numeric', year: 'numeric' },
    )
    return (
      <div>
        <div
          style={{
            padding: '20px 24px',
            border: '2px solid var(--ink)',
            background: '#e8f1d2',
            boxShadow: '4px 4px 0 var(--ink)',
            marginBottom: 20,
          }}
        >
          <div
            style={{
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 11,
              letterSpacing: '.3em',
              textTransform: 'uppercase',
              color: 'var(--olive-deep)',
              marginBottom: 8,
            }}
          >
            ✓ Activated
          </div>
          <div
            style={{
              fontFamily: "'Alfa Slab One', serif",
              fontSize: 24,
              lineHeight: 1.1,
              color: 'var(--ink)',
              marginBottom: 6,
            }}
          >
            Personal Shopper, on us.
          </div>
          <p style={{ margin: 0, fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink)' }}>
            Code <strong style={{ fontFamily: 'var(--font-mono, monospace)', fontStyle: 'normal' }}>{comped.code}</strong> got you {comped.duration_months}{' '}
            {comped.duration_months === 1 ? 'month' : 'months'} of full access — no card, no recurring charge. Free access through <strong>{expires}</strong>.
          </p>
        </div>
        <a
          href="/"
          className="btn-primary"
          style={{ display: 'inline-block', textDecoration: 'none' }}
        >
          Open your watchlist <span className="arr">→</span>
        </a>
      </div>
    )
  }

  if (clientSecret) {
    return (
      <Elements
        key={clientSecret}
        stripe={stripePromise}
        options={{
          clientSecret,
          appearance: {
            theme: 'flat',
            variables: {
              colorPrimary: '#3a3a2f',
              colorBackground: '#f4ede0',
              colorText: '#1a1a1a',
              colorDanger: '#a64d2f',
              fontFamily: 'Georgia, "Times New Roman", serif',
              borderRadius: '0px',
              spacingUnit: '4px',
            },
          },
        }}
      >
        <PaymentForm plan={plan} appliedCode={applied?.code ?? null} />
      </Elements>
    )
  }

  // ── Plan step (default view) ─────────────────────────────────────

  // CTA label reflects the validated code:
  //   - no code  → "Continue to payment"
  //   - paid discount applied → "Continue to payment (NEW PRICE/month)"
  //   - comp code applied → "Activate free access"
  const continueLabel = applied
    ? applied.requires_credit_card
      ? `Continue to payment (${fmtCents(applied.discounted_amount_cents)}/mo)`
      : 'Activate free access'
    : 'Continue to payment'

  return (
    <div>
      <div className="t-eyebrow" style={{ marginBottom: 12 }}>
        Your plan
      </div>

      {/* Plan price summary */}
      <div
        style={{
          padding: '20px 24px',
          border: '1.5px solid var(--ink)',
          background: 'var(--paper)',
          color: 'var(--ink)',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'baseline',
          gap: 16,
          marginBottom: 24,
        }}
      >
        <div>
          <div style={{ fontWeight: 600, fontSize: 14 }}>Personal Shopper</div>
          <div style={{ fontSize: 13, color: 'var(--ink-70)', marginTop: 4 }}>
            {planInfo.note}
          </div>
        </div>
        <div style={{ fontFamily: 'var(--font-serif)', fontSize: 28, lineHeight: 1, fontWeight: 300 }}>
          {planInfo.price}
          <span style={{ fontSize: 14, color: 'var(--ink-55)', fontStyle: 'italic', marginLeft: 4 }}>
            {planInfo.period}
          </span>
        </div>
      </div>

      {/* Promo code — always-visible textbox + Apply. Validated via
          /api/checkout/validate-code so the user sees the discount
          (or error) BEFORE they go anywhere near payment. */}
      <div style={{ marginBottom: 24 }}>
        <label
          className="t-eyebrow"
          style={{ display: 'block', marginBottom: 8 }}
        >
          Promo code (optional)
        </label>
        {applied ? (
          // Confirmation chip. Replaces the input once a code is
          // successfully applied.
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: 10,
              padding: '12px 14px',
              border: '1.5px solid var(--ink)',
              background: '#e8f1d2',
              fontFamily: 'var(--font-mono, monospace)',
              fontSize: 14,
              color: 'var(--ink)',
              flexWrap: 'wrap',
            }}
          >
            <span aria-hidden="true">✓</span>
            <span>
              <strong>{applied.code}</strong> — {applied.message}
            </span>
            <button
              type="button"
              onClick={handleRemovePromo}
              style={{
                marginLeft: 'auto',
                background: 'none',
                border: 'none',
                color: 'var(--ink-70)',
                fontSize: 12,
                fontFamily: 'inherit',
                cursor: 'pointer',
                textDecoration: 'underline',
                textDecorationStyle: 'dotted',
              }}
            >
              Remove
            </button>
          </div>
        ) : (
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
            <input
              type="text"
              value={promoCode}
              onChange={(e) => {
                setPromoCode(e.target.value)
                if (promoMsg) setPromoMsg(null)
              }}
              onKeyDown={(e) => {
                if (e.key === 'Enter') {
                  e.preventDefault()
                  void handleApplyPromo()
                }
              }}
              placeholder="ENTERCODE"
              autoCapitalize="characters"
              autoComplete="off"
              spellCheck={false}
              disabled={applying}
              style={{
                flex: '1 1 200px',
                padding: '12px 14px',
                border: '1.5px solid var(--ink)',
                background: 'var(--paper)',
                color: 'var(--ink)',
                fontFamily: 'var(--font-mono, monospace)',
                fontSize: 15,
                letterSpacing: '.08em',
                textTransform: 'uppercase',
                outline: 'none',
                boxSizing: 'border-box',
              }}
            />
            <button
              type="button"
              onClick={handleApplyPromo}
              disabled={applying || !promoCode.trim()}
              style={{
                padding: '12px 22px',
                background: 'var(--ink)',
                color: '#fff8e2',
                border: '1.5px solid var(--ink)',
                fontFamily: "'Stardos Stamp', monospace",
                fontSize: 12,
                letterSpacing: '.18em',
                textTransform: 'uppercase',
                cursor: applying || !promoCode.trim() ? 'not-allowed' : 'pointer',
                opacity: applying || !promoCode.trim() ? 0.6 : 1,
              }}
            >
              {applying ? 'Checking…' : 'Apply'}
            </button>
          </div>
        )}
        {promoMsg && (
          <p style={{ margin: '8px 0 0', fontSize: 13, color: 'oklch(50% 0.2 20)' }}>
            {promoMsg}
          </p>
        )}
      </div>

      {error && (
        <p className="t-meta" style={{ marginBottom: 16, color: 'oklch(50% 0.2 20)' }}>
          {error}
        </p>
      )}

      <button
        type="button"
        onClick={handleContinue}
        disabled={starting}
        className="btn-primary"
      >
        {starting ? 'Loading…' : (
          <>
            {continueLabel} <span className="arr">→</span>
          </>
        )}
      </button>
    </div>
  )
}

// ─────────────────────────────────────────────────────────────────────
// PaymentForm — Stripe Elements step.
//
// The promo code field used to live here too. Now validation happens
// upstream on the plan step (so users with 100%-off comp codes never
// reach this component at all), and we only render the card form.
// `appliedCode` is passed in purely so the "you'll be charged" copy
// can mention the discount.
// ─────────────────────────────────────────────────────────────────────

function PaymentForm({
  plan,
  appliedCode,
}: {
  plan: Plan
  appliedCode: string | null
}) {
  const stripe = useStripe()
  const elements = useElements()
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!stripe || !elements) return

    setSubmitting(true)
    setError(null)

    const { error: submitError } = await stripe.confirmPayment({
      elements,
      confirmParams: {
        return_url: `${window.location.origin}/pricing/success`,
      },
    })

    if (submitError) {
      setError(submitError.message ?? 'Payment failed')
    }
    setSubmitting(false)
  }

  const info = PLAN_LABEL[plan]

  return (
    <form onSubmit={handleSubmit}>
      <div className="t-eyebrow" style={{ marginBottom: 12 }}>
        Payment details
      </div>
      <div style={{ marginBottom: 20, color: 'var(--ink-70)', fontSize: 14 }}>
        You&rsquo;ll be charged{' '}
        <strong style={{ color: 'var(--ink)' }}>
          {info.price}
          {info.period}
        </strong>
        . {info.note}
        {appliedCode && (
          <>
            {' '}
            <span style={{ color: 'var(--olive-deep)', fontFamily: 'var(--font-mono, monospace)', fontSize: 13 }}>
              · Code {appliedCode} applied.
            </span>
          </>
        )}
      </div>

      <PaymentElement />

      {error && (
        <p className="t-meta" style={{ marginTop: 16, color: 'oklch(50% 0.2 20)' }}>
          {error}
        </p>
      )}

      <button
        type="submit"
        disabled={!stripe || submitting}
        className="btn-primary"
        style={{ marginTop: 32 }}
      >
        {submitting ? 'Processing…' : (
          <>
            Subscribe <span className="arr">→</span>
          </>
        )}
      </button>
      <div className="t-meta" style={{ marginTop: 16, color: 'var(--ink-40)' }}>
        Powered by Stripe · Cancel anytime
      </div>
    </form>
  )
}
