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
echo "  <global>/agent-os/        (base skills, templates)"
echo ""
echo "Projects create their own agents using /create-project-agents"
echo "Projects create their own skills using /add-skill"
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
mkdir -p "$AGENT_OS_DIR/templates/team-development/agents"

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

# Download Agent Templates (4 new)
echo ""
echo "Downloading agent templates..."

download_file "$REPO_URL/agent-os/templates/team-development/agents/backend-dev-template.md" \
  "$AGENT_OS_DIR/templates/team-development/agents/backend-dev-template.md" "agent template"

download_file "$REPO_URL/agent-os/templates/team-development/agents/frontend-dev-template.md" \
  "$AGENT_OS_DIR/templates/team-development/agents/frontend-dev-template.md" "agent template"

download_file "$REPO_URL/agent-os/templates/team-development/agents/qa-specialist-template.md" \
  "$AGENT_OS_DIR/templates/team-development/agents/qa-specialist-template.md" "agent template"

download_file "$REPO_URL/agent-os/templates/team-development/agents/devops-specialist-template.md" \
  "$AGENT_OS_DIR/templates/team-development/agents/devops-specialist-template.md" "agent template"

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
echo "  $AGENT_OS_DIR/skills/base/              - 2 base skills (testing, devops)"
echo "  $AGENT_OS_DIR/templates/team-development/agents/    - 4 agent templates"
echo "  $AGENT_OS_DIR/templates/team-development/backend/   - 4 backend templates"
echo "  $AGENT_OS_DIR/templates/team-development/frontend/  - 4 frontend templates"
echo "  $AGENT_OS_DIR/templates/team-development/qa/        - 2 QA templates"
echo "  $AGENT_OS_DIR/templates/team-development/devops/    - 2 DevOps templates"
echo "  ~/.claude/skills/                       - 2 skill symlinks"
echo ""
echo "What's included:"
echo ""
echo "  Base Skills (framework-agnostic):"
echo "    - testing-best-practices.md"
echo "    - devops-patterns.md"
echo ""
echo "  Agent Templates (customize per project):"
echo "    - backend-dev-template.md"
echo "    - frontend-dev-template.md"
echo "    - qa-specialist-template.md"
echo "    - devops-specialist-template.md"
echo ""
echo "  Templates for code generation:"
echo "    - Backend: API specs, services, repositories, handoffs"
echo "    - Frontend: Components, pages, state, handoffs"
echo "    - QA: Test plans, test reports"
echo "    - DevOps: CI/CD configs, deployment plans"
echo ""
echo "Next steps for each project:"
echo ""
echo "  1. Go to your project directory"
echo ""
echo "  2. Create project-specific agents:"
echo "     /create-project-agents"
echo "     → Select which agents you need (backend, frontend, qa, devops)"
echo "     → Agents are customized with your tech stack"
echo "     → Saved to project/.claude/agents/"
echo ""
echo "  3. Create project-specific skills:"
echo "     /add-skill --analyze --type api"
echo "     /add-skill --analyze --type component"
echo "     → Analyzes your code and creates patterns"
echo "     → Saved to project/.claude/skills/"
echo ""
echo "  4. Assign skills to agents (if needed):"
echo "     /assign-skills-to-agent"
echo "     → Manual skill assignment to agents"
echo "     → Auto-assignment via naming convention also works"
echo ""
echo "  5. Enable in config.yml:"
echo "     team_system.enabled: true"
echo ""
echo "  6. Use /execute-tasks with smart routing:"
echo "     → Tasks are routed to specialists automatically"
echo "     → Specialists use project skills + base skills"
echo ""
echo "For complete guide, see: agent-os/specs/2025-12-28-team-development-system/"
echo ""
