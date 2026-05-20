import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Sign In — Deal Dossier',
  description: 'Sign in to your Deal Dossier account or create one free. Build a watchlist and get curated deals from 1,000+ retailers delivered to your inbox.',
  alternates: { canonical: 'https://dealdossier.io/login' },
  robots: { index: false, follow: false },
}

export default function LoginLayout({ children }: { children: React.ReactNode }) {
  return <>{children}</>
}
