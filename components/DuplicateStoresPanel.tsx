'use client'

// Duplicate Stores · Review.
//
// Each cluster = two-or-more store rows whose `website` normalizes to
// the same apex domain. The user picks ONE keeper per cluster; the
// others get hard-deleted (true row removal, not soft-delete — soft
// delete wouldn't free the unique-website index for the keeper).
//
// The endpoint pre-sorts members within each cluster: active rows
// first, then by # of categories, then oldest. So the first card in
// each row is the default-recommended keeper — but the user can pick
// any of them.

import { useCallback, useEffect, useState } from 'react'

type Member = {
  id: string
  name: string
  website: string | null
  status: string | null
  is_active: boolean
  categories: string[] | null
  price_tier: string | null
  date_added: string | null
  created_at: string
}

type Cluster = {
  normalized_website: string
  members: Member[]
}

function formatDate(iso: string | null): string {
  if (!iso) return '—'
  try {
    return new Date(iso).toLocaleDateString(undefined, {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
    })
  } catch {
    return '—'
  }
}

export function DuplicateStoresPanel() {
  const [clusters, setClusters] = useState<Cluster[] | null>(null)
  const [err, setErr] = useState<string | null>(null)
  const [busyClusterKey, setBusyClusterKey] = useState<string | null>(null)
  const [affected, setAffected] = useState(0)

  const load = useCallback(async () => {
    setErr(null)
    try {
      const res = await fetch('/api/admin/stores/duplicates', { cache: 'no-store' })
      const d = await res.json()
      if (!res.ok) {
        setErr(d.error ?? 'Failed to load')
        return
      }
      setClusters(d.clusters ?? [])
      setAffected(d.affected_rows ?? 0)
    } catch {
      setErr('Network error')
    }
  }, [])

  useEffect(() => {
    void load()
  }, [load])

  const dismiss = useCallback(
    async (cluster: Cluster) => {
      if (
        !confirm(
          `Keep all ${cluster.members.length} rows under "${cluster.normalized_website.replace(/^https?:\/\//, '')}"?\n\nThis hides the cluster from the review panel permanently. Future stores sharing this apex domain won't surface here either. To undo: delete the row from the non_duplicate_clusters table in SQL.`
        )
      ) {
        return
      }
      setBusyClusterKey(cluster.normalized_website)
      try {
        const res = await fetch('/api/admin/stores/duplicates/dismiss', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ normalized_website: cluster.normalized_website }),
        })
        const d = await res.json().catch(() => ({}))
        if (!res.ok) {
          alert(d.error ?? 'Dismiss failed')
          return
        }
        await load()
      } finally {
        setBusyClusterKey(null)
      }
    },
    [load]
  )

  const merge = useCallback(
    async (cluster: Cluster, keeperId: string) => {
      const keeper = cluster.members.find((m) => m.id === keeperId)
      const losers = cluster.members.filter((m) => m.id !== keeperId)
      if (!keeper || losers.length === 0) return

      const loserList = losers.map((l) => `  • ${l.name} (${l.website ?? 'no url'}) — ${l.status ?? 'unknown'}`).join('\n')
      if (
        !confirm(
          `Keep "${keeper.name}" and DELETE the other ${losers.length} duplicate row${losers.length === 1 ? '' : 's'}?\n\nLosers:\n${loserList}\n\nHard delete — irreversible.`
        )
      ) {
        return
      }

      setBusyClusterKey(cluster.normalized_website)
      try {
        // Parallel — order doesn't matter, each loser is independent.
        const results = await Promise.all(
          losers.map((l) =>
            fetch(`/api/admin/stores/${l.id}?hard=1`, { method: 'DELETE' }).then((res) =>
              res.ok ? null : res.json().then((d) => d.error ?? 'Delete failed').catch(() => 'Delete failed')
            )
          )
        )
        const errs = results.filter((r): r is string => !!r)
        if (errs.length > 0) {
          alert(`Some deletes failed:\n${errs.join('\n')}`)
        }
        await load()
      } finally {
        setBusyClusterKey(null)
      }
    },
    [load]
  )

  if (err) {
    return <p className="t-meta" style={{ color: 'var(--red, #d4322a)' }}>Error: {err}</p>
  }
  if (clusters === null) return <p className="t-meta">Loading…</p>
  if (clusters.length === 0) {
    return (
      <p className="t-meta" style={{ color: 'var(--ink-40)', fontStyle: 'italic' }}>
        No duplicates — every store has a unique website.
      </p>
    )
  }

  return (
    <div>
      <p className="t-meta" style={{ fontSize: 12, color: 'var(--ink-40)', marginBottom: 16 }}>
        {clusters.length} cluster{clusters.length === 1 ? '' : 's'} · {affected} affected rows. Pick the row to keep — the others get hard-deleted.
      </p>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
        {clusters.map((cluster) => (
          <ClusterCard
            key={cluster.normalized_website}
            cluster={cluster}
            busy={busyClusterKey === cluster.normalized_website}
            onMerge={merge}
            onDismiss={dismiss}
          />
        ))}
      </div>
    </div>
  )
}

