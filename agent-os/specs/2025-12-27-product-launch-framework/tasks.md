# Implementation Tasks: Market Validation System

> Spec: Product Launch Framework - Phase A
> Created: 2025-12-27 (Updated with product-strategist + web-developer)
> Total Estimated Effort: 26-32 hours

## Task Overview

| Category | Tasks | Estimated Effort |
|----------|-------|------------------|
| 1. Skills Creation | 6 skills | 6-7h |
| 2. Template Creation | 7 templates | 2.5-3.5h |
| 3. Specialist Agents | 7 agents | 6-7h |
| 4. Workflow Implementation | 1 workflow | 6-8h |
| 5. Command & Config | 2 files | 2h |
| 6. Setup Scripts | 2 scripts | 1-2h |
| 7. Documentation | 2 docs | 2-3h |
| 8. Testing & Verification | All components | 2h |

## Category 1: Skills Creation (6-7h total)

### Task 1.0: Create product-strategy-patterns.md (NEW)
**Effort**: 1-1.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/product/product-strategy-patterns.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: Product Strategy Patterns
  description: Apply proven frameworks for product definition and strategy development
  triggers:
    - task_mentions: "product strategy|product brief|persona|value proposition|product definition"
    - file_contains: "product-brief|target-audience|value-proposition"
  ---
  ```

- Content sections:
  - Product Definition Frameworks
    - Jobs-to-be-Done framework
    - Value Proposition Canvas
    - Lean Canvas
  - Persona Development Methodologies
    - User persona template
    - B2B persona (firmographics + demographics)
    - B2C persona (demographics + psychographics)
  - Problem Framing Techniques
    - Problem statement formula
    - Pain point severity assessment
    - Problem frequency and impact
  - Feature Prioritization Methods
    - MoSCoW (Must have, Should have, Could have, Won't have)
    - RICE (Reach, Impact, Confidence, Effort)
    - Kano Model
  - Effective Q&A Techniques
    - Open-ended question formulation
    - Follow-up question strategies
    - Assumption testing

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete with examples
- [ ] Value Proposition Canvas template included
- [ ] Persona development guide with examples
- [ ] File saved in `agent-os/skills/product/`

---

## Category 1 (continued): Skills Creation (6-7h total)

### Task 1.1: Create market-research-best-practices.md
**Effort**: 1-1.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/business/market-research-best-practices.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: Market Research Best Practices
  description: Apply systematic frameworks for competitive analysis and market sizing
  triggers:
    - task_mentions: "market research|competitor analysis|market validation|competitive intelligence"
    - file_contains: "competitor-analysis|market-positioning"
  ---
  ```

- Content sections:
  - Competitive Analysis Frameworks
    - Porter's Five Forces
    - SWOT Analysis
    - Feature comparison matrices
  - Market Sizing Methodologies
    - TAM, SAM, SOM calculation
    - Top-down vs bottom-up approaches
  - Positioning Strategies
    - Differentiation strategies
    - Niche identification
    - Value proposition design
  - Research Sources and Methods
    - Primary research (surveys, interviews)
    - Secondary research (reports, databases)
    - Competitive intelligence tools
  - Data Validation Techniques
    - Triangulation
    - Source credibility assessment

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete with examples
- [ ] Minimum 2 examples per framework/methodology
- [ ] Checklist format for easy application
- [ ] File saved in `agent-os/skills/business/`

---

### Task 1.2: Create business-analysis-methods.md
**Effort**: 1-1.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/business/business-analysis-methods.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: Business Analysis Methods
  description: Apply data-driven decision frameworks and metrics analysis
  triggers:
    - task_mentions: "business analysis|metrics|data analysis|go-no-go decision|kpi"
    - file_contains: "validation-results|decision-matrix"
  ---
  ```

- Content sections:
  - Metrics Analysis
    - Conversion rate calculation and benchmarks
    - CPA (Cost Per Acquisition) optimization
    - CAC (Customer Acquisition Cost)
    - LTV (Lifetime Value) estimation
    - ROI calculation
  - Decision Frameworks
    - Decision matrix (weighted scoring)
    - GO/NO-GO criteria setting
    - Risk-reward assessment
  - Data Visualization Best Practices
    - Chart selection (line, bar, pie)
    - Dashboard design principles
  - Statistical Significance Testing
    - Sample size calculation
    - Confidence intervals
    - A/B test validation
  - Qualitative Feedback Analysis
    - Thematic coding
    - Sentiment analysis
    - Insight extraction

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete
- [ ] Formulas included for metrics calculations
- [ ] Decision matrix template provided
- [ ] Examples for each analysis method

---

### Task 1.3: Create validation-strategies.md
**Effort**: 1-1.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/business/validation-strategies.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: Validation Strategies
  description: Apply landing page best practices and conversion optimization techniques
  triggers:
    - task_mentions: "validation|landing page|conversion optimization|cro|a/b test"
    - file_contains: "landing-page|validation-plan"
  ---
  ```

- Content sections:
  - Landing Page Best Practices
    - Hero section design (headline, subheadline, CTA)
    - Above-the-fold optimization
    - Social proof placement (testimonials, logos, stats)
    - Trust signals (security badges, guarantees)
  - Conversion Rate Optimization (CRO)
    - CTA button optimization (color, text, placement)
    - Form design best practices (field reduction, inline validation)
    - Page speed optimization
    - Mobile optimization
  - A/B Testing Methodologies
    - Hypothesis formulation
    - Test design (control vs variant)
    - Sample size determination
    - Statistical significance
  - Analytics Setup
    - Google Analytics 4 configuration
    - Conversion goal setup
    - Event tracking implementation
    - Funnel visualization
  - Campaign Optimization Strategies
    - Bid optimization
    - Targeting refinement
    - Ad creative iteration
    - Budget allocation

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete
- [ ] Landing page checklist included
- [ ] CRO best practices with before/after examples
- [ ] Analytics setup step-by-step guide

