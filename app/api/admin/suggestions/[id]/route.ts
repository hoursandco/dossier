// DELETE /api/admin/suggestions/[id]
//
// Removes a single store suggestion from the admin queue. This is
// intentionally a hard delete on the store_suggestions row — it does
// NOT touch the corresponding store in the stores table (if one was
// created from this suggestion via the "Added" response, that store
// stays where it is). The use case is dismissing already-actioned
// suggestions to declutter the /admin queue.

import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  // Admin gate
  const sb = await createClient()
  const { data: { user } } = await sb.auth.getUser()
  const adminEmail = process.env.ADMIN_EMAIL
  if (!adminEmail || !user || user.email !== adminEmail) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const service = createServiceClient()
  const { error, count } = await service
    .from('store_suggestions')
    .delete({ count: 'exact' })
    .eq('id', id)

  if (error) {
    console.error('[admin suggestions DELETE] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to remove suggestion' }, { status: 500 })
  }
  if (!count) {
    return NextResponse.json({ error: 'Not found' }, { status: 404 })
  }
  return NextResponse.json({ removed: true })
}
