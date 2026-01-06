---
name: data-analyst
description: Analyzes product metrics and provides data-driven insights
version: 1.0
---

# Data Analyst

Transforms raw product data into actionable insights, tracks KPIs, and supports data-driven decision making for product development.

## Trigger Conditions

```yaml
task_mentions:
  - "metrics|analytics|kpi"
  - "data|measure|track"
  - "conversion|retention|engagement"
  - "ab test|experiment"
file_extension:
  - .md
  - .sql
file_contains:
  - "## Metrics"
  - "SELECT"
  - "conversion"
always_active_for_agents:
  - po-agent
  - product-agent
```

## When to Load

- Defining success metrics
- Analyzing feature performance
- Planning A/B tests
- Sprint/release retrospectives

## Core Competencies

### Key Metrics Framework

#### AARRR Pirate Metrics
```
┌─────────────────────────────────────────────────────────────┐
│ ACQUISITION    │ How do users find us?                      │
│ ───────────────┼───────────────────────────────────────────── │
│ Metrics        │ Traffic, Signups, CAC, Channel performance  │
├─────────────────────────────────────────────────────────────┤
│ ACTIVATION     │ Do users have a great first experience?     │
│ ───────────────┼───────────────────────────────────────────── │
│ Metrics        │ Onboarding completion, Time to value        │
├─────────────────────────────────────────────────────────────┤
│ RETENTION      │ Do users come back?                         │
│ ───────────────┼───────────────────────────────────────────── │
│ Metrics        │ DAU/MAU, Churn rate, Session frequency      │
├─────────────────────────────────────────────────────────────┤
│ REFERRAL       │ Do users tell others?                       │
│ ───────────────┼───────────────────────────────────────────── │
│ Metrics        │ NPS, Referral rate, Viral coefficient       │
├─────────────────────────────────────────────────────────────┤
│ REVENUE        │ Can we monetize?                            │
│ ───────────────┼───────────────────────────────────────────── │
│ Metrics        │ MRR, ARPU, LTV, Conversion rate             │
└─────────────────────────────────────────────────────────────┘
```

### Feature Success Metrics

```markdown
# Feature Metrics: [Feature Name]

## Primary Success Metric (North Star)
**Metric**: [e.g., Weekly Active Users of feature]
**Target**: [e.g., 5,000 WAU within 30 days]
**Current**: [e.g., 3,200 WAU]
**Status**: 🟡 64% to goal

## Supporting Metrics

### Adoption
| Metric | Definition | Target | Current |
|--------|------------|--------|---------|
| Feature discovery | % users who see feature | 80% | 72% |
| Feature trial | % who try once | 40% | 35% |
| Feature adoption | % who use regularly | 20% | 12% |

### Engagement
| Metric | Definition | Target | Current |
|--------|------------|--------|---------|
| Sessions/week | Avg sessions per user | 3.0 | 2.4 |
| Time in feature | Avg time per session | 5 min | 4.2 min |
| Actions/session | Avg interactions | 8 | 6.5 |

### Satisfaction
| Metric | Definition | Target | Current |
|--------|------------|--------|---------|
| Task completion | % successful completions | 90% | 85% |
| Error rate | % sessions with errors | < 5% | 8% |
| Support tickets | Related tickets/week | < 10 | 15 |

## Funnel Analysis
```
Users who see feature     10,000 (100%)
         │
         ▼
Users who click          7,200 (72%) — 28% drop-off
         │
         ▼
Users who complete setup  3,500 (35%) — 51% drop-off ⚠️
         │
         ▼
Users who use weekly     1,200 (12%)  — 66% drop-off ⚠️
```

## Insights
1. **Setup completion** is the biggest drop-off point
2. Users who complete setup have **3x higher retention**
3. Mobile users convert at **50% lower rate** than desktop

## Recommendations
1. Simplify setup flow (reduce from 5 steps to 3)
2. Add progress indicator during setup
3. Improve mobile onboarding experience
```

### A/B Test Design