---

### Task 1.4: Create content-writing-best-practices.md
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/marketing/content-writing-best-practices.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: Content Writing Best Practices
  description: Apply proven copywriting formulas and persuasion techniques
  triggers:
    - task_mentions: "copywriting|content creation|ad copy|landing page copy|headline"
    - file_contains: "ad-campaigns|landing-page"
  ---
  ```

- Content sections:
  - Copywriting Formulas
    - AIDA (Attention, Interest, Desire, Action)
    - PAS (Problem, Agitate, Solution)
    - Before-After-Bridge
    - FAB (Features, Advantages, Benefits)
  - Value Proposition Design
    - Unique value identification
    - Target audience alignment
    - Differentiation articulation
  - Call-to-Action Optimization
    - Action verb usage (Get, Start, Join, Discover)
    - Urgency creation (limited time, scarcity)
    - Specificity (avoid vague CTAs)
    - Button text best practices
  - Headline Writing Techniques
    - Benefit-driven headlines
    - Curiosity-driven headlines
    - Number-based headlines (listicles)
    - Question headlines
  - Ad Copy Structure
    - Hook (grab attention in first 3 words)
    - Body (expand on benefit, address objection)
    - CTA (clear next step)
    - Character limits (Google: 30/90, Meta: 125)

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete
- [ ] 3+ examples per copywriting formula
- [ ] Headline templates provided
- [ ] Ad copy templates for Google + Meta

---

### Task 1.5: Create seo-optimization-patterns.md
**Effort**: 1h
**Priority**: MEDIUM
**Dependencies**: None

**Location**: `agent-os/skills/marketing/seo-optimization-patterns.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: SEO Optimization Patterns
  description: Apply on-page SEO best practices for search visibility and rankings
  triggers:
    - task_mentions: "seo|search engine optimization|meta tags|keywords"
    - file_contains: "landing-page|<meta"
  ---
  ```

- Content sections:
  - On-Page SEO Checklist
    - Title tag optimization (length: 50-60 chars)
    - Meta description (150-160 chars)
    - H1-H6 heading hierarchy
    - Alt text for images
    - Schema markup (JSON-LD)
  - Keyword Research Process
    - Keyword research tools (Google Keyword Planner, Ubersuggest)
    - Search intent identification (informational, navigational, transactional)
    - Long-tail keyword targeting
    - Keyword difficulty assessment
  - Meta Tag Optimization
    - Title tag best practices (keyword placement, brand inclusion)
    - Description tag persuasion (include CTA)
    - Open Graph tags (og:title, og:description, og:image)
    - Twitter Card tags
  - Technical SEO Basics
    - Responsive design (mobile-first indexing)
    - Page speed optimization (<3 seconds)
    - Semantic HTML (header, nav, main, article, footer)
    - Clean URL structure
  - Content Optimization
    - Keyword density (1-2% natural usage)
    - Readability (Flesch Reading Ease score)
    - Internal linking strategy
    - Content-length guidelines (1000+ words for blog, concise for landing pages)

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete
- [ ] Meta tag templates provided
- [ ] Technical SEO checklist included
- [ ] Keyword research workflow documented

---

## Category 2: Template Creation (2-3h total)

### Task 2.1: Create competitor-analysis.md template
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/market-validation/competitor-analysis.md`

**Deliverables**:
- Frontmatter metadata section
- Executive Summary section (placeholder)
- Competitors Identified section
  - Direct Competitors table (5-7 rows)
  - Indirect Competitors table (3-5 rows)
- Feature Comparison Matrix (expandable columns)
- Market Gaps Identified (3-5 gaps)
- Pricing Analysis section
- Market Insights section
- Sources section

**Acceptance Criteria**:
- [ ] All placeholder sections with `[VARIABLE_NAME]` format
- [ ] Tables formatted correctly
- [ ] Example entries provided for guidance
- [ ] Markdown formatting valid

---

### Task 2.2: Create market-positioning.md template
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/market-validation/market-positioning.md`

**Deliverables**:
- Target Audience section (primary + secondary segments)
- Unique Value Proposition section
- Positioning Statement template
- Competitive Positioning Map (ASCII art)
- Messaging Pillars (3 pillars)
- Go-to-Market Strategy section

**Acceptance Criteria**:
- [ ] Positioning statement template follows formula
- [ ] Positioning map visualization included
- [ ] All sections have placeholder guidance
- [ ] Examples provided

---

### Task 2.3: Create validation-plan.md template
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/market-validation/validation-plan.md`

**Deliverables**:
- Validation Objectives section
- Timeline table (4 weeks)
- Budget Allocation table
- Landing Page Strategy section
- Ad Campaign Strategy (Google Ads + Meta Ads)
- Analytics Setup section
- Risk Mitigation table
- Decision Criteria section (GO/MAYBE/NO-GO thresholds)

**Acceptance Criteria**:
- [ ] All tables formatted correctly
- [ ] Configurable threshold placeholders
- [ ] 2-4 week timeline default
- [ ] Risk mitigation strategies included

---

