---
description: Market Validation System for data-driven GO/NO-GO decisions before development
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
installation: global  # Installed in ~/.agent-os/ by default, can be overridden in project/agent-os/
---

# Market Validation Workflow

Validate product-market fit through competitive analysis, landing page validation, ad campaigns, and data-driven decision-making.

## File Lookup Strategy

This workflow uses **dual-lookup** for templates, skills, and agents:

**Lookup Order**:
1. **Project-local first**: `projekt/agent-os/templates/market-validation/`
2. **Global fallback**: `~/.agent-os/templates/market-validation/`

**Example**:
```
Need: product-brief.md template

Check: projekt/agent-os/templates/market-validation/product-brief.md
  → If exists: Use project-specific version ✅
  → If not exists: Use global version from ~/.agent-os/ ✅

This allows:
- Global defaults (work out of the box)
- Project overrides (customize when needed)
```

**Same pattern applies to**:
- Templates: `@templates/market-validation/` → Check local first, then `~/.agent-os/templates/`
- Skills: Auto-activated from `.claude/skills/` (symlinked from global or local)
- Agents: Invoked from `.claude/agents/` (global or project-override)

<pre_flight_check>
  EXECUTE: @agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="context_loading">

### Step 1: Context Loading (Conditional)

Use the context-fetcher subagent to load mission-lite.md and tech-stack.md only if not already in context.

<conditional_logic>
  IF both mission-lite.md AND tech-stack.md already in context:
    SKIP this step
    PROCEED to step 2
  ELSE:
    READ only files not in context:
      - @agent-os/product/mission-lite.md (if not in context)
      - @agent-os/product/tech-stack.md (if not in context)
    CONTINUE
</conditional_logic>

</step>

<step number="2" name="product_idea_capture">

### Step 2: Product Idea Capture

Request product idea from user (if not provided in command arguments).

**Expected Input**: 1-3 paragraphs describing the product idea (can be vague)

**Examples of Valid Input**:
- Vague: "A tool for invoicing"
- Moderate: "An invoicing app for freelancers that's simpler than QuickBooks"
- Detailed: "Automated invoice generation from time tracking for creative freelancers"

**Store**: Product idea description for product-strategist

<conditional_logic>
  IF user provided idea in command arguments:
    USE provided idea
    PROCEED to step 3
  ELSE:
    ASK user: "Please describe your product idea (1-3 paragraphs). Can be rough - we'll sharpen it together."
    WAIT for user input
    STORE user input
    PROCEED to step 3
</conditional_logic>

</step>

<step number="3" subagent="date-checker" name="date_determination">

### Step 3: Date Determination

Use the date-checker subagent to determine current date in YYYY-MM-DD format for folder naming.

**Output**: Current date for creating `agent-os/market-validation/YYYY-MM-DD-product-name/`

</step>

<step number="4" subagent="file-creator" name="workspace_creation">

### Step 4: Workspace Creation

Use the file-creator subagent to create directory structure:

**Base Directory**: `agent-os/market-validation/YYYY-MM-DD-product-name/`

**Subdirectories**:
- `landing-page/` - For HTML/CSS/JS files
- `assets/` - For images (if any)

**Placeholder Files** (optional):
- `README.md` - Overview of validation campaign

</step>

<step number="5" subagent="product-strategist" name="idea_sharpening">

### Step 5: Product Idea Sharpening

Delegate to product-strategist agent to sharpen vague product idea into clear, focused product brief.

**Process**:
1. product-strategist receives initial product idea (from step 2)
2. product-strategist analyzes for completeness (target audience clear? problem specific?)
3. product-strategist formulates 4-5 strategic questions using AskUserQuestion tool:
   - **Target Audience**: Who specifically is this for?
   - **Core Problem**: What specific problem does this solve?
   - **Solution Approach**: How does it solve the problem?
   - **Value Proposition**: Why is this better than alternatives?
   - [**Success Metrics**: Optional 5th question if needed]
4. product-strategist synthesizes answers into sharp product brief
5. product-strategist generates product-brief.md from template

**Output**: `@agent-os/market-validation/YYYY-MM-DD-product-name/product-brief.md`

**Quality Gate**:
<quality_check>
  Product brief must include:
  - ✅ Specific target audience (not "everyone")
  - ✅ Measurable problem (frequency, impact, cost)
  - ✅ 3-5 concrete features (not 20)
  - ✅ Clear value proposition
  - ✅ Differentiation hypothesis

  IF any element missing or vague:
    RETURN to product-strategist for refinement
  ELSE:
    PROCEED to step 6
</quality_check>

</step>

<step number="6" subagent="market-researcher" name="competitive_analysis">

### Step 6: Competitive Analysis

Delegate to market-researcher agent to conduct comprehensive competitive research.

**Process**:
1. market-researcher receives product-brief.md (sharp definition)
2. market-researcher uses Perplexity MCP (`mcp__perplexity__deep_research`) to identify 10-15 competitors
3. market-researcher uses WebSearch and WebFetch to gather detailed competitor info:
   - Pricing (all tiers)
   - Key features (what they offer)
   - Target audience (who they serve)
   - Reviews (G2, Capterra, Trustpilot)
   - Strengths and weaknesses
