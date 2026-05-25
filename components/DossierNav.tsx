'use client'

// Shared top nav for every Dossier Look page.
//
// Deliberately minimal: brand badge + tagline on the left, at most
// one button on the right (Admin for the admin user, Sign In for
// signed-out visitors). The site's actual navigation lives in the
// footer; the top nav is a brand strip, not a menu.
//
// Auth state is auto-fetched on mount unless the parent passes it
// in (server-rendered pages may already know).

import { useEffect, useState } from 'react'

export function DossierNav({
  signedIn: signedInProp,
  isAdmin: isAdminProp,
}: {
  // Optional overrides — if the parent already knows the auth state
  // (e.g. server-rendered pages where it'd be wasteful to refetch),
  // pass them as props. Otherwise the nav fetches its own state on
  // mount via /api/account + /api/admin/check.
  signedIn?: boolean
  isAdmin?: boolean
  // Legacy prop, accepted but ignored — kept so existing call sites
  // (e.g. <DossierNav active="login" />) don't need rewriting.
  active?: string
}) {
  const [signedInAuto, setSignedInAuto] = useState<boolean | null>(
    signedInProp ?? null
  )
  const [isAdminAuto, setIsAdminAuto] = useState<boolean | null>(
    isAdminProp ?? null
  )

  useEffect(() => {
    if (signedInProp !== undefined && isAdminProp !== undefined) return
    let cancelled = false
    Promise.all([
      signedInProp === undefined
        ? fetch('/api/account', { cache: 'no-store' })
            .then((r) => (r.ok ? r.json().then(() => true) : false))
            .catch(() => false)
        : Promise.resolve(signedInProp),
      isAdminProp === undefined
        ? fetch('/api/admin/check', { cache: 'no-store' })
            .then((r) => (r.ok ? r.json().then((d) => !!d.isAdmin) : false))
            .catch(() => false)
        : Promise.resolve(isAdminProp),
    ]).then(([si, ad]) => {
      if (cancelled) return
      setSignedInAuto(si)
      setIsAdminAuto(ad)
    })
    return () => {
      cancelled = true
    }
  }, [signedInProp, isAdminProp])

  const signedIn = signedInProp ?? signedInAuto ?? false
  const isAdmin = isAdminProp ?? isAdminAuto ?? false

  return (
    <nav className="nav">
      <a className="brand" href="/">
        <span className="brand-badge">DEAL DOSSIER</span>
        <span className="brand-sub">Today&rsquo;s sales, on demand.</span>
      </a>
      {(isAdmin || !signedIn) && (
        <div className="nav-links">
          {isAdmin && <a href="/admin">Admin</a>}
          {!signedIn && <a href="/login">Sign In</a>}
        </div>
      )}
    </nav>
  )
}
