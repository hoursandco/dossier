'use client'

// Admin subscriptions table.
//
// One row per subscriber. Each row has a single "Edit" button that
// opens a portal-anchored popover with context-aware actions:
//   - Comp / Uncomp        (always available; pure DB)
//   - Cancel / Reactivate  (only with a stripe_subscription_id)
//   - Refund last invoice  (only with a stripe_customer_id)
//   - Delete subscriber    (always available; destructive)
//
// Portal placement (not inline) keeps the menu above the admin-table
// grid's stacking context — same pattern as SuggestionActions.

import { useEffect, useRef, useState, useCallback } from 'react'
import { createPortal } from 'react-dom'

type SubscriberRow = {
  id: string
  email: string
  tier: string | null
  is_comped: boolean | null
  comped_at: string | null
  comped_reason: string | null
  stripe_customer_id: string | null
  stripe_subscription_id: string | null
  subscription_status: string | null
  created_at: string
  stripe: {
    status: string | null
    current_period_end: string | null
    cancel_at_period_end: boolean | null
    amount: number | null
    currency: string | null
    interval: string | null
  }
}

function formatMoney(cents: number | null, currency: string | null): string {
  if (cents == null) return '—'
  const cur = (currency ?? 'usd').toUpperCase()
  return `$${(cents / 100).toFixed(2)} ${cur}`
}

function formatDate(iso: string | null): string {
  if (!iso) return '—'
  try {
    return new Date(iso).toLocaleDateString(undefined, {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
    })
  } catch {
    return '—'
  }
}

function StatusBadge({ s }: { s: SubscriberRow }) {
  if (s.is_comped) {
    return (
      <span
        className="t-meta"
        style={{
          background: 'var(--olive-deep)',
          color: 'var(--bone)',
          padding: '2px 8px',
          borderRadius: 3,
          fontSize: 11,
          letterSpacing: '.08em',
          textTransform: 'uppercase',
        }}
      >
        Comped
      </span>
    )
  }
  const status = s.stripe.status ?? (s.tier === 'paid' ? 'paid' : 'free')
  const palette: Record<string, { bg: string; fg: string }> = {
    active: { bg: 'var(--olive-deep)', fg: 'var(--bone)' },
    trialing: { bg: 'var(--olive-deep)', fg: 'var(--bone)' },
    past_due: { bg: 'var(--red, #d4322a)', fg: 'var(--bone)' },
    canceled: { bg: 'var(--ink-40)', fg: 'var(--bone)' },
    incomplete: { bg: 'var(--ink-55)', fg: 'var(--bone)' },
    incomplete_expired: { bg: 'var(--ink-55)', fg: 'var(--bone)' },
    unpaid: { bg: 'var(--red, #d4322a)', fg: 'var(--bone)' },
    paused: { bg: 'var(--ink-55)', fg: 'var(--bone)' },
    lookup_failed: { bg: 'var(--red, #d4322a)', fg: 'var(--bone)' },
    paid: { bg: 'var(--olive-deep)', fg: 'var(--bone)' },
    free: { bg: 'var(--ink-25, #cbc4ad)', fg: 'var(--ink, #181612)' },
  }
  const p = palette[status] ?? palette.free
  return (
    <span
      className="t-meta"
      style={{
        background: p.bg,
        color: p.fg,
        padding: '2px 8px',
        borderRadius: 3,
        fontSize: 11,
        letterSpacing: '.08em',
        textTransform: 'uppercase',
      }}
    >
      {status.replace(/_/g, ' ')}
    </span>
  )
}

const PAGE_SIZE = 5

