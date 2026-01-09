#!/bin/bash

# Agent OS DevTeam System - Global Standards Installation
# Installs global code standards to ~/.agent-os/standards/ as fallback for all projects
# Version: 2.1

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "========================================="
echo "Agent OS DevTeam - Global Standards Setup"
echo "========================================="
echo ""
echo "This installs global coding standards to ~/.agent-os/standards/"
echo "These serve as fallback when projects don't have custom standards."
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
    echo "✓ Downloaded: $(basename $dest)"
}

# Global installation directory
GLOBAL_STANDARDS_DIR="$HOME/.agent-os/standards"

echo "Installing to: $GLOBAL_STANDARDS_DIR"
echo ""

# Create directory if it doesn't exist
mkdir -p "$GLOBAL_STANDARDS_DIR"

# Download global standards
echo "Downloading global coding standards..."
echo ""

download_file "$REPO_URL/agent-os/standards/code-style.md" \
  "$GLOBAL_STANDARDS_DIR/code-style.md" "global code-style"

download_file "$REPO_URL/agent-os/standards/best-practices.md" \
  "$GLOBAL_STANDARDS_DIR/best-practices.md" "global best-practices"

download_file "$REPO_URL/agent-os/standards/tech-stack.md" \
  "$GLOBAL_STANDARDS_DIR/tech-stack.md" "global tech-stack template"

echo ""
echo "✅ Global standards installed!"
echo ""
echo "Installed to:"
echo "  $GLOBAL_STANDARDS_DIR/"
echo "    ├── code-style.md           - Universal code style guidelines"
echo "    ├── best-practices.md       - Universal development best practices"
echo "    └── tech-stack.md           - Tech stack template"
echo ""
echo "How it works:"
echo ""
echo "  📚 Hybrid Standards System:"
echo ""
echo "  1. Global (fallback for all projects):"
echo "     ~/.agent-os/standards/code-style.md"
echo "     ~/.agent-os/standards/best-practices.md"
echo ""
echo "  2. Project-specific (optional, created in /plan-product):"
echo "     .agent-os/standards/code-style.md"
echo "     .agent-os/standards/best-practices.md"
echo ""
echo "  3. Lookup order:"
echo "     - First: Check project .agent-os/standards/"
echo "     - Fallback: Use global ~/.agent-os/standards/"
echo ""
echo "Benefits:"
echo "  ✅ Consistent standards across all projects (global)"
echo "  ✅ Customize per project when needed (override)"
echo "  ✅ Tech-stack aware standards (when generated in /plan-product)"
echo "  ✅ No setup required - global fallback always available"
echo ""
echo "Project Standards Generation:"
echo ""
echo "  When running /plan-product, you'll be asked:"
echo "  \"Generate project-specific code standards? (yes/no)\""
echo ""
echo "  If YES:"
echo "    → tech-architect generates .agent-os/standards/"
echo "    → Standards are tech-stack aware (Rails, React, etc.)"
echo "    → Project standards override global"
echo ""
echo "  If NO:"
echo "    → Uses global standards from ~/.agent-os/standards/"
echo "    → Faster setup, consistent across projects"
echo ""
echo "Next steps:"
echo ""
echo "  1. For project setup, run:"
echo "     curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash"
echo ""
echo "  2. Then for Claude Code:"
echo "     curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash"
echo ""
echo "  3. Start planning your product:"
echo "     /plan-product"
echo "     → Will ask about generating project-specific standards"
echo ""
echo "  4. Build your DevTeam:"
echo "     /build-development-team"
echo "     → Uses standards (project or global)"
echo ""
echo "For more information:"
echo "  https://github.com/michsindlinger/agent-os-extended"
echo ""
