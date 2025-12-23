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
download_file "$REPO_URL/standards/tech-stack.md" "agent-os/standards/tech-stack.md" "standards"
download_file "$REPO_URL/standards/code-style.md" "agent-os/standards/code-style.md" "standards"
download_file "$REPO_URL/standards/best-practices.md" "agent-os/standards/best-practices.md" "standards"

# Download code style files
download_file "$REPO_URL/standards/code-style/javascript-style.md" "agent-os/standards/code-style/javascript-style.md" "standards"
download_file "$REPO_URL/standards/code-style/css-style.md" "agent-os/standards/code-style/css-style.md" "standards"
download_file "$REPO_URL/standards/code-style/html-style.md" "agent-os/standards/code-style/html-style.md" "standards"

# Download workflow files (renamed from instructions)
echo ""
echo "Setting up workflows..."

# Analysis & Planning
download_file "$REPO_URL/workflows/core/analyze-product.md" "agent-os/workflows/core/analyze-product.md" "workflows"
download_file "$REPO_URL/workflows/core/analyze-b2b-application.md" "agent-os/workflows/core/analyze-b2b-application.md" "workflows"
download_file "$REPO_URL/workflows/core/plan-product.md" "agent-os/workflows/core/plan-product.md" "workflows"
download_file "$REPO_URL/workflows/core/plan-b2b-application.md" "agent-os/workflows/core/plan-b2b-application.md" "workflows"
download_file "$REPO_URL/workflows/core/plan-gift-book.md" "agent-os/workflows/core/plan-gift-book.md" "workflows"

# Brainstorming & Transfer
download_file "$REPO_URL/workflows/core/start-brainstorming.md" "agent-os/workflows/core/start-brainstorming.md" "workflows"
download_file "$REPO_URL/workflows/core/transfer-and-create-spec.md" "agent-os/workflows/core/transfer-and-create-spec.md" "workflows"
download_file "$REPO_URL/workflows/core/transfer-and-create-bug.md" "agent-os/workflows/core/transfer-and-create-bug.md" "workflows"
download_file "$REPO_URL/workflows/core/transfer-and-plan-product.md" "agent-os/workflows/core/transfer-and-plan-product.md" "workflows"

# Spec & Feature Development
download_file "$REPO_URL/workflows/core/create-spec.md" "agent-os/workflows/core/create-spec.md" "workflows"
download_file "$REPO_URL/workflows/core/update-feature.md" "agent-os/workflows/core/update-feature.md" "workflows"
download_file "$REPO_URL/workflows/core/document-feature.md" "agent-os/workflows/core/document-feature.md" "workflows"
download_file "$REPO_URL/workflows/core/retroactive-doc.md" "agent-os/workflows/core/retroactive-doc.md" "workflows"
download_file "$REPO_URL/workflows/core/update-changelog.md" "agent-os/workflows/core/update-changelog.md" "workflows"

# Bug Management
download_file "$REPO_URL/workflows/core/create-bug.md" "agent-os/workflows/core/create-bug.md" "workflows"
download_file "$REPO_URL/workflows/core/execute-bug.md" "agent-os/workflows/core/execute-bug.md" "workflows"

# Task Execution
download_file "$REPO_URL/workflows/core/execute-task.md" "agent-os/workflows/core/execute-task.md" "workflows"
download_file "$REPO_URL/workflows/core/execute-tasks.md" "agent-os/workflows/core/execute-tasks.md" "workflows"

# Daily Planning
download_file "$REPO_URL/workflows/core/create-daily-plan.md" "agent-os/workflows/core/create-daily-plan.md" "workflows"
download_file "$REPO_URL/workflows/core/execute-daily-plan.md" "agent-os/workflows/core/execute-daily-plan.md" "workflows"
download_file "$REPO_URL/workflows/core/review-daily-work.md" "agent-os/workflows/core/review-daily-work.md" "workflows"

# Estimation
download_file "$REPO_URL/workflows/core/estimate-spec.md" "agent-os/workflows/core/estimate-spec.md" "workflows"
download_file "$REPO_URL/workflows/core/validate-estimation.md" "agent-os/workflows/core/validate-estimation.md" "workflows"

# Instagram Marketing
download_file "$REPO_URL/workflows/core/create-instagram-account.md" "agent-os/workflows/core/create-instagram-account.md" "workflows"
download_file "$REPO_URL/workflows/core/create-content-plan.md" "agent-os/workflows/core/create-content-plan.md" "workflows"

# Base Setup
download_file "$REPO_URL/workflows/core/init-base-setup.md" "agent-os/workflows/core/init-base-setup.md" "workflows"
download_file "$REPO_URL/workflows/core/validate-base-setup.md" "agent-os/workflows/core/validate-base-setup.md" "workflows"
download_file "$REPO_URL/workflows/core/extend-setup.md" "agent-os/workflows/core/extend-setup.md" "workflows"

# Download meta workflow files
download_file "$REPO_URL/workflows/meta/pre-flight.md" "agent-os/workflows/meta/pre-flight.md" "workflows"

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
echo "✅ Agent OS Extended setup complete!"
echo ""
echo "Project structure created:"
echo "  agent-os/standards/  - Coding standards and best practices"
echo "  agent-os/workflows/  - Core workflow instructions"
echo ""
echo "Next steps:"
echo "1. Customize CLAUDE.md with your project-specific information"
echo "2. Customize agent-os/standards/ files for your project"
echo "3. Configure your AI coding assistant to use these files"
echo "4. Start using structured AI development workflows"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"