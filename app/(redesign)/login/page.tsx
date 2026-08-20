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
import { trackPixel } from '@/lib/pixel'
import { trackEvent } from '@/lib/analytics'

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
    <main className="login-ledger">
      <header className="login-ledger__bar">
        <a className="ledger-brand" href="/">
          <span className="ledger-wordmark">DEAL DOSSIER</span>
          <span className="ledger-tagline">Pull every live sale.</span>
        </a>
        <a href="/">← Back to search</a>
      </header>
      <section className="login-ledger__body">
        <div className="login-ledger__status"><span>ACCOUNT ACCESS</span><span>NO PASSWORD REQUIRED</span></div>
        <div className="login-ledger__grid">
          <div className="login-ledger__intro">
            <span className="login-ledger__index">01 / SIGN IN</span>
            <h1>{sent ? 'Check your inbox.' : 'Save the search.'}</h1>
            <p>{sent ? 'One tap and you’re back in.' : 'Sign in to save searches and get an email when a matching sale lands.'}</p>
          </div>
          {sent ? (
            <div className="login-ledger__card login-ledger__sent">
              <span className="login-ledger__signal">✓</span>
              <h2>Magic link sent</h2>
              <p>We sent a one-time sign-in link to <strong>{email}</strong>. It expires in 24 hours.</p>
              <button type="button" className="login-ledger__secondary" onClick={() => { setSent(false); setEmail('') }}>Use a different email</button>
            </div>
          ) : (
            <form className="login-ledger__card" onSubmit={handleSubmit}>
              <label htmlFor="login-email">Email address <span>required</span></label>
              <input id="login-email" type="email" placeholder="you@example.com" value={email} onChange={(e) => setEmail(e.target.value)} required autoFocus />
              {error && <p className="login-ledger__error" role="alert">{error}</p>}
              <button className="login-ledger__submit" type="submit" disabled={submitting || !email}>{submitting ? 'Sending…' : 'Send magic link →'}</button>
              <p className="login-ledger__fine">Free · no card · no password<br />Already have saved searches? They’ll be right where you left them.</p>
            </form>
          )}
        </div>
      </section>
      <footer className="login-ledger__footer"><span>SECURE ONE-TIME LINK</span><span>AN HOURS &amp; CO. PUBLICATION · © 2026</span></footer>
    </main>
  )
}
