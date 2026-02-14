# Validate Market

Conduct comprehensive market research and validation before product development

Refer to the instructions located in @specwright/workflows/validation/validate-market.md

**Version**: 4.0 (Phase A - Market Validation System)

**Features:**
- Product idea sharpening with interactive Q&A
- Competitive analysis using Perplexity MCP
- Strategic market positioning with brand story
- Production-ready landing page generation (HTML/CSS/JS)
- Quality assurance with visual validation
- Ad campaign planning (Google Ads, Meta Ads)
- Analytics setup guidance (Google Analytics 4, conversion tracking)
- Data-driven GO/NO-GO decision based on validation metrics

**Specialist Agents** (9):
- marketing-system__product-idea-refiner: Transforms vague ideas into structured product briefs
- marketing-system__market-researcher: Competitive intelligence with Perplexity MCP
- marketing-system__product-strategist: Market positioning, brand story, and tone of voice
- marketing-system__content-creator: Landing page and ad copy creation
- marketing-system__seo-expert: SEO optimization for search visibility
- marketing-system__landing-page-builder: Production-ready HTML/CSS/JS landing page
- marketing-system__quality-assurance: Visual validation and QA before deployment
- validation-specialist: Ad campaign and analytics coordination
- business-analyst: Metrics analysis and GO/NO-GO decision

**Deliverables** (per validation campaign):

*Core Outputs (always created):*
- product-brief.md - Sharp product definition with target persona
- competitor-analysis.md - 5-10 competitors with feature comparison
- market-position.md - Strategic positioning and messaging pillars
- story.md - Brand narrative using StoryBrand framework
- stil-tone.md - Communication style and voice guidelines

*Optional Outputs - Phase 3 (if landing page requested):*
- design-system.md - Visual design tokens from reference
- landing-page-module-structure.md - Page structure and modules
- seo-keywords.md - Keyword research and SEO specifications
- landingpage-contents.md - All copy and content for landing page
- landing-page/index.html - Production-ready, deployable landing page

*Optional Outputs - Phase 4 (if user opts in after QA):*
- ad-campaigns.md - Complete Google + Meta ad campaign plans
- analytics-setup.md - GA4 and conversion tracking setup guide
- validation-plan.md - Timeline, budget, success criteria
- validation-results.md - Metrics analysis with GO/NO-GO decision (after campaign)

**Workflow Phases:**
1. **Product Definition** (Steps 1-4): Idea capture → Product brief → User review
2. **Market Research** (Steps 5-7): Competitor analysis → Market positioning → User review
3. **Landing Page Creation** (Steps 8-13, optional): Design → Structure → SEO → Content → Build → QA
4. **Campaign & Decision** (Steps 14-17, optional - user is asked): Campaign plan → User executes → GO/NO-GO

**Timeline:**
- Core validation: 10-15 minutes (Steps 1-7)
- Full setup: 30-40 minutes (Steps 1-14)
- Campaign Execution: 2-4 weeks (user runs campaigns)
- GO/NO-GO Analysis: 5-10 minutes (Step 16)

**Estimated Cost:**
- Ad Spend: €100-€2,000 (user chooses, €500 recommended)
- Tools: €0 (all free tiers: GA4, Netlify, Clarity)
- **Total**: €100-€2,000

**Success Criteria** (default thresholds, configurable):
- **GO**: Conversion ≥5%, CPA ≤€10, TAM ≥100k
- **MAYBE**: Conversion 3-5%, CPA €10-€15, TAM 50-100k
- **NO-GO**: Conversion <3%, CPA >€15, TAM <50k

**Usage:**
```bash
# Basic usage (interactive Q&A)
/validate-market

# With product idea upfront
/validate-market "Automated invoice generation for freelance designers who hate accounting"

# After campaign completion
"I have validation metrics" (workflow resumes for GO/NO-GO analysis)
```

**Example Flow:**
1. You describe product idea (can be vague)
2. marketing-system__product-idea-refiner asks clarifying questions, creates product brief
3. User reviews and approves product brief
4. marketing-system__market-researcher finds 5-10 competitors, identifies market gaps
5. marketing-system__product-strategist creates positioning, brand story, and tone guide
6. User reviews and approves positioning (can stop here or continue to Phase 3)
7. Design system extracted from reference URL/screenshot → design-system.md
8. marketing-system__landing-page-builder (Structure) defines page modules
9. marketing-system__seo-expert conducts keyword research → seo-keywords.md
10. marketing-system__content-creator writes all content → landingpage-contents.md
11. marketing-system__landing-page-builder (Final Build) generates HTML → index.html
12. marketing-system__quality-assurance validates before deployment
13. **User is asked: Continue to Phase 4?** (can stop here or continue)
14. validation-specialist creates ad campaigns and analytics setup
15. You deploy landing page and run campaigns (2-4 weeks)
16. business-analyst analyzes results and provides GO/NO-GO decision
17. If GO → Proceed to /plan-product with validated demand

**Agent Handoff Chain:**
```
product-idea-refiner → market-researcher → product-strategist →
  [OPTIONAL: PHASE 3 - LANDING PAGE]
  → landing-page-builder (Structure) → seo-expert → content-creator →
  → landing-page-builder (Final Build) → quality-assurance →
  [USER DECISION: Continue to Phase 4?]
  [OPTIONAL: PHASE 4 - CAMPAIGN & DECISION]
  → validation-specialist → [USER CAMPAIGN 2-4 weeks] → business-analyst
```

**Integration:**
- Validation results automatically loaded into /plan-product workflow
- Competitive insights inform product feature prioritization
- Validated positioning guides product messaging
- User feedback shapes product roadmap

**Learn More**: @specwright/workflows/validation/README.md (complete guide)