### Task 2.4: Create ad-campaigns.md template
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/market-validation/ad-campaigns.md`

**Deliverables**:
- Google Ads section
  - Campaign structure (search + display)
  - 7-10 ad copy variants
  - Keyword list
  - Targeting specs
  - Budget recommendations
  - Setup instructions (step-by-step)
- Meta Ads section
  - Campaign structure (Facebook + Instagram)
  - 5-7 ad copy variants
  - Audience targeting (demographics, interests)
  - Creative specifications
  - Budget recommendations
  - Setup instructions (step-by-step)

**Acceptance Criteria**:
- [ ] Ad copy placeholders with character limits
- [ ] Targeting specs comprehensive
- [ ] Setup instructions actionable
- [ ] Examples for ad variants

---

### Task 2.5: Create analytics-setup.md template
**Effort**: 20 min
**Priority**: MEDIUM
**Dependencies**: None

**Location**: `agent-os/templates/market-validation/analytics-setup.md`

**Deliverables**:
- Google Analytics 4 Setup section
  - Property creation steps
  - Data stream configuration
  - Tracking code installation
- Conversion Goals section
  - Goal types (destination, event, duration)
  - Goal setup instructions
- Event Tracking section
  - Event parameters
  - Custom event code examples
  - Common events (button_click, form_submit, email_signup)
- Heatmap Tool Setup section
  - Tool recommendations (Hotjar, Microsoft Clarity)
  - Installation instructions
- Dashboard Design section
  - Key metrics to track
  - Dashboard template

**Acceptance Criteria**:
- [ ] GA4 setup step-by-step
- [ ] Event tracking code examples included
- [ ] Heatmap tool comparison provided
- [ ] Dashboard metrics defined

---

### Task 2.6: Create validation-results.md template
**Effort**: 20 min
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/market-validation/validation-results.md`

**Deliverables**:
- Campaign Summary section
- Metrics Analysis section
  - Conversion rate calculation
  - CPA calculation
  - TAM estimation
- Decision Matrix section
  - Criteria evaluation table
  - Threshold comparison
- GO/NO-GO Recommendation section
  - Decision statement
  - Confidence level
  - Supporting data
- Product Refinement Recommendations section (if GO)
  - Feature prioritization based on feedback
  - Target segment focus
- Alternative Approaches section (if NO-GO)
  - Pivot suggestions
  - Re-test recommendations

**Acceptance Criteria**:
- [ ] Decision matrix formula documented
- [ ] All three criteria (conversion, CPA, TAM) included
- [ ] Recommendation format clear
- [ ] Confidence level scale defined

---

## Category 3: Specialist Agents (6-7h total)

### Task 3.0: Create product-strategist.md agent (NEW)
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: Task 1.0 (product-strategy-patterns skill)

**Location**: `.claude/agents/product-strategist.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: product-strategist
  description: Product strategy specialist for sharpening vague ideas into clear product briefs
  tools: Read, Write
  color: purple
  ---
  ```

- Core Responsibilities section
  - Analyze initial (potentially vague) product idea
  - Identify gaps in product definition
  - Ask structured questions via AskUserQuestion tool
  - Synthesize answers into sharp product brief
  - Generate product-brief.md

- Workflow section
  - Step 1: Receive initial product idea from user
  - Step 2: Analyze idea for completeness
  - Step 3: Formulate 5 strategic questions (Target Audience, Core Problem, Solution, Value Prop, Success Metrics)
  - Step 4: Use AskUserQuestion tool for interactive Q&A
  - Step 5: Apply product-strategy-patterns skill
  - Step 6: Generate product-brief.md from template
  - Step 7: Provide sharp product brief to market-researcher

- Q&A Strategy section
  - Question formulation techniques
  - Follow-up question triggers
  - Answer synthesis methods

- Output Format section (markdown template for product brief)
- Important Constraints section

**Acceptance Criteria**:
- [ ] Frontmatter complete with all required fields
- [ ] All sections documented clearly
- [ ] AskUserQuestion integration explained
- [ ] Q&A strategy documented
- [ ] Output format defined

---

### Task 3.1: Create market-researcher.md agent
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: Task 1.1 (market-research-best-practices skill), Task 3.0 (product-strategist)

**Location**: `.claude/agents/market-researcher.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: market-researcher
  description: Market research specialist using Perplexity MCP and WebSearch for competitive intelligence
  tools: Read, Write, Grep, Glob, Bash
  color: cyan
  ---
  ```

- Core Responsibilities section
  - Use Perplexity MCP to identify 5-10 competitors
  - Use WebSearch to gather detailed competitor information
  - Generate competitor-analysis.md with feature comparison matrix
  - Identify market gaps and opportunities
  - Create market-positioning.md with positioning recommendations

- Workflow section
  - Step 1: Receive product idea description
  - Step 2: Use Perplexity deep research for competitor identification
  - Step 3: Use WebSearch for specific competitor details
  - Step 4: Apply market-research-best-practices skill
  - Step 5: Generate competitor-analysis.md from template
  - Step 6: Generate market-positioning.md from template
  - Step 7: Provide handoff summary

- Output Format section (markdown template for handoff)
- Important Constraints section
  - Perplexity rate limits
  - Manual fallback process
  - Minimum 5 competitors required

**Acceptance Criteria**:
- [ ] Frontmatter complete with all required fields
- [ ] All sections documented clearly
- [ ] Perplexity MCP integration documented
- [ ] WebSearch usage explained
- [ ] Handoff format defined

---

