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
    fetch('/api/stores')
      .then((r) => (r.ok ? r.json() : { stores: [] }))
      .then((d) => {
        const arr = (d.stores ?? []) as Array<{ id: string; name: string }>
        setStores(arr.map((s) => ({ id: s.id, name: s.name })))
        setStoresLoaded(true)
      })
      .catch(() => setStoresLoaded(true))

    fetch('/api/account')
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

  const toggleGroup = (name: string) => {
    setOpenGroups((prev) => {
      const n = new Set(prev)
      if (n.has(name)) n.delete(name)
      else n.add(name)
      return n
    })
  }

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
        <div className="form-card flush">
          {/* Header — matches /preferences */}
          <p className="form-step">— Your Watchlist —</p>
          <h2 className="form-h">
            {totalPicks === 0
              ? <>Pick what you&rsquo;re <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>shopping for.</em></>
              : <>What we&rsquo;re hunting for, on your behalf.</>}
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

          {overLimit && (
            <div style={{ marginBottom: 16, padding: '14px 18px', background: '#fde0de', border: '2px solid var(--red-deep)', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)' }}>
              <strong>Sends paused.</strong> You have {totalPicks} picks but free tier allows {FREE_PICK_LIMIT}. Remove {totalPicks - FREE_PICK_LIMIT} below, or <a href="/pricing" style={{ color: 'var(--red-deep)', textDecoration: 'underline' }}>upgrade for unlimited</a>.
            </div>
          )}

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
                    fontSize: 13,
                    letterSpacing: '.16em',
                    textTransform: 'uppercase',
                    padding: '14px 20px 12px',
                    minHeight: 44,
                    flex: '1 1 auto',
                    background: isActive ? 'var(--ink)' : 'transparent',
                    color: isActive ? 'var(--bone, #fff5d4)' : 'var(--ink-55, #6b6353)',
                    border: '2px solid var(--ink)',
                    borderBottom: 'none',
                    cursor: 'pointer',
                    marginBottom: '-2px',
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
                  placeholder={storesLoaded ? 'Search 1,700+ brands — try \'J.Crew\', \'Nordstrom\', \'REI\'…' : 'Loading brands…'}
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
            <a href="/stores" style={{ color: 'var(--ink-soft)', textDecoration: 'underline', textDecorationStyle: 'dotted' }}>See all 1,700+ brands →</a>
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
              <div style={{ marginTop: 28 }}>
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
                      Upgrade to <strong style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal' }}>Personal Shopper</strong> for unlimited category and store picks.
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

              {/* Danger zone */}
              <div className="danger">
                <p>
                  <em>Need to step away?</em>{' '}
                  <strong>Unsubscribe</strong> keeps your account but clears your watchlist — come back any time.{' '}
                  <strong>Delete</strong> wipes everything: watchlist, picks, send history, and your sign-in entirely.
                </p>
                <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
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
            </>
          )}
        </div>
      </div>
    </section>
  )
}
