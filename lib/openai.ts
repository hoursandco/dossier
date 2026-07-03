import OpenAI from 'openai'
import type { ResponseFormatJSONObject, ResponseFormatJSONSchema } from 'openai/resources/shared'
import { z } from 'zod'
import type { Category } from '@/types'
import { overrideCategoriesForRetailer } from '@/lib/deals'

type JsonSchema = Record<string, unknown>

export const EXTRACTION_PROMPT_VERSION = 'deal-extraction-v2'
export const PRIMARY_EXTRACTION_PROVIDER = 'openrouter'
export const SHADOW_EXTRACTION_PROVIDER = 'openrouter'

export class ApiCreditExhaustedError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'ApiCreditExhaustedError'
  }
}

export class ApiRateLimitError extends Error {
  readonly retryAfterMs: number
  constructor(message: string, retryAfterMs = 60_000) {
    super(message)
    this.name = 'ApiRateLimitError'
    this.retryAfterMs = retryAfterMs
  }
}

export class ApiSchemaValidationError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'ApiSchemaValidationError'
  }
}

const DealSchema = z.object({
  retailer: z.string(),
  description: z.string(),
  percent_off: z.number().nullable(),
  deal_type: z.enum([
    'percent-off', 'bogo-free', 'bogo-half', 'free-item',
    'free-shipping', 'flash-sale', 'stackable', 'loyalty', 'up-to',
    'price-point'
  ]),
  promo_code: z.string().nullable(),
  expiration_date: z.string().nullable(),
  link: z.string().nullable(),
  categories: z.array(z.string()),
  deal_subtype: z.string().nullable(),
  keywords: z.array(z.string()),
  redemption_channel: z.enum(['online', 'in-store', 'online-and-in-store']),
}).strict()

const ExtractionSchema = z.object({
  deals: z.array(DealSchema),
}).strict()

const extractionJsonSchema: JsonSchema = {
  type: 'object',
  additionalProperties: false,
  required: ['deals'],
  properties: {
    deals: {
      type: 'array',
      items: {
        type: 'object',
        additionalProperties: false,
        required: [
          'retailer',
          'description',
          'percent_off',
          'deal_type',
          'promo_code',
          'expiration_date',
          'link',
          'categories',
          'deal_subtype',
          'keywords',
          'redemption_channel',
        ],
        properties: {
          retailer: { type: 'string' },
          description: { type: 'string' },
          percent_off: { type: ['number', 'null'] },
          deal_type: {
            type: 'string',
            enum: [
              'percent-off',
              'bogo-free',
              'bogo-half',
              'free-item',
              'free-shipping',
              'flash-sale',
              'stackable',
              'loyalty',
              'up-to',
              'price-point',
            ],
          },
          promo_code: { type: ['string', 'null'] },
          expiration_date: { type: ['string', 'null'] },
          link: { type: ['string', 'null'] },
          categories: {
            type: 'array',
            items: { type: 'string' },
          },
          deal_subtype: { type: ['string', 'null'] },
          keywords: {
            type: 'array',
            items: { type: 'string' },
          },
          redemption_channel: {
            type: 'string',
            enum: ['online', 'in-store', 'online-and-in-store'],
          },
        },
      },
    },
  },
}

export type ExtractedDeal = z.infer<typeof DealSchema>
type UserContent =
  | string
  | Array<
      | { type: 'text'; text: string }
      | { type: 'image_url'; image_url: { url: string } }
    >

export interface CategoryRow {
  slug: string
  label: string
}

export interface ExtractionSnapshot {
  from: string
  subject: string
  cleanedBody: string
  imageUrls: string[]
}

export interface QueuedExtractionResult {
  provider: string
  model: string
  prompt_version: typeof EXTRACTION_PROMPT_VERSION
  method: 'text' | 'vision'
  schema_valid: boolean
  deals: NormalizedDeal[]
}

export interface NormalizedDeal {
  retailer: string
  description: string
  percent_off: number | null
  deal_type: string
  promo_code: string | null
  expiration_date: string | null
  link: string | null
  categories: string[]
  deal_subtype: string | null
  keywords: string[]
  redemption_channel: string
}

export interface ExtractionComparisonResult {
  status: 'match' | 'needs_review' | 'schema_failed' | 'provider_failed'
  production_schema_valid: boolean
  shadow_schema_valid: boolean
  deal_count_match: boolean
  retailer_agreement: boolean
  deal_type_agreement: boolean
  percent_agreement: boolean
  promo_code_agreement: boolean
  category_agreement: boolean
  description_differences: Array<{
    index: number
    production: string | null
    shadow: string | null
  }>
  details: Record<string, unknown>
}

