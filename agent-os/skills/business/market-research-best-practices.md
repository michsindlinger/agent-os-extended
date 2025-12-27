---
name: Market Research Best Practices
description: Apply systematic frameworks for competitive analysis and market sizing
triggers:
  - task_mentions: "market research|competitor analysis|market validation|competitive intelligence"
  - file_contains: "competitor-analysis|market-positioning"
---

# Market Research Best Practices

Apply proven frameworks for competitive analysis, market sizing, and strategic positioning to validate product-market fit.

## 1. Competitive Analysis Frameworks

### Porter's Five Forces

Analyze competitive dynamics across five dimensions:

**1. Competitive Rivalry** (Intensity of competition)
- How many competitors?
- Market growth rate (growing = less intense rivalry)
- Product differentiation (low = price wars)
- Exit barriers (high = trapped competitors fight harder)

**2. Threat of New Entrants**
- Barriers to entry (capital, technology, brand, regulation)
- Economies of scale
- Network effects
- Switching costs for customers

**3. Bargaining Power of Suppliers**
- Supplier concentration (few suppliers = high power)
- Switching costs to change suppliers
- Forward integration threat

**4. Bargaining Power of Buyers**
- Buyer concentration (few large buyers = high power)
- Price sensitivity
- Switching costs
- Backward integration threat

**5. Threat of Substitutes**
- Alternative solutions (different approach to same problem)
- Price-performance ratio of substitutes
- Switching costs

**Application Example** (Invoice automation):
```
Competitive Rivalry: HIGH (FreshBooks, QuickBooks, Xero, 20+ others)
New Entrants: MEDIUM (low tech barriers, but brand loyalty exists)
Supplier Power: LOW (many tech providers, APIs, cloud services)
Buyer Power: HIGH (freelancers price-sensitive, easy to switch)
Substitutes: HIGH (Excel, Word templates, manual invoicing)

→ Strategy: Differentiate on ease-of-use + niche targeting
```

### SWOT Analysis

**Internal Factors**:
- **Strengths**: What advantages do you have?
- **Weaknesses**: What disadvantages do you have?

**External Factors**:
- **Opportunities**: What favorable trends exist?
- **Threats**: What obstacles do you face?

**SWOT Matrix**:
```
+----------------+------------------+
| STRENGTHS      | WEAKNESSES       |
| - Expertise    | - Small team     |
| - Low cost     | - No brand       |
+----------------+------------------+
| OPPORTUNITIES  | THREATS          |
| - Market gap   | - Competitors    |
| - Trend        | - Regulation     |
+----------------+------------------+
```

**Strategic Actions**:
1. **Strength + Opportunity** = Growth strategy
2. **Strength + Threat** = Defensive strategy
3. **Weakness + Opportunity** = Development strategy
4. **Weakness + Threat** = Damage control

### Feature Comparison Matrix

**Structure**:

| Feature | Our Product | Competitor A | Competitor B | Competitor C |
|---------|-------------|--------------|--------------|--------------|
| Feature 1 | ✅ | ✅ | ❌ | ✅ |
| Feature 2 | ✅ | ❌ | ✅ | ❌ |
| Pricing | €15/mo | €25/mo | €20/mo | Free + €50/mo |
| Target | Freelancers | SMBs | Enterprise | All |

**Rating System**:
- ✅ Full support
- ⚠️ Partial support
- ❌ Not supported
- ➕ Our unique advantage

**Analysis**:
```
Unique Features (only we have): [List]
Parity Features (everyone has): [List]
Missing Features (we lack): [List]
→ Positioning: "Only solution with [unique features] for [target]"
```

### Competitive Intelligence Sources

**Public Sources**:
- Company websites (features, pricing, case studies)
- Product reviews (G2, Capterra, Trustpilot)
- Social media (Twitter, LinkedIn for announcements)
- Job postings (hiring = growth, tech stack insights)
- Financial reports (if public company)
- Press releases and news

