#!/bin/bash
#
# Automated Story Execution Script
# Runs Claude Code in a loop, executing one phase per iteration
# until all stories are complete.
#
# Usage:
#   ./auto-execute.sh [spec-name] [-v|--verbose]
#
# Example:
#   ./auto-execute.sh 2026-01-13-multi-delete-projects
#   ./auto-execute.sh -v  # Verbose mode with debug output
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Configuration
SPECS_DIR="agent-os/specs"
MAX_ITERATIONS=50  # Safety limit
DELAY_BETWEEN_PHASES=2  # Seconds to wait between phases
MAX_RETRIES=3
VERBOSE=false

# Logging
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_debug() {
    if [[ "$VERBOSE" == true ]]; then
        echo -e "${GRAY}[DEBUG]${NC} $1"
    fi
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    # Check if claude is installed
    if ! command -v claude &> /dev/null; then
        log_error "Claude CLI not found. Please install it first."
        exit 1
    fi
    log_debug "Claude CLI found: $(which claude)"

    # Check current directory
    log_debug "Working directory: $(pwd)"

    # Check if .claude/commands/agent-os exists
    if [[ -d ".claude/commands/agent-os" ]]; then
        log_debug "Skills directory: .claude/commands/agent-os/"
        log_debug "Available skills: $(ls .claude/commands/agent-os/ | tr '\n' ' ')"

        if [[ -f ".claude/commands/agent-os/execute-tasks.md" ]]; then
            log_success "execute-tasks.md skill found"
        else
            log_error "execute-tasks.md NOT found in .claude/commands/agent-os/"
            exit 1
        fi
    else
        log_warning ".claude/commands/agent-os/ directory not found"
        log_warning "Checking global skills..."

        if [[ -d "$HOME/.claude/commands/agent-os" ]]; then
            log_debug "Global skills: $HOME/.claude/commands/agent-os/"
        else
            log_error "No agent-os skills found (local or global)"
            exit 1
        fi
    fi

    # Check specs directory
    if [[ ! -d "$SPECS_DIR" ]]; then
        log_error "Specs directory not found: $SPECS_DIR"
        exit 1
    fi
    log_debug "Specs directory: $SPECS_DIR"

    log_success "Prerequisites OK"
}

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

# Get story count from kanban board (using template structure)
get_story_counts() {
    local spec="$1"
    local kanban_file="$SPECS_DIR/$spec/kanban-board.md"

    if [[ ! -f "$kanban_file" ]]; then
        echo "0/0"
        return 0
    fi

    # Parse from Board Status section (template structure)
    # Format: | **Completed** | 2 |
    local completed=$(grep "\*\*Completed\*\*" "$kanban_file" 2>/dev/null | sed 's/.*\*\*Completed\*\*[[:space:]]*|[[:space:]]*\([0-9]*\).*/\1/' | xargs)
    local total=$(grep "\*\*Total Stories\*\*" "$kanban_file" 2>/dev/null | sed 's/.*\*\*Total Stories\*\*[[:space:]]*|[[:space:]]*\([0-9]*\).*/\1/' | xargs)

    # Fallback: Try old format (header style)
    if [[ -z "$total" || "$total" == "0" ]]; then
        total=$(grep -E "\*\*Total Stories\*\*.*[0-9]+" "$kanban_file" 2>/dev/null | grep -oE "[0-9]+" | head -1)
    fi
    if [[ -z "$completed" || "$completed" == "-" ]]; then
        completed=$(grep -E "\*\*Completed\*\*.*[0-9]+" "$kanban_file" 2>/dev/null | grep -oE "[0-9]+" | head -1)
    fi

    # Fallback: count checkbox format (legacy)
    if [[ -z "$total" || "$total" == "0" ]]; then
        total=$(grep -E "^\- \[[ x]\] \*\*Story" "$kanban_file" 2>/dev/null | wc -l | xargs)
    fi
    if [[ -z "$completed" || "$completed" == "0" ]]; then
        completed=$(grep -E "^\- \[x\] \*\*Story" "$kanban_file" 2>/dev/null | wc -l | xargs)
    fi

    # Ensure we have numbers
    total=${total:-0}
    completed=${completed:-0}

    echo "$completed/$total"
}

