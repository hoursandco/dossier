'use client'

import { useCallback, useEffect, useMemo, useState } from 'react'

interface CategoryRow {
  slug: string
  label: string
  group_name: string | null
  sort_order: number
  is_active: boolean
  is_editorial?: boolean
  search_terms: string[]
}

type SortKey = 'slug' | 'label' | 'group_name' | 'sort_order' | 'is_active' | 'search_terms'
type SortDirection = 'asc' | 'desc'

const SORT_LABELS: Record<SortKey, string> = {
  slug: 'Slug',
  label: 'Label',
  group_name: 'Group',
  sort_order: 'Sort',
  is_active: 'Active',
  search_terms: 'Search Terms',
}

const emptyDraft = (): CategoryRow => ({
  slug: '',
  label: '',
  group_name: '',
  sort_order: 0,
  is_active: true,
  search_terms: [],
})

function termsToText(terms: string[] | null | undefined): string {
  return (terms ?? []).join(', ')
}

function textToTerms(value: string): string[] {
  return Array.from(
    new Set(
      value
        .split(',')
        .map((term) => term.trim().toLowerCase())
        .filter(Boolean),
    ),
  ).sort((a, b) => a.localeCompare(b))
}

export function CategoriesAdmin() {
  const [categories, setCategories] = useState<CategoryRow[]>([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')
  const [editingSlug, setEditingSlug] = useState<string | null>(null)
  const [draft, setDraft] = useState<CategoryRow>(emptyDraft())
  const [termsText, setTermsText] = useState('')
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState('')
  const [info, setInfo] = useState('')
  const [sort, setSort] = useState<{ key: SortKey; direction: SortDirection }>({
    key: 'sort_order',
    direction: 'asc',
  })

  const load = useCallback(async () => {
    setLoading(true)
    setError('')
    try {
      const res = await fetch('/api/admin/categories', { cache: 'no-store' })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Failed to load categories')
      setCategories((data.categories ?? []).map((category: CategoryRow) => ({
        ...category,
        search_terms: category.search_terms ?? [],
      })))
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load categories')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => { void load() }, [load])

  const filtered = useMemo(() => {
    const term = search.trim().toLowerCase()
    const rows = term
      ? categories.filter((category) => [
          category.slug,
          category.label,
          category.group_name ?? '',
          category.is_active ? 'active' : 'inactive',
          category.is_editorial ? 'editorial' : 'content',
          ...(category.search_terms ?? []),
        ].join(' ').toLowerCase().includes(term))
      : categories

    const comparable = (category: CategoryRow) => {
      if (sort.key === 'sort_order') return category.sort_order
      if (sort.key === 'is_active') return category.is_active ? 1 : 0
      if (sort.key === 'search_terms') return termsToText(category.search_terms)
      return category[sort.key] ?? ''
    }

    return [...rows].sort((a, b) => {
      const av = comparable(a)
      const bv = comparable(b)
      const comparison = typeof av === 'number' && typeof bv === 'number'
        ? av - bv
        : String(av).localeCompare(String(bv), undefined, { sensitivity: 'base' })
      return sort.direction === 'asc' ? comparison : -comparison
    })
  }, [categories, search, sort])

  const toggleSort = (key: SortKey) => {
    setSort((prev) => ({
      key,
      direction: prev.key === key && prev.direction === 'asc' ? 'desc' : 'asc',
    }))
  }

  const startNew = () => {
    setError('')
    setInfo('')
    setEditingSlug('new')
    setDraft(emptyDraft())
    setTermsText('')
  }

  const startEdit = (category: CategoryRow) => {
    setError('')
    setInfo('')
    setEditingSlug(category.slug)
    setDraft({ ...category })
    setTermsText(termsToText(category.search_terms))
  }

  const cancel = () => {
    setEditingSlug(null)
    setDraft(emptyDraft())
    setTermsText('')
  }

  const save = async () => {
    setSaving(true)
    setError('')
    try {
      const isNew = editingSlug === 'new'
      const payload = {
        slug: draft.slug,
        label: draft.label,
        group_name: draft.group_name,
        sort_order: draft.sort_order,
        is_active: draft.is_active,
        search_terms: textToTerms(termsText),
      }
      const res = await fetch('/api/admin/categories', {
        method: isNew ? 'POST' : 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Save failed')
      setInfo(isNew ? 'Category added' : 'Category updated')
      cancel()
      await load()
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Save failed')
    } finally {
      setSaving(false)
    }
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
          <div className="t-eyebrow">Categories</div>
          <div className="t-meta" style={{ color: 'var(--ink-55)', marginTop: 4 }}>
            {filtered.length} of {categories.length} categor{categories.length === 1 ? 'y' : 'ies'}
          </div>
        </div>
        <button type="button" onClick={startNew} disabled={editingSlug !== null} className="btn-primary">
          + Add category
        </button>
      </div>

      <div className="field" style={{ marginBottom: 16 }}>
        <input
          type="search"
          placeholder="Search slugs, labels, groups, or aliases..."
          value={search}
          onChange={(event) => setSearch(event.target.value)}
        />
      </div>

      {error && (
        <div style={{ padding: '10px 14px', border: '1px solid var(--ink-15)', background: '#fff7f5', color: 'var(--ink)', fontSize: 13.5, marginBottom: 16 }}>
          {error}
        </div>
      )}
      {info && (
        <div style={{ padding: '10px 14px', border: '1px solid var(--ink-15)', background: 'var(--olive-soft, #f4f5ef)', color: 'var(--ink)', fontSize: 13.5, marginBottom: 16 }}>
          {info}
        </div>
      )}

      {editingSlug !== null && (
        <div
          role="dialog"
          aria-modal="true"
          aria-labelledby="category-editor-title"
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
              maxHeight: 'min(88vh, 760px)',
              overflowY: 'auto',
              padding: 18,
              border: '1.5px solid var(--ink)',
              background: 'var(--paper)',
              boxShadow: '0 24px 80px rgba(0, 0, 0, 0.22)',
            }}
          >
            <div id="category-editor-title" className="t-eyebrow" style={{ marginBottom: 14 }}>
              {editingSlug === 'new' ? 'New Category' : 'Edit Category'}
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr 90px 110px', gap: 12, alignItems: 'end' }}>
              <div>
                <div className="t-meta" style={{ marginBottom: 6 }}>Slug</div>
                <div className="field">
                  <input
                    value={draft.slug}
                    disabled={editingSlug !== 'new'}
                    onChange={(event) => setDraft((current) => ({ ...current, slug: event.target.value }))}
                    placeholder="skincare"
                  />
                </div>
              </div>
              <div>
                <div className="t-meta" style={{ marginBottom: 6 }}>Label</div>
                <div className="field">
                  <input
                    value={draft.label}
                    onChange={(event) => setDraft((current) => ({ ...current, label: event.target.value }))}
                    placeholder="Skincare"
                  />
                </div>
              </div>
              <div>
                <div className="t-meta" style={{ marginBottom: 6 }}>Group</div>
                <div className="field">
                  <input
                    value={draft.group_name ?? ''}
                    onChange={(event) => setDraft((current) => ({ ...current, group_name: event.target.value }))}
                    placeholder="Health & Wellness"
                  />
                </div>
              </div>
              <div>
                <div className="t-meta" style={{ marginBottom: 6 }}>Sort</div>
                <div className="field">
                  <input
                    type="number"
                    value={draft.sort_order}
                    onChange={(event) => setDraft((current) => ({ ...current, sort_order: Number(event.target.value) }))}
                  />
                </div>
              </div>
              <label style={{ display: 'flex', alignItems: 'center', gap: 8, paddingBottom: 10, fontSize: 13 }}>
                <input
                  type="checkbox"
                  checked={draft.is_active}
                  onChange={(event) => setDraft((current) => ({ ...current, is_active: event.target.checked }))}
                />
                Active
              </label>
            </div>
            <div style={{ marginTop: 12 }}>
              <div className="t-meta" style={{ marginBottom: 6 }}>Aliases / search terms</div>
              <div className="field">
                <input
                  value={termsText}
                  onChange={(event) => setTermsText(event.target.value)}
                  placeholder="skin care, face care, moisturizer"
                />
              </div>
            </div>
            <div style={{ display: 'flex', gap: 10, marginTop: 14 }}>
              <button type="button" onClick={save} disabled={saving} className="btn-primary">
                {saving ? 'Saving...' : 'Save'}
              </button>
              <button type="button" onClick={cancel} disabled={saving} className="btn-ghost">
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}

      <div className="admin-table">
        <div className="admin-table-head" style={{ gridTemplateColumns: '1fr 1.1fr 1.1fr 70px 80px 1.6fr 80px' }}>
          <SortableHeader sortKey="slug" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="label" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="group_name" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="sort_order" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="is_active" sort={sort} onSort={toggleSort} />
          <SortableHeader sortKey="search_terms" sort={sort} onSort={toggleSort} />
          <span></span>
        </div>
        {loading ? (
          <div style={{ padding: 32, textAlign: 'center', color: 'var(--ink-55)' }}>Loading...</div>
        ) : filtered.length === 0 ? (
          <div style={{ padding: 32, textAlign: 'center', color: 'var(--ink-55)' }}>No categories match that search.</div>
        ) : filtered.map((category) => (
          <div key={category.slug} className="admin-table-row" style={{ gridTemplateColumns: '1fr 1.1fr 1.1fr 70px 80px 1.6fr 80px' }}>
            <span className="t-mono">{category.slug}</span>
            <span>{category.label}</span>
            <span>{category.group_name ?? '-'}</span>
            <span className="t-mono">{category.sort_order}</span>
            <span>{category.is_active ? 'Yes' : 'No'}</span>
            <span style={{ color: category.search_terms?.length ? 'var(--ink-70)' : 'var(--ink-40)' }}>
              {termsToText(category.search_terms) || '-'}
            </span>
            <button type="button" onClick={() => startEdit(category)} disabled={editingSlug !== null} className="btn-ghost" style={{ fontSize: 10.5, padding: '5px 10px', letterSpacing: '0.06em' }}>
              Edit
            </button>
          </div>
        ))}
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
      aria-label={`Sort by ${SORT_LABELS[sortKey]}${active ? `, currently ${sort.direction}` : ''}`}
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
