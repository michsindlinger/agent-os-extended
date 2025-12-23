#!/bin/bash

# Test suite for rollback-v2-migration.sh script
# Run this to verify rollback script functionality

# Don't exit on errors - we want to run all tests
set +e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$SCRIPT_DIR/test-projects"
PASS_COUNT=0
FAIL_COUNT=0

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_test() {
    echo -e "${YELLOW}TEST: $1${NC}"
}

assert_success() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ PASS: $1${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: $1${NC}"
        ((FAIL_COUNT++))
    fi
}

assert_dir_exists() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓ PASS: Directory exists: $1${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: Directory does not exist: $1${NC}"
        ((FAIL_COUNT++))
    fi
}

assert_dir_not_exists() {
    if [ ! -d "$1" ]; then
        echo -e "${GREEN}✓ PASS: Directory does not exist: $1${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: Directory still exists: $1${NC}"
        ((FAIL_COUNT++))
    fi
}

assert_file_exists() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓ PASS: File exists: $1${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: File does not exist: $1${NC}"
        ((FAIL_COUNT++))
    fi
}

# Setup test project with old structure
setup_old_structure() {
    local project_dir=$1

    mkdir -p "$project_dir/.agent-os/instructions/core"
    mkdir -p "$project_dir/.claude/commands"

    cat > "$project_dir/.agent-os/instructions/core/test.md" << 'EOF'
# Old Structure
@.agent-os/instructions/test
EOF

    cat > "$project_dir/.claude/commands/test.md" << 'EOF'
# Old Command
@.agent-os/instructions/core/test.md
EOF

    cat > "$project_dir/CLAUDE.md" << 'EOF'
# Old CLAUDE.md
@.agent-os/standards/test
EOF
}

# Cleanup test projects
cleanup_test_projects() {
    echo "Cleaning up test projects..."
    rm -rf "$TEST_DIR"
}

# Test Suite
echo "======================================"
echo "Rollback Script Test Suite"
echo "======================================"
echo ""

# Ensure rollback script exists
if [ ! -f "$SCRIPT_DIR/rollback-v2-migration.sh" ]; then
    echo -e "${RED}ERROR: rollback-v2-migration.sh not found${NC}"
    exit 1
fi

# Make scripts executable
chmod +x "$SCRIPT_DIR/update-to-v2.sh"
chmod +x "$SCRIPT_DIR/rollback-v2-migration.sh"

# Test 1: Rollback detects missing backup
print_test "Rollback detects when no backup exists"
rm -rf "$TEST_DIR/test-rollback-1"
mkdir -p "$TEST_DIR/test-rollback-1"
setup_old_structure "$TEST_DIR/test-rollback-1"
cd "$TEST_DIR/test-rollback-1"
if bash "$SCRIPT_DIR/rollback-v2-migration.sh" --yes 2>/dev/null; then
    echo -e "${RED}✗ FAIL: Should have failed with no backup${NC}"
    ((FAIL_COUNT++))
else
    echo -e "${GREEN}✓ PASS: Correctly detected missing backup${NC}"
    ((PASS_COUNT++))
fi
cd "$SCRIPT_DIR"

# Test 2: Complete migration and rollback cycle
print_test "Complete migration and rollback restores original state"
rm -rf "$TEST_DIR/test-rollback-2"
mkdir -p "$TEST_DIR/test-rollback-2"
setup_old_structure "$TEST_DIR/test-rollback-2"

# Initialize git
cd "$TEST_DIR/test-rollback-2"
git init -q
git add .
git commit -q -m "Initial commit"

# Take snapshot of original state
original_structure=$(find . -type f -o -type d | sort)

# Run migration
bash "$SCRIPT_DIR/update-to-v2.sh" --yes >/dev/null 2>&1

# Verify migration happened
assert_dir_exists "agent-os"
assert_dir_not_exists ".agent-os"

# Run rollback
bash "$SCRIPT_DIR/rollback-v2-migration.sh" --yes >/dev/null 2>&1

