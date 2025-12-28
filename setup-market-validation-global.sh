#!/bin/bash

# Market Validation System - Global Installation
# Installs to ~/.agent-os/ and ~/.claude/ for use across all projects
# Version: 2.0 (Phase A)

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "========================================="
echo "Market Validation System - Global Setup"
echo "========================================="
echo ""
echo "This installs market validation components to:"
echo "  ~/.agent-os/          (skills, templates, workflows)"
echo "  ~/.claude/            (agents, commands)"
echo ""
echo "All projects can then use /validate-market command"
echo "Projects can override specific components if needed"
echo ""

# Download helper function
download_file() {
    local url="$1"
    local dest="$2"
    local category="${3:-file}"

    if command -v curl &> /dev/null; then
        curl -sSL "$url" -o "$dest" 2>/dev/null || {
            echo "⚠ Warning: Failed to download $category: $dest"
            return 1
        }
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest" 2>/dev/null || {
            echo "⚠ Warning: Failed to download $category: $dest"
            return 1
        }
    else
        echo "Error: Neither curl nor wget is available"
        exit 1
    fi
    echo "✓ Downloaded $category: $(basename $dest)"
}

# Create global directory structure
echo "Creating global directory structure..."
mkdir -p ~/.agent-os/skills/product
mkdir -p ~/.agent-os/skills/business
mkdir -p ~/.agent-os/skills/marketing
mkdir -p ~/.agent-os/templates/market-validation
mkdir -p ~/.agent-os/workflows/validation
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/commands/agent-os

# Download Skills (6 new)
echo ""
echo "Downloading market validation skills..."

download_file "$REPO_URL/agent-os/skills/product/product-strategy-patterns.md" \
  ~/.agent-os/skills/product/product-strategy-patterns.md "skill"

download_file "$REPO_URL/agent-os/skills/business/market-research-best-practices.md" \
  ~/.agent-os/skills/business/market-research-best-practices.md "skill"

download_file "$REPO_URL/agent-os/skills/business/business-analysis-methods.md" \
  ~/.agent-os/skills/business/business-analysis-methods.md "skill"

download_file "$REPO_URL/agent-os/skills/business/validation-strategies.md" \
  ~/.agent-os/skills/business/validation-strategies.md "skill"

download_file "$REPO_URL/agent-os/skills/marketing/content-writing-best-practices.md" \
  ~/.agent-os/skills/marketing/content-writing-best-practices.md "skill"

download_file "$REPO_URL/agent-os/skills/marketing/seo-optimization-patterns.md" \
  ~/.agent-os/skills/marketing/seo-optimization-patterns.md "skill"

download_file "$REPO_URL/agent-os/skills/marketing/copywriting-style.md" \
  ~/.agent-os/skills/marketing/copywriting-style.md "skill"

# Download Templates (7 new)
echo ""
echo "Downloading market validation templates..."

download_file "$REPO_URL/agent-os/templates/market-validation/product-brief.md" \
  ~/.agent-os/templates/market-validation/product-brief.md "template"

download_file "$REPO_URL/agent-os/templates/market-validation/competitor-analysis.md" \
  ~/.agent-os/templates/market-validation/competitor-analysis.md "template"

download_file "$REPO_URL/agent-os/templates/market-validation/market-positioning.md" \
  ~/.agent-os/templates/market-validation/market-positioning.md "template"

download_file "$REPO_URL/agent-os/templates/market-validation/validation-plan.md" \
  ~/.agent-os/templates/market-validation/validation-plan.md "template"

download_file "$REPO_URL/agent-os/templates/market-validation/ad-campaigns.md" \
  ~/.agent-os/templates/market-validation/ad-campaigns.md "template"

download_file "$REPO_URL/agent-os/templates/market-validation/analytics-setup.md" \
  ~/.agent-os/templates/market-validation/analytics-setup.md "template"

download_file "$REPO_URL/agent-os/templates/market-validation/validation-results.md" \
  ~/.agent-os/templates/market-validation/validation-results.md "template"

# Download Workflow (1 new)
echo ""
echo "Downloading market validation workflow..."

download_file "$REPO_URL/agent-os/workflows/validation/validate-market.md" \
  ~/.agent-os/workflows/validation/validate-market.md "workflow"

download_file "$REPO_URL/agent-os/workflows/validation/README.md" \
  ~/.agent-os/workflows/validation/README.md "documentation"

