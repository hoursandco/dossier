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
  const ordered = emails.slice().sort((a, b) => a.uid - b.uid)
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
