import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  const q = request.nextUrl.searchParams.get('q')?.trim() ?? ''

  if (!q) {
    return NextResponse.json({ keywords: [] })
  }

  const supabase = createServiceClient()

  const { data, error } = await supabase
    .from('keywords')
    .select('keyword, deal_count')
    .ilike('keyword', `${q}%`)
    .order('deal_count', { ascending: false })
    .limit(10)

  if (error) {
    console.error('[keywords/suggest] error:', JSON.stringify(error))
    return NextResponse.json({ keywords: [] }, { status: 500 })
  }

  return NextResponse.json({ keywords: data ?? [] })
}
