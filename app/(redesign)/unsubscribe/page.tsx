'use client'

// /preview-unsubscribe — one-click opt-out in the Dossier Look.
// Same POST /api/unsubscribe flow as production; just restyled.

import { useState, Suspense } from 'react'

const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

function UnsubscribeForm() {
  const [submitting, setSubmitting] = useState(false)
  const [done, setDone] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSubmitting(true)
    setError('')
    try {
      const res = await fetch('/api/unsubscribe', {
        method: 'POST',
      })
      if (res.ok) {
        setDone(true)
      } else {
        const data = await res.json()
        setError(res.status === 401 ? 'Sign in first, then unsubscribe from this page.' : data.error || 'Something went wrong.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  if (done) {
    return (
      <div className="form-card flush" style={{ textAlign: 'center', position: 'relative' }}>
        <div style={{ position: 'absolute', top: -30, left: '50%', transform: 'translateX(-50%) rotate(-4deg)' }}>
          <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
            <div className="star">
              <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
            </div>
            <div className="content">
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 28, lineHeight: 1 }}>DONE</div>
            </div>
          </div>
        </div>
        <p className="form-step" style={{ marginTop: 50 }}>— You&rsquo;re Out —</p>
        <h2 className="form-h">Unsubscribed <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>cleanly.</em></h2>
        <p style={{ fontFamily: "'IM Fell English', serif", fontSize: 18, lineHeight: 1.5, color: 'var(--ink-soft)', maxWidth: '50ch', margin: '0 auto 28px' }}>
          We won&rsquo;t email you again. Your watchlist data has been removed from our system. No hard feelings — we only want to be in inboxes that want us.
        </p>
        <a href="/" className="submit-btn" style={{ fontSize: 16 }}>← BACK TO HOME</a>
      </div>
    )
  }

  return (
    <form className="form-card flush" onSubmit={handleSubmit}>
      <p className="form-step">— Stopping the Mail —</p>
      <h2 className="form-h">Confirm your unsubscribe.</h2>

      {error && (
        <div style={{ background: '#fde0de', border: '2px solid var(--red-deep)', padding: '12px 16px', marginBottom: 20, fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)' }}>
          {error}
        </div>
      )}

      <p style={{ fontFamily: "'IM Fell English', serif", fontSize: 17, lineHeight: 1.5, color: 'var(--ink-soft)', margin: '0 0 24px' }}>
        We&rsquo;ll remove the signed-in account from every list and delete its watchlist data. No questions, no &ldquo;are you sure&rdquo; popups.
      </p>

      <div className="submit-row">
        <button className="submit-btn" type="submit" disabled={submitting}>
          {submitting ? 'PROCESSING…' : 'UNSUBSCRIBE →'}
        </button>
        <p className="fine">
          Need to sign in first?<br />
          <a href="/login?next=/unsubscribe" style={{ color: 'var(--red)', textDecoration: 'none' }}>Send me a magic link →</a>
          <br /><br />
          Changed your mind?<br />
          <a href="/" style={{ color: 'var(--red)', textDecoration: 'none' }}>Pause emails instead →</a>
        </p>
      </div>
    </form>
  )
}

export default function PreviewUnsubscribe() {
  return (
    <>
      <nav className="nav">
        <a className="brand" href="/">
          <span className="brand-badge">DEAL DOSSIER</span>
          <span className="brand-sub">— the weekly brief</span>
        </a>
        <div className="nav-links">
          <a href="/suggest">Suggest a Store</a>
          <a href="/">Settings</a>
        </div>
      </nav>

      <section className="page-head light">
        <div className="head-stickers" aria-hidden="true">
          <div className="s" style={{ top: 50, left: '10%', transform: 'rotate(-7deg)' }}>
            <div className="sticker bg-red sh-pricegun" style={{ width: 150, padding: '14px 12px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>NO HARD</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 24, lineHeight: 1 }}>FEELINGS</div>
            </div>
          </div>

          <div className="s" style={{ top: 56, right: '10%', transform: 'rotate(6deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 140, padding: '14px 12px' }}>
              <div className="lbl">ONE</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 26, lineHeight: 1 }}>CLICK</div>
            </div>
          </div>
        </div>

        <div className="page-head-inner">
          <p className="page-kicker">— Unsubscribe —</p>
          <h1 className="page-title">Stopping the <em>mail.</em></h1>
          <p className="page-sub">
            We won&rsquo;t make this hard. Sign in, confirm once, and you&rsquo;re out — every list, every watchlist row, gone.
          </p>
        </div>
      </section>

      <section className="form-section">
        <div className="form-wrap-narrow">
          <Suspense fallback={<div style={{ padding: 60, textAlign: 'center', fontFamily: "'Special Elite', monospace", color: 'var(--ink-soft)' }}>Loading…</div>}>
            <UnsubscribeForm />
          </Suspense>
        </div>
      </section>

      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/suggest">Suggest a Store</a> · <a href="/">Settings</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a> · <a href="mailto:hello@dealdossier.io">Contact</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </>
  )
}
