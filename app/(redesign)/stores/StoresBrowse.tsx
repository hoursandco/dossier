'use client'

// Client half of the /stores browse page. The route's page.tsx is a
// thin server component that exports metadata + renders this. Putting
// the interactivity here keeps the SEO meta + OG image working
// (server-rendered head) while still allowing search, filters, and
// optimistic watchlist toggles (client state).
//
// Behavior:
//   - Public. No auth required to browse.
//   - Multi-column grid; default sort A-Z but you can switch to
//     "Newest in directory" or "Most watched."
//   - Search input (debounced) filters by name.
//   - Collection + price-tier filter chips narrow further.
//   - "Popular this week" callout — top 8 brands picked up the most
//     in the last 7 days, surfaced above the grid for discovery.
//   - Each card shows name + website link + add-to-watchlist toggle.
//   - Signed-out users tapping + are redirected to /login?next=/stores
//     so they come back here after sign-in.
//   - 3-pick free-tier limit is honored — clicking + when at cap pops
//     the same upgrade modal we built for /preferences.

import { useCallback, useEffect, useMemo, useState } from 'react'
import { DossierNav } from '@/components/DossierNav'
import { trackEvent } from '@/lib/analytics'

const FREE_PICK_LIMIT = 3

interface DirectoryStore {
  id: string
  name: string
  website: string
  categories: string[]
  price_tier: string | null
  status: string
  is_active: boolean
  // date_added is the original "first seen in directory" date (set on
  // INSERT, kept stable). Used for the "Newest in directory" sort so
  // brands the admin or ingest cron just discovered surface first.
  date_added?: string | null
}

interface Category {
  slug: string
  label: string
}

interface StorePick {
  id: string         // subscriber_stores.id
  store_id: string
}

type SortMode = 'az' | 'newest' | 'most_watched'

const PRICE_TIERS = ['$', '$$', '$$$', '$$$$'] as const

