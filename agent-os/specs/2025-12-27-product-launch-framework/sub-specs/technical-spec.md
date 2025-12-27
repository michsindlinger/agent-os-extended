# Technical Specification: Market Validation System

> Spec: Product Launch Framework - Phase A
> Created: 2025-12-27
> Parent Spec: @agent-os/specs/2025-12-27-product-launch-framework/spec.md

## Architecture Overview

The Market Validation System follows Agent OS Extended's established patterns:
- **Command Layer**: User-facing command file
- **Workflow Layer**: XML-based orchestration logic
- **Agent Layer**: Specialized subagents for execution
- **Skills Layer**: Context-aware expertise injection
- **Template Layer**: Structured output generation

```
User → /validate-market command
  ↓
agent-os/workflows/validation/validate-market.md (orchestrator)
  ↓
Delegates to 5 specialist agents sequentially:
  1. market-researcher (Perplexity MCP + WebSearch)
  2. content-creator (copywriting)
  3. seo-specialist (optimization)
  4. validation-specialist (landing page + ads + analytics)
  5. business-analyst (data analysis + GO/NO-GO)
  ↓
Outputs to agent-os/market-validation/YYYY-MM-DD-product-name/
```

## Reusable Components (From Codebase Analysis)

### 1. Workflow Patterns
**Source**: `agent-os/workflows/core/create-spec-v2.md`, `execute-tasks.md`

**Reuse**:
- ✅ XML-based `<process_flow>` container
- ✅ `<step number="N" subagent="agent-name">` delegation pattern
- ✅ `<conditional_logic>` blocks for branching
- ✅ `<pre_flight_check>` pattern
- ✅ Frontmatter structure (description, globs, version, encoding)
- ✅ `@agent-os/` file path convention

**Implementation**:
```xml
---
description: Market Validation System for data-driven GO/NO-GO decisions
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

<pre_flight_check>
  EXECUTE: @agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>
  <step number="1" subagent="context-fetcher" name="context_loading">
    Load mission-lite.md, tech-stack.md if not in context
  </step>

  <step number="2" subagent="market-researcher" name="competitive_analysis">
    ### Step 2: Competitive Analysis
    ...
  </step>
</process_flow>
```

### 2. Subagent System
**Source**: `.claude/agents/context-fetcher.md`, `file-creator.md`, `git-workflow.md`

**Reuse**:
- ✅ Frontmatter pattern (name, description, tools, color)
- ✅ Section structure (Responsibilities, Workflow, Output Format, Constraints)
- ✅ Tool allocation (Read, Write, Edit, Grep, Glob, Bash, LSP)
- ✅ Delegation via `Task(subagent_type="agent-name")`

**Existing Agents to Reuse**:
- `context-fetcher` - Load mission/tech-stack/standards
- `date-checker` - Determine current date for folder naming
- `file-creator` - Create directory structure + apply templates
- `git-workflow` - Commit validation artifacts, create PR if needed

### 3. Template System
**Source**: `agent-os/templates/research/`, `agent-os/templates/verification/`

**Reuse**:
- ✅ Structured sections with clear headings
- ✅ Placeholder format: `[VARIABLE_NAME]`
- ✅ Required vs Optional section markers
- ✅ Example content for guidance
- ✅ Frontmatter metadata

**Pattern**:
```markdown
# Template Name

> Created: [DATE]
> Product: [PRODUCT_NAME]

## Section 1: Required Information
[Placeholder for content]

## Section 2: Optional Details
[Placeholder for optional content]

## Examples
[Example content to guide user]
```

### 4. Skills System
**Source**: `agent-os/skills/base/`, `agent-os/skills/java/`, etc.

**Reuse**:
- ✅ Frontmatter trigger system
- ✅ Directory organization (base/, java/, react/, angular/)
- ✅ Symlink to `.claude/skills/` for Claude Code discovery
- ✅ Trigger types: task_mentions, file_extension, file_contains

**Pattern**:
```yaml
---
name: Skill Name
description: Brief description of what this skill provides
triggers:
  - task_mentions: "keyword1|keyword2|keyword3"
  - file_contains: "pattern1|pattern2"
---

## Skill Content
Expertise, patterns, examples, checklists
```

### 5. Config System
**Source**: `agent-os/config.yml`

**Reuse**:
- ✅ YAML structure
- ✅ Feature flags pattern
- ✅ Profile-based settings
- ✅ Nested configuration sections

