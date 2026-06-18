import { describe, expect, it } from 'vitest'
import { selectEmailsForIngest } from '@/lib/ingestSelection'

const emails = [
  { id: 'newest', uid: 103 },
  { id: 'oldest', uid: 100 },
  { id: 'middle', uid: 101 },
  { id: 'later', uid: 102 },
]

describe('selectEmailsForIngest', () => {
  it('drains cursor batches oldest-first so deferred UIDs are not skipped', () => {
    const result = selectEmailsForIngest(emails, {
      limit: 2,
      forceDateWindow: false,
      reprocess: false,
      offset: 99,
      alreadyProcessedIds: new Set(),
    })

    expect(result.selected.map((email) => email.uid)).toEqual([100, 101])
    expect(result.selectedOffset).toBe(0)
    expect(result.deferred).toBe(2)
  })

  it('skips already-processed emails during ordinary backfills', () => {
    const result = selectEmailsForIngest(emails, {
      limit: 2,
      forceDateWindow: true,
      reprocess: false,
      offset: 0,
      alreadyProcessedIds: new Set(['oldest', 'middle']),
    })

    expect(result.selected.map((email) => email.uid)).toEqual([103, 102])
  })

  it('supports deterministic reprocessing batches with offsets', () => {
    const result = selectEmailsForIngest(emails, {
      limit: 2,
      forceDateWindow: true,
      reprocess: true,
      offset: 2,
      alreadyProcessedIds: new Set(['oldest']),
    })

    expect(result.selected.map((email) => email.uid)).toEqual([101, 100])
    expect(result.deferred).toBe(0)
  })
})
