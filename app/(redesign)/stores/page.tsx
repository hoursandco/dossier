// /stores — server entry. Exports metadata so search engines + social
// shares get a proper title, description, and OG card. The actual
// interactive UI is in StoresBrowse.tsx ("use client") — that file
// owns search, filters, sort, and the watchlist toggle.
//
// We pull the live store count so the meta description is current
// rather than stale. Cached 1h since this number changes slowly and
// the metadata generation runs on every request to a fresh deploy.

import type { Metadata } from 'next'
import { createServiceClient } from '@/lib/supabase/server'
import { StoresBrowse } from './StoresBrowse'

export const revalidate = 3600 // 1h

async function getDirectoryCount(): Promise<number> {
  try {
    const service = createServiceClient()
    const { count } = await service
      .from('stores')
      .select('id', { count: 'exact', head: true })
      .neq('status', 'declined')
    return count ?? 0
  } catch {
    return 0
  }
}

export async function generateMetadata(): Promise<Metadata> {
  const count = await getDirectoryCount()
  const total = count > 0 ? count.toLocaleString() : '1,000+'
  const title = `Browse ${total} retail brands · Deal Dossier`
  const description = `The full directory of every brand we track. Curated weekly deal alerts from ${total} retailers — pick your favorites, get the sales, skip the spam.`
  const url = 'https://dealdossier.io/stores'
  return {
    title,
    description,
    alternates: { canonical: url },
    openGraph: {
      title,
      description,
      url,
      siteName: 'Deal Dossier',
      type: 'website',
    },
    twitter: {
      card: 'summary_large_image',
      title,
      description,
    },
  }
}

export default function StoresPage() {
  return <StoresBrowse />
}
