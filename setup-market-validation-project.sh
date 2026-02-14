#!/bin/bash

# Market Validation System - Project Setup
# Creates project-specific directories for validation results
# Version: 2.0 (Phase A)

set -e

echo "========================================="
echo "Market Validation - Project Setup"
echo "========================================="
echo ""
echo "This creates project-specific directories for storing validation results."
echo ""
echo "Prerequisites:"
echo "  ✓ Global installation: setup-market-validation-global.sh must be run first"
echo "  ✓ Skills, templates, agents installed in ~/.specwright/ and ~/.claude/"
echo ""
echo "This script creates:"
echo "  specwright/market-validation/  (for validation campaign results)"
echo ""

# Check if global installation exists
if [[ ! -d ~/.specwright/workflows/validation ]]; then
    echo "❌ Error: Global Market Validation System not found"
    echo ""
    echo "Please run global installation first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/specwright/main/setup-market-validation-global.sh | bash"
    echo ""
    exit 1
fi

# Create project directories
echo "Creating project directories..."
mkdir -p specwright/market-validation
mkdir -p .claude/agents  # For project-specific agent overrides (empty by default)
mkdir -p .claude/commands/specwright  # For project-specific command overrides (empty by default)

echo ""
echo "✅ Project structure created!"
echo ""
echo "Created directories:"
echo "  specwright/market-validation/     - Validation campaign results stored here"
echo "  .claude/agents/                 - Place project-specific agent overrides here (optional)"
echo "  .claude/commands/specwright/      - Place project-specific command overrides here (optional)"
echo ""
echo "How it works:"
echo ""
echo "1. Global components (default):"
echo "   - Agents: ~/.claude/agents/product-strategist.md, etc."
echo "   - Skills: ~/.claude/skills/product-strategy-patterns.md, etc."
echo "   - Templates: ~/.specwright/templates/market-validation/"
echo "   - Workflow: ~/.specwright/workflows/validation/validate-market.md"
echo ""
echo "2. Validation results (project-specific):"
echo "   - Each validation creates: specwright/market-validation/YYYY-MM-DD-product-name/"
echo "   - Contains: product-brief.md, competitor-analysis.md, landing-page/, etc."
echo "   - Committed to your project repository"
echo ""
echo "3. Override if needed (project-specific customization):"
echo "   Example: Custom market-researcher for pharma compliance"
echo ""
echo "   cp ~/.claude/agents/market-researcher.md .claude/agents/"
echo "   vim .claude/agents/market-researcher.md"
echo "   # Add FDA compliance checks"
echo "   # This project now uses custom researcher, others use global"
echo ""
echo "Ready to use:"
echo "  /validate-market \"Your product idea\""
echo ""
echo "The system will:"
echo "  - Use global agents/skills/templates (unless overridden)"
echo "  - Save validation results to this project's specwright/market-validation/"
echo "  - Results are git-committable and project-specific"
echo ""

# Optional: Update project config.yml if it exists
if [[ -f specwright/config.yml ]]; then
    echo "Updating project config.yml..."

    # Check if market_validation section already exists
    if ! grep -q "market_validation:" specwright/config.yml; then
        cat >> specwright/config.yml << 'EOF'

# Market Validation Configuration (uses global installation)
market_validation:
  enabled: true

  # File lookup order (project-local first, then global fallback)
  lookup_order:
    - project  # Check specwright/ and .claude/ in project first
    - global   # Fallback to ~/.specwright/ and ~/.claude/

  # Override global decision criteria if needed (optional)
  # decision_criteria:
  #   conversion_rate_threshold: 5.0
  #   cpa_threshold: 10.0
  #   tam_threshold: 100000
EOF
        echo "✓ Added market_validation section to specwright/config.yml"
    else
        echo "✓ market_validation section already exists in config.yml"
    fi
else
    echo "⚠ No specwright/config.yml found (run base setup first if needed)"
fi

echo ""
echo "✅ Project setup complete!"
echo ""
echo "Global installation location:"
echo "  ~/.specwright/        (shared across all projects)"
echo "  ~/.claude/          (shared across all projects)"
echo ""
echo "This project's validation results:"
echo "  $(pwd)/specwright/market-validation/"
echo ""
echo "Start validating:"
echo "  /validate-market"
