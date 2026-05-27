'use client'

import { useEffect, useRef, useState } from 'react'
import { createPortal } from 'react-dom'

type Collection = {
  slug: string
  label: string
  group_name?: string | null
}

const PRESETS = [
  { value: 'added',           label: 'Add brand',                 glyph: '✓' },
  { value: 'not_us',          label: 'Not available in the US',   glyph: '✕' },
  { value: 'no_online_store', label: 'No online store',           glyph: '✕' },
  { value: 'no_deals',        label: "Doesn't provide deals/coupons", glyph: '✕' },
]

export function SuggestionActions({
  suggestionId,
  storeName,
  website,
  initialStatus,
}: {
  suggestionId: string
  storeName: string
  website: string | null
  initialStatus: string
}) {
  const [status, setStatus]   = useState(initialStatus)
  const [open, setOpen]       = useState(false)
  const [note, setNote]       = useState('')
  const [sending, setSending] = useState(false)
  const [sent, setSent]       = useState(false)
  const [selected, setSelected] = useState('')
  const [collections, setCollections] = useState<Collection[]>([])
  const [selectedCollections, setSelectedCollections] = useState<Set<string>>(new Set())
  const [collectionsOpen, setCollectionsOpen] = useState(false)
  // Bounding rect of the trigger button, captured at open time so we can
  // anchor the portaled popover. Re-captured every time the popover opens
  // so it follows the button if the page reflowed.
  const [rect, setRect] = useState<DOMRect | null>(null)
  const buttonRef = useRef<HTMLButtonElement>(null)
  const popoverRef = useRef<HTMLDivElement>(null)
  const wrapperRef = useRef<HTMLDivElement>(null)

  // Close on outside click — check both the wrapper AND the portaled
  // popover, since the popover isn't a DOM child of the wrapper anymore.
  useEffect(() => {
    fetch('/api/collections')
      .then((r) => (r.ok ? r.json() : { collections: [] }))
      .then((d) => setCollections(d.collections ?? []))
      .catch(() => {})
  }, [])

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

  if (status !== 'pending') {
    const isAdded = status === 'added'
    return (
      <span
        className="t-meta"
        style={{ color: isAdded ? 'var(--olive-deep)' : 'var(--ink-40)' }}
      >
        {isAdded ? '● Added' : `● ${status}`}
      </span>
    )
  }

  if (sent) {
    return (
      <span className="t-meta" style={{ color: 'var(--olive-deep)' }}>
        ✓ Response sent
      </span>
    )
  }

  const handleSend = async () => {
    if (!selected) return
    setSending(true)
    const res = await fetch('/api/admin/respond-suggestion', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        suggestion_id: suggestionId,
        response_type: selected,
        note,
        website,
        collection_slugs: Array.from(selectedCollections),
      }),
    })
    if (res.ok) {
      setStatus(selected === 'added' ? 'added' : 'declined')
      setSent(true)
      setOpen(false)
    }
    setSending(false)
  }

  // The popover lives in a React Portal to document.body so it escapes
  // any ancestor stacking context (e.g. <Reveal>'s transform). Without
  // this, even z-index: 9999 won't lift it above sibling animated cards.
  const popover = open && rect && typeof document !== 'undefined' && createPortal(
    <div
      ref={popoverRef}
      className="admin-popover"
      style={{
        position: 'fixed',
        top: rect.bottom + 8,
        right: Math.max(8, window.innerWidth - rect.right),
        zIndex: 1000,
      }}
    >
      <div className="t-meta" style={{ color: 'var(--ink-40)', marginBottom: 10 }}>
        Respond to: {storeName}
      </div>
      {PRESETS.map((r) => (
        <label
          key={r.value}
          className={`sug-row ${selected === r.value ? 'on' : ''}`}
        >
          <input
            type="radio"
            name={`s-${suggestionId}`}
            checked={selected === r.value}
            onChange={() => setSelected(r.value)}
          />
          <span
            style={{
              marginRight: 8,
              color: r.value === 'added' ? 'var(--olive-deep)' : 'var(--ink-40)',
            }}
          >
            {r.glyph}
          </span>
          <span>{r.label}</span>
        </label>
      ))}
      {selected === 'added' && (
        <div style={{ marginTop: 10 }}>
          <button
            type="button"
            className="sug-note"
            onClick={() => setCollectionsOpen((v) => !v)}
            style={{
              width: '100%',
              textAlign: 'left',
              cursor: 'pointer',
              minHeight: 36,
              color: selectedCollections.size === 0 ? 'var(--ink-40)' : 'var(--ink)',
            }}
          >
            {selectedCollections.size === 0
              ? 'Collections optional...'
              : `${selectedCollections.size} collection${selectedCollections.size === 1 ? '' : 's'} selected`}
          </button>
          {collectionsOpen && (
            <div
              style={{
                maxHeight: 180,
                overflowY: 'auto',
                border: '1px solid var(--ink-15)',
                borderTop: 0,
                background: 'var(--paper)',
              }}
            >
              {collections.map((c) => {
                const checked = selectedCollections.has(c.slug)
                return (
                  <label
                    key={c.slug}
                    className={`sug-row ${checked ? 'on' : ''}`}
                    style={{ margin: 0, border: 0 }}
                  >
                    <input
                      type="checkbox"
                      checked={checked}
                      onChange={() => {
                        setSelectedCollections((prev) => {
                          const next = new Set(prev)
                          if (next.has(c.slug)) next.delete(c.slug)
                          else next.add(c.slug)
                          return next
                        })
                      }}
                    />
                    <span>{c.label}</span>
                  </label>
                )
              })}
              {collections.length === 0 && (
                <div className="t-meta" style={{ padding: 10, color: 'var(--ink-40)' }}>
                  No collections found.
                </div>
              )}
            </div>
          )}
        </div>
      )}
      <textarea
        className="sug-note"
        placeholder="Optional note…"
        value={note}
        onChange={(e) => setNote(e.target.value)}
        rows={2}
      />
      <div
        style={{
          display: 'flex',
          gap: 8,
          justifyContent: 'flex-end',
          marginTop: 10,
        }}
      >
        <button
          type="button"
          className="admin-link-btn"
          onClick={() => setOpen(false)}
        >
          Cancel
        </button>
        <button
          type="button"
          className="admin-btn admin-btn-sm"
          disabled={!selected || sending}
          onClick={handleSend}
        >
          {sending ? 'Sending…' : 'Send'}
        </button>
      </div>
    </div>,
    document.body
  )

  return (
    <div ref={wrapperRef} style={{ display: 'inline-block' }}>
      <button
        ref={buttonRef}
        type="button"
        className="admin-link-btn"
        onClick={handleToggle}
      >
        Respond ↳
      </button>
      {popover}
    </div>
  )
}
