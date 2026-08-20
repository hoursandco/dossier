export const DEFAULT_EMAIL_IMAGE_URL_LIMIT = 32
export const MAX_EMAIL_IMAGE_URL_LIMIT = 64

function decodeHtmlAttr(value: string): string {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
}

function parseDimension(value: string | undefined): number | null {
  if (!value) return null
  const match = value.match(/\d+/)
  return match ? Number(match[0]) : null
}

function looksLikePromoImage(url: string, width: number | null, height: number | null): boolean {
  const lower = url.toLowerCase()
  if (!/^https?:\/\//i.test(url)) return false
  if (lower.startsWith('data:') || lower.startsWith('cid:')) return false
  if (/\.(svg|ico)(?:[?#]|$)/i.test(lower)) return false
  if (/(pixel|tracking|beacon|openrate|spacer|blank|transparent|clear\.gif|1x1)/i.test(lower)) {
    return false
  }
  if (width !== null && height !== null) {
    if (width <= 2 || height <= 2) return false
    if (width < 120 && height < 120) return false
  }
  return true
}

function boundedImageLimit(limit: number): number {
  if (!Number.isFinite(limit)) return DEFAULT_EMAIL_IMAGE_URL_LIMIT
  return Math.min(MAX_EMAIL_IMAGE_URL_LIMIT, Math.max(1, Math.floor(limit)))
}

export function extractEmailImageUrls(
  html: string,
  limit = DEFAULT_EMAIL_IMAGE_URL_LIMIT,
): string[] {
  const urls: string[] = []
  const maxUrls = boundedImageLimit(limit)

  const imgRegex = /<img\b[^>]*>/gi
  const attrRegex = /\s(src|data-src|data-original|background|width|height|srcset)=["']([^"']+)["']/gi
  let imgMatch
  while ((imgMatch = imgRegex.exec(html)) !== null) {
    const attrs = new Map<string, string>()
    let attrMatch
    attrRegex.lastIndex = 0
    while ((attrMatch = attrRegex.exec(imgMatch[0])) !== null) {
      attrs.set(attrMatch[1].toLowerCase(), decodeHtmlAttr(attrMatch[2]))
    }

    const width = parseDimension(attrs.get('width'))
    const height = parseDimension(attrs.get('height'))
    const candidates = [
      attrs.get('src'),
      attrs.get('data-src'),
      attrs.get('data-original'),
      attrs.get('background'),
    ]

    const srcset = attrs.get('srcset')
    if (srcset) {
      candidates.push(
        ...srcset
          .split(',')
          .map((entry) => entry.trim().split(/\s+/)[0])
      )
    }

    for (const candidate of candidates) {
      if (candidate && looksLikePromoImage(candidate, width, height)) {
        urls.push(candidate)
      }
    }
  }

  const cssUrlRegex = /url\(["']?(https?:\/\/[^"')\s]+)["']?\)/gi
  let cssMatch
  while ((cssMatch = cssUrlRegex.exec(html)) !== null) {
    const url = decodeHtmlAttr(cssMatch[1])
    if (looksLikePromoImage(url, null, null)) urls.push(url)
  }

  return Array.from(new Set(urls)).slice(0, maxUrls)
}
