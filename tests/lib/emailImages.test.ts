import { describe, expect, it } from 'vitest'
import { extractEmailImageUrls } from '@/lib/emailImages'

describe('extractEmailImageUrls', () => {
  it('extracts normal promotional images', () => {
    const html = '<img src="https://cdn.example.com/product.jpg" width="600" height="800">'
    expect(extractEmailImageUrls(html)).toEqual(['https://cdn.example.com/product.jpg'])
  })

  it('dedupes srcset and keeps enough candidates for later extraction scoring', () => {
    const html = `<img src="https://cdn.example.com/a.jpg" srcset="https://cdn.example.com/a.jpg 1x, https://cdn.example.com/b.jpg 2x" width="600" height="600">`
    expect(extractEmailImageUrls(html)).toEqual([
      'https://cdn.example.com/a.jpg',
      'https://cdn.example.com/b.jpg',
    ])
  })

  it('rejects tracking pixels and tiny images', () => {
    const html = `<img src="https://cdn.example.com/tracking.gif" width="1" height="1"><img src="https://cdn.example.com/icon.png" width="40" height="40">`
    expect(extractEmailImageUrls(html)).toEqual([])
  })

  it('honors the requested result limit', () => {
    const html = '<img src="https://cdn.example.com/a.jpg"><img src="https://cdn.example.com/b.jpg">'
    expect(extractEmailImageUrls(html, 1)).toEqual(['https://cdn.example.com/a.jpg'])
  })
})
