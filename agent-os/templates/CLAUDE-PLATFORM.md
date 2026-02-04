# CLAUDE.md - [PLATFORM_NAME]

> [PLATFORM_NAME] Development Guide
> Last Updated: [CURRENT_DATE]
> Type: Multi-Module Platform

## Purpose
Essential guidance for Claude Code development. **Context is loaded on-demand** to preserve context window for actual work.

## Platform Overview

**Platform:** [PLATFORM_NAME]
**Type:** Multi-Module Platform
**Modules:** [MODULE_COUNT] modules

### Core Modules
[MODULE_LIST]

## Document Locations (Load on Demand)

### Platform Information (DO NOT use @ prefix - load via context-fetcher when needed)
- **Platform Vision**: agent-os/product/platform-brief.md
- **Technical Architecture**: agent-os/product/tech-stack.md
- **Platform Roadmap**: agent-os/product/roadmap/platform-roadmap.md
- **Module Dependencies**: agent-os/product/architecture/module-dependencies.md
- **Platform Architecture**: agent-os/product/architecture/platform-architecture.md
- **Secrets & Credentials**: agent-os/product/secrets.md (Required credentials tracking)

### Module Briefs (load specific module when working on it)
[MODULE_BRIEF_PATHS]

### Module Roadmaps (load specific module when planning)
[MODULE_ROADMAP_PATHS]

### Development Standards (DO NOT use @ prefix)
- **Tech Stack Defaults**: agent-os/standards/tech-stack.md
- **Code Style Preferences**: agent-os/standards/code-style.md
- **Best Practices Philosophy**: agent-os/standards/best-practices.md

### Agent OS Workflows (Loaded automatically via Skill system when invoked)
Available via slash commands - NO need to preload:
- `/plan-platform` - Update platform planning
- `/build-development-team` - Create DevTeam agents
- `/create-spec` - Feature specifications (per module)
- `/execute-tasks` - Task execution
- `/retroactive-doc` - Document existing features

## Critical Rules
- **FOLLOW ALL INSTRUCTIONS** - Mandatory, not optional
- **ASK FOR CLARIFICATION** - If uncertain about any requirement
- **MINIMIZE CHANGES** - Edit only what's necessary
- **LOAD CONTEXT ON DEMAND** - Use context-fetcher subagent to load documents when needed
- **MODULE FOCUS** - Work on one module at a time, load only that module's context

## Context Loading Strategy

**IMPORTANT: Do NOT preload all documents. Load on demand.**

When you need platform/architecture context:
1. Use context-fetcher subagent to load specific documents
2. Request only what's needed for the current task
3. For module work, load only that module's brief and roadmap

Example delegation:
```
DELEGATE to context-fetcher:
"Load agent-os/product/modules/[module-name]/module-brief.md for current task context"
```

## Platform Development Strategy

**Module Dependency Order:**
Check `agent-os/product/architecture/module-dependencies.md` before starting work.

**Development Phases:**
Check `agent-os/product/roadmap/platform-roadmap.md` for phase ordering.

**Per-Module Development:**
1. Load module brief from `agent-os/product/modules/[module-name]/`
2. Load module roadmap from `agent-os/product/roadmap/modules/[module-name]/`
3. Use `/create-spec` for module features
4. Execute with DevTeam agents

## Sub-Agents
**MANDATORY DELEGATION** - Sub-agents have separate context windows.

**Delegation Strategy:**
- **Strategic Planning** → You decide WHAT needs to be done
- **Implementation Planning** → Delegate to Core Development specialists
- **Execution Tasks** → Delegate to Utility & Support agents
- **Context Loading** → Use context-fetcher to load documents on demand

### Utility & Support
- **context-fetcher** - Load documents on demand (CRITICAL for context efficiency)
- **date-checker** - Determine today's date
- **file-creator** - Create files and apply templates
- **git-workflow** - Git operations, commits, PRs

## File Organization Rules

**CRITICAL - No Files in Project Root:**
- Implementation reports: `agent-os/specs/[spec-name]/implementation-reports/`
- Testing checklists: `agent-os/specs/[spec-name]/implementation-reports/`
- Handover docs: `agent-os/specs/[spec-name]/handover-docs/`
- Architecture docs: `agent-os/product/architecture/`
- Module docs: `agent-os/product/modules/`
- Team docs: `agent-os/team/`

## Quality Requirements

**Mandatory Checks:**
- Run linting after ALL code changes
- ALL lint errors must be fixed before task completion

## Platform Workflow

**Available Commands (load workflow context automatically):**

1. **Platform Planning:**
   - `/plan-platform` → Update platform documentation

2. **Team Setup:**
   - `/build-development-team` → Creates DevTeam agents & skills

3. **Feature Development (per module):**
   - `/create-spec` → Creates detailed specification
   - `/execute-tasks` → Executes planned tasks

4. **Bug Management:**
   - `/create-bug` → Creates bug specification
   - `/add-bug` → Adds bug to existing spec

5. **Documentation:**
   - `/retroactive-doc` → Documents existing features

**Directory Structure:**
```
agent-os/
├── product/
│   ├── platform-brief.md          # Platform vision
│   ├── tech-stack.md              # Technology choices
│   ├── modules/
│   │   ├── [module-1]/
│   │   │   └── module-brief.md
│   │   └── [module-2]/
│   │       └── module-brief.md
│   ├── architecture/
│   │   ├── module-dependencies.md
│   │   └── platform-architecture.md
│   └── roadmap/
│       ├── platform-roadmap.md
│       └── modules/
│           ├── [module-1]/roadmap.md
│           └── [module-2]/roadmap.md
├── specs/                          # Feature specifications
└── team/                           # DevTeam agents and skills
```

## Development Notes
- Bitte merke dir, wir nutzen hier in diesem Branch die V2-Komponenten für die Projekte und die Profile im Moment und für die Seite Teams und Settings.

---

**Context Efficiency Note:** This CLAUDE.md uses ~600 tokens instead of loading all platform docs. Documents are loaded on-demand via context-fetcher. Skills are extracted by Orchestrator during task execution (see `agent-os/team/skill-index.md`).