### Task 3.5: Create web-developer.md agent (NEW)
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: Task 1.3 (validation-strategies skill), Task 3.3 (content-creator), Task 3.4 (seo-specialist)

**Location**: `.claude/agents/web-developer.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: web-developer
  description: Web development specialist for production-ready landing page creation
  tools: Read, Write, Edit
  color: blue
  ---
  ```

- Core Responsibilities section
  - Generate production-ready HTML/CSS/JS landing page
  - Integrate copy from content-creator
  - Implement SEO optimizations from seo-specialist
  - Ensure responsive design (mobile, tablet, desktop)
  - Optimize performance (<3 sec load time)
  - Implement email collection form with validation
  - Add privacy policy and GDPR compliance elements
  - Create single self-contained index.html file
  - Provide deployment instructions

- Workflow section
  - Step 1: Receive product brief and positioning
  - Step 2: Receive copy from content-creator
  - Step 3: Receive SEO specs from seo-specialist
  - Step 4: Apply validation-strategies skill (CRO best practices)
  - Step 5: Generate HTML structure (semantic markup)
  - Step 6: Implement responsive CSS (mobile-first)
  - Step 7: Add JavaScript (form validation, tracking)
  - Step 8: Integrate copy and SEO elements
  - Step 9: Performance optimization
  - Step 10: Generate deployment instructions

- Landing Page Technical Spec section
  - HTML5 semantic markup
  - CSS3 responsive design (Flexbox/Grid)
  - Vanilla JavaScript (ES6+)
  - Self-contained (no external dependencies)
  - Performance requirements (<3 sec load, <30KB total)

- Output Format section
- Important Constraints section

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] Landing page generation process documented
- [ ] Technical specs clearly defined
- [ ] Copy and SEO integration explained
- [ ] Deployment instructions included
- [ ] Performance targets specified

---

### Task 3.6: Create validation-specialist.md agent (UPDATED)
**Effort**: 45 min
**Priority**: HIGH
**Dependencies**: Task 1.3 (validation-strategies skill), Task 3.5 (web-developer)

**Location**: `.claude/agents/validation-specialist.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: validation-specialist
  description: Validation campaign coordinator for ad campaigns and analytics setup
  tools: Read, Write
  color: green
  ---
  ```

- Core Responsibilities section
  - Create ad campaign plans for Google Ads and Meta Ads
  - Provide analytics setup instructions (GA4, conversion tracking)
  - Create comprehensive validation plan (timeline, budget, success criteria)
  - Coordinate validation campaign execution guidance
  - Integration with landing page from web-developer

- Workflow section
  - Step 1: Receive product brief and landing page
  - Step 2: Apply validation-strategies skill
  - Step 3: Create Google Ads campaign plan
  - Step 4: Create Meta Ads campaign plan
  - Step 5: Generate analytics-setup.md (GA4 config)
  - Step 6: Generate validation-plan.md (timeline, budget, criteria)
  - Step 7: Provide campaign execution guidance

- Output Format section
- Important Constraints section

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] Ad campaign planning process documented
- [ ] Analytics setup process documented
- [ ] Validation plan structure defined
- [ ] Integration with web-developer explained

---

### Task 3.3: Create content-creator.md agent
**Effort**: 45 min
**Priority**: HIGH
**Dependencies**: Task 1.4 (content-writing-best-practices skill)

**Location**: `.claude/agents/content-creator.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: content-creator
  description: Copywriting specialist for landing pages and ad campaigns
  tools: Read, Write
  color: purple
  ---
  ```

- Core Responsibilities section
  - Write compelling landing page copy (headline, value prop, CTA)
  - Create 5-10 ad copy variants per platform
  - Apply copywriting formulas (AIDA, PAS)
  - Benefit-driven messaging
  - Integration with validation-specialist

- Workflow section
  - Step 1: Receive product positioning strategy
  - Step 2: Apply content-writing-best-practices skill
  - Step 3: Write landing page headline (benefit-driven)
  - Step 4: Write landing page value proposition
  - Step 5: Write CTA button text
  - Step 6: Create Google Ads copy variants (7-10)
  - Step 7: Create Meta Ads copy variants (5-7)
  - Step 8: Provide copy to validation-specialist

- Copywriting Formulas section (reference to skill)
- Output Format section
- Important Constraints section (character limits for ads)

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] Copywriting process documented
- [ ] Character limits for ads specified
- [ ] Integration with validation-specialist explained
- [ ] Output examples provided

---

### Task 3.4: Create seo-specialist.md agent
**Effort**: 45 min
**Priority**: MEDIUM
**Dependencies**: Task 1.5 (seo-optimization-patterns skill)

**Location**: `.claude/agents/seo-specialist.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: seo-specialist
  description: SEO optimization specialist for landing pages and content
  tools: Read, Write, Edit
  color: orange
  ---
  ```

- Core Responsibilities section
  - Optimize meta tags (title, description, OG tags)
  - Keyword research and integration
  - On-page SEO implementation
  - Technical SEO checklist
  - Integration with validation-specialist

- Workflow section
  - Step 1: Receive landing page copy from content-creator
  - Step 2: Apply seo-optimization-patterns skill
  - Step 3: Conduct keyword research for product
  - Step 4: Optimize title tag (50-60 chars)
  - Step 5: Optimize meta description (150-160 chars)
  - Step 6: Add Open Graph tags
  - Step 7: Integrate keywords into copy (natural, 1-2% density)
  - Step 8: Technical SEO checklist (responsive, semantic HTML)
  - Step 9: Provide optimized copy to validation-specialist

