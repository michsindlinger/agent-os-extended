#!/bin/bash

# Agent OS Extended - Cursor Project-level Setup
# Installs Cursor specific Agent OS files in the current project

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "🤖 Agent OS Extended - Cursor Setup"
echo "Installing Cursor configuration in current project..."
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

# Create Cursor specific directory
echo "Creating Cursor directory..."
mkdir -p .cursor/rules

# Function to create MDC file with front matter
create_mdc_file() {
    local source_file=$1
    local target_file=$2
    local temp_file=$(mktemp)
    
    echo "Creating $target_file..."
    
    # Add front matter
    echo "---" > "$temp_file"
    echo "alwaysApply: false" >> "$temp_file"
    echo "---" >> "$temp_file"
    echo "" >> "$temp_file"
    
    # Download and append content
    curl -sSL "$source_file" >> "$temp_file"
    
    # Move to final location
    mv "$temp_file" "$target_file"
}

# Create Cursor rule files
echo ""
echo "Setting up Cursor rules..."
create_mdc_file "$REPO_URL/commands/plan-product.md" ".cursor/rules/plan-product.mdc"
create_mdc_file "$REPO_URL/commands/plan-b2b-application.md" ".cursor/rules/plan-b2b-application.mdc"
create_mdc_file "$REPO_URL/commands/create-spec.md" ".cursor/rules/create-spec.mdc"
create_mdc_file "$REPO_URL/commands/execute-tasks.md" ".cursor/rules/execute-tasks.mdc"
create_mdc_file "$REPO_URL/commands/analyze-product.md" ".cursor/rules/analyze-product.mdc"
create_mdc_file "$REPO_URL/commands/analyze-b2b-application.md" ".cursor/rules/analyze-b2b-application.mdc"

echo ""
echo "✅ Cursor setup complete!"
echo ""
echo "Project structure created:"
echo "  .cursor/rules/      - Cursor Agent OS rules"
echo ""
echo "Available Cursor commands:"
echo "  @plan-product         - Plan your product roadmap"
echo "  @plan-b2b-application - Plan B2B enterprise application"
echo "  @create-spec          - Create feature specifications"
echo "  @execute-tasks        - Execute development tasks"
echo "  @analyze-product      - Analyze product requirements"
echo "  @analyze-b2b-application - Analyze B2B enterprise application"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"