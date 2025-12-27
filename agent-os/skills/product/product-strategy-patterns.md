---
name: Product Strategy Patterns
description: Apply proven frameworks for product definition and strategy development
triggers:
  - task_mentions: "product strategy|product brief|persona|value proposition|product definition"
  - file_contains: "product-brief|target-audience|value-proposition"
---

# Product Strategy Patterns

Apply systematic frameworks for defining products, developing personas, framing problems, and prioritizing features.

## 1. Product Definition Frameworks

### Jobs-to-be-Done (JTBD) Framework

**Core Concept**: People 'hire' products to get a job done.

**Job Statement Formula**:
```
When [situation], I want to [motivation], so I can [expected outcome].
```

**Example**:
- When I'm running late for a meeting, I want to quickly order a coffee, so I can get caffeine without losing time.

**Application Checklist**:
- [ ] Identify the job to be done (functional, emotional, social)
- [ ] Describe the situation/context
- [ ] Articulate the desired outcome
- [ ] Identify current solutions (competitors)
- [ ] Find unmet needs in current solutions

### Value Proposition Canvas

**Customer Profile**:
- **Jobs**: Tasks customers want to accomplish
- **Pains**: Negative outcomes, risks, obstacles
- **Gains**: Positive outcomes, benefits desired

**Value Map**:
- **Products & Services**: What you offer
- **Pain Relievers**: How you eliminate pains
- **Gain Creators**: How you create gains

**Fit Assessment**:
```
Strong Fit = Pain Relievers address top 3 pains
           + Gain Creators deliver top 3 gains
           + Product helps complete essential jobs
```

**Example**:
```
Customer Pain: "Invoicing takes 2 hours per week"
Pain Reliever: "Generate invoices in 60 seconds from time tracking"
Product Feature: "1-click invoice from timesheet"
```

### Lean Canvas (1-Page Business Model)

**9 Building Blocks**:
1. **Problem**: Top 3 problems
2. **Solution**: Top 3 features
3. **Unique Value Proposition**: Single, clear message
4. **Unfair Advantage**: Can't be easily copied
5. **Customer Segments**: Target users
6. **Key Metrics**: Measurable indicators
7. **Channels**: Path to customers
8. **Cost Structure**: Fixed and variable costs
9. **Revenue Streams**: How you make money

**Usage**: Fill out in 20 minutes, iterate weekly.

## 2. Persona Development Methodologies

### B2B Persona Template

**Demographics**:
- Job Title: [e.g., Marketing Manager]
- Industry: [e.g., SaaS, E-commerce]
- Company Size: [e.g., 10-50 employees]
- Department: [e.g., Marketing, Sales]
- Seniority: [e.g., Manager, Director, VP]

**Firmographics**:
- Company Revenue: [e.g., €1M-€10M]
- Company Growth Stage: [e.g., Startup, Scale-up, Enterprise]
- Technology Stack: [e.g., HubSpot, Salesforce]
- Budget Authority: [e.g., <€5k: Self, >€5k: VP approval]

**Psychographics**:
- **Goals**: What are they trying to achieve? (e.g., Increase lead generation by 50%)
- **Challenges**: What blocks them? (e.g., Limited marketing budget, small team)
- **Motivations**: What drives decisions? (e.g., Career advancement, efficiency)
- **Fears**: What do they worry about? (e.g., Making wrong investment, looking incompetent)

**Behavioral Patterns**:
- Information Sources: [e.g., LinkedIn, industry blogs, peer recommendations]
- Buying Process: [e.g., Research → Demo → Trial → Manager Approval]
- Decision Criteria: [e.g., ROI, ease of use, integration capability]

**Example B2B Persona**:
```
Name: Marketing Manager Maria
Company: 20-person SaaS startup
Goal: Generate 100 qualified leads/month with 2-person team
Pain: Too much time on manual reporting (10h/week)
Budget: €500/month for tools (self-serve)
Decision: Tries free trial → Shows results to VP → Buys if clear ROI
```

### B2C Persona Template

**Demographics**:
- Age Range: [e.g., 25-40]
- Gender: [e.g., All, Female-focused]
- Location: [e.g., Urban Germany]
- Education: [e.g., University degree]
- Income: [e.g., €40k-€70k/year]
- Family Status: [e.g., Single, Married with kids]

**Psychographics**:
- **Lifestyle**: How do they live? (e.g., Busy professional, fitness-focused)
- **Values**: What matters to them? (e.g., Sustainability, convenience)
- **Interests**: What do they care about? (e.g., Travel, technology, cooking)
- **Personality**: How do they behave? (e.g., Early adopter, skeptical, brand-loyal)

**Behavioral Patterns**:
- **Shopping Habits**: Where do they buy? (e.g., Online-first, compares prices)
- **Media Consumption**: What do they read/watch? (e.g., Instagram, podcasts)
- **Tech Savviness**: Comfort with technology (e.g., High, uses 5+ apps daily)

