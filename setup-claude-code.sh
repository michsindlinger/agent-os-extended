#!/bin/bash

# Agent OS Extended - Claude Code Project-level Setup
# Installs Claude Code specific Agent OS files in the current project

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "🤖 Agent OS Extended - Claude Code Setup"
echo "Installing Claude Code configuration in current project..."
echo ""

# Check if base Agent OS is installed in project
if [[ ! -d "agent-os/standards" ]] || [[ ! -d "agent-os/workflows" ]]; then
    echo "❌ Error: Agent OS base installation not found in current project."
    echo ""
    echo "Please run the base setup first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash"
    echo ""
    exit 1
fi

# Create Claude Code specific directories
echo "Creating Claude Code directories..."
mkdir -p .claude/commands/agent-os
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
    "brainstorm-upselling-ideas.md"
    "transfer-and-create-spec.md"
    "transfer-and-create-bug.md"
    "transfer-and-plan-product.md"
    "create-spec.md"
    "create-bug.md"
    "add-bug.md"
    "execute-bug.md"
    "update-feature.md"
    "document-feature.md"
    "retroactive-doc.md"
    "update-changelog.md"
    "execute-tasks.md"
    "plan-product.md"
    "build-development-team.md"
    "plan-b2b-application.md"
    "plan-gift-book.md"
    "init-base-setup.md"
    "validate-base-setup.md"
    "extend-setup.md"
    "create-daily-plan.md"
    "execute-daily-plan.md"
    "review-daily-work.md"
    "estimate-spec.md"
    "validate-estimation.md"
    "create-instagram-account.md"
    "create-content-plan.md"
    "develop-positioning.md"
    "validate-market.md"
)

for file in "${command_files[@]}"; do
    download_file "$REPO_URL/.claude/commands/agent-os/$file" ".claude/commands/agent-os/$file"
done

# Download agent files
echo ""
echo "Setting up agents..."
download_file "$REPO_URL/.claude/agents/test-runner.md" ".claude/agents/test-runner.md"
download_file "$REPO_URL/.claude/agents/context-fetcher.md" ".claude/agents/context-fetcher.md"
download_file "$REPO_URL/.claude/agents/git-workflow.md" ".claude/agents/git-workflow.md"
download_file "$REPO_URL/.claude/agents/file-creator.md" ".claude/agents/file-creator.md"
download_file "$REPO_URL/.claude/agents/date-checker.md" ".claude/agents/date-checker.md"
download_file "$REPO_URL/.claude/agents/estimation-specialist.md" ".claude/agents/estimation-specialist.md"

# Download market validation specialist agents (Phase A)
echo ""
echo "Downloading market validation specialists..."
download_file "$REPO_URL/.claude/agents/product-strategist.md" ".claude/agents/product-strategist.md"
download_file "$REPO_URL/.claude/agents/market-researcher.md" ".claude/agents/market-researcher.md"
download_file "$REPO_URL/.claude/agents/content-creator.md" ".claude/agents/content-creator.md"
download_file "$REPO_URL/.claude/agents/seo-specialist.md" ".claude/agents/seo-specialist.md"
download_file "$REPO_URL/.claude/agents/web-developer.md" ".claude/agents/web-developer.md"
download_file "$REPO_URL/.claude/agents/validation-specialist.md" ".claude/agents/validation-specialist.md"
download_file "$REPO_URL/.claude/agents/business-analyst.md" ".claude/agents/business-analyst.md"

# Create Skills symlinks (Phase II)
echo ""
echo "Setting up Claude Code Skills symlinks..."
mkdir -p .claude/skills

