import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

export const maxDuration = 300

export async function POST(request: NextRequest) {
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const appUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://dealdossier.io'
  const secret = process.env.CRON_SECRET
  const workerUrl = new URL('/api/cron/process-extraction-jobs', appUrl)
  request.nextUrl.searchParams.forEach((value, key) => {
    workerUrl.searchParams.set(key, value)
  })

  const res = await fetch(workerUrl.toString(), {
    headers: secret ? { Authorization: `Bearer ${secret}` } : {},
  })

  const data = await res.json()
  return NextResponse.json(data, { status: res.status })
}
