// Meta Pixel conversion-event helper.
//
// The base pixel + automatic PageView fire from the root layout
// (app/layout.tsx). This module fires the *conversion* events on top
// of that — the moments that actually matter for ad optimization and
// reporting:
//
//   Lead      → magic-link form submitted on /login (signup intent)
//   Purchase  → landed on /pricing/success (paid subscription)
//
// fbq queues calls internally, so trackPixel works even if it runs
// before fbevents.js has finished loading. If the pixel isn't present
// at all (e.g. blocked), the optional-chain call simply no-ops.

declare global {
  interface Window {
    fbq?: (...args: unknown[]) => void
  }
}

export type PixelEvent =
  | 'Lead'
  | 'CompleteRegistration'
  | 'InitiateCheckout'
  | 'Subscribe'
  | 'Purchase'

export function trackPixel(
  event: PixelEvent,
  params?: Record<string, unknown>
): void {
  if (typeof window === 'undefined') return
  window.fbq?.('track', event, params)
}
