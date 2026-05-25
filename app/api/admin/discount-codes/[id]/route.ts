// DELETE /api/admin/discount-codes/:id
// PATCH  /api/admin/discount-codes/:id — toggle active for soft-disable
//
// Hard delete is straightforward. We also expose a PATCH that flips
// `active` because the spec asks for either; soft-disable is the
// better default since it preserves the times_used join target for
// analytics — admins can disable without losing history.

import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

const PatchSchema = z.object({
  active: z.boolean(),
})

export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> },
) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const parsed = PatchSchema.safeParse(await req.json().catch(() => null))
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid body' }, { status: 400 })
  }

  const service = createServiceClient()
  const { error } = await service
    .from('discount_codes')
    .update({ active: parsed.data.active })
    .eq('id', id)

  if (error) {
    console.error('[discount-codes PATCH] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to update' }, { status: 500 })
  }

  return NextResponse.json({ success: true })
}

export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> },
) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { id } = await params
  if (!id) return NextResponse.json({ error: 'Missing id' }, { status: 400 })

  const service = createServiceClient()
  const { error } = await service.from('discount_codes').delete().eq('id', id)

  if (error) {
    console.error('[discount-codes DELETE] error:', JSON.stringify(error))
    return NextResponse.json({ error: 'Failed to delete' }, { status: 500 })
  }

  return NextResponse.json({ success: true })
}
