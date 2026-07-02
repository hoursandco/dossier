'use client'

import { useState } from 'react'

export function RunIngestButton() {
  const [status, setStatus] = useState<'idle' | 'running' | 'done' | 'error'>('idle')
  const [mode, setMode] = useState<'normal' | 'backfill'>('normal')
  const [result, setResult] = useState<Record<string, unknown> | null>(null)

  const handleRun = async (nextMode: 'normal' | 'backfill') => {
    setMode(nextMode)
    setStatus('running')
    setResult(null)
    try {
      const url = nextMode === 'backfill'
        ? '/api/admin/run-ingest?hours=8&limit=20'
        : '/api/admin/run-ingest'
      const res = await fetch(url, { method: 'POST' })
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
      ? `${(result.emails_processed as number) ?? 0} emails · ${(result.new_deals as number) ?? 0} new deals`
      : null

  return (
    <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
      <button
        type="button"
        onClick={() => handleRun('normal')}
        disabled={status === 'running'}
        className={`admin-btn ${status === 'running' && mode === 'normal' ? 'is-running' : ''} ${
          status === 'done' && mode === 'normal' ? 'is-done' : ''
        }`}
      >
        <span>
          {status === 'idle' || mode !== 'normal' ? 'Run Ingest' : null}
          {status === 'running' && mode === 'normal' && 'Scanning...'}
          {status === 'done' && mode === 'normal' && (summary || 'Done')}
          {status === 'error' && mode === 'normal' &&
            ((result?.error as string | undefined) ?? 'Error - try again')}
        </span>
        {status === 'running' && mode === 'normal' && <span className="admin-btn-spinner" aria-hidden="true" />}
      </button>
      <button
        type="button"
        onClick={() => handleRun('backfill')}
        disabled={status === 'running'}
        className={`admin-btn admin-btn-ghost ${status === 'running' && mode === 'backfill' ? 'is-running' : ''} ${
          status === 'done' && mode === 'backfill' ? 'is-done' : ''
        }`}
      >
        <span>
          {status === 'idle' || mode !== 'backfill' ? '8h Backfill' : null}
          {status === 'running' && mode === 'backfill' && 'Scanning 8h...'}
          {status === 'done' && mode === 'backfill' && (summary || 'Done')}
          {status === 'error' && mode === 'backfill' &&
            ((result?.error as string | undefined) ?? 'Error - try again')}
        </span>
        {status === 'running' && mode === 'backfill' && <span className="admin-btn-spinner" aria-hidden="true" />}
      </button>
    </div>
  )
}
