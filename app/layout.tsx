import type { Metadata, Viewport } from 'next'
import { Fraunces, Inter, Barlow_Condensed, JetBrains_Mono } from 'next/font/google'
import Script from 'next/script'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import './globals.css'

const GA_MEASUREMENT_ID = 'G-8N54H781N4'
const ADSENSE_CLIENT_ID = 'ca-pub-7740708597836782'

// AdSense is hidden only for legacy paid subscribers.
async function viewerIsPaid(): Promise<boolean> {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user?.email) return false
    const service = createServiceClient()
    const { data: subscriber } = await service
      .from('subscribers')
      .select('tier')
      .eq('email', user.email)
      .single()
    return subscriber?.tier === 'paid'
  } catch {
    return false
  }
}

// Load Fraunces as a true variable font — the SOFT axis (and auto-loaded
// optical-size axis) lets .t-display use 'SOFT' 30 (roman) / 'SOFT' 50
// (italic) for the prototype's softer editorial character.
const fraunces = Fraunces({
  subsets: ['latin'],
  axes: ['SOFT'],
  style: ['normal', 'italic'],
  variable: '--font-serif',
  display: 'swap',
})

const inter = Inter({
  subsets: ['latin'],
  weight: ['300', '400', '500', '600'],
  variable: '--font-sans',
  display: 'swap',
})

const barlowCondensed = Barlow_Condensed({
  subsets: ['latin'],
  weight: ['300', '400', '500', '600', '700'],
  variable: '--font-condensed',
  display: 'swap',
})

const jetbrainsMono = JetBrains_Mono({
  subsets: ['latin'],
  weight: ['400', '500', '600'],
  variable: '--font-mono',
  display: 'swap',
})

export const viewport: Viewport = {
  width: 'device-width',
  initialScale: 1,
}

const TITLE = "Deal Dossier — Tell us what you want. We'll find the deal."
const DESC_LONG = "Build a watchlist of what you're shopping for. We sit on every retailer's promo inbox and email you the deals when they hit. Free to start."
const DESC_SHORT = "Build a watchlist of what you're shopping for. We sit on every retailer's promo inbox and email you the deals when they hit."

export const metadata: Metadata = {
  title: TITLE,
  description: DESC_LONG,
  metadataBase: new URL('https://dealdossier.io'),
  openGraph: {
    title: TITLE,
    description: DESC_SHORT,
    type: 'website',
    url: 'https://dealdossier.io',
    siteName: 'Deal Dossier',
    images: [{ url: '/dealdossier-logo.png', width: 800, height: 160, alt: 'Deal Dossier' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: TITLE,
    description: DESC_SHORT,
  },
  robots: {
    index: true,
    follow: true,
  },
  alternates: {
    canonical: 'https://dealdossier.io',
  },
  // AdSense verification — emits <meta name="google-adsense-account"> in
  // <head>, which AdSense's crawler looks for as the official verification
  // signal. Always present (independent of viewer tier) so verification
  // succeeds even though we conditionally load the actual ads script.
  other: {
    'google-adsense-account': ADSENSE_CLIENT_ID,
  },
}

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const isPaid = await viewerIsPaid()

  return (
    <html
      lang="en"
      className={`${fraunces.variable} ${inter.variable} ${barlowCondensed.variable} ${jetbrainsMono.variable}`}
    >
      <body className="grain">
        {children}
        <div className="grain-layer" aria-hidden="true" />

        {/* Meta Pixel — loaded after interactive to avoid blocking paint. */}
        <Script id="meta-pixel" strategy="afterInteractive">
          {`
            !function(f,b,e,v,n,t,s)
            {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
            n.callMethod.apply(n,arguments):n.queue.push(arguments)};
            if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
            n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t,s)}(window, document,'script',
            'https://connect.facebook.net/en_US/fbevents.js');
            fbq('init', '1017433624181244');
            fbq('track', 'PageView');
          `}
        </Script>
        <noscript>
          <img
            height="1"
            width="1"
            style={{ display: 'none' }}
            src="https://www.facebook.com/tr?id=1017433624181244&ev=PageView&noscript=1"
            alt=""
          />
        </noscript>

        {/* Google Analytics (gtag.js) — loaded after interactive so it
            doesn't block first paint or font swap. */}
        <Script
          src={`https://www.googletagmanager.com/gtag/js?id=${GA_MEASUREMENT_ID}`}
          strategy="afterInteractive"
        />
        <Script id="gtag-init" strategy="afterInteractive">
          {`
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', '${GA_MEASUREMENT_ID}');
          `}
        </Script>

        {/* Google AdSense — hidden only for legacy paid subscribers.

            Rendered as a plain <script> element (not next/script) so it
            appears as a real <script async src="..."> tag in the
            server-rendered HTML. App Router's <Script> component wraps
            the URL in a __next_s.push() queue under every strategy,
            which AdSense's verifier doesn't recognize. React 19 hoists
            this <script> to <head> automatically. */}
        {/* Organization + WebSite structured data — helps AI engines and
            Google Knowledge Panel identify the brand, URL, and description. */}
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify({
              '@context': 'https://schema.org',
              '@graph': [
                {
                  '@type': 'Organization',
                  name: 'Deal Dossier',
                  url: 'https://dealdossier.io',
                  logo: 'https://dealdossier.io/dealdossier-logo.png',
                  description:
                    'Deal Dossier monitors over 1,000 retailer newsletters and emails you curated deals that match your personal watchlist. Free to start.',
                },
                {
                  '@type': 'WebSite',
                  name: 'Deal Dossier',
                  url: 'https://dealdossier.io',
                  description:
                    'Build a watchlist of what you\'re shopping for. We sit on every retailer\'s promo inbox and email you the deals when they hit.',
                },
              ],
            }),
          }}
        />

        {!isPaid && (
          <script
            async
            src={`https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${ADSENSE_CLIENT_ID}`}
            crossOrigin="anonymous"
          />
        )}
      </body>
    </html>
  )
}
