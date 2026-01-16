#!/bin/bash

# Agent OS Extended - DevTeam System Installation
# Installs core Agent OS structure for DevTeam workflow
# Version: 2.1

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"
OVERWRITE_WORKFLOWS=false
OVERWRITE_STANDARDS=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --overwrite-workflows)
            OVERWRITE_WORKFLOWS=true
            shift
            ;;
        --overwrite-standards)
            OVERWRITE_STANDARDS=true
            shift
            ;;
        -h|--help)
            echo "Agent OS DevTeam System - Project Installation"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --overwrite-workflows      Overwrite existing workflow files"
            echo "  --overwrite-standards      Overwrite existing standards files"
            echo "  -h, --help                 Show this help message"
            echo ""
            echo "Installs Agent OS DevTeam system in current project."
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

echo "🤖 Agent OS DevTeam System v2.1 - Project Installation"
echo "Installing core structure in current project..."
echo ""

# Create project directories
echo "Creating directory structure..."
mkdir -p agent-os/standards
mkdir -p agent-os/workflows/core
mkdir -p agent-os/workflows/meta
mkdir -p agent-os/templates  # For optional project overrides
mkdir -p agent-os/docs  # Documentation and guides

# Function to download file if it doesn't exist or if overwrite is enabled
download_file() {
    local url=$1
    local path=$2
    local category=$3

    if [[ -f "$path" ]]; then
        if [[ "$category" == "standards" && "$OVERWRITE_STANDARDS" == true ]] ||
           [[ "$category" == "workflows" && "$OVERWRITE_WORKFLOWS" == true ]]; then
            echo "Overwriting $path..."
            curl -sSL "$url" -o "$path"
        else
            echo "Skipping $path (already exists)"
        fi
    else
        echo "Downloading $path..."
        curl -sSL "$url" -o "$path"
    fi
}

# ═══════════════════════════════════════════════════════════
# STANDARDS
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Standards ═══"

# Core standards only (global fallback available via setup-devteam-global.sh)
download_file "$REPO_URL/agent-os/standards/code-style.md" "agent-os/standards/code-style.md" "standards"
download_file "$REPO_URL/agent-os/standards/best-practices.md" "agent-os/standards/best-practices.md" "standards"

# ═══════════════════════════════════════════════════════════
# DOCS - Documentation and Guides
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Documentation ═══"

download_file "$REPO_URL/agent-os/docs/story-sizing-guidelines.md" "agent-os/docs/story-sizing-guidelines.md" "docs"
download_file "$REPO_URL/agent-os/docs/mcp-setup-guide.md" "agent-os/docs/mcp-setup-guide.md" "docs"
download_file "$REPO_URL/agent-os/docs/agent-learning-guide.md" "agent-os/docs/agent-learning-guide.md" "docs"

# ═══════════════════════════════════════════════════════════
# WORKFLOWS - Core DevTeam Workflows Only
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Core Workflows ═══"

# Meta workflow
download_file "$REPO_URL/agent-os/workflows/meta/pre-flight.md" "agent-os/workflows/meta/pre-flight.md" "workflows"

# Product planning
download_file "$REPO_URL/agent-os/workflows/core/plan-product.md" "agent-os/workflows/core/plan-product.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/analyze-feasibility.md" "agent-os/workflows/core/analyze-feasibility.md" "workflows"

# Platform planning
download_file "$REPO_URL/agent-os/workflows/core/plan-platform.md" "agent-os/workflows/core/plan-platform.md" "workflows"

# Blocker analysis
download_file "$REPO_URL/agent-os/workflows/core/analyze-blockers.md" "agent-os/workflows/core/analyze-blockers.md" "workflows"

# Milestone planning
download_file "$REPO_URL/agent-os/workflows/core/plan-milestones.md" "agent-os/workflows/core/plan-milestones.md" "workflows"

# Team setup
download_file "$REPO_URL/agent-os/workflows/core/build-development-team.md" "agent-os/workflows/core/build-development-team.md" "workflows"

# Spec development
download_file "$REPO_URL/agent-os/workflows/core/create-spec.md" "agent-os/workflows/core/create-spec.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/add-story.md" "agent-os/workflows/core/add-story.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/retroactive-doc.md" "agent-os/workflows/core/retroactive-doc.md" "workflows"

# Bug management
download_file "$REPO_URL/agent-os/workflows/core/add-bug.md" "agent-os/workflows/core/add-bug.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/create-bug.md" "agent-os/workflows/core/create-bug.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/execute-bug.md" "agent-os/workflows/core/execute-bug.md" "workflows"

# Task execution
download_file "$REPO_URL/agent-os/workflows/core/execute-tasks.md" "agent-os/workflows/core/execute-tasks.md" "workflows"

# Backlog / Quick tasks
download_file "$REPO_URL/agent-os/workflows/core/add-todo.md" "agent-os/workflows/core/add-todo.md" "workflows"

# Skill management
download_file "$REPO_URL/agent-os/workflows/core/add-skill.md" "agent-os/workflows/core/add-skill.md" "workflows"

# ═══════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Setting up Configuration ═══"

if [[ ! -f "agent-os/config.yml" ]]; then
    cat > agent-os/config.yml << 'EOF'
# Agent OS DevTeam System Configuration
# Version: 2.1

# Project Information
project:
  name: "[PROJECT_NAME]"  # Customize this

# DevTeam System
devteam:
  enabled: false  # Set to true after /build-development-team

# Workflow Settings
workflows:
  auto_commit_per_story: true  # Git commit after each story completion

# Standards Lookup
standards:
  # Order: project first, then global fallback
  # Project: .agent-os/standards/code-style.md
  # Global: ~/.agent-os/standards/code-style.md
  use_global_fallback: true
EOF
    echo "✓ Created agent-os/config.yml"
    echo "📝 Customize project.name in agent-os/config.yml"
else
    echo "Skipping agent-os/config.yml (already exists)"
fi

# ═══════════════════════════════════════════════════════════
# CLAUDE.md
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Setting up CLAUDE.md ═══"

if [[ -f "CLAUDE.md" ]]; then
    echo "CLAUDE.md already exists - creating CLAUDE.md.template for reference"
    download_file "$REPO_URL/CLAUDE.md" "CLAUDE.md.template" "claude"
    echo "💡 Consider merging CLAUDE.md.template into your existing CLAUDE.md"
else
    echo "Creating CLAUDE.md from template..."
    download_file "$REPO_URL/CLAUDE.md" "CLAUDE.md" "claude"
    echo "📝 Customize CLAUDE.md with your project-specific information"
fi

# ═══════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══════════════════════════════════════════"
echo "✅ Agent OS DevTeam System v2.1 Installed!"
echo "═══════════════════════════════════════════"
echo ""
echo "📁 Installed Structure:"
echo ""
echo "  agent-os/"
echo "    ├── standards/              (2 core files)"
echo "    ├── workflows/core/         (15 core workflows)"
echo "    ├── workflows/meta/         (1 meta workflow)"
echo "    └── config.yml              (minimal configuration)"
echo ""
echo "  CLAUDE.md                     (project instructions template)"
echo ""
echo "📊 Statistics:"
echo "  • Standards: 2 files"
echo "  • Workflows: 16 files (15 core + 1 meta)"
echo "  • Config: 1 file"
echo "  • Total: 19 files + CLAUDE.md"
echo ""
echo "📚 Templates (53 files) installed globally:"
echo "  Templates are loaded from ~/.agent-os/templates/"
echo "  Run setup-devteam-global.sh if not yet installed."
echo ""
echo "  Hybrid lookup:"
echo "    1. Check: agent-os/templates/ (project override)"
echo "    2. Fallback: ~/.agent-os/templates/ (global)"
echo ""
echo "🎯 Next Steps:"
echo ""
echo "1. Customize CLAUDE.md:"
echo "   nano CLAUDE.md"
echo "   → Add your project name, description, tech stack hints"
echo ""
echo "2. Install Claude Code support:"
echo "   curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash"
echo "   → Installs .claude/commands/ and .claude/agents/"
echo ""
echo "3. Start your workflow:"
echo "   /plan-product"
echo "   → Creates product-brief.md, tech-stack.md, roadmap.md"
echo "   → Optional: Generate project-specific standards (Step 5.5)"
echo ""
echo "4. Build your DevTeam:"
echo "   /build-development-team"
echo "   → Creates dev-team agents from templates"
echo "   → Generates tech-stack-specific skills"
echo "   → Creates dod.md and dor.md"
echo ""
echo "5. Develop features:"
echo "   /create-spec        → PO + Architect create user stories"
echo "   /add-story [spec]   → Add story to existing spec"
echo "   /execute-tasks      → Orchestrator executes via DevTeam"
echo ""
echo "6. Quick tasks & bugs (lightweight, goes to backlog):"
echo "   /add-todo           → Add quick task to backlog"
echo "   /add-bug            → Add bug with root-cause analysis"
echo "   /execute-tasks backlog → Execute backlog tasks"
echo ""
echo "7. Skill management:"
echo "   /add-skill          → Create custom skills for agents"
echo ""
echo "📚 Documentation:"
echo "  • Installation Guide: INSTALL.md (created after Claude Code setup)"
echo "  • Workflow Diagram: agent-os-workflow-complete.md"
echo ""
echo "⚠️  Prerequisites:"
echo ""
echo "  Templates are loaded from ~/.agent-os/templates/"
echo "  If not yet installed, run:"
echo "    curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-devteam-global.sh | bash"
echo ""
echo "  This installs 70 templates + 3 global standards to ~/.agent-os/"
echo ""
echo "For more info: https://github.com/michsindlinger/agent-os-extended"
echo ""