4. market-researcher creates feature comparison matrix
5. market-researcher identifies 3-5 market gaps (with evidence from reviews, research)
6. market-researcher generates competitor-analysis.md from template
7. market-researcher develops positioning strategy
8. market-researcher generates market-positioning.md from template

**Output**:
- `@agent-os/market-validation/YYYY-MM-DD-product-name/competitor-analysis.md`
- `@agent-os/market-validation/YYYY-MM-DD-product-name/market-positioning.md`

**Quality Gate**:
<quality_check>
  Competitive analysis must include:
  - ✅ 5-10 competitors identified (minimum 5)
  - ✅ Feature comparison matrix (5+ features compared)
  - ✅ Pricing analysis (market range calculated)
  - ✅ 3+ market gaps with evidence (not assumptions)
  - ✅ Positioning statement (follows formula)
  - ✅ Research sources cited (Perplexity queries, URLs)

  IF incomplete:
    RETURN to market-researcher for additional research
  ELSE:
    PROCEED to step 7
</quality_check>

<error_handling>
  IF Perplexity MCP rate limit reached:
    - Use WebSearch as fallback
    - Generate partial competitor-analysis.md
    - Include manual research template for user to complete
    - Note: "Perplexity rate limited, completed with WebSearch"
    - PROCEED (don't block on this)
</error_handling>

</step>

<step number="7" subagent="content-creator" name="copywriting">

### Step 7: Copywriting

Delegate to content-creator agent to write compelling landing page and ad copy.

**Process**:
1. content-creator receives product-brief.md and market-positioning.md
2. content-creator extracts target audience, pain points, differentiators
3. content-creator applies AIDA formula for landing page:
   - **Attention**: Benefit-driven headline (6-12 words)
   - **Interest**: Subheadline (target audience + how it works)
   - **Desire**: 3-5 features with emotional benefits
   - **Action**: Specific CTA (2-5 words)
4. content-creator writes social proof section (testimonials or "Join waitlist" if pre-launch)
5. content-creator writes FAQ section (5 Q&As addressing objections)
6. content-creator creates 7 Google ad copy variants (different angles: pain, speed, simplicity, price, social proof, question, urgency)
7. content-creator creates 5 Facebook ad copy variants
8. content-creator verifies all copy within character limits (Google: 30/90, Facebook: 125/27)

**Output**: Copy content (not file, provided in agent output for next agents)

**Quality Gate**:
<quality_check>
  Copy must include:
  - ✅ Headline (benefit-driven, specific)
  - ✅ Subheadline (target audience mentioned)
  - ✅ 3-5 features (FAB format: Feature → Advantage → Benefit)
  - ✅ Specific CTA (action verb, not "Submit")
  - ✅ 7+ Google ad variants (within 30/90 char limits)
  - ✅ 5+ Facebook ad variants (within 125/27 char limits)
  - ✅ FAQ (5 questions, objections addressed)

  IF any element weak or missing:
    RETURN to content-creator for improvement
  ELSE:
    PROCEED to step 8
</quality_check>

</step>

<step number="8" subagent="seo-specialist" name="seo_optimization">

### Step 8: SEO Optimization

Delegate to seo-specialist agent to optimize copy for search engines.

**Process**:
1. seo-specialist receives copy from content-creator
2. seo-specialist receives product positioning from market-researcher
3. seo-specialist conducts keyword research (Perplexity or WebSearch):
   - Primary keyword (highest volume, medium difficulty)
   - 3-5 secondary keywords
   - 5-10 long-tail keywords (lower difficulty, easier to rank)
4. seo-specialist creates optimized title tag (50-60 chars, keyword-rich)
5. seo-specialist creates optimized meta description (150-160 chars, includes CTA)
6. seo-specialist creates Open Graph tags (social sharing optimization)
7. seo-specialist creates Twitter Card tags
8. seo-specialist integrates keywords into copy naturally (1-2% density)
9. seo-specialist provides image alt text specifications
10. seo-specialist creates heading hierarchy (H1 → H2 → H3)
11. seo-specialist provides technical SEO checklist for web-developer

**Output**: SEO specifications (not file, provided in agent output)

**Quality Gate**:
<quality_check>
  SEO specs must include:
  - ✅ Title tag (50-60 chars, primary keyword)
  - ✅ Meta description (150-160 chars, CTA included)
  - ✅ OG tags (complete: title, description, image specs)
  - ✅ Keywords integrated naturally (no stuffing)
  - ✅ Heading hierarchy (H1 → H2 → H3 logical)
  - ✅ Image alt text (for all images)
  - ✅ Technical SEO checklist (semantic HTML, responsive, etc.)

  IF incomplete or keyword-stuffed:
    RETURN to seo-specialist for refinement
  ELSE:
    PROCEED to step 9
</quality_check>

</step>

<step number="9" name="design_system_extraction">

### Step 9: Design System Extraction (User Input)

Ask user if they want to provide a design reference for the landing page, then use design-system-extractor skill to create project-specific frontend-design skill.

**Prompt User**:
```
Would you like to provide a design reference for your landing page?

This helps create a landing page that matches your preferred style.

Options:
1. Provide URL of a website you like (I'll analyze colors, fonts, layout)
2. Provide screenshot/mockup (I'll extract design system)
3. Use default clean minimal design (professional, conversion-optimized)
```

<conditional_logic>
  IF user provides URL:
    <url_analysis>
      ACTION: Load design-system-extractor skill
      CONTEXT: Design-system-extractor skill provides framework for extraction

      STEP 1: Analyze URL with WebFetch
        TOOL: WebFetch
        URL: [USER_PROVIDED_URL]
        PROMPT: Use design-system-extractor skill Step 1 Option A prompt template
        EXTRACT:
          - Color palette (primary, secondary, accent, backgrounds, text colors)
          - Typography (font families, sizes, weights, line heights)
          - Spacing system (base unit, section padding, container widths)
          - Component styles (buttons, cards, inputs, border radius)
          - Visual effects (shadows, gradients, animations)
          - Layout patterns (grid, breakpoints, section layouts)

      STEP 2: Load official frontend-design skill template
        SOURCE: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/frontend-design/skills/frontend-design/SKILL.md
        ACTION: Fetch template content

      STEP 3: Generate project-specific frontend-design skill
        ACTION: Follow design-system-extractor skill Step 3
        MERGE: Official skill framework + Extracted UI tokens
        STRUCTURE:
          - Keep original frontmatter (name: frontend-design, description, globs)
          - ADD: "Project Design System" section with extracted tokens
          - KEEP: All original principles (Typography, Color, Motion, Spatial, Visual)
          - KEEP: All original guardrails
          - UPDATE: Examples to use extracted tokens

      STEP 4: Save project-specific skill
        LOCATION: .claude/skills/frontend-design.md
        FORMAT: Complete SKILL.md with frontmatter

      PROCEED: To step 10
    </url_analysis>

  ELIF user provides screenshot/image path:
    <screenshot_analysis>
      ACTION: Load design-system-extractor skill
      CONTEXT: Design-system-extractor skill provides framework for extraction

      STEP 1: Analyze screenshot
        TOOL: Read (image file)
        FILE: [USER_PROVIDED_IMAGE_PATH]

        THEN: Use Task tool with general-purpose subagent
        PROMPT: Use design-system-extractor skill Step 1 Option B prompt template
        ATTACH: Reference images to subagent
        EXTRACT:
          - Color palette (identify hex codes from image)
          - Typography (font style, sizes, weights)
          - Spacing and layout (measure consistent gaps)
          - Component design (buttons, cards, forms)
          - Visual effects (shadows, gradients, border radius)
          - Overall aesthetic (minimal, bold, playful, etc.)
        SAVE: design-system-extracted.md

      STEP 2: Load official frontend-design skill template
        SOURCE: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/frontend-design/skills/frontend-design/SKILL.md
        ACTION: Fetch template content

      STEP 3: Generate project-specific frontend-design skill
        ACTION: Follow design-system-extractor skill Step 3
        MERGE: Official skill framework + Extracted UI tokens from design-system-extracted.md
        STRUCTURE: Same as URL analysis

      STEP 4: Save project-specific skill
        LOCATION: .claude/skills/frontend-design.md

      PROCEED: To step 10
    </screenshot_analysis>

  ELSE (user chooses default):
    <default_design>
      STEP 1: Use default design tokens
        TOKENS:
          - Colors: Primary #4a9eff, Accent #ff6b35, Background #ffffff
          - Fonts: System fonts (system-ui, -apple-system, sans-serif)
          - Spacing: Base unit 8px
          - Border radius: 8px
          - Layout: Clean minimal, conversion-optimized

      STEP 2: Load official frontend-design skill template
        SOURCE: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/frontend-design/skills/frontend-design/SKILL.md

      STEP 3: Generate project-specific frontend-design skill
        MERGE: Official skill + Default tokens
        NOTE: Default tokens are minimal (let official skill principles guide)

      STEP 4: Save project-specific skill
        LOCATION: .claude/skills/frontend-design.md

      PROCEED: To step 10
    </default_design>
</conditional_logic>

<output_verification>
  VERIFY: .claude/skills/frontend-design.md created
  CONTENT: Must include:
    - Frontmatter with name: frontend-design
    - Project Design System section with extracted tokens
    - All original frontend-design skill principles
    - All original guardrails

  IF missing or incomplete:
    RETRY: Generation with more explicit instructions
</output_verification>

**Generated Skill Location**: `.claude/skills/frontend-design.md`

**This skill will be used by**: web-developer agent in Step 10

</step>

<step number="10" subagent="web-developer" name="landing_page_generation">

### Step 10: Landing Page Generation

Delegate to web-developer agent to create production-ready HTML/CSS/JS landing page with design template integration.

**Process**:
1. web-developer receives copy from content-creator
2. web-developer receives SEO specs from seo-specialist
3. web-developer receives design specs from step 9 (user-provided or default)
4. web-developer applies design system (colors, fonts, button styles from design specs)
5. web-developer generates HTML5 structure with semantic tags
6. web-developer integrates all copy (headline, features, social proof, FAQ, CTA)
7. web-developer implements all SEO meta tags
8. web-developer creates responsive CSS (mobile-first, Flexbox/Grid)
9. web-developer implements JavaScript (form validation, analytics tracking placeholders)
10. web-developer optimizes performance (<3 sec load, <30KB total)
11. web-developer creates self-contained index.html (inline CSS/JS, no external dependencies)
12. web-developer saves to landing-page/index.html

**Output**: `@agent-os/market-validation/YYYY-MM-DD-product-name/landing-page/index.html`

**Quality Gate**:
<quality_check>
  Landing page must:
  - ✅ Be valid HTML5 (passes W3C validator)
  - ✅ Be responsive (mobile, tablet, desktop)
  - ✅ Load fast (<3 sec, <30KB)
  - ✅ Be self-contained (single index.html file)
  - ✅ Have working form (validation, submission handler)
  - ✅ Include all SEO meta tags
  - ✅ Design specs applied correctly (if provided)

  IF fails quality check:
    RETURN to web-developer for fixes
  ELSE:
    PROCEED to step 10.5 (visual validation)
</quality_check>

</step>

<step number="10.5" name="visual_validation">

### Step 10.5: Visual Validation (Chrome DevTools MCP)

Use Chrome DevTools MCP to validate landing page visually before proceeding.

**Purpose**: Catch visual issues like broken videos, missing images, layout problems BEFORE user deploys.

**Process**:

<conditional_logic>
  IF Chrome DevTools MCP available:
    1. Use MCP to render landing page in headless Chrome
    2. Take screenshot (desktop view)
    3. Take screenshot (mobile view)
    4. Check for console errors
    5. Verify all elements render correctly:
       - Headlines visible and styled?
       - Buttons visible and clickable?
       - Form elements present?
       - No broken images/videos?
       - Layout not broken?
    6. If issues found:
       - Document specific problems
       - RETURN to web-developer with issues
       - web-developer fixes
       - RETRY visual validation
    7. If all good:
       - PROCEED to step 11

  ELSE (Chrome DevTools MCP not available):
    WARN user: "Visual validation skipped (Chrome DevTools MCP not available)"
    INFORM user: "Please test landing page manually after deployment"
    PROCEED to step 11
</conditional_logic>

**Common Issues to Catch**:
- Embedded YouTube videos not loading (remove or replace with image)
- External images with broken links (use emoji icons instead)
- CSS not applied (inline CSS missing)
- JavaScript errors (form handler broken)
- Mobile layout broken (elements overlapping)
- Colors not from design template (if provided)

**If Issues Found** (example):
```
Visual Validation FAILED:
❌ YouTube iframe not loading (external dependency)
❌ Hero image 404 (broken link)
⚠️ Button color doesn't match design template (#ff6b35 expected, #ff0000 used)

Returning to web-developer with fixes:
- Remove YouTube embed, use static image or text description
- Replace hero image with emoji or remove
- Correct button color to match design template
```

</step>

<step number="11" name="budget_and_timeline_questions">

### Step 11: Budget and Timeline Selection (User Input)

Ask user for validation budget and timeline before creating campaign plans.

**Prompt User with AskUserQuestion**:

```typescript
AskUserQuestion({
  questions: [
    {
      question: "What is your total budget for this validation campaign?",
      header: "Ad Budget",
      multiSelect: false,
      options: [
        {
          label: "€300 (Starter)",
          description: "Good for niche products with low expected CPA. May not reach full statistical significance."
        },
        {
          label: "€500 (Recommended)",
          description: "Sweet spot for most products. Adequate for 1,000+ visitors and 50+ conversions at 5% rate."
        },
        {
          label: "€1,000 (Confident)",
          description: "For competitive markets. Robust data with 2,000+ visitors and 100+ conversions."
        },
        {
          label: "€2,000 (Aggressive)",
          description: "Maximum confidence. 3,000-4,000 visitors. Use for high-stakes validation."
        }
      ]
    },
    {
      question: "How long do you want to run the validation campaign?",
      header: "Timeline",
      multiSelect: false,
      options: [
        {
          label: "2 weeks (Fast)",
          description: "Fastest feedback. Risk: May not reach significance or capture weekly variance. Minimum recommended."
        },
        {
          label: "3 weeks (Balanced)",
          description: "Good balance of speed and data quality. Likely reaches 1,000+ visitors."
        },
        {
          label: "4 weeks (Recommended)",
          description: "Robust data with weekly variance captured. Best for most validations."
        },
        {
          label: "6 weeks (Extended)",
          description: "Maximum confidence with 2,000+ visitors. Use for competitive markets or when certainty is critical."
        }
      ]
    }
  ]
})
```

**Store User Choices**:
- Budget: €[SELECTED_AMOUNT]
- Timeline: [SELECTED_WEEKS] weeks

**Calculate Daily Budget**:
```
Daily Budget = Total Budget ÷ (Weeks × 7 days)

Example:
€500 ÷ (4 weeks × 7 days) = €500 ÷ 28 = €17.86/day
```

**PROCEED to step 12** with budget and timeline for validation-specialist

</step>

<step number="12" subagent="validation-specialist" name="campaign_coordination">

### Step 12: Validation Campaign Coordination

Delegate to validation-specialist agent to create complete validation campaign package.

**Process**:
1. validation-specialist receives all previous outputs (product-brief, competitor-analysis, positioning, landing-page)
2. validation-specialist receives budget and timeline from step 11 (user-provided)
3. validation-specialist calculates budget allocation from user's total budget:
   - Google Ads: 60% of total
   - Meta Ads: 30% of total
   - Reserve: 10% of total
   - Daily budgets: Total ÷ (Weeks × 7)
4. validation-specialist applies validation-plan.md template:
   - Timeline: [USER_SELECTED_WEEKS] weeks (from step 11)
   - Budget: €[USER_SELECTED_BUDGET] (from step 11)
   - Budget breakdown: Calculated allocations
   - Success criteria: GO/MAYBE/NO-GO thresholds
   - Risk mitigation strategies
5. validation-specialist applies ad-campaigns.md template:
   - Integrates all ad copy from content-creator
   - Adds campaign structure (budgets, targeting, keywords)
   - Provides step-by-step setup instructions for Google Ads
   - Provides step-by-step setup instructions for Facebook Ads
   - Adds UTM parameters for tracking
   - Includes troubleshooting guide
5. validation-specialist applies analytics-setup.md template:
   - GA4 setup instructions (property → tracking code → conversion event)
   - Meta Pixel setup instructions (if using Facebook)
   - Heatmap tool recommendation (Microsoft Clarity)
   - Dashboard design (key metrics)
   - Daily monitoring checklist
6. validation-specialist creates execution checklist (pre-launch, weekly, post-campaign)

**Output**:
- `@agent-os/market-validation/YYYY-MM-DD-product-name/ad-campaigns.md`
- `@agent-os/market-validation/YYYY-MM-DD-product-name/analytics-setup.md`
- `@agent-os/market-validation/YYYY-MM-DD-product-name/validation-plan.md`

**Quality Gate**:
<quality_check>
  Validation package must include:
  - ✅ Complete ad campaigns (7+ Google variants, 5+ Facebook variants)
  - ✅ Step-by-step setup instructions (beginner-friendly)
  - ✅ Budget allocation (realistic, adds up to total)
  - ✅ Success criteria (GO/MAYBE/NO-GO defined)
  - ✅ Analytics setup (GA4 + heatmap + pixel if needed)
  - ✅ Execution checklist (25+ items)
  - ✅ All templates fully filled (no empty placeholders)

  IF incomplete:
    RETURN to validation-specialist for completion
  ELSE:
    PROCEED to step 11
</quality_check>

</step>

<step number="13" name="user_execution_phase">

### Step 13: User Deployment & Campaign Execution

Inform user of validation campaign execution process.

**Summary for User**:
```markdown
## Validation Campaign Package Ready ✅

All files have been created for your validation campaign:

**Generated Files**:
1. **product-brief.md** - Your sharpened product definition
2. **competitor-analysis.md** - 5-10 competitors analyzed
3. **market-positioning.md** - Strategic positioning
4. **landing-page/index.html** - Production-ready landing page
5. **ad-campaigns.md** - Complete ad campaign plans (Google + Facebook)
6. **analytics-setup.md** - Analytics configuration guide
7. **validation-plan.md** - Timeline, budget, success criteria

**Next Steps** (follow in order):

**Immediate (Day 0) - ~1 hour total**:
1. Follow **analytics-setup.md** to install tracking (30 min)
   - Create Google Analytics 4 property
   - Add tracking code to landing page
   - Install Meta Pixel (if using Facebook Ads)
   - Install heatmap tool (Clarity or Hotjar)
   - Test: Submit form, verify conversion tracked

2. Follow **ad-campaigns.md** setup instructions (30 min)
   - Create Google Ads account
   - Create Facebook Ads account
   - Add payment methods
   - Verify accounts approved

3. Deploy landing page (10-15 min)
   - Option 1 (easiest): Drag index.html to Netlify
   - Option 2: Use Vercel CLI
   - Option 3: GitHub Pages
   - Get live URL

**Day 1 (Campaign Launch) - ~1 hour**:
1. Create Google Search campaign (follow ad-campaigns.md)
2. Create Facebook Feed campaign (follow ad-campaigns.md)
3. Launch both campaigns
4. Verify ads are live (check preview)
5. Verify tracking works (submit test conversion in GA4 Realtime)

**Weeks 1-4 (Monitoring) - ~5-10 min/day**:
1. Check daily metrics (traffic, conversions, spend, CPA)
2. Weekly optimization (pause underperformers, boost winners)
3. Respond to any user comments/questions on ads
4. Collect qualitative feedback (reply to signups with "What made you sign up?")

**Week 4 (End of Campaign) - ~30 min**:
1. Pause all campaigns
2. Compile final metrics from GA4 and ad platforms
3. Gather all user feedback
4. Run next step to provide metrics for analysis

**What You'll Need from Ad Platforms**:
- Total visitors (from Google Analytics)
- Total conversions (email signups)
- Total ad spend (from Google Ads + Facebook Ads)
- Traffic source breakdown (Google vs. Facebook)
- Any user feedback received

**Questions?** Review validation-plan.md for detailed timeline and FAQs.
```

**PAUSE WORKFLOW**: Wait for user to execute campaign (2-4 weeks)

**User Indicates Readiness**:
```
When campaign complete (2-4 weeks later), user says:
"I have the validation metrics" or "Campaign complete" or "Ready for analysis"

→ PROCEED to step 12
```

<conditional_logic>
  IF user says "skip campaign, just show me the plan":
    INFORM user: "Validation package created. Follow validation-plan.md to execute."
    INFORM user: "Return when you have metrics and run: 'Analyze validation results' or 'I have validation metrics'"
    EXIT workflow
    NOTE: User can resume later with metrics

  ELIF user wants to proceed immediately to analysis (has run campaign elsewhere):
    PROCEED to step 12

  ELSE:
    WAIT for user confirmation that campaign is complete
    PROCEED to step 12
</conditional_logic>

</step>

<step number="14" name="collect_validation_metrics">

### Step 14: Collect Validation Metrics

Request validation metrics from user.

**Prompt User**:
```markdown
Please provide your validation campaign results:

**Required Metrics**:
1. **Total Visitors**: [#] (from Google Analytics)
2. **Total Conversions**: [#] email signups
3. **Total Ad Spend**: €[X] (Google + Facebook total)

**Optional but Valuable**:
4. **Traffic Sources**: Google [#], Facebook [#], Direct [#]
5. **Campaign Duration**: [X] weeks
6. **User Feedback**: Any comments, emails, or responses from signups

**Example**:
```
Total Visitors: 1,000
Total Conversions: 62 email signups
Total Ad Spend: €500
Google: 600 visitors
Facebook: 300 visitors
Direct: 100 visitors
Duration: 3 weeks
Feedback: "30 email responses, mostly positive"
```
```

**Store Metrics**: Save for business-analyst analysis

<conditional_logic>
  IF user provides complete metrics:
    PROCEED to step 13

  ELIF user provides partial metrics (only visitors + conversions):
    WARN user: "For best analysis, please also provide ad spend and traffic sources"
    OFFER: "Continue with available data (lower confidence) OR wait for complete data?"
    IF user chooses continue:
      PROCEED to step 13 with partial data
    ELSE:
      WAIT for complete data
      PROCEED to step 13

  ELSE (user provides no metrics):
    PROVIDE data collection template
    WAIT for user to gather data
    PROCEED to step 13 when ready
</conditional_logic>

</step>

<step number="15" subagent="business-analyst" name="results_analysis">

### Step 15: Validation Results Analysis & GO/NO-GO Decision

Delegate to business-analyst agent to analyze metrics and make data-driven recommendation.

**Process**:
1. business-analyst receives validation metrics from user (step 12)
2. business-analyst loads validation-plan.md for success criteria thresholds
3. business-analyst loads competitor-analysis.md for TAM data
4. business-analyst calculates conversion rate:
   - Formula: (Conversions ÷ Visitors) × 100%
   - Example: (62 ÷ 1,000) × 100% = 6.2%
5. business-analyst calculates CPA:
   - Formula: Ad Spend ÷ Conversions
   - Example: €500 ÷ 62 = €8.06
6. business-analyst retrieves TAM from competitor-analysis.md
7. business-analyst creates decision matrix:
   - Compare each metric to threshold
   - Status: ✅ Met / ❌ Not Met
   - Calculate how many criteria met (0-3)
8. business-analyst applies decision logic:
   - 3/3 criteria met → GO
   - 2/3 criteria met → MAYBE
   - 1/3 criteria met → MAYBE (weak)
   - 0/3 criteria met → NO-GO
9. business-analyst analyzes qualitative feedback (if provided):
   - Sentiment score
   - Thematic analysis
   - Feature requests
10. business-analyst generates validation-results.md from template
11. business-analyst provides specific next steps based on decision

**Output**: `@agent-os/market-validation/YYYY-MM-DD-product-name/validation-results.md`

**Quality Gate**:
<quality_check>
  Validation results must include:
  - ✅ Clear decision (GO/MAYBE/NO-GO with confidence %)
  - ✅ All 3 criteria analyzed (conversion, CPA, TAM)
  - ✅ Decision matrix (table with status)
  - ✅ Calculations shown (not just results)
  - ✅ Statistical significance assessed (sample size, confidence interval)
  - ✅ Qualitative feedback analyzed (if provided)
  - ✅ Specific next steps (actionable recommendations)
  - ✅ Financial projection (if GO decision)

  IF decision unclear or unsupported:
    RETURN to business-analyst for clearer recommendation
  ELSE:
    PROCEED to step 14
</quality_check>

**Decision Output Examples**:

**GO Decision**:
```
DECISION: GO ✅
Confidence: High (95%)
Criteria: 3/3 met
Next: Proceed to /plan-product immediately
```

**MAYBE Decision**:
```
DECISION: MAYBE ⚠️
Confidence: Medium (75%)
Criteria: 2/3 met (conversion slightly below)
Next: Test new headline, re-validate for 2 weeks with €300
```

**NO-GO Decision**:
```
DECISION: NO-GO ❌
Confidence: High (90%)
Criteria: 0/3 met
Next: Consider pivot to "payment reminders only" or abandon
Saved: €50,000 + 6 months (avoided building unwanted product)
```

</step>

<step number="16" name="integration_with_planning">

### Step 16: Integration with Product Planning

Provide guidance for next steps based on decision.

<conditional_logic>

  <!-- GO DECISION PATH -->
  IF decision == GO:

    INFORM user:
    ```
    🎉 Validation Successful - GO Decision!

    Your product idea has been validated with strong market demand.

    **Next Step**: Run /plan-product to create detailed product specification

    **Validation Results Will Inform Planning**:
    - Target audience (from product brief)
    - Core features (validated through feedback)
    - Positioning (from competitive analysis)
    - Marketing approach (winning ad copy, best channels)

    **Automatic Integration**:
    When you run /plan-product, the system will automatically load:
    - validation-results.md (metrics and decision)
    - product-brief.md (sharp product definition)
    - market-positioning.md (competitive positioning)
    - Qualitative feedback (feature priorities)

    Would you like to proceed to /plan-product now?
    ```

    <user_choice>
      IF user says yes/proceed:
        TRIGGER /plan-product workflow
        PASS validation context to planning workflow
      ELSE:
        INFORM: "Run /plan-product when ready. Validation results will be automatically loaded."
        EXIT workflow
    </user_choice>


  <!-- MAYBE DECISION PATH -->
  ELIF decision == MAYBE:

    INFORM user:
    ```
    ⚠️ Partial Validation - MAYBE Decision

    Your validation showed mixed results. Not a clear GO, but not a definitive NO-GO either.

    **Gaps Identified**:
    [List specific gaps from business-analyst]

    **Improvement Plan**:
    [Specific recommendations from business-analyst]

    **Re-Test Recommendation**:
    - Budget: €[X]
    - Duration: [Y] weeks
    - Changes: [List of improvements]
    - New Success Criteria: [Adjusted thresholds]

    **Options**:
    1. Implement improvements and re-test (recommended)
    2. Proceed to development anyway (risky, not recommended)
    3. Consider alternative approach or pivot

    What would you like to do?
    ```

    <user_choice>
      IF user chooses "re-test":
        INFORM: "Implement improvements listed in validation-results.md"
        INFORM: "When ready, run /validate-market again with refined approach"
        EXIT workflow

      ELIF user chooses "proceed anyway":
        WARN: "Proceeding without clear validation increases risk significantly"
        CONFIRM: "Are you sure you want to proceed to /plan-product?"
        IF confirmed:
          TRIGGER /plan-product workflow
          NOTE: "Proceeded despite MAYBE validation (user choice)"
        ELSE:
          EXIT workflow

      ELSE:
        INFORM: "Review validation-results.md for detailed analysis and recommendations"
        EXIT workflow
    </user_choice>


  <!-- NO-GO DECISION PATH -->
  ELSE (decision == NO-GO):

    INFORM user:
    ```
    ❌ Validation Failed - NO-GO Decision

    Based on validation data, proceeding with development is not recommended.

    **Why NO-GO**:
    [Specific reasons from business-analyst]

    **Value of This Validation**:
    - You invested: €[X] (ad spend) + [Y] hours (setup time)
    - You avoided: €50,000+ (development cost) + 6+ months (wasted time)
    - **Net Savings**: €[50,000-X] + 6 months

    This is a successful outcome! Better to learn now than after expensive development.

    **Alternative Approaches** (from business-analyst):
    [List of pivot options or alternative directions]

    **Learnings to Carry Forward**:
    [What worked, what didn't, insights for next idea]

    **Options**:
    1. Explore alternative approaches (pivot)
    2. Validate a different product idea (start fresh)
    3. Document learnings and move on

    What would you like to do?
    ```

    <user_choice>
      IF user chooses "explore alternatives":
        INFORM: "Review validation-results.md for pivot recommendations"
        INFORM: "When ready to test alternative, run /validate-market with new approach"
        EXIT workflow

      ELIF user chooses "new product idea":
        INFORM: "Great! When ready, run /validate-market with your new product idea"
        INFORM: "Learnings from this validation will inform the next attempt"
        EXIT workflow

      ELSE:
        INFORM: "Validation results documented in validation-results.md"
        INFORM: "Learnings preserved for future product development"
        EXIT workflow
    </user_choice>

</conditional_logic>

</step>

<step number="17" subagent="git-workflow" name="version_control">

### Step 17: Version Control (Optional)

Optionally commit validation artifacts to version control.

**Ask User**:
```
Would you like to commit these validation artifacts to Git?
- product-brief.md
- competitor-analysis.md
- market-positioning.md
- landing-page/index.html
- ad-campaigns.md
- analytics-setup.md
- validation-plan.md
- validation-results.md (if completed)

This preserves your research and allows tracking validation history.
```

<conditional_logic>
  IF user approves:
    USE git-workflow subagent to:
      - Add all files in market-validation/YYYY-MM-DD-product-name/
      - Commit with message: "Market validation for [PRODUCT_NAME] - [GO/MAYBE/NO-GO] decision"
      - Optionally create PR if user wants
    INFORM: "Validation artifacts committed to Git"
  ELSE:
    SKIP version control
    INFORM: "Files are in agent-os/market-validation/ directory"
</conditional_logic>

</step>

<step number="18" name="workflow_completion">

### Step 18: Workflow Completion Summary

Provide final summary of validation workflow.

**Summary**:
```markdown
## Market Validation Workflow Complete ✅

**Product**: [PRODUCT_NAME]

**Validation Artifacts Created**:
- ✅ Product Brief (sharp product definition)
- ✅ Competitive Analysis (5-10 competitors)
- ✅ Market Positioning (strategic positioning)
- ✅ Landing Page (production-ready HTML)
- ✅ Ad Campaigns (Google + Facebook plans)
- ✅ Analytics Setup (GA4 + tracking guide)
- ✅ Validation Plan (timeline, budget, criteria)
- [✅ Validation Results (GO/MAYBE/NO-GO decision)] (if campaign completed)

**Location**: @agent-os/market-validation/YYYY-MM-DD-product-name/

**Status**: [Current status based on decision]

**Next Action**: [Specific next step based on decision]
```

<decision_based_summary>

  IF decision == GO:
    ```
    **Validation Status**: ✅ SUCCESSFUL - Strong market demand validated

    **Key Metrics**:
    - Conversion: [X]% (Target: [Y]%) ✅
    - CPA: €[X] (Target: €[Y]) ✅
    - TAM: [X] (Target: [Y]) ✅

    **Next Step**: Proceed to /plan-product with validated demand and competitive insights

    **Timeline**: Ready to start product planning immediately
    ```

  ELIF decision == MAYBE:
    ```
    **Validation Status**: ⚠️ PARTIAL - Refinement needed

    **Gaps**: [List from business-analyst]

    **Next Step**: Implement improvements and re-test, or proceed with caution

    **Timeline**: 2-4 weeks for re-validation (if chosen)
    ```

  ELIF decision == NO-GO:
    ```
    **Validation Status**: ❌ NOT VALIDATED - Proceed not recommended

    **Value Delivered**: Saved €50,000+ and 6+ months by validating first

    **Next Step**: Explore alternative approaches or new product ideas

    **Learnings**: Documented in validation-results.md for future reference
    ```

  ELSE (campaign not yet run):
    ```
    **Validation Status**: 📋 READY FOR EXECUTION

    **Next Step**: Follow validation-plan.md to deploy landing page and launch campaigns

    **Timeline**: 2-4 weeks for data collection, then return for analysis

    **When Complete**: Run 'Analyze validation results' or 'I have validation metrics'
    ```

</decision_based_summary>

</step>

</process_flow>

## Execution Standards

### Sequential Coordination

**Agent Execution Order** (MVP - no parallel):
```
1. product-strategist (idea sharpening) → product-brief.md
2. market-researcher (competitive analysis) → competitor-analysis.md + market-positioning.md
3. content-creator (copywriting) → copy output
4. seo-specialist (optimization) → SEO specs output
5. web-developer (landing page) → index.html
6. validation-specialist (campaign coordination) → ad-campaigns.md + analytics-setup.md + validation-plan.md
7. [USER EXECUTES CAMPAIGN - 2-4 weeks]
8. business-analyst (results analysis) → validation-results.md + GO/NO-GO decision
```

**Each Agent**:
- Receives outputs from previous agents
- Has access to necessary context (product-brief, positioning)
- Produces specific deliverable(s)
- Hands off to next agent with clear summary

**No Parallel Execution** (Phase A MVP):
- Agents run one after another (sequential)
- Each completes before next starts
- Clear handoff points
- Simpler coordination, easier debugging

### Quality Gates

**After Each Agent**:
- Verify deliverable meets quality standards (checklist in each step)
- If quality insufficient → Return to agent for refinement
- If quality good → Proceed to next agent

**Final Quality Gate** (before user execution):
- All 7 files created
- All templates fully filled (no empty placeholders)
- Landing page is valid HTML
- Ad campaigns have setup instructions
- Analytics setup is complete
- Success criteria are defined

### Error Handling

**Perplexity Rate Limits**:
- Catch in market-researcher step
- Fall back to WebSearch
- Provide manual template if needed
- Don't block workflow

**Invalid HTML**:
- Catch in web-developer quality gate
- Return for fixes
- Verify with simple validation (check for closing tags)

**Incomplete Metrics**:
- Handle in step 12
- Work with partial data if needed
- Note limitations in confidence level

### User Interaction Points

**User Input Required** (workflow pauses):
1. **Step 2**: Product idea description (if not provided)
2. **Step 5**: Answer product-strategist's questions (4-5 questions)
3. **Step 10**: Validation budget confirmation (or use default €500)
4. **Step 11**: Execute campaign (2-4 weeks)
5. **Step 12**: Provide validation metrics
6. **Step 14**: Choose next action (GO → plan-product, MAYBE → re-test, NO-GO → pivot)

**User Can Skip/Modify**:
- Budget (provide own, or use recommended)
- Timeline (2-6 weeks, recommend 3-4)
- Success criteria (adjust thresholds if needed)

---

## Success Criteria

**Workflow is successful when**:
- ✅ User receives clear GO/MAYBE/NO-GO decision
- ✅ Decision is data-driven (not gut feel)
- ✅ All artifacts are professional quality
- ✅ Landing page is production-ready (deployable)
- ✅ Ad campaigns are execution-ready (user can follow instructions)
- ✅ User knows exactly what to do next

**Workflow is complete when**:
- All files generated
- User has executed campaign OR has validation package ready
- GO/NO-GO decision provided (if campaign completed)
- Next steps clear (plan-product, re-test, or pivot)

---

**Use this workflow when**: User wants to validate product-market fit before committing to development.

**Expected Duration**:
- Workflow execution: 15-20 minutes (automated)
- User campaign execution: 2-4 weeks (manual)
- Total time to decision: 2-4 weeks + 20 minutes

**Expected Outputs**: 7-8 files (product-brief, competitor-analysis, market-positioning, landing-page/index.html, ad-campaigns, analytics-setup, validation-plan, validation-results)
