// Watchlist email — generated on-demand when a subscriber refreshes their
// watchlist or on the weekly send. Organized by the user's watches: one
// section per "I'm shopping for X" entry, retailers grouped within.
//
// Dossier Look styling. Web fonts (Alfa Slab One / Stardos Stamp / Special
// Elite / IM Fell English) degrade to Georgia / Courier on clients that
// don't load them — the look holds via the cream paper, ink borders, and
// the colored savings badges.

import { format } from 'date-fns'
import type { Deal } from '@/types'

// ── Dossier Look palette (literal hex — CSS vars don't work in mail) ──
const FONT_DISPLAY = "'Alfa Slab One',Georgia,serif"
const FONT_STAMP = "'Stardos Stamp','Courier New',monospace"
const FONT_TYPE = "'Special Elite','Courier New',monospace"
const FONT_BODY = "'IM Fell English',Georgia,serif"
const CREAM = '#f1e6c8'       // outer page background
const PAPER = '#f6ecd2'       // container / postscript panel
const PANEL = '#fff5d4'       // body section background
const DARK = '#0d0c0a'        // header + hero background
const INK = '#181612'
const INK_SOFT = '#2a261f'
const CREAM_TEXT = '#fff8e2'
const HERO_SUB = '#efe2bd'
const RED = '#d4322a'
const RED_DEEP = '#b3211a'
const YELLOW = '#f4c623'
const GREEN = '#4ea843'
const MAGENTA = '#e8367e'
const ORANGE = '#ee7c2f'
const BLUE = '#2563a8'

const FONT_LINK =
  'https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=IM+Fell+English:ital@0;1&family=Special+Elite&family=Stardos+Stamp:wght@400;700&display=swap'

export interface WatchSection {
  label: string          // human-readable: "Bath & Towels", "Womens Clothes — jeans"
  deals: Deal[]
}

export interface WatchlistEmailInput {
  appUrl: string
  watchSections: WatchSection[]
}

function escape(s: string): string {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}

// Wrap the last word of a heading in the signature red drop-shadow.
function shadowLastWord(text: string, textColor: string = INK): string {
  const words = escape(text).trim().split(/\s+/).filter(Boolean)
  if (words.length === 0) return ''
  const last = words.pop()!
  const prefix = words.length ? `${words.join(' ')} ` : ''
  return `${prefix}<span style="font-family:${FONT_DISPLAY};color:${textColor};text-shadow:2px 2px 0 ${RED},4px 4px 0 ${RED_DEEP};padding:0 .04em;">${last}</span>`
}

function dateStamp(): string {
  const now = new Date()
  return `${format(now, 'EEE').toUpperCase()} · ${format(now, 'MMM').toUpperCase()} ${format(now, 'd')} · '${format(now, 'yy')}`
}

