// /preview-privacy — privacy policy in the Dossier Look.
// Text-only page; the design system carries the visual identity via
// page-head + footer. Sections render as a numbered list with kicker +
// heading + body — mirrors the editorial sectioning used elsewhere.

import { DossierNav } from '@/components/DossierNav'
import { DlFooter } from '@/components/DlFooter'

export const metadata = {
  title: 'Privacy Policy — Deal Dossier',
}

const SECTIONS: Array<{ title: string; body: string }> = [
  {
    title: 'Information We Collect',
    body: 'We collect your email address when you subscribe or sign in. When you configure your account we also collect your delivery preferences (send day, minimum discount threshold), content filters (deal categories, deal types, gender, spend tier), and any individual retailers you have selected. You can search for deals without entering an email address.',
  },
  {
    title: 'How We Use Your Information',
    body: 'Your email address is used solely to send you the weekly Deal Dossier briefing and transactional emails (sign-in links, preference confirmations, billing receipts). We do not sell, rent, or share your personal information with third parties for marketing purposes.',
  },
  {
    title: 'Affiliate Relationships',
    body: 'Deal Dossier may earn a commission when you click certain retailer links in our email. These are clearly disclosed in each issue. Affiliate relationships do not influence editorial decisions. Deals are selected on merit alone.',
  },
  {
    title: 'Data Retention',
    body: 'Your account data is retained while your subscription is active. If you unsubscribe, we remove your email from active mailing lists within 24 hours. You may request complete deletion of your data using the unsubscribe link in any email we send, or by emailing support@dealdossier.io.',
  },
  {
    title: 'Security',
    body: 'We use industry-standard encryption (TLS) for data in transit and at rest. Authentication is handled via magic links — no passwords are ever created or stored. Hours & Co., LLC, as the data controller, operates Deal Dossier on infrastructure provided by Supabase (database and auth), Vercel (hosting), and Resend (email delivery). All providers operate enterprise-grade security practices. Your email address is shared with Resend solely for the purpose of delivering sign-in links and your weekly brief.',
  },
  {
    title: 'Cookies & Analytics',
    body: 'We use session cookies required for authentication. We also use Google Analytics to understand aggregate site usage — it sets analytics cookies (such as _ga and _ga_*) that do not identify individual users. Visitors may see advertisements delivered by Google AdSense, which uses cookies to personalize ads and measure performance. You can opt out of personalized advertising at adssettings.google.com, or block third-party cookies in your browser settings.',
  },
  {
    title: 'Your Rights',
    body: 'You have the right to access, correct, or delete the personal information Hours & Co., LLC holds about you. To exercise these rights, email support@dealdossier.io. If you are located in the European Economic Area, the United Kingdom, or California, you may have additional rights under GDPR or the CCPA — including the right to opt out of the sale or sharing of your personal information. Hours & Co., LLC does not sell your personal information.',
  },
  {
    title: 'Contact',
    body: 'For general questions about this Privacy Policy or about Deal Dossier, email hello@dealdossier.io. For account, billing, or data-deletion requests, email support@dealdossier.io. Both reach Hours & Co., LLC, the operator of Deal Dossier. You can also use the unsubscribe link in any Deal Dossier email to reach your account settings.',
  },
]

export default function PreviewPrivacy() {
  return (
    <>
      <DossierNav />

      <section className="page-head light">
        <div className="page-head-inner">
          <p className="page-kicker">— Legal —</p>
          <h1 className="page-title">Privacy <em>policy.</em></h1>
          <p className="page-sub" style={{ marginBottom: 12 }}>
            How we handle your data. The short version: only what we need, only as long as we need it, and only to send you the brief you signed up for.
          </p>
          <p style={{ fontFamily: "'Stardos Stamp', sans-serif", fontSize: 11, letterSpacing: '.25em', textTransform: 'uppercase', color: 'var(--ink-soft)', margin: 0 }}>
            Last Updated · May 2026
          </p>
        </div>
      </section>

      <section className="form-section" style={{ padding: '64px 28px 80px' }}>
        <div className="form-wrap-narrow" style={{ maxWidth: 760 }}>
          {SECTIONS.map((s, i) => {
            const num = String(i + 1).padStart(2, '0')
            // Apply the red-em treatment to the final word of each section title
            const parts = s.title.split(' ')
            const lastWord = parts.pop() ?? s.title
            const beforeLast = parts.join(' ')
            return (
              <article key={s.title} style={{ marginBottom: 48 }}>
                <p
                  className="form-step"
                  style={{ margin: '0 0 8px' }}
                >
                  — Section {num} —
                </p>
                <h2
                  style={{
                    fontFamily: "'Alfa Slab One', serif",
                    fontWeight: 400,
                    fontSize: 28,
                    letterSpacing: '.04em',
                    margin: '0 0 18px',
                    lineHeight: 1.05,
                    color: 'var(--ink)',
                  }}
                >
                  {beforeLast ? `${beforeLast} ` : ''}
                  <span
                    style={{
                      fontFamily: "'Alfa Slab One', serif",
                      color: 'var(--ink)',
                      textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)',
                      padding: '0 .04em',
                    }}
                  >
                    {lastWord}.
                  </span>
                </h2>
                <p
                  style={{
                    fontFamily: "'Special Elite', monospace",
                    fontSize: 15,
                    lineHeight: 1.7,
                    color: 'var(--ink-soft)',
                    margin: 0,
                  }}
                >
                  {s.body}
                </p>
                {i < SECTIONS.length - 1 && (
                  <hr style={{ border: 0, borderTop: '2px dashed var(--ink)', margin: '40px 0 0' }} />
                )}
              </article>
            )
          })}
        </div>
      </section>

      <DlFooter />
    </>
  )
}
