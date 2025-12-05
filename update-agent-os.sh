#!/bin/bash

# Agent OS Extended - Update Script
# Updates existing Agent OS Extended installations with latest features

set -e

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"
FORCE_UPDATE=false
BACKUP_EXISTING=true

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --force)
            FORCE_UPDATE=true
            shift
            ;;
        --no-backup)
            BACKUP_EXISTING=false
            shift
            ;;
        -h|--help)
            echo "Agent OS Extended Update Script"
            echo ""
            echo "Updates existing Agent OS Extended installations with latest features."
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --force                    Force update even if files are newer"
            echo "  --no-backup               Skip creating backups of existing files"
            echo "  -h, --help                 Show this help message"
            echo ""
            echo "This script:"
            echo "- Detects existing Agent OS Extended installations"
            echo "- Backs up existing files (unless --no-backup specified)"
            echo "- Updates commands and instructions with latest versions"
            echo "- Creates any new directory structures needed"
            echo "- Preserves project-specific customizations"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

echo "🔄 Agent OS Extended - Update Script"
echo "Updating Agent OS Extended installation..."
echo ""

# Function to detect installation type
detect_installation() {
    if [[ -d ".agent-os" ]]; then
        echo "project-local"
    elif [[ -d "$HOME/.agent-os" ]]; then
        echo "global"
    else
        echo "none"
    fi
}

# Function to get base path
get_base_path() {
    local install_type=$1
    if [[ "$install_type" == "project-local" ]]; then
        echo "."
    elif [[ "$install_type" == "global" ]]; then
        echo "$HOME"
    fi
}

# Function to backup file
backup_file() {
    local file_path=$1
    local backup_suffix=".backup-$(date +%Y%m%d-%H%M%S)"
    
    if [[ -f "$file_path" && "$BACKUP_EXISTING" == true ]]; then
        echo "  Backing up existing $file_path"
        cp "$file_path" "${file_path}${backup_suffix}"
    fi
}

# Function to download file with update logic
update_file() {
    local url=$1
    local path=$2
    local description=$3
    
    if [[ -f "$path" ]]; then
        if [[ "$FORCE_UPDATE" == true ]]; then
            backup_file "$path"
            echo "  Force updating $description..."
            curl -sSL "$url" -o "$path"
        else
            # Check if remote file is different
            local temp_file=$(mktemp)
            curl -sSL "$url" -o "$temp_file"
            
            if ! cmp -s "$path" "$temp_file"; then
                backup_file "$path"
                echo "  Updating $description..."
                mv "$temp_file" "$path"
            else
                echo "  $description is up to date"
                rm "$temp_file"
            fi
        fi
    else
        echo "  Adding new $description..."
        curl -sSL "$url" -o "$path"
    fi
}

# Detect installation
INSTALL_TYPE=$(detect_installation)

if [[ "$INSTALL_TYPE" == "none" ]]; then
    echo "❌ No Agent OS Extended installation found!"
    echo ""
    echo "Please run the setup script first:"
    echo "  curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash"
    exit 1
fi

BASE_PATH=$(get_base_path "$INSTALL_TYPE")
AGENT_OS_PATH="$BASE_PATH/.agent-os"

echo "📍 Detected $INSTALL_TYPE installation at: $AGENT_OS_PATH"
echo ""

# Create backup directory if backing up
if [[ "$BACKUP_EXISTING" == true ]]; then
    BACKUP_DIR="$AGENT_OS_PATH/backups/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    echo "💾 Backups will be stored in: $BACKUP_DIR"
    echo ""
fi

# Create required directories
echo "📁 Ensuring directory structure..."
mkdir -p "$AGENT_OS_PATH/standards/code-style"
mkdir -p "$AGENT_OS_PATH/instructions/core"
mkdir -p "$AGENT_OS_PATH/instructions/meta"
mkdir -p "$AGENT_OS_PATH/specs"
mkdir -p "$AGENT_OS_PATH/docs"
mkdir -p "$AGENT_OS_PATH/bugs"
mkdir -p "$AGENT_OS_PATH/estimations/active"
mkdir -p "$AGENT_OS_PATH/estimations/completed"
mkdir -p "$AGENT_OS_PATH/estimations/history"
mkdir -p "$AGENT_OS_PATH/estimations/config"
mkdir -p "$AGENT_OS_PATH/estimations/reports"

