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
download_file "$REPO_URL/instructions/core/analyze-product.md" ".agent-os/instructions/core/analyze-product.md" "instructions"
download_file "$REPO_URL/instructions/core/analyze-b2b-application.md" ".agent-os/instructions/core/analyze-b2b-application.md" "instructions"
download_file "$REPO_URL/instructions/core/create-spec.md" ".agent-os/instructions/core/create-spec.md" "instructions"
download_file "$REPO_URL/instructions/core/execute-task.md" ".agent-os/instructions/core/execute-task.md" "instructions"
download_file "$REPO_URL/instructions/core/execute-tasks.md" ".agent-os/instructions/core/execute-tasks.md" "instructions"
download_file "$REPO_URL/instructions/core/plan-product.md" ".agent-os/instructions/core/plan-product.md" "instructions"
download_file "$REPO_URL/instructions/core/plan-b2b-application.md" ".agent-os/instructions/core/plan-b2b-application.md" "instructions"

# Download meta instruction files
download_file "$REPO_URL/instructions/meta/pre-flight.md" ".agent-os/instructions/meta/pre-flight.md" "instructions"

echo ""
echo "✅ Agent OS Extended setup complete!"
echo ""
echo "Project structure created:"
echo "  .agent-os/standards/     - Coding standards and best practices"
echo "  .agent-os/instructions/  - Core workflow instructions"
echo ""
echo "Next steps:"
echo "1. Customize standards/ files for your project"
echo "2. Configure your AI coding assistant to use these files"
echo "3. Start using structured AI development workflows"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"