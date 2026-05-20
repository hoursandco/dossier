// DELETE /api/store-picks/[id]
//
// Removes one of the signed-in subscriber's store picks. Auth-scoped:
// we always filter by subscriber_id derived from the session, so a
// user can't delete someone else's pick by guessing the id.

import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const service = createServiceClient()
  const { data: subscriber } = await service
    .from('subscribers')
    .select('id')
    .eq('email', user.email)
    .single()
  if (!subscriber) {
    return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
  }

  const { error, count } = await service
    .from('subscriber_stores')
    .delete({ count: 'exact' })
    .eq('id', id)
    .eq('subscriber_id', subscriber.id)

  if (error) {
    const code = (error as { code?: string }).code
    if (code === '42P01' || code === 'PGRST205') {
      return NextResponse.json(
        { error: 'subscriber_stores table missing — run migration 028' },
        { status: 500 }
      )
    }
    console.error('[store-picks DELETE] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to remove store pick' }, { status: 500 })
  }
  if (!count) {
    return NextResponse.json({ error: 'Not found' }, { status: 404 })
  }
  return NextResponse.json({ removed: true })
}
