#!/bin/bash

# Agent OS DevTeam System - Global Installation
# Installs standards and templates to ~/.agent-os/ as fallback for all projects
# Version: 2.5 - Fixed skill template paths (SKILL.md in subdirectories)

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "========================================="
echo "Agent OS DevTeam - Global Installation"
echo "========================================="
echo ""
echo "This installs to ~/.agent-os/:"
echo "  • Global coding standards (fallback)"
echo "  • All DevTeam templates (~80 files)"
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
mkdir -p "$GLOBAL_DIR/templates/platform"
mkdir -p "$GLOBAL_DIR/templates/agents/dev-team"
mkdir -p "$GLOBAL_DIR/agents"
# Architect skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/architect/pattern-enforcement"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/architect/api-designing"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/architect/security-guidance"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/architect/data-modeling"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/architect/dependency-checking"
# Backend skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/backend/logic-implementing"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/backend/persistence-adapter"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/backend/integration-adapter"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/backend/test-engineering"
# Frontend skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/frontend/ui-component-architecture"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/frontend/state-management"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/frontend/api-bridge-building"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/frontend/interaction-designing"
# DevOps skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/devops/pipeline-engineering"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/devops/infrastructure-provisioning"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/devops/observability-management"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/devops/security-hardening"
# QA skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/qa/test-strategy"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/qa/test-automation"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/qa/quality-metrics"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/qa/regression-testing"
# PO skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/po/backlog-organization"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/po/requirements-engineering"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/po/acceptance-testing"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/po/data-analysis"
# Documenter skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/documenter/changelog-generation"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/documenter/api-documentation"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/documenter/user-guide-writing"
mkdir -p "$GLOBAL_DIR/templates/skills/dev-team/documenter/code-documentation"
# Other skill directories
mkdir -p "$GLOBAL_DIR/templates/skills/orchestration"
mkdir -p "$GLOBAL_DIR/templates/skills/platform"
mkdir -p "$GLOBAL_DIR/templates/skills/skill"
mkdir -p "$GLOBAL_DIR/templates/skills"
mkdir -p "$GLOBAL_DIR/templates/docs"
mkdir -p "$GLOBAL_DIR/templates/feasibility"

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
# TEMPLATES (~80 files including skill SKILL.md files)
# ═══════════════════════════════════════════════════════════

echo ""
echo "═══ Installing Templates (~80 files) ═══"

# CLAUDE templates (2)
echo "→ CLAUDE templates (2)..."
download_file "$REPO_URL/agent-os/templates/CLAUDE-LITE.md" "$GLOBAL_DIR/templates/CLAUDE-LITE.md"
download_file "$REPO_URL/agent-os/templates/CLAUDE-PLATFORM.md" "$GLOBAL_DIR/templates/CLAUDE-PLATFORM.md"

# Product templates (10)
echo "→ Product templates (10)..."
download_file "$REPO_URL/agent-os/templates/product/product-brief-template.md" "$GLOBAL_DIR/templates/product/product-brief-template.md"
download_file "$REPO_URL/agent-os/templates/product/product-brief-lite-template.md" "$GLOBAL_DIR/templates/product/product-brief-lite-template.md"
download_file "$REPO_URL/agent-os/templates/product/tech-stack-template.md" "$GLOBAL_DIR/templates/product/tech-stack-template.md"
download_file "$REPO_URL/agent-os/templates/product/roadmap-template.md" "$GLOBAL_DIR/templates/product/roadmap-template.md"
download_file "$REPO_URL/agent-os/templates/product/architecture-decision-template.md" "$GLOBAL_DIR/templates/product/architecture-decision-template.md"
download_file "$REPO_URL/agent-os/templates/product/boilerplate-structure-template.md" "$GLOBAL_DIR/templates/product/boilerplate-structure-template.md"
download_file "$REPO_URL/agent-os/templates/product/design-system-template.md" "$GLOBAL_DIR/templates/product/design-system-template.md"
download_file "$REPO_URL/agent-os/templates/product/ux-patterns-template.md" "$GLOBAL_DIR/templates/product/ux-patterns-template.md"
download_file "$REPO_URL/agent-os/templates/product/blocker-analysis-template.md" "$GLOBAL_DIR/templates/product/blocker-analysis-template.md"
download_file "$REPO_URL/agent-os/templates/product/milestone-plan-template.md" "$GLOBAL_DIR/templates/product/milestone-plan-template.md"

