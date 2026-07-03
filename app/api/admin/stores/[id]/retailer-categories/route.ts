import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

async function requireAdmin(): Promise<{ ok: true } | { ok: false; res: NextResponse }> {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return { ok: false, res: NextResponse.json({ error: 'Unauthorized' }, { status: 401 }) }
  }
  return { ok: true }
}

async function getStoreName(service: ReturnType<typeof createServiceClient>, id: string) {
  const { data, error } = await service
    .from('stores')
    .select('name')
    .eq('id', id)
    .maybeSingle()

  if (error) throw error
  return typeof data?.name === 'string' ? data.name : null
}

export async function GET(
  _request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const service = createServiceClient()
  const retailer = await getStoreName(service, id)
  if (!retailer) return NextResponse.json({ error: 'Store not found' }, { status: 404 })

  const { data, error } = await service
    .from('retailer_categories')
    .select('category_slug, is_primary')
    .eq('retailer', retailer)
    .order('is_primary', { ascending: false })
    .order('category_slug')

  if (error) {
    console.error('[admin store retailer categories] lookup error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to load retailer categories' }, { status: 500 })
  }

  return NextResponse.json({
    retailer,
    categories: (data ?? []).map((row) => row.category_slug),
  })
}

export async function PATCH(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  let body: { retailer?: string; previous_retailer?: string | null; categories?: string[] }
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const retailer = body.retailer?.trim()
  if (!retailer) return NextResponse.json({ error: 'Missing retailer' }, { status: 400 })

  const categorySlugs = Array.from(
    new Set((body.categories ?? []).map((slug) => slug.trim()).filter(Boolean))
  )

  const service = createServiceClient()

  const validResult = await service
    .from('categories')
    .select('slug')
    .eq('is_active', true)
    .eq('is_editorial', false)
    .in('slug', categorySlugs.length > 0 ? categorySlugs : ['__none__'])

  if (validResult.error) {
    console.error('[admin store retailer categories] category validation error:', JSON.stringify(validResult.error))
    return NextResponse.json({ error: 'Failed to validate categories' }, { status: 500 })
  }

  const validSlugs = new Set((validResult.data ?? []).map((row) => row.slug))
  const cleanSlugs = categorySlugs.filter((slug) => validSlugs.has(slug))

  const retailersToClear = Array.from(
    new Set([body.previous_retailer?.trim(), retailer].filter(Boolean) as string[])
  )

  if (retailersToClear.length > 0) {
    const { error: deleteError } = await service
      .from('retailer_categories')
      .delete()
      .in('retailer', retailersToClear)

    if (deleteError) {
      console.error('[admin store retailer categories] delete error:', JSON.stringify(deleteError))
      return NextResponse.json({ error: 'Failed to clear existing categories' }, { status: 500 })
    }
  }

  if (cleanSlugs.length > 0) {
    const { error: insertError } = await service
      .from('retailer_categories')
      .insert(cleanSlugs.map((category_slug, index) => ({
        retailer,
        category_slug,
        is_primary: index === 0,
      })))

    if (insertError) {
      console.error('[admin store retailer categories] insert error:', JSON.stringify(insertError))
      return NextResponse.json({ error: 'Failed to save retailer categories' }, { status: 500 })
    }
  }

  return NextResponse.json({ retailer, categories: cleanSlugs })
}
