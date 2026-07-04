export interface SearchableDeal {
  retailer?: string | null
  description?: string | null
  keywords?: string[] | null
  categories?: string[] | null
}

export interface DealSearchOptions {
  includeRetailer?: boolean
  includeDescription?: boolean
  includeCategories?: boolean
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

function matchesKeyword(keyword: string, rawTerm: string, term: string): boolean {
  const normalizedKeyword = normalizeComparable(keyword)
  return normalizedKeyword === term ||
    includesPhrase(keyword, rawTerm)
}

export function dealMatchesSearchTerm(
  deal: SearchableDeal,
  rawTerm: string,
  options: DealSearchOptions = {},
): boolean {
  const {
    includeRetailer = true,
    includeDescription = true,
    includeCategories = true,
  } = options
  const term = normalizeComparable(rawTerm)
  if (!term) return false

  if (includeRetailer) {
    const retailer = normalizeComparable(deal.retailer ?? '')
    if (retailer === term || includesPhrase(deal.retailer ?? '', rawTerm)) return true
  }

  if ((deal.keywords ?? []).some((keyword) => matchesKeyword(keyword, rawTerm, term))) {
    return true
  }

  if (
    includeCategories &&
    (deal.categories ?? []).some((category) => matchesKeyword(category, rawTerm, term))
  ) {
    return true
  }

  return includeDescription && includesPhrase(deal.description ?? '', rawTerm)
}

export function dealMatchesAnySearchTerm(
  deal: SearchableDeal,
  terms: string[],
  options?: DealSearchOptions,
): boolean {
  return terms.some((term) => dealMatchesSearchTerm(deal, term, options))
}

export interface CategorySearchRow {
  slug: string
  label?: string | null
  search_terms?: string[] | null
}

// Map free-typed search terms onto canonical category slugs. A term that
// matches a category's slug, label, or one of its search_terms aliases
// ("skin care" → skincare) expands to include the slug itself, which is
// what deals.categories and stores.categories store verbatim.
export function expandCategorySearchTerms(
  terms: string[],
  categories: CategorySearchRow[],
): string[] {
  const slugByAlias = new Map<string, string>()
  for (const category of categories) {
    const aliases = [category.slug, category.label ?? '', ...(category.search_terms ?? [])]
    for (const alias of aliases) {
      const key = normalizeComparable(alias)
      if (key && !slugByAlias.has(key)) slugByAlias.set(key, category.slug)
    }
  }

  const expanded = new Set<string>()
  for (const term of terms) {
    expanded.add(term)
    const slug = slugByAlias.get(normalizeComparable(term))
    if (slug) expanded.add(slug)
  }
  return [...expanded]
}
