# Research Notes: Product Launch Framework

> Created: 2025-12-27
> Feature: Team-Based Product Launch Framework with Market Validation
> Research Phase: v2.0 Enhanced

## 1. Feature Overview

Implement a comprehensive **Product Launch Framework** that enables team-based market validation, strategic planning, and coordinated development execution. This framework introduces the first true multi-agent collaboration system to Agent OS Extended.

**Vision Flow**:
```
Product Idea
  ↓
Market Research Team → Competitive analysis, market fit assessment
  ↓
Validation Team → Landing page + Ad campaign + Analytics
  ↓
GO/NO-GO Decision (data-driven)
  ↓
[IF GO] Planning Team → Product/project planning
  ↓
[IF GO] Development Team → Build, test, deploy
  ↓
[IF GO] Marketing Team → Launch, growth
```

**Priority**: Phase A - Market Validation System (20-24h effort)

## 2. Codebase Analysis

### 2.1 Existing Workflow Patterns (REUSABLE)

**Location**: `agent-os/workflows/`

**Key Findings**:
- ✅ XML-based step definition pattern established
- ✅ Pre-flight check pattern (`<pre_flight_check>`)
- ✅ Process flow container (`<process_flow>`)
- ✅ Conditional logic blocks (`<conditional_logic>`)
- ✅ Decision tree pattern for branching
- ✅ Frontmatter with version, description, encoding

**Reusable Components**:
```xml
<step number="N" subagent="agent-name" name="step_identifier">
  ### Step N: Descriptive Title

  Instructions...

  <conditional_logic>
    IF condition:
      ACTION
    ELSE:
      ALTERNATIVE_ACTION
  </conditional_logic>
</step>
```

**Pattern to Follow**:
- `create-spec-v2.md` - Multi-phase research workflow
- `execute-tasks.md` - Task delegation to specialists
- All workflows use `@agent-os/` file references
- Date format: YYYY-MM-DD everywhere

### 2.2 Existing Subagent Patterns (REUSABLE)

**Location**: `.claude/agents/`

**Available Subagents** (to reuse):
- `context-fetcher` - Retrieve documentation selectively
- `date-checker` - Determine current date
- `file-creator` - Create files/directories with templates
- `git-workflow` - Git operations, commits, PRs
- `estimation-specialist` - Estimate specs
- `test-runner` - Run test suites

**Subagent Structure Pattern**:
```yaml
---
name: agent-name
description: Use proactively to...
tools: Read, Write, Edit, Grep, Glob, Bash
color: blue
---

## Core Responsibilities
[List of responsibilities]

## Workflow/Process
[Step-by-step process]

## Output Format
[Expected deliverables]

## Important Constraints
[Limitations and rules]
```

**Pattern to Follow**: Use frontmatter + clear sections

### 2.3 Team/Collaboration Patterns (NEW TERRITORY)

**Finding**: ❌ No explicit "team" or "multi-agent coordinator" pattern exists yet

**Current Pattern**: Sequential subagent delegation
- Main workflow orchestrates
- Delegates specific steps to specialized subagents
- Each subagent completes task and returns control
- Linear, not parallel

**Opportunity**: **Product Launch Framework introduces first team-based pattern**

**Decision from Q&A**: Start with sequential execution (MVP), add parallel later

### 2.4 Config System (EXTENSIBLE)

**Location**: `agent-os/config.yml`

**Current Structure**:
```yaml
active_profile: base
profiles: {...}
skills: {...}
verification: {...}
features:
  profile_system: true
  skills_system: true
  enhanced_research: true
  verification_system: true
```

**Recommendation**: Add new section
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
    - conversion_rate_threshold
    - cost_per_acquisition
    - market_size_validation
```

### 2.5 Template System (LEVERAGE)

**Location**: `agent-os/templates/`

**Existing Categories**:
- `research/` - research-questions.md, research-notes.md
- `verification/` - spec/implementation/visual verification reports

**Recommendation**: Create new category
```
templates/
└── market-validation/
    ├── competitor-analysis.md
    ├── market-positioning.md
    ├── validation-plan.md
    ├── ad-campaigns.md
    ├── analytics-setup.md
    └── validation-results.md
