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

export function IngestAuditPanel() {
  const [runs, setRuns] = useState<AuditRun[]>([])
  const [runId, setRunId] = useState('')
  const [emails, setEmails] = useState<EmailAudit[]>([])
  const [candidates, setCandidates] = useState<Candidate[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [expanded, setExpanded] = useState<Set<string>>(new Set())
  const [backfillOffset, setBackfillOffset] = useState(0)
  const [backfillRunning, setBackfillRunning] = useState(false)
  const [backfillMessage, setBackfillMessage] = useState('')

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

  const selectedRun = runs.find((run) => run.id === runId)
  const counts = useMemo(() => {
    const result: Record<string, number> = {}
    for (const email of emails) result[email.outcome] = (result[email.outcome] ?? 0) + 1
    return result
  }, [emails])

  const runAuditBackfill = async (restart = false) => {
    const offset = restart ? 0 : backfillOffset
    setBackfillRunning(true)
    setBackfillMessage(`Scanning 14 days from batch offset ${offset}…`)
    try {
      const res = await fetch(`/api/admin/run-ingest?hours=336&limit=40&reprocess=1&offset=${offset}`, {
        method: 'POST',
      })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Backfill failed.')
      const nextOffset = typeof data.next_offset === 'number' ? data.next_offset : 0
      setBackfillOffset(nextOffset)
      setBackfillMessage(
        data.next_offset == null
          ? `Audit backfill complete: ${data.emails_processed ?? 0} emails in final batch.`
          : `Batch complete: ${data.emails_processed ?? 0} emails. ${data.emails_deferred ?? 0} remain.`,
      )
      await load(data.audit_run_id)
    } catch (err) {
      setBackfillMessage(err instanceof Error ? err.message : 'Backfill failed.')
    } finally {
      setBackfillRunning(false)
    }
  }

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
        <button className="admin-btn admin-btn-sm" disabled={backfillRunning} onClick={() => runAuditBackfill(backfillOffset === 0)}>
          {backfillRunning ? 'Scanning…' : backfillOffset > 0 ? 'Run Next Audit Batch' : 'Start 14-Day Audit'}
        </button>
        {backfillOffset > 0 && (
          <button className="admin-link-btn" disabled={backfillRunning} onClick={() => runAuditBackfill(true)}>
            Restart at first batch
          </button>
        )}
      </div>
      {backfillMessage && <p className="t-meta" style={{ marginBottom: 18 }}>{backfillMessage}</p>}

      {selectedRun && (
        <div className="admin-stat-row admin-stat-row-5" style={{ marginBottom: 24 }}>
          {[
            ['Fetched', selectedRun.emails_fetched],
            ['Selected', selectedRun.emails_selected],
            ['Inserted', selectedRun.deals_inserted],
            ['Rejected emails', counts.all_candidates_rejected ?? 0],
            ['No candidates', counts.no_deals_extracted ?? 0],
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
                  <div style={{ display: 'grid', gridTemplateColumns: '110px minmax(160px, .8fr) minmax(260px, 1.7fr) 130px 90px', gap: 14, alignItems: 'center' }}>
                    <span className="t-meta">{OUTCOME_LABELS[email.outcome] ?? email.outcome}</span>
                    <span style={{ fontSize: 13, overflow: 'hidden', textOverflow: 'ellipsis' }}>{email.sender}</span>
                    <span style={{ fontSize: 14 }}>{email.subject || '(no subject)'}</span>
                    <span className="t-mono" style={{ fontSize: 11 }}>
                      {email.extracted_count} extracted · {email.inserted_count} added
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
