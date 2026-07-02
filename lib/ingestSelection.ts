export interface IngestEmailRef {
  id: string
  uid: number
}

export function selectEmailsForIngest<T extends IngestEmailRef>(
  emails: T[],
  options: {
    limit: number
    forceDateWindow: boolean
    reprocess: boolean
    offset: number
    alreadyProcessedIds: Set<string>
  },
): {
  selected: T[]
  eligibleCount: number
  selectedOffset: number
  deferred: number
} {
  // Cursor mode must be oldest-first so the saved UID advances only across
  // a contiguous processed range. Date-window audits are independent of the
  // cursor and should be newest-first so the admin sees today's evidence
  // before spending hours walking older mail.
  const ordered = emails.slice().sort((a, b) =>
    options.forceDateWindow ? b.uid - a.uid : a.uid - b.uid
  )
  const eligible = options.forceDateWindow && !options.reprocess
    ? ordered.filter((email) => !options.alreadyProcessedIds.has(email.id))
    : ordered
  const selectedOffset = options.forceDateWindow ? options.offset : 0
  const selected = eligible.slice(selectedOffset, selectedOffset + options.limit)

  return {
    selected,
    eligibleCount: eligible.length,
    selectedOffset,
    deferred: Math.max(0, eligible.length - selectedOffset - selected.length),
  }
}

export function computeSafeCursorAfterProduction(
  currentCursorUid: number,
  processedUids: number[],
  failedUids: number[],
): number {
  if (processedUids.length === 0) return currentCursorUid
  const firstFailedUid = failedUids.length > 0 ? Math.min(...failedUids) : Infinity
  const safeProcessedUids = processedUids.filter((uid) => uid < firstFailedUid)
  return safeProcessedUids.length > 0
    ? Math.max(...safeProcessedUids)
    : currentCursorUid
}
