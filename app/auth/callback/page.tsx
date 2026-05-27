'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'

export default function AuthCallbackPage() {
  const router = useRouter()

  useEffect(() => {
    const handleCallback = async () => {
      const hash = window.location.hash.substring(1)
      const params = new URLSearchParams(hash)

      const accessToken  = params.get('access_token')
      const refreshToken = params.get('refresh_token')
      const errorParam   = params.get('error')

      if (errorParam || !accessToken || !refreshToken) {
        router.replace('/login?error=auth_failed')
        return
      }

      const supabase = createClient()
      const { data, error } = await supabase.auth.setSession({
        access_token:  accessToken,
        refresh_token: refreshToken,
      })

      if (error || !data.user) {
        router.replace('/login?error=auth_failed')
        return
      }

      // The picker IS the homepage now (the redesign collapsed
      // /preferences into HomePicker on /). Land magic-link sign-ins
      // there so they immediately see the watchlist + SEND ME DEALS
      // NOW button. A ?next= query param still overrides for any
      // call site that needs to deep-link somewhere specific.
      const next = new URLSearchParams(window.location.search).get('next')
      router.replace(next ?? '/')
    }

    handleCallback()
  }, [router])

  return (
    <div
      style={{
        minHeight: '100vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        gap: 16,
        background: 'var(--paper)',
      }}
    >
      <div
        style={{
          width: 12,
          height: 12,
          border: '1.5px solid var(--olive-deep)',
          borderTopColor: 'transparent',
          borderRadius: '50%',
          animation: 'adminSpin 0.7s linear infinite',
        }}
        aria-hidden="true"
      />
      <p className="t-meta" style={{ color: 'var(--ink-40)' }}>
        Signing you in…
      </p>
    </div>
  )
}
