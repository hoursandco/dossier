'use client'

import { useCallback, useEffect, useState } from 'react'

type ItemRow = {
  keyword: string
  deal_count: number
  last_seen: string | null
  review: {
    canonical_keyword: string | null
    parent_keyword: string | null
    is_hidden: boolean
  } | null
}

export function ItemAuditPanel() {
  const [items, setItems] = useState<ItemRow[]>([])
  const [query, setQuery] = useState('')
  const [drafts, setDrafts] = useState<Record<string, string>>({})
  const [parents, setParents] = useState<Record<string, string>>({})
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState('')
  const [error, setError] = useState('')

  const load = useCallback(async (q = '') => {
    setLoading(true)
    setError('')
    try {
      const res = await fetch(`/api/admin/item-audit?q=${encodeURIComponent(q)}`, { cache: 'no-store' })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Could not load item audit.')
      setItems(data.items ?? [])
      setDrafts(Object.fromEntries(
        (data.items ?? []).map((item: ItemRow) => [
          item.keyword,
          item.review?.canonical_keyword ?? '',
        ]),
      ))
      setParents(Object.fromEntries(
        (data.items ?? []).map((item: ItemRow) => [
          item.keyword,
          item.review?.parent_keyword ?? '',
        ]),
      ))
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Could not load item audit.')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => { void load() }, [load])

  const save = async (item: ItemRow, mode: 'merge' | 'parent' | 'hide' | 'clear') => {
    setSaving(item.keyword)
    setError('')
    try {
      const res = mode === 'clear'
        ? await fetch(`/api/admin/item-audit?keyword=${encodeURIComponent(item.keyword)}`, { method: 'DELETE' })
        : await fetch('/api/admin/item-audit', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              keyword: item.keyword,
              canonical_keyword: mode === 'merge' ? drafts[item.keyword]?.trim() || null : item.review?.canonical_keyword ?? null,
              parent_keyword: mode === 'parent' ? parents[item.keyword]?.trim() || null : item.review?.parent_keyword ?? null,
              is_hidden: mode === 'hide',
            }),
          })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Could not save item review.')
      await load(query)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Could not save item review.')
    } finally {
      setSaving('')
    }
  }

  return (
    <div>
      <form
        onSubmit={(event) => { event.preventDefault(); void load(query) }}
        style={{ display: 'flex', gap: 10, marginBottom: 20, flexWrap: 'wrap' }}
      >
        <input
          value={query}
          onChange={(event) => setQuery(event.target.value)}
          placeholder="Find food, groceries, denim…"
          style={{ flex: '1 1 260px', padding: '10px 12px', background: 'var(--cream)', border: '1px solid var(--ink-25)' }}
        />
        <button className="admin-btn admin-btn-sm" type="submit">Search items</button>
      </form>

      {error && <p style={{ color: 'var(--red-deep)', marginBottom: 16 }}>{error}</p>}
      {loading ? <p className="t-meta">Loading item vocabulary…</p> : (
        <div className="admin-table">
          <div className="admin-table-head" style={{ gridTemplateColumns: 'minmax(150px, 1fr) 70px minmax(145px, 1fr) minmax(145px, 1fr) 300px' }}>
            <span>Item</span><span>Deals</span><span>Merge into</span><span>Include under</span><span>Action</span>
          </div>
          {items.map((item) => {
            const reviewed = !!item.review
            return (
              <div
                key={item.keyword}
                className="admin-table-row"
                style={{ gridTemplateColumns: 'minmax(150px, 1fr) 70px minmax(145px, 1fr) minmax(145px, 1fr) 300px' }}
              >
                <div>
                  <strong>{item.keyword}</strong>
                  {item.review?.is_hidden && <div className="t-meta" style={{ color: 'var(--red-deep)' }}>Hidden</div>}
                  {item.review?.canonical_keyword && (
                    <div className="t-meta" style={{ color: 'var(--olive-deep)' }}>
                      → {item.review.canonical_keyword}
                    </div>
                  )}
                  {item.review?.parent_keyword && (
                    <div className="t-meta" style={{ color: 'var(--ink-55)' }}>
                      included under {item.review.parent_keyword}
                    </div>
                  )}
                </div>
                <span className="t-mono">{item.deal_count}</span>
                <input
                  value={drafts[item.keyword] ?? ''}
                  onChange={(event) => setDrafts((current) => ({ ...current, [item.keyword]: event.target.value }))}
                  placeholder="canonical item"
                  style={{ width: '100%', padding: '8px 10px', background: 'var(--cream)', border: '1px solid var(--ink-25)' }}
                />
                <input
                  value={parents[item.keyword] ?? ''}
                  onChange={(event) => setParents((current) => ({ ...current, [item.keyword]: event.target.value }))}
                  placeholder="broader item"
                  style={{ width: '100%', padding: '8px 10px', background: 'var(--cream)', border: '1px solid var(--ink-25)' }}
                />
                <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
                  <button
                    className="admin-btn admin-btn-sm"
                    disabled={saving === item.keyword || !drafts[item.keyword]?.trim()}
                    onClick={() => void save(item, 'merge')}
                  >
                    Merge
                  </button>
                  <button
                    className="admin-btn admin-btn-sm"
                    disabled={saving === item.keyword || !parents[item.keyword]?.trim()}
                    onClick={() => void save(item, 'parent')}
                  >
                    Include
                  </button>
                  <button
                    className="admin-link-btn"
                    disabled={saving === item.keyword}
                    onClick={() => void save(item, 'hide')}
                  >
                    Hide
                  </button>
                  {reviewed && (
                    <button
                      className="admin-link-btn"
                      disabled={saving === item.keyword}
                      onClick={() => void save(item, 'clear')}
                    >
                      Reset
                    </button>
                  )}
                </div>
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
