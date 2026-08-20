'use client'

// Tab strip for /admin. Each tab's content is mounted only when active,
// so panels with their own fetches (SubscriptionsPanel, DiscountCodes-
// Panel, etc.) don't all fire on initial page load — only when the
// user actually visits that tab.
//
// Persists the active tab in the URL hash (e.g. `/admin#coupons`) so
// reloads + shared links land on the same tab the admin was using.

import { useEffect, useState } from 'react'

export type AdminTabConfig = {
  id: string
  label: string
  // Optional small badge — e.g. "3" next to "Review Queue" if there's
  // pending items. Renders to the right of the label.
  badge?: number | string | null
  content: React.ReactNode
}

export function AdminTabs({ tabs }: { tabs: AdminTabConfig[] }) {
  const [active, setActive] = useState<string>(tabs[0]?.id ?? '')

  // Initial hash sync (after mount so SSR/CSR match) + popstate
  // listener for back-button navigation between tabs.
  useEffect(() => {
    const fromHash = typeof window !== 'undefined' ? window.location.hash.slice(1) : ''
    if (fromHash && tabs.some((t) => t.id === fromHash)) {
      setActive(fromHash)
    }
    const onPop = () => {
      const h = window.location.hash.slice(1)
      if (h && tabs.some((t) => t.id === h)) setActive(h)
    }
    window.addEventListener('popstate', onPop)
    return () => window.removeEventListener('popstate', onPop)
  }, [tabs])

  const goTo = (id: string) => {
    setActive(id)
    // Use replaceState so each tab swap doesn't pollute the browser
    // history — but DO update the URL so reload preserves the tab.
    if (typeof window !== 'undefined') {
      const newUrl = `${window.location.pathname}#${id}`
      window.history.replaceState(null, '', newUrl)
    }
  }

  const current = tabs.find((t) => t.id === active) ?? tabs[0]

  return (
    <>
      {/* ── Tab strip ──────────────────────────────────────────────── */}
      <div
        className="admin-tabs"
        role="tablist"
        style={{
          display: 'flex',
          gap: 0,
          marginTop: 32,
          marginBottom: 28,
          borderBottom: '1px solid var(--ink, #181612)',
          flexWrap: 'nowrap',
          overflowX: 'auto',
        }}
      >
        {tabs.map((t) => {
          const isActive = t.id === active
          return (
            <button
              className="admin-tab"
              key={t.id}
              role="tab"
              aria-selected={isActive}
              type="button"
              onClick={() => goTo(t.id)}
              style={{
                fontFamily: 'var(--mono)',
                fontSize: 11.5,
                letterSpacing: 0,
                textTransform: 'none',
                padding: '11px 14px',
                background: 'transparent',
                color: isActive ? 'var(--ink)' : 'var(--ink-55)',
                border: 'none',
                borderBottom: isActive ? '2px solid var(--ink)' : '2px solid transparent',
                cursor: 'pointer',
                marginBottom: '-1px',
                transition: 'background .12s, color .12s',
                position: 'relative',
                whiteSpace: 'nowrap',
              }}
            >
              {t.label}
              {t.badge != null && t.badge !== '' && t.badge !== 0 && (
                <span
                  className="admin-tab-badge"
                  style={{
                    marginLeft: 8,
                    background: isActive ? 'var(--red, #d4322a)' : 'var(--red, #d4322a)',
                    color: 'var(--bone, #fff5d4)',
                    padding: '1px 6px',
                    fontSize: 10,
                    letterSpacing: 0,
                    borderRadius: 2,
                  }}
                >
                  {t.badge}
                </span>
              )}
            </button>
          )
        })}
      </div>

      {/* ── Active tab content ─────────────────────────────────────── */}
      <div role="tabpanel" aria-labelledby={active}>
        {current?.content}
      </div>
    </>
  )
}