// ── Savings badge — colored, bordered block keyed to the deal type ──────
function savingsBadge(deal: Deal): string {
  const wrap = (bg: string, inner: string, pad = '14px 18px 10px') =>
    `<table role="presentation" cellpadding="0" cellspacing="0" border="0" style="display:inline-block;" class="badge-wrap"><tr><td style="background:${bg};border:2.5px solid ${INK};padding:${pad};text-align:center;">${inner}</td></tr></table>`
  const small = (txt: string, fg: string) =>
    `<div style="font-family:${FONT_STAMP};color:${fg};font-size:10px;letter-spacing:.2em;text-transform:uppercase;">${txt}</div>`
  const big = (txt: string, fg: string) =>
    `<div style="font-family:${FONT_DISPLAY};color:${fg};font-size:30px;line-height:1;letter-spacing:.02em;">${txt}</div>`
  const mid = (txt: string, fg: string) =>
    `<div style="font-family:${FONT_DISPLAY};color:${fg};font-size:22px;line-height:1;letter-spacing:.02em;">${txt}</div>`
  const tag = (txt: string, fg: string) =>
    `<div style="font-family:${FONT_STAMP};color:${fg};font-size:11px;letter-spacing:.2em;margin:2px 0;">${txt}</div>`

  switch (deal.deal_type) {
    case 'bogo-free':
      return wrap(MAGENTA, `${mid('BUY 1', CREAM_TEXT)}${tag('GET 1', CREAM_TEXT)}${mid('FREE', CREAM_TEXT)}`, '12px 16px 10px')
    case 'bogo-half':
      return wrap(ORANGE, `${mid('B1G1', INK)}${tag('HALF OFF', INK)}${mid('50%', INK)}`, '12px 16px 10px')
    case 'free-item':
      return wrap(GREEN, `${small('YOURS', CREAM_TEXT)}${mid('FREE', CREAM_TEXT)}<div style="font-family:${FONT_STAMP};color:${CREAM_TEXT};font-size:10px;letter-spacing:.2em;text-transform:uppercase;margin-top:2px;">ITEM</div>`, '14px 16px 10px')
    case 'free-shipping':
      return wrap(GREEN, `${small('FREE', CREAM_TEXT)}${mid('SHIP', CREAM_TEXT)}`)
  }
  if (deal.percent_off) {
    if (deal.deal_type === 'up-to') {
      return wrap(YELLOW, `${small('UP TO', INK)}${big(`${deal.percent_off}%`, INK)}`)
    }
    return wrap(RED, `${small('SAVE', CREAM_TEXT)}${big(`${deal.percent_off}%`, CREAM_TEXT)}`)
  }
  return wrap(BLUE, `${small('ON', CREAM_TEXT)}<div style="font-family:${FONT_DISPLAY};color:${CREAM_TEXT};font-size:28px;line-height:1;letter-spacing:.02em;">SALE</div>`)
}

// ── One deal: description + optional code chip / expiry on the left,
//    savings badge on the right ──────────────────────────────────────────
function dealRow(deal: Deal): string {
  const link = escape(deal.affiliate_link || deal.original_link || '#')
  const description = escape(deal.description)
  const codeChip = deal.promo_code
    ? `<span style="display:inline-block;background:${YELLOW};border:1.5px solid ${INK};padding:4px 9px 3px;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.18em;text-transform:uppercase;color:${INK};">CODE&nbsp;·&nbsp;${escape(deal.promo_code)}</span>`
    : ''
  const expiry = deal.expiration_date
    ? `<span style="display:inline-block;font-family:${FONT_BODY};font-style:italic;font-size:13px;color:${INK_SOFT};${deal.promo_code ? 'margin-left:8px;' : ''}">Ends ${escape(deal.expiration_date)}</span>`
    : ''
  const meta = codeChip || expiry ? `<div style="margin-top:8px;">${codeChip}${expiry}</div>` : ''

  return `
            <table class="deal-row" role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
              <tr>
                <td class="deal-left" valign="top" style="vertical-align:top;padding-right:14px;width:64%;">
                  <a href="${link}" style="font-family:${FONT_TYPE};font-size:16px;line-height:1.45;color:${INK};text-decoration:none;">${description}</a>
                  ${meta}
                </td>
                <td class="deal-right" valign="top" align="right" style="vertical-align:top;text-align:right;width:36%;">
                  ${savingsBadge(deal)}
                </td>
              </tr>
            </table>`
}

// ── One retailer within a section: name + its deals (dashed dividers) ────
function retailerBlock(retailer: string, deals: Deal[]): string {
  const name = escape(retailer)
  const firstLink = escape(deals[0]?.affiliate_link || deals[0]?.original_link || '#')
  const count = deals.length
  const rows = deals
    .map((d, i) => dealRow(d) + (i < deals.length - 1 ? `\n            <hr style="border:0;border-top:1.5px dashed ${INK};margin:14px 0;">` : ''))
    .join('')
  return `
            <p style="margin:0 0 14px;">
              <a href="${firstLink}" style="font-family:${FONT_DISPLAY};font-size:24px;letter-spacing:.03em;line-height:1.1;color:${INK};text-decoration:none;border-bottom:2px solid ${INK};padding-bottom:2px;">${name}</a>
              <span style="font-family:${FONT_BODY};font-style:italic;color:${INK_SOFT};font-size:14px;margin-left:8px;">— ${count} ${count === 1 ? 'deal' : 'deals'}</span>
            </p>${rows}`
}

