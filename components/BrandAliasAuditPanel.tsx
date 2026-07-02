'use client'

import { useCallback, useEffect, useState } from 'react'
import type { AliasCandidate } from '@/lib/brandAliasAudit'
import type { BrandRelationshipDecision } from '@/lib/brandRelationships'

const CONFIDENCE_STYLE = {
  high: { label: 'High', color: 'var(--olive-deep)', background: '#eef1df' },
  medium: { label: 'Medium', color: '#7a5600', background: '#fff2c7' },
  low: { label: 'Low', color: 'var(--ink-55)', background: 'var(--ink-08)' },
} as const

type AuditResponse = {
  candidates: AliasCandidate[]
  candidate_count: number
  filtered_count: number
  high_confidence_count: number
  reviewed_count: number
  page: number
  per_page: number
  total_pages: number
  evidence_window_days: number
  reviews_available: boolean
}

export function BrandAliasAuditPanel() {
  const [data, setData] = useState<AuditResponse | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [search, setSearch] = useState('')
  const [debouncedSearch, setDebouncedSearch] = useState('')
  const [confidence, setConfidence] = useState<'all' | AliasCandidate['confidence']>('all')
  const [reviewStatus, setReviewStatus] = useState<'unreviewed' | 'reviewed' | 'all'>('unreviewed')
  const [page, setPage] = useState(1)
  const [savingKey, setSavingKey] = useState<string | null>(null)

  useEffect(() => {
    const timer = window.setTimeout(() => {
      setDebouncedSearch(search.trim())
      setPage(1)
    }, 250)
    return () => window.clearTimeout(timer)
  }, [search])

  const load = useCallback(async () => {
    setError(null)
    const controller = new AbortController()
    const timeout = window.setTimeout(() => controller.abort(), 20000)
    try {
      const params = new URLSearchParams({
        page: String(page),
        confidence,
        review_status: reviewStatus,
      })
      if (debouncedSearch) params.set('q', debouncedSearch)
      const res = await fetch(`/api/admin/stores/alias-audit?${params}`, {
        cache: 'no-store',
        signal: controller.signal,
      })
      const result = await res.json()
      if (!res.ok) throw new Error(result.error || 'Failed to load alias audit')
      setData(result)
    } catch (err) {
      setError(
        err instanceof DOMException && err.name === 'AbortError'
          ? 'The alias audit took too long to respond. Try refreshing it.'
          : err instanceof Error ? err.message : 'Failed to load alias audit'
      )
    } finally {
      window.clearTimeout(timeout)
    }
  }, [confidence, debouncedSearch, page, reviewStatus])

  useEffect(() => {
    void load()
  }, [load])

  const review = async (
    candidate: AliasCandidate,
    decision: BrandRelationshipDecision,
    parentStoreId?: string,
  ) => {
    setSavingKey(candidate.key)
    setError(null)
    try {
      const res = await fetch('/api/admin/stores/alias-audit/review', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          left_store_id: candidate.left.id,
          right_store_id: candidate.right.id,
          decision,
          parent_store_id: parentStoreId ?? null,
        }),
      })
      const result = await res.json().catch(() => ({}))
      if (!res.ok) throw new Error(result.error || 'Failed to save review')
      await load()
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to save review')
    } finally {
      setSavingKey(null)
    }
  }

  if (error && !data) {
    return (
      <div>
        <p className="t-meta" style={{ color: 'var(--red-deep)' }}>{error}</p>
        <button type="button" className="btn-ghost" onClick={() => void load()} style={{ marginTop: 12 }}>
          Retry
        </button>
      </div>
    )
  }

  if (data === null) {
    return <p className="t-meta" style={{ color: 'var(--ink-40)' }}>Building candidate list…</p>
  }

  return (
    <div>
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(3, minmax(0, 1fr))',
          border: '1px solid var(--ink-15)',
          marginBottom: 20,
        }}
      >
        {[
          ['Review candidates', data.candidate_count],
          ['High confidence', data.high_confidence_count],
          ['Reviewed', data.reviewed_count],
        ].map(([label, value], index) => (
          <div
            key={label}
            style={{
              padding: '14px 16px',
              borderLeft: index ? '1px solid var(--ink-15)' : undefined,
            }}
          >
            <div style={{ fontFamily: 'var(--font-serif)', fontSize: 26 }}>{value}</div>
            <div className="t-meta" style={{ color: 'var(--ink-40)', marginTop: 3 }}>{label}</div>
          </div>
        ))}
      </div>

      {!data.reviews_available && (
        <p style={{ padding: 12, border: '1px solid var(--red-deep)', color: 'var(--red-deep)', fontSize: 13 }}>
          Review saving is not installed yet. Run database migration 044.
        </p>
      )}
      {error && (
        <p className="t-meta" style={{ color: 'var(--red-deep)', marginBottom: 12 }}>{error}</p>
      )}

      <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', marginBottom: 20 }}>
        <div className="field" style={{ flex: '1 1 260px' }}>
          <input
            type="search"
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Search either brand or evidence…"
          />
        </div>
        <select
          value={reviewStatus}
          onChange={(event) => {
            setReviewStatus(event.target.value as typeof reviewStatus)
            setPage(1)
          }}
          style={selectStyle}
          aria-label="Filter alias candidates by review status"
        >
          <option value="unreviewed">Needs review</option>
          <option value="reviewed">Reviewed</option>
          <option value="all">All candidates</option>
        </select>
        <select
          value={confidence}
          onChange={(event) => {
            setConfidence(event.target.value as typeof confidence)
            setPage(1)
          }}
          style={selectStyle}
          aria-label="Filter alias candidates by confidence"
        >
          <option value="all">All confidence</option>
          <option value="high">High confidence</option>
          <option value="medium">Medium confidence</option>
        </select>
        <button type="button" className="btn-ghost" onClick={() => void load()}>
          Refresh
        </button>
      </div>

      <p className="t-meta" style={{ color: 'var(--ink-40)', marginBottom: 14 }}>
        {data.filtered_count} match{data.filtered_count === 1 ? '' : 'es'} · showing 10 per page · evidence uses the last {data.evidence_window_days} days
      </p>

      {data.candidates.length === 0 ? (
        <p className="t-meta" style={{ color: 'var(--ink-40)', fontStyle: 'italic' }}>
          No candidates match these filters.
        </p>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
          {data.candidates.map((candidate) => (
            <AliasCandidateCard
              key={candidate.key}
              candidate={candidate}
              saving={savingKey === candidate.key}
              reviewsAvailable={data.reviews_available}
              onReview={review}
            />
          ))}
        </div>
      )}

      {data.total_pages > 1 && (
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 12, marginTop: 22 }}>
          <button
            type="button"
            className="btn-ghost"
            disabled={data.page <= 1}
            onClick={() => setPage((current) => Math.max(1, current - 1))}
          >
            ← Previous
          </button>
          <span className="t-meta" style={{ color: 'var(--ink-55)' }}>
            Page {data.page} of {data.total_pages}
          </span>
          <button
            type="button"
            className="btn-ghost"
            disabled={data.page >= data.total_pages}
            onClick={() => setPage((current) => Math.min(data.total_pages, current + 1))}
          >
            Next →
          </button>
        </div>
      )}
    </div>
  )
}

