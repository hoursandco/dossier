// Shared free-tier "pick limit" math.
//
// A subscriber's "picks" total = category watches + store picks.
// Free tier caps at FREE_PICK_LIMIT total. Paid (or comped) is
// unlimited. Used by:
//
//   /api/watches POST      — refuses to add a 4th watch
//   /api/store-picks POST  — same, but counts watches too
//   /api/deals/refresh     — refuses to send if a downgraded user
//                            has more picks than the free limit
//                            (the "frozen sends until they prune" UX)
//
// We do TWO count queries in parallel rather than one combined query
// because the two tables aren't joinable by a single column. The
// queries are HEAD requests (count-only, no rows returned) so the
// network cost is negligible.

import type { SupabaseClient } from '@supabase/supabase-js'

export const FREE_PICK_LIMIT = 3

export async function countTotalPicks(
  service: SupabaseClient,
  subscriberId: string
): Promise<number> {
  const [watches, stores] = await Promise.all([
    service
      .from('subscriber_watches')
      .select('id', { count: 'exact', head: true })
      .eq('subscriber_id', subscriberId),
    service
      .from('subscriber_stores')
      .select('id', { count: 'exact', head: true })
      .eq('subscriber_id', subscriberId),
  ])

  // subscriber_stores may not exist yet pre-migration-028. Treat
  // missing-table as zero rather than failing the parent operation.
  const watchCount = watches.count ?? 0
  let storeCount = 0
  if (stores.error) {
    const code = (stores.error as { code?: string }).code
    if (code !== '42P01' && code !== 'PGRST205') {
      console.warn('[pickLimits] store count error (continuing as 0):', JSON.stringify(stores.error))
    }
  } else {
    storeCount = stores.count ?? 0
  }

  return watchCount + storeCount
}