# Verify rollback
assert_dir_exists ".agent-os"
assert_dir_not_exists "agent-os"
assert_dir_exists ".agent-os/instructions"
assert_file_exists ".agent-os/instructions/core/test.md"
assert_file_exists ".claude/commands/test.md"
assert_file_exists "CLAUDE.md"

cd "$SCRIPT_DIR"

# Test 3: Rollback validates backup structure
print_test "Rollback validates backup structure"
rm -rf "$TEST_DIR/test-rollback-3"
mkdir -p "$TEST_DIR/test-rollback-3"
cd "$TEST_DIR/test-rollback-3"

# Create invalid backup
mkdir -p ".agent-os.backup-test"
echo "invalid" > ".agent-os.backup-test/MANIFEST.txt"
# Missing .agent-os directory in backup

if bash "$SCRIPT_DIR/rollback-v2-migration.sh" --yes 2>/dev/null; then
    echo -e "${RED}✗ FAIL: Should have failed with invalid backup${NC}"
    ((FAIL_COUNT++))
else
    echo -e "${GREEN}✓ PASS: Correctly detected invalid backup${NC}"
    ((PASS_COUNT++))
fi

cd "$SCRIPT_DIR"

# Test 4: Rollback preserves backup directory
print_test "Rollback preserves backup directory after restoration"
rm -rf "$TEST_DIR/test-rollback-4"
mkdir -p "$TEST_DIR/test-rollback-4"
setup_old_structure "$TEST_DIR/test-rollback-4"

cd "$TEST_DIR/test-rollback-4"
git init -q
git add .
git commit -q -m "Initial commit"

# Run migration and rollback
bash "$SCRIPT_DIR/update-to-v2.sh" --yes >/dev/null 2>&1
backup_dir=$(ls -d .agent-os.backup-* | head -n 1)
bash "$SCRIPT_DIR/rollback-v2-migration.sh" --yes >/dev/null 2>&1

# Verify backup still exists
if [ -d "$backup_dir" ]; then
    echo -e "${GREEN}✓ PASS: Backup directory preserved${NC}"
    ((PASS_COUNT++))
else
    echo -e "${RED}✗ FAIL: Backup directory was deleted${NC}"
    ((FAIL_COUNT++))
fi

cd "$SCRIPT_DIR"

# Test 5: Multiple backups - uses most recent
print_test "Rollback uses most recent backup when multiple exist"
rm -rf "$TEST_DIR/test-rollback-5"
mkdir -p "$TEST_DIR/test-rollback-5"
setup_old_structure "$TEST_DIR/test-rollback-5"

cd "$TEST_DIR/test-rollback-5"
git init -q
git add .
git commit -q -m "Initial commit"

# Create multiple backups
mkdir -p ".agent-os.backup-2025-01-01-000000/.agent-os"
echo "old backup" > ".agent-os.backup-2025-01-01-000000/.agent-os/test.txt"
sleep 1
mkdir -p ".agent-os.backup-2025-12-31-235959/.agent-os"
echo "recent backup" > ".agent-os.backup-2025-12-31-235959/.agent-os/test.txt"

# Create v2 structure to rollback from
mkdir -p "agent-os"

# Run rollback
bash "$SCRIPT_DIR/rollback-v2-migration.sh" --yes >/dev/null 2>&1

# Check which backup was used
if [ -f ".agent-os/test.txt" ]; then
    content=$(cat ".agent-os/test.txt")
    if [ "$content" = "recent backup" ]; then
        echo -e "${GREEN}✓ PASS: Used most recent backup${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: Used wrong backup${NC}"
        ((FAIL_COUNT++))
    fi
else
    echo -e "${RED}✗ FAIL: Backup not restored${NC}"
    ((FAIL_COUNT++))
fi

cd "$SCRIPT_DIR"

# Cleanup
cleanup_test_projects

# Summary
echo ""
echo "======================================"
echo "Test Summary"
echo "======================================"
echo -e "Passed: ${GREEN}$PASS_COUNT${NC}"
echo -e "Failed: ${RED}$FAIL_COUNT${NC}"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