# Download Specialist Agents (7 new)
echo ""
echo "Downloading market validation specialist agents..."

download_file "$REPO_URL/.claude/agents/product-strategist.md" \
  ~/.claude/agents/product-strategist.md "agent"

download_file "$REPO_URL/.claude/agents/market-researcher.md" \
  ~/.claude/agents/market-researcher.md "agent"

download_file "$REPO_URL/.claude/agents/content-creator.md" \
  ~/.claude/agents/content-creator.md "agent"

download_file "$REPO_URL/.claude/agents/seo-specialist.md" \
  ~/.claude/agents/seo-specialist.md "agent"

download_file "$REPO_URL/.claude/agents/web-developer.md" \
  ~/.claude/agents/web-developer.md "agent"

download_file "$REPO_URL/.claude/agents/validation-specialist.md" \
  ~/.claude/agents/validation-specialist.md "agent"

download_file "$REPO_URL/.claude/agents/business-analyst.md" \
  ~/.claude/agents/business-analyst.md "agent"

# Download Command
echo ""
echo "Downloading /validate-market command..."

download_file "$REPO_URL/.claude/commands/agent-os/validate-market.md" \
  ~/.claude/commands/agent-os/validate-market.md "command"

# Create Skills symlinks in ~/.claude/skills/
echo ""
echo "Creating skill symlinks in ~/.claude/skills/..."

if [[ -d ~/.agent-os/skills ]]; then
    mkdir -p ~/.claude/skills

    # Market validation skills
    ln -sf ~/.agent-os/skills/product/product-strategy-patterns.md \
      ~/.claude/skills/product-strategy-patterns.md

    ln -sf ~/.agent-os/skills/business/market-research-best-practices.md \
      ~/.claude/skills/market-research-best-practices.md

    ln -sf ~/.agent-os/skills/business/business-analysis-methods.md \
      ~/.claude/skills/business-analysis-methods.md

    ln -sf ~/.agent-os/skills/business/validation-strategies.md \
      ~/.claude/skills/validation-strategies.md

    ln -sf ~/.agent-os/skills/marketing/content-writing-best-practices.md \
      ~/.claude/skills/content-writing-best-practices.md

    ln -sf ~/.agent-os/skills/marketing/seo-optimization-patterns.md \
      ~/.claude/skills/seo-optimization-patterns.md

    ln -sf ~/.agent-os/skills/marketing/copywriting-style.md \
      ~/.claude/skills/copywriting-style.md

    echo "✓ Created 7 skill symlinks in ~/.claude/skills/"
else
    echo "⚠ Skills directory not found (expected at ~/.agent-os/skills/)"
fi

echo ""
echo "✅ Market Validation System (Global) installed!"
echo ""
echo "Installed to:"
echo "  ~/.agent-os/skills/product/        - Product strategy skill"
echo "  ~/.agent-os/skills/business/       - 3 business skills"
echo "  ~/.agent-os/skills/marketing/      - 2 marketing skills"
echo "  ~/.agent-os/templates/market-validation/  - 7 templates"
echo "  ~/.agent-os/workflows/validation/  - validate-market workflow"
echo "  ~/.claude/agents/                  - 7 specialist agents"
echo "  ~/.claude/commands/agent-os/       - /validate-market command"
echo "  ~/.claude/skills/                  - 6 skill symlinks"
echo ""
echo "Usage in ANY project:"
echo "  /validate-market \"Your product idea\""
echo ""
echo "To override for a specific project:"
echo "  1. Copy component from ~/.agent-os/ to projekt/agent-os/"
echo "  2. Or from ~/.claude/ to projekt/.claude/"
echo "  3. Modify as needed"
echo "  4. Project version takes precedence"
echo ""
echo "Example override:"
echo "  cp ~/.claude/agents/market-researcher.md projekt/.claude/agents/"
echo "  vim projekt/.claude/agents/market-researcher.md"
echo "  # Now this project uses custom market-researcher"
echo ""
echo "To create project-specific validation results only:"
echo "  mkdir -p projekt/agent-os/market-validation/"
echo "  # Results will be stored here automatically"
echo ""
echo "Next steps:"
echo "  1. Go to any project directory"
echo "  2. Run: /validate-market"
echo "  3. System uses global components"
echo "  4. Results saved to projekt/agent-os/market-validation/"
echo ""
echo "For complete guide, see: ~/.agent-os/workflows/validation/README.md"