**Research Tools**:
- **Perplexity / ChatGPT**: "Find top 10 competitors for [product] in [market]"
- **SimilarWeb / Alexa**: Traffic estimates
- **BuiltWith**: Technology stack
- **Crunchbase**: Funding, investors
- **Google Trends**: Interest over time

**Validation**:
- Cross-check at least 3 sources
- Look for recent data (<6 months)
- Verify claims with user reviews

## 2. Market Sizing Methodologies

### TAM, SAM, SOM Framework

**TAM (Total Addressable Market)**:
- Total revenue opportunity if you had 100% market share
- Usually calculated globally or for entire category

**SAM (Serviceable Available Market)**:
- Portion of TAM you can realistically target
- Limited by geography, product capabilities, regulations

**SOM (Serviceable Obtainable Market)**:
- Portion of SAM you can realistically capture short-term
- Limited by competition, budget, distribution

**Visual**:
```
┌─────────────────────────────┐
│   TAM (Total Market)        │  €10B globally
│  ┌─────────────────────┐    │
│  │ SAM (Your Segment)  │    │  €500M (freelancers in EU)
│  │  ┌─────────────┐    │    │
│  │  │ SOM (Obtain)│    │    │  €5M (0.5% in year 1)
│  │  └─────────────┘    │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```

### Top-Down Market Sizing

**Approach**: Start with macro data, narrow down.

**Formula**:
```
TAM = Total Target Population × Average Revenue Per User (ARPU)
```

**Example** (Invoice automation for freelancers):
```
Step 1: Total freelancers in Germany = 1.5M (public data)
Step 2: Freelancers who invoice regularly = 1.2M (80%)
Step 3: Tech-savvy freelancers (use digital tools) = 600k (50%)
Step 4: Freelancers with invoicing pain = 300k (50% of tech-savvy)
Step 5: Willing to pay for solution = 150k (50%)
Step 6: ARPU = €15/month × 12 = €180/year

TAM = 150,000 × €180 = €27M/year (Germany only)
SAM = €27M (focus on Germany initially)
SOM = €27M × 1% (year 1 capture) = €270k
```

### Bottom-Up Market Sizing

**Approach**: Start with unit economics, scale up.

**Formula**:
```
SOM = Number of Customers You Can Acquire × ARPU
```

**Example**:
```
Step 1: Marketing budget = €50k/year
Step 2: Cost Per Acquisition (CPA) = €10 (from validation)
Step 3: Customers acquired = €50k / €10 = 5,000
Step 4: Churn rate = 20%/year
Step 5: Net customers after year 1 = 5,000 × 80% = 4,000
Step 6: ARPU = €180/year

SOM = 4,000 × €180 = €720k/year
```

**Validation**: Does bottom-up match top-down? If vastly different, re-examine assumptions.

### Market Sizing Data Sources

**Official Statistics**:
- Government census data
- Industry association reports
- Trade publications
- Market research firms (Gartner, Forrester, IDC)

**Estimation When Data Unavailable**:
```
If no direct data:
1. Find proxy data (e.g., "tax filers" as proxy for "freelancers")
2. Apply conversion rates (e.g., 30% of tax filers are active freelancers)
3. Triangulate with multiple proxies
```

## 3. Positioning Strategies

### Differentiation Strategies

**Five Ways to Differentiate**:

1. **Feature Differentiation**
   - Unique functionality competitors lack
   - Example: "Only invoice tool with built-in contract templates"

2. **Quality Differentiation**
   - Better performance, reliability, support
   - Example: "99.99% uptime vs. industry 95%"

3. **Price Differentiation**
   - Premium (higher price, more value)
   - Budget (lower price, good enough)
   - Example: "€5/month vs. €25/month competitors"

4. **Convenience Differentiation**
   - Easier, faster, more accessible
   - Example: "Create invoice in 60 seconds vs. 30 minutes"

