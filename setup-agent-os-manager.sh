#!/bin/bash

# Agent OS Manager - Installation Script
# Builds and installs the Agent OS Manager desktop application
# Version: 1.0

set -e

echo "========================================="
echo "Agent OS Manager - Installation"
echo "========================================="
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Darwin*)    PLATFORM="mac";;
    Linux*)     PLATFORM="linux";;
    MINGW*|MSYS*|CYGWIN*) PLATFORM="win";;
    *)          PLATFORM="unknown";;
esac

echo "Detected platform: ${PLATFORM}"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js not found"
    echo ""
    echo "Please install Node.js 22+ first:"
    echo "  https://nodejs.org/"
    echo ""
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Error: Node.js version too old (found: v$NODE_VERSION)"
    echo "Please install Node.js 18+ or newer"
    exit 1
fi

echo "✓ Node.js $(node -v) found"
echo ""

# Check if running from agent-os-extended repo
if [[ ! -d "agent-os-manager" ]]; then
    echo "❌ Error: agent-os-manager directory not found"
    echo ""
    echo "This script must be run from the agent-os-extended repository:"
    echo "  git clone https://github.com/michsindlinger/agent-os-extended.git"
    echo "  cd agent-os-extended"
    echo "  bash setup-agent-os-manager.sh"
    echo ""
    exit 1
fi

echo "✓ agent-os-manager directory found"
echo ""

# Navigate to agent-os-manager
cd agent-os-manager

# Install dependencies if needed
if [[ ! -d "node_modules" ]]; then
    echo "Installing dependencies..."
    npm install
    echo ""
fi

echo "✓ Dependencies installed"
echo ""

# Build the app
echo "Building Agent OS Manager..."
npm run build

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Build failed"
    echo "Check the output above for errors"
    exit 1
fi

echo ""
echo "✓ Build successful"
echo ""

# Package for platform
echo "Packaging for ${PLATFORM}..."

case "${PLATFORM}" in
    mac)
        npm run package:mac

        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Agent OS Manager packaged successfully!"
            echo ""
            echo "DMG created in:"
            echo "  $(pwd)/dist-electron/"
            echo ""

            # Find the DMG file
            DMG_FILE=$(find dist-electron -name "*.dmg" | head -1)

            if [[ -n "$DMG_FILE" ]]; then
                echo "To install:"
                echo "  1. Open: $DMG_FILE"
                echo "  2. Drag 'Agent OS Manager' to Applications folder"
                echo "  3. Launch from Applications"
                echo ""
                echo "Or install automatically:"
                echo "  open '$DMG_FILE'"
            fi
        else
            echo "❌ Packaging failed"
            exit 1
        fi
        ;;

    linux)
        npm run package:linux

        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Agent OS Manager packaged successfully!"
            echo ""

            APPIMAGE=$(find dist-electron -name "*.AppImage" | head -1)

            echo "AppImage created:"
            echo "  $APPIMAGE"
            echo ""
            echo "To run:"
            echo "  chmod +x '$APPIMAGE'"
            echo "  ./'$APPIMAGE'"
        fi
        ;;

    win)
        npm run package:win

        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Agent OS Manager packaged successfully!"
            echo ""

            EXE=$(find dist-electron -name "*.exe" | head -1)

            echo "Installer created:"
            echo "  $EXE"
            echo ""
            echo "Run the installer to install Agent OS Manager"
        fi
        ;;

    *)
        echo "❌ Unsupported platform: ${PLATFORM}"
        echo "Please build manually:"
        echo "  npm run package:mac    # macOS"
        echo "  npm run package:win    # Windows"
        echo "  npm run package:linux  # Linux"
        exit 1
        ;;
esac

echo ""
echo "Usage:"
echo "  1. Install the app (see instructions above)"
echo "  2. Open Agent OS Manager"
echo "  3. Navigate to your project directory"
echo "  4. Launch the app from there to see project-specific components"
echo ""
echo "Features:"
echo "  - Dashboard: View component counts and locations"
echo "  - Skills: Edit, override, revert skills with Monaco Editor"
echo "  - Agents: Manage specialist agents"
echo "  - Templates: Hierarchical template management"
echo "  - Config: Visual config editor + raw YAML mode"
echo "  - Dark/Light mode support"
echo ""