export function SubscriptionsPanel() {
  const [rows, setRows] = useState<SubscriberRow[] | null>(null)
  const [total, setTotal] = useState(0)
  const [err, setErr] = useState<string | null>(null)
  const [search, setSearch] = useState('')
  const [debouncedSearch, setDebouncedSearch] = useState('')
  const [offset, setOffset] = useState(0)
  const [emailsPaused, setEmailsPaused] = useState<boolean | null>(null)
  const [pauseBusy, setPauseBusy] = useState(false)

  // Debounce the search input so we don't fire a request per keystroke.
  // 250ms is short enough to feel instant but long enough to coalesce
  // a typed phrase into one request.
  useEffect(() => {
    const t = setTimeout(() => setDebouncedSearch(search.trim()), 250)
    return () => clearTimeout(t)
  }, [search])

  // Reset to first page whenever the search term changes — searching
  // shouldn't land you on "page 4 of results" because the previous
  // result set had 4 pages.
  useEffect(() => {
    setOffset(0)
  }, [debouncedSearch])

  const load = useCallback(async () => {
    setErr(null)
    try {
      const params = new URLSearchParams({
        limit: String(PAGE_SIZE),
        offset: String(offset),
      })
      if (debouncedSearch) params.set('q', debouncedSearch)
      const res = await fetch(`/api/admin/subscriptions?${params.toString()}`, { cache: 'no-store' })
      const d = await res.json()
      if (!res.ok) {
        setErr(d.error ?? 'Failed to load')
        return
      }
      setRows(d.subscribers ?? [])
      setTotal(d.total ?? 0)
    } catch {
      setErr('Network error')
    }
  }, [debouncedSearch, offset])

  useEffect(() => {
    void load()
  }, [load])

  const loadPauseState = useCallback(async () => {
    try {
      const res = await fetch('/api/admin/subscribers/pause-emails', { cache: 'no-store' })
      if (!res.ok) return
      const d = await res.json()
      setEmailsPaused(d.paused ?? false)
    } catch {
      // non-fatal
    }
  }, [])

  useEffect(() => {
    void loadPauseState()
  }, [loadPauseState])

  const togglePause = async () => {
    const next = !emailsPaused
    const confirmed = next
      ? confirm('Pause all outbound emails for every active subscriber?')
      : confirm('Resume emails for all active subscribers?')
    if (!confirmed) return
    setPauseBusy(true)
    try {
      const res = await fetch('/api/admin/subscribers/pause-emails', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ paused: next }),
      })
      if (res.ok) setEmailsPaused(next)
      else alert('Action failed — check console')
    } finally {
      setPauseBusy(false)
    }
  }

  const cols = '2fr 0.9fr 1fr 1fr 0.6fr'
  const page = Math.floor(offset / PAGE_SIZE) + 1
  const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE))
  const from = total === 0 ? 0 : offset + 1
  const to = Math.min(offset + PAGE_SIZE, total)

  return (
    <div>
      {/* ── Search bar ─────────────────────────────────────────────── */}
      <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 14 }}>
        <input
          type="search"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search by email…"
          style={{
            flex: 1,
            maxWidth: 320,
            fontFamily: 'var(--font-mono, monospace)',
            fontSize: 13,
            padding: '8px 12px',
            border: '1.5px solid var(--ink, #181612)',
            background: 'var(--paper, #fcf8ed)',
            color: 'var(--ink, #181612)',
            height: 36,
            boxSizing: 'border-box',
          }}
        />
        {search && (
          <button
            type="button"
            className="admin-link-btn"
            onClick={() => setSearch('')}
          >
            Clear
          </button>
        )}
        <div style={{ flex: 1 }} />
        {emailsPaused !== null && (
          <button
            type="button"
            className="admin-link-btn"
            disabled={pauseBusy}
            onClick={togglePause}
            style={{
              color: emailsPaused ? 'var(--olive-deep)' : 'var(--red, #d4322a)',
              fontWeight: 600,
            }}
          >
            {pauseBusy ? '…' : emailsPaused ? 'Resume all emails' : 'Pause all emails'}
          </button>
        )}
        <span className="t-meta" style={{ fontSize: 12, color: 'var(--ink-40)' }}>
          {total === 0
            ? debouncedSearch
              ? `No matches for "${debouncedSearch}"`
              : 'No subscribers'
            : `${from}–${to} of ${total}`}
        </span>
      </div>

      {/* ── Table ─────────────────────────────────────────────────── */}
      {err && (
        <p className="t-meta" style={{ color: 'var(--red, #d4322a)' }}>Error: {err}</p>
      )}
      {rows === null && !err && <p className="t-meta">Loading subscribers…</p>}
      {rows && rows.length > 0 && (
        <div className="admin-table">
          <div className="admin-table-head" style={{ gridTemplateColumns: cols }}>
            <div>Email</div>
            <div>Status</div>
            <div>Plan</div>
            <div>Next bill</div>
            <div style={{ textAlign: 'right' }}>Actions</div>
          </div>
          {rows.map((s) => {
            const hasStripe = !!s.stripe_subscription_id
            const cancelPending = s.stripe.cancel_at_period_end === true
            return (
              <div key={s.id} className="admin-table-row" style={{ gridTemplateColumns: cols }}>
                <div>
                  <div style={{ fontFamily: 'var(--font-mono)', fontSize: 13 }}>{s.email}</div>
                  {s.is_comped && s.comped_reason && (
                    <div className="t-meta" style={{ color: 'var(--ink-40)', fontSize: 11, marginTop: 2 }}>
                      Comp: {s.comped_reason}
                    </div>
                  )}
                </div>
                <div><StatusBadge s={s} /></div>
                <div className="t-meta" style={{ fontSize: 12 }}>
                  {hasStripe
                    ? `${formatMoney(s.stripe.amount, s.stripe.currency)} / ${s.stripe.interval ?? '?'}`
                    : '—'}
                </div>
                <div className="t-meta" style={{ fontSize: 12 }}>
                  {cancelPending ? (
                    <span style={{ color: 'var(--red, #d4322a)' }}>
                      Cancels {formatDate(s.stripe.current_period_end)}
                    </span>
                  ) : (
                    formatDate(s.stripe.current_period_end)
                  )}
                </div>
                <div style={{ textAlign: 'right' }}>
                  <SubscriberEditMenu subscriber={s} hasStripe={hasStripe} cancelPending={cancelPending} onChange={load} />
                </div>
              </div>
            )
          })}
        </div>
      )}

      {/* ── Pagination ────────────────────────────────────────────── */}
      {totalPages > 1 && (
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginTop: 14, justifyContent: 'flex-end' }}>
          <button
            type="button"
            className="admin-link-btn"
            disabled={offset === 0}
            onClick={() => setOffset(Math.max(0, offset - PAGE_SIZE))}
          >
            ← Prev
          </button>
          <span className="t-meta" style={{ fontSize: 12, color: 'var(--ink-40)' }}>
            Page {page} of {totalPages}
          </span>
          <button
            type="button"
            className="admin-link-btn"
            disabled={offset + PAGE_SIZE >= total}
            onClick={() => setOffset(offset + PAGE_SIZE)}
          >
            Next →
          </button>
        </div>
      )}
    </div>
  )
}

