import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  // ?keywords=body+care,soap,lotion  — OR search across multiple terms
  // ?keyword=jeans                   — single term (legacy, treated as keywords=[jeans])
  // ?retailer=Roaman%27s             — brand search
  const keywordsParam = request.nextUrl.searchParams.get('keywords')?.trim() ?? ''
  const keywordParam  = request.nextUrl.searchParams.get('keyword')?.trim() ?? ''
  const retailer      = request.nextUrl.searchParams.get('retailer')?.trim() ?? ''

  const keywords = keywordsParam
    ? keywordsParam.split(',').map((k) => k.trim().toLowerCase()).filter(Boolean)
    : keywordParam
    ? [keywordParam.toLowerCase()]
    : []

  if (keywords.length === 0 && !retailer) {
    return NextResponse.json({ deals: [] })
  }

  const supabase = createServiceClient()

  const today = new Date().toISOString().slice(0, 10)

  const SELECT =
    'id, retailer, description, percent_off, deal_type, promo_code, expiration_date, original_link, affiliate_link, categories, keywords, deal_subtype, week_of, created_at, source_email_link'

  let query = supabase
    .from('deals')
    .select(SELECT)
    .order('created_at', { ascending: false })
    .limit(50)

  if (retailer) {
    // Strip apostrophes/curly-quotes so "Roaman's" matches "Roamans" in the DB
    // and vice versa. No date filter — show all deals for this brand, newest first.
    const pattern = `%${retailer.replace(/[''`]/g, '')}%`
    console.log('[deals/search] retailer query — pattern:', pattern)
    query = query.ilike('retailer', pattern)
  } else {
    // overlaps() returns deals where the deal's keywords array shares ANY
    // element with the search terms — this is the OR logic needed for
    // multi-keyword searches ("body care" + "soap" + "lotion").
    query = query
      .overlaps('keywords', keywords)
      .or(`expiration_date.is.null,expiration_date.gte.${today}`)
  }

  const { data, error } = await query

  if (error) {
    console.error('[deals/search] error:', JSON.stringify(error))
    return NextResponse.json({ deals: [], debug_error: error }, { status: 500 })
  }

  console.log(`[deals/search] retailer="${retailer}" → ${data?.length ?? 0} rows`)
  if (retailer && (data?.length ?? 0) === 0) {
    return NextResponse.json({ deals: [], _debug: { retailer, pattern: `%${retailer.replace(/[''`]/g, '')}%`, rows: 0 } })
  }

  const deals = data ?? []

  // For deals where original_link is a Google search fallback, look up the
  // store's actual website so the UI can show a real brand URL instead.
  const retailersNeedingWebsite = [
    ...new Set(
      deals
        .filter((d) => !d.affiliate_link && d.original_link.includes('google.com/search'))
        .map((d) => d.retailer)
    ),
  ]

  let storeWebsiteByRetailer: Record<string, string> = {}
  if (retailersNeedingWebsite.length > 0) {
    const { data: storeRows } = await supabase
      .from('stores')
      .select('name, website')
      .in('name', retailersNeedingWebsite)
    if (storeRows) {
      for (const row of storeRows) {
        if (row.name && row.website) storeWebsiteByRetailer[row.name] = row.website
      }
    }
  }

  const enriched = deals.map((d) => {
    if (!d.affiliate_link && d.original_link.includes('google.com/search')) {
      const website = storeWebsiteByRetailer[d.retailer]
      if (website) return { ...d, original_link: website }
    }
    return d
  })

  return NextResponse.json({ deals: enriched })
}
