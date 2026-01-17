---
description: Add quick task to backlog with lightweight PO + Architect refinement
globs:
alwaysApply: false
version: 1.1
encoding: UTF-8
---

# Add Todo Workflow

## Overview

Add a lightweight task to the backlog without full spec creation. Uses same story template as create-spec but with minimal overhead.

**Use Cases:**
- Small UI tweaks (e.g., "Add loading state to modal")
- Minor bug fixes
- Quick enhancements
- Tasks that don't warrant full specification

<pre_flight_check>
  EXECUTE: agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="backlog_setup">

### Step 1: Backlog Setup

<mandatory_actions>
  1. CHECK: Does agent-os/backlog/ directory exist?
     ```bash
     ls -la agent-os/backlog/ 2>/dev/null
     ```

  2. IF NOT exists:
     CREATE: agent-os/backlog/ directory
     CREATE: agent-os/backlog/story-index.md (from template)

     <template_lookup>
       PATH: backlog-story-index-template.md

       LOOKUP STRATEGY (Hybrid):
         1. TRY: agent-os/templates/docs/backlog-story-index-template.md
         2. IF NOT FOUND: ~/.agent-os/templates/docs/backlog-story-index-template.md
         3. IF STILL NOT FOUND: Error - run setup-devteam-global.sh
     </template_lookup>

  3. USE: date-checker to get current date (YYYY-MM-DD)

  4. DETERMINE: Next story index for today
     COUNT: Existing stories with today's date prefix
     ```bash
     ls agent-os/backlog/ | grep "^$(date +%Y-%m-%d)" | wc -l
     ```
     NEXT_INDEX = count + 1 (formatted as 3 digits: 001, 002, etc.)

  5. GENERATE: Story ID = YYYY-MM-DD-[INDEX]
     Example: 2025-01-15-001, 2025-01-15-002
</mandatory_actions>

</step>

<step number="2" name="po_quick_dialog">

### Step 2: PO Phase - Quick Requirements Dialog

⚠️ **LIGHTWEIGHT:** Unlike create-spec, this is a brief dialog (2-4 questions max).

<mandatory_actions>
  1. IF user provided task description in command:
     EXTRACT: Task description from input

  2. ASK quick clarifying questions (only if needed):
     - What exactly should be done? (if unclear)
     - Where in the app? (which component/page)
     - Any special acceptance criteria?

  3. DETERMINE: Story type
     - Frontend (UI changes)
     - Backend (API/Logic changes)
     - DevOps (Infrastructure)
     - Test (Test additions)

  4. KEEP IT BRIEF:
     - No extensive requirements gathering
     - No clarification document
     - Direct to story creation
</mandatory_actions>

</step>

<step number="3" name="create_story_file">

### Step 3: Create User Story File

<mandatory_actions>
  1. GENERATE: File name
     FORMAT: user-story-[YYYY-MM-DD]-[INDEX]-[slug].md
     Example: user-story-2025-01-15-001-loading-state-modal.md

  2. USE: story-template.md (same as create-spec)

     <template_lookup>
       PATH: story-template.md

       LOOKUP STRATEGY (Hybrid):
         1. TRY: agent-os/templates/docs/story-template.md
         2. IF NOT FOUND: ~/.agent-os/templates/docs/story-template.md
         3. IF STILL NOT FOUND: Error - run setup-devteam-global.sh
     </template_lookup>

  3. FILL fachliche content (PO perspective):
     - Story Title
     - Als [User] möchte ich [Aktion], damit [Nutzen]
     - Fachliche acceptance criteria (2-4 items, keep brief)
     - Priority: Low/Medium/High
     - Type: Frontend/Backend/DevOps/Test

  4. LEAVE technical sections EMPTY:
     - DoR/DoD checkboxes (unchecked)
     - WAS/WIE/WO/WER fields
     - Completion Check commands

  5. WRITE: Story file to agent-os/backlog/
</mandatory_actions>

<story_file_structure>
  agent-os/backlog/user-story-YYYY-MM-DD-[INDEX]-[slug].md
</story_file_structure>

</step>

<step number="4" subagent="dev-team__architect" name="architect_refinement">

### Step 4: Architect Phase - Technical Refinement

