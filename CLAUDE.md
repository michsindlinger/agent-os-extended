# CLAUDE.md

> [PROJECT_NAME] Development Guide
> Last Updated: [CURRENT_DATE]

## Purpose
Essential guidance for Claude Code development in the [PROJECT_NAME] repository. All detailed standards and product information are maintained in Agent OS structure.

## Agent OS References (Lazy Loading)

**IMPORTANT:** Documents are loaded on-demand, not at startup. Use context-fetcher subagent when needed.

### Product Information (load via context-fetcher)
- **Product Vision**: agent-os/product/product-brief.md
- **Technical Architecture**: agent-os/product/tech-stack.md
- **Development Roadmap**: agent-os/product/roadmap.md
- **Architecture Decision**: agent-os/product/architecture-decision.md

### Development Standards (load via context-fetcher)
- **Tech Stack Defaults**: agent-os/standards/tech-stack.md
- **Code Style Preferences**: agent-os/standards/code-style.md
- **Best Practices Philosophy**: agent-os/standards/best-practices.md

### Agent OS Workflows (loaded automatically via slash commands)
Available commands - workflow context loads when invoked:
- `/plan-product` - Single-product planning
- `/plan-platform` - Multi-module platform planning
- `/build-development-team` - Create DevTeam agents
- `/create-spec` - Feature specifications
- `/execute-tasks` - Task execution
- `/retroactive-doc` - Document existing features


## Critical Rules
- **FOLLOW ALL INSTRUCTIONS** - These are mandatory, not optional
- **ASK FOR CLARIFICATION** - If uncertain about any requirement
- **MINIMIZE CHANGES** - Edit only what's necessary
- **PRODUCTION SAFETY** - [CUSTOMIZE: Add your production safety context]

## Sub-Agents
**MANDATORY DELEGATION** - Sub-agents have separate context windows. You are the strategic brain that makes high-level decisions.

**Delegation Strategy:**
- **Strategic Planning** → You decide WHAT needs to be done
- **Implementation Planning** → Delegate to Core Development specialists  
- **Execution Tasks** → Delegate to Utility & Support agents
- **Context Optimization** → Use sub-agents to keep routine tasks out of your main context

**Rule:** Never do what a specialist can do better. Always delegate when sub-agents are available.

### Core Development
<!-- CUSTOMIZE: Add your project-specific development agents -->
- **[ROLE-NAME]** - [TECHNOLOGY_DESCRIPTION]
- **[ROLE-NAME]** - [TECHNOLOGY_DESCRIPTION]

### Quality & Infrastructure
<!-- CUSTOMIZE: Add your project-specific quality agents -->
- **testing-specialist** - [YOUR_TESTING_STACK]
- **security-specialist** - [YOUR_SECURITY_SETUP]
- **devops-specialist** - [YOUR_DEPLOYMENT_PLATFORM]

### Utility & Support
- **context-fetcher** - Retrieve and extract relevant information from Agent OS documentation
- **date-checker** - Determine today's date including current year, month and day
- **file-creator** - Create files, directories, and apply templates for Agent OS workflows
- **git-workflow** - Handle git operations, branch management, commits, and PR creation
- **debugger** - Immediate bug fixes and runtime errors
- **analyzer** - Strategic problem analysis (5-Why methodology)


## Essential Commands

```bash
# Product Planning
/plan-product            # Single-product planning (brief, tech-stack, roadmap)
/plan-platform           # Multi-module platform planning (modules, dependencies, architecture)

# Team Setup
/build-development-team  # Create DevTeam agents and skills

# Feature Development
/create-spec             # Create detailed specifications for new features
/execute-tasks           # Execute planned implementation tasks
/retroactive-doc         # Document existing features without specs

# Bug Management
/create-bug              # Create bug specification
/add-bug                 # Add bug to existing spec

# CUSTOMIZE: Add your project-specific commands
# Development
[COMMAND]                # [DESCRIPTION]
[COMMAND]                # [DESCRIPTION]

# Testing
[COMMAND]                # [DESCRIPTION]
[COMMAND]                # [DESCRIPTION]
```

## MCP Server Integration

<!-- CUSTOMIZE: Add your MCP server integrations -->
- **[MCP_NAME]** - [DESCRIPTION]
- **[MCP_NAME]** - [DESCRIPTION]

## File Organization Rules

