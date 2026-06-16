import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  const keyword = request.nextUrl.searchParams.get('keyword')?.trim() ?? ''

  if (!keyword) {
    return NextResponse.json({ deals: [] })
  }

  const supabase = createServiceClient()

  const today = new Date().toISOString().slice(0, 10)

  // Match deals where the keyword appears in the keywords array.
  // Also include deals where expiration_date is null (no stated expiry)
  // or is today / in the future.
  const { data, error } = await supabase
    .from('deals')
    .select(
      'id, retailer, description, percent_off, deal_type, promo_code, expiration_date, original_link, affiliate_link, categories, keywords, deal_subtype, week_of, created_at'
    )
    .contains('keywords', [keyword.toLowerCase()])
    .or(`expiration_date.is.null,expiration_date.gte.${today}`)
    .order('created_at', { ascending: false })
    .limit(30)

  if (error) {
    console.error('[deals/search] error:', JSON.stringify(error))
    return NextResponse.json({ deals: [] }, { status: 500 })
  }

  return NextResponse.json({ deals: data ?? [] })
}