# Update core instructions
echo ""
echo "📝 Updating instructions..."

# Get list of instruction files from the repository
instruction_files=(
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
    "execute-task.md"
    "execute-tasks.md"
    "plan-product.md"
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
)

for file in "${instruction_files[@]}"; do
    update_file "$REPO_URL/instructions/core/$file" \
                "$AGENT_OS_PATH/instructions/core/$file" \
                "instruction: $file"
done

# Update meta instructions
update_file "$REPO_URL/instructions/meta/pre-flight.md" \
            "$AGENT_OS_PATH/instructions/meta/pre-flight.md" \
            "meta instruction: pre-flight.md"

# Update commands for different AI tools
echo ""

# Check for Claude Code installation (.claude/commands/)
if [[ -d "$BASE_PATH/.claude/commands" || -f "$BASE_PATH/CLAUDE.md" || "$FORCE_UPDATE" == true ]]; then
    echo "🎯 Updating Claude Code commands..."
    
    mkdir -p "$BASE_PATH/.claude/commands"
    
    # Get list of command files
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
        "plan-gift-book.md"
        "init-base-setup.md"
        "validate-base-setup.md"
        "extend-setup.md"
        "create-daily-plan.md"
        "execute-daily-plan.md"
        "review-daily-work.md"
        "estimate-spec.md"
        "validate-estimation.md"
    )
    
    for file in "${command_files[@]}"; do
        update_file "$REPO_URL/commands/$file" \
                    "$BASE_PATH/.claude/commands/$file" \
                    "Claude Code command: $file"
    done

    # Update Claude Code agents
    echo ""
    echo "🤖 Updating Claude Code agents..."
    mkdir -p "$BASE_PATH/.claude/agents"

    agent_files=(
        "test-runner.md"
        "context-fetcher.md"
        "git-workflow.md"
        "file-creator.md"
        "date-checker.md"
        "estimation-specialist.md"
    )

    for file in "${agent_files[@]}"; do
        update_file "$REPO_URL/agents/$file" \
                    "$BASE_PATH/.claude/agents/$file" \
                    "Claude Code agent: $file"
    done
fi

# Check for legacy commands/ directory (for backward compatibility)
if [[ -d "$BASE_PATH/commands" ]]; then
    echo "🎯 Updating legacy commands..."

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
        "plan-gift-book.md"
        "init-base-setup.md"
        "validate-base-setup.md"
        "extend-setup.md"
        "create-daily-plan.md"
        "execute-daily-plan.md"
        "review-daily-work.md"
        "estimate-spec.md"
        "validate-estimation.md"
    )
    
    for file in "${command_files[@]}"; do
        update_file "$REPO_URL/commands/$file" \
                    "$BASE_PATH/commands/$file" \
                    "legacy command: $file"
    done
fi

# Check for Cursor installation (.cursor/rules/)
if [[ -d "$BASE_PATH/.cursor" || "$FORCE_UPDATE" == true ]]; then
    echo "🎯 Updating Cursor rules..."
    
    mkdir -p "$BASE_PATH/.cursor/rules"
    
    # Note: Cursor uses .mdc format, but we'll provide .md files for now
    # Users can convert them if needed
    cursor_files=(
        "create-spec.md"
        "update-feature.md"
        "document-feature.md"
        "retroactive-doc.md"
        "update-changelog.md"
        "execute-tasks.md"
    )
    
    for file in "${cursor_files[@]}"; do
        update_file "$REPO_URL/commands/$file" \
                    "$BASE_PATH/.cursor/rules/$file" \
                    "Cursor rule: $file"
    done
fi

