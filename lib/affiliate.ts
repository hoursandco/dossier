// Affiliate link rewriting.
//
// Two networks, two strategies:
//
//   - Amazon (amazon.*): NOT in Skimlinks. We append our own
//     `?tag=<NEXT_PUBLIC_AMAZON_TAG>` Associates parameter directly,
//     overriding any existing tag on the URL (so we never give
//     attribution to a third party for a click on our property).
//
//   - Everything else: routed through the Skimlinks redirect, which
//     handles per-merchant rewriting on their side using our publisher
//     ID. Used for EMAIL links — site-side clicks are auto-rewritten
//     by the Skimlinks JS in the (redesign) layout.
//
// Both IDs are read from env so they can be rotated / disabled per
// environment. Missing env vars → link passes through unchanged.
// We never break a link to add an affiliate tag.
//
// Skimlinks redirect format:
//   https://go.skimresources.com/?id=<pubId>&xs=1&url=<encoded>
//
// `xs=1` flags it as a server-side rewrite (vs JS-rewritten), which
// Skimlinks uses for attribution / reporting.

const SKIM_ID = process.env.NEXT_PUBLIC_SKIMLINKS_ID || ''
const AMAZON_TAG = process.env.NEXT_PUBLIC_AMAZON_TAG || ''

const SKIP_HOSTS = [
  'dealdossier.io',
  'localhost',
]

const AMAZON_RE = /(^|\.)amazon\.[a-z.]+$/i

// Adds our Associates tag to any amazon.* URL. Idempotent: overrides
// any existing `tag=` param. Safe to call on non-Amazon URLs — they
// pass through unchanged. Exported separately so site components that
// render an Amazon link directly can call this without dragging in the
// Skimlinks wrapper (the JS doesn't handle Amazon).
export function addAmazonTag(rawUrl: string | null | undefined): string {
  if (!rawUrl) return '#'
  if (!AMAZON_TAG) return rawUrl
  if (!/^https?:\/\//i.test(rawUrl)) return rawUrl
  let parsed: URL
  try {
    parsed = new URL(rawUrl)
  } catch {
    return rawUrl
  }
  if (!AMAZON_RE.test(parsed.hostname.toLowerCase())) return rawUrl
  parsed.searchParams.set('tag', AMAZON_TAG)
  return parsed.toString()
}

export function toAffiliateUrl(rawUrl: string | null | undefined): string {
  if (!rawUrl) return '#'

  // mailto, tel, hash, javascript: — never touch
  if (!/^https?:\/\//i.test(rawUrl)) return rawUrl

  let parsed: URL
  try {
    parsed = new URL(rawUrl)
  } catch {
    return rawUrl
  }

  const host = parsed.hostname.toLowerCase()
  if (SKIP_HOSTS.some((h) => host === h || host.endsWith('.' + h))) return rawUrl

  // Amazon: tag it ourselves, don't route through Skimlinks.
  if (AMAZON_RE.test(host)) return addAmazonTag(rawUrl)

  // Everything else: Skimlinks wrap (if configured).
  if (!SKIM_ID) return rawUrl
  return `https://go.skimresources.com/?id=${encodeURIComponent(SKIM_ID)}&xs=1&url=${encodeURIComponent(rawUrl)}`
}