# Feasibility templates (1)
echo "→ Feasibility templates (1)..."
download_file "$REPO_URL/agent-os/templates/feasibility/feasibility-report.md" "$GLOBAL_DIR/templates/feasibility/feasibility-report.md"

# Platform templates (7)
echo "→ Platform templates (7)..."
download_file "$REPO_URL/agent-os/templates/platform/platform-brief-template.md" "$GLOBAL_DIR/templates/platform/platform-brief-template.md"
download_file "$REPO_URL/agent-os/templates/platform/module-brief-template.md" "$GLOBAL_DIR/templates/platform/module-brief-template.md"
download_file "$REPO_URL/agent-os/templates/platform/module-dependencies-template.md" "$GLOBAL_DIR/templates/platform/module-dependencies-template.md"
download_file "$REPO_URL/agent-os/templates/platform/platform-architecture-template.md" "$GLOBAL_DIR/templates/platform/platform-architecture-template.md"
download_file "$REPO_URL/agent-os/templates/platform/platform-roadmap-template.md" "$GLOBAL_DIR/templates/platform/platform-roadmap-template.md"
download_file "$REPO_URL/agent-os/templates/platform/module-roadmap-template.md" "$GLOBAL_DIR/templates/platform/module-roadmap-template.md"
download_file "$REPO_URL/agent-os/templates/platform/platform-blocker-analysis-template.md" "$GLOBAL_DIR/templates/platform/platform-blocker-analysis-template.md"

# Global agents (1)
echo "→ Global agents (1)..."
download_file "$REPO_URL/.agent-os/agents/platform-architect.md" "$GLOBAL_DIR/agents/platform-architect.md"

# Agent templates (7)
echo "→ Agent templates (7)..."
download_file "$REPO_URL/agent-os/templates/agents/dev-team/architect-template.md" "$GLOBAL_DIR/templates/agents/dev-team/architect-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/backend-developer-template.md" "$GLOBAL_DIR/templates/agents/dev-team/backend-developer-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/frontend-developer-template.md" "$GLOBAL_DIR/templates/agents/dev-team/frontend-developer-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/devops-specialist-template.md" "$GLOBAL_DIR/templates/agents/dev-team/devops-specialist-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/qa-specialist-template.md" "$GLOBAL_DIR/templates/agents/dev-team/qa-specialist-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/po-template.md" "$GLOBAL_DIR/templates/agents/dev-team/po-template.md"
download_file "$REPO_URL/agent-os/templates/agents/dev-team/documenter-template.md" "$GLOBAL_DIR/templates/agents/dev-team/documenter-template.md"

# Architect skills (5) - NEW STRUCTURE: each skill in own directory with SKILL.md
echo "→ Architect skill templates (5)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/pattern-enforcement/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/pattern-enforcement/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/api-designing/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/api-designing/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/security-guidance/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/security-guidance/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/data-modeling/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/data-modeling/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/architect/dependency-checking/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/architect/dependency-checking/SKILL.md"

# Backend skills (4)
echo "→ Backend skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/logic-implementing/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/logic-implementing/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/persistence-adapter/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/persistence-adapter/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/integration-adapter/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/integration-adapter/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/backend/test-engineering/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/backend/test-engineering/SKILL.md"

# Frontend skills (4)
echo "→ Frontend skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/ui-component-architecture/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/ui-component-architecture/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/state-management/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/state-management/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/api-bridge-building/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/api-bridge-building/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/frontend/interaction-designing/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/frontend/interaction-designing/SKILL.md"

# DevOps skills (4)
echo "→ DevOps skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/pipeline-engineering/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/pipeline-engineering/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/infrastructure-provisioning/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/infrastructure-provisioning/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/observability-management/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/observability-management/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/devops/security-hardening/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/devops/security-hardening/SKILL.md"

