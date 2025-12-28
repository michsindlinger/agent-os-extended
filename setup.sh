#!/bin/bash

# Agent OS Extended - Project-level Installation Script
# Installs Agent OS configuration files directly in the current project

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
            echo "Agent OS Extended Setup - Project-level installation"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --overwrite-workflows      Overwrite existing workflow files"
            echo "  --overwrite-standards      Overwrite existing standards files"
            echo "  -h, --help                 Show this help message"
            echo ""
            echo "This script installs Agent OS files in the current project directory"
            echo "using the v2.0 structure (agent-os/, workflows/)."
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

echo "🤖 Agent OS Extended - Project-level Setup"
echo "Installing Agent OS configuration in current project..."
echo ""

# Create project-level directories
echo "Creating project directories..."
mkdir -p agent-os/standards/code-style
mkdir -p agent-os/workflows/core
mkdir -p agent-os/workflows/meta

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

# Download standards files
echo ""
echo "Setting up standards..."
download_file "$REPO_URL/agent-os/standards/tech-stack.md" "agent-os/standards/tech-stack.md" "standards"
download_file "$REPO_URL/agent-os/standards/code-style.md" "agent-os/standards/code-style.md" "standards"
download_file "$REPO_URL/agent-os/standards/best-practices.md" "agent-os/standards/best-practices.md" "standards"

# Download code style files
download_file "$REPO_URL/agent-os/standards/code-style/javascript-style.md" "agent-os/standards/code-style/javascript-style.md" "standards"
download_file "$REPO_URL/agent-os/standards/code-style/css-style.md" "agent-os/standards/code-style/css-style.md" "standards"
download_file "$REPO_URL/agent-os/standards/code-style/html-style.md" "agent-os/standards/code-style/html-style.md" "standards"

# Download workflow files (renamed from instructions)
echo ""
echo "Setting up workflows..."

# Analysis & Planning
download_file "$REPO_URL/agent-os/workflows/core/analyze-product.md" "agent-os/workflows/core/analyze-product.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/analyze-b2b-application.md" "agent-os/workflows/core/analyze-b2b-application.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/plan-product.md" "agent-os/workflows/core/plan-product.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/plan-b2b-application.md" "agent-os/workflows/core/plan-b2b-application.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/plan-gift-book.md" "agent-os/workflows/core/plan-gift-book.md" "workflows"

# Brainstorming & Transfer
download_file "$REPO_URL/agent-os/workflows/core/start-brainstorming.md" "agent-os/workflows/core/start-brainstorming.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/transfer-and-create-spec.md" "agent-os/workflows/core/transfer-and-create-spec.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/transfer-and-create-bug.md" "agent-os/workflows/core/transfer-and-create-bug.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/transfer-and-plan-product.md" "agent-os/workflows/core/transfer-and-plan-product.md" "workflows"

# Spec & Feature Development
download_file "$REPO_URL/agent-os/workflows/core/create-spec.md" "agent-os/workflows/core/create-spec.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/update-feature.md" "agent-os/workflows/core/update-feature.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/document-feature.md" "agent-os/workflows/core/document-feature.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/retroactive-doc.md" "agent-os/workflows/core/retroactive-doc.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/update-changelog.md" "agent-os/workflows/core/update-changelog.md" "workflows"

# Bug Management
download_file "$REPO_URL/agent-os/workflows/core/create-bug.md" "agent-os/workflows/core/create-bug.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/execute-bug.md" "agent-os/workflows/core/execute-bug.md" "workflows"

# Task Execution
download_file "$REPO_URL/agent-os/workflows/core/execute-task.md" "agent-os/workflows/core/execute-task.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/execute-tasks.md" "agent-os/workflows/core/execute-tasks.md" "workflows"

# Daily Planning
download_file "$REPO_URL/agent-os/workflows/core/create-daily-plan.md" "agent-os/workflows/core/create-daily-plan.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/execute-daily-plan.md" "agent-os/workflows/core/execute-daily-plan.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/review-daily-work.md" "agent-os/workflows/core/review-daily-work.md" "workflows"

# Estimation
download_file "$REPO_URL/agent-os/workflows/core/estimate-spec.md" "agent-os/workflows/core/estimate-spec.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/validate-estimation.md" "agent-os/workflows/core/validate-estimation.md" "workflows"

# Instagram Marketing
download_file "$REPO_URL/agent-os/workflows/core/create-instagram-account.md" "agent-os/workflows/core/create-instagram-account.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/create-content-plan.md" "agent-os/workflows/core/create-content-plan.md" "workflows"

# Base Setup
download_file "$REPO_URL/agent-os/workflows/core/init-base-setup.md" "agent-os/workflows/core/init-base-setup.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/validate-base-setup.md" "agent-os/workflows/core/validate-base-setup.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/core/extend-setup.md" "agent-os/workflows/core/extend-setup.md" "workflows"

# Marketing
download_file "$REPO_URL/agent-os/workflows/develop-positioning.md" "agent-os/workflows/develop-positioning.md" "workflows"

