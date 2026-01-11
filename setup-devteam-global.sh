#!/bin/bash

# Agent OS DevTeam System - Global Installation
# Installs standards and templates to ~/.agent-os/ as fallback for all projects
# Version: 2.1

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "========================================="
echo "Agent OS DevTeam - Global Installation"
echo "========================================="
echo ""
echo "This installs to ~/.agent-os/:"
echo "  • Global coding standards (fallback)"
echo "  • All DevTeam templates (53 files)"
echo ""

# Download helper function
download_file() {
    local url="$1"
    local dest="$2"
    local category="${3:-file}"

    if command -v curl &> /dev/null; then
        curl -sSL "$url" -o "$dest" 2>/dev/null || {
            echo "⚠ Warning: Failed to download $category: $dest"
            return 1
        }
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest" 2>/dev/null || {
            echo "⚠ Warning: Failed to download $category: $dest"
            return 1
        }
    else
        echo "Error: Neither curl nor wget is available"
        exit 1
    fi
    echo "✓ Downloaded: $(basename $dest)"
}

# Global installation directory
GLOBAL_DIR="$HOME/.agent-os"

echo "Installing to: $GLOBAL_DIR"
echo ""

# Create directory structure
echo "Creating global directory structure..."
mkdir -p "$GLOBAL_DIR/standards"
mkdir -p "$GLOBAL_DIR/templates/product"
mkdir -p "$GLOBAL_DIR/templates/agents/dev-team"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/architect"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/backend"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/frontend"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/devops"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/qa"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/po"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/documenter"
mkdir -p "$GLOBAL_DIR/templates/skills/orchestration"
mkdir -p "$GLOBAL_DIR/templates/skills"
mkdir -p "$GLOBAL_DIR/templates/docs"

# ═══════════════════════════════════════════════════════════
# STANDARDS
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Global Standards ═══"

download_file "$REPO_URL/agent-os/standards/code-style.md" \
  "$GLOBAL_DIR/standards/code-style.md" "code-style"

download_file "$REPO_URL/agent-os/standards/best-practices.md" \
  "$GLOBAL_DIR/standards/best-practices.md" "best-practices"

download_file "$REPO_URL/agent-os/standards/tech-stack.md" \
  "$GLOBAL_DIR/standards/tech-stack.md" "tech-stack template"

# ═══════════════════════════════════════════════════════════
# TEMPLATES (53 files)
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Templates (53 files) ═══"

# Product templates (7)
echo "→ Product templates (7)..."
download_file "$REPO_URL/agent-os/templates/product/product-brief-template.md" "$GLOBAL_DIR/templates/product/product-brief-template.md"
download_file "$REPO_URL/agent-os/templates/product/product-brief-lite-template.md" "$GLOBAL_DIR/templates/product/product-brief-lite-template.md"
download_file "$REPO_URL/agent-os/templates/product/tech-stack-template.md" "$GLOBAL_DIR/templates/product/tech-stack-template.md"
download_file "$REPO_URL/agent-os/templates/product/roadmap-template.md" "$GLOBAL_DIR/templates/product/roadmap-template.md"
download_file "$REPO_URL/agent-os/templates/product/architecture-decision-template.md" "$GLOBAL_DIR/templates/product/architecture-decision-template.md"
download_file "$REPO_URL/agent-os/templates/product/boilerplate-structure-template.md" "$GLOBAL_DIR/templates/product/boilerplate-structure-template.md"
download_file "$REPO_URL/agent-os/templates/product/design-system-template.md" "$GLOBAL_DIR/templates/product/design-system-template.md"

# Agent templates (7)
echo "→ Agent templates (7)..."
download_file "$REPO_URL/agent-os/templates/agents/dev-team/architect-template.md" "$GLOBAL_DIR/templates/agents/dev-team/architect-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/backend-developer-template.md" "$GLOBAL_DIR/templates/agents/dev-team/backend-developer-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/frontend-developer-template.md" "$GLOBAL_DIR/templates/agents/dev-team/frontend-developer-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/devops-specialist-template.md" "$GLOBAL_DIR/templates/agents/dev-team/devops-specialist-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/qa-specialist-template.md" "$GLOBAL_DIR/templates/agents/dev-team/qa-specialist-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/po-template.md" "$GLOBAL_DIR/templates/agents/dev-team/po-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/documenter-template.md" "$GLOBAL_DIR/templates/agents/dev-team/documenter-template.md"

# Architect skills (5)
echo "→ Architect skill templates (5)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/pattern-enforcement-template.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/pattern-enforcement-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/api-designing-template.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/api-designing-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/security-guidance-template.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/security-guidance-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/data-modeling-template.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/data-modeling-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/dependency-checking-template.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/dependency-checking-template.md"

# Backend skills (4)
echo "→ Backend skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/logic-implementing-template.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/logic-implementing-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/persistence-adapter-template.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/persistence-adapter-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/integration-adapter-template.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/integration-adapter-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/test-engineering-template.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/test-engineering-template.md"

# Frontend skills (4)
echo "→ Frontend skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/ui-component-architecture-template.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/ui-component-architecture-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/state-management-template.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/state-management-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/api-bridge-building-template.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/api-bridge-building-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/interaction-designing-template.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/interaction-designing-template.md"

# DevOps skills (4)
echo "→ DevOps skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/pipeline-engineering-template.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/pipeline-engineering-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/infrastructure-provisioning-template.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/infrastructure-provisioning-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/observability-management-template.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/observability-management-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/security-hardening-template.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/security-hardening-template.md"

