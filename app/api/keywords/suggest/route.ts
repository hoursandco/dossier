import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  const q = request.nextUrl.searchParams.get('q')?.trim() ?? ''

  if (!q) {
    return NextResponse.json({ keywords: [] })
  }

  const supabase = createServiceClient()

  const [keywordsResult, storesResult] = await Promise.all([
    supabase
      .from('keywords')
      .select('keyword, deal_count')
      .ilike('keyword', `${q}%`)
      .order('deal_count', { ascending: false })
      .limit(8),
    supabase
      .from('stores')
      .select('name')
      .ilike('name', `%${q}%`)
      .eq('status', 'active')
      .eq('is_active', true)
      .limit(4),
  ])

  const brands = (storesResult.data ?? []).map((s) => ({
    keyword: s.name,
    deal_count: 0,
    type: 'brand' as const,
  }))

  const keywords = (keywordsResult.data ?? []).map((k) => ({
    ...k,
    type: 'keyword' as const,
  }))

  return NextResponse.json({ keywords: [...brands, ...keywords] })
}
