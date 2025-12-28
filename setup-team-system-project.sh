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
echo "  ✓ Skills, templates, agents installed globally"
echo ""
echo "This script creates:"
echo "  agent-os/templates/team-development/  (for project-specific template overrides)"
echo "  .claude/agents/                       (for project-specific agent overrides)"
echo "  Updates agent-os/config.yml           (if exists)"
echo ""

# Detect global installation location
GLOBAL_AGENT_OS=""
if [[ -d "$HOME/.agent-os" ]]; then
    GLOBAL_AGENT_OS="$HOME/.agent-os"
elif [[ -f "agent-os/config.yml" ]] && [[ -d "agent-os/skills" ]]; then
    # Running from agent-os-extended repo itself
    GLOBAL_AGENT_OS="$(pwd)/agent-os"
fi

# Check if global installation exists
if [[ -z "$GLOBAL_AGENT_OS" ]] || [[ ! -d "$GLOBAL_AGENT_OS/templates/team-development" ]]; then
    echo "❌ Error: Global Team Development System not found"
    echo ""
    echo "Please run global installation first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-team-system-global.sh | bash"
    echo ""
    echo "Or if running from agent-os-extended repo:"
    echo "  bash setup-team-system-global.sh"
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
mkdir -p .claude/agents  # For project-specific agent overrides (empty by default)

echo ""
echo "✅ Project structure created!"
echo ""
echo "Created directories:"
echo "  agent-os/templates/team-development/  - Place template overrides here (optional)"
echo "    ├── backend/                         - Backend template overrides"
echo "    ├── frontend/                        - Frontend template overrides"
echo "    ├── qa/                              - QA template overrides"
echo "    └── devops/                          - DevOps template overrides"
echo "  .claude/agents/                        - Place agent overrides here (optional)"
echo ""
echo "How it works:"
echo ""
echo "1. Global components (default):"
echo "   - Agents: .claude/agents/backend-dev.md, frontend-dev.md, etc."
echo "   - Skills: .claude/skills/testing-best-practices.md, devops-patterns.md"
echo "   - Templates: $GLOBAL_AGENT_OS/templates/team-development/"
echo ""
echo "2. Smart Task Routing (automatic):"
echo "   - /execute-tasks analyzes task descriptions"
echo "   - Routes to appropriate specialist based on keywords"
echo "   - Backend: api, endpoint, controller, service, repository"
echo "   - Frontend: component, page, view, ui, react, angular"
echo "   - QA: test, spec, coverage, e2e, integration"
echo "   - DevOps: deploy, ci, cd, docker, pipeline"
echo ""
echo "3. Override if needed (project-specific customization):"
echo "   Example: Custom backend-dev for this project's architecture"
echo ""
echo "   cp .claude/agents/backend-dev.md .claude/agents/"
echo "   vim .claude/agents/backend-dev.md"
echo "   # Add project-specific patterns (e.g., custom DTO structure)"
echo "   # This project now uses custom backend-dev, others use global"
echo ""
echo "   Example: Custom API spec template"
echo "   cp $GLOBAL_AGENT_OS/templates/team-development/backend/api-spec.md \\"
echo "      agent-os/templates/team-development/backend/"
echo "   vim agent-os/templates/team-development/backend/api-spec.md"
echo "   # This project now uses custom API spec template"
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
echo "  ✓ Specialists: backend-dev, frontend-dev, qa-specialist, devops-specialist"
echo ""
echo "Ready to use:"
echo "  /execute-tasks"
echo ""
echo "Example tasks.md that triggers specialists:"
echo ""
echo "  1. Create POST /api/users endpoint with validation"
echo "     → Routes to: backend-dev (keywords: api, endpoint)"
echo ""
echo "  2. Create UserList component with pagination"
echo "     → Routes to: frontend-dev (keywords: component, pagination)"
echo ""
echo "  3. Add comprehensive tests for user management"
echo "     → Routes to: qa-specialist (keywords: tests)"
echo ""
echo "  4. Setup GitHub Actions CI/CD pipeline"
echo "     → Routes to: devops-specialist (keywords: github actions, ci/cd, pipeline)"
echo ""
echo "The system will:"
echo "  1. Analyze each task description"
echo "  2. Detect task type based on keywords"
echo "  3. Route to appropriate specialist"
echo "  4. Specialist uses global skills and templates"
echo "  5. Specialist generates complete implementation"
echo "  6. Handoff created for next specialist"
echo ""
echo "Customization examples:"
echo ""
echo "  # Use Node.js instead of Java for this project"
echo "  Edit agent-os/config.yml:"
echo "    specialists:"
echo "      backend_dev:"
echo "        default_stack: nodejs_express"
echo ""
echo "  # Use Angular instead of React"
echo "  Edit agent-os/config.yml:"
echo "    specialists:"
echo "      frontend_dev:"
echo "        default_framework: angular"
echo ""
echo "  # Disable DevOps specialist for this project"
echo "  Edit agent-os/config.yml:"
echo "    specialists:"
echo "      devops_specialist:"
echo "        enabled: false"
echo ""
echo "  # Higher coverage target for critical project"
echo "  Edit agent-os/config.yml:"
echo "    quality_gates:"
echo "      coverage_minimum: 90"
echo ""
echo "For complete documentation:"
echo "  See: $GLOBAL_AGENT_OS/../specs/2025-12-28-team-development-system/spec.md"
echo ""