interface ParsedExtractionResult {
  schemaValid: boolean
  deals: ExtractedDeal[]
}

const extractionSchemaValidity = new WeakMap<ExtractedDeal[], boolean>()

interface ExtractorRequest {
  systemPrompt: string
  userContent: UserContent
  schemaName: string
  schema: JsonSchema
}

interface ExtractorProviderConfig {
  name: 'gemini' | 'openrouter'
  model: string
  apiKey: string
  baseURL: string
  responseFormat: (name: string, schema: JsonSchema) => ResponseFormatJSONObject | ResponseFormatJSONSchema
  providerRouting?: {
    require_parameters: boolean
  }
}

interface ExtractorProvider {
  readonly name: ExtractorProviderConfig['name']
  complete(request: ExtractorRequest): Promise<string | null>
}

class ChatCompletionExtractorProvider implements ExtractorProvider {
  readonly name: ExtractorProviderConfig['name']
  private readonly client: OpenAI

  constructor(private readonly config: ExtractorProviderConfig) {
    this.name = config.name
    this.client = new OpenAI({
      apiKey: config.apiKey || 'placeholder',
      baseURL: config.baseURL,
    })
  }

  async complete(request: ExtractorRequest): Promise<string | null> {
    const response = await this.client.chat.completions.create({
      model: this.config.model,
      messages: [
        { role: 'system', content: request.systemPrompt },
        { role: 'user', content: request.userContent },
      ],
      response_format: this.config.responseFormat(request.schemaName, request.schema),
      temperature: 0,
      ...(this.config.providerRouting
        ? { provider: this.config.providerRouting }
        : {}),
    } as Parameters<typeof this.client.chat.completions.create>[0] & {
      provider?: ExtractorProviderConfig['providerRouting']
    })

    if ('choices' in response) {
      return response.choices[0]?.message?.content ?? null
    }

    return null
  }
}

export function getGeminiConfig(): ExtractorProviderConfig {
  return {
    name: 'gemini',
    apiKey: process.env.GEMINI_API_KEY || '',
    // Gemini exposes an OpenAI-compatible endpoint. The OpenAI SDK appends
    // "/chat/completions", so this base URL intentionally has no trailing slash.
    baseURL: 'https://generativelanguage.googleapis.com/v1beta/openai',
    model: 'gemini-2.5-flash-lite',
    responseFormat: () => ({ type: 'json_object' }),
  }
}

export function getOpenRouterConfig(): ExtractorProviderConfig {
  return {
    name: 'openrouter',
    apiKey: process.env.OPENROUTER_API_KEY || '',
    baseURL: 'https://openrouter.ai/api/v1',
    model: process.env.OPENROUTER_MODEL || 'google/gemini-2.5-flash-lite',
    responseFormat: (name, schema) => ({
      type: 'json_schema',
      json_schema: {
        name,
        strict: true,
        schema,
      },
    }),
    providerRouting: { require_parameters: true },
  }
}

function createExtractorProvider(config: ExtractorProviderConfig): ExtractorProvider {
  return new ChatCompletionExtractorProvider(config)
}

function getPrimaryExtractorProvider(): ExtractorProvider {
  return createExtractorProvider(getOpenRouterConfig())
}

export function getExtractorProviderConfig(provider: 'gemini' | 'openrouter'): ExtractorProviderConfig {
  return provider === 'openrouter' ? getOpenRouterConfig() : getGeminiConfig()
}

export function getPrimaryExtractionModel(): string {
  return getOpenRouterConfig().model
}

export function getOpenRouterExtractionModel(): string {
  return getOpenRouterConfig().model
}

