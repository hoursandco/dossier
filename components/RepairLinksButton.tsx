'use client'

// One-shot button to clean up legacy "google.com/search?q=..." fallback
// links in the deals table. POSTs to /api/admin/deals/repair-links, which
// rewrites those rows to the matching brand's website (when the brand is
// in the stores table) and reports counts. Idempotent — safe to click
// repeatedly. New ingest runs no longer emit Google fallbacks, so this
// is really only for cleaning up historical rows.

import { useState } from 'react'

type RepairResult = {
  total_bad_deals?: number
  matched_to_store?: number
  unmatched_brands?: number
  rows_repaired?: number
  retailers_updated?: number
  repaired?: number
  message?: string
  error?: string
}

export function RepairLinksButton() {
  const [status, setStatus] = useState<'idle' | 'running' | 'done' | 'error'>('idle')
  const [result, setResult] = useState<RepairResult | null>(null)

  const handleRun = async () => {
    setStatus('running')
    setResult(null)
    try {
      const res = await fetch('/api/admin/deals/repair-links', { method: 'POST' })
      const data: RepairResult = await res.json()
      setResult(data)
      setStatus(res.ok ? 'done' : 'error')
      if (res.ok) setTimeout(() => setStatus('idle'), 10000)
    } catch {
      setStatus('error')
      setTimeout(() => setStatus('idle'), 5000)
    }
  }

  const summary =
    status === 'done' && result
      ? result.rows_repaired != null
        ? `${result.rows_repaired} link${result.rows_repaired === 1 ? '' : 's'} fixed · ${result.unmatched_brands ?? 0} unmatched`
        : result.message ?? '✓ Done'
      : null

  return (
    <button
      type="button"
      onClick={handleRun}
      disabled={status === 'running'}
      className={`admin-btn ${status === 'running' ? 'is-running' : ''} ${
        status === 'done' ? 'is-done' : ''
      }`}
      title="Replaces old google.com/search fallback links in past deals with the actual brand website."
    >
      <span>
        {status === 'idle' && 'Repair Links'}
        {status === 'running' && 'Repairing…'}
        {status === 'done' && (summary || '✓ Done')}
        {status === 'error' && (result?.error ?? 'Error — try again')}
      </span>
      {status === 'running' && <span className="admin-btn-spinner" aria-hidden="true" />}
    </button>
  )
}
