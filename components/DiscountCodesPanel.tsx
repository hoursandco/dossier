'use client'

// Admin panel for the in-app discount-code system (migration 030).
// Replaces the older Stripe-based CouponsPanel — these codes live
// entirely in our DB and are validated/applied server-side without
// any Stripe round-trip. The point: 100%-off ("comped") codes never
// touch Stripe at all, so no per-charge fees on $0 redemptions and
// no $0 noise in the Stripe dashboard.
//
// Shape:
//   - Top: create form (code, plan, % off, duration, expires, require
//          card, max redemptions)
//   - Bottom: list of codes with times_used, sorted Active-first

import { useCallback, useEffect, useState } from 'react'

type CodeRow = {
  id: string
  code: string
  plan_types: string[]
  percent_off: number
  duration_months: number
  expires_at: string
  requires_credit_card: boolean
  active: boolean
  max_redemptions: number | null
  created_at: string
  created_by: string | null
  times_used: number
}

function inputStyle(): React.CSSProperties {
  return {
    padding: '8px 10px',
    fontFamily: 'var(--font-mono, monospace)',
    fontSize: 14,
    border: '1.5px solid var(--ink, #181612)',
    background: '#fff8e2',
    color: 'var(--ink, #181612)',
    outline: 'none',
    boxSizing: 'border-box',
  }
}

function formatDate(iso: string): string {
  try {
    return new Date(iso + 'T00:00:00').toLocaleDateString(undefined, {
      month: 'short',
      day: 'numeric',
      year: '2-digit',
    })
  } catch {
    return iso
  }
}