// ── One watch section: eyebrow + heading + retailer blocks (or empty) ────
function sectionBlock(s: WatchSection, index: number): string {
  const num = String(index + 1).padStart(2, '0')
  const eyebrow = `<p style="margin:0 0 12px;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.4em;text-transform:uppercase;color:${RED_DEEP};">— Section ${num} —</p>`
  const h2 = `<h2 style="margin:0 0 24px;font-family:${FONT_DISPLAY};font-weight:400;font-size:38px;line-height:1;letter-spacing:.04em;color:${INK};text-indent:.04em;">${shadowLastWord(s.label)}</h2>`

  if (s.deals.length === 0) {
    return `
        <tr>
          <td class="px" style="padding:36px 40px 32px;background:${PANEL};">
            ${eyebrow}
            ${h2}
            <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
              <tr>
                <td style="background:${PAPER};border:2px dashed ${INK};padding:24px 28px;text-align:center;">
                  <p style="margin:0;font-family:${FONT_BODY};font-style:italic;font-size:18px;line-height:1.4;color:${INK_SOFT};">Nothing fresh yet — we&rsquo;ll keep watching.</p>
                </td>
              </tr>
            </table>
          </td>
        </tr>`
  }

  // Group the section's deals by retailer.
  const byRetailer = new Map<string, Deal[]>()
  for (const d of s.deals) {
    const arr = byRetailer.get(d.retailer) ?? []
    arr.push(d)
    byRetailer.set(d.retailer, arr)
  }
  const retailers = Array.from(byRetailer.entries())
  const blocks = retailers
    .map(([retailer, deals], i) => {
      const top = i === 0 ? '0' : '24px'
      const bottom = i === retailers.length - 1 ? '28px' : '20px'
      const block = `
        <tr>
          <td class="px" style="padding:${top} 40px ${bottom};background:${PANEL};">${retailerBlock(retailer, deals)}
          </td>
        </tr>`
      const divider = i < retailers.length - 1
        ? `
        <tr><td class="px" style="padding:0 40px;background:${PANEL};"><hr style="border:0;border-top:1.5px solid ${INK};margin:0;"></td></tr>`
        : ''
      return block + divider
    })
    .join('')

  return `
        <tr>
          <td class="px" style="padding:36px 40px 0;background:${PANEL};">
            ${eyebrow}
            ${h2}
          </td>
        </tr>${blocks}`
}

