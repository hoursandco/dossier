-- Cropped, short-lived deal thumbnails. We store only the generated
-- product thumbnail, never the full email marketing image.
ALTER TABLE deals
  ADD COLUMN IF NOT EXISTS image_url TEXT,
  ADD COLUMN IF NOT EXISTS image_storage_path TEXT,
  ADD COLUMN IF NOT EXISTS image_source_url TEXT,
  ADD COLUMN IF NOT EXISTS image_alt TEXT,
  ADD COLUMN IF NOT EXISTS image_confidence NUMERIC,
  ADD COLUMN IF NOT EXISTS image_expires_at TIMESTAMPTZ;

CREATE INDEX IF NOT EXISTS deals_image_expires_at_idx
  ON deals(image_expires_at)
  WHERE image_storage_path IS NOT NULL;

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'deal-thumbnails',
  'deal-thumbnails',
  TRUE,
  1048576,
  ARRAY['image/webp']
)
ON CONFLICT (id) DO UPDATE
SET
  public = TRUE,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

CREATE POLICY "deal_thumbnails_public_read"
  ON storage.objects
  FOR SELECT
  USING (bucket_id = 'deal-thumbnails');
