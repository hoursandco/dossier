// Dynamic Open Graph image for /stores. Generated at request time
// via next/og's ImageResponse (Vercel edge). The image gets cached
// at Vercel's CDN, so the first share warms the cache and every
// subsequent unfurl is instant.
//
// The Dossier Look here uses the same red plaque + cream paper
// vocabulary as the rest of the site — when this URL gets pasted in
// iMessage / Slack / Twitter / FB, it should be unmistakable as a
// Deal Dossier link.

import { ImageResponse } from 'next/og'
import { createServiceClient } from '@/lib/supabase/server'

export const runtime = 'nodejs'
export const alt = 'Browse every brand we track — Deal Dossier'
export const size = { width: 1200, height: 630 }
export const contentType = 'image/png'

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

export default async function OpengraphImage() {
  const count = await getDirectoryCount()
  const total = count > 0 ? count.toLocaleString() : '1,000+'

  return new ImageResponse(
    (
      <div
        style={{
          width: '100%',
          height: '100%',
          background: '#f1e6c8',
          display: 'flex',
          flexDirection: 'column',
          padding: '64px 72px',
          fontFamily: 'serif',
          position: 'relative',
        }}
      >
        {/* Top strip: brand plaque */}
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
          }}
        >
          <div
            style={{
              background: '#d4322a',
              color: '#fff8e2',
              padding: '14px 22px',
              fontSize: 32,
              border: '3px solid #181612',
              boxShadow: '6px 6px 0 #181612',
              fontWeight: 700,
              letterSpacing: '2px',
              transform: 'rotate(-2deg)',
            }}
          >
            DEAL DOSSIER
          </div>
          <div
            style={{
              fontSize: 18,
              color: '#5c6a3a',
              fontStyle: 'italic',
              letterSpacing: '4px',
              textTransform: 'uppercase',
            }}
          >
            — the directory —
          </div>
        </div>

        {/* Big editorial headline */}
        <div
          style={{
            marginTop: 64,
            display: 'flex',
            flexDirection: 'column',
            gap: 8,
          }}
        >
          <div
            style={{
              display: 'flex',
              fontSize: 124,
              fontWeight: 900,
              color: '#181612',
              lineHeight: 0.95,
              letterSpacing: '-2px',
            }}
          >
            {`${total} brands.`}
          </div>
          <div
            style={{
              display: 'flex',
              fontSize: 124,
              fontWeight: 900,
              color: '#181612',
              lineHeight: 0.95,
              letterSpacing: '-2px',
            }}
          >
            One inbox.
          </div>
        </div>

        {/* Bottom strip: subtitle + URL */}
        <div
          style={{
            marginTop: 'auto',
            display: 'flex',
            alignItems: 'flex-end',
            justifyContent: 'space-between',
            gap: 24,
          }}
        >
          <div
            style={{
              display: 'flex',
              fontSize: 26,
              fontStyle: 'italic',
              color: '#2a261f',
              maxWidth: 720,
              lineHeight: 1.3,
            }}
          >
            Pick your favorites. We’ll watch for their deals — weekly, on your schedule.
          </div>
          <div
            style={{
              fontSize: 22,
              color: '#181612',
              background: '#f4c623',
              padding: '12px 18px',
              border: '3px solid #181612',
              boxShadow: '4px 4px 0 #181612',
              letterSpacing: '2px',
              transform: 'rotate(2deg)',
              fontWeight: 700,
            }}
          >
            DEALDOSSIER.IO
          </div>
        </div>
      </div>
    ),
    { ...size }
  )
}