**Example B2C Persona**:
```
Name: Freelance Felix
Age: 32, Male
Lifestyle: Solo creative professional (graphic designer)
Pain: Forgets to invoice clients, loses €500/month
Tech: Uses 10+ tools, loves automation
Budget: Pays €15/month for tools that save time
Discovery: Finds products via Twitter, YouTube reviews
```

### Persona Validation Checklist

- [ ] Based on real data (interviews, surveys, analytics)?
- [ ] Specific enough to design for (not "everyone")?
- [ ] Includes actual quotes from target users?
- [ ] Identifies primary pain points (top 3)?
- [ ] Describes current solutions they use?
- [ ] Outlines decision-making process?
- [ ] Quantifies impact (time saved, money saved, revenue gained)?

## 3. Problem Framing Techniques

### Problem Statement Formula

**Template**:
```
[Target Persona] needs [solution/improvement]
because [current situation causes pain]
which results in [negative outcome].
```

**Example**:
```
Freelance designers need automated invoicing
because manual invoice creation takes 2 hours per week
which results in €500 lost income monthly and client payment delays.
```

### Pain Point Severity Assessment

**Scoring Matrix** (1-5 scale for each):

| Criterion | Score | Description |
|-----------|-------|-------------|
| **Frequency** | 1-5 | How often does this problem occur? (1=Yearly, 5=Daily) |
| **Impact** | 1-5 | How painful when it happens? (1=Minor annoyance, 5=Critical blocker) |
| **Willingness to Pay** | 1-5 | Would they pay to solve it? (1=No, 5=Yes, urgently) |

**Total Score**: Frequency × Impact × Willingness = Priority Score (max 125)

**Priority Levels**:
- 75-125: **Critical** - Must solve immediately
- 40-74: **Important** - Solve soon
- 15-39: **Nice to have** - Solve if easy
- <15: **Low priority** - Ignore for MVP

**Example**:
```
Problem: Manual invoice creation
Frequency: 5 (weekly)
Impact: 4 (wastes 2 hours, delays payment)
Willingness: 4 (would pay €20/month)
Score: 5 × 4 × 4 = 80 (Critical)
```

### Problem Frequency and Impact Grid

```
High Impact
    ^
    |  Nice       | FOCUS HERE
    |  to Have    | (solve first)
    |-------------|-------------
    |  Ignore     | Quick Wins
    |             | (solve if easy)
    |
    +--------------------------> High Frequency
```

**FOCUS**: High frequency + High impact = MVP features

## 4. Feature Prioritization Methods

### MoSCoW Method

**Categories**:
- **Must Have**: Non-negotiable, product fails without it
- **Should Have**: Important, but product works without it
- **Could Have**: Nice to have, adds value
- **Won't Have**: Out of scope for this version

**Application**:
1. List all feature ideas
2. Categorize each feature
3. Build MVP with Must Haves only
4. Add Should Haves in v1.1
5. Consider Could Haves for v2.0

**Example**:
```
Must Have:
- Create invoice from time entries
- Send invoice via email

Should Have:
- Invoice templates
- Payment reminders

Could Have:
- Multi-currency support
- Invoice analytics

Won't Have (now):
- Expense tracking
- Tax filing automation
```

### RICE Scoring

**Formula**: RICE Score = (Reach × Impact × Confidence) / Effort

**Components**:
- **Reach**: How many users per quarter? (number)
- **Impact**: How much impact per user? (3=Massive, 2=High, 1=Medium, 0.5=Low, 0.25=Minimal)
- **Confidence**: How confident in estimates? (100%=High, 80%=Medium, 50%=Low)
- **Effort**: Person-months to build (number)

**Example**:
```
Feature: Auto-invoice from timesheet
Reach: 1000 users/quarter
Impact: 3 (Massive - saves 2h/week)
Confidence: 100% (validated with users)
Effort: 1 person-month
RICE: (1000 × 3 × 1.0) / 1 = 3000

Feature: Multi-currency
Reach: 100 users/quarter
Impact: 2 (High for those who need it)
Confidence: 50% (not validated)
Effort: 2 person-months
RICE: (100 × 2 × 0.5) / 2 = 50

→ Prioritize auto-invoice (3000 >> 50)
```

### Kano Model

