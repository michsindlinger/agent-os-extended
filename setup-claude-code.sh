#!/bin/bash

# Agent OS Extended - Claude Code Project-level Setup
# Installs Claude Code specific Agent OS files in the current project

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "🤖 Agent OS Extended - Claude Code Setup"
echo "Installing Claude Code configuration in current project..."
echo ""

# Check if base Agent OS is installed in project
if [[ ! -d ".agent-os/standards" ]] || [[ ! -d ".agent-os/instructions" ]]; then
    echo "❌ Error: Agent OS base installation not found in current project."
    echo ""
    echo "Please run the base setup first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash"
    echo ""
    exit 1
fi

# Create Claude Code specific directories
echo "Creating Claude Code directories..."
mkdir -p .claude/commands
mkdir -p .claude/agents

# Function to download file
download_file() {
    local url=$1
    local path=$2
    
    echo "Downloading $path..."
    curl -sSL "$url" -o "$path"
}

# Download command files
echo ""
echo "Setting up commands..."
download_file "$REPO_URL/commands/plan-product.md" ".claude/commands/plan-product.md"
download_file "$REPO_URL/commands/plan-b2b-application.md" ".claude/commands/plan-b2b-application.md"
download_file "$REPO_URL/commands/create-spec.md" ".claude/commands/create-spec.md"
download_file "$REPO_URL/commands/execute-tasks.md" ".claude/commands/execute-tasks.md"
download_file "$REPO_URL/commands/analyze-product.md" ".claude/commands/analyze-product.md"
download_file "$REPO_URL/commands/analyze-b2b-application.md" ".claude/commands/analyze-b2b-application.md"

# Download agent files
echo ""
echo "Setting up agents..."
download_file "$REPO_URL/agents/test-runner.md" ".claude/agents/test-runner.md"
download_file "$REPO_URL/agents/context-fetcher.md" ".claude/agents/context-fetcher.md"
download_file "$REPO_URL/agents/git-workflow.md" ".claude/agents/git-workflow.md"
download_file "$REPO_URL/agents/file-creator.md" ".claude/agents/file-creator.md"
download_file "$REPO_URL/agents/date-checker.md" ".claude/agents/date-checker.md"

echo ""
echo "✅ Claude Code setup complete!"
echo ""
echo "Project structure created:"
echo "  .claude/commands/     - Claude Code commands"
echo "  .claude/agents/       - Claude Code agents"
echo ""
echo "Available commands:"
echo "  /plan-product         - Plan your product roadmap"
echo "  /plan-b2b-application - Plan B2B enterprise application"
echo "  /create-spec          - Create feature specifications"
echo "  /execute-tasks        - Execute development tasks"
echo "  /analyze-product      - Analyze product requirements"
echo "  /analyze-b2b-application - Analyze B2B enterprise application"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"