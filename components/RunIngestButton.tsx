'use client'

import { useState } from 'react'

export function RunIngestButton() {
  const [status, setStatus] = useState<'idle' | 'running' | 'done' | 'error'>('idle')
  const [result, setResult] = useState<Record<string, unknown> | null>(null)

  const handleRun = async () => {
    setStatus('running')
    setResult(null)
    try {
      const res = await fetch('/api/admin/run-ingest?hours=24&limit=20', { method: 'POST' })
      const data = await res.json()
      setResult(data)
      setStatus(res.ok ? 'done' : 'error')
      if (res.ok) setTimeout(() => setStatus('idle'), 8000)
    } catch {
      setStatus('error')
      setTimeout(() => setStatus('idle'), 5000)
    }
  }

  const summary =
    status === 'done' && result
      ? `${(result.emails_processed as number) ?? 0} emails · ${(result.emails_skipped_stale as number) ?? 0} stale skipped · ${(result.new_deals as number) ?? 0} new deals`
      : null

  return (
    <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
      <button
        type="button"
        onClick={handleRun}
        disabled={status === 'running'}
        className={`admin-btn ${status === 'running' ? 'is-running' : ''} ${
          status === 'done' ? 'is-done' : ''
        }`}
      >
        <span>
          {status === 'idle' ? 'Run 24h Ingest' : null}
          {status === 'running' && 'Scanning 24h...'}
          {status === 'done' && (summary || 'Done')}
          {status === 'error' &&
            ((result?.error as string | undefined) ?? 'Error - try again')}
        </span>
        {status === 'running' && <span className="admin-btn-spinner" aria-hidden="true" />}
      </button>
    </div>
  )
}