# Run one phase of execute-tasks
run_phase() {
    local spec="$1"
    local iteration="$2"
    local retry=0
    local log_file="/tmp/claude-phase-${spec}-$iteration.log"

    log_info "Starting Phase (Iteration $iteration)..."
    log_debug "Spec: $spec"
    log_debug "Log file: $log_file"

    while [[ $retry -lt $MAX_RETRIES ]]; do
        local cmd="claude -p \"/agent-os:execute-tasks $spec\" --dangerously-skip-permissions --model sonnet"
        log_debug "Command: $cmd"
        log_debug "Attempt: $((retry + 1))/$MAX_RETRIES"

        echo -e "${CYAN}--- Claude Output Start ---${NC}"

        # Run Claude Code with execute-tasks
        claude -p "/agent-os:execute-tasks $spec" \
            --dangerously-skip-permissions \
            --model sonnet \
            2>&1 | tee "$log_file"

        local exit_code=${PIPESTATUS[0]}

        echo -e "${CYAN}--- Claude Output End ---${NC}"

        log_debug "Exit code: $exit_code"
        log_debug "Log file size: $(wc -c < "$log_file" | xargs) bytes"

        # Check for "Unknown skill" error
        if grep -q "Unknown skill" "$log_file" 2>/dev/null; then
            retry=$((retry + 1))
            log_warning "Unknown skill error detected!"
            log_warning "Retry $retry/$MAX_RETRIES in 5 seconds..."

            # Show more debug info
            log_debug "Full error from log:"
            grep -i "unknown\|error\|skill" "$log_file" 2>/dev/null | head -5

            sleep 5
            continue
        fi

        # Check for other common errors
        if grep -qi "error\|failed\|exception" "$log_file" 2>/dev/null; then
            log_warning "Potential error detected in output"
            log_debug "Error lines:"
            grep -i "error\|failed\|exception" "$log_file" 2>/dev/null | head -5
        fi

        if [[ $exit_code -ne 0 ]]; then
            log_warning "Claude exited with code $exit_code"
        else
            log_success "Phase completed successfully"
        fi

        return $exit_code
    done

    log_error "Failed after $MAX_RETRIES retries due to Unknown skill error"
    log_error "Please check:"
    log_error "  1. .claude/commands/agent-os/execute-tasks.md exists"
    log_error "  2. File has correct format"
    log_error "  3. Try running manually: claude -p '/agent-os:execute-tasks'"
    return 1
}

# Parse arguments
parse_args() {
    local spec=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                echo "Usage: $0 [spec-name] [-v|--verbose]"
                echo ""
                echo "Options:"
                echo "  -v, --verbose    Enable debug output"
                echo "  -h, --help       Show this help"
                echo ""
                echo "Examples:"
                echo "  $0 2026-01-13-feature-name"
                echo "  $0 -v"
                echo "  $0 2026-01-13-feature-name --verbose"
                exit 0
                ;;
            *)
                spec="$1"
                shift
                ;;
        esac
    done

    echo "$spec"
}

# Main execution loop
main() {
    local spec_name="$1"

    log_info "=== Automated Story Execution ==="
    log_info "Verbose mode: $VERBOSE"
    log_info "Starting automated execution..."

    # Check prerequisites first
    check_prerequisites

    # Find active spec
    local spec=$(find_active_spec "$spec_name")
    if [[ -z "$spec" ]]; then
        log_error "No spec found. Exiting."
        exit 1
    fi

    log_success "Using spec: $spec"
    log_debug "Spec path: $SPECS_DIR/$spec"

    # Show kanban board status
    local kanban_file="$SPECS_DIR/$spec/kanban-board.md"
    if [[ -f "$kanban_file" ]]; then
        log_debug "Kanban board exists: $kanban_file"
        log_debug "Kanban size: $(wc -l < "$kanban_file" | xargs) lines"
    else
        log_debug "No kanban board yet (will be created in Phase 1)"
    fi

    local iteration=0
    local phase=""
    local last_phase=""
    local last_counts=""

    while [[ $iteration -lt $MAX_ITERATIONS ]]; do
        iteration=$((iteration + 1))

        # Get current phase
        phase=$(get_current_phase "$spec")
        local counts=$(get_story_counts "$spec")

        log_info "=========================================="
        log_info "=== Iteration $iteration ==="
        log_info "=========================================="
        log_info "Current Phase: $phase"
        log_info "Progress: $counts stories done"

        # Detect stuck state (only warn if BOTH phase AND progress unchanged)
        if [[ "$phase" == "$last_phase" && "$counts" == "$last_counts" && $iteration -gt 1 ]]; then
            log_warning "No progress detected (phase and story count unchanged)"
            log_warning "This might indicate a problem."
        fi
        last_phase="$phase"
        last_counts="$counts"

        # Check if complete (multiple completion indicators)
        if [[ "$phase" == "complete" || "$phase" == "None" || "$phase" == "none" || "$phase" == "4-complete" ]]; then
            log_success "=========================================="
            log_success "=== All phases complete! ==="
            log_success "=========================================="
            log_success "Spec execution finished successfully."

            # Play completion sound
            afplay /System/Library/Sounds/Glass.aiff 2>/dev/null || true

            exit 0
        fi

        # Run the next phase
        if ! run_phase "$spec" "$iteration"; then
            log_error "Phase failed. Check logs at /tmp/claude-phase-${spec}-$iteration.log"
            # Continue anyway to allow manual intervention
        fi

        # Brief pause between phases
        log_info "Waiting ${DELAY_BETWEEN_PHASES}s before next phase..."
        sleep $DELAY_BETWEEN_PHASES

    done

    log_error "Reached maximum iterations ($MAX_ITERATIONS). Something may be wrong."
    exit 1
}

# Handle interrupts
cleanup() {
    echo ""
    log_warning "Interrupted. Exiting..."
    log_info "Logs available at: /tmp/claude-phase-<spec>-*.log"
    exit 130
}

trap cleanup SIGINT SIGTERM

# Parse arguments and run
SPEC_ARG=$(parse_args "$@")
main "$SPEC_ARG"