```markdown
# A/B Test: [Test Name]

## Hypothesis
If we [change X], then [metric Y] will [increase/decrease] by [Z%]
because [rationale].

## Test Details
| Parameter | Value |
|-----------|-------|
| Start date | 2024-01-15 |
| Duration | 2 weeks |
| Sample size needed | 5,000 per variant |
| Traffic allocation | 50/50 |
| Primary metric | Conversion rate |
| MDE (Minimum Detectable Effect) | 5% |

## Variants
| Variant | Description |
|---------|-------------|
| Control | Current checkout flow (3 steps) |
| Treatment | New checkout flow (1-page) |

## Segmentation
- Device: All
- User type: New users only
- Geography: US only

## Success Criteria
- Primary: Conversion rate increases by ≥5%
- Secondary: Avg order value doesn't decrease by >2%
- Guardrail: Error rate doesn't increase by >1%

## Results

### Statistical Summary
| Metric | Control | Treatment | Lift | P-value | Significant? |
|--------|---------|-----------|------|---------|--------------|
| Conversion | 3.2% | 3.8% | +18.7% | 0.002 | ✅ Yes |
| AOV | $85.20 | $84.50 | -0.8% | 0.45 | ❌ No |
| Error rate | 1.2% | 1.1% | -8.3% | 0.67 | ❌ No |

### Recommendation
**SHIP IT** - Treatment shows significant conversion lift (+18.7%)
with no negative impact on AOV or error rates.

### Follow-up
- Monitor for 2 weeks post-launch
- Plan iteration to improve mobile experience
```

## Best Practices

### SQL Analytics Patterns

```sql
-- Daily Active Users
SELECT
  DATE(created_at) as date,
  COUNT(DISTINCT user_id) as dau
FROM events
WHERE event_type = 'session_start'
  AND created_at >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY DATE(created_at)
ORDER BY date;

-- Retention Cohort
WITH cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC('week', MIN(created_at)) as cohort_week
  FROM users
  GROUP BY user_id
),
activities AS (
  SELECT
    user_id,
    DATE_TRUNC('week', created_at) as activity_week
  FROM events
  GROUP BY user_id, DATE_TRUNC('week', created_at)
)
SELECT
  c.cohort_week,
  COUNT(DISTINCT c.user_id) as cohort_size,
  COUNT(DISTINCT CASE
    WHEN a.activity_week = c.cohort_week + INTERVAL '1 week'
    THEN a.user_id END) * 100.0 / COUNT(DISTINCT c.user_id) as week_1_retention
FROM cohorts c
LEFT JOIN activities a ON c.user_id = a.user_id
GROUP BY c.cohort_week
ORDER BY c.cohort_week;

-- Conversion Funnel
SELECT
  COUNT(DISTINCT CASE WHEN event = 'page_view' THEN user_id END) as viewed,
  COUNT(DISTINCT CASE WHEN event = 'add_to_cart' THEN user_id END) as added,
  COUNT(DISTINCT CASE WHEN event = 'checkout_start' THEN user_id END) as checkout,
  COUNT(DISTINCT CASE WHEN event = 'purchase' THEN user_id END) as purchased
FROM events
WHERE created_at >= CURRENT_DATE - INTERVAL '7 days';
```

### Dashboard Design Principles

| Principle | Application |
|-----------|-------------|
| One metric per question | Don't overcrowd |
| Compare to baseline | Show targets, trends |
| Time context | Always show time period |
| Actionable | Link metrics to actions |
| Drill-down | Allow exploration |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Vanity metrics | Not actionable | Focus on behavior metrics |
| No baseline | Can't measure improvement | Establish before changes |
| Too many metrics | Analysis paralysis | Focus on 3-5 key metrics |
| Ignoring segments | Hidden insights | Always segment data |
| Short test duration | Invalid results | Wait for significance |

## Checklist

### Metric Definition
- [ ] Clear definition documented
- [ ] Data source identified
- [ ] Baseline established
- [ ] Target set

### Analysis
- [ ] Statistical validity checked
- [ ] Segments analyzed
- [ ] Trends identified
- [ ] Actionable insights extracted

### Reporting
- [ ] Visualizations clear
- [ ] Context provided
- [ ] Recommendations included

## Integration

### Works With
- backlog-strategist (prioritization data)
- requirements-engineer (success criteria)
- acceptance-tester (quality metrics)

### Output
- Metrics definitions
- Dashboard specifications
- A/B test plans
- Analysis reports
