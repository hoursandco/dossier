'use client'

// Fires a GA4 event once, on mount. Drop into a server component (e.g.
// /pricing/success) that can't call trackEvent directly. Renders nothing.

import { useEffect } from 'react'
import { trackEvent } from '@/lib/analytics'

export function GaEvent({
  event,
  params,
}: {
  event: string
  params?: Record<string, unknown>
}) {
  useEffect(() => {
    trackEvent(event, params)
    // Fire exactly once on mount — the event marks a page arrival.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])
  return null
}
