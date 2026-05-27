import { NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { getStripe } from '@/lib/stripe'

export const dynamic = 'force-dynamic'

export async function POST() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const service = createServiceClient()
  const { data: subscriber } = await service
    .from('subscribers')
    .select('stripe_customer_id')
    .eq('email', user.email)
    .single()

  if (!subscriber?.stripe_customer_id) {
    return NextResponse.json({ error: 'No billing account on file' }, { status: 404 })
  }

  // return_url is where Stripe sends the user back after they finish
  // in the portal. Homepage is the post-redesign settings surface
  // (/preferences was retired). NEXT_PUBLIC_APP_URL fallback covers
  // local dev where the var might not be set.
  const appUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://dealdossier.io'
  const session = await getStripe().billingPortal.sessions.create({
    customer: subscriber.stripe_customer_id,
    return_url: `${appUrl}/`,
  })

  return NextResponse.json({ url: session.url })
}
