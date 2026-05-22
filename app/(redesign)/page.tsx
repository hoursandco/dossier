'use client'

// /preview-redesign — homepage in the new Dossier Look aesthetic.
//
// This is a Phase 1 port: one big component, near-verbatim HTML
// structure from the design package, wired to the same real endpoints
// the current homepage uses (subscribe form, stats ticker, admin gate).
// Phase 2 will break it into smaller composable React components.

import { useEffect, useRef, useState } from 'react'
import { format } from 'date-fns'
import { DossierNav } from '@/components/DossierNav'
import { trackPixel } from '@/lib/pixel'
import { trackEvent } from '@/lib/analytics'

// 14-point starburst shape. Reused across stickers and counters.
const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

interface Stats {
  deals_found: number
  retailers_count: number
  emails_scanned: number
}

export default function PreviewRedesign() {
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [subscribeError, setSubscribeError] = useState('')
  const [stats, setStats] = useState<Stats | null>(null)
  // Brand directory size + a sample of recognizable names — drives
  // BOTH the social-proof number strip AND the scrolling brand
  // marquee. One fetch, two surfaces.
  const [brandCount, setBrandCount] = useState<number | null>(null)
  const [brandSample, setBrandSample] = useState<string[]>([])
  const [isAdmin, setIsAdmin] = useState(false)
  const rootRef = useRef<HTMLDivElement | null>(null)

  // Fetch live stats for the counters
  useEffect(() => {
    fetch('/api/editions/latest')
      .then((r) => r.json())
      .then((d) => {
        if (d.edition) setStats(d.edition)
      })
      .catch(() => {})
    // Separate fetch for the full directory — /api/stores returns
    // every non-declined store. Cached server-side at 5 min so this
    // is light. We pull the count for the social-proof strip AND a
    // random 40-name sample for the scrolling marquee.
    fetch('/api/stores')
      .then((r) => (r.ok ? r.json() : { stores: [] }))
      .then((d) => {
        const all = (d.stores ?? []) as Array<{ name: string; is_active?: boolean }>
        setBrandCount(all.length)
        // Pick a random 40-name slice of ACTIVE stores. Random keeps
        // the marquee feeling fresh across page loads. Filter to
        // is_active so we don't surface pending/declined names.
        const active = all.filter((s) => s.is_active !== false && s.name)
        const shuffled = [...active].sort(() => Math.random() - 0.5)
        setBrandSample(shuffled.slice(0, 40).map((s) => s.name))
      })
      .catch(() => {})
  }, [])

  // Admin gate for the nav link
  useEffect(() => {
    fetch('/api/admin/check')
      .then((r) => r.json())
      .then((d) => setIsAdmin(!!d.isAdmin))
      .catch(() => {})
  }, [])

  // Sticker pop + scroll reveal animations (ported from the HTML's
  // inline <script>). Lifts inline rotate() into a --r CSS variable so
  // animations preserve the final tilt.
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

    const targets: HTMLElement[] = []

    // Hero stickers pop on load with a stagger
    const heroStickers = root.querySelectorAll<HTMLElement>('.sticker-bg .s')
    heroStickers.forEach((el, i) => {
      liftRotation(el)
      el.classList.add('sticker-pop')
      el.style.setProperty('--d', (200 + i * 90) + 'ms')
    })
    requestAnimationFrame(() => requestAnimationFrame(() => {
      heroStickers.forEach((el) => el.classList.add('in'))
    }))

    const addTarget = (el: HTMLElement | null, delay: number) => {
      if (!el) return
      liftRotation(el)
      el.classList.add('reveal')
      if (delay) el.style.setProperty('--d', delay + 'ms')
      targets.push(el)
    }
    const addSticker = (el: HTMLElement | null, delay: number) => {
      if (!el) return
      liftRotation(el)
      el.classList.add('sticker-pop')
      if (delay) el.style.setProperty('--d', delay + 'ms')
      targets.push(el)
    }

    root.querySelectorAll<HTMLElement>('.section h2.kicker, .section h2.title')
      .forEach((el, i) => addTarget(el, i % 2 ? 80 : 0))
    root.querySelectorAll<HTMLElement>('.counters-inner .counter')
      .forEach((el, i) => addSticker(el, i * 120))
    root.querySelectorAll<HTMLElement>('.brief-stickers > .sticker, .brief-stickers > .sh-starburst')
      .forEach((el, i) => addSticker(el, i * 100))
    root.querySelectorAll<HTMLElement>('.system-grid .step')
      .forEach((el, i) => addTarget(el, i * 140))
    root.querySelectorAll<HTMLElement>('.pricing-grid .plan')
      .forEach((el, i) => addTarget(el, i * 150))
    root.querySelectorAll<HTMLElement>('.plan .corner-2')
      .forEach((el, i) => addSticker(el, 400 + i * 150))
    root.querySelectorAll<HTMLElement>('.faq-list .faq-item')
      .forEach((el, i) => addTarget(el, i * 80))
    const fw = root.querySelector<HTMLElement>('.footer-wordmark')
    if (fw) addTarget(fw, 0)

    const io = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add('in')
          io.unobserve(e.target)
        }
      })
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' })
    targets.forEach((t) => io.observe(t))

    return () => io.disconnect()
  }, [])

  const handleSubscribe = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email) return
    setSubmitting(true)
    setSubscribeError('')
    try {
      // 1. Create/update the subscriber row.
      await fetch('/api/subscribe', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email }),
      })
      // 2. Send the magic-link sign-in email. Without this step the
      //    signup never completes — the button would say "CHECK INBOX"
      //    while no email was ever sent.
      const res = await fetch('/api/auth/magic-link', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email,
          redirectTo: `${window.location.origin}/auth/callback`,
        }),
      })
      if (res.ok) {
        setSubmitted(true)
        // Conversion tracking — the homepage hero form is where most
        // ad traffic converts. Fire the same events as the /login form.
        trackPixel('Lead')
        trackEvent('sign_up', { method: 'magic_link', location: 'homepage_hero' })
      } else {
        const data = await res.json().catch(() => ({}))
        setSubscribeError(data.error || 'Something went wrong. Please try again.')
      }
    } catch {
      setSubscribeError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  const today = format(new Date(), 'EEEE · MMMM d · yyyy').toUpperCase()
  const dealsN = stats?.deals_found ?? 0
  const fmt = (n: number) => n.toLocaleString('en-US')

  return (
    <div ref={rootRef}>
      {/* ============ NAV ============ */}
      <DossierNav active="home" />

      {/* ============ HERO ============ */}
      <section className="hero">
        <div className="sticker-bg" aria-hidden="true">

          <div className="s" style={{ top: 30, left: 24, transform: 'rotate(-8deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 150, height: 150 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#ee7c2f" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 10, letterSpacing: '.18em', color: '#181612' }}>RETAIL</div>
                <div style={{ fontFamily: "'IM Fell English',serif", fontStyle: 'italic', fontSize: 13, color: '#181612' }}>$59</div>
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 10, letterSpacing: '.18em', color: '#181612', marginTop: 2 }}>OUR PRICE</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 26, color: '#181612', lineHeight: 1 }}>$19</div>
              </div>
            </div>
          </div>

          <div className="s" style={{ top: 30, left: '22%', transform: 'rotate(4deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 130 }}>
              <div className="lbl">SPECIAL</div>
              <div className="big">$1<span className="currency">99</span></div>
            </div>
          </div>

          <div className="s" style={{ top: 22, left: 165, transform: 'rotate(-3deg)' }}>
            <div className="sticker sh-circle bg-magenta" style={{ width: 110, height: 110 }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>EVERY DAY</div>
              <div className="big" style={{ fontSize: 28 }}>$1<span className="currency">98</span></div>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 8 }}>WORTH EVERY CENT</div>
            </div>
          </div>

          <div className="s" style={{ top: 36, right: '2%', transform: 'rotate(6deg)' }}>
            <div className="sticker sh-scallop" style={{ ['--c' as string]: 'var(--red)', width: 130, padding: '22px 18px' } as React.CSSProperties}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 10 }}>REDUCED TO</div>
              <div className="big" style={{ color: '#fff8e2', fontSize: 30 }}>$9.<span className="currency">99</span></div>
            </div>
          </div>

          <div className="s" style={{ top: 30, right: '22%', transform: 'rotate(-5deg)' }}>
            <div className="sticker bg-green sh-pricegun" style={{ width: 100 }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>HI-FI</div>
              <div className="big" style={{ color: '#fff8e2', fontSize: 26 }}>$1<span className="currency">00</span></div>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>SPECIAL</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 90, left: '6%', transform: 'rotate(-6deg)' }}>
            <div className="sticker bg-orange" style={{ width: 160, padding: '18px 14px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 34, letterSpacing: '.04em' }}>BIG</div>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 34, letterSpacing: '.04em', marginTop: -6 }}>SALE!!!</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 56, right: '6%', transform: 'rotate(-7deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 180, height: 180 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 42, lineHeight: '.95' }}>$1<span style={{ fontSize: '.5em', verticalAlign: '.6em' }}>00</span></div>
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 11, letterSpacing: '.25em' }}>SPECIAL</div>
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
                // Lift the top row above the bottom row so the overlap
                // reads as "front line on top" not "behind." Without
                // position:relative + z-index the sibling row below
                // paints on top because of DOM order.
                position: 'relative',
                zIndex: 2,
              }}
            >
              {/* ~2x the default .small size — big editorial impact
                  without overwhelming the line below. Negative margin
                  lets it slightly kiss the headline beneath. */}
              <span
                className="small"
                style={{
                  // Sized so the action-verb top line ("Tap to pull")
                  // lands roughly the same visual width as the noun
                  // emphasized below ("SALE.") — keeps the two rows
                  // balanced rather than the top over-running the bottom.
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
          <p className="hero-sub">
            Tell us what you shop. Tap to pull the latest sales from 1,700 brands
            {' '}
            <em>
              —{' '}
              <a
                href="#two-ways"
                onClick={() => trackEvent('cta_click', { label: 'two_ways_to_shop' })}
                style={{ color: 'inherit', textDecorationThickness: '2px', textUnderlineOffset: '4px' }}
              >
                two ways to shop
              </a>
              .
            </em>
          </p>

          <div className="cta-ticket">
            <form onSubmit={handleSubscribe}>
              <input
                type="email"
                placeholder="you@inbox.com"
                aria-label="Email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                disabled={submitting || submitted}
              />
              <button type="submit" disabled={submitting || submitted}>
                {submitted ? 'CHECK INBOX ✓' : submitting ? 'SENDING…' : 'START FREE →'}
              </button>
            </form>
          </div>
          {subscribeError && (
            <p className="cta-fineprint" style={{ color: 'var(--red, #d4322a)' }}>
              {subscribeError}
            </p>
          )}
          <p className="cta-fineprint">No credit card · No password · Unsubscribe anytime</p>
        </div>
      </section>

      {/* ============ COUNTERS (social proof) ============ */}
      {/* Repurposed from the original deal/retailer/email-scanned trio
          to the three numbers that actually sell the product:
            1. Coverage breadth     — total brands in directory
            2. Live activity        — deals surfaced this week
            3. Brand promise        — "0 daily blasts" — the anti-spam
                                      promise: emails arrive on demand,
                                      never as an unprompted daily push. */}
      <section className="counters">
        <div className="counters-inner">

          <div className="counter" style={{ transform: 'rotate(-4deg)' }}>
            <div className="shape">
              <svg viewBox="0 0 200 200" preserveAspectRatio="xMidYMid meet">
                <polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" />
              </svg>
            </div>
            <div className="content">
              <div className="n">{brandCount != null ? fmt(brandCount) : '—'}</div>
              <div className="l">Brands in<br />the directory</div>
            </div>
          </div>

          <div className="counter" style={{ transform: 'rotate(3deg)' }}>
            <div className="shape">
              <svg viewBox="0 0 200 200">
                <circle cx="100" cy="100" r="94" fill="#d4322a" stroke="#181612" strokeWidth="3" />
                <circle cx="100" cy="100" r="82" fill="none" stroke="#fff8e2" strokeWidth="2" strokeDasharray="5 4" />
              </svg>
            </div>
            <div className="content" style={{ color: '#fff8e2' }}>
              <div className="n">{fmt(dealsN)}</div>
              <div className="l">Deals surfaced<br />this week</div>
            </div>
          </div>

          <div className="counter" style={{ transform: 'rotate(-2deg)' }}>
            <div className="shape">
              <svg viewBox="0 0 200 200">
                <polygon points="14,0 186,0 200,14 200,186 186,200 14,200 0,186 0,14" fill="#4ea843" stroke="#181612" strokeWidth="3" />
                <polygon points="22,8 178,8 192,22 192,178 178,192 22,192 8,178 8,22" fill="none" stroke="#fff8e2" strokeWidth="2" strokeDasharray="5 4" />
              </svg>
            </div>
            <div className="content" style={{ color: '#fff8e2' }}>
              <div className="n">0</div>
              <div className="l">Daily blasts.<br />Ever.</div>
            </div>
          </div>

        </div>
      </section>

      {/* ============ BRAND MARQUEE ============ */}
      {/* Auto-scrolling strip of real brand names from the live
          directory. Proof-of-coverage at first glance — visitors see
          their favorite brand in the marquee and the "1,780+ brands"
          claim becomes credible without them having to navigate to
          /stores. Duplicated content so the scroll loops seamlessly. */}
      {brandSample.length > 0 && (
        <section
          aria-label="A sampling of brands we track"
          style={{
            padding: '32px 0',
            background: '#fff5d4',
            borderTop: '3px solid var(--ink)',
            borderBottom: '3px solid var(--ink)',
            overflow: 'hidden',
            position: 'relative',
          }}
        >
          <p
            style={{
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 11,
              letterSpacing: '.4em',
              textTransform: 'uppercase',
              color: 'var(--red-deep)',
              textAlign: 'center',
              margin: '0 0 20px',
            }}
          >
            — What we&rsquo;re watching for you —
          </p>
          <div
            style={{
              display: 'flex',
              gap: 32,
              whiteSpace: 'nowrap',
              // 30s = brisk but readable. ~2x faster than the typical
              // "logo carousel" pace so visitors see ~80 brand names
              // pass by in a single scroll-through of the page.
              animation: 'dd-marquee 30s linear infinite',
              willChange: 'transform',
            }}
          >
            {/* Render the sample TWICE so the loop wraps without a
                visible jump. The animation translates by -50% which
                lands the second copy exactly where the first started. */}
            {[...brandSample, ...brandSample].map((name, i) => (
              <span
                key={`${name}-${i}`}
                style={{
                  flex: '0 0 auto',
                  fontFamily: "'Alfa Slab One', serif",
                  fontSize: 'clamp(24px, 3.5vw, 36px)',
                  letterSpacing: '.02em',
                  color: 'var(--ink)',
                  textTransform: 'uppercase',
                }}
              >
                {name}
                <span
                  aria-hidden="true"
                  style={{ marginLeft: 32, color: 'var(--red)' }}
                >
                  ✱
                </span>
              </span>
            ))}
          </div>
          <style>{`
            @keyframes dd-marquee {
              from { transform: translateX(0); }
              to   { transform: translateX(-50%); }
            }
            @media (prefers-reduced-motion: reduce) {
              section [style*="dd-marquee"] { animation: none !important; }
            }
          `}</style>
        </section>
      )}

      {/* ============ TWO WAYS TO SHOP ============ */}
      {/* Diptych — two parallel cards explaining the store-driven vs.
          category-driven angles. Sits above pricing so visitors see how
          the product actually works for THEM before they see the cost.
          id="two-ways" is the anchor target for the hero subhead link.
          Framing leans into "on-demand action" — user taps to pull live
          sales — rather than the older "we watch for you" passive read. */}
      <section id="two-ways" className="section">
        <h2 className="kicker">— Pick Your Angle —</h2>
        <h2 className="title">Two ways to <em>shop.</em></h2>
        <p
          style={{
            fontFamily: "'IM Fell English', serif",
            fontStyle: 'italic',
            textAlign: 'center',
            fontSize: 'clamp(16px, 1.6vw, 18px)',
            color: 'var(--ink-soft)',
            maxWidth: 620,
            margin: '0 auto 40px',
            lineHeight: 1.5,
          }}
        >
          By store. By category. Either way — tap to pull the live sales on demand.
        </p>

        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
            gap: 24,
            maxWidth: 1000,
            margin: '0 auto',
          }}
        >
          {/* Way 1 — By Store */}
          <div
            style={{
              border: '2.5px solid var(--ink)',
              background: 'var(--paper, #f6ecd2)',
              boxShadow: '6px 6px 0 var(--ink)',
              padding: 'clamp(24px, 3vw, 32px)',
              display: 'flex',
              flexDirection: 'column',
              gap: 16,
              position: 'relative',
            }}
          >
            <div style={{ position: 'relative', alignSelf: 'flex-start' }}>
              <div className="sticker sh-starburst" style={{ width: 96, height: 96 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content">
                  <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 9, letterSpacing: '.18em' }}>WAY</div>
                  <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 32, lineHeight: 1 }}>01</div>
                </div>
              </div>
            </div>
            <h3 style={{ margin: 0 }}>
              <span className="ribbon">BY STORE</span>
            </h3>
            <p
              style={{
                fontFamily: "'IM Fell English', serif",
                fontSize: 'clamp(17px, 1.7vw, 19px)',
                lineHeight: 1.5,
                color: 'var(--ink)',
                margin: 0,
              }}
            >
              Know where you&rsquo;re shopping? Switch the store on. Tap to pull every live deal they&rsquo;re running — <em>before you head out.</em>
            </p>
            <a
              href="/preferences"
              style={{
                marginTop: 'auto',
                alignSelf: 'flex-start',
                fontFamily: "'Alfa Slab One', serif",
                fontSize: 14,
                letterSpacing: '.08em',
                textTransform: 'uppercase',
                background: 'var(--ink)',
                color: '#fff8e2',
                padding: '14px 22px 12px',
                border: '2px solid var(--ink)',
                boxShadow: '4px 4px 0 var(--red)',
                textDecoration: 'none',
              }}
            >
              Add your favorite stores →
            </a>
          </div>

          {/* Way 2 — By Category */}
          <div
            style={{
              border: '2.5px solid var(--ink)',
              background: 'var(--paper, #f6ecd2)',
              boxShadow: '6px 6px 0 var(--ink)',
              padding: 'clamp(24px, 3vw, 32px)',
              display: 'flex',
              flexDirection: 'column',
              gap: 16,
              position: 'relative',
            }}
          >
            <div style={{ position: 'relative', alignSelf: 'flex-start' }}>
              <div className="sticker sh-starburst" style={{ width: 96, height: 96 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content">
                  <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 9, letterSpacing: '.18em' }}>WAY</div>
                  <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 32, lineHeight: 1 }}>02</div>
                </div>
              </div>
            </div>
            <h3 style={{ margin: 0 }}>
              <span className="ribbon">BY CATEGORY</span>
            </h3>
            <p
              style={{
                fontFamily: "'IM Fell English', serif",
                fontSize: 'clamp(17px, 1.7vw, 19px)',
                lineHeight: 1.5,
                color: 'var(--ink)',
                margin: 0,
              }}
            >
              Know what you want — but not from where? Pick the category. Tap to pull every store with a live sale on that item. <em>Discover deals you didn&rsquo;t know existed.</em>
            </p>
            <a
              href="/preferences"
              style={{
                marginTop: 'auto',
                alignSelf: 'flex-start',
                fontFamily: "'Alfa Slab One', serif",
                fontSize: 14,
                letterSpacing: '.08em',
                textTransform: 'uppercase',
                background: 'var(--ink)',
                color: '#fff8e2',
                padding: '14px 22px 12px',
                border: '2px solid var(--ink)',
                boxShadow: '4px 4px 0 var(--red)',
                textDecoration: 'none',
              }}
            >
              Pick your category →
            </a>
          </div>
        </div>
      </section>

      {/* ============ PRICING ============ */}
      {/* id="pricing" makes the nav's /#pricing jump-link land here.
          The Subscribe button in the paid card below still navigates
          to /pricing for the Stripe checkout — this section is just
          the at-a-glance comparison + plan-pick entry point. */}
      <section id="pricing" className="section pricing" style={{ scrollMarginTop: 80 }}>
        <h2 className="kicker">— Pricing —</h2>
        <h2 className="title">Two ways to <em>read.</em></h2>

        <div className="pricing-grid">
          <div className="plan">
            <div className="corner-2">
              <div className="sticker sh-starburst" style={{ width: 110, height: 110 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content">
                  <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 14, letterSpacing: '.04em', lineHeight: 1 }}>NO CC</div>
                  <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 14, letterSpacing: '.04em', lineHeight: 1 }}>REQ&rsquo;D</div>
                </div>
              </div>
            </div>
            <h3 className="plan-name">Inbox Cleaner</h3>
            <div className="price"><span className="cur">$</span>0<span className="per">/ forever</span></div>
            <p className="price-sub">Enough to try. Built to outgrow.</p>
            <ul>
              <li><span className="check">✱</span><div><h4>3 picks total</h4><p>Any mix of categories or specific stores.</p></div></li>
              <li><span className="check">✱</span><div><h4>Unlimited on-demand sends</h4><p>Tap &ldquo;send me deals&rdquo; before every shopping trip — as often as you want.</p></div></li>
              <li><span className="check">✱</span><div><h4>Includes light ads</h4><p>Small, on-site only. Never in your email.</p></div></li>
              <li><span className="check">✱</span><div><h4>No credit card, ever</h4><p>Free means free. Upgrade only if you want more.</p></div></li>
            </ul>
            <a href="/login" className="btn">START FREE →</a>
          </div>

          <div className="plan featured">
            <div className="corner-2">
              <div className="sticker sh-starburst" style={{ width: 120, height: 120 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#fff8e2" strokeWidth="3" /></svg>
                </div>
                <div className="content">
                  <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 9, letterSpacing: '.2em' }}>SAVE</div>
                  <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 30, lineHeight: 1 }}>25<span style={{ fontSize: '.6em' }}>%</span></div>
                  <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 8, letterSpacing: '.18em' }}>ANNUAL</div>
                </div>
              </div>
            </div>
            <h3 className="plan-name">Personal Shopper</h3>
            <div className="price"><span className="cur">$</span>4<span style={{ fontSize: '.55em', verticalAlign: '.85em' }}>.99</span><span className="per">/ month</span></div>
            <p className="price-sub">or $45/year — save 25%</p>
            <ul>
              <li><span className="check">✱</span><div><h4>Unlimited picks</h4><p>Every category AND every favorite store. Watch all of them.</p></div></li>
              <li><span className="check">✱</span><div><h4>Priority alerts</h4><p>Time-sensitive deals — flash sales, exclusive codes — surface first.</p></div></li>
              <li><span className="check">✱</span><div><h4>Per-watch modifiers</h4><p>Narrow each pick by sub-type, price tier ($–$$$$), minimum discount %.</p></div></li>
              <li><span className="check">✱</span><div><h4>Zero ads anywhere</h4><p>Clean site experience. Clean emails. Just the deals.</p></div></li>
              <li><span className="check">✱</span><div><h4>Cancel anytime</h4><p>One click from settings. Keep your watchlist, drop the bill.</p></div></li>
            </ul>
            <a href="/pricing" className="btn">UPGRADE FOR $4.99/MO →</a>
          </div>
        </div>
      </section>

      {/* ============ FAQ ============ */}
      <section className="section faq">
        <h2 className="kicker">— Questions —</h2>
        <h2 className="title">Worth <em>asking.</em></h2>

        <div className="faq-list">
          <details className="faq-item" open>
            <span className="faq-tag">Q · 01</span>
            <summary>What does Deal Dossier do for me?</summary>
            <div className="ans">
              <p>You tell us what you&rsquo;re shopping for — bath &amp; towels, a new mattress, mens jeans, perfume, whatever. We do the rest.</p>
              <p>Our AI is subscribed to over 1,700 brand newsletters. Every day it scans an inbox, extracts real discounts, tags each deal by category, and stores them. The moment you ask — by hitting &ldquo;send me deals now&rdquo; — we email everything matching your watchlist. You tell us what you&rsquo;re shopping for, we&rsquo;ll immediately send you a tidy list of recent deals for those categories or brands.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/login" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Pick three brands you actually shop. We&rsquo;ll do the watching. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 02</span>
            <summary>Is the free tier really free?</summary>
            <div className="ans">
              <p>Yes, absolutely. No credit card required. Up to 3 active watches plus the on-demand refresh — enough to track most short-term shopping projects at no cost.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/login" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Start free — no card, no catch. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 03</span>
            <summary>How are deals selected?</summary>
            <div className="ans">
              <p>AI does the window shopping for you. We scan 1,700+ brand emails daily. Skip the fluff — a 10% discount with a $200 minimum isn&rsquo;t a win, and &ldquo;store cash&rdquo; isn&rsquo;t savings. Just the real ones.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/login" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Choose three. Get the deals. Skip the spam. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 04</span>
            <summary>How are deals ranked in my email?</summary>
            <div className="ans">
              <p>Two factors. The biggest driver is savings — a 60% off deal ranks above a 20% off deal, every time. Second: store tier. A rare sale at a higher-end retailer gets a meaningful boost over the same discount at a store that&rsquo;s always running promotions.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/login" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Three brands. One email. Zero noise — starting this week. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 05</span>
            <summary>How does paid billing work?</summary>
            <div className="ans">
              <p>Personal Shopper is $4.99/month or $45/year. Billing handled by Stripe — your card details never touch our servers. Cancel any time from settings; you keep access through the end of the period you&rsquo;ve paid for.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/login" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Lock in your three brands. We&rsquo;ll handle the rest. →
                </a>
              </p>
            </div>
          </details>
        </div>

        {/* FAQ closer — anyone who scrolled this far is high-intent.
            Give them an immediate next action instead of forcing a
            scroll back up. Two doors: start free OR jump to the paid
            comparison. */}
        <div
          style={{
            marginTop: 56,
            padding: '28px 24px',
            background: '#fff8e2',
            border: '3px solid var(--ink)',
            boxShadow: '6px 6px 0 var(--ink)',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            gap: 16,
            textAlign: 'center',
            maxWidth: 640,
            margin: '56px auto 0',
          }}
        >
          <p
            style={{
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 11,
              letterSpacing: '.4em',
              textTransform: 'uppercase',
              color: 'var(--red-deep)',
              margin: 0,
            }}
          >
            — Ready? —
          </p>
          <h3
            style={{
              fontFamily: "'Alfa Slab One', serif",
              fontWeight: 400,
              fontSize: 'clamp(26px, 4vw, 36px)',
              lineHeight: 1.05,
              letterSpacing: '.02em',
              margin: 0,
              color: 'var(--ink)',
            }}
          >
            Quiet your inbox{' '}
            <em
              style={{
                fontFamily: "'Alfa Slab One', serif",
                fontStyle: 'normal',
                textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)',
                padding: '0 .04em',
              }}
            >
              in a minute.
            </em>
          </h3>
          <p
            style={{
              fontFamily: "'IM Fell English', serif",
              fontStyle: 'italic',
              fontSize: 17,
              color: 'var(--ink-soft)',
              margin: 0,
              maxWidth: '40ch',
            }}
          >
            Pick three brands free, or unlock unlimited from day one.
          </p>
          <div
            style={{
              display: 'flex',
              flexWrap: 'wrap',
              gap: 12,
              justifyContent: 'center',
              marginTop: 6,
            }}
          >
            <a
              href="#top"
              onClick={(e) => {
                e.preventDefault()
                window.scrollTo({ top: 0, behavior: 'smooth' })
              }}
              style={{
                fontFamily: "'Alfa Slab One', serif",
                fontSize: 14,
                letterSpacing: '.08em',
                textTransform: 'uppercase',
                background: 'var(--ink)',
                color: '#fff8e2',
                padding: '14px 22px 12px',
                border: '2px solid var(--ink)',
                boxShadow: '4px 4px 0 var(--ink)',
                textDecoration: 'none',
              }}
            >
              Start Free →
            </a>
            <a
              href="#pricing"
              style={{
                fontFamily: "'Alfa Slab One', serif",
                fontSize: 14,
                letterSpacing: '.08em',
                textTransform: 'uppercase',
                background: 'var(--red)',
                color: '#fff8e2',
                padding: '14px 22px 12px',
                border: '2px solid var(--ink)',
                boxShadow: '4px 4px 0 var(--ink)',
                textDecoration: 'none',
              }}
            >
              See Plans →
            </a>
          </div>
        </div>
      </section>

      {/* ============ FOOTER ============ */}
      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/suggest">Suggest a Store</a> · <a href="/preferences">Settings</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a> · <a href="mailto:hello@dealdossier.io">Contact</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </div>
  )
}
