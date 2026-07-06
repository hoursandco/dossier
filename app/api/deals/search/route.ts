import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import {
  dealMatchesAnySearchTerm,
  expandCategorySearchTerms,
  type CategorySearchRow,
} from '@/lib/dealSearch'
import {
  brandNamesIncludingAliases,
  relatedBrandNamesForTarget,
  type RelationshipStore,
} from '@/lib/brandRelationships'
import {
  expandItemSearchTerms,
  type ItemKeywordReview,
} from '@/lib/itemCuration'

export const dynamic = 'force-dynamic'

function normalizeRetailerName(value: string): string {
  return value.toLowerCase().replace(/[^a-z0-9]/g, '')
}

export async function GET(request: NextRequest) {
  // ?keywords=body+care,soap,lotion  — OR search across multiple terms
  // ?keyword=jeans                   — single term (legacy, treated as keywords=[jeans])
  // ?retailer=Roaman%27s             — brand search
  const keywordsParam = request.nextUrl.searchParams.get('keywords')?.trim() ?? ''
  const keywordParam  = request.nextUrl.searchParams.get('keyword')?.trim() ?? ''
  const retailer      = request.nextUrl.searchParams.get('retailer')?.trim() ?? ''

  const rawKeywords = keywordsParam
    ? keywordsParam.split(',').map((k) => k.trim().toLowerCase()).filter(Boolean)
    : keywordParam
    ? [keywordParam.toLowerCase()]
    : []

  let keywords = Array.from(new Set(rawKeywords))

  if (keywords.length === 0 && !retailer) {
    return NextResponse.json({ deals: [] })
  }

  const supabase = createServiceClient()

  if (keywords.length > 0) {
    // Keyword curation lives on the keywords vocabulary table itself
    // (migration 056); only the curated slice matters for expansion.
    const { data: itemReviews, error: itemReviewsError } = await supabase
      .from('keywords')
      .select('keyword, canonical_keyword, parent_keyword, is_hidden')
      .or('canonical_keyword.not.is.null,parent_keyword.not.is.null,is_hidden.eq.true')
      .limit(5000)
    if (!itemReviewsError) {
      keywords = expandItemSearchTerms(
        keywords,
        (itemReviews ?? []) as ItemKeywordReview[],
      )
    }

    // Category aliases: "skin care" (or the label "Skincare") expands to the
    // canonical slug so category-tagged deals match. Skipped silently if the
    // search_terms column isn't there yet (migration 050 not applied).
    const { data: categoryRows, error: categoryError } = await supabase
      .from('categories')
      .select('slug, label, search_terms')
      .eq('is_active', true)
    if (!categoryError) {
      keywords = expandCategorySearchTerms(
        keywords,
        (categoryRows ?? []) as CategorySearchRow[],
      )
    }
  }

  const today = new Date().toISOString().slice(0, 10)
  const cutoff = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString()
  let retailerNames = retailer ? brandNamesIncludingAliases([retailer]) : []

  if (retailer) {
    const { data: directoryRows } = await supabase
      .from('stores')
      .select('id, name, parent_store_id, alias_of_store_id')
      .eq('status', 'active')
      .eq('is_active', true)
      .limit(5000)
    const directory = (directoryRows ?? []) as RelationshipStore[]
    const targetStore = directory.find(
      (store) => normalizeRetailerName(store.name) === normalizeRetailerName(retailer),
    )
    if (targetStore) {
      retailerNames = relatedBrandNamesForTarget(targetStore.id, directory)
    }
  }

  const SELECT =
    'id, retailer, description, percent_off, deal_type, promo_code, expiration_date, original_link, affiliate_link, categories, keywords, redemption_channel, week_of, created_at, last_seen_at, source_email_link, image_url, image_alt, image_expires_at'

  let query = supabase
    .from('deals')
    .select(SELECT)
    .order('last_seen_at', { ascending: false, nullsFirst: false })
    .order('created_at', { ascending: false })
    // Keyword matching is intentionally finished in JS below. Postgres array
    // overlap only supports exact values, which made normal searches such as
    // "shoe" vs "shoes" fail and ignored product text in descriptions.
    .limit(retailer ? 1000 : 1000)

  if (retailer) {
    // Fetch the recent pool and finish matching in JS. Parent-brand reviews
    // can expand one selected store to multiple retailer names, which cannot
    // be represented safely by the old single ilike pattern.
    query = query
      .or(`expiration_date.is.null,expiration_date.gte.${today}`)
      .gte('last_seen_at', cutoff)
  } else {
    query = query
      .or(`expiration_date.is.null,expiration_date.gte.${today}`)
      .gte('last_seen_at', cutoff)
  }

  const { data, error } = await query

  if (error) {
    console.error('[deals/search] error:', JSON.stringify(error))
    return NextResponse.json({ deals: [], debug_error: error }, { status: 500 })
  }

  const deals = retailer
    ? (data ?? []).filter((d) => {
        const normalized = normalizeRetailerName(d.retailer ?? '')
        return retailerNames.some((name) => normalizeRetailerName(name) === normalized)
      })
    : (data ?? [])
        .filter((d) => dealMatchesAnySearchTerm(d, keywords, {
          includeRetailer: false,
          includeDescription: false,
        }))
        .slice(0, 50)

  console.log(`[deals/search] retailer="${retailer}" → ${deals.length} rows`)
  if (retailer && deals.length === 0) {
    return NextResponse.json({ deals: [], _debug: { retailer, rows: 0 } })
  }

  const retailers = [...new Set(deals.map((d) => d.retailer).filter(Boolean))]
  const retailerKeys = new Set(retailers.map((name) => normalizeRetailerName(name)))
  const storeWebsiteByRetailer: Record<string, string> = {}
  const storeTierByRetailer: Record<string, string> = {}
  if (retailers.length > 0) {
    // Pull the active store directory and match in JS so punctuation/case
    // drift never leaves a google-search fallback in the UI.
    const { data: storeRows } = await supabase
      .from('stores')
      .select('name, website, price_tier')
      .eq('status', 'active')
      .eq('is_active', true)
    if (storeRows) {
      for (const row of storeRows) {
        if (!row.name) continue
        const normalizedName = normalizeRetailerName(row.name)
        if (!retailerKeys.has(normalizedName)) continue
        const keys = [row.name, normalizeRetailerName(row.name)]
        for (const key of keys) {
          if (row.website) storeWebsiteByRetailer[key] = row.website
          if (row.price_tier) storeTierByRetailer[key] = row.price_tier
        }
      }
    }
  }

  const enriched = deals.map((d) => {
    const retailerKey = normalizeRetailerName(d.retailer ?? '')
    const priceTier = storeTierByRetailer[d.retailer] ?? storeTierByRetailer[retailerKey] ?? null
    const website = storeWebsiteByRetailer[d.retailer] ?? storeWebsiteByRetailer[retailerKey] ?? null
    const affiliateLink = d.affiliate_link?.includes('google.com/search') ? null : d.affiliate_link
    const imageExpired = d.image_expires_at && new Date(d.image_expires_at).getTime() <= Date.now()
    const imageFields = imageExpired
      ? { image_url: null, image_alt: null, image_expires_at: null }
      : {}
    if (!d.affiliate_link && d.original_link.includes('google.com/search')) {
      if (website) return { ...d, ...imageFields, affiliate_link: affiliateLink, original_link: website, store_website: website, price_tier: priceTier }
    }
    return { ...d, ...imageFields, affiliate_link: affiliateLink, store_website: website, price_tier: priceTier }
  })

  return NextResponse.json({ deals: enriched })
}