# QA skills (4)
echo "→ QA skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/test-strategy/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/test-strategy/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/test-automation/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/test-automation/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/quality-metrics/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/quality-metrics/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/qa/regression-testing/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/qa/regression-testing/SKILL.md"

# PO skills (4)
echo "→ PO skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/backlog-organization/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/po/backlog-organization/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/requirements-engineering/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/po/requirements-engineering/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/acceptance-testing/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/po/acceptance-testing/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/po/data-analysis/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/po/data-analysis/SKILL.md"

# Documenter skills (4)
echo "→ Documenter skill templates (4)..."
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/changelog-generation/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/changelog-generation/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/api-documentation/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/api-documentation/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/user-guide-writing/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/user-guide-writing/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/dev-team/documenter/code-documentation/SKILL.md" "$GLOBAL_DIR/templates/skills/dev-team/documenter/code-documentation/SKILL.md"

# Platform skills (4) - NEW STRUCTURE: each skill in own directory with SKILL.md
echo "→ Platform skill templates (4)..."
mkdir -p "$GLOBAL_DIR/templates/skills/platform/system-integration-patterns"
mkdir -p "$GLOBAL_DIR/templates/skills/platform/dependency-management"
mkdir -p "$GLOBAL_DIR/templates/skills/platform/modular-architecture"
mkdir -p "$GLOBAL_DIR/templates/skills/platform/platform-scalability"
download_file "$REPO_URL/agent-os/templates/skills/platform/system-integration-patterns/SKILL.md" "$GLOBAL_DIR/templates/skills/platform/system-integration-patterns/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/platform/dependency-management/SKILL.md" "$GLOBAL_DIR/templates/skills/platform/dependency-management/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/platform/modular-architecture/SKILL.md" "$GLOBAL_DIR/templates/skills/platform/modular-architecture/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/platform/platform-scalability/SKILL.md" "$GLOBAL_DIR/templates/skills/platform/platform-scalability/SKILL.md"

# Orchestration skill (1)
echo "→ Orchestration skill template (1)..."
mkdir -p "$GLOBAL_DIR/templates/skills/orchestration/orchestration"
download_file "$REPO_URL/agent-os/templates/skills/orchestration/orchestration/SKILL.md" "$GLOBAL_DIR/templates/skills/orchestration/orchestration/SKILL.md"

# Generic skill template (1)
echo "→ Generic skill template (1)..."
mkdir -p "$GLOBAL_DIR/templates/skills/generic-skill"
download_file "$REPO_URL/agent-os/templates/skills/generic-skill/SKILL.md" "$GLOBAL_DIR/templates/skills/generic-skill/SKILL.md"

# Base skill template (1) - YAML frontmatter template
echo "→ Base skill template (1)..."
download_file "$REPO_URL/agent-os/templates/skills/skill/SKILL.md" "$GLOBAL_DIR/templates/skills/skill/SKILL.md"

# Additional root-level skills (4)
echo "→ Additional skill templates (4)..."
mkdir -p "$GLOBAL_DIR/templates/skills/api-implementation-patterns"
mkdir -p "$GLOBAL_DIR/templates/skills/component-architecture"
mkdir -p "$GLOBAL_DIR/templates/skills/deployment-automation"
mkdir -p "$GLOBAL_DIR/templates/skills/file-organization-patterns"
mkdir -p "$GLOBAL_DIR/templates/skills/testing-strategies"
download_file "$REPO_URL/agent-os/templates/skills/api-implementation-patterns/SKILL.md" "$GLOBAL_DIR/templates/skills/api-implementation-patterns/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/component-architecture/SKILL.md" "$GLOBAL_DIR/templates/skills/component-architecture/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/deployment-automation/SKILL.md" "$GLOBAL_DIR/templates/skills/deployment-automation/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/file-organization-patterns/SKILL.md" "$GLOBAL_DIR/templates/skills/file-organization-patterns/SKILL.md"
download_file "$REPO_URL/agent-os/templates/skills/testing-strategies/SKILL.md" "$GLOBAL_DIR/templates/skills/testing-strategies/SKILL.md"

