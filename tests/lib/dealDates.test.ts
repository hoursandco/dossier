import { describe, expect, it } from 'vitest'
import { formatDealExpiration } from '@/lib/dealDates'

describe('formatDealExpiration', () => {
  it('formats ISO deal dates as MM-DD-YY', () => {
    expect(formatDealExpiration('2026-06-18')).toBe('06-18-26')
  })

  it('leaves unexpected date values unchanged', () => {
    expect(formatDealExpiration('While supplies last')).toBe('While supplies last')
  })
})
