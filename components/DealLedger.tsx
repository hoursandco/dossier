'use client'

import { useCallback, useEffect, useMemo, useRef, useState } from 'react'

type Deal = {
  id: string; retailer: string; description: string; percent_off: number | null
  promo_code: string | null; expiration_date: string | null; original_link: string
  affiliate_link: string | null; store_website: string | null; price_tier: string | null
  source_email_link: string | null
}
type SortKey = 'retailer' | 'deal' | 'off' | 'ends' | 'code'
const TRIES = [
  'AllModern',
  'CB2',
  'Friends With Frank',
  'FWRD',
  'Gap',
  'Haven Well Within',
  'Hemi Blurr',
  'ME+EM',
  'Rains',
  'Rebag',
  'Salomon',
  'Shoes',
  'Skincare',
  'The Citizenry',
]
const TIERS = ['$', '$$', '$$$', '$$$$']

function headline(text: string) {
  const first = text.split(/[.!?]/)[0].trim()
  return first.length <= 48 ? first : `${first.slice(0, 45).trim()}…`
}
function daysLeft(date: string | null) {
  if (!date) return null
  return Math.max(0, Math.ceil((new Date(`${date}T23:59:59`).getTime() - Date.now()) / 86400000))
}
function endsLabel(date: string | null) {
  const days = daysLeft(date)
  if (days === null) return '—'
  return days === 0 ? 'today' : `${days}d`
}