function buildSystemPrompt(newCategories: CategoryRow[]): string {
  const newList = newCategories
    .map((c) => `${c.slug} (${c.label})`)
    .join(', ')

  return `You are a deal extraction specialist for an editorial newsletter called Deal Dossier.

Prompt version: ${EXTRACTION_PROMPT_VERSION}

Extract ALL deals and promotions from retail/promotional emails. Be inclusive — if there is any offer, discount, sale, code, or promotion, extract it.

For each deal:
1. RETAILER: The store/brand name (clean, no domain)
2. DESCRIPTION: Clear, factual description of the deal (1–2 sentences, no hype)
3. PERCENT_OFF: The discount percentage as a number (null if not a percentage deal)
4. DEAL_TYPE: One of: percent-off, bogo-free, bogo-half, free-item, free-shipping, flash-sale, stackable, loyalty, up-to, price-point
5. PROMO_CODE: The promotional code if present (null if none)
6. EXPIRATION_DATE: The expiration date in YYYY-MM-DD format (null if unknown)
7. LINK: The direct URL to the deal (null if not found)
8. CATEGORIES: Array of 0-2 category slugs from this list ONLY: ${newList}

   STRICT TAGGING RULES — read carefully, this is where most extraction errors happen:

   a) Tag what THE DEAL IS ABOUT, not what the retailer broadly sells.
      WRONG: Tagging a Macy's "20% off site-wide" email with ["jewelry","shoes","handbags","beauty"] because Macy's sells all those.
      RIGHT: Site-wide sales with no specific category mentioned get [] (empty array).

   b) Pick the MOST SPECIFIC SINGLE category that fits.
      WRONG: A Reebok email about running shoes tagged ["shoes","athleisure"] because Reebok is athleisure-adjacent.
      RIGHT: Just ["shoes"]. Shoes are NEVER athleisure even when sold by athleisure brands.

   c) ONE category is the default. Use TWO only when the email
      genuinely covers two distinct categories (e.g., "20% off
      handbags AND watches"). Never three.

   d) Athleisure means leggings / sports bras / joggers / hoodies —
      stretchy daily-wear apparel. Athleisure does NOT include:
      shoes (use "shoes"), accessories, or random apparel from a
      department store. If you're not sure, don't tag athleisure.

   e) A "general department-store sale" without a category focus
      (e.g., "30% off everything at Marshalls") is []. The "flash-
      sale" deal_type captures it; no category guess needed.

   f) If the email focuses on one specific product (e.g., a vacuum,
      a sofa, a perfume), tag the matching slug — NOT a random
      slug from elsewhere in the email's clutter.

   g) Furniture deals use the slug "furniture" for sofas, couches,
      sectionals, chairs, dining tables,
      desks, dressers, bed frames, nightstands, bookshelves, cabinets,
      patio furniture, and similar home furniture. Do not use
      "home-decor" for actual furniture.
9. DEAL_SUBTYPE: A single short fine-grained product type if the email is specifically about it (e.g. "jeans", "sneakers", "lipstick", "coffee maker", "yoga pants"). null for generic / site-wide / multi-product sales.
10. KEYWORDS: Array of 5–15 specific product terms a shopper might type when searching for this deal. Focus on the actual items on sale, not the discount mechanics. Be specific and varied — include synonyms and common names. Examples: a furniture email → ["couch","sofa","sectional","dining table","bookshelf","nightstand"]; a shoe sale → ["sneakers","boots","heels","sandals","running shoes"]; a skincare email → ["moisturizer","sunscreen","serum","face cream","SPF"]. For a generic site-wide sale with no specific products mentioned, use [].
11. REDEMPTION_CHANNEL: Where a shopper can get the deal. Use "online" for online, app, website, or shipped offers; "in-store" for store-only, retail-location-only, pickup-only, or local circular offers; "online-and-in-store" only when the email explicitly says both online and in stores. If unclear, use "online".

RULES:
- Return JSON that exactly matches the requested schema. The top-level object must have only "deals".
- Every deal object must include exactly these keys: retailer, description, percent_off, deal_type, promo_code, expiration_date, link, categories, deal_subtype, keywords, redemption_channel.
- Do not include extra keys. Do not omit keys.
- Use null for unknown scalar fields that do not apply: percent_off, promo_code, expiration_date, link, deal_subtype.
- Use [] for empty arrays. categories and keywords must always be arrays.
- Extract any sale, discount, promo code, or special offer — even if the percentage is not stated
- "Up to X% off" deals use deal_type "up-to" not "percent-off"
- "Sale" or "event" with no stated percentage: use deal_type "flash-sale" and percent_off null
- A promoted product price with no comparison price or stated savings uses deal_type "price-point" and percent_off null. Examples: "denim shorts starting at $12.99", "steak on sale for $8.99", "$1.98 spinach", or a furniture item advertised at a specific price. Preserve the product, package/size, and advertised price in the description.
- For "up-to" and "flash-sale" deals where the email body lists specific brands, products, or categories on sale, include ALL of them in the description as a comma-separated list. Format: "Up to 55% off KitchenAid, Dyson, Instant Pot, Shark, Ninja and more as part of Deals of the Day." Do not truncate with "and more" unless you have genuinely listed every brand mentioned. If no specific items are named, keep the description general.
- For BOGO deals, use bogo-free or bogo-half accordingly
- Free shipping promotions count as deals (deal_type "free-shipping")
- If a retailer has multiple distinct deals, create separate entries for each
- Promo codes should be exact as shown (uppercase)
- Dates should account for the current year if not specified
- If the email is purely transactional (order confirmation, shipping notice) with no promotion, return empty array

DO NOT EXTRACT:
- Welcome offers, new customer offers, or first-order discounts (these are single-use and won't work for most readers)
- Birthday offers or anniversary offers (these are personalized and single-use)
- Return policies, exchange policies, or free returns/exchanges (these are store policies, not deals)
- Loyalty point notices, reward balance updates, or points-earning promotions of any kind — this includes "earn double points," "earn triple points," "bonus points events," or anything where the benefit is rewards points rather than a direct discount on price
- Referral programs or "give $X, get $X" referral offers
- Credit card member exclusives or store card promotions (earn points, special financing, etc.)
- Ordinary non-promotional catalog prices with no merchandising or offer context. However, promoted prices in sale emails, grocery circulars, product spotlights, or price-led collections SHOULD be extracted as "price-point" offers even when no before-price is shown.
- "Earn $X store cash / store credit with a $Y purchase" — these are deferred-value promotions with redemption windows and spending requirements, not direct discounts (e.g. "Earn $25 LOFT Cash with a $75 purchase")
- Games, sweepstakes, contests, or play-to-win promotions — anything where the user has to play a game, score points, enter a drawing, scratch a card, or take some kind of action beyond purchasing to qualify for a prize. Examples we never want: "Play the HOME AWAY game and score enough points to win a surprise gift," "Spin the wheel for a chance at savings," "Enter to win," "Scratch & win." These are entertainment + sweepstakes mechanics, not deals.

Return ONLY this exact JSON structure:
{
  "deals": [
    {
      "retailer": "Store Name",
      "description": "Brief description of the deal",
      "percent_off": 40,
      "deal_type": "percent-off",
      "promo_code": "CODE123",
      "expiration_date": "2024-12-31",
      "link": "https://example.com",
      "categories": ["womens-clothes"],
      "deal_subtype": "jeans",
      "keywords": ["jeans", "denim", "skinny jeans", "straight leg jeans"],
      "redemption_channel": "online"
    }
  ]
}
Use null for nullable scalar fields that do not apply. Use [] for empty arrays. percent_off must be a number or null.`
}

