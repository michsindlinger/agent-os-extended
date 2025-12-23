# Agent OS Extended v2.0

> **Note**: This repository is based on the original [Agent OS](https://github.com/buildermethods/agent-os) by Builder Methods. This extended version includes enhancements specifically designed for enterprise project development.

Agent OS Extended is a project-level implementation of the Agent OS system, designed to improve AI coding workflows through structured context and guidance. Unlike the original global installation, this version installs configuration files directly within each project.

## What's New in v2.0

- **Improved directory structure** - `agent-os/` (visible) instead of `.agent-os/` (hidden)
- **Clearer naming** - `workflows/` instead of `instructions/` for better semantics
- **Command isolation** - Commands organized in `.claude/commands/agent-os/` namespace
- **Migration tools** - Automated migration from v1.x with rollback support
- **Enhanced workflow organization** - Better structure for complex projects

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

If you have an existing project using Agent OS Extended v1.x (`.agent-os/` structure), you can migrate to v2.0:

```bash
# Download and run migration script
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-to-v2.sh | bash
```

**What the migration does:**
- Renames `.agent-os/` → `agent-os/`
- Renames `instructions/` → `workflows/`
- Moves commands to `.claude/commands/agent-os/`
- Updates all file references automatically
- Creates timestamped backup for safety

**Rollback if needed:**
```bash
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

### 📁 Directory Structure

- **`agent-os/specs/`** - Development-oriented specifications (timestamped, includes change history)
- **`agent-os/docs/`** - User-oriented documentation (hierarchical, feature-focused)
- **`agent-os/bugs/`** - Bug tracking with investigation, reproduction, and resolution documentation
- **`agent-os/brainstorming/`** - Brainstorming sessions for feature and bug ideation

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

## Original Agent OS

For more information about the original Agent OS concept, visit [buildermethods.com/agent-os](https://buildermethods.com/agent-os).

## License

This project maintains the same open-source license as the original Agent OS project.