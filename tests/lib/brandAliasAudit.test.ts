import { describe, expect, it } from 'vitest'
import { buildBrandAliasCandidates } from '@/lib/brandAliasAudit'

const stores = [
  { id: 'vs', name: "Victoria's Secret", website: 'https://victoriassecret.com', status: 'active', is_active: true },
  { id: 'pink', name: 'PINK', website: 'https://victoriassecret.com/us/pink', status: 'active', is_active: true },
  { id: 'ae', name: 'American Eagle Outfitters', website: 'https://www.ae.com/us/en', status: 'active', is_active: true },
  { id: 'aerie', name: 'Aerie', website: 'https://aerie.com', status: 'active', is_active: true },
  { id: 'jcrew', name: 'J.Crew', website: 'https://jcrew.com', status: 'active', is_active: true },
  { id: 'factory', name: 'J.Crew Factory', website: 'https://factory.jcrew.com', status: 'active', is_active: true },
]

describe('buildBrandAliasCandidates', () => {
  it('finds brands sharing an apex domain and suggests the root storefront as parent', () => {
    const candidates = buildBrandAliasCandidates(stores)
    const vsPink = candidates.find((candidate) => candidate.key.includes('vs') && candidate.key.includes('pink'))

    expect(vsPink?.confidence).toBe('high')
    expect(vsPink?.parent_store_id).toBe('vs')
    expect(vsPink?.evidence.some((item) => item.kind === 'shared-domain')).toBe(true)
  })

  it('includes curated family hints when related brands use separate domains', () => {
    const candidates = buildBrandAliasCandidates(stores)
    const aeAerie = candidates.find((candidate) => candidate.key.includes('ae') && candidate.key.includes('aerie'))

    expect(aeAerie?.confidence).toBe('medium')
    expect(aeAerie?.parent_store_id).toBe('ae')
    expect(aeAerie?.evidence).toContainEqual({
      kind: 'curated-family',
      label: 'Aerie is an American Eagle brand',
    })
  })

  it('uses recent deal counts as review context without creating relationships', () => {
    const candidates = buildBrandAliasCandidates(stores, [
      { retailer: 'PINK', original_link: 'https://victoriassecret.com/us/pink/sale' },
      { retailer: 'PINK', original_link: 'https://victoriassecret.com/us/pink/clearance' },
      { retailer: "Victoria's Secret", original_link: 'https://victoriassecret.com/sale' },
    ])
    const vsPink = candidates.find((candidate) => candidate.key.includes('vs') && candidate.key.includes('pink'))

    expect(vsPink?.recent_deals).toEqual({ left: 2, right: 1 })
    expect(vsPink?.evidence.some((item) => item.kind === 'deal-link-domain')).toBe(true)
  })

  it('does not suggest punctuation-only duplicate names as aliases', () => {
    const candidates = buildBrandAliasCandidates([
      { id: 'one', name: 'J.Crew', website: 'https://jcrew.com', status: 'active', is_active: true },
      { id: 'two', name: 'J Crew', website: 'https://www.jcrew.com', status: 'active', is_active: true },
    ])

    expect(candidates).toEqual([])
  })
})
