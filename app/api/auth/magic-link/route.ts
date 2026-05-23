import { NextRequest, NextResponse } from 'next/server'
import { createServiceClient } from '@/lib/supabase/server'
import { Resend } from 'resend'
import { z } from 'zod'

export const dynamic = 'force-dynamic'

function getResend() { return new Resend(process.env.RESEND_API_KEY) }

const Body = z.object({
  email: z.string().email(),
  redirectTo: z.string().url().optional(),
})

const EMAIL_LIMIT_PER_HOUR = 5
const IP_LIMIT_PER_HOUR = 10

function requestIp(req: NextRequest): string | null {
  const forwarded = req.headers.get('x-forwarded-for')?.split(',')[0]?.trim()
  return forwarded || req.headers.get('x-real-ip') || null
}

function safeCallbackUrl(req: NextRequest, redirectTo: string | undefined): string {
  const appUrl = process.env.NEXT_PUBLIC_APP_URL || req.nextUrl.origin
  const fallback = `${appUrl}/api/auth/callback`
  if (!redirectTo) return fallback

  try {
    const target = new URL(redirectTo)
    const allowedOrigins = new Set([req.nextUrl.origin, new URL(appUrl).origin])
    const allowedPaths = new Set(['/auth/callback', '/api/auth/callback'])
    if (!allowedOrigins.has(target.origin)) return fallback
    if (!allowedPaths.has(target.pathname)) return fallback
    return target.toString()
  } catch {
    return fallback
  }
}

async function isRateLimited(
  supabase: ReturnType<typeof createServiceClient>,
  email: string,
  ip: string | null
): Promise<boolean> {
  const since = new Date(Date.now() - 60 * 60 * 1000).toISOString()

  const emailCount = supabase
    .from('magic_link_throttle')
    .select('id', { count: 'exact', head: true })
    .eq('email', email)
    .gte('sent_at', since)

  const ipCount = ip
    ? supabase
        .from('magic_link_throttle')
        .select('id', { count: 'exact', head: true })
        .eq('ip', ip)
        .gte('sent_at', since)
    : Promise.resolve({ count: 0, error: null })

  const [byEmail, byIp] = await Promise.all([emailCount, ipCount])

  if (byEmail.error) {
    console.warn('[magic-link] throttle email lookup failed:', JSON.stringify(byEmail.error))
  }
  if (byIp.error) {
    console.warn('[magic-link] throttle ip lookup failed:', JSON.stringify(byIp.error))
  }

  return (byEmail.count ?? 0) >= EMAIL_LIMIT_PER_HOUR || (byIp.count ?? 0) >= IP_LIMIT_PER_HOUR
}

