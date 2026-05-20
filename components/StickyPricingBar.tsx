'use client'

// Mobile-only sticky pricing bar for /pricing. Renders fixed at the
// bottom of the viewport, keeping the offer + CTA in view while the
// user scrolls the benefits list. Hidden on screens ≥720px where the
// plan picker is already on screen without scrolling.
//
// Lives in /components (not inline in the pricing page) because the
// onClick smooth-scroll handler requires a client component, and the
// pricing page itself is a server component for SEO/auth checks.

export function StickyPricingBar() {
  return (
    <>
      <div
        className="sticky-pricing-bar"
        style={{
          position: 'fixed',
          left: 0,
          right: 0,
          bottom: 0,
          background: 'var(--ink)',
          color: 'var(--paper, #f6ecd2)',
          borderTop: '2px solid var(--ink)',
          padding: '12px 16px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          gap: 12,
          zIndex: 900,
          boxShadow: '0 -4px 0 rgba(0,0,0,0.15)',
        }}
      >
        <div style={{ flex: 1, minWidth: 0 }}>
          <div
            style={{
              fontFamily: "'Alfa Slab One', serif",
              fontSize: 16,
              lineHeight: 1.05,
              letterSpacing: '.02em',
            }}
          >
            $4.99/mo
          </div>
          <div
            style={{
              fontFamily: "'Stardos Stamp', monospace",
              fontSize: 10,
              letterSpacing: '.16em',
              textTransform: 'uppercase',
              color: 'rgba(255,248,226,0.7)',
              marginTop: 2,
            }}
          >
            Cancel anytime · No card to try free
          </div>
        </div>
        <a
          href="#upgrade-flow"
          onClick={(e) => {
            // Smooth-scroll to the Stripe form anchor inside the page.
            e.preventDefault()
            document
              .querySelector('.form-card.flush')
              ?.scrollIntoView({ behavior: 'smooth', block: 'start' })
          }}
          style={{
            fontFamily: "'Alfa Slab One', serif",
            fontSize: 13,
            letterSpacing: '.06em',
            textTransform: 'uppercase',
            background: 'var(--red)',
            color: '#fff8e2',
            padding: '12px 16px 10px',
            border: '2px solid #fff8e2',
            textDecoration: 'none',
            flexShrink: 0,
          }}
        >
          Upgrade →
        </a>
      </div>
      <style>{`
        .sticky-pricing-bar { display: none !important; }
        @media (max-width: 720px) {
          .sticky-pricing-bar { display: flex !important; }
          .dl-shell .form-section { padding-bottom: 120px !important; }
        }
      `}</style>
    </>
  )
}
