import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

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

  // Expand each keyword to include apostrophe variants so "fathers day"
  // matches deals tagged "father's day" and vice versa.
  const keywords = Array.from(new Set(
    rawKeywords.flatMap((k) => {
      const stripped = k.replace(/[''`]/g, '')                        // "father's day" → "fathers day"
      const apostrophied = stripped.replace(/([^aeiou\s])s(\s|$)/g, "$1's$2") // "fathers day" → "father's day"
      return [k, stripped, apostrophied]
    })
  ))

  if (keywords.length === 0 && !retailer) {
    return NextResponse.json({ deals: [] })
  }

  const supabase = createServiceClient()

  const today = new Date().toISOString().slice(0, 10)
  const cutoff = new Date(Date.now() - 14 * 24 * 60 * 60 * 1000).toISOString().slice(0, 10)

  const SELECT =
    'id, retailer, description, percent_off, deal_type, promo_code, expiration_date, original_link, affiliate_link, categories, keywords, deal_subtype, week_of, created_at, source_email_link'

  let query = supabase
    .from('deals')
    .select(SELECT)
    .order('created_at', { ascending: false })
    .limit(retailer ? 200 : 50)

  if (retailer) {
    // Retailer searches must be exact after punctuation/case normalization:
    // "Gap" is not "Gap Factory", and "J.Crew" is not "J.Crew Factory".
    // We fetch recent, unexpired rows with a broad prefix-ish pattern for
    // punctuation tolerance, then enforce the exact normalized match in JS.
    const pattern = `%${retailer.replace(/[''`]/g, '').replace(/\s+/g, '%')}%`
    console.log('[deals/search] retailer query — exact:', retailer, 'pattern:', pattern)
    query = query
      .ilike('retailer', pattern)
      .or(`expiration_date.is.null,expiration_date.gte.${today}`)
      .gte('created_at', cutoff)
  } else {
    // overlaps() returns deals where the deal's keywords array shares ANY
    // element with the search terms — this is the OR logic needed for
    // multi-keyword searches ("body care" + "soap" + "lotion").
    query = query
      .overlaps('keywords', keywords)
      .or(`expiration_date.is.null,expiration_date.gte.${today}`)
      .gte('created_at', cutoff)
  }

  const { data, error } = await query

  if (error) {
    console.error('[deals/search] error:', JSON.stringify(error))
    return NextResponse.json({ deals: [], debug_error: error }, { status: 500 })
  }

  const deals = retailer
    ? (data ?? []).filter((d) => normalizeRetailerName(d.retailer ?? '') === normalizeRetailerName(retailer))
    : (data ?? [])

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
    if (!d.affiliate_link && d.original_link.includes('google.com/search')) {
      if (website) return { ...d, affiliate_link: affiliateLink, original_link: website, store_website: website, price_tier: priceTier }
    }
    return { ...d, affiliate_link: affiliateLink, store_website: website, price_tier: priceTier }
  })

  return NextResponse.json({ deals: enriched })
}
