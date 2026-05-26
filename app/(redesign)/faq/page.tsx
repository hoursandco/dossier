// /faq — the questions worth asking, on their own page. Moved off the
// homepage as part of the single-page restructure; reachable from the
// footer. Server-rendered so the "N brands" copy reflects the live
// confirmed brand count (admin-curated active rows only).

import type { Metadata } from 'next'
import { DossierNav } from '@/components/DossierNav'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'FAQ · Deal Dossier',
  description:
    'How Deal Dossier works — what it does for you, the free tier, how deals are selected and ranked, and how billing works.',
  alternates: { canonical: 'https://dealdossier.io/faq' },
}

// Round down to the nearest 100 for marketing copy — "1,742 brands"
// reads as falsely precise / promotional dishonest. "1,700+ brands"
// hits the right register (and reflects the current set without
// hard-coding).
function brandsMarketingCount(actual: number): string {
  if (actual < 100) return String(actual)
  const floored = Math.floor(actual / 100) * 100
  return `${floored.toLocaleString('en-US')}+`
}

export default async function FaqPage() {
  const service = createServiceClient()
  const { count } = await service
    .from('stores')
    .select('id', { count: 'exact', head: true })
    .eq('status', 'active')
    .eq('is_active', true)
  const brandsLabel = brandsMarketingCount(count ?? 0)

  return (
    <>
      <DossierNav />

      <section className="section faq" style={{ paddingTop: 'clamp(40px, 6vw, 76px)' }}>
        <h2 className="kicker">— Questions —</h2>
        <h2 className="title">Worth <em>asking.</em></h2>

        <div className="faq-list">
          <details className="faq-item" open>
            <span className="faq-tag">Q · 01</span>
            <summary>What does Deal Dossier do for me?</summary>
            <div className="ans">
              <p>You tell us what you&rsquo;re shopping for — bath &amp; towels, a new mattress, mens jeans, perfume, whatever. We do the rest.</p>
              <p>Our AI is subscribed to over {brandsLabel} brand newsletters. Every day it scans an inbox, extracts real discounts, tags each deal by category, and stores them. The moment you ask — by hitting &ldquo;send me deals now&rdquo; — we email everything matching your watchlist. You tell us what you&rsquo;re shopping for, we&rsquo;ll immediately send you a tidy list of recent deals for those categories or brands.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Pick three brands you actually shop. We&rsquo;ll do the watching. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 02</span>
            <summary>Is the free tier really free?</summary>
            <div className="ans">
              <p>Yes, absolutely. No credit card required. Up to 3 active picks plus the on-demand refresh — enough to track most short-term shopping projects at no cost.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Start free — no card, no catch. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 03</span>
            <summary>How are deals selected?</summary>
            <div className="ans">
              <p>AI does the window shopping for you. We scan {brandsLabel} brand emails daily. Skip the fluff — a 10% discount with a $200 minimum isn&rsquo;t a win, and &ldquo;store cash&rdquo; isn&rsquo;t savings. Just the real ones.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Choose three. Get the deals. Skip the spam. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 04</span>
            <summary>How are deals ranked in my email?</summary>
            <div className="ans">
              <p>Two factors. The biggest driver is savings — a 60% off deal ranks above a 20% off deal, every time. Second: store tier. A rare sale at a higher-end retailer gets a meaningful boost over the same discount at a store that&rsquo;s always running promotions.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Three brands. One email. Zero noise — starting this week. →
                </a>
              </p>
            </div>
          </details>

          <details className="faq-item">
            <span className="faq-tag">Q · 05</span>
            <summary>How does paid billing work?</summary>
            <div className="ans">
              <p>Personal Shopper is $4.99/month. Billing handled by Stripe — your card details never touch our servers. Cancel any time from settings; you keep access through the end of the period you&rsquo;ve paid for.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Lock in your three brands. We&rsquo;ll handle the rest. →
                </a>
              </p>
            </div>
          </details>
        </div>
      </section>

      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/">Home</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a> · <a href="mailto:hello@dealdossier.io">Contact</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </>
  )
}