const selectStyle = {
  padding: '10px 12px',
  border: '1.5px solid var(--ink)',
  background: 'var(--paper)',
  fontFamily: 'var(--font-mono)',
  fontSize: 12,
}

function AliasCandidateCard({
  candidate,
  saving,
  reviewsAvailable,
  onReview,
}: {
  candidate: AliasCandidate
  saving: boolean
  reviewsAvailable: boolean
  onReview: (
    candidate: AliasCandidate,
    decision: BrandRelationshipDecision,
    parentStoreId?: string,
  ) => Promise<void>
}) {
  const style = CONFIDENCE_STYLE[candidate.confidence]
  const suggestedChild = candidate.parent_store_id
    ? [candidate.left, candidate.right].find((store) => store.id !== candidate.parent_store_id)
    : null

  const reviewLabel = candidate.review?.decision === 'unrelated'
    ? 'Marked as different brands'
    : candidate.review?.decision === 'equivalent'
      ? 'Marked as the same brand'
      : candidate.review?.decision === 'parent_child'
        ? `Parent saved: ${
            candidate.review.parent_store_id === candidate.left.id
              ? candidate.left.name
              : candidate.right.name
          }`
        : null

  return (
    <article style={{ border: '1.5px solid var(--ink)', background: 'var(--paper)', padding: 18 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', gap: 16, flexWrap: 'wrap' }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 10, flexWrap: 'wrap' }}>
            <span style={{ fontFamily: 'var(--font-serif)', fontSize: 21 }}>{candidate.left.name}</span>
            <span className="t-meta" style={{ color: 'var(--ink-25)' }}>↔</span>
            <span style={{ fontFamily: 'var(--font-serif)', fontSize: 21 }}>{candidate.right.name}</span>
          </div>
          {reviewLabel ? (
            <p className="t-meta" style={{ marginTop: 7, color: 'var(--olive-deep)' }}>{reviewLabel}</p>
          ) : candidate.parent_name && suggestedChild ? (
            <p className="t-meta" style={{ marginTop: 7, color: 'var(--olive-deep)' }}>
              Suggested direction: {candidate.parent_name} → {suggestedChild.name}
            </p>
          ) : (
            <p className="t-meta" style={{ marginTop: 7, color: 'var(--ink-40)' }}>
              Direction needs review
            </p>
          )}
        </div>
        <span
          className="t-meta"
          style={{
            alignSelf: 'flex-start',
            padding: '5px 8px',
            color: style.color,
            background: style.background,
            border: `1px solid ${style.color}`,
          }}
        >
          {style.label} · {candidate.score}
        </span>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, minmax(0, 1fr))', gap: 12, marginTop: 16 }}>
        {[candidate.left, candidate.right].map((store) => {
          const dealCount = store.id === candidate.left.id ? candidate.recent_deals.left : candidate.recent_deals.right
          return (
            <div key={store.id} style={{ border: '1px solid var(--ink-15)', padding: 12, minWidth: 0 }}>
              <div style={{ fontWeight: 600 }}>{store.name}</div>
              {store.website ? (
                <a href={store.website} target="_blank" rel="noopener noreferrer" className="t-mono" style={websiteStyle}>
                  {store.website.replace(/^https?:\/\//, '').replace(/\/$/, '')}
                </a>
              ) : null}
              <div className="t-meta" style={{ color: 'var(--ink-40)', marginTop: 8 }}>
                {dealCount} recent deal{dealCount === 1 ? '' : 's'} · {store.status ?? 'unknown'}
              </div>
            </div>
          )
        })}
      </div>

      <div style={{ marginTop: 15 }}>
        <div className="t-meta" style={{ color: 'var(--ink-40)', marginBottom: 7 }}>Evidence</div>
        <ul style={{ margin: 0, paddingLeft: 19, color: 'var(--ink-70)', fontSize: 13, lineHeight: 1.55 }}>
          {candidate.evidence.map((evidence) => (
            <li key={`${evidence.kind}:${evidence.label}`}>{evidence.label}</li>
          ))}
        </ul>
      </div>

      <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap', marginTop: 16, paddingTop: 15, borderTop: '1px dashed var(--ink-25)' }}>
        <button
          type="button"
          className="btn-ghost"
          disabled={saving || !reviewsAvailable}
          onClick={() => void onReview(candidate, 'unrelated')}
        >
          Different brands
        </button>
        <button
          type="button"
          className="btn-ghost"
          disabled={saving || !reviewsAvailable}
          onClick={() => void onReview(candidate, 'parent_child', candidate.left.id)}
        >
          {candidate.left.name} is parent
        </button>
        <button
          type="button"
          className="btn-ghost"
          disabled={saving || !reviewsAvailable}
          onClick={() => void onReview(candidate, 'parent_child', candidate.right.id)}
        >
          {candidate.right.name} is parent
        </button>
        <button
          type="button"
          className="btn-ghost"
          disabled={saving || !reviewsAvailable}
          onClick={() => void onReview(candidate, 'equivalent')}
        >
          Same brand / spelling
        </button>
        {saving && <span className="t-meta" style={{ alignSelf: 'center', color: 'var(--ink-40)' }}>Saving…</span>}
      </div>
    </article>
  )
}

const websiteStyle = {
  display: 'block',
  color: 'var(--ink-55)',
  fontSize: 11,
  marginTop: 4,
  overflow: 'hidden',
  textOverflow: 'ellipsis',
  whiteSpace: 'nowrap' as const,
}