- SEO Checklist section
- Output Format section
- Important Constraints section

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] SEO optimization process documented
- [ ] Keyword research methodology explained
- [ ] Meta tag optimization guidelines provided
- [ ] Technical SEO checklist included

---

### Task 3.5: Create business-analyst.md agent
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: Task 1.2 (business-analysis-methods skill)

**Location**: `.claude/agents/business-analyst.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  name: business-analyst
  description: Business analysis specialist for metrics analysis and GO/NO-GO decisions
  tools: Read, Write, Bash
  color: blue
  ---
  ```

- Core Responsibilities section
  - Analyze validation metrics (conversion rate, CPA, TAM)
  - Calculate decision matrix based on thresholds
  - Provide GO/NO-GO recommendation with supporting data
  - Product refinement suggestions based on user feedback
  - Integration with plan-product workflow

- Workflow section
  - Step 1: Receive validation metrics from user
  - Step 2: Apply business-analysis-methods skill
  - Step 3: Calculate conversion rate
  - Step 4: Calculate CPA
  - Step 5: Estimate TAM from research data
  - Step 6: Evaluate against thresholds (from config or validation-plan)
  - Step 7: Generate decision matrix
  - Step 8: Formulate GO/NO-GO recommendation
  - Step 9: Provide product refinement suggestions (if GO)
  - Step 10: Generate validation-results.md from template

- Decision Matrix Calculation section
  ```
  IF conversion_rate >= threshold AND cpa <= threshold AND tam >= threshold:
    DECISION = GO
  ELIF (conversion_rate >= threshold*0.6) AND (cpa <= threshold*1.5):
    DECISION = MAYBE
  ELSE:
    DECISION = NO-GO
  ```

- Output Format section
- Important Constraints section

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] Metrics analysis process documented
- [ ] Decision matrix formula clearly defined
- [ ] GO/MAYBE/NO-GO criteria specified
- [ ] Product refinement process explained

---

## Category 4: Workflow Implementation (6-8h total)

### Task 4.1: Create validate-market.md workflow
**Effort**: 6-8h
**Priority**: CRITICAL
**Dependencies**: All agents (3.1-3.5), all templates (2.1-2.6)

**Location**: `agent-os/workflows/validation/validate-market.md`

**Deliverables**:
- Frontmatter:
  ```yaml
  ---
  description: Market Validation System for data-driven GO/NO-GO decisions
  globs:
  alwaysApply: false
  version: 2.0
  encoding: UTF-8
  ---
  ```

- Pre-flight check block
- Process flow with 10-12 steps:
  1. Context loading (context-fetcher)
  2. Product idea capture (user input)
  3. Date determination (date-checker)
  4. Workspace creation (file-creator)
  5. Competitive analysis (market-researcher)
  6. Copywriting (content-creator)
  7. SEO optimization (seo-specialist)
  8. Asset generation (validation-specialist)
  9. User deployment phase (pause for user action)
  10. Results analysis (business-analyst)
  11. Integration with planning (conditional)
  12. Version control (git-workflow, optional)

**Each step must include**:
- XML tags with subagent attribute (if delegating)
- Step description
- Conditional logic (if applicable)
- Input/output specifications
- Error handling

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] Pre-flight check included
- [ ] All 12 steps implemented with XML structure
- [ ] Subagent delegation uses Task tool
- [ ] Conditional logic for GO/NO-GO paths
- [ ] User pause mechanism for deployment phase
- [ ] Integration with plan-product documented
- [ ] Error handling for Perplexity failures
- [ ] File path conventions follow `@agent-os/` pattern

---

## Category 5: Command & Config (2h total)

### Task 5.1: Create validate-market.md command
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: Task 4.1 (workflow)

**Location**: `.claude/commands/agent-os/validate-market.md`

**Deliverables**:
- Command title and description
- Version note (Phase A)
- Reference to workflow: `@agent-os/workflows/validation/validate-market.md`
- Feature highlights (5-6 bullet points)
- Usage instructions
- Deliverables list
- Timeline estimate
- Cost estimate

**Acceptance Criteria**:
- [ ] Clear command description
- [ ] Correct workflow reference
- [ ] User-friendly usage instructions
- [ ] All deliverables listed
- [ ] Realistic timeline and cost estimates

---

### Task 5.2: Update agent-os/config.yml
**Effort**: 1.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/config.yml`

**Deliverables**:
- Add new `market_validation` section:
  ```yaml
  # Market validation configuration
  market_validation:
    enabled: true
    landing_page_tech: html_css_js
    ad_campaign_mode: planning_only
    research_methods:
      - perplexity_mcp
      - web_search
      - template_driven
    decision_criteria:
      conversion_rate_threshold: 5.0  # percent
      cpa_threshold: 10.0  # euros
      tam_threshold: 100000  # minimum addressable market
    deployment_platforms:
      - netlify
      - vercel
      - github_pages
  ```

- Update features section:
  ```yaml
  features:
    profile_system: true
    skills_system: true
    enhanced_research: true
    verification_system: true
    market_validation: true  # NEW
  ```

**Acceptance Criteria**:
- [ ] market_validation section added
- [ ] All configuration options documented
- [ ] Default values reasonable
- [ ] Features flag added
- [ ] YAML syntax valid

---

## Category 6: Setup Scripts (1-2h total)

### Task 6.1: Update setup.sh
**Effort**: 45 min
**Priority**: HIGH
**Dependencies**: All skills (1.1-1.5), all templates (2.1-2.6)

**Location**: `setup.sh`

**Modifications**:
- Create `agent-os/skills/business/` directory
- Create `agent-os/skills/marketing/` directory
- Create `agent-os/templates/market-validation/` directory
- Download 5 new skills from GitHub
- Download 6 new templates from GitHub
- Download validation workflow

**Code additions**:
```bash
# Download market validation skills
echo "Setting up market validation skills..."
mkdir -p agent-os/skills/business
mkdir -p agent-os/skills/marketing