# Check for Gemini CLI installation (.gemini/tools/)
if [[ -d "$BASE_PATH/.gemini/tools" || -f "$BASE_PATH/GEMINI.md" || "$FORCE_UPDATE" == true ]]; then
    echo "🎯 Updating Gemini CLI tools..."
    
    mkdir -p "$BASE_PATH/.gemini/tools"
    mkdir -p "$BASE_PATH/.gemini/workflows"
    
    # Function to create/update Gemini tool file
    update_gemini_tool() {
        local source_url=$1
        local tool_name=$2
        local target_file="$BASE_PATH/.gemini/tools/${tool_name}.md"
        local temp_file=$(mktemp)
        local source_temp=$(mktemp)
        
        # Download source content
        curl -sSL "$source_url" -o "$source_temp"
        
        # Create tool file with header
        echo "# $tool_name Tool" > "$temp_file"
        echo "" >> "$temp_file"
        echo "This tool provides Agent OS Extended functionality for $tool_name." >> "$temp_file"
        echo "" >> "$temp_file"
        echo "## Instructions" >> "$temp_file"
        echo "" >> "$temp_file"
        cat "$source_temp" >> "$temp_file"
        
        # Update using standard update logic
        if [[ -f "$target_file" ]]; then
            if [[ "$FORCE_UPDATE" == true ]]; then
                backup_file "$target_file"
                echo "  Force updating Gemini tool: $tool_name..."
                mv "$temp_file" "$target_file"
            else
                if ! cmp -s "$target_file" "$temp_file"; then
                    backup_file "$target_file"
                    echo "  Updating Gemini tool: $tool_name..."
                    mv "$temp_file" "$target_file"
                else
                    echo "  Gemini tool $tool_name is up to date"
                    rm "$temp_file"
                fi
            fi
        else
            echo "  Adding new Gemini tool: $tool_name..."
            mv "$temp_file" "$target_file"
        fi
        
        rm -f "$source_temp"
    }
    
    # Update all Gemini tools
    gemini_tools=(
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
        "plan-gift-book"
        "init-base-setup"
        "validate-base-setup"
        "extend-setup"
        "create-daily-plan"
        "execute-daily-plan"
        "review-daily-work"
        "estimate-spec"
        "validate-estimation"
    )
    
    for tool in "${gemini_tools[@]}"; do
        update_gemini_tool "$REPO_URL/commands/${tool}.md" "$tool"
    done
fi

# Update standards
echo ""
echo "📚 Updating standards..."

standard_files=(
    "tech-stack.md"
    "code-style.md"
    "best-practices.md"
    "code-style/javascript-style.md"
    "code-style/css-style.md"
    "code-style/html-style.md"
)

for file in "${standard_files[@]}"; do
    update_file "$REPO_URL/standards/$file" \
                "$AGENT_OS_PATH/standards/$file" \
                "standard: $file"
done

# Update Estimation System Config Files
echo ""
echo "📊 Updating Estimation System configuration..."

# Create estimation config files if they don't exist
if [[ ! -f "$AGENT_OS_PATH/estimations/config/industry-benchmarks.json" ]]; then
    echo "  Creating industry-benchmarks.json..."
    curl -sSL "$REPO_URL/test-project/.agent-os/estimations/config/industry-benchmarks.json" \
         -o "$AGENT_OS_PATH/estimations/config/industry-benchmarks.json"
else
    echo "  industry-benchmarks.json exists - preserving project-specific benchmarks"
    echo "  💡 Check test-project/.agent-os/estimations/config/industry-benchmarks.json for latest template"
fi

if [[ ! -f "$AGENT_OS_PATH/estimations/config/estimation-config.json" ]]; then
    echo "  Creating estimation-config.json..."
    curl -sSL "$REPO_URL/test-project/.agent-os/estimations/config/estimation-config.json" \
         -o "$AGENT_OS_PATH/estimations/config/estimation-config.json"
else
    echo "  estimation-config.json exists - preserving team-specific configuration"
    echo "  💡 Check test-project/.agent-os/estimations/config/estimation-config.json for latest template"
fi

if [[ ! -f "$AGENT_OS_PATH/estimations/history/index.json" ]]; then
    echo "  Creating history/index.json..."
    curl -sSL "$REPO_URL/test-project/.agent-os/estimations/history/index.json" \
         -o "$AGENT_OS_PATH/estimations/history/index.json"
fi

