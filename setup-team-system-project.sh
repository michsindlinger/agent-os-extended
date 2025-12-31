#!/bin/bash

# Team Development System - Project Setup
# Creates project-specific directories and configuration
# Version: 2.0 (Phase B)

set -e

echo "========================================="
echo "Team Development System - Project Setup"
echo "========================================="
echo ""
echo "This creates project-specific configuration for team development."
echo ""
echo "Prerequisites:"
echo "  ✓ Global installation: setup-team-system-global.sh must be run first"
echo "  ✓ Base skills and templates installed globally"
echo ""
echo "This script creates:"
echo "  agent-os/templates/team-development/  (for project-specific template overrides)"
echo "  .claude/agents/                       (project agents will be created here)"
echo "  .claude/skills/                       (project skills will be created here)"
echo "  Updates agent-os/config.yml           (enables team system)"
echo ""

# Global installation is always at HOME/.agent-os
GLOBAL_AGENT_OS="$HOME/.agent-os"

# Check if global installation exists
if [[ ! -d "$GLOBAL_AGENT_OS/templates/team-development" ]]; then
    echo "❌ Error: Global Team Development System not found at $GLOBAL_AGENT_OS"
    echo ""
    echo "Please run global installation first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-team-system-global.sh | bash"
    echo ""
    echo "This will install to: $HOME/.agent-os"
    echo ""
    exit 1
fi

echo "✓ Found global installation at: $GLOBAL_AGENT_OS"
echo ""

# Create project directories
echo "Creating project directories..."
mkdir -p agent-os/templates/team-development/backend
mkdir -p agent-os/templates/team-development/frontend
mkdir -p agent-os/templates/team-development/qa
mkdir -p agent-os/templates/team-development/devops
mkdir -p .claude/agents  # Project agents created with /create-project-agents
mkdir -p .claude/skills  # Project skills created with /add-skill

echo ""
echo "✅ Project structure created!"
echo ""
echo "Created directories:"
echo "  agent-os/templates/team-development/  - Template overrides (optional)"
echo "    ├── backend/                         - Backend template overrides"
echo "    ├── frontend/                        - Frontend template overrides"
echo "    ├── qa/                              - QA template overrides"
echo "    └── devops/                          - DevOps template overrides"
echo "  .claude/agents/                        - Project agents (create with commands)"
echo "  .claude/skills/                        - Project skills (create with commands)"
echo ""
echo "Next steps:"
echo ""
echo "1. Create project-specific agents:"
echo "   /create-project-agents"
echo "   → Select which agents you need (backend, frontend, qa, devops)"
echo "   → Agents are customized with your tech stack"
echo "   → Saved to .claude/agents/"
echo ""
echo "2. Create project-specific skills:"
echo "   /add-skill --analyze --type api"
echo "   /add-skill --analyze --type component"
echo "   /add-skill --analyze --type testing"
echo "   → Analyzes your code and creates pattern skills"
echo "   → Saved to .claude/skills/"
echo ""
echo "3. (Optional) Manually assign additional skills:"
echo "   /assign-skills-to-agent"
echo "   → Choose agent and skills to assign"
echo ""
echo "4. Verify team system is enabled:"
echo "   Check agent-os/config.yml: team_system.enabled: true"
echo ""
echo "5. Use smart task routing:"
echo "   /execute-tasks"
echo "   → Tasks are automatically routed to specialists"
echo "   → Specialists use project skills + base skills"
echo ""
echo "How it works:"
echo ""
echo "Global (installed once):"
echo "  - Base Skills: testing-best-practices, devops-patterns"
echo "  - Templates: Agent templates, code generation templates"
echo ""
echo "Project-specific (created per project):"
echo "  - Agents: Created with /create-project-agents"
echo "  - Skills: Created with /add-skill"
echo "  - Auto-loading: Agents find skills via naming convention"
echo ""
echo "Task Routing Keywords:"
echo "  Backend:  api, endpoint, controller, service, repository"
echo "  Frontend: component, page, view, ui, react, angular"
echo "  QA:       test, spec, coverage, e2e, integration"
echo "  DevOps:   deploy, ci, cd, docker, pipeline"
echo ""

