#!/bin/bash

# Agent OS Extended - Gemini CLI Project-level Setup
# Installs Gemini CLI specific Agent OS files in the current project

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

echo "🤖 Agent OS Extended - Gemini CLI Setup"
echo "Installing Gemini CLI configuration in current project..."
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

# Create Gemini CLI specific directories
echo "Creating Gemini CLI directories..."
mkdir -p .gemini/tools
mkdir -p .gemini/workflows

# Function to download file
download_file() {
    local url=$1
    local path=$2
    
    echo "Downloading $path..."
    curl -sSL "$url" -o "$path"
}

# Function to create Gemini tool file from command
create_gemini_tool() {
    local source_file=$1
    local tool_name=$2
    local target_file=".gemini/tools/${tool_name}.md"
    local temp_file=$(mktemp)
    
    echo "Creating Gemini tool: $tool_name..."
    
    # Add Gemini-specific header
    echo "# $tool_name Tool" > "$temp_file"
    echo "" >> "$temp_file"
    echo "This tool provides Agent OS Extended functionality for $tool_name." >> "$temp_file"
    echo "" >> "$temp_file"
    echo "## Instructions" >> "$temp_file"
    echo "" >> "$temp_file"
    
    # Download and append content
    curl -sSL "$source_file" >> "$temp_file"
    
    # Move to final location
    mv "$temp_file" "$target_file"
}

# Create Gemini tools from commands
echo ""
echo "Setting up Gemini tools..."
tool_files=(
    "analyze-product"
    "analyze-b2b-application"
    "start-brainstorming"
    "transfer-and-create-spec"
    "transfer-and-create-bug"
    "transfer-and-plan-product"
    "create-spec"
    "create-bug"
    "execute-bug"
    "update-feature"
    "document-feature"
    "retroactive-doc"
    "update-changelog"
    "execute-tasks"
    "plan-product"
    "plan-b2b-application"
    "init-base-setup"
    "validate-base-setup"
    "extend-setup"
    "create-daily-plan"
    "execute-daily-plan"
    "review-daily-work"
)

for tool in "${tool_files[@]}"; do
    create_gemini_tool "$REPO_URL/commands/${tool}.md" "$tool"
done

# Create GEMINI.md context file
echo ""
echo "Setting up GEMINI.md context file..."
if [[ -f "GEMINI.md" ]]; then
    echo "GEMINI.md already exists - creating GEMINI.md.template for reference"
    cat > "GEMINI.md.template" << 'EOF'
# Agent OS Extended - Gemini CLI Context

This project uses Agent OS Extended for structured AI development workflows.

## Available Tools

Use the tools in `.gemini/tools/` to execute Agent OS Extended workflows:

- **Product Planning**: analyze-product, plan-product, plan-b2b-application
- **Feature Development**: create-spec, update-feature, document-feature
- **Bug Management**: create-bug, execute-bug
- **Brainstorming**: start-brainstorming, transfer-and-*
- **Project Setup**: init-base-setup, validate-base-setup, extend-setup
- **Documentation**: retroactive-doc, update-changelog
- **Task Execution**: execute-tasks
- **Daily Work Management**: create-daily-plan, execute-daily-plan, review-daily-work

## Project Standards

Refer to `.agent-os/standards/` for:
- Tech stack preferences
- Code style guidelines
- Best practices philosophy

## Instructions

Detailed workflow instructions are available in `.agent-os/instructions/core/`

## Usage

To use these tools with Gemini CLI, reference them in your conversations:
- "Use the create-spec tool to create a feature specification"
- "Follow the standards in .agent-os/standards/ for this implementation"

EOF
    echo "💡 Consider merging GEMINI.md.template into your existing GEMINI.md"
else
    echo "Creating GEMINI.md from template..."
    cat > "GEMINI.md" << 'EOF'
# Agent OS Extended - Gemini CLI Context

This project uses Agent OS Extended for structured AI development workflows.

## Available Tools

Use the tools in `.gemini/tools/` to execute Agent OS Extended workflows:

- **Product Planning**: analyze-product, plan-product, plan-b2b-application
- **Feature Development**: create-spec, update-feature, document-feature
- **Bug Management**: create-bug, execute-bug
- **Brainstorming**: start-brainstorming, transfer-and-*
- **Project Setup**: init-base-setup, validate-base-setup, extend-setup
- **Documentation**: retroactive-doc, update-changelog
- **Task Execution**: execute-tasks
- **Daily Work Management**: create-daily-plan, execute-daily-plan, review-daily-work

## Project Standards

Refer to `.agent-os/standards/` for:
- Tech stack preferences
- Code style guidelines
- Best practices philosophy

## Instructions

Detailed workflow instructions are available in `.agent-os/instructions/core/`

## Usage

To use these tools with Gemini CLI, reference them in your conversations:
- "Use the create-spec tool to create a feature specification"
- "Follow the standards in .agent-os/standards/ for this implementation"

EOF
    echo "📝 Please customize GEMINI.md with your project-specific information"
fi

echo ""
echo "✅ Gemini CLI setup complete!"
echo ""
echo "Project structure created:"
echo "  .gemini/tools/        - Agent OS Extended tools for Gemini CLI"
echo "  .gemini/workflows/    - Custom workflows (empty, ready for your additions)"
echo "  GEMINI.md             - Context file for Gemini CLI"
echo ""
echo "Available tools:"
echo "  analyze-product       - Analyze product requirements"
echo "  analyze-b2b-application - Analyze B2B enterprise application"
echo "  start-brainstorming   - Start collaborative brainstorming sessions"
echo "  transfer-and-create-spec - Transfer brainstorming to feature spec"
echo "  transfer-and-create-bug  - Transfer brainstorming to bug report"
echo "  transfer-and-plan-product - Transfer brainstorming to product plan"
echo "  create-spec           - Create feature specifications"
echo "  create-bug            - Create bug reports"
echo "  execute-bug           - Execute bug fixes"
echo "  update-feature        - Update existing features"
echo "  document-feature      - Document completed features"
echo "  retroactive-doc       - Document existing features"
echo "  update-changelog      - Update project changelog"
echo "  execute-tasks         - Execute development tasks"
echo "  plan-product          - Plan your product roadmap"
echo "  plan-b2b-application  - Plan B2B enterprise application"
echo "  init-base-setup       - Initialize base project setup"
echo "  validate-base-setup   - Validate base setup configuration"
echo "  extend-setup          - Extend setup with additional features"
echo ""
echo "Usage with Gemini CLI:"
echo "  'Use the create-spec tool to create a feature specification'"
echo "  'Follow the standards in .agent-os/standards/ for this code'"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"