#!/bin/bash

# Agent OS Extended - Update to Phase II Features
# Adds Phase II features (profiles, skills, research, verification) to v2.0 structure

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "\n${BLUE}==> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check for v2.0 structure
if [[ ! -d "agent-os" ]]; then
    print_error "Agent OS v2.0 structure not found (agent-os/ directory missing)"
    echo ""
    echo "Please migrate to v2.0 first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-to-v2.sh | bash"
    exit 1
fi

print_success "Found agent-os/ directory (v2.0 structure)"

# Function to download file
download_file() {
    local url=$1
    local path=$2

    echo "Downloading $path..."
    curl -sSL "$url" -o "$path"
}

# Phase II: Profiles
print_step "Installing Profiles"
mkdir -p agent-os/profiles
download_file "$REPO_URL/profiles/base.md" "agent-os/profiles/base.md"
download_file "$REPO_URL/profiles/java-spring-boot.md" "agent-os/profiles/java-spring-boot.md"
download_file "$REPO_URL/profiles/react-frontend.md" "agent-os/profiles/react-frontend.md"
download_file "$REPO_URL/profiles/angular-frontend.md" "agent-os/profiles/angular-frontend.md"
download_file "$REPO_URL/profiles/README.md" "agent-os/profiles/README.md"
print_success "Installed 4 profiles"

# Phase II: Skills
print_step "Installing Skills"
mkdir -p agent-os/skills/{base,java,react,angular}

# Base skills
download_file "$REPO_URL/skills/base/security-best-practices.md" "agent-os/skills/base/security-best-practices.md"
download_file "$REPO_URL/skills/base/git-workflow-patterns.md" "agent-os/skills/base/git-workflow-patterns.md"

# Java skills
download_file "$REPO_URL/skills/java/java-core-patterns.md" "agent-os/skills/java/java-core-patterns.md"
download_file "$REPO_URL/skills/java/spring-boot-conventions.md" "agent-os/skills/java/spring-boot-conventions.md"
download_file "$REPO_URL/skills/java/jpa-best-practices.md" "agent-os/skills/java/jpa-best-practices.md"

# React skills
download_file "$REPO_URL/skills/react/react-component-patterns.md" "agent-os/skills/react/react-component-patterns.md"
download_file "$REPO_URL/skills/react/react-hooks-best-practices.md" "agent-os/skills/react/react-hooks-best-practices.md"
download_file "$REPO_URL/skills/react/typescript-react-patterns.md" "agent-os/skills/react/typescript-react-patterns.md"

# Angular skills
download_file "$REPO_URL/skills/angular/angular-component-patterns.md" "agent-os/skills/angular/angular-component-patterns.md"
download_file "$REPO_URL/skills/angular/angular-services-patterns.md" "agent-os/skills/angular/angular-services-patterns.md"
download_file "$REPO_URL/skills/angular/rxjs-best-practices.md" "agent-os/skills/angular/rxjs-best-practices.md"

download_file "$REPO_URL/skills/README.md" "agent-os/skills/README.md"
print_success "Installed 11 skills"

# Phase II: Research Workflows
print_step "Installing Research Workflows"
mkdir -p agent-os/workflows/research
mkdir -p agent-os/templates/research
download_file "$REPO_URL/workflows/research/analyze-codebase-patterns.md" "agent-os/workflows/research/analyze-codebase-patterns.md"
download_file "$REPO_URL/workflows/research/visual-assets.md" "agent-os/workflows/research/visual-assets.md"
download_file "$REPO_URL/workflows/research/README.md" "agent-os/workflows/research/README.md"
download_file "$REPO_URL/templates/research/research-questions.md" "agent-os/templates/research/research-questions.md"
download_file "$REPO_URL/templates/research/research-notes.md" "agent-os/templates/research/research-notes.md"
print_success "Installed research workflows"

# Phase II: Verification Workflows
print_step "Installing Verification Workflows"
mkdir -p agent-os/workflows/verification
mkdir -p agent-os/templates/verification
download_file "$REPO_URL/workflows/verification/verify-spec.md" "agent-os/workflows/verification/verify-spec.md"
download_file "$REPO_URL/workflows/verification/verify-implementation.md" "agent-os/workflows/verification/verify-implementation.md"
download_file "$REPO_URL/workflows/verification/verify-visual.md" "agent-os/workflows/verification/verify-visual.md"
download_file "$REPO_URL/workflows/verification/README.md" "agent-os/workflows/verification/README.md"
download_file "$REPO_URL/templates/verification/spec-verification-report.md" "agent-os/templates/verification/spec-verification-report.md"
download_file "$REPO_URL/templates/verification/implementation-verification-report.md" "agent-os/templates/verification/implementation-verification-report.md"
download_file "$REPO_URL/templates/verification/visual-verification-report.md" "agent-os/templates/verification/visual-verification-report.md"
print_success "Installed verification workflows"