```

**Pattern**: Structured sections with placeholders `[VARIABLE_NAME]`

### 2.6 Skills System (EXPAND)

**Location**: `agent-os/skills/`

**Current Organization**:
```
skills/
├── base/ (2 skills)
├── java/ (3 skills)
├── react/ (3 skills)
└── angular/ (3 skills)
Total: 11 skills
```

**Decision from Q&A**: Add all 13 new skills

**Recommended Expansion**:
```
skills/
├── base/
│   ├── security-best-practices.md ✅
│   ├── git-workflow-patterns.md ✅
│   ├── testing-best-practices.md ⭐ NEW
│   └── devops-patterns.md ⭐ NEW
├── product/
│   ├── product-management-patterns.md ⭐ NEW
│   ├── ux-design-principles.md ⭐ NEW
│   └── user-research-methods.md ⭐ NEW
├── marketing/
│   ├── content-writing-best-practices.md ⭐ NEW
│   ├── seo-optimization-patterns.md ⭐ NEW
│   └── social-media-strategies.md ⭐ NEW
├── business/
│   ├── business-analysis-methods.md ⭐ NEW
│   ├── market-research-best-practices.md ⭐ NEW
│   └── validation-strategies.md ⭐ NEW
└── agile/
    ├── user-story-writing.md ⭐ NEW
    └── story-refinement.md ⭐ NEW
Total: 24 skills (11 existing + 13 new)
```

**Trigger Pattern**:
```yaml
---
name: Market Research Best Practices
triggers:
  - task_mentions: "market research|competitor analysis|market validation"
  - file_contains: "competitor-analysis|market-positioning"
---
```

### 2.7 Command Patterns (SIMPLE)

**Location**: `.claude/commands/agent-os/`

**Pattern**: Lightweight reference to workflow
```markdown
# Validate Market

Conduct market research and validation before product development

Refer to the instructions located in @agent-os/workflows/validation/validate-market.md

**Features:**
- Competitive analysis with Perplexity/web research
- Landing page creation (HTML/CSS/JS)
- Ad campaign planning (Google Ads, Meta Ads)
- Analytics setup guidance
- Data-driven GO/NO-GO decision
```

**Recommendation**: Create `.claude/commands/agent-os/validate-market.md`

### 2.8 Research & Verification Patterns (v2.0) (LEVERAGE)

**Research Phase Pattern** (from create-spec-v2.md):
1. Codebase Analysis - Find reusable patterns ✅
2. Interactive Q&A - Clarify requirements ✅
3. Visual Asset Collection - Gather mockups ✅

**Output**: `research-notes.md` ✅ (this document!)

**Verification Pattern**:
- Three checkpoints: Spec → Implementation → Visual
- Scoring system: Percentage + Status (Excellent/Good/Fair/Poor)
- Gap identification: Critical/Important/Minor
- Actionable recommendations

**Recommendation**: Apply verification to market validation outputs
- Validate competitor analysis completeness
- Validate landing page quality
- Validate ad campaign readiness

### 2.9 Profile System (EXTEND)

**Location**: `agent-os/profiles/`

**Current Profiles**:
- base.md - Universal standards
- java-spring-boot.md
- react-frontend.md
- angular-frontend.md

**Recommendation**: Market validation is profile-agnostic
- Works with any tech stack
- No new profile needed
- Universal command available to all profiles

## 3. Requirements Clarification

### 3.1 Implementation Phase Priority

**Question**: Which phase to prioritize first?
**Answer**: **Phase A: Market Validation System**

**Scope**:
- `/validate-market` command
- Market research workflow
- Validation workflow
- Business specialist agents (3-4 agents)
- Business/Marketing skills (5-6 skills)
- Market validation templates (6 templates)

**Estimated Effort**: 20-24 hours

**Why this phase?**:
- Critical differentiator for Agent OS Extended
- Data-driven decision making before expensive development
- Reduces risk of building unwanted features
- Complements existing development workflows

### 3.2 Execution Model

**Question**: Parallel or sequential agent execution?
**Answer**: **Sequential only (MVP)**

**Rationale**:
- Simpler to implement and debug
- Agents work one after another
- Clear handoff points
- Can add parallel execution in future enhancement

**Implementation**:
```xml
<step number="N" subagent="market-researcher">
  Market research completes first...
