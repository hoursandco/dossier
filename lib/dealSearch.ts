export interface SearchableDeal {
  retailer?: string | null
  description?: string | null
  deal_subtype?: string | null
  keywords?: string[] | null
}

function normalizeWords(value: string): string {
  return value
    .toLowerCase()
    .replace(/['’`]/g, '')
    .replace(/[^a-z0-9]+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

function singularizeWord(word: string): string {
  if (word.length <= 3) return word
  if (word.endsWith('ies') && word.length > 4) return `${word.slice(0, -3)}y`
  if (/(ches|shes|xes|zes|sses)$/.test(word)) return word.slice(0, -2)
  if (word.endsWith('s') && !word.endsWith('ss')) return word.slice(0, -1)
  return word
}

function normalizeComparable(value: string): string {
  return normalizeWords(value)
    .split(' ')
    .filter((word) => word !== 'and')
    .map(singularizeWord)
    .join(' ')
}

function includesPhrase(value: string, term: string): boolean {
  const haystack = ` ${normalizeComparable(value)} `
  const needle = normalizeComparable(term)
  return needle.length > 0 && haystack.includes(` ${needle} `)
}

export function dealMatchesSearchTerm(deal: SearchableDeal, rawTerm: string): boolean {
  const term = normalizeComparable(rawTerm)
  if (!term) return false

  const retailer = normalizeComparable(deal.retailer ?? '')
  if (retailer === term || includesPhrase(deal.retailer ?? '', rawTerm)) return true

  if ((deal.keywords ?? []).some((keyword) => {
    const normalizedKeyword = normalizeComparable(keyword)
    return normalizedKeyword === term ||
      includesPhrase(keyword, rawTerm) ||
      includesPhrase(rawTerm, keyword)
  })) {
    return true
  }

  return includesPhrase(deal.deal_subtype ?? '', rawTerm) ||
    includesPhrase(deal.description ?? '', rawTerm)
}

export function dealMatchesAnySearchTerm(
  deal: SearchableDeal,
  terms: string[],
): boolean {
  return terms.some((term) => dealMatchesSearchTerm(deal, term))
}
