---
description: Migrate existing skills to include proper YAML frontmatter
version: 1.0
encoding: UTF-8
---

# Migrate Skills Workflow

## Overview

Scan existing skills in `.claude/skills/` and add missing YAML frontmatter. This workflow upgrades legacy skills to the new format with proper `name`, `description`, `globs`, and other required fields.

## Process Flow

<process_flow>

<step number="1" name="scan_skills">

### Step 1: Scan for Skills

Find all skill files in the project that may need migration.

<instructions>
  ACTION: Use Glob tool to find all skills

  SCAN_PATTERNS:
    1. `.claude/skills/**/SKILL.md` (folder format)
    2. `.claude/skills/*.md` (flat format)
    3. `.claude/skills/**/*.md` (nested format)

  COLLECT: All skill file paths
  STORE: In skills_list variable

  LOG: "Found {count} skill files to check"
</instructions>

</step>

<step number="2" name="analyze_skills">

### Step 2: Analyze Each Skill

Check each skill file for proper frontmatter and identify what needs to be added.

<instructions>
  FOR EACH skill_file in skills_list:

    1. READ: skill file content
    2. CHECK: Has YAML frontmatter
       - File starts with `---`
       - Has closing `---`
       - Has required fields (name, description)

    3. IF frontmatter exists AND complete:
       SKIP: This skill
       LOG: "✓ {skill_file} - already has frontmatter"

    4. ELSE (missing or incomplete frontmatter):
       EXTRACT: Skill information
       - skill_name: From folder name or filename
       - content: Main content after existing frontmatter (if any)
       - framework: Detect from content or tech-stack.md
       - skill_type: Detect from folder structure

       ADD to: migration_queue

  DISPLAY: Summary
    "Found {migration_count} skills needing migration"
    "{complete_count} skills already compliant"
</instructions>

</step>

<step number="3" name="detect_project_context">

### Step 3: Detect Project Context

Load project information for generating appropriate frontmatter.

<instructions>
  ACTION: Gather project context

  1. READ: specwright/product/tech-stack.md (if exists)
     EXTRACT: Framework, language, version

  2. DETECT: Project name
     - Try: specwright/config.yml (project.name)
     - Try: package.json (name field)
     - Try: directory name

  3. READ: @specwright/workflows/skill/utils/globs-mapping.md
     EXTRACT: Framework-specific globs

  STORE: In project_context variable
</instructions>

</step>

<step number="4" name="generate_frontmatter">

### Step 4: Generate Frontmatter for Each Skill

Create proper YAML frontmatter for each skill in migration queue.

<instructions>
  FOR EACH skill in migration_queue:

    1. EXTRACT skill components:
       - project_name: From project_context or folder name
       - agent_role: From folder pattern (architect, backend, frontend, devops, qa, po, documenter)
       - skill_name: Last part of folder name
       - existing_content: Read from file

    2. DETECT skill_type from name:
       - *pattern-enforcement* → architect + pattern-enforcement
       - *logic-implementing* → backend + logic-implementing
       - *ui-component-architecture* → frontend + ui-component-architecture
       - *infrastructure-provisioning* → devops + infrastructure-provisioning
       - *test-strategy* → qa + test-strategy
       - *backlog-organization* → po + backlog-organization
       - etc.

    3. LOOKUP globs from globs-mapping.md:
       - Use framework + skill_type as key
       - If framework unknown: Use generic patterns
       - If no globs available: Skip globs field

    4. GENERATE description:
       FORMAT: "{agent_role} {skill_name} skill for {project_name}. Use when: (1) [trigger], (2) [trigger], (3) [trigger]"

       TRIGGER_EXAMPLES by skill_type:
       - logic-implementing: "Implementing business logic", "Creating services", "Domain operations"
       - persistence-adapter: "Working with repositories", "Data access", "Database operations"
       - ui-component-architecture: "Creating UI components", "Component structure", "UI patterns"
       - test-automation: "Writing tests", "Test implementation", "Quality assurance"

    5. BUILD frontmatter:

       ```yaml
       ---
       name: {project_name}-{agent_role}-{skill_name}
       description: "{generated_description}"
       version: 1.0
       created: {current_date}
       encoding: UTF-8
       [IF globs_available:]
       globs:
         - "{glob_1}"
         - "{glob_2}"
       [ENDIF]
       ---
       ```

    STORE: Generated frontmatter in migration_plan
</instructions>

</step>

<step number="5" name="preview_migration">

### Step 5: Preview Migration Plan

Show the user what will be changed and get confirmation.

<instructions>
  DISPLAY: Migration summary

    "═══════════════════════════════════════════════════════════════
    📋 SKILL MIGRATION PLAN
    ═══════════════════════════════════════════════════════════════

    Project: {project_name}
    Framework: {detected_framework}
    Skills to migrate: {migration_count}

    ─────────────────────────────────────────────────────────────
    📝 CHANGES PREVIEW
    ─────────────────────────────────────────────────────────────"

  FOR EACH skill in migration_queue:
    DISPLAY:
      "📄 {skill_name}
         Old: {old_status}
         New: {new_frontmatter_preview}"

  DISPLAY: Warning
    "⚠️  Backup files will be created (*.old)
    ⚠️  Git revert available if needed"

  USE: AskUserQuestion
  QUESTION: "Proceed with migration?"
  OPTIONS:
    - "✅ Yes, migrate all skills"
    - "📖 Show details for specific skill"
    - "❌ No, cancel"

  IF "Show details":
    SELECT skill to show
    DISPLAY: Full before/after comparison
    ASK again

  IF "No":
    EXIT workflow
