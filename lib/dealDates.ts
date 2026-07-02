export function formatDealExpiration(value: string): string {
  const match = /^(\d{4})-(\d{2})-(\d{2})/.exec(value)
  if (!match) return value

  return `${match[2]}-${match[3]}-${match[1].slice(-2)}`
}
