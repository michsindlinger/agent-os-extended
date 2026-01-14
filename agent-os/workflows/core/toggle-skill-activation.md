---
description: Toggle skill activation mode between auto-load, explicit, and always-active
version: 1.0
encoding: UTF-8
---

# Toggle Skill Activation Workflow

## Overview

Change how a skill is activated by Claude Code. Skills can be set to:
- **Auto-Load**: Automatically loaded when working with files matching glob patterns
- **Explicit Only**: Only loaded when explicitly invoked by name
- **Always Active**: Always loaded regardless of context

## Process Flow

<process_flow>

<step number="1" name="select_skill">

### Step 1: Select Skill to Modify

List available skills and let user choose which one to modify.

<instructions>
  ACTION: Use Glob tool to find all skills

  SCAN_PATTERNS:
    - `.claude/skills/**/SKILL.md`
    - `.claude/skills/*.md`

  COLLECT: All skill file paths
  EXTRACT: Skill names from folder names or filenames

  DISPLAY: List of available skills

    "═══════════════════════════════════════════════════════════════
    📋 AVAILABLE SKILLS
    ═══════════════════════════════════════════════════════════════"

  FOR EACH skill:
    DISPLAY: "• {skill_name}"

  USE: AskUserQuestion
  QUESTION: "Which skill do you want to modify?"
  OPTIONS: List all skills + "Other (specify name)" + "Cancel"

  IF "Other":
    ASK: For skill name
    VERIFY: File exists

  IF "Cancel":
    EXIT workflow

  STORE: selected_skill_path
</instructions>

</step>

<step number="2" name="analyze_current_state">

### Step 2: Analyze Current Activation State

Read the skill file and determine its current activation mode.

<instructions>
  ACTION: Read selected skill file

  PARSE: YAML frontmatter

  DETERMINE: Current activation mode

  IF `always_apply: true`:
    current_mode = "always_active"
    DISPLAY: "✓ Currently: Always Active"

  ELSE IF has `globs:` field with patterns:
    current_mode = "auto_load"
    DISPLAY: "✓ Currently: Auto-Load"
    SHOW: Globs being used

  ELSE:
    current_mode = "explicit_only"
    DISPLAY: "✓ Currently: Explicit Only"

  DISPLAY: Skill information
    "Name: {name}
     Description: {description}
     Framework: {framework or N/A}
     Version: {version or N/A}"
</instructions>

</step>

<step number="3" name="select_new_mode">

### Step 3: Select New Activation Mode

Present options and get user's choice for new mode.

<instructions>
  USE: AskUserQuestion
  QUESTION: "How should this skill be activated?"

  OPTIONS:
    - label: "Auto-Load (with file patterns)"
      description: "Automatically load when working with specific file types"

    - label: "Explicit Only"
      description: "Only load when explicitly invoked by name"

    - label: "Always Active"
      description: "Always load regardless of context"

    - label: "Cancel"
      description: "Don't change anything"

  RECEIVE: user_selection
  STORE: new_mode
</instructions>

</step>

<step number="4" name="configure_mode">

### Step 4: Configure Selected Mode

Based on user's choice, configure the skill accordingly.

<instructions>
  IF new_mode == "auto_load":

    USE: AskUserQuestion
    QUESTION: "Select framework or enter custom globs"
    OPTIONS:
      - "Auto-detect from tech-stack.md"
      - "Choose from framework list"
      - "Enter custom patterns"

    IF "Auto-detect":
      READ: agent-os/product/tech-stack.md
      DETECT: Framework
      LOOKUP: Globs from @agent-os/workflows/skill/utils/globs-mapping.md
      EXTRACT: Relevant globs for this skill type

    ELSE IF "Choose from framework":
      SHOW: Framework list (Spring Boot, Rails, React, Angular, etc.)
      RECEIVE: framework_choice
      LOOKUP: Globs from globs-mapping.md
      EXTRACT: Relevant globs

    ELSE IF "Custom":
      USE: AskUserQuestion (or direct input)
      RECEIVE: List of glob patterns
      VALIDATE: Each pattern is valid glob syntax

    SET: `globs: [pattern_list]`
    REMOVE: `always_apply` field (if present)

  ELSE IF new_mode == "explicit_only":

    REMOVE: `globs` field entirely
    REMOVE: `always_apply` field (if present)
    SET: No auto-activation

  ELSE IF new_mode == "always_active":

    SET: `always_apply: true`
    REMOVE: `globs` field (or keep, both can coexist)

  ELSE IF "Cancel":

    EXIT workflow

  PREPARE: Updated frontmatter
</instructions>

</step>

<step number="5" name="preview_changes">

### Step 5: Preview Changes

Show user exactly what will change before applying.

