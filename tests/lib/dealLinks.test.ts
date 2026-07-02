import { describe, expect, it } from 'vitest'
import { resolveDealLink } from '@/lib/dealLinks'

describe('resolveDealLink', () => {
  it('turns a bare store domain into an external HTTPS URL', () => {
    expect(resolveDealLink({
      store_website: 'bathandbodyworks.com',
      affiliate_link: null,
      original_link: 'https://example.com/deal',
    })).toBe('https://bathandbodyworks.com')
  })

  it('preserves complete external URLs', () => {
    expect(resolveDealLink({
      store_website: 'https://www.example.com/sale',
      affiliate_link: null,
      original_link: null,
    })).toBe('https://www.example.com/sale')
  })

  it('does not render an internal link when no safe destination exists', () => {
    expect(resolveDealLink({
      store_website: null,
      affiliate_link: null,
      original_link: '#',
    })).toBeNull()
  })
})
