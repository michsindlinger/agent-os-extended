---
name: Business Analysis Methods
description: Apply data-driven decision frameworks and metrics analysis for validation
triggers:
  - task_mentions: "business analysis|metrics|data analysis|go-no-go decision|kpi"
  - file_contains: "validation-results|decision-matrix"
---

# Business Analysis Methods

Apply proven frameworks for analyzing metrics, making data-driven decisions, and presenting business insights.

## 1. Metrics Analysis

### Key Performance Indicators (KPIs)

**Acquisition Metrics**:
- **Traffic**: Visitors to landing page
- **Conversion Rate**: % of visitors who take desired action
- **Cost Per Acquisition (CPA)**: Ad spend ÷ conversions
- **Customer Acquisition Cost (CAC)**: Total marketing spend ÷ new customers

**Engagement Metrics**:
- **Activation Rate**: % of signups who complete onboarding
- **Daily/Monthly Active Users (DAU/MAU)**
- **Session Duration**: Time spent per visit
- **Pages Per Session**: Depth of engagement

**Retention Metrics**:
- **Churn Rate**: % of customers who cancel per month
- **Retention Rate**: % of customers who stay (100% - churn)
- **Cohort Retention**: Track cohorts over time

**Revenue Metrics**:
- **Monthly Recurring Revenue (MRR)**: Predictable monthly revenue
- **Average Revenue Per User (ARPU)**: Total revenue ÷ users
- **Lifetime Value (LTV)**: ARPU × (1 ÷ churn rate) × gross margin
- **LTV:CAC Ratio**: LTV ÷ CAC (target >3:1)

### Conversion Rate Analysis

**Formula**:
```
Conversion Rate = (Conversions ÷ Total Visitors) × 100%
```

**Example**:
```
Landing page visitors: 1,000
Email signups: 62
Conversion rate: (62 ÷ 1,000) × 100% = 6.2%
```

**Benchmarks by Industry**:
- **SaaS Landing Pages**: 2-5% (good), 5-10% (excellent)
- **E-commerce**: 2-3% (average), 3-5% (good)
- **Lead Gen**: 5-10% (average), 10-15% (good)

**Conversion Rate Improvement**:
```
Baseline: 2%
After optimization: 3%
Improvement: (3% - 2%) ÷ 2% = 50% increase
Impact: 50% more customers from same traffic
```

### Cost Per Acquisition (CPA)

**Formula**:
```
CPA = Total Ad Spend ÷ Number of Conversions
```

**Example**:
```
Google Ads spend: €500
Email signups: 50
CPA: €500 ÷ 50 = €10 per signup
```

**CPA Evaluation**:
```
If CPA < (LTV × 30%) → Excellent (profitable to scale)
If CPA < (LTV × 50%) → Good (profitable)
If CPA < LTV → Acceptable (break-even long-term)
If CPA > LTV → Bad (losing money)
```

**Example Decision**:
```
CPA: €10
ARPU: €180/year
LTV: €180 ÷ 20% churn × 70% margin = €630
Ratio: €630 ÷ €10 = 63:1 (Excellent!)
→ Decision: Scale ad spend aggressively
```

### Customer Acquisition Cost (CAC)

**Formula**:
```
CAC = (Sales + Marketing Costs) ÷ New Customers Acquired
```

**Example**:
```
Marketing costs: €10,000 (ads, content, tools)
Sales costs: €5,000 (sales team time)
New customers: 100
CAC: (€10,000 + €5,000) ÷ 100 = €150
```

**CAC Payback Period**:
```
CAC Payback = CAC ÷ (ARPU × Gross Margin)
```

**Example**:
```
CAC: €150
ARPU: €180/year = €15/month
Gross Margin: 70%
CAC Payback: €150 ÷ (€15 × 0.7) = 14.3 months
→ Takes 14 months to recover acquisition cost
→ Target: <12 months for SaaS
```

### Lifetime Value (LTV)

**Formula** (for subscription business):
```
LTV = ARPU × (1 ÷ Churn Rate) × Gross Margin
```

**Example**:
```
ARPU: €180/year
Churn: 20%/year
Gross Margin: 70%
LTV: €180 × (1 ÷ 0.20) × 0.70 = €630
```

**Alternative Formula** (cohort-based):
```
LTV = Average Revenue Per Month × Average Customer Lifespan × Gross Margin
```

**Example**:
```
ARPM: €15
Avg Lifespan: 3 years = 36 months
Gross Margin: 70%
LTV: €15 × 36 × 0.70 = €378
```

### Return on Investment (ROI)

