// /terms — Terms of Service in the Dossier Look.
// Same structural pattern as /privacy: numbered sections with kicker
// + headline (with red-em treatment on the last word) + body. Text
// only; the design system carries the visual identity.

import { LegalLedger } from '@/components/LegalLedger'

export const metadata = {
  title: 'Terms of Service — Deal Dossier',
  description: 'The rules of the road for using Deal Dossier — your account, our service, and what each side is on the hook for.',
}

const SECTIONS: Array<{ title: string; body: string }> = [
  {
    title: 'Acceptance of Terms',
    body: 'By creating a Deal Dossier account, by using the Service, or by browsing the site with cookies enabled, you agree to these Terms of Service. If you do not agree, do not use the Service. Deal Dossier is operated by Hours & Co., LLC ("we," "us," "our"). You must be at least 13 years old to use the Service; if you are under 18, you must have permission from a parent or legal guardian.',
  },
  {
    title: 'The Service',
    body: 'Deal Dossier is an email-based deal discovery service. You tell us which categories of products or specific retailers you are interested in, and we send you a curated digest of real deals from those retailers — weekly, plus on-demand when you press the send-now button. We aggregate publicly-available promotional emails from retailers we subscribe to ourselves. We do not sell products directly and we do not control retailer prices, inventory, promo codes, or shipping.',
  },
  {
    title: 'Your Account',
    body: 'Sign-in is via emailed "magic links" — no passwords are created or stored on your behalf. You are responsible for keeping access to your email account secure, since anyone with access to your email can sign in as you. If you suspect unauthorized access to your account, contact support@dealdossier.io immediately. You may delete your account at any time from your settings or by emailing support@dealdossier.io.',
  },
  {
    title: 'Acceptable Use',
    body: 'You agree not to: (a) scrape, copy, or systematically extract content from the Service; (b) interfere with or disrupt the Service or its infrastructure; (c) attempt to gain unauthorized access to any part of the Service or to another user’s account; (d) automate sign-ups, sign-ins, or self-sends beyond the limits we enforce; (e) use the Service for any unlawful purpose or in violation of these Terms. We may suspend or terminate accounts that violate these rules, with or without notice.',
  },
  {
    title: 'Fees',
    body: 'Deal Dossier does not currently charge a subscription fee for shopper-facing features. We may introduce paid offerings in the future, but we will not charge you unless you affirmatively choose a paid product and provide any required billing information.',
  },
  {
    title: 'Affiliate Relationships',
    body: 'Many outbound links in our emails and on our site are affiliate links — including links routed through Skimlinks, Amazon Associates, and direct retailer affiliate programs. If you click such a link and complete a qualifying purchase, we may earn a commission at no additional cost to you. Affiliate relationships do not influence which deals we surface; deals are selected on merit and editorial fit alone. This disclosure is provided in accordance with the U.S. Federal Trade Commission’s Endorsement Guides.',
  },
  {
    title: 'Accuracy of Deals',
    body: 'We work hard to surface accurate, current, and useful deals, but Deal Dossier does not control retailer prices, inventory, promo codes, or shipping policies. Deals may expire, sell out, change in price, or be subject to restrictions we are unaware of by the time you click through. We are not responsible for any losses arising from inaccurate, unavailable, or expired deals. Always verify final pricing, eligibility, and shipping on the retailer’s own site before completing a purchase.',
  },
  {
    title: 'Intellectual Property',
    body: 'The Deal Dossier name, logo, visual identity, editorial copy, curated content, and software are owned by Hours & Co., LLC. You may not reproduce, redistribute, republish, or create derivative works of our content without prior written permission. Brand names, logos, and trademarks of third-party retailers belong to their respective owners and are used here only to identify those retailers descriptively (nominative fair use). No endorsement by or affiliation with any retailer is implied unless explicitly stated.',
  },
  {
    title: 'Disclaimers & Limitation of Liability',
    body: 'The Service is provided "as is" and "as available," without warranties of any kind, express or implied, including warranties of merchantability, fitness for a particular purpose, and non-infringement. To the maximum extent permitted by law, Hours & Co., LLC’s total cumulative liability for any claim arising from your use of the Service is limited to $50 USD. We are not liable for indirect, incidental, consequential, special, or punitive damages — including but not limited to lost profits, lost savings, or losses on purchases made through affiliate links.',
  },
  {
    title: 'Indemnification',
    body: 'You agree to defend, indemnify, and hold harmless Hours & Co., LLC and its officers, directors, employees, and agents from any claims, losses, damages, liabilities, and expenses (including reasonable attorneys’ fees) arising out of or relating to your misuse of the Service, your violation of these Terms, or your violation of any rights of a third party.',
  },
  {
    title: 'Termination',
    body: 'We may suspend or terminate your account at any time, with or without notice, for any reason — most commonly for violation of the Acceptable Use rules above, abuse, or suspected fraud. You may stop using the Service and delete your account at any time from your settings. Sections of these Terms that by their nature should survive termination (including Intellectual Property, Disclaimers, Limitation of Liability, and Indemnification) will continue to apply after termination.',
  },
  {
    title: 'Governing Law & Disputes',
    body: 'These Terms are governed by the laws of the state in which Hours & Co., LLC is registered, without regard to its conflict-of-law principles. Any dispute that cannot be resolved informally between us will be resolved by binding individual arbitration administered in that same jurisdiction. You agree to bring claims only in your individual capacity, and not as part of a class action, collective action, or representative proceeding.',
  },
  {
    title: 'Changes & Contact',
    body: 'We may update these Terms from time to time. When we do, the "Last Updated" date at the top of this page will change. Material changes will be communicated by email to active subscribers at least 30 days before they take effect. Continued use of the Service after changes take effect constitutes acceptance. Questions about these Terms? Email hello@dealdossier.io. For account, billing, or data-deletion requests, email support@dealdossier.io.',
  },
]

export default function TermsPage() {
  return (
    <LegalLedger
      eyebrow="Legal · Terms"
      title="Terms of service."
      summary="The rules of the road. Plain English, no surprises — what we promise, what we don’t, and what each side is on the hook for."
      updated="May 2026"
      sections={SECTIONS}
    />
  )
}