</step>

<step number="N+1" subagent="validation-specialist">
  Validation builds on research results...
</step>
```

### 3.3 Specialist Agents Needed

**Question**: Which specialist agents are essential?
**Answer**: **All four teams selected** (Development, Product, Marketing, Business)

**Priority for Phase A (Market Validation)**:
1. **Business Team** (HIGH PRIORITY):
   - `market-researcher` - Competitive analysis using Perplexity/web
   - `business-analyst` - Data analysis, GO/NO-GO decision
   - `validation-specialist` - Landing page + ad campaign planning

2. **Marketing Team** (MEDIUM PRIORITY):
   - `content-creator` - Landing page copy, ad copy
   - `seo-specialist` - Landing page SEO optimization

3. **Development Team** (CONDITIONAL):
   - `frontend-dev` - Landing page HTML/CSS/JS (if needed)

4. **Product Team** (FUTURE):
   - Reserved for Phase B/C (product planning, user stories)

**Total New Agents for Phase A**: 5-6 specialists

### 3.4 Skills System Strategy

**Question**: How to expand skills?
**Answer**: **Add all 13 new skills**

**Breakdown by Phase A needs**:

**Critical for Phase A**:
- `market-research-best-practices.md` - Competitive analysis patterns
- `business-analysis-methods.md` - Data analysis, metrics
- `validation-strategies.md` - Landing page, A/B testing, analytics
- `content-writing-best-practices.md` - Landing page copy, ads
- `seo-optimization-patterns.md` - Landing page SEO

**Total for Phase A**: 5 new skills (+ 2 base skills reused: security, git-workflow)

**Future phases**: Remaining 8 skills (product, agile, social-media, etc.)

### 3.5 Landing Page Technology

**Question**: What tech for landing page?
**Answer**: **Simple HTML/CSS/JS**

**Rationale**:
- Self-contained, no framework overhead
- Fast to deploy to static hosting (Netlify, Vercel, GitHub Pages)
- Validation specialist can generate complete code
- User can copy/paste and deploy immediately

**Deliverable**: Single `index.html` file with inline CSS/JS

### 3.6 Ad Campaign Scope

**Question**: Execution or planning?
**Answer**: **Planning only**

**Deliverables**:
- Ad copy for Google Ads (search, display)
- Ad copy for Meta Ads (Facebook, Instagram)
- Targeting specifications (demographics, interests, keywords)
- Budget recommendations (daily spend, total budget)
- Campaign structure (ad groups, campaigns)

**User executes**: User manually creates campaigns in ad platforms

**Rationale**: Avoids API integration complexity, user maintains control

### 3.7 Market Research Methods

**Question**: How to access competitive intelligence?
**Answer**: **Multi-method approach**
1. **Perplexity MCP** - Competitor analysis, market trends, industry data
2. **Web search integration** - WebSearch/WebFetch for public information
3. **Template-driven analysis** - User fills in structured templates

**Workflow**:
```
Step 1: market-researcher uses Perplexity to find competitors
Step 2: market-researcher uses WebSearch for specific competitor details
Step 3: market-researcher generates competitor-analysis.md template
Step 4: User optionally adds insider knowledge to template
```

### 3.8 GO/NO-GO Decision Criteria

**Question**: What metrics drive the decision?
**Answer**: **Three key metrics**

1. **Conversion Rate Thresholds**
   - Email signup rate >5% = Strong interest
   - Configurable per validation campaign

2. **Cost Per Acquisition (CPA)**
   - Track ad spend vs. conversions
   - Must be below target CPA (e.g., <€10 per signup)

3. **Market Size Validation**
   - Total Addressable Market (TAM) estimate from research
   - Minimum market size threshold (e.g., >100k potential customers)

**Decision Matrix**:
```
IF conversion_rate > 5% AND cpa < target AND tam > 100k:
  DECISION = GO
