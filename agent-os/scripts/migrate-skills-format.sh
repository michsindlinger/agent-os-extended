#!/bin/bash
# migrate-skills-format.sh
# Migriert Skills vom alten flachen Format zum Anthropic Ordner-Format
#
# Konvertiert: skill-name-template.md -> skill-name/SKILL.md
#
# Usage: ./migrate-skills-format.sh [OPTIONS] <directory>
#
# Options:
#   -d, --dry-run    Show what would be done without making changes
#   -v, --verbose    Show detailed output
#   -D, --delete     Delete original files after migration
#   -h, --help       Show this help message
#
# Example:
#   ./migrate-skills-format.sh --dry-run ./agent-os/templates/skills/
#   ./migrate-skills-format.sh --verbose --delete ./my-project/skills/

set -euo pipefail

# Configuration
DRY_RUN=false
VERBOSE=false
DELETE_ORIGINALS=false
MIGRATED_COUNT=0
SKIPPED_COUNT=0
ERROR_COUNT=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_verbose() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${BLUE}[VERBOSE]${NC} $1"
    fi
}

# Show usage information
usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] <directory>

Migrate skill files from flat format (*-template.md) to Anthropic folder format (*/SKILL.md)

Options:
    -d, --dry-run    Show what would be done without making changes
    -v, --verbose    Show detailed output
    -D, --delete     Delete original files after successful migration
    -h, --help       Show this help message

Examples:
    $(basename "$0") --dry-run ./skills/
    $(basename "$0") --verbose --delete ./agent-os/templates/skills/

Migration Format:
    Before: skill-name-template.md
    After:  skill-name/SKILL.md

EOF
}

# Migrate a single skill file
migrate_skill() {
    local source_file="$1"
    local source_dir
    local filename
    local skill_name
    local target_dir
    local target_file

    source_dir=$(dirname "$source_file")
    filename=$(basename "$source_file")

    # Extract skill name (remove -template.md suffix)
    skill_name="${filename%-template.md}"

    # Skip if filename doesn't match expected pattern
    if [[ "$skill_name" == "$filename" ]]; then
        log_verbose "Skipping non-template file: $filename"
        return 1
    fi

    target_dir="${source_dir}/${skill_name}"
    target_file="${target_dir}/SKILL.md"

    log_verbose "Processing: $filename -> ${skill_name}/SKILL.md"

    # Check if target directory already exists
    if [[ -d "$target_dir" ]]; then
        if [[ -f "$target_file" ]]; then
            log_warning "Target already exists, skipping: $target_file"
            ((SKIPPED_COUNT++))
            return 0
        fi
    fi

    # Check if source file is readable
    if [[ ! -r "$source_file" ]]; then
        log_error "Cannot read source file: $source_file"
        ((ERROR_COUNT++))
        return 1
    fi

    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY-RUN] Would create: $target_dir/"
        log_info "[DRY-RUN] Would migrate: $source_file -> $target_file"
        if [[ "$DELETE_ORIGINALS" == "true" ]]; then
            log_info "[DRY-RUN] Would delete: $source_file"
        fi
    else
        # Create target directory
        if ! mkdir -p "$target_dir"; then
            log_error "Failed to create directory: $target_dir"
            ((ERROR_COUNT++))
            return 1
        fi

        # Copy content to new location
        if ! cp "$source_file" "$target_file"; then
            log_error "Failed to copy file: $source_file -> $target_file"
            ((ERROR_COUNT++))
            return 1
        fi

        log_success "Migrated: $filename -> ${skill_name}/SKILL.md"

        # Delete original if requested
        if [[ "$DELETE_ORIGINALS" == "true" ]]; then
            if rm "$source_file"; then
                log_verbose "Deleted original: $source_file"
            else
                log_warning "Could not delete original: $source_file"
            fi
        fi
    fi

    ((MIGRATED_COUNT++))
    return 0
}

# Main function
main() {
    local target_directory=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -D|--delete)
                DELETE_ORIGINALS=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            -*)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
            *)
                target_directory="$1"
                shift
                ;;
        esac
    done

    # Check if directory was provided
    if [[ -z "$target_directory" ]]; then
        log_error "No target directory specified"
        usage
        exit 1
    fi

    # Check if directory exists
    if [[ ! -d "$target_directory" ]]; then
        log_error "Directory does not exist: $target_directory"
        exit 1
    fi

    log_info "Starting skill migration..."
    log_info "Target directory: $target_directory"
    [[ "$DRY_RUN" == "true" ]] && log_info "Mode: DRY-RUN (no changes will be made)"
    [[ "$DELETE_ORIGINALS" == "true" ]] && log_info "Original files will be deleted after migration"
    echo ""

    # Find and process all template files
    local template_files
    template_files=$(find "$target_directory" -name "*-template.md" -type f 2>/dev/null || true)

    if [[ -z "$template_files" ]]; then
        log_info "No *-template.md files found in $target_directory"
        exit 0
    fi

    # Process each template file
    while IFS= read -r file; do
        migrate_skill "$file" || true
    done <<< "$template_files"

    # Print summary
    echo ""
    log_info "========== Migration Summary =========="
    log_info "Files migrated: $MIGRATED_COUNT"
    log_info "Files skipped:  $SKIPPED_COUNT"
    log_info "Errors:         $ERROR_COUNT"

    if [[ "$DRY_RUN" == "true" ]]; then
        echo ""
        log_info "This was a dry run. Run without --dry-run to apply changes."
    fi

    # Exit with error if there were failures
    if [[ $ERROR_COUNT -gt 0 ]]; then
        exit 1
    fi
}

# Run main function
main "$@"
