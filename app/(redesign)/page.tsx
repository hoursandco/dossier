'use client'

// Homepage — single-page product surface in the Dossier Look.
//
// Top nav is gone — the only top-level UI is a slim admin bar that
// renders only for the admin user (everyone else lands straight on the
// hero). Footer carries the standard nav.
//
// The HomePicker IS the page below the hero: anonymous picker for
// new visitors, pre-loaded watchlist + action buttons for signed-in.

import { useEffect, useRef } from 'react'
import { format } from 'date-fns'
import { HomePicker } from '@/components/HomePicker'
import { DossierNav } from '@/components/DossierNav'

// 14-point starburst shape — still used by the $100 SPECIAL hero
// sticker. The three counters that also used it were retired.
const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

export default function Home() {
  const rootRef = useRef<HTMLDivElement | null>(null)
  // (Stats / brand-count state + fetches removed when the three hero
  // counters were retired. DossierNav handles its own /api/admin/check
  // and /api/account calls.)

  // Sticker pop animation for the hero's decorative stickers.
  useEffect(() => {
    const root = rootRef.current
    if (!root) return
    const liftRotation = (el: HTMLElement) => {
      const t = el.style.transform || ''
      const m = t.match(/rotate\(([-\d.]+)deg\)/)
      if (m) {
        el.style.setProperty('--r', m[1] + 'deg')
        const cleaned = t.replace(/rotate\([^)]+\)/, '').replace(/\s+/g, ' ').trim()
        el.style.transform = cleaned
      }
    }
    const heroStickers = root.querySelectorAll<HTMLElement>('.sticker-bg .s')
    heroStickers.forEach((el, i) => {
      liftRotation(el)
      el.classList.add('sticker-pop')
      el.style.setProperty('--d', (200 + i * 90) + 'ms')
    })
    requestAnimationFrame(() =>
      requestAnimationFrame(() => {
        heroStickers.forEach((el) => el.classList.add('in'))
      })
    )
  }, [])

  const today = format(new Date(), 'EEEE · MMMM d · yyyy').toUpperCase()

  return (
    <div ref={rootRef}>
      {/* ============ HERO + SEARCH (side-by-side) ============ */}
      <div className="hero-search-row">
      {/* ============ HERO ============ */}
      <section className="hero">
        {/* Decorative price-tag stickers — kept slimmer than before. */}
        <div className="sticker-bg" aria-hidden="true">
          {/* s-special: classname is a target for the mobile media
              query in redesign.css that re-positions this sticker off
              the centered "Tap to pull" text. Yellow-on-yellow on
              phones makes the text unreadable otherwise. */}
          <div className="s s-special" style={{ top: 30, left: '22%', transform: 'rotate(4deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 120 }}>
              <div className="lbl">SPECIAL</div>
              <div className="big">$1<span className="currency">99</span></div>
            </div>
          </div>
          <div className="s" style={{ top: 36, right: '4%', transform: 'rotate(6deg)' }}>
            <div className="sticker sh-scallop" style={{ ['--c' as string]: 'var(--red)', width: 120, padding: '22px 18px' } as React.CSSProperties}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 10 }}>REDUCED TO</div>
              <div className="big" style={{ color: '#fff8e2', fontSize: 28 }}>$9.<span className="currency">99</span></div>
            </div>
          </div>
          <div className="s" style={{ bottom: 70, left: '6%', transform: 'rotate(-6deg)' }}>
            <div className="sticker bg-orange" style={{ width: 150, padding: '16px 14px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 30, letterSpacing: '.04em' }}>BIG</div>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 30, letterSpacing: '.04em', marginTop: -6 }}>SALE!!!</div>
            </div>
          </div>
          <div className="s" style={{ bottom: 56, right: '6%', transform: 'rotate(-7deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 160, height: 160 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 38, lineHeight: '.95' }}>$1<span style={{ fontSize: '.5em', verticalAlign: '.6em' }}>00</span></div>
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.25em' }}>SPECIAL</div>
              </div>
            </div>
          </div>
        </div>

        <span className="date-stamp">{today}</span>

        <div className="hero-inner">
          <h1 className="hero-title">
            <span
              className="row"
              style={{
                position: 'relative',
                zIndex: 2,
              }}
            >
              <span
                className="small"
                style={{
                  fontSize: 'clamp(24px, 5vw, 68px)',
                  lineHeight: 0.88,
                  display: 'inline-block',
                  marginBottom: '-0.04em',
                }}
              >
                Tap to pull
              </span>
            </span>
            <span className="row">EVERY LIVE SALE.</span>
          </h1>
          <p className="hero-eyebrow">— Today&rsquo;s sales, on demand. —</p>
        </div>

      </section>

      {/* (Hero counters retired. The .hero-counters-band CSS rule
          remains in redesign.css in case we bring them back.) */}

      {/* ============ RIGHT COLUMN: nav + picker ============ */}
      <div>
        <DossierNav />
        <HomePicker />
      </div>
      </div>

      {/* ============ FOOTER (the new nav) ============ */}
      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/faq">FAQ</a> · <a href="/stores">All Brands</a> · <a href="/suggest">Suggest a Store</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a> · <a href="mailto:hello@dealdossier.io">Contact</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </div>
  )
}