function isCreditsExhausted(err: unknown): boolean {
  if (!(err instanceof Error) || !('status' in err)) return false
  const status = (err as { status?: number }).status
  if (status === 402) return true
  if (status === 429) {
    const msg = err.message.toLowerCase()
    return msg.includes('quota') || msg.includes('resource_exhausted') ||
           msg.includes('billing') || msg.includes('credit')
  }
  return false
}

function parsePositiveInteger(value: string | undefined, fallback: number): number {
  if (!value) return fallback
  const parsed = Number(value)
  return Number.isFinite(parsed) && parsed > 0 ? Math.floor(parsed) : fallback
}

function parseSampleRate(value: string | undefined): number {
  if (!value) return 0
  const parsed = Number(value)
  if (!Number.isFinite(parsed)) return 0
  return Math.max(0, Math.min(1, parsed))
}

function envFlagEnabled(value: string | undefined): boolean {
  return ['1', 'true', 'yes', 'on'].includes((value ?? '').toLowerCase())
}

let openRouterShadowDay = ''
let openRouterShadowCount = 0

export function shouldEnqueueOpenRouterShadow(): boolean {
  if (PRIMARY_EXTRACTION_PROVIDER === SHADOW_EXTRACTION_PROVIDER) return false
  if (!envFlagEnabled(process.env.OPENROUTER_SHADOW_ENABLED)) return false
  if (!process.env.OPENROUTER_API_KEY) return false

  const today = new Date().toISOString().slice(0, 10)
  if (openRouterShadowDay !== today) {
    openRouterShadowDay = today
    openRouterShadowCount = 0
  }

  const dailyLimit = parsePositiveInteger(process.env.OPENROUTER_SHADOW_DAILY_LIMIT, 0)
  if (dailyLimit <= 0 || openRouterShadowCount >= dailyLimit) return false

  const sampleRate = parseSampleRate(process.env.OPENROUTER_SHADOW_SAMPLE_RATE)
  if (sampleRate <= 0 || Math.random() > sampleRate) return false

  openRouterShadowCount += 1
  return true
}

