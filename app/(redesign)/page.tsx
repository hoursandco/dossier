'use client'

// Homepage — single-page product surface in the Dossier Look.
//
// Top nav is gone — the only top-level UI is a slim admin bar that
// renders only for the admin user (everyone else lands straight on the
// hero). Footer carries the standard nav.
//
// The HomePicker IS the page below the hero: anonymous picker for
// new visitors, pre-loaded watchlist + action buttons for signed-in.

import { useEffect, useRef, useState } from 'react'
import { format } from 'date-fns'
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
  const [isAdmin, setIsAdmin] = useState(false)
  const rootRef = useRef<HTMLDivElement | null>(null)

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
    // Admin gate — top admin bar only renders for the admin user.
    fetch('/api/admin/check')
      .then((r) => r.json())
      .then((d) => setIsAdmin(!!d.isAdmin))
      .catch(() => {})
  }, [])

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
  const dealsN = stats?.deals_found ?? 0
  const fmt = (n: number) => n.toLocaleString('en-US')

  return (
    <div ref={rootRef}>
      {/* Top bar — brand badge + tagline (always visible). Admin link
          on the right only when /api/admin/check says the visitor is
          the admin. No other nav links; the footer carries those. */}
      <nav className="nav">
        <a className="brand" href="/">
          <span className="brand-badge">DEAL DOSSIER</span>
          <span className="brand-sub">Today&rsquo;s sales, on demand.</span>
        </a>
        {isAdmin && (
          <div className="nav-links">
            <a href="/admin">Admin</a>
          </div>
        )}
      </nav>

      {/* ============ HERO ============ */}
      <section className="hero">
        {/* Decorative price-tag stickers — kept slimmer than before. */}
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

        {/* Counters — bottom of the hero ("black header"), under the
            eyebrow. Sticker-shaped trio, visible on every screen
            (outside .sticker-bg so the mobile fade doesn't touch them). */}
        <div
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            justifyContent: 'center',
            gap: 'clamp(12px, 2.5vw, 28px)',
            margin: '32px auto 0',
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
          <div style={{ width: 120, height: 120, position: 'relative', transform: 'rotate(-2deg)' }}>
            <svg viewBox="0 0 200 200" style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }}>
              <polygon points="14,0 186,0 200,14 200,186 186,200 14,200 0,186 0,14" fill="#4ea843" stroke="#181612" strokeWidth="3" />
              <polygon points="22,8 178,8 192,22 192,178 178,192 22,192 8,178 8,22" fill="none" stroke="#fff8e2" strokeWidth="2" strokeDasharray="5 4" />
            </svg>
            <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center', padding: '0 12px', color: '#fff8e2' }}>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 26, lineHeight: 1 }}>0</div>
              <div style={{ fontFamily: "'Stardos Stamp',monospace", fontSize: 8, letterSpacing: '.16em', textTransform: 'uppercase', marginTop: 4 }}>Daily blasts<br />ever</div>
            </div>
          </div>
        </div>
      </section>

      {/* ============ PICKER ============ */}
      <HomePicker />

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
