import type { SupabaseClient } from '@supabase/supabase-js'
import type { DealThumbnailCropSelection } from '@/lib/openai'

export const DEAL_THUMBNAIL_BUCKET = 'deal-thumbnails'
export const DEAL_THUMBNAIL_TTL_DAYS = 7

export interface StoredDealThumbnail {
  image_url: string
  image_storage_path: string
  image_source_url: string
  image_alt: string
  image_confidence: number
  image_expires_at: string
}

function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value))
}

function safePathPart(value: string): string {
  return value.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '').slice(0, 60) || 'deal'
}

async function fetchImage(url: string): Promise<{ bytes: ArrayBuffer; contentType: string | null } | null> {
  try {
    const res = await fetch(url, {
      headers: { 'User-Agent': 'Mozilla/5.0 (compatible; DealDossierBot/1.0)' },
      signal: AbortSignal.timeout(8000),
    })
    if (!res.ok) return null
    const contentType = res.headers.get('content-type')
    if (contentType && !contentType.toLowerCase().startsWith('image/')) return null
    const contentLength = Number(res.headers.get('content-length') ?? 0)
    if (contentLength > 8 * 1024 * 1024) return null
    const bytes = await res.arrayBuffer()
    if (bytes.byteLength === 0 || bytes.byteLength > 8 * 1024 * 1024) return null
    return { bytes, contentType }
  } catch (err) {
    console.warn('[deal-images] source fetch failed:', err)
    return null
  }
}

function normalizedCropToPixels(
  crop: DealThumbnailCropSelection['crop'],
  width: number,
  height: number,
): { left: number; top: number; width: number; height: number } {
  const x = clamp(crop.x, 0, 0.98)
  const y = clamp(crop.y, 0, 0.98)
  const w = clamp(crop.width, 0.05, 1 - x)
  const h = clamp(crop.height, 0.05, 1 - y)

  const left = Math.floor(x * width)
  const top = Math.floor(y * height)
  const cropWidth = Math.max(1, Math.floor(w * width))
  const cropHeight = Math.max(1, Math.floor(h * height))
  return {
    left,
    top,
    width: Math.min(cropWidth, width - left),
    height: Math.min(cropHeight, height - top),
  }
}

export async function createDealThumbnail(
  supabase: SupabaseClient,
  input: {
    dealId: string
    retailer: string
    description: string
    selection: DealThumbnailCropSelection
  },
): Promise<StoredDealThumbnail | null> {
  if (!input.selection.accepted) return null

  const source = await fetchImage(input.selection.image_url)
  if (!source) return null

  try {
    const sharp = (await import('sharp')).default
    const image = sharp(Buffer.from(source.bytes), { animated: false }).rotate()
    const metadata = await image.metadata()
    if (!metadata.width || !metadata.height) return null

    const crop = normalizedCropToPixels(input.selection.crop, metadata.width, metadata.height)
    const webp = await image
      .extract(crop)
      .resize(420, 420, { fit: 'cover', position: 'attention' })
      .webp({ quality: 78 })
      .toBuffer()

    const expiresAt = new Date(Date.now() + DEAL_THUMBNAIL_TTL_DAYS * 24 * 60 * 60 * 1000).toISOString()
    const path = `${new Date().toISOString().slice(0, 10)}/${safePathPart(input.retailer)}/${input.dealId}.webp`

    const { error: uploadError } = await supabase.storage
      .from(DEAL_THUMBNAIL_BUCKET)
      .upload(path, webp, {
        contentType: 'image/webp',
        cacheControl: '86400',
        upsert: true,
      })
    if (uploadError) {
      console.error('[deal-images] upload error:', JSON.stringify(uploadError))
      return null
    }

    const { data } = supabase.storage.from(DEAL_THUMBNAIL_BUCKET).getPublicUrl(path)
    return {
      image_url: data.publicUrl,
      image_storage_path: path,
      image_source_url: input.selection.image_url,
      image_alt: input.selection.alt_text || `${input.retailer} product image`,
      image_confidence: input.selection.confidence,
      image_expires_at: expiresAt,
    }
  } catch (err) {
    console.error('[deal-images] thumbnail creation failed:', err)
    return null
  }
}
