function externalUrl(value: string | null | undefined): string | null {
  const url = value?.trim()
  if (!url || url === '#') return null
  if (/^https?:\/\//i.test(url)) return url
  if (url.startsWith('//')) return `https:${url}`
  if (/^[a-z0-9.-]+\.[a-z]{2,}(?:[/?#].*)?$/i.test(url)) {
    return `https://${url}`
  }
  return null
}

export function resolveDealLink(deal: {
  store_website?: string | null
  affiliate_link?: string | null
  original_link?: string | null
}): string | null {
  const originalLink = deal.original_link?.includes('google.com/search')
    ? null
    : deal.original_link

  return (
    externalUrl(deal.store_website) ||
    externalUrl(deal.affiliate_link) ||
    externalUrl(originalLink)
  )
}
