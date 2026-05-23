import { createClient, createServiceClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import { format, subDays } from 'date-fns'
import { Reveal } from '@/components/Reveal'
import { FlapNumber } from '@/components/FlapNumber'
import { SuggestionActions } from '@/components/SuggestionActions'
import { RunIngestButton } from '@/components/RunIngestButton'
import { SubscriptionsPanel } from '@/components/SubscriptionsPanel'
import { CouponsPanel } from '@/components/CouponsPanel'
import { AutoAddedStoresPanel } from '@/components/AutoAddedStoresPanel'
import { DuplicateStoresPanel } from '@/components/DuplicateStoresPanel'
import { StoresAdmin } from '@/components/StoresAdmin'
import { AdminTabs } from '@/components/AdminTabs'
import { isAdminEmail } from '@/lib/admin'

export const dynamic = 'force-dynamic'

// ── Numbered editorial section header ──────────────────────────────────
function SectionLabel({ n, children }: { n: string; children: React.ReactNode }) {
  return (
    <div className="t-meta" style={{ color: 'var(--olive-deep)' }}>
      <span style={{ color: 'var(--ink-25)', marginRight: 10 }}>{n}</span>
      {children}
    </div>
  )
}

// ── Ranked list row (rank + label + count) ─────────────────────────────
function ListRow({
  rank,
  label,
  count,
  countAccent = false,
  labelMono = false,
}: {
  rank: number
  label: React.ReactNode
  count: React.ReactNode
  countAccent?: boolean
  labelMono?: boolean
}) {
  return (
    <div className="admin-list-row">
      <span
        className="t-mono"
        style={{ color: 'var(--ink-40)', minWidth: 22 }}
      >
        {String(rank).padStart(2, '0')}
      </span>
      <span
        style={{
          flex: 1,
          fontSize: labelMono ? 12 : 14,
          fontFamily: labelMono ? 'var(--font-mono)' : 'var(--font-sans)',
          color: labelMono ? 'var(--ink-70)' : 'var(--ink)',
          overflow: 'hidden',
          textOverflow: 'ellipsis',
          whiteSpace: 'nowrap',
        }}
      >
        {label}
      </span>
      <span
        className="t-mono"
        style={{ color: countAccent ? 'var(--olive-deep)' : 'var(--ink-55)' }}
      >
        {count}
      </span>
    </div>
  )
}

export default async function AdminPage() {
  // ── Auth ──────────────────────────────────────────────────────────────
  const authClient = await createClient()
  const {
    data: { user },
  } = await authClient.auth.getUser()

  if (!isAdminEmail(user?.email)) {
    redirect('/')
  }

  const db = createServiceClient()
  const now = new Date()
  const sevenDaysAgo = format(subDays(now, 7), 'yyyy-MM-dd')
  const thirtyDaysAgo = format(subDays(now, 30), 'yyyy-MM-dd')

  // ── Parallel data fetch ───────────────────────────────────────────────
  // Single Promise.all for the Data tab + Review Queue tab content
  // (Store Suggestions). Subscription / Coupons / Manage-Stores / the
  // other Review panels do their own client-side fetches when the tab
  // mounts — keeps the initial page load fast and means hitting a tab
  // shows fresh data without a full page refresh.
  const [
    { count: totalSubscribers },
    { count: activeSubscribers },
    { data: tierData },
    { count: newThisWeek },
    { data: recentSubscribers },
    { count: totalEmailsSent },
    { count: sentThisWeek },
    { data: topRetailers },
    { count: totalEmailsScannedCount },
    { count: totalDealsFoundCount },
    { data: retailerScanLog },
    { data: storeSuggestions },
  ] = await Promise.all([
    db.from('subscribers').select('*', { count: 'exact', head: true }),
    db.from('subscribers').select('*', { count: 'exact', head: true }).eq('is_active', true),
    db.from('subscribers').select('tier').eq('is_active', true),
    db.from('subscribers').select('*', { count: 'exact', head: true }).gte('created_at', sevenDaysAgo),
    db.from('subscribers').select('email, tier, created_at').order('created_at', { ascending: false }).limit(3),
    db.from('sent_emails').select('*', { count: 'exact', head: true }),
    db.from('sent_emails').select('*', { count: 'exact', head: true }).gte('created_at', sevenDaysAgo),
    db.from('deals').select('retailer').gte('created_at', thirtyDaysAgo),
    db.from('processed_emails').select('*', { count: 'exact', head: true }),
    db.from('deals').select('*', { count: 'exact', head: true }),
    db.from('retailer_scan_log').select('retailer, sender_email, emails_processed, deals_extracted').order('emails_processed', { ascending: false }),
    db.from('store_suggestions').select('id, store_name, website, category, notes, status, created_at').order('created_at', { ascending: false }).limit(50),
  ])

  // ── Derived stats ─────────────────────────────────────────────────────
  const freeCount = (tierData || []).filter((r) => r.tier === 'free').length
  const paidCount = (tierData || []).filter((r) => r.tier === 'paid').length

  // Top retailers (last 30 days)
  const retailerCounts: Record<string, number> = {}
  for (const row of topRetailers || []) {
    if (row.retailer) retailerCounts[row.retailer] = (retailerCounts[row.retailer] || 0) + 1
  }
  const topRetailerList = Object.entries(retailerCounts)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 10)

  const totalEmailsScanned = totalEmailsScannedCount ?? 0
  const totalDealsFound = totalDealsFoundCount ?? 0

  // Newsletter performance — aggregate by retailer
  const retailerAggMap = new Map<
    string,
    { retailer: string; sender_email: string; emails_processed: number; deals_extracted: number }
  >()
  for (const row of retailerScanLog || []) {
    const key = row.retailer
    const existing = retailerAggMap.get(key)
    if (existing) {
      existing.emails_processed += row.emails_processed
      existing.deals_extracted += row.deals_extracted
    } else {
      retailerAggMap.set(key, { ...row })
    }
  }
  const aggregatedScanLog = Array.from(retailerAggMap.values())
  const dealProducers = aggregatedScanLog
    .filter((r) => r.deals_extracted > 0)
    .sort((a, b) => b.deals_extracted - a.deals_extracted)
    .slice(0, 15)
  const zeroDealSenders = aggregatedScanLog
    .filter((r) => r.deals_extracted === 0)
    .sort((a, b) => b.emails_processed - a.emails_processed)
    .slice(0, 15)

  // Pending-suggestions count → badge on the Review Queue tab.
  const pendingSuggestions = (storeSuggestions || []).filter((s) => s.status === 'pending').length

  // ── Tab content blocks ────────────────────────────────────────────────
  // Each block is JSX assigned to a const so the AdminTabs call at the
  // bottom of the return stays readable. All the data-tab sections come
  // from the server-fetched data above; the other tabs delegate to
  // client components that fetch their own data on mount.

  const dataTab = (
    <>
      {/* 01 Subscribers */}
      <Reveal delay={120}>
        <div className="admin-section-label">
          <SectionLabel n="01">Subscribers</SectionLabel>
        </div>
        <div className="admin-stat-row admin-stat-row-5">
          {[
            {
              n: totalSubscribers ?? 0,
              l: 'Total Subscribers',
              sub: null,
              accent: false,
            },
            {
              n: activeSubscribers ?? 0,
              l: 'Active',
              sub:
                totalSubscribers && totalSubscribers > 0
                  ? `${Math.round(((activeSubscribers ?? 0) / totalSubscribers) * 100)}% of total`
                  : null,
              accent: false,
            },
            { n: freeCount, l: 'Free Tier', sub: null, accent: false },
            { n: paidCount, l: 'Paid Tier', sub: null, accent: false },
            {
              n: newThisWeek ?? 0,
              l: 'New This Week',
              sub: '+ trending',
              accent: true,
            },
          ].map(({ n, l, sub, accent }) => (
            <div
              key={l}
              className={`admin-stat ${accent ? 'admin-stat-accent' : ''}`}
            >
              <div className="admin-stat-num">
                <FlapNumber value={String(n)} />
              </div>
              <div className="t-meta admin-stat-label">{l}</div>
              {sub && <div className="admin-stat-sub">{sub}</div>}
            </div>
          ))}
        </div>
      </Reveal>

      {/* 02 Pipeline Totals */}
      <Reveal delay={160}>
        <div className="admin-section-label" style={{ marginTop: 64 }}>
          <SectionLabel n="02">Pipeline Totals</SectionLabel>
        </div>
        <div className="admin-stat-row admin-stat-row-4">
          {[
            { n: totalEmailsScanned, l: 'Emails Scanned' },
            { n: totalDealsFound, l: 'Deals Extracted' },
            { n: totalEmailsSent ?? 0, l: 'Emails Delivered' },
            { n: sentThisWeek ?? 0, l: 'Delivered This Week' },
          ].map(({ n, l }) => (
            <div key={l} className="admin-stat">
              <div className="admin-stat-num">
                <FlapNumber value={String(n)} />
              </div>
              <div className="t-meta admin-stat-label">{l}</div>
            </div>
          ))}
        </div>
      </Reveal>

      {/* 03 / 04 / 05 — Top Retailers · Deal Producers · Zero-Deal */}
      <div className="admin-3col" style={{ marginTop: 32 }}>
        <Reveal>
          <div className="admin-card admin-card-tight">
            <SectionLabel n="03">Top Retailers · 30 Days</SectionLabel>
            <div className="admin-list" style={{ marginTop: 20 }}>
              {topRetailerList.length === 0 ? (
                <p className="t-meta" style={{ color: 'var(--ink-40)' }}>
                  No deals in the last 30 days
                </p>
              ) : (
                topRetailerList.map(([retailer, count], i) => (
                  <ListRow
                    key={retailer}
                    rank={i + 1}
                    label={retailer}
                    count={`${count} deal${count !== 1 ? 's' : ''}`}
                  />
                ))
              )}
            </div>
          </div>
        </Reveal>

        <Reveal delay={80}>
          <div className="admin-card admin-card-tight">
            <SectionLabel n="04">Deal-Producing Newsletters</SectionLabel>
            <div className="admin-list" style={{ marginTop: 20 }}>
              {dealProducers.length === 0 ? (
                <p className="t-meta" style={{ color: 'var(--ink-40)' }}>
                  No data yet
                </p>
              ) : (
                dealProducers.slice(0, 10).map((r, i) => (
                  <ListRow
                    key={r.retailer}
                    rank={i + 1}
                    label={r.retailer}
                    count={r.deals_extracted}
                    countAccent
                  />
                ))
              )}
            </div>
          </div>
        </Reveal>

        <Reveal delay={160}>
          <div className="admin-card admin-card-tight">
            <SectionLabel n="05">Zero-Deal · Consider Unsub</SectionLabel>
            {zeroDealSenders.length === 0 ? (
              <p style={{ marginTop: 20, fontSize: 13, color: 'var(--ink-55)' }}>
                All scanned senders have produced at least one deal.
              </p>
            ) : (
              <div className="admin-list" style={{ marginTop: 20 }}>
                {zeroDealSenders.slice(0, 10).map((r, i) => (
                  <ListRow
                    key={r.retailer}
                    rank={i + 1}
                    label={r.retailer}
                    count={`${r.emails_processed}`}
                    labelMono={false}
                  />
                ))}
              </div>
            )}
          </div>
        </Reveal>
      </div>

      {/* 06 — Recent Signups */}
      <div style={{ marginTop: 32 }}>
        <Reveal>
          <div className="admin-card">
            <SectionLabel n="06">Recent Signups</SectionLabel>
            <div className="admin-table" style={{ marginTop: 20 }}>
              <div
                className="admin-table-head"
                style={{ gridTemplateColumns: '2fr 0.7fr 0.8fr' }}
              >
                <div>Email</div>
                <div>Tier</div>
                <div>Joined</div>
              </div>
              {!recentSubscribers || recentSubscribers.length === 0 ? (
                <p style={{ marginTop: 20, fontSize: 13, color: 'var(--ink-55)' }}>
                  No subscribers yet.
                </p>
              ) : (
                recentSubscribers.map((sub, i) => (
                  <div
                    key={i}
                    className="admin-table-row"
                    style={{ gridTemplateColumns: '2fr 0.7fr 0.8fr' }}
                  >
                    <div
                      className="t-mono"
                      style={{
                        fontSize: 12,
                        overflow: 'hidden',
                        textOverflow: 'ellipsis',
                        whiteSpace: 'nowrap',
                      }}
                    >
                      {sub.email}
                    </div>
                    <div>
                      <span className={`tier-badge ${sub.tier}`}>{sub.tier}</span>
                    </div>
                    <div className="t-meta" style={{ color: 'var(--ink-40)' }}>
                      {format(new Date(sub.created_at), 'MMM d')}
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
        </Reveal>
      </div>
    </>
  )

  const subscriptionsTab = (
    <div className="admin-card">
      <p className="t-meta" style={{ color: 'var(--ink-40)', marginBottom: 20 }}>
        Comp / uncomp accounts, cancel or reactivate Stripe subscriptions, refund the latest invoice. Search by email to find any subscriber.
      </p>
      <SubscriptionsPanel />
    </div>
  )

  const couponsTab = (
    <div className="admin-card">
      <p className="t-meta" style={{ color: 'var(--ink-40)', marginBottom: 20 }}>
        Create Stripe promotion codes customers enter at /pricing. Deactivate = stops working immediately, history preserved.
      </p>
      <CouponsPanel />
    </div>
  )

  const reviewTab = (
    <>
      {/* 01 — Auto-Added Stores */}
      <Reveal>
        <div className="admin-card">
          <SectionLabel n="01">Auto-Added Stores</SectionLabel>
          <p className="t-meta" style={{ color: 'var(--ink-40)', marginTop: 8, marginBottom: 20 }}>
            Brands the ingest cron discovered from a first-time promotional email. Already live in the directory — approve to graduate to a regular store, decline to hide from future runs.
          </p>
          <AutoAddedStoresPanel />
        </div>
      </Reveal>

      {/* 02 — Store Suggestions (user-submitted) */}
      <Reveal delay={80}>
        <div className="admin-card" style={{ marginTop: 32 }}>
          <SectionLabel n="02">Store Suggestions</SectionLabel>
          <p className="t-meta" style={{ color: 'var(--ink-40)', marginTop: 8, marginBottom: 20 }}>
            Brands submitted by subscribers via /suggest. Respond with a preset action or delete to clear from the queue.
          </p>
          {(storeSuggestions || []).length === 0 ? (
            <p className="t-meta" style={{ color: 'var(--ink-40)', fontStyle: 'italic' }}>
              No suggestions in the queue.
            </p>
          ) : (
            <div className="admin-table" style={{ marginTop: 8 }}>
              <div
                className="admin-table-head"
                style={{ gridTemplateColumns: '1.3fr 1.2fr 1.2fr 1.3fr 0.7fr 0.6fr 0.8fr' }}
              >
                <div>Store</div>
                <div>Website</div>
                <div>Categories</div>
                <div>Notes</div>
                <div>Status</div>
                <div>Date</div>
                <div></div>
              </div>
              {(storeSuggestions || []).map((s) => (
                <div
                  key={s.id}
                  className="admin-table-row"
                  style={{ gridTemplateColumns: '1.3fr 1.2fr 1.2fr 1.3fr 0.7fr 0.6fr 0.8fr' }}
                >
                  <div>
                    <div
                      style={{
                        fontFamily: 'var(--font-serif)',
                        fontSize: 18,
                        fontWeight: 350,
                        letterSpacing: '-0.01em',
                      }}
                    >
                      {s.store_name}
                    </div>
                  </div>
                  <div className="t-mono" style={{ fontSize: 12 }}>
                    {s.website ? (
                      <a
                        href={s.website.startsWith('http') ? s.website : `https://${s.website}`}
                        target="_blank"
                        rel="noopener noreferrer"
                        style={{
                          color: 'var(--olive-deep)',
                          textDecoration: 'none',
                          borderBottom: '1px solid currentColor',
                          wordBreak: 'break-all',
                        }}
                      >
                        {s.website.replace(/^https?:\/\//, '')}
                      </a>
                    ) : (
                      <span style={{ color: 'var(--ink-25)' }}>—</span>
                    )}
                  </div>
                  <div style={{ fontSize: 12, color: 'var(--ink-70)', lineHeight: 1.5 }}>
                    {s.category || <span style={{ color: 'var(--ink-25)' }}>—</span>}
                  </div>
                  <div style={{ fontSize: 13, color: 'var(--ink-70)', lineHeight: 1.5 }}>
                    {s.notes || <span style={{ color: 'var(--ink-25)' }}>—</span>}
                  </div>
                  <div>
                    {s.status === 'pending' ? (
                      <span className="t-meta" style={{ color: 'var(--ink-40)' }}>
                        ○ Pending
                      </span>
                    ) : (
                      <span className="t-meta" style={{ color: 'var(--olive-deep)' }}>
                        ●{' '}
                        {s.status === 'added'
                          ? 'Added'
                          : s.status.charAt(0).toUpperCase() + s.status.slice(1)}
                      </span>
                    )}
                  </div>
                  <div className="t-meta" style={{ color: 'var(--ink-40)' }}>
                    {format(new Date(s.created_at), 'MMM d')}
                  </div>
                  <div style={{ textAlign: 'right' }}>
                    <SuggestionActions
                      suggestionId={s.id}
                      storeName={s.store_name}
                      initialStatus={s.status}
                    />
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </Reveal>

      {/* 03 — Duplicate Stores */}
      <Reveal delay={160}>
        <div className="admin-card" style={{ marginTop: 32 }}>
          <SectionLabel n="03">Duplicate Stores</SectionLabel>
          <p className="t-meta" style={{ color: 'var(--ink-40)', marginTop: 8, marginBottom: 20 }}>
            Two or more rows pointing at the same brand domain. Pick the row to keep — the others get hard-deleted to free up the unique-website index.
          </p>
          <DuplicateStoresPanel />
        </div>
      </Reveal>
    </>
  )

  const storesTab = <StoresAdmin />

  // ── Render ────────────────────────────────────────────────────────────
  return (
    <div className="admin-route">
      <nav className="nav">
        <a className="brand" href="/">
          <span className="brand-badge">DEAL DOSSIER</span>
          <span className="brand-sub">— the weekly brief</span>
        </a>
        <div className="nav-links">
          <a href="/suggest">Suggest a Store</a>
          <a href="/preferences">Settings</a>
          <a href="/admin" className="active">Admin</a>
        </div>
      </nav>

      <section style={{ padding: 'clamp(48px, 6vw, 72px) 0 clamp(56px, 7vw, 80px)' }}>
        <div className="wrap">
          {/* Header */}
          <div className="admin-header">
            <div>
              <Reveal>
                <div
                  style={{
                    fontFamily: "'Stardos Stamp', sans-serif",
                    fontSize: 11,
                    letterSpacing: '.4em',
                    textTransform: 'uppercase',
                    color: 'var(--red-deep)',
                  }}
                >
                  — Dashboard —
                </div>
              </Reveal>
              <Reveal delay={80}>
                <h1
                  style={{
                    fontFamily: "'Alfa Slab One', serif",
                    fontWeight: 400,
                    fontSize: 'clamp(40px, 5vw, 72px)',
                    marginTop: 16,
                    lineHeight: 1,
                    letterSpacing: '.04em',
                    color: 'var(--ink)',
                    textIndent: '.04em',
                  }}
                >
                  Admin{' '}
                  <span style={{ fontFamily: "'Alfa Slab One', serif", color: 'var(--ink)', textShadow: '2px 2px 0 var(--red), 4px 4px 0 var(--red-deep)', padding: '0 .04em' }}>
                    Overview.
                  </span>
                </h1>
              </Reveal>
              <Reveal delay={160}>
                <p
                  style={{
                    marginTop: 16,
                    fontFamily: "'IM Fell English', serif",
                    fontStyle: 'italic',
                    color: 'var(--ink-soft)',
                    fontSize: 16,
                  }}
                >
                  Internal operations · Cron + Pipeline + Subscribers
                </p>
              </Reveal>
            </div>
            <div className="admin-actions" style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
              <RunIngestButton />
            </div>
          </div>

          <AdminTabs
            tabs={[
              { id: 'data', label: 'Data', content: dataTab },
              { id: 'subscriptions', label: 'Subscriptions', content: subscriptionsTab },
              { id: 'coupons', label: 'Coupons', content: couponsTab },
              {
                id: 'review',
                label: 'Review Queue',
                badge: pendingSuggestions || null,
                content: reviewTab,
              },
              { id: 'stores', label: 'Manage Stores', content: storesTab },
            ]}
          />
        </div>
      </section>

      <footer className="dl-footer">
        <div className="footer-wordmark" aria-label="Deal Dossier">
          DEAL&nbsp;D<span className="o">O</span>SSIER
        </div>
        <div className="footer-meta">
          <a href="/">Public Site</a> · <a href="/privacy">Privacy</a> · <a href="/terms">Terms</a><br /><br />
          An Hours &amp; Co. publication · © 2026
        </div>
      </footer>
    </div>
  )
}
