// POST /api/auth/logout — sign the current session out of Supabase.
// Server-side so cookies are cleared properly via the SSR cookie
// adapter (a client-side signOut leaves the http-only auth cookies
// behind and the next page load re-hydrates as signed-in).
//
// Idempotent: no session = still returns 200.

import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function POST() {
  const supabase = await createClient()
  await supabase.auth.signOut()
  return NextResponse.json({ success: true })
}
