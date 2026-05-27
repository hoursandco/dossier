import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  const { searchParams, origin } = new URL(request.url)
  const code = searchParams.get('code')
  const next = searchParams.get('next')

  if (code) {
    const supabase = await createClient()
    const { error } = await supabase.auth.exchangeCodeForSession(code)
    if (!error) {
      // The homepage IS the picker now (the redesign collapsed
      // /preferences into the HomePicker on /). Land returning users
      // there so they immediately see their watchlist + SEND ME DEALS
      // NOW button. A `?next=` query param still overrides if some
      // call site needs to deep-link somewhere specific.
      return NextResponse.redirect(`${origin}${next ?? '/'}`)
    }
  }

  return NextResponse.redirect(`${origin}/login?error=auth_failed`)
}