export function DealLedger() {
  const [query, setQuery] = useState('')
  const [tiers, setTiers] = useState<string[]>([])
  const [deals, setDeals] = useState<Deal[]>([])
  const [loading, setLoading] = useState(false)
  const [sort, setSort] = useState<SortKey>('off')
  const [direction, setDirection] = useState<'asc' | 'desc'>('desc')
  const [expanded, setExpanded] = useState<string | null>(null)
  const [pinned, setPinned] = useState<string | null>(null)
  const [email, setEmail] = useState<string | null>(null)
  const [isAdmin, setIsAdmin] = useState(false)
  const [thanks, setThanks] = useState(false)
  const [menu, setMenu] = useState(false)
  const searchRef = useRef<HTMLInputElement>(null)

  const load = useCallback(async (term: string) => {
    const keyword = term.trim()
    if (!keyword) {
      setDeals([])
      setLoading(false)
      return
    }
    setLoading(true)
    try {
      const response = await fetch(`/api/deals/search?keyword=${encodeURIComponent(keyword)}`, { cache: 'no-store' })
      const data = response.ok ? await response.json() : { deals: [] }
      setDeals(data.deals ?? [])
    } catch { setDeals([]) }
    finally { setLoading(false) }
  }, [])

  useEffect(() => {
    const params = new URLSearchParams(window.location.search)
    const initial = params.get('q') ?? ''
    const initialTiers = params.get('price')?.split(',').filter(Boolean) ?? []
    setQuery(initial); setTiers(initialTiers); load(initial)
    Promise.all([
      fetch('/api/account', { cache: 'no-store' }).then(r => r.ok ? r.json() : null).catch(() => null),
      fetch('/api/admin/check', { cache: 'no-store' }).then(r => r.ok ? r.json() : null).catch(() => null),
    ]).then(([account, admin]) => { setEmail(account?.email ?? null); setIsAdmin(!!admin?.isAdmin) })
  }, [load])

  useEffect(() => {
    const timer = window.setTimeout(() => {
      const params = new URLSearchParams(window.location.search)
      query ? params.set('q', query) : params.delete('q')
      tiers.length ? params.set('price', tiers.join(',')) : params.delete('price')
      params.set('sort', sort); params.set('dir', direction)
      window.history.replaceState(null, '', `${window.location.pathname}?${params}`)
      load(query)
    }, 220)
    return () => window.clearTimeout(timer)
  }, [query, tiers, sort, direction, load])

  useEffect(() => {
    const onKey = (event: KeyboardEvent) => {
      if (event.key === '/' && document.activeElement !== searchRef.current) { event.preventDefault(); searchRef.current?.focus() }
      if (event.key === 'Escape') { setPinned(null); setThanks(false); if (document.activeElement === searchRef.current) setQuery('') }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [])

  const visible = useMemo(() => {
    const filtered = tiers.length ? deals.filter(d => d.price_tier && tiers.includes(d.price_tier)) : deals
    return [...filtered].sort((a, b) => {
      const values: Record<SortKey, [string | number, string | number]> = {
        retailer: [a.retailer, b.retailer], deal: [a.description, b.description],
        off: [a.percent_off ?? -1, b.percent_off ?? -1],
        ends: [a.expiration_date ?? '9999', b.expiration_date ?? '9999'], code: [a.promo_code ?? '', b.promo_code ?? ''],
      }
      const [av, bv] = values[sort]
      const result = typeof av === 'number' ? av - (bv as number) : String(av).localeCompare(String(bv))
      return direction === 'asc' ? result : -result
    })
  }, [deals, tiers, sort, direction])

  const changeSort = (key: SortKey) => { if (sort === key) setDirection(d => d === 'asc' ? 'desc' : 'asc'); else { setSort(key); setDirection(key === 'retailer' ? 'asc' : 'desc') } }
  const chooseTry = (value: string) => setQuery(value)
  const toggleTier = (tier: string) => setTiers(current => current.includes(tier) ? current.filter(t => t !== tier) : [...current, tier])

  return (
    <main className="ledger-app">
      <aside className="ledger-rail">
        <a className="ledger-brand" href="/">
          <span className="ledger-wordmark">DEAL DOSSIER</span>
          <span className="ledger-tagline">Pull every live sale.</span>
        </a>
        <label className="ledger-search"><span>⌕</span><input ref={searchRef} value={query} onChange={e => setQuery(e.target.value)} placeholder="Search every live sale" aria-label="Search every live sale" /></label>
        <div className="ledger-filter"><span className="ledger-label">Try:</span><div className="ledger-chips">{TRIES.map(item => <button key={item} onClick={() => chooseTry(item)}>{item}</button>)}</div></div>
        <div className="ledger-filter"><span className="ledger-label">Price</span><div className="ledger-tiers">{TIERS.map(tier => <button key={tier} className={tiers.includes(tier) ? 'active' : ''} aria-pressed={tiers.includes(tier)} onClick={() => toggleTier(tier)}>{tier}</button>)}</div></div>
        <div className="ledger-saved"><span className="ledger-label">Saved searches</span>{query && <div className="saved-row"><span>{query}</span><button className="toggle active" aria-label={`Alerts for ${query}`} /></div>}<button className="save-search" onClick={() => email ? undefined : location.assign(`/login?next=${encodeURIComponent(location.pathname + location.search)}`)}>+ save this search</button></div>
        <div className="ledger-account">
          {email ? <><button className="account-button" onClick={() => setMenu(!menu)}><span className="avatar">{email[0].toUpperCase()}</span><span><strong>{email}</strong><small>signed in · manage alerts</small></span><span>⌄</span></button>{menu && <div className="account-menu"><a href="/">Saved searches</a><a href="/">Manage alerts</a><button onClick={async () => { await fetch('/api/auth/logout', { method: 'POST' }); location.reload() }}>Sign out</button></div>}</> : <a className="sign-in" href="/login"><span className="avatar">+</span>Sign in to save searches</a>}
        </div>
      </aside>

      <section className="ledger-pane">
        <div className="mobile-brand"><a className="ledger-brand" href="/"><span className="ledger-wordmark">DEAL DOSSIER</span><span className="ledger-tagline">Pull every live sale.</span></a>{email ? <span className="avatar">{email[0].toUpperCase()}</span> : <a href="/login">Sign in</a>}</div>
        <div className="mobile-controls"><label className="ledger-search"><span>⌕</span><input value={query} onChange={e => setQuery(e.target.value)} placeholder="Search every live sale" /></label><div className="ledger-tiers">{TIERS.map(tier => <button key={tier} className={tiers.includes(tier) ? 'active' : ''} onClick={() => toggleTier(tier)}>{tier}</button>)}</div><div className="mobile-tries"><span>TRY:</span>{TRIES.map(item => <button key={item} onClick={() => chooseTry(item)}>{item}</button>)}</div></div>
        <div className="result-line">{!query.trim() ? 'Enter a store or product to search every live sale.' : loading ? 'reading promo inboxes…' : `${visible.length} results · “${query}”`}</div>
        <div className="ledger-head">{(['retailer','deal','off','ends','code'] as SortKey[]).map(key => <button key={key} className={sort === key ? 'active' : ''} onClick={() => changeSort(key)}>{key === 'off' ? 'Off' : key[0].toUpperCase()+key.slice(1)} <span>{sort === key ? (direction === 'asc' ? '↑' : '↓') : '⌄'}</span></button>)}<i /></div>
        <div className="ledger-scroll">
          {!query.trim() ? <div className="ledger-empty"><strong>What are you shopping for?</strong><span>Search a store, brand, or product to pull every live sale.</span></div> : loading ? Array.from({length: 12}, (_, i) => <div className="skeleton-row" key={i}><i style={{width: `${34 + (i%4)*13}%`}} /></div>) : visible.length === 0 ? <div className="ledger-empty"><strong>No live sale.</strong><span>We&rsquo;ll email you the minute one lands.</span>{!email && <input type="email" placeholder="you@example.com" />}<button onClick={() => location.assign('/login')}>Watch this store</button></div> : visible.map(deal => {
            const open = expanded === deal.id
            const card = pinned === deal.id
            const link = deal.affiliate_link || deal.original_link || deal.store_website || '#'
            return <article className={`deal-row ${open ? 'expanded' : ''}`} key={deal.id} onClick={() => setExpanded(open ? null : deal.id)}>
              <a className="deal-retailer" href={link} target="_blank" rel="noopener noreferrer" onClick={e => e.stopPropagation()}>{deal.retailer} ↗</a>
              {deal.source_email_link ? (
                <a
                  className="deal-copy"
                  href={deal.source_email_link}
                  target="_blank"
                  rel="noopener noreferrer"
                  title="Open the original email"
                  onMouseEnter={() => setPinned(deal.id)}
                  onMouseLeave={() => setPinned(null)}
                  onFocus={() => setPinned(deal.id)}
                  onBlur={() => setPinned(null)}
                  onClick={e => e.stopPropagation()}
                >
                  {headline(deal.description)}
                </a>
              ) : (
                <button className="deal-copy" onMouseEnter={() => setPinned(deal.id)} onMouseLeave={() => { if (!card) setPinned(null) }} onFocus={() => setPinned(deal.id)} onClick={e => { e.stopPropagation(); setPinned(card ? null : deal.id) }}>{headline(deal.description)}</button>
              )}
              <span className="deal-off">{deal.percent_off ? `${deal.percent_off}%` : '—'}</span><span className="deal-ends">{endsLabel(deal.expiration_date)}</span><span className="deal-code">{deal.promo_code || '—'}</span><span className="deal-caret">{open ? '▲' : '▾'}</span>
              <div className="mobile-detail"><p>{deal.description}</p><div><span>{deal.promo_code ? `code ${deal.promo_code}` : 'no code'}</span><span>{daysLeft(deal.expiration_date) === null ? 'end date unknown' : `ends in ${daysLeft(deal.expiration_date)} days`}</span></div><a href={link} target="_blank" rel="noopener noreferrer">Go to sale ↗</a></div>
              {card && <div className="hover-card"><p>{deal.description}</p><div><span>{deal.promo_code ? `code ${deal.promo_code}` : 'no code'}</span><span>{daysLeft(deal.expiration_date) === null ? 'end date unknown' : `ends in ${daysLeft(deal.expiration_date)} days`}</span></div></div>}
            </article>
          })}
        </div>
        <footer className="ledger-footer"><a href="/faq">FAQ</a><span>·</span><a href="/suggest">Suggest a store</a><span>·</span><button onClick={() => setThanks(true)}>Thank the builder</button><span className="desktop-legal">·</span><a className="desktop-legal" href="/privacy">Privacy</a><span className="desktop-legal">·</span><a className="desktop-legal" href="/terms">Terms</a>{isAdmin && <><span>·</span><a href="/admin">Admin</a></>}</footer>
      </section>
      {thanks && <div className="thanks-backdrop" onMouseDown={e => { if (e.target === e.currentTarget) setThanks(false) }}><section className="thanks-modal" role="dialog" aria-modal="true" aria-labelledby="thanks-title"><header><h2 id="thanks-title">Thank the builder</h2><button onClick={() => setThanks(false)} aria-label="Close">✕</button></header><p>Free, no ads, no affiliate links. If it saved you money, tip whatever it was worth.</p><a href="https://venmo.com/" target="_blank" rel="noopener noreferrer"><b>V</b> Venmo <span>↗</span></a><a href="https://paypal.com/" target="_blank" rel="noopener noreferrer"><b>P</b> PayPal <span>↗</span></a><a href="https://buymeacoffee.com/" target="_blank" rel="noopener noreferrer"><b>☕</b> Buy Me a Coffee <span>↗</span></a><small>opens in a new tab · esc to close</small></section></div>}
    </main>
  )
}
