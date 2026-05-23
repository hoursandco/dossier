'use client'

// HomePicker — the homepage's picker + actions surface.
//
// Two modes wired into one component:
//
//   - Signed-out (cold visitor):
//       anonymous picks held in client state → email field at the
//       bottom → submit saves all picks + sends magic link in one
//       call. Magic-link click on any device restores the picks
//       (saved server-side at submit).
//
//   - Signed-in (returning subscriber):
//       loads existing watches + store picks on mount and shows them
//       pre-selected. Toggling a chip immediately calls the API
//       (POST/DELETE) — no batch save. Bottom panel: "Send Deals Now"
//       (calls /api/deals/refresh), plus the danger-zone Unsubscribe
//       and Delete-account actions that previously lived at the
//       bottom of /preferences.

import { useCallback, useEffect, useMemo, useState } from 'react'
import { trackPixel } from '@/lib/pixel'
import { trackEvent } from '@/lib/analytics'

type Category = { slug: string; label: string; group_name?: string | null }
type StoreLite = { id: string; name: string }
type PickerTab = 'categories' | 'stores'

const FREE_PICK_LIMIT = 3

const INK = '#181612'
const INK_SOFT = '#4a443a'
const PAPER = '#fff8e2'
const CREAM = '#f1e6c8'
const RED = '#d4322a'
const RED_DEEP = '#8f1a14'
const YELLOW = '#f4c623'