# Phase II: Enhanced create-spec
print_step "Installing Enhanced Workflows"
download_file "$REPO_URL/workflows/core/create-spec-v2.md" "agent-os/workflows/core/create-spec-v2.md"
print_success "Installed create-spec v2.0"

# Create/Update config.yml
print_step "Configuring Phase II Features"
if [[ ! -f "agent-os/config.yml" ]]; then
    download_file "$REPO_URL/config.yml" "agent-os/config.yml"
    print_success "Created agent-os/config.yml"
else
    echo "⚠ agent-os/config.yml already exists - not overwriting"
    echo "💡 Review agent-os/config.yml to enable Phase II features:"
    echo "   - profile_system: true"
    echo "   - skills_system: true"
    echo "   - enhanced_research: true"
    echo "   - verification_system: true"
fi

# Update .claude/commands/agent-os/create-spec.md if exists
if [[ -f ".claude/commands/agent-os/create-spec.md" ]]; then
    print_step "Updating /create-spec command to v2.0"
    download_file "$REPO_URL/commands/create-spec.md" ".claude/commands/agent-os/create-spec.md"
    print_success "Updated create-spec command"
fi

# Create skills symlinks for Claude Code
if [[ -d ".claude" ]]; then
    print_step "Creating Skills Symlinks for Claude Code"
    mkdir -p .claude/skills

    # Base skills
    ln -sf ../../agent-os/skills/base/security-best-practices.md .claude/skills/security-best-practices.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/base/git-workflow-patterns.md .claude/skills/git-workflow-patterns.md 2>/dev/null || true

    # Java skills
    ln -sf ../../agent-os/skills/java/java-core-patterns.md .claude/skills/java-core-patterns.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/java/spring-boot-conventions.md .claude/skills/spring-boot-conventions.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/java/jpa-best-practices.md .claude/skills/jpa-best-practices.md 2>/dev/null || true

    # React skills
    ln -sf ../../agent-os/skills/react/react-component-patterns.md .claude/skills/react-component-patterns.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/react/react-hooks-best-practices.md .claude/skills/react-hooks-best-practices.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/react/typescript-react-patterns.md .claude/skills/typescript-react-patterns.md 2>/dev/null || true

    # Angular skills
    ln -sf ../../agent-os/skills/angular/angular-component-patterns.md .claude/skills/angular-component-patterns.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/angular/angular-services-patterns.md .claude/skills/angular-services-patterns.md 2>/dev/null || true
    ln -sf ../../agent-os/skills/angular/rxjs-best-practices.md .claude/skills/rxjs-best-practices.md 2>/dev/null || true

    print_success "Created 11 skill symlinks"
fi

# Summary
print_step "Phase II Update Complete"

echo ""
echo "======================================"
echo "Phase II Features Installed!"
echo "======================================"
echo ""
echo "Added:"
echo "  ✓ Profile System (4 profiles: base, java, react, angular)"
echo "  ✓ Skills System (11 contextual skills)"
echo "  ✓ Enhanced Research (codebase analysis, Q&A, visuals)"
echo "  ✓ Verification System (spec, implementation, visual)"
echo "  ✓ Enhanced /create-spec workflow"
echo ""
echo "Configuration:"
echo "  📝 Review agent-os/config.yml to:"
echo "     - Set active_profile (base, java-spring-boot, react-frontend, angular-frontend)"
echo "     - Enable/disable verification types"
echo ""
echo "Next steps:"
echo "  1. Set your active profile in agent-os/config.yml"
echo "  2. Try /create-spec to experience the enhanced research phase"
echo "  3. Skills activate automatically based on file type and context"
echo ""
echo "For more information:"
echo "  - Profiles: agent-os/profiles/README.md"
echo "  - Skills: agent-os/skills/README.md"
echo "  - Research: agent-os/workflows/research/README.md"
echo "  - Verification: agent-os/workflows/verification/README.md"
echo ""
