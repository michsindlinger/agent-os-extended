#!/bin/bash

# Team Development System - Global Installation
# Installs to global agent-os/ and .claude/ for use across all projects
# Version: 2.0 (Phase B)

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "========================================="
echo "Team Development System - Global Setup"
echo "========================================="
echo ""
echo "This installs team development components to:"
echo "  <global>/agent-os/        (skills, templates)"
echo "  .claude/                  (agents)"
echo ""
echo "All projects can then use smart task routing in /execute-tasks"
echo "Projects can override specific components if needed"
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
    echo "✓ Downloaded $category: $(basename $dest)"
}

# Detect global agent-os location
if [[ -d "$HOME/.agent-os" ]]; then
    AGENT_OS_DIR="$HOME/.agent-os"
elif [[ -d "agent-os" ]]; then
    AGENT_OS_DIR="$(pwd)/agent-os"
else
    # Default to current directory's agent-os
    AGENT_OS_DIR="$(pwd)/agent-os"
fi

echo "Installing to: $AGENT_OS_DIR"
echo ""

# Create global directory structure
echo "Creating global directory structure..."
mkdir -p "$AGENT_OS_DIR/skills/base"
mkdir -p "$AGENT_OS_DIR/templates/team-development/backend"
mkdir -p "$AGENT_OS_DIR/templates/team-development/frontend"
mkdir -p "$AGENT_OS_DIR/templates/team-development/qa"
mkdir -p "$AGENT_OS_DIR/templates/team-development/devops"
mkdir -p .claude/agents

# Download Skills (2 new)
echo ""
echo "Downloading team development skills..."

download_file "$REPO_URL/agent-os/skills/base/testing-best-practices.md" \
  "$AGENT_OS_DIR/skills/base/testing-best-practices.md" "skill"

download_file "$REPO_URL/agent-os/skills/base/devops-patterns.md" \
  "$AGENT_OS_DIR/skills/base/devops-patterns.md" "skill"

# Download Backend Templates (4 new)
echo ""
echo "Downloading backend templates..."

download_file "$REPO_URL/agent-os/templates/team-development/backend/api-spec.md" \
  "$AGENT_OS_DIR/templates/team-development/backend/api-spec.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/backend/service-class.md" \
  "$AGENT_OS_DIR/templates/team-development/backend/service-class.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/backend/repository-class.md" \
  "$AGENT_OS_DIR/templates/team-development/backend/repository-class.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/backend/backend-handoff.md" \
  "$AGENT_OS_DIR/templates/team-development/backend/backend-handoff.md" "template"

# Download Frontend Templates (4 new)
echo ""
echo "Downloading frontend templates..."

download_file "$REPO_URL/agent-os/templates/team-development/frontend/component-spec.md" \
  "$AGENT_OS_DIR/templates/team-development/frontend/component-spec.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/frontend/page-spec.md" \
  "$AGENT_OS_DIR/templates/team-development/frontend/page-spec.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/frontend/state-management.md" \
  "$AGENT_OS_DIR/templates/team-development/frontend/state-management.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/frontend/frontend-handoff.md" \
  "$AGENT_OS_DIR/templates/team-development/frontend/frontend-handoff.md" "template"

# Download QA Templates (2 new)
echo ""
echo "Downloading QA templates..."

download_file "$REPO_URL/agent-os/templates/team-development/qa/test-plan.md" \
  "$AGENT_OS_DIR/templates/team-development/qa/test-plan.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/qa/test-report.md" \
  "$AGENT_OS_DIR/templates/team-development/qa/test-report.md" "template"

# Download DevOps Templates (2 new)
echo ""
echo "Downloading DevOps templates..."

download_file "$REPO_URL/agent-os/templates/team-development/devops/ci-cd-config.md" \
  "$AGENT_OS_DIR/templates/team-development/devops/ci-cd-config.md" "template"

download_file "$REPO_URL/agent-os/templates/team-development/devops/deployment-plan.md" \
  "$AGENT_OS_DIR/templates/team-development/devops/deployment-plan.md" "template"

# Download Specialist Agents (5 new)
echo ""
echo "Downloading team development specialist agents..."

download_file "$REPO_URL/.claude/agents/backend-dev.md" \
  ~/.claude/agents/backend-dev.md "agent"