ELIF conversion_rate > 3% AND cpa < target*1.5:
  DECISION = MAYBE (refine and re-test)
ELSE:
  DECISION = NO-GO
```

**Output**: `validation-results.md` with decision + reasoning

## 4. Visual Assets

**Status**: No visual designs provided

**Reasoning**: This is primarily a backend workflow system with CLI interaction. No UI components required for Phase A.

**Future consideration**: If team dashboard/progress tracking UI is added in later phases, visual designs would be valuable.

## 5. Technical Constraints

### 5.1 Agent OS Extended Architecture

**Must follow**:
- XML-based workflow definitions
- Frontmatter for metadata
- `@agent-os/` file path convention
- Date-prefixed spec folders (YYYY-MM-DD)
- Template-driven outputs

### 5.2 Subagent System

**Constraints**:
- Sequential execution only (MVP decision)
- Each subagent has separate context window
- Clear input/output contracts
- Frontmatter + structured sections

### 5.3 Skills System

**Constraints**:
- Skills are passive (no tools)
- Trigger-based activation
- Profile association
- 60-80% context reduction goal

### 5.4 MCP Integration

**Available**:
- Perplexity MCP for deep research
- Web search/fetch for public data

**Not available**:
- Google Ads API
- Meta Ads API
- Analytics platforms API

**Implication**: Planning-only approach for ads/analytics

### 5.5 Technology Stack

**Landing Page**:
- HTML5
- CSS3 (Flexbox/Grid)
- Vanilla JavaScript (ES6+)
- No external dependencies

**Deployment guidance**:
- Static hosting (Netlify, Vercel, GitHub Pages, S3+CloudFront)
- Custom domain setup instructions
- SSL certificate (Let's Encrypt)

### 5.6 Verification System

**Must include**:
- Pre-validation verification (before launching campaign)
- Post-validation verification (after data collection)
- Gap analysis with recommendations

## 6. Recommendations

### 6.1 Reuse Strategy

**Workflows**:
- ✅ Reuse XML step pattern from create-spec-v2.md
- ✅ Reuse pre-flight check pattern
- ✅ Reuse conditional logic blocks
- ✅ Reuse verification gate pattern

**Subagents**:
- ✅ Reuse context-fetcher for loading mission/tech-stack
- ✅ Reuse date-checker for folder naming
- ✅ Reuse file-creator for template application
- ✅ Reuse git-workflow for committing validation artifacts

**Templates**:
- ✅ Follow research template pattern (sections with placeholders)
- ✅ Follow verification template pattern (checklists with scoring)

**Skills**:
- ✅ Reuse security-best-practices (landing page security)
- ✅ Reuse git-workflow-patterns (version control)

### 6.2 Implementation Approach

**Phase A (Market Validation) - Recommended Order**:

1. **Create 5 New Skills** (5-6h)
   - market-research-best-practices.md
   - business-analysis-methods.md
   - validation-strategies.md
   - content-writing-best-practices.md
   - seo-optimization-patterns.md

2. **Create 6 Market Validation Templates** (2-3h)
   - competitor-analysis.md
   - market-positioning.md
   - validation-plan.md
   - ad-campaigns.md
   - analytics-setup.md
   - validation-results.md

3. **Create 5 Specialist Subagents** (4-5h)
   - market-researcher.md
   - business-analyst.md
   - validation-specialist.md
   - content-creator.md
   - seo-specialist.md

4. **Create /validate-market Workflow** (6-8h)
   - validate-market.md (main workflow)
   - 10-12 steps with conditional logic
   - Integration with Perplexity MCP
   - Template-driven outputs

5. **Create Command File** (30 min)
   - .claude/commands/agent-os/validate-market.md

6. **Update Config** (30 min)
   - Add market_validation section to config.yml

7. **Update Setup Scripts** (1-2h)
   - Download new skills
   - Download new templates
   - Download new agents
   - Download new command

8. **Documentation** (2-3h)
   - Update README.md
   - Create market-validation/README.md guide
   - Example validation project

**Total Phase A Effort**: 22-28 hours (slightly higher than initial 20-24h estimate due to comprehensive Q&A)

### 6.3 Integration Points

**With existing workflows**:
- `plan-product.md` should check for validation results
- `plan-project.md` should recommend validation if not done
- Validation results inform product planning decisions

**Extension in config**:
```yaml
# In plan-product workflow
validation:
  check_before_planning: true
  recommend_if_missing: true
  load_validation_results: true
