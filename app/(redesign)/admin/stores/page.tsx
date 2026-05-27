import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import { StoresAdmin } from '@/components/StoresAdmin'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

// Admin-only brand directory management — list, search, add, edit,
// soft-delete. The page itself is a thin server wrapper that handles
// the auth redirect; all interactivity lives in StoresAdmin (client).
export default async function StoresAdminPage() {
  const authClient = await createClient()
  const { data: { user } } = await authClient.auth.getUser()
  if (!isAdminEmail(user?.email)) {
    redirect('/')
  }

  return (
    <>
      <nav className="nav">
        <a className="brand" href="/">
          <span className="brand-badge">DEAL DOSSIER</span>
          <span className="brand-sub">— the weekly brief</span>
        </a>
        <div className="nav-links">
          <a href="/suggest">Suggest a Store</a>
          <a href="/">Settings</a>
          <a href="/admin" className="active">Admin</a>
        </div>
      </nav>

      <section
        style={{
          padding: 'clamp(48px, 6vw, 72px) 0 clamp(56px, 7vw, 80px)',
        }}
      >
        <div className="wrap" style={{ maxWidth: 1200 }}>
          <p
            style={{
              fontFamily: "'Stardos Stamp', sans-serif",
              fontSize: 11,
              letterSpacing: '.4em',
              textTransform: 'uppercase',
              color: 'var(--red-deep)',
              margin: '0 0 16px',
            }}
          >
            — Admin · Brand Directory —
          </p>
          <h1
            style={{
              fontFamily: "'Alfa Slab One', serif",
              fontWeight: 400,
              fontSize: 'clamp(40px, 6vw, 64px)',
              margin: '0 0 16px',
              lineHeight: 1,
              letterSpacing: '.04em',
              color: 'var(--ink)',
              textIndent: '.04em',
            }}
          >
            <span style={{ fontFamily: "'Alfa Slab One', serif", color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>
              Stores.
            </span>
          </h1>
          <p
            style={{
              marginTop: 16,
              fontFamily: "'IM Fell English', serif",
              fontStyle: 'italic',
              color: 'var(--ink-soft)',
              fontSize: 17,
              maxWidth: '60ch',
            }}
          >
            The source of truth for every brand we track. Edits here go live within five minutes on the public surface.
          </p>
          <p
            style={{
              marginTop: 8,
              fontFamily: "'IM Fell English', serif",
              fontStyle: 'italic',
              color: 'var(--ink-soft)',
              fontSize: 17,
              maxWidth: '60ch',
            }}
          >
            Brands appear here after we extract their first deal. Welcome emails alone don&rsquo;t trigger this — we wait for a real promo so the catalog stays clean.
          </p>

          <StoresAdmin />
        </div>
      </section>

      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/admin">Admin Home</a> · <a href="/">Public Site</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </>
  )
}
