#!/bin/bash

# Agent OS Extended - Claude Code Setup
# Installs Claude Code specific commands and agents for DevTeam workflow
# Version: 3.0 - Direct Execution with Self-Learning Skills

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "🤖 Agent OS DevTeam System - Claude Code Setup"
echo "Installing Claude Code configuration in current project..."
echo ""

# Check if base Agent OS is installed in project
if [[ ! -d "agent-os/templates" ]] || [[ ! -d "agent-os/workflows" ]]; then
    echo "❌ Error: Agent OS base installation not found in current project."
    echo ""
    echo "Please run the base setup first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash"
    echo ""
    exit 1
fi

# Create Claude Code specific directories
echo "Creating Claude Code directories..."
mkdir -p .claude/commands/agent-os
mkdir -p .claude/agents

# Function to download file
download_file() {
    local url=$1
    local path=$2

    echo "Downloading $path..."
    curl -sSL "$url" -o "$path"
}

# ═══════════════════════════════════════════════════════════
# COMMANDS - Core DevTeam Commands
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Core Commands ═══"

command_files=(
    # Product planning
    "plan-product.md"
    "analyze-feasibility.md"

    # Platform planning
    "plan-platform.md"

    # Blocker analysis
    "analyze-blockers.md"

    # Milestone planning
    "plan-milestones.md"

    # Team setup
    "build-development-team.md"

    # Spec development
    "create-spec.md"
    "add-story.md"
    "retroactive-doc.md"

    # Bug management
    "add-bug.md"
    "create-bug.md"

    # Task execution
    "execute-tasks.md"
    "add-todo.md"

    # v3.0: Self-Learning Commands
    "add-learning.md"
    "add-domain.md"

    # Skill management
    "add-skill.md"
    "migrate-skills.md"
    "toggle-skill-activation.md"
    "migrate-devteam-v2.md"

    # Kanban migration
    "migrate-kanban.md"

    # Feedback processing
    "process-feedback.md"

    # Brainstorming
    "start-brainstorming.md"
    "transfer-and-create-spec.md"
    "transfer-and-create-bug.md"
    "transfer-and-plan-product.md"

    # Profile optimization
    "optimize-profile.md"
    "optimize-profile-match.md"

    # Accessibility validation
    "validate-accessibility-report.md"
)

for file in "${command_files[@]}"; do
    download_file "$REPO_URL/.claude/commands/agent-os/$file" ".claude/commands/agent-os/$file"
done

# ═══════════════════════════════════════════════════════════
# SKILLS - User-Invocable Skills
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Skills ═══"

mkdir -p .claude/skills/review-implementation-plan

download_file "$REPO_URL/.claude/skills/review-implementation-plan/SKILL.md" ".claude/skills/review-implementation-plan/SKILL.md"

# ═══════════════════════════════════════════════════════════
# AGENTS - Utility Agents Only
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Utility Agents ═══"

# Core utility agents
download_file "$REPO_URL/.claude/agents/context-fetcher.md" ".claude/agents/context-fetcher.md"
download_file "$REPO_URL/.claude/agents/file-creator.md" ".claude/agents/file-creator.md"
download_file "$REPO_URL/.claude/agents/git-workflow.md" ".claude/agents/git-workflow.md"
download_file "$REPO_URL/.claude/agents/date-checker.md" ".claude/agents/date-checker.md"
download_file "$REPO_URL/.claude/agents/test-runner.md" ".claude/agents/test-runner.md"

# Product planning agents
download_file "$REPO_URL/.claude/agents/product-strategist.md" ".claude/agents/product-strategist.md"
download_file "$REPO_URL/.claude/agents/tech-architect.md" ".claude/agents/tech-architect.md"
download_file "$REPO_URL/.claude/agents/design-extractor.md" ".claude/agents/design-extractor.md"
download_file "$REPO_URL/.claude/agents/ux-designer.md" ".claude/agents/ux-designer.md"
download_file "$REPO_URL/.claude/agents/business-analyst.md" ".claude/agents/business-analyst.md"

# Note: DevTeam agents (dev-team__architect, backend-dev, frontend-dev, etc.)
# are created dynamically via /build-development-team command

# ═══════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════

