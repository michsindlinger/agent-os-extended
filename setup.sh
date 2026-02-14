#!/bin/bash

# Specwright - DevTeam System Installation
# Installs core Specwright structure for DevTeam workflow
# Version: 2.3 - Phase-based execute-tasks for 80% context reduction

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/specwright/main"
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
            echo "Specwright DevTeam System - Project Installation"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --overwrite-workflows      Overwrite existing workflow files"
            echo "  --overwrite-standards      Overwrite existing standards files"
            echo "  -h, --help                 Show this help message"
            echo ""
            echo "Installs Specwright DevTeam system in current project."
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

echo "🤖 Specwright DevTeam System v2.3 - Project Installation"
echo "Installing core structure in current project..."
echo ""

# Legacy detection: Check for existing agent-os/ installation
if [[ -d "agent-os" && ! -L "agent-os" ]]; then
    echo "⚠️  Detected existing agent-os/ installation."
    echo "   Agent OS has been renamed to Specwright."
    echo ""
    echo "   To migrate your existing project, run:"
    echo "   curl -fsSL https://raw.githubusercontent.com/michsindlinger/specwright/main/migrate-to-specwright.sh | bash"
    echo ""
    echo "   Or use --fresh flag for a clean install alongside existing agent-os/."
    echo ""
    exit 1
fi

# Create project directories
echo "Creating directory structure..."
mkdir -p specwright/standards
mkdir -p specwright/workflows/core
mkdir -p specwright/workflows/meta
mkdir -p specwright/templates  # For optional project overrides
mkdir -p specwright/templates/product  # For product templates
mkdir -p specwright/docs  # Documentation and guides

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
download_file "$REPO_URL/specwright/standards/code-style.md" "specwright/standards/code-style.md" "standards"
download_file "$REPO_URL/specwright/standards/best-practices.md" "specwright/standards/best-practices.md" "standards"
download_file "$REPO_URL/specwright/standards/plan-review-guidelines.md" "specwright/standards/plan-review-guidelines.md" "standards"

# ═══════════════════════════════════════════════════════════
# DOCS - Documentation and Guides
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Documentation ═══"

download_file "$REPO_URL/specwright/docs/story-sizing-guidelines.md" "specwright/docs/story-sizing-guidelines.md" "docs"
download_file "$REPO_URL/specwright/docs/mcp-setup-guide.md" "specwright/docs/mcp-setup-guide.md" "docs"
download_file "$REPO_URL/specwright/docs/agent-learning-guide.md" "specwright/docs/agent-learning-guide.md" "docs"

# ═══════════════════════════════════════════════════════════
# WORKFLOWS - Core DevTeam Workflows Only
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Core Workflows ═══"

# Meta workflow
download_file "$REPO_URL/specwright/workflows/meta/pre-flight.md" "specwright/workflows/meta/pre-flight.md" "workflows"

# Security 
download_file "$REPO_URL/specwright/templates/product/secrets-template.md" "specwright/templates/product/secrets-template.md" "templates" 

# Product planning
download_file "$REPO_URL/specwright/workflows/core/plan-product.md" "specwright/workflows/core/plan-product.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/analyze-feasibility.md" "specwright/workflows/core/analyze-feasibility.md" "workflows"

# Platform planning
download_file "$REPO_URL/specwright/workflows/core/plan-platform.md" "specwright/workflows/core/plan-platform.md" "workflows"

# Blocker analysis
download_file "$REPO_URL/specwright/workflows/core/analyze-blockers.md" "specwright/workflows/core/analyze-blockers.md" "workflows"

# Milestone planning
download_file "$REPO_URL/specwright/workflows/core/plan-milestones.md" "specwright/workflows/core/plan-milestones.md" "workflows"

# Team setup
download_file "$REPO_URL/specwright/workflows/core/build-development-team.md" "specwright/workflows/core/build-development-team.md" "workflows"

# Spec development
download_file "$REPO_URL/specwright/workflows/core/create-spec.md" "specwright/workflows/core/create-spec.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/add-story.md" "specwright/workflows/core/add-story.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/retroactive-doc.md" "specwright/workflows/core/retroactive-doc.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/retroactive-spec.md" "specwright/workflows/core/retroactive-spec.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/change-spec.md" "specwright/workflows/core/change-spec.md" "workflows"