# QA skills (4)
echo "→ QA skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/test-strategy-template.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/test-strategy-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/test-automation-template.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/test-automation-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/quality-metrics-template.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/quality-metrics-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/regression-testing-template.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/regression-testing-template.md"

# PO skills (4)
echo "→ PO skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/backlog-organization-template.md" "$GLOBAL_DIR/templates/skills/dev-team/po/backlog-organization-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/requirements-engineering-template.md" "$GLOBAL_DIR/templates/skills/dev-team/po/requirements-engineering-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/acceptance-testing-template.md" "$GLOBAL_DIR/templates/skills/dev-team/po/acceptance-testing-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/data-analysis-template.md" "$GLOBAL_DIR/templates/skills/dev-team/po/data-analysis-template.md"

# Documenter skills (4)
echo "→ Documenter skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/changelog-generation-template.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/changelog-generation-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/api-documentation-template.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/api-documentation-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/user-guide-writing-template.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/user-guide-writing-template.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/code-documentation-template.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/code-documentation-template.md"

# Orchestration skill (1)
echo "→ Orchestration skill template (1)..."
download_file "$REPO_URL/agent-os/templates/skills/orchestration/orchestration-template.md" "$GLOBAL_DIR/templates/skills/orchestration/orchestration-template.md"

# Generic skill template (1)
echo "→ Generic skill template (1)..."
download_file "$REPO_URL/agent-os/templates/skills/generic-skill-template.md" "$GLOBAL_DIR/templates/skills/generic-skill-template.md"

# Documentation templates (10)
echo "→ Documentation templates (10)..."
download_file "$REPO_URL/agent-os/templates/docs/spec-template.md" "$GLOBAL_DIR/templates/docs/spec-template.md"
download_file "$REPO_URL/agent-os/templates/docs/spec-lite-template.md" "$GLOBAL_DIR/templates/docs/spec-lite-template.md"
download_file "$REPO_URL/agent-os/templates/docs/user-stories-template.md" "$GLOBAL_DIR/templates/docs/user-stories-template.md"
download_file "$REPO_URL/agent-os/templates/docs/cross-cutting-decisions-template.md" "$GLOBAL_DIR/templates/docs/cross-cutting-decisions-template.md"
download_file "$REPO_URL/agent-os/templates/docs/bug-description-template.md" "$GLOBAL_DIR/templates/docs/bug-description-template.md"
download_file "$REPO_URL/agent-os/templates/docs/kanban-board-template.md" "$GLOBAL_DIR/templates/docs/kanban-board-template.md"
download_file "$REPO_URL/agent-os/templates/docs/handover-doc-template.md" "$GLOBAL_DIR/templates/docs/handover-doc-template.md"
download_file "$REPO_URL/agent-os/templates/docs/changelog-entry-template.md" "$GLOBAL_DIR/templates/docs/changelog-entry-template.md"
download_file "$REPO_URL/agent-os/templates/docs/dod-template.md" "$GLOBAL_DIR/templates/docs/dod-template.md"
download_file "$REPO_URL/agent-os/templates/docs/dor-template.md" "$GLOBAL_DIR/templates/docs/dor-template.md"

echo ""
echo "✅ Global installation complete!"
echo ""
echo "Installed to $GLOBAL_DIR:"
echo ""
echo "  standards/ (3 files)"
echo "    ├── code-style.md"
echo "    ├── best-practices.md"
echo "    └── tech-stack.md"
echo ""
echo "  templates/ (55 files)"
echo "    ├── product/ (7)"
echo "    ├── agents/dev-team/ (7)"
echo "    ├── skills/ (31 total)"
echo "    │   ├── dev-team/ (29)"
echo "    │   │   ├── architect/ (5)"
echo "    │   │   ├── backend/ (4)"
echo "    │   │   ├── frontend/ (4)"
echo "    │   │   ├── devops/ (4)"
echo "    │   │   ├── qa/ (4)"
echo "    │   │   ├── po/ (4)"
echo "    │   │   └── documenter/ (4)"
echo "    │   ├── orchestration/ (1)"
echo "    │   └── generic-skill-template.md (1)"
echo "    └── docs/ (10)"
echo ""
echo "📚 Hybrid Lookup System:"
echo ""
echo "  Templates lookup order:"
echo "    1. Project: agent-os/templates/ (local override)"
echo "    2. Global: ~/.agent-os/templates/ (fallback)"
echo ""
echo "  Standards lookup order:"
echo "    1. Project: agent-os/standards/ (generated in /plan-product)"
echo "    2. Global: ~/.agent-os/standards/ (fallback)"
echo ""
echo "Benefits:"
echo "  ✅ Templates available globally for all projects"
echo "  ✅ No local installation needed unless customizing"
echo "  ✅ Consistent templates across projects"
echo "  ✅ Project overrides when needed"
echo ""
echo "Next steps:"
echo ""
echo "1. Install Agent OS in your project:"
echo "   cd your-project/"
echo "   curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash"
echo ""
echo "2. Install Claude Code:"
echo "   curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash"
echo ""
echo "3. Start workflow:"
echo "   /plan-product         → Uses global templates"
echo "   /build-development-team → Uses global templates"
echo ""
echo "Templates will be loaded from ~/.agent-os/templates/ automatically."
echo "To customize templates, copy to project's agent-os/templates/ and modify."
echo ""
echo "For more info: https://github.com/michsindlinger/agent-os-extended"
echo ""