# Optional: Update project config.yml if it exists
if [[ -f agent-os/config.yml ]]; then
    echo "Updating project config.yml..."

    # Check if team_system section already exists
    if ! grep -q "team_system:" agent-os/config.yml; then
        cat >> agent-os/config.yml << 'EOF'

# Team Development System Configuration (uses global installation)
team_system:
  enabled: true

  # File lookup order (project-local first, then global fallback)
  lookup_order:
    - project  # Check agent-os/ and .claude/ in project first
    - global   # Fallback to global agent-os/ and .claude/

  # Coordination mode
  coordination_mode: sequential  # MVP: sequential execution

  # Smart task routing
  task_routing:
    enabled: true       # Enable automatic task routing
    auto_delegate: true # Automatically delegate to specialists

  # Specialist configuration (override global defaults if needed)
  specialists:
    backend_dev:
      enabled: true
      default_stack: java_spring_boot  # Options: java_spring_boot, nodejs_express
      code_generation: full            # Options: full, scaffolding, guidance

    frontend_dev:
      enabled: true
      default_framework: react  # Options: react, angular
      code_generation: full

    qa_specialist:
      enabled: true
      test_types: [unit, integration, e2e]
      coverage_target: 80
      auto_fix_attempts: 3

    devops_specialist:
      enabled: true
      ci_platform: github_actions
      containerization: docker

  # Quality gates
  quality_gates:
    unit_tests_required: true
    integration_tests_required: true
    coverage_minimum: 80
    build_success_required: true
EOF
        echo "✓ Added team_system section to agent-os/config.yml"
    else
        echo "✓ team_system section already exists in agent-os/config.yml"
    fi
else
    echo "⚠ No agent-os/config.yml found - skipping config update"
    echo "  To enable team system, create agent-os/config.yml with:"
    echo "  team_system:"
    echo "    enabled: true"
fi

echo ""
echo "✅ Project setup complete!"
echo ""
echo "Configuration:"
echo "  ✓ team_system.enabled: true (in config.yml)"
echo "  ✓ Smart task routing: enabled"
echo "  ✓ Directories created for agents and skills"
echo ""
echo "🚀 Next Commands to Run:"
echo ""
echo "1. Create project agents:"
echo "   /create-project-agents"
echo "   → Interactive: Select which agents you need"
echo "   → Auto-detects your tech stack"
echo "   → Creates customized agents in .claude/agents/"
echo ""
echo "2. Create project skills:"
echo "   /add-skill --analyze --type api"
echo "   /add-skill --analyze --type component"
echo "   /add-skill --analyze --type testing"
echo "   → Analyzes your codebase patterns"
echo "   → Creates skills in .claude/skills/"
echo "   → Auto-assigned to agents via naming convention"
echo ""
echo "3. (Optional) Manual skill assignment:"
echo "   /assign-skills-to-agent"
echo "   → For custom skill assignments"
echo ""
echo "Then use:"
echo "  /execute-tasks"
echo ""
echo "Example tasks.md that triggers specialists:"
echo ""
echo "  - Create POST /api/users endpoint with validation"
echo "    → Routes to: backend-dev (keywords: api, endpoint)"
echo ""
echo "  - Create UserList component with pagination"
echo "    → Routes to: frontend-dev (keywords: component)"
echo ""
echo "  - Add comprehensive tests for user management"
echo "    → Routes to: qa-specialist (keywords: tests)"
echo ""
echo "The system will:"
echo "  1. Analyze task description"
echo "  2. Route to appropriate specialist"
echo "  3. Specialist loads project skills + base skills"
echo "  4. Specialist generates complete implementation"
echo "  5. Handoff created for collaboration"
echo ""
echo "Customization (in agent-os/config.yml):"
echo "  - Adjust default frameworks per specialist"
echo "  - Set coverage targets"
echo "  - Enable/disable specialists"
echo "  - Configure quality gates"
echo ""
echo "For complete documentation:"
echo "  See: $GLOBAL_AGENT_OS/../specs/2025-12-28-team-development-system/spec.md"
echo ""
