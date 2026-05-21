// /preview-pricing — Personal Shopper upgrade page in the Dossier Look.
//
// Three states based on auth + subscription:
//   - Not signed in        → sign-in CTA card
//   - Signed in, free tier → Stripe upgrade flow (UpgradeFlow)
//   - Signed in, paid      → "already subscribed" card
//
// The UpgradeFlow component keeps its own internal styling (Stripe
// Elements has its own visual system anyway) — we just restyle the page
// shell and the two non-Stripe state cards.

import { createClient, createServiceClient } from '@/lib/supabase/server'
import { UpgradeFlow } from '@/components/UpgradeFlow'
import { DossierNav } from '@/components/DossierNav'
import { StickyPricingBar } from '@/components/StickyPricingBar'

export const dynamic = 'force-dynamic'

const STAR_POINTS =
  '100,2 113,28 142,12 142,42 172,42 156,67 184,79 159,98 184,118 156,128 172,154 142,154 142,184 113,168 100,194 87,168 58,184 58,154 28,154 44,128 16,118 41,98 16,79 44,67 28,42 58,42 58,12 87,28'

export default async function PreviewPricing() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  let subscriberTier: 'free' | 'paid' | null = null
  let subscriptionStatus: string | null = null
  if (user?.email) {
    const service = createServiceClient()
    const { data: subscriber } = await service
      .from('subscribers')
      .select('tier, subscription_status')
      .eq('email', user.email)
      .single()
    subscriberTier = subscriber?.tier ?? null
    subscriptionStatus = subscriber?.subscription_status ?? null
  }

  const alreadyPaid =
    subscriberTier === 'paid' &&
    ['active', 'trialing'].includes(subscriptionStatus ?? '')

  return (
    <>
      {/* ============ NAV ============ */}
      <DossierNav active="pricing" signedIn={!!user} />


      {/* ============ PAGE HEAD ============ */}
      <section className="page-head light">
        <div className="head-stickers" aria-hidden="true">

          <div className="s" style={{ top: 50, left: '6%', transform: 'rotate(-9deg)' }}>
            <div className="sticker sh-starburst" style={{ width: 160, height: 160 }}>
              <div className="star">
                <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#d4322a" stroke="#181612" strokeWidth="2" /></svg>
              </div>
              <div className="content">
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.18em' }}>SAVE</div>
                <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 38, lineHeight: 1, marginTop: 2 }}>25%</div>
                <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 9, letterSpacing: '.18em', marginTop: 2 }}>ANNUAL</div>
              </div>
            </div>
          </div>

          <div className="s" style={{ top: 40, left: '24%', transform: 'rotate(5deg)' }}>
            <div className="sticker bg-yellow sh-pricegun" style={{ width: 130, padding: '14px 12px' }}>
              <div className="lbl">FROM</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", fontSize: 32, lineHeight: 1 }}>$4<span style={{ fontSize: '.55em', verticalAlign: '.6em' }}>.99</span></div>
              <div className="lbl">PER MO</div>
            </div>
          </div>

          <div className="s" style={{ top: 56, right: '6%', transform: 'rotate(7deg)' }}>
            <div className="sticker bg-green sh-pricegun" style={{ width: 180, padding: '14px 14px' }}>
              <div className="lbl" style={{ color: '#fff8e2' }}>UNLIMITED</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 20, lineHeight: 1, letterSpacing: '.01em' }}>STORES OR</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 20, lineHeight: 1, letterSpacing: '.01em', marginTop: 2 }}>CATEGORIES</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 40, right: '14%', transform: 'rotate(-5deg)' }}>
            <div className="sticker bg-magenta sh-circle" style={{ width: 100, height: 100 }}>
              <div className="lbl" style={{ color: '#fff8e2', fontSize: 9 }}>AD</div>
              <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 22, lineHeight: 1 }}>FREE</div>
            </div>
          </div>

          <div className="s" style={{ bottom: 50, left: '10%', transform: 'rotate(3deg)' }}>
            <div className="sticker bg-orange sh-pricegun" style={{ width: 140, padding: '14px 12px' }}>
              <div style={{ fontFamily: "'Bigshot One',serif", fontSize: 26, letterSpacing: '.04em' }}>CANCEL</div>
              <div className="lbl">ANYTIME</div>
            </div>
          </div>

        </div>

        <div className="page-head-inner">
          <p className="page-kicker">— Personal Shopper —</p>
          <h1 className="page-title">Unlock <em>everything.</em></h1>
          <p className="page-sub">
            Unlimited watches. Per-watch modifiers. Ad-free emails. Priority alerts.
            The full Dossier experience.
          </p>
        </div>
      </section>

      {/* ============ BODY ============ */}
      <section className="form-section">
        <div className="form-wrap-narrow">
          {!user ? (
            <SignInPrompt />
          ) : alreadyPaid ? (
            <AlreadySubscribed />
          ) : (
            <div className="form-card flush">
              <p className="form-step">— Upgrade —</p>
              <h2 className="form-h">Switch on <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>Personal Shopper.</em></h2>

              {/* Benefits recap — last visual before they hit Stripe. Keeps
                  the value prop front-of-mind during card entry. Styled
                  as a stamped checklist so it reads like a dossier of
                  what they're unlocking, not a generic feature table. */}
              <ul
                style={{
                  listStyle: 'none',
                  padding: 0,
                  margin: '0 0 28px',
                  display: 'grid',
                  gap: 10,
                }}
              >
                {[
                  { title: 'Unlimited picks', body: 'Watch every category AND every favorite store — no 3-pick cap.' },
                  { title: 'Per-pick modifiers', body: 'Narrow each pick by sub-type, price tier ($–$$$$), and minimum discount.' },
                  { title: 'Ad-free emails', body: 'No sponsored slots, no inline ads — just the deals.' },
                  { title: 'Priority alerts', body: 'Time-sensitive deals (24-hour flash, exclusive codes) surface first.' },
                  { title: 'Cancel anytime', body: 'One-click cancel from settings. Keep your picks, drop the bill.' },
                ].map((b) => (
                  <li
                    key={b.title}
                    style={{
                      display: 'grid',
                      gridTemplateColumns: '28px 1fr',
                      gap: 12,
                      alignItems: 'baseline',
                      padding: '10px 12px',
                      background: '#fff8e2',
                      border: '1.5px solid var(--ink)',
                    }}
                  >
                    <span
                      style={{
                        fontFamily: "'Alfa Slab One', serif",
                        color: 'var(--red)',
                        fontSize: 20,
                        lineHeight: 1,
                      }}
                      aria-hidden="true"
                    >
                      ✓
                    </span>
                    <span>
                      <strong style={{ fontFamily: "'Alfa Slab One', serif", fontWeight: 400, fontSize: 16, letterSpacing: '.02em' }}>
                        {b.title}
                      </strong>
                      <span style={{ display: 'block', fontFamily: "'IM Fell English', serif", fontStyle: 'italic', fontSize: 15, color: 'var(--ink-soft)', lineHeight: 1.45, marginTop: 2 }}>
                        {b.body}
                      </span>
                    </span>
                  </li>
                ))}
              </ul>

              <UpgradeFlow />
            </div>
          )}
        </div>
      </section>

      {/* ============ STICKY MOBILE PRICING BAR ============ */}
      {/* Only renders for free / not-signed-in visitors — paid
          subscribers don't need an upgrade nudge. Mobile-only via
          CSS media query so it doesn't clutter desktop where the
          plan card is already in view. */}
      {!alreadyPaid && <StickyPricingBar />}

      {/* ============ FOOTER ============ */}
      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/suggest">Suggest a Store</a> · <a href="/preferences">Settings</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a> · <a href="mailto:hello@dealdossier.io">Contact</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </>
  )
}