```

### 6.4 Future Enhancements (Post-Phase A)

**Phase B: Core Team System**:
- /build-team command
- Development team agents (backend-dev, frontend-dev, qa, devops)
- Team coordination workflow
- Parallel execution support

**Phase C: Scrum/Agile Events**:
- /write-user-stories command
- /refine-stories command
- /plan-sprint command
- /daily-standup command
- Product team agents

**Phase D: Launch Execution**:
- /execute-launch command
- Marketing campaign execution
- Post-launch analytics tracking
- Growth optimization

## 7. Open Questions

1. **Analytics Integration**: Should we provide step-by-step Google Analytics 4 setup instructions, or just recommendations?
   - **Recommendation**: Step-by-step instructions in analytics-setup.md template

2. **Landing Page Hosting**: Should validation-specialist include deployment instructions for specific platforms?
   - **Recommendation**: Yes, include instructions for Netlify, Vercel, GitHub Pages (most common)

3. **A/B Testing**: Should validation include A/B test setup (multiple landing page variants)?
   - **Recommendation**: Not for MVP, add in future enhancement

4. **Email Collection**: Should we recommend specific email service providers (Mailchimp, ConvertKit)?
   - **Recommendation**: Yes, provide options with pros/cons in validation-plan.md

5. **Budget Guidance**: What ad budget ranges should we recommend?
   - **Recommendation**: Tiered approach (Small: €100-500, Medium: €500-2000, Large: €2000+)

## 8. Success Criteria for Phase A

**Workflow Success**:
- ✅ User can run `/validate-market` command
- ✅ market-researcher produces comprehensive competitor analysis
- ✅ validation-specialist generates complete landing page HTML
- ✅ validation-specialist creates detailed ad campaign plans
- ✅ business-analyst provides clear GO/NO-GO decision with data

**Output Quality**:
- ✅ Competitor analysis identifies 5-10 competitors with feature comparison
- ✅ Landing page is production-ready (valid HTML, responsive, SEO-optimized)
- ✅ Ad campaigns include 5-10 ad variants with targeting specs
- ✅ Analytics setup includes GA4, conversion tracking, heatmap recommendations
- ✅ Validation results provide actionable metrics and clear decision rationale

**Integration Success**:
- ✅ Validation results load into plan-product workflow
- ✅ Skills activate correctly for market research tasks
- ✅ Templates generate consistently formatted outputs
- ✅ Perplexity MCP integration works for competitive research

**Documentation Success**:
- ✅ README.md includes Market Validation section
- ✅ market-validation/README.md provides complete guide
- ✅ Example validation project demonstrates end-to-end flow

## 9. Risk Mitigation

**Risk**: Perplexity MCP rate limits during extensive research
- **Mitigation**: Cache research results, provide manual fallback templates

**Risk**: Landing page code quality varies
- **Mitigation**: Create reusable landing page template with best practices baked in

**Risk**: GO/NO-GO decision criteria too rigid
- **Mitigation**: Make thresholds configurable in validation-plan.md

**Risk**: User lacks ad platform experience
- **Mitigation**: Provide detailed step-by-step campaign setup guides

**Risk**: Market research incomplete due to limited public data
- **Mitigation**: Template includes sections for user to add insider knowledge

## 10. Next Steps

1. **User Review**: Review this research summary and confirm approach
2. **Formal Spec Creation**: Generate spec.md, spec-lite.md, technical-spec.md
3. **Task Breakdown**: Create tasks.md with detailed implementation steps
4. **Begin Implementation**: Start with skills → templates → agents → workflow

---

**Research Phase Complete!** ✅

Ready to proceed with formal specification?
