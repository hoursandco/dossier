'use client'

// Admin coupons panel.
//
// Top: create form. Bottom: list of active coupons + their stats.
// Delete = deactivate (Stripe's safest stop — preserves history).
//
// The form is intentionally opinionated: enforces "exactly one of
// percent_off / amount_off" client-side too, so users don't fight a
// 400 from the API. The discount-type radio drives which field is
// enabled.

import { useCallback, useEffect, useState } from 'react'

type CouponRow = {
  id: string
  code: string
  active: boolean
  coupon_id: string
  percent_off: number | null
  amount_off: number | null
  currency: string | null
  duration: 'once' | 'repeating' | 'forever'
  duration_in_months: number | null
  max_redemptions: number | null
  times_redeemed: number
  redeem_by: string | null
  created: string | null
}

function formatDiscount(c: CouponRow): string {
  if (c.percent_off) return `${c.percent_off}% off`
  if (c.amount_off) {
    const cur = (c.currency ?? 'usd').toUpperCase()
    return `$${(c.amount_off / 100).toFixed(2)} ${cur} off`
  }
  return '—'
}

function formatDuration(c: CouponRow): string {
  if (c.duration === 'once') return 'one charge'
  if (c.duration === 'forever') return 'forever'
  if (c.duration === 'repeating') {
    return `${c.duration_in_months ?? '?'} ${c.duration_in_months === 1 ? 'month' : 'months'}`
  }
  return c.duration
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

// Consistent typewriter-form input styling used across the create form.
// 34px tall so the Create button can match height exactly.
function inputStyle(): React.CSSProperties {
  return {
    fontFamily: 'var(--font-mono, monospace)',
    fontSize: 13,
    padding: '6px 10px',
    border: '1.5px solid var(--ink, #181612)',
    background: 'var(--paper, #f6ecd2)',
    color: 'var(--ink, #181612)',
    height: 34,
    boxSizing: 'border-box',
    width: '100%',
  }
}

// Labelled field wrapper. `basis` is a fixed pixel width that becomes
// the flex-basis so the row stays predictable; flexGrow=0 prevents
// auto-stretching that made the old grid look sparse.
function Field({
  label,
  basis,
  children,
}: {
  label: string
  basis: number
  children: React.ReactNode
}) {
  return (
    <label
      style={{
        display: 'flex',
        flexDirection: 'column',
        gap: 4,
        flex: `0 0 ${basis}px`,
      }}
    >
      <span
        className="t-meta"
        style={{
          fontSize: 10,
          letterSpacing: '.14em',
          textTransform: 'uppercase',
          color: 'var(--ink-55)',
        }}
      >
        {label}
      </span>
      {children}
    </label>
  )
}

export function CouponsPanel() {
  const [rows, setRows] = useState<CouponRow[] | null>(null)
  const [err, setErr] = useState<string | null>(null)
  const [busy, setBusy] = useState(false)

  // Create form state
  const [code, setCode] = useState('')
  const [discountType, setDiscountType] = useState<'percent' | 'amount'>('percent')
  const [percentOff, setPercentOff] = useState<string>('20')
  const [amountOff, setAmountOff] = useState<string>('500')
  const [duration, setDuration] = useState<'once' | 'repeating' | 'forever'>('once')
  const [durationMonths, setDurationMonths] = useState<string>('3')
  const [maxRedemptions, setMaxRedemptions] = useState<string>('')
  const [redeemBy, setRedeemBy] = useState<string>('')
  const [formMsg, setFormMsg] = useState<string | null>(null)

  const load = useCallback(async () => {
    setErr(null)
    try {
      const res = await fetch('/api/admin/coupons', { cache: 'no-store' })
      const d = await res.json()
      if (!res.ok) {
        setErr(d.error ?? 'Failed to load')
        return
      }
      // Sort: Active (live) coupons first, then Inactive. Within each
      // group keep the server's original ordering (typically newest
      // first via the /api/admin/coupons handler).
      const fetched = (d.coupons ?? []) as CouponRow[]
      const sorted = [...fetched].sort((a, b) => {
        if (a.active === b.active) return 0
        return a.active ? -1 : 1
      })
      setRows(sorted)
    } catch {
      setErr('Network error')
    }
  }, [])

  useEffect(() => {
    void load()
  }, [load])

  const create = useCallback(async (e: React.FormEvent) => {
    e.preventDefault()
    setFormMsg(null)
    if (!code.trim()) {
      setFormMsg('Code is required')
      return
    }
    setBusy(true)
    try {
      const body: Record<string, unknown> = {
        code: code.trim(),
        duration,
      }
      if (discountType === 'percent') {
        body.percent_off = Number(percentOff)
      } else {
        body.amount_off = Number(amountOff)
        body.currency = 'usd'
      }
      if (duration === 'repeating') {
        body.duration_in_months = Number(durationMonths)
      }
      if (maxRedemptions.trim()) body.max_redemptions = Number(maxRedemptions)
      if (redeemBy.trim()) {
        body.redeem_by = new Date(redeemBy).toISOString()
      }
      const res = await fetch('/api/admin/coupons', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        setFormMsg(d.error ?? 'Create failed')
        return
      }
      setFormMsg(`✓ Created ${d.code}`)
      setCode('')
      setMaxRedemptions('')
      setRedeemBy('')
      await load()
    } finally {
      setBusy(false)
    }
  }, [code, discountType, percentOff, amountOff, duration, durationMonths, maxRedemptions, redeemBy, load])

  const deactivate = useCallback(async (id: string, displayCode: string) => {
    if (!confirm(`Deactivate code "${displayCode}"? It immediately stops working at checkout but stays in Stripe for accounting.`)) return
    setBusy(true)
    try {
      const res = await fetch(`/api/admin/coupons/${id}`, { method: 'DELETE' })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        alert(d.error ?? 'Deactivate failed')
        return
      }
      await load()
    } finally {
      setBusy(false)
    }
  }, [load])

  return (
    <div>
      {/* ── Create form ──────────────────────────────────────────────── */}
      {/* Single tight row, no CSS-grid auto-fit (which stretches sparse
          fields into uneven gaps on wide screens). Each field gets an
          explicit flex-basis so the row reads left-to-right like a
          single sentence: "code [LAUNCH50] is [20%] off [once], max
          [∞] redemptions, expires [date]". Create button sits inline
          at the end of the row. Wraps cleanly on narrow viewports. */}
      <form
        onSubmit={create}
        style={{
          display: 'flex',
          flexWrap: 'wrap',
          alignItems: 'flex-end',
          gap: 10,
          padding: 16,
          border: '1.5px dashed var(--ink-25, #cbc4ad)',
          background: 'var(--bone, #fff5d4)',
          marginBottom: 20,
        }}
      >
        <Field label="Code" basis={140}>
          <input
            type="text"
            value={code}
            onChange={(e) => setCode(e.target.value.toUpperCase().replace(/[^A-Z0-9_-]/g, ''))}
            placeholder="LAUNCH50"
            disabled={busy}
            style={inputStyle()}
          />
        </Field>

        <Field label="Discount" basis={discountType === 'percent' ? 160 : 200}>
          <div style={{ display: 'flex' }}>
            <select
              value={discountType}
              onChange={(e) => setDiscountType(e.target.value as 'percent' | 'amount')}
              disabled={busy}
              style={{ ...inputStyle(), borderRight: 'none', paddingLeft: 8, paddingRight: 8 }}
            >
              <option value="percent">% off</option>
              <option value="amount">$ (¢)</option>
            </select>
            {discountType === 'percent' ? (
              <input
                type="number"
                min={1}
                max={100}
                value={percentOff}
                onChange={(e) => setPercentOff(e.target.value)}
                disabled={busy}
                style={{ ...inputStyle(), width: 60, flexShrink: 0 }}
              />
            ) : (
              <input
                type="number"
                min={1}
                value={amountOff}
                onChange={(e) => setAmountOff(e.target.value)}
                disabled={busy}
                style={{ ...inputStyle(), width: 90, flexShrink: 0 }}
              />
            )}
          </div>
        </Field>

        <Field label="Duration" basis={duration === 'repeating' ? 200 : 130}>
          <div style={{ display: 'flex' }}>
            <select
              value={duration}
              onChange={(e) => setDuration(e.target.value as 'once' | 'repeating' | 'forever')}
              disabled={busy}
              style={{ ...inputStyle(), ...(duration === 'repeating' ? { borderRight: 'none' } : {}) }}
            >
              <option value="once">Once</option>
              <option value="repeating">N months</option>
              <option value="forever">Forever</option>
            </select>
            {duration === 'repeating' && (
              <input
                type="number"
                min={1}
                max={36}
                value={durationMonths}
                onChange={(e) => setDurationMonths(e.target.value)}
                disabled={busy}
                style={{ ...inputStyle(), width: 60, flexShrink: 0 }}
              />
            )}
          </div>
        </Field>

        <Field label="Max redemptions" basis={130}>
          <input
            type="number"
            min={1}
            value={maxRedemptions}
            onChange={(e) => setMaxRedemptions(e.target.value)}
            placeholder="∞"
            disabled={busy}
            style={inputStyle()}
          />
        </Field>

        <Field label="Expires" basis={150}>
          <input
            type="date"
            value={redeemBy}
            onChange={(e) => setRedeemBy(e.target.value)}
            disabled={busy}
            style={inputStyle()}
          />
        </Field>

        <button
          type="submit"
          disabled={busy}
          className="admin-btn"
          style={{ alignSelf: 'flex-end', height: 34, padding: '0 14px' }}
        >
          {busy ? 'Saving…' : '+ Create'}
        </button>

        {formMsg && (
          <div
            style={{
              flexBasis: '100%',
              marginTop: 4,
              fontSize: 12,
              color: formMsg.startsWith('✓') ? 'var(--olive-deep)' : 'var(--red, #d4322a)',
            }}
          >
            {formMsg}
          </div>
        )}
      </form>

      {/* ── List ─────────────────────────────────────────────────────── */}
      {err && <p className="t-meta" style={{ color: 'var(--red, #d4322a)' }}>Error: {err}</p>}
      {rows === null && !err && <p className="t-meta">Loading coupons…</p>}
      {rows && rows.length === 0 && (
        <p className="t-meta" style={{ textAlign: 'center', padding: 20, color: 'var(--ink-40)' }}>No coupons yet. Create one above.</p>
      )}
      {rows && rows.length > 0 && (
        <CouponList rows={rows} busy={busy} onDeactivate={deactivate} />
      )}
    </div>
  )
}

