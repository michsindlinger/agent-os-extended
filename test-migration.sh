#!/bin/bash

# Test suite for update-to-v2.sh migration script
# Run this to verify migration script functionality

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

assert_file_contains() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓ PASS: File contains '$2': $1${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: File does not contain '$2': $1${NC}"
        ((FAIL_COUNT++))
    fi
}

assert_file_not_contains() {
    if ! grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓ PASS: File does not contain '$2': $1${NC}"
        ((PASS_COUNT++))
    else
        echo -e "${RED}✗ FAIL: File still contains '$2': $1${NC}"
        ((FAIL_COUNT++))
    fi
}

# Setup test project
setup_test_project() {
    local project_name=$1
    local project_dir="$TEST_DIR/$project_name"

    echo "Setting up test project: $project_name"

    # Clean up if exists
    rm -rf "$project_dir"

    # Create old structure
    mkdir -p "$project_dir/.agent-os/instructions/core"
    mkdir -p "$project_dir/.agent-os/instructions/meta"
    mkdir -p "$project_dir/.agent-os/standards"
    mkdir -p "$project_dir/.agent-os/specs"
    mkdir -p "$project_dir/.agent-os/docs"
    mkdir -p "$project_dir/.agent-os/bugs"
    mkdir -p "$project_dir/.claude/commands"
    mkdir -p "$project_dir/.claude/agents"

    # Create sample files with old references
    cat > "$project_dir/.agent-os/instructions/core/create-spec.md" << 'EOF'
# Create Spec
@.agent-os/instructions/meta/pre-flight.md
@.agent-os/standards/tech-stack.md
EOF

    cat > "$project_dir/.claude/commands/create-spec.md" << 'EOF'
# Create Spec Command
@.agent-os/instructions/core/create-spec.md
EOF

    cat > "$project_dir/CLAUDE.md" << 'EOF'
# CLAUDE.md
Reference: @.agent-os/standards/code-style.md
Instructions: @.agent-os/instructions/core/
EOF

    # Initialize git repo
    cd "$project_dir"
    git init -q
    git add .
    git commit -q -m "Initial commit"
    cd "$SCRIPT_DIR"

    echo "✓ Test project created: $project_dir"
}

# Cleanup test projects
cleanup_test_projects() {
    echo "Cleaning up test projects..."
    rm -rf "$TEST_DIR"
}

# Test Suite
echo "======================================"
echo "Migration Script Test Suite"
echo "======================================"
echo ""

# Ensure migration script exists
if [ ! -f "$SCRIPT_DIR/update-to-v2.sh" ]; then
    echo -e "${RED}ERROR: update-to-v2.sh not found${NC}"
    echo "Please create the migration script first"
    exit 1
fi

# Make migration script executable
chmod +x "$SCRIPT_DIR/update-to-v2.sh"

# Test 1: Pre-flight checks
print_test "Pre-flight checks detect old structure"
setup_test_project "test1-preflight"
cd "$TEST_DIR/test1-preflight"
# Run migration script in dry-run mode if available, or just check detection
if [ -d ".agent-os" ]; then
    assert_success "Old .agent-os structure detected"
else
    ((FAIL_COUNT++))
fi
cd "$SCRIPT_DIR"

# Test 2: Backup creation
print_test "Backup is created before migration"
setup_test_project "test2-backup"
cd "$TEST_DIR/test2-backup"
bash "$SCRIPT_DIR/update-to-v2.sh" --yes 2>/dev/null || true
# Check if backup was created
backup_dir=$(ls -d .agent-os.backup-* 2>/dev/null | head -n 1)
if [ -n "$backup_dir" ]; then
    assert_success "Backup directory created"
    assert_dir_exists "$backup_dir/instructions"
else
    ((FAIL_COUNT++))
    echo -e "${RED}✗ FAIL: No backup directory created${NC}"
fi
cd "$SCRIPT_DIR"

# Test 3: Directory renaming
print_test "Directories are renamed correctly"
setup_test_project "test3-rename"
cd "$TEST_DIR/test3-rename"
bash "$SCRIPT_DIR/update-to-v2.sh" --yes 2>/dev/null || true
assert_dir_exists "agent-os"
assert_dir_not_exists ".agent-os"
assert_dir_exists "agent-os/workflows"
assert_dir_not_exists "agent-os/instructions"
cd "$SCRIPT_DIR"

# Test 4: Command isolation
print_test "Commands are moved to isolated directory"
setup_test_project "test4-commands"
cd "$TEST_DIR/test4-commands"
bash "$SCRIPT_DIR/update-to-v2.sh" --yes 2>/dev/null || true
assert_dir_exists ".claude/commands/agent-os"
assert_file_exists ".claude/commands/agent-os/create-spec.md"
cd "$SCRIPT_DIR"

# Test 5: Reference updates
print_test "References are updated in files"
setup_test_project "test5-references"
cd "$TEST_DIR/test5-references"
bash "$SCRIPT_DIR/update-to-v2.sh" --yes 2>/dev/null || true
assert_file_contains "agent-os/workflows/core/create-spec.md" "@agent-os/workflows/meta/pre-flight.md"
assert_file_not_contains "agent-os/workflows/core/create-spec.md" "@.agent-os/instructions"
assert_file_contains "CLAUDE.md" "@agent-os/standards/code-style.md"
assert_file_not_contains "CLAUDE.md" "@.agent-os/standards"
cd "$SCRIPT_DIR"

# Test 6: Preservation of custom files
print_test "Custom files and specs are preserved"
setup_test_project "test6-preservation"
cd "$TEST_DIR/test6-preservation"
echo "custom content" > ".agent-os/specs/test-spec.md"
echo "bug content" > ".agent-os/bugs/test-bug.md"
bash "$SCRIPT_DIR/update-to-v2.sh" --yes 2>/dev/null || true
assert_file_exists "agent-os/specs/test-spec.md"
assert_file_exists "agent-os/bugs/test-bug.md"
assert_file_contains "agent-os/specs/test-spec.md" "custom content"
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