<instructions>
  DISPLAY: Before/After comparison

    "═══════════════════════════════════════════════════════════════
    📝 CHANGES PREVIEW
    ═══════════════════════════════════════════════════════════════

    Skill: {skill_name}

    ─────────────────────────────────────────────────────────────
    BEFORE:
    ─────────────────────────────────────────────────────────────
    {old_frontmatter_yaml}

    ─────────────────────────────────────────────────────────────
    AFTER:
    ─────────────────────────────────────────────────────────────
    {new_frontmatter_yaml}

    ═══════════════════════════════════════════════════════════════"

  IF new_mode == "auto_load":
    EXPLAIN: "Skill will load automatically when working with files matching:
              {glob_list}"

  IF new_mode == "explicit_only":
    EXPLAIN: "Skill will only load when explicitly invoked by name.
              To use: Reference '{skill_name}' in your prompts"

  IF new_mode == "always_active":
    EXPLAIN: "Skill will always be loaded for every conversation."

  USE: AskUserQuestion
  QUESTION: "Apply these changes?"
  OPTIONS:
    - "✅ Yes, apply changes"
    - "❌ No, cancel"

  IF "No":
    EXIT workflow
</instructions>

</step>

<step number="6" name="apply_changes">

### Step 6: Apply Changes

Update the skill file with new frontmatter.

<instructions>
  ACTION: Update skill file

  1. CREATE: Backup file (*-backup.yaml or .old)
  2. READ: Current file content
  3. REPLACE: Frontmatter section
  4. PRESERVE: All content after frontmatter
  5. WRITE: Updated file

  VERIFY: File was written correctly
  LOG: "✓ Updated: {skill_name}"
</instructions>

</step>

<step number="7" name="verify_and_summarize">

### Step 7: Verify and Summarize

Confirm changes and provide next steps.

<instructions>
  VERIFY:
    1. Read updated file
    2. Confirm new frontmatter is valid YAML
    3. Confirm changes match requested mode

  DISPLAY: Success message

    "✅ Skill Activation Updated!

    Skill: {skill_name}
    New Mode: {new_mode_display}

    {mode_specific_message}

    📁 File: {skill_path}
    🔄 Backup: {backup_path}

    Changes will take effect immediately."

  MODE_SPECIFIC_MESSAGES:
    auto_load: "Claude Code will now automatically load this skill when working with:
                {glob_list}"
    explicit_only: "Invoke this skill by mentioning '{skill_name}' in your prompts."
    always_active: "This skill is now always active in all conversations."

  OPTIONAL_OFFERS:
    USE: AskUserQuestion
    QUESTION: "What would you like to do?"
    OPTIONS:
      - "Modify another skill"
      - "View the updated skill file"
      - "Done"

  IF "View skill":
    READ: Updated skill file
    DISPLAY: Full content

  IF "Modify another":
    GOTO: Step 1
</instructions>

</step>

</process_flow>

## Error Handling

<error_protocols>
  <skill_not_found>
    MESSAGE: "Skill '{skill_name}' not found"
    LIST: Available skills
    OFFER: "Try again with different name"
    RETURN_TO: Step 1
  </skill_not_found>

  <invalid_frontmatter>
    MESSAGE: "Skill has invalid YAML frontmatter"
    OFFER: "Run /migrate-skills first to fix frontmatter"
    EXIT: Workflow
  </invalid_frontmatter>

  <invalid_glob_pattern>
    MESSAGE: "Invalid glob pattern: {pattern}"
    EXAMPLE: "Valid patterns: src/**/*.java, **/*.ts"
    ASK: For corrected pattern
    RETRY: Configuration
  </invalid_glob_pattern>

  <file_write_failed>
    MESSAGE: "Failed to update skill file"
    ERROR: {specific_error}
    OFFER: "Check file permissions"
    RESTORE: From backup if created
  </file_write_failed>
</error_protocols>

## Activation Mode Reference

### Auto-Load

**Best for:** Framework-specific or file-type-specific skills

**Frontmatter:**
```yaml
---
name: my-spring-boot-api-patterns
description: "Spring Boot API patterns"
globs:
  - "src/**/*Controller.java"
  - "src/**/*Service.java"
  - "src/**/*Repository.java"
always_apply: false
---
```

**Behavior:** Skill loads when any matching file is open or being edited

### Explicit Only

**Best for:** Utility skills, git workflows, general-purpose skills

**Frontmatter:**
```yaml
---
name: git-workflow
description: "Git workflow patterns"
always_apply: false
---
```

**Behavior:** Skill only loads when you mention it by name

### Always Active

**Best for:** Project standards, coding conventions, core practices

**Frontmatter:**
```yaml
---
name: project-standards
description: "Project coding standards"
always_apply: true
---
```

**Behavior:** Skill is always loaded for every conversation

## Quick Reference for Claude

**When user runs:** `/toggle-skill-activation`

**Execute:**
1. List all skills in `.claude/skills/`
2. Ask user to select which skill to modify
3. Analyze current activation mode
4. Ask user for new mode (auto/explicit/always)
5. If auto-load: Configure globs (detect/custom)
6. Preview before/after changes
7. On approval: Update file with backup
8. Verify and summarize

**When user runs:** `/toggle-skill-activation [skill-name]`

**Execute:**
Same as above, but skip Step 1 (skill already specified)