// Per-row Edit button + portal popover menu. Anchored to the trigger's
// bounding rect, captured at open time so it follows the button after
// layout shifts. Closes on outside click OR after any action fires.
function SubscriberEditMenu({
  subscriber,
  hasStripe,
  cancelPending,
  onChange,
}: {
  subscriber: SubscriberRow
  hasStripe: boolean
  cancelPending: boolean
  onChange: () => Promise<void> | void
}) {
  const [open, setOpen] = useState(false)
  const [rect, setRect] = useState<DOMRect | null>(null)
  const [busy, setBusy] = useState(false)
  const buttonRef = useRef<HTMLButtonElement>(null)
  const popoverRef = useRef<HTMLDivElement>(null)
  const wrapperRef = useRef<HTMLDivElement>(null)

  // Close on outside click — check both the wrapper AND the portaled
  // popover, since the popover isn't a DOM child of the wrapper.
  useEffect(() => {
    if (!open) return
    const onDoc = (e: MouseEvent) => {
      const t = e.target as Node
      if (wrapperRef.current?.contains(t)) return
      if (popoverRef.current?.contains(t)) return
      setOpen(false)
    }
    document.addEventListener('mousedown', onDoc)
    return () => document.removeEventListener('mousedown', onDoc)
  }, [open])

  const handleToggle = () => {
    if (!open && buttonRef.current) {
      setRect(buttonRef.current.getBoundingClientRect())
    }
    setOpen((o) => !o)
  }

  // Runs an action, awaits it, then refreshes the list and closes the menu.
  const run = useCallback(
    async (fn: () => Promise<void>) => {
      setBusy(true)
      try {
        await fn()
        await onChange()
        setOpen(false)
      } finally {
        setBusy(false)
      }
    },
    [onChange]
  )

  const comp = () =>
    run(async () => {
      const reason = prompt(`Comp ${subscriber.email}? Optional note (e.g. "beta tester"):`)
      if (reason === null) throw new Error('cancelled')
      const res = await fetch(`/api/admin/subscriptions/${subscriber.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'comp', ...(reason ? { reason } : {}) }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) alert(d.error ?? 'Comp failed')
    }).catch(() => undefined)

  const uncomp = () =>
    run(async () => {
      if (!confirm(`Remove comp for ${subscriber.email}? They lose paid features unless they have a real Stripe subscription.`)) {
        throw new Error('cancelled')
      }
      const res = await fetch(`/api/admin/subscriptions/${subscriber.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'uncomp' }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) alert(d.error ?? 'Uncomp failed')
    }).catch(() => undefined)

  const cancel = () =>
    run(async () => {
      if (!confirm(`Cancel ${subscriber.email}'s Stripe subscription at period end?\n\nThey keep paid access until the current period ends.`)) {
        throw new Error('cancelled')
      }
      const res = await fetch(`/api/admin/subscriptions/${subscriber.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'cancel' }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) alert(d.error ?? 'Cancel failed')
    }).catch(() => undefined)

  const reactivate = () =>
    run(async () => {
      if (!confirm(`Reactivate ${subscriber.email}? Future billing will resume.`)) {
        throw new Error('cancelled')
      }
      const res = await fetch(`/api/admin/subscriptions/${subscriber.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'reactivate' }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) alert(d.error ?? 'Reactivate failed')
    }).catch(() => undefined)

  const refund = () =>
    run(async () => {
      if (
        !confirm(
          `Refund the most recent paid invoice for ${subscriber.email}?\n\nThis processes a FULL refund through Stripe. Does NOT cancel the subscription — do that separately.`
        )
      ) {
        throw new Error('cancelled')
      }
      const res = await fetch(`/api/admin/subscriptions/${subscriber.id}/refund`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reason: 'requested_by_customer' }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        alert(d.error ?? 'Refund failed')
        return
      }
      alert(
        `Refund successful.\n\n$${((d.amount_refunded ?? 0) / 100).toFixed(2)} ${(d.currency ?? 'usd').toUpperCase()} returned (status: ${d.status}).`
      )
    }).catch(() => undefined)

  const isPaidBillingState =
    subscriber.tier === 'paid' ||
    ['active', 'trialing', 'past_due'].includes(subscriber.subscription_status ?? '')

  const remove = () =>
    run(async () => {
      if (isPaidBillingState) {
        alert('Paid subscribers cannot be deleted here. Cancel the subscription and issue any refund first, then delete after billing is no longer active.')
        throw new Error('cancelled')
      }
      // Two-step confirm — typed match guards against finger-slip.
      if (
        !confirm(
          `DELETE ${subscriber.email}?\n\nThis wipes the subscriber row, all watches/send-log/preferences, AND the auth user. Irreversible.\n\n` +
            `Click OK to confirm, then type the email on the next prompt.`
        )
      ) {
        throw new Error('cancelled')
      }
      const typed = prompt(`Type "${subscriber.email}" to confirm:`)
      if (typed !== subscriber.email) {
        alert('Email did not match. Delete cancelled.')
        throw new Error('cancelled')
      }
      const res = await fetch(`/api/admin/subscriptions/${subscriber.id}`, {
        method: 'DELETE',
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        alert(d.error ?? 'Delete failed')
        return
      }
    }).catch(() => undefined)

  const popover =
    open && rect && typeof document !== 'undefined'
      ? createPortal(
          <div
            ref={popoverRef}
            className="admin-popover"
            style={{
              position: 'fixed',
              top: rect.bottom + 6,
              right: Math.max(8, window.innerWidth - rect.right),
              zIndex: 1000,
              minWidth: 180,
              background: 'var(--paper, #fcf8ed)',
              border: '2px solid var(--ink, #181612)',
              boxShadow: '4px 4px 0 var(--ink, #181612)',
              padding: 6,
            }}
          >
            <MenuItem
              label={subscriber.is_comped ? 'Uncomp' : 'Comp'}
              hint={subscriber.is_comped ? 'Remove comped access' : 'Give paid-tier access (free)'}
              disabled={busy}
              onClick={subscriber.is_comped ? uncomp : comp}
            />
            {hasStripe && !cancelPending && (
              <MenuItem
                label="Cancel subscription"
                hint="At period end — they keep access until then"
                disabled={busy}
                onClick={cancel}
              />
            )}
            {hasStripe && cancelPending && (
              <MenuItem
                label="Reactivate"
                hint="Undo pending cancellation"
                disabled={busy}
                onClick={reactivate}
              />
            )}
            {subscriber.stripe_customer_id && (
              <MenuItem
                label="Refund last invoice"
                hint="Full refund via Stripe — does NOT cancel"
                disabled={busy}
                color="var(--red, #d4322a)"
                onClick={refund}
              />
            )}
            <div style={{ borderTop: '1px dashed var(--ink-25, #cbc4ad)', margin: '6px 0' }} />
            <MenuItem
              label="Delete subscriber"
              hint={isPaidBillingState ? 'Cancel/refund paid subscriber first' : 'Irreversible — wipes account + auth user'}
              disabled={busy || isPaidBillingState}
              color="var(--red, #d4322a)"
              onClick={remove}
            />
          </div>,
          document.body
        )
      : null

  return (
    <div ref={wrapperRef} style={{ display: 'inline-block' }}>
      <button
        ref={buttonRef}
        type="button"
        className="admin-link-btn"
        onClick={handleToggle}
        disabled={busy}
      >
        {busy ? '…' : 'Edit ▾'}
      </button>
      {popover}
    </div>
  )
}

function MenuItem({
  label,
  hint,
  disabled,
  color,
  onClick,
}: {
  label: string
  hint?: string
  disabled?: boolean
  color?: string
  onClick: () => void
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      disabled={disabled}
      style={{
        display: 'block',
        width: '100%',
        textAlign: 'left',
        padding: '8px 10px',
        background: 'transparent',
        border: 'none',
        cursor: disabled ? 'not-allowed' : 'pointer',
        color: color ?? 'var(--ink, #181612)',
        fontFamily: 'inherit',
        fontSize: 13,
        opacity: disabled ? 0.5 : 1,
        transition: 'background .1s',
      }}
      onMouseEnter={(e) => {
        if (!disabled) e.currentTarget.style.background = 'var(--bone, #fff5d4)'
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.background = 'transparent'
      }}
    >
      <div style={{ fontWeight: 500 }}>{label}</div>
      {hint && (
        <div className="t-meta" style={{ fontSize: 11, color: 'var(--ink-40)', marginTop: 2 }}>
          {hint}
        </div>
      )}
    </button>
  )
}
