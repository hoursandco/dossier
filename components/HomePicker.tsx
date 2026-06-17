'use client'

// HomePicker — the homepage's picker + actions surface.
//
// Two modes:
//   - Signed-OUT: keyword search → on-page results → email field to send
//     matching deals to yourself.
//   - Signed-IN:  keyword search + on-page results, plus store watchlist
//     and SEND ME DEALS NOW for brand-based sends.

import { useCallback, useEffect, useRef, useState } from 'react'
import { createPortal } from 'react-dom'
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
  store_website: string | null
  source_email_link: string | null
  week_of: string
  price_tier: string | null
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

  const [pickedStores, setPickedStores] = useState<StoreLite[]>([])
  const [pickIdByStoreId, setPickIdByStoreId] = useState<Map<string, string>>(new Map())

  // Deal filters
  const [allowedTiers, setAllowedTiers] = useState<Set<string>>(new Set())

  // Keyword search state
  const [keywordInput, setKeywordInput] = useState('')
  const [suggestions, setSuggestions] = useState<KeywordSuggestion[]>([])
  const [showSuggestions, setShowSuggestions] = useState(false)
  const [searchResults, setSearchResults] = useState<DealResult[] | null>(null)
  const [activeKeywords, setActiveKeywords] = useState<string[]>([])
  const [searching, setSearching] = useState(false)
  const searchInputRef = useRef<HTMLInputElement>(null)
  const suggestionsRef = useRef<HTMLDivElement>(null)

  // Tracks which activeKeywords entries are brand (retailer) searches
  const brandKeywordsRef = useRef<Set<string>>(new Set())

  // Anon submit (email deals from search results)
  const [email, setEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)

  // Signed-in send
  const [sendingDeals, setSendingDeals] = useState(false)
  const [statusMsg, setStatusMsg] = useState('')
  const [error, setError] = useState('')
  const [tipMenuOpen, setTipMenuOpen] = useState(false)
  const tipRef = useRef<HTMLDivElement>(null)

  const [resultsPortal, setResultsPortal] = useState<Element | null>(null)
  useEffect(() => {
    setResultsPortal(document.getElementById('deal-results-portal'))
  }, [])

  useEffect(() => {
    if (!tipMenuOpen) return
    function handleOutside(e: MouseEvent) {
      if (tipRef.current && !tipRef.current.contains(e.target as Node)) {
        setTipMenuOpen(false)
      }
    }
    document.addEventListener('mousedown', handleOutside)
    return () => document.removeEventListener('mousedown', handleOutside)
  }, [tipMenuOpen])

  const debouncedKeyword = useDebounce(keywordInput, 300)

  useEffect(() => {
    fetch('/api/account', { cache: 'no-store' })
      .then(async (r) => {
        if (!r.ok) { setSignedIn(false); return }
        const d = await r.json()
        if (d?.email) {
          setSignedIn(true)
          setAccountEmail(d.email)
          setIsPaid(true)
          setIsComped(d.subscription_status === 'comped')
          setHasBillingAccount(!!d.has_billing_account)
          if (Array.isArray(d.allowed_price_tiers) && d.allowed_price_tiers.length > 0) {
            setAllowedTiers(new Set(d.allowed_price_tiers))
          }
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
    if (!terms.length) return
    setShowSuggestions(false)
    setSearchResults(null)
    setSearching(true)
    setError('')
    try {
      const brands = brandKeywordsRef.current
      const brandTerms = terms.filter((t) => brands.has(t))
      const kwTerms = terms.filter((t) => !brands.has(t)).map((t) => t.toLowerCase())

      const fetches: Promise<DealResult[]>[] = []
      if (kwTerms.length > 0) {
        fetches.push(
          fetch(`/api/deals/search?keywords=${encodeURIComponent(kwTerms.join(','))}`)
            .then((r) => (r.ok ? r.json() : { deals: [] }))
            .then((d) => d.deals ?? [])
            .catch(() => [])
        )
      }
      for (const brand of brandTerms) {
        fetches.push(
          fetch(`/api/deals/search?retailer=${encodeURIComponent(brand)}`)
            .then((r) => (r.ok ? r.json() : { deals: [] }))
            .then((d) => d.deals ?? [])
            .catch(() => [])
        )
      }

      const results = await Promise.all(fetches)
      const seen = new Set<string>()
      const deduped = results.flat().filter((d) => {
        if (seen.has(d.id)) return false
        seen.add(d.id)
        return true
      })
      setSearchResults(deduped)
      trackEvent('keyword_search', { keywords: terms.join(','), results: deduped.length })
    } catch {
      setSearchResults([])
    } finally {
      setSearching(false)
    }
  }, [])

  const removeKeyword = useCallback((kw: string) => {
    brandKeywordsRef.current.delete(kw)
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
    setActiveKeywords((prev) => {
      if (prev.includes(term)) return prev
      const next = [...prev, term]
      runSearch(next)
      return next
    })
  }

  const searchBrand = useCallback((name: string) => {
    if (activeKeywords.includes(name)) return
    brandKeywordsRef.current.add(name)
    setActiveKeywords((prev) => {
      const next = [...prev, name]
      runSearch(next)
      return next
    })
  }, [activeKeywords, runSearch])

  const storeCount = pickedStores.length
  const removeStore = useCallback(async (id: string) => {
    const pickId = pickIdByStoreId.get(id)
    setPickedStores((prev) => prev.filter((s) => s.id !== id))
    setPickIdByStoreId((prev) => { const n = new Map(prev); n.delete(id); return n })
    if (!signedIn || !pickId) return
    try { await fetch(`/api/store-picks/${pickId}`, { method: 'DELETE' }) } catch {}
  }, [signedIn, pickIdByStoreId])

  // Unified suggestion handler — both brands and keywords become activeKeyword chips
  const handleSuggestionSelect = useCallback((s: KeywordSuggestion) => {
    setShowSuggestions(false)
    setKeywordInput('')
    const term = s.type === 'brand' ? s.keyword : s.keyword.trim().toLowerCase()
    if (s.type === 'brand') {
      brandKeywordsRef.current.add(term)
    }
    setActiveKeywords((prev) => {
      if (prev.includes(term)) return prev
      const next = [...prev, term]
      runSearch(next)
      return next
    })
  }, [runSearch])

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

  const toggleTier = useCallback(async (tier: string) => {
    const next = new Set(allowedTiers)
    if (next.has(tier)) next.delete(tier)
    else next.add(tier)
    setAllowedTiers(next)
    if (!signedIn) return
    try {
      await fetch('/api/account', {
        method: 'PATCH', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ allowed_price_tiers: Array.from(next) }),
      })
    } catch {}
  }, [allowedTiers, signedIn])

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

  const tierFilterActive = allowedTiers.size > 0 && allowedTiers.size < PRICE_TIERS.length
  const visibleSearchResults = searchResults?.filter((deal) => {
    if (!tierFilterActive) return true
    return !!deal.price_tier && allowedTiers.has(deal.price_tier)
  }) ?? null
  const displayedSearchResults = visibleSearchResults ?? []

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
    <>
    <section className="form-section">
      <div className="form-wrap-narrow">
        <div className="form-card">

          {/* ── SEARCH ── */}
          <h2 className="form-h">
            Whatcha{' '}
            <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>
              shopping for?
            </em>
          </h2>

          <div className="dl-field">
            {/* Watched brand chips (watchlist — click to search, × to remove from watchlist) */}
            {pickedStores.length > 0 && (
              <div style={{ marginBottom: 12 }}>
                <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
                  {pickedStores.map((p) => (
                    <span
                      key={p.id}
                      style={{
                        display: 'inline-flex', alignItems: 'center', gap: 0,
                        border: '1.5px solid var(--ink)',
                        background: 'var(--ink)',
                        color: 'var(--paper, #f6ecd2)',
                        fontFamily: 'var(--font-mono, monospace)', fontSize: 13,
                        minHeight: 36,
                      }}
                    >
                      <button
                        type="button"
                        onClick={() => searchBrand(p.name)}
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
                        onClick={() => removeStore(p.id)}
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
                  ))}
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

            {/* Price tier filter — applies to the live results rail. */}
            <div style={{ marginTop: 12 }}>
              <div style={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center', gap: 6 }}>
                <span style={{
                  fontFamily: "'Stardos Stamp', monospace", fontSize: 9,
                  letterSpacing: '.18em', textTransform: 'uppercase',
                  color: 'var(--ink-soft)', marginRight: 2,
                }}>Price:</span>
                {PRICE_TIERS.map((tier) => (
                  <button
                    key={tier}
                    type="button"
                    onClick={() => toggleTier(tier)}
                    aria-pressed={allowedTiers.has(tier)}
                    title={`Show ${tier} stores`}
                    style={{
                      fontFamily: "'Stardos Stamp', monospace", fontSize: 11,
                      letterSpacing: '.12em', textTransform: 'uppercase',
                      padding: '5px 10px', minHeight: 30,
                      background: allowedTiers.has(tier) ? 'var(--ink)' : '#fffbe6',
                      color: allowedTiers.has(tier) ? 'var(--paper, #f6ecd2)' : 'var(--ink)',
                      border: '1.5px solid var(--ink)',
                      cursor: 'pointer',
                      opacity: 1,
                    }}
                  >{tier}</button>
                ))}
              </div>
            </div>

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

          </div>

          {signedIn === null && (
            <p style={{ marginTop: 28, textAlign: 'center', color: 'var(--ink-soft)', fontFamily: "'Special Elite', monospace" }}>Loading…</p>
          )}

          {/* Signed-in: send + danger zone */}
          {signedIn === true && (
            <>
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

              <p style={{ margin: '28px 0 8px', fontFamily: "'Stardos Stamp', monospace", fontSize: 12, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)' }}>
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
                      <><strong>Manage billing</strong> opens Stripe&rsquo;s portal — update card, view invoices, or cancel legacy billing.{' '}</>
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

              <div ref={tipRef} style={{ position: 'relative', display: 'inline-block', marginTop: 4 }}>
                <button
                  type="button"
                  onClick={() => setTipMenuOpen(o => !o)}
                  style={{ background: 'none', border: 'none', padding: '8px 0', cursor: 'pointer', fontFamily: "'Stardos Stamp', monospace", fontSize: 12, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--ink-soft)', userSelect: 'none' }}
                >
                  Thank the Builder
                </button>
                {tipMenuOpen && (
                  <div style={{ position: 'absolute', bottom: '100%', left: 0, background: 'var(--ink)', border: '1px solid var(--ink)', zIndex: 200, minWidth: 220 }}>
                    {[
                      { label: '☕ Buy Me a Coffee', url: 'https://buymeacoffee.com/breroz' },
                      { label: '· Venmo',            url: 'https://venmo.com/u/breroz' },
                      { label: '· PayPal',           url: 'https://paypal.me/breroz' },
                    ].map(({ label, url }) => (
                      <a
                        key={url}
                        href={url}
                        target="_blank"
                        rel="noopener noreferrer"
                        onClick={() => setTipMenuOpen(false)}
                        style={{ display: 'block', padding: '10px 14px', fontFamily: "'Stardos Stamp', monospace", fontSize: 12, letterSpacing: '.18em', textTransform: 'uppercase', color: 'var(--cream)', textDecoration: 'none', borderBottom: '1px solid rgba(255,255,255,.1)' }}
                        onMouseEnter={e => (e.currentTarget.style.background = 'rgba(255,255,255,.08)')}
                        onMouseLeave={e => (e.currentTarget.style.background = 'transparent')}
                      >
                        {label}
                      </a>
                    ))}
                  </div>
                )}
              </div>
            </>
          )}
        </div>
      </div>
    </section>

    {/* Keyword + brand results rendered in the homepage results rail. */}
    {resultsPortal && createPortal(
      <div className="deal-results-shell">

        {searchResults === null ? (
          <div className="deal-results-empty">
            <p>Deals will appear here as you search.</p>
          </div>
        ) : (
          <div>
            {searching ? (
              <p style={{ textAlign: 'center', fontFamily: "'Special Elite', monospace", fontSize: 14, color: 'var(--ink-soft)', padding: '20px 0' }}>
                Searching…
              </p>
            ) : displayedSearchResults.length === 0 ? (
              <div style={{ padding: '20px 0', textAlign: 'center' }}>
                <p style={{ fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 17, color: 'var(--ink-soft)', margin: 0 }}>
                  No live deals for <strong style={{ fontStyle: 'normal' }}>&ldquo;{activeKeywords.join(', ')}&rdquo;</strong>{tierFilterActive ? ` in ${Array.from(allowedTiers).join(', ')} stores` : ''} right now.
                </p>
                <p style={{ fontFamily: "'Special Elite', monospace", fontSize: 13, color: 'var(--ink-soft)', marginTop: 8 }}>
                  {tierFilterActive ? 'Clear a price filter or search something else.' : 'New deals land daily — try again tomorrow or search something else.'}
                </p>
              </div>
            ) : (
              <>
                <p style={{ fontFamily: "'Stardos Stamp', monospace", fontSize: 11, letterSpacing: '.22em', textTransform: 'uppercase', color: 'var(--red-deep)', marginBottom: 14 }}>
                  — {displayedSearchResults.length} {displayedSearchResults.length === 1 ? 'deal' : 'deals'} for &ldquo;{activeKeywords.join(', ')}&rdquo;{tierFilterActive ? ` · ${Array.from(allowedTiers).join(', ')}` : ''} —
                </p>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                  {displayedSearchResults.map((deal) => (
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

      </div>,
      resultsPortal
    )}
  </>
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
  const fallbackLink = deal.original_link.includes('google.com/search') ? null : deal.original_link
  const link = deal.store_website || deal.affiliate_link || fallbackLink || '#'

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

const PRICE_TIERS = ['$', '$$', '$$$', '$$$$'] as const
