// Heuristics for cleaning up retailer domains derived from sender
// email addresses or sloppy admin input.
//
// The pipeline:
//   1. parseHost(input)            → strip protocol, path, leading 'www.'
//   2. stripMailSubdomain(host)    → repeatedly remove known mail/ESP
//                                    subdomain prefixes ('email.', 'news.',
//                                    'mkt.', 't.', etc.)
//   3. reduceToApex(host)          → drop deep subdomains down to the
//                                    registrable apex (e.g.
//                                    'cs01.engage.brand.com' → 'brand.com')
//                                    while respecting common multi-part
//                                    public suffixes ('co.uk', etc.)
//
// Result: 'https://<apex-host>' or null if we can't get to a sensible
// shape. The cron and the repair endpoint both run this; admin can
// always override manually.

// Common mail / marketing / transactional subdomain prefixes. Loop
// until nothing matches in case of stacked prefixes ("email.news.brand").
const MAIL_SUBDOMAIN_RE = new RegExp(
  '^(?:' +
    [
      // Generic mail
      'e?mail',
      'mail\\d?',
      'em',
      'email\\d+',
      // Newsletters
      'news',
      'newsletter',
      'newsletters',
      'letters',
      // Marketing / ESPs
      'mkt',
      'mktg',
      'marketing',
      'promo',
      'promos',
      'offers',
      'deals',
      'campaigns',
      'crm',
      'engage',
      'connect',
      'engagement',
      // Transactional / no-reply
      'do[-_]?not[-_]?reply',
      'noreply',
      'no[-_]?reply',
      'reply',
      'send',
      'sender',
      'notify',
      'notifications',
      'alerts',
      'updates',
      'update',
      'comms',
      'messaging',
      'messages',
      // Greeting senders
      'hello',
      'hi',
      'info',
      'contact',
      // Customer / loyalty
      'members?',
      'member',
      'loyalty',
      'rewards',
      'customer',
      'support',
      'cs',
      // Short cryptic ones used by ESPs (Klaviyo, Sendgrid, etc.)
      't',
      'r',
      's',
      'e',
      'm',
      'o',
      'p',
      'q',
      'n',
      'f',
      'link',
      'links',
      'track',
      'tracking',
      'click',
      'clicks',
    ].join('|') +
    ')\\.',
  'i'
)

// Public suffixes that span two labels. NOT exhaustive — just the
// most common ones we hit in US/UK retail. For unknown TLDs we treat
// the last label as the suffix.
const TWO_PART_TLDS = new Set([
  'co.uk',
  'co.in',
  'co.jp',
  'co.kr',
  'co.nz',
  'co.za',
  'com.au',
  'com.br',
  'com.mx',
  'com.sg',
  'com.tw',
  'org.uk',
  'ac.uk',
])

function isHostCleanish(host: string): boolean {
  // Sanity check: looks like a real dotted hostname.
  return /^[a-z0-9.-]+\.[a-z]{2,}$/i.test(host)
}

export function parseHost(input: string): string | null {
  if (!input) return null
  let s = input.trim().toLowerCase()
  if (!s) return null
  // Strip protocol + leading slashes
  s = s.replace(/^https?:\/\//, '')
  // Strip path / query / hash
  s = s.split('/')[0].split('?')[0].split('#')[0]
  // Strip credentials (rare for our data)
  s = s.replace(/^.*@/, '')
  // Strip leading 'www.' — we want the apex
  s = s.replace(/^www\./, '')
  if (!isHostCleanish(s)) return null
  return s
}

export function stripMailSubdomain(host: string): string {
  let prev = ''
  let cur = host
  while (cur !== prev) {
    prev = cur
    cur = cur.replace(MAIL_SUBDOMAIN_RE, '')
  }
  return cur
}

export function reduceToApex(host: string): string {
  const parts = host.split('.')
  if (parts.length <= 2) return host

  // Check if the last two parts are a known multi-part TLD
  const lastTwo = parts.slice(-2).join('.')
  if (TWO_PART_TLDS.has(lastTwo)) {
    // Need to keep last 3 parts (label + co.uk)
    return parts.slice(-3).join('.')
  }

  // Standard case: keep last 2 parts (label.tld)
  return parts.slice(-2).join('.')
}

// Full pipeline: parse + strip + reduce. Always returns an absolute
// URL ('https://<host>') or null if input couldn't be normalized.
export function normalizeRetailerWebsite(input: string | null | undefined): string | null {
  if (!input) return null
  const host = parseHost(input)
  if (!host) return null
  const stripped = stripMailSubdomain(host)
  const apex = reduceToApex(stripped)
  if (!isHostCleanish(apex)) return null
  return `https://${apex}`
}