<delegation>
  DELEGATE to dev-team__architect via Task tool:

  PROMPT:
  "Add technical refinement to backlog story.

  Story File: agent-os/backlog/user-story-[YYYY-MM-DD]-[INDEX]-[slug].md

  Context:
  - Tech Stack: agent-os/product/tech-stack.md
  - Architecture: agent-os/product/architecture-decision.md (if exists)
  - Architecture Structure: agent-os/product/architecture-structure.md (if exists)
  - Definition of Ready: agent-os/team/dor.md (if exists)
  - Definition of Done: agent-os/team/dod.md (if exists)

  Available DevTeam Agents:
  - List agents from .claude/agents/dev-team/

  Tasks:
  1. READ the story file
  2. ANALYZE the fachliche requirements
  3. FILL technical sections:

     **DoR (Definition of Ready):**
     - Load project DoR from agent-os/team/dor.md (if exists)
     - Apply relevant DoR criteria to this story
     - Mark ALL checkboxes as [x] when complete

     **DoD (Definition of Done):**
     - Load project DoD from agent-os/team/dod.md (if exists)
     - Apply relevant DoD criteria to this story
     - Define completion criteria (start unchecked [ ])

     **Technical Details:**
     - WAS: Components to create/modify (brief)
     - WIE: Architecture guidance only (NO code)
     - WO: File paths to modify
     - WER: Which agent (e.g., dev-team__frontend-developer)
     - Abhängigkeiten: None (backlog stories are independent)
     - Geschätzte Komplexität: XS or S (if larger, suggest create-spec)

     **Completion Check:**
     - Add bash verify commands

  4. IF story seems too large (>5 files, >400 LOC):
     WARN: 'This task may be too complex for /add-todo. Consider /create-spec instead.'
     ASK: 'Proceed anyway or switch to /create-spec?'

  IMPORTANT:
  - Keep it lightweight - this is a quick task
  - Add ONLY technical sections
  - Do NOT modify fachliche descriptions
  - Mark ALL DoR checkboxes as [x] complete
  - Backlog stories should be XS or S complexity"

  WAIT for dev-team__architect completion
</delegation>

</step>

<step number="4.5" name="story_size_validation">

### Step 4.5: Story Size Validation

Validate that the task complies with size guidelines for single-session execution.

<validation_process>
  READ: The story file from agent-os/backlog/user-story-[...].md

  <extract_metrics>
    ANALYZE: WO (Where) field
      COUNT: Number of file paths mentioned
      EXTRACT: File paths list

    ANALYZE: Geschätzte Komplexität field
      EXTRACT: Complexity rating (XS/S/M/L/XL)

    ANALYZE: WAS (What) field
      ESTIMATE: Lines of code based on components mentioned
      HEURISTIC:
        - Each new file/component ~100-150 lines
        - Each modified file ~50-100 lines
        - Tests ~50-100 lines per test file
  </extract_metrics>

  <check_thresholds>
    CHECK: Number of files
      IF files > 5:
        FLAG: Task as "Too Large - File Count"
        SEVERITY: High

    CHECK: Complexity rating
      IF complexity in [M, L, XL]:
        FLAG: Task as "Too Complex for /add-todo"
        SEVERITY: High

    CHECK: Estimated LOC
      IF estimated_loc > 400:
        FLAG: Task as "Too Large - Code Volume"
        SEVERITY: High
      ELSE IF estimated_loc > 300:
        FLAG: Task as "Watch - Approaching Limit"
        SEVERITY: Low

    CHECK: Cross-layer detection
      IF WO contains backend AND frontend paths:
        FLAG: Task as "Multi-Layer"
        SEVERITY: Medium
        SUGGEST: "Consider /create-spec for multi-layer tasks"
  </check_thresholds>
</validation_process>

