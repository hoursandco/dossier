// Admin gate — supports multiple admins via comma-separated ADMIN_EMAIL.
//
// Set ADMIN_EMAIL in your environment to either a single email
// ("bre999@gmail.com") or a comma-separated list
// ("bre999@gmail.com, matthew.bahrengurg@gmail.com"). Whitespace is
// trimmed and the comparison is case-insensitive.
//
// Usage in route handlers:
//   const { data: { user } } = await supabase.auth.getUser()
//   if (!isAdminEmail(user?.email)) {
//     return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
//   }

export function getAdminEmails(): string[] {
  const raw = process.env.ADMIN_EMAIL
  if (!raw) return []
  return raw
    .split(',')
    .map((s) => s.trim().toLowerCase())
    .filter(Boolean)
}

export function isAdminEmail(email: string | null | undefined): boolean {
  if (process.env.NODE_ENV === 'development') return true
  if (!email) return false
  return getAdminEmails().includes(email.toLowerCase())
}