export function StoresBrowse() {
  const [stores, setStores] = useState<DirectoryStore[]>([])
  const [categories, setCategories] = useState<Category[]>([])
  const [storePicks, setStorePicks] = useState<StorePick[]>([])
  const [signedIn, setSignedIn] = useState(false)
  const [isPaid, setIsPaid] = useState(false)
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')
  const [debouncedSearch, setDebouncedSearch] = useState('')
  const [categoryFilter, setCategoryFilter] = useState<string>('')
  const [priceTierFilter, setPriceTierFilter] = useState<string>('')
  const [sortMode, setSortMode] = useState<SortMode>('az')
  // Aggregate watch counts from /api/stores/watch-counts — used by both
  // the "Most watched" sort and the "Popular this week" callout.
  const [watchTotal, setWatchTotal] = useState<Record<string, number>>({})
  const [watchWeek, setWatchWeek] = useState<Record<string, number>>({})
  const [busyId, setBusyId] = useState<string | null>(null)
  const [limitModal, setLimitModal] = useState<{ current: number; allowed: number } | null>(null)
  // Back-to-top FAB visibility — appears after the user scrolls past
  // ~600px so they can jump back to the top of a long brand list.
  const [showToTop, setShowToTop] = useState(false)
  useEffect(() => {
    const onScroll = () => setShowToTop(window.scrollY > 600)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  // Bootstrap: load directory, collections, and (if signed in) the
  // user's current picks + tier. All in parallel — the page is read-
  // mostly so we batch the initial fetches.
  useEffect(() => {
    let cancelled = false
    Promise.all([
      // ?confirmed=true → only admin-curated active brands. Pending /
      // auto_added rows are still in admin review and shouldn't surface
      // to public visitors.
      fetch('/api/stores?confirmed=true').then((r) => (r.ok ? r.json() : { stores: [] })),
      fetch('/api/collections').then((r) => (r.ok ? r.json() : { collections: [] })),
      fetch('/api/store-picks').then((r) => (r.ok ? r.json() : { store_picks: [] })),
      fetch('/api/account').then((r) => (r.ok ? r.json() : null)).catch(() => null),
      fetch('/api/stores/watch-counts').then((r) => (r.ok ? r.json() : { total: {}, week: {} })).catch(() => ({ total: {}, week: {} })),
    ])
      .then(([storesRes, catsRes, picksRes, accountRes, countsRes]) => {
        if (cancelled) return
        setStores(storesRes.stores ?? [])
        setCategories(catsRes.collections ?? [])
        setStorePicks(picksRes.store_picks ?? [])
        setSignedIn(!!accountRes?.email)
        setIsPaid(accountRes?.tier === 'paid')
        setWatchTotal(countsRes.total ?? {})
        setWatchWeek(countsRes.week ?? {})
      })
      .finally(() => {
        if (!cancelled) setLoading(false)
      })
    return () => {
      cancelled = true
    }
  }, [])

  // Debounce search so we don't filter on every keystroke (1700+ stores
  // is still snappy but the user-perceived smoothness improves).
  useEffect(() => {
    // Strip non-alphanumerics so "dr martens" / "drmartens" / "Dr. Martens"
    // all match — punctuation in store names shouldn't break search.
    const t = setTimeout(
      () => setDebouncedSearch(search.trim().toLowerCase().replace(/[^a-z0-9]/g, '')),
      180
    )
    return () => clearTimeout(t)
  }, [search])

  const pickedStoreIds = useMemo(
    () => new Set(storePicks.map((p) => p.store_id)),
    [storePicks]
  )
  const pickIdByStore = useMemo(
    () => new Map(storePicks.map((p) => [p.store_id, p.id])),
    [storePicks]
  )

  // Filter pipeline: search → collection → price tier. Then sort by
  // the user's chosen mode (default A-Z mirrors /api/stores' natural
  // order so we only pay for the sort when they switch modes).
  const filteredStores = useMemo(() => {
    const filtered = stores.filter((s) => {
      if (debouncedSearch && !s.name.toLowerCase().replace(/[^a-z0-9]/g, '').includes(debouncedSearch)) return false
      if (categoryFilter && !(s.categories ?? []).includes(categoryFilter)) return false
      if (priceTierFilter && s.price_tier !== priceTierFilter) return false
      return true
    })
    if (sortMode === 'az') return filtered
    if (sortMode === 'newest') {
      return [...filtered].sort((a, b) => {
        const da = a.date_added ? new Date(a.date_added).getTime() : 0
        const db = b.date_added ? new Date(b.date_added).getTime() : 0
        return db - da
      })
    }
    // most_watched — secondary sort by name to keep deterministic order
    // when many stores tie at 0 watches.
    return [...filtered].sort((a, b) => {
      const ca = watchTotal[a.id] ?? 0
      const cb = watchTotal[b.id] ?? 0
      if (cb !== ca) return cb - ca
      return a.name.localeCompare(b.name)
    })
  }, [stores, debouncedSearch, categoryFilter, priceTierFilter, sortMode, watchTotal])

  // Top 8 of this week's most-watched, surfaced as a "Popular this
  // week" callout above the grid. Skipped entirely if no week-level
  // activity yet (cold start / no signups).
  const popularThisWeek = useMemo(() => {
    const entries = Object.entries(watchWeek)
      .filter(([, n]) => n > 0)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 8)
    const byId = new Map(stores.map((s) => [s.id, s]))
    return entries
      .map(([id, count]) => {
        const store = byId.get(id)
        return store ? { store, count } : null
      })
      .filter((x): x is { store: DirectoryStore; count: number } => x !== null)
  }, [watchWeek, stores])

  const addPick = useCallback(async (storeId: string) => {
    if (!signedIn) {
      // Redirect to login; come back here after.
      window.location.href = `/login?next=${encodeURIComponent('/stores')}`
      return
    }
    setBusyId(storeId)
    try {
      const res = await fetch('/api/store-picks', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ store_id: storeId }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        if (d?.over_limit) {
          setLimitModal({
            current: d.current_picks ?? FREE_PICK_LIMIT,
            allowed: d.allowed_picks ?? FREE_PICK_LIMIT,
          })
          return
        }
        alert(d.error ?? 'Could not add')
        return
      }
      // Refetch picks so the chip flips state without a full reload.
      const refreshed = await fetch('/api/store-picks').then((r) => r.json())
      setStorePicks(refreshed.store_picks ?? [])
      trackEvent('store_add', { location: 'stores_page' })
    } finally {
      setBusyId(null)
    }
  }, [signedIn])

  const removePick = useCallback(async (storeId: string) => {
    const pickId = pickIdByStore.get(storeId)
    if (!pickId) return
    setBusyId(storeId)
    try {
      const res = await fetch(`/api/store-picks/${pickId}`, { method: 'DELETE' })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        alert(d.error ?? 'Could not remove')
        return
      }
      setStorePicks((prev) => prev.filter((p) => p.id !== pickId))
    } finally {
      setBusyId(null)
    }
  }, [pickIdByStore])

  return (
    <>
      <DossierNav active="stores" />

      <section className="page-head light">
        <div className="page-head-inner">
          <p className="page-kicker">— The Directory —</p>
          <h1 className="page-title">
            Browse <em>every brand</em> we track.
          </h1>
          <p className="page-sub">
            {loading
              ? 'Loading the dossier…'
              : `${stores.length.toLocaleString()} brands. Pick the ones you actually shop or hunt for items you actually need. We'll send their current sales — before you head out.`}
          </p>
        </div>
      </section>

      <section className="form-section">
        <div className="form-wrap">
          {/* Back link to the picker — once a user has dropped into
              /stores from the home picker, they need a one-tap way
              back to finish editing or hit Send. Sits right above the
              search input so it's the first thing a returning visitor
              sees inside the working area. */}
          <p style={{ margin: '0 0 14px', fontFamily: "'Stardos Stamp', monospace", fontSize: 13, letterSpacing: '.08em' }}>
            <a
              href="/"
              style={{ color: 'var(--red-deep)', textDecoration: 'none' }}
            >
              ← Back to your picks
            </a>
          </p>
          {/* ── Search + collection filter ───────────────────────────── */}
          <div
            style={{
              display: 'flex',
              flexWrap: 'wrap',
              gap: 12,
              alignItems: 'center',
              marginBottom: 20,
            }}
          >
            <input
              type="search"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Search brands…"
              style={{
                flex: '1 1 240px',
                minHeight: 44,
                padding: '10px 14px',
                fontFamily: "'Special Elite', monospace",
                fontSize: 15,
                border: '2px solid var(--ink, #181612)',
                background: '#fff8e2',
                boxSizing: 'border-box',
              }}
            />
            {(search || categoryFilter) && (
              <button
                type="button"
                onClick={() => { setSearch(''); setCategoryFilter('') }}
                style={{
                  padding: '10px 16px',
                  minHeight: 44,
                  border: '2px solid var(--ink)',
                  background: 'transparent',
                  fontFamily: "'Stardos Stamp', monospace",
                  fontSize: 12,
                  letterSpacing: '.14em',
                  textTransform: 'uppercase',
                  cursor: 'pointer',
                }}
              >
                Clear
              </button>
            )}
          </div>

          {/* Collection chip filter — horizontal scroll on narrow screens */}
          {categories.length > 0 && (
            <div
              style={{
                display: 'flex',
                gap: 6,
                marginBottom: 12,
                overflowX: 'auto',
                paddingBottom: 6,
              }}
            >
              <button
                type="button"
                onClick={() => setCategoryFilter('')}
                style={chipStyle(categoryFilter === '')}
              >
                All
              </button>
              {categories.map((c) => (
                <button
                  key={c.slug}
                  type="button"
                  onClick={() => setCategoryFilter(c.slug === categoryFilter ? '' : c.slug)}
                  style={chipStyle(categoryFilter === c.slug)}
                >
                  {c.label}
                </button>
              ))}
            </div>
          )}

          {/* ── Sort + price tier row ───────────────────────────────── */}
          <div
            style={{
              display: 'flex',
              flexWrap: 'wrap',
              alignItems: 'center',
              gap: 14,
              marginBottom: 20,
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
              <span className="t-meta" style={{ fontSize: 11, color: 'var(--ink-55)', letterSpacing: '.14em', textTransform: 'uppercase' }}>Sort</span>
              {([
                { id: 'az' as SortMode, label: 'A–Z' },
                { id: 'newest' as SortMode, label: 'Newest' },
                { id: 'most_watched' as SortMode, label: 'Most watched' },
              ]).map((m) => (
                <button
                  key={m.id}
                  type="button"
                  onClick={() => setSortMode(m.id)}
                  style={chipStyle(sortMode === m.id)}
                >
                  {m.label}
                </button>
              ))}
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
              <span className="t-meta" style={{ fontSize: 11, color: 'var(--ink-55)', letterSpacing: '.14em', textTransform: 'uppercase' }}>Price</span>
              <button
                type="button"
                onClick={() => setPriceTierFilter('')}
                style={chipStyle(priceTierFilter === '')}
              >
                Any
              </button>
              {PRICE_TIERS.map((t) => (
                <button
                  key={t}
                  type="button"
                  onClick={() => setPriceTierFilter(t === priceTierFilter ? '' : t)}
                  style={chipStyle(priceTierFilter === t)}
                >
                  {t}
                </button>
              ))}
            </div>
          </div>

          {/* ── Popular this week callout ───────────────────────────── */}
          {!loading && popularThisWeek.length > 0 && (
            <div
              style={{
                marginBottom: 24,
                padding: '16px 18px',
                background: '#fff8e2',
                border: '2px dashed var(--ink)',
                position: 'relative',
              }}
            >
              <div
                style={{
                  fontFamily: "'Stardos Stamp', monospace",
                  fontSize: 11,
                  letterSpacing: '.22em',
                  textTransform: 'uppercase',
                  color: 'var(--red-deep)',
                  marginBottom: 10,
                }}
              >
                — Popular this week —
              </div>
              <div
                style={{
                  display: 'flex',
                  gap: 8,
                  overflowX: 'auto',
                  paddingBottom: 4,
                }}
              >
                {popularThisWeek.map(({ store, count }) => {
                  const picked = pickedStoreIds.has(store.id)
                  const overCap = signedIn && !isPaid && !picked && storePicks.length >= FREE_PICK_LIMIT
                  return (
                    <button
                      key={store.id}
                      type="button"
                      onClick={() => (picked ? removePick(store.id) : addPick(store.id))}
                      disabled={busyId === store.id || (overCap && !picked)}
                      title={
                        picked
                          ? `Watching ${store.name}`
                          : !signedIn
                            ? `Sign in to add ${store.name} to your watchlist`
                            : `Add ${store.name} to your watchlist`
                      }
                      style={{
                        flex: '0 0 auto',
                        display: 'inline-flex',
                        alignItems: 'center',
                        gap: 8,
                        padding: '8px 12px',
                        background: picked ? 'var(--olive-deep)' : 'var(--paper)',
                        color: picked ? '#fff8e2' : 'var(--ink)',
                        border: `1.5px solid ${picked ? 'var(--olive-deep)' : 'var(--ink)'}`,
                        boxShadow: '2px 2px 0 var(--ink)',
                        cursor: overCap && !picked ? 'not-allowed' : 'pointer',
                        opacity: overCap && !picked ? 0.5 : 1,
                        fontFamily: 'var(--font-serif)',
                        fontSize: 14,
                        fontWeight: 500,
                        whiteSpace: 'nowrap',
                      }}
                    >
                      {store.name}
                      <span
                        style={{
                          fontFamily: "'Stardos Stamp', monospace",
                          fontSize: 10,
                          letterSpacing: '.12em',
                          background: picked ? '#fff8e2' : 'var(--red)',
                          color: picked ? 'var(--olive-deep)' : '#fff8e2',
                          padding: '1px 6px',
                        }}
                      >
                        +{count}
                      </span>
                    </button>
                  )
                })}
              </div>
            </div>
          )}

          {/* ── Result count ────────────────────────────────────────── */}
          <p className="t-meta" style={{ color: 'var(--ink-55)', fontSize: 13, marginBottom: 12 }}>
            {loading
              ? 'Loading…'
              : filteredStores.length === stores.length
                ? `${stores.length.toLocaleString()} brands`
                : `${filteredStores.length.toLocaleString()} of ${stores.length.toLocaleString()} brands match`}
          </p>

          {/* ── The grid ─────────────────────────────────────────────── */}
          {!loading && filteredStores.length === 0 ? (
            <div
              style={{
                padding: '40px 24px',
                textAlign: 'center',
                fontFamily: "'IM Fell English', serif",
                fontStyle: 'italic',
                fontSize: 17,
                color: 'var(--ink-soft)',
                border: '2px dashed var(--ink-15)',
                background: '#fff8e2',
              }}
            >
              No brands match. Try a different search.
              {' '}
              <a href="/suggest" style={{ color: 'var(--red-deep)', textDecoration: 'underline' }}>Suggest one</a>
              {' '}we&rsquo;re missing.
            </div>
          ) : (
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))',
                gap: 10,
              }}
            >
              {filteredStores.map((s) => {
                const picked = pickedStoreIds.has(s.id)
                const busy = busyId === s.id
                const overCap = signedIn && !isPaid && !picked && storePicks.length >= FREE_PICK_LIMIT
                return (
                  <div
                    key={s.id}
                    style={{
                      border: '1.5px solid var(--ink-15)',
                      background: 'var(--paper)',
                      padding: '12px 14px',
                      display: 'flex',
                      flexDirection: 'column',
                      gap: 6,
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', gap: 10 }}>
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <a
                          href={s.website.startsWith('http') ? s.website : `https://${s.website}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          style={{
                            fontFamily: 'var(--font-serif)',
                            fontSize: 17,
                            fontWeight: 500,
                            color: 'var(--ink)',
                            textDecoration: 'none',
                            borderBottom: '1px dotted var(--ink-40)',
                          }}
                          title="Open brand website"
                        >
                          {s.name}
                        </a>
                        <div
                          style={{
                            fontFamily: 'var(--font-mono, monospace)',
                            fontSize: 11,
                            color: 'var(--ink-55)',
                            marginTop: 2,
                            overflow: 'hidden',
                            textOverflow: 'ellipsis',
                            whiteSpace: 'nowrap',
                          }}
                        >
                          {s.website.replace(/^https?:\/\//, '').replace(/\/$/, '')}
                          {s.price_tier && <span style={{ marginLeft: 8, color: 'var(--ink-40)' }}>{s.price_tier}</span>}
                        </div>
                      </div>
                      {picked ? (
                        <button
                          type="button"
                          onClick={() => removePick(s.id)}
                          disabled={busy}
                          title="Remove from your watchlist"
                          style={{
                            ...pillStyle('var(--olive-deep)', '#fff8e2'),
                            border: '1.5px solid var(--olive-deep)',
                            cursor: busy ? 'wait' : 'pointer',
                          }}
                        >
                          {busy ? '…' : '✓ Watching'}
                        </button>
                      ) : (
                        <button
                          type="button"
                          onClick={() => addPick(s.id)}
                          disabled={busy || overCap}
                          title={
                            !signedIn
                              ? 'Sign in to add this store to your watchlist'
                              : overCap
                                ? 'Free-tier limit reached — upgrade for unlimited'
                                : 'Add to your watchlist'
                          }
                          style={{
                            ...pillStyle(overCap ? 'transparent' : '#fff8e2', overCap ? 'var(--ink-40)' : 'var(--ink)'),
                            border: `1.5px solid ${overCap ? 'var(--ink-25, #cbc4ad)' : 'var(--ink)'}`,
                            cursor: overCap ? 'not-allowed' : (busy ? 'wait' : 'pointer'),
                            opacity: overCap ? 0.6 : 1,
                          }}
                        >
                          {busy ? '…' : signedIn ? '+ Add' : '+ Sign in'}
                        </button>
                      )}
                    </div>
                  </div>
                )
              })}
            </div>
          )}

          {/* CTA at the bottom of the page so visitors who scroll the whole
              list still have a clear next action. Back link on the left
              gets users home in one tap without scrolling all the way up. */}
          <div style={{ marginTop: 36, display: 'flex', flexWrap: 'wrap', gap: 16, justifyContent: 'center', alignItems: 'center' }}>
            <a href="/" className="btn-ghost" style={{ display: 'inline-block', padding: '12px 22px', fontFamily: "'Stardos Stamp', monospace", fontSize: 13, letterSpacing: '.14em', textTransform: 'uppercase' }}>
              ← Back to your picks
            </a>
            <a href="/suggest" className="btn-ghost" style={{ display: 'inline-block', padding: '12px 22px', fontFamily: "'Stardos Stamp', monospace", fontSize: 13, letterSpacing: '.14em', textTransform: 'uppercase' }}>
              Missing a brand? Suggest one →
            </a>
          </div>
        </div>
      </section>

      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/">Home</a> · <a href="/suggest">Suggest a Store</a> · <a href="/">Settings</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>

      {limitModal && (
        <LimitModal
          current={limitModal.current}
          allowed={limitModal.allowed}
          onClose={() => setLimitModal(null)}
        />
      )}

      {/* ── Back-to-top FAB ─────────────────────────────────────────────
          Fixed bottom-right, shows after the user scrolls past the fold.
          Stamp-styled square in the Dossier ink+paper palette so it
          reads as native to the page rather than a generic Material FAB. */}
      {showToTop && (
        <button
          type="button"
          onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
          aria-label="Back to top"
          style={{
            position: 'fixed',
            bottom: 24,
            right: 24,
            width: 52,
            height: 52,
            border: '2px solid var(--ink)',
            background: 'var(--red, #c8413a)',
            color: 'var(--paper, #f6ecd2)',
            boxShadow: '3px 3px 0 var(--ink)',
            fontFamily: "'Stardos Stamp', monospace",
            fontSize: 12,
            letterSpacing: '.1em',
            cursor: 'pointer',
            zIndex: 50,
          }}
        >
          ↑ TOP
        </button>
      )}
    </>
  )
}

function chipStyle(active: boolean): React.CSSProperties {
  return {
    flex: '0 0 auto',
    padding: '8px 12px',
    border: `1.5px solid ${active ? 'var(--ink)' : 'var(--ink-15)'}`,
    background: active ? 'var(--ink)' : 'transparent',
    color: active ? 'var(--paper, #f6ecd2)' : 'var(--ink)',
    fontFamily: "'Stardos Stamp', monospace",
    fontSize: 11,
    letterSpacing: '.14em',
    textTransform: 'uppercase',
    cursor: 'pointer',
    whiteSpace: 'nowrap',
  }
}

function pillStyle(bg: string, fg: string): React.CSSProperties {
  return {
    flex: '0 0 auto',
    padding: '6px 10px',
    background: bg,
    color: fg,
    fontFamily: "'Stardos Stamp', monospace",
    fontSize: 11,
    letterSpacing: '.14em',
    textTransform: 'uppercase',
  }
}

// Tiny inline modal — kept here instead of importing the
// LimitReachedModal from /preferences so this page has no cross-page
// dependency. Same visual language so the experience is consistent.
function LimitModal({
  current,
  allowed,
  onClose,
}: {
  current: number
  allowed: number
  onClose: () => void
}) {
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    document.addEventListener('keydown', onKey)
    const prev = document.body.style.overflow
    document.body.style.overflow = 'hidden'
    return () => {
      document.removeEventListener('keydown', onKey)
      document.body.style.overflow = prev
    }
  }, [onClose])

  return (
    <div
      role="dialog"
      aria-modal="true"
      onClick={onClose}
      style={{
        position: 'fixed', inset: 0,
        background: 'rgba(13, 12, 10, 0.65)',
        zIndex: 1200,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '24px 16px',
      }}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{
          background: '#f6ecd2',
          maxWidth: 460,
          width: '100%',
          border: '2.5px solid #181612',
          boxShadow: '6px 6px 0 #181612',
          padding: 'clamp(20px, 5vw, 28px)',
          maxHeight: '90vh',
          overflowY: 'auto',
          position: 'relative',
        }}
      >
        <div style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: '#b3211a', marginBottom: 8 }}>
          — You&rsquo;ve hit your limit —
        </div>
        <h3 style={{ margin: '0 0 14px', fontFamily: "'Alfa Slab One', serif", fontWeight: 400, fontSize: 'clamp(22px, 6vw, 28px)', lineHeight: 1.05 }}>
          {allowed} picks max <span style={{ fontFamily: "'Alfa Slab One', serif", textShadow: '2px 2px 0 #d4322a, 4px 4px 0 #b3211a', padding: '0 .04em' }}>on free.</span>
        </h3>
        <p style={{ margin: '0 0 22px', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 16, lineHeight: 1.5 }}>
          You have {current} picks. Upgrade to <strong style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal' }}>Personal Shopper</strong> for unlimited category and store picks.
        </p>
        <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
          <a
            href="/pricing"
            style={{
              flex: '1 1 200px', minHeight: 48,
              fontFamily: "'Alfa Slab One', serif", fontSize: 14, letterSpacing: '.08em', textTransform: 'uppercase',
              background: '#d4322a', color: '#fff8e2',
              padding: '14px 18px 12px', border: '2px solid #181612', boxShadow: '4px 4px 0 #181612',
              textDecoration: 'none', textAlign: 'center',
            }}
          >
            Upgrade →
          </a>
          <button
            type="button"
            onClick={onClose}
            style={{
              flex: '1 1 200px', minHeight: 48,
              fontFamily: "'Special Elite', monospace", fontSize: 13,
              background: 'transparent', color: '#181612',
              padding: '14px 18px 12px', border: '2px solid #181612', cursor: 'pointer',
            }}
          >
            Maybe later
          </button>
        </div>
      </div>
    </div>
  )
}