download_file "$REPO_URL/agent-os/skills/business/market-research-best-practices.md" \
  "agent-os/skills/business/market-research-best-practices.md"
download_file "$REPO_URL/agent-os/skills/business/business-analysis-methods.md" \
  "agent-os/skills/business/business-analysis-methods.md"
download_file "$REPO_URL/agent-os/skills/business/validation-strategies.md" \
  "agent-os/skills/business/validation-strategies.md"
download_file "$REPO_URL/agent-os/skills/marketing/content-writing-best-practices.md" \
  "agent-os/skills/marketing/content-writing-best-practices.md"
download_file "$REPO_URL/agent-os/skills/marketing/seo-optimization-patterns.md" \
  "agent-os/skills/marketing/seo-optimization-patterns.md"

# Download market validation templates
echo "Setting up market validation templates..."
mkdir -p agent-os/templates/market-validation

download_file "$REPO_URL/agent-os/templates/market-validation/competitor-analysis.md" \
  "agent-os/templates/market-validation/competitor-analysis.md"
download_file "$REPO_URL/agent-os/templates/market-validation/market-positioning.md" \
  "agent-os/templates/market-validation/market-positioning.md"
download_file "$REPO_URL/agent-os/templates/market-validation/validation-plan.md" \
  "agent-os/templates/market-validation/validation-plan.md"
download_file "$REPO_URL/agent-os/templates/market-validation/ad-campaigns.md" \
  "agent-os/templates/market-validation/ad-campaigns.md"
download_file "$REPO_URL/agent-os/templates/market-validation/analytics-setup.md" \
  "agent-os/templates/market-validation/analytics-setup.md"
download_file "$REPO_URL/agent-os/templates/market-validation/validation-results.md" \
  "agent-os/templates/market-validation/validation-results.md"

# Download validation workflow
mkdir -p agent-os/workflows/validation
download_file "$REPO_URL/agent-os/workflows/validation/validate-market.md" \
  "agent-os/workflows/validation/validate-market.md"
```

**Acceptance Criteria**:
- [ ] Directory creation commands added
- [ ] All 5 skills downloaded
- [ ] All 6 templates downloaded
- [ ] Workflow downloaded
- [ ] Error handling for download failures

---

### Task 6.2: Update setup-claude-code.sh
**Effort**: 45 min
**Priority**: HIGH
**Dependencies**: All agents (3.1-3.5), command (5.1)

**Location**: `setup-claude-code.sh`

**Modifications**:
- Download 5 specialist agents to `.claude/agents/`
- Download validate-market command to `.claude/commands/agent-os/`
- Symlink new skills to `.claude/skills/business/` and `.claude/skills/marketing/`

**Code additions**:
```bash
# Download market validation specialist agents
echo "Setting up market validation specialists..."

download_file "$REPO_URL/.claude/agents/market-researcher.md" \
  ".claude/agents/market-researcher.md"
download_file "$REPO_URL/.claude/agents/validation-specialist.md" \
  ".claude/agents/validation-specialist.md"
download_file "$REPO_URL/.claude/agents/content-creator.md" \
  ".claude/agents/content-creator.md"
download_file "$REPO_URL/.claude/agents/seo-specialist.md" \
  ".claude/agents/seo-specialist.md"
download_file "$REPO_URL/.claude/agents/business-analyst.md" \
  ".claude/agents/business-analyst.md"

# Download validate-market command
download_file "$REPO_URL/.claude/commands/agent-os/validate-market.md" \
  ".claude/commands/agent-os/validate-market.md"

# Symlink market validation skills
if [ "$CREATE_SYMLINKS" = true ]; then
  echo "Creating symlinks for market validation skills..."
  mkdir -p .claude/skills/business
  mkdir -p .claude/skills/marketing

  ln -sf "$(pwd)/agent-os/skills/business/market-research-best-practices.md" \
    ".claude/skills/business/market-research-best-practices.md"
  ln -sf "$(pwd)/agent-os/skills/business/business-analysis-methods.md" \
    ".claude/skills/business/business-analysis-methods.md"
  ln -sf "$(pwd)/agent-os/skills/business/validation-strategies.md" \
    ".claude/skills/business/validation-strategies.md"
  ln -sf "$(pwd)/agent-os/skills/marketing/content-writing-best-practices.md" \
    ".claude/skills/marketing/content-writing-best-practices.md"
  ln -sf "$(pwd)/agent-os/skills/marketing/seo-optimization-patterns.md" \
    ".claude/skills/marketing/seo-optimization-patterns.md"
fi
```

**Acceptance Criteria**:
- [ ] All 5 agents downloaded
- [ ] Command file downloaded
- [ ] Skills symlinked correctly
- [ ] Directory creation for skills
- [ ] Conditional symlink creation based on flag

---

## Category 7: Documentation (2-3h total)

### Task 7.1: Update README.md
**Effort**: 1-1.5h
**Priority**: HIGH
**Dependencies**: All implementation tasks

**Location**: `README.md`

**Modifications**:
- Add "Market Validation System (Phase A)" section
- Document `/validate-market` command
- Provide quick start guide
- Link to comprehensive validation guide

**New content**:
```markdown
## Market Validation System (Phase A)