<decision_tree>
  IF no flags raised OR only low severity:
    LOG: "✅ Task passes size validation - appropriate for /add-todo"
    PROCEED: To Step 5 (Update Story Index)

  ELSE (task flagged with Medium/High severity):
    GENERATE: Validation Report

    <validation_report_format>
      ⚠️ Task Size Validation - Issues Detected

      **Task:** [Story Title]
      **File:** [Story file path]

      **Metrics:**
      - Files: [count] (max recommended: 5) [✅/❌]
      - Complexity: [rating] (max recommended: S) [✅/❌]
      - Est. LOC: ~[count] (max recommended: 400) [✅/❌]
      - Cross-layer: [Yes/No] [✅/⚠️]

      **Issue:** [Description of what exceeds guidelines]

      **Why this matters:**
      - /add-todo is designed for quick, small tasks
      - Larger tasks benefit from full specification process
      - Full specs provide better planning, dependencies, and integration stories

      **Recommendation:** Use /create-spec instead for:
      - Better requirements clarification
      - Proper story splitting
      - Dependency mapping
      - Integration story generation
    </validation_report_format>

    PRESENT: Validation Report to user

    ASK user via AskUserQuestion:
    "This task exceeds /add-todo size guidelines. How would you like to proceed?

    Options:
    1. Switch to /create-spec (Recommended)
       → Full specification with proper planning
       → Story splitting if needed
       → Better context efficiency

    2. Edit task to reduce scope
       → Modify the story file manually
       → Re-run validation after edits

    3. Proceed anyway
       → Accept higher context usage
       → Risk mid-execution context compaction
       → Continue with current task"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Switch to /create-spec":
        INFORM: "Switching to /create-spec workflow.
                 The task description will be used as starting point."

        DELETE: The backlog story file (optional cleanup)

        INVOKE: /create-spec with task description
        STOP: This workflow

      ELSE IF choice = "Edit task to reduce scope":
        INFORM: "Please edit the story file: agent-os/backlog/[story-file].md"
        INFORM: "Reduce the scope by:
                 - Fewer files in WO section
                 - Smaller complexity rating
                 - Narrower focus on core functionality"
        PAUSE: Wait for user to edit
        ASK: "Ready to re-validate? (yes/no)"
        IF yes:
          REPEAT: Step 4.5 (this validation step)
        ELSE:
          PROCEED: To Step 5 with warning flag

      ELSE IF choice = "Proceed anyway":
        WARN: "⚠️ Proceeding with oversized task
               - Expect higher token costs
               - Mid-execution compaction possible
               - Consider breaking into smaller tasks next time"
        LOG: Validation bypassed by user
        PROCEED: To Step 5
    </user_choice_handling>
</decision_tree>

<instructions>
  ACTION: Validate task against size guidelines
  CHECK: File count, complexity, estimated LOC, cross-layer detection
  THRESHOLD: Max 5 files, max S complexity, max 400 LOC
  REPORT: Issues found with specific recommendations
  OFFER: Three options (switch to create-spec, edit, proceed)
  ENFORCE: Validation before adding to backlog
</instructions>

**Output:**
- Validation report (if issues found)
- User decision on how to proceed
- Task either validated, edited, or escalated to /create-spec

</step>

<step number="5" name="update_story_index">

### Step 5: Update Backlog Story Index

<mandatory_actions>
  1. READ: agent-os/backlog/story-index.md

  2. ADD new story to Story Summary table:
     | Story ID | Title | Type | Priority | Dependencies | Status | Points |

  3. UPDATE totals:
     - Total Stories: +1
     - Backlog Count: +1

  4. UPDATE: Last Updated date

  5. WRITE: Updated story-index.md
</mandatory_actions>

</step>

<step number="6" name="completion_summary">

### Step 6: Task Added Confirmation

⚠️ **Note:** Only reached if task passed size validation (Step 4.5)

<summary_template>
  ✅ Task added to backlog!

  **Story ID:** [YYYY-MM-DD-INDEX]
  **File:** agent-os/backlog/user-story-[YYYY-MM-DD]-[INDEX]-[slug].md

  **Summary:**
  - Title: [Story Title]
  - Type: [Frontend/Backend/etc.]
  - Complexity: [XS/S]
  - Status: Ready

  **Backlog Status:**
  - Total tasks: [N]
  - Ready for execution: [N]

  **Next Steps:**
  1. Add more tasks: /add-todo "[description]"
  2. Execute backlog: /execute-tasks backlog
  3. View backlog: agent-os/backlog/story-index.md
</summary_template>

</step>

</process_flow>

## Final Checklist

<verify>
  - [ ] Backlog directory exists
  - [ ] Story file created with correct naming
  - [ ] Story ID format: YYYY-MM-DD-[INDEX]
  - [ ] Fachliche content complete (brief)
  - [ ] Technical refinement complete
  - [ ] All DoR checkboxes marked [x]
  - [ ] **Story size validation passed (Step 4.5)**
  - [ ] Story-index.md updated
  - [ ] Ready for /execute-tasks backlog
</verify>

## When NOT to Use /add-todo

Suggest /create-spec instead when:
- Task requires multiple stories
- Task needs clarification document
- Estimated complexity > S
- Task affects >5 files
- Task needs extensive requirements gathering
- Task is a major feature
