// GET /api/collections — public/admin list of active brand collections.
// These are editorial tags stored in the categories table with
// is_editorial=true, and are assigned to stores.categories.

import { NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET() {
  const service = createServiceClient()

  const { data, error } = await service
    .from('categories')
    .select('slug, label, sort_order, group_name')
    .eq('is_active', true)
    .eq('is_editorial', true)
    .order('sort_order')

  if (error) {
    console.error('[collections] lookup error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to load collections' }, { status: 500 })
  }

  return NextResponse.json({ collections: data ?? [] })
}
