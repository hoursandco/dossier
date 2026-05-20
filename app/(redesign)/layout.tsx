// Route-group layout for the Dossier Look (price-tag aesthetic) pages.
//
// Pages under app/(redesign)/ are wrapped in a .dl-shell div and inherit
// the scoped CSS in redesign.css. The route group syntax means this
// layout adds onto the root layout (which still provides <html>/<body>),
// so existing pages outside the group are unaffected.
//
// Google Fonts load via plain <link> in the JSX — Next hoists these to
// <head>. Once the design is locked we can swap to next/font/google for
// the performance optimisations (font-display: swap is already default).

import Script from 'next/script'
import './redesign.css'

// Skimlinks publisher ID — when set, the JS auto-rewrites every
// outbound merchant link on the page into an affiliate redirect so
// converting clicks earn commission. Email links are wrapped
// server-side via lib/affiliate.ts (the JS can't run in mailboxes).
const SKIM_ID = process.env.NEXT_PUBLIC_SKIMLINKS_ID

export default function RedesignLayout({ children }: { children: React.ReactNode }) {
  return (
    <>
      {/* eslint-disable-next-line @next/next/no-page-custom-font */}
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
      <link
        rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Stardos+Stamp:wght@400;700&family=Special+Elite&family=IM+Fell+English:ital@0;1&family=Bigshot+One&family=Bungee&family=Smokum&display=swap"
      />
      <div className="dl-shell">
        <div className="dl-grain" aria-hidden="true" />
        {children}
      </div>
      {SKIM_ID && (
        <Script
          src={`https://s.skimresources.com/js/${SKIM_ID}.skimlinks.js`}
          strategy="afterInteractive"
        />
      )}
    </>
  )
}
