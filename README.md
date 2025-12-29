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

**Team Development System (Phase B) 🆕**

- Smart task routing with specialist agents for coordinated feature development
- 4 development specialists (backend-dev, frontend-dev, qa-specialist, devops-specialist)
- 1 utility agent (mock-generator) for API mock generation
- Multi-stack support: Java Spring Boot/Node.js backends, React/Angular frontends
- Automatic task type detection (backend/frontend/qa/devops keywords)
- Sequential coordination with clear handoffs between specialists
- API mock generation for independent frontend development
- Comprehensive testing with auto-fix capabilities (unit, integration, E2E)
- CI/CD pipeline generation (GitHub Actions, Docker, deployment automation)
- Quality gates enforcement (≥80% coverage, all tests passing)
- 2 new skills (testing-best-practices, devops-patterns)
- 12 team templates (API specs, components, test plans, CI/CD configs)

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
5. **web-developer** - **Marketing landing page creation** (vanilla HTML/CSS/JS, self-contained, <30KB)
   - **Purpose**: Quick validation landing pages BEFORE building the product
   - **Tech**: No frameworks, single index.html file, inline CSS/JS
   - **Deploy**: Static hosting (Netlify, Vercel, GitHub Pages)
   - **Note**: For production applications after GO decision, use frontend-dev from Team System
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

## Team Development System (Phase B) 🆕

**Coordinated feature development with specialist agents that handle backend, frontend, testing, and deployment automatically.**

### Installation

The Team Development System supports **global installation** (recommended) with **project-specific overrides**.

#### Global Installation (Recommended)

Install once, use in all projects:

```bash
# Install team development system to global agent-os/ and .claude/
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-team-system-global.sh | bash
```

**What This Installs**:
- 2 skills → `agent-os/skills/base/` (testing-best-practices, devops-patterns)
- 12 templates → `agent-os/templates/team-development/` (4 backend, 4 frontend, 2 qa, 2 devops)
- 5 agents → `.claude/agents/` (backend-dev, frontend-dev, qa-specialist, devops-specialist, mock-generator)
- Updates → `agent-os/workflows/core/execute-tasks.md` (smart task routing)

**Then in Each Project**:
```bash
cd your-project
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-team-system-project.sh | bash
```

Creates: `agent-os/templates/team-development/` structure for project-specific template overrides.

**Benefits**:
- ✅ Install once, use everywhere
- ✅ Smart task routing in /execute-tasks (automatic specialist delegation)
- ✅ Updates propagate to all projects
- ✅ Override when needed (custom agents, templates per project)

#### Project-Specific Installation (Alternative)

Install everything locally in one project:

```bash
cd your-project
# Run existing setup.sh (includes team system)
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash
```

**What This Does**:
- Installs all components to `projekt/agent-os/` and `projekt/.claude/`
- Self-contained (no global dependencies)
- Useful for: Testing, isolated environments, per-project customization

### How It Works

**Transparent Integration with /execute-tasks**:

```markdown
# Your tasks.md
1. Create POST /api/users endpoint with validation
2. Create UserList component with pagination
3. Add comprehensive tests for user management
4. Setup GitHub Actions CI/CD pipeline
```

**What Happens** (when `team_system.enabled: true`):

