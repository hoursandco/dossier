'use client'

// HomePicker — the anonymous category + store picker on the homepage.
//
// UX mirrors the /preferences picker: two tabs (Categories / Stores),
// category groups rendered as collapsible drawers (click the bar to
// expand), store search with typeahead in the Stores tab. New visitors
// pick anonymously (picks held in client state), drop their email,
// and the submit creates the subscriber + saves all picks + sends a
// magic link in one call. Magic-link click on any device returns
// them to a homepage with everything already saved.

import { useEffect, useMemo, useState } from 'react'
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
  const [categories, setCategories] = useState<Category[]>([])
  const [stores, setStores] = useState<StoreLite[]>([])
  const [storesLoaded, setStoresLoaded] = useState(false)
  const [tab, setTab] = useState<PickerTab>('categories')
  const [openGroups, setOpenGroups] = useState<Set<string>>(new Set())
  const [pickedCats, setPickedCats] = useState<Set<string>>(new Set())
  const [pickedStores, setPickedStores] = useState<StoreLite[]>([])
  const [storeQuery, setStoreQuery] = useState('')
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)
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
  }, [])

  // Group categories by group_name for the drawer UI.
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

  const toggleCat = (slug: string) => {
    setPickedCats((prev) => {
      const next = new Set(prev)
      if (next.has(slug)) next.delete(slug)
      else next.add(slug)
      return next
    })
  }
  const toggleGroup = (name: string) => {
    setOpenGroups((prev) => {
      const next = new Set(prev)
      if (next.has(name)) next.delete(name)
      else next.add(name)
      return next
    })
  }
  const addStore = (s: StoreLite) => {
    setPickedStores((prev) => [...prev, s])
    setStoreQuery('')
  }
  const removeStore = (id: string) => {
    setPickedStores((prev) => prev.filter((s) => s.id !== id))
  }

  const handleSubmit = async (e: React.FormEvent) => {
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

  if (submitted) {
    return (
      <section
        style={{
          background: PAPER,
          border: `3px solid ${INK}`,
          maxWidth: 640,
          margin: '40px auto',
          padding: '48px 36px',
          textAlign: 'center',
        }}
      >
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

  // ── Tab buttons ────────────────────────────────────────────────────
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
          borderBottom: active ? `2px solid ${INK}` : `2px solid ${INK}`,
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
    <section
      style={{
        background: CREAM,
        padding: 'clamp(28px,4vw,56px) clamp(16px,3vw,32px)',
        borderTop: `3px solid ${INK}`,
      }}
    >
      <div style={{ maxWidth: 760, margin: '0 auto' }}>
        {/* Intro — load-bearing microcopy that explains the page */}
        <p style={{ margin: '0 0 8px', fontFamily: "'Stardos Stamp',monospace", fontSize: 12, letterSpacing: '.3em', textTransform: 'uppercase', color: RED_DEEP, textAlign: 'center' }}>
          — Choose Your Picks —
        </p>
        <p style={{ margin: '0 auto 24px', fontFamily: "'IM Fell English',serif", fontStyle: 'italic', fontSize: 'clamp(17px,2vw,20px)', lineHeight: 1.45, color: INK, textAlign: 'center', maxWidth: 580 }}>
          Tell us what you shop for — by category, by brand, or both. Drop your email and we&rsquo;ll send the live sales.
        </p>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: 10 }}>
          {tabBtn('categories', 'Categories', pickedCats.size)}
          {tabBtn('stores', 'Stores', pickedStores.length)}
        </div>

        {/* Categories tab — collapsible drawers per group */}
        {tab === 'categories' && (
          <div
            style={{
              background: PAPER,
              border: `2px solid ${INK}`,
              borderTop: 'none',
              padding: 'clamp(14px,2vw,20px)',
            }}
          >
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
                    style={{
                      width: '100%',
                      textAlign: 'left',
                      padding: '10px 4px',
                      background: 'transparent',
                      border: 'none',
                      cursor: 'pointer',
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                      fontFamily: "'Alfa Slab One',serif",
                      fontSize: 16,
                      letterSpacing: '.04em',
                      color: INK,
                    }}
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
                            style={{
                              fontFamily: "'Alfa Slab One',serif",
                              fontWeight: 400,
                              fontSize: 13,
                              letterSpacing: '.04em',
                              padding: '7px 12px 6px',
                              border: `2px solid ${INK}`,
                              background: on ? RED : CREAM,
                              color: on ? PAPER : INK,
                              cursor: 'pointer',
                              boxShadow: on ? `2px 2px 0 ${INK}` : 'none',
                            }}
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

        {/* Stores tab — search + typeahead + picked-store chips */}
        {tab === 'stores' && (
          <div
            style={{
              background: PAPER,
              border: `2px solid ${INK}`,
              borderTop: 'none',
              padding: 'clamp(14px,2vw,20px)',
            }}
          >
            <div style={{ position: 'relative' }}>
              <input
                type="text"
                value={storeQuery}
                onChange={(e) => setStoreQuery(e.target.value)}
                placeholder={storesLoaded ? 'Search 1,700+ brands…' : 'Loading brands…'}
                disabled={!storesLoaded}
                style={{
                  width: '100%',
                  padding: '12px 14px',
                  fontFamily: "'Special Elite',monospace",
                  fontSize: 16,
                  background: CREAM,
                  border: `2px solid ${INK}`,
                  color: INK,
                  outline: 'none',
                  boxSizing: 'border-box',
                }}
              />
              {storeResults.length > 0 && (
                <div
                  style={{
                    position: 'absolute',
                    top: '100%',
                    left: 0,
                    right: 0,
                    background: CREAM,
                    border: `2px solid ${INK}`,
                    borderTop: 'none',
                    zIndex: 5,
                    maxHeight: 280,
                    overflowY: 'auto',
                  }}
                >
                  {storeResults.map((s) => (
                    <button
                      key={s.id}
                      type="button"
                      onClick={() => addStore(s)}
                      style={{
                        display: 'block',
                        width: '100%',
                        textAlign: 'left',
                        padding: '10px 14px',
                        fontFamily: "'Special Elite',monospace",
                        fontSize: 15,
                        background: 'transparent',
                        border: 'none',
                        borderBottom: `1px solid ${INK}33`,
                        color: INK,
                        cursor: 'pointer',
                      }}
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
                  <span
                    key={s.id}
                    style={{
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 8,
                      fontFamily: "'Alfa Slab One',serif",
                      fontSize: 13,
                      letterSpacing: '.04em',
                      padding: '8px 8px 7px 14px',
                      background: RED,
                      color: PAPER,
                      border: `2px solid ${INK}`,
                      boxShadow: `2px 2px 0 ${INK}`,
                    }}
                  >
                    {s.name}
                    <button
                      type="button"
                      onClick={() => removeStore(s.id)}
                      aria-label={`Remove ${s.name}`}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        color: PAPER,
                        fontFamily: "'Alfa Slab One',serif",
                        fontSize: 16,
                        lineHeight: 1,
                        cursor: 'pointer',
                        padding: '0 4px',
                      }}
                    >
                      ×
                    </button>
                  </span>
                ))}
              </div>
            )}
          </div>
        )}

        {/* Footer-of-form links */}
        <p style={{ margin: '16px 0 0', fontFamily: "'Special Elite',monospace", fontSize: 13, color: INK_SOFT, textAlign: 'center' }}>
          <a href="/stores" style={{ color: INK_SOFT, textDecoration: 'underline', textDecorationStyle: 'dotted' }}>
            See all 1,700+ brands →
          </a>
          {'  ·  '}
          <a href="/suggest" style={{ color: INK_SOFT, textDecoration: 'underline', textDecorationStyle: 'dotted' }}>
            Suggest a store →
          </a>
        </p>

        {/* Over-limit nudge */}
        {overLimit && (
          <div
            style={{
              marginTop: 22,
              padding: '14px 18px',
              background: YELLOW,
              border: `2px solid ${INK}`,
              fontFamily: "'Special Elite',monospace",
              fontSize: 15,
              color: INK,
              textAlign: 'center',
            }}
          >
            Free tier covers {FREE_PICK_LIMIT} picks — you&rsquo;ve chosen {totalPicks}.{' '}
            <a href="/pricing" style={{ color: RED_DEEP, fontWeight: 'bold' }}>
              Upgrade for unlimited →
            </a>
          </div>
        )}

        {/* Email + submit */}
        <form
          onSubmit={handleSubmit}
          style={{
            marginTop: 28,
            background: PAPER,
            border: `3px solid ${INK}`,
            padding: 'clamp(20px,3vw,28px)',
            boxShadow: `6px 6px 0 ${INK}`,
          }}
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
              style={{
                flex: '1 1 220px',
                padding: '14px 16px',
                fontFamily: "'Special Elite',monospace",
                fontSize: 16,
                background: CREAM,
                border: `2px solid ${INK}`,
                color: INK,
                outline: 'none',
                boxSizing: 'border-box',
              }}
            />
            <button
              type="submit"
              disabled={submitting || !email || totalPicks === 0}
              style={{
                flex: '0 0 auto',
                padding: '14px 24px',
                fontFamily: "'Alfa Slab One',serif",
                fontSize: 15,
                letterSpacing: '.06em',
                background: submitting || !email || totalPicks === 0 ? '#999' : RED,
                color: PAPER,
                border: `2px solid ${INK}`,
                boxShadow: `4px 4px 0 ${INK}`,
                cursor: submitting || !email || totalPicks === 0 ? 'not-allowed' : 'pointer',
              }}
            >
              {submitting ? 'SENDING…' : 'SEND ME DEALS →'}
            </button>
          </div>
          {error && (
            <p style={{ margin: '12px 0 0', fontFamily: "'Special Elite',monospace", fontSize: 14, color: RED_DEEP, textAlign: 'center' }}>
              {error}
            </p>
          )}
          <p style={{ margin: '14px 0 0', fontFamily: "'Stardos Stamp',monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: INK_SOFT, textAlign: 'center' }}>
            No card · No password · Unsubscribe anytime
          </p>
        </form>
      </div>
    </section>
  )
}
