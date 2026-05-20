// Google Analytics 4 event helper.
//
// gtag.js + the base config (which fires the automatic page_view) live
// in the root layout (app/layout.tsx). Turn on Enhanced Measurement in
// the GA4 property so client-side route changes also register as page
// views. This module fires the custom *funnel* events on top of that:
//
//   sign_up        → email captured (/login form, homepage hero form)
//   cta_click      → a key call-to-action link clicked
//   deals_pull     → "send me deals now" — the on-demand action
//   store_add      → a store added to the watchlist
//   category_add   → a category added to the watchlist
//   begin_checkout → Stripe upgrade flow started
//   purchase       → paid subscription completed
//
// gtag queues calls internally, so trackEvent works even before the
// gtag.js script has finished loading. If GA is blocked/absent the
// optional-chain call simply no-ops.

declare global {
  interface Window {
    gtag?: (...args: unknown[]) => void
  }
}

export function trackEvent(
  event: string,
  params?: Record<string, unknown>
): void {
  if (typeof window === 'undefined') return
  window.gtag?.('event', event, params)
}
