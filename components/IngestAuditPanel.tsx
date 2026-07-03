'use client'

import { useCallback, useEffect, useMemo, useState } from 'react'

type AuditRun = {
  id: string
  mode: string
  lookback_hours: number
  reprocess: boolean
  started_at: string
  emails_fetched: number
  emails_selected: number
  emails_deferred: number
  deals_extracted: number
  deals_inserted: number
  status: string
}

type EmailAudit = {
  id: string
  email_id: string
  uid: number
  sender: string
  subject: string
  received_at: string | null
  body_sparse: boolean
  web_version_used: boolean
  image_count: number
  extraction_method: string | null
  extracted_count: number
  inserted_count: number
  rejected_count: number
  duplicate_count: number
  outcome: string
  outcome_detail: string | null
  processing_ms: number | null
}

type Candidate = {
  id: string
  email_id: string
  retailer: string | null
  description: string | null
  percent_off: number | null
  deal_type: string | null
  promo_code: string | null
  decision: string
  reason: string | null
  keywords: string[]
}

type NormalizedDeal = {
  retailer?: string | null
  description?: string | null
  percent_off?: number | null
  deal_type?: string | null
  promo_code?: string | null
  expiration_date?: string | null
  categories?: string[] | null
  deal_subtype?: string | null
  keywords?: string[] | null
  redemption_channel?: string | null
}

type ExtractionOutput = {
  provider?: string
  model?: string
  method?: string
  schema_valid?: boolean
  deals?: NormalizedDeal[]
} | null

type ExtractionComparison = {
  id: string
  source_email_audit_id: string
  email_id: string
  production_provider: string
  production_model: string
  shadow_provider: string
  shadow_model: string
  status: 'match' | 'needs_review' | 'schema_failed' | 'provider_failed'
  production_schema_valid: boolean
  shadow_schema_valid: boolean
  deal_count_match: boolean
  retailer_agreement: boolean
  deal_type_agreement: boolean
  percent_agreement: boolean
  promo_code_agreement: boolean
  category_agreement: boolean
  description_differences: Array<{
    index: number
    production: string | null
    shadow: string | null
  }>
  details: {
    production_deal_count?: number
    shadow_deal_count?: number
    provider_error?: string
  } | null
  error: string | null
  production_output: ExtractionOutput
  shadow_output: ExtractionOutput
}

const OUTCOME_LABELS: Record<string, string> = {
  deals_inserted: 'Inserted',
  no_deals_extracted: 'No candidates',
  all_candidates_rejected: 'All rejected',
  duplicates_only: 'Duplicates only',
  already_processed: 'Already processed',
  transactional_skipped: 'Transactional',
  failed: 'Failed',
  extracted_no_insert: 'No insert',
}

const COMPARISON_LABELS: Record<ExtractionComparison['status'], string> = {
  match: 'Shadow match',
  needs_review: 'Needs review',
  schema_failed: 'Schema failed',
  provider_failed: 'Provider failed',
}

const COMPARISON_COLORS: Record<ExtractionComparison['status'], string> = {
  match: 'var(--olive-deep)',
  needs_review: '#8a6418',
  schema_failed: 'var(--red-deep)',
  provider_failed: 'var(--red-deep)',
}

function formatDealMeta(deal: NormalizedDeal): string {
  const parts = [
    deal.deal_type,
    deal.percent_off != null ? `${deal.percent_off}%` : null,
    deal.promo_code ? `code ${deal.promo_code}` : null,
    deal.redemption_channel,
  ].filter(Boolean)
  return parts.join(' · ')
}

function DealOutputCard({
  title,
  output,
}: {
  title: string
  output: ExtractionOutput
}) {
  const deals = output?.deals ?? []
  return (
    <div style={{ background: 'var(--ink-06)', padding: '12px 14px' }}>
      <div className="t-meta" style={{ marginBottom: 8 }}>
        {title} · {output?.model ?? 'no model'} · schema {String(output?.schema_valid ?? false)}
      </div>
      {deals.length === 0 ? (
        <p className="t-meta">No deals returned.</p>
      ) : deals.map((deal, index) => (
        <div key={`${deal.retailer ?? 'deal'}-${index}`} style={{ paddingTop: index === 0 ? 0 : 12, marginTop: index === 0 ? 0 : 12, borderTop: index === 0 ? 0 : '1px solid var(--ink-15)' }}>
          <div style={{ fontFamily: 'var(--font-serif)', fontSize: 16 }}>{deal.retailer ?? 'Unknown retailer'}</div>
          <div className="t-mono" style={{ marginTop: 4, fontSize: 11, color: 'var(--ink-60)' }}>
            {formatDealMeta(deal) || 'no structured deal metadata'}
          </div>
          <div style={{ marginTop: 6, fontSize: 13 }}>{deal.description ?? 'No description'}</div>
          {deal.categories && deal.categories.length > 0 && (
            <div className="t-mono" style={{ marginTop: 7, fontSize: 11, color: 'var(--ink-55)' }}>
              {deal.categories.join(' · ')}
            </div>
          )}
        </div>
      ))}
    </div>
  )
}