export async function POST(req: NextRequest) {
  try {
    const parsed = Body.safeParse(await req.json().catch(() => null))
    if (!parsed.success) {
      return NextResponse.json({ error: 'Valid email required' }, { status: 400 })
    }

    const email = parsed.data.email.trim().toLowerCase()
    const ip = requestIp(req)
    const supabase = createServiceClient()

    if (await isRateLimited(supabase, email, ip)) {
      return NextResponse.json({ error: 'Too many requests. Try again later.' }, { status: 429 })
    }

    const callbackUrl = safeCallbackUrl(req, parsed.data.redirectTo)

    // Use Supabase admin API to generate the magic link token
    // This creates the auth session token without sending any email
    const { data, error } = await supabase.auth.admin.generateLink({
      type: 'magiclink',
      email,
      options: { redirectTo: callbackUrl },
    })

    if (error || !data?.properties?.action_link) {
      console.error('generateLink error:', error)
      return NextResponse.json({ error: 'Failed to generate link' }, { status: 500 })
    }

    const magicLink = data.properties.action_link

    // ── Dossier Look palette (literal hex — CSS vars don't work in mail).
    // Display/stamp/body fonts degrade to Georgia / Courier on clients
    // that don't load web fonts (Gmail, Outlook) — the look survives via
    // the cream paper, ink borders, and red accents. ──
    const FONT_DISPLAY = "'Alfa Slab One','Georgia',serif"
    const FONT_STAMP = "'Special Elite','Courier New',monospace"
    const FONT_BODY = "'IM Fell English','Georgia',serif"
    const CREAM = '#ece0c0'   // outer page background
    const PAPER = '#fff8e2'   // card / panel
    const INK = '#181612'
    const RED = '#d4322a'
    const RED_DEEP = '#8f1a14'
    const INK_SOFT = '#4a443a'

    // Send the link ourselves via Resend — no Supabase SMTP needed
    const { error: emailError } = await getResend().emails.send({
      from: process.env.RESEND_FROM_EMAIL || 'Deal Dossier <noreply@dealdossier.io>',
      to: email,
      subject: 'Your Deal Dossier sign-in link',
      html: `<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="x-apple-disable-message-reformatting">
<meta name="color-scheme" content="light">
<meta name="supported-color-schemes" content="light">
<title>Your Deal Dossier sign-in link</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Special+Elite&family=IM+Fell+English:ital@0;1&display=swap" rel="stylesheet">
<!--[if mso]><style>* { font-family: Georgia, serif !important; }</style><![endif]-->
<style>
  body { margin:0; padding:0; background-color:${CREAM}; }
  a { color: inherit; }
  @media only screen and (max-width:600px) {
    .hpad { padding-left: 26px !important; padding-right: 26px !important; }
    .htitle { font-size: 30px !important; }
  }
</style>
</head>
<body style="margin:0;padding:0;background-color:${CREAM};-webkit-font-smoothing:antialiased;">

<table width="100%" cellpadding="0" cellspacing="0" role="presentation" style="background-color:${CREAM};padding:40px 16px 56px;">
<tr><td align="center">

  <!-- Wordmark -->
  <table width="560" cellpadding="0" cellspacing="0" role="presentation" style="max-width:560px;width:100%;">
    <tr><td align="center" style="padding-bottom:22px;">
      <span style="display:inline-block;background-color:${RED};border:2px solid ${INK};padding:9px 18px 7px;font-family:${FONT_DISPLAY};font-size:19px;letter-spacing:.06em;color:${PAPER};">DEAL DOSSIER</span>
    </td></tr>
  </table>

  <!-- Card -->
  <table width="560" cellpadding="0" cellspacing="0" role="presentation" style="max-width:560px;width:100%;background-color:${PAPER};border:3px solid ${INK};">
    <tr>
      <td class="hpad" style="padding:48px 40px 44px;">

        <p style="margin:0 0 16px;font-family:${FONT_STAMP};font-size:12px;letter-spacing:.26em;text-transform:uppercase;color:${RED_DEEP};">— Sign In —</p>

        <h1 class="htitle" style="margin:0 0 20px;font-family:${FONT_DISPLAY};font-weight:400;font-size:38px;line-height:1.08;color:${INK};">Your magic link is ready.</h1>

        <p style="margin:0 0 32px;font-family:${FONT_BODY};font-size:18px;line-height:1.55;color:${INK_SOFT};">
          Tap the button below to sign in to Deal Dossier. The link works once and expires in 24 hours.
        </p>

        <table cellpadding="0" cellspacing="0" role="presentation">
          <tr>
            <td style="background-color:${RED};border:2px solid ${INK};">
              <a href="${magicLink}" style="display:inline-block;font-family:${FONT_DISPLAY};font-size:14px;letter-spacing:.05em;color:${PAPER};text-decoration:none;padding:16px 30px 14px;">SIGN IN TO DEAL DOSSIER&nbsp;→</a>
            </td>
          </tr>
        </table>

        <p style="margin:32px 0 0;font-family:${FONT_BODY};font-style:italic;font-size:15px;line-height:1.55;color:${INK_SOFT};">
          Didn&rsquo;t request this? You can safely ignore this email — someone may have typed your address by mistake.
        </p>

      </td>
    </tr>
  </table>

  <!-- Footer -->
  <table width="560" cellpadding="0" cellspacing="0" role="presentation" style="max-width:560px;width:100%;">
    <tr><td align="center" style="padding:22px 20px 0;font-family:${FONT_STAMP};font-size:11px;letter-spacing:.16em;text-transform:uppercase;color:${INK_SOFT};">
      An Hours &amp; Co. publication · Link expires in 24 hours
    </td></tr>
  </table>

</td></tr>
</table>
</body>
</html>`,
    })

    if (emailError) {
      console.error('Resend send error:', emailError)
      return NextResponse.json({ error: 'Failed to send email' }, { status: 500 })
    }

    await supabase.from('magic_link_throttle').delete().lt(
      'sent_at',
      new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString()
    )
    const { error: throttleErr } = await supabase
      .from('magic_link_throttle')
      .insert({ email, ip })
    if (throttleErr) {
      console.warn('[magic-link] throttle insert failed:', JSON.stringify(throttleErr))
    }

    return NextResponse.json({ success: true })
  } catch (err) {
    console.error('magic-link error:', err)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
