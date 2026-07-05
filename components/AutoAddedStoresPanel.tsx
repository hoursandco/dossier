'use client'

// Quick-review panel for stores the ingest cron auto-created.
//
// When the ingest sees a promo email from a sender NOT in the stores
// table, it inserts a row with status='auto_added' and is_active=false
// so the admin can approve it before it appears publicly. This panel
// surfaces those rows so the admin can:
//
//   - Approve     → status='active'  (graduates to a regular store)
//   - Decline     → status='declined' (hide from future ingest matching,
//                                     keeps history for audit)
//   - Edit        → opens a local quick editor for name / website / tags
//
// Empty state ("All caught up") is the normal day-to-day state — most
// retailers in the directory already exist after the first few weeks.

import { useCallback, useEffect, useState } from 'react'

type AutoAddedRow = {
  id: string
  name: string
  website: string
  categories: string[]
  date_added: string | null
  created_at: string
}

function formatDate(iso: string | null): string {
  if (!iso) return '—'
  try {
    return new Date(iso).toLocaleDateString(undefined, {
      month: 'short',
      day: 'numeric',
    })
  } catch {
    return '—'
  }
}

export function AutoAddedStoresPanel() {
  const [rows, setRows] = useState<AutoAddedRow[] | null>(null)
  const [err, setErr] = useState<string | null>(null)
  const [busyId, setBusyId] = useState<string | null>(null)
  const [editing, setEditing] = useState<AutoAddedRow | null>(null)
  const [draftName, setDraftName] = useState('')
  const [draftWebsite, setDraftWebsite] = useState('')
  const [draftCategories, setDraftCategories] = useState('')
  const [savingEdit, setSavingEdit] = useState(false)

  const load = useCallback(async () => {
    setErr(null)
    try {
      // Reuse the existing admin stores list endpoint with a status filter.
      const res = await fetch('/api/admin/stores?status=auto_added', {
        cache: 'no-store',
      })
      const d = await res.json()
      if (!res.ok) {
        setErr(d.error ?? 'Failed to load')
        return
      }
      setRows(d.stores ?? [])
    } catch {
      setErr('Network error')
    }
  }, [])

  useEffect(() => {
    void load()
  }, [load])

  const setStatus = useCallback(
    async (id: string, status: 'active' | 'declined', name: string) => {
      if (status === 'declined' && !confirm(`Decline "${name}"? Future ingest runs will skip emails from this brand.`)) return
      setBusyId(id)
      try {
        const res = await fetch(`/api/admin/stores/${id}`, {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            status,
            // Declining also drops it from public listings.
            ...(status === 'declined' ? { is_active: false } : {}),
          }),
        })
        const d = await res.json().catch(() => ({}))
        if (!res.ok) {
          alert(d.error ?? `Failed: ${status}`)
          return
        }
        await load()
      } finally {
        setBusyId(null)
      }
    },
    [load]
  )

  const startEdit = (row: AutoAddedRow) => {
    setEditing(row)
    setDraftName(row.name)
    setDraftWebsite(row.website)
    setDraftCategories(row.categories.join(', '))
  }

  const cancelEdit = () => {
    setEditing(null)
    setDraftName('')
    setDraftWebsite('')
    setDraftCategories('')
  }

  const saveEdit = async () => {
    if (!editing) return
    setSavingEdit(true)
    try {
      const categories = Array.from(
        new Set(
          draftCategories
            .split(',')
            .map((slug) => slug.trim())
            .filter(Boolean),
        ),
      )
      const res = await fetch(`/api/admin/stores/${editing.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: draftName.trim(),
          website: draftWebsite.trim(),
          categories,
        }),
      })
      const d = await res.json().catch(() => ({}))
      if (!res.ok) {
        alert(d.error ?? 'Failed to update store')
        return
      }
      cancelEdit()
      await load()
    } finally {
      setSavingEdit(false)
    }
  }

  if (err) {
    return <p className="t-meta" style={{ color: 'var(--red, #d4322a)' }}>Error: {err}</p>
  }
  if (rows === null) return <p className="t-meta">Loading…</p>
  if (rows.length === 0) {
    return (
      <p className="t-meta" style={{ color: 'var(--ink-40)', fontStyle: 'italic' }}>
        All caught up — no new auto-added stores awaiting review.
      </p>
    )
  }

  const cols = '1.2fr 1.4fr 1.6fr 0.8fr 1.6fr'
  return (
    <>
      {editing && (
        <div
          role="dialog"
          aria-modal="true"
          aria-labelledby="auto-added-store-editor-title"
          style={{
            position: 'fixed',
            inset: 0,
            zIndex: 1000,
            padding: '24px clamp(12px, 3vw, 32px)',
            background: 'rgba(34, 31, 25, 0.42)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <div
            style={{
              width: 'min(760px, 100%)',
              maxHeight: 'min(88vh, 680px)',
              overflowY: 'auto',
              padding: 20,
              border: '1.5px solid var(--ink)',
              background: 'var(--paper)',
              boxShadow: '0 24px 80px rgba(0, 0, 0, 0.22)',
            }}
          >
            <div id="auto-added-store-editor-title" className="t-eyebrow" style={{ marginBottom: 16 }}>
              Edit Auto-Added Store
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 14, marginBottom: 14 }}>
              <div>
                <div className="t-meta" style={{ marginBottom: 6 }}>Name</div>
                <div className="field">
                  <input value={draftName} onChange={(event) => setDraftName(event.target.value)} />
                </div>
              </div>
              <div>
                <div className="t-meta" style={{ marginBottom: 6 }}>Website</div>
                <div className="field">
                  <input value={draftWebsite} onChange={(event) => setDraftWebsite(event.target.value)} />
                </div>
              </div>
            </div>
            <div>
              <div className="t-meta" style={{ marginBottom: 6 }}>Categories</div>
              <div className="field">
                <input
                  value={draftCategories}
                  onChange={(event) => setDraftCategories(event.target.value)}
                  placeholder="skincare, beauty, women-owned"
                />
              </div>
              <div className="t-meta" style={{ color: 'var(--ink-40)', marginTop: 6 }}>
                Comma-separated category slugs. Unknown slugs are ignored when saved.
              </div>
            </div>
            <div style={{ display: 'flex', gap: 10, marginTop: 16 }}>
              <button type="button" onClick={saveEdit} disabled={savingEdit} className="btn-primary">
                {savingEdit ? 'Saving...' : 'Save'}
              </button>
              <button type="button" onClick={cancelEdit} disabled={savingEdit} className="btn-ghost">
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}

      <div className="admin-table">
        <div className="admin-table-head" style={{ gridTemplateColumns: cols }}>
          <div>Brand</div>
          <div>Website</div>
          <div>Categories</div>
          <div>Added</div>
          <div style={{ textAlign: 'right' }}>Actions</div>
        </div>
        {rows.map((s) => (
          <div key={s.id} className="admin-table-row" style={{ gridTemplateColumns: cols }}>
            <div style={{ fontWeight: 500 }}>{s.name}</div>
            <div className="t-meta" style={{ fontSize: 12 }}>
              <a
                href={s.website.startsWith('http') ? s.website : `https://${s.website}`}
                target="_blank"
                rel="noopener noreferrer"
                style={{ color: 'var(--ink-55)' }}
              >
                {s.website.replace(/^https?:\/\//, '').replace(/\/$/, '')}
              </a>
            </div>
            <div className="t-meta" style={{ fontSize: 12, color: 'var(--ink-40)' }}>
              {s.categories.length === 0 ? (
                <span style={{ fontStyle: 'italic' }}>none — edit to add</span>
              ) : (
                s.categories.slice(0, 3).join(', ') + (s.categories.length > 3 ? `, +${s.categories.length - 3}` : '')
              )}
            </div>
            <div className="t-meta" style={{ fontSize: 12, color: 'var(--ink-40)' }}>
              {formatDate(s.created_at)}
            </div>
            <div style={{ textAlign: 'right' }}>
              <div style={{ display: 'inline-flex', gap: 6 }}>
                <button
                  type="button"
                  className="admin-link-btn"
                  disabled={busyId === s.id}
                  onClick={() => setStatus(s.id, 'active', s.name)}
                  style={{ color: 'var(--olive-deep)' }}
                >
                  Approve
                </button>
                <button
                  type="button"
                  className="admin-link-btn"
                  disabled={busyId === s.id}
                  onClick={() => startEdit(s)}
                  style={{ color: 'var(--ink-55)' }}
                >
                  Edit
                </button>
                <button
                  type="button"
                  className="admin-link-btn"
                  disabled={busyId === s.id}
                  onClick={() => setStatus(s.id, 'declined', s.name)}
                  style={{ color: 'var(--red, #d4322a)' }}
                >
                  Decline
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </>
  )
}