# Download meta workflow files
download_file "$REPO_URL/agent-os/workflows/meta/pre-flight.md" "agent-os/workflows/meta/pre-flight.md" "workflows"

# Download research workflows (Phase II)
echo ""
echo "Setting up research workflows..."
mkdir -p agent-os/workflows/research
mkdir -p agent-os/templates/research
download_file "$REPO_URL/agent-os/workflows/research/analyze-codebase-patterns.md" "agent-os/workflows/research/analyze-codebase-patterns.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/research/visual-assets.md" "agent-os/workflows/research/visual-assets.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/research/README.md" "agent-os/workflows/research/README.md" "workflows"
download_file "$REPO_URL/agent-os/templates/research/research-questions.md" "agent-os/templates/research/research-questions.md" "workflows"
download_file "$REPO_URL/agent-os/templates/research/research-notes.md" "agent-os/templates/research/research-notes.md" "workflows"

# Download verification workflows (Phase II)
echo ""
echo "Setting up verification workflows..."
mkdir -p agent-os/workflows/verification
mkdir -p agent-os/templates/verification
download_file "$REPO_URL/agent-os/workflows/verification/verify-spec.md" "agent-os/workflows/verification/verify-spec.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/verification/verify-implementation.md" "agent-os/workflows/verification/verify-implementation.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/verification/verify-visual.md" "agent-os/workflows/verification/verify-visual.md" "workflows"
download_file "$REPO_URL/agent-os/workflows/verification/README.md" "agent-os/workflows/verification/README.md" "workflows"
download_file "$REPO_URL/agent-os/templates/verification/spec-verification-report.md" "agent-os/templates/verification/spec-verification-report.md" "workflows"
download_file "$REPO_URL/agent-os/templates/verification/implementation-verification-report.md" "agent-os/templates/verification/implementation-verification-report.md" "workflows"
download_file "$REPO_URL/agent-os/templates/verification/visual-verification-report.md" "agent-os/templates/verification/visual-verification-report.md" "workflows"

# Download enhanced create-spec workflow (Phase II)
download_file "$REPO_URL/agent-os/workflows/core/create-spec-v2.md" "agent-os/workflows/core/create-spec-v2.md" "workflows"

# Download profiles (Phase II)
echo ""
echo "Setting up profiles..."
mkdir -p agent-os/profiles
download_file "$REPO_URL/agent-os/profiles/base.md" "agent-os/profiles/base.md" "profiles"
download_file "$REPO_URL/agent-os/profiles/java-spring-boot.md" "agent-os/profiles/java-spring-boot.md" "profiles"
download_file "$REPO_URL/agent-os/profiles/react-frontend.md" "agent-os/profiles/react-frontend.md" "profiles"
download_file "$REPO_URL/agent-os/profiles/angular-frontend.md" "agent-os/profiles/angular-frontend.md" "profiles"
download_file "$REPO_URL/agent-os/profiles/README.md" "agent-os/profiles/README.md" "profiles"

# Download skills (Phase II)
echo ""
echo "Setting up skills..."
mkdir -p agent-os/skills/{base,java,react,angular}

# Base skills
download_file "$REPO_URL/agent-os/skills/base/security-best-practices.md" "agent-os/skills/base/security-best-practices.md" "skills"
download_file "$REPO_URL/agent-os/skills/base/git-workflow-patterns.md" "agent-os/skills/base/git-workflow-patterns.md" "skills"

# Java skills
download_file "$REPO_URL/agent-os/skills/java/java-core-patterns.md" "agent-os/skills/java/java-core-patterns.md" "skills"
download_file "$REPO_URL/agent-os/skills/java/spring-boot-conventions.md" "agent-os/skills/java/spring-boot-conventions.md" "skills"
download_file "$REPO_URL/agent-os/skills/java/jpa-best-practices.md" "agent-os/skills/java/jpa-best-practices.md" "skills"

# React skills
download_file "$REPO_URL/agent-os/skills/react/react-component-patterns.md" "agent-os/skills/react/react-component-patterns.md" "skills"
download_file "$REPO_URL/agent-os/skills/react/react-hooks-best-practices.md" "agent-os/skills/react/react-hooks-best-practices.md" "skills"
download_file "$REPO_URL/agent-os/skills/react/typescript-react-patterns.md" "agent-os/skills/react/typescript-react-patterns.md" "skills"

# Angular skills
download_file "$REPO_URL/agent-os/skills/angular/angular-component-patterns.md" "agent-os/skills/angular/angular-component-patterns.md" "skills"
download_file "$REPO_URL/agent-os/skills/angular/angular-services-patterns.md" "agent-os/skills/angular/angular-services-patterns.md" "skills"
download_file "$REPO_URL/agent-os/skills/angular/rxjs-best-practices.md" "agent-os/skills/angular/rxjs-best-practices.md" "skills"

download_file "$REPO_URL/agent-os/skills/README.md" "agent-os/skills/README.md" "skills"

