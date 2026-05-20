'use client'

// Fires a Meta Pixel conversion event once, on mount. Drop this into a
// server component (e.g. /pricing/success) that can't call trackPixel
// directly. Renders nothing.

import { useEffect } from 'react'
import { trackPixel, type PixelEvent as PixelEventName } from '@/lib/pixel'

export function PixelEvent({
  event,
  params,
}: {
  event: PixelEventName
  params?: Record<string, unknown>
}) {
  useEffect(() => {
    trackPixel(event, params)
    // Fire exactly once on mount — the event marks a page arrival.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])
  return null
}