**Extension**:
```yaml
# Existing structure maintained
active_profile: base
profiles: {...}
skills: {...}
verification: {...}

# NEW: Market validation configuration
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
```

### 6. Verification System
**Source**: `agent-os/workflows/verification/`, `agent-os/templates/verification/`

**Reuse**:
- ✅ Three-checkpoint pattern (Spec → Implementation → Visual)
- ✅ Scoring system (percentage + status labels)
- ✅ Gap identification (Critical/Important/Minor)
- ✅ Recommendation generation

**Application to Market Validation**:
- **Pre-Validation Verification**: Check competitor analysis completeness, landing page quality, ad campaign readiness
- **Post-Validation Verification**: Check data collection completeness, metrics accuracy, decision rationale soundness

## New Components Needed

### 1. Specialist Agents (7 new)

#### product-strategist.md (NEW)
**Location**: `.claude/agents/product-strategist.md`

**Frontmatter**:
```yaml
---
name: product-strategist
description: Product strategy specialist for sharpening vague ideas into clear product briefs
tools: Read, Write
color: purple
---
```

**Responsibilities**:
- Analyze initial (potentially vague) product idea
- Identify gaps in product definition (target audience unclear? problem vague?)
- Ask structured questions via AskUserQuestion tool
- Synthesize answers into sharp product brief
- Generate product-brief.md with clear target audience, problem, solution, value prop

**Key Integration**:
- AskUserQuestion tool: Interactive Q&A across 5 dimensions
- Template application: product-brief.md
- Skill activation: product-strategy-patterns (product definition frameworks)

**Output Format**:
```markdown
## Product Brief Complete

**Initial Idea**: [User's vague description]

**Questions Asked**: 5
- Target Audience
- Core Problem
- Solution Approach
- Value Proposition
- Success Metrics

**Product Brief Generated**: product-brief.md

**Key Insights**:
- Target Audience: [Specific persona]
- Core Problem: [Specific pain point]
- Key Features: [3-5 features]
- Differentiation: [How this is different]

**Ready for Market Research**: Yes
```

#### market-researcher.md
**Location**: `.claude/agents/market-researcher.md`

**Frontmatter**:
```yaml
---
name: market-researcher
description: Market research specialist using Perplexity MCP and WebSearch for competitive intelligence
tools: Read, Write, Grep, Glob, Bash
color: cyan
---
```

**Responsibilities**:
- Receive sharp product brief from product-strategist
- Use Perplexity MCP to identify competitors (based on target audience + problem space from brief)
- Use WebSearch to gather detailed competitor information
- Generate competitor-analysis.md with feature comparison matrix
- Identify market gaps and opportunities
- Create market-positioning.md with positioning recommendations (informed by product brief)

**Key Integration**:
- Perplexity MCP tool: `mcp__perplexity__deep_research` for comprehensive analysis
- WebSearch tool: For specific competitor details
- Template application: competitor-analysis.md, market-positioning.md

**Output Format**:
```markdown
## Competitive Analysis Complete

**Competitors Identified**: 8
- Competitor 1 (Direct)
- Competitor 2 (Direct)
- Competitor 3 (Indirect)
...

**Market Gaps Found**: 3 key opportunities

**Positioning Recommendation**: [Strategy]

**Files Created**:
- competitor-analysis.md
- market-positioning.md
```

#### validation-specialist.md
**Location**: `.claude/agents/validation-specialist.md`

**Frontmatter**:
```yaml
---
name: validation-specialist
description: Validation campaign specialist for landing pages, ad campaigns, and analytics setup
tools: Read, Write, Edit, Bash
color: green
---
```

**Responsibilities**:
- Generate production-ready HTML/CSS/JS landing page
- Create ad campaign plans for Google Ads and Meta Ads
- Provide analytics setup instructions (GA4, conversion tracking)
- Deployment guidance for static hosting
- Integration with content-creator and seo-specialist outputs

**Key Skills Auto-Activated**:
- validation-strategies (landing page best practices, CRO)
- content-writing-best-practices (for copy integration)
- seo-optimization-patterns (for technical SEO)

**Output Format**:
```markdown
## Validation Campaign Assets Complete

**Landing Page**: landing-page/index.html (production-ready)
**Ad Campaigns**:
- Google Ads: 7 variants
- Meta Ads: 6 variants

**Analytics Setup**: analytics-setup.md

**Deployment Ready**: Yes
**Estimated Setup Time**: 30 minutes

**Files Created**:
- landing-page/index.html
- ad-campaigns.md
- analytics-setup.md
- validation-plan.md
```