async function callExtractorWithRetry(
  provider: ExtractorProvider,
  request: ExtractorRequest,
): Promise<string | null> {
  for (let attempt = 0; attempt < 3; attempt++) {
    try {
      return await provider.complete(request)
    } catch (err) {
      if (isCreditsExhausted(err)) {
        throw new ApiCreditExhaustedError(
          err instanceof Error ? err.message : String(err)
        )
      }
      const isRateLimit =
        err instanceof Error &&
        'status' in err &&
        (err as { status?: number }).status === 429
      if (!isRateLimit) throw err
      if (attempt === 2) {
        // All retries exhausted — surface as a typed error so callers can
        // pause the worker pool rather than silently swallowing the failure.
        const retryAfterSec = err instanceof Error && 'headers' in err
          ? Number((err as { headers?: { get?: (k: string) => string | null } }).headers?.get?.('retry-after') ?? NaN)
          : NaN
        const retryAfterMs = Number.isFinite(retryAfterSec) && retryAfterSec > 0
          ? retryAfterSec * 1000
          : 60_000
        throw new ApiRateLimitError(err.message, retryAfterMs)
      }
      const waitMs = 1000 * Math.pow(2, attempt) + Math.random() * 250
      console.warn(`[${provider.name}] 429 rate limit, retry ${attempt + 1}/3 in ${Math.round(waitMs)}ms`)
      await new Promise((r) => setTimeout(r, waitMs))
    }
  }
  return null
}

async function callExtractor(request: ExtractorRequest): Promise<string | null> {
  return callExtractorWithRetry(getPrimaryExtractorProvider(), request)
}

function parseExtractionResult(content: string, logPrefix: string): ParsedExtractionResult {
  let parsed: unknown
  try {
    parsed = JSON.parse(content)
  } catch (err) {
    console.error(`${logPrefix} JSON parse failed:`, err)
    const deals: ExtractedDeal[] = []
    extractionSchemaValidity.set(deals, false)
    return { schemaValid: false, deals }
  }

  console.log(`${logPrefix} raw response:`, JSON.stringify(parsed).slice(0, 500))

  const validated = ExtractionSchema.safeParse(parsed)
  if (!validated.success) {
    console.error(`${logPrefix} Zod validation failed:`, JSON.stringify(validated.error.issues))
    const deals: ExtractedDeal[] = []
    extractionSchemaValidity.set(deals, false)
    return { schemaValid: false, deals }
  }

  // Apply pattern-based category overrides (e.g. eyewear → accessories,
  // not fashion). Source of truth for category routing lives in lib/deals.
  const deals = validated.data.deals.map((d) => ({
    ...d,
    categories: overrideCategoriesForRetailer(d.retailer, d.categories as Category[]),
  }))
  extractionSchemaValidity.set(deals, true)
  return { schemaValid: true, deals }
}

function parseProductionExtractionResponse(content: string, logPrefix: string): ExtractedDeal[] {
  const result = parseExtractionResult(content, logPrefix)
  if (!result.schemaValid) {
    throw new ApiSchemaValidationError(`${logPrefix} returned invalid extraction JSON`)
  }
  return result.deals
}

export function getExtractionSchemaValidity(deals: ExtractedDeal[]): boolean {
  return extractionSchemaValidity.get(deals) ?? true
}

function normalizeText(value: string | null | undefined): string {
  return (value ?? '').trim().replace(/\s+/g, ' ')
}

function normalizeOptionalText(value: string | null | undefined): string | null {
  const normalized = normalizeText(value)
  return normalized.length > 0 ? normalized : null
}

function normalizeForCompare(value: string | null | undefined): string {
  return normalizeText(value).toLowerCase()
}

function normalizeList(values: string[] | null | undefined): string[] {
  return Array.from(
    new Set(
      (values ?? [])
        .map((value) => normalizeText(value).toLowerCase())
        .filter(Boolean)
    )
  ).sort()
}

