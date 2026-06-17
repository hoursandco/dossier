import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

function normalizeSuggestion(value: string): string {
  return value.toLowerCase().replace(/[^a-z0-9]/g, '')
}

// Group similar keyword variants under one suggestion. Strips apostrophes and
// trailing " gift" / " gifts" so "father's day", "fathers day gift", and
// "fathers day gifts" all collapse to the same entry.
function normalizeKeywordForDedup(kw: string): string {
  return kw.toLowerCase()
    .replace(/[''`]/g, '')
    .replace(/\s+gifts?\s*$/, '')
    .trim()
}

// Build a fuzzy store-name pattern from a user query by treating "&" and the
// word "and" as interchangeable noise connectors.  Strips them out, then
// joins remaining words with "%" wildcards, producing a pattern like
// `%bath%body%works%` that matches "Bath & Body Works", "Bath and Body Works",
// "bath and body works", etc. regardless of punctuation or connector phrasing.
function buildStorePattern(q: string): string {
  const words = q
    .replace(/&/g, ' ')
    .split(/\s+/)
    .map((w) => w.replace(/[^a-zA-Z0-9']/g, ''))
    .filter((w) => w.length > 0 && w.toLowerCase() !== 'and')
  if (words.length === 0) return `%${q}%`
  return '%' + words.join('%') + '%'
}

export async function GET(request: NextRequest) {
  const q = request.nextUrl.searchParams.get('q')?.trim() ?? ''

  if (!q) {
    return NextResponse.json({ keywords: [] })
  }

  const supabase = createServiceClient()

  const storePattern = buildStorePattern(q)

  const [keywordsResult, storesResult] = await Promise.all([
    supabase
      .from('keywords')
      .select('keyword, deal_count')
      .ilike('keyword', `${q}%`)
      .order('keyword', { ascending: true })
      .limit(12),
    supabase
      .from('stores')
      .select('name')
      .ilike('name', storePattern)
      .eq('status', 'active')
      .eq('is_active', true)
      .limit(12),
  ])

  const storeRows = storesResult.data ?? []
  const exactBrands = storeRows.filter(
    (s) => normalizeSuggestion(s.name) === normalizeSuggestion(q)
  )
  const brandRows = exactBrands.length > 0 ? exactBrands : storeRows

  const brands = brandRows.map((s) => ({
    keyword: s.name,
    deal_count: 0,
    type: 'brand' as const,
  }))

  const keywords = (keywordsResult.data ?? []).map((k) => ({
    ...k,
    type: 'keyword' as const,
  }))

  type Suggestion = { keyword: string; deal_count: number; type: 'brand' | 'keyword' }

  // Deduplicate by lowercased keyword — prefer brands over keywords, then
  // higher deal_count. This prevents the same word appearing twice when the
  // keywords table has both a capitalized and a lowercase variant.
  const seen = new Map<string, Suggestion>()
  for (const item of [...brands, ...keywords]) {
    const key = normalizeKeywordForDedup(item.keyword)
    const existing = seen.get(key)
    if (!existing) { seen.set(key, item); continue }
    // Brands always win over keyword rows
    if (item.type === 'brand' && existing.type !== 'brand') { seen.set(key, item); continue }
    // Among same type, prefer shorter label (base term over "gift" variant),
    // then higher deal_count as tiebreaker
    if (item.type === existing.type) {
      if (item.keyword.length < existing.keyword.length) { seen.set(key, item); continue }
      if (item.keyword.length === existing.keyword.length && item.deal_count > existing.deal_count) seen.set(key, item)
    }
  }

  const merged = Array.from(seen.values())
    .sort((a, b) => a.keyword.localeCompare(b.keyword, undefined, { sensitivity: 'base' }))
    .slice(0, 12)

  return NextResponse.json({ keywords: merged })
}