# Download market validation skills (Phase A)
echo ""
echo "Downloading market validation skills (Phase A)..."
mkdir -p agent-os/skills/product
mkdir -p agent-os/skills/business
mkdir -p agent-os/skills/marketing

download_file "$REPO_URL/agent-os/skills/product/product-strategy-patterns.md" "agent-os/skills/product/product-strategy-patterns.md" "skills"
download_file "$REPO_URL/agent-os/skills/business/market-research-best-practices.md" "agent-os/skills/business/market-research-best-practices.md" "skills"
download_file "$REPO_URL/agent-os/skills/business/business-analysis-methods.md" "agent-os/skills/business/business-analysis-methods.md" "skills"
download_file "$REPO_URL/agent-os/skills/business/validation-strategies.md" "agent-os/skills/business/validation-strategies.md" "skills"
download_file "$REPO_URL/agent-os/skills/marketing/content-writing-best-practices.md" "agent-os/skills/marketing/content-writing-best-practices.md" "skills"
download_file "$REPO_URL/agent-os/skills/marketing/seo-optimization-patterns.md" "agent-os/skills/marketing/seo-optimization-patterns.md" "skills"
download_file "$REPO_URL/agent-os/skills/marketing/copywriting-style.md" "agent-os/skills/marketing/copywriting-style.md" "skills"

# Download market validation templates (Phase A)
echo ""
echo "Downloading market validation templates..."
mkdir -p agent-os/templates/market-validation

download_file "$REPO_URL/agent-os/templates/market-validation/product-brief.md" "agent-os/templates/market-validation/product-brief.md" "templates"
download_file "$REPO_URL/agent-os/templates/market-validation/competitor-analysis.md" "agent-os/templates/market-validation/competitor-analysis.md" "templates"
download_file "$REPO_URL/agent-os/templates/market-validation/market-positioning.md" "agent-os/templates/market-validation/market-positioning.md" "templates"
download_file "$REPO_URL/agent-os/templates/market-validation/validation-plan.md" "agent-os/templates/market-validation/validation-plan.md" "templates"
download_file "$REPO_URL/agent-os/templates/market-validation/ad-campaigns.md" "agent-os/templates/market-validation/ad-campaigns.md" "templates"
download_file "$REPO_URL/agent-os/templates/market-validation/analytics-setup.md" "agent-os/templates/market-validation/analytics-setup.md" "templates"
download_file "$REPO_URL/agent-os/templates/market-validation/validation-results.md" "agent-os/templates/market-validation/validation-results.md" "templates"

# Download market validation workflow (Phase A)
echo ""
echo "Downloading market validation workflow..."
mkdir -p agent-os/workflows/validation

download_file "$REPO_URL/agent-os/workflows/validation/validate-market.md" "agent-os/workflows/validation/validate-market.md" "workflows"

# Create config.yml if it doesn't exist
echo ""
echo "Setting up configuration..."
if [[ ! -f "agent-os/config.yml" ]]; then
    download_file "$REPO_URL/agent-os/config.yml" "agent-os/config.yml" "config"
    echo "📝 Review agent-os/config.yml to set your active profile"
else
    echo "Skipping agent-os/config.yml (already exists)"
fi

# Handle CLAUDE.md - copy template if not exists, suggest merge if exists
echo ""
echo "Setting up CLAUDE.md..."
if [[ -f "CLAUDE.md" ]]; then
    echo "CLAUDE.md already exists - creating CLAUDE.md.template for reference"
    download_file "$REPO_URL/CLAUDE.md" "CLAUDE.md.template" "claude"
    echo "💡 Consider merging CLAUDE.md.template into your existing CLAUDE.md"
else
    echo "Creating CLAUDE.md from template..."
    download_file "$REPO_URL/CLAUDE.md" "CLAUDE.md" "claude"
    echo "📝 Please customize CLAUDE.md with your project-specific information"
fi

echo ""
echo "✅ Agent OS Extended v2.0 setup complete!"
echo ""
echo "Project structure created:"
echo "  agent-os/standards/      - Coding standards and best practices"
echo "  agent-os/workflows/      - Core workflow instructions"
echo "  agent-os/profiles/       - Tech-stack profiles (Phase II)"
echo "  agent-os/skills/         - Claude Code Skills (Phase II)"
echo "  agent-os/config.yml      - Configuration file"
echo ""
echo "Phase II Features Installed:"
echo "  ✓ Profile System (Java, React, Angular)"
echo "  ✓ Skills System (12 contextual skills)"
echo "  ✓ Enhanced Research (codebase analysis, Q&A, visuals)"
echo "  ✓ Verification System (spec, implementation, visual)"
echo "  ✓ Market Validation (Phase A: 6 skills, 7 templates, 1 workflow)"
echo ""
echo "Next steps:"
echo "1. Customize CLAUDE.md with your project-specific information"
echo "2. Set your profile in agent-os/config.yml (active_profile: ...)"
echo "3. Run tool-specific setup (e.g., setup-claude-code.sh for Claude Code)"
echo "4. Start using v2.0 workflows with enhanced features"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"