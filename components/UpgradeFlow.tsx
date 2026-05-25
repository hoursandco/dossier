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
// annual plan was retired.) Kept as a Plan union of one literal so
// adding a future plan is a one-line change here + in lib/stripe.ts.
type Plan = 'monthly'

const PLAN_LABEL: Record<Plan, { price: string; period: string; note: string }> = {
  monthly: { price: '$4.99', period: '/month', note: 'Cancel anytime.' },
}

export function UpgradeFlow() {
  // Single plan — no picker needed. `plan` is hard-pinned to 'monthly'
  // and sent to the server unchanged.
  const plan: Plan = 'monthly'
  const planInfo = PLAN_LABEL[plan]
  const [clientSecret, setClientSecret] = useState<string | null>(null)
  const [starting, setStarting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  // Promo code is optional. Hidden behind a "Have a promo code?"
  // disclosure so the field doesn't compete with the main CTA for
  // people who don't have one.
  const [promoOpen, setPromoOpen] = useState(false)
  const [promoCode, setPromoCode] = useState('')

  // Lazy-load Stripe.js only on the client; bail out cleanly if the key is missing.
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

  const startCheckout = async () => {
    setStarting(true)
    setError(null)
    try {
      const res = await fetch('/api/billing/create-subscription', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          plan,
          // Send only when present — undefined values are stripped by
          // JSON.stringify, which keeps the Zod optional() happy.
          ...(promoCode.trim() ? { promo_code: promoCode.trim() } : {}),
        }),
      })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Failed to start checkout')
      setClientSecret(data.clientSecret)
      // Funnel event: Stripe checkout successfully initiated.
      trackEvent('begin_checkout', { plan, currency: 'USD' })
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Something went wrong')
    } finally {
      setStarting(false)
    }
  }

  if (clientSecret) {
    return (
      <Elements
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
        <PaymentForm plan={plan} />
      </Elements>
    )
  }

  return (
    <div>
      <div className="t-eyebrow" style={{ marginBottom: 12 }}>
        Your plan
      </div>
      {/* Single-plan price summary — no picker since there's only one
          option. Styled to match the look-and-feel of the old radio
          card so the page rhythm stays the same. */}
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
          marginBottom: 32,
        }}
      >
        <div>
          <div style={{ fontWeight: 600, fontSize: 14 }}>
            Personal Shopper
          </div>
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

      {/* Promo code — collapsed by default; the disclosure expands an
          input that the server validates on submit. Bad codes return a
          400 with a friendly message that flows into the `error` block
          below. */}
      <div style={{ marginBottom: 24 }}>
        {!promoOpen ? (
          <button
            type="button"
            onClick={() => setPromoOpen(true)}
            style={{
              background: 'none',
              border: 'none',
              padding: 0,
              color: 'var(--ink-70)',
              cursor: 'pointer',
              fontSize: 13,
              textDecoration: 'underline',
              textDecorationStyle: 'dotted',
              fontFamily: 'inherit',
            }}
          >
            Have a promo code?
          </button>
        ) : (
          <label style={{ display: 'block' }}>
            <span
              className="t-eyebrow"
              style={{ display: 'block', marginBottom: 8 }}
            >
              Promo code
            </span>
            <input
              type="text"
              value={promoCode}
              onChange={(e) => setPromoCode(e.target.value)}
              placeholder="ENTERCODE"
              autoCapitalize="characters"
              autoComplete="off"
              spellCheck={false}
              style={{
                width: '100%',
                padding: '12px 14px',
                border: '1.5px solid var(--ink-15)',
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
          </label>
        )}
      </div>

      {error && (
        <p className="t-meta" style={{ marginBottom: 16, color: 'oklch(50% 0.2 20)' }}>
          {error}
        </p>
      )}

      <button
        type="button"
        onClick={startCheckout}
        disabled={starting}
        className="btn-primary"
      >
        {starting ? 'Loading…' : (
          <>
            Continue to payment <span className="arr">→</span>
          </>
        )}
      </button>
    </div>
  )
}

function PaymentForm({ plan }: { plan: Plan }) {
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

    // confirmPayment redirects on success. If we get here, something went wrong.
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
      <div style={{ marginBottom: 24, color: 'var(--ink-70)', fontSize: 14 }}>
        You&rsquo;ll be charged{' '}
        <strong style={{ color: 'var(--ink)' }}>
          {info.price}
          {info.period}
        </strong>
        . {info.note}
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
