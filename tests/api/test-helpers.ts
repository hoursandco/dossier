import { vi } from 'vitest'

interface QueryResult<T = unknown> {
  data?: T
  error?: unknown
  count?: number | null
}

type QueryQueue = Record<string, QueryResult | QueryResult[]>

export function jsonRequest(path: string, body?: unknown): Request {
  return new Request(`http://localhost${path}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: body === undefined ? undefined : JSON.stringify(body),
  })
}

export function makeAuthClient(user: { email?: string } | null) {
  return {
    auth: {
      getUser: vi.fn(async () => ({ data: { user } })),
    },
  }
}

export function makeQuery<T = unknown>(result: QueryResult<T>) {
  const query: Record<string, unknown> = {}
  const chain = () => query

  for (const method of [
    'select',
    'eq',
    'neq',
    'gte',
    'order',
    'range',
    'limit',
    'contains',
    'ilike',
    'insert',
    'update',
    'delete',
  ]) {
    query[method] = vi.fn(chain)
  }

  query.single = vi.fn(async () => result)
  query.then = (resolve: (value: QueryResult<T>) => unknown, reject: (reason?: unknown) => unknown) =>
    Promise.resolve(result).then(resolve, reject)

  return query as Record<string, ReturnType<typeof vi.fn>> & {
    single: ReturnType<typeof vi.fn>
    then: Promise<QueryResult<T>>['then']
  }
}

export function makeServiceClient(results: QueryQueue) {
  const queries: Record<string, ReturnType<typeof makeQuery>[]> = {}
  const cursors: Record<string, number> = {}

  for (const [table, tableResults] of Object.entries(results)) {
    const queue = Array.isArray(tableResults) ? tableResults : [tableResults]
    queries[table] = queue.map((result) => makeQuery(result))
  }

  return {
    from: vi.fn((table: string) => {
      const queue = queries[table]
      if (!queue?.length) {
        throw new Error(`Unexpected Supabase table query: ${table}`)
      }
      const index = cursors[table] ?? 0
      cursors[table] = index + 1
      if (!queue[index]) {
        throw new Error(`Unexpected extra Supabase query for table: ${table}`)
      }
      return queue[index]
    }),
    queries,
  }
}

export async function mockSupabase(
  user: { email?: string } | null,
  results: QueryQueue = {},
) {
  const authClient = makeAuthClient(user)
  const service = makeServiceClient(results)

  vi.doMock('@/lib/supabase/server', () => ({
    createClient: vi.fn(async () => authClient),
    createServiceClient: vi.fn(() => service),
  }))

  return { authClient, service }
}
