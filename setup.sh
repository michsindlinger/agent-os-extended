#!/bin/bash

# Agent OS Extended - Project-level Installation Script
# Installs Agent OS configuration files directly in the current project

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"
OVERWRITE_INSTRUCTIONS=false
OVERWRITE_STANDARDS=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --overwrite-instructions)
            OVERWRITE_INSTRUCTIONS=true
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
            echo "  --overwrite-instructions    Overwrite existing instruction files"
            echo "  --overwrite-standards      Overwrite existing standards files"
            echo "  -h, --help                 Show this help message"
            echo ""
            echo "This script installs Agent OS files in the current project directory"
            echo "instead of the global ~/.agent-os/ directory."
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
mkdir -p .agent-os/standards/code-style
mkdir -p .agent-os/instructions/core
mkdir -p .agent-os/instructions/meta

# Function to download file if it doesn't exist or if overwrite is enabled
download_file() {
    local url=$1
    local path=$2
    local category=$3
    
    if [[ -f "$path" ]]; then
        if [[ "$category" == "standards" && "$OVERWRITE_STANDARDS" == true ]] || 
           [[ "$category" == "instructions" && "$OVERWRITE_INSTRUCTIONS" == true ]]; then
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
download_file "$REPO_URL/standards/tech-stack.md" ".agent-os/standards/tech-stack.md" "standards"
download_file "$REPO_URL/standards/code-style.md" ".agent-os/standards/code-style.md" "standards"
download_file "$REPO_URL/standards/best-practices.md" ".agent-os/standards/best-practices.md" "standards"

# Download code style files
download_file "$REPO_URL/standards/code-style/javascript-style.md" ".agent-os/standards/code-style/javascript-style.md" "standards"
download_file "$REPO_URL/standards/code-style/css-style.md" ".agent-os/standards/code-style/css-style.md" "standards"
download_file "$REPO_URL/standards/code-style/html-style.md" ".agent-os/standards/code-style/html-style.md" "standards"

# Download instruction files
echo ""
echo "Setting up instructions..."

# Analysis & Planning
download_file "$REPO_URL/instructions/core/analyze-product.md" ".agent-os/instructions/core/analyze-product.md" "instructions"
download_file "$REPO_URL/instructions/core/analyze-b2b-application.md" ".agent-os/instructions/core/analyze-b2b-application.md" "instructions"
download_file "$REPO_URL/instructions/core/plan-product.md" ".agent-os/instructions/core/plan-product.md" "instructions"
download_file "$REPO_URL/instructions/core/plan-b2b-application.md" ".agent-os/instructions/core/plan-b2b-application.md" "instructions"
download_file "$REPO_URL/instructions/core/plan-gift-book.md" ".agent-os/instructions/core/plan-gift-book.md" "instructions"

# Brainstorming & Transfer
download_file "$REPO_URL/instructions/core/start-brainstorming.md" ".agent-os/instructions/core/start-brainstorming.md" "instructions"
download_file "$REPO_URL/instructions/core/transfer-and-create-spec.md" ".agent-os/instructions/core/transfer-and-create-spec.md" "instructions"
download_file "$REPO_URL/instructions/core/transfer-and-create-bug.md" ".agent-os/instructions/core/transfer-and-create-bug.md" "instructions"
download_file "$REPO_URL/instructions/core/transfer-and-plan-product.md" ".agent-os/instructions/core/transfer-and-plan-product.md" "instructions"

# Spec & Feature Development
download_file "$REPO_URL/instructions/core/create-spec.md" ".agent-os/instructions/core/create-spec.md" "instructions"
download_file "$REPO_URL/instructions/core/update-feature.md" ".agent-os/instructions/core/update-feature.md" "instructions"
download_file "$REPO_URL/instructions/core/document-feature.md" ".agent-os/instructions/core/document-feature.md" "instructions"
download_file "$REPO_URL/instructions/core/retroactive-doc.md" ".agent-os/instructions/core/retroactive-doc.md" "instructions"
download_file "$REPO_URL/instructions/core/update-changelog.md" ".agent-os/instructions/core/update-changelog.md" "instructions"

# Bug Management
download_file "$REPO_URL/instructions/core/create-bug.md" ".agent-os/instructions/core/create-bug.md" "instructions"
download_file "$REPO_URL/instructions/core/execute-bug.md" ".agent-os/instructions/core/execute-bug.md" "instructions"

# Task Execution
download_file "$REPO_URL/instructions/core/execute-task.md" ".agent-os/instructions/core/execute-task.md" "instructions"
download_file "$REPO_URL/instructions/core/execute-tasks.md" ".agent-os/instructions/core/execute-tasks.md" "instructions"

# Daily Planning
download_file "$REPO_URL/instructions/core/create-daily-plan.md" ".agent-os/instructions/core/create-daily-plan.md" "instructions"
download_file "$REPO_URL/instructions/core/execute-daily-plan.md" ".agent-os/instructions/core/execute-daily-plan.md" "instructions"
download_file "$REPO_URL/instructions/core/review-daily-work.md" ".agent-os/instructions/core/review-daily-work.md" "instructions"

# Estimation
download_file "$REPO_URL/instructions/core/estimate-spec.md" ".agent-os/instructions/core/estimate-spec.md" "instructions"
download_file "$REPO_URL/instructions/core/validate-estimation.md" ".agent-os/instructions/core/validate-estimation.md" "instructions"

# Instagram Marketing
download_file "$REPO_URL/instructions/core/create-instagram-account.md" ".agent-os/instructions/core/create-instagram-account.md" "instructions"
download_file "$REPO_URL/instructions/core/create-content-plan.md" ".agent-os/instructions/core/create-content-plan.md" "instructions"

# Base Setup
download_file "$REPO_URL/instructions/core/init-base-setup.md" ".agent-os/instructions/core/init-base-setup.md" "instructions"
download_file "$REPO_URL/instructions/core/validate-base-setup.md" ".agent-os/instructions/core/validate-base-setup.md" "instructions"
download_file "$REPO_URL/instructions/core/extend-setup.md" ".agent-os/instructions/core/extend-setup.md" "instructions"

# Download meta instruction files
download_file "$REPO_URL/instructions/meta/pre-flight.md" ".agent-os/instructions/meta/pre-flight.md" "instructions"

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
echo "  .agent-os/standards/     - Coding standards and best practices"
echo "  .agent-os/instructions/  - Core workflow instructions"
echo ""
echo "Next steps:"
echo "1. Customize CLAUDE.md with your project-specific information"
echo "2. Customize .agent-os/standards/ files for your project"
echo "3. Configure your AI coding assistant to use these files"
echo "4. Start using structured AI development workflows"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"