echo ""
echo "════════════════════════════════════"
echo "✅ Claude Code Setup Complete!"
echo "════════════════════════════════════"
echo ""
echo "📁 Installed Structure:"
echo ""
echo "  .claude/"
echo "    ├── commands/agent-os/   (25 core commands)"
echo "    ├── skills/              (1 user-invocable skill)"
echo "    └── agents/              (10 utility agents)"
echo ""
echo "📋 Available Commands:"
echo ""
echo "  Product Planning:"
echo "    /plan-product             → Single-product planning"
echo "    /plan-platform            → Multi-module platform planning"
echo "    /analyze-feasibility      → Feasibility analysis (GO/CAUTION/NO-GO)"
echo "    /analyze-blockers         → Identify external dependencies and blockers"
echo "    /plan-milestones          → Milestone-based payment plan for fixed-price projects"
echo ""
echo "  Team Setup (v3.0):"
echo "    /build-development-team   → Create skills for main agent (no sub-agents)"
echo ""
echo "  Feature Development:"
echo "    /create-spec              → PO + Architect create spec with user stories"
echo "    /add-story [spec]         → Add new story to existing spec"
echo "    /retroactive-doc          → Document existing features (legacy code)"
echo ""
echo "  Bug Management:"
echo "    /add-bug                  → Add bug to backlog with root-cause analysis"
echo "                                 (Hypothesis-driven debugging, same quality as /add-todo)"
echo "    /create-bug               → Create standalone bug spec (for complex bugs)"
echo ""
echo "  Quick Tasks:"
echo "    /add-todo                 → Add lightweight task to backlog"
echo "                                 (PO + Architect refinement, same story template)"
echo ""
echo "  Execution (v3.0 Direct Execution):"
echo "    /execute-tasks            → Main agent implements stories directly"
echo "    /execute-tasks backlog    → Execute quick tasks from backlog"
echo "    /execute-tasks [spec]     → Execute specific specification"
echo ""
echo "  Self-Learning (NEW in v3.0):"
echo "    /add-learning             → Add insight to skill dos-and-donts.md"
echo "    /add-domain              → Add business domain area documentation"
echo ""
echo "  Brainstorming:"
echo "    /start-brainstorming      → Interactive idea exploration"
echo "    /transfer-and-create-spec → Convert brainstorming to spec"
echo "    /transfer-and-create-bug  → Convert brainstorming to bug report"
echo "    /transfer-and-plan-product → Convert brainstorming to product plan"
echo ""
echo "  Profile Optimization:"
echo "    /optimize-profile         → Full profile optimization (Phase 1 + 2)"
echo "    /optimize-profile-match   → Job-specific profile matching (Phase 2 only)"
echo ""
echo "  Skill Management:"
echo "    /add-skill                → Create custom skills for DevTeam agents"
echo "    /migrate-skills           → Add YAML frontmatter to existing skills"
echo "    /toggle-skill-activation  → Change skill activation mode"
echo "    /migrate-devteam-v2       → Migrate DevTeam to v2.0 (skill-index)"
echo ""
echo "  Migration:"
echo "    /migrate-kanban           → Migrate MD kanbans to JSON format"
echo ""
echo "  Feedback Processing:"
echo "    /process-feedback         → Analyze customer feedback into specs/bugs/todos"
echo ""
echo "  Plan Review:"
echo "    /review-implementation-plan → Standalone review of implementation plans"
echo "                                   (Self-Review + Minimalinvasiv-Analyse)"
echo ""
echo "🤖 Utility Agents Installed:"
echo "  • context-fetcher    → Conditional file loading"
echo "  • file-creator       → File and directory creation"
echo "  • git-workflow       → Git operations (commit, push, PR)"
echo "  • date-checker       → Current date determination"
echo "  • test-runner        → Test suite execution"
echo "  • product-strategist → Product planning and strategy"
echo "  • tech-architect     → Tech stack and architecture decisions"
echo "  • design-extractor   → Design system extraction from URLs/screenshots"
echo "  • ux-designer        → UX patterns definition and frontend review"
echo "  • business-analyst   → Blocker analysis and GO/NO-GO decisions"
echo ""
echo "🎯 Recommended Workflow:"
echo ""
echo "1. /plan-product (single product) OR /plan-platform (multi-module)"
echo "   → Creates product-brief.md, tech-stack.md, roadmap.md"
echo "   → Step 5.5: Choose to generate project-specific standards"
echo ""
echo "2. /build-development-team (v3.0)"
echo "   → Creates skills in .claude/skills/ (Claude Code standard)"
echo "   → Quality Gates skill (always active)"
echo "   → Technology skills (Angular, React, Rails, NestJS, etc.)"
echo "   → Optional: Domain skill for business knowledge"
echo "   → Creates dod.md and dor.md"
echo "   → NO sub-agents - main agent executes directly"
echo ""
echo "3. /start-brainstorming (optional)"
echo "   → Interactive exploration of ideas"
echo "   → Challenges assumptions, explores edge cases"
echo "   → /transfer-and-create-spec converts to formal spec"
echo ""
echo "4. /create-spec \"Feature Name\""
echo "   → PO gathers fachliche requirements"
echo "   → Architect does technical refinement"
echo "   → Creates user-stories.md with DoR/DoD"
echo "   → Stories reference domain areas (optional)"
echo ""
echo "5. /execute-tasks (v3.0 Direct Execution)"
echo "   → Main agent implements stories directly"
echo "   → Skills auto-load via glob patterns"
echo "   → Self-review with DoD checklist"
echo "   → Self-learning: updates dos-and-donts.md"
echo "   → Domain updates: keeps business docs current"
echo "   → Commits per story"
echo ""
echo "6. /add-bug \"Bug description\""
echo "   → Hypothesis-driven root-cause analysis"
echo "   → Creates bug story in backlog"
echo "   → Execute with /execute-tasks backlog"
echo ""
echo "Quick Tasks (alternative to create-spec):"
echo ""
echo "  /add-todo \"Loading state for modal\""
echo "   → Creates lightweight user story in backlog"
echo "   → Same quality (PO + Architect) but minimal overhead"
echo ""
echo "  /execute-tasks backlog"
echo "   → Creates daily kanban (kanban-YYYY-MM-DD.md)"
echo "   → Executes quick tasks without git worktree"
echo ""
echo "📚 Learn More:"
echo "  • See INSTALL.md for detailed guide"
echo "  • See agent-os-workflow-complete.md for system diagram"
echo "  • Check CLAUDE.md for project-specific instructions"
echo ""
echo "For more info: https://github.com/michsindlinger/agent-os-extended"
echo ""
