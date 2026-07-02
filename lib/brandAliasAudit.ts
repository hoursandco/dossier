import { normalizeRetailerWebsite } from '@/lib/domainNormalize'
import type { BrandRelationshipDecision } from '@/lib/brandRelationships'

export type AliasAuditStore = {
  id: string
  name: string
  website: string | null
  status: string | null
  is_active: boolean
}

export type AliasAuditDeal = {
  retailer: string | null
  original_link: string | null
}

export type AliasAuditScan = {
  retailer: string | null
  sender_email: string | null
}

export type AliasEvidence = {
  kind: 'shared-domain' | 'deal-link-domain' | 'sender-domain' | 'name-family' | 'curated-family'
  label: string
}

export type AliasCandidate = {
  key: string
  confidence: 'high' | 'medium' | 'low'
  score: number
  parent_store_id: string | null
  parent_name: string | null
  left: AliasAuditStore
  right: AliasAuditStore
  evidence: AliasEvidence[]
  recent_deals: { left: number; right: number }
  review?: {
    decision: BrandRelationshipDecision
    parent_store_id: string | null
    child_store_id: string | null
    updated_at: string | null
  } | null
}

type DirectionHint = {
  parent: string
  child: string
  label: string
}

// Separate domains make these important families impossible to discover from
// URL evidence alone. They are audit hints only: nothing here creates an alias.
const CURATED_FAMILY_HINTS: DirectionHint[] = [
  { parent: "Victoria's Secret", child: 'PINK', label: "PINK is a Victoria's Secret sub-brand" },
  { parent: 'American Eagle Outfitters', child: 'Aerie', label: 'Aerie is an American Eagle brand' },
  { parent: 'Gap', child: 'Gap Factory', label: 'Gap Factory is the outlet brand for Gap' },
  { parent: 'J.Crew', child: 'J.Crew Factory', label: 'J.Crew Factory is the outlet brand for J.Crew' },
  { parent: 'Abercrombie & Fitch', child: 'Hollister', label: 'Hollister is an Abercrombie & Fitch brand' },
  { parent: 'Saks Fifth Avenue', child: 'Saks OFF 5TH', label: 'Saks OFF 5TH is the Saks outlet brand' },
]

// Shared infrastructure and marketplace domains do not imply brand ownership.
// A cluster larger than this is also almost certainly a platform/domain
// normalization artifact rather than one reviewable brand family.
const NON_BRAND_DOMAINS = new Set([
  'amazon.com',
  'facebook.com',
  'gmail.com',
  'google.com',
  'instagram.com',
  'linktr.ee',
  'shopify.com',
  'youtube.com',
])
const MAX_REVIEWABLE_DOMAIN_CLUSTER = 8

export function normalizeBrandName(value: string | null | undefined): string {
  return (value ?? '').toLowerCase().replace(/[^a-z0-9]/g, '')
}

function domainFromEmail(value: string | null | undefined): string | null {
  if (!value) return null
  const match = value.toLowerCase().match(/@([a-z0-9.-]+\.[a-z]{2,})/)
  return match ? normalizeRetailerWebsite(match[1]) : null
}

function pairKey(a: AliasAuditStore, b: AliasAuditStore): string {
  return [a.id, b.id].sort().join('::')
}

function confidenceFor(score: number): AliasCandidate['confidence'] {
  if (score >= 90) return 'high'
  if (score >= 55) return 'medium'
  return 'low'
}

function looksLikeNameFamily(a: string, b: string): boolean {
  if (a === b || a.length < 5 || b.length < 5) return false
  const shorter = a.length < b.length ? a : b
  const longer = a.length < b.length ? b : a
  return longer.startsWith(shorter) && longer.length - shorter.length >= 4
}

