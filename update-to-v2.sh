#!/bin/bash

# Agent OS Extended - Migration Script to Version 2.0
# Migrates existing Agent OS Extended installations to v2.0 structure

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)
BACKUP_DIR=".agent-os.backup-$TIMESTAMP"
AUTO_YES=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --yes|-y)
            AUTO_YES=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--yes]"
            exit 1
            ;;
    esac
done

# Helper functions
print_step() {
    echo -e "\n${BLUE}==> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

confirm() {
    if [ "$AUTO_YES" = true ]; then
        return 0
    fi

    local message=$1
    echo -e "${YELLOW}$message (y/n)${NC}"
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# ============================================
# Step 1: Pre-flight Checks
# ============================================
print_step "Step 1: Pre-flight Checks"

# Check if .agent-os exists
if [ ! -d ".agent-os" ]; then
    print_error "No .agent-os directory found in current directory"
    echo "This script must be run from a project root with Agent OS Extended installed"
    exit 1
fi

print_success "Found .agent-os directory"

# Check if already migrated
if [ -d "agent-os" ]; then
    print_warning "Found agent-os directory - this project may already be migrated"
    if ! confirm "Continue anyway?"; then
        echo "Migration cancelled"
        exit 0
    fi
fi

# Check for git repository
if [ -d ".git" ]; then
    print_success "Git repository detected"

    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        print_warning "You have uncommitted changes in your git repository"
        if ! confirm "Continue migration anyway?"; then
            echo "Migration cancelled"
            echo "Please commit or stash your changes first"
            exit 0
        fi
    else
        print_success "No uncommitted changes detected"
    fi
else
    print_warning "No git repository detected - proceeding without version control"
fi

# Check if backup already exists
if [ -d "$BACKUP_DIR" ]; then
    print_error "Backup directory already exists: $BACKUP_DIR"
    exit 1
fi

print_success "Pre-flight checks complete"

# ============================================
# Step 2: Create Backup
# ============================================
print_step "Step 2: Creating Backup"

echo "Creating backup at: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Copy .agent-os directory
if [ -d ".agent-os" ]; then
    cp -R ".agent-os" "$BACKUP_DIR/"
    print_success "Backed up .agent-os/"
fi

# Copy .claude/commands directory
if [ -d ".claude/commands" ]; then
    mkdir -p "$BACKUP_DIR/.claude"
    cp -R ".claude/commands" "$BACKUP_DIR/.claude/"
    print_success "Backed up .claude/commands/"
fi

# Copy CLAUDE.md if exists
if [ -f "CLAUDE.md" ]; then
    cp "CLAUDE.md" "$BACKUP_DIR/"
    print_success "Backed up CLAUDE.md"
fi

# Create backup manifest
cat > "$BACKUP_DIR/MANIFEST.txt" << EOF
Agent OS Extended - Backup Manifest
Created: $TIMESTAMP
Original Location: $(pwd)

Backed up:
- .agent-os/ directory
- .claude/commands/ directory
- CLAUDE.md (if exists)

To restore from this backup, run:
  bash rollback-v2-migration.sh
EOF

print_success "Backup created successfully: $BACKUP_DIR"

# ============================================
# Step 3: Directory Renaming
# ============================================
print_step "Step 3: Renaming Directories"

# Rename .agent-os to agent-os
if [ -d ".agent-os" ] && [ ! -d "agent-os" ]; then
    mv ".agent-os" "agent-os"
    print_success "Renamed .agent-os → agent-os"
elif [ -d "agent-os" ]; then
    print_warning "agent-os already exists, skipping rename"
else
    print_error "Could not rename .agent-os"
    exit 1
fi

# ============================================
# Step 4: Rename workflows directory
# ============================================
print_step "Step 4: Renaming instructions → workflows"

if [ -d "agent-os/instructions" ]; then
    mv "agent-os/instructions" "agent-os/workflows"
    print_success "Renamed agent-os/instructions → agent-os/workflows"
elif [ -d "agent-os/workflows" ]; then
    print_warning "agent-os/workflows already exists, skipping rename"
else
    print_warning "No instructions directory found, skipping"
fi

# ============================================
# Step 5: Command Isolation
# ============================================
print_step "Step 5: Isolating Commands"

# Create .claude/commands/agent-os directory
if [ ! -d ".claude/commands/agent-os" ]; then
    mkdir -p ".claude/commands/agent-os"
    print_success "Created .claude/commands/agent-os/"
fi

# Move all .md files from .claude/commands/ to .claude/commands/agent-os/
if [ -d ".claude/commands" ]; then
    # Count files to move
    file_count=$(find ".claude/commands" -maxdepth 1 -name "*.md" -type f | wc -l | tr -d ' ')

    if [ "$file_count" -gt 0 ]; then
        # Move files
        find ".claude/commands" -maxdepth 1 -name "*.md" -type f -exec mv {} ".claude/commands/agent-os/" \;
        print_success "Moved $file_count command files to agent-os/ subdirectory"
    else
        print_warning "No command files found to move"
    fi
fi

# ============================================
# Step 6: Update References
# ============================================
print_step "Step 6: Updating References"

# Function to update references in a file
update_references() {
    local file=$1
    local updated=false

    # Update @.agent-os/ → @agent-os/
    if grep -q "@\.agent-os/" "$file" 2>/dev/null; then
        sed -i.bak 's/@\.agent-os\//@agent-os\//g' "$file"
        updated=true
    fi

    # Update instructions/ → workflows/ (in context of agent-os paths)
    if grep -q "agent-os/instructions/" "$file" 2>/dev/null; then
        sed -i.bak 's/agent-os\/instructions\//agent-os\/workflows\//g' "$file"
        updated=true
    fi

    # Update @.agent-os/instructions/ → @agent-os/workflows/
    if grep -q "@agent-os/instructions/" "$file" 2>/dev/null; then
        sed -i.bak 's/@agent-os\/instructions\//@agent-os\/workflows\//g' "$file"
        updated=true
    fi

    # Remove backup file if it exists
    if [ -f "${file}.bak" ]; then
        rm "${file}.bak"
    fi

    if [ "$updated" = true ]; then
        return 0
    else
        return 1
    fi
}

# Update references in all workflow files
if [ -d "agent-os/workflows" ]; then
    updated_count=0
    while IFS= read -r -d '' file; do
        if update_references "$file"; then
            ((updated_count++))
        fi
    done < <(find "agent-os/workflows" -type f -name "*.md" -print0)

    if [ $updated_count -gt 0 ]; then
        print_success "Updated references in $updated_count workflow files"
    fi
fi

# Update references in command files
if [ -d ".claude/commands/agent-os" ]; then
    updated_count=0
    while IFS= read -r -d '' file; do
        if update_references "$file"; then
            ((updated_count++))
        fi
    done < <(find ".claude/commands/agent-os" -type f -name "*.md" -print0)

    if [ $updated_count -gt 0 ]; then
        print_success "Updated references in $updated_count command files"
    fi
fi

# Update CLAUDE.md if exists
if [ -f "CLAUDE.md" ]; then
    if update_references "CLAUDE.md"; then
        print_success "Updated references in CLAUDE.md"
    fi
fi

# Update README.md if exists
if [ -f "README.md" ]; then
    if update_references "README.md"; then
        print_success "Updated references in README.md"
    fi
fi

# ============================================
# Step 7: Verification
# ============================================
print_step "Step 7: Verification"

verification_passed=true

# Verify agent-os exists
if [ -d "agent-os" ]; then
    print_success "agent-os/ directory exists"
else
    print_error "agent-os/ directory not found"
    verification_passed=false
fi

# Verify workflows exists
if [ -d "agent-os/workflows" ]; then
    print_success "agent-os/workflows/ directory exists"
else
    print_error "agent-os/workflows/ directory not found"
    verification_passed=false
fi

# Verify commands are isolated
if [ -d ".claude/commands/agent-os" ]; then
    print_success ".claude/commands/agent-os/ directory exists"
else
    print_error ".claude/commands/agent-os/ directory not found"
    verification_passed=false
fi

# Verify old directory is gone
if [ ! -d ".agent-os" ]; then
    print_success ".agent-os/ directory removed"
else
    print_warning ".agent-os/ directory still exists"
fi

# Check for old references
old_refs_found=false

if grep -r "@\.agent-os/" agent-os/ 2>/dev/null | grep -v ".backup-" | grep -q .; then
    print_warning "Found remaining @.agent-os/ references"
    old_refs_found=true
fi

if grep -r "instructions/" agent-os/ 2>/dev/null | grep -v ".backup-" | grep -q .; then
    print_warning "Found remaining instructions/ references"
    old_refs_found=true
fi

if [ "$old_refs_found" = false ]; then
    print_success "No old references found"
fi

# ============================================
# Step 8: Summary
# ============================================
print_step "Migration Summary"

echo ""
echo "======================================"
echo "Migration Complete!"
echo "======================================"
echo ""
echo "Changes made:"
echo "  • Renamed: .agent-os → agent-os"
echo "  • Renamed: agent-os/instructions → agent-os/workflows"
echo "  • Moved commands to: .claude/commands/agent-os/"
echo "  • Updated all references in files"
echo ""
echo "Backup created at: $BACKUP_DIR"
echo ""

if [ "$verification_passed" = true ]; then
    print_success "All verification checks passed"
    echo ""
    echo "Next steps:"
    echo "  1. Test your commands to ensure everything works"
    echo "  2. Commit the changes to git"
    echo "  3. If issues occur, run: bash rollback-v2-migration.sh"
    echo ""
    echo "To remove the backup after confirming everything works:"
    echo "  rm -rf $BACKUP_DIR"
else
    print_error "Some verification checks failed"
    echo ""
    echo "Please review the warnings above"
    echo "To rollback: bash rollback-v2-migration.sh"
fi

echo ""