#### content-creator.md
**Location**: `.claude/agents/content-creator.md`

**Frontmatter**:
```yaml
---
name: content-creator
description: Copywriting specialist for landing pages and ad campaigns
tools: Read, Write
color: purple
---
```

**Responsibilities**:
- Write compelling landing page copy (headline, value proposition, CTA)
- Create 5-10 ad copy variants per platform
- Apply copywriting formulas (AIDA, PAS)
- Benefit-driven messaging
- Integration with validation-specialist

**Key Skills Auto-Activated**:
- content-writing-best-practices (copywriting formulas, CTA optimization)

**Output**:
- Copy integrated into landing page
- Ad copy variants in ad-campaigns.md

#### seo-specialist.md
**Location**: `.claude/agents/seo-specialist.md`

**Frontmatter**:
```yaml
---
name: seo-specialist
description: SEO optimization specialist for landing pages and content
tools: Read, Write, Edit
color: orange
---
```

**Responsibilities**:
- Optimize meta tags (title, description, OG tags)
- Keyword research and integration
- On-page SEO implementation
- SEO recommendations for technical implementation
- Integration with web-developer

**Key Skills Auto-Activated**:
- seo-optimization-patterns (meta tags, keywords, technical SEO)

**Output**:
- SEO-optimized copy with integrated keywords
- Meta tag specifications for web-developer
- SEO recommendations document

#### web-developer.md (NEW)
**Location**: `.claude/agents/web-developer.md`

**Frontmatter**:
```yaml
---
name: web-developer
description: Web development specialist for production-ready landing page creation
tools: Read, Write, Edit
color: blue
---
```

**Responsibilities**:
- Generate production-ready HTML/CSS/JS landing page
- Integrate copy from content-creator
- Implement SEO optimizations from seo-specialist
- Ensure responsive design (mobile, tablet, desktop)
- Optimize performance (<3 sec load time)
- Implement email collection form with validation
- Add privacy policy and GDPR compliance elements
- Create single self-contained index.html file
- Provide deployment instructions for static hosting

**Key Skills Auto-Activated**:
- validation-strategies (landing page best practices, CRO)
- seo-optimization-patterns (technical SEO implementation)

**Output Format**:
```markdown
## Landing Page Complete

**File**: landing-page/index.html (production-ready)

**Features Implemented**:
- ✅ Responsive design (mobile, tablet, desktop tested)
- ✅ SEO-optimized (meta tags, semantic HTML)
- ✅ Performance-optimized (< 3 sec load)
- ✅ Email collection form with validation
- ✅ Privacy policy link
- ✅ Self-contained (no external dependencies)

**Technical Stack**:
- HTML5 (semantic markup)
- CSS3 (Flexbox/Grid, media queries)
- Vanilla JavaScript (ES6+, form validation)

**Deployment Instructions**:
1. Netlify: `netlify deploy --prod`
2. Vercel: `vercel --prod`
3. GitHub Pages: Push to gh-pages branch

**Performance Metrics**:
- HTML size: ~15KB
- CSS size: ~8KB
- JS size: ~5KB
- Total: ~28KB (gzipped: ~10KB)
- Load time: ~1.8 seconds (estimated)

**File Created**: landing-page/index.html
```

#### validation-specialist.md
**Location**: `.claude/agents/validation-specialist.md`

**Frontmatter**:
```yaml
---
name: validation-specialist
description: Validation campaign coordinator for ad campaigns and analytics setup
tools: Read, Write
color: green
---
```

**Responsibilities**:
- Create ad campaign plans for Google Ads and Meta Ads
- Provide analytics setup instructions (GA4, conversion tracking)
- Create comprehensive validation plan (timeline, budget, success criteria)
- Coordinate validation campaign execution guidance
- Integration with landing page from web-developer

**Key Skills Auto-Activated**:
- validation-strategies (campaign planning, analytics)
- business-analysis-methods (success criteria definition)

**Output Format**:
```markdown
## Validation Campaign Plan Complete

**Ad Campaigns**:
- Google Ads: 7 variants (search + display)
- Meta Ads: 6 variants (Facebook + Instagram)

**Analytics Setup**: analytics-setup.md
- GA4 configuration
- Conversion tracking
- Event tracking code

**Validation Plan**: validation-plan.md
- Timeline: 2-4 weeks
- Budget: €500-2000 (recommended)
- Success criteria: 5% conversion, €10 CPA, 100k TAM

**Files Created**:
- ad-campaigns.md
- analytics-setup.md
- validation-plan.md
```

