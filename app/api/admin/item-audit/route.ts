import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

const ReviewBody = z.object({
  keyword: z.string().trim().min(1).max(120),
  canonical_keyword: z.string().trim().min(1).max(120).nullable().optional(),
  parent_keyword: z.string().trim().min(1).max(120).nullable().optional(),
  is_hidden: z.boolean().default(false),
})

async function requireAdmin() {
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  return isAdminEmail(user?.email) ? user : null
}

function normalizeTerm(value: string | null | undefined): string {
  return (value ?? '').toLowerCase().replace(/\s+/g, ' ').trim()
}

function reviewMatchesQuery(
  review: {
    keyword: string | null
    canonical_keyword: string | null
    parent_keyword: string | null
  },
  q: string,
): boolean {
  const needle = normalizeTerm(q)
  if (!needle) return true
  return [
    review.keyword,
    review.canonical_keyword,
    review.parent_keyword,
  ].some((value) => normalizeTerm(value).includes(needle))
}

export async function GET(request: NextRequest) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const db = createServiceClient()
  const q = request.nextUrl.searchParams.get('q')?.trim() ?? ''
  let keywordsQuery = db
    .from('keywords')
    .select('keyword, deal_count, last_seen, canonical_keyword, parent_keyword, is_hidden, reviewed_at')
    .order('deal_count', { ascending: false })
    .limit(400)
  if (q) keywordsQuery = keywordsQuery.ilike('keyword', `%${q}%`)

  // Curation lives on the keywords rows themselves (migration 056). The
  // second query pulls the curated slice so a search by canonical/parent
  // term can surface rows whose own keyword didn't match the ilike.
  const [{ data: keywords, error: keywordsError }, { data: curated, error: curatedError }] =
    await Promise.all([
      keywordsQuery,
      db
        .from('keywords')
        .select('keyword, deal_count, last_seen, canonical_keyword, parent_keyword, is_hidden, reviewed_at')
        .or('canonical_keyword.not.is.null,parent_keyword.not.is.null,is_hidden.eq.true')
        .limit(5000),
    ])

  if (keywordsError) {
    const code = (keywordsError as { code?: string }).code
    if (code === '42703') {
      return NextResponse.json({
        error: 'Keyword curation columns are not installed yet. Run migration 056.',
        setup_required: true,
      }, { status: 503 })
    }
    return NextResponse.json({ error: 'Could not load item vocabulary.' }, { status: 500 })
  }
  if (curatedError) {
    return NextResponse.json({ error: 'Could not load item curation.' }, { status: 500 })
  }

  type KeywordRow = {
    keyword: string
    deal_count: number
    last_seen: string | null
    canonical_keyword: string | null
    parent_keyword: string | null
    is_hidden: boolean
    reviewed_at: string | null
  }
  const toItem = (row: KeywordRow) => {
    const isReviewed = !!row.canonical_keyword || !!row.parent_keyword || row.is_hidden || !!row.reviewed_at
    return {
      keyword: row.keyword,
      deal_count: row.deal_count,
      last_seen: row.last_seen,
      review: isReviewed
        ? {
            keyword: row.keyword,
            canonical_keyword: row.canonical_keyword,
            parent_keyword: row.parent_keyword,
            is_hidden: row.is_hidden,
            updated_at: row.reviewed_at,
          }
        : null,
    }
  }

  const itemsByKeyword = new Map(
    ((keywords ?? []) as KeywordRow[]).map((row) => [row.keyword, toItem(row)]),
  )

  if (q) {
    for (const row of (curated ?? []) as KeywordRow[]) {
      if (!reviewMatchesQuery(row, q)) continue
      if (itemsByKeyword.has(row.keyword)) continue
      itemsByKeyword.set(row.keyword, toItem(row))
    }
  }

  return NextResponse.json({
    items: [...itemsByKeyword.values()],
  })
}

export async function POST(request: NextRequest) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const parsed = ReviewBody.safeParse(await request.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid item review.' }, { status: 400 })
  }

  const keyword = parsed.data.keyword.toLowerCase()
  const canonicalKeyword = parsed.data.canonical_keyword?.toLowerCase() ?? null
  const parentKeyword = parsed.data.parent_keyword?.toLowerCase() ?? null
  if (canonicalKeyword === keyword) {
    return NextResponse.json({ error: 'An item cannot be merged into itself.' }, { status: 400 })
  }
  if (parentKeyword === keyword) {
    return NextResponse.json({ error: 'An item cannot include itself as a broader item.' }, { status: 400 })
  }

  const db = createServiceClient()
  // Upsert onto the keywords vocabulary row (migration 056). deal_count is
  // deliberately omitted so an existing row's count is never clobbered; a
  // brand-new curation-only row gets the column default.
  const { data, error } = await db
    .from('keywords')
    .upsert({
      keyword,
      canonical_keyword: canonicalKeyword,
      parent_keyword: parentKeyword,
      is_hidden: parsed.data.is_hidden,
      reviewed_by_email: user.email ?? null,
      reviewed_at: new Date().toISOString(),
    }, { onConflict: 'keyword' })
    .select('keyword, canonical_keyword, parent_keyword, is_hidden, reviewed_at')
    .single()

  if (error) {
    return NextResponse.json({ error: 'Could not save item review.' }, { status: 500 })
  }
  return NextResponse.json({
    review: data ? { ...data, updated_at: data.reviewed_at } : data,
  })
}

export async function DELETE(request: NextRequest) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const keyword = request.nextUrl.searchParams.get('keyword')?.trim().toLowerCase()
  if (!keyword) return NextResponse.json({ error: 'Keyword is required.' }, { status: 400 })

  const db = createServiceClient()
  // Clearing a review resets the curation columns but keeps the vocabulary
  // row — deal_count/last_seen are real usage data, not curation.
  const { error } = await db
    .from('keywords')
    .update({
      canonical_keyword: null,
      parent_keyword: null,
      is_hidden: false,
      reviewed_by_email: null,
      reviewed_at: null,
    })
    .eq('keyword', keyword)
  if (error) return NextResponse.json({ error: 'Could not clear item review.' }, { status: 500 })
  return NextResponse.json({ ok: true })
}