// ── Empty-watchlist nudge ──────────────────────────────────────────────
// Sent to subscribers with no active watches. Retention touchpoint: a
// reminder the product exists + a one-click path to set up a watchlist.
export function generateEmptyWatchlistNudgeEmail({
  appUrl,
}: { appUrl: string }): string {
  const preferencesUrl = `${appUrl}/preferences`
  const suggestUrl = `${appUrl}/suggest`
  const unsubscribeUrl = `${appUrl}/unsubscribe`

  const step = (n: string, bg: string, numColor: string, title: string, body: string, last: boolean) => `
        <tr>
          <td class="px" style="padding:0 40px ${last ? '16px' : '8px'};background:${PANEL};">
            <table class="step-row" role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
              <tr>
                <td valign="middle" align="center" width="80" style="vertical-align:middle;text-align:center;padding:6px 10px 6px 0;">
                  <table role="presentation" cellpadding="0" cellspacing="0" border="0" style="display:inline-block;">
                    <tr><td style="background:${bg};border:2px solid ${INK};padding:10px 14px 8px;text-align:center;width:48px;">
                      <span style="font-family:${FONT_DISPLAY};color:${numColor};font-size:22px;line-height:1;">${n}</span>
                    </td></tr>
                  </table>
                </td>
                <td valign="middle" style="vertical-align:middle;padding:14px 0 14px 6px;${last ? '' : `border-bottom:1.5px dashed ${INK};`}">
                  <div style="font-family:${FONT_DISPLAY};font-size:20px;letter-spacing:.04em;color:${INK};line-height:1;margin-bottom:4px;">${title}</div>
                  <div style="font-family:${FONT_TYPE};font-size:14px;line-height:1.5;color:${INK_SOFT};">${body}</div>
                </td>
              </tr>
            </table>
          </td>
        </tr>`

  return `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="x-apple-disable-message-reformatting">
<meta name="color-scheme" content="light only">
<meta name="supported-color-schemes" content="light">
<title>You haven't told us what you want yet · Deal Dossier</title>
<link href="${FONT_LINK}" rel="stylesheet">
<style>
  body { margin:0 !important; padding:0 !important; width:100% !important; background:${CREAM}; }
  table { border-collapse:collapse !important; }
  img { -ms-interpolation-mode:bicubic; border:0; outline:none; }
  a { text-decoration:none; color:${INK}; }
  @media screen and (max-width:620px) {
    .container { width:100% !important; }
    .px { padding-left:22px !important; padding-right:22px !important; }
    .h-title { font-size:38px !important; line-height:1 !important; }
    .step-row td { display:block !important; width:100% !important; padding:6px 0 !important; }
  }
  [data-ogsc] body, body[data-ogsc] { background:${CREAM} !important; }
</style>
</head>
<body style="margin:0;padding:0;background:${CREAM};font-family:${FONT_TYPE};color:${INK};">
<div style="display:none;font-size:1px;color:${CREAM};line-height:1px;max-height:0;max-width:0;opacity:0;overflow:hidden;mso-hide:all;">Tell us what you're shopping for. The dossier writes itself once you do.</div>

<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="background:${CREAM};">
  <tr><td align="center" style="padding:24px 12px;">
    <table class="container" role="presentation" cellpadding="0" cellspacing="0" border="0" width="600" style="width:600px;max-width:600px;background:${PAPER};border:3px solid ${INK};">

      <!-- Header -->
      <tr>
        <td class="px" style="padding:28px 40px 22px;background:${DARK};border-bottom:3px solid ${INK};">
          <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"><tr>
            <td valign="middle" style="vertical-align:middle;">
              <table role="presentation" cellpadding="0" cellspacing="0" border="0" style="display:inline-block;"><tr>
                <td style="background:${RED};border:2px solid ${INK};padding:8px 14px 7px;font-family:${FONT_DISPLAY};color:${CREAM_TEXT};font-size:18px;letter-spacing:.04em;">DEAL DOSSIER</td>
              </tr></table>
            </td>
            <td valign="middle" align="right" style="vertical-align:middle;text-align:right;">
              <span style="font-family:${FONT_STAMP};color:${YELLOW};font-size:12px;letter-spacing:.3em;text-transform:uppercase;">${dateStamp()}</span>
            </td>
          </tr></table>
        </td>
      </tr>

      <!-- Hero -->
      <tr>
        <td class="px" align="center" style="padding:60px 40px 8px;background:${DARK};">
          <p style="margin:0 0 18px;font-family:${FONT_STAMP};color:${YELLOW};font-size:11px;letter-spacing:.55em;text-transform:uppercase;text-indent:.55em;">— A Friendly Reminder —</p>
          <h1 class="h-title" style="margin:0;font-family:${FONT_DISPLAY};font-weight:400;color:${CREAM_TEXT};font-size:52px;line-height:.98;letter-spacing:.04em;text-indent:.04em;">You haven&rsquo;t told us<br>${shadowLastWord('what you want.', CREAM_TEXT)}</h1>
        </td>
      </tr>
      <tr>
        <td class="px" align="center" style="padding:22px 56px 56px;background:${DARK};border-bottom:3px solid ${INK};">
          <p style="margin:0;font-family:${FONT_BODY};font-style:italic;color:${HERO_SUB};font-size:18px;line-height:1.5;">Yet. The dossier writes itself once you do.</p>
        </td>
      </tr>

      <!-- Body -->
      <tr>
        <td class="px" style="padding:36px 56px 8px;background:${PANEL};">
          <p style="margin:0 0 18px;font-family:${FONT_BODY};font-size:20px;line-height:1.5;color:${INK};">You signed up — thank you. But we haven&rsquo;t heard <em style="font-style:italic;color:${RED_DEEP};">what</em> you&rsquo;re shopping for yet, so we don&rsquo;t have anything to send you.</p>
          <p style="margin:0 0 28px;font-family:${FONT_TYPE};font-size:16px;line-height:1.6;color:${INK_SOFT};">Pick a few categories — towels, mens jeans, a new mattress, perfume, whatever — and we&rsquo;ll watch every relevant retailer for real markdowns. The moment one matches, your inbox knows.</p>
          <p style="margin:0 0 18px;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.4em;text-transform:uppercase;color:${RED_DEEP};">— Three Steps —</p>
        </td>
      </tr>
${step('01', INK, YELLOW, 'PICK', 'Choose the categories you&rsquo;re actively shopping for. As broad as &ldquo;Womens Apparel&rdquo; or as narrow as &ldquo;Mens Denim&rdquo;.', false)}
${step('02', RED, CREAM_TEXT, 'WE WATCH', '1,700+ retailer newsletters land in our inbox. We extract the real markdowns and tag every one.', false)}
${step('03', GREEN, CREAM_TEXT, 'WE EMAIL', 'Matches arrive in a single dossier — never spam, never welcome codes, never noise.', true)}

      <!-- CTA -->
      <tr>
        <td class="px" align="center" style="padding:32px 40px 44px;background:${PANEL};border-bottom:3px solid ${INK};">
          <table role="presentation" cellpadding="0" cellspacing="0" border="0" style="display:inline-block;"><tr>
            <td align="center" style="background:${RED};border:2.5px solid ${INK};box-shadow:6px 6px 0 ${INK};">
              <a href="${preferencesUrl}" style="display:inline-block;padding:18px 36px 16px;font-family:${FONT_DISPLAY};color:${CREAM_TEXT};font-size:22px;letter-spacing:.14em;text-indent:.14em;text-decoration:none;">SET UP YOUR WATCHLIST →</a>
            </td>
          </tr></table>
          <p style="margin:18px 0 0;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.3em;text-transform:uppercase;color:${INK_SOFT};">No card · Cancel anytime</p>
        </td>
      </tr>

      <!-- Aside -->
      <tr>
        <td class="px" style="padding:32px 40px;background:${PAPER};border-bottom:3px solid ${INK};">
          <p style="margin:0;font-family:${FONT_BODY};font-style:italic;font-size:16px;line-height:1.55;color:${INK_SOFT};">Already not shopping for anything? <a href="${unsubscribeUrl}" style="color:${RED};text-decoration:underline;text-decoration-style:dotted;">unsubscribe here</a> — no hard feelings. We only want to be in inboxes that want us.</p>
        </td>
      </tr>

      <!-- Footer -->
      <tr><td class="px" align="center" style="padding:44px 40px 28px;background:${CREAM};">
        <div style="font-family:${FONT_DISPLAY};font-size:42px;letter-spacing:.08em;line-height:.9;color:${INK};">DEAL&nbsp;D<span style="color:${RED};">O</span>SSIER</div>
      </td></tr>
      <tr><td class="px" align="center" style="padding:0 40px 18px;background:${CREAM};">
        <p style="margin:0;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.18em;text-transform:uppercase;color:${INK_SOFT};">
          <a href="${preferencesUrl}" style="color:${INK_SOFT};text-decoration:none;padding:0 6px;">Settings</a> ·
          <a href="${suggestUrl}" style="color:${INK_SOFT};text-decoration:none;padding:0 6px;">Suggest a Store</a> ·
          <a href="${unsubscribeUrl}" style="color:${INK_SOFT};text-decoration:none;padding:0 6px;">Unsubscribe</a>
        </p>
      </td></tr>
      <tr><td class="px" align="center" style="padding:0 40px 36px;background:${CREAM};">
        <p style="margin:0;font-family:${FONT_BODY};font-style:italic;font-size:13px;color:${INK_SOFT};">An Hours &amp; Co. publication · © 2026</p>
      </td></tr>

    </table>
  </td></tr>
</table>
</body>
</html>`
}

