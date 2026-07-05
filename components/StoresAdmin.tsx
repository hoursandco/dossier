'use client'

import { useCallback, useEffect, useMemo, useState } from 'react'
import { groupCategories } from '@/lib/categoryGroups'

interface Store {
  id: string
  name: string
  website: string
  categories: string[]
  price_tier: string | null
  is_active: boolean
  status: string
  age_group: string | null
  affiliate_id: string | null
  date_added: string
  updated_at: string
}

const STATUS_LABELS: Record<string, { label: string; color: string }> = {
  active:   { label: 'Active',   color: 'var(--olive-deep)' },
  pending:  { label: 'Pending',  color: 'var(--ink-55)' },
  no_email: { label: 'No email', color: 'var(--ink-40)' },
  declined: { label: 'Declined', color: 'var(--ink-40)' },
}

interface Category {
  slug: string
  label: string
  group_name?: string | null
  is_editorial?: boolean
}

type StoreDraft = Partial<Store>

const PRICE_TIERS = ['$', '$$', '$$$', '$$$$'] as const

type SortKey = 'name' | 'website' | 'categories' | 'price_tier' | 'status' | 'is_active'
type SortDirection = 'asc' | 'desc'

const SORT_LABELS: Record<SortKey, string> = {
  name: 'Name',
  website: 'Website',
  categories: 'Categories',
  price_tier: '$',
  status: 'Status',
  is_active: 'Active',
}

const emptyDraft = (): Partial<Store> => ({
  name: '',
  website: '',
  categories: [],
  price_tier: null,
  is_active: true,
  status: 'active',
  age_group: null,
  affiliate_id: null,
})

