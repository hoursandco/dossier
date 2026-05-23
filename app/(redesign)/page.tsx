'use client'

// Homepage — single-page product surface in the Dossier Look.
//
// Land here, see the picker immediately, choose your categories +
// stores, drop your email at the end. The HomePicker component owns
// the anonymous picking + submit + magic-link send. Picks are saved
// server-side at email-submit so the magic-link round-trip restores
// them across devices.
//
// The 3 social-proof counters live in the hero header zone (right
// under the date stamp, above the headline) instead of being a
// separate scroll-down section — so visitors see the credibility AND
// the picker on first paint.

import { useEffect, useRef, useState } from 'react'
import { format } from 'date-fns'
import { DossierNav } from '@/components/DossierNav'
import { HomePicker } from '@/components/HomePicker'

// 14-point starburst shape reused across stickers and counters.
const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

interface Stats {
  deals_found: number
  retailers_count: number
  emails_scanned: number
}

export default function Home() {
  const [stats, setStats] = useState<Stats | null>(null)
  const [brandCount, setBrandCount] = useState<number | null>(null)
  const rootRef = useRef<HTMLDivElement | null>(null)

  // Live stats for the in-hero counters.
  useEffect(() => {
    fetch('/api/editions/latest')
      .then((r) => r.json())
      .then((d) => {
        if (d.edition) setStats(d.edition)
      })
      .catch(() => {})
    fetch('/api/stores')
      .then((r) => (r.ok ? r.json() : { stores: [] }))
      .then((d) => {
        const all = (d.stores ?? []) as Array<{ name: string }>
        setBrandCount(all.length)
      })
      .catch(() => {})
  }, [])

  // Sticker pop animation for the hero's decorative stickers + counters.
  // Simpler than before — most marketing sections are gone.
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
  const dealsN = stats?.deals_found ?? 0
  const fmt = (n: number) => n.toLocaleString('en-US')

  return (
    <div ref={rootRef}>
      <DossierNav active="home" />

      {/* ============ HERO ============ */}
      <section className="hero">
        {/* Decorative price-tag stickers — kept slimmer than before; the
            counters carry the informational load now. */}
        <div className="sticker-bg" aria-hidden="true">
          <div className="s" style={{ top: 30, left: '22%', transform: 'rotate(4deg)' }}>
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

        {/* Counters in the hero header zone — small, sticker-shaped,
            inline (NOT inside .sticker-bg) so they don't inherit the
            mobile sticker-fade. Visible on every screen. */}
        <div
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            justifyContent: 'center',
            gap: 'clamp(12px, 2.5vw, 28px)',
            margin: '0 auto 8px',
            maxWidth: 760,
            padding: '0 16px',
            position: 'relative',
            zIndex: 2,
          }}
        >
          <div style={{ width: 120, height: 120, position: 'relative', transform: 'rotate(-4deg)' }}>
            <svg viewBox="0 0 200 200" style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }}>
              <polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" />
            </svg>
            <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center', padding: '0 12px' }}>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 22, lineHeight: 1, color: '#181612' }}>{brandCount != null ? fmt(brandCount) : '—'}</div>
              <div style={{ fontFamily: "'Stardos Stamp',monospace", fontSize: 8, letterSpacing: '.16em', textTransform: 'uppercase', color: '#181612', marginTop: 4 }}>Brands<br />tracked</div>
            </div>
          </div>
          <div style={{ width: 120, height: 120, position: 'relative', transform: 'rotate(3deg)' }}>
            <svg viewBox="0 0 200 200" style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }}>
              <circle cx="100" cy="100" r="94" fill="#d4322a" stroke="#181612" strokeWidth="3" />
              <circle cx="100" cy="100" r="82" fill="none" stroke="#fff8e2" strokeWidth="2" strokeDasharray="5 4" />
            </svg>
            <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center', padding: '0 12px', color: '#fff8e2' }}>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 22, lineHeight: 1 }}>{fmt(dealsN)}</div>
              <div style={{ fontFamily: "'Stardos Stamp',monospace", fontSize: 8, letterSpacing: '.16em', textTransform: 'uppercase', marginTop: 4 }}>Deals this<br />week</div>
            </div>
          </div>
        </div>

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
            <span className="row" style={{ whiteSpace: 'nowrap' }}>EVERY LIVE SALE.</span>
          </h1>
          <p className="hero-eyebrow">— Today&rsquo;s sales, on demand. —</p>
        </div>
      </section>

      {/* ============ PICKER ============ */}
      {/* The whole product, immediately. Anonymous picking, email at
          the end, magic-link restore. */}
      <HomePicker />

      {/* ============ FOOTER ============ */}
      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/faq">FAQ</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a> · <a href="mailto:hello@dealdossier.io">Contact</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </div>
  )
}
