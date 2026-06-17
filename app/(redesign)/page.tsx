'use client'

// Homepage — single-page product surface in the Dossier Look.
//
// Top nav is gone — the only top-level UI is a slim admin bar that
// renders only for the admin user (everyone else lands straight on the
// hero). Footer carries the standard nav.
//
// The HomePicker IS the page below the hero: anonymous picker for
// new visitors, pre-loaded watchlist + action buttons for signed-in.

import { HomePicker } from '@/components/HomePicker'
import { DossierNav } from '@/components/DossierNav'
import { DlFooter } from '@/components/DlFooter'

export default function Home() {
  return (
    <div>
      {/* ============ SEARCH + RESULTS ============ */}
      <div className="hero-search-row">
        {/* ============ LEFT COLUMN: nav + headline + picker ============ */}
        <div className="home-search-column">
          <DossierNav />
          <header className="home-search-hero">
            <h1>
              <span className="home-search-hero-script">Tap to pull</span>
              <span className="home-search-hero-main">EVERY LIVE SALE.</span>
            </h1>
            <p>— Today&rsquo;s sales, on demand. —</p>
          </header>
          <HomePicker />
        </div>

        {/* ============ RIGHT COLUMN: live deal results ============ */}
        <aside className="deal-results-column" aria-live="polite">
          <div id="deal-results-portal" />
        </aside>
      </div>

      {/* ============ FOOTER (the new nav) ============ */}
      <DlFooter />
    </div>
  )
}