Validate market demand before expensive product development.

### Features
- Competitive analysis using Perplexity MCP
- Production-ready landing page generation (HTML/CSS/JS)
- Ad campaign planning (Google Ads, Meta Ads)
- Analytics setup guidance (Google Analytics 4)
- Data-driven GO/NO-GO decision

### Quick Start
```bash
# Run market validation
/validate-market "Your product idea description"

# Deploy landing page
cd agent-os/market-validation/YYYY-MM-DD-product-name/landing-page
netlify deploy --prod

# Run ad campaigns (2-4 weeks)
# Follow instructions in ad-campaigns.md

# Analyze results
# business-analyst provides GO/NO-GO in validation-results.md

# If GO, proceed with planning
/plan-product
```

### Deliverables
- competitor-analysis.md
- market-positioning.md
- landing-page/index.html
- ad-campaigns.md
- analytics-setup.md
- validation-results.md

For complete guide, see: [Market Validation Guide](agent-os/workflows/validation/README.md)
```

**Acceptance Criteria**:
- [ ] Section added to README.md
- [ ] Features clearly listed
- [ ] Quick start guide actionable
- [ ] Link to comprehensive guide included

---

### Task 7.2: Create agent-os/workflows/validation/README.md
**Effort**: 1-1.5h
**Priority**: HIGH
**Dependencies**: All implementation tasks

**Location**: `agent-os/workflows/validation/README.md`

**Deliverables**:
- Complete market validation guide (2000-3000 words)
- Sections:
  - Introduction (what is market validation?)
  - When to use market validation
  - How the validation system works
  - Step-by-step walkthrough
  - Example validation project
  - Troubleshooting common issues
  - Best practices for validation campaigns
  - FAQ

**Content outline**:
1. **Introduction**
   - Why validate before building
   - Cost savings (example: €50k saved)
   - Time savings (example: 6 months saved)

2. **When to Use**
   - New product ideas
   - Feature prioritization
   - Market expansion
   - Pivot decisions

3. **How It Works**
   - 5 specialist agents
   - Sequential workflow
   - Output artifacts
   - Timeline (2-4 weeks)

4. **Step-by-Step Walkthrough**
   - Step 1: Run /validate-market
   - Step 2: Review competitor analysis
   - Step 3: Deploy landing page
   - Step 4: Setup ad campaigns
   - Step 5: Configure analytics
   - Step 6: Monitor campaign (2-4 weeks)
   - Step 7: Provide metrics to business-analyst
   - Step 8: Receive GO/NO-GO decision
   - Step 9: Proceed with /plan-product (if GO)

5. **Example Validation Project**
   - Product idea: "AI-powered invoice automation for SMBs"
   - Competitors found: 8 (FreshBooks, Xero, QuickBooks, etc.)
   - Positioning: "Easiest invoice automation for non-accountants"
   - Landing page deployed: example.com
   - Ad campaigns: Google + Meta, €500 budget
   - Results: 6.2% conversion, €8.50 CPA, 250k TAM
   - Decision: GO

6. **Troubleshooting**
   - Perplexity rate limits → use manual research
   - Low landing page traffic → increase budget
   - High CPA → refine targeting
   - Low conversion rate → test new headlines

7. **Best Practices**
   - Budget recommendations (€500-2000)
   - Timeline (2-4 weeks minimum)
   - Traffic targets (1000+ visitors)
   - A/B testing (optional for MVP)

8. **FAQ**
   - How much does validation cost?
   - How long should I run campaigns?
   - What conversion rate is good?
   - Can I validate multiple ideas?

**Acceptance Criteria**:
- [ ] All 8 sections complete
- [ ] Example project walkthrough included
- [ ] Troubleshooting covers common issues
- [ ] FAQ answers key questions
- [ ] Well-formatted markdown with TOC

---

## Category 8: Testing & Verification (2h total)

### Task 8.1: Unit test specialist agents
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: All agents (3.1-3.5)

**Test cases**:
- [ ] market-researcher: Test Perplexity MCP integration (mock product idea)
- [ ] validation-specialist: Test landing page HTML generation (valid HTML?)
- [ ] content-creator: Test ad copy generation (character limits met?)
- [ ] seo-specialist: Test meta tag optimization (correct length?)
- [ ] business-analyst: Test decision matrix calculation (GO/MAYBE/NO-GO logic)

**Method**: Manual testing with example inputs

**Acceptance Criteria**:
- [ ] All 5 agents tested
- [ ] Outputs match expected formats
- [ ] Skills activate correctly
- [ ] Templates applied successfully

---

### Task 8.2: Integration test complete workflow
**Effort**: 1h
**Priority**: CRITICAL
**Dependencies**: Task 4.1 (workflow), all agents, all templates

**Test case**:
- Run `/validate-market "AI-powered email assistant for busy professionals"`
- Verify each step executes:
  1. Context loaded
  2. Product idea captured
  3. Date determined (YYYY-MM-DD)
  4. Workspace created in agent-os/market-validation/
  5. market-researcher produces competitor-analysis.md + market-positioning.md
  6. content-creator produces copy
  7. seo-specialist optimizes copy
  8. validation-specialist produces landing-page/index.html + ad-campaigns.md + analytics-setup.md
  9. Workflow pauses for user deployment
  10. (Mock metrics) business-analyst produces validation-results.md with GO/NO-GO

**Acceptance Criteria**:
- [ ] Workflow completes without errors
- [ ] All expected files created
- [ ] Files follow template structures
- [ ] Landing page HTML is valid and responsive
- [ ] Decision matrix calculation correct

---

### Task 8.3: Test landing page deployment
**Effort**: 20 min
**Priority**: HIGH
**Dependencies**: Task 4.1 (workflow)

**Test case**:
- Deploy generated landing page to Netlify
- Verify:
  - Page loads correctly (no errors)
  - Responsive on mobile, tablet, desktop
  - Form submission works (email validation)
  - Meta tags present (view source)
  - Page speed <3 seconds

**Acceptance Criteria**:
- [ ] Landing page deploys successfully
- [ ] All visual elements render correctly
- [ ] Form validation works
- [ ] SEO meta tags present
- [ ] Performance acceptable

---

### Task 8.4: Verify plan-product integration
**Effort**: 10 min
**Priority**: MEDIUM
**Dependencies**: Task 4.1 (workflow)

**Test case**:
- Run `/plan-product` after completing market validation
- Verify:
  - plan-product checks for validation results
  - validation-results.md loaded into context
  - Competitive insights inform product planning
  - Positioning strategy referenced

**Acceptance Criteria**:
- [ ] plan-product detects validation results
- [ ] Validation data incorporated into planning
- [ ] Recommendation to validate if missing

---

## Task Dependencies Diagram

```
Category 1 (Skills)
  ├── 1.1 market-research-best-practices ─┐
  ├── 1.2 business-analysis-methods ──────┼─► Category 3 (Agents)
  ├── 1.3 validation-strategies ──────────┤   ├── 3.1 market-researcher
  ├── 1.4 content-writing-best-practices ─┤   ├── 3.2 validation-specialist
  └── 1.5 seo-optimization-patterns ──────┘   ├── 3.3 content-creator
                                               ├── 3.4 seo-specialist
                                               └── 3.5 business-analyst
                                                     │
