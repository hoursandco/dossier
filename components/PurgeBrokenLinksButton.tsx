'use client'

// One-shot cleanup: deletes deals stuck with google.com/search?q=...
// fallback URLs whose retailer has no matching store. Companion to
// the Repair Links button — that one fixes what it can, this one
// removes the rest.

import { useState } from 'react'

type PurgeResult = {
  scanned?: number
  deleted?: number
  kept?: number
  error?: string
}

export function PurgeBrokenLinksButton() {
  const [status, setStatus] = useState<'idle' | 'running' | 'done' | 'error'>('idle')
  const [result, setResult] = useState<PurgeResult | null>(null)

  const handleRun = async () => {
    if (
      !confirm(
        `Delete every deal with a broken google.com/search link whose brand isn't in the stores table?\n\nThese are historical rows from before auto-store-creation existed. Not customer-visible (older than the 14-day email window). Irreversible.`
      )
    ) {
      return
    }
    setStatus('running')
    setResult(null)
    try {
      const res = await fetch('/api/admin/deals/purge-broken-links', { method: 'POST' })
      const data: PurgeResult = await res.json()
      setResult(data)
      setStatus(res.ok ? 'done' : 'error')
      if (res.ok) setTimeout(() => setStatus('idle'), 12000)
    } catch {
      setStatus('error')
      setTimeout(() => setStatus('idle'), 5000)
    }
  }

  const summary =
    status === 'done' && result
      ? result.deleted != null
        ? `${result.deleted} deleted · ${result.kept ?? 0} kept`
        : '✓ Done'
      : null

  return (
    <button
      type="button"
      onClick={handleRun}
      disabled={status === 'running'}
      className={`admin-btn ${status === 'running' ? 'is-running' : ''} ${
        status === 'done' ? 'is-done' : ''
      }`}
      title="Hard-deletes deals with broken google.com/search links whose brand has no store record. Idempotent — running again on a clean DB returns 0 deleted."
    >
      <span>
        {status === 'idle' && 'Purge Broken Links'}
        {status === 'running' && 'Purging…'}
        {status === 'done' && (summary || '✓ Done')}
        {status === 'error' && (result?.error ?? 'Error — try again')}
      </span>
      {status === 'running' && <span className="admin-btn-spinner" aria-hidden="true" />}
    </button>
  )
}