#### business-analyst.md
**Location**: `.claude/agents/business-analyst.md`

**Frontmatter**:
```yaml
---
name: business-analyst
description: Business analysis specialist for metrics analysis and GO/NO-GO decisions
tools: Read, Write, Bash
color: blue
---
```

**Responsibilities**:
- Analyze validation metrics (conversion rate, CPA, TAM)
- Calculate decision matrix based on thresholds
- Provide GO/NO-GO recommendation with supporting data
- Product refinement suggestions based on user feedback
- Integration with plan-product workflow

**Key Skills Auto-Activated**:
- business-analysis-methods (metrics, decision frameworks)
- market-research-best-practices (TAM estimation)

**Output Format**:
```markdown
## Validation Results Analysis

**Metrics**:
- Conversion Rate: 6.2% ✅
- Cost Per Acquisition: €8.50 ✅
- Total Addressable Market: 250,000 ✅

**Decision Matrix**: 3/3 criteria met

**Recommendation**: **GO** - Strong market validation

**Confidence Level**: High (95%)

**Next Steps**:
1. Proceed to /plan-product
2. Focus on features X, Y, Z (based on user feedback)
3. Prioritize customer segment A (highest conversion)

**File Created**: validation-results.md
```

### 2. Skills (5 new)

#### market-research-best-practices.md
**Location**: `agent-os/skills/business/market-research-best-practices.md`

