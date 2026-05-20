'use client'

// Shared top nav for every Dossier Look page.
//
// Desktop (>=560px): brand badge on the left, full link row on the right —
//                   same layout the inline navs had before.
// Mobile (<560px):  brand badge on the left, hamburger toggle on the right.
//                   Tap → full-width drop-down menu with all the same links
//                   listed vertically.
//
// Centralized so we can add/remove menu items in one place instead of
// hunting through every page's inline <nav>. Pages tell it which item
// is active (so it gets the red highlight) and whether the user is
// signed in / is an admin (so we show or hide Settings / Admin / Sign In).

import { useEffect, useState } from 'react'
import { createPortal } from 'react-dom'

type NavItemId = 'home' | 'pricing' | 'suggest' | 'preferences' | 'admin' | 'login' | 'stores'

type NavItem = {
  id: NavItemId
  label: string
  href: string
}

export function DossierNav({
  active,
  signedIn: signedInProp,
  isAdmin: isAdminProp,
}: {
  active?: NavItemId
  // Optional overrides — if the parent already knows the auth state
  // (e.g. server-rendered pages where it'd be wasteful to refetch),
  // pass them as props. Otherwise the nav fetches its own state on
  // mount via /api/account + /api/admin/check.
  signedIn?: boolean
  isAdmin?: boolean
}) {
  const [open, setOpen] = useState(false)
  const [signedInAuto, setSignedInAuto] = useState<boolean | null>(
    signedInProp ?? null
  )
  const [isAdminAuto, setIsAdminAuto] = useState<boolean | null>(
    isAdminProp ?? null
  )

  // Auto-fetch auth state when props weren't supplied. /api/account
  // returns 401 (treated as not-signed-in) or a subscriber payload
  // (signed in). /api/admin/check returns a small JSON either way.
  // Both are cheap GETs — homepage gets two extra calls on first load,
  // which is acceptable for the consistency win.
  useEffect(() => {
    if (signedInProp !== undefined && isAdminProp !== undefined) return
    let cancelled = false
    Promise.all([
      signedInProp === undefined
        ? fetch('/api/account')
            .then((r) => (r.ok ? r.json().then(() => true) : false))
            .catch(() => false)
        : Promise.resolve(signedInProp),
      isAdminProp === undefined
        ? fetch('/api/admin/check')
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

  // Close the drawer on Escape + lock body scroll while it's open so
  // the page underneath doesn't drift if the user scrolls inside the
  // menu.
  useEffect(() => {
    if (!open) return
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setOpen(false)
    }
    document.addEventListener('keydown', onKey)
    const prev = document.body.style.overflow
    document.body.style.overflow = 'hidden'
    return () => {
      document.removeEventListener('keydown', onKey)
      document.body.style.overflow = prev
    }
  }, [open])

  // Build the link list dynamically — Settings only shows when signed
  // in, Admin only when isAdmin, Sign In only when signed out. Order
  // chosen for what a user is most likely to want at the top of a
  // mobile drawer.
  const items: NavItem[] = [
    { id: 'home', label: 'Home', href: '/' },
    { id: 'stores', label: 'Browse Brands', href: '/stores' },
    { id: 'suggest', label: 'Suggest a Store', href: '/suggest' },
    // Pricing jump-links to the homepage section. The standalone
    // /pricing page is still there for the actual Stripe checkout —
    // users reach it from the SUBSCRIBE button inside that section.
    { id: 'pricing', label: 'Pricing', href: '/#pricing' },
    ...(signedIn ? [{ id: 'preferences' as const, label: 'Settings', href: '/preferences' }] : []),
    ...(isAdmin ? [{ id: 'admin' as const, label: 'Admin', href: '/admin' }] : []),
    ...(!signedIn ? [{ id: 'login' as const, label: 'Sign In', href: '/login' }] : []),
  ]

  return (
    <nav className="nav">
      <a className="brand" href="/">
        <span className="brand-badge">DEAL DOSSIER</span>
        <span className="brand-sub">Today&rsquo;s sales, on demand.</span>
      </a>

      {/* Desktop link row — hidden on mobile via .nav-links-desktop CSS */}
      <div className="nav-links nav-links-desktop">
        {items.map((it) => (
          <a
            key={it.id}
            href={it.href}
            className={active === it.id ? 'active' : undefined}
          >
            {it.label}
          </a>
        ))}
      </div>

      {/* Mobile hamburger button — hidden on desktop via .nav-hamburger CSS */}
      <button
        type="button"
        className="nav-hamburger"
        aria-label={open ? 'Close menu' : 'Open menu'}
        aria-expanded={open}
        onClick={() => setOpen((o) => !o)}
      >
        {/* Three lines or X depending on state. Using <span> stacks
            rather than an icon font so it inherits the page's ink color. */}
        <span aria-hidden="true" className={open ? 'is-x' : ''}>
          <span />
          <span />
          <span />
        </span>
      </button>

      {/* Mobile drop-down drawer — portaled to document.body so it
          escapes any ancestor stacking context. (The .dl-shell wrapper
          has its own context, and the inline page hero stickers were
          painting on top of an in-place drawer.) */}
      {open && typeof document !== 'undefined' && createPortal(
        <div
          className="nav-drawer"
          onClick={() => setOpen(false)}
        >
          <ul onClick={(e) => e.stopPropagation()}>
            {items.map((it) => (
              <li key={it.id}>
                <a
                  href={it.href}
                  className={active === it.id ? 'active' : undefined}
                  onClick={() => setOpen(false)}
                >
                  {it.label}
                </a>
              </li>
            ))}
          </ul>
        </div>,
        document.body
      )}
    </nav>
  )
}
