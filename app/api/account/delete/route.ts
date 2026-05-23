import { NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { createClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function DELETE() {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const service = createServiceClient()

    if (!user.email) {
      return NextResponse.json({ error: 'Missing account email' }, { status: 400 })
    }

    const { data: subscriber, error: lookupError } = await service
      .from('subscribers')
      .select('id')
      .eq('email', user.email)
      .single()

    if (lookupError || !subscriber) {
      console.error('Subscriber lookup error:', lookupError)
      return NextResponse.json({ error: 'Subscriber not found' }, { status: 404 })
    }

    // Delete subscriber record (FK cascades to preferences, watches, send logs, etc.).
    // subscribers.id is independent from auth.users.id, so scope by the
    // subscriber row looked up from the authenticated email.
    const { error: subscriberDeleteError } = await service
      .from('subscribers')
      .delete()
      .eq('id', subscriber.id)

    if (subscriberDeleteError) {
      console.error('Delete subscriber error:', JSON.stringify(subscriberDeleteError))
      return NextResponse.json({ error: 'Failed to delete subscriber data' }, { status: 500 })
    }

    // Delete the auth user via admin API
    const { error } = await service.auth.admin.deleteUser(user.id)
    if (error) {
      console.error('Delete user error:', error)
      return NextResponse.json({ error: 'Failed to delete account' }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (err) {
    console.error('Account delete error:', err)
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