**Content Structure**:
- Competitive analysis frameworks (Porter's Five Forces, SWOT)
- Market sizing methodologies (TAM, SAM, SOM)
- Positioning strategies (differentiation, niche identification)
- Research sources and methods
- Data validation techniques

**Triggers**:
```yaml
triggers:
  - task_mentions: "market research|competitor analysis|market validation|competitive intelligence"
  - file_contains: "competitor-analysis|market-positioning"
```

#### business-analysis-methods.md
**Location**: `agent-os/skills/business/business-analysis-methods.md`

**Content Structure**:
- Metrics analysis (conversion rates, CPA, CAC, LTV, ROI)
- Decision frameworks (decision matrix, weighted scoring)
- Data visualization best practices
- Statistical significance testing
- Qualitative feedback analysis

**Triggers**:
```yaml
triggers:
  - task_mentions: "business analysis|metrics|data analysis|go-no-go decision"
  - file_contains: "validation-results|decision-matrix"
```

#### validation-strategies.md
**Location**: `agent-os/skills/business/validation-strategies.md`

**Content Structure**:
- Landing page best practices (hero section, CTA placement, social proof)
- Conversion rate optimization (CRO) techniques
- A/B testing methodologies
- Analytics setup (GA4, conversion tracking, event tracking)
- Campaign optimization strategies

**Triggers**:
```yaml
triggers:
  - task_mentions: "validation|landing page|conversion optimization|cro|a/b test"
  - file_contains: "landing-page|validation-plan"
```

#### content-writing-best-practices.md
**Location**: `agent-os/skills/marketing/content-writing-best-practices.md`

**Content Structure**:
- Copywriting formulas (AIDA, PAS, Before-After-Bridge)
- Value proposition design (unique value, target audience, differentiation)
- Call-to-action optimization (action verbs, urgency, specificity)
- Headline writing techniques (benefit-driven, curiosity-driven)
- Ad copy structure (hook, body, CTA)

**Triggers**:
```yaml
triggers:
  - task_mentions: "copywriting|content creation|ad copy|landing page copy|headline"
  - file_contains: "ad-campaigns|landing-page"
```

#### seo-optimization-patterns.md
**Location**: `agent-os/skills/marketing/seo-optimization-patterns.md`

**Content Structure**:
- On-page SEO checklist (meta tags, headings, alt text, schema markup)
- Keyword research process (tools, search intent, long-tail keywords)
- Meta tag optimization (title length, description best practices, OG tags)
- Technical SEO basics (responsive design, page speed, semantic HTML)
- Content optimization (keyword density, readability, internal linking)

**Triggers**:
```yaml
triggers:
  - task_mentions: "seo|search engine optimization|meta tags|keywords"
  - file_contains: "landing-page|seo"
```

### 3. Templates (6 new)

#### competitor-analysis.md
**Location**: `agent-os/templates/market-validation/competitor-analysis.md`

**Structure**:
```markdown
# Competitive Analysis

> Product: [PRODUCT_NAME]
> Created: [DATE]
> Analyst: market-researcher

## Executive Summary
[1-2 paragraph overview]

## Competitors Identified

### Direct Competitors (5-7)
| Competitor | URL | Founded | Pricing | Key Features | Strengths | Weaknesses |
|------------|-----|---------|---------|--------------|-----------|------------|
| [Name] | [URL] | [Year] | [Price] | [Features] | [Strengths] | [Weaknesses] |

### Indirect Competitors (3-5)
[Same table structure]

## Feature Comparison Matrix

| Feature | Our Product | Competitor 1 | Competitor 2 | Competitor 3 |
|---------|-------------|--------------|--------------|--------------|
| Feature A | ✅ | ✅ | ❌ | ✅ |
| Feature B | ✅ | ❌ | ✅ | ❌ |

## Market Gaps Identified

1. **Gap 1**: [Description of unmet need]
2. **Gap 2**: [Description of unmet need]
3. **Gap 3**: [Description of unmet need]

## Pricing Analysis

- **Market Range**: €X - €Y per month
- **Average Price**: €Z per month
- **Recommended Positioning**: [Premium/Mid-market/Budget]

## Market Insights

- **Market Maturity**: [Emerging/Growing/Mature]
- **Competition Intensity**: [Low/Medium/High]
- **Differentiation Opportunities**: [List]

## Sources
- [Research source 1]
- [Research source 2]
```

#### market-positioning.md
**Location**: `agent-os/templates/market-validation/market-positioning.md`

**Structure**:
```markdown
# Market Positioning Strategy

> Product: [PRODUCT_NAME]
> Created: [DATE]
> Based on: @competitor-analysis.md

## Target Audience

**Primary Segment**:
- **Who**: [Demographics, firmographics]
- **Pain Points**: [Top 3 problems they face]
- **Current Solutions**: [What they use now]
- **Why Switch**: [Reasons to choose our product]

**Secondary Segment** (if applicable):
[Same structure]

## Unique Value Proposition

**One-Sentence UVP**:
[Benefit-driven statement]

**Key Differentiators**:
1. [Differentiator 1] - [Why it matters]
2. [Differentiator 2] - [Why it matters]
3. [Differentiator 3] - [Why it matters]

## Positioning Statement

For [target audience] who [need/want], [product name] is a [category] that [key benefit]. Unlike [competitors], [product name] [unique differentiator].

## Competitive Positioning

**Positioning Map**:
```
High Price
    ^
    |   Competitor A
    |              Our Product
    |                      Competitor B
    |
    |   Competitor C
    +-------------------------->
Low Features            High Features
```

## Messaging Pillars

1. **Pillar 1**: [Core message]
   - Supporting points

2. **Pillar 2**: [Core message]
   - Supporting points

3. **Pillar 3**: [Core message]
   - Supporting points

## Go-to-Market Strategy

**Primary Channels**:
- [Channel 1]: [Why/How]
- [Channel 2]: [Why/How]

**Content Strategy**:
- [Content type]: [Purpose]

**Launch Approach**:
[Soft launch/Big bang/Phased rollout]
```

#### validation-plan.md
**Location**: `agent-os/templates/market-validation/validation-plan.md`

**Structure**:
```markdown
# Validation Plan

> Product: [PRODUCT_NAME]
> Created: [DATE]
> Duration: 2-4 weeks

## Validation Objectives

**Primary Goal**: [What we want to learn]

**Success Criteria**:
- Conversion Rate: ≥ [X]%
- Cost Per Acquisition: ≤ €[Y]
- Total Addressable Market: ≥ [Z]

## Timeline

| Week | Activities | Deliverables |
|------|-----------|--------------|
| Week 1 | Landing page deployment, ad campaign setup | Live landing page, active campaigns |
| Week 2-3 | Campaign optimization, data collection | Daily metrics reports |
| Week 4 | Data analysis, GO/NO-GO decision | Validation results report |

## Budget Allocation

**Total Budget**: €[AMOUNT]

| Category | Amount | Percentage |
|----------|--------|------------|
| Google Ads | €[X] | [%] |
| Meta Ads | €[Y] | [%] |
| Tools (Analytics, Heatmap) | €[Z] | [%] |

## Landing Page Strategy

**URL**: [Proposed URL]
**Hosting**: [Platform]
**Email Collection Tool**: [Service]

**Key Elements**:
- Hero section with value proposition
- Social proof (testimonials, logos)
- Feature highlights
- Call-to-action (email signup)
- Privacy policy

## Ad Campaign Strategy

### Google Ads
- **Campaign Type**: Search + Display
- **Keywords**: [List]
- **Target Locations**: [Countries/Regions]
- **Budget**: €[X]/day

### Meta Ads
- **Platforms**: Facebook + Instagram
- **Target Audience**: [Demographics, interests]
- **Ad Format**: Image/Video/Carousel
- **Budget**: €[Y]/day

## Analytics Setup

**Tools**:
- Google Analytics 4
- [Heatmap tool]
- [Email service analytics]

**Events to Track**:
- Page views
- Button clicks
- Form submissions
- Email signups

## Risk Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Low conversion rate | Medium | High | A/B test headlines, optimize CTA |
| High CPA | Medium | Medium | Refine targeting, pause low-performing ads |
| Insufficient traffic | Low | High | Increase budget, expand targeting |

## Decision Criteria

**GO Decision**:
- Conversion rate ≥ 5% AND
- CPA ≤ €10 AND
- TAM ≥ 100,000

**MAYBE Decision**:
- Conversion rate 3-5% OR
- CPA €10-20 OR
- TAM 50,000-100,000
- → Refine and re-test

**NO-GO Decision**:
- Conversion rate < 3% OR
- CPA > €20 OR
- TAM < 50,000
- → Consider pivot or abandon
```

#### ad-campaigns.md
**Location**: `agent-os/templates/market-validation/ad-campaigns.md`

**Structure**: Detailed ad copy variants, targeting specs, setup instructions for Google Ads and Meta Ads

#### analytics-setup.md
**Location**: `agent-os/templates/market-validation/analytics-setup.md`

**Structure**: Step-by-step GA4 configuration, conversion tracking code, event tracking implementation

#### validation-results.md
**Location**: `agent-os/templates/market-validation/validation-results.md`

**Structure**: Metrics summary, decision matrix calculation, GO/NO-GO recommendation, product refinement suggestions

### 4. Workflow Implementation

#### validate-market.md
**Location**: `agent-os/workflows/validation/validate-market.md`

**Structure** (10-12 steps):
```xml
---
description: Market Validation System for data-driven GO/NO-GO decisions
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

<pre_flight_check>
  EXECUTE: @agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="context_loading">
  ### Step 1: Context Loading (Conditional)

  Load mission-lite.md, tech-stack.md if not already in context
</step>

<step number="2" name="product_idea_capture">
  ### Step 2: Product Idea Capture

  Request product idea description from user
  Expected: 1-3 paragraphs describing the product
</step>

<step number="3" subagent="date-checker" name="date_determination">
  ### Step 3: Date Determination

  Determine current date for folder naming
</step>

<step number="4" subagent="file-creator" name="workspace_creation">
  ### Step 4: Workspace Creation

  Create: agent-os/market-validation/YYYY-MM-DD-product-name/
</step>

<step number="5" subagent="market-researcher" name="competitive_analysis">
  ### Step 5: Competitive Analysis

  Use Perplexity MCP to identify 5-10 competitors
  Use WebSearch for detailed competitor information
  Generate competitor-analysis.md
  Generate market-positioning.md
</step>

<step number="6" subagent="content-creator" name="copywriting">
  ### Step 6: Copywriting

  Based on positioning strategy:
  - Write landing page copy (headline, value prop, CTA)
  - Create 5-10 ad copy variants per platform
</step>

<step number="7" subagent="seo-specialist" name="seo_optimization">
  ### Step 7: SEO Optimization

  Optimize landing page copy:
  - Meta tags (title, description, OG tags)
  - Keyword integration
  - Technical SEO checklist
</step>

<step number="8" subagent="validation-specialist" name="asset_generation">
  ### Step 8: Validation Asset Generation

  Generate:
  - Landing page HTML/CSS/JS (production-ready)
  - ad-campaigns.md (Google Ads + Meta Ads)
  - analytics-setup.md (GA4 configuration)
  - validation-plan.md (timeline, budget, criteria)
</step>

<step number="9" name="user_deployment">
  ### Step 9: User Deployment Phase

  Inform user:
  - Deploy landing page following instructions
  - Setup ad campaigns following ad-campaigns.md
  - Configure analytics following analytics-setup.md
  - Run campaigns for 2-4 weeks
  - Collect data

  PAUSE workflow until user provides metrics
</step>

<step number="10" subagent="business-analyst" name="results_analysis">
  ### Step 10: Results Analysis

  IF user provides metrics:
    Analyze conversion rate, CPA, TAM
    Calculate decision matrix
    Generate validation-results.md with GO/NO-GO
  ELSE:
    Provide data collection template
    WAIT for user input
</step>

<step number="11" name="integration_with_planning">
  ### Step 11: Integration with Product Planning

  IF decision == GO:
    Recommend: Run /plan-product with validation insights
    Auto-load validation results into planning context
  ELIF decision == MAYBE:
    Recommend: Refine and re-test
    Provide improvement suggestions
  ELSE (NO-GO):
    Recommend: Pivot or abandon
    Suggest alternative approaches
</step>

<step number="12" subagent="git-workflow" name="version_control">
  ### Step 12: Version Control (Optional)

  Commit validation artifacts:
  - All generated files
  - Commit message: "Market validation for [product-name]"
</step>

</process_flow>
```

### 5. Command File

#### validate-market.md
**Location**: `.claude/commands/agent-os/validate-market.md`

**Content**:
```markdown
# Validate Market

Conduct comprehensive market research and validation before product development

Refer to the instructions located in @agent-os/workflows/validation/validate-market.md

**Features:**
- Competitive analysis with Perplexity MCP
- Production-ready landing page generation (HTML/CSS/JS)
- Ad campaign planning (Google Ads, Meta Ads)
- Analytics setup guidance (Google Analytics 4)
- Data-driven GO/NO-GO decision

**Usage:**
```
/validate-market "Your product idea description (1-3 paragraphs)"
```

**Deliverables:**
- competitor-analysis.md - 5-10 competitors with feature matrix
- market-positioning.md - Positioning strategy
- landing-page/index.html - Production-ready landing page
- ad-campaigns.md - Complete ad campaign plans
- analytics-setup.md - GA4 setup guide
- validation-results.md - GO/NO-GO decision (after campaign)

**Timeline:** 2-4 weeks for validation campaign

**Estimated Cost:** €100-€2000 (ad spend)
```

## Integration Points

### 1. With Existing Workflows

#### plan-product.md
**Modification**: Add Step 0 - Market Validation Check

```xml
<step number="0" name="market_validation_check">
  ### Step 0: Market Validation Check (Recommended)

  ASK user: "Have you validated market demand for this product?"

  IF not validated:
    RECOMMEND: Run /validate-market first
    EXPLAIN: Benefits of validation before planning
    OFFER:
      Option A - Proceed anyway
      Option B - Run /validate-market now

  IF validated:
    LOAD: @agent-os/market-validation/[latest]/validation-results.md
    INCORPORATE: Validation insights into product plan
    - Use competitor analysis for feature prioritization
    - Use positioning strategy for product messaging
    - Use user feedback for feature refinement
</step>
```

#### plan-project.md
**Modification**: Similar validation check recommendation

### 2. With Perplexity MCP

**Tool**: `mcp__perplexity__deep_research`

**Usage in market-researcher**:
```markdown
Use Perplexity for:
- Identifying competitors: "Find top 10 competitors for [product description]"
- Market trends: "What are the latest trends in [industry]?"
- Market size: "Estimate total addressable market for [product]"
```

**Fallback**: If Perplexity unavailable, use WebSearch + manual template

### 3. With Config System

**Reading config values**:
```yaml
# In workflow, read thresholds from config
conversion_rate_threshold: config.market_validation.decision_criteria.conversion_rate_threshold
cpa_threshold: config.market_validation.decision_criteria.cpa_threshold
tam_threshold: config.market_validation.decision_criteria.tam_threshold
```

**User customization**: Users can override in project-level config.yml

### 4. With Skills System

**Auto-activation**:
```
market-researcher works on competitor-analysis.md
  → market-research-best-practices skill activates
  → Provides competitive analysis frameworks in context

validation-specialist generates landing page
  → validation-strategies skill activates
  → Provides CRO best practices
  → content-writing-best-practices activates
  → Provides copywriting formulas
```

### 5. With Verification System

**Pre-Validation Verification**:
- Check competitor analysis completeness (5-10 competitors?)
- Check landing page quality (responsive? SEO-optimized?)
- Check ad campaign readiness (targeting specs complete?)

**Post-Validation Verification**:
- Check data collection (all metrics provided?)
- Check decision rationale (supported by data?)
- Check recommendations (actionable?)

## External Dependencies

### Required
- **Perplexity MCP**: For deep competitive research (fallback: manual research)
- **WebSearch**: For specific competitor details
- **WebFetch**: For accessing competitor websites (if needed)

### Optional
- **Git**: For version control (via git-workflow subagent)

### Not Required (User Provides)
- Google Ads account (user creates campaigns)
- Meta Ads account (user creates campaigns)
- Google Analytics 4 property (user configures)
- Static hosting service (Netlify/Vercel/GitHub Pages)
- Email collection service (optional, can use mailto: form)

## Landing Page Technical Specification

### Technology
- HTML5 (semantic markup)
- CSS3 (Flexbox/Grid for layout)
- Vanilla JavaScript (ES6+, no frameworks)
- Self-contained (no external dependencies)

### Structure
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- SEO Meta Tags -->
  <title>[Product Name] - [Value Proposition]</title>
  <meta name="description" content="[SEO-optimized description]">

  <!-- Open Graph Tags -->
  <meta property="og:title" content="[Product Name]">
  <meta property="og:description" content="[Description]">
  <meta property="og:image" content="[Image URL]">

  <style>
    /* Inline CSS for self-contained deployment */
    /* Responsive design (mobile-first) */
    /* Conversion-optimized layout */
  </style>
</head>
<body>
  <!-- Hero Section (above fold) -->
  <header>
    <h1>[Benefit-driven headline]</h1>
    <p>[Value proposition]</p>
    <form id="signup-form">
      <input type="email" placeholder="Enter your email" required>
      <button type="submit">[CTA button text]</button>
    </form>
  </header>

  <!-- Features Section -->
  <section>
    <!-- Key features with benefits -->
  </section>

  <!-- Social Proof Section -->
  <section>
    <!-- Testimonials, logos, stats -->
  </section>

  <!-- FAQ Section -->
  <section>
    <!-- Common questions -->
  </section>

  <!-- Footer -->
  <footer>
    <!-- Privacy policy, terms -->
  </footer>

  <script>
    // Form validation and submission
    // Google Analytics tracking code
    // Conversion tracking
  </script>
</body>
</html>
```

### Requirements
- ✅ Responsive (mobile, tablet, desktop)
- ✅ Fast loading (<3 seconds)
- ✅ SEO-optimized (meta tags, semantic HTML)
- ✅ Conversion-optimized (clear CTA, benefit-driven)
- ✅ GDPR-compliant (privacy policy link, consent)
- ✅ Analytics-ready (GA4 tracking code)
- ✅ Accessible (ARIA labels, semantic markup)

## Performance Requirements

### Workflow Execution
- Market research: <10 minutes (with Perplexity)
- Landing page generation: <5 minutes
- Ad campaign planning: <5 minutes
- Complete workflow: <20 minutes (excluding user deployment)

### Skills Activation
- Context overhead: <20% (vs. loading all standards)
- Activation latency: <1 second

### Output Quality
- Competitor analysis: 5-10 competitors minimum
- Landing page: Production-ready, no edits needed
- Ad campaigns: 5-10 variants per platform
- Decision clarity: Clear GO/NO-GO with rationale

## Testing Strategy

### Unit Testing (Per Component)
- Each specialist agent tested independently
- Each skill tested for trigger activation
- Each template tested for completion

### Integration Testing
- Full /validate-market workflow end-to-end
- Perplexity MCP integration
- plan-product integration (validation check)

### User Acceptance Testing
- Deploy example landing page to Netlify
- Verify ad campaign setup instructions
- Confirm GO/NO-GO decision clarity

## Deployment Strategy

### Phase A Rollout
1. Create skills (week 1)
2. Create templates (week 1)
3. Create specialist agents (week 2)
4. Create workflow (week 2-3)
5. Create command + config (week 3)
6. Update setup scripts (week 3)
7. Documentation (week 4)
8. Testing (week 4)

### Distribution
- **GitHub**: Push to agent-os-extended repository
- **Setup Scripts**: Users download via setup.sh + setup-claude-code.sh
- **Documentation**: README.md + agent-os/workflows/validation/README.md

## Maintenance Considerations

### Version Control
- All files versioned in git
- Changelog updates for Phase A release
- Breaking changes: None (new feature, no modifications to existing)

### Backward Compatibility
- Existing workflows unaffected
- Optional feature (enabled via config flag)
- No breaking changes to Agent OS Extended core

### Future Evolution
- Phase B: Add /build-team for development coordination
- Phase C: Add Scrum/Agile events
- Parallel execution: Enable frontend/backend simultaneous work
- A/B testing: Automate variant testing

---

**Technical Specification Complete**

**Next**: Review specification, then proceed to tasks.md creation.
