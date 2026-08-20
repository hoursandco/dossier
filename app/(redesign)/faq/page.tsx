// /faq — the questions worth asking, on their own page. Moved off the
// homepage as part of the single-page restructure; reachable from the
// footer. Server-rendered so the "N brands" copy reflects the live
// confirmed brand count (admin-curated active rows only).

import type { Metadata } from 'next'
import { DossierNav } from '@/components/DossierNav'
import { DlFooter } from '@/components/DlFooter'
import { createServiceClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'FAQ · Deal Dossier',
  description:
    'How Deal Dossier works — what it does for you, how deals are selected and ranked, and what it costs.',
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
    <div className="legal-ledger faq-ledger">
      <DossierNav />

      <main className="legal-ledger-main">
        <header className="legal-ledger-header">
          <div><span className="legal-ledger-eyebrow">Help · FAQ</span><h1>Worth asking.</h1></div>
          <div className="legal-ledger-summary"><p>How Deal Dossier finds sales, ranks the useful ones, and keeps your inbox quiet.</p><span>{brandsLabel} brands monitored</span></div>
        </header>

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
            <summary>Is Deal Dossier really free?</summary>
            <div className="ans">
              <p>Yes. No credit card required, and the deal search works even if you do not enter an email address. If you sign in, your watchlist and filters are saved for next time.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Start searching — no card, no catch. →
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
            <summary>What does it cost?</summary>
            <div className="ans">
              <p>Nothing right now. Deal Dossier does not have a paid tier, and all shopping/search features are available without a subscription.</p>
              <p style={{ marginTop: 14, fontStyle: 'italic' }}>
                <a href="/" style={{ color: 'var(--red-deep)', borderBottom: '1.5px solid var(--red-deep)' }}>
                  Lock in your three brands. We&rsquo;ll handle the rest. →
                </a>
              </p>
            </div>
          </details>
        </div>
      </main>

      <DlFooter />
    </div>
  )
}