**Formula**:
```
ROI = (Gain - Cost) ÷ Cost × 100%
```

**Example** (Marketing campaign):
```
Ad spend: €500
Revenue from campaign: €2,000
Profit margin: 70%
Gain: €2,000 × 0.70 = €1,400
ROI: (€1,400 - €500) ÷ €500 × 100% = 180%
→ For every €1 spent, gained €1.80
```

## 2. Decision Frameworks

### Decision Matrix (Weighted Scoring)

**Structure**:
1. List criteria with weights (total 100%)
2. Score each option (1-10)
3. Calculate weighted scores
4. Highest score wins

**Example** (Choosing validation approach):

| Criteria | Weight | Option A: Landing Page | Option B: MVP | Option C: Survey |
|----------|--------|----------------------|---------------|------------------|
| Speed to Market | 30% | 9 (2.7) | 4 (1.2) | 10 (3.0) |
| Cost | 25% | 9 (2.25) | 3 (0.75) | 10 (2.5) |
| Data Quality | 25% | 7 (1.75) | 9 (2.25) | 5 (1.25) |
| Scalability | 20% | 8 (1.6) | 7 (1.4) | 6 (1.2) |
| **Total** | | **8.3** | **5.6** | **7.95** |

→ **Decision**: Choose Landing Page (highest score 8.3)

### GO/NO-GO Decision Criteria

**Three-Threshold System**:

**GO Decision** (All criteria met):
- Conversion Rate ≥ Target
- CPA ≤ Target
- TAM ≥ Minimum viable market

**MAYBE Decision** (1-2 criteria met):
- Conversion Rate: 60-99% of target
- CPA: 100-150% of target
- TAM: 50-99% of minimum

**NO-GO Decision** (0 criteria met or critical failure):
- Conversion Rate < 60% of target
- CPA > 150% of target
- TAM < 50% of minimum

**Example Thresholds**:
```
GO:
- Conversion ≥ 5%
- CPA ≤ €10
- TAM ≥ 100,000

MAYBE:
- Conversion: 3-4.9%
- CPA: €10-€15
- TAM: 50,000-99,999

NO-GO:
- Conversion < 3%
- CPA > €15
- TAM < 50,000
```

**Decision Logic**:
```
Actual Results:
- Conversion: 6.2% ✅ (exceeds 5%)
- CPA: €8.50 ✅ (below €10)
- TAM: 250,000 ✅ (exceeds 100k)

→ 3/3 criteria met → GO Decision
Confidence: High (95%)
```

### Risk-Reward Assessment

**Formula**:
```
Risk-Adjusted Return = Expected Return × Probability of Success - Potential Loss × Probability of Failure
```

**Example**:
```
Expected Return: €1M revenue/year
Probability of Success: 40% (from validation data)
Development Cost: €100k
Probability of Failure: 60%

Risk-Adjusted Return:
= (€1M × 0.4) - (€100k × 0.6)
= €400k - €60k
= €340k positive

→ Decision: Proceed (positive risk-adjusted return)
```

### Break-Even Analysis

**Formula**:
```
Break-Even Point = Fixed Costs ÷ (Price - Variable Cost per Unit)
```

**Example**:
```
Fixed Costs: €50,000/year (salaries, tools, hosting)
Price: €180/year per customer
Variable Cost: €30/year per customer (support, hosting, payment fees)

Break-Even: €50,000 ÷ (€180 - €30) = 333 customers
→ Need 333 paying customers to break even
```

**Time to Break-Even**:
```
If acquiring 50 customers/month:
333 ÷ 50 = 6.7 months to break even
```

## 3. Data Visualization

### Chart Selection Guide

**Comparison**: Bar Chart
- Compare values across categories
- Example: Revenue by product line

**Trend Over Time**: Line Chart
- Show changes over time
- Example: Monthly signups over 12 months

**Composition**: Pie Chart or Stacked Bar
- Show parts of a whole
- Example: Traffic sources (40% Google, 30% Direct, 30% Social)

**Distribution**: Histogram
- Show frequency distribution
- Example: Customer lifetime value distribution

**Relationship**: Scatter Plot
- Show correlation between two variables
- Example: Ad spend vs. conversions

**Ranking**: Horizontal Bar Chart
- Compare many items by value
- Example: Top 20 competitors by market share

### Dashboard Design Principles

**Hierarchy**:
1. **Top**: Most important metric (North Star KPI)
2. **Middle**: Supporting metrics
3. **Bottom**: Detailed breakdown