```bash
# Run tasks as usual
/execute-tasks

# Smart routing analyzes each task:

# Task 1: "Create POST /api/users endpoint with validation"
# Keywords detected: [api, endpoint]
# → Routes to: backend-dev specialist
#   → Loads skills: java-core-patterns, spring-boot-conventions, jpa-best-practices
#   → Generates: Controller, Service, Repository, DTOs, Tests (>80% coverage)
#   → Creates: API mocks in api-mocks/users.json
#   → Handoff: Documents API for frontend team

# Task 2: "Create UserList component with pagination"
# Keywords detected: [component, pagination]
# → Routes to: frontend-dev specialist
#   → Loads skills: react-component-patterns, react-hooks-best-practices
#   → Generates: Components, Services, Types, Tests (>80% coverage)
#   → Uses: API mocks from backend-dev
#   → Handoff: E2E test scenarios for QA

# Task 3: "Add comprehensive tests for user management"
# Keywords detected: [tests]
# → Routes to: qa-specialist
#   → Loads skills: testing-best-practices
#   → Runs: Unit tests (backend + frontend)
#   → Runs: Integration tests (API endpoints)
#   → Runs: E2E tests (Playwright - critical flows)
#   → Auto-fix: Delegates failures back to specialists (max 3 attempts)
#   → Verifies: Coverage ≥80%, all tests passing
#   → Handoff: Test report with quality confirmation

# Task 4: "Setup GitHub Actions CI/CD pipeline"
# Keywords detected: [github actions, ci/cd, pipeline]
# → Routes to: devops-specialist
#   → Loads skills: devops-patterns, security-best-practices
#   → Generates: .github/workflows/ci.yml, deploy-staging.yml, deploy-production.yml
#   → Generates: Dockerfile (backend + frontend), docker-compose.yml
#   → Creates: deployment-plan.md with complete instructions
#   → Handoff: CI/CD ready for deployment

# Result: Complete feature implemented with backend, frontend, tests, and deployment!
```

### Task Routing Keywords

**Backend** → `backend-dev`:
```
api, endpoint, controller, service, repository, rest, graphql, database, backend, server
```

**Frontend** → `frontend-dev`:
```
component, page, view, ui, frontend, react, angular, state, redux, interface
```

**QA** → `qa-specialist`:
```
test, spec, coverage, e2e, integration, unit, playwright, cypress, jest, junit, testing
```

**DevOps** → `devops-specialist`:
```
deploy, ci, cd, docker, pipeline, github actions, kubernetes, aws, deployment, infrastructure
```

**Unknown** → Direct execution (fallback to current /execute-tasks behavior)

### Specialist Agents (5)

1. **backend-dev** - Backend development specialist
   - Java Spring Boot 3.x (primary) or Node.js/Express
   - Full API implementation: Controllers, Services, Repositories, DTOs, Entities
   - Exception handling with custom errors
   - Unit tests with JUnit 5/Mockito (>80% coverage)
   - API mock generation for frontend independence
   - Handoff documentation

2. **frontend-dev** - **Production application frontend development** (React/Angular)
   - **Purpose**: Build production-ready web applications AFTER GO decision
   - **Tech**: React 18+ or Angular 17+ with TypeScript, npm packages, build tools
   - **Output**: Component architecture, routing, state management, comprehensive tests
   - Complete component implementation with hooks/services
   - API integration using backend-provided mocks
   - Form validation matching backend rules
   - Component tests with React Testing Library (>80% coverage)
   - E2E test scenario documentation
   - **Note**: For pre-validation marketing landing pages, use web-developer from Market Validation

3. **qa-specialist** - Testing specialist with auto-fix
   - Testing pyramid: Unit → Integration → E2E
   - Multi-stack support: JUnit, Jest, React Testing Library, Playwright
   - Auto-fix loop: Analyzes failures, delegates to specialists, max 3 retries
   - Coverage analysis and enforcement (≥80%)
   - Quality gate verification before deployment
   - Comprehensive test reporting

4. **devops-specialist** - CI/CD and deployment specialist
   - GitHub Actions pipeline generation (CI + CD)
   - Docker multi-stage builds for backend and frontend
   - docker-compose for local multi-container development
   - Deployment automation (staging auto-deploy, production manual approval)
   - Secrets management and security best practices
   - Complete deployment documentation

5. **mock-generator** - API mock generation utility
   - Generates realistic JSON mocks from backend code or OpenAPI specs
   - Success and error case coverage (200, 201, 400, 404, 409)
   - Exact DTO structure matching
   - Used by backend-dev and frontend-dev

### Override Mechanism

**Global Default** (works for 95% of cases):
```
User runs: /execute-tasks
Task: "Create POST /api/users endpoint"
System uses: .claude/agents/backend-dev.md (global)
```

