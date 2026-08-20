const BLOCKED_RETAILER_KEYS = new Set(['groupon'])

function normalize(value: string): string {
  return value.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export function isBlockedRetailer(retailer: string | null | undefined): boolean {
  return BLOCKED_RETAILER_KEYS.has(normalize(retailer ?? ''))
}

export function isBlockedEmailSender(from: string | null | undefined): boolean {
  const value = (from ?? '').toLowerCase()
  return /(?:^|[^a-z0-9])groupon(?:[^a-z0-9]|$)/.test(value) ||
    /@(?:[a-z0-9-]+\.)*groupon\.com\b/.test(value)
}