export function buildBrandAliasCandidates(
  stores: AliasAuditStore[],
  deals: AliasAuditDeal[] = [],
  scans: AliasAuditScan[] = [],
): AliasCandidate[] {
  const activeStores = stores.filter((store) => store.name && store.status !== 'declined')
  const storesByName = new Map(activeStores.map((store) => [normalizeBrandName(store.name), store]))
  const dealCountByName = new Map<string, number>()
  for (const deal of deals) {
    const key = normalizeBrandName(deal.retailer)
    if (key) dealCountByName.set(key, (dealCountByName.get(key) ?? 0) + 1)
  }

  const candidates = new Map<string, {
    left: AliasAuditStore
    right: AliasAuditStore
    score: number
    parentId: string | null
    evidence: AliasEvidence[]
  }>()

  const add = (
    a: AliasAuditStore,
    b: AliasAuditStore,
    points: number,
    evidence: AliasEvidence,
    parentId: string | null = null,
  ) => {
    if (a.id === b.id || normalizeBrandName(a.name) === normalizeBrandName(b.name)) return
    const key = pairKey(a, b)
    const existing = candidates.get(key)
    if (existing) {
      if (!existing.evidence.some((item) => item.kind === evidence.kind && item.label === evidence.label)) {
        existing.evidence.push(evidence)
        existing.score += points
      }
      if (!existing.parentId && parentId) existing.parentId = parentId
      return
    }
    const [left, right] = a.name.localeCompare(b.name) <= 0 ? [a, b] : [b, a]
    candidates.set(key, { left, right, score: points, parentId, evidence: [evidence] })
  }

  const storesByDomain = new Map<string, AliasAuditStore[]>()
  for (const store of activeStores) {
    const domain = normalizeRetailerWebsite(store.website)
    if (!domain) continue
    const group = storesByDomain.get(domain) ?? []
    group.push(store)
    storesByDomain.set(domain, group)
  }
  for (const [domain, group] of storesByDomain) {
    const host = domain.replace(/^https:\/\//, '')
    if (
      group.length < 2 ||
      group.length > MAX_REVIEWABLE_DOMAIN_CLUSTER ||
      NON_BRAND_DOMAINS.has(host)
    ) continue
    for (let i = 0; i < group.length; i++) {
      for (let j = i + 1; j < group.length; j++) {
        const a = group[i]
        const b = group[j]
        const aPathLength = (a.website ?? '').replace(/^https?:\/\/[^/]+/i, '').length
        const bPathLength = (b.website ?? '').replace(/^https?:\/\/[^/]+/i, '').length
        const parentId = aPathLength === bPathLength ? null : (aPathLength < bPathLength ? a.id : b.id)
        add(a, b, 90, {
          kind: 'shared-domain',
          label: `Both storefronts resolve to ${domain.replace(/^https:\/\//, '')}`,
        }, parentId)
      }
    }
  }

  const retailersByDealDomain = new Map<string, Set<string>>()
  for (const deal of deals) {
    const domain = normalizeRetailerWebsite(deal.original_link)
    const retailer = normalizeBrandName(deal.retailer)
    if (!domain || !retailer) continue
    const names = retailersByDealDomain.get(domain) ?? new Set<string>()
    names.add(retailer)
    retailersByDealDomain.set(domain, names)
  }
  for (const [domain, names] of retailersByDealDomain) {
    if (NON_BRAND_DOMAINS.has(domain.replace(/^https:\/\//, ''))) continue
    const matched = [...names].map((name) => storesByName.get(name)).filter(Boolean) as AliasAuditStore[]
    if (matched.length > MAX_REVIEWABLE_DOMAIN_CLUSTER) continue
    for (let i = 0; i < matched.length; i++) {
      for (let j = i + 1; j < matched.length; j++) {
        add(matched[i], matched[j], 35, {
          kind: 'deal-link-domain',
          label: `Recent deals from both brands link to ${domain.replace(/^https:\/\//, '')}`,
        })
      }
    }
  }

  const retailersBySenderDomain = new Map<string, Set<string>>()
  for (const scan of scans) {
    const domain = domainFromEmail(scan.sender_email)
    const retailer = normalizeBrandName(scan.retailer)
    if (!domain || !retailer) continue
    const names = retailersBySenderDomain.get(domain) ?? new Set<string>()
    names.add(retailer)
    retailersBySenderDomain.set(domain, names)
  }
  for (const [domain, names] of retailersBySenderDomain) {
    if (NON_BRAND_DOMAINS.has(domain.replace(/^https:\/\//, ''))) continue
    const matched = [...names].map((name) => storesByName.get(name)).filter(Boolean) as AliasAuditStore[]
    if (matched.length > MAX_REVIEWABLE_DOMAIN_CLUSTER) continue
    for (let i = 0; i < matched.length; i++) {
      for (let j = i + 1; j < matched.length; j++) {
        add(matched[i], matched[j], 45, {
          kind: 'sender-domain',
          label: `Newsletter records for both brands use ${domain.replace(/^https:\/\//, '')}`,
        })
      }
    }
  }

  for (let i = 0; i < activeStores.length; i++) {
    for (let j = i + 1; j < activeStores.length; j++) {
      const a = activeStores[i]
      const b = activeStores[j]
      const an = normalizeBrandName(a.name)
      const bn = normalizeBrandName(b.name)
      if (!looksLikeNameFamily(an, bn)) continue
      const parent = an.length < bn.length ? a : b
      add(a, b, 55, {
        kind: 'name-family',
        label: `One brand name extends the other (${parent.name})`,
      }, parent.id)
    }
  }

  for (const hint of CURATED_FAMILY_HINTS) {
    const parent = storesByName.get(normalizeBrandName(hint.parent))
    const child = storesByName.get(normalizeBrandName(hint.child))
    if (!parent || !child) continue
    add(parent, child, 70, { kind: 'curated-family', label: hint.label }, parent.id)
  }

  return [...candidates.entries()]
    .map(([key, candidate]) => {
      const parent = candidate.parentId
        ? [candidate.left, candidate.right].find((store) => store.id === candidate.parentId) ?? null
        : null
      return {
        key,
        score: candidate.score,
        confidence: confidenceFor(candidate.score),
        parent_store_id: parent?.id ?? null,
        parent_name: parent?.name ?? null,
        left: candidate.left,
        right: candidate.right,
        evidence: candidate.evidence,
        recent_deals: {
          left: dealCountByName.get(normalizeBrandName(candidate.left.name)) ?? 0,
          right: dealCountByName.get(normalizeBrandName(candidate.right.name)) ?? 0,
        },
      }
    })
    // One weak domain coincidence is not worth an admin's time. Keep pairs
    // with a strong signal or multiple supporting signals.
    .filter((candidate) => candidate.score >= 55)
    .sort((a, b) => b.score - a.score || a.left.name.localeCompare(b.left.name))
}