function normName(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export function HomePicker() {
  const [signedIn, setSignedIn] = useState<boolean | null>(null) // null = unknown / loading
  const [accountEmail, setAccountEmail] = useState<string | null>(null)
  const [categories, setCategories] = useState<Category[]>([])
  const [stores, setStores] = useState<StoreLite[]>([])
  const [storesLoaded, setStoresLoaded] = useState(false)
  const [tab, setTab] = useState<PickerTab>('categories')
  const [openGroups, setOpenGroups] = useState<Set<string>>(new Set())

  // Picks — UI state shared between modes.
  const [pickedCats, setPickedCats] = useState<Set<string>>(new Set())
  const [pickedStores, setPickedStores] = useState<StoreLite[]>([])

  // Signed-in-only: maps for resolving the row IDs needed by DELETE.
  const [watchIdBySlug, setWatchIdBySlug] = useState<Map<string, string>>(new Map())
  const [pickIdByStoreId, setPickIdByStoreId] = useState<Map<string, string>>(new Map())

  const [storeQuery, setStoreQuery] = useState('')
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [sendingDeals, setSendingDeals] = useState(false)
  const [statusMsg, setStatusMsg] = useState('')
  const [error, setError] = useState('')

  // Initial load: detect auth + pull data.
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

    // Auth probe. /api/account returns 200 + email when signed in,
    // 401 otherwise. We use that to fork between modes.
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
          // Load existing watches + store picks in parallel.
          const [watchesRes, picksRes] = await Promise.all([
            fetch('/api/watches').then((r) => (r.ok ? r.json() : { watches: [] })).catch(() => ({ watches: [] })),
            fetch('/api/store-picks').then((r) => (r.ok ? r.json() : { store_picks: [] })).catch(() => ({ store_picks: [] })),
          ])
          const watches = (watchesRes.watches ?? []) as Array<{ id: string; category_slug: string }>
          const picks = (picksRes.store_picks ?? []) as Array<{
            id: string
            store_id: string
            store_name?: string
          }>
          const catSet = new Set(watches.map((w) => w.category_slug))
          const wMap = new Map(watches.map((w) => [w.category_slug, w.id] as const))
          setPickedCats(catSet)
          setWatchIdBySlug(wMap)
          const stArr: StoreLite[] = picks.map((p) => ({ id: p.store_id, name: p.store_name || '' }))
          const pMap = new Map(picks.map((p) => [p.store_id, p.id] as const))
          setPickedStores(stArr)
          setPickIdByStoreId(pMap)
        } else {
          setSignedIn(false)
        }
      })
      .catch(() => setSignedIn(false))
  }, [])

  const grouped = useMemo(() => {
    const g = new Map<string, Category[]>()
    for (const c of categories) {
      const key = c.group_name || 'More'
      const arr = g.get(key) ?? []
      arr.push(c)
      g.set(key, arr)
    }
    return Array.from(g.entries())
  }, [categories])

  const pickedStoreIds = useMemo(
    () => new Set(pickedStores.map((s) => s.id)),
    [pickedStores]
  )

  const storeResults = useMemo(() => {
    const q = normName(storeQuery.trim())
    if (!q) return [] as StoreLite[]
    return stores
      .filter((s) => !pickedStoreIds.has(s.id) && normName(s.name).includes(q))
      .slice(0, 8)
  }, [storeQuery, stores, pickedStoreIds])

  const totalPicks = pickedCats.size + pickedStores.length
  const overLimit = totalPicks > FREE_PICK_LIMIT

  const toggleGroup = (name: string) => {
    setOpenGroups((prev) => {
      const next = new Set(prev)
      if (next.has(name)) next.delete(name)
      else next.add(name)
      return next
    })
  }

  // ── Toggle handlers — branch on signedIn ──────────────────────────
  const toggleCat = useCallback(
    async (slug: string) => {
      if (!signedIn) {
        // Anonymous — just state.
        setPickedCats((prev) => {
          const next = new Set(prev)
          if (next.has(slug)) next.delete(slug)
          else next.add(slug)
          return next
        })
        return
      }
      // Signed in — persist immediately. Optimistic UI; roll back on failure.
      if (pickedCats.has(slug)) {
        const watchId = watchIdBySlug.get(slug)
        if (!watchId) return
        setPickedCats((prev) => {
          const n = new Set(prev)
          n.delete(slug)
          return n
        })
        setWatchIdBySlug((prev) => {
          const n = new Map(prev)
          n.delete(slug)
          return n
        })
        try {
          await fetch(`/api/watches/${watchId}`, { method: 'DELETE' })
        } catch {
          // best-effort; user can retry
        }
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
            if (newId) {
              setWatchIdBySlug((prev) => new Map(prev).set(slug, newId))
            }
          } else {
            // roll back on failure
            setPickedCats((prev) => {
              const n = new Set(prev)
              n.delete(slug)
              return n
            })
          }
        } catch {
          setPickedCats((prev) => {
            const n = new Set(prev)
            n.delete(slug)
            return n
          })
        }
      }
    },
    [signedIn, pickedCats, watchIdBySlug]
  )

  const addStore = useCallback(
    async (s: StoreLite) => {
      if (!signedIn) {
        setPickedStores((prev) => [...prev, s])
        setStoreQuery('')
        return
      }
      setPickedStores((prev) => [...prev, s])
      setStoreQuery('')
      try {
        const res = await fetch('/api/store-picks', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ store_id: s.id }),
        })
        if (res.ok) {
          const d = await res.json()
          const pickId = d.store_pick?.id
          if (pickId) {
            setPickIdByStoreId((prev) => new Map(prev).set(s.id, pickId))
          }
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
      if (!signedIn) {
        setPickedStores((prev) => prev.filter((s) => s.id !== id))
        return
      }
      const pickId = pickIdByStoreId.get(id)
      setPickedStores((prev) => prev.filter((s) => s.id !== id))
      setPickIdByStoreId((prev) => {
        const n = new Map(prev)
        n.delete(id)
        return n
      })
      if (!pickId) return
      try {
        await fetch(`/api/store-picks/${pickId}`, { method: 'DELETE' })
      } catch {}
    },
    [signedIn, pickIdByStoreId]
  )

  // ── Anonymous submit: subscribe + magic link ─────────────────────
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
        body: JSON.stringify({
          email,
          redirectTo: `${window.location.origin}/auth/callback`,
        }),
      })
      if (mlRes.ok) {
        setSubmitted(true)
        trackPixel('Lead')
        trackEvent('sign_up', {
          method: 'magic_link',
          location: 'homepage_picker',
          category_picks: pickedCats.size,
          store_picks: pickedStores.length,
        })
      } else {
        const d = await mlRes.json().catch(() => ({}))
        setError(d.error || 'Could not send the sign-in link. Please try again.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  // ── Signed-in actions ────────────────────────────────────────────
  const sendDealsNow = async () => {
    if (totalPicks === 0) {
      setError('Pick at least one above first.')
      return
    }
    setSendingDeals(true)
    setError('')
    setStatusMsg('')
    try {
      const res = await fetch('/api/deals/refresh', { method: 'POST' })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        setError(d.error || 'Send failed. Please try again.')
        return
      }
      const n = d.total_deals ?? d.deals ?? 0
      setStatusMsg(
        n > 0
          ? `Sent — ${n} ${n === 1 ? 'deal' : 'deals'} on the way to your inbox.`
          : `Nothing fresh right now. We'll keep watching and email when something lands.`
      )
      trackEvent('deals_pull', { deals_count: n })
    } catch {
      setError('Send failed. Please try again.')
    } finally {
      setSendingDeals(false)
    }
  }

  const handleUnsubscribe = async () => {
    if (
      !confirm(
        'Unsubscribe? You will stop receiving deal emails but your account stays so you can resubscribe later.'
      )
    )
      return
    try {
      const res = await fetch('/api/unsubscribe', { method: 'POST' })
      if (res.ok) {
        setStatusMsg('Unsubscribed. You can re-enable emails from settings any time.')
      } else {
        setError('Could not unsubscribe. Please try again.')
      }
    } catch {
      setError('Could not unsubscribe. Please try again.')
    }
  }

  const handleDeleteAccount = async () => {
    if (!accountEmail) return
    if (
      !confirm(
        `Delete your account and ALL your data?\n\nThis wipes your watchlist, store picks, send history, and your sign-in. Irreversible.\n\nClick OK to confirm, then type your email on the next prompt.`
      )
    )
      return
    const typed = prompt(`Type "${accountEmail}" to confirm:`)
    if (typed !== accountEmail) {
      alert('Email did not match. Delete cancelled.')
      return
    }
    try {
      const res = await fetch('/api/account/delete', { method: 'DELETE' })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        setError(d.error || 'Delete failed.')
        return
      }
      window.location.href = '/'
    } catch {
      setError('Delete failed.')
    }
  }

  // ── Anonymous "check inbox" success state ────────────────────────
  if (submitted) {
    return (
      <section style={{ background: PAPER, border: `3px solid ${INK}`, maxWidth: 640, margin: '40px auto', padding: '48px 36px', textAlign: 'center' }}>
        <p style={{ margin: '0 0 14px', fontFamily: "'Stardos Stamp',monospace", fontSize: 12, letterSpacing: '.3em', textTransform: 'uppercase', color: RED_DEEP }}>
          — Check Inbox —
        </p>
        <h2 style={{ margin: '0 0 16px', fontFamily: "'Alfa Slab One',serif", fontWeight: 400, fontSize: 'clamp(28px,4vw,40px)', lineHeight: 1.05, color: INK }}>
          Your magic link is{' '}
          <em style={{ fontFamily: "'Alfa Slab One',serif", fontStyle: 'normal', textShadow: `2px 2px 0 ${RED}, 4px 4px 0 ${RED_DEEP}`, padding: '0 .04em' }}>
            on its way.
          </em>
        </h2>
        <p style={{ margin: '0 0 18px', fontFamily: "'IM Fell English',serif", fontStyle: 'italic', fontSize: 18, lineHeight: 1.5, color: INK_SOFT }}>
          We sent a sign-in link to <strong style={{ fontFamily: "'Special Elite',monospace", fontStyle: 'normal' }}>{email}</strong>. Click it to finish — your {totalPicks} {totalPicks === 1 ? 'pick' : 'picks'} {totalPicks === 1 ? 'is' : 'are'} already saved.
        </p>
        <p style={{ margin: 0, fontFamily: "'Special Elite',monospace", fontSize: 13, color: INK_SOFT }}>
          The link expires in 24 hours · No password, ever
        </p>
      </section>
    )
  }

  // ── Tab buttons (shared) ─────────────────────────────────────────
  const tabBtn = (id: PickerTab, label: string, count: number) => {
    const active = tab === id
    return (
      <button
        type="button"
        onClick={() => setTab(id)}
        style={{
          flex: 1,
          padding: '14px 18px 12px',
          fontFamily: "'Alfa Slab One',serif",
          fontSize: 16,
          letterSpacing: '.04em',
          background: active ? RED : PAPER,
          color: active ? PAPER : INK,
          border: `2px solid ${INK}`,
          cursor: 'pointer',
          boxShadow: active ? `2px 2px 0 ${INK}` : 'none',
        }}
      >
        {label}
        {count > 0 && (
          <span
            style={{
              marginLeft: 8,
              fontFamily: "'Stardos Stamp',monospace",
              fontSize: 11,
              letterSpacing: '.12em',
              padding: '2px 7px',
              background: active ? PAPER : RED,
              color: active ? INK : PAPER,
              border: `1.5px solid ${INK}`,
            }}
          >
            {count}
          </span>
        )}
      </button>
    )
  }

  return (
    <section style={{ background: CREAM, padding: 'clamp(28px,4vw,56px) clamp(16px,3vw,32px)', borderTop: `3px solid ${INK}` }}>
      <div style={{ maxWidth: 760, margin: '0 auto' }}>
        <p style={{ margin: '0 0 8px', fontFamily: "'Stardos Stamp',monospace", fontSize: 12, letterSpacing: '.3em', textTransform: 'uppercase', color: RED_DEEP, textAlign: 'center' }}>
          {signedIn ? '— Your Watchlist —' : '— Choose Your Picks —'}
        </p>
        <p style={{ margin: '0 auto 24px', fontFamily: "'IM Fell English',serif", fontStyle: 'italic', fontSize: 'clamp(17px,2vw,20px)', lineHeight: 1.45, color: INK, textAlign: 'center', maxWidth: 580 }}>
          {signedIn
            ? <>Welcome back{accountEmail ? <>, <strong style={{ fontFamily: "'Special Elite',monospace", fontStyle: 'normal' }}>{accountEmail}</strong></> : ''}. Toggle picks below — changes save instantly.</>
            : <>Tell us what you shop for — by category, by brand, or both. Drop your email and we&rsquo;ll send the live sales.</>
          }
        </p>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: 10 }}>
          {tabBtn('categories', 'Categories', pickedCats.size)}
          {tabBtn('stores', 'Stores', pickedStores.length)}
        </div>

        {/* Categories tab */}
        {tab === 'categories' && (
          <div style={{ background: PAPER, border: `2px solid ${INK}`, borderTop: 'none', padding: 'clamp(14px,2vw,20px)' }}>
            {grouped.length === 0 && (
              <p style={{ textAlign: 'center', color: INK_SOFT, fontFamily: "'Special Elite',monospace", margin: 0, padding: '20px 0' }}>
                Loading categories…
              </p>
            )}
            {grouped.map(([groupName, cats]) => {
              const isOpen = openGroups.has(groupName)
              const pickedInGroup = cats.filter((c) => pickedCats.has(c.slug)).length
              return (
                <div key={groupName} style={{ borderBottom: `1.5px dashed ${INK}55`, paddingBottom: 6, marginBottom: 6 }}>
                  <button
                    type="button"
                    onClick={() => toggleGroup(groupName)}
                    style={{ width: '100%', textAlign: 'left', padding: '10px 4px', background: 'transparent', border: 'none', cursor: 'pointer', display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: "'Alfa Slab One',serif", fontSize: 16, letterSpacing: '.04em', color: INK }}
                  >
                    <span>
                      {groupName}
                      {pickedInGroup > 0 && (
                        <span style={{ marginLeft: 10, fontFamily: "'Stardos Stamp',monospace", fontSize: 11, letterSpacing: '.14em', color: RED_DEEP }}>
                          {pickedInGroup} PICKED
                        </span>
                      )}
                    </span>
                    <span style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 18, color: INK_SOFT }}>
                      {isOpen ? '▾' : '▸'}
                    </span>
                  </button>
                  {isOpen && (
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, padding: '4px 4px 12px' }}>
                      {cats.map((c) => {
                        const on = pickedCats.has(c.slug)
                        return (
                          <button
                            key={c.slug}
                            type="button"
                            onClick={() => toggleCat(c.slug)}
                            style={{ fontFamily: "'Alfa Slab One',serif", fontWeight: 400, fontSize: 13, letterSpacing: '.04em', padding: '7px 12px 6px', border: `2px solid ${INK}`, background: on ? RED : CREAM, color: on ? PAPER : INK, cursor: 'pointer', boxShadow: on ? `2px 2px 0 ${INK}` : 'none' }}
                          >
                            {c.label}
                          </button>
                        )
                      })}
                    </div>
                  )}
                </div>
              )
            })}
          </div>
        )}

        {/* Stores tab */}
        {tab === 'stores' && (
          <div style={{ background: PAPER, border: `2px solid ${INK}`, borderTop: 'none', padding: 'clamp(14px,2vw,20px)' }}>
            <div style={{ position: 'relative' }}>
              <input
                type="text"
                value={storeQuery}
                onChange={(e) => setStoreQuery(e.target.value)}
                placeholder={storesLoaded ? 'Search 1,700+ brands…' : 'Loading brands…'}
                disabled={!storesLoaded}
                style={{ width: '100%', padding: '12px 14px', fontFamily: "'Special Elite',monospace", fontSize: 16, background: CREAM, border: `2px solid ${INK}`, color: INK, outline: 'none', boxSizing: 'border-box' }}
              />
              {storeResults.length > 0 && (
                <div style={{ position: 'absolute', top: '100%', left: 0, right: 0, background: CREAM, border: `2px solid ${INK}`, borderTop: 'none', zIndex: 5, maxHeight: 280, overflowY: 'auto' }}>
                  {storeResults.map((s) => (
                    <button
                      key={s.id}
                      type="button"
                      onClick={() => addStore(s)}
                      style={{ display: 'block', width: '100%', textAlign: 'left', padding: '10px 14px', fontFamily: "'Special Elite',monospace", fontSize: 15, background: 'transparent', border: 'none', borderBottom: `1px solid ${INK}33`, color: INK, cursor: 'pointer' }}
                    >
                      + {s.name}
                    </button>
                  ))}
                </div>
              )}
            </div>
            {pickedStores.length === 0 && (
              <p style={{ margin: '16px 0 0', fontFamily: "'IM Fell English',serif", fontStyle: 'italic', fontSize: 15, color: INK_SOFT, textAlign: 'center' }}>
                Type a brand name. Add any you actually shop.
              </p>
            )}
            {pickedStores.length > 0 && (
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, marginTop: 16 }}>
                {pickedStores.map((s) => (
                  <span key={s.id} style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontFamily: "'Alfa Slab One',serif", fontSize: 13, letterSpacing: '.04em', padding: '8px 8px 7px 14px', background: RED, color: PAPER, border: `2px solid ${INK}`, boxShadow: `2px 2px 0 ${INK}` }}>
                    {s.name}
                    <button
                      type="button"
                      onClick={() => removeStore(s.id)}
                      aria-label={`Remove ${s.name}`}
                      style={{ background: 'transparent', border: 'none', color: PAPER, fontFamily: "'Alfa Slab One',serif", fontSize: 16, lineHeight: 1, cursor: 'pointer', padding: '0 4px' }}
                    >
                      ×
                    </button>
                  </span>
                ))}
              </div>
            )}
          </div>
        )}

        {/* In-form links */}
        <p style={{ margin: '16px 0 0', fontFamily: "'Special Elite',monospace", fontSize: 13, color: INK_SOFT, textAlign: 'center' }}>
          <a href="/stores" style={{ color: INK_SOFT, textDecoration: 'underline', textDecorationStyle: 'dotted' }}>
            See all 1,700+ brands →
          </a>
          {'  ·  '}
          <a href="/suggest" style={{ color: INK_SOFT, textDecoration: 'underline', textDecorationStyle: 'dotted' }}>
            Suggest a store →
          </a>
        </p>

        {/* Over-limit nudge — only meaningful on a fresh signup */}
        {overLimit && !signedIn && (
          <div style={{ marginTop: 22, padding: '14px 18px', background: YELLOW, border: `2px solid ${INK}`, fontFamily: "'Special Elite',monospace", fontSize: 15, color: INK, textAlign: 'center' }}>
            Free tier covers {FREE_PICK_LIMIT} picks — you&rsquo;ve chosen {totalPicks}.{' '}
            <a href="/pricing" style={{ color: RED_DEEP, fontWeight: 'bold' }}>Upgrade for unlimited →</a>
          </div>
        )}

        {/* ── Action panel ───────────────────────────────────────── */}
        {signedIn === null && (
          <p style={{ marginTop: 28, textAlign: 'center', color: INK_SOFT, fontFamily: "'Special Elite',monospace" }}>
            Loading…
          </p>
        )}

        {/* Signed-out: email + submit */}
        {signedIn === false && (
          <form
            onSubmit={handleAnonSubmit}
            style={{ marginTop: 28, background: PAPER, border: `3px solid ${INK}`, padding: 'clamp(20px,3vw,28px)', boxShadow: `6px 6px 0 ${INK}` }}
          >
            <p style={{ margin: '0 0 14px', fontFamily: "'Stardos Stamp',monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: RED_DEEP, textAlign: 'center' }}>
              {totalPicks === 0
                ? '— Pick at least one above —'
                : `— ${totalPicks} ${totalPicks === 1 ? 'pick' : 'picks'} · drop your email —`}
            </p>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 10 }}>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="you@inbox.com"
                required
                disabled={submitting || totalPicks === 0}
                style={{ flex: '1 1 220px', padding: '14px 16px', fontFamily: "'Special Elite',monospace", fontSize: 16, background: CREAM, border: `2px solid ${INK}`, color: INK, outline: 'none', boxSizing: 'border-box' }}
              />
              <button
                type="submit"
                disabled={submitting || !email || totalPicks === 0}
                style={{ flex: '0 0 auto', padding: '14px 24px', fontFamily: "'Alfa Slab One',serif", fontSize: 15, letterSpacing: '.06em', background: submitting || !email || totalPicks === 0 ? '#999' : RED, color: PAPER, border: `2px solid ${INK}`, boxShadow: `4px 4px 0 ${INK}`, cursor: submitting || !email || totalPicks === 0 ? 'not-allowed' : 'pointer' }}
              >
                {submitting ? 'SENDING…' : 'SEND ME DEALS →'}
              </button>
            </div>
            {error && (
              <p style={{ margin: '12px 0 0', fontFamily: "'Special Elite',monospace", fontSize: 14, color: RED_DEEP, textAlign: 'center' }}>{error}</p>
            )}
            <p style={{ margin: '14px 0 0', fontFamily: "'Stardos Stamp',monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: INK_SOFT, textAlign: 'center' }}>
              No card · No password · Unsubscribe anytime
            </p>
          </form>
        )}

        {/* Signed-in: send-deals + danger zone */}
        {signedIn === true && (
          <>
            <div style={{ marginTop: 28, background: PAPER, border: `3px solid ${INK}`, padding: 'clamp(20px,3vw,28px)', boxShadow: `6px 6px 0 ${INK}`, textAlign: 'center' }}>
              <p style={{ margin: '0 0 14px', fontFamily: "'Stardos Stamp',monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: RED_DEEP }}>
                {totalPicks === 0
                  ? '— Pick at least one above —'
                  : `— ${totalPicks} active ${totalPicks === 1 ? 'pick' : 'picks'} —`}
              </p>
              <button
                type="button"
                onClick={sendDealsNow}
                disabled={sendingDeals || totalPicks === 0}
                style={{ padding: '16px 28px', fontFamily: "'Alfa Slab One',serif", fontSize: 16, letterSpacing: '.06em', background: sendingDeals || totalPicks === 0 ? '#999' : RED, color: PAPER, border: `2px solid ${INK}`, boxShadow: `4px 4px 0 ${INK}`, cursor: sendingDeals || totalPicks === 0 ? 'not-allowed' : 'pointer' }}
              >
                {sendingDeals ? 'SENDING…' : 'SEND ME DEALS NOW →'}
              </button>
              {statusMsg && (
                <p style={{ margin: '14px 0 0', fontFamily: "'IM Fell English',serif", fontStyle: 'italic', fontSize: 15, color: INK_SOFT }}>{statusMsg}</p>
              )}
              {error && (
                <p style={{ margin: '12px 0 0', fontFamily: "'Special Elite',monospace", fontSize: 14, color: RED_DEEP }}>{error}</p>
              )}
            </div>

            {/* Danger zone */}
            <div style={{ marginTop: 36, padding: '20px 18px', border: `2px dashed ${INK}55`, background: 'transparent', textAlign: 'center' }}>
              <p style={{ margin: '0 0 12px', fontFamily: "'Stardos Stamp',monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: INK_SOFT }}>
                — Account —
              </p>
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 10, justifyContent: 'center' }}>
                <button
                  type="button"
                  onClick={handleUnsubscribe}
                  style={{ padding: '10px 18px', fontFamily: "'Special Elite',monospace", fontSize: 14, background: 'transparent', color: INK_SOFT, border: `1.5px solid ${INK_SOFT}`, cursor: 'pointer' }}
                >
                  Unsubscribe
                </button>
                <button
                  type="button"
                  onClick={handleDeleteAccount}
                  style={{ padding: '10px 18px', fontFamily: "'Special Elite',monospace", fontSize: 14, background: 'transparent', color: RED_DEEP, border: `1.5px solid ${RED_DEEP}`, cursor: 'pointer' }}
                >
                  Delete account
                </button>
              </div>
            </div>
          </>
        )}
      </div>
    </section>
  )
}
