'use client'

// HomePicker — the homepage's picker + actions surface.
//
// Two modes:
//   - Signed-OUT: keyword search → on-page results → email field to send
//     matching deals to yourself.
//   - Signed-IN:  keyword search + on-page results, plus store watchlist
//     and SEND ME DEALS NOW for brand-based sends.

import { useCallback, useEffect, useMemo, useRef, useState } from 'react'
import { trackPixel } from '@/lib/pixel'
import { trackEvent } from '@/lib/analytics'

type StoreLite = { id: string; name: string }
type KeywordSuggestion = { keyword: string; deal_count: number; type: 'keyword' | 'brand' }
type DealResult = {
  id: string
  retailer: string
  description: string
  percent_off: number | null
  deal_type: string
  promo_code: string | null
  expiration_date: string | null
  original_link: string
  affiliate_link: string | null
  source_email_link: string | null
  week_of: string
}

const FREE_PICK_LIMIT = 3

function normName(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]/g, '')
}

function useDebounce<T>(value: T, delay: number): T {
  const [debounced, setDebounced] = useState(value)
  useEffect(() => {
    const t = setTimeout(() => setDebounced(value), delay)
    return () => clearTimeout(t)
  }, [value, delay])
  return debounced
}

export function HomePicker() {
  const [signedIn, setSignedIn] = useState<boolean | null>(null)
  const [accountEmail, setAccountEmail] = useState<string | null>(null)
  const [isPaid, setIsPaid] = useState(false)
  const [isComped, setIsComped] = useState(false)
  const [hasBillingAccount, setHasBillingAccount] = useState(false)
  const [cancelsAt, setCancelsAt] = useState<string | null>(null)
  const [stores, setStores] = useState<StoreLite[]>([])

  const [pickedStores, setPickedStores] = useState<StoreLite[]>([])
  const [pickIdByStoreId, setPickIdByStoreId] = useState<Map<string, string>>(new Map())

  // Paid-tier filters
  const [minDiscountPct, setMinDiscountPct] = useState<number | null>(null)
  const [allowedTiers, setAllowedTiers] = useState<Set<string>>(new Set())
  const [includeFreeShipping, setIncludeFreeShipping] = useState(false)
  const [includeBogo, setIncludeBogo] = useState(false)
  const [includeGwp, setIncludeGwp] = useState(false)

  // Keyword search state
  const [keywordInput, setKeywordInput] = useState('')
  const [suggestions, setSuggestions] = useState<KeywordSuggestion[]>([])
  const [showSuggestions, setShowSuggestions] = useState(false)
  const [searchResults, setSearchResults] = useState<DealResult[] | null>(null)
  const [activeKeywords, setActiveKeywords] = useState<string[]>([])
  const [searching, setSearching] = useState(false)
  const searchInputRef = useRef<HTMLInputElement>(null)
  const suggestionsRef = useRef<HTMLDivElement>(null)

  // Brand deal search state
  const [activeBrand, setActiveBrand] = useState<string | null>(null)
  const [brandResults, setBrandResults] = useState<DealResult[] | null>(null)
  const [brandSearching, setBrandSearching] = useState(false)

  // Anon submit (email deals from search results)
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)

  // Signed-in send
  const [sendingDeals, setSendingDeals] = useState(false)
  const [statusMsg, setStatusMsg] = useState('')
  const [error, setError] = useState('')

  const debouncedKeyword = useDebounce(keywordInput, 300)

  useEffect(() => {
    fetch('/api/stores?confirmed=true')
      .then((r) => (r.ok ? r.json() : { stores: [] }))
      .then((d) => {
        const arr = (d.stores ?? []) as Array<{ id: string; name: string }>
        setStores(arr.map((s) => ({ id: s.id, name: s.name })))
      })
      .catch(() => {})

    fetch('/api/account', { cache: 'no-store' })
      .then(async (r) => {
        if (!r.ok) { setSignedIn(false); return }
        const d = await r.json()
        if (d?.email) {
          setSignedIn(true)
          setAccountEmail(d.email)
          setIsPaid(d.tier === 'paid')
          setIsComped(d.subscription_status === 'comped')
          setHasBillingAccount(!!d.has_billing_account)
          setCancelsAt(d.cancels_at ?? null)
          if (typeof d.min_discount_pct === 'number') setMinDiscountPct(d.min_discount_pct)
          if (Array.isArray(d.allowed_price_tiers) && d.allowed_price_tiers.length > 0) {
            setAllowedTiers(new Set(d.allowed_price_tiers))
          }
          setIncludeFreeShipping(!!d.include_free_shipping)
          setIncludeBogo(!!d.include_bogo)
          setIncludeGwp(!!d.include_gwp)
          const picksRes = await fetch('/api/store-picks')
            .then((r) => (r.ok ? r.json() : { store_picks: [] }))
            .catch(() => ({ store_picks: [] }))
          const picks = (picksRes.store_picks ?? []) as Array<{ id: string; store_id: string; store_name?: string }>
          setPickedStores(picks.map((p) => ({ id: p.store_id, name: p.store_name || '' })))
          setPickIdByStoreId(new Map(picks.map((p) => [p.store_id, p.id] as const)))
        } else {
          setSignedIn(false)
        }
      })
      .catch(() => setSignedIn(false))
  }, [])

  // Fetch autocomplete suggestions when debounced input changes
  useEffect(() => {
    if (!debouncedKeyword.trim()) {
      setSuggestions([])
      setShowSuggestions(false)
      return
    }
    fetch(`/api/keywords/suggest?q=${encodeURIComponent(debouncedKeyword.trim())}`)
      .then((r) => (r.ok ? r.json() : { keywords: [] }))
      .then((d) => {
        setSuggestions(d.keywords ?? [])
        setShowSuggestions(true)
      })
      .catch(() => setSuggestions([]))
  }, [debouncedKeyword])

  // Close suggestions dropdown when clicking outside
  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (
        suggestionsRef.current &&
        !suggestionsRef.current.contains(e.target as Node) &&
        searchInputRef.current &&
        !searchInputRef.current.contains(e.target as Node)
      ) {
        setShowSuggestions(false)
      }
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  const runSearch = useCallback(async (terms: string[]) => {
    const clean = terms.map((t) => t.trim().toLowerCase()).filter(Boolean)
    if (!clean.length) return
    setShowSuggestions(false)
    setSearchResults(null)
    setSearching(true)
    setError('')
    try {
      const res = await fetch(`/api/deals/search?keywords=${encodeURIComponent(clean.join(','))}`)
      const d = res.ok ? await res.json() : { deals: [] }
      setSearchResults(d.deals ?? [])
      trackEvent('keyword_search', { keywords: clean.join(','), results: (d.deals ?? []).length })
    } catch {
      setSearchResults([])
    } finally {
      setSearching(false)
    }
  }, [])

  const removeKeyword = useCallback((kw: string) => {
    setActiveKeywords((prev) => {
      const next = prev.filter((k) => k !== kw)
      if (next.length === 0) { setSearchResults(null) } else { runSearch(next) }
      return next
    })
  }, [runSearch])

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    const term = keywordInput.trim().toLowerCase()
    if (!term) return
    setKeywordInput('')
    setActiveBrand(null)
    setBrandResults(null)
    setActiveKeywords((prev) => {
      if (prev.includes(term)) return prev
      const next = [...prev, term]
      runSearch(next)
      return next
    })
  }

  const selectBrand = useCallback(async (name: string) => {
    if (activeBrand === name) {
      setActiveBrand(null)
      setBrandResults(null)
      return
    }
    setActiveKeywords([])
    setSearchResults(null)
    setActiveBrand(name)
    setBrandResults(null)
    setBrandSearching(true)
    try {
      const res = await fetch(`/api/deals/search?retailer=${encodeURIComponent(name)}`)
      const d = res.ok ? await res.json() : { deals: [] }
      setBrandResults(d.deals ?? [])
    } catch {
      setBrandResults([])
    } finally {
      setBrandSearching(false)
    }
  }, [activeBrand])

  const storeCount = pickedStores.length
  const pickedStoreIds = useMemo(() => new Set(pickedStores.map((s) => s.id)), [pickedStores])

  const cancelsAtLabel = cancelsAt
    ? (() => {
        const d = new Date(cancelsAt)
        const now = new Date()
        return d.toLocaleDateString('en-US', {
          month: 'short', day: 'numeric',
          ...(d.getFullYear() === now.getFullYear() ? {} : { year: 'numeric' }),
        })
      })()
    : null

  const addStore = useCallback(async (s: StoreLite) => {
    setActiveKeywords([])
    setSearchResults(null)
    setActiveBrand(s.name)
    setBrandResults(null)
    setBrandSearching(true)
    fetch(`/api/deals/search?retailer=${encodeURIComponent(s.name)}`)
      .then((res) => (res.ok ? res.json() : { deals: [] }))
      .then((d) => setBrandResults(d.deals ?? []))
      .catch(() => setBrandResults([]))
      .finally(() => setBrandSearching(false))
    if (pickedStoreIds.has(s.id)) return
    setPickedStores((prev) => [...prev, s])
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
  }, [signedIn, pickedStoreIds])

  const removeStore = useCallback(async (id: string) => {
    const pickId = pickIdByStoreId.get(id)
    setPickedStores((prev) => prev.filter((s) => s.id !== id))
    setPickIdByStoreId((prev) => { const n = new Map(prev); n.delete(id); return n })
    if (!signedIn || !pickId) return
    try { await fetch(`/api/store-picks/${pickId}`, { method: 'DELETE' }) } catch {}
  }, [signedIn, pickIdByStoreId])

  // Unified suggestion handler — routes to keyword or brand search
  const handleSuggestionSelect = useCallback((s: KeywordSuggestion) => {
    setShowSuggestions(false)
    setKeywordInput('')
    if (s.type === 'brand') {
      const store = stores.find((st) => normName(st.name) === normName(s.keyword))
      if (store) {
        addStore(store)
      } else {
        setActiveKeywords([])
        setSearchResults(null)
        setActiveBrand(s.keyword)
        setBrandResults(null)
        setBrandSearching(true)
        fetch(`/api/deals/search?retailer=${encodeURIComponent(s.keyword)}`)
          .then((res) => (res.ok ? res.json() : { deals: [] }))
          .then((d) => setBrandResults(d.deals ?? []))
          .catch(() => setBrandResults([]))
          .finally(() => setBrandSearching(false))
      }
    } else {
      const term = s.keyword.trim().toLowerCase()
      setActiveBrand(null)
      setBrandResults(null)
      setActiveKeywords((prev) => {
        if (prev.includes(term)) return prev
        const next = [...prev, term]
        runSearch(next)
        return next
      })
    }
  }, [stores, addStore, runSearch])

  // Anonymous: email search results to yourself
  const handleAnonEmailResults = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email || !activeKeywords.length) return
    setSubmitting(true)
    setError('')
    try {
      const subRes = await fetch('/api/subscribe', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, watches: [], store_ids: [] }),
      })
      if (!subRes.ok) {
        const d = await subRes.json().catch(() => ({}))
        setError(d.error || 'Could not save your email. Please try again.')
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
        trackEvent('sign_up', { method: 'magic_link', location: 'keyword_search_results', keyword: activeKeywords })
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
    if (storeCount === 0) { setError('Add at least one brand below first.'); return }
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

  const saveMinDiscount = useCallback(async (next: number | null) => {
    setMinDiscountPct(next)
    try {
      await fetch('/api/account', {
        method: 'PATCH', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ min_discount_pct: next }),
      })
    } catch {}
  }, [])

  const updateInclude = useCallback(
    async (key: 'include_free_shipping' | 'include_bogo' | 'include_gwp', value: boolean) => {
      if (key === 'include_free_shipping') setIncludeFreeShipping(value)
      else if (key === 'include_bogo') setIncludeBogo(value)
      else setIncludeGwp(value)
      try {
        await fetch('/api/account', {
          method: 'PATCH', headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ [key]: value }),
        })
      } catch {}
    }, [])

  const toggleTier = useCallback(async (tier: string) => {
    const next = new Set(allowedTiers)
    if (next.has(tier)) next.delete(tier)
    else next.add(tier)
    setAllowedTiers(next)
    try {
      await fetch('/api/account', {
        method: 'PATCH', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ allowed_price_tiers: Array.from(next) }),
      })
    } catch {}
  }, [allowedTiers])

  const handleLogout = async () => {
    try { await fetch('/api/auth/logout', { method: 'POST' }) } catch {}
    window.location.href = '/'
  }

  const handleManageBilling = async () => {
    setError(''); setStatusMsg('Opening billing portal…')
    try {
      const res = await fetch('/api/billing/portal', { method: 'POST' })
      const d = await res.json().catch(() => ({}))
      if (!res.ok || !d.url) { setStatusMsg(''); setError(d.error || 'Could not open billing portal.'); return }
      window.location.href = d.url
    } catch { setStatusMsg(''); setError('Could not open billing portal.') }
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
              We sent a sign-in link to <strong style={{ fontFamily: "'Special Elite', monospace", fontStyle: 'normal' }}>{email}</strong>. Click it to finish setting up your account.
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
        <div className="form-card">

          {/* ── SEARCH ── */}
          <h2 className="form-h">
            What are you{' '}
            <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>
              shopping for?
            </em>
          </h2>

          <div className="dl-field">
            {/* Watched brand chips */}
            {pickedStores.length > 0 && (
              <div style={{ marginBottom: 12 }}>
                <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
                  {pickedStores.map((p) => {
                    const isActive = activeBrand === p.name
                    return (
                      <span
                        key={p.id}
                        style={{
                          display: 'inline-flex', alignItems: 'center', gap: 0,
                          border: '1.5px solid var(--ink)',
                          background: isActive ? 'var(--red-deep)' : 'var(--ink)',
                          color: 'var(--paper, #f6ecd2)',
                          fontFamily: 'var(--font-mono, monospace)', fontSize: 13,
                          minHeight: 36,
                        }}
                      >
                        <button
                          type="button"
                          onClick={() => selectBrand(p.name)}
                          style={{
                            background: 'none', border: 'none', padding: '0 0 0 12px',
                            color: 'inherit', fontFamily: 'inherit', fontSize: 'inherit',
                            cursor: 'pointer', minHeight: 36, display: 'inline-flex',
                            alignItems: 'center',
                          }}
                        >
                          {p.name}
                        </button>
                        <button
                          type="button"
                          onClick={() => {
                            removeStore(p.id)
                            if (activeBrand === p.name) { setActiveBrand(null); setBrandResults(null) }
                          }}
                          aria-label={`Remove ${p.name}`}
                          style={{
                            minWidth: 36, minHeight: 36, display: 'inline-flex',
                            alignItems: 'center', justifyContent: 'center',
                            border: 'none', background: 'transparent',
                            color: 'var(--paper, #f6ecd2)', cursor: 'pointer',
                            fontSize: 20, lineHeight: 1, padding: 0,
                          }}
                        >×</button>
                      </span>
                    )
                  })}
                </div>
              </div>
            )}

            {/* Unified search input */}
            <form onSubmit={handleSearchSubmit} style={{ position: 'relative', marginBottom: 0 }}>
              <input
                ref={searchInputRef}
                type="search"
                value={keywordInput}
                onChange={(e) => { setKeywordInput(e.target.value); setShowSuggestions(true) }}
                onFocus={() => { if (suggestions.length > 0) setShowSuggestions(true) }}
                placeholder="sneakers, couch, J.Crew, Nordstrom…"
                style={{
                  width: '100%', padding: '14px 16px',
                  fontFamily: "'Special Elite', monospace", fontSize: 16,
                  background: '#fff8e2', border: '2px solid var(--ink)',
                  color: 'var(--ink)', outline: 'none', boxSizing: 'border-box',
                }}
              />

              {showSuggestions && suggestions.length > 0 && (
                <div
                  ref={suggestionsRef}
                  style={{
                    position: 'absolute', top: '100%', left: 0, right: 0, zIndex: 10,
                    background: '#fff8e2', border: '2px solid var(--ink)', borderTop: 'none',
                    maxHeight: 240, overflowY: 'auto',
                  }}
                >
                  {suggestions.map((s) => (
                    <button
                      key={`${s.type}-${s.keyword}`}
                      type="button"
                      onMouseDown={(e) => { e.preventDefault(); handleSuggestionSelect(s) }}
                      style={{
                        display: 'flex', width: '100%', textAlign: 'left',
                        alignItems: 'center', justifyContent: 'space-between',
                        padding: '10px 16px',
                        fontFamily: "'Special Elite', monospace", fontSize: 15,
                        background: 'transparent', border: 'none',
                        borderBottom: '1px solid rgba(24,22,18,0.15)',
                        color: 'var(--ink)', cursor: 'pointer',
                      }}
                    >
                      <span>{s.keyword}</span>
                      {s.type === 'brand' && (
                        <span style={{
                          fontFamily: "'Stardos Stamp', monospace", fontSize: 9,
                          letterSpacing: '.18em', textTransform: 'uppercase',
                          color: 'var(--ink-soft)', marginLeft: 8, flexShrink: 0,
                        }}>brand</span>
                      )}
                    </button>
                  ))}
                </div>
              )}
            </form>

            {/* Min discount — inline row below search */}
            {signedIn === true && (
              <div style={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center', gap: 6, marginTop: 10 }}>
                <span style={{
                  fontFamily: "'Stardos Stamp', monospace", fontSize: 9,
                  letterSpacing: '.18em', textTransform: 'uppercase',
                  color: 'var(--ink-soft)', marginRight: 2,
                }}>Min:</span>
                {DISCOUNT_STEPS.map((step) => (
                  <button
                    key={step.label}
                    type="button"
                    disabled={!isPaid}
                    onClick={() => saveMinDiscount(step.value)}
                    style={{
                      fontFamily: "'Stardos Stamp', monospace", fontSize: 11,
                      letterSpacing: '.12em', textTransform: 'uppercase',
                      padding: '5px 10px', minHeight: 30,
                      background: (minDiscountPct ?? null) === step.value ? 'var(--ink)' : '#fffbe6',
                      color: (minDiscountPct ?? null) === step.value ? 'var(--paper, #f6ecd2)' : 'var(--ink)',
                      border: '1.5px solid var(--ink)',
                      cursor: !isPaid ? 'not-allowed' : 'pointer',
                      opacity: !isPaid ? 0.55 : 1,
                    }}
                  >{step.label}</button>
                ))}
              </div>
            )}

            {/* Active keyword chips */}
            {activeKeywords.length > 0 && (
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginTop: 12 }}>
                {activeKeywords.map((kw) => (
                  <span
                    key={kw}
                    style={{
                      display: 'inline-flex', alignItems: 'center', gap: 0,
                      border: '1.5px solid var(--ink)', background: 'var(--ink)',
                      color: 'var(--paper, #f6ecd2)',
                      fontFamily: 'var(--font-mono, monospace)', fontSize: 13,
                      minHeight: 36,
                    }}
                  >
                    <span style={{ padding: '0 4px 0 12px' }}>{kw}</span>
                    <button
                      type="button"
                      onClick={() => removeKeyword(kw)}
                      aria-label={`Remove ${kw}`}
                      style={{
                        minWidth: 36, minHeight: 36, display: 'inline-flex',
                        alignItems: 'center', justifyContent: 'center',
                        border: 'none', background: 'transparent',
                        color: 'var(--paper, #f6ecd2)', cursor: 'pointer',
                        fontSize: 20, lineHeight: 1, padding: 0,
                      }}
                    >×</button>
                  </span>
                ))}
              </div>
            )}

            {/* Keyword search results */}
            {searchResults !== null && (
              <div style={{ marginTop: 16 }}>
                {searching ? (
                  <p style={{ textAlign: 'center', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--ink-soft)', padding: '20px 0' }}>
                    Searching…
                  </p>
                ) : searchResults.length === 0 ? (
                  <div style={{ padding: '20px 0', textAlign: 'center' }}>
                    <p style={{ fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 17, color: 'var(--ink-soft)', margin: 0 }}>
                      No live deals for <strong style={{ fontStyle: 'normal' }}>&ldquo;{activeKeywords.join(', ')}&rdquo;</strong> right now.
                    </p>
                    <p style={{ fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--ink-soft)', marginTop: 8 }}>
                      New deals land daily — try again tomorrow or search something else.
                    </p>
                  </div>
                ) : (
                  <>
                    <p style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--red-deep)', marginBottom: 14 }}>
                      — {searchResults.length} {searchResults.length === 1 ? 'deal' : 'deals'} for &ldquo;{activeKeywords.join(', ')}&rdquo; —
                    </p>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                      {searchResults.map((deal) => (
                        <DealCard key={deal.id} deal={deal} />
                      ))}
                    </div>

                    <div style={{ marginTop: 24, padding: '18px 20px', background: '#fff8e2', border: '2px dashed var(--ink)' }}>
                      {signedIn === true ? (
                        <>
                          <p style={{ margin: '0 0 12px', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink)' }}>
                            Want these emailed to you? Hit send below.
                          </p>
                          <button type="button" onClick={sendDealsNow} disabled={sendingDeals} className="submit-btn" style={{ width: '100%' }}>
                            {sendingDeals ? 'SENDING…' : 'EMAIL THESE DEALS →'}
                          </button>
                          {statusMsg && <p style={{ margin: '10px 0 0', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 14, color: 'var(--ink-soft)', textAlign: 'center' }}>{statusMsg}</p>}
                          {error && <p style={{ margin: '10px 0 0', fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--red-deep)', textAlign: 'center' }}>{error}</p>}
                        </>
                      ) : (
                        <>
                          <p style={{ margin: '0 0 12px', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink)' }}>
                            Drop your email and we&rsquo;ll send you these — plus flag new ones as they land.
                          </p>
                          <form onSubmit={handleAnonEmailResults} style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
                            <input
                              type="email"
                              value={email}
                              onChange={(e) => setEmail(e.target.value)}
                              placeholder="you@inbox.com"
                              required
                              disabled={submitting}
                              style={{ flex: '1 1 200px', padding: '12px 14px', fontFamily: "'Special Elite', monospace", fontSize: 15, background: 'white', border: '2px solid var(--ink)', color: 'var(--ink)', outline: 'none', boxSizing: 'border-box' }}
                            />
                            <button type="submit" disabled={submitting || !email} className="submit-btn" style={{ flex: '0 0 auto' }}>
                              {submitting ? 'SENDING…' : 'EMAIL ME THESE →'}
                            </button>
                          </form>
                          {error && <p style={{ margin: '10px 0 0', fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--red-deep)' }}>{error}</p>}
                          <p style={{ margin: '10px 0 0', fontFamily: "'Stardos Stamp', monospace", fontSize: 10, letterSpacing: '.18em', textTransform: 'uppercase', color: 'var(--ink-soft)' }}>
                            No card · No password · Unsubscribe anytime
                          </p>
                        </>
                      )}
                    </div>
                  </>
                )}
              </div>
            )}

            {/* Brand results */}
            {brandResults !== null && (
              <div style={{ marginTop: 24 }}>
                {brandSearching ? (
                  <p style={{ textAlign: 'center', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--ink-soft)', padding: '20px 0' }}>
                    Searching…
                  </p>
                ) : brandResults.length === 0 ? (
                  <div style={{ padding: '20px 0', textAlign: 'center' }}>
                    <p style={{ fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 17, color: 'var(--ink-soft)', margin: 0 }}>
                      No live deals for <strong style={{ fontStyle: 'normal' }}>{activeBrand}</strong> right now.
                    </p>
                    <p style={{ fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--ink-soft)', marginTop: 8 }}>
                      New deals land daily — check back tomorrow.
                    </p>
                  </div>
                ) : (
                  <>
                    <p style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--red-deep)', marginBottom: 14 }}>
                      — {brandResults.length} {brandResults.length === 1 ? 'deal' : 'deals'} for {activeBrand} —
                    </p>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                      {brandResults.map((deal) => (
                        <DealCard key={deal.id} deal={deal} />
                      ))}
                    </div>
                  </>
                )}
              </div>
            )}
          </div>

          {signedIn === null && (
            <p style={{ marginTop: 28, textAlign: 'center', color: 'var(--ink-soft)', fontFamily: "'Special Elite', monospace" }}>Loading…</p>
          )}

          {/* Signed-in: filters + send + danger zone */}
          {signedIn === true && (
            <>
              <FilterPanel
                isPaid={isPaid}
                allowedTiers={allowedTiers}
                onToggleTier={toggleTier}
                includeFreeShipping={includeFreeShipping}
                includeBogo={includeBogo}
                includeGwp={includeGwp}
                onToggleInclude={updateInclude}
              />

              {storeCount > 0 && (
                <div style={{ marginTop: 20 }}>
                  <button
                    type="button"
                    onClick={sendDealsNow}
                    disabled={sendingDeals}
                    className="submit-btn"
                    style={{ width: '100%' }}
                  >
                    {sendingDeals ? 'SENDING…' : 'SEND ME DEALS FROM MY BRANDS →'}
                  </button>
                  <p style={{ margin: '10px 0 0', fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', textAlign: 'center' }}>
                    Pulls fresh deals from your {storeCount} watched {storeCount === 1 ? 'brand' : 'brands'}
                  </p>
                  {statusMsg && <p style={{ margin: '14px 0 0', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink-soft)', textAlign: 'center' }}>{statusMsg}</p>}
                  {error && <p style={{ margin: '12px 0 0', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--red-deep)', textAlign: 'center' }}>{error}</p>}
                </div>
              )}

              {!isPaid && (
                <div style={{ marginTop: 28, padding: '20px 22px', background: '#fff8e2', border: '2.5px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', display: 'flex', flexWrap: 'wrap', alignItems: 'center', gap: 16, justifyContent: 'space-between' }}>
                  <div style={{ flex: '1 1 220px' }}>
                    <div style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.3em', textTransform: 'uppercase', color: 'var(--red-deep)', marginBottom: 6 }}>
                      — Want more? —
                    </div>
                    <p style={{ margin: 0, fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 16, color: 'var(--ink)', lineHeight: 1.45 }}>
                      Upgrade for unlimited brand picks and deal filters.
                    </p>
                  </div>
                  <a href="/pricing" style={{ fontFamily: "'Alfa Slab One', serif", fontSize: 14, letterSpacing: '.08em', textTransform: 'uppercase', background: 'var(--red)', color: 'var(--paper, #f6ecd2)', padding: '14px 24px 12px', border: '2px solid var(--ink)', boxShadow: '4px 4px 0 var(--ink)', textDecoration: 'none', flexShrink: 0, minHeight: 48, display: 'inline-flex', alignItems: 'center', justifyContent: 'center' }}>
                    Upgrade →
                  </a>
                </div>
              )}

              <p style={{ margin: '28px 0 8px', fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--ink-soft)', textAlign: 'center' }}>
                <a href="/suggest" style={{ color: 'var(--ink-soft)', textDecoration: 'underline', textDecorationStyle: 'dotted' }}>Suggest a store →</a>
              </p>

              <details className="danger-zone-collapsible">
                <summary style={{ listStyle: 'none', cursor: 'pointer', display: 'inline-flex', alignItems: 'center', gap: 8, fontFamily: "'Stardos Stamp', monospace", fontSize: 12, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', padding: '8px 0', userSelect: 'none' }}>
                  Delete account
                  <span aria-hidden="true" className="danger-zone-chevron" style={{ display: 'inline-block', transition: 'transform .15s ease', fontSize: 14, lineHeight: 1 }}>▾</span>
                </summary>
                <div className="danger" style={{ marginTop: 12 }}>
                  <p>
                    <em>Need to step away?</em>{' '}
                    <strong>Log out</strong> ends this session — sign back in any time via magic link.{' '}
                    {isPaid && !isComped && hasBillingAccount && (
                      <><strong>Manage billing</strong> opens Stripe&rsquo;s portal — update card, view invoices, or cancel (keeps paid access through your current billing period).{' '}</>
                    )}
                    <strong>Unsubscribe</strong> stops deal emails
                    {isPaid && !isComped && hasBillingAccount ? ' and cancels your subscription at the end of your current billing period. ' : '. '}
                    <strong>Delete</strong> wipes everything
                    {isPaid && !isComped && hasBillingAccount ? ' and cancels your subscription immediately — ' : ' — '}
                    watchlist, picks, send history, sign-in.
                  </p>
                  <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
                    <button type="button" className="btn-ghost-tag" onClick={handleLogout}>Log out</button>
                    {isPaid && !isComped && hasBillingAccount && (
                      <button type="button" className="btn-ghost-tag" onClick={handleManageBilling}>Manage billing</button>
                    )}
                    <button type="button" className="btn-ghost-tag" style={{ background: '#fde0de', color: 'var(--red-deep)' }} onClick={handleUnsubscribe}>Unsubscribe</button>
                    <button type="button" className="btn-ghost-tag" style={{ background: 'var(--red-deep)', color: '#fff8e2', border: '2px solid var(--red-deep)' }} onClick={handleDeleteAccount}>Delete my account</button>
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

// ── DealCard ────────────────────────────────────────────────────────────

function formatDealType(type: string, pct: number | null): string {
  if (type === 'percent-off' && pct) return `${pct}% off`
  if (type === 'bogo-free') return 'BOGO free'
  if (type === 'bogo-half') return 'BOGO 50% off'
  if (type === 'free-item') return 'Free item'
  if (type === 'free-shipping') return 'Free shipping'
  if (type === 'up-to' && pct) return `Up to ${pct}% off`
  if (type === 'loyalty') return 'Loyalty offer'
  if (type === 'stackable') return 'Stackable deal'
  return 'Sale'
}

function DealCard({ deal }: { deal: DealResult }) {
  const badge = formatDealType(deal.deal_type, deal.percent_off)
  const link = deal.affiliate_link || deal.original_link

  return (
    <div style={{
      padding: '16px 18px',
      border: '2px solid var(--ink)',
      background: '#fffbe6',
      boxShadow: '3px 3px 0 var(--ink)',
    }}>
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: 10, flexWrap: 'wrap', marginBottom: 6 }}>
        <div>
          <span style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 12, letterSpacing: '.16em', textTransform: 'uppercase', color: 'var(--red-deep)' }}>
            {badge}
          </span>
          {' · '}
          <span style={{ fontFamily: "'Alfa Slab One', serif", fontSize: 15, color: 'var(--ink)' }}>
            {deal.retailer}
          </span>
        </div>
        {deal.promo_code && (
          <span style={{
            fontFamily: "'Special Elite', monospace", fontSize: 12,
            padding: '3px 8px', background: 'var(--ink)', color: '#fff8e2',
            letterSpacing: '.12em', whiteSpace: 'nowrap',
          }}>
            {deal.promo_code}
          </span>
        )}
      </div>

      <p style={{ margin: '0 0 10px', fontFamily: "'IM Fell English', serif", fontSize: 15, lineHeight: 1.45, color: 'var(--ink)' }}>
        {deal.description}
      </p>

      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 10, flexWrap: 'wrap' }}>
        {deal.expiration_date && (
          <span style={{ fontFamily: "'Special Elite', monospace", fontSize: 12, color: 'var(--ink-soft)' }}>
            Expires {deal.expiration_date}
          </span>
        )}
        <div style={{ display: 'flex', alignItems: 'center', gap: 14, flexWrap: 'wrap' }}>
          <a
            href={link}
            target="_blank"
            rel="noopener noreferrer"
            style={{
              fontFamily: "'Stardos Stamp', monospace", fontSize: 11,
              letterSpacing: '.18em', textTransform: 'uppercase',
              color: 'var(--ink)', textDecoration: 'underline',
              textDecorationStyle: 'dotted', whiteSpace: 'nowrap',
            }}
          >
            Shop the deal →
          </a>
          {deal.source_email_link && (
            <a
              href={deal.source_email_link}
              target="_blank"
              rel="noopener noreferrer"
              style={{
                fontFamily: "'Stardos Stamp', monospace", fontSize: 11,
                letterSpacing: '.18em', textTransform: 'uppercase',
                color: 'var(--ink-soft)', textDecoration: 'underline',
                textDecorationStyle: 'dotted', whiteSpace: 'nowrap',
              }}
            >
              View email →
            </a>
          )}
        </div>
      </div>
    </div>
  )
}

// ── FilterPanel ─────────────────────────────────────────────────────────

const PRICE_TIERS = ['$', '$$', '$$$', '$$$$'] as const
const DISCOUNT_STEPS: Array<{ label: string; value: number | null }> = [
  { label: 'Any', value: null },
  { label: '20%', value: 20 },
  { label: '30%', value: 30 },
  { label: '40%', value: 40 },
  { label: '50%+', value: 50 },
]

function FilterPanel({
  isPaid,
  allowedTiers, onToggleTier,
  includeFreeShipping, includeBogo, includeGwp, onToggleInclude,
}: {
  isPaid: boolean
  allowedTiers: Set<string>
  onToggleTier: (tier: string) => void
  includeFreeShipping: boolean
  includeBogo: boolean
  includeGwp: boolean
  onToggleInclude: (key: 'include_free_shipping' | 'include_bogo' | 'include_gwp', value: boolean) => void
}) {
  const disabled = !isPaid

  const chipStyle = (active: boolean): React.CSSProperties => ({
    fontFamily: "'Stardos Stamp', monospace", fontSize: 12,
    letterSpacing: '.14em', textTransform: 'uppercase',
    padding: '8px 14px', minHeight: 36,
    background: active ? 'var(--ink)' : '#fffbe6',
    color: active ? 'var(--paper, #f6ecd2)' : 'var(--ink)',
    border: '2px solid var(--ink)', boxShadow: '2px 2px 0 var(--ink)',
    cursor: disabled ? 'not-allowed' : 'pointer',
    opacity: disabled ? 0.55 : 1,
    transition: 'transform .12s',
  })

  return (
    <div style={{ marginTop: 28, padding: '18px 20px', background: '#fff8e2', border: '2px solid var(--ink)', boxShadow: '3px 3px 0 var(--ink)', position: 'relative' }}>
      {disabled && (
        <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 10 }}>
          <a href="/pricing" style={{ display: 'inline-flex', alignItems: 'center', gap: 6, padding: '4px 10px', background: 'var(--ink)', color: 'var(--yellow)', fontFamily: "'Stardos Stamp', monospace", fontSize: 10, letterSpacing: '.18em', textTransform: 'uppercase', textDecoration: 'none', border: '1.5px solid var(--ink)' }} title="Upgrade to use these filters" aria-label="Upgrade to Personal Shopper">
            <span aria-hidden="true">🔒</span>Locked
          </a>
        </div>
      )}

      <div>
        <div style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 10, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', marginBottom: 8 }}>Price tier</div>
        <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap' }}>
          {PRICE_TIERS.map((tier) => (
            <button key={tier} type="button" disabled={disabled} onClick={() => onToggleTier(tier)} style={chipStyle(allowedTiers.has(tier))} aria-pressed={allowedTiers.has(tier)}>{tier}</button>
          ))}
        </div>
        <p style={{ margin: '8px 0 0', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 12, color: 'var(--ink-soft)' }}>
          {allowedTiers.size === 0 || allowedTiers.size === 4 ? 'All tiers' : `Only ${Array.from(allowedTiers).join(' / ')} stores`}
        </p>
      </div>

      <div style={{ marginTop: 16 }}>
        <div style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 10, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', marginBottom: 8 }}>Also include</div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px 18px', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--ink)' }}>
          {([
            { key: 'include_free_shipping' as const, label: 'Free shipping', value: includeFreeShipping },
            { key: 'include_bogo' as const, label: 'BOGO offers', value: includeBogo },
            { key: 'include_gwp' as const, label: 'Gift with purchase', value: includeGwp },
          ]).map(({ key, label, value }) => (
            <label key={key} style={{ display: 'inline-flex', alignItems: 'center', gap: 6, cursor: disabled ? 'not-allowed' : 'pointer', opacity: disabled ? 0.55 : 1 }}>
              <input type="checkbox" checked={value} disabled={disabled} onChange={(e) => onToggleInclude(key, e.target.checked)} />
              {label}
            </label>
          ))}
        </div>
      </div>
    </div>
  )
}