**Project Override** (when customization needed):
```bash
# Copy global agent to project
cp .claude/agents/backend-dev.md .claude/agents/

# Customize for this project's architecture
vim .claude/agents/backend-dev.md
# Add: Project-specific DTO patterns, custom validation rules

# Next time you run /execute-tasks in THIS project:
System uses: projekt/.claude/agents/backend-dev.md (local override)

# Other projects still use:
System uses: .claude/agents/backend-dev.md (global default)
```

**Lookup Order** (configured in `agent-os/config.yml`):
```yaml
team_system:
  lookup_order:
    - project  # Check local first
    - global   # Fallback to global
```

**Override Examples**:

1. **Custom Backend Stack** (Node.js instead of Java):
   ```yaml
   # In projekt/agent-os/config.yml
   team_system:
     specialists:
       backend_dev:
         default_stack: nodejs_express  # Override global default
   ```

2. **Custom Frontend Framework** (Angular instead of React):
   ```yaml
   # In projekt/agent-os/config.yml
   team_system:
     specialists:
       frontend_dev:
         default_framework: angular
   ```

3. **Custom API Spec Template** (different API structure):
   ```bash
   mkdir -p agent-os/templates/team-development/backend
   cp agent-os/templates/team-development/backend/api-spec.md agent-os/templates/
   # Edit to add GraphQL schema, custom pagination format, etc.
   ```

4. **Higher Coverage Target** (critical application):
   ```yaml
   # In projekt/agent-os/config.yml
   team_system:
     quality_gates:
       coverage_minimum: 90  # Increase from default 80%
   ```

5. **Disable Specialist** (manual DevOps for this project):
   ```yaml
   # In projekt/agent-os/config.yml
   team_system:
     specialists:
       devops_specialist:
         enabled: false  # Handle DevOps manually
   ```

### Why Use Team System?

**Without Team System** (/execute-tasks direct execution):
- You implement everything yourself
- Manual coordination between layers
- Easy to miss testing or deployment steps
- Inconsistent patterns across features

**With Team System** (/execute-tasks with smart routing):
- Specialists handle their domains automatically
- Clear handoffs between layers (API mocks, test scenarios)
- Quality gates enforced (coverage, tests passing)
- Production-ready CI/CD generated
- Consistent patterns (Spring Boot conventions, React best practices)

**ROI**: Faster feature development, higher code quality, automatic best practices application.

### Configuration

Enable in `agent-os/config.yml`:

```yaml
team_system:
  enabled: true  # Enable smart task routing

  specialists:
    backend_dev:
      enabled: true
      default_stack: java_spring_boot  # or nodejs_express
      code_generation: full            # or scaffolding, guidance

    frontend_dev:
      enabled: true
      default_framework: react  # or angular
      code_generation: full

    qa_specialist:
      enabled: true
      test_types: [unit, integration, e2e]
      coverage_target: 80
      auto_fix_attempts: 3

    devops_specialist:
      enabled: true
      ci_platform: github_actions
      containerization: docker

  quality_gates:
    unit_tests_required: true
    integration_tests_required: true
    coverage_minimum: 80
    build_success_required: true
```

### Deliverables

**Per feature implementation** (automated by specialists):

**Backend** (backend-dev):
- Controllers with full REST endpoints
- Service layer with business logic
- Repository layer with Spring Data JPA
- Entity models with JPA annotations
- DTOs with validation rules
- Exception handling with custom errors
- Unit tests (>80% coverage)
- API mocks for frontend (`api-mocks/*.json`)
- Backend handoff documentation

**Frontend** (frontend-dev):
- Components (presentational + container)
- Services with API integration (using mocks)
- TypeScript types matching backend DTOs
- Custom hooks or Angular services
- Form validation matching backend rules
- Component tests (>80% coverage)
- Frontend handoff with E2E test scenarios

**QA** (qa-specialist):
- Unit test execution and auto-fix
- Integration test execution
- E2E test implementation (Playwright)
- Coverage reports
- Test execution report
- Quality gate verification

**DevOps** (devops-specialist):
- `.github/workflows/ci.yml` - CI pipeline (test + build)
- `.github/workflows/deploy-staging.yml` - Auto-deploy to staging
- `.github/workflows/deploy-production.yml` - Manual production deploy
- `Dockerfile` (backend + frontend with multi-stage builds)
- `docker-compose.yml` - Local development setup
- `deployment-plan.md` - Complete deployment guide

