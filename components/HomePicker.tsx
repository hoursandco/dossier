'use client'

// HomePicker — the homepage's picker + actions surface.
//
// UX mirrors /preferences pixel-for-pixel by reusing its CSS classes
// (.cat-list / .cat / .cat-head / .swatch / .chip-group / .chip /
//  .selected-summary / .danger / etc.) which are styled in
// redesign.css. Same colored drawer headers, same chip style, same
// danger-zone footer.
//
// Two modes:
//   - Signed-OUT: anonymous picks held in state → email field at the
//     bottom → submit creates subscriber + saves picks + magic link.
//   - Signed-IN:  loads existing watches + store picks, toggles
//     persist immediately, action panel is SEND ME DEALS NOW +
//     upgrade box (free only) + Unsubscribe + Delete account.

import { useCallback, useEffect, useMemo, useState } from 'react'
import { trackPixel } from '@/lib/pixel'
import { trackEvent } from '@/lib/analytics'
import { groupCategories } from '@/lib/categoryGroups'

type Category = { slug: string; label: string; group_name?: string | null }
type StoreLite = { id: string; name: string }
type PickerTab = 'categories' | 'stores'

const FREE_PICK_LIMIT = 3

function normName(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export function HomePicker() {
  const [signedIn, setSignedIn] = useState<boolean | null>(null)
  const [accountEmail, setAccountEmail] = useState<string | null>(null)
  const [isPaid, setIsPaid] = useState(false)
  const [categories, setCategories] = useState<Category[]>([])
  const [stores, setStores] = useState<StoreLite[]>([])
  const [storesLoaded, setStoresLoaded] = useState(false)
  const [pickerTab, setPickerTab] = useState<PickerTab>('categories')
  const [openGroups, setOpenGroups] = useState<Set<string>>(new Set())

  const [pickedCats, setPickedCats] = useState<Set<string>>(new Set())
  const [pickedStores, setPickedStores] = useState<StoreLite[]>([])

  const [watchIdBySlug, setWatchIdBySlug] = useState<Map<string, string>>(new Map())
  const [pickIdByStoreId, setPickIdByStoreId] = useState<Map<string, string>>(new Map())

  // Paid-tier filters (migration 029). null/empty = no filter.
  // Free users see the controls but can't change them — the lock
  // badge above the section links to /pricing.
  const [minDiscountPct, setMinDiscountPct] = useState<number | null>(null)
  const [allowedTiers, setAllowedTiers] = useState<Set<string>>(new Set())
  // Bottom-of-email opt-ins (migration 031). All default false so a
  // free user sees the cleaner email; paid users opt into compact
  // brand-list sections at the bottom.
  const [includeFreeShipping, setIncludeFreeShipping] = useState(false)
  const [includeBogo, setIncludeBogo] = useState(false)
  const [includeGwp, setIncludeGwp] = useState(false)

  const [storeQuery, setStoreQuery] = useState('')
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [sendingDeals, setSendingDeals] = useState(false)
  const [statusMsg, setStatusMsg] = useState('')
  const [error, setError] = useState('')

  useEffect(() => {
    fetch('/api/categories')
      .then((r) => (r.ok ? r.json() : { categories: [] }))
      .then((d) => setCategories(d.categories ?? []))
      .catch(() => {})
    // Only confirmed brands surface in the picker — pending /
    // auto_added rows are still in admin review.
    fetch('/api/stores?confirmed=true')
      .then((r) => (r.ok ? r.json() : { stores: [] }))
      .then((d) => {
        const arr = (d.stores ?? []) as Array<{ id: string; name: string }>
        setStores(arr.map((s) => ({ id: s.id, name: s.name })))
        setStoresLoaded(true)
      })
      .catch(() => setStoresLoaded(true))

    // cache: 'no-store' so the browser refetches on every mount. Without
    // it, a returning user (e.g. just activated a comp code on /pricing
    // and clicked back to the watchlist) would see a stale tier from
    // a previous page load — banner stuck on "Inbox Cleaner" even
    // though they're now "Personal Shopper" in the DB.
    fetch('/api/account', { cache: 'no-store' })
      .then(async (r) => {
        if (!r.ok) {
          setSignedIn(false)
          return
        }
        const d = await r.json()
        if (d?.email) {
          setSignedIn(true)
          setAccountEmail(d.email)
          setIsPaid(d.tier === 'paid')
          // Hydrate the paid-tier filter state from the API. For free
          // users these will be null/empty and the UI stays in
          // "locked, defaults" state.
          if (typeof d.min_discount_pct === 'number') {
            setMinDiscountPct(d.min_discount_pct)
          }
          if (Array.isArray(d.allowed_price_tiers) && d.allowed_price_tiers.length > 0) {
            setAllowedTiers(new Set(d.allowed_price_tiers))
          }
          setIncludeFreeShipping(!!d.include_free_shipping)
          setIncludeBogo(!!d.include_bogo)
          setIncludeGwp(!!d.include_gwp)
          const [watchesRes, picksRes] = await Promise.all([
            fetch('/api/watches').then((r) => (r.ok ? r.json() : { watches: [] })).catch(() => ({ watches: [] })),
            fetch('/api/store-picks').then((r) => (r.ok ? r.json() : { store_picks: [] })).catch(() => ({ store_picks: [] })),
          ])
          const watches = (watchesRes.watches ?? []) as Array<{ id: string; category_slug: string }>
          const picks = (picksRes.store_picks ?? []) as Array<{ id: string; store_id: string; store_name?: string }>
          setPickedCats(new Set(watches.map((w) => w.category_slug)))
          setWatchIdBySlug(new Map(watches.map((w) => [w.category_slug, w.id] as const)))
          setPickedStores(picks.map((p) => ({ id: p.store_id, name: p.store_name || '' })))
          setPickIdByStoreId(new Map(picks.map((p) => [p.store_id, p.id] as const)))
        } else {
          setSignedIn(false)
        }
      })
      .catch(() => setSignedIn(false))
  }, [])

  const grouped = useMemo(() => groupCategories(categories), [categories])

  const pickedStoreIds = useMemo(() => new Set(pickedStores.map((s) => s.id)), [pickedStores])

  const storeResults = useMemo(() => {
    const q = normName(storeQuery.trim())
    if (!q) return [] as StoreLite[]
    return stores
      .filter((s) => !pickedStoreIds.has(s.id) && normName(s.name).includes(q))
      .slice(0, 8)
  }, [storeQuery, stores, pickedStoreIds])

  const watchCount = pickedCats.size
  const storeCount = pickedStores.length
  const totalPicks = watchCount + storeCount
  const overLimit = totalPicks > FREE_PICK_LIMIT && !isPaid
  const tierLabel = isPaid ? 'Personal Shopper' : 'Inbox Cleaner'

  const toggleGroup = (name: string) => {
    setOpenGroups((prev) => {
      const n = new Set(prev)
      if (n.has(name)) n.delete(name)
      else n.add(name)
      return n
    })
  }

  // Wipe every selected category at once. Signed-out users only need
  // local state cleared; signed-in users also need each saved watch
  // deleted from the DB. We fire the DELETEs in parallel and don't
  // wait for them — the UI optimistically clears immediately, and if
  // one DELETE fails it'll resurface on the next page load (no harm).
  const clearAllCats = useCallback(async () => {
    if (pickedCats.size === 0) return
    if (!confirm(`Clear all ${pickedCats.size} ${pickedCats.size === 1 ? 'category' : 'categories'}?`)) return
    const ids = Array.from(watchIdBySlug.values())
    setPickedCats(new Set())
    setWatchIdBySlug(new Map())
    if (!signedIn) return
    await Promise.allSettled(
      ids.map((id) => fetch(`/api/watches/${id}`, { method: 'DELETE' })),
    )
  }, [pickedCats, watchIdBySlug, signedIn])

  const toggleCat = useCallback(
    async (slug: string) => {
      if (!signedIn) {
        setPickedCats((prev) => {
          const n = new Set(prev)
          if (n.has(slug)) n.delete(slug)
          else n.add(slug)
          return n
        })
        return
      }
      if (pickedCats.has(slug)) {
        const watchId = watchIdBySlug.get(slug)
        if (!watchId) return
        setPickedCats((prev) => { const n = new Set(prev); n.delete(slug); return n })
        setWatchIdBySlug((prev) => { const n = new Map(prev); n.delete(slug); return n })
        try { await fetch(`/api/watches/${watchId}`, { method: 'DELETE' }) } catch {}
      } else {
        setPickedCats((prev) => new Set(prev).add(slug))
        try {
          const res = await fetch('/api/watches', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ category_slug: slug }),
          })
          if (res.ok) {
            const d = await res.json()
            const newId = d.watch?.id ?? d.id
            if (newId) setWatchIdBySlug((prev) => new Map(prev).set(slug, newId))
          } else {
            setPickedCats((prev) => { const n = new Set(prev); n.delete(slug); return n })
          }
        } catch {
          setPickedCats((prev) => { const n = new Set(prev); n.delete(slug); return n })
        }
      }
    },
    [signedIn, pickedCats, watchIdBySlug]
  )

  const addStore = useCallback(
    async (s: StoreLite) => {
      setPickedStores((prev) => [...prev, s])
      setStoreQuery('')
      if (!signedIn) return
      try {
        const res = await fetch('/api/store-picks', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ store_id: s.id }),
        })
        if (res.ok) {
          const d = await res.json()
          const pickId = d.store_pick?.id
          if (pickId) setPickIdByStoreId((prev) => new Map(prev).set(s.id, pickId))
        } else {
          setPickedStores((prev) => prev.filter((x) => x.id !== s.id))
        }
      } catch {
        setPickedStores((prev) => prev.filter((x) => x.id !== s.id))
      }
    },
    [signedIn]
  )

  const removeStore = useCallback(
    async (id: string) => {
      const pickId = pickIdByStoreId.get(id)
      setPickedStores((prev) => prev.filter((s) => s.id !== id))
      setPickIdByStoreId((prev) => { const n = new Map(prev); n.delete(id); return n })
      if (!signedIn || !pickId) return
      try { await fetch(`/api/store-picks/${pickId}`, { method: 'DELETE' }) } catch {}
    },
    [signedIn, pickIdByStoreId]
  )

  const handleAnonSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email || totalPicks === 0) return
    setSubmitting(true)
    setError('')
    try {
      const subRes = await fetch('/api/subscribe', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email,
          watches: Array.from(pickedCats),
          store_ids: pickedStores.map((s) => s.id),
        }),
      })
      if (!subRes.ok) {
        const d = await subRes.json().catch(() => ({}))
        setError(d.error || 'Could not save your picks. Please try again.')
        setSubmitting(false)
        return
      }
      const mlRes = await fetch('/api/auth/magic-link', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, redirectTo: `${window.location.origin}/auth/callback` }),
      })
      if (mlRes.ok) {
        setSubmitted(true)
        trackPixel('Lead')
        trackEvent('sign_up', { method: 'magic_link', location: 'homepage_picker', category_picks: watchCount, store_picks: storeCount })
      } else {
        const d = await mlRes.json().catch(() => ({}))
        setError(d.error || 'Could not send the sign-in link.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  // Persist filter changes immediately (same pattern as the watchlist
  // toggles further up the file). Only fires for paid users; free
  // users never hit these handlers — the lock badge intercepts clicks.
  const saveMinDiscount = useCallback(async (next: number | null) => {
    setMinDiscountPct(next)
    try {
      await fetch('/api/account', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ min_discount_pct: next }),
      })
    } catch {}
  }, [])

  // PATCH a single include_* boolean. Optimistic — flip local state
  // first, then write. If the server rejects we just leave the local
  // flip (the next page load will rehydrate from the DB).
  const updateInclude = useCallback(
    async (key: 'include_free_shipping' | 'include_bogo' | 'include_gwp', value: boolean) => {
      if (key === 'include_free_shipping') setIncludeFreeShipping(value)
      else if (key === 'include_bogo') setIncludeBogo(value)
      else setIncludeGwp(value)
      try {
        await fetch('/api/account', {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ [key]: value }),
        })
      } catch {}
    },
    [],
  )

  const toggleTier = useCallback(async (tier: string) => {
    const next = new Set(allowedTiers)
    if (next.has(tier)) next.delete(tier)
    else next.add(tier)
    setAllowedTiers(next)
    try {
      await fetch('/api/account', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ allowed_price_tiers: Array.from(next) }),
      })
    } catch {}
  }, [allowedTiers])

  const sendDealsNow = async () => {
    if (totalPicks === 0) { setError('Pick at least one above first.'); return }
    setSendingDeals(true); setError(''); setStatusMsg('')
    try {
      const res = await fetch('/api/deals/refresh', { method: 'POST' })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) { setError(d.error || 'Send failed.'); return }
      const n = d.total_deals ?? d.deals ?? 0
      setStatusMsg(n > 0
        ? `Sent — ${n} ${n === 1 ? 'deal' : 'deals'} on the way to your inbox.`
        : `Nothing fresh right now. We'll keep watching and email when something lands.`)
      trackEvent('deals_pull', { deals_count: n })
    } catch { setError('Send failed.') } finally { setSendingDeals(false) }
  }

  const handleLogout = async () => {
    try {
      await fetch('/api/auth/logout', { method: 'POST' })
    } catch {
      // best-effort: even if the network call fails, reloading drops
      // the in-memory session state so the user sees a signed-out
      // page next.
    }
    window.location.href = '/'
  }

  const handleUnsubscribe = async () => {
    if (!confirm('Unsubscribe? You stop receiving deal emails but your account stays so you can resubscribe later.')) return
    try {
      const res = await fetch('/api/unsubscribe', { method: 'POST' })
      if (res.ok) setStatusMsg('Unsubscribed. You can re-enable emails from settings any time.')
      else setError('Could not unsubscribe.')
    } catch { setError('Could not unsubscribe.') }
  }

  const handleDeleteAccount = async () => {
    if (!accountEmail) return
    if (!confirm('Delete your account and ALL your data?\n\nThis wipes your watchlist, store picks, send history, and your sign-in. Irreversible.\n\nClick OK to confirm, then type your email on the next prompt.')) return
    const typed = prompt(`Type "${accountEmail}" to confirm:`)
    if (typed !== accountEmail) { alert('Email did not match. Delete cancelled.'); return }
    try {
      const res = await fetch('/api/account/delete', { method: 'DELETE' })
      if (!res.ok) { const d = await res.json().catch(() => ({})); setError(d.error || 'Delete failed.'); return }
      window.location.href = '/'
    } catch { setError('Delete failed.') }
  }

  if (submitted) {
    return (
      <section className="form-section">
        <div className="form-wrap-narrow">
          <div className="form-card flush" style={{ textAlign: 'center' }}>
            <p className="form-step">— Check Inbox —</p>
            <h2 className="form-h">
              Your magic link is{' '}
              <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>
                on its way.
              </em>
            </h2>
            <p style={{ fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 18, lineHeight: 1.5, color: 'var(--ink-soft)' }}>
              We sent a sign-in link to <strong style={{ fontFamily: "'Special Elite', monospace", fontStyle: 'normal' }}>{email}</strong>. Click it to finish — your {totalPicks} {totalPicks === 1 ? 'pick' : 'picks'} {totalPicks === 1 ? 'is' : 'are'} already saved.
            </p>
            <p style={{ marginTop: 14, fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--ink-soft)' }}>
              The link expires in 24 hours · No password, ever
            </p>
          </div>
        </div>
      </section>
    )
  }

  return (
    <section className="form-section">
      <div className="form-wrap-narrow">
        {/* Drop `flush` so the form-card lifts INTO the dark hero above,
            matching /preferences. We override the default -180px lift
            with a clamped value so the counters that live at the bottom
            of the hero don't get eaten by the form. Hero's padding-
            bottom was bumped in redesign.css to leave clearance. */}
        <div
          className="form-card"
          style={{ marginTop: 'clamp(-140px, -14vw, -80px)' }}
        >
          {/* (Form-tag "NO PASSWORD EVER" corner sticker removed — the
              counters now straddle the form-card's top edge and the
              sticker was crowding them.) */}

          {/* Signed-in banner — green bar with account summary. Mirrors
              the /preferences page's .sub-banner. Anonymous visitors
              don't see it (we're about to ask them to sign up). */}
          {signedIn === true && accountEmail && (
            <div className="sub-banner">
              <div style={{
                width: 36, height: 36, borderRadius: '50%',
                background: '#fff8e2', color: 'var(--green-deep)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontFamily: "'Alfa Slab One', serif", fontSize: 22,
                border: '2px solid var(--ink)', flexShrink: 0,
              }}>✱</div>
              <div style={{ minWidth: 0, wordBreak: 'break-word' }}>
                <strong>Signed in</strong><br />
                <span style={{ fontSize: 14 }}>
                  {accountEmail} · {tierLabel} · {totalPicks} active {totalPicks === 1 ? 'pick' : 'picks'}
                </span>
              </div>
            </div>
          )}

          {/* Header — matches /preferences */}
          <p className="form-step">— Your Watchlist —</p>
          <h2 className="form-h">
            {totalPicks === 0
              ? <>Pick what you&rsquo;re <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>shopping for.</em></>
              : <>What are you <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>shopping for?</em></>}
          </h2>

          {totalPicks === 0 ? (
            <div style={{ marginBottom: 16, padding: '18px 22px', background: '#fff8e2', border: '2px dashed var(--ink)', fontFamily: "'IM Fell English', serif", fontSize: 17, lineHeight: 1.5, color: 'var(--ink)' }}>
              Welcome in. Pick categories (broad — e.g. <em>Skincare</em>) or specific brands (narrow — e.g. <em>J.Crew</em>) — any mix. We&rsquo;ll email when real deals land. <em style={{ fontStyle: 'italic', color: 'var(--red-deep)' }}>Pick three to start — free.</em>
            </div>
          ) : (
            <p className="selected-summary">
              <b>{totalPicks}</b>
              {isPaid
                ? `active ${totalPicks === 1 ? 'pick' : 'picks'} · unlimited on Personal Shopper`
                : `of ${FREE_PICK_LIMIT} picks · ${watchCount} ${watchCount === 1 ? 'category' : 'categories'} + ${storeCount} ${storeCount === 1 ? 'store' : 'stores'}`}
            </p>
          )}

          {/* (Sends-paused warning moved down — now renders just
              above SEND ME DEALS NOW so it's right where the user
              looks for confirmation that the next send will work.) */}

          {/* Tabs */}
          <div role="tablist" style={{ display: 'flex', gap: 2, borderBottom: '2px solid var(--ink)', marginBottom: 16 }}>
            {([
              { id: 'categories' as PickerTab, label: `Categories${watchCount > 0 ? ` (${watchCount})` : ''}` },
              { id: 'stores' as PickerTab, label: `Stores${storeCount > 0 ? ` (${storeCount})` : ''}` },
            ]).map((t) => {
              const isActive = pickerTab === t.id
              return (
                <button
                  key={t.id}
                  type="button"
                  role="tab"
                  aria-selected={isActive}
                  onClick={() => setPickerTab(t.id)}
                  style={{
                    fontFamily: "'Stardos Stamp', monospace",
                    fontSize: 'clamp(11px, 3vw, 13px)',
                    letterSpacing: 'clamp(.08em, 1.2vw, .16em)',
                    textTransform: 'uppercase',
                    padding: '14px clamp(6px, 2.5vw, 20px) 12px',
                    minHeight: 44,
                    minWidth: 0,
                    flex: '1 1 0',
                    background: isActive ? 'var(--ink)' : 'transparent',
                    color: isActive ? 'var(--bone, #fff5d4)' : 'var(--ink-55, #6b6353)',
                    border: '2px solid var(--ink)',
                    borderBottom: 'none',
                    cursor: 'pointer',
                    marginBottom: '-2px',
                    whiteSpace: 'nowrap',
                    overflow: 'hidden',
                    textOverflow: 'ellipsis',
                  }}
                >
                  {t.label}
                </button>
              )
            })}
          </div>

          {/* Categories tab — uses /preferences .cat-list styling */}
          {pickerTab === 'categories' && (
            <div className="dl-field">
              {/* Clear-all link — only renders when at least one cat
                  is picked. Saves the user from opening every group
                  drawer to unpick individually. */}
              {pickedCats.size > 0 && (
                <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 8 }}>
                  <button
                    type="button"
                    onClick={clearAllCats}
                    style={{
                      background: 'none',
                      border: 'none',
                      padding: '4px 0',
                      color: 'var(--red-deep)',
                      fontFamily: "'Stardos Stamp', monospace",
                      fontSize: 11,
                      letterSpacing: '.18em',
                      textTransform: 'uppercase',
                      cursor: 'pointer',
                      textDecoration: 'underline',
                      textDecorationStyle: 'dotted',
                    }}
                  >
                    Clear all ({pickedCats.size})
                  </button>
                </div>
              )}
              <div className="cat-list">
                {grouped.length === 0 && (
                  <p style={{ textAlign: 'center', color: 'var(--ink-soft)', fontFamily: "'Special Elite', monospace", margin: 0, padding: '20px 0' }}>
                    Loading categories…
                  </p>
                )}
                {grouped.map((group) => {
                  const total = group.items.length
                  const onCount = group.items.filter((c) => pickedCats.has(c.slug)).length
                  const isOpen = openGroups.has(group.name)
                  return (
                    <div key={group.name} className={`cat ${isOpen ? 'open' : ''}`}>
                      <div className="cat-head" onClick={() => toggleGroup(group.name)}>
                        <span className="swatch" />
                        <h4>{group.name}</h4>
                        <span className={`cat-count ${onCount > 0 ? 'has' : ''}`}>
                          {onCount > 0 ? `${onCount} / ${total}` : `${total} types`}
                        </span>
                        <span className="cat-chevron">+</span>
                      </div>
                      <div className="cat-body">
                        <div className="chip-group">
                          {group.items.map((c) => {
                            const on = pickedCats.has(c.slug)
                            return (
                              <button
                                key={c.slug}
                                type="button"
                                className={`chip ${on ? 'on' : ''}`}
                                onClick={(e) => {
                                  e.stopPropagation()
                                  toggleCat(c.slug)
                                }}
                              >
                                {c.label}
                              </button>
                            )
                          })}
                        </div>
                      </div>
                    </div>
                  )
                })}
              </div>
            </div>
          )}

          {/* Stores tab */}
          {pickerTab === 'stores' && (
            <div className="dl-field">
              {pickedStores.length > 0 && (
                <div style={{ marginBottom: 16 }}>
                  <div className="t-meta" style={{ fontSize: 11, letterSpacing: '.16em', textTransform: 'uppercase', color: 'var(--ink-55)', marginBottom: 8 }}>
                    Watching {storeCount} {storeCount === 1 ? 'store' : 'stores'}
                  </div>
                  <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
                    {pickedStores.map((p) => (
                      <span key={p.id} style={{ display: 'inline-flex', alignItems: 'center', gap: 4, paddingLeft: 12, border: '1.5px solid var(--ink)', background: 'var(--ink)', color: 'var(--paper, #f6ecd2)', fontFamily: 'var(--font-mono, monospace)', fontSize: 13, minHeight: 36 }}>
                        {p.name}
                        <button
                          type="button"
                          onClick={() => removeStore(p.id)}
                          aria-label={`Remove ${p.name}`}
                          style={{ minWidth: 36, minHeight: 36, display: 'inline-flex', alignItems: 'center', justifyContent: 'center', border: 'none', background: 'transparent', color: 'var(--paper, #f6ecd2)', cursor: 'pointer', fontSize: 20, lineHeight: 1, padding: 0 }}
                        >
                          ×
                        </button>
                      </span>
                    ))}
                  </div>
                </div>
              )}
              <div style={{ position: 'relative' }}>
                <input
                  type="search"
                  value={storeQuery}
                  onChange={(e) => setStoreQuery(e.target.value)}
                  placeholder={storesLoaded ? `Search ${stores.length.toLocaleString('en-US')} brands — try 'J.Crew', 'Nordstrom', 'REI'…` : 'Loading brands…'}
                  disabled={!storesLoaded}
                  style={{ width: '100%', padding: '12px 14px', fontFamily: "'Special Elite', monospace", fontSize: 16, background: '#fff8e2', border: '2px solid var(--ink)', color: 'var(--ink)', outline: 'none', boxSizing: 'border-box' }}
                />
                {storeResults.length > 0 && (
                  <div style={{ position: 'absolute', top: '100%', left: 0, right: 0, background: '#fff8e2', border: '2px solid var(--ink)', borderTop: 'none', zIndex: 5, maxHeight: 280, overflowY: 'auto' }}>
                    {storeResults.map((s) => (
                      <button
                        key={s.id}
                        type="button"
                        onClick={() => addStore(s)}
                        style={{ display: 'block', width: '100%', textAlign: 'left', padding: '10px 14px', fontFamily: "'Special Elite', monospace", fontSize: 15, background: 'transparent', border: 'none', borderBottom: '1px solid rgba(24,22,18,0.2)', color: 'var(--ink)', cursor: 'pointer' }}
                      >
                        + {s.name}
                      </button>
                    ))}
                  </div>
                )}
              </div>
              {pickedStores.length === 0 && storesLoaded && (
                <p style={{ margin: '16px 0 0', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink-soft)', textAlign: 'center' }}>
                  Type a brand name. Add any you actually shop.
                </p>
              )}
            </div>
          )}

          {/* In-form links */}
          <p style={{ margin: '16px 0 0', fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--ink-soft)', textAlign: 'center' }}>
            <a href="/stores" style={{ color: 'var(--ink-soft)', textDecoration: 'underline', textDecorationStyle: 'dotted' }}>See all {storesLoaded ? stores.length.toLocaleString('en-US') : ''} brands →</a>
            {'  ·  '}
            <a href="/suggest" style={{ color: 'var(--ink-soft)', textDecoration: 'underline', textDecorationStyle: 'dotted' }}>Suggest a store →</a>
          </p>

          {/* Action panel */}
          {signedIn === null && (
            <p style={{ marginTop: 28, textAlign: 'center', color: 'var(--ink-soft)', fontFamily: "'Special Elite', monospace" }}>Loading…</p>
          )}

          {/* Signed-out: email + submit */}
          {signedIn === false && (
            <form onSubmit={handleAnonSubmit} style={{ marginTop: 28 }}>
              <p style={{ margin: '0 0 14px', fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--red-deep)', textAlign: 'center' }}>
                {totalPicks === 0 ? '— Pick at least one above —' : `— ${totalPicks} ${totalPicks === 1 ? 'pick' : 'picks'} · drop your email —`}
              </p>
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 10 }}>
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="you@inbox.com"
                  required
                  disabled={submitting || totalPicks === 0}
                  style={{ flex: '1 1 220px', padding: '14px 16px', fontFamily: "'Special Elite', monospace", fontSize: 16, background: '#fff8e2', border: '2px solid var(--ink)', color: 'var(--ink)', outline: 'none', boxSizing: 'border-box' }}
                />
                <button
                  type="submit"
                  disabled={submitting || !email || totalPicks === 0}
                  className="submit-btn"
                  style={{ flex: '0 0 auto' }}
                >
                  {submitting ? 'SENDING…' : 'SEND ME DEALS →'}
                </button>
              </div>
              {error && (<p style={{ margin: '12px 0 0', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)', textAlign: 'center' }}>{error}</p>)}
              <p style={{ margin: '14px 0 0', fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', textAlign: 'center' }}>
                No card · No password · Unsubscribe anytime
              </p>
            </form>
          )}

          {/* Signed-in: send + upgrade + danger zone */}
          {signedIn === true && (
            <>
              {/* ── Paid filters (price tier + min discount) ───────────
                  Side-by-side on desktop, stacks on phones via flex-
                  wrap. Free users see the same UI but inputs are
                  disabled and the lock badge links to /pricing —
                  visible upsell without a CTA button. */}
              <FilterPanel
                isPaid={isPaid}
                minDiscountPct={minDiscountPct}
                onChangeMinDiscount={saveMinDiscount}
                allowedTiers={allowedTiers}
                onToggleTier={toggleTier}
                includeFreeShipping={includeFreeShipping}
                includeBogo={includeBogo}
                includeGwp={includeGwp}
                onToggleInclude={updateInclude}
              />

              <div style={{ marginTop: 20 }}>
                {/* Sends-paused warning — anchored right above the
                    SEND button (rather than at the top of the form-
                    card) so the user sees the reason their send is
                    blocked at the exact moment they reach for the
                    button. */}
                {overLimit && (
                  <div style={{ marginBottom: 14, padding: '14px 18px', background: '#fde0de', border: '2px solid var(--red-deep)', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)' }}>
                    <strong>Sends paused.</strong> You have {totalPicks} picks but free tier allows {FREE_PICK_LIMIT}. Remove {totalPicks - FREE_PICK_LIMIT} above, or <a href="/pricing" style={{ color: 'var(--red-deep)', textDecoration: 'underline' }}>upgrade for unlimited</a>.
                  </div>
                )}
                <button
                  type="button"
                  onClick={sendDealsNow}
                  disabled={sendingDeals || totalPicks === 0 || overLimit}
                  className="submit-btn"
                  style={{ width: '100%' }}
                >
                  {sendingDeals ? 'SENDING…' : 'SEND ME DEALS NOW →'}
                </button>
                <p style={{ margin: '10px 0 0', fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', textAlign: 'center' }}>
                  {totalPicks === 0
                    ? 'Pick at least one above first'
                    : `Pulls fresh deals matching your ${totalPicks} active ${totalPicks === 1 ? 'pick' : 'picks'}`}
                </p>
                {statusMsg && (<p style={{ margin: '14px 0 0', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink-soft)', textAlign: 'center' }}>{statusMsg}</p>)}
                {error && (<p style={{ margin: '12px 0 0', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)', textAlign: 'center' }}>{error}</p>)}
              </div>

              {/* Upgrade nudge — free users only */}
              {!isPaid && (
                <div style={{ marginTop: 28, padding: '20px 22px', background: '#fff8e2', border: '2.5px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', display: 'flex', flexWrap: 'wrap', alignItems: 'center', gap: 16, justifyContent: 'space-between' }}>
                  <div style={{ flex: '1 1 220px' }}>
                    <div style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.3em', textTransform: 'uppercase', color: 'var(--red-deep)', marginBottom: 6 }}>
                      — Want more? —
                    </div>
                    <p style={{ margin: 0, fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 16, color: 'var(--ink)', lineHeight: 1.45 }}>
                      Upgrade for unlimited category and store picks.
                    </p>
                  </div>
                  <a
                    href="/pricing"
                    style={{ fontFamily: "'Alfa Slab One', serif", fontSize: 14, letterSpacing: '.08em', textTransform: 'uppercase', background: 'var(--red)', color: 'var(--paper, #f6ecd2)', padding: '14px 24px 12px', border: '2px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', textDecoration: 'none', flexShrink: 0, minHeight: 48, display: 'inline-flex', alignItems: 'center', justifyContent: 'center' }}
                  >
                    Upgrade →
                  </a>
                </div>
              )}

              {/* Danger zone — collapsed by default so the destructive
                  buttons aren't accidental-clickable. <details> is a
                  native HTML disclosure — no JS, no library, and the
                  chevron flips automatically via CSS [open] selector. */}
              <details className="danger-zone-collapsible" style={{ marginTop: 36 }}>
                <summary
                  style={{
                    listStyle: 'none',
                    cursor: 'pointer',
                    display: 'inline-flex',
                    alignItems: 'center',
                    gap: 8,
                    fontFamily: "'Stardos Stamp', monospace",
                    fontSize: 12,
                    letterSpacing: '.22em',
                    textTransform: 'uppercase',
                    color: 'var(--ink-soft)',
                    padding: '8px 0',
                    userSelect: 'none',
                  }}
                >
                  Danger Zone
                  <span
                    aria-hidden="true"
                    className="danger-zone-chevron"
                    style={{
                      display: 'inline-block',
                      transition: 'transform .15s ease',
                      fontSize: 14,
                      lineHeight: 1,
                    }}
                  >
                    ▾
                  </span>
                </summary>
                <div className="danger" style={{ marginTop: 12 }}>
                  <p>
                    <em>Need to step away?</em>{' '}
                    <strong>Log out</strong> ends this session — sign back in any time via magic link.{' '}
                    <strong>Unsubscribe</strong> keeps your account but clears your watchlist.{' '}
                    <strong>Delete</strong> wipes everything: watchlist, picks, send history, and your sign-in entirely.
                  </p>
                  <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
                    <button
                      type="button"
                      className="btn-ghost-tag"
                      onClick={handleLogout}
                    >
                      Log out
                    </button>
                    <button
                      type="button"
                      className="btn-ghost-tag"
                      style={{ background: '#fde0de', color: 'var(--red-deep)' }}
                      onClick={handleUnsubscribe}
                    >
                      Unsubscribe
                    </button>
                    <button
                      type="button"
                      className="btn-ghost-tag"
                      style={{ background: 'var(--red-deep)', color: '#fff8e2', border: '2px solid var(--red-deep)' }}
                      onClick={handleDeleteAccount}
                    >
                      Delete my account
                    </button>
                  </div>
                </div>
              </details>
            </>
          )}
        </div>
      </div>
    </section>
  )
}

// ─────────────────────────────────────────────────────────────────────
// FilterPanel — paid-only price-tier + min-discount controls.
//
// Lives above the SEND ME DEALS NOW button. Free users see the
// inputs (greyed out, non-interactive) plus a lock badge in the
// header that links to /pricing. The visible-but-disabled pattern is
// a stronger upsell than an "Upgrade for filters" CTA — users see
// exactly what they're getting.
// ─────────────────────────────────────────────────────────────────────

const PRICE_TIERS = ['$', '$$', '$$$', '$$$$'] as const
// 5 chips so the row fits side-by-side with the 4-chip price tier
// without wrapping. Dropped the 10% step — under 20% off is barely a
// meaningful threshold (most retailers have a standing 10% offer
// anyway), so trimming it surfaces tougher thresholds without losing
// real signal.
const DISCOUNT_STEPS: Array<{ label: string; value: number | null }> = [
  { label: 'Any', value: null },
  { label: '20%', value: 20 },
  { label: '30%', value: 30 },
  { label: '40%', value: 40 },
  { label: '50%+', value: 50 },
]

function FilterPanel({
  isPaid,
  minDiscountPct,
  onChangeMinDiscount,
  allowedTiers,
  onToggleTier,
  includeFreeShipping,
  includeBogo,
  includeGwp,
  onToggleInclude,
}: {
  isPaid: boolean
  minDiscountPct: number | null
  onChangeMinDiscount: (next: number | null) => void
  allowedTiers: Set<string>
  onToggleTier: (tier: string) => void
  includeFreeShipping: boolean
  includeBogo: boolean
  includeGwp: boolean
  onToggleInclude: (
    key: 'include_free_shipping' | 'include_bogo' | 'include_gwp',
    value: boolean,
  ) => void
}) {
  const disabled = !isPaid

  // Visual styling for an individual chip button. Tier chips use the
  // same style with a tweak for the dollar-sign font scaling.
  const chipStyle = (active: boolean): React.CSSProperties => ({
    fontFamily: "'Stardos Stamp', monospace",
    fontSize: 12,
    letterSpacing: '.14em',
    textTransform: 'uppercase',
    padding: '8px 14px',
    minHeight: 36,
    background: active ? 'var(--ink)' : '#fffbe6',
    color: active ? 'var(--paper, #f6ecd2)' : 'var(--ink)',
    border: '2px solid var(--ink)',
    boxShadow: active ? '2px 2px 0 var(--ink)' : '2px 2px 0 var(--ink)',
    cursor: disabled ? 'not-allowed' : 'pointer',
    opacity: disabled ? 0.55 : 1,
    transition: 'transform .12s',
  })

  return (
    <div
      style={{
        marginTop: 28,
        padding: '18px 20px',
        background: '#fff8e2',
        border: '2px solid var(--ink)',
        boxShadow: '3px 3px 0 var(--ink)',
        position: 'relative',
      }}
    >
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          gap: 12,
          marginBottom: 14,
          flexWrap: 'wrap',
        }}
      >
        <div
          style={{
            fontFamily: "'Stardos Stamp', monospace",
            fontSize: 11,
            letterSpacing: '.3em',
            textTransform: 'uppercase',
            color: 'var(--red-deep)',
          }}
        >
          — Personal Shopper Filters —
        </div>
        {disabled && (
          // Lock badge — anchor, not button, so right-click "Open in
          // new tab" works for users who want to keep the picker in
          // place while they check pricing.
          <a
            href="/pricing"
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: 6,
              padding: '4px 10px',
              background: 'var(--ink)',
              color: 'var(--yellow)',
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 10,
              letterSpacing: '.18em',
              textTransform: 'uppercase',
              textDecoration: 'none',
              border: '1.5px solid var(--ink)',
            }}
            title="Upgrade to use these filters"
            aria-label="Upgrade to Personal Shopper"
          >
            <span aria-hidden="true">🔒</span>
            Locked
          </a>
        )}
      </div>

      {/* Side-by-side layout. Flex with min-width:0 columns so labels
          can wrap on narrow screens, and gap:24 between groups. Stacks
          via flex-wrap when the container can't fit both at min width. */}
      <div
        style={{
          display: 'flex',
          gap: 24,
          flexWrap: 'wrap',
        }}
      >
        {/* Price tier */}
        <div style={{ flex: '1 1 220px', minWidth: 0 }}>
          <div
            style={{
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 10,
              letterSpacing: '.22em',
              textTransform: 'uppercase',
              color: 'var(--ink-soft)',
              marginBottom: 8,
            }}
          >
            Price tier
          </div>
          <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap' }}>
            {PRICE_TIERS.map((tier) => {
              const active = allowedTiers.has(tier)
              return (
                <button
                  key={tier}
                  type="button"
                  disabled={disabled}
                  onClick={() => onToggleTier(tier)}
                  style={chipStyle(active)}
                  aria-pressed={active}
                >
                  {tier}
                </button>
              )
            })}
          </div>
          <p
            style={{
              margin: '8px 0 0',
              fontFamily: "'IM Fell English', serif",
              fontStyle: 'italic',
              fontSize: 12,
              color: 'var(--ink-soft)',
            }}
          >
            {allowedTiers.size === 0 || allowedTiers.size === 4
              ? 'All tiers'
              : `Only ${Array.from(allowedTiers).join(' / ')} stores`}
          </p>
        </div>

        {/* Min discount */}
        <div style={{ flex: '1 1 220px', minWidth: 0 }}>
          <div
            style={{
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 10,
              letterSpacing: '.22em',
              textTransform: 'uppercase',
              color: 'var(--ink-soft)',
              marginBottom: 8,
            }}
          >
            Min discount
          </div>
          <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap' }}>
            {DISCOUNT_STEPS.map((step) => {
              const active = (minDiscountPct ?? null) === step.value
              return (
                <button
                  key={step.label}
                  type="button"
                  disabled={disabled}
                  onClick={() => onChangeMinDiscount(step.value)}
                  style={chipStyle(active)}
                  aria-pressed={active}
                >
                  {step.label}
                </button>
              )
            })}
          </div>
          <p
            style={{
              margin: '8px 0 0',
              fontFamily: "'IM Fell English', serif",
              fontStyle: 'italic',
              fontSize: 12,
              color: 'var(--ink-soft)',
            }}
          >
            {minDiscountPct == null
              ? 'No minimum'
              : `${minDiscountPct}%+ off · BOGO/free-shipping pass through`}
          </p>
        </div>
      </div>

      {/* ── Include section — opt-ins for the bottom-of-email compact
          brand lists. Default OFF for everyone (cleaner email); paid
          users can flip each on to surface free-shipping / BOGO / GWP
          deals as comma-separated brand lists under "Also Today" at
          the bottom of the email. */}
      <div
        style={{
          marginTop: 18,
          paddingTop: 14,
          borderTop: '1.5px dashed var(--ink-25, #cbc4ad)',
        }}
      >
        <div
          style={{
            fontFamily: "'Stardos Stamp', monospace",
            fontSize: 10,
            letterSpacing: '.22em',
            textTransform: 'uppercase',
            color: 'var(--ink-soft)',
            marginBottom: 8,
          }}
        >
          Also include in email
        </div>
        <div
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            gap: '8px 18px',
            fontFamily: "'Special Elite', monospace",
            fontSize: 14,
            color: 'var(--ink)',
          }}
        >
          {([
            { key: 'include_free_shipping' as const, label: 'Free shipping', value: includeFreeShipping },
            { key: 'include_bogo' as const, label: 'BOGO offers', value: includeBogo },
            { key: 'include_gwp' as const, label: 'Gift with purchase', value: includeGwp },
          ]).map(({ key, label, value }) => (
            <label
              key={key}
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
                cursor: disabled ? 'not-allowed' : 'pointer',
                opacity: disabled ? 0.55 : 1,
              }}
            >
              <input
                type="checkbox"
                checked={value}
                disabled={disabled}
                onChange={(e) => onToggleInclude(key, e.target.checked)}
              />
              {label}
            </label>
          ))}
        </div>
        <p
          style={{
            margin: '8px 0 0',
            fontFamily: "'IM Fell English', serif",
            fontStyle: 'italic',
            fontSize: 12,
            color: 'var(--ink-soft)',
          }}
        >
          Renders as a compact brand list at the bottom of the email,
          not full deal blocks. Only your matched brands appear.
        </p>
      </div>
    </div>
  )
}