**CRITICAL - No Files in Project Root:**
- ❌ NEVER create markdown reports, checklists, or documentation in project root
- ❌ NEVER create implementation reports like `STORY-001-IMPLEMENTATION.md` in root
- ❌ NEVER create temporary files in root

**Correct Locations:**
- ✅ Implementation reports: `agent-os/specs/[spec-name]/implementation-reports/`
- ✅ Testing checklists: `agent-os/specs/[spec-name]/implementation-reports/`
- ✅ Handover docs: `agent-os/specs/[spec-name]/handover-docs/`
- ✅ Architecture docs: `agent-os/product/`
- ✅ Team docs: `agent-os/team/`
- ✅ Temporary files: `/tmp/` or `node_modules/.cache/`

**When delegating to DevTeam agents:**
Explicitly instruct them on correct file placement for any reports or documentation.

## Quality Requirements

**Mandatory Checks:**
- Run linting after ALL code changes
- ALL lint errors must be fixed before task completion
- Follow TypeScript strict mode (no `any` types)
<!-- CUSTOMIZE: Add your project-specific quality requirements -->

## Production Safety Rules

**CRITICAL RESTRICTIONS:**
<!-- CUSTOMIZE: Add your production safety rules -->
- Never modify [CRITICAL_SYSTEM] without approval
- Never deploy [SENSITIVE_COMPONENT] without approval  
- Never create automatic Git commits
- Always ask before infrastructure changes

## Feature Development Workflow

**Complete Lifecycle Management:**

1. **Product/Platform Planning:**
   - `/plan-product` → Single cohesive products
   - `/plan-platform` → Multi-module platforms
   - Creates: product-brief.md, tech-stack.md, roadmap.md, architecture-decision.md

2. **Team Setup:**
   - `/build-development-team` → Creates DevTeam agents & skills
   - Generates role-specific agents based on tech-stack

3. **Feature Development:**
   - `/create-spec` → Creates detailed specification
   - `/execute-tasks` → Executes planned tasks with DevTeam
   - Creates spec in `agent-os/specs/YYYY-MM-DD-feature-name/`

4. **Bug Management:**
   - `/create-bug` → Creates bug specification
   - `/add-bug` → Adds bug to existing spec

5. **Retroactive Documentation:**
   - `/retroactive-doc` → Documents existing features without specs
   - Analyzes code to create comprehensive documentation
   - Perfect for legacy features

**Directory Structure:**
- `agent-os/product/` - Product vision, tech-stack, roadmap
- `agent-os/specs/` - Feature specifications (development-oriented)
- `agent-os/team/` - DevTeam agents and skills

## Workflow Resume (Post-Compaction Recovery)

**IMPORTANT:** After conversation compaction, workflow context may be lost. Follow these recovery steps:

**Detecting Active Workflows:**
```bash
# Check for active Kanban boards (indicates /execute-tasks in progress)
ls agent-os/specs/*/kanban-board.md 2>/dev/null
```

**Recovery Protocol:**
1. **If Kanban Board exists with "In Progress" stories:**
   - Read the Kanban Board file
   - Find the "🔄 Resume Context" section at the top
   - Follow the "Resume Instructions" in that section
   - The Resume Context contains: current step, current story, assigned agent, next action

2. **Critical: Maintain Delegation Pattern**
   - ALWAYS delegate to DevTeam agents via Task tool
   - NEVER implement code directly after compaction
   - The Kanban Board "Agent Assignment Rules" shows which agent handles which story type

3. **After Each Action:**
   - Update the Kanban Board's Resume Context section
   - This ensures the next compaction can also recover

**Quick Resume Command:**
If unsure, simply run `/execute-tasks` again - it will detect the existing Kanban Board and offer resume options.

## Development Notes

<!-- CUSTOMIZE: Add your project-specific development context -->
- **Platform:** [YOUR_PLATFORM_DESCRIPTION]
- **Current Focus:** [CURRENT_DEVELOPMENT_PRIORITIES]
- **Architecture Notes:** [IMPORTANT_ARCHITECTURAL_DECISIONS]

---

**Remember:** This is a [PRODUCTION/DEVELOPMENT] system serving [TARGET_AUDIENCE]. Quality, [KEY_REQUIREMENTS], and reliability are paramount. Always refer to Agent OS documentation for detailed guidance.