5. **Niche Differentiation**
   - Specialized for specific segment
   - Example: "Built for creative freelancers, not accountants"

**Strategy Selection**:
```
If you can compete on:
- Technology → Feature Differentiation
- Operations → Quality / Convenience
- Cost Structure → Price Differentiation
- Market Knowledge → Niche Differentiation
```

### Positioning Statement Template

**Formula**:
```
For [target audience]
who [need/want],
[product name] is a [category]
that [key benefit].

Unlike [competitors],
[product name] [unique differentiator].
```

**Example**:
```
For freelance creatives
who waste hours on manual invoicing,
InvoiceSnap is an invoicing tool
that generates invoices in 60 seconds from time tracking.

Unlike QuickBooks and FreshBooks,
InvoiceSnap requires zero accounting knowledge and costs €5/month.
```

### Blue Ocean Strategy (Create New Market Space)

**Four Actions Framework**:

1. **Eliminate**: Which factors can we remove that the industry takes for granted?
2. **Reduce**: Which factors can we reduce below industry standard?
3. **Raise**: Which factors can we raise above industry standard?
4. **Create**: Which factors can we create that the industry has never offered?

**Example** (Invoice automation):
```
Eliminate: Complex accounting features (tax calculations, multi-entity)
Reduce: Support channels (email only, no phone)
Raise: Ease of use (1-click invoice generation)
Create: Automatic payment reminders via WhatsApp
```

### Niche Identification

**Riches in Niches**:

**Bad Niche** (too broad):
- "Anyone who needs invoicing"
- "All small businesses"

**Good Niche** (specific):
- "Freelance graphic designers in Germany with 5-20 clients/month"
- "Solo consultants who bill hourly and hate accounting"

**Niche Validation Criteria**:
- [ ] Can you list 10 specific customers?
- [ ] Do they hang out in specific places (communities, forums)?
- [ ] Do they have unique needs vs. broader market?
- [ ] Is the niche large enough (>10k potential customers)?
- [ ] Can you reach them affordably?

## 4. Research Sources and Methods

### Primary Research (Direct from Users)

**User Interviews**:
- 5-10 interviews to find patterns
- 30-60 minute conversations
- Ask about current behavior, not hypotheticals
- Record and transcribe

**Surveys**:
- 50-100 responses for statistical significance
- Mix of multiple choice (quantitative) and open-ended (qualitative)
- Keep survey <5 minutes
- Incentivize with discount or entry to prize draw

**Observation**:
- Watch users perform tasks
- Note workarounds, errors, frustrations
- Don't interrupt during observation

**Landing Page Test**:
- Create fake product page
- Drive traffic with ads
- Measure email signups / pre-orders
- Conversion rate >5% = strong interest

### Secondary Research (Existing Data)

**Industry Reports**:
- Market size, growth trends, key players
- Sources: Gartner, Forrester, Statista

**Competitor Analysis**:
- Feature sets, pricing, positioning
- User reviews for pain points

**Trend Analysis**:
- Google Trends for search volume
- Social media mentions
- News and press coverage

### Research Validation Checklist

- [ ] Data is recent (<12 months)
- [ ] Data source is credible (not marketing material)
- [ ] Sample size is adequate (>30 for qualitative, >100 for quantitative)
- [ ] Multiple sources confirm findings
- [ ] Findings match real user conversations

## 5. Data Validation Techniques

### Triangulation Method

**Principle**: Confirm with 3+ independent sources.

**Example** (Validating market size):
```
Source 1: Government data says 1.5M freelancers in Germany
Source 2: Tax authority reports 1.3M self-employed
Source 3: Industry association estimates 1.6M
→ Consensus: ~1.5M ± 10%
```

### Sanity Check Calculations

**Question Everything**:
```
Claim: "10M potential customers in Germany"
Reality Check:
- Germany population = 83M
- Labor force = 45M
- Freelancers = ~1.5M
→ 10M is impossible, re-examine assumption
```

