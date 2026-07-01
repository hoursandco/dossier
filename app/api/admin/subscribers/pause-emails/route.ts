import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

async function requireAdmin(): Promise<{ error: NextResponse } | { error: null }> {
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return { error: NextResponse.json({ error: 'Unauthorized' }, { status: 401 }) }
  }
  return { error: null }
}

// PATCH /api/admin/subscribers/pause-emails
// Body: { paused: boolean }
// Sets admin_emails_paused on all active subscribers.
export async function PATCH(request: NextRequest) {
  const auth = await requireAdmin()
  if (auth.error) return auth.error

  let body: unknown
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const paused = (body as Record<string, unknown>).paused
  if (typeof paused !== 'boolean') {
    return NextResponse.json({ error: 'paused must be a boolean' }, { status: 400 })
  }

  const service = createServiceClient()
  const { error, count } = await service
    .from('subscribers')
    .update({ admin_emails_paused: paused }, { count: 'exact' })
    .eq('is_active', true)

  if (error) {
    console.error('[pause-emails] update error:', error)
    return NextResponse.json({ error: 'Update failed' }, { status: 500 })
  }

  return NextResponse.json({ paused, updated: count ?? 0 })
}

// GET /api/admin/subscribers/pause-emails
// Returns whether any active subscriber has emails paused.
export async function GET(_request: NextRequest) {
  const auth = await requireAdmin()
  if (auth.error) return auth.error

  const service = createServiceClient()
  const { count, error } = await service
    .from('subscribers')
    .select('id', { count: 'exact' })
    .eq('is_active', true)
    .eq('admin_emails_paused', true)

  if (error) {
    return NextResponse.json({ error: 'Lookup failed' }, { status: 500 })
  }

  return NextResponse.json({ paused: (count ?? 0) > 0, paused_count: count ?? 0 })
}
