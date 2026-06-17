'use client'

// /preview-suggest — /suggest in the Dossier Look aesthetic.
//
// Phase 3 port: one big client component for speed. Wires the
// brand-name autofill + form submission + recent-stores strip to real
// production APIs. Auth-gated; redirects to /login if not signed in
// (matching production /suggest behavior).

import { useCallback, useEffect, useMemo, useRef, useState } from 'react'
import { useRouter } from 'next/navigation'
import { format, parseISO } from 'date-fns'
import { createClient } from '@/lib/supabase/client'
import { DossierNav } from '@/components/DossierNav'
import { DlFooter } from '@/components/DlFooter'

const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

interface KnownStore {
  name: string
  website: string
  status: string
  categories: string[]
  price_tier: string | null
  date_added: string
}

interface RecentStore {
  name: string
  date_added: string
  categories: string[]
}

interface Category {
  slug: string
  label: string
}

// Normalize a brand name for fuzzy matching — strips punctuation + lowercases.
function normalize(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export default function PreviewSuggest() {
  const router = useRouter()
  const rootRef = useRef<HTMLDivElement | null>(null)

  const [loading, setLoading] = useState(true)
  const [isAdmin, setIsAdmin] = useState(false)
  const [knownStores, setKnownStores] = useState<KnownStore[]>([])
  const [categories, setCategories] = useState<Category[]>([])

  const [storeName, setStoreName] = useState('')
  const [website, setWebsite] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [errMsg, setErrMsg] = useState<string | null>(null)

  // Bootstrap: auth check, then load stores + categories + admin status
  useEffect(() => {
    async function load() {
      const supabase = createClient()
      const { data: { user } } = await supabase.auth.getUser()
      if (!user?.email) {
        router.push('/login?next=/suggest')
        return
      }
      try {
        const [storesRes, catsRes, adminRes] = await Promise.all([
          fetch('/api/stores').then((r) => r.json()),
          fetch('/api/categories').then((r) => (r.ok ? r.json() : { categories: [] })),
          fetch('/api/admin/check').then((r) => r.json()).catch(() => ({ isAdmin: false })),
        ])
        const stores: KnownStore[] = (storesRes.stores ?? []).map(
          (s: { name: string; website: string; status?: string; categories?: string[]; price_tier?: string | null; date_added?: string }) => ({
            name: s.name,
            website: s.website,
            status: s.status ?? 'active',
            categories: Array.isArray(s.categories) ? s.categories : [],
            price_tier: s.price_tier ?? null,
            date_added: s.date_added ?? '',
          })
        )
        setKnownStores(stores)
        setCategories(catsRes.categories ?? [])
        setIsAdmin(!!adminRes.isAdmin)
      } catch (err) {
        console.error(err)
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [router])

  // Sticker pop on header
  useEffect(() => {
    if (loading) return
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
    const heroStickers = root.querySelectorAll<HTMLElement>('.head-stickers .s')
    heroStickers.forEach((el, i) => {
      liftRotation(el)
      el.classList.add('sticker-pop')
      el.style.setProperty('--d', (200 + i * 90) + 'ms')
    })
    requestAnimationFrame(() => requestAnimationFrame(() => {
      heroStickers.forEach((el) => el.classList.add('in'))
    }))
  }, [loading])

  // Live autofill match — does the typed name look like a brand we already track?
  const existingMatch = useMemo(() => {
    const typed = normalize(storeName)
    if (typed.length < 3) return null
    return (
      knownStores.find((s) => {
        const n = normalize(s.name)
        return n === typed || n.startsWith(typed) || typed.startsWith(n)
      }) ?? null
    )
  }, [storeName, knownStores])

  // Recent stores strip — 5 most recently added, active or pending only.
  // We don't show declined or no_email ones because they're not net-new
  // "wins" to celebrate.
  const recentStores = useMemo<RecentStore[]>(() => {
    return knownStores
      .filter((s) => s.status === 'active' || s.status === 'pending')
      .filter((s) => s.date_added)
      .slice()
      .sort((a, b) => (a.date_added < b.date_added ? 1 : -1))
      .slice(0, 5)
      .map((s) => ({
        name: s.name,
        date_added: s.date_added,
        categories: s.categories,
      }))
  }, [knownStores])

  const formatSince = (iso: string): string => {
    try {
      return format(parseISO(iso), 'MM · dd')
    } catch {
      return ''
    }
  }

  // Get readable category labels from slugs (cap at 2 for card display)
  const categoryLabels = useCallback((slugs: string[]): string => {
    if (slugs.length === 0) return 'Brand'
    const labels = slugs
      .map((slug) => categories.find((c) => c.slug === slug)?.label ?? slug)
      .slice(0, 2)
    const more = slugs.length > 2 ? ` · +${slugs.length - 2}` : ''
    return labels.join(' · ') + more
  }, [categories])

  const handleSubmit = useCallback(async (e: React.FormEvent) => {
    e.preventDefault()
    setErrMsg(null)
    if (!storeName.trim()) {
      setErrMsg('Brand name is required.')
      return
    }
    if (!website.trim()) {
      setErrMsg('Website is required.')
      return
    }
    setSubmitting(true)
    try {
      const res = await fetch('/api/stores/suggest', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          store_name: storeName,
          website,
          category: null,
          notes: null,
        }),
      })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Submission failed')
      setSubmitted(true)
      window.scrollTo({ top: 0, behavior: 'smooth' })
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Something went wrong')
    } finally {
      setSubmitting(false)
    }
  }, [storeName, website])

  // Render the autofill banner based on the matched store's status
  const autofillBanner = (() => {
    if (!existingMatch) return null
    const status = existingMatch.status
    const labels = existingMatch.categories
      .map((slug) => categories.find((c) => c.slug === slug)?.label ?? slug)
      .slice(0, 4)
    const moreLabels = Math.max(0, existingMatch.categories.length - 4)
    const meta: string[] = []
    if (labels.length > 0) {
      meta.push(`Tagged: ${labels.join(', ')}${moreLabels > 0 ? ` +${moreLabels}` : ''}`)
    }
    if (existingMatch.price_tier) meta.push(existingMatch.price_tier)

    if (status === 'active') {
      return (
        <div className="autofill-banner active">
          ✓ <strong>{existingMatch.name}</strong> — we already track them. Their deals flow into matching watchlists. Different brand, same name? Submit anyway and we&rsquo;ll sort it out.
          {meta.length > 0 && <div className="autofill-meta">{meta.join('  ·  ')}</div>}
        </div>
      )
    }
    if (status === 'no_email') {
      return (
        <div className="autofill-banner no-email">
          We&rsquo;ve checked <strong>{existingMatch.name}</strong> and they don&rsquo;t publish a promotional email list, so we can&rsquo;t track their deals. If that&rsquo;s changed, submit anyway and let us know.
          {meta.length > 0 && <div className="autofill-meta">{meta.join('  ·  ')}</div>}
        </div>
      )
    }
    // pending or anything else — we know about them, awaiting first email
    return (
      <div className="autofill-banner">
        <strong>{existingMatch.name}</strong> is in our directory but we haven&rsquo;t received a promo email from them yet. Once we do, they&rsquo;ll flip on automatically.
        {meta.length > 0 && <div className="autofill-meta">{meta.join('  ·  ')}</div>}
      </div>
    )
  })()

  if (loading) {
    return (
      <div style={{ padding: 120, textAlign: 'center', fontFamily: "'Special Elite', monospace", color: 'var(--ink-soft)' }}>
        Loading…
      </div>
    )
  }

  return (
    <div ref={rootRef}>
      {/* ============ NAV ============ */}
      <DossierNav active="suggest" signedIn={true} isAdmin={isAdmin} />

      {/* ============ PAGE HEAD ============ */}
      <section className="page-head light">
        <div className="head-stickers" aria-hidden="true">

          <div className="s" style={{ top: 60, left: '6%', transform: 'rotate(-9deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 160, height: 160 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 10, letterSpacing: '.18em' }}>SUGGEST A</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 26, lineHeight: 1, marginTop: 2 }}>STORE</div>
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 9, letterSpacing: '.18em', marginTop: 2 }}>FREE!</div>
              </div>
            </div>
          </div>

          <div className="s" style={{ top: 36, left: '22%', transform: 'rotate(4deg)' }}>
            <div className="sticker bg-magenta sh-circle" style={{ width: 96, height: 96 }}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>REWARD</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 22, lineHeight: 1 }}>NEW!</div>
            </div>
          </div>

          <div className="s" style={{ top: 50, right: '6%', transform: 'rotate(7deg)' }}>
            <div className="sticker bg-red sh-pricegun" style={{ width: 150, padding: '18px 14px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>USA ONLY</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 22, lineHeight: 1 }}>SHIPS HERE</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 30, right: '14%', transform: 'rotate(-5deg)' }}>
            <div className="sticker bg-orange sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 26, letterSpacing: '.04em' }}>TIP US</div>
              <div className="lbl">A BRAND</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 40, left: '10%', transform: 'rotate(3deg)' }}>
            <div className="sticker bg-green sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>ADDED</div>
              <div className="big" style={{ color: '#fff8e2', fontSize: 30 }}>+{recentStores.length > 0 ? knownStores.filter((s) => {
                if (!s.date_added) return false
                const cutoff = new Date()
                cutoff.setDate(cutoff.getDate() - 30)
                try { return parseISO(s.date_added) >= cutoff } catch { return false }
              }).length : 0}</div>
              <div className="lbl" style={{ color: '#fff8e2' }}>THIS MONTH</div>
            </div>
          </div>

        </div>

        <div className="page-head-inner">
          <p className="page-kicker">— Suggest a Store —</p>
          <h1 className="page-title">Know a brand <em>we&rsquo;re missing?</em></h1>
          <p className="page-sub">
            We track over {knownStores.length.toLocaleString()} retailers — but there&rsquo;s always more.
            Tell us about a brand you love and we&rsquo;ll evaluate adding it to the rotation.
            We only cover retailers that ship to the USA.
          </p>
        </div>
      </section>

      {/* ============ FORM ============ */}
      <section className="form-section">
        <div className="form-wrap-narrow">
          {/* Back link to the picker — visitors land here from the
              /stores "Suggest one" CTA and need a one-tap exit back
              to their watchlist if they decide not to tip a brand.
              Padded from the left to clear the absolutely-positioned
              "TAKES 2 MIN" sticker that hovers in the top-left of
              the form area. */}
          <p style={{ margin: '0 0 18px', paddingLeft: 'clamp(110px, 18vw, 160px)', fontFamily: "'Stardos Stamp', monospace", fontSize: 13, letterSpacing: '.08em' }}>
            <a
              href="/"
              style={{ color: 'var(--red-deep)', textDecoration: 'none' }}
            >
              ← Back to your picks
            </a>
          </p>
          <div className="form-tag left">
            <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em' }}>TAKES</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 30, lineHeight: 1 }}>2 MIN</div>
              </div>
            </div>
          </div>

          {submitted ? (
            <div style={{ background: '#fff5d4', border: '3px solid var(--ink)', boxShadow: '10px 10px 0 var(--red)', padding: '56px 48px', textAlign: 'center', position: 'relative' }}>
              <div style={{ position: 'absolute', top: -30, left: '50%', transform: 'translateX(-50%) rotate(-4deg)' }}>
                <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                  <div className="star">
                    <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
                  </div>
                  <div className="content">
                    <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 30, lineHeight: 1 }}>GOT IT!</div>
                    <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em', marginTop: 2 }}>THANKS</div>
                  </div>
                </div>
              </div>
              <h2 style={{ fontFamily: "'Alfa Slab One',serif", fontWeight: 400, fontSize: 36, letterSpacing: '.04em', margin: '50px 0 16px' }}>Tip received.</h2>
              <p style={{ fontFamily: "'IM Fell English',serif", fontSize: 19, color: 'var(--ink-soft)', maxWidth: '50ch', margin: '0 auto 28px' }}>
                We&rsquo;ll look at it within the week. If we add the retailer, their deals start flowing into watchlists that match.
              </p>
              <div style={{ display: 'flex', gap: 12, justifyContent: 'center', flexWrap: 'wrap' }}>
                <a href="/" style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 16, letterSpacing: '.14em', padding: '14px 22px 12px', background: 'var(--red)', color: '#fff8e2', border: '2px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', textDecoration: 'none', display: 'inline-block' }}>
                  ← BACK TO HOME
                </a>
                <button
                  type="button"
                  onClick={() => {
                    setSubmitted(false)
                    setStoreName('')
                    setWebsite('')
                  }}
                  style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 12, letterSpacing: '.25em', textTransform: 'uppercase', padding: '14px 22px', background: '#fffbe6', color: 'var(--ink)', border: '2px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', cursor: 'pointer' }}
                >
                  Suggest another →
                </button>
              </div>
            </div>
          ) : (
            <form className="form-card flush" onSubmit={handleSubmit}>
              <p className="form-step">— The Tip-Off —</p>
              <h2 className="form-h">Tell us about a store we should be watching.</h2>

              {errMsg && (
                <div style={{ background: '#fde0de', border: '2px solid var(--red-deep)', padding: '12px 16px', marginBottom: 20, fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)' }}>
                  {errMsg}
                </div>
              )}

              <div className="dl-field">
                <label className="lbl-top">Brand or store name <span className="hint">— required</span></label>
                <input
                  type="text"
                  placeholder="e.g. Buck Mason, Sunday Citizen, Filson…"
                  value={storeName}
                  onChange={(e) => setStoreName(e.target.value)}
                  required
                />
                {autofillBanner}
              </div>

              <div className="dl-field">
                <label className="lbl-top">Website <span className="hint">— required</span></label>
                <input
                  type="url"
                  placeholder="https://"
                  value={website}
                  onChange={(e) => setWebsite(e.target.value)}
                  required
                />
              </div>

              <div className="ships-note">
                <div className="seal">!</div>
                <p>
                  <strong>FYI: USA only.</strong><br />
                  At this time, we only track retailers that ship within the United States. Worth a quick check on the brand&rsquo;s site before you send.
                </p>
              </div>

              <div className="submit-row">
                <button className="submit-btn" type="submit" disabled={submitting}>
                  {submitting ? 'SENDING…' : 'SEND THE TIP →'}
                </button>
                <p className="fine">No spam. We&rsquo;ll only email if your suggestion makes the cut.</p>
              </div>
            </form>
          )}
        </div>
      </section>

      {/* ============ HOW WE EVALUATE ============ */}
      <section className="eval">
        <h2 className="kicker">— Our Cut —</h2>
        <h2 className="title">How we <em>evaluate</em>.</h2>

        <div className="criteria">
          <div className="crit">
            <div className="icon">
              <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content"><div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 38, lineHeight: 1 }}>01</div></div>
              </div>
            </div>
            <h3>Real Sales</h3>
            <p>The retailer has to run honest discounts — not just constant &ldquo;20% off everything.&rdquo; We pass on stores in perpetual sale mode.</p>
          </div>

          <div className="crit">
            <div className="icon">
              <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content"><div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 38, lineHeight: 1 }}>02</div></div>
              </div>
            </div>
            <h3>Ships USA</h3>
            <p>We only cover brands that fulfill within the United States. International-only stores get a polite note back.</p>
          </div>

          <div className="crit">
            <div className="icon">
              <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content"><div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 38, lineHeight: 1 }}>03</div></div>
              </div>
            </div>
            <h3>Email List</h3>
            <p>They send promo emails — that&rsquo;s our source of truth. If a brand only runs sales on social or in-store, we have no signal.</p>
          </div>
        </div>
      </section>

      {/* ============ RECENTLY ADDED ============ */}
      {recentStores.length > 0 && (
        <section className="recent">
          <h2 className="kicker">— Just In —</h2>
          <h2 className="title">Recently <em>added</em>.</h2>

          <div className="recent-grid">
            {recentStores.map((s) => (
              <div key={s.name} className="recent-card">
                <p className="since">Added {formatSince(s.date_added)}</p>
                <h3 className="name">{s.name}</h3>
                <p className="meta">{categoryLabels(s.categories)}</p>
                <div className="seal">NEW<br />STORE</div>
              </div>
            ))}
          </div>
        </section>
      )}

      {/* ============ FOOTER ============ */}
      <DlFooter />
    </div>
  )
}
