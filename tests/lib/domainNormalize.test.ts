import { describe, expect, it } from 'vitest'
import { normalizeRetailerWebsite } from '@/lib/domainNormalize'

describe('normalizeRetailerWebsite', () => {
  it('normalizes common newsletter sender subdomains to the retailer apex', () => {
    expect(normalizeRetailerWebsite('newsletter.arenasport.com')).toBe('https://arenasport.com')
    expect(normalizeRetailerWebsite('em.kingarthurbaking.com')).toBe('https://kingarthurbaking.com')
  })

  it('rejects non-domain placeholders', () => {
    expect(normalizeRetailerWebsite('about:blank')).toBeNull()
  })
})