download_file "$REPO_URL/.claude/agents/frontend-dev.md" \
  ~/.claude/agents/frontend-dev.md "agent"

download_file "$REPO_URL/.claude/agents/qa-specialist.md" \
  ~/.claude/agents/qa-specialist.md "agent"

download_file "$REPO_URL/.claude/agents/devops-specialist.md" \
  ~/.claude/agents/devops-specialist.md "agent"

download_file "$REPO_URL/.claude/agents/mock-generator.md" \
  ~/.claude/agents/mock-generator.md "agent"

# Create Skills symlinks in ~/.claude/skills/
echo ""
echo "Creating skill symlinks in ~/.claude/skills/..."

if [[ -d "$AGENT_OS_DIR/skills" ]]; then
    mkdir -p ~/.claude/skills

    # Team development skills
    ln -sf "$AGENT_OS_DIR/skills/base/testing-best-practices.md" \
      ~/.claude/skills/testing-best-practices.md

    ln -sf "$AGENT_OS_DIR/skills/base/devops-patterns.md" \
      ~/.claude/skills/devops-patterns.md

    echo "✓ Created 2 skill symlinks in ~/.claude/skills/"
else
    echo "⚠ Skills directory not found (expected at $AGENT_OS_DIR/skills/)"
fi

echo ""
echo "✅ Team Development System (Global) installed!"
echo ""
echo "Installed to:"
echo "  $AGENT_OS_DIR/skills/base/           - 2 new skills (testing, devops)"
echo "  $AGENT_OS_DIR/templates/team-development/backend/   - 4 backend templates"
echo "  $AGENT_OS_DIR/templates/team-development/frontend/  - 4 frontend templates"
echo "  $AGENT_OS_DIR/templates/team-development/qa/        - 2 QA templates"
echo "  $AGENT_OS_DIR/templates/team-development/devops/    - 2 DevOps templates"
echo "  ~/.claude/agents/                    - 5 specialist agents"
echo "  ~/.claude/skills/                    - 2 skill symlinks"
echo ""
echo "Specialist Agents:"
echo "  backend-dev       - Java Spring Boot / Node.js backend specialist"
echo "  frontend-dev      - React / Angular frontend specialist"
echo "  qa-specialist     - Testing specialist with auto-fix"
echo "  devops-specialist - CI/CD and deployment specialist"
echo "  mock-generator    - API mock generation utility"
echo ""
echo "How it works:"
echo "  1. Enable in config.yml: team_system.enabled: true"
echo "  2. Run /execute-tasks as usual"
echo "  3. Smart task routing detects task type (backend/frontend/qa/devops)"
echo "  4. Delegates to appropriate specialist automatically"
echo "  5. Specialists use skills and templates"
echo ""
echo "Task Routing Keywords:"
echo "  Backend:  api, endpoint, controller, service, repository, database"
echo "  Frontend: component, page, view, ui, react, angular, state"
echo "  QA:       test, spec, coverage, e2e, integration, unit"
echo "  DevOps:   deploy, ci, cd, docker, pipeline, github actions"
echo ""
echo "To override for a specific project:"
echo "  1. Copy component from $AGENT_OS_DIR to projekt/agent-os/"
echo "  2. Or from .claude/ to projekt/.claude/"
echo "  3. Modify as needed"
echo "  4. Project version takes precedence"
echo ""
echo "Example override:"
echo "  cp .claude/agents/backend-dev.md projekt/.claude/agents/"
echo "  vim projekt/.claude/agents/backend-dev.md"
echo "  # Now this project uses custom backend-dev"
echo ""
echo "Example: Custom template for project"
echo "  mkdir -p projekt/agent-os/templates/team-development/backend"
echo "  cp $AGENT_OS_DIR/templates/team-development/backend/api-spec.md \\"
echo "     projekt/agent-os/templates/team-development/backend/"
echo "  vim projekt/agent-os/templates/team-development/backend/api-spec.md"
echo "  # Now this project uses custom API spec template"
echo ""
echo "Next steps:"
echo "  1. Go to any project directory"
echo "  2. Run: bash setup-team-system-project.sh (creates project structure)"
echo "  3. Ensure team_system.enabled: true in agent-os/config.yml"
echo "  4. Use /execute-tasks - smart routing activates automatically"
echo ""
echo "For complete guide, see spec: agent-os/specs/2025-12-28-team-development-system/spec.md"
echo ""
