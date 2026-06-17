'use client'

// /login — magic-link sign-in. Email-only, no upfront category picking.
// The flow:
//   1. User enters email
//   2. POST /api/subscribe creates/updates the subscriber row (no watches)
//   3. POST /api/auth/magic-link sends the Supabase magic link
//   4. Sent-state UI tells them to check inbox
//   5. Clicking the link in their email → /auth/callback → /preferences,
//      where they pick categories / stores. Splits the decision in two —
//      "do I want this?" first, "what am I shopping for?" later.

import { useState } from 'react'
import { DossierNav } from '@/components/DossierNav'
import { DlFooter } from '@/components/DlFooter'
import { trackPixel } from '@/lib/pixel'
import { trackEvent } from '@/lib/analytics'

const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

export default function PreviewLogin() {
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [sent, setSent] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email) return
    setSubmitting(true)
    setError('')
    try {
      // Create-or-update subscriber row with NO watches. The user will
      // pick categories / stores on /preferences after they click the
      // magic-link email — keeps the signup decision a single yes/no.
      await fetch('/api/subscribe', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email }),
      })
      const res = await fetch('/api/auth/magic-link', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email,
          // /auth/callback exchanges the token and then redirects to
          // /preferences, which is where new users actually need to
          // make their decisions.
          redirectTo: `${window.location.origin}/auth/callback`,
        }),
      })
      if (res.ok) {
        setSent(true)
        // Conversion tracking: magic-link sent = signup captured.
        // Meta 'Lead' is what the launch ad optimizes for; GA 'sign_up'
        // mirrors it for the funnel report.
        trackPixel('Lead')
        trackEvent('sign_up', { method: 'magic_link', location: 'login_page' })
      } else {
        const data = await res.json().catch(() => ({}))
        setError(data.error || 'Something went wrong. Please try again.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <>
      {/* ============ NAV ============ */}
      <DossierNav active="login" signedIn={false} />

      {/* ============ PAGE HEAD ============ */}
      <section className="page-head light">
        <div className="head-stickers" aria-hidden="true">

          <div className="s" style={{ top: 50, left: '6%', transform: 'rotate(-9deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 170, height: 170 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 10, letterSpacing: '.18em' }}>NO</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 18, lineHeight: 1, marginTop: 2, letterSpacing: '.01em' }}>PASSWORD</div>
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 9, letterSpacing: '.18em', marginTop: 2 }}>EVER</div>
              </div>
            </div>
          </div>

          <div className="s" style={{ top: 40, left: '24%', transform: 'rotate(5deg)' }}>
            <div className="sticker bg-magenta sh-circle" style={{ width: 96, height: 96 }}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>MAGIC</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 20, lineHeight: 1 }}>LINK</div>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>SIGN-IN</div>
            </div>
          </div>

          <div className="s" style={{ top: 56, right: '6%', transform: 'rotate(7deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 160, padding: '14px 12px' }}>
              <div className="lbl">FREE</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 26, lineHeight: 1 }}>FOREVER</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 40, right: '14%', transform: 'rotate(-5deg)' }}>
            <div className="sticker bg-green sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>30-SEC</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 24, lineHeight: 1 }}>SIGN-UP</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 50, left: '10%', transform: 'rotate(3deg)' }}>
            <div className="sticker bg-orange sh-pricegun" style={{ width: 140, padding: '14px 12px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 24, letterSpacing: '.04em' }}>NO</div>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 24, letterSpacing: '.04em', marginTop: -4 }}>SPAM</div>
            </div>
          </div>

        </div>

        <div className="page-head-inner">
          <p className="page-kicker">— Sign In · Sign Up —</p>
          <h1 className="page-title">What are you <em>shopping for?</em></h1>
          <p className="page-sub">
            Tell us what you&rsquo;re hunting for and we&rsquo;ll send deals the moment they hit.
            Already a subscriber? Just enter your email to sign in — your watchlist is preserved.
          </p>
        </div>
      </section>

      {/* ============ FORM ============ */}
      <section className="form-section">
        <div className="form-wrap-narrow">
          <div className="form-tag left">
            <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em' }}>TAKES</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 30, lineHeight: 1 }}>30 SEC</div>
              </div>
            </div>
          </div>

          {sent ? (
            <div style={{ background: '#fff5d4', border: '3px solid var(--ink)', boxShadow: '10px 10px 0 var(--green)', padding: '56px 48px', textAlign: 'center', position: 'relative' }}>
              <div style={{ position: 'absolute', top: -30, left: '50%', transform: 'translateX(-50%) rotate(-4deg)' }}>
                <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                  <div className="star">
                    <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
                  </div>
                  <div className="content">
                    <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em' }}>CHECK</div>
                    <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 26, lineHeight: 1 }}>INBOX</div>
                  </div>
                </div>
              </div>
              <h2 style={{ fontFamily: "'Alfa Slab One',serif", fontWeight: 400, fontSize: 36, letterSpacing: '.04em', margin: '50px 0 16px' }}>
                Magic link <em style={{ fontFamily: "'Alfa Slab One',serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>sent.</em>
              </h2>
              <p style={{ fontFamily: "'IM Fell English',serif", fontSize: 19, color: 'var(--ink-soft)', maxWidth: '50ch', margin: '0 auto 28px' }}>
                We sent a sign-in link to <strong style={{ fontFamily: "'Stardos Stamp',sans-serif", letterSpacing: '.12em', textTransform: 'uppercase', fontSize: 14, color: 'var(--ink)' }}>{email}</strong>.
                Click the link to finish signing in. The link expires in one hour.
              </p>
              <button
                type="button"
                onClick={() => { setSent(false); setEmail('') }}
                style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 12, letterSpacing: '.25em', textTransform: 'uppercase', padding: '14px 22px', background: '#fffbe6', color: 'var(--ink)', border: '2px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', cursor: 'pointer' }}
              >
                Use a different email →
              </button>
            </div>
          ) : (
            <form className="form-card flush" onSubmit={handleSubmit}>
              <p className="form-step">— Your Email —</p>
              <h2 className="form-h">Send the magic link.</h2>

              {error && (
                <div style={{ background: '#fde0de', border: '2px solid var(--red-deep)', padding: '12px 16px', marginBottom: 20, fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)' }}>
                  {error}
                </div>
              )}

              <div className="dl-field">
                <label className="lbl-top">Email address <span className="hint">— required</span></label>
                <input
                  type="email"
                  placeholder="you@inbox.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  autoFocus
                />
              </div>

              <div className="submit-row">
                <button className="submit-btn" type="submit" disabled={submitting || !email}>
                  {submitting ? 'SENDING…' : 'SEND MAGIC LINK →'}
                </button>
                <p className="fine">
                  Free forever · No card required<br />
                  We send a one-tap sign-in link. No password.
                  <br /><br />
                  After you tap it, we&rsquo;ll take you to your watchlist
                  to pick what you&rsquo;re shopping for.
                </p>
              </div>
            </form>
          )}
        </div>
      </section>

      {/* ============ FOOTER ============ */}
      <DlFooter />
    </>
  )
}
