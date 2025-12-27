# Validate Market

Conduct comprehensive market research and validation before product development

Refer to the instructions located in @agent-os/workflows/validation/validate-market.md

**Version**: 2.0 (Phase A - Market Validation System)

**Features:**
- Product idea sharpening with interactive Q&A
- Competitive analysis using Perplexity MCP
- Production-ready landing page generation (HTML/CSS/JS)
- Ad campaign planning (Google Ads, Meta Ads)
- Analytics setup guidance (Google Analytics 4, conversion tracking)
- Data-driven GO/NO-GO decision based on validation metrics

**Specialist Agents** (7):
- product-strategist: Sharpens vague ideas into clear product briefs
- market-researcher: Competitive intelligence with Perplexity MCP
- content-creator: Landing page and ad copy creation
- seo-specialist: SEO optimization for search visibility
- web-developer: Production-ready HTML/CSS/JS landing page
- validation-specialist: Ad campaign and analytics coordination
- business-analyst: Metrics analysis and GO/NO-GO decision

**Deliverables** (per validation campaign):
- product-brief.md - Sharp product definition with target persona
- competitor-analysis.md - 5-10 competitors with feature comparison
- market-positioning.md - Strategic positioning and messaging
- landing-page/index.html - Production-ready, deployable landing page
- ad-campaigns.md - Complete Google + Meta ad campaign plans
- analytics-setup.md - GA4 and conversion tracking setup guide
- validation-plan.md - Timeline, budget, success criteria
- validation-results.md - Metrics analysis with GO/NO-GO decision (after campaign)

**Timeline:**
- Setup: 15-20 minutes (automated workflow)
- Campaign Execution: 2-4 weeks (user runs campaigns)
- Analysis: 5 minutes (business-analyst decision)
- **Total**: 2-4 weeks to validated decision

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
"I have validation metrics" (workflow resumes for analysis)
```

**Example Flow:**
1. You describe product idea (can be vague)
2. product-strategist asks clarifying questions, creates sharp product brief
3. market-researcher finds 5-10 competitors, identifies market gaps
4. content-creator writes landing page copy and ad variants
5. seo-specialist optimizes for search engines
6. web-developer generates production-ready index.html
7. validation-specialist creates ad campaigns and analytics setup
8. You deploy landing page and run campaigns (2-4 weeks)
9. business-analyst analyzes results and provides GO/NO-GO decision
10. If GO → Proceed to /plan-product with validated demand

**Integration:**
- Validation results automatically loaded into /plan-product workflow
- Competitive insights inform product feature prioritization
- Validated positioning guides product messaging
- User feedback shapes product roadmap

**Learn More**: @agent-os/workflows/validation/README.md (complete guide)