# Check if skills directory exists
if [[ -d "agent-os/skills" ]]; then
    # Create symlinks for all skills
    echo "Creating symlinks to agent-os/skills/..."

    # Base skills
    ln -sf ../../agent-os/skills/base/security-best-practices.md .claude/skills/security-best-practices.md
    ln -sf ../../agent-os/skills/base/git-workflow-patterns.md .claude/skills/git-workflow-patterns.md

    # Java skills
    ln -sf ../../agent-os/skills/java/java-core-patterns.md .claude/skills/java-core-patterns.md
    ln -sf ../../agent-os/skills/java/spring-boot-conventions.md .claude/skills/spring-boot-conventions.md
    ln -sf ../../agent-os/skills/java/jpa-best-practices.md .claude/skills/jpa-best-practices.md

    # React skills
    ln -sf ../../agent-os/skills/react/react-component-patterns.md .claude/skills/react-component-patterns.md
    ln -sf ../../agent-os/skills/react/react-hooks-best-practices.md .claude/skills/react-hooks-best-practices.md
    ln -sf ../../agent-os/skills/react/typescript-react-patterns.md .claude/skills/typescript-react-patterns.md

    # Angular skills
    ln -sf ../../agent-os/skills/angular/angular-component-patterns.md .claude/skills/angular-component-patterns.md
    ln -sf ../../agent-os/skills/angular/angular-services-patterns.md .claude/skills/angular-services-patterns.md
    ln -sf ../../agent-os/skills/angular/rxjs-best-practices.md .claude/skills/rxjs-best-practices.md

    # Market validation skills (Phase A)
    ln -sf ../../agent-os/skills/product/product-strategy-patterns.md .claude/skills/product-strategy-patterns.md
    ln -sf ../../agent-os/skills/business/market-research-best-practices.md .claude/skills/market-research-best-practices.md
    ln -sf ../../agent-os/skills/business/business-analysis-methods.md .claude/skills/business-analysis-methods.md
    ln -sf ../../agent-os/skills/business/validation-strategies.md .claude/skills/validation-strategies.md
    ln -sf ../../agent-os/skills/marketing/content-writing-best-practices.md .claude/skills/content-writing-best-practices.md
    ln -sf ../../agent-os/skills/marketing/seo-optimization-patterns.md .claude/skills/seo-optimization-patterns.md
    ln -sf ../../agent-os/skills/marketing/copywriting-style.md .claude/skills/copywriting-style.md

    echo "✓ Created 18 skill symlinks (11 base + 7 market validation)"
else
    echo "⚠ Skills directory not found. Run base setup first to install skills."
fi

echo ""
echo "✅ Claude Code setup complete!"
echo ""
echo "Project structure created:"
echo "  .claude/commands/agent-os/  - Claude Code commands"
echo "  .claude/agents/             - Claude Code agents"
echo "  .claude/skills/             - Claude Code Skills (symlinks to agent-os/skills/)"
echo ""
echo "Phase II Features Configured:"
echo "  ✓ 17 Skills symlinked (11 base + 6 market validation)"
echo "  ✓ Commands updated for v2.0 workflows"
echo "  ✓ Enhanced /create-spec with research phase"
echo "  ✓ Market Validation (Phase A: /validate-market command)"
echo ""
echo "Available commands:"
echo "  /analyze-product      - Analyze product requirements"
echo "  /analyze-b2b-application - Analyze B2B enterprise application"
echo "  /start-brainstorming  - Start collaborative brainstorming sessions"
echo "  /brainstorm-upselling-ideas - Generate upselling opportunities"
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
echo "  /plan-gift-book       - Plan gift books for Amazon KDP"
echo "  /init-base-setup      - Initialize base project setup"
echo "  /validate-base-setup  - Validate base setup configuration"
echo "  /extend-setup         - Extend setup with additional features"
echo "  /create-daily-plan    - Create structured daily work plan"
echo "  /execute-daily-plan   - Execute daily tasks autonomously"
echo "  /review-daily-work    - Review and iterate on completed work"
echo "  /estimate-spec        - Estimate effort for feature specifications"
echo "  /validate-estimation  - Validate estimation plausibility"
echo "  /create-instagram-account - Create Instagram marketing strategy"
echo "  /create-content-plan  - Create 7-day Instagram content plan"
echo "  /develop-positioning  - Develop positioning strategy from project specs"
echo "  /validate-market      - Market validation with landing page and ad campaigns (Phase A)"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"