if [[ ! -f "$AGENT_OS_PATH/estimations/README.md" ]]; then
    echo "  Creating Estimation System README..."
    curl -sSL "$REPO_URL/test-project/.agent-os/estimations/README.md" \
         -o "$AGENT_OS_PATH/estimations/README.md"
else
    # Always update README as it's documentation, not configuration
    update_file "$REPO_URL/test-project/.agent-os/estimations/README.md" \
                "$AGENT_OS_PATH/estimations/README.md" \
                "Estimation System README"
fi

# Create .gitkeep files for empty directories
touch "$AGENT_OS_PATH/estimations/active/.gitkeep"
touch "$AGENT_OS_PATH/estimations/completed/.gitkeep"
touch "$AGENT_OS_PATH/estimations/reports/.gitkeep"

# Handle CLAUDE.md template update
echo ""
echo "📋 Checking CLAUDE.md template..."

if [[ -f "$BASE_PATH/CLAUDE.md" ]]; then
    # Always create/update template for reference
    update_file "$REPO_URL/CLAUDE.md" \
                "$BASE_PATH/CLAUDE.md.template" \
                "CLAUDE.md template"
    echo "  💡 Check CLAUDE.md.template for latest configuration options"
else
    # Create CLAUDE.md from template if it doesn't exist
    update_file "$REPO_URL/CLAUDE.md" \
                "$BASE_PATH/CLAUDE.md" \
                "CLAUDE.md"
    echo "  📝 Please customize CLAUDE.md with your project-specific information"
fi

# Handle GEMINI.md context file update
if [[ -d "$BASE_PATH/.gemini" || -f "$BASE_PATH/GEMINI.md" ]]; then
    echo ""
    echo "📋 Checking GEMINI.md context file..."
    
    if [[ -f "$BASE_PATH/GEMINI.md" ]]; then
        echo "  GEMINI.md already exists - context file is project-specific"
        echo "  💡 Refer to setup-gemini.sh for latest template if needed"
    else
        echo "  Creating GEMINI.md context file..."
        cat > "$BASE_PATH/GEMINI.md" << 'EOF'
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
- **Effort Estimation**: estimate-spec, validate-estimation

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
        echo "  📝 Please customize GEMINI.md with your project-specific information"
    fi
fi

# Clean up old backup files (keep only last 5)
if [[ "$BACKUP_EXISTING" == true && -d "$AGENT_OS_PATH/backups" ]]; then
    echo ""
    echo "🧹 Cleaning up old backups (keeping last 5)..."
    cd "$AGENT_OS_PATH/backups"
    ls -1t | tail -n +6 | xargs -r rm -rf
    cd - > /dev/null
fi

echo ""
echo "✅ Agent OS Extended update complete!"
echo ""
echo "📁 Directory structure ensured:"
echo "  • .agent-os/instructions/ - Core workflow instructions"
echo "  • .agent-os/standards/    - Development standards"
echo "  • .agent-os/specs/        - Feature specifications"
echo "  • .agent-os/docs/         - Feature documentation"
echo "  • .agent-os/bugs/         - Bug tracking and resolution"
echo "  • .agent-os/estimations/  - Effort estimation system"
echo "    - active/               - Active estimations"
echo "    - completed/            - Completed with actual data"
echo "    - history/              - Historical database"
echo "    - config/               - Configuration files"
echo "    - reports/              - Accuracy reports"

if [[ -d "$BASE_PATH/.claude" ]]; then
    echo "  • .claude/commands/       - Claude Code commands"
    echo "  • .claude/agents/         - Claude Code agents"
fi

if [[ -d "$BASE_PATH/.cursor" ]]; then
    echo "  • .cursor/rules/          - Cursor AI rules"
fi

if [[ -d "$BASE_PATH/.gemini" ]]; then
    echo "  • .gemini/tools/          - Gemini CLI tools"
    echo "  • .gemini/workflows/      - Gemini CLI workflows"
fi
echo ""
if [[ "$BACKUP_EXISTING" == true ]]; then
    echo "💾 Backups stored in: $BACKUP_DIR"
    echo ""
fi
echo "🚀 Your Agent OS Extended installation is now up to date!"
echo ""
echo "For more information, visit: https://github.com/michsindlinger/agent-os-extended"