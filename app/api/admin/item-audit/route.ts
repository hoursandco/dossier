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
    .select('keyword, deal_count, last_seen')
    .order('deal_count', { ascending: false })
    .limit(400)
  if (q) keywordsQuery = keywordsQuery.ilike('keyword', `%${q}%`)

  const [{ data: keywords, error: keywordsError }, { data: reviews, error: reviewsError }] =
    await Promise.all([
      keywordsQuery,
      db
        .from('item_keyword_reviews')
        .select('keyword, canonical_keyword, parent_keyword, is_hidden, updated_at')
        .limit(5000),
    ])

  if (keywordsError) {
    return NextResponse.json({ error: 'Could not load item vocabulary.' }, { status: 500 })
  }
  if (reviewsError) {
    return NextResponse.json({
      error: 'Item audit table is not installed yet. Run migration 045.',
      setup_required: true,
    }, { status: 503 })
  }

  const reviewByKeyword = new Map((reviews ?? []).map((row) => [row.keyword, row]))
  const itemsByKeyword = new Map(
    (keywords ?? []).map((item) => [
      item.keyword,
      {
        ...item,
        review: reviewByKeyword.get(item.keyword) ?? null,
      },
    ]),
  )

  if (q) {
    for (const review of reviews ?? []) {
      if (!reviewMatchesQuery(review, q)) continue
      if (itemsByKeyword.has(review.keyword)) continue
      itemsByKeyword.set(review.keyword, {
        keyword: review.keyword,
        deal_count: 0,
        last_seen: null,
        review,
      })
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
  const { data, error } = await db
    .from('item_keyword_reviews')
    .upsert({
      keyword,
      canonical_keyword: canonicalKeyword,
      parent_keyword: parentKeyword,
      is_hidden: parsed.data.is_hidden,
      reviewed_by_email: user.email ?? null,
      updated_at: new Date().toISOString(),
    }, { onConflict: 'keyword' })
    .select('keyword, canonical_keyword, parent_keyword, is_hidden, updated_at')
    .single()

  if (error) {
    return NextResponse.json({ error: 'Could not save item review.' }, { status: 500 })
  }
  return NextResponse.json({ review: data })
}

export async function DELETE(request: NextRequest) {
  const user = await requireAdmin()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const keyword = request.nextUrl.searchParams.get('keyword')?.trim().toLowerCase()
  if (!keyword) return NextResponse.json({ error: 'Keyword is required.' }, { status: 400 })

  const db = createServiceClient()
  const { error } = await db.from('item_keyword_reviews').delete().eq('keyword', keyword)
  if (error) return NextResponse.json({ error: 'Could not clear item review.' }, { status: 500 })
  return NextResponse.json({ ok: true })
}