export function IngestAuditPanel() {
  const [runs, setRuns] = useState<AuditRun[]>([])
  const [runId, setRunId] = useState('')
  const [emails, setEmails] = useState<EmailAudit[]>([])
  const [candidates, setCandidates] = useState<Candidate[]>([])
  const [comparisons, setComparisons] = useState<ExtractionComparison[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [expanded, setExpanded] = useState<Set<string>>(new Set())

  const load = useCallback(async (selectedRunId?: string) => {
    setLoading(true)
    setError('')
    const params = new URLSearchParams()
    if (selectedRunId) params.set('run_id', selectedRunId)
    try {
      const res = await fetch(`/api/admin/ingest-audit?${params}`, { cache: 'no-store' })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Could not load ingest audit.')
      setRuns(data.runs ?? [])
      setRunId(data.run_id ?? '')
      setEmails(data.emails ?? [])
      setCandidates(data.candidates ?? [])
      setComparisons(data.comparisons ?? [])
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Could not load ingest audit.')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => { load() }, [load])

  const candidatesByEmail = useMemo(() => {
    const map = new Map<string, Candidate[]>()
    for (const candidate of candidates) {
      const rows = map.get(candidate.email_id) ?? []
      rows.push(candidate)
      map.set(candidate.email_id, rows)
    }
    return map
  }, [candidates])

  const comparisonsByEmailAudit = useMemo(() => {
    const map = new Map<string, ExtractionComparison[]>()
    for (const comparison of comparisons) {
      const rows = map.get(comparison.source_email_audit_id) ?? []
      rows.push(comparison)
      map.set(comparison.source_email_audit_id, rows)
    }
    return map
  }, [comparisons])

  const selectedRun = runs.find((run) => run.id === runId)
  const comparisonCounts = useMemo(() => {
    const result: Record<string, number> = {}
    for (const comparison of comparisons) {
      result[comparison.status] = (result[comparison.status] ?? 0) + 1
    }
    return result
  }, [comparisons])

  if (loading) return <p className="t-meta">Loading ingest evidence…</p>
  if (error) return <p style={{ color: 'var(--red-deep)' }}>{error}</p>

  return (
    <div>
      <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', alignItems: 'center', marginBottom: 20 }}>
        <select
          value={runId}
          onChange={(event) => load(event.target.value)}
          style={{ padding: '10px 12px', minWidth: 280, background: 'var(--cream)', border: '1px solid var(--ink-25)' }}
        >
          {runs.map((run) => (
            <option key={run.id} value={run.id}>
              {new Date(run.started_at).toLocaleString()} · {run.mode} · {run.status}
            </option>
          ))}
        </select>
      </div>

      {selectedRun && (
        <div className="admin-stat-row admin-stat-row-5" style={{ marginBottom: 24 }}>
          {[
            ['Fetched', selectedRun.emails_fetched],
            ['Selected', selectedRun.emails_selected],
            ['Inserted', selectedRun.deals_inserted],
            ['Gemini/OpenRouter', comparisons.length],
            ['Needs review', comparisonCounts.needs_review ?? 0],
          ].map(([label, value]) => (
            <div className="admin-stat" key={String(label)}>
              <div className="admin-stat-num">{value}</div>
              <div className="t-meta admin-stat-label">{label}</div>
            </div>
          ))}
        </div>
      )}

      {emails.length === 0 ? (
        <p className="t-meta">No audited emails in this run.</p>
      ) : (
        <div className="admin-table">
          {emails.map((email) => {
            const emailCandidates = candidatesByEmail.get(email.email_id) ?? []
            const emailComparisons = comparisonsByEmailAudit.get(email.id) ?? []
            const latestComparison = emailComparisons[0]
            const isExpanded = expanded.has(email.id)
            return (
              <div key={email.id} style={{ borderBottom: '1px solid var(--ink-15)' }}>
                <button
                  type="button"
                  onClick={() => setExpanded((current) => {
                    const next = new Set(current)
                    if (next.has(email.id)) next.delete(email.id)
                    else next.add(email.id)
                    return next
                  })}
                  style={{ width: '100%', border: 0, background: 'transparent', textAlign: 'left', padding: '15px 10px', cursor: 'pointer' }}
                >
                  <div style={{ display: 'grid', gridTemplateColumns: '110px minmax(160px, .8fr) minmax(260px, 1.7fr) 130px 120px 90px', gap: 14, alignItems: 'center' }}>
                    <span className="t-meta">{OUTCOME_LABELS[email.outcome] ?? email.outcome}</span>
                    <span style={{ fontSize: 13, overflow: 'hidden', textOverflow: 'ellipsis' }}>{email.sender}</span>
                    <span style={{ fontSize: 14 }}>{email.subject || '(no subject)'}</span>
                    <span className="t-mono" style={{ fontSize: 11 }}>
                      {email.extracted_count} extracted · {email.inserted_count} added
                    </span>
                    <span
                      className="t-meta"
                      style={{
                        color: latestComparison ? COMPARISON_COLORS[latestComparison.status] : 'var(--ink-45)',
                      }}
                    >
                      {latestComparison ? COMPARISON_LABELS[latestComparison.status] : 'No shadow'}
                    </span>
                    <span className="t-meta">{isExpanded ? 'Close −' : 'Inspect +'}</span>
                  </div>
                </button>
                {isExpanded && (
                  <div style={{ padding: '0 18px 18px 18px' }}>
                    <p className="t-mono" style={{ fontSize: 11, color: 'var(--ink-55)', marginBottom: 12 }}>
                      UID {email.uid} · {email.extraction_method ?? 'none'} · sparse={String(email.body_sparse)} · web={String(email.web_version_used)} · images={email.image_count} · {email.processing_ms ?? 0}ms
                    </p>
                    {email.outcome_detail && <p style={{ fontSize: 13, marginBottom: 12 }}>{email.outcome_detail}</p>}
                    {emailComparisons.length > 0 && (
                      <div style={{ padding: '12px 14px', marginBottom: 12, background: 'var(--cream)' }}>
                        {emailComparisons.map((comparison) => (
                          <div key={comparison.id} style={{ marginBottom: 10 }}>
                            <div className="t-meta" style={{ color: COMPARISON_COLORS[comparison.status] }}>
                              {COMPARISON_LABELS[comparison.status]} · {comparison.production_provider} vs {comparison.shadow_provider}
                            </div>
                            <div className="t-mono" style={{ marginTop: 6, fontSize: 11, color: 'var(--ink-65)' }}>
                              schema {String(comparison.production_schema_valid)}/{String(comparison.shadow_schema_valid)}
                              {' · '}count {String(comparison.deal_count_match)}
                              {' · '}retailer {String(comparison.retailer_agreement)}
                              {' · '}type {String(comparison.deal_type_agreement)}
                              {' · '}percent {String(comparison.percent_agreement)}
                              {' · '}code {String(comparison.promo_code_agreement)}
                              {' · '}category {String(comparison.category_agreement)}
                            </div>
                            <div className="t-meta" style={{ marginTop: 5 }}>
                              Gemini {comparison.details?.production_deal_count ?? '—'} deals · OpenRouter {comparison.details?.shadow_deal_count ?? '—'} deals
                            </div>
                            {comparison.error && (
                              <p style={{ marginTop: 6, fontSize: 12, color: 'var(--red-deep)' }}>{comparison.error}</p>
                            )}
                            {comparison.description_differences?.length > 0 && (
                              <div style={{ marginTop: 8 }}>
                                {comparison.description_differences.slice(0, 3).map((diff) => (
                                  <div key={diff.index} style={{ fontSize: 12, marginTop: 6 }}>
                                    <div><strong>Gemini:</strong> {diff.production ?? '—'}</div>
                                    <div><strong>OpenRouter:</strong> {diff.shadow ?? '—'}</div>
                                  </div>
                                ))}
                              </div>
                            )}
                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: 12, marginTop: 12 }}>
                              <DealOutputCard title="Gemini" output={comparison.production_output} />
                              <DealOutputCard title="OpenRouter" output={comparison.shadow_output} />
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                    {emailCandidates.length === 0 ? (
                      <p className="t-meta">No extracted candidates were returned.</p>
                    ) : emailCandidates.map((candidate) => (
                      <div key={candidate.id} style={{ padding: '12px 14px', marginTop: 8, background: 'var(--ink-06)' }}>
                        <div className="t-meta" style={{ color: candidate.decision === 'inserted' ? 'var(--olive-deep)' : 'var(--red-deep)' }}>
                          {candidate.decision}{candidate.reason ? ` — ${candidate.reason}` : ''}
                        </div>
                        <div style={{ marginTop: 5, fontFamily: 'var(--font-serif)', fontSize: 17 }}>{candidate.retailer}</div>
                        <div style={{ marginTop: 4, fontSize: 13 }}>{candidate.description}</div>
                        {candidate.keywords?.length > 0 && (
                          <div className="t-mono" style={{ marginTop: 7, fontSize: 11 }}>{candidate.keywords.join(' · ')}</div>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