Category 2 (Templates)                               │
  ├── 2.1 competitor-analysis ───────────────────────┤
  ├── 2.2 market-positioning ────────────────────────┤
  ├── 2.3 validation-plan ───────────────────────────┼─► Category 4 (Workflow)
  ├── 2.4 ad-campaigns ──────────────────────────────┤   └── 4.1 validate-market.md
  ├── 2.5 analytics-setup ───────────────────────────┤         │
  └── 2.6 validation-results ────────────────────────┘         │
                                                                │
Category 5 (Command & Config)                                  │
  ├── 5.1 validate-market command ◄──────────────────────────┤
  └── 5.2 config.yml update                                   │
        │                                                      │
        │                                                      │
Category 6 (Setup Scripts) ◄───────────────────────────────────┤
  ├── 6.1 setup.sh (downloads skills, templates, workflow)    │
  └── 6.2 setup-claude-code.sh (downloads agents, command)    │
        │                                                      │
        │                                                      │
Category 7 (Documentation) ◄───────────────────────────────────┤
  ├── 7.1 README.md update                                     │
  └── 7.2 validation/README.md (complete guide)                │
        │                                                      │
        │                                                      │
Category 8 (Testing) ◄─────────────────────────────────────────┘
  ├── 8.1 Unit test agents
  ├── 8.2 Integration test workflow
  ├── 8.3 Test landing page deployment
  └── 8.4 Verify plan-product integration
```

## Recommended Implementation Order

**Week 1: Foundation (Skills + Templates)**
- Day 1-2: Tasks 1.1-1.5 (Skills)
- Day 3: Tasks 2.1-2.6 (Templates)

**Week 2: Agents + Workflow**
- Day 1-2: Tasks 3.1-3.5 (Specialist Agents)
- Day 3-5: Task 4.1 (Workflow - most complex)

**Week 3: Integration + Setup**
- Day 1: Tasks 5.1-5.2 (Command + Config)
- Day 2-3: Tasks 6.1-6.2 (Setup Scripts)

**Week 4: Documentation + Testing**
- Day 1-2: Tasks 7.1-7.2 (Documentation)
- Day 3: Tasks 8.1-8.4 (Testing)
- Day 4-5: Bug fixes, refinements, example project

## Success Criteria (Overall)

**Functional**:
- [ ] User can run `/validate-market` command
- [ ] All 5 specialist agents execute correctly
- [ ] All 6 output files generated from templates
- [ ] Landing page is production-ready (HTML valid, responsive)
- [ ] Ad campaigns include 5+ variants per platform
- [ ] GO/NO-GO decision is clear and data-driven

**Quality**:
- [ ] Skills activate automatically for relevant tasks
- [ ] Competitor analysis identifies 5-10 competitors
- [ ] Landing page loads in <3 seconds
- [ ] Ad copy meets character limits
- [ ] Metrics analysis uses correct formulas

**Integration**:
- [ ] plan-product checks for validation results
- [ ] Perplexity MCP integration works
- [ ] WebSearch fallback available
- [ ] config.yml properly configured

**Documentation**:
- [ ] README.md updated with validation section
- [ ] Complete validation guide written
- [ ] Example project documented
- [ ] Troubleshooting guide complete

---

**Total Tasks**: 27
**Estimated Effort**: 22-28 hours
**Recommended Timeline**: 4 weeks (part-time) or 1 week (full-time)

**Next Steps**: Begin with Category 1 (Skills Creation) as foundation for all agent expertise.