function SignInPrompt() {
  return (
    <div className="form-card flush" style={{ textAlign: 'center' }}>
      <p className="form-step">— Sign In First —</p>
      <h2 className="form-h">You need an account to upgrade.</h2>
      <p style={{ fontFamily: "'IM Fell English', serif", fontSize: 18, lineHeight: 1.5, color: 'var(--ink-soft)', maxWidth: '50ch', margin: '0 auto 32px' }}>
        Sign in (or sign up — same magic link) and you&rsquo;ll come back here ready to switch on Personal Shopper.
      </p>
      <a
        href="/login?next=/pricing"
        className="submit-btn"
        style={{ textAlign: 'center' }}
      >
        SIGN IN →
      </a>
    </div>
  )
}

function AlreadySubscribed() {
  return (
    <div className="form-card flush" style={{ textAlign: 'center', position: 'relative' }}>
      <div style={{ position: 'absolute', top: -30, left: '50%', transform: 'translateX(-50%) rotate(-4deg)' }}>
        <div className="sticker sh-starburst" style={{ width: 130, height: 130 }}>
          <div className="star">
            <svg viewBox="0 0 200 200"><polygon points={STAR_POINTS} fill="#4ea843" stroke="#181612" strokeWidth="2" /></svg>
          </div>
          <div className="content">
            <div style={{ fontFamily: "'Alfa Slab One',serif", color: '#fff8e2', fontSize: 26, lineHeight: 1 }}>ACTIVE</div>
            <div style={{ fontFamily: "'Stardos Stamp',sans-serif", color: '#fff8e2', fontSize: 10, letterSpacing: '.2em', marginTop: 2 }}>SHOPPER</div>
          </div>
        </div>
      </div>
      <p className="form-step" style={{ marginTop: 50 }}>— You&rsquo;re a Shopper —</p>
      <h2 className="form-h">Personal Shopper, <em style={{ fontFamily: "'Alfa Slab One', serif", fontStyle: 'normal', color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>active.</em></h2>
      <p style={{ fontFamily: "'IM Fell English', serif", fontSize: 18, lineHeight: 1.5, color: 'var(--ink-soft)', maxWidth: '50ch', margin: '0 auto 32px' }}>
        Unlimited watches, per-watch modifiers, ad-free emails — all switched on.
        Manage your subscription from settings.
      </p>
      <a href="/preferences" className="submit-btn">OPEN MY WATCHLIST →</a>
    </div>
  )
}
