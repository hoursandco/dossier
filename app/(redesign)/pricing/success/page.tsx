// /pricing/success — post-Stripe-purchase confirmation page in the
// Dossier Look. The Stripe webhook actually flips the subscriber's
// tier to 'paid' asynchronously, so this page is a celebratory pause
// before the user heads into /preferences.

import Link from 'next/link'
import { PixelEvent } from '@/components/PixelEvent'
import { GaEvent } from '@/components/GaEvent'

export const dynamic = 'force-dynamic'

const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

export default function PricingSuccessPage() {
  return (
    <>
      {/* Meta Pixel conversion: paid subscription completed. Value is a
          baseline estimate (monthly plan); exact per-plan revenue would
          come from the Stripe webhook via the Conversions API. */}
      <PixelEvent event="Purchase" params={{ value: 4.99, currency: 'USD' }} />
      <GaEvent event="purchase" params={{ value: 4.99, currency: 'USD' }} />

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

          <div className="s" style={{ top: 60, left: '8%', transform: 'rotate(-8deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 160, height: 160 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 11, letterSpacing: '.2em' }}>PAYMENT</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 26, lineHeight: 1, marginTop: 2 }}>CONFIRMED</div>
              </div>
            </div>
          </div>

          <div className="s" style={{ top: 40, left: '28%', transform: 'rotate(6deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div className="lbl">PRO TIER</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 24, lineHeight: 1 }}>ACTIVE</div>
            </div>
          </div>

          <div className="s" style={{ top: 56, right: '8%', transform: 'rotate(7deg)' }}>
            <div className="sticker bg-magenta sh-circle" style={{ width: 130, height: 130 }}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>UNLIMITED</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 15, lineHeight: 1, letterSpacing: '.02em', marginTop: 2 }}>STORES &amp;</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 15, lineHeight: 1, letterSpacing: '.02em', marginTop: 2 }}>CATEGORIES</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 40, right: '14%', transform: 'rotate(-5deg)' }}>
            <div className="sticker bg-orange sh-pricegun" style={{ width: 140, padding: '14px 12px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 28, letterSpacing: '.04em' }}>AD</div>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 28, letterSpacing: '.04em', marginTop: -4 }}>FREE</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 50, left: '12%', transform: 'rotate(3deg)' }}>
            <div className="sticker bg-red sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>PER-WATCH</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 22, lineHeight: 1 }}>MODIFIERS</div>
            </div>
          </div>

        </div>

        <div className="page-head-inner">
          <p className="page-kicker">— Welcome to Personal Shopper —</p>
          <h1 className="page-title">You&rsquo;re <em>in.</em></h1>
          <p className="page-sub">
            Payment confirmed. Your account is being upgraded — full access to
            unlimited watches, per-watch modifiers, ad-free emails, and priority alerts.
          </p>
        </div>
      </section>

      <section className="form-section">
        <div className="form-wrap-narrow">
          <div className="form-card flush" style={{ textAlign: 'center' }}>
            <p className="form-step">— Next Step —</p>
            <h2 className="form-h">
              Head to your <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>watchlist.</em>
            </h2>
            <p style={{ fontFamily: "'IM Fell English', serif", fontSize: 18, lineHeight: 1.5, color: 'var(--ink-soft)', maxWidth: '50ch', margin: '0 auto 32px' }}>
              Open your settings to add more watches, set price-tier modifiers, and dial in your delivery cadence.
              A confirmation email is on its way from Stripe.
            </p>
            <Link href="/" className="submit-btn">
              OPEN MY WATCHLIST →
            </Link>
          </div>
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
