#!/bin/bash

# Agent OS Extended - Rollback Script for Version 2.0 Migration
# Restores project to pre-migration state from backup

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
# Step 1: Find and Validate Backup
# ============================================
print_step "Step 1: Finding Backup"

# Find most recent backup
BACKUP_DIR=$(ls -dt .agent-os.backup-* 2>/dev/null | head -n 1)

if [ -z "$BACKUP_DIR" ]; then
    print_error "No backup directory found"
    echo "Backup directories should be named: .agent-os.backup-YYYY-MM-DD-HHMMSS"
    echo ""
    echo "Available directories:"
    ls -d .agent-os.backup-* 2>/dev/null || echo "  (none found)"
    exit 1
fi

print_success "Found backup: $BACKUP_DIR"

# Validate backup structure
print_step "Step 2: Validating Backup"

validation_passed=true

if [ ! -d "$BACKUP_DIR/.agent-os" ]; then
    print_error "Backup does not contain .agent-os directory"
    validation_passed=false
fi

if [ ! -f "$BACKUP_DIR/MANIFEST.txt" ]; then
    print_warning "Backup manifest not found (not critical)"
else
    print_success "Backup manifest found"
    echo ""
    echo "Backup details:"
    cat "$BACKUP_DIR/MANIFEST.txt" | head -5
    echo ""
fi

if [ "$validation_passed" = false ]; then
    print_error "Backup validation failed"
    exit 1
fi

print_success "Backup validation passed"

# ============================================
# Step 3: Confirm Rollback
# ============================================
print_step "Step 3: Confirm Rollback"

echo ""
print_warning "⚠️  WARNING: This will restore your project to its pre-migration state"
echo ""
echo "Current state will be REPLACED with:"
echo "  Backup: $BACKUP_DIR"
echo ""
echo "The following will happen:"
echo "  • agent-os/ will be REMOVED"
echo "  • .agent-os/ will be RESTORED from backup"
echo "  • .claude/commands/agent-os/ will be REMOVED"
echo "  • .claude/commands/ will be RESTORED from backup"
echo "  • CLAUDE.md will be RESTORED from backup (if exists)"
echo ""

if ! confirm "Continue with rollback?"; then
    echo "Rollback cancelled"
    exit 0
fi

# Check for uncommitted changes
if [ -d ".git" ]; then
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        print_warning "You have uncommitted changes in your git repository"
        if ! confirm "Continue rollback anyway?"; then
            echo "Rollback cancelled"
            echo "Please commit or stash your changes first"
            exit 0
        fi
    fi
fi

# ============================================
# Step 4: Remove v2.0 Structure
# ============================================
print_step "Step 4: Removing v2.0 Structure"

# Remove agent-os directory if exists
if [ -d "agent-os" ]; then
    rm -rf "agent-os"
    print_success "Removed agent-os/"
else
    print_warning "agent-os/ not found (already removed?)"
fi

# Remove .claude/commands/agent-os directory if exists
if [ -d ".claude/commands/agent-os" ]; then
    rm -rf ".claude/commands/agent-os"
    print_success "Removed .claude/commands/agent-os/"
else
    print_warning ".claude/commands/agent-os/ not found (already removed?)"
fi

# ============================================
# Step 5: Restore from Backup
# ============================================
print_step "Step 5: Restoring from Backup"

# Restore .agent-os directory
if [ -d "$BACKUP_DIR/.agent-os" ]; then
    cp -R "$BACKUP_DIR/.agent-os" "./"
    print_success "Restored .agent-os/"
else
    print_error "Backup does not contain .agent-os directory"
    exit 1
fi

# Restore .claude/commands directory
if [ -d "$BACKUP_DIR/.claude/commands" ]; then
    # Create .claude directory if it doesn't exist
    mkdir -p ".claude"

    # Remove current commands directory if exists
    if [ -d ".claude/commands" ]; then
        rm -rf ".claude/commands"
    fi

    # Restore from backup
    cp -R "$BACKUP_DIR/.claude/commands" ".claude/"
    print_success "Restored .claude/commands/"
else
    print_warning "Backup does not contain .claude/commands/ (skipping)"
fi

# Restore CLAUDE.md if exists in backup
if [ -f "$BACKUP_DIR/CLAUDE.md" ]; then
    cp "$BACKUP_DIR/CLAUDE.md" "./"
    print_success "Restored CLAUDE.md"
else
    print_warning "Backup does not contain CLAUDE.md (skipping)"
fi

# ============================================
# Step 6: Verification
# ============================================
print_step "Step 6: Verification"

verification_passed=true

# Verify .agent-os exists
if [ -d ".agent-os" ]; then
    print_success ".agent-os/ directory restored"
else
    print_error ".agent-os/ directory not found"
    verification_passed=false
fi

# Verify agent-os is removed
if [ ! -d "agent-os" ]; then
    print_success "agent-os/ directory removed"
else
    print_error "agent-os/ directory still exists"
    verification_passed=false
fi

# Verify .claude/commands/agent-os is removed
if [ ! -d ".claude/commands/agent-os" ]; then
    print_success ".claude/commands/agent-os/ removed"
else
    print_error ".claude/commands/agent-os/ still exists"
    verification_passed=false
fi

# ============================================
# Step 7: Summary
# ============================================
print_step "Rollback Summary"

echo ""
echo "======================================"
echo "Rollback Complete!"
echo "======================================"
echo ""
echo "Restoration performed:"
echo "  • Removed: agent-os/"
echo "  • Removed: .claude/commands/agent-os/"
echo "  • Restored: .agent-os/"
echo "  • Restored: .claude/commands/"
echo "  • Restored: CLAUDE.md (if existed)"
echo ""
echo "Backup used: $BACKUP_DIR"
echo ""

if [ "$verification_passed" = true ]; then
    print_success "All verification checks passed"
    echo ""
    echo "Your project has been restored to its pre-migration state"
    echo ""
    echo "Next steps:"
    echo "  1. Verify your commands work correctly"
    echo "  2. The backup directory is still available: $BACKUP_DIR"
    echo "  3. You can safely delete it after verification: rm -rf $BACKUP_DIR"
else
    print_error "Some verification checks failed"
    echo ""
    echo "Please review the warnings above"
    echo "You may need to manually check your project state"
fi

echo ""
