import { afterEach, describe, expect, it, vi } from 'vitest'
import {
  compareExtractionOutputs,
  createNormalizedExtractionOutput,
  getExtractorProviderConfig,
  getGeminiConfig,
  getOpenRouterConfig,
  getPrimaryExtractionModel,
  PRIMARY_EXTRACTION_PROVIDER,
  shouldEnqueueOpenRouterShadow,
  type ExtractedDeal,
} from '@/lib/openai'

afterEach(() => {
  vi.unstubAllEnvs()
  vi.resetModules()
  vi.clearAllMocks()
})

function deal(overrides: Partial<ExtractedDeal> = {}): ExtractedDeal {
  return {
    retailer: 'Gap',
    description: '40% off jeans.',
    percent_off: 40,
    deal_type: 'percent-off',
    promo_code: 'SAVE40',
    expiration_date: null,
    link: null,
    categories: ['womens-clothes', 'womens-clothes'],
    deal_subtype: null,
    keywords: ['Jeans', 'denim'],
    redemption_channel: 'online',
    ...overrides,
  }
}

describe('extractor provider config', () => {
  it('uses OpenRouter as the production extraction provider', () => {
    vi.stubEnv('OPENROUTER_MODEL', 'openai/gpt-4o-mini')

    expect(PRIMARY_EXTRACTION_PROVIDER).toBe('openrouter')
    expect(getPrimaryExtractionModel()).toBe('openai/gpt-4o-mini')
  })

  it('selects Gemini and OpenRouter provider configs', () => {
    vi.stubEnv('OPENROUTER_MODEL', 'anthropic/claude-3.5-sonnet')

    expect(getExtractorProviderConfig('gemini')).toMatchObject({
      name: 'gemini',
      baseURL: 'https://generativelanguage.googleapis.com/v1beta/openai',
      model: 'gemini-2.5-flash-lite',
    })
    expect(getExtractorProviderConfig('openrouter')).toMatchObject({
      name: 'openrouter',
      baseURL: 'https://openrouter.ai/api/v1',
      model: 'anthropic/claude-3.5-sonnet',
    })
  })

  it('constructs strict OpenRouter json_schema response format', () => {
    const schema = { type: 'object', additionalProperties: false }

    expect(getOpenRouterConfig().responseFormat('deal_extraction', schema)).toEqual({
      type: 'json_schema',
      json_schema: {
        name: 'deal_extraction',
        strict: true,
        schema,
      },
    })
  })

  it('requires OpenRouter routes that support requested parameters', () => {
    expect(getOpenRouterConfig().providerRouting).toEqual({
      require_parameters: true,
    })
  })

  it('keeps Gemini on JSON object response format', () => {
    expect(getGeminiConfig().responseFormat('deal_extraction', {})).toEqual({
      type: 'json_object',
    })
  })

  it('does not enqueue OpenRouter shadow jobs while OpenRouter is production', () => {
    vi.stubEnv('OPENROUTER_API_KEY', 'test-key')
    vi.stubEnv('OPENROUTER_SHADOW_ENABLED', 'true')
    vi.stubEnv('OPENROUTER_SHADOW_DAILY_LIMIT', '20')
    vi.stubEnv('OPENROUTER_SHADOW_SAMPLE_RATE', '1')

    expect(shouldEnqueueOpenRouterShadow()).toBe(false)
  })
})

describe('output normalization and comparison', () => {
  it('normalizes output using one shared deal schema', () => {
    const output = createNormalizedExtractionOutput({
      provider: 'gemini',
      model: 'gemini-2.5-flash-lite',
      method: 'text',
      deals: [deal({ promo_code: ' save40 ', categories: ['Shoes', 'shoes'], keywords: ['Boots', 'boots'] })],
    })

    expect(output).toMatchObject({
      provider: 'gemini',
      prompt_version: 'deal-extraction-v2',
      schema_valid: true,
      deals: [
        expect.objectContaining({
          promo_code: 'SAVE40',
          categories: ['shoes'],
          keywords: ['boots'],
          redemption_channel: 'online',
        }),
      ],
    })
  })

  it('keeps acceptable wording differences isolated to description review', () => {
    const production = createNormalizedExtractionOutput({
      provider: 'gemini',
      model: 'gemini',
      method: 'text',
      deals: [deal({ description: '40% off jeans.' })],
    })
    const shadow = createNormalizedExtractionOutput({
      provider: 'openrouter',
      model: 'openrouter',
      method: 'text',
      deals: [deal({ description: 'Take 40% off denim.' })],
    })

    const comparison = compareExtractionOutputs(production, shadow)

    expect(comparison.status).toBe('needs_review')
    expect(comparison.deal_count_match).toBe(true)
    expect(comparison.retailer_agreement).toBe(true)
    expect(comparison.deal_type_agreement).toBe(true)
    expect(comparison.percent_agreement).toBe(true)
    expect(comparison.promo_code_agreement).toBe(true)
    expect(comparison.category_agreement).toBe(true)
    expect(comparison.description_differences).toHaveLength(1)
  })

  it('flags hard mismatches across structured fields', () => {
    const production = createNormalizedExtractionOutput({
      provider: 'gemini',
      model: 'gemini',
      method: 'text',
      deals: [deal()],
    })
    const shadow = createNormalizedExtractionOutput({
      provider: 'openrouter',
      model: 'openrouter',
      method: 'text',
      deals: [deal({ retailer: 'Old Navy', deal_type: 'flash-sale', percent_off: null, promo_code: null, categories: ['shoes'] })],
    })

    const comparison = compareExtractionOutputs(production, shadow)

    expect(comparison.status).toBe('needs_review')
    expect(comparison.retailer_agreement).toBe(false)
    expect(comparison.deal_type_agreement).toBe(false)
    expect(comparison.percent_agreement).toBe(false)
    expect(comparison.promo_code_agreement).toBe(false)
    expect(comparison.category_agreement).toBe(false)
  })
})

describe('strict schema handling', () => {
  it('throws for invalid production JSON so ingest can retry the email', async () => {
    const create = vi.fn(async () => ({
      choices: [{ message: { content: '{ bad json' } }],
    }))
    vi.doMock('openai', () => ({
      default: vi.fn(function OpenAI() {
        return { chat: { completions: { create } } }
      }),
    }))
    vi.resetModules()
    const { extractDealsFromEmail, ApiSchemaValidationError: SchemaError } = await import('@/lib/openai')

    await expect(
      extractDealsFromEmail('Gap <sale@gap.com>', 'Sale', 'Save on jeans.', []),
    ).rejects.toBeInstanceOf(SchemaError)
  })

  it('marks OpenRouter output schema invalid when required keys are missing', async () => {
    const create = vi.fn(async () => ({
      choices: [{ message: { content: JSON.stringify({ deals: [{ retailer: 'Gap' }] }) } }],
    }))
    vi.doMock('openai', () => ({
      default: vi.fn(function OpenAI() {
        return { chat: { completions: { create } } }
      }),
    }))
    vi.resetModules()
    const { processOpenRouterExtractionSnapshot: processSnapshot } = await import('@/lib/openai')

    const output = await processSnapshot({
      from: 'Gap <sale@gap.com>',
      subject: 'Sale',
      cleanedBody: 'Save today on jeans and denim.',
      imageUrls: [],
    })

    expect(output.schema_valid).toBe(false)
    expect(output.deals).toEqual([])
  })
})
