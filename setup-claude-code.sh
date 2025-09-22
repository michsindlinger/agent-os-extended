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
command_files=(
    "analyze-product.md"
    "analyze-b2b-application.md"
    "start-brainstorming.md"
    "transfer-and-create-spec.md"
    "transfer-and-create-bug.md"
    "transfer-and-plan-product.md"
    "create-spec.md"
    "create-bug.md"
    "execute-bug.md"
    "update-feature.md"
    "document-feature.md"
    "retroactive-doc.md"
    "update-changelog.md"
    "execute-tasks.md"
    "plan-product.md"
    "plan-b2b-application.md"
    "init-base-setup.md"
    "validate-base-setup.md"
    "extend-setup.md"
    "create-daily-plan.md"
    "execute-daily-plan.md"
    "review-daily-work.md"
)

for file in "${command_files[@]}"; do
    download_file "$REPO_URL/commands/$file" ".claude/commands/$file"
done

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
echo "  /analyze-product      - Analyze product requirements"
echo "  /analyze-b2b-application - Analyze B2B enterprise application"
echo "  /start-brainstorming  - Start collaborative brainstorming sessions"
echo "  /transfer-and-create-spec - Transfer brainstorming to feature spec"
echo "  /transfer-and-create-bug  - Transfer brainstorming to bug report"
echo "  /transfer-and-plan-product - Transfer brainstorming to product plan"
echo "  /create-spec          - Create feature specifications"
echo "  /create-bug           - Create bug reports"
echo "  /execute-bug          - Execute bug fixes"
echo "  /update-feature       - Update existing features"
echo "  /document-feature     - Document completed features"
echo "  /retroactive-doc      - Document existing features"
echo "  /update-changelog     - Update project changelog"
echo "  /execute-tasks        - Execute development tasks"
echo "  /plan-product         - Plan your product roadmap"
echo "  /plan-b2b-application - Plan B2B enterprise application"
echo "  /init-base-setup      - Initialize base project setup"
echo "  /validate-base-setup  - Validate base setup configuration"
echo "  /extend-setup         - Extend setup with additional features"
echo "  /create-daily-plan    - Create structured daily work plan"
echo "  /execute-daily-plan   - Execute daily tasks autonomously"
echo "  /review-daily-work    - Review and iterate on completed work"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"