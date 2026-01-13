#!/bin/bash
#
# Automated Story Execution Script
# Runs Claude Code in a loop, executing one phase per iteration
# until all stories are complete.
#
# Usage:
#   ./auto-execute.sh [spec-name]
#
# Example:
#   ./auto-execute.sh 2026-01-13-multi-delete-projects
#   ./auto-execute.sh  # Auto-detects spec with kanban board
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SPECS_DIR="agent-os/specs"
MAX_ITERATIONS=50  # Safety limit
DELAY_BETWEEN_PHASES=2  # Seconds to wait between phases

# Logging
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Find spec with kanban board or use provided spec
find_active_spec() {
    local provided_spec="$1"

    if [[ -n "$provided_spec" ]]; then
        if [[ -d "$SPECS_DIR/$provided_spec" ]]; then
            echo "$provided_spec"
            return 0
        else
            log_error "Spec not found: $SPECS_DIR/$provided_spec"
            return 1
        fi
    fi

    # Find spec with existing kanban board
    local kanban_file=$(ls $SPECS_DIR/*/kanban-board.md 2>/dev/null | head -1)
    if [[ -n "$kanban_file" ]]; then
        basename $(dirname "$kanban_file")
        return 0
    fi

    # Find most recent spec
    local latest_spec=$(ls -1 $SPECS_DIR/ 2>/dev/null | sort -r | head -1)
    if [[ -n "$latest_spec" ]]; then
        echo "$latest_spec"
        return 0
    fi

    log_error "No specs found in $SPECS_DIR/"
    return 1
}

# Get current phase from kanban board
get_current_phase() {
    local spec="$1"
    local kanban_file="$SPECS_DIR/$spec/kanban-board.md"

    if [[ ! -f "$kanban_file" ]]; then
        echo "no-board"
        return 0
    fi

    # Extract Current Phase from Resume Context
    local phase=$(grep -A1 "Current Phase" "$kanban_file" | tail -1 | sed 's/.*| *\([^|]*\) *|.*/\1/' | xargs)

    if [[ -z "$phase" ]]; then
        echo "unknown"
    else
        echo "$phase"
    fi
}

# Get story count from kanban board
get_story_counts() {
    local spec="$1"
    local kanban_file="$SPECS_DIR/$spec/kanban-board.md"

    if [[ ! -f "$kanban_file" ]]; then
        echo "0/0"
        return 0
    fi

    # Count stories in Done vs Total
    local done=$(grep -c "^## .*Done" "$kanban_file" 2>/dev/null || echo "0")
    local total=$(grep -c "^\- \[ \] \*\*Story" "$kanban_file" 2>/dev/null || echo "0")
    local done_count=$(grep -A100 "^## .*Done" "$kanban_file" 2>/dev/null | grep -c "^\- \[x\] \*\*Story" || echo "0")

    echo "$done_count/$total"
}

# Run one phase of execute-tasks
run_phase() {
    local spec="$1"
    local iteration="$2"

    log_info "Starting Phase (Iteration $iteration)..."
    log_info "Spec: $spec"

    # Run Claude Code with execute-tasks
    # Using -p for non-interactive mode
    # Using --dangerously-skip-permissions for automation
    claude -p "/agent-os:execute-tasks $spec" \
        --dangerously-skip-permissions \
        --model sonnet \
        2>&1 | tee "/tmp/claude-phase-$iteration.log"

    local exit_code=$?

    if [[ $exit_code -ne 0 ]]; then
        log_warning "Claude exited with code $exit_code"
    fi

    return $exit_code
}

# Main execution loop
main() {
    local spec_name="$1"

    log_info "=== Automated Story Execution ==="
    log_info "Starting automated execution..."

    # Find active spec
    local spec=$(find_active_spec "$spec_name")
    if [[ -z "$spec" ]]; then
        log_error "No spec found. Exiting."
        exit 1
    fi

    log_success "Using spec: $spec"

    local iteration=0
    local phase=""

    while [[ $iteration -lt $MAX_ITERATIONS ]]; do
        iteration=$((iteration + 1))

        # Get current phase
        phase=$(get_current_phase "$spec")
        local counts=$(get_story_counts "$spec")

        log_info "=== Iteration $iteration ==="
        log_info "Current Phase: $phase"
        log_info "Progress: $counts stories"

        # Check if complete
        if [[ "$phase" == "complete" ]]; then
            log_success "=== All phases complete! ==="
            log_success "Spec execution finished successfully."

            # Play completion sound
            afplay /System/Library/Sounds/Glass.aiff 2>/dev/null || true

            exit 0
        fi

        # Run the next phase
        run_phase "$spec" "$iteration"

        # Brief pause between phases
        log_info "Waiting ${DELAY_BETWEEN_PHASES}s before next phase..."
        sleep $DELAY_BETWEEN_PHASES

    done

    log_error "Reached maximum iterations ($MAX_ITERATIONS). Something may be wrong."
    exit 1
}

# Handle interrupts
cleanup() {
    log_warning "Interrupted. Exiting..."
    exit 130
}

trap cleanup SIGINT SIGTERM

# Run main
main "$1"
