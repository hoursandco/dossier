import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { DEAL_THUMBNAIL_BUCKET } from '@/lib/dealImages'

export const dynamic = 'force-dynamic'

function verifyCronSecret(request: NextRequest): boolean {
  const secret = process.env.CRON_SECRET
  if (!secret) return false
  return request.headers.get('authorization') === `Bearer ${secret}`
}

export async function GET(request: NextRequest) {
  if (!verifyCronSecret(request)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const supabase = createServiceClient()
  const now = new Date().toISOString()
  const { data: expired, error: loadError } = await supabase
    .from('deals')
    .select('id, image_storage_path')
    .not('image_storage_path', 'is', null)
    .lte('image_expires_at', now)
    .limit(1000)

  if (loadError) {
    console.error('[cleanup-deal-images] load error:', JSON.stringify(loadError))
    return NextResponse.json({ error: 'Failed to load expired images' }, { status: 500 })
  }

  const rows = expired ?? []
  const paths = rows
    .map((row) => row.image_storage_path)
    .filter((path): path is string => typeof path === 'string' && path.length > 0)

  if (paths.length > 0) {
    const { error: removeError } = await supabase.storage
      .from(DEAL_THUMBNAIL_BUCKET)
      .remove(paths)
    if (removeError) {
      console.error('[cleanup-deal-images] storage remove error:', JSON.stringify(removeError))
      return NextResponse.json({ error: 'Failed to remove expired images' }, { status: 500 })
    }
  }

  const ids = rows.map((row) => row.id).filter(Boolean)
  if (ids.length > 0) {
    const { error: updateError } = await supabase
      .from('deals')
      .update({
        image_url: null,
        image_storage_path: null,
        image_source_url: null,
        image_alt: null,
        image_confidence: null,
        image_expires_at: null,
      })
      .in('id', ids)
    if (updateError) {
      console.error('[cleanup-deal-images] deal update error:', JSON.stringify(updateError))
      return NextResponse.json({ error: 'Failed to clear expired image fields' }, { status: 500 })
    }
  }

  return NextResponse.json({ scanned: rows.length, deleted: paths.length, cleared: ids.length })
}
