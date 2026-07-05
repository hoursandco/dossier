// Admin CRUD for the canonical shopping taxonomy.
//
// Existing slugs are intentionally treated as stable IDs because
// subscriber_watches.category_slug and deals.categories depend on them.

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

function cleanTerms(value: unknown): string[] {
  if (!Array.isArray(value)) return []
  return Array.from(
    new Set(
      value
        .map((term) => String(term).trim().toLowerCase())
        .filter(Boolean),
    ),
  ).sort((a, b) => a.localeCompare(b))
}

export async function GET() {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  const service = createServiceClient()
  const { data, error } = await service
    .from('categories')
    .select('slug, label, group_name, sort_order, is_active, is_editorial, search_terms')
    .order('sort_order', { ascending: true })
    .order('label', { ascending: true })

  if (error) {
    console.error('[admin categories] list error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to load categories' }, { status: 500 })
  }

  return NextResponse.json({ categories: data ?? [] })
}

export async function POST(request: NextRequest) {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  let body: Record<string, unknown>
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const slug = String(body.slug ?? '').trim().toLowerCase()
  const label = String(body.label ?? '').trim()
  if (!slug || !/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(slug)) {
    return NextResponse.json({ error: 'slug must be lowercase words separated by hyphens' }, { status: 400 })
  }
  if (!label) return NextResponse.json({ error: 'label is required' }, { status: 400 })

  const service = createServiceClient()
  const { data, error } = await service
    .from('categories')
    .insert({
      slug,
      label,
      group_name: String(body.group_name ?? '').trim() || null,
      sort_order: Number.isFinite(Number(body.sort_order)) ? Number(body.sort_order) : 0,
      is_active: body.is_active !== false,
      search_terms: cleanTerms(body.search_terms),
    })
    .select('slug, label, group_name, sort_order, is_active, is_editorial, search_terms')
    .single()

  if (error) {
    const code = (error as { code?: string }).code
    if (code === '23505') {
      return NextResponse.json({ error: 'A category with that slug already exists' }, { status: 409 })
    }
    console.error('[admin categories] create error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to create category' }, { status: 500 })
  }

  return NextResponse.json({ category: data })
}

export async function PATCH(request: NextRequest) {
  const auth = await requireAdmin()
  if (!auth.ok) return auth.res

  let body: Record<string, unknown>
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const slug = String(body.slug ?? '').trim()
  if (!slug) return NextResponse.json({ error: 'slug is required' }, { status: 400 })

  const update: Record<string, unknown> = {}
  if ('label' in body) update.label = String(body.label ?? '').trim()
  if ('group_name' in body) update.group_name = String(body.group_name ?? '').trim() || null
  if ('sort_order' in body) update.sort_order = Number.isFinite(Number(body.sort_order)) ? Number(body.sort_order) : 0
  if ('is_active' in body) update.is_active = body.is_active !== false
  if ('search_terms' in body) update.search_terms = cleanTerms(body.search_terms)

  if (typeof update.label === 'string' && !update.label) {
    return NextResponse.json({ error: 'label is required' }, { status: 400 })
  }
  if (Object.keys(update).length === 0) {
    return NextResponse.json({ error: 'No updatable fields provided' }, { status: 400 })
  }

  const service = createServiceClient()
  const { data, error } = await service
    .from('categories')
    .update(update)
    .eq('slug', slug)
    .select('slug, label, group_name, sort_order, is_active, is_editorial, search_terms')
    .single()

  if (error) {
    console.error('[admin categories] update error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to update category' }, { status: 500 })
  }

  return NextResponse.json({ category: data })
}