# Bug management
download_file "$REPO_URL/specwright/workflows/core/add-bug.md" "specwright/workflows/core/add-bug.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/create-bug.md" "specwright/workflows/core/create-bug.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-bug.md" "specwright/workflows/core/execute-bug.md" "workflows"

# Task execution (Phase-based architecture v3.0)
mkdir -p specwright/workflows/core/execute-tasks
mkdir -p specwright/workflows/core/execute-tasks/shared
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/entry-point.md" "specwright/workflows/core/execute-tasks/entry-point.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/spec-phase-1.md" "specwright/workflows/core/execute-tasks/spec-phase-1.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/spec-phase-2.md" "specwright/workflows/core/execute-tasks/spec-phase-2.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/spec-phase-3.md" "specwright/workflows/core/execute-tasks/spec-phase-3.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/spec-phase-4-5.md" "specwright/workflows/core/execute-tasks/spec-phase-4-5.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/spec-phase-5.md" "specwright/workflows/core/execute-tasks/spec-phase-5.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/backlog-phase-1.md" "specwright/workflows/core/execute-tasks/backlog-phase-1.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/backlog-phase-2.md" "specwright/workflows/core/execute-tasks/backlog-phase-2.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/backlog-phase-3.md" "specwright/workflows/core/execute-tasks/backlog-phase-3.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/shared/resume-context.md" "specwright/workflows/core/execute-tasks/shared/resume-context.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/shared/error-handling.md" "specwright/workflows/core/execute-tasks/shared/error-handling.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/execute-tasks/shared/skill-extraction.md" "specwright/workflows/core/execute-tasks/shared/skill-extraction.md" "workflows"

# Backlog / Quick tasks
download_file "$REPO_URL/specwright/workflows/core/add-todo.md" "specwright/workflows/core/add-todo.md" "workflows"

# Concept planning
download_file "$REPO_URL/specwright/workflows/core/plan-concept.md" "specwright/workflows/core/plan-concept.md" "workflows"

# Brainstorming
download_file "$REPO_URL/specwright/workflows/core/start-brainstorming.md" "specwright/workflows/core/start-brainstorming.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/transfer-and-create-spec.md" "specwright/workflows/core/transfer-and-create-spec.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/transfer-and-create-bug.md" "specwright/workflows/core/transfer-and-create-bug.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/transfer-and-plan-product.md" "specwright/workflows/core/transfer-and-plan-product.md" "workflows"

# Profile optimization
download_file "$REPO_URL/specwright/workflows/core/optimize-profile.md" "specwright/workflows/core/optimize-profile.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/optimize-profile-phase2.md" "specwright/workflows/core/optimize-profile-phase2.md" "workflows"

# Skill management
download_file "$REPO_URL/specwright/workflows/core/add-skill.md" "specwright/workflows/core/add-skill.md" "workflows"
download_file "$REPO_URL/specwright/workflows/core/migrate-devteam-v2.md" "specwright/workflows/core/migrate-devteam-v2.md" "workflows"

# Accessibility validation
download_file "$REPO_URL/specwright/workflows/core/validate-accessibility-report.md" "specwright/workflows/core/validate-accessibility-report.md" "workflows"

# Migration
download_file "$REPO_URL/specwright/workflows/core/migrate-kanban.md" "specwright/workflows/core/migrate-kanban.md" "workflows"

# Feedback processing
download_file "$REPO_URL/specwright/workflows/core/process-feedback.md" "specwright/workflows/core/process-feedback.md" "workflows"

# OpenClaw Strategy
mkdir -p specwright/workflows/openclaw
mkdir -p specwright/templates/openclaw
download_file "$REPO_URL/specwright/workflows/openclaw/openclaw-strategy.md" "specwright/workflows/openclaw/openclaw-strategy.md" "workflows"
download_file "$REPO_URL/specwright/templates/openclaw/strategy-document-template.md" "specwright/templates/openclaw/strategy-document-template.md" "templates"

# ═══════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Setting up Configuration ═══"

if [[ ! -f "specwright/config.yml" ]]; then
    cat > specwright/config.yml << 'EOF'
# Specwright DevTeam System Configuration
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
  # Project: .specwright/standards/code-style.md
  # Global: ~/.specwright/standards/code-style.md
  use_global_fallback: true