### Multi-Stack Support

**Backend Stacks**:
- **Java Spring Boot 3.x** (primary) - Full stack generation with controllers, services, JPA repositories
- **Node.js/Express** (future) - REST API with TypeScript

**Frontend Frameworks**:
- **React 18+** (primary) - Functional components, hooks, TypeScript
- **Angular 17+** - Standalone components, services, RxJS

**Detection**: Checks `active_profile` in config.yml or analyzes `pom.xml` / `package.json`

### Quality Gates

**Enforced automatically before deployment**:

- ✅ All unit tests passing (backend + frontend)
- ✅ All integration tests passing
- ✅ All E2E tests passing
- ✅ Code coverage ≥80%
- ✅ Build succeeds without errors
- ✅ No linting errors

**Auto-Fix Loop** (qa-specialist):
- Detects test failures
- Analyzes root cause
- Delegates fix to appropriate specialist (backend-dev or frontend-dev)
- Re-runs tests
- Repeats up to 3 times
- Reports to user if still failing

### Example Workflow

**User Task**:
```markdown
# tasks.md
1. Implement user management feature
   1.1. Create user CRUD API endpoints
   1.2. Create user list and detail UI
   1.3. Add comprehensive testing
   1.4. Setup CI/CD for deployment
```

**Team System Execution**:

```bash
/execute-tasks

# System automatically:

# 1.1 → backend-dev
#   ✓ Generates: UserController, UserService, UserRepository
#   ✓ Generates: User entity, UserDTO, UserCreateRequest, UserUpdateRequest
#   ✓ Generates: Exception handling (UserNotFoundException, etc.)
#   ✓ Generates: Unit tests (24 tests, 92% coverage)
#   ✓ Generates: api-mocks/users.json
#   ✓ Creates: Backend handoff document

# 1.2 → frontend-dev
#   ✓ Reads: Backend handoff (API structure, mocks)
#   ✓ Generates: UserList, UserCard, UserForm components
#   ✓ Generates: UserService with mock integration
#   ✓ Generates: TypeScript types (User, UserCreateRequest)
#   ✓ Generates: Component tests (18 tests, 85% coverage)
#   ✓ Creates: Frontend handoff with E2E scenarios

# 1.3 → qa-specialist
#   ✓ Runs: Backend unit tests (24 tests ✅)
#   ✓ Runs: Frontend unit tests (18 tests ✅)
#   ✓ Runs: Integration tests (12 API endpoint tests ✅)
#   ✓ Runs: E2E tests (5 critical flows ✅)
#   ✓ Verifies: Coverage 87% backend, 85% frontend ✅
#   ✓ Creates: Test execution report
#   ✓ All quality gates passed ✅

# 1.4 → devops-specialist
#   ✓ Generates: .github/workflows/ci.yml
#   ✓ Generates: .github/workflows/deploy-staging.yml
#   ✓ Generates: .github/workflows/deploy-production.yml
#   ✓ Generates: Dockerfile (backend + frontend)
#   ✓ Generates: docker-compose.yml
#   ✓ Creates: deployment-plan.md
#   ✓ Handoff: Setup instructions for user

# Result: Complete feature with 54 tests, CI/CD ready! 🎉
```

### Coordination & Handoffs

**Sequential Execution** (MVP):
```
Phase 1: Backend Development
↓ (Handoff: API mocks + endpoint docs)
Phase 2: Frontend Development
↓ (Handoff: E2E test scenarios)
Phase 3: Quality Assurance
↓ (Handoff: Test report + quality confirmation)
Phase 4: Deployment Setup
↓ (Handoff: CI/CD instructions)
Done! ✅
```

**Handoff System**:
- Each specialist generates handoff document using templates
- Next specialist reads handoff before starting
- API mocks serve as contract between backend/frontend
- Clear quality gates at each phase

### Configuration Options

**Basic Configuration** (defaults work for most projects):
```yaml
team_system:
  enabled: true
```

