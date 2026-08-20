import { describe, expect, it } from 'vitest'
import { isBlockedEmailSender, isBlockedRetailer } from '@/lib/blockedRetailers'

describe('blocked retailers', () => {
  it('blocks Groupon retailer name variants', () => {
    expect(isBlockedRetailer('Groupon')).toBe(true)
    expect(isBlockedRetailer('GROUPON!')).toBe(true)
    expect(isBlockedRetailer('Gap')).toBe(false)
  })

  it('blocks Groupon display names and sender domains', () => {
    expect(isBlockedEmailSender('Groupon <offers@e.groupon.com>')).toBe(true)
    expect(isBlockedEmailSender('offers@groupon.com')).toBe(true)
    expect(isBlockedEmailSender('Gap <offers@gap.com>')).toBe(false)
  })
})
