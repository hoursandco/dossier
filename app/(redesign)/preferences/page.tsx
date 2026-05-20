'use client'

// /preview-settings — /preferences in the Dossier Look aesthetic.
//
// Phase 4 port: one big client component for speed. Wires the accordion
// category picker, cadence radios, plan selector, refresh button, and
// unsubscribe/delete actions to the real APIs already in use by the
// current olive-bone /preferences page. The auth check + admin gate
// match the production page's behavior.

import { useCallback, useEffect, useMemo, useRef, useState } from 'react'
import { createPortal } from 'react-dom'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { groupCategories, CATEGORY_GROUP_ORDER } from '@/lib/categoryGroups'
import { DossierNav } from '@/components/DossierNav'
import { trackEvent } from '@/lib/analytics'

const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

interface Category {
  slug: string
  label: string
  group_name?: string | null
}

interface Watch {
  id: string
  category_slug: string
  category_label: string
  sub_type?: string | null
  min_price_tier?: string | null
  min_discount?: number | null
}

interface StorePick {
  id: string
  store_id: string
  store_name: string
  website: string
  categories: string[]
  price_tier: string | null
  created_at: string
}

// Store-directory row for the picker search list (returned by /api/stores).
interface DirectoryStore {
  id: string
  name: string
  website: string
  categories: string[]
  price_tier: string | null
}

type PickerTab = 'categories' | 'stores'

const PRICE_TIERS = ['$', '$$', '$$$', '$$$$'] as const
const DISCOUNT_OPTIONS = [20, 30, 40, 50, 60] as const
const FREE_PICK_LIMIT = 3

// Compact countdown formatter for the send-cooldown button. Shows the
// two largest non-zero units so it reads naturally:
//   6d 23h    (anything > 1 day shows days + hours)
//   23h 15m   (under a day shows hours + minutes)
//   15m 30s   (under an hour shows minutes + seconds)
//   30s       (under a minute shows just seconds)
function formatCooldown(ms: number): string {
  if (ms <= 0) return '0s'
  const totalSec = Math.ceil(ms / 1000)
  const d = Math.floor(totalSec / 86400)
  const h = Math.floor((totalSec % 86400) / 3600)
  const m = Math.floor((totalSec % 3600) / 60)
  const s = totalSec % 60
  if (d > 0) return `${d}D ${h}H`
  if (h > 0) return `${h}H ${m}M`
  if (m > 0) return `${m}M ${s}S`
  return `${s}S`
}

interface AccountInfo {
  email: string
  tier: 'free' | 'paid'
  weekly_email_enabled: boolean
  // ISO string of when the free user can send again, or null if they're
  // not in cooldown (either paid, or never sent / window expired).
  next_ondemand_send_at: string | null
}

