'use client'

import { useEffect } from 'react'
import Link from 'next/link'
import { Nav } from '@/components/Nav'
import { Footer } from '@/components/Footer'
import { Reveal } from '@/components/Reveal'
import { createClient } from '@/lib/supabase/client'

export default function WelcomePage() {
  useEffect(() => {
    // Mark onboarding complete so this page is only shown once
    const supabase = createClient()
    supabase.auth.getUser().then(({ data: { user } }) => {
      if (!user?.email) return
      supabase
        .from('subscribers')
        .update({ onboarding_completed: true })
        .eq('email', user.email)
        .then(() => {})
    })

    // Meta Pixel — new free signup via magic link
    if (typeof window !== 'undefined' && (window as any).fbq) {
      ;(window as any).fbq('track', 'Lead')
    }
  }, [])

  return (
    <>
      <Nav />

      <section
        style={{
          minHeight: '70vh',
          display: 'flex',
          alignItems: 'center',
          padding: 'clamp(80px, 10vw, 140px) 0',
        }}
      >
        <div className="wrap" style={{ maxWidth: 720 }}>
          <Reveal>
            <div className="t-eyebrow" style={{ color: 'var(--olive-deep)' }}>
              You&rsquo;re in
            </div>
          </Reveal>
          <Reveal delay={100}>
            <h1
              style={{
                fontFamily: 'var(--font-serif)',
                fontWeight: 300,
                fontSize: 'clamp(48px, 7vw, 96px)',
                marginTop: 20,
                lineHeight: 1,
                letterSpacing: '-0.03em',
              }}
            >
              Let&rsquo;s build your{' '}
              <em style={{ color: 'var(--olive-deep)', fontWeight: 300 }}>
                watchlist.
              </em>
            </h1>
          </Reveal>
          <Reveal delay={220}>
            <p
              style={{
                marginTop: 32,
                color: 'var(--ink-70)',
                fontSize: 17,
                lineHeight: 1.55,
                maxWidth: '48ch',
              }}
            >
              Pick the categories you&rsquo;re shopping for and we&rsquo;ll
              start watching. Hit &ldquo;send me deals now&rdquo; any time to
              pull a fresh list from every brand on your list.
            </p>
          </Reveal>
          <Reveal delay={320}>
            <Link
              href="/preferences"
              className="btn-primary"
              style={{ marginTop: 40 }}
            >
              Set up my watchlist <span className="arr">→</span>
            </Link>
          </Reveal>
        </div>
      </section>

      <Footer />
    </>
  )
}