**Advanced Configuration**:
```yaml
team_system:
  enabled: true

  # Coordination
  coordination_mode: sequential  # MVP (parallel in Phase C)

  # Task routing
  task_routing:
    enabled: true       # Smart routing active
    auto_delegate: true # No manual confirmation

  # Specialist customization
  specialists:
    backend_dev:
      enabled: true
      default_stack: java_spring_boot  # Override per project
      code_generation: full            # Options: full, scaffolding, guidance

    frontend_dev:
      enabled: true
      default_framework: react
      code_generation: full

    qa_specialist:
      enabled: true
      test_types: [unit, integration, e2e]
      coverage_target: 80       # Increase to 90 for critical apps
      auto_fix_attempts: 3      # Max auto-fix iterations

    devops_specialist:
      enabled: true
      ci_platform: github_actions
      containerization: docker

  # Quality gates (customize thresholds)
  quality_gates:
    unit_tests_required: true
    integration_tests_required: true
    coverage_minimum: 80      # Configurable per project
    build_success_required: true
```

### Backward Compatibility

**Team System Disabled** (default for existing projects):
```yaml
team_system:
  enabled: false  # Or not configured at all
```
→ Behavior: Exactly like current /execute-tasks (no delegation)

**Unknown Task Type** (no keyword matches):
```markdown
# Task without specialist keywords
1. Refactor database query optimization
```
→ Behavior: Direct execution (fallback to current behavior)

**Mixed Mode** (some tasks routed, some direct):
```markdown
1. Create POST /api/users endpoint  ← Routed to backend-dev
2. Optimize database indexes        ← Direct execution (unknown type)
3. Create UserList component        ← Routed to frontend-dev
```

### Skills Integration

**Auto-Loaded by Specialists**:

**backend-dev**:
- java-core-patterns (SOLID, design patterns)
- spring-boot-conventions (DI, controllers, services)
- jpa-best-practices (N+1 prevention, caching)
- security-best-practices (validation, encryption)

**frontend-dev** (React):
- react-component-patterns (composition, rendering)
- react-hooks-best-practices (useState, useEffect, useMemo)
- typescript-react-patterns (types, generics)

**frontend-dev** (Angular):
- angular-component-patterns (standalone, lifecycle)
- angular-services-patterns (DI, HTTP)
- rxjs-best-practices (operators, subscriptions)

**qa-specialist**:
- testing-best-practices (test patterns, coverage, E2E)

**devops-specialist**:
- devops-patterns (CI/CD, Docker, deployment)
- security-best-practices (secrets, container security)

### Templates (12)

**Backend Templates** (`templates/team-development/backend/`):
- `api-spec.md` - REST API endpoint specification
- `service-class.md` - Service layer class template
- `repository-class.md` - Repository/DAO template
- `backend-handoff.md` - API mocks + documentation

**Frontend Templates** (`templates/team-development/frontend/`):
- `component-spec.md` - React/Angular component specification
- `page-spec.md` - Full page with routing
- `state-management.md` - Redux/NgRx setup
- `frontend-handoff.md` - UI integration notes

**QA Templates** (`templates/team-development/qa/`):
- `test-plan.md` - Test cases and coverage goals
- `test-report.md` - Test execution results

**DevOps Templates** (`templates/team-development/devops/`):
- `ci-cd-config.md` - GitHub Actions pipeline
- `deployment-plan.md` - Environment and deployment steps

### When to Use Team System

**Ideal For**:
- ✅ Full-stack feature development (API + UI)
- ✅ Projects with clear separation (backend/frontend)
- ✅ Teams wanting consistent code patterns
- ✅ Automated testing requirements
- ✅ CI/CD pipeline setup
- ✅ Spring Boot + React/Angular stacks

**Not Ideal For**:
- ❌ Simple script projects
- ❌ Non-web applications
- ❌ Custom tech stacks (not Java/Node.js + React/Angular)
- ❌ Exploratory prototyping (overhead not worth it)

**Fallback**: Disable team system, use direct /execute-tasks

### Performance

**Task Routing Overhead**: <10% (keyword detection is fast)

