---
description: Migration plan for adding YAML frontmatter to Specwright skills
version: 1.0
encoding: UTF-8
---

# Skill YAML Frontmatter Migration Plan

## Problem Statement

Current DevTeam skill templates generate skills without proper YAML frontmatter. The `build-development-team` workflow creates skills but doesn't ensure the frontmatter is correctly populated, particularly the `globs` field for auto-activation.

## Current State Analysis

### What Works
- `generate-frontmatter.md` exists with proper YAML generation logic
- `assemble-skill.md` knows how to combine frontmatter + content
- `/add-skill` command properly generates frontmattered skills

### What Doesn't Work
- DevTeam skill templates in `specwright/templates/skills/dev-team/*/SKILL.md` have placeholder frontmatter
- `build-development-team.md` Step 6 generates skills but doesn't invoke frontmatter generation
- No mechanism to add `globs` for auto-activation
- Existing skills in projects lack proper frontmatter

## Solution Architecture

### Phase 1: Update Skill Templates

**File**: `specwright/templates/skills/skill/SKILL.md`

Update the template with proper frontmatter structure:

```yaml
---
name: [SKILL_NAME]
description: [SKILL_DESCRIPTION]
version: 1.0
created: [CURRENT_DATE]
encoding: UTF-8
[globs_section]
---

# [SKILL_NAME]

[REST_OF_CONTENT]
```

**Key Changes**:
1. Replace placeholder variables with clear bracketed names
2. Add `globs` section documentation
3. Include `created` date placeholder

### Phase 2: Update build-development-team Workflow

**File**: `specwright/workflows/core/build-development-team.md`

**Step 6 Enhancement**:

Add frontmatter generation before skill creation:

```markdown
<step number="6" subagent="file-creator" name="generate_skills">

### Step 6: Generate Tech-Stack-Specific Skills

<skill_generation_process>
  FOR EACH created agent:

    FOR EACH skill template:
      1. LOAD skill template (hybrid lookup: project → global)
      2. READ tech-stack.md for framework information
      3. GENERATE YAML frontmatter:
         - Use skill name format: [PROJECT]-[AGENT]-[SKILL]
         - Generate description from template content
         - Add framework-specific globs
         - Set created date
      4. FILL [TECH_STACK_SPECIFIC] sections
      5. FILL [MCP_TOOLS] placeholder
      6. CREATE directory: .claude/skills/[PROJECT]-[agent]-[skill]/
      7. WRITE to .claude/skills/[PROJECT]-[agent]-[skill]/SKILL.md
```

**New Frontmatter Generation Logic**:

```markdown
<frontmatter_generation>
  FOR EACH skill:
    skill_name = "[PROJECT]-[AGENT_ROLE]-[SKILL_NAME]"

    description = "[AGENT_ROLE] [SKILL_NAME] skill for [PROJECT_NAME]. Use when: [TRIGGER_CONDITIONS]"

    globs = framework_globs[framework][skill_type]

    frontmatter = """---
name: {skill_name}
description: {description}
version: 1.0
created: {current_date}
encoding: UTF-8
globs:
{globs_yaml}
---"""
</frontmatter_generation>
```

### Phase 3: Globs Mapping Table

**New File**: `specwright/workflows/skill/utils/globs-mapping.md`

Define framework-specific globs for each skill type:

```markdown
# Globs Mapping by Framework

## Backend Skills

### Spring Boot
- logic-implementing: `src/**/*Service.java`, `src/**/service/**/*.java`
- persistence-adapter: `src/**/*Repository.java`, `src/**/repository/**/*.java`
- integration-adapter: `src/**/*Client.java`, `src/**/client/**/*.java`
- test-engineering: `src/test/**/*Test.java`, `src/test/**/*Tests.java`

### Rails
- logic-implementing: `app/services/**/*.rb`
- persistence-adapter: `app/models/**/*.rb`
- integration-adapter: `app/services/**/*_client.rb`
- test-engineering: `spec/**/*_spec.rb`

## Frontend Skills

### React
- ui-component-architecture: `src/**/*.{tsx,jsx}`, `src/components/**/*`
- state-management: `src/**/context/**/*`, `src/**/store/**/*`
- api-bridge-building: `src/**/api/**/*.{ts,js}`
- interaction-designing: `src/**/*.{tsx,jsx}`

### Angular
- ui-component-architecture: `src/**/*.component.ts`
- state-management: `src/**/*.service.ts`
- api-bridge-building: `src/**/services/**/*`
- interaction-designing: `src/**/*.component.ts`

## DevOps Skills

- infrastructure-provisioning: `terraform/**/*`, `k8s/**/*`, `docker/**/*`
- pipeline-engineering: `.github/workflows/**/*`, `.gitlab-ci.yml`, `Jenkinsfile*`
- observability-management: `prometheus/**/*`, `grafana/**/*`, `**/monitoring/**/*`

## QA Skills

- test-strategy: `**/test-plan.md`, `**/testing-strategy.md`
- test-automation: `tests/**/*`, `e2e/**/*`, `spec/**/*`
```

