import { describe, expect, it } from 'vitest'
import { extractViewInBrowserUrl } from '@/lib/gmail'

describe('extractViewInBrowserUrl', () => {
  it('finds standard view-in-browser links', () => {
    const html = '<a href="https://example.com/campaign/123">View in browser</a>'
    expect(extractViewInBrowserUrl(html)).toBe('https://example.com/campaign/123')
  })

  it('finds view-entire-message links', () => {
    const html =
      '<div>[Message clipped]</div><a href="https://example.com/full/123">View entire message</a>'
    expect(extractViewInBrowserUrl(html)).toBe('https://example.com/full/123')
  })

  it('finds nested full-email link text', () => {
    const html =
      '<a href="https://example.com/full/456"><span>See the full</span> <strong>email</strong></a>'
    expect(extractViewInBrowserUrl(html)).toBe('https://example.com/full/456')
  })

  it('ignores unrelated view links', () => {
    const html = '<a href="https://example.com/products">View collection</a>'
    expect(extractViewInBrowserUrl(html)).toBeNull()
  })
})