# Documentation templates (14)
echo "→ Documentation templates (14)..."
download_file "$REPO_URL/agent-os/templates/docs/spec-template.md" "$GLOBAL_DIR/templates/docs/spec-template.md"
download_file "$REPO_URL/agent-os/templates/docs/spec-lite-template.md" "$GLOBAL_DIR/templates/docs/spec-lite-template.md"
download_file "$REPO_URL/agent-os/templates/docs/user-stories-template.md" "$GLOBAL_DIR/templates/docs/user-stories-template.md"
download_file "$REPO_URL/agent-os/templates/docs/story-template.md" "$GLOBAL_DIR/templates/docs/story-template.md"
download_file "$REPO_URL/agent-os/templates/docs/story-index-template.md" "$GLOBAL_DIR/templates/docs/story-index-template.md"
download_file "$REPO_URL/agent-os/templates/docs/backlog-story-index-template.md" "$GLOBAL_DIR/templates/docs/backlog-story-index-template.md"
download_file "$REPO_URL/agent-os/templates/docs/cross-cutting-decisions-template.md" "$GLOBAL_DIR/templates/docs/cross-cutting-decisions-template.md"
download_file "$REPO_URL/agent-os/templates/docs/bug-description-template.md" "$GLOBAL_DIR/templates/docs/bug-description-template.md"
download_file "$REPO_URL/agent-os/templates/docs/kanban-board-template.md" "$GLOBAL_DIR/templates/docs/kanban-board-template.md"
download_file "$REPO_URL/agent-os/templates/docs/handover-doc-template.md" "$GLOBAL_DIR/templates/docs/handover-doc-template.md"
download_file "$REPO_URL/agent-os/templates/docs/changelog-entry-template.md" "$GLOBAL_DIR/templates/docs/changelog-entry-template.md"
download_file "$REPO_URL/agent-os/templates/docs/dod-template.md" "$GLOBAL_DIR/templates/docs/dod-template.md"
download_file "$REPO_URL/agent-os/templates/docs/dor-template.md" "$GLOBAL_DIR/templates/docs/dor-template.md"
download_file "$REPO_URL/agent-os/templates/docs/skill-index-template.md" "$GLOBAL_DIR/templates/docs/skill-index-template.md"

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
echo "  agents/ (1 file)"
echo "    └── platform-architect.md"
echo ""
echo "  templates/ (~80 files)"
echo "    ├── CLAUDE-LITE.md (for single products)"
echo "    ├── CLAUDE-PLATFORM.md (for platforms)"
echo "    ├── product/ (10)"
echo "    ├── platform/ (7)"
echo "    ├── agents/dev-team/ (7)"
echo "    ├── skills/ (40 total) - NEW STRUCTURE: SKILL.md in subdirectories"
echo "    │   ├── dev-team/ (29 skills)"
echo "    │   │   ├── architect/ (5): api-designing, data-modeling, ..."
echo "    │   │   ├── backend/ (4): logic-implementing, persistence-adapter, ..."
echo "    │   │   ├── frontend/ (4): ui-component-architecture, state-management, ..."
echo "    │   │   ├── devops/ (4): pipeline-engineering, infrastructure-provisioning, ..."
echo "    │   │   ├── qa/ (4): test-strategy, test-automation, ..."
echo "    │   │   ├── po/ (4): backlog-organization, requirements-engineering, ..."
echo "    │   │   └── documenter/ (4): changelog-generation, api-documentation, ..."
echo "    │   ├── platform/ (4): system-integration-patterns, dependency-management, ..."
echo "    │   ├── orchestration/ (1)"
echo "    │   ├── skill/ (1) - base template"
echo "    │   ├── generic-skill/ (1)"
echo "    │   └── root-level/ (5): api-implementation-patterns, component-architecture, ..."
echo "    └── docs/ (14) ← includes skill-index-template"
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
echo "   /plan-product         → Single-product projects"
echo "   /plan-platform        → Multi-module platforms"
echo "   /build-development-team → DevTeam setup"
echo ""
echo "Templates will be loaded from ~/.agent-os/templates/ automatically."
echo "To customize templates, copy to project's agent-os/templates/ and modify."
echo ""
echo "For more info: https://github.com/michsindlinger/agent-os-extended"
echo ""