export function normalizeExtractedDeal(deal: ExtractedDeal): NormalizedDeal {
  return {
    retailer: normalizeText(deal.retailer),
    description: normalizeText(deal.description),
    percent_off: typeof deal.percent_off === 'number' ? deal.percent_off : null,
    deal_type: normalizeText(deal.deal_type || 'flash-sale'),
    promo_code: normalizeOptionalText(deal.promo_code)?.toUpperCase() ?? null,
    expiration_date: normalizeOptionalText(deal.expiration_date),
    link: normalizeOptionalText(deal.link),
    categories: normalizeList(deal.categories),
    deal_subtype: normalizeOptionalText(deal.deal_subtype),
    keywords: normalizeList(deal.keywords),
    redemption_channel: normalizeText(deal.redemption_channel || 'online'),
  }
}

export function createNormalizedExtractionOutput(input: {
  provider: string
  model: string
  method: 'text' | 'vision'
  deals: ExtractedDeal[]
  schemaValid?: boolean
}): QueuedExtractionResult {
  return {
    provider: input.provider,
    model: input.model,
    prompt_version: EXTRACTION_PROMPT_VERSION,
    method: input.method,
    schema_valid: input.schemaValid ?? true,
    deals: input.deals.map(normalizeExtractedDeal),
  }
}

function sortedComparisonDeals(output: QueuedExtractionResult): NormalizedDeal[] {
  return [...output.deals].sort((a, b) => {
    const aKey = [
      normalizeForCompare(a.retailer),
      normalizeForCompare(a.deal_type),
      a.percent_off ?? '',
      normalizeForCompare(a.promo_code),
      a.categories.join('|'),
      normalizeForCompare(a.description),
    ].join('::')
    const bKey = [
      normalizeForCompare(b.retailer),
      normalizeForCompare(b.deal_type),
      b.percent_off ?? '',
      normalizeForCompare(b.promo_code),
      b.categories.join('|'),
      normalizeForCompare(b.description),
    ].join('::')
    return aKey.localeCompare(bKey)
  })
}

function sameMultiset(left: string[], right: string[]): boolean {
  if (left.length !== right.length) return false
  const l = [...left].sort()
  const r = [...right].sort()
  return l.every((value, index) => value === r[index])
}

function fieldValues(
  deals: NormalizedDeal[],
  field: 'retailer' | 'deal_type' | 'percent_off' | 'promo_code' | 'categories',
): string[] {
  return deals.map((deal) => {
    if (field === 'categories') return deal.categories.join('|')
    if (field === 'percent_off') return deal.percent_off == null ? '' : String(deal.percent_off)
    return normalizeForCompare(deal[field])
  })
}

export function compareExtractionOutputs(
  production: QueuedExtractionResult,
  shadow: QueuedExtractionResult | null,
  providerError: string | null = null,
): ExtractionComparisonResult {
  if (!shadow) {
    return {
      status: 'provider_failed',
      production_schema_valid: production.schema_valid,
      shadow_schema_valid: false,
      deal_count_match: false,
      retailer_agreement: false,
      deal_type_agreement: false,
      percent_agreement: false,
      promo_code_agreement: false,
      category_agreement: false,
      description_differences: [],
      details: { provider_error: providerError },
    }
  }

  const productionSchemaValid = production.schema_valid
  const shadowSchemaValid = shadow.schema_valid
  const productionDeals = sortedComparisonDeals(production)
  const shadowDeals = sortedComparisonDeals(shadow)
  const dealCountMatch = productionDeals.length === shadowDeals.length
  const retailerAgreement = sameMultiset(
    fieldValues(productionDeals, 'retailer'),
    fieldValues(shadowDeals, 'retailer'),
  )
  const dealTypeAgreement = sameMultiset(
    fieldValues(productionDeals, 'deal_type'),
    fieldValues(shadowDeals, 'deal_type'),
  )
  const percentAgreement = sameMultiset(
    fieldValues(productionDeals, 'percent_off'),
    fieldValues(shadowDeals, 'percent_off'),
  )
  const promoCodeAgreement = sameMultiset(
    fieldValues(productionDeals, 'promo_code'),
    fieldValues(shadowDeals, 'promo_code'),
  )
  const categoryAgreement = sameMultiset(
    fieldValues(productionDeals, 'categories'),
    fieldValues(shadowDeals, 'categories'),
  )

  const descriptionDifferences: ExtractionComparisonResult['description_differences'] = []
  const maxDeals = Math.max(productionDeals.length, shadowDeals.length)
  for (let index = 0; index < maxDeals; index++) {
    const productionDescription = productionDeals[index]?.description ?? null
    const shadowDescription = shadowDeals[index]?.description ?? null
    if (normalizeForCompare(productionDescription) !== normalizeForCompare(shadowDescription)) {
      descriptionDifferences.push({
        index,
        production: productionDescription,
        shadow: shadowDescription,
      })
    }
  }

  const schemaFailed = !productionSchemaValid || !shadowSchemaValid
  const allStructuredFieldsMatch =
    dealCountMatch &&
    retailerAgreement &&
    dealTypeAgreement &&
    percentAgreement &&
    promoCodeAgreement &&
    categoryAgreement
  const status = schemaFailed
    ? 'schema_failed'
    : allStructuredFieldsMatch && descriptionDifferences.length === 0
      ? 'match'
      : 'needs_review'

  return {
    status,
    production_schema_valid: productionSchemaValid,
    shadow_schema_valid: shadowSchemaValid,
    deal_count_match: dealCountMatch,
    retailer_agreement: retailerAgreement,
    deal_type_agreement: dealTypeAgreement,
    percent_agreement: percentAgreement,
    promo_code_agreement: promoCodeAgreement,
    category_agreement: categoryAgreement,
    description_differences: descriptionDifferences,
    details: {
      production_deal_count: productionDeals.length,
      shadow_deal_count: shadowDeals.length,
    },
  }
}