### Phase 4: Existing Skills Migration Tool

**New Workflow**: `/migrate-skills`

**Purpose**: Add YAML frontmatter to existing skills in projects

**Process**:

```markdown
# Migrate Skills Workflow

## Overview
Scan existing skills in `.claude/skills/` and add missing YAML frontmatter.

## Process

<step number="1" name="scan_skills">
### Step 1: Scan for Skills

USE: Glob tool to find all skills:
- Pattern: `.claude/skills/**/SKILL.md`
- Also: `.claude/skills/*.md` (old format)

COLLECT: All skill files needing migration
</step>

<step number="2" name="analyze_skill">
### Step 2: Analyze Each Skill

FOR EACH skill file:
  READ: File content
  CHECK: Has YAML frontmatter (starts with ---)
  IF no frontmatter OR incomplete frontmatter:
    EXTRACT: Skill content
    DETECT: Skill type from content/folder name
    DETERMINE: Appropriate globs
    ADD to migration queue
</step>

<step number="3" name="generate_frontmatter">
### Step 3: Generate Frontmatter

FOR EACH skill in migration queue:
  skill_name = extract from folder name or filename
  description = generate from first heading or content summary
  framework = detect from tech-stack.md or content
  globs = lookup from globs-mapping.md

  GENERATE: YAML frontmatter
</step>

<step number="4" name="update_file">
### Step 4: Update Skill File

FOR EACH skill:
  PREPEND: Generated frontmatter
  PRESERVE: Existing content
  CREATE: Backup (*.old)
  WRITE: Updated file
</step>

<step number="5" name="verify">
### Step 5: Verify Migration

VALIDATE:
- All skills have required frontmatter fields
- No content lost
- Proper YAML syntax

REPORT: Migration summary
</step>
```

### Phase 5: Toggling Auto-Load vs Explicit

**New Workflow**: `/toggle-skill-activation`

**Purpose**: Change skill activation mode between auto-load and explicit

**Interface**:

```markdown
# Toggle Skill Activation

## Usage
`/toggle-skill-activation [skill-name]`

## Process

1. LOAD: skill file
2. DISPLAY: Current activation mode
   - If has `globs`: "Auto-Load for: [globs]"
   - If no `globs`: "Explicit invocation only"
   - If `always_apply: true`: "Always active"
3. ASK: What mode do you want?
   - "Auto-Load (specify file patterns)"
   - "Explicit only (remove globs)"
   - "Always active (set always_apply)"
4. UPDATE: skill file accordingly
```

## Implementation Order

1. ✅ **Create spec** (done - this file)
2. **Update skill template** (`specwright/templates/skills/skill/SKILL.md`)
3. **Create globs mapping** (`specwright/workflows/skill/utils/globs-mapping.md`)
4. **Update build-development-team workflow**
5. **Create /migrate-skills command**
6. **Create /toggle-skill-activation command**
7. **Test on existing projects**

## Testing Strategy

1. **Unit Tests**: Test frontmatter generation logic
2. **Integration Tests**: Test full build-development-team workflow
3. **Migration Tests**: Test on sample projects with existing skills
4. **Manual Tests**: Verify Claude Code loads skills correctly

## Rollback Plan

If migration causes issues:
1. Backups created automatically (*.old files)
2. Git revert available
3. Can selectively migrate specific skills

## Success Criteria

- ✅ All new skills have proper YAML frontmatter
- ✅ All skills have appropriate `globs` for auto-activation
- ✅ Existing skills can be migrated safely
- ✅ Skills can be toggled between activation modes
- ✅ Claude Code recognizes and loads all skills
