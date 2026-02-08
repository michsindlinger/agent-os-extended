#!/bin/bash

# ============================================================================
# Kanban MCP Server Setup for Agent OS
# ============================================================================
#
# Installs the Kanban MCP Server globally to ~/.agent-os/scripts/mcp/
# and configures it in the project's .mcp.json file.
#
# The MCP server provides safe, atomic operations for kanban.json management,
# preventing race conditions and JSON corruption.
#
# Usage:
#   bash setup-mcp.sh
#
# ============================================================================

set -e  # Exit on error

echo "🔧 Installing Kanban MCP Server for Agent OS..."
echo ""

# Create global MCP scripts directory
MCP_DIR="$HOME/.agent-os/scripts/mcp"
mkdir -p "$MCP_DIR"

# Copy MCP server files to global location
echo "📦 Copying MCP server files to $MCP_DIR..."
cp agent-os/scripts/mcp/kanban-mcp-server.ts "$MCP_DIR/"
cp agent-os/scripts/mcp/kanban-lock.ts "$MCP_DIR/"
cp agent-os/scripts/mcp/story-parser.ts "$MCP_DIR/"
cp agent-os/scripts/mcp/item-templates.ts "$MCP_DIR/"
echo "   ✅ Files copied"
echo ""

# Create package.json for MCP server dependencies
echo "📦 Installing MCP SDK dependencies..."
cat > "$MCP_DIR/package.json" <<EOF
{
  "name": "kanban-mcp-server",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.4",
    "@anthropic-ai/sdk": "^0.32.0"
  }
}
EOF

# Install dependencies
cd "$MCP_DIR"
npm install --silent
cd - > /dev/null
echo "   ✅ Dependencies installed"
echo ""

# Configure .mcp.json
MCP_CONFIG=".mcp.json"

if [ -f "$MCP_CONFIG" ]; then
  echo "📝 Adding kanban MCP server to existing $MCP_CONFIG..."

  # Check if kanban server already exists
  if grep -q '"kanban"' "$MCP_CONFIG"; then
    echo "   ⚠️  Kanban MCP server already configured in $MCP_CONFIG"
    echo "   Skipping configuration update"
  else
    # Backup existing config
    cp "$MCP_CONFIG" "${MCP_CONFIG}.backup"

    # Add kanban server entry (basic merge - assumes mcpServers object exists)
    # For production, would use jq for proper JSON merging
    echo "   Note: Manual merge may be needed if .mcp.json has complex structure"
    echo "   Add this to your .mcp.json manually if auto-merge fails:"
    echo ""
    echo '   "kanban": {'
    echo '     "command": "npx",'
    echo '     "args": ["tsx", "'"$MCP_DIR"'/kanban-mcp-server.ts"]'
    echo '   }'
    echo ""
  fi
else
  echo "📝 Creating new $MCP_CONFIG..."
  cat > "$MCP_CONFIG" <<EOF
{
  "mcpServers": {
    "kanban": {
      "command": "npx",
      "args": ["tsx", "$MCP_DIR/kanban-mcp-server.ts"]
    }
  }
}
EOF
  echo "   ✅ $MCP_CONFIG created"
fi

echo ""
echo "✅ Kanban MCP Server installation complete!"
echo ""
echo "📖 What was installed:"
echo "   • MCP server: $MCP_DIR/kanban-mcp-server.ts"
echo "   • Lock utility: $MCP_DIR/kanban-lock.ts"
echo "   • Configuration: .mcp.json (or needs manual merge)"
echo ""
echo "🧪 Test the installation:"
echo "   echo '{\"jsonrpc\":\"2.0\",\"method\":\"tools/list\",\"id\":1}' | npx tsx $MCP_DIR/kanban-mcp-server.ts"
echo ""
echo "📚 The MCP server provides these tools for Claude CLI:"
echo "   • kanban_read - Read kanban state"
echo "   • kanban_create - Initialize kanban from story files"
echo "   • kanban_start_story - Mark story as in_progress"
echo "   • kanban_complete_story - Mark story as done"
echo "   • kanban_update_phase - Update execution phase"
echo "   • kanban_set_git_strategy - Set git strategy info"
echo ""
echo "🎯 Purpose: Prevents JSON corruption from race conditions when"
echo "   multiple Claude sessions or the web UI access kanban.json simultaneously."
echo ""