export function cleanEmailBodyForExtraction(body: string): string {
  return body
    .replace(/<style[^>]*>[\s\S]*?<\/style>/gi, '')
    .replace(/<script[^>]*>[\s\S]*?<\/script>/gi, '')
    .replace(/https?:\/\/[^\s"'>]{10,}/g, '')
    .replace(/base64,[a-zA-Z0-9+/=]+/g, '')
    .replace(/<[^>]+>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 20000)
}

function usableImageUrls(imageUrls: string[]): string[] {
  return Array.from(new Set(imageUrls))
    .filter((url) => /^https?:\/\//i.test(url))
    .slice(0, 8)
}

function buildTextExtractionRequest(
  from: string,
  subject: string,
  cleanedBody: string,
  newCategories: CategoryRow[],
): ExtractorRequest {
  return {
    systemPrompt: buildSystemPrompt(newCategories),
    userContent: `FROM: ${from}
SUBJECT: ${subject}
BODY: ${cleanedBody}`,
    schemaName: 'deal_extraction',
    schema: extractionJsonSchema,
  }
}

function buildVisionExtractionRequest(
  from: string,
  subject: string,
  imageUrls: string[],
  newCategories: CategoryRow[],
): ExtractorRequest | null {
  const urls = usableImageUrls(imageUrls)
  if (urls.length === 0) return null

  return {
    systemPrompt: buildSystemPrompt(newCategories),
    userContent: [
      {
        type: 'text',
        text: `FROM: ${from}
SUBJECT: ${subject}

This promotional email has little or no useful HTML text. It may have appeared clipped in Gmail, with important sale copy near the bottom. Inspect every supplied image and read sale copy, promo codes, expiration dates, product/category text, and offer details directly from the pixels. Ignore logos, social icons, app badges, decorative photography with no sale copy, and tracking pixels. Return only the deal JSON requested by the system prompt.`,
      },
      ...urls.map((url) => ({
        type: 'image_url' as const,
        image_url: { url },
      })),
    ],
    schemaName: 'deal_extraction',
    schema: extractionJsonSchema,
  }
}

export async function processOpenRouterExtractionSnapshot(
  snapshot: ExtractionSnapshot,
  newCategories: CategoryRow[] = [],
): Promise<QueuedExtractionResult> {
  const provider = createExtractorProvider(getOpenRouterConfig())
  const model = getOpenRouterExtractionModel()
  const textContent = await provider.complete(
    buildTextExtractionRequest(
      snapshot.from,
      snapshot.subject,
      snapshot.cleanedBody,
      newCategories,
    )
  )
  const textResult = textContent
    ? parseExtractionResult(textContent, 'OpenRouter text')
    : { schemaValid: false, deals: [] }

  const visionRequest = buildVisionExtractionRequest(
    snapshot.from,
    snapshot.subject,
    snapshot.imageUrls,
    newCategories,
  )

  if ((snapshot.cleanedBody.length < 500 || textResult.deals.length === 0) && visionRequest) {
    const visionContent = await provider.complete(visionRequest)
    const visionResult = visionContent
      ? parseExtractionResult(visionContent, 'OpenRouter vision')
      : { schemaValid: false, deals: [] }
    if (visionResult.deals.length > 0 || textResult.deals.length === 0) {
      return createNormalizedExtractionOutput({
        provider: SHADOW_EXTRACTION_PROVIDER,
        model,
        method: 'vision',
        deals: visionResult.deals,
        schemaValid: visionResult.schemaValid,
      })
    }
  }

  return createNormalizedExtractionOutput({
    provider: SHADOW_EXTRACTION_PROVIDER,
    model,
    method: 'text',
    deals: textResult.deals,
    schemaValid: textResult.schemaValid,
  })
}

export async function extractDealsFromEmail(
  from: string,
  subject: string,
  body: string,
  newCategories: CategoryRow[] = [],
): Promise<ExtractedDeal[]> {
  const cleanBody = cleanEmailBodyForExtraction(body)

  try {
    const content = await callExtractor(
      buildTextExtractionRequest(from, subject, cleanBody, newCategories)
    )
    if (!content) {
      const deals: ExtractedDeal[] = []
      extractionSchemaValidity.set(deals, false)
      return deals
    }

    return parseProductionExtractionResponse(content, 'OpenRouter text')
  } catch (err) {
    if (
      err instanceof ApiCreditExhaustedError ||
      err instanceof ApiRateLimitError ||
      err instanceof ApiSchemaValidationError
    ) throw err
    console.error('OpenRouter text extraction error:', err)
    return []
  }
}

export async function extractDealsFromEmailImages(
  from: string,
  subject: string,
  imageUrls: string[],
  newCategories: CategoryRow[] = [],
): Promise<ExtractedDeal[]> {
  const request = buildVisionExtractionRequest(from, subject, imageUrls, newCategories)
  if (!request) return []

  try {
    const content = await callExtractor(request)
    if (!content) {
      const deals: ExtractedDeal[] = []
      extractionSchemaValidity.set(deals, false)
      return deals
    }
    return parseProductionExtractionResponse(content, 'OpenRouter vision')
  } catch (err) {
    if (
      err instanceof ApiCreditExhaustedError ||
      err instanceof ApiRateLimitError ||
      err instanceof ApiSchemaValidationError
    ) throw err
    console.error('OpenRouter vision extraction error:', err)
    return []
  }
}

// ── Retailer category lookup ───────────────────────────────────────────
// Given a retailer name, ask the LLM what categories that brand primarily
// sells (using its training knowledge of the brand, not any specific email).
// Returns slugs from the new taxonomy. Returns empty array if the brand is
// unknown to the model — the caller should fall back to using whatever the
// current deal's tags were.

const RetailerCategoriesSchema = z.object({
  categories: z.array(z.string()),
}).strict()

const retailerCategoriesJsonSchema: JsonSchema = {
  type: 'object',
  additionalProperties: false,
  required: ['categories'],
  properties: {
    categories: {
      type: 'array',
      items: { type: 'string' },
    },
  },
}

export async function getRetailerCategories(
  retailer: string,
  allCategories: CategoryRow[],
): Promise<string[]> {
  if (!retailer || allCategories.length === 0) return []

  const categoryList = allCategories
    .map((c) => `${c.slug} (${c.label})`)
    .join(', ')

  const systemPrompt = `You are a retail-industry expert. Given a retailer name, list ALL product categories they primarily sell to consumers — based on your general knowledge of the brand, not any specific email.

Use slugs from this list ONLY: ${categoryList}

For mega-retailers (Walmart, Target, Amazon, Costco, Nordstrom, etc.) list every applicable category — there's no cap. For specialty brands (Boll & Branch, Warby Parker, etc.) list 1-3. If the brand is unknown to you, return an empty array.

Return ONLY this exact JSON structure:
{ "categories": ["slug1", "slug2", ...] }`

  try {
    const content = await callExtractor({
      systemPrompt,
      userContent: `Retailer: ${retailer}`,
      schemaName: 'retailer_categories',
      schema: retailerCategoriesJsonSchema,
    })
    if (!content) return []

    const parsed = JSON.parse(content)
    const validated = RetailerCategoriesSchema.safeParse(parsed)
    if (!validated.success) return []

    // Filter to only valid slugs (defense against LLM hallucination)
    const validSlugs = new Set(allCategories.map((c) => c.slug))
    return validated.data.categories.filter((slug) => validSlugs.has(slug))
  } catch (err) {
    console.error(`[extractor] getRetailerCategories error for "${retailer}":`, err)
    return []
  }
}