export function StoresAdmin() {
  const [stores, setStores] = useState<Store[]>([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')
  const [editingId, setEditingId] = useState<string | null>(null) // null = none, 'new' = new row
  const [draft, setDraft] = useState<StoreDraft>(emptyDraft())
  const [allCategories, setAllCategories] = useState<Category[]>([])
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [info, setInfo] = useState<string | null>(null)
  const [sort, setSort] = useState<{ key: SortKey; direction: SortDirection }>({
    key: 'name',
    direction: 'asc',
  })

  const loadStores = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const res = await fetch('/api/admin/stores', { cache: 'no-store' })
      if (!res.ok) throw new Error('Failed to load stores')
      const data = await res.json()
      setStores(data.stores ?? [])
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load stores')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    loadStores()
    fetch('/api/categories')
      .then((r) => (r.ok ? r.json() : { categories: [] }))
      .then((data) => setAllCategories(data.categories ?? []))
      .catch(() => {})
  }, [loadStores])

  // One picker over the whole canonical taxonomy: editorial Collections
  // render as their own group (group_name='Collections'), content
  // categories under their content groups. All of it writes to
  // stores.categories.
  const groupedCategories = useMemo(
    () => groupCategories(allCategories),
    [allCategories]
  )

  const categoryLabelsBySlug = useMemo(
    () => new Map(allCategories.map((c) => [c.slug, c.label])),
    [allCategories]
  )

  const visibleStores = useMemo(() => {
    const term = search.trim().toLowerCase()
    const rows = term
      ? stores.filter((store) => {
          const categoryText = (store.categories ?? [])
            .map((slug) => categoryLabelsBySlug.get(slug) ?? slug)
            .join(' ')
          return [
            store.name,
            store.website,
            categoryText,
            store.price_tier ?? '',
            STATUS_LABELS[store.status]?.label ?? store.status,
            store.is_active ? 'active yes visible' : 'inactive no hidden',
          ].join(' ').toLowerCase().includes(term)
        })
      : stores

    const getComparable = (store: Store) => {
      if (sort.key === 'website') return store.website
      if (sort.key === 'categories') {
        return (store.categories ?? [])
          .map((slug) => categoryLabelsBySlug.get(slug) ?? slug)
          .sort((a, b) => a.localeCompare(b))
          .join(', ')
      }
      if (sort.key === 'price_tier') return store.price_tier?.length ?? 0
      if (sort.key === 'status') return STATUS_LABELS[store.status]?.label ?? store.status
      if (sort.key === 'is_active') return store.is_active ? 1 : 0
      return store.name
    }

    return [...rows].sort((a, b) => {
      const aValue = getComparable(a)
      const bValue = getComparable(b)
      const comparison =
        typeof aValue === 'number' && typeof bValue === 'number'
          ? aValue - bValue
          : String(aValue).localeCompare(String(bValue), undefined, { sensitivity: 'base' })
      return sort.direction === 'asc' ? comparison : -comparison
    })
  }, [categoryLabelsBySlug, search, sort, stores])

  const storeActivityCounts = useMemo(() => {
    const active = stores.filter((store) => store.is_active).length
    return {
      active,
      inactive: stores.length - active,
    }
  }, [stores])

  const toggleSort = (key: SortKey) => {
    setSort((prev) => ({
      key,
      direction: prev.key === key && prev.direction === 'asc' ? 'desc' : 'asc',
    }))
  }

  const startEdit = (store: Store) => {
    setError(null)
    setInfo(null)
    setEditingId(store.id)
    setDraft({ ...store })
  }

  const startNew = () => {
    setError(null)
    setInfo(null)
    setEditingId('new')
    setDraft(emptyDraft())
  }

  const cancelEdit = () => {
    setEditingId(null)
    setDraft(emptyDraft())
  }

  const save = async () => {
    if (!draft.name?.trim() || !draft.website?.trim()) {
      setError('Name and website are required')
      return
    }
    setSaving(true)
    setError(null)
    try {
      const isNew = editingId === 'new'
      const url = isNew ? '/api/admin/stores' : `/api/admin/stores/${editingId}`
      const method = isNew ? 'POST' : 'PATCH'
      // Only send slugs that exist in the canonical categories table —
      // unless the categories fetch hasn't resolved, in which case pass
      // the draft through untouched rather than wiping the store's tags.
      const knownSlugs = new Set(allCategories.map((c) => c.slug))
      const payload = {
        ...draft,
        categories: knownSlugs.size > 0
          ? (draft.categories ?? []).filter((s) => knownSlugs.has(s))
          : draft.categories ?? [],
      }
      const res = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      })
      if (!res.ok) {
        const data = await res.json().catch(() => ({}))
        throw new Error(data.error || 'Save failed')
      }
      setEditingId(null)
      setDraft(emptyDraft())
      setInfo(isNew ? 'Store added' : 'Store updated')
      await loadStores()
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Save failed')
    } finally {
      setSaving(false)
    }
  }

  const setStatus = async (id: string, status: string, name: string) => {
    try {
      const res = await fetch(`/api/admin/stores/${id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status }),
      })
      if (!res.ok) throw new Error('Update failed')
      setInfo(`${name} → ${STATUS_LABELS[status]?.label ?? status}`)
      await loadStores()
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Update failed')
    }
  }

  const toggleCategory = (slug: string) => {
    setDraft((prev) => {
      const set = new Set(prev.categories ?? [])
      if (set.has(slug)) set.delete(slug)
      else set.add(slug)
      return { ...prev, categories: Array.from(set) }
    })
  }

  return (
    <div style={{ marginTop: 48 }}>
      <div
        style={{
          display: 'flex',
          gap: 12,
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          marginBottom: 18,
        }}
      >
        <div>
          <div className="t-eyebrow">Stores</div>
          <div className="t-meta" style={{ color: 'var(--ink-55)', marginTop: 4 }}>
            {visibleStores.length} of {stores.length} store{stores.length === 1 ? '' : 's'} · {storeActivityCounts.active} active · {storeActivityCounts.inactive} non-active
          </div>
        </div>
      </div>

      {/* Controls */}
      <div
        style={{
          display: 'flex',
          gap: 12,
          alignItems: 'center',
          flexWrap: 'wrap',
          marginBottom: 24,
        }}
      >
        <div className="field" style={{ flex: 1, minWidth: 260 }}>
          <input
            type="search"
            placeholder="Search names, websites, categories, status..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>
        <button
          type="button"
          onClick={startNew}
          disabled={editingId !== null}
          className="btn-primary"
        >
          + Add store
        </button>
      </div>

      {/* Banners */}
      {error && (
        <div
          style={{
            padding: '10px 14px',
            border: '1px solid var(--ink-15)',
            background: '#fff7f5',
            color: 'var(--ink)',
            fontSize: 13.5,
            marginBottom: 16,
          }}
        >
          {error}
        </div>
      )}
      {info && (
        <div
          style={{
            padding: '10px 14px',
            border: '1px solid var(--ink-15)',
            background: 'var(--olive-soft, #f4f5ef)',
            color: 'var(--ink)',
            fontSize: 13.5,
            marginBottom: 16,
          }}
        >
          {info}
        </div>
      )}

      {/* Edit / new form */}
      {editingId !== null && (
        <div
          role="dialog"
          aria-modal="true"
          aria-labelledby="store-editor-title"
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
              width: 'min(980px, 100%)',
              maxHeight: 'min(88vh, 920px)',
              overflowY: 'auto',
              boxShadow: '0 24px 80px rgba(0, 0, 0, 0.22)',
            }}
          >
            <StoreForm
              draft={draft}
              setDraft={setDraft}
              groupedCategories={groupedCategories}
              toggleCategory={toggleCategory}
              onSave={save}
              onCancel={cancelEdit}
              saving={saving}
              isNew={editingId === 'new'}
            />
          </div>
        </div>
      )}

      {/* Table */}
      <div
        style={{
          marginTop: 24,
          border: '1px solid var(--ink-15)',
          background: 'var(--paper)',
        }}
      >
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: '1.1fr 1.2fr 1.7fr 50px 80px 70px 130px',
            gap: 12,
            padding: '12px 16px',
            borderBottom: '1px solid var(--ink-15)',
            background: 'var(--paper)',
            fontSize: 11,
            textTransform: 'uppercase',
            letterSpacing: '0.08em',
            color: 'var(--ink-55)',
            fontFamily: 'var(--font-mono)',
          }}
        >
          <SortableHeader sortKey="name" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="website" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="categories" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="price_tier" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="status" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="is_active" sort={sort} onSort={toggleSort} />
          <div></div>
        </div>

        {loading ? (
          <div style={{ padding: 32, textAlign: 'center', color: 'var(--ink-55)' }}>Loading…</div>
        ) : visibleStores.length === 0 ? (
          <div style={{ padding: 32, textAlign: 'center', color: 'var(--ink-55)' }}>
            {search ? 'No stores match that search.' : 'No stores yet. Add one or import from the sheet.'}
          </div>
        ) : (
          visibleStores.map((s) => {
            const catLabels = (s.categories ?? [])
              .map((slug) => categoryLabelsBySlug.get(slug) ?? slug)
              .sort((a, b) => a.localeCompare(b))
            const shown = catLabels.slice(0, 3).join(', ')
            const more = catLabels.length > 3 ? ` +${catLabels.length - 3}` : ''
            return (
              <div
                key={s.id}
                style={{
                  display: 'grid',
                  gridTemplateColumns: '1.1fr 1.2fr 1.7fr 50px 80px 70px 130px',
                  gap: 12,
                  padding: '12px 16px',
                  borderBottom: '1px solid var(--ink-08, var(--ink-15))',
                  alignItems: 'center',
                  fontSize: 13.5,
                  opacity: s.is_active ? 1 : 0.55,
                }}
              >
                <div style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                  <div style={{ fontWeight: 500 }}>{s.name}</div>
                </div>
                <div style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                  <a
                    href={s.website}
                    target="_blank"
                    rel="noreferrer noopener"
                    style={{
                      fontSize: 11.5,
                      color: 'var(--ink-55)',
                      textDecoration: 'underline',
                      textUnderlineOffset: 2,
                    }}
                  >
                    {s.website.replace(/^https?:\/\//, '').replace(/\/$/, '')}
                  </a>
                </div>
                <div style={{ fontSize: 12.5, color: 'var(--ink-70)' }}>
                  {shown || <span style={{ color: 'var(--ink-40)' }}>—</span>}
                  {more}
                </div>
                <div className="t-mono" style={{ color: 'var(--ink-70)' }}>
                  {s.price_tier ?? '—'}
                </div>
                <div style={{ fontSize: 11, color: STATUS_LABELS[s.status]?.color ?? 'var(--ink-55)' }}>
                  {STATUS_LABELS[s.status]?.label ?? s.status}
                </div>
                <div className="t-mono" style={{ color: s.is_active ? 'var(--olive-deep)' : 'var(--ink-40)' }}>
                  {s.is_active ? 'Yes' : 'No'}
                </div>
                <div style={{ display: 'flex', gap: 6 }}>
                  <button
                    type="button"
                    onClick={() => startEdit(s)}
                    disabled={editingId !== null}
                    className="btn-ghost"
                    style={{ fontSize: 10.5, padding: '5px 10px', letterSpacing: '0.06em' }}
                  >
                    Edit
                  </button>
                  {s.status !== 'declined' && (
                    <button
                      type="button"
                      onClick={() => setStatus(s.id, 'declined', s.name)}
                      className="btn-ghost"
                      style={{ fontSize: 10.5, padding: '5px 10px', letterSpacing: '0.06em', color: 'var(--ink-55)' }}
                      title="Mark as declined — hidden from /suggest autofill"
                    >
                      Decline
                    </button>
                  )}
                </div>
              </div>
            )
          })
        )}
      </div>
    </div>
  )
}

function SortableHeader({
  sortKey,
  sort,
  onSort,
}: {
  sortKey: SortKey
  sort: { key: SortKey; direction: SortDirection }
  onSort: (key: SortKey) => void
}) {
  const active = sort.key === sortKey
  return (
    <button
      type="button"
      onClick={() => onSort(sortKey)}
      aria-label={`Sort by ${SORT_LABELS[sortKey]}${
        active ? `, currently ${sort.direction === 'asc' ? 'ascending' : 'descending'}` : ''
      }`}
      style={{
        border: 'none',
        background: 'transparent',
        padding: 0,
        color: active ? 'var(--ink)' : 'inherit',
        cursor: 'pointer',
        font: 'inherit',
        letterSpacing: 'inherit',
        textTransform: 'inherit',
        textAlign: 'left',
        display: 'inline-flex',
        alignItems: 'center',
        gap: 5,
      }}
    >
      <span>{SORT_LABELS[sortKey]}</span>
      <span aria-hidden="true" style={{ fontSize: 10, lineHeight: 1 }}>
        {active ? (sort.direction === 'asc' ? '▲' : '▼') : '↕'}
      </span>
    </button>
  )
}

function StoreForm({
  draft,
  setDraft,
  groupedCategories,
  toggleCategory,
  onSave,
  onCancel,
  saving,
  isNew,
}: {
  draft: StoreDraft
  setDraft: (updater: (prev: StoreDraft) => StoreDraft) => void
  groupedCategories: ReturnType<typeof groupCategories>
  toggleCategory: (slug: string) => void
  onSave: () => void
  onCancel: () => void
  saving: boolean
  isNew: boolean
}) {
  return (
    <div
      style={{
        marginBottom: 24,
        padding: 24,
        border: '1.5px solid var(--ink)',
        background: 'var(--paper)',
      }}
    >
      <div id="store-editor-title" className="t-eyebrow" style={{ marginBottom: 16 }}>
        {isNew ? 'New Store' : 'Edit Store'}
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16, marginBottom: 16 }}>
        <div>
          <div className="t-meta" style={{ marginBottom: 6 }}>Name *</div>
          <div className="field">
            <input
              type="text"
              value={draft.name ?? ''}
              onChange={(e) => setDraft((p) => ({ ...p, name: e.target.value }))}
              placeholder="J.Crew"
            />
          </div>
        </div>
        <div>
          <div className="t-meta" style={{ marginBottom: 6 }}>Website *</div>
          <div className="field">
            <input
              type="url"
              value={draft.website ?? ''}
              onChange={(e) => setDraft((p) => ({ ...p, website: e.target.value }))}
              placeholder="https://jcrew.com"
            />
          </div>
        </div>
      </div>

      {/* Categories — editorial Collections + canonical content taxonomy */}
      <div style={{ marginBottom: 16 }}>
        <div className="t-meta" style={{ marginBottom: 6 }}>
          Categories — editorial collections plus what the brand sells
        </div>
        <div
          style={{
            maxHeight: 280,
            overflowY: 'auto',
            padding: 8,
            border: '1px solid var(--ink-15)',
            background: 'var(--bone, var(--paper))',
          }}
        >
          {groupedCategories.map((group) => (
            <div key={group.name} style={{ marginBottom: 12 }}>
              <div
                className="t-meta"
                style={{
                  padding: '4px 4px 6px',
                  color: 'var(--olive-deep)',
                  letterSpacing: '0.08em',
                  fontSize: 10.5,
                  textTransform: 'uppercase',
                  position: 'sticky',
                  top: 0,
                  background: 'var(--bone, var(--paper))',
                  zIndex: 1,
                }}
              >
                {group.name}
              </div>
              <div
                style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(auto-fill, minmax(160px, 1fr))',
                  gap: 4,
                }}
              >
                {group.items.map((c) => {
                  const on = (draft.categories ?? []).includes(c.slug)
                  return (
                    <button
                      key={c.slug}
                      type="button"
                      onClick={() => toggleCategory(c.slug)}
                      style={{
                        textAlign: 'left',
                        padding: '6px 10px',
                        border: `1.5px solid ${on ? 'var(--ink)' : 'var(--ink-15)'}`,
                        background: on ? 'var(--ink)' : 'transparent',
                        color: on ? 'var(--paper)' : 'var(--ink)',
                        cursor: 'pointer',
                        fontFamily: 'inherit',
                        fontSize: 12,
                        transition: 'all .12s',
                      }}
                    >
                      {on ? '✓ ' : '+ '}{c.label}
                    </button>
                  )
                })}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Price tier, active, age */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 16, marginBottom: 16 }}>
        <div>
          <div className="t-meta" style={{ marginBottom: 6 }}>Price tier</div>
          <div style={{ display: 'flex', gap: 4 }}>
            {PRICE_TIERS.map((t) => (
              <button
                key={t}
                type="button"
                onClick={() =>
                  setDraft((p) => ({ ...p, price_tier: p.price_tier === t ? null : t }))
                }
                style={{
                  flex: 1,
                  padding: '8px',
                  border: `1.5px solid ${draft.price_tier === t ? 'var(--ink)' : 'var(--ink-15)'}`,
                  background: draft.price_tier === t ? 'var(--ink)' : 'transparent',
                  color: draft.price_tier === t ? 'var(--paper)' : 'var(--ink)',
                  cursor: 'pointer',
                  fontFamily: 'var(--font-mono)',
                  fontSize: 13,
                }}
              >
                {t}
              </button>
            ))}
          </div>
        </div>
        <div>
          <div className="t-meta" style={{ marginBottom: 6 }}>Status</div>
          <select
            value={draft.status ?? 'pending'}
            onChange={(e) => {
              const status = e.target.value
              setDraft((p) => ({
                ...p,
                status,
                // Keep is_active in sync — only the active status implies
                // public visibility.
                is_active: status === 'active',
              }))
            }}
            style={{
              width: '100%',
              padding: '8px 10px',
              fontFamily: 'inherit',
              fontSize: 13.5,
              border: '1.5px solid var(--ink-15)',
              background: 'var(--paper)',
              color: 'var(--ink)',
            }}
          >
            <option value="active">Active — tracked</option>
            <option value="pending">Pending — awaiting first email</option>
            <option value="no_email">No email — no promo list</option>
            <option value="declined">Declined — don&rsquo;t track</option>
          </select>
        </div>
        <div>
          <div className="t-meta" style={{ marginBottom: 6 }}>Age group</div>
          <div className="field">
            <input
              type="text"
              value={draft.age_group ?? ''}
              onChange={(e) => setDraft((p) => ({ ...p, age_group: e.target.value || null }))}
              placeholder="All Ages"
            />
          </div>
        </div>
      </div>

      <div style={{ marginBottom: 20 }}>
        <div className="t-meta" style={{ marginBottom: 6 }}>Affiliate ID</div>
        <div className="field">
          <input
            type="text"
            value={draft.affiliate_id ?? ''}
            onChange={(e) => setDraft((p) => ({ ...p, affiliate_id: e.target.value || null }))}
            placeholder="(leave blank for now)"
          />
        </div>
      </div>

      <div style={{ display: 'flex', gap: 12 }}>
        <button type="button" onClick={onSave} disabled={saving} className="btn-primary">
          {saving ? 'Saving…' : isNew ? 'Add store' : 'Save changes'}
        </button>
        <button type="button" onClick={onCancel} disabled={saving} className="btn-ghost">
          Cancel
        </button>
      </div>
    </div>
  )
}