**Example Dashboard** (Validation Campaign):
```
┌─────────────────────────────────────┐
│  CONVERSION RATE: 6.2%             │ ← Primary KPI
│  (Target: 5%, Status: ✅ Exceeded) │
├─────────────────────────────────────┤
│  Traffic: 1,000  |  CPA: €8.50     │ ← Supporting
│  Signups: 62     |  Budget: €500   │
├─────────────────────────────────────┤
│  Traffic Sources:                   │ ← Breakdown
│  - Google Ads: 600 (60%)           │
│  - Facebook: 300 (30%)             │
│  - Direct: 100 (10%)               │
└─────────────────────────────────────┘
```

**Color Coding**:
- ✅ Green: Exceeds target
- ⚠️ Yellow: Close to target (90-100%)
- ❌ Red: Below target (<90%)

### Data Presentation Best Practices

**Simplify**:
- One chart = one message
- Remove unnecessary gridlines, borders
- Use clear labels

**Contextualize**:
- Always show target/benchmark
- Include time period
- Add units (€, %, #)

**Highlight**:
- Draw attention to key insights
- Use color for emphasis (not decoration)

## 4. Statistical Significance Testing

### Sample Size Calculation

**For Conversion Rate Tests**:
```
Required Sample Size ≈ 16 × (1 ÷ Conversion Rate)²
```

**Example**:
```
Expected Conversion: 5%
Sample Size: 16 × (1 ÷ 0.05)² = 16 × 400 = 6,400 visitors

→ Need ~6,400 visitors to detect meaningful difference
```

**Quick Rules**:
- High conversion (10%): ~1,600 visitors
- Medium conversion (5%): ~6,400 visitors
- Low conversion (1%): ~160,000 visitors

### Confidence Intervals

**95% Confidence Interval** (most common):
```
CI = Conversion Rate ± 1.96 × √[(CR × (1-CR)) ÷ n]
```

**Example**:
```
Conversion Rate: 6.2%
Sample Size: 1,000

CI = 0.062 ± 1.96 × √[(0.062 × 0.938) ÷ 1,000]
   = 0.062 ± 1.96 × 0.0076
   = 0.062 ± 0.015
   = 4.7% to 7.7%

→ 95% confident true conversion is between 4.7% and 7.7%
```

**Interpretation**:
```
If target was 5%:
Lower bound (4.7%) is close to target → MAYBE decision
If target was 3%:
Lower bound (4.7%) exceeds target → GO decision (conservative)
```

### A/B Test Significance

**Chi-Square Test** (simplified):
```
If Variant B conversion is >10% different from Variant A
AND sample size >1,000 per variant
→ Likely statistically significant
```

**Online Calculator**: Use tool like Optimizely, VWO, or Google Optimize

**Example**:
```
Variant A (control): 1,000 visitors, 50 conversions (5%)
Variant B (test): 1,000 visitors, 70 conversions (7%)

Improvement: (7% - 5%) ÷ 5% = 40% lift
Sample size: 1,000 each (adequate)
→ Use calculator → p-value = 0.03 (< 0.05)
→ Statistically significant at 95% confidence
```

## 5. Qualitative Feedback Analysis

### Thematic Coding

**Process**:
1. Collect feedback (user interviews, surveys, reviews)
2. Read through all feedback
3. Identify recurring themes
4. Code each piece of feedback with theme tags
5. Count frequency of themes
6. Prioritize by frequency and impact

**Example** (Invoice tool feedback):
```
Feedback 1: "Too complicated, took 30 mins to set up"
→ Code: [Complexity], [Onboarding]

Feedback 2: "Love how fast I can create invoices now"
→ Code: [Speed], [Positive]

Feedback 3: "Wish it had expense tracking"
→ Code: [Feature Request], [Expenses]

... (analyze 50+ pieces of feedback)

Theme Frequency:
- [Complexity]: 15 mentions → Top priority to fix
- [Speed]: 12 mentions → Key strength, emphasize in marketing
- [Feature Request: Expenses]: 8 mentions → Consider for v2
```

### Sentiment Analysis

**Manual Scoring** (simple):
- **Positive**: 😊 +1
- **Neutral**: 😐 0
- **Negative**: 😞 -1

**Example**:
```
30 positive comments: 30 × 1 = +30
10 neutral comments: 10 × 0 = 0
5 negative comments: 5 × -1 = -5
Total: +25 ÷ 45 = +0.56 (Positive overall)
```

**Net Promoter Score (NPS)**:
```
Question: "How likely are you to recommend this to a friend? (0-10)"

Promoters (9-10): Would recommend
Passives (7-8): Satisfied but not enthusiastic
Detractors (0-6): Unsatisfied

NPS = % Promoters - % Detractors
```

**Example**:
```
100 responses:
- 50 Promoters (9-10): 50%
- 30 Passives (7-8): 30%
- 20 Detractors (0-6): 20%

NPS = 50% - 20% = +30
→ Good (>0 is positive, >50 is excellent)
```

### Insight Extraction

**Pattern Recognition**:
```
Raw Feedback: "It's too expensive for what it does"
→ Insight: Perceived value < price (feature gap or pricing issue?)

Raw Feedback: "I only use 2 features out of 20"
→ Insight: Over-engineered product (opportunity to simplify)

Raw Feedback: "My accountant doesn't understand it"
→ Insight: Missing integration with accountants (B2B opportunity)
```

**Actionable Recommendations**:
```
Theme: [Complexity] (15 mentions)
Root Cause: Too many features, complex onboarding
Recommendation: Create "Simple Mode" with 3 core features only
Expected Impact: Reduce onboarding time from 30 min to 5 min
```

## Application Checklist

When analyzing validation data:

**Metrics Collection**:
- [ ] Recorded conversion rate (target vs. actual)
- [ ] Calculated CPA (target vs. actual)
- [ ] Estimated TAM (realistic addressable market)
- [ ] Collected qualitative feedback (10+ responses)
- [ ] Measured sample size (adequate for significance?)

**Decision Making**:
- [ ] Compared against all three criteria (conversion, CPA, TAM)
- [ ] Calculated confidence intervals
- [ ] Assessed statistical significance (if applicable)
- [ ] Considered qualitative insights
- [ ] Documented decision rationale

**Presentation**:
- [ ] Created clear decision matrix
- [ ] Visualized key metrics
- [ ] Provided GO/MAYBE/NO-GO recommendation
- [ ] Listed supporting evidence
- [ ] Outlined next steps

## Common Pitfalls to Avoid

❌ **Insufficient Sample Size**: Drawing conclusions from 50 visitors
✅ **Fix**: Wait for >1,000 visitors minimum

❌ **Ignoring Statistical Significance**: Declaring winner too early
✅ **Fix**: Use confidence intervals, wait for adequate sample

❌ **Cherry-Picking Metrics**: Only showing favorable data
✅ **Fix**: Report all three criteria (conversion, CPA, TAM)

❌ **Vanity Metrics**: "1,000 visitors!" (but 1% conversion)
✅ **Fix**: Focus on conversion and CPA, not just traffic

❌ **No Context**: "6.2% conversion" (vs. what?)
✅ **Fix**: Always compare to target/benchmark

## Example: Complete Validation Analysis

**Validation Campaign Results**:
```
Duration: 3 weeks
Ad Spend: €500
Landing Page: Simple HTML, one-page

Traffic:
- Google Ads: 600 visitors
- Facebook Ads: 300 visitors
- Organic: 100 visitors
- Total: 1,000 visitors

Conversions:
- Email Signups: 62
- Conversion Rate: 6.2%

Cost Per Acquisition:
- CPA: €500 ÷ 62 = €8.06

Market Size:
- TAM: 1.5M freelancers in Germany
- SAM: 300k tech-savvy creatives
- Realistic TAM: 300,000
```

**Decision Matrix**:
| Criterion | Target | Actual | Status | Weight |
|-----------|--------|--------|--------|--------|
| Conversion | ≥5% | 6.2% | ✅ Exceeded | Critical |
| CPA | ≤€10 | €8.06 | ✅ Achieved | Critical |
| TAM | ≥100k | 300k | ✅ Exceeded | Critical |

**Qualitative Insights** (from 30 email responses):
- 18 positive: "So simple!", "Exactly what I need", "Finally!"
- 8 neutral: "Looks interesting, will try when launched"
- 4 negative: "Missing expense tracking", "Need mobile app"

**Sentiment Score**: +14 ÷ 30 = +0.47 (Positive)

**Decision**:
```
GO - Strong Validation ✅

Confidence: High (95%)

Rationale:
1. All 3 criteria exceeded targets
2. Conversion rate 24% above target (6.2% vs 5%)
3. CPA 19% below target (€8.06 vs €10)
4. TAM 3x minimum viable (300k vs 100k)
5. Positive user sentiment (+0.47)
6. Statistical significance (1,000 visitors, CI: 4.7-7.7%)

Next Steps:
1. Proceed to /plan-product
2. Prioritize features based on feedback
3. Target "freelance creatives" niche (strongest segment)
4. Plan for v1.0 with core features only
5. Add expense tracking in v1.1 (frequent request)
```

---

**Use this skill when**: Analyzing validation metrics, making GO/NO-GO decisions, or presenting business insights.