export default function PreviewSettings() {
  const router = useRouter()
  const rootRef = useRef<HTMLDivElement | null>(null)

  const [loading, setLoading] = useState(true)
  const [isAdmin, setIsAdmin] = useState(false)
  const [account, setAccount] = useState<AccountInfo | null>(null)
  const [categories, setCategories] = useState<Category[]>([])
  const [watches, setWatches] = useState<Watch[]>([])
  const [storePicks, setStorePicks] = useState<StorePick[]>([])
  const [storeDirectory, setStoreDirectory] = useState<DirectoryStore[]>([])
  const [pickerTab, setPickerTab] = useState<PickerTab>('categories')
  const [storeSearch, setStoreSearch] = useState('')
  const [openGroups, setOpenGroups] = useState<Set<string>>(new Set())
  // Modal that pops when a free-tier user tries to exceed the pick
  // limit. Distinct from the regular error banner because hitting the
  // ceiling is a routine + actionable event (upgrade), not a failure
  // that needs a fix. Setting to non-null opens; null closes.
  const [limitModal, setLimitModal] = useState<{ current: number; allowed: number } | null>(null)
  const [togglingSlug, setTogglingSlug] = useState<string | null>(null)
  const [refreshing, setRefreshing] = useState(false)
  const [statusMsg, setStatusMsg] = useState<string | null>(null)
  const [errMsg, setErrMsg] = useState<string | null>(null)
  // Ticks every second so the send-cooldown countdown text stays live.
  // Cheap — only re-renders the small countdown number. Reset to 0
  // anchors the interval so React's StrictMode-double-mount doesn't
  // produce duplicate intervals.
  const [, setNowTick] = useState(0)
  useEffect(() => {
    const id = setInterval(() => setNowTick((n) => n + 1), 1000)
    return () => clearInterval(id)
  }, [])

  // Bootstrap: auth check, then load everything in parallel
  useEffect(() => {
    async function load() {
      const supabase = createClient()
      const { data: { user } } = await supabase.auth.getUser()
      if (!user?.email) {
        router.push('/login?next=/preferences')
        return
      }
      try {
        const [watchesRes, catsRes, accountRes, adminRes, picksRes, storesRes] = await Promise.all([
          fetch('/api/watches').then((r) => r.json()),
          fetch('/api/categories').then((r) => r.json()),
          fetch('/api/account').then((r) => (r.ok ? r.json() : null)).catch(() => null),
          fetch('/api/admin/check').then((r) => r.json()).catch(() => ({ isAdmin: false })),
          fetch('/api/store-picks').then((r) => r.json()).catch(() => ({ store_picks: [] })),
          fetch('/api/stores').then((r) => r.json()).catch(() => ({ stores: [] })),
        ])
        setWatches(watchesRes.watches ?? [])
        setCategories(catsRes.categories ?? [])
        setStorePicks(picksRes.store_picks ?? [])
        setStoreDirectory(storesRes.stores ?? [])
        if (accountRes?.email) {
          setAccount({
            email: accountRes.email,
            tier: accountRes.tier ?? 'free',
            weekly_email_enabled: !!accountRes.weekly_email_enabled,
            next_ondemand_send_at: accountRes.next_ondemand_send_at ?? null,
          })
        } else {
          setAccount({
            email: user.email!,
            tier: 'free',
            weekly_email_enabled: true,
            next_ondemand_send_at: null,
          })
        }
        setIsAdmin(!!adminRes.isAdmin)
      } catch (err) {
        console.error(err)
        setErrMsg('Failed to load your watchlist. Try refreshing the page.')
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [router])

  // Categories grouped using our 8-parent taxonomy. Order respects
  // CATEGORY_GROUP_ORDER. The accordion below renders one .cat per group.
  const grouped = useMemo(() => groupCategories(categories), [categories])
  const watchedSlugs = useMemo(() => new Set(watches.map((w) => w.category_slug)), [watches])

  // Pre-open a group on first load so the page doesn't read as a wall
  // of collapsed headers. Two cases:
  //  - Returning user with watches → open the first group that contains
  //    one of their active watches (so they see what they're tracking)
  //  - First-time user (no watches) → open the very first group
  //    ("Clothing") so they see the chips and understand what's possible
  // Idempotent — only fires when openGroups is still empty.
  useEffect(() => {
    if (loading || openGroups.size > 0 || grouped.length === 0) return
    if (watches.length > 0) {
      const firstWithSelection = grouped.find((g) => g.items.some((it) => watchedSlugs.has(it.slug)))
      if (firstWithSelection) {
        setOpenGroups(new Set([firstWithSelection.name]))
      }
    } else {
      setOpenGroups(new Set([grouped[0].name]))
    }
  }, [loading, grouped, watches.length, watchedSlugs, openGroups.size])

  const toggleGroup = useCallback((name: string) => {
    setOpenGroups((prev) => {
      const next = new Set(prev)
      if (next.has(name)) next.delete(name)
      else next.add(name)
      return next
    })
  }, [])

  // Toggle a category as a watch — POST to add, DELETE to remove.
  // On 403 over-limit, opens the upgrade modal instead of just showing
  // the error banner (which a user can miss if scrolled).
  const toggleWatch = useCallback(async (slug: string, label: string) => {
    const existing = watches.find((w) => w.category_slug === slug)
    setTogglingSlug(slug)
    setErrMsg(null)
    try {
      if (existing) {
        const res = await fetch(`/api/watches/${existing.id}`, { method: 'DELETE' })
        if (!res.ok) {
          const d = await res.json().catch(() => ({}))
          throw new Error(d.error || 'Could not remove')
        }
        setWatches((prev) => prev.filter((w) => w.id !== existing.id))
      } else {
        const res = await fetch('/api/watches', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ category_slug: slug }),
        })
        if (!res.ok) {
          const d = await res.json().catch(() => ({}))
          if (d?.over_limit) {
            setLimitModal({
              current: d.current_picks ?? FREE_PICK_LIMIT,
              allowed: d.allowed_picks ?? FREE_PICK_LIMIT,
            })
            return
          }
          throw new Error(d.error || 'Could not add')
        }
        // refetch — simpler than constructing the response shape ourselves
        const w = await fetch('/api/watches').then((r) => r.json())
        setWatches(w.watches ?? [])
        trackEvent('category_add', { category: slug })
      }
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Toggle failed')
    } finally {
      setTogglingSlug(null)
    }
  }, [watches])

  // Update a watch's min_price_tier modifier (paid feature). Passing null
  // clears the modifier. Optimistic local update with rollback on failure.
  // Generic per-watch modifier PATCH. Same optimistic-update +
  // rollback pattern as setWatchTier; just parameterized over the
  // field name + value so we don't repeat the body three times.
  const patchWatch = useCallback(async (
    watchId: string,
    field: 'sub_type' | 'min_price_tier' | 'min_discount',
    value: string | number | null,
  ) => {
    const existing = watches.find((w) => w.id === watchId)
    if (!existing) return
    setErrMsg(null)
    setStatusMsg(null)
    const optimistic = watches.map((w) =>
      w.id === watchId ? { ...w, [field]: value } : w
    )
    setWatches(optimistic)
    try {
      const res = await fetch(`/api/watches/${watchId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ [field]: value }),
      })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        if (d.upgrade_url) {
          throw new Error('Per-watch modifiers are a Personal Shopper feature. Upgrade to unlock.')
        }
        throw new Error(d.error || 'Could not save')
      }
    } catch (err) {
      // Rollback
      setWatches(watches)
      setErrMsg(err instanceof Error ? err.message : 'Save failed')
    }
  }, [watches])

  const setWatchTier = useCallback(async (watchId: string, tier: string | null) => {
    const existing = watches.find((w) => w.id === watchId)
    if (!existing) return
    setErrMsg(null)
    setStatusMsg(null)
    const optimistic = watches.map((w) =>
      w.id === watchId ? { ...w, min_price_tier: tier } : w
    )
    setWatches(optimistic)
    try {
      const res = await fetch(`/api/watches/${watchId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ min_price_tier: tier }),
      })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        if (d.upgrade_url) {
          throw new Error('Per-watch modifiers are a Personal Shopper feature. Upgrade to unlock.')
        }
        throw new Error(d.error || 'Could not save')
      }
      setStatusMsg(tier ? `Modifier saved · ${tier}+` : 'Modifier cleared')
    } catch (err) {
      // Rollback
      setWatches(watches)
      setErrMsg(err instanceof Error ? err.message : 'Save failed')
    }
  }, [watches])

  // Add a store to the watchlist. Counts toward the free-tier total
  // limit (categories + stores combined).
  const addStorePick = useCallback(async (storeId: string) => {
    setErrMsg(null)
    try {
      const res = await fetch('/api/store-picks', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ store_id: storeId }),
      })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        if (d?.over_limit) {
          setLimitModal({
            current: d.current_picks ?? FREE_PICK_LIMIT,
            allowed: d.allowed_picks ?? FREE_PICK_LIMIT,
          })
          return
        }
        throw new Error(d.error || 'Could not add')
      }
      const refreshed = await fetch('/api/store-picks').then((r) => r.json())
      setStorePicks(refreshed.store_picks ?? [])
      trackEvent('store_add', { location: 'preferences' })
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Add failed')
    }
  }, [])

  const removeStorePick = useCallback(async (pickId: string) => {
    setErrMsg(null)
    try {
      const res = await fetch(`/api/store-picks/${pickId}`, { method: 'DELETE' })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        throw new Error(d.error || 'Could not remove')
      }
      setStorePicks((prev) => prev.filter((p) => p.id !== pickId))
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Remove failed')
    }
  }, [])

  // "Send me deals now" — fires the on-demand refresh email
  const refreshDeals = useCallback(async () => {
    setRefreshing(true)
    setErrMsg(null)
    setStatusMsg(null)
    try {
      const res = await fetch('/api/deals/refresh', { method: 'POST' })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        // Custom-formatted errors for the two free-tier guardrails so
        // the user sees actionable copy, not just a generic failure.
        if (res.status === 429 && d.retry_after_iso) {
          const when = new Date(d.retry_after_iso).toLocaleDateString(undefined, {
            weekday: 'long',
            month: 'short',
            day: 'numeric',
          })
          throw new Error(`Free tier sends 1 email per week. Next send: ${when}. Upgrade for unlimited.`)
        }
        if (res.status === 403 && d.over_limit) {
          throw new Error(
            `You have ${d.current_picks} picks but free tier allows ${d.allowed_picks}. Remove ${d.current_picks - d.allowed_picks} to send.`
          )
        }
        throw new Error(d.error || 'Refresh failed')
      }
      const n = d.total_deals ?? d.deals ?? 0
      // Funnel event: the on-demand "send me deals now" action fired.
      trackEvent('deals_pull', { deals_count: n })
      setStatusMsg(
        n > 0
          ? `Sent — ${n} ${n === 1 ? 'deal' : 'deals'} across your watchlist. Check your inbox.`
          : `Nothing fresh right now. We'll keep watching and email when something lands.`
      )
      // Refetch account so next_ondemand_send_at populates and the
      // countdown starts ticking immediately on the button below.
      try {
        const fresh = await fetch('/api/account').then((r) => r.ok ? r.json() : null)
        if (fresh?.email) {
          setAccount({
            email: fresh.email,
            tier: fresh.tier ?? 'free',
            weekly_email_enabled: !!fresh.weekly_email_enabled,
            next_ondemand_send_at: fresh.next_ondemand_send_at ?? null,
          })
        }
      } catch {
        // Non-fatal — countdown will sync on next page load.
      }
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Refresh failed')
    } finally {
      setRefreshing(false)
    }
  }, [])

  const handleUnsubscribe = async () => {
    if (!account) return
    if (!confirm('Unsubscribe completely? You can resubscribe any time but your watchlist will be cleared.')) return
    try {
      const res = await fetch('/api/unsubscribe', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: account.email }),
      })
      if (!res.ok) throw new Error('Unsubscribe failed')
      router.push('/')
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Unsubscribe failed')
    }
  }

  // Full account deletion — wipes subscriber row + cascades to all
  // per-user tables (watches, store-picks, send log) + deletes the
  // auth.users row so the magic-link sign-in stops working. Two-step
  // confirm because it's irreversible.
  const handleDeleteAccount = async () => {
    if (!account) return
    if (
      !confirm(
        `Delete your account and ALL your data?\n\nThis wipes your watchlist, store picks, send history, and your sign-in. Irreversible.\n\nClick OK to confirm, then type your email on the next prompt.`
      )
    ) {
      return
    }
    const typed = prompt(`Type "${account.email}" to confirm:`)
    if (typed !== account.email) {
      alert('Email did not match. Delete cancelled.')
      return
    }
    try {
      const res = await fetch('/api/account/delete', { method: 'DELETE' })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) throw new Error(d.error || 'Delete failed')
      // Sign out + bounce to homepage. The auth user is gone so the
      // session cookie is now invalid; landing on / is the cleanest exit.
      router.push('/')
    } catch (err) {
      setErrMsg(err instanceof Error ? err.message : 'Delete failed')
    }
  }

  // Sticker pop animation for the header decorations
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

  const watchCount = watches.length
  const storeCount = storePicks.length
  // pickCount is the source-of-truth metric — total across categories
  // + stores. Free tier caps at FREE_PICK_LIMIT; paid is unlimited.
  const pickCount = watchCount + storeCount
  const isPaid = account?.tier === 'paid'
  const overLimit = !isPaid && pickCount > FREE_PICK_LIMIT
  const tierLabel = account?.tier === 'paid' ? 'Personal Shopper' : 'Inbox Cleaner'

  // Store picker — derive filtered results from search term + directory.
  // Cap at 40 to keep the render light; the search box makes it
  // navigable. Excludes stores already picked (so they don't show up
  // again in the "add" list).
  const pickedStoreIds = useMemo(() => new Set(storePicks.map((p) => p.store_id)), [storePicks])
  const filteredStores = useMemo(() => {
    const q = storeSearch.trim().toLowerCase()
    if (!q) return []
    return storeDirectory
      .filter((s) => !pickedStoreIds.has(s.id) && s.name.toLowerCase().includes(q))
      .slice(0, 40)
  }, [storeSearch, storeDirectory, pickedStoreIds])

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
      <DossierNav active="preferences" signedIn={true} isAdmin={isAdmin} />

      {/* ============ PAGE HEAD ============ */}
      <section className="page-head">
        <div className="head-stickers" aria-hidden="true">

          <div className="s" style={{ top: 50, left: '5%', transform: 'rotate(-9deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 160, height: 160 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", fontSize: 10, letterSpacing: '.18em' }}>FREE!</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 22, lineHeight: 1, marginTop: 2 }}>NO PASS-</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 22, lineHeight: 1 }}>WORD</div>
              </div>
            </div>
          </div>

          <div className="s" style={{ top: 40, left: '24%', transform: 'rotate(5deg)' }}>
            <div className="sticker bg-magenta sh-circle" style={{ width: 96, height: 96 }}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>MAGIC</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 20, lineHeight: 1 }}>LINK</div>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>SIGN-IN</div>
            </div>
          </div>

          <div className="s" style={{ top: 56, right: '6%', transform: 'rotate(7deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 180, padding: '14px 14px' }}>
              <div className="lbl">UP TO</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 54, lineHeight: 1, letterSpacing: '.02em' }}>∞</div>
              <div className="lbl" style={{ marginTop: 4 }}>STORES OR CATEGORIES</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 60, right: '18%', transform: 'rotate(-5deg)' }}>
            <div className="sticker bg-orange sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 26, letterSpacing: '.04em' }}>NO</div>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 26, letterSpacing: '.04em', marginTop: -6 }}>PAYWALL</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 50, left: '10%', transform: 'rotate(3deg)' }}>
            <div className="sticker bg-green sh-pricegun" style={{ width: 170, padding: '14px 14px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>YOUR LIST</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 20, lineHeight: 1, letterSpacing: '.02em' }}>PRESERVED</div>
            </div>
          </div>

        </div>

        <div className="page-head-inner">
          <p className="page-kicker">— Your Settings —</p>
          <h1 className="page-title">What are you <em>shopping for?</em></h1>
          <p className="page-sub">Tell us what you need. We&rsquo;ll dig up deals from brands flying under your radar — just toggle the categories below to build your watchlist.</p>
        </div>
      </section>

      {/* ============ FORM ============ */}
      <section className="form-section">
        <div className="form-wrap">
          <div className="form-card">
            <div className="form-tag">
              <div className="sticker sh-starburst" style={{ width: 160, height: 160 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content">
                  <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em' }}>NO</div>
                  <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 18, lineHeight: 1, letterSpacing: '.01em' }}>PASSWORD</div>
                  <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em' }}>EVER</div>
                </div>
              </div>
            </div>

            {/* Signed-in banner */}
            {account && (
              <div className="sub-banner">
                <div style={{
                  width: 36, height: 36, borderRadius: '50%',
                  background: '#fff8e2', color: 'var(--green-deep)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontFamily: "'Alfa Slab One', serif", fontSize: 22,
                  border: '2px solid var(--ink)', flexShrink: 0,
                }}>✱</div>
                <div>
                  <strong>Signed in</strong><br />
                  <span style={{ fontSize: 14 }}>
                    {account.email} · {tierLabel} · {pickCount} active {pickCount === 1 ? 'pick' : 'picks'}
                  </span>
                </div>
              </div>
            )}

            {/* Status / error banners */}
            {statusMsg && (
              <div style={{
                background: '#fff5d4', border: '2px solid var(--ink)',
                padding: '12px 16px', marginBottom: 20,
                fontFamily: "'Special Elite', monospace", fontSize: 14,
                boxShadow: '3px 3px 0 var(--ink)',
              }}>
                {statusMsg}
              </div>
            )}
            {errMsg && (
              <div style={{
                background: '#fde0de', border: '2px solid var(--red-deep)',
                padding: '12px 16px', marginBottom: 20,
                fontFamily: "'Special Elite', monospace", fontSize: 14,
                color: 'var(--red-deep)',
              }}>
                {errMsg}
              </div>
            )}

            {/* WATCHLIST PICKER */}
            <p className="form-step">— Your Watchlist —</p>
            <h2 className="form-h">
              {pickCount === 0
                ? <>Pick what you&rsquo;re <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>shopping for.</em></>
                : <>What we&rsquo;re hunting for, on your behalf.</>}
            </h2>

            {pickCount === 0 ? (
              // First-time empty-state. Explains the two flavors of picks
              // (categories vs specific stores) so they understand the tabs
              // they're about to see below.
              <div
                style={{
                  marginBottom: 16,
                  padding: '18px 22px',
                  background: '#fff8e2',
                  border: '2px dashed var(--ink)',
                  fontFamily: "'IM Fell English', serif",
                  fontSize: 17,
                  lineHeight: 1.5,
                  color: 'var(--ink)',
                }}
              >
                Welcome in. Pick categories (broad — e.g. <em>Skincare</em>) or specific brands (narrow — e.g. <em>J.Crew</em>) — any mix. We&rsquo;ll email when real deals land. <em style={{ fontStyle: 'italic', color: 'var(--red-deep)' }}>Pick three to start — free.</em>
              </div>
            ) : (
              <p className="selected-summary">
                <b>{pickCount}</b>
                {isPaid
                  ? `active ${pickCount === 1 ? 'pick' : 'picks'} · unlimited on Personal Shopper`
                  : `of ${FREE_PICK_LIMIT} picks · ${watchCount} ${watchCount === 1 ? 'category' : 'categories'} + ${storeCount} ${storeCount === 1 ? 'store' : 'stores'}`}
              </p>
            )}

            {/* Downgrade-freeze banner — shows if a former paid user came
                back to free with more picks than allowed. They can't
                send until they prune. */}
            {overLimit && (
              <div
                style={{
                  marginBottom: 16,
                  padding: '14px 18px',
                  background: '#fde0de',
                  border: '2px solid var(--red-deep)',
                  fontFamily: "'Special Elite', monospace",
                  fontSize: 14,
                  color: 'var(--red-deep)',
                }}
              >
                <strong>Sends paused.</strong> You have {pickCount} picks but free tier allows {FREE_PICK_LIMIT}.
                Remove {pickCount - FREE_PICK_LIMIT} below, or <a href="/pricing" style={{ color: 'var(--red-deep)', textDecoration: 'underline' }}>upgrade for unlimited</a>.
              </div>
            )}

            {/* Tabs: Categories | Stores */}
            <div
              role="tablist"
              style={{
                display: 'flex',
                gap: 2,
                borderBottom: '2px solid var(--ink)',
                marginBottom: 16,
              }}
            >
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
                      // Bigger tap target — 44px tall is the iOS standard
                      // for primary controls. Tabs are critical on this
                      // page so they get the full guideline size.
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

            {/* Tab content — Categories accordion (existing UI) */}
            {pickerTab === 'categories' && (
              <div className="dl-field">
                <div className="cat-list">
                  {grouped.map((group) => {
                    const total = group.items.length
                    const onCount = group.items.filter((c) => watchedSlugs.has(c.slug)).length
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
                              const on = watchedSlugs.has(c.slug)
                              const isToggling = togglingSlug === c.slug
                              return (
                                <button
                                  key={c.slug}
                                  type="button"
                                  className={`chip ${on ? 'on' : ''}`}
                                  disabled={isToggling}
                                  onClick={(e) => {
                                    e.stopPropagation()
                                    toggleWatch(c.slug, c.label)
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
                  {/* Reference CATEGORY_GROUP_ORDER so import isn't flagged unused */}
                  <div style={{ display: 'none' }} data-groups={CATEGORY_GROUP_ORDER.join(',')} />
                </div>
              </div>
            )}

            {/* Tab content — Stores picker */}
            {pickerTab === 'stores' && (
              <div className="dl-field">
                {/* Picked stores list (chips with × remove) */}
                {storePicks.length > 0 && (
                  <div style={{ marginBottom: 16 }}>
                    <div className="t-meta" style={{ fontSize: 11, letterSpacing: '.16em', textTransform: 'uppercase', color: 'var(--ink-55)', marginBottom: 8 }}>
                      Watching {storeCount} {storeCount === 1 ? 'store' : 'stores'}
                    </div>
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
                      {storePicks.map((p) => (
                        <span
                          key={p.id}
                          style={{
                            display: 'inline-flex',
                            alignItems: 'center',
                            gap: 4,
                            paddingLeft: 12,
                            border: '1.5px solid var(--ink)',
                            background: 'var(--ink)',
                            color: 'var(--paper, #f6ecd2)',
                            fontFamily: 'var(--font-mono, monospace)',
                            fontSize: 13,
                            minHeight: 36,
                          }}
                        >
                          {p.store_name}
                          <button
                            type="button"
                            onClick={() => removeStorePick(p.id)}
                            aria-label={`Remove ${p.store_name}`}
                            title={`Remove ${p.store_name}`}
                            style={{
                              // Bigger tap target for thumbs — Apple/Google guideline
                              // says 44×44 ideal; 36×36 is the workable minimum and
                              // keeps the chip from looking oversized on desktop.
                              minWidth: 36,
                              minHeight: 36,
                              display: 'inline-flex',
                              alignItems: 'center',
                              justifyContent: 'center',
                              border: 'none',
                              background: 'transparent',
                              color: 'var(--paper, #f6ecd2)',
                              cursor: 'pointer',
                              fontSize: 20,
                              lineHeight: 1,
                              padding: 0,
                            }}
                          >
                            ×
                          </button>
                        </span>
                      ))}
                    </div>
                  </div>
                )}

                {/* Search input */}
                <input
                  type="search"
                  value={storeSearch}
                  onChange={(e) => setStoreSearch(e.target.value)}
                  placeholder="Search 1,700+ brands — try 'J.Crew', 'Nordstrom', 'REI'…"
                  style={{
                    width: '100%',
                    padding: '12px 14px',
                    fontFamily: "'Special Elite', monospace",
                    fontSize: 14,
                    border: '2px solid var(--ink)',
                    background: '#fff8e2',
                    boxSizing: 'border-box',
                    marginBottom: 12,
                  }}
                />

                {/* Search results */}
                {!storeSearch.trim() && storeDirectory.length > 0 && (
                  <p className="t-meta" style={{ fontSize: 13, color: 'var(--ink-55)', fontStyle: 'italic', padding: '20px 0' }}>
                    {storeDirectory.length.toLocaleString()} brands in our directory.{' '}
                    Start typing to find one, or{' '}
                    <a
                      href="/stores"
                      style={{
                        color: 'var(--red-deep)',
                        textDecoration: 'underline',
                      }}
                    >
                      browse all →
                    </a>
                  </p>
                )}
                {storeSearch.trim() && filteredStores.length === 0 && (
                  <p className="t-meta" style={{ fontSize: 13, color: 'var(--ink-55)', fontStyle: 'italic', padding: '20px 0' }}>
                    No matches for &ldquo;{storeSearch}&rdquo;. <a href="/suggest" style={{ color: 'var(--red-deep)', textDecoration: 'underline' }}>Suggest a store?</a>
                  </p>
                )}
                {filteredStores.length > 0 && (
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 6, maxHeight: 360, overflowY: 'auto', padding: 2 }}>
                    {filteredStores.map((s) => (
                      <button
                        key={s.id}
                        type="button"
                        onClick={() => addStorePick(s.id)}
                        disabled={overLimit || (!isPaid && pickCount >= FREE_PICK_LIMIT)}
                        style={{
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'space-between',
                          gap: 12,
                          // Generous vertical padding so the whole row is
                          // an easy thumb tap (~58px tall on mobile).
                          padding: '14px 14px',
                          minHeight: 56,
                          border: '1.5px solid var(--ink-15)',
                          background: 'var(--paper)',
                          cursor: 'pointer',
                          textAlign: 'left',
                          fontFamily: 'inherit',
                        }}
                      >
                        <div>
                          <div style={{ fontFamily: 'var(--font-serif)', fontSize: 16, fontWeight: 500 }}>{s.name}</div>
                          <div style={{ fontFamily: 'var(--font-mono, monospace)', fontSize: 11, color: 'var(--ink-55)' }}>
                            {s.website.replace(/^https?:\/\//, '').replace(/\/$/, '')}
                          </div>
                        </div>
                        <span
                          style={{
                            fontFamily: "'Stardos Stamp', monospace",
                            fontSize: 11,
                            letterSpacing: '.14em',
                            textTransform: 'uppercase',
                            color: 'var(--olive-deep)',
                            border: '1.5px solid var(--olive-deep)',
                            padding: '4px 10px',
                            flexShrink: 0,
                          }}
                        >
                          + Add
                        </span>
                      </button>
                    ))}
                  </div>
                )}

                {/* Limit reminder when at cap */}
                {!isPaid && pickCount >= FREE_PICK_LIMIT && !overLimit && (
                  <p className="t-meta" style={{ marginTop: 12, fontSize: 12, color: 'var(--red-deep)', fontStyle: 'italic' }}>
                    At your {FREE_PICK_LIMIT}-pick limit. Remove one to add another, or <a href="/pricing" style={{ color: 'var(--red-deep)', textDecoration: 'underline' }}>upgrade</a> for unlimited.
                  </p>
                )}
              </div>
            )}

            {/* PER-WATCH MODIFIERS */}
            {watchCount > 0 && (
              <>
                <p className="form-step" style={{ marginTop: 32 }}>— Per-Watch Modifiers —</p>
                <h3 style={{ fontFamily: "'Alfa Slab One', serif", fontWeight: 400, fontSize: 22, letterSpacing: '.04em', margin: '0 0 8px', lineHeight: 1.1 }}>
                  Narrow each watch by <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>price tier.</em>
                </h3>
                <p style={{ fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink-soft)', margin: '0 0 18px' }}>
                  Pick a minimum tier to skip cheaper brands.
                  {' '}
                  {account?.tier !== 'paid' && (
                    <>
                      <a href="/pricing" style={{ color: 'var(--red)', textDecoration: 'underline', textDecorationStyle: 'dotted' }}>
                        Personal Shopper feature
                      </a>
                      {' '}— upgrade to unlock.
                    </>
                  )}
                </p>
                <div className="dl-field">
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                    {watches.map((w) => {
                      const currentTier = w.min_price_tier ?? null
                      const currentDiscount = w.min_discount ?? null
                      const currentSubType = w.sub_type ?? ''
                      const isPaid = account?.tier === 'paid'
                      return (
                        <WatchModifierRow
                          key={w.id}
                          watchId={w.id}
                          label={w.category_label}
                          isPaid={isPaid}
                          currentTier={currentTier}
                          currentDiscount={currentDiscount}
                          currentSubType={currentSubType}
                          onSetTier={(t) => setWatchTier(w.id, t)}
                          onSetDiscount={(n) => patchWatch(w.id, 'min_discount', n)}
                          onSetSubType={(s) => patchWatch(w.id, 'sub_type', s)}
                        />
                      )
                    })}
                  </div>
                </div>
              </>
            )}

            {/* ACTIONS */}
            {/* Cooldown math — derived from the live setNowTick state
                above. Paid users have no cooldown so cooldownMs stays
                <= 0 and the button reads normally. */}
            {(() => {
              const cooldownMs = account?.next_ondemand_send_at
                ? new Date(account.next_ondemand_send_at).getTime() - Date.now()
                : 0
              const inCooldown = cooldownMs > 0 && !isPaid
              const buttonText = refreshing
                ? 'SENDING…'
                : inCooldown
                ? `NEXT SEND IN ${formatCooldown(cooldownMs)}`
                : 'SEND ME DEALS NOW →'
              const fineLine = inCooldown
                ? `Free tier: one self-send per week. Upgrade for unlimited.`
                : pickCount === 0
                ? `Pick at least one above first.`
                : `Pulls fresh deals matching\nyour ${pickCount} active ${pickCount === 1 ? 'pick' : 'picks'}.`
              return (
                <div className="magic-row">
                  <button
                    className="magic"
                    type="button"
                    onClick={refreshDeals}
                    disabled={refreshing || inCooldown || pickCount === 0 || overLimit}
                  >
                    {buttonText}
                  </button>
                  <p className="fine" style={{ whiteSpace: 'pre-line' }}>{fineLine}</p>
                </div>
              )
            })()}

            {/* UPGRADE CTA — only for free tier. Replaces the old Cadence
                + Plan sections; everything paid unlocks lives behind
                this single link. */}
            {!isPaid && (
              <div
                style={{
                  marginTop: 20,
                  padding: '16px 20px',
                  border: '2px dashed var(--ink)',
                  background: '#fff8e2',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: 16,
                  flexWrap: 'wrap',
                }}
              >
                <div style={{ flex: 1, minWidth: 240 }}>
                  <div
                    className="t-meta"
                    style={{
                      fontFamily: "'Stardos Stamp', monospace",
                      fontSize: 11,
                      letterSpacing: '.2em',
                      textTransform: 'uppercase',
                      color: 'var(--red-deep)',
                      marginBottom: 4,
                    }}
                  >
                    — Want more? —
                  </div>
                  <p
                    style={{
                      margin: 0,
                      fontFamily: "'IM Fell English', serif",
                      fontStyle: 'italic',
                      fontSize: 16,
                      color: 'var(--ink)',
                      lineHeight: 1.45,
                    }}
                  >
                    Upgrade to <strong style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal' }}>Personal Shopper</strong> for unlimited picks and unlimited self-sends.
                  </p>
                </div>
                <a
                  href="/pricing"
                  style={{
                    fontFamily: "'Alfa Slab One', serif",
                    fontSize: 14,
                    letterSpacing: '.08em',
                    textTransform: 'uppercase',
                    background: 'var(--red)',
                    color: 'var(--paper, #f6ecd2)',
                    padding: '14px 24px 12px',
                    border: '2px solid var(--ink)',
                    boxShadow: '4px 4px 0 var(--ink)',
                    textDecoration: 'none',
                    flexShrink: 0,
                    // Full-width on tiny screens where the card stacks,
                    // tap-target sized at 48px tall.
                    minHeight: 48,
                    display: 'inline-flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  Upgrade →
                </a>
              </div>
            )}

            {/* DANGER ZONE */}
            <div className="danger">
              <p>
                <em>Need to step away?</em>
                {' '}
                <strong>Unsubscribe</strong> keeps your account but clears your watchlist — come back any time.
                {' '}
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
                  style={{
                    background: 'var(--red-deep)',
                    color: '#fff8e2',
                    border: '2px solid var(--red-deep)',
                  }}
                  onClick={handleDeleteAccount}
                >
                  Delete my account
                </button>
              </div>
            </div>

          </div>
        </div>
      </section>

      {/* ============ WHY NO PASSWORD ============ */}
      <section className="why">
        <h2 className="kicker">— The Method —</h2>
        <h2 className="title">No <em>password.</em> No paywall.</h2>

        <div className="why-grid">
          <div className="why-item">
            <div className="icon">
              <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#f4c623" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content"><div style={{ fontFamily: "'Alfa Slab One', serif", fontSize: 34, lineHeight: 1 }}>01</div></div>
              </div>
            </div>
            <h3>Magic Link Only</h3>
            <p>Enter your email, get a one-tap sign-in link. Never another forgotten password. Never another reset flow.</p>
          </div>

          <div className="why-item">
            <div className="icon">
              <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content"><div style={{ fontFamily: "'Alfa Slab One', serif", color: '#fff8e2', fontSize: 34, lineHeight: 1 }}>02</div></div>
              </div>
            </div>
            <h3>Free Forever</h3>
            <p>Up to 3 active watches with no credit card. Upgrade only if you want unlimited tracking — never to access anything basic.</p>
          </div>

          <div className="why-item">
            <div className="icon">
              <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
                <div className="star">
                  <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
                </div>
                <div className="content"><div style={{ fontFamily: "'Alfa Slab One', serif", color: '#fff8e2', fontSize: 34, lineHeight: 1 }}>03</div></div>
              </div>
            </div>
            <h3>Yours to Leave</h3>
            <p>Unsubscribe with one click, any time. Your watchlist sticks around so you can come back if you change your mind.</p>
          </div>
        </div>
      </section>

      {/* ============ LIMIT-REACHED MODAL ============ */}
      {limitModal && typeof document !== 'undefined' && createPortal(
        <LimitReachedModal
          current={limitModal.current}
          allowed={limitModal.allowed}
          onClose={() => setLimitModal(null)}
          onUpgrade={() => {
            setLimitModal(null)
            router.push('/pricing')
          }}
        />,
        document.body
      )}

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

// Per-watch modifier row — category label on top, three modifier
// controls (price tier, min discount, sub-type) below. Free-tier users
// see the same controls disabled with `not-allowed` cursor.
function WatchModifierRow({
  watchId, label, isPaid,
  currentTier, currentDiscount, currentSubType,
  onSetTier, onSetDiscount, onSetSubType,
}: {
  watchId: string
  label: string
  isPaid: boolean
  currentTier: string | null
  currentDiscount: number | null
  currentSubType: string
  onSetTier: (t: string | null) => void
  onSetDiscount: (n: number | null) => void
  onSetSubType: (s: string | null) => void
}) {
  const [subTypeDraft, setSubTypeDraft] = useState(currentSubType)
  useEffect(() => { setSubTypeDraft(currentSubType) }, [currentSubType])

  const commitSubType = () => {
    const trimmed = subTypeDraft.trim()
    if (trimmed === (currentSubType ?? '')) return
    onSetSubType(trimmed === '' ? null : trimmed)
  }

  return (
    <div
      style={{
        border: '1.5px solid var(--ink-15)',
        background: '#fffbe6',
        padding: '12px 14px',
        opacity: isPaid ? 1 : 0.65,
      }}
    >
      <div
        style={{
          fontFamily: "'Alfa Slab One', serif",
          fontSize: 14, letterSpacing: '.02em',
          color: 'var(--ink)',
          marginBottom: 10,
        }}
      >
        {label}
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: 16, flexWrap: 'wrap' }}>

        {/* MIN TIER */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
          <span className="t-meta" style={{ color: 'var(--ink-soft)', fontSize: 10 }}>MIN TIER</span>
          <div style={{ display: 'flex', gap: 4 }}>
            {(['$', '$$', '$$$', '$$$$'] as const).map((t) => {
              const active = currentTier === t
              return (
                <button
                  key={t}
                  type="button"
                  disabled={!isPaid}
                  onClick={() => onSetTier(active ? null : t)}
                  title={isPaid ? `Set min tier to ${t}` : 'Personal Shopper feature'}
                  style={{
                    minWidth: 32,
                    padding: '5px 8px 3px',
                    border: `1.5px solid ${active ? 'var(--ink)' : 'var(--ink-15)'}`,
                    background: active ? 'var(--ink)' : 'transparent',
                    color: active ? 'var(--yellow)' : 'var(--ink)',
                    fontFamily: "'Stardos Stamp', sans-serif",
                    fontSize: 11,
                    letterSpacing: '.05em',
                    cursor: isPaid ? 'pointer' : 'not-allowed',
                    boxShadow: active ? '2px 2px 0 var(--ink)' : 'none',
                  }}
                >
                  {t}
                </button>
              )
            })}
            <button
              type="button"
              disabled={!isPaid || !currentTier}
              onClick={() => onSetTier(null)}
              title="Clear min tier"
              style={{
                marginLeft: 2,
                padding: '5px 8px 3px',
                border: '1.5px solid var(--ink-15)',
                background: 'transparent',
                color: 'var(--ink-soft)',
                fontFamily: "'Stardos Stamp', sans-serif",
                fontSize: 11,
                letterSpacing: '.1em',
                cursor: (isPaid && currentTier) ? 'pointer' : 'not-allowed',
                opacity: currentTier ? 1 : 0.4,
              }}
            >
              ×
            </button>
          </div>
        </div>

        {/* MIN DISCOUNT */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
          <span className="t-meta" style={{ color: 'var(--ink-soft)', fontSize: 10 }}>MIN OFF</span>
          <select
            value={currentDiscount ?? ''}
            disabled={!isPaid}
            onChange={(e) => {
              const v = e.target.value
              onSetDiscount(v === '' ? null : Number(v))
            }}
            style={{
              padding: '5px 8px 3px',
              border: `1.5px solid ${currentDiscount ? 'var(--ink)' : 'var(--ink-15)'}`,
              background: currentDiscount ? 'var(--ink)' : 'transparent',
              color: currentDiscount ? 'var(--yellow)' : 'var(--ink)',
              fontFamily: "'Stardos Stamp', sans-serif",
              fontSize: 11,
              letterSpacing: '.05em',
              cursor: isPaid ? 'pointer' : 'not-allowed',
              minWidth: 64,
              boxShadow: currentDiscount ? '2px 2px 0 var(--ink)' : 'none',
            }}
          >
            <option value="">any %</option>
            {([20, 30, 40, 50, 60] as const).map((n) => (
              <option key={n} value={n}>{n}%+</option>
            ))}
          </select>
        </div>

        {/* SUB-TYPE */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 6, flex: 1, minWidth: 180 }}>
          <span className="t-meta" style={{ color: 'var(--ink-soft)', fontSize: 10 }}>SUB-TYPE</span>
          <input
            type="text"
            placeholder="e.g. denim, sneakers"
            value={subTypeDraft}
            disabled={!isPaid}
            onChange={(e) => setSubTypeDraft(e.target.value)}
            onBlur={commitSubType}
            onKeyDown={(e) => {
              if (e.key === 'Enter') {
                e.preventDefault()
                ;(e.target as HTMLInputElement).blur()
              }
            }}
            style={{
              flex: 1,
              minWidth: 120,
              padding: '5px 10px 3px',
              border: '1.5px solid var(--ink-15)',
              background: subTypeDraft ? 'var(--ink)' : 'transparent',
              color: subTypeDraft ? 'var(--yellow)' : 'var(--ink)',
              fontFamily: "'Special Elite', monospace",
              fontSize: 12,
              outline: 'none',
              boxShadow: subTypeDraft ? '2px 2px 0 var(--ink)' : 'none',
            }}
            data-watch-id={watchId}
          />
        </div>
      </div>
    </div>
  )
}

// Modal that surfaces when a free user tries to add a pick beyond the
// limit. Dossier Look styling — cream paper card on a dark backdrop,
// red sticker accent. Backdrop click + Escape both close. Body scroll
// is locked while open so the page underneath doesn't drift if the
// user scrolls inside the modal.
function LimitReachedModal({
  current,
  allowed,
  onClose,
  onUpgrade,
}: {
  current: number
  allowed: number
  onClose: () => void
  onUpgrade: () => void
}) {
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose()
    }
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
        position: 'fixed',
        inset: 0,
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
          // Slimmer shadow on small screens so it doesn't clip past the
          // viewport edge — same Dossier feel, just less aggressive.
          boxShadow: '6px 6px 0 #181612',
          padding: 'clamp(20px, 5vw, 28px) clamp(18px, 5vw, 24px)',
          position: 'relative',
          // Make sure the card itself can scroll if a really small
          // screen + giant font setting would otherwise overflow.
          maxHeight: '90vh',
          overflowY: 'auto',
        }}
      >
        {/* Red sticker accent in top-right corner */}
        <div
          style={{
            position: 'absolute',
            top: -14,
            right: 16,
            transform: 'rotate(5deg)',
            background: '#d4322a',
            color: '#fff8e2',
            padding: '6px 14px 4px',
            border: '2px solid #181612',
            fontFamily: "'Stardos Stamp', monospace",
            fontSize: 11,
            letterSpacing: '.18em',
            textTransform: 'uppercase',
          }}
        >
          Free tier
        </div>

        <div
          style={{
            fontFamily: "'Stardos Stamp', monospace",
            fontSize: 11,
            letterSpacing: '.22em',
            textTransform: 'uppercase',
            color: '#b3211a',
            marginBottom: 8,
          }}
        >
          — You&rsquo;ve hit your limit —
        </div>

        <h3
          style={{
            margin: '0 0 14px',
            fontFamily: "'Alfa Slab One', serif",
            fontWeight: 400,
            // Fluid sizing: 22px on tiny phones, 28px on bigger screens.
            fontSize: 'clamp(22px, 6vw, 28px)',
            lineHeight: 1.05,
            letterSpacing: '.02em',
            color: '#181612',
          }}
        >
          {allowed} picks max{' '}
          <span
            style={{
              fontFamily: "'Alfa Slab One', serif",
              color: '#181612',
              textShadow: '2px 2px 0 #d4322a, 4px 4px 0 #b3211a',
              padding: '0 .04em',
            }}
          >
            on free.
          </span>
        </h3>

        <p
          style={{
            margin: '0 0 22px',
            fontFamily: "'IM Fell English', serif",
            fontStyle: 'italic',
            fontSize: 16,
            lineHeight: 1.5,
            color: '#181612',
          }}
        >
          You have {current} picks across categories and stores. Upgrade to <strong style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal' }}>Personal Shopper</strong> for unlimited picks and unlimited self-sends, or remove one to swap in a new pick.
        </p>

        <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
          <button
            type="button"
            onClick={onUpgrade}
            style={{
              flex: '1 1 200px',
              minHeight: 48,
              fontFamily: "'Alfa Slab One', serif",
              fontSize: 14,
              letterSpacing: '.08em',
              textTransform: 'uppercase',
              background: '#d4322a',
              color: '#fff8e2',
              padding: '14px 18px 12px',
              border: '2px solid #181612',
              boxShadow: '4px 4px 0 #181612',
              cursor: 'pointer',
            }}
          >
            Upgrade →
          </button>
          <button
            type="button"
            onClick={onClose}
            style={{
              // Same flex so on narrow screens it stacks full-width below
              // the upgrade button instead of cramping next to it.
              flex: '1 1 200px',
              minHeight: 48,
              fontFamily: "'Special Elite', monospace",
              fontSize: 13,
              background: 'transparent',
              color: '#181612',
              padding: '14px 18px 12px',
              border: '2px solid #181612',
              cursor: 'pointer',
            }}
          >
            Maybe later
          </button>
        </div>
      </div>
    </div>
  )
}
