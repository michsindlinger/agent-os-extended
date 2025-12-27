# Agent OS Extended v2.0

> **Note**: This repository is based on the original [Agent OS](https://github.com/buildermethods/agent-os) by Builder Methods. This extended version includes enhancements specifically designed for enterprise project development.

Agent OS Extended is a project-level implementation of the Agent OS system, designed to improve AI coding workflows through structured context and guidance. Unlike the original global installation, this version installs configuration files directly within each project.

## What's New in v2.0

### Phase I: Structural Improvements
- **Improved directory structure** - `agent-os/` (visible) instead of `.agent-os/` (hidden)
- **Clearer naming** - `workflows/` instead of `instructions/` for better semantics
- **Command isolation** - Commands organized in `.claude/commands/agent-os/` namespace
- **Migration tools** - Automated migration from v1.x with rollback support
- **Enhanced workflow organization** - Better structure for complex projects

### Phase II: Advanced Features

**Profile System**
- Tech-stack-specific profiles (Java Spring Boot, React, Angular)
- Profile inheritance (all profiles inherit from base)
- Automatic skill loading based on active profile
- Flexible profile switching per project

**Skills System**
- 11 contextual Claude Code Skills that activate automatically
- 60-80% context reduction vs loading all standards
- Trigger-based activation (file type, content, task mentions)
- Skills organized by tech stack:
  - Base: security-best-practices, git-workflow-patterns
  - Java: java-core-patterns, spring-boot-conventions, jpa-best-practices
  - React: react-component-patterns, react-hooks-best-practices, typescript-react-patterns
  - Angular: angular-component-patterns, angular-services-patterns, rxjs-best-practices

**Enhanced Research Phase**
- Automatic codebase pattern analysis
- Interactive Q&A for requirements clarification
- Visual asset integration (mockups, wireframes, screenshots)
- Research documentation alongside specs
- Informed specifications based on existing architecture

**Verification System**
- Spec Verification: 30 checkpoints for specification completeness
- Implementation Verification: 24 checkpoints for code quality
- Visual Verification: 38 checkpoints for UI/design matching
- Quality gates at each development phase
- Automated reporting with pass/fail/warning status

**Market Validation System (Phase A) 🆕**
- Validate product-market fit BEFORE expensive development
- 7 specialist agents (product-strategist, market-researcher, content-creator, seo-specialist, web-developer, validation-specialist, business-analyst)
- Product idea sharpening through interactive Q&A
- Competitive analysis using Perplexity MCP
- Production-ready landing page generation (HTML/CSS/JS)
- Ad campaign planning (Google Ads, Meta Ads)
- Analytics setup (Google Analytics 4, conversion tracking)
- Data-driven GO/NO-GO decisions (conversion rate, CPA, TAM)
- 6 new skills (product strategy, market research, business analysis, validation, copywriting, SEO)
- Complete validation in 2-4 weeks for €100-€2,000

## Key Differences from Original Agent OS

- **Project-level installation** instead of global `~/agent-os/` installation
- **Enterprise-focused enhancements** for complex project development
- **Project-specific customization** allowing different standards per project
- **v2.0 structure alignment** with visible directories and clearer naming

## Quick Start

### Base Installation
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash
```

### Tool-Specific Setup

#### Claude Code
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash
```

#### Cursor
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-cursor.sh | bash
```

#### Gemini CLI
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-gemini.sh | bash
```

## Migration from v1.x to v2.0

If you have an existing project using Agent OS Extended v1.x (`.agent-os/` structure), migrate in two steps:

### Step 1: Structural Migration (Phase I)

```bash
# Migrate directory structure to v2.0
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-to-v2.sh | bash
```

**What Phase I migration does:**
- Renames `.agent-os/` → `agent-os/`
- Renames `instructions/` → `workflows/`
- Moves commands to `.claude/commands/agent-os/`
- Updates all file references automatically
- Creates timestamped backup for safety

### Step 2: Phase II Features (Optional)

```bash
# Add advanced features (profiles, skills, research, verification)
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-to-v2-phase2.sh | bash
```

**What Phase II adds:**
- Profile System (4 profiles: Java, React, Angular, Base)
- Skills System (11 contextual skills)
- Enhanced Research (codebase analysis, Q&A, visuals)
- Verification System (spec, implementation, visual)
- Enhanced /create-spec workflow

### Rollback if needed:

```bash
# Rollback Phase I migration
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/rollback-v2-migration.sh | bash
```

## Updates

### Main Update Script
Update your Agent OS Extended installation (recommended):
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-agent-os.sh | bash
```
*Includes: workflows, commands, standards, and automatic tool detection*

### Selective Updates
For specific component updates only:

```bash
# Standards only
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-standards.sh | bash

# Workflows only
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-workflows.sh | bash
```

## Project Structure (v2.0)

After installation, your project will contain:

```
your-project/
├── CLAUDE.md (Claude Code configuration)
├── agent-os/                                    # ← Visible directory (v2.0)
│   ├── specs/                                   # Feature specifications
│   │   └── YYYY-MM-DD-feature-name/            # Timestamped specs
│   ├── docs/                                    # User documentation
│   ├── bugs/                                    # Bug tracking
│   ├── standards/                               # Coding standards
│   │   ├── tech-stack.md
│   │   ├── code-style.md
│   │   ├── best-practices.md
│   │   └── code-style/
│   │       ├── javascript-style.md
│   │       ├── css-style.md
│   │       └── html-style.md
│   └── workflows/                               # ← Renamed from instructions/
│       ├── core/                                # Core workflows
│       │   ├── analyze-product.md
│       │   ├── analyze-b2b-application.md
│       │   ├── create-spec.md
│       │   ├── create-bug.md
│       │   ├── execute-bug.md
│       │   ├── update-feature.md
│       │   ├── document-feature.md
│       │   ├── retroactive-doc.md
│       │   ├── update-changelog.md
│       │   ├── execute-task.md
│       │   ├── execute-tasks.md
│       │   ├── plan-product.md
│       │   ├── plan-b2b-application.md
│       │   ├── init-base-setup.md
│       │   ├── validate-base-setup.md
│       │   └── extend-setup.md
│       └── meta/
│           └── pre-flight.md
├── .claude/                                     # Claude Code specific
│   ├── commands/
│   │   └── agent-os/                           # ← Isolated namespace (v2.0)
│   │       ├── plan-product.md
│   │       ├── plan-b2b-application.md
│   │       ├── start-brainstorming.md
│   │       ├── transfer-and-create-spec.md
│   │       ├── create-spec.md
│   │       ├── execute-tasks.md
│   │       └── ... (all commands)
│   └── agents/
│       ├── test-runner.md
│       ├── context-fetcher.md
│       ├── git-workflow.md
│       ├── file-creator.md
│       └── date-checker.md
├── .cursor/rules/                               # Cursor specific
│   ├── plan-product.mdc
│   ├── create-spec.mdc
│   └── execute-tasks.mdc
├── .gemini/                                     # Gemini CLI specific
│   ├── tools/
│   └── workflows/
└── GEMINI.md (Gemini CLI context)
```

**Key Changes in v2.0:**
- `agent-os/` is visible (no dot prefix) for better discoverability
- `workflows/` replaces `instructions/` for clearer semantics
- Commands organized in `.claude/commands/agent-os/` namespace

## Usage

### With Claude Code
Use commands like:

#### Base Setup & Project Initialization
- `/init-base-setup` - Initialize project with pre-configured templates (Next.js + shadcn + Tailwind + Supabase)
- `/validate-base-setup` - AI-powered validation of your setup with security and performance checks
- `/extend-setup` - Add modular extensions (authentication, database, UI components, etc.)

#### Feature Development & Management
- `/plan-product`, `/analyze-product` - Product planning and analysis
- `/start-brainstorming` - Interactive idea exploration before formal documentation
- `/brainstorm-upselling-ideas` - Generate strategic upselling and cross-selling opportunities
- `/transfer-and-create-spec`, `/transfer-and-create-bug`, `/transfer-and-plan-product` - Convert brainstorming sessions to formal specs/bugs/product plans
- `/create-spec`, `/update-feature`, `/document-feature`, `/retroactive-doc` - Feature lifecycle management
- `/create-bug`, `/execute-bug` - Bug management and resolution
- `/update-changelog` - Automatic changelog generation from documented features and resolved bugs
- `/execute-tasks` - Implementation execution
- `/plan-b2b-application`, `/analyze-b2b-application` - B2B application workflows

### With Cursor
Use commands like `@plan-product`, `@create-spec`, `@execute-tasks`, `@analyze-product`, `@plan-b2b-application`, and `@analyze-b2b-application`.

### With Gemini CLI
Reference tools in conversations:
- "Use the create-spec tool to create a feature specification"
- "Follow the analyze-product tool to analyze requirements"
- "Execute the init-base-setup tool to initialize the project"

## Feature Management System

Agent OS Extended includes a comprehensive Feature Lifecycle Management System:

### 🔄 Complete Workflows

1. **New Feature Development**
   ```
   /create-spec → Development → /document-feature
   ```
   - Creates timestamped spec in `agent-os/specs/YYYY-MM-DD-feature-name/`
   - Generates user documentation in `agent-os/docs/Feature-Name/`

2. **Feature Updates**
   ```
   /update-feature → Development → /document-feature
   ```
   - Adds comprehensive change tracking in `specs/feature/changes/`
   - Updates existing documentation with new capabilities

3. **Retroactive Documentation**
   ```
   /retroactive-doc
   ```
   - Perfect for existing projects with undocumented features
   - Analyzes existing code to generate both specs and user documentation
   - Ideal for documenting legacy features step by step

4. **Bug Management**
   ```
   /create-bug → /execute-bug
   ```
   - Interactive bug reporting with structured documentation
   - Systematic investigation and resolution workflow
   - Root cause analysis and solution tracking
   - Comprehensive resolution documentation

5. **Brainstorming & Ideation**
   ```
   /start-brainstorming
   /brainstorm-upselling-ideas
   /transfer-and-create-spec
   /transfer-and-create-bug
   /transfer-and-plan-product
   ```
   - Interactive brainstorming sessions for exploring ideas before formal documentation
   - Generate upselling opportunities based on project analysis
   - Automatic gap detection when transferring to specs/bugs/product plans
   - Intelligent questionnaire to fill missing information
   - Preserves brainstorming context and decisions

6. **Changelog Management**
   ```
   /update-changelog
   ```
   - Automatic changelog generation from documented features and resolved bugs
   - Tracks features and bug fixes since last update with intelligent date filtering
   - Bilingual support (German/English) with proper categorization
   - Includes main features, sub-features, and bug fixes in chronological order

7. **Market Validation** 🆕
   ```
   /validate-market
   ```
   - Validate market demand BEFORE development (save €50k+ and 6 months)
   - Product idea sharpening through interactive Q&A
   - Competitive analysis (5-10 competitors via Perplexity MCP)
   - Production-ready landing page (HTML/CSS/JS, self-contained)
   - Ad campaign plans (Google Ads + Meta Ads with setup guides)
   - Analytics setup (GA4, conversion tracking, heatmaps)
   - Data-driven GO/NO-GO decision (conversion rate, CPA, TAM)
   - 7 specialist agents coordinated sequentially
   - Complete validation in 2-4 weeks for €100-€2,000

### 📁 Directory Structure

- **`agent-os/specs/`** - Development-oriented specifications (timestamped, includes change history)
- **`agent-os/docs/`** - User-oriented documentation (hierarchical, feature-focused)
- **`agent-os/bugs/`** - Bug tracking with investigation, reproduction, and resolution documentation
- **`agent-os/brainstorming/`** - Brainstorming sessions for feature and bug ideation
- **`agent-os/market-validation/`** - Market validation campaigns (product briefs, competitor analysis, landing pages, results) 🆕

## Customization

### CLAUDE.md Configuration
The setup script installs a `CLAUDE.md` template that needs project-specific customization:

- Replace `[PROJECT_NAME]` with your project name
- Add your specific development agents and tech stack
- Configure MCP server integrations  
- Define production safety rules
- Add essential project commands

If you already have a `CLAUDE.md`, the script creates `CLAUDE.md.template` for reference.

## Enterprise Features

This extended version provides additional capabilities for enterprise development:

- **Project-specific configuration management** - Each project maintains its own Agent OS configuration
- **B2B Enterprise Planning** - Specialized workflows for B2B application development
- **Compliance & Security Integration** - Built-in support for regulatory requirements (GDPR, SOX, HIPAA)
- **Enterprise Integration Strategy** - Structured approach to system integration and migration
- **Enhanced workflow automation** - Enterprise-grade development processes
- **Scalable team collaboration patterns** - Multi-stakeholder coordination support

## Market Validation System (Phase A) 🆕

**Validate product-market fit BEFORE committing to expensive development.**

### Installation

The Market Validation System supports **global installation** (recommended) with **project-specific overrides**.

#### Global Installation (Recommended)

Install once, use in all projects:

```bash
# Install market validation to ~/.agent-os/ and ~/.claude/
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-market-validation-global.sh | bash
```

**What This Installs**:
- 6 skills → `~/.agent-os/skills/product/`, `~/.agent-os/skills/business/`, `~/.agent-os/skills/marketing/`
- 7 templates → `~/.agent-os/templates/market-validation/`
- 1 workflow → `~/.agent-os/workflows/validation/validate-market.md`
- 7 agents → `~/.claude/agents/` (product-strategist, market-researcher, etc.)
- 1 command → `~/.claude/commands/agent-os/validate-market.md`

**Then in Each Project**:
```bash
cd your-project
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-market-validation-project.sh | bash
```

Creates: `agent-os/market-validation/` directory for project-specific validation results.

**Benefits**:
- ✅ Install once, use everywhere
- ✅ Updates propagate to all projects (update global, all benefit)
- ✅ Project-specific results (validation campaigns stored per project)
- ✅ Override when needed (copy global → local, customize)

#### Project-Specific Installation (Alternative)

Install everything locally in one project:

```bash
cd your-project
# Run existing setup.sh (already includes market validation)
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash
```

**What This Does**:
- Installs all components to `projekt/agent-os/` and `projekt/.claude/`
- Self-contained (no global dependencies)
- Useful for: Testing, isolated environments, per-project customization

### Override Mechanism

**Global Default** (works for 95% of cases):
```
User runs: /validate-market
System uses: ~/.claude/agents/market-researcher.md (global)
```

**Project Override** (when customization needed):
```bash
# Copy global agent to project
cp ~/.claude/agents/market-researcher.md .claude/agents/

# Customize for this project
vim .claude/agents/market-researcher.md
# Add: Pharma-specific compliance checks

# Next time you run /validate-market in THIS project:
System uses: projekt/.claude/agents/market-researcher.md (local override)

# Other projects still use:
System uses: ~/.claude/agents/market-researcher.md (global default)
```

**Lookup Order** (configured in `agent-os/config.yml`):
```yaml
market_validation:
  lookup_order:
    - project  # Check local first
    - global   # Fallback to global
```

**Override Examples**:

1. **Custom Market Researcher** (add industry-specific research):
   ```bash
   cp ~/.claude/agents/market-researcher.md .claude/agents/
   # Edit to add healthcare/pharma/fintech specific sources
   ```

2. **Custom Success Criteria** (B2B vs B2C thresholds):
   ```yaml
   # In projekt/agent-os/config.yml
   market_validation:
     decision_criteria:
       conversion_rate_threshold: 2.0  # Lower for B2B
       cpa_threshold: 50.0             # Higher for high-LTV
   ```

3. **Custom Template** (different product brief format):
   ```bash
   mkdir -p agent-os/templates/market-validation
   cp ~/.agent-os/templates/market-validation/product-brief.md agent-os/templates/
   # Edit to add industry-specific sections
   ```

### Why Validate?

**Without Validation**:
- 6 months development
- €50,000+ investment
- Launch to crickets
- Product failure

**With Validation** (/validate-market):
- 2-4 weeks testing
- €100-€2,000 ad spend
- Clear GO/NO-GO signal
- Build with confidence OR avoid expensive mistake

**ROI**: Avoid building products nobody wants. Validate demand before development.

### How It Works

```bash
# 1. Start validation with your idea
/validate-market "AI-powered invoice automation for SMBs"

# 2. Answer 4-5 strategic questions (product-strategist)
#    → Sharp product brief created

# 3. Competitive analysis runs automatically (market-researcher)
#    → 5-10 competitors found via Perplexity MCP
#    → Market gaps identified
#    → Positioning strategy developed

# 4. Landing page and ads created (content-creator, seo-specialist, web-developer)
#    → Production-ready HTML/CSS/JS landing page
#    → 7 Google ad variants, 5 Facebook ad variants
#    → SEO-optimized, mobile-responsive

# 5. Campaign planning completed (validation-specialist)
#    → Complete ad campaign setup guides
#    → Google Analytics 4 configuration
#    → Success criteria defined (conversion, CPA, TAM)

# 6. You execute campaign (2-4 weeks)
#    → Deploy landing page (Netlify/Vercel - 2 minutes)
#    → Run ad campaigns following guides
#    → Collect data

# 7. Analysis and decision (business-analyst)
#    → Provide your metrics (visitors, conversions, spend)
#    → Receive GO/MAYBE/NO-GO decision
#    → Get product refinement recommendations

# 8. If GO → Proceed to development
/plan-product  # Validation results auto-loaded
```

### Deliverables

**Per validation campaign** (in `agent-os/market-validation/YYYY-MM-DD-product-name/`):
- `product-brief.md` - Sharp product definition with persona
- `competitor-analysis.md` - 5-10 competitors with feature comparison matrix
- `market-positioning.md` - Strategic positioning and messaging pillars
- `landing-page/index.html` - Production-ready, deployable landing page
- `ad-campaigns.md` - Complete Google + Meta ad campaign plans with setup instructions
- `analytics-setup.md` - GA4 and conversion tracking configuration guide
- `validation-plan.md` - Timeline, budget, success criteria, execution checklist
- `validation-results.md` - Metrics analysis with GO/NO-GO decision (after campaign)

### Specialist Agents (7)

1. **product-strategist** - Sharpens vague ideas into clear product briefs through interactive Q&A
2. **market-researcher** - Competitive intelligence using Perplexity MCP + WebSearch
3. **content-creator** - Compelling copywriting for landing pages and ad campaigns
4. **seo-specialist** - SEO optimization for search visibility and organic traffic
5. **web-developer** - Production-ready HTML/CSS/JS landing page generation
6. **validation-specialist** - Ad campaign and analytics coordination
7. **business-analyst** - Metrics analysis and data-driven GO/NO-GO decisions

### Success Criteria (Configurable)

**GO Decision** (All 3 criteria met):
- Conversion Rate ≥ 5% (email signups / visitors)
- Cost Per Acquisition ≤ €10
- Total Addressable Market ≥ 100,000 users

**MAYBE Decision** (1-2 criteria met):
- Refine and re-test recommended
- Specific improvement plan provided

**NO-GO Decision** (0 criteria met):
- Proceed not recommended
- Alternative approaches suggested
- Saved €50k+ and 6 months

### Example: Invoice Automation Validation

```
Product Idea: "Invoice automation for freelancers"

product-strategist Q&A:
→ Target: Freelance designers 28-42, Germany
→ Problem: Waste 2h/week, forget invoices, lose €500/month
→ Solution: 1-click from timesheet + auto reminders
→ Value: Simplicity + Speed + €5/month price

market-researcher finds:
→ 8 competitors (FreshBooks €15/mo, QuickBooks €25/mo, Wave Free)
→ Gap: No simple tool for non-accountants at low price
→ Positioning: "QuickBooks alternative for people who hate QuickBooks"

Landing page created:
→ Headline: "From Timesheet to Invoice in 60 Seconds"
→ Responsive, SEO-optimized, <30KB, <3 sec load
→ Deployed to Netlify in 2 minutes

Campaigns run for 3 weeks:
→ €500 ad spend (€300 Google, €150 Facebook, €50 reserve)
→ 1,000 visitors, 62 email signups
→ Conversion: 6.2% ✅ (target: 5%)
→ CPA: €8.06 ✅ (target: €10)
→ TAM: 300k ✅ (target: 100k)

business-analyst decision:
→ GO ✅ (High confidence: 95%)
→ All criteria exceeded
→ Positive user sentiment
→ Proceed to /plan-product

Result: Validated demand before €50k development investment
```

### Integration with Planning

When you run `/plan-product` after successful validation:
- Validation results automatically loaded
- Competitor insights inform feature priorities
- Validated positioning guides product messaging
- User feedback shapes product roadmap
- Best-performing ad copy informs marketing strategy

### Configuration

Customize thresholds in `agent-os/config.yml`:
```yaml
market_validation:
  decision_criteria:
    conversion_rate_threshold: 5.0    # Adjust for your product
    cpa_threshold: 10.0               # Adjust for your economics
    tam_threshold: 100000             # Adjust for your market
```

**Learn More**: See `~/.agent-os/workflows/validation/README.md` (global) or `agent-os/workflows/validation/README.md` (if project-local) for complete guide.

### Architecture: Global + Override Pattern

The Market Validation System uses a **layered architecture** inspired by Node.js, Git, and VS Code:

```
Installation Layer:
┌─────────────────────────────────────────┐
│ Global (~/.agent-os/, ~/.claude/)      │ ← Installed once
│ - Skills (product, business, marketing)│
│ - Templates (7 validation templates)   │
│ - Workflow (validate-market.md)        │
│ - Agents (7 specialists)               │
│ - Command (/validate-market)           │
└─────────────────────────────────────────┘
         ↑ Fallback if not found locally
         │
┌─────────────────────────────────────────┐
│ Project (projekt/agent-os/, .claude/)  │ ← Checked first
│ - Overrides (optional, only if needed) │
│ - Validation Results (always local)    │
└─────────────────────────────────────────┘
```

**Lookup Flow**:
```
User runs: /validate-market

1. Need: product-strategist agent
   Check: projekt/.claude/agents/product-strategist.md
   → Not found
   Fallback: ~/.claude/agents/product-strategist.md
   → Found! Use global version ✅

2. Need: product-brief.md template
   Check: projekt/agent-os/templates/market-validation/product-brief.md
   → Not found
   Fallback: ~/.agent-os/templates/market-validation/product-brief.md
   → Found! Use global version ✅

3. Create: validation results
   Location: projekt/agent-os/market-validation/2025-12-27-product/
   → Always project-local (results belong to project) ✅
```

**When to Override**:

✅ **Override Agent** when:
- Industry-specific requirements (pharma compliance, fintech regulations)
- Different research sources (internal database instead of Perplexity)
- Custom business logic (different decision criteria)

✅ **Override Template** when:
- Industry-specific sections (add "Regulatory Compliance" section)
- Different format preferences (company-specific documentation style)

✅ **Override Workflow** when:
- Additional steps needed (add legal review step)
- Different orchestration (parallel instead of sequential)

❌ **Don't Override** if:
- Just tweaking thresholds (use config.yml instead)
- Minor changes (contribut back to global)
- No strong reason (global version works fine)

**Configuration Hierarchy**:
```yaml
# Global defaults: ~/.agent-os/config.yml (if exists)
market_validation:
  decision_criteria:
    conversion_rate_threshold: 5.0
    cpa_threshold: 10.0

# Project override: projekt/agent-os/config.yml
market_validation:
  decision_criteria:
    conversion_rate_threshold: 2.0  # B2B project, lower threshold
    # cpa_threshold inherits from global (10.0)
```

**Learn More**: See `~/.agent-os/workflows/validation/README.md` (global) or `agent-os/workflows/validation/README.md` (if project-local) for complete guide.

## Original Agent OS

For more information about the original Agent OS concept, visit [buildermethods.com/agent-os](https://buildermethods.com/agent-os).

## License

This project maintains the same open-source license as the original Agent OS project.