// Extracted to keep the parent JSX readable. Uses the div-grid pattern
// consistent with the rest of /admin (Recent Signups, Top Retailers).
function CouponList({
  rows,
  busy,
  onDeactivate,
}: {
  rows: CouponRow[]
  busy: boolean
  onDeactivate: (id: string, code: string) => void
}) {
  const cols = '1.2fr 1fr 1fr 1fr 1fr 0.8fr 1fr'
  return (
    <div className="admin-table">
      <div className="admin-table-head" style={{ gridTemplateColumns: cols }}>
        <div>Code</div>
        <div>Discount</div>
        <div>Duration</div>
        <div>Redemptions</div>
        <div>Expires</div>
        <div>Status</div>
        <div style={{ textAlign: 'right' }}>Actions</div>
      </div>
      {rows.map((c) => (
        <div
          key={c.id}
          className="admin-table-row"
          style={{ gridTemplateColumns: cols, opacity: c.active ? 1 : 0.5 }}
        >
          <div style={{ fontFamily: 'var(--font-mono)', fontSize: 13 }}>{c.code}</div>
          <div className="t-meta" style={{ fontSize: 12 }}>{formatDiscount(c)}</div>
          <div className="t-meta" style={{ fontSize: 12 }}>{formatDuration(c)}</div>
          <div className="t-meta" style={{ fontSize: 12 }}>
            {c.times_redeemed}
            {c.max_redemptions != null && ` / ${c.max_redemptions}`}
          </div>
          <div className="t-meta" style={{ fontSize: 12 }}>{formatDate(c.redeem_by)}</div>
          <div className="t-meta" style={{ fontSize: 12 }}>
            {c.active ? (
              <span style={{ color: 'var(--olive-deep)' }}>Active</span>
            ) : (
              <span style={{ color: 'var(--ink-40)' }}>Inactive</span>
            )}
          </div>
          <div style={{ textAlign: 'right' }}>
            {c.active && (
              <button
                type="button"
                className="admin-link-btn"
                disabled={busy}
                onClick={() => onDeactivate(c.id, c.code)}
                style={{ color: 'var(--ink-55)' }}
              >
                Deactivate
              </button>
            )}
          </div>
        </div>
      ))}
    </div>
  )
}