// ── Watchlist deal email ───────────────────────────────────────────────
export function generateWatchlistEmail({
  appUrl,
  watchSections,
}: WatchlistEmailInput): string {
  const totalDeals = watchSections.reduce((sum, s) => sum + s.deals.length, 0)
  const matched = watchSections.filter((s) => s.deals.length > 0).length
  const total = watchSections.length
  const topMarkdown = watchSections
    .flatMap((s) => s.deals)
    .reduce((max, d) => Math.max(max, d.percent_off ?? 0), 0)
  const preferencesUrl = `${appUrl}/preferences`
  const suggestUrl = `${appUrl}/suggest`
  const unsubscribeUrl = `${appUrl}/unsubscribe`
  const todayLong = format(new Date(), 'MMMM d, yyyy')

  const headline = totalDeals === 0
    ? `Still ${shadowLastWord('watching.', CREAM_TEXT)}`
    : `${totalDeals} ${shadowLastWord(`fresh ${totalDeals === 1 ? 'deal' : 'deals'}`, CREAM_TEXT)}<br>this morning.`
  const subline = totalDeals === 0
    ? `Nothing matched your ${total === 1 ? 'watch' : 'watches'} today — but we&rsquo;re still on it. We&rsquo;ll email the moment something lands.`
    : `${matched} of your ${total} ${total === 1 ? 'watch' : 'watches'} matched. We skipped the noise — these are worth a look.`

  const stat = (value: string, label: string, valueColor: string = INK) =>
    `<td align="center" style="padding:0 8px;">
                  <div style="font-family:${FONT_DISPLAY};font-size:28px;line-height:1;color:${valueColor};">${value}</div>
                  <div style="font-family:${FONT_STAMP};font-size:10px;letter-spacing:.2em;text-transform:uppercase;color:${INK_SOFT};margin-top:4px;">${label}</div>
                </td>`

  const sectionsHtml = watchSections
    .map((s, i) => sectionBlock(s, i))
    .join(`
        <tr><td class="px" style="padding:0 40px;background:${PANEL};"><hr style="border:0;border-top:3px solid ${INK};margin:0;"></td></tr>`)

  return `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="x-apple-disable-message-reformatting">
<meta name="color-scheme" content="light only">
<meta name="supported-color-schemes" content="light">
<title>Your watchlist deals · ${todayLong}</title>
<link href="${FONT_LINK}" rel="stylesheet">
<style>
  body { margin:0 !important; padding:0 !important; width:100% !important; background:${CREAM}; }
  table { border-collapse:collapse !important; }
  img { -ms-interpolation-mode:bicubic; border:0; outline:none; }
  a { text-decoration:none; color:${INK}; }
  @media screen and (max-width:620px) {
    .container { width:100% !important; }
    .px { padding-left:20px !important; padding-right:20px !important; }
    .deal-row .deal-left, .deal-row .deal-right { display:block !important; width:100% !important; padding:0 0 12px !important; text-align:left !important; }
    .badge-wrap { margin:6px 0 14px !important; }
    .h-title { font-size:36px !important; line-height:1 !important; }
    .stat-stack td { display:block !important; width:100% !important; padding:4px 0 !important; }
  }
  [data-ogsc] body, body[data-ogsc] { background:${CREAM} !important; }
</style>
</head>
<body style="margin:0;padding:0;background:${CREAM};font-family:${FONT_TYPE};color:${INK};">
<div style="display:none;font-size:1px;color:${CREAM};line-height:1px;max-height:0;max-width:0;opacity:0;overflow:hidden;mso-hide:all;">${totalDeals === 0 ? 'Still watching your list — nothing fresh to report yet.' : `${totalDeals} fresh ${totalDeals === 1 ? 'deal' : 'deals'} across your watchlist.`}</div>

<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="background:${CREAM};">
  <tr><td align="center" style="padding:24px 12px;">
    <table class="container" role="presentation" cellpadding="0" cellspacing="0" border="0" width="600" style="width:600px;max-width:600px;background:${PAPER};border:3px solid ${INK};">

      <!-- Header -->
      <tr>
        <td class="px" style="padding:28px 40px 22px;background:${DARK};border-bottom:3px solid ${INK};">
          <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"><tr>
            <td valign="middle" style="vertical-align:middle;">
              <table role="presentation" cellpadding="0" cellspacing="0" border="0" style="display:inline-block;"><tr>
                <td style="background:${RED};border:2px solid ${INK};padding:8px 14px 7px;font-family:${FONT_DISPLAY};color:${CREAM_TEXT};font-size:18px;letter-spacing:.04em;">DEAL DOSSIER</td>
              </tr></table>
            </td>
            <td valign="middle" align="right" style="vertical-align:middle;text-align:right;">
              <span style="font-family:${FONT_STAMP};color:${YELLOW};font-size:12px;letter-spacing:.3em;text-transform:uppercase;">${dateStamp()}</span>
            </td>
          </tr></table>
        </td>
      </tr>

      <!-- Hero -->
      <tr>
        <td class="px" align="center" style="padding:44px 40px 8px;background:${DARK};">
          <p style="margin:0 0 14px;font-family:${FONT_STAMP};color:${YELLOW};font-size:11px;letter-spacing:.55em;text-transform:uppercase;text-indent:.55em;">— Your Watchlist —</p>
          <h1 class="h-title" style="margin:0;font-family:${FONT_DISPLAY};font-weight:400;color:${CREAM_TEXT};font-size:52px;line-height:.98;letter-spacing:.04em;text-indent:.04em;">${headline}</h1>
        </td>
      </tr>
      <tr>
        <td class="px" align="center" style="padding:18px 56px 44px;background:${DARK};border-bottom:3px solid ${INK};">
          <p style="margin:0;font-family:${FONT_BODY};font-style:italic;color:${HERO_SUB};font-size:17px;line-height:1.5;">${subline}</p>
        </td>
      </tr>

      <!-- At-a-glance stats -->
      <tr>
        <td class="px" style="padding:28px 40px 8px;background:${PANEL};">
          <table class="stat-stack" role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"><tr>
                ${stat(String(totalDeals), 'Fresh Deals')}
                ${stat(`${matched} / ${total}`, 'Watches Matched')}
                ${stat(topMarkdown > 0 ? `${topMarkdown}%` : '—', 'Top Markdown', topMarkdown > 0 ? RED : INK)}
          </tr></table>
        </td>
      </tr>
      <tr><td class="px" style="background:${PANEL};padding:24px 40px 0;"><hr style="border:0;border-top:2px dashed ${INK};margin:0;"></td></tr>

      <!-- Sections -->
${sectionsHtml}

      <!-- Postscript -->
      <tr>
        <td class="px" style="padding:36px 40px;background:${PAPER};border-top:3px solid ${INK};border-bottom:3px solid ${INK};">
          <p style="margin:0 0 14px;font-family:${FONT_BODY};font-style:italic;font-size:18px;line-height:1.5;color:${INK};">That&rsquo;s it for now. If a deal you wanted didn&rsquo;t make the cut, it&rsquo;s because we ranked it below the noise — not because we missed it.</p>
          <p style="margin:0;font-family:${FONT_TYPE};font-size:14px;line-height:1.5;color:${INK_SOFT};">Want to add a category, narrow one, or pause for a bit? &nbsp;<a href="${preferencesUrl}" style="color:${RED};text-decoration:none;">Open your watchlist →</a></p>
        </td>
      </tr>

      <!-- Footer -->
      <tr><td class="px" align="center" style="padding:44px 40px 28px;background:${CREAM};">
        <div style="font-family:${FONT_DISPLAY};font-size:42px;letter-spacing:.08em;line-height:.9;color:${INK};">DEAL&nbsp;D<span style="color:${RED};">O</span>SSIER</div>
      </td></tr>
      <tr><td class="px" align="center" style="padding:0 40px 18px;background:${CREAM};">
        <p style="margin:0;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.18em;text-transform:uppercase;color:${INK_SOFT};">
          <a href="${preferencesUrl}" style="color:${INK_SOFT};text-decoration:none;padding:0 6px;">Settings</a> ·
          <a href="${suggestUrl}" style="color:${INK_SOFT};text-decoration:none;padding:0 6px;">Suggest a Store</a> ·
          <a href="${unsubscribeUrl}" style="color:${INK_SOFT};text-decoration:none;padding:0 6px;">Unsubscribe</a>
        </p>
      </td></tr>
      <tr><td class="px" align="center" style="padding:0 40px 36px;background:${CREAM};">
        <p style="margin:0;font-family:${FONT_BODY};font-style:italic;font-size:13px;color:${INK_SOFT};">An Hours &amp; Co. publication · © 2026</p>
      </td></tr>

    </table>
  </td></tr>
</table>
</body>
</html>`
}
