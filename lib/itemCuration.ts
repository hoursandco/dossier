export type ItemKeywordReview = {
  keyword: string
  canonical_keyword: string | null
  parent_keyword?: string | null
  is_hidden: boolean
}

export type ItemSuggestion = {
  keyword: string
  deal_count: number
  type: 'keyword'
}

function normalizeItem(value: string): string {
  return value.toLowerCase().replace(/\s+/g, ' ').trim()
}

export function expandItemSearchTerms(
  terms: string[],
  reviews: ItemKeywordReview[],
): string[] {
  const canonicalByKeyword = new Map(
    reviews
      .filter((review) => review.canonical_keyword && !review.is_hidden)
      .map((review) => [
        normalizeItem(review.keyword),
        normalizeItem(review.canonical_keyword!),
      ]),
  )
  const aliasesByCanonical = new Map<string, Set<string>>()
  const childrenByParent = new Map<string, Set<string>>()
  for (const [keyword, canonical] of canonicalByKeyword) {
    const aliases = aliasesByCanonical.get(canonical) ?? new Set<string>()
    aliases.add(keyword)
    aliasesByCanonical.set(canonical, aliases)
  }
  for (const review of reviews) {
    if (review.is_hidden) continue
    if (!review.parent_keyword) continue
    const parent = normalizeItem(review.parent_keyword)
    const child = normalizeItem(review.keyword)
    if (!parent || !child) continue
    const children = childrenByParent.get(parent) ?? new Set<string>()
    children.add(child)
    childrenByParent.set(parent, children)
  }

  const expanded = new Set<string>()
  for (const rawTerm of terms) {
    const term = normalizeItem(rawTerm)
    if (!term) continue
    const canonical = canonicalByKeyword.get(term) ?? term
    expanded.add(term)
    expanded.add(canonical)
    for (const alias of aliasesByCanonical.get(canonical) ?? []) expanded.add(alias)
    for (const child of childrenByParent.get(canonical) ?? []) {
      expanded.add(child)
      const childCanonical = canonicalByKeyword.get(child)
      if (childCanonical) expanded.add(childCanonical)
      for (const alias of aliasesByCanonical.get(childCanonical ?? child) ?? []) expanded.add(alias)
    }
  }
  return [...expanded]
}

export function curateItemSuggestions(
  suggestions: ItemSuggestion[],
  reviews: ItemKeywordReview[],
): ItemSuggestion[] {
  const reviewByKeyword = new Map(
    reviews.map((review) => [normalizeItem(review.keyword), review]),
  )
  const merged = new Map<string, ItemSuggestion>()

  for (const suggestion of suggestions) {
    const source = normalizeItem(suggestion.keyword)
    const review = reviewByKeyword.get(source)
    if (review?.is_hidden && !review.canonical_keyword) continue

    const label = normalizeItem(review?.canonical_keyword ?? suggestion.keyword)
    if (!label) continue
    const existing = merged.get(label)
    if (existing) {
      existing.deal_count += suggestion.deal_count
    } else {
      merged.set(label, { ...suggestion, keyword: label })
    }
  }

  return [...merged.values()]
}