function ClusterCard({
  cluster,
  busy,
  onMerge,
  onDismiss,
}: {
  cluster: Cluster
  busy: boolean
  onMerge: (cluster: Cluster, keeperId: string) => void
  onDismiss: (cluster: Cluster) => void
}) {
  return (
    <div
      style={{
        border: '1.5px solid var(--ink, #181612)',
        background: 'var(--paper, #f6ecd2)',
        padding: 14,
      }}
    >
      <div style={{ display: 'flex', alignItems: 'baseline', gap: 12, marginBottom: 10, flexWrap: 'wrap' }}>
        <span
          className="t-meta"
          style={{
            fontFamily: 'var(--font-mono, monospace)',
            fontSize: 13,
            color: 'var(--ink, #181612)',
          }}
        >
          {cluster.normalized_website.replace(/^https?:\/\//, '')}
        </span>
        <span className="t-meta" style={{ fontSize: 11, color: 'var(--ink-40)' }}>
          {cluster.members.length} rows
        </span>
        <div style={{ flex: 1 }} />
        {/* False-positive escape hatch: parent-company domains
            (gap.com → Old Navy / Banana Republic / Athleta) collapse
            here but aren't actual duplicates. This hides the cluster
            for good. */}
        <button
          type="button"
          className="admin-link-btn"
          disabled={busy}
          onClick={() => onDismiss(cluster)}
          style={{ color: 'var(--ink-55)', fontSize: 11 }}
          title="These aren't duplicates — keep all rows and hide this cluster from the review panel"
        >
          Not duplicates · keep all
        </button>
      </div>

      <div
        style={{
          display: 'grid',
          gridTemplateColumns: `repeat(${cluster.members.length}, 1fr)`,
          gap: 10,
        }}
      >
        {cluster.members.map((m, i) => (
          <MemberCard
            key={m.id}
            member={m}
            isRecommended={i === 0}
            busy={busy}
            onKeep={() => onMerge(cluster, m.id)}
          />
        ))}
      </div>
    </div>
  )
}

function MemberCard({
  member,
  isRecommended,
  busy,
  onKeep,
}: {
  member: Member
  isRecommended: boolean
  busy: boolean
  onKeep: () => void
}) {
  return (
    <div
      style={{
        border: `1.5px solid ${isRecommended ? 'var(--olive-deep)' : 'var(--ink-25, #cbc4ad)'}`,
        background: 'var(--bone, #fff5d4)',
        padding: 12,
        display: 'flex',
        flexDirection: 'column',
        gap: 8,
        position: 'relative',
      }}
    >
      {isRecommended && (
        <span
          className="t-meta"
          style={{
            position: 'absolute',
            top: -10,
            left: 8,
            background: 'var(--olive-deep)',
            color: 'var(--bone, #fff5d4)',
            padding: '1px 8px',
            fontSize: 10,
            letterSpacing: '.08em',
            textTransform: 'uppercase',
          }}
        >
          Best guess
        </span>
      )}
      <div style={{ fontWeight: 500, fontSize: 13 }}>{member.name}</div>
      <div className="t-meta" style={{ fontSize: 11, color: 'var(--ink-55)', wordBreak: 'break-all' }}>
        {member.website?.replace(/^https?:\/\//, '') ?? '—'}
      </div>
      <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap', fontSize: 11 }}>
        <span
          className="t-meta"
          style={{
            background: member.is_active ? 'var(--olive-deep)' : 'var(--ink-40)',
            color: 'var(--bone, #fff5d4)',
            padding: '1px 6px',
            textTransform: 'uppercase',
            letterSpacing: '.08em',
            fontSize: 10,
          }}
        >
          {member.status ?? (member.is_active ? 'active' : 'inactive')}
        </span>
        <span className="t-meta" style={{ color: 'var(--ink-40)' }}>
          {member.categories?.length ?? 0} cats
        </span>
        {member.price_tier && (
          <span className="t-meta" style={{ color: 'var(--ink-40)' }}>
            {member.price_tier}
          </span>
        )}
      </div>
      <div className="t-meta" style={{ fontSize: 11, color: 'var(--ink-40)' }}>
        Added {formatDate(member.created_at)}
      </div>
      <button
        type="button"
        className="admin-btn admin-btn-sm"
        disabled={busy}
        onClick={onKeep}
        style={{ marginTop: 'auto' }}
      >
        {busy ? '…' : 'Keep this · delete others'}
      </button>
    </div>
  )
}