**Benefits**:
- Parallel specialist work (Phase C future)
- Specialists focus on their domain (better code quality)
- Auto-fix reduces manual debugging time
- Templates ensure consistency

**Learn More**: See `agent-os/workflows/team/README.md` for complete guide, examples, and troubleshooting.

---

## Design System Extraction

**Maintain design consistency across frontend work with `/extract-design` command.**

### Purpose

Extract UI design tokens from existing websites or screenshots to generate a project-specific `frontend-design.md` skill that frontend specialists use automatically.

**Use Cases**:
- ✅ Extract design from your existing application (maintain consistency)
- ✅ Extract design from competitor websites (inspiration)
- ✅ Document design patterns from mockups/screenshots
- ✅ Prepare design tokens before frontend development

### Usage

**From URL**:
```bash
/extract-design https://your-app.com
```

**From Screenshots**:
```bash
/extract-design screenshots/dashboard.png screenshots/form.png
```

**Interactive Mode**:
```bash
/extract-design
# Prompts for URL or screenshot paths
```

### What It Does

1. **Analyzes Reference**:
   - **URL**: WebFetch analyzes website structure and styles
   - **Screenshots**: general-purpose agent analyzes images visually

2. **Extracts UI Tokens**:
   - Colors (primary, secondary, accent, backgrounds, text) with hex codes
   - Typography (font families, sizes, weights, line heights)
   - Spacing (base unit, section padding, grid gaps)
   - Components (button, card, input styles with exact values)
   - Visual effects (shadows, gradients, border radius, animations)
   - Layout patterns (grid, breakpoints, container widths)

3. **Fetches Official Template**:
   - Downloads official Claude `frontend-design` skill from GitHub
   - Contains: Design thinking, aesthetic direction, implementation principles, guardrails

4. **Merges Tokens + Framework**:
   - Combines extracted tokens with official frontend-design principles
   - Adds "Project Design System" section with your specific values
   - Keeps all original guidance and best practices

5. **Saves Project-Specific Skill**:
   - Location: `.claude/skills/frontend-design.md`
   - Auto-loaded by: `web-developer`, `frontend-dev` agents
   - Used for: All frontend work in this project

### Generated Skill Example

```markdown
---
name: frontend-design
description: Your Project design system with extracted UI tokens
globs: ["**/*.{html,css,tsx,jsx,vue,svelte}"]
---

## Project Design System (Extracted from Reference)

Source: https://your-app.com
Extracted: 2025-12-29

### Color Palette
```css
--color-primary: #1a73e8;        /* Main brand - CTAs, links */
--color-secondary: #34a853;      /* Success states */
--color-accent: #ea4335;         /* Highlights, errors */
/* ... */
```

### Typography System
```css
--font-heading: "Roboto", sans-serif;
--font-body: "Open Sans", sans-serif;
/* ... */
```

[... All original frontend-design framework sections ...]
```

### Integration with Workflows

**Market Validation** (`/validate-market`):
- Step 9 internally uses same extraction process
- Generates `.claude/skills/frontend-design.md`
- web-developer uses it for landing page styling

**Team Development** (`/execute-tasks`):
- Run `/extract-design` before frontend tasks (one-time setup)
- frontend-dev auto-loads `.claude/skills/frontend-design.md`
- All generated components match your design

### Real-World Scenario

**Existing project with established design**:

```bash
# 1. Extract design from your app
/extract-design https://your-app.com

# Result: .claude/skills/frontend-design.md created
# Contains: Your colors (#1a73e8), fonts (Roboto), spacing (8px)

# 2. Add new features
# tasks.md:
# 1. Create invoice dashboard component
# 2. Create payment form component

/execute-tasks

# → frontend-dev loads .claude/skills/frontend-design.md
# → Generates InvoiceDashboard.tsx with YOUR #1a73e8 color
# → Generates PaymentForm.tsx with YOUR Roboto font
# → New components look identical to existing app!

# 3. Future features automatically consistent
# All frontend tasks use same design system
# No manual "use our blue color" instructions needed
```

**Benefits**:
- ✅ One-time setup, permanent consistency
- ✅ No manual design token communication needed
- ✅ New developers onboard faster (design system documented)
- ✅ Design updates propagate (re-run `/extract-design`)

