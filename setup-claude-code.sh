#!/bin/bash

# Agent OS Extended - Claude Code Setup
# Installs Claude Code specific commands and agents for DevTeam workflow
# Version: 2.2

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

    # Platform planning
    "plan-platform.md"

    # Team setup
    "build-development-team.md"

    # Spec development
    "create-spec.md"
    "retroactive-doc.md"

    # Bug management
    "add-bug.md"
    "create-bug.md"

    # Task execution
    "execute-tasks.md"

    # Skill management
    "add-skill.md"
    "migrate-skills.md"
    "toggle-skill-activation.md"
)

for file in "${command_files[@]}"; do
    download_file "$REPO_URL/.claude/commands/agent-os/$file" ".claude/commands/agent-os/$file"
done

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
echo "    ├── commands/agent-os/   (11 core commands)"
echo "    └── agents/              (9 utility agents)"
echo ""
echo "📋 Available Commands:"
echo ""
echo "  Product Planning:"
echo "    /plan-product             → Single-product planning"
echo "    /plan-platform            → Multi-module platform planning"
echo ""
echo "  Team Setup:"
echo "    /build-development-team   → Create DevTeam agents and skills"
echo ""
echo "  Feature Development:"
echo "    /create-spec              → PO + Architect create spec with user stories"
echo "    /retroactive-doc          → Document existing features (legacy code)"
echo ""
echo "  Bug Management:"
echo "    /add-bug [spec]           → Add bug to existing spec"
echo "    /create-bug               → Create standalone bug spec"
echo ""
echo "  Execution:"
echo "    /execute-tasks            → Orchestrator executes user stories via DevTeam"
echo "                                 (includes bugs, docs, and changelog generation)"
echo ""
echo "  Skill Management:"
echo "    /add-skill                → Create custom skills for DevTeam agents"
echo "    /migrate-skills           → Add YAML frontmatter to existing skills"
echo "    /toggle-skill-activation  → Change skill activation mode"
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
echo ""
echo "🎯 Recommended Workflow:"
echo ""
echo "1. /plan-product (single product) OR /plan-platform (multi-module)"
echo "   → Creates product-brief.md, tech-stack.md, roadmap.md"
echo "   → Step 5.5: Choose to generate project-specific standards"
echo ""
echo "2. /build-development-team"
echo "   → Creates dev-team__architect, dev-team__po, dev-team__documenter"
echo "   → Choose additional agents (backend, frontend, devops, qa)"
echo "   → Generates tech-stack-specific skills per agent"
echo "   → Creates dod.md and dor.md"
echo ""
echo "3. /create-spec \"Feature Name\""
echo "   → dev-team__po gathers fachliche requirements"
echo "   → dev-team__architect does technical refinement"
echo "   → Creates user-stories.md with DoR/DoD"
echo ""
echo "4. /execute-tasks"
echo "   → Claude Code orchestrates DevTeam execution"
echo "   → Creates kanban-board.md (resumable!)"
echo "   → Executes stories with quality gates"
echo "   → Commits per story, generates docs"
echo ""
echo "5. /add-bug [spec-name] \"Bug description\""
echo "   → Adds bug to existing spec's kanban"
echo "   → Option to fix immediately or later"
echo ""
echo "📚 Learn More:"
echo "  • See INSTALL.md for detailed guide"
echo "  • See agent-os-workflow-complete.md for system diagram"
echo "  • Check CLAUDE.md for project-specific instructions"
echo ""
echo "For more info: https://github.com/michsindlinger/agent-os-extended"
echo ""