### Source Credibility Assessment

**Trust Levels**:
- ✅ **High**: Government statistics, academic research, industry associations
- ⚠️ **Medium**: Established research firms (Gartner, Forrester), financial reports
- ❌ **Low**: Vendor marketing claims, single-source blog posts, anonymous surveys

### Outdated Data Detection

**Red Flags**:
- Data >2 years old (especially in tech)
- Pre-pandemic data (2019 and earlier)
- No publication date listed
- Round numbers (suspiciously convenient)

## Application Checklist

When conducting market research:

**Competitive Analysis**:
- [ ] Identified 5-10 direct competitors
- [ ] Created feature comparison matrix
- [ ] Analyzed pricing across competitors
- [ ] Read 10+ user reviews of each competitor
- [ ] Identified 2-3 market gaps

**Market Sizing**:
- [ ] Calculated TAM (top-down)
- [ ] Calculated SOM (bottom-up)
- [ ] Validated with 3+ data sources
- [ ] Sanity-checked numbers
- [ ] Documented assumptions clearly

**Positioning**:
- [ ] Defined target niche (specific persona)
- [ ] Identified unique differentiator
- [ ] Created positioning statement
- [ ] Tested positioning with 5+ target users
- [ ] Refined based on feedback

## Common Pitfalls to Avoid

❌ **Confirmation Bias**: Only looking for data that supports your idea
✅ **Fix**: Actively search for contradicting evidence

❌ **Sampling Bias**: Interviewing only friends/family
✅ **Fix**: Talk to strangers in target market

❌ **Outdated Data**: Using 5-year-old market research
✅ **Fix**: Validate all data is <2 years old

❌ **Vanity Metrics**: "1 billion smartphone users = TAM"
✅ **Fix**: Narrow to realistic addressable segment

❌ **No Primary Research**: Relying only on desk research
✅ **Fix**: Interview 10+ target customers

## Example: Complete Competitive Analysis

**Product**: Invoice automation for freelance creatives

**Competitors Identified** (via Perplexity + Google):
1. FreshBooks - SMB accounting platform
2. QuickBooks - Enterprise accounting
3. Wave - Free invoicing
4. Zoho Invoice - Business suite
5. Invoice Ninja - Open source
6. Bonsai - Freelancer all-in-one
7. HoneyBook - Creative freelancers
8. AND.CO - Fiverr product

**Feature Comparison**:
| Feature | Our Product | FreshBooks | Wave | HoneyBook |
|---------|-------------|------------|------|-----------|
| 1-Click Invoice | ✅ ➕ | ❌ | ❌ | ⚠️ |
| Time Tracking | ✅ | ✅ | ❌ | ✅ |
| Payment Processing | ✅ | ✅ | ✅ | ✅ |
| Contracts | ❌ | ❌ | ❌ | ✅ |
| Accounting | ❌ | ✅ | ✅ | ❌ |
| Pricing | €5/mo | €15/mo | Free | €24/mo |

**Market Gaps Identified**:
1. **Simplicity**: All competitors are feature-bloated for simple freelancers
2. **Speed**: None offer true 1-click invoicing from time tracking
3. **Price**: Wave is free but lacks features, others are 3-5x more expensive
4. **Onboarding**: All require 30+ min setup, complex for non-accountants

**Positioning**:
```
For freelance creatives who hate accounting,
InvoiceSnap is the simplest invoicing tool
that turns timesheets into invoices in one click.

Unlike FreshBooks and HoneyBook,
InvoiceSnap requires zero setup and costs €5/month.
```

**Market Size**:
```
TAM: 1.5M freelancers × €180/year = €270M (Germany)
SAM: 300k tech-savvy creatives × €180 = €54M
SOM (Year 1): 2,000 customers × €180 = €360k
```

---

**Use this skill when**: Conducting competitive research, sizing markets, or developing positioning strategies.
