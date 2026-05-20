// POST /api/admin/stores/duplicates/dismiss
//
// Persistently marks a duplicate-cluster as "not duplicates" so the
// review panel stops showing it. Keyed by the cluster's normalized
// apex domain — once dismissed, future store additions sharing that
// apex won't resurface the cluster either.
//
// Body: { normalized_website: string }
//
// Idempotent — upsert on the unique index. Admin-gated.

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

const Body = z.object({
  normalized_website: z.string().trim().min(1).max(2048),
})

export async function POST(req: NextRequest) {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  const adminEmail = process.env.ADMIN_EMAIL
  if (!adminEmail || !user || user.email !== adminEmail) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const parsed = Body.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid body' }, { status: 400 })
  }

  const service = createServiceClient()
  const { error } = await service
    .from('non_duplicate_clusters')
    .upsert(
      {
        normalized_website: parsed.data.normalized_website,
        dismissed_by_email: user.email ?? null,
        dismissed_at: new Date().toISOString(),
      },
      { onConflict: 'normalized_website' }
    )

  if (error) {
    // Postgres returns 42P01 for missing tables; PostgREST wraps that
    // as PGRST205 ("Could not find the table … in the schema cache").
    // Match both so the admin sees the actionable hint either way.
    const code = (error as { code?: string }).code
    if (code === '42P01' || code === 'PGRST205') {
      return NextResponse.json(
        { error: 'non_duplicate_clusters table missing — run migration 027 in Supabase' },
        { status: 500 }
      )
    }
    console.error('[duplicates/dismiss] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to dismiss' }, { status: 500 })
  }

  return NextResponse.json({ success: true })
}
