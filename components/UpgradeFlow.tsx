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

// Shape returned by the create-subscription/apply-promo flows so
// PaymentForm can surface granular errors without re-deriving them.
export type ApplyResult = { ok: true } | { ok: false; error: string }

export function UpgradeFlow() {
  // Single plan — no picker needed. `plan` is hard-pinned to 'monthly'
  // and sent to the server unchanged.
  const plan: Plan = 'monthly'
  const planInfo = PLAN_LABEL[plan]
  const [clientSecret, setClientSecret] = useState<string | null>(null)
  const [starting, setStarting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  // Promo code now lives on the PaymentForm (after "You'll be charged
  // …"), but the applied state is hoisted here because applying a
  // code means re-creating the subscription — which means a new
  // clientSecret, which means the PaymentForm remounts and would
  // otherwise lose track of what's applied.
  const [appliedCode, setAppliedCode] = useState<string | null>(null)
  // Comped success state — set when a 100%-off code with
  // requires_credit_card=false is applied. Bypasses Stripe entirely
  // and we render an activation confirmation instead of the
  // PaymentForm.
  const [comped, setComped] = useState<{
    code: string
    duration_months: number
    comp_expires_at: string
  } | null>(null)

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

  // Shared subscription-creation call. Used for both:
  //   - Initial "Continue to payment" click (no promo code)
  //   - "Apply" on the promo input inside the PaymentForm (with code)
  // For the promo path: creating a new subscription with the discount
  // attached gives us a fresh PaymentIntent at the discounted amount.
  // The previous incomplete subscription (if any) is left in Stripe;
  // it auto-expires after 23h with no payment. New clientSecret causes
  // the <Elements key={clientSecret}> below to remount, which gives
  // us a fresh PaymentElement reflecting the new price.
  const callCreateSubscription = async (
    promoCode?: string,
  ): Promise<ApplyResult> => {
    setStarting(true)
    setError(null)
    try {
      const res = await fetch('/api/billing/create-subscription', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          plan,
          ...(promoCode?.trim() ? { promo_code: promoCode.trim() } : {}),
        }),
      })
      const data = await res.json()
      if (!res.ok) {
        const msg = data.error || 'Failed to start checkout'
        setError(msg)
        return { ok: false, error: msg }
      }
      // Server signals which branch was taken. The COMPED branch never
      // returns a clientSecret because there's no Stripe charge — we
      // flip to the success state directly.
      if (data.comped) {
        setComped({
          code: data.promo_code,
          duration_months: data.duration_months,
          comp_expires_at: data.comp_expires_at,
        })
        setAppliedCode(data.promo_code)
        // Fire begin_checkout/funnel events even on the free path so
        // it shows up in analytics — same event-funnel shape, just
        // value=0.
        trackEvent('begin_checkout', { plan, currency: 'USD' })
        return { ok: true }
      }
      setClientSecret(data.clientSecret)
      setAppliedCode(promoCode?.trim() || null)
      return { ok: true }
    } catch (e) {
      const msg = e instanceof Error ? e.message : 'Something went wrong'
      setError(msg)
      return { ok: false, error: msg }
    } finally {
      setStarting(false)
    }
  }

  const startCheckout = async () => {
    const result = await callCreateSubscription()
    if (result.ok) {
      trackEvent('begin_checkout', { plan, currency: 'USD' })
    }
  }

  if (comped) {
    // 100%-off code applied with requires_credit_card=false. We
    // bypassed Stripe entirely — show a clean activation success
    // state with the expiry date so the user knows what they got.
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
        // key forces a clean remount of Elements (and PaymentElement
        // inside it) whenever we swap clientSecret — required when
        // applying a promo code mid-flow.
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
        <PaymentForm
          plan={plan}
          appliedCode={appliedCode}
          onApplyPromo={callCreateSubscription}
        />
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

      {/* (Promo code field moved to the PaymentForm — it's right after
          the "Payment details / You'll be charged $X" copy on the next
          step so customers actually see it.) */}

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

function PaymentForm({
  plan,
  appliedCode,
  onApplyPromo,
}: {
  plan: Plan
  appliedCode: string | null
  onApplyPromo: (code: string) => Promise<ApplyResult>
}) {
  const stripe = useStripe()
  const elements = useElements()
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  // Local promo state. Note: this component remounts whenever the
  // parent swaps clientSecret (after Apply), so this state is fresh
  // on each mount — no need to manually clear after success.
  const [promoOpen, setPromoOpen] = useState(false)
  const [promoCode, setPromoCode] = useState('')
  const [applying, setApplying] = useState(false)
  const [promoError, setPromoError] = useState<string | null>(null)

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

  const handleApply = async () => {
    const code = promoCode.trim()
    if (!code) return
    setApplying(true)
    setPromoError(null)
    const result = await onApplyPromo(code)
    // We don't toggle `applying` off on success because the parent is
    // already swapping clientSecret, which is about to unmount us.
    if (!result.ok) {
      setApplying(false)
      setPromoError(result.error || 'Code not accepted')
    }
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
      </div>

      {/* Promo code — inline disclosure right under the "You'll be
          charged" line, where customers are most likely to look for
          it. Applying re-creates the subscription with the discount
          attached; the Elements above remounts and the PaymentElement
          shows the new total. The user does have to re-enter their
          card afterwards (PaymentElement resets on remount). */}
      <div style={{ marginBottom: 24 }}>
        {appliedCode ? (
          <div
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: 10,
              padding: '8px 14px',
              border: '1.5px solid var(--ink)',
              background: '#f4ede0',
              fontFamily: 'var(--font-mono, monospace)',
              fontSize: 13,
              letterSpacing: '.08em',
              textTransform: 'uppercase',
              color: 'var(--ink)',
            }}
          >
            <span aria-hidden="true">✓</span>
            <span>Code applied: <strong>{appliedCode}</strong></span>
          </div>
        ) : !promoOpen ? (
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
          <div>
            <label style={{ display: 'block', marginBottom: 6 }}>
              <span
                className="t-eyebrow"
                style={{ display: 'block', marginBottom: 8 }}
              >
                Promo code
              </span>
              <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
                <input
                  type="text"
                  value={promoCode}
                  onChange={(e) => setPromoCode(e.target.value)}
                  placeholder="ENTERCODE"
                  autoCapitalize="characters"
                  autoComplete="off"
                  spellCheck={false}
                  disabled={applying}
                  style={{
                    flex: '1 1 180px',
                    padding: '10px 14px',
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
                <button
                  type="button"
                  onClick={handleApply}
                  disabled={applying || !promoCode.trim()}
                  style={{
                    padding: '10px 18px',
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
                  {applying ? 'Applying…' : 'Apply'}
                </button>
              </div>
            </label>
            {promoError ? (
              <p style={{ margin: '8px 0 0', fontSize: 13, color: 'oklch(50% 0.2 20)' }}>
                {promoError}
              </p>
            ) : (
              <p style={{ margin: '8px 0 0', fontSize: 12, color: 'var(--ink-55)', fontStyle: 'italic' }}>
                Applying will refresh the card form below.
              </p>
            )}
          </div>
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