</instructions>

</step>

<step number="6" name="execute_migration">

### Step 6: Execute Migration

Update skill files with new frontmatter.

<instructions>
  FOR EACH skill in migration_queue:

    1. CREATE backup:
       USE: Bash command or Write tool
       COPY: Original file to {file_path}.old

    2. PREPEND: Generated frontmatter
    3. PRESERVE: Existing content
    4. WRITE: Updated file

    5. VERIFY: File was written correctly
    6. LOG: "✓ Migrated: {skill_name}"

  DISPLAY: Progress
    "Migrating: 1/{total}..."
    "Migrating: 2/{total}..."
    etc.
</instructions>

</step>

<step number="7" name="verify_migration">

### Step 7: Verify Migration

Ensure all skills were successfully migrated.

<instructions>
  VERIFY:
    1. All files have valid YAML frontmatter
    2. All required fields present (name, description)
    3. No content lost
    4. Backup files created
    5. Proper YAML syntax

  VALIDATION:
    FOR EACH migrated skill:
      READ: File content
      CHECK: Starts with `---`
      CHECK: Has `name:` field
      CHECK: Has `description:` field
      CHECK: Ends first `---` block

  IF validation_fails:
    REPORT: Which skills failed
    OFFER: Restore from backups

  ELSE:
    DISPLAY: Success message
</instructions>

</step>

<step number="8" name="display_summary">

### Step 8: Display Summary

Show migration results and next steps.

<instructions>
  DISPLAY: Success message

    "✅ Skill Migration Complete!

    📊 Results:
    - Skills migrated: {success_count}
    - Already compliant: {skipped_count}
    - Failed: {failed_count}

    📁 Files created:
    - Migrated skills: .claude/skills/*/
    - Backups: .claude/skills/*/*.old

    🔄 Rollback:
    If issues occur, restore from *.old files or use git revert.

    ✨ Skills now have:
    - Proper YAML frontmatter
    - Auto-activation via globs
    - Clear descriptions
    - Claude Code compatibility"

  OPTIONAL_OFFERS:
    USE: AskUserQuestion
    QUESTION: "What would you like to do?"
    OPTIONS:
      - "View a migrated skill"
      - "Delete backup files"
      - "Done"

  IF "View a migrated skill":
    SELECT: Which skill to view
    DISPLAY: Full file content

  IF "Delete backup files":
    USE: Bash command
    REMOVE: All *.old files
    CONFIRM: "Backup files deleted"
</instructions>

</step>

</process_flow>

## Error Handling

<error_protocols>
  <no_skills_found>
    MESSAGE: "No skills found in .claude/skills/"
    SUGGEST: "Run /build-development-team first to create skills"
    EXIT: Workflow
  </no_skills_found>

  <all_skills_compliant>
    MESSAGE: "✅ All skills already have proper frontmatter!"
    OFFER: "Would you like to view existing skills?"
    EXIT: Workflow
  </all_skills_compliant>

  <migration_failed>
    LOG: Which skill failed and why
    CREATE: Error report
    OFFER: "Restore from backups?"
    IF yes: RESTORE from *.old files
  </migration_failed>

  <invalid_yaml>
    MESSAGE: "Invalid YAML in generated frontmatter"
    FIX: Syntax errors
    RETRY: Migration
    FALLBACK: Minimal frontmatter (name + description only)
  </invalid_yaml>
</error_protocols>

## Example Output

**Before Migration:**
```markdown
# Backend Logic Implementing

> Generated by Specwright

## Patterns

[... content without frontmatter ...]
```

**After Migration:**
```markdown
---
name: my-project-backend-logic-implementing
description: "Backend logic implementing skill for my-project. Use when: (1) Implementing business logic, (2) Creating services, (3) Domain operations"
version: 1.0
framework: spring-boot
created: 2026-01-14
encoding: UTF-8
globs:
  - "src/**/*Service.java"
  - "src/**/service/**/*.java"
---

# Backend Logic Implementing

> Generated by Specwright

## Patterns

[... content preserved ...]
```

## Related Workflows

- `@specwright/workflows/core/build-development-team.md` - Creates new skills with frontmatter
- `@specwright/workflows/core/toggle-skill-activation.md` - Modify skill activation modes
- `@specwright/workflows/skill/utils/globs-mapping.md` - Framework-specific globs

## Quick Reference for Claude

**When user runs:** `/migrate-skills`

**Execute:**
1. Scan .claude/skills/ for all skill files
2. Check each for proper YAML frontmatter
3. Detect project context (framework, project name)
4. Generate frontmatter for skills missing it
5. Preview changes to user
6. On approval, migrate all skills
7. Create backups (*.old)
8. Verify success
9. Display summary
