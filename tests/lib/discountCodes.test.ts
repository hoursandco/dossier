import { describe, expect, it, vi } from 'vitest'
import { validateDiscountCode, type DiscountCodeRow } from '@/lib/discountCodes'

function makeRow(overrides: Partial<DiscountCodeRow> = {}): DiscountCodeRow {
  return {
    id: 'code_1',
    code: 'SAVE20',
    plan_types: ['monthly'],
    percent_off: 20,
    duration_months: 2,
    expires_at: '2999-01-01',
    requires_credit_card: true,
    active: true,
    max_redemptions: null,
    ...overrides,
  }
}

function makeService(row: DiscountCodeRow | null, redemptionCount = 0) {
  return {
    from: vi.fn((table: string) => {
      if (table === 'discount_codes') {
        return {
          select: vi.fn().mockReturnThis(),
          ilike: vi.fn().mockReturnThis(),
          maybeSingle: vi.fn(async () => ({ data: row, error: null })),
        }
      }
      if (table === 'subscribers') {
        const result = { data: null, error: null, count: redemptionCount }
        return {
          select: vi.fn().mockReturnThis(),
          ilike: vi.fn().mockReturnThis(),
          then: (resolve: (value: typeof result) => unknown) => Promise.resolve(resolve(result)),
        }
      }
      throw new Error(`Unexpected table ${table}`)
    }),
  }
}

describe('validateDiscountCode', () => {
  it('validates a partial discount and requires a card even if the row says otherwise', async () => {
    const service = makeService(makeRow({ requires_credit_card: false }))

    const result = await validateDiscountCode(service as never, ' save20 ', 'monthly')

    expect(result.valid).toBe(true)
    if (!result.valid) throw new Error(result.message)
    expect(result.percent_off).toBe(20)
    expect(result.requires_credit_card).toBe(true)
    expect(result.list_price_cents).toBe(499)
    expect(result.discounted_amount_cents).toBe(399)
  })

  it('treats 100 percent off as a no-card comp', async () => {
    const service = makeService(makeRow({
      code: 'FREE',
      percent_off: 100,
      duration_months: 1,
      requires_credit_card: true,
    }))

    const result = await validateDiscountCode(service as never, 'free', 'monthly')

    expect(result.valid).toBe(true)
    if (!result.valid) throw new Error(result.message)
    expect(result.requires_credit_card).toBe(false)
    expect(result.discounted_amount_cents).toBe(0)
    expect(result.message).toContain('no credit card required')
  })

  it('rejects expired codes', async () => {
    const service = makeService(makeRow({ expires_at: '2000-01-01' }))

    const result = await validateDiscountCode(service as never, 'SAVE20', 'monthly')

    expect(result).toEqual({ valid: false, message: 'That code has expired.' })
  })

  it('rejects codes that reached their redemption limit', async () => {
    const service = makeService(makeRow({ max_redemptions: 3 }), 3)

    const result = await validateDiscountCode(service as never, 'SAVE20', 'monthly')

    expect(result).toEqual({
      valid: false,
      message: 'That code has reached its redemption limit.',
    })
  })
})