export function DiscountCodesPanel() {
  const [rows, setRows] = useState<CodeRow[] | null>(null)
  const [err, setErr] = useState<string | null>(null)
  const [busy, setBusy] = useState(false)

  // Create-form state
  const [code, setCode] = useState('')
  const [percentOff, setPercentOff] = useState('20')
  const [durationMonths, setDurationMonths] = useState('1')
  const today = new Date().toISOString().slice(0, 10)
  const oneYear = new Date(Date.now() + 365 * 86400_000).toISOString().slice(0, 10)
  const [expiresAt, setExpiresAt] = useState(oneYear)
  const [requiresCard, setRequiresCardRaw] = useState(true)
  // Wrap the setter so callers can't get the box back into an
  // inconsistent state with percent_off=100.
  const setRequiresCard = setRequiresCardRaw
  const [maxRedemptions, setMaxRedemptions] = useState('')
  const [formMsg, setFormMsg] = useState<string | null>(null)

  const load = useCallback(async () => {
    setErr(null)
    try {
      const res = await fetch('/api/admin/discount-codes', { cache: 'no-store' })
      const d = await res.json()
      if (!res.ok) {
        setErr(d.error ?? 'Failed to load')
        return
      }
      // Active-first, then newest within each group.
      const fetched = (d.codes ?? []) as CodeRow[]
      const sorted = [...fetched].sort((a, b) => {
        if (a.active !== b.active) return a.active ? -1 : 1
        return (b.created_at ?? '').localeCompare(a.created_at ?? '')
      })
      setRows(sorted)
    } catch {
      setErr('Network error')
    }
  }, [])

  useEffect(() => {
    void load()
  }, [load])

  const create = async (e: React.FormEvent) => {
    e.preventDefault()
    setFormMsg(null)
    setBusy(true)
    try {
      const body: Record<string, unknown> = {
        code: code.trim().toUpperCase(),
        plan_types: ['monthly'],
        percent_off: Number(percentOff),
        duration_months: Number(durationMonths),
        expires_at: expiresAt,
        requires_credit_card: requiresCard,
      }
      const max = maxRedemptions.trim()
      if (max) body.max_redemptions = Number(max)

      const res = await fetch('/api/admin/discount-codes', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      })
      const d = await res.json()
      if (!res.ok) {
        setFormMsg(d.error ?? 'Create failed')
        return
      }
      setFormMsg(`✓ ${d.code?.code ?? code.toUpperCase()} created`)
      setCode('')
      setMaxRedemptions('')
      await load()
    } catch {
      setFormMsg('Network error')
    } finally {
      setBusy(false)
    }
  }

  const toggleActive = async (row: CodeRow) => {
    setBusy(true)
    try {
      await fetch(`/api/admin/discount-codes/${row.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ active: !row.active }),
      })
      await load()
    } finally {
      setBusy(false)
    }
  }

  const remove = async (row: CodeRow) => {
    if (!confirm(`Delete code ${row.code}? Past redemptions stay in the system; the code just disappears.`)) return
    setBusy(true)
    try {
      await fetch(`/api/admin/discount-codes/${row.id}`, { method: 'DELETE' })
      await load()
    } finally {
      setBusy(false)
    }
  }

  return (
    <div>
      {/* ── Create form ───────────────────────────────────────────── */}
      <div
        style={{
          padding: 16,
          border: '1.5px dashed var(--ink-25, #cbc4ad)',
          background: '#fffbe6',
          marginBottom: 24,
        }}
      >
        <div
          style={{
            fontFamily: "'Stardos Stamp', monospace",
            fontSize: 11,
            letterSpacing: '.22em',
            textTransform: 'uppercase',
            color: 'var(--red-deep, #b3211a)',
            marginBottom: 12,
          }}
        >
          New code
        </div>

        <form onSubmit={create}>
          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))',
              gap: 10,
              marginBottom: 12,
            }}
          >
            <label>
              <div style={{ fontSize: 11, textTransform: 'uppercase', letterSpacing: '.16em', marginBottom: 4, color: 'var(--ink-soft)' }}>Code</div>
              <input
                value={code}
                onChange={(e) => setCode(e.target.value.toUpperCase())}
                placeholder="LAUNCH50"
                required
                maxLength={64}
                style={{ ...inputStyle(), width: '100%', letterSpacing: '.08em' }}
              />
            </label>
            <label>
              <div style={{ fontSize: 11, textTransform: 'uppercase', letterSpacing: '.16em', marginBottom: 4, color: 'var(--ink-soft)' }}>% off</div>
              <input
                type="number"
                value={percentOff}
                onChange={(e) => {
                  const next = e.target.value
                  setPercentOff(next)
                  // 100%-off codes can't go through Stripe (see the
                  // validator's comment). Force the "no card" branch
                  // whenever the admin lands on 100% so the form can't
                  // submit a state the server will reject.
                  if (Number(next) >= 100) setRequiresCard(false)
                }}
                min={0}
                max={100}
                step="any"
                required
                style={{ ...inputStyle(), width: '100%' }}
              />
            </label>
            <label>
              <div style={{ fontSize: 11, textTransform: 'uppercase', letterSpacing: '.16em', marginBottom: 4, color: 'var(--ink-soft)' }}>Months</div>
              <input
                type="number"
                value={durationMonths}
                onChange={(e) => setDurationMonths(e.target.value)}
                min={1}
                max={120}
                required
                style={{ ...inputStyle(), width: '100%' }}
              />
            </label>
            <label>
              <div style={{ fontSize: 11, textTransform: 'uppercase', letterSpacing: '.16em', marginBottom: 4, color: 'var(--ink-soft)' }}>Expires</div>
              <input
                type="date"
                value={expiresAt}
                onChange={(e) => setExpiresAt(e.target.value)}
                min={today}
                required
                style={{ ...inputStyle(), width: '100%' }}
              />
            </label>
            <label>
              <div style={{ fontSize: 11, textTransform: 'uppercase', letterSpacing: '.16em', marginBottom: 4, color: 'var(--ink-soft)' }}>Max redemptions</div>
              <input
                type="number"
                value={maxRedemptions}
                onChange={(e) => setMaxRedemptions(e.target.value)}
                min={1}
                placeholder="∞"
                style={{ ...inputStyle(), width: '100%' }}
              />
            </label>
          </div>

          {(() => {
            const isFullOff = Number(percentOff) >= 100
            return (
              <label style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 12, fontSize: 13, opacity: isFullOff ? 0.55 : 1 }}>
                <input
                  type="checkbox"
                  checked={isFullOff ? false : requiresCard}
                  onChange={(e) => setRequiresCard(e.target.checked)}
                  disabled={isFullOff}
                />
                <span>
                  <strong>Require credit card</strong> — uncheck for free / 100%-off comp codes (no Stripe round-trip).
                  {isFullOff && (
                    <em style={{ display: 'block', marginTop: 2, fontSize: 12, color: 'var(--ink-soft)', fontStyle: 'italic' }}>
                      Locked off — 100%-off codes always skip card collection (Stripe can&rsquo;t process $0 charges).
                    </em>
                  )}
                </span>
              </label>
            )
          })()}

          <button
            type="submit"
            disabled={busy || !code.trim()}
            style={{
              padding: '10px 18px',
              background: 'var(--ink, #181612)',
              color: '#fff8e2',
              border: '1.5px solid var(--ink, #181612)',
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 12,
              letterSpacing: '.18em',
              textTransform: 'uppercase',
              cursor: busy ? 'not-allowed' : 'pointer',
              opacity: busy ? 0.6 : 1,
            }}
          >
            {busy ? 'Saving…' : 'Create'}
          </button>

          {formMsg && (
            <span
              style={{
                marginLeft: 12,
                fontSize: 13,
                fontFamily: 'var(--font-mono)',
                color: formMsg.startsWith('✓') ? 'var(--olive-deep)' : 'var(--red, #d4322a)',
              }}
            >
              {formMsg}
            </span>
          )}
        </form>
      </div>

      {/* ── List ─────────────────────────────────────────────────── */}
      {err && (
        <p style={{ color: 'var(--red, #d4322a)', fontSize: 13 }}>{err}</p>
      )}

      {rows === null ? (
        <p className="t-meta" style={{ color: 'var(--ink-40)' }}>Loading…</p>
      ) : rows.length === 0 ? (
        <p className="t-meta" style={{ color: 'var(--ink-40)' }}>
          No codes yet. Create one above.
        </p>
      ) : (
        <CodeList rows={rows} busy={busy} onToggle={toggleActive} onDelete={remove} />
      )}
    </div>
  )
}

function CodeList({
  rows, busy, onToggle, onDelete,
}: {
  rows: CodeRow[]
  busy: boolean
  onToggle: (row: CodeRow) => void
  onDelete: (row: CodeRow) => void
}) {
  const cols = '1.2fr 0.8fr 0.8fr 0.9fr 0.8fr 0.8fr 0.7fr 1fr'
  return (
    <div className="admin-table">
      <div className="admin-table-head" style={{ gridTemplateColumns: cols }}>
        <div>Code</div>
        <div>Discount</div>
        <div>Duration</div>
        <div>Expires</div>
        <div>Card?</div>
        <div>Used</div>
        <div>Status</div>
        <div style={{ textAlign: 'right' }}>Actions</div>
      </div>
      {rows.map((c) => {
        // 100%-off codes always behave as comps at redemption time
        // (server-side override in lib/discountCodes.ts), regardless
        // of what the DB row says. Mirror that in the displayed Card?
        // column so the admin sees the actual behavior, not stale DB
        // state from before the override.
        const effectivelyComp = !c.requires_credit_card || c.percent_off >= 100
        const cardLabel = effectivelyComp ? 'No (comp)' : 'Yes'
        const usedLabel = c.max_redemptions != null
          ? `${c.times_used} / ${c.max_redemptions}`
          : String(c.times_used)
        return (
          <div
            key={c.id}
            className="admin-table-row"
            style={{ gridTemplateColumns: cols, opacity: c.active ? 1 : 0.5 }}
          >
            <div style={{ fontFamily: 'var(--font-mono)', fontSize: 13, letterSpacing: '.06em' }}>
              {c.code}
            </div>
            <div className="t-meta" style={{ fontSize: 12 }}>
              {c.percent_off}% off
            </div>
            <div className="t-meta" style={{ fontSize: 12 }}>
              {c.duration_months} {c.duration_months === 1 ? 'mo' : 'mos'}
            </div>
            <div className="t-meta" style={{ fontSize: 12 }}>
              {formatDate(c.expires_at)}
            </div>
            <div className="t-meta" style={{ fontSize: 12, color: effectivelyComp ? 'var(--olive-deep)' : 'var(--ink-55)' }}>
              {cardLabel}
            </div>
            <div className="t-meta" style={{ fontSize: 12 }}>
              {usedLabel}
            </div>
            <div className="t-meta" style={{ fontSize: 12 }}>
              {c.active ? (
                <span style={{ color: 'var(--olive-deep)' }}>Active</span>
              ) : (
                <span style={{ color: 'var(--ink-40)' }}>Inactive</span>
              )}
            </div>
            <div style={{ display: 'flex', gap: 6, justifyContent: 'flex-end' }}>
              <button
                type="button"
                onClick={() => onToggle(c)}
                disabled={busy}
                style={{
                  padding: '4px 8px',
                  fontSize: 11,
                  fontFamily: "'Stardos Stamp', monospace",
                  letterSpacing: '.14em',
                  textTransform: 'uppercase',
                  background: '#fffbe6',
                  border: '1.5px solid var(--ink, #181612)',
                  cursor: busy ? 'not-allowed' : 'pointer',
                }}
              >
                {c.active ? 'Disable' : 'Enable'}
              </button>
              <button
                type="button"
                onClick={() => onDelete(c)}
                disabled={busy}
                style={{
                  padding: '4px 8px',
                  fontSize: 11,
                  fontFamily: "'Stardos Stamp', monospace",
                  letterSpacing: '.14em',
                  textTransform: 'uppercase',
                  background: 'var(--red-deep, #b3211a)',
                  color: '#fff8e2',
                  border: '1.5px solid var(--red-deep, #b3211a)',
                  cursor: busy ? 'not-allowed' : 'pointer',
                }}
              >
                Delete
              </button>
            </div>
          </div>
        )
      })}
    </div>
  )
}