**Categories**:
- **Basic Needs**: Expected, absence causes dissatisfaction (e.g., app doesn't crash)
- **Performance Needs**: More is better (e.g., faster invoice generation)
- **Delighters**: Unexpected, create satisfaction (e.g., automatic thank you note)

**Strategy**:
1. Ensure all Basic Needs are met (table stakes)
2. Compete on Performance Needs (differentiation)
3. Add 1-2 Delighters (wow factor)

## 5. Effective Q&A Techniques

### Open-Ended Question Formulation

**Good Question Patterns**:
- "How do you currently [do task]?"
- "What's the biggest challenge with [problem area]?"
- "Walk me through the last time you [experienced problem]."
- "What would make [task] easier for you?"
- "Why is [outcome] important to you?"

**Avoid**:
- ❌ "Would you use a feature that does X?" (Leading question)
- ❌ "Do you like this idea?" (Yes/no question)
- ✅ "How would you use a feature that does X?" (Open-ended)

### The 5 Whys Technique

**Process**: Ask "Why?" five times to find root cause.

**Example**:
```
Problem: Freelancers don't invoice on time
Why? → Forgot to send invoice
Why? → No reminder system
Why? → Busy with client work
Why? → Manual invoicing takes too long
Why? → Current tools are complicated
Root Cause: Need simple, automated invoicing
```

### Follow-Up Question Strategies

**Triggers for Follow-Ups**:
1. **Vague Answer**: "Can you give me a specific example?"
2. **Interesting Detail**: "Tell me more about that."
3. **Unexpected Behavior**: "Why did you do it that way?"
4. **Workaround Mentioned**: "How often do you need to do that?"
5. **Strong Emotion**: "What makes that so frustrating?"

**Deep Dive Template**:
```
Initial: "How do you create invoices?"
→ Answer: "I use a Word template."
Follow-up: "Walk me through the last invoice you created."
→ Answer: "I copied last month's, changed dates, forgot to update amount."
Follow-up: "What happened when the amount was wrong?"
→ Answer: "Client emailed, I sent corrected invoice, delayed payment by 2 weeks."
Follow-up: "How often does this happen?"
→ Answer: "Maybe 1 in 5 invoices."
Insight: Error-prone process → Need validation/auto-fill
```

### Assumption Testing Questions

**Framework**: "We assume [assumption]. Is that correct?"

**Examples**:
- "We assume freelancers invoice weekly. How often do you actually invoice?"
- "We assume time tracking is the main input. What else goes on an invoice?"
- "We assume clients prefer PDF invoices. What format do your clients want?"

### Question Synthesis for Product Brief

**Ask Across 5 Dimensions**:

1. **Target Audience**:
   - "Who specifically is this for?"
   - "What's their job title / industry / company size?"
   - "What tools do they use daily?"

2. **Core Problem**:
   - "What's the specific problem this solves?"
   - "How often does this problem occur?"
   - "What's it costing them (time, money, stress)?"

3. **Solution Approach**:
   - "How does this solve the problem?"
   - "What are the 3-5 key features?"
   - "How is this different from [competitor]?"

4. **Value Proposition**:
   - "Why is this better than current alternatives?"
   - "What's the main benefit in one sentence?"
   - "What would convince someone to switch?"

5. **Success Metrics**:
   - "What would success look like for users?"
   - "How would we measure if this is working?"
   - "What outcome matters most?"

## Application Checklist

When sharpening a product idea:

- [ ] Applied JTBD framework to identify core job
- [ ] Created detailed persona (B2B or B2C)
- [ ] Validated persona with real user data
- [ ] Framed problem with severity scoring
- [ ] Prioritized features with MoSCoW or RICE
- [ ] Prepared 5-10 strategic questions for user
- [ ] Tested assumptions with follow-up questions
- [ ] Synthesized answers into clear product brief

## Common Pitfalls to Avoid

❌ **Too Broad**: "A tool for everyone" → ✅ "For freelance creatives with no accounting knowledge"
❌ **Solution-First**: "An app with AI" → ✅ "Eliminates 2h/week of manual invoice work"
❌ **Feature List**: "Has 20 features" → ✅ "Solves late payments by automating reminders"
❌ **Vague Problem**: "Invoicing is hard" → ✅ "Freelancers lose €500/month from forgotten invoices"
❌ **No Validation**: "I think users want..." → ✅ "5 users confirmed they'd pay €20/month"

## Examples of Well-Defined Products

**Example 1 - B2B SaaS**:
```
Target: Marketing managers at 10-50 person SaaS companies
Problem: Spend 10h/week creating marketing reports manually
Solution: Auto-generate reports from connected tools (Google Analytics, HubSpot)
Value Prop: "From data to report in 60 seconds"
Success Metric: Reduce reporting time from 10h to 1h per week
```

**Example 2 - B2C App**:
```
Target: Busy parents (30-45, 2+ kids, dual income)
Problem: Forget to buy groceries, last-minute expensive takeout (€200/month waste)
Solution: AI meal planner + auto-generated shopping list based on family preferences
Value Prop: "Never forget groceries, save €200/month"
Success Metric: 80% of meals cooked at home (up from 50%)
```

---

**Use this skill when**: Sharpening vague product ideas, creating product briefs, developing user personas, or prioritizing features.