---

## Complete Product Development Workflow

**Combine Market Validation (Phase A) and Team Development (Phase B) for end-to-end product creation:**

### Phase A: Market Validation (Weeks 1-4)

**Goal**: Validate product-market fit BEFORE expensive development

```bash
# 1. Validate market demand
/validate-market "AI-powered invoice automation for SMBs"

# Agents work:
# → product-strategist: Sharpens idea through Q&A
# → market-researcher: Analyzes 5-10 competitors
# → content-creator: Writes compelling copy
# → seo-specialist: Optimizes for search
# → web-developer: Creates HTML/CSS/JS landing page (vanilla, <30KB)
# → validation-specialist: Plans ad campaigns
# → business-analyst: Defines success criteria

# 2. Deploy landing page (2 minutes)
netlify deploy --dir=agent-os/market-validation/2025-12-29-invoice-automation/landing-page

# 3. Run ad campaigns (2-4 weeks)
# → Execute Google Ads + Meta Ads campaigns
# → Collect data: visitors, conversions, CPA

# 4. Analyze results
/analyze-validation-results
# → business-analyst: GO/MAYBE/NO-GO decision

# Result: GO decision (5% conversion, €8 CPA, 100K TAM)
```

**Deliverables**:
- ✅ Validated product-market fit
- ✅ Marketing landing page (HTML/CSS/JS)
- ✅ 500-2,000 validated email addresses
- ✅ Clear demand signal
- ✅ Investment: €500-€2,000

---

### Phase B: Product Development (Months 1-6)

**Goal**: Build production application with validated demand

```bash
# 1. Plan product based on validation
/plan-product
# Validation results automatically loaded
# Creates technical spec and tasks

# 2. Execute development with team specialists
/execute-tasks

# Agents work (smart routing):
# Task: "Create user authentication API"
# → backend-dev: Spring Boot REST API, JPA, tests (React/Angular app)

# Task: "Create invoice dashboard UI"
# → frontend-dev: React/Angular components, routing, state, tests

# Task: "Add comprehensive testing"
# → qa-specialist: Unit, integration, E2E tests (auto-fix failures)

# Task: "Setup CI/CD pipeline"
# → devops-specialist: GitHub Actions, Docker, deployment automation

# 3. Deploy to production
# → CI/CD pipeline deploys automatically
# → Staging → Production with approval

# Result: Production application deployed
```

**Deliverables**:
- ✅ Full-stack web application
- ✅ Backend API (Spring Boot/Node.js)
- ✅ Frontend SPA (React/Angular)
- ✅ Comprehensive test suite (>80% coverage)
- ✅ CI/CD pipeline
- ✅ Production deployment

---

### Agent Comparison

| Aspect | web-developer (Phase A) | frontend-dev (Phase B) |
|--------|------------------------|------------------------|
| **Purpose** | Marketing validation | Production application |
| **Technology** | Vanilla HTML/CSS/JS | React/Angular + TypeScript |
| **Complexity** | Single page | Multi-component app |
| **File Count** | 1 file (index.html) | 20-50+ files |
| **Dependencies** | None (self-contained) | npm packages, build tools |
| **Testing** | None | >80% coverage required |
| **Backend** | No integration | Full API integration |
| **State** | Simple JS variables | Context/Redux/NgRx |
| **Routing** | None | React Router/Angular Router |
| **Build** | None (deploy as-is) | Vite/Webpack build |
| **Size** | <30KB total | 500KB-2MB bundle |
| **Load Time** | <3 seconds | <5 seconds |
| **Use Case** | Ad campaigns, email collection | Full product features |
| **Timeline** | 1 day | Weeks to months |
| **Cost** | €100-€2,000 validation | €50,000-€200,000 development |

**Key Insight**: web-developer validates IDEAS cheaply. frontend-dev builds PRODUCTS after validation.

---

## Original Agent OS

For more information about the original Agent OS concept, visit [buildermethods.com/agent-os](https://buildermethods.com/agent-os).

## License

This project maintains the same open-source license as the original Agent OS project.