EOF
    echo "✓ Created specwright/config.yml"
    echo "📝 Customize project.name in specwright/config.yml"
else
    echo "Skipping specwright/config.yml (already exists)"
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
# MCP SERVER (OPTIONAL)
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Kanban MCP Server (optional) ═══"

if command -v npx >/dev/null 2>&1; then
  echo "Installing Kanban MCP Server..."
  bash setup-mcp.sh
else
  echo "⚠️  npx not found - MCP server installation skipped"
  echo "   Install Node.js to enable MCP tools for kanban management"
  echo "   You can run setup-mcp.sh manually later after installing Node.js"
fi

# ═══════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══════════════════════════════════════════"
echo "✅ Specwright DevTeam System v2.3 Installed!"
echo "═══════════════════════════════════════════"
echo ""
echo "📁 Installed Structure:"
echo ""
echo "  specwright/"
echo "    ├── standards/              (3 core files)"
echo "    ├── workflows/core/         (25 core workflows)"
echo "    │   └── execute-tasks/      (12 phase files - 80% less context)"
echo "    ├── workflows/openclaw/     (1 openclaw workflow)"
echo "    ├── workflows/meta/         (1 meta workflow)"
echo "    └── config.yml              (minimal configuration)"
echo ""
echo "  CLAUDE.md                     (project instructions template)"
echo ""
echo "📊 Statistics:"
echo "  • Standards: 3 files"
echo "  • Workflows: 39 files (25 core + 12 execute-tasks + 1 openclaw + 1 meta)"
echo "  • Templates: 1 openclaw template"
echo "  • Config: 1 file"
echo "  • Total: 42 files + CLAUDE.md"
echo ""
echo "📚 Templates (53 files) installed globally:"
echo "  Templates are loaded from ~/.specwright/templates/"
echo "  Run setup-devteam-global.sh if not yet installed."
echo ""
echo "  Hybrid lookup:"
echo "    1. Check: specwright/templates/ (project override)"
echo "    2. Fallback: ~/.specwright/templates/ (global)"
echo ""
echo "🎯 Next Steps:"
echo ""
echo "1. Customize CLAUDE.md:"
echo "   nano CLAUDE.md"
echo "   → Add your project name, description, tech stack hints"
echo ""
echo "2. Install Claude Code support:"
echo "   curl -sSL https://raw.githubusercontent.com/michsindlinger/specwright/main/setup-claude-code.sh | bash"
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
echo "   → Generates skills to specwright/skills/ with skill-index.md"
echo "   → Creates dod.md and dor.md"
echo ""
echo "5. Concept planning (optional):"
echo "   /plan-concept          → Create proposal package from project inquiry"
echo ""
echo "6. Brainstorm ideas (optional):"
echo "   /start-brainstorming   → Interactive session to explore ideas"
echo "   /transfer-and-create-spec → Convert brainstorming to spec"
echo ""
echo "7. Develop features:"
echo "   /create-spec        → PO + Architect create user stories"
echo "   /add-story [spec]   → Add story to existing spec"
echo "   /execute-tasks      → Orchestrator executes via DevTeam"
echo ""
echo "8. Quick tasks & bugs (lightweight, goes to backlog):"
echo "   /add-todo           → Add quick task to backlog"
echo "   /add-bug            → Add bug with root-cause analysis"
echo "   /execute-tasks backlog → Execute backlog tasks"
echo ""
echo "9. Skill management:"
echo "   /add-skill          → Create custom skills for agents"
echo ""
echo "10. OpenClaw Strategy:"
echo "    /openclaw-strategy → Interactive strategy advisor for automation goals"
echo ""
echo "📚 Documentation:"
echo "  • Installation Guide: INSTALL.md (created after Claude Code setup)"
echo "  • Workflow Diagram: specwright-workflow-complete.md"
echo ""
echo "⚠️  Prerequisites:"
echo ""
echo "  Templates are loaded from ~/.specwright/templates/"
echo "  If not yet installed, run:"
echo "    curl -sSL https://raw.githubusercontent.com/michsindlinger/specwright/main/setup-devteam-global.sh | bash"
echo ""
echo "  This installs 70 templates + 3 global standards to ~/.specwright/"
echo ""
echo "For more info: https://github.com/michsindlinger/specwright"
echo ""
