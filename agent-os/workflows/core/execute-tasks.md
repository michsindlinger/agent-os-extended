---
description: Rules to initiate execution of a set of tasks using Agent OS
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Task Execution Rules (Phase-Based Architecture)

## Overview

Execute tasks using a **phase-based architecture** optimized for token efficiency.
Each phase is a discrete unit that ends with a pause point for `/clear`.

<architecture>
  <principle>Each phase = One focused task + State persistence + Pause</principle>
  <benefit>Minimal token usage per phase</benefit>
  <benefit>Perfect resumability via Kanban Board</benefit>
  <benefit>No context overflow</benefit>
</architecture>

<pre_flight_check>
  EXECUTE: @~/.agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

---

## Phase Detection (Entry Point)

<phase_detection>
  WHEN /execute-tasks is invoked:

  1. CHECK: Does kanban-board.md exist for any spec?
     ```bash
     ls agent-os/specs/*/kanban-board.md 2>/dev/null | head -1
     ```

  2. IF kanban-board.md EXISTS:
     READ: Resume Context section
     EXTRACT: Current Phase field
     GOTO: Appropriate phase based on state

  3. IF NO kanban-board.md:
     GOTO: Phase 1 (Initialize)

  <phase_routing>
    | Resume Context State | Next Phase |
    |---------------------|------------|
    | No kanban board | Phase 1: Initialize |
    | Phase: 1-complete | Phase 2: Git Branch |
    | Phase: 2-complete | Phase 3: Execute Story |
    | Phase: story-complete | Phase 3: Execute Story (next) |
    | Phase: all-stories-done | Phase 4: Finalize |
  </phase_routing>
</phase_detection>

---

## Phase 1: Initialize (Spec Selection + Kanban Board)

<phase number="1" name="initialize">

### Purpose
Select specification and create Kanban Board. This is a one-time setup phase.

### Entry Condition
- No kanban-board.md exists for target spec

### Actions

<step name="spec_selection">
  CHECK: Did user provide spec name as parameter?

  IF parameter provided:
    VALIDATE: agent-os/specs/[spec-name]/ exists
    SET: SELECTED_SPEC = [spec-name]

  ELSE:
    LIST: Available specs
    ```bash
    ls -1 agent-os/specs/ | sort -r
    ```

    IF 1 spec: CONFIRM with user
    IF multiple: ASK user via AskUserQuestion
</step>

<step name="create_kanban_board" subagent="file-creator">
  USE: file-creator subagent

  PROMPT: "Create kanban board for spec: agent-os/specs/{SELECTED_SPEC}/

  Source: Parse user-stories.md in that folder
  Output: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  Template: agent-os/templates/docs/kanban-board-template.md (global) or agent-os/templates/docs/kanban-board-template.md (project)

  CRITICAL STEPS:
  1. READ user-stories.md
  2. VALIDATE DoR for each story:
     - CHECK: All DoR checkboxes are marked [x] (checked)
     - IF any DoR checkbox is [ ] (unchecked):
       - STORY_STATUS: BLOCKED - Incomplete DoR
       - ADD_NOTE: 'Missing DoR items. Please run /create-spec again to complete technical refinement.'
     - IF all DoR checkboxes are [x]:
       - STORY_STATUS: Ready

  3. PARSE story details into table format
  4. CREATE kanban board with:
     - All valid stories in Backlog
     - Blocked stories marked with status

  CRITICAL: Use the template structure EXACTLY as defined. The template contains:
  - Resume Context section (CRITICAL for phase recovery)
  - Board Status metrics (with exact field names for parsing)
  - Backlog, In Progress, In Review, Testing, Done sections
  - Change Log section

  Template Variables to Replace:
  - {{SPEC_NAME}} → Spec folder name
  - {{SPEC_FOLDER}} → Spec folder name (same)
  - {{TOTAL_STORIES}} → Count from user-stories.md
  - {{COMPLETED_COUNT}} → 0
  - {{IN_PROGRESS_COUNT}} → 0
  - {{IN_REVIEW_COUNT}} → 0
  - {{TESTING_COUNT}} → 0
  - {{BACKLOG_COUNT}} → Count of READY stories (excluding blocked)
  - {{CURRENT_PHASE}} → 1-complete
  - {{NEXT_PHASE}} → 2 - Git Branch
  - {{CURRENT_STORY}} → None
  - {{LAST_ACTION}} → Kanban board created
  - {{NEXT_ACTION}} → Create/switch git branch
  - {{BACKLOG_STORIES}} → All READY stories from user-stories.md in table format
  - {{BLOCKED_STORIES}} → Section for stories with incomplete DoR
  - {{IN_PROGRESS_STORIES}} → (empty section with comment)
  - {{IN_REVIEW_STORIES}} → (empty section with comment)
  - {{TESTING_STORIES}} → (empty section with comment)
  - {{DONE_STORIES}} → (empty section with comment)
  - {{CHANGE_LOG_ENTRIES}} → Initial entry: Board created with DoR validation

  Story Table Format (use for each story section):
  | Story ID | Title | Type | Dependencies | DoR Status | Points |
  |----------|-------|------|--------------|------------|--------|
  | STORY-ID | Story Title | Backend/Frontend/DevOps/Test | None or STORY-ID, STORY-ID | ✅ Ready or ⚠️ Blocked | 1/2/3/5/8 |

  IMPORTANT: The Board Status section MUST be parseable by shell scripts:
  - Use exact field names: Total Stories, Completed, In Progress, In Review, Testing, Backlog
  - Format: **Fieldname**: number

  DoR VALIDATION RULES:
  - Story must have '### Technisches Refinement (vom Architect)' section
  - Under '#### DoR (Definition of Ready)':
    - 'Fachliche Anforderungen' subsection must have all [x] checked
    - 'Technische Vorbereitung' subsection must have all [x] checked
  - If any [ ] (unchecked) found: Mark as BLOCKED with note which items are missing

  OUTPUT VALIDATION:
  - Count total stories from user-stories.md
  - Count stories with complete DoR (ready for execution)
  - Count stories with incomplete DoR (blocked)
  - Report summary to user after creation

  IF BLOCKED stories found:
    ADD_WARNING: '⚠️ Some stories are BLOCKED due to incomplete Definition of Ready.
                   Please run /create-spec again to complete technical refinement.
                   Blocked stories: [list of story IDs]'"

  WAIT: For file-creator completion

  VALIDATE: DoR validation was performed
  CHECK: If any stories were marked as BLOCKED
  IF blocked_stories > 0:
    DISPLAY: Warning about blocked stories
    LIST: Each blocked story with missing DoR items
    OFFER: 'Run /create-spec again to complete technical refinement?'
</step>

### Phase Completion

<phase_complete>
  UPDATE: kanban-board.md Resume Context
    - Current Phase: 1-complete
    - Next Phase: 2 - Git Branch

  OUTPUT to user:
  ---
  ## ✅ Phase 1 Complete: Initialization

  **Created:**
  - Kanban Board: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  - Stories loaded: [X] stories in Backlog

  **Next Phase:** Git Branch Setup

  ---
  **👉 To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 2
</phase_complete>

</phase>

---

## Phase 2: Git Branch Setup

<phase number="2" name="git_branch">

### Purpose
Create or switch to the appropriate git branch for this spec.

### Entry Condition
- kanban-board.md exists
- Resume Context shows: Phase 1-complete or Next Phase = 2

### Actions

<step name="load_resume_context">
  READ: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  EXTRACT: Resume Context section
  VALIDATE: Phase 1 is complete
</step>

<step name="check_dev_server">
  RUN: lsof -i :3000 2>/dev/null | head -5

  IF server running:
    ASK: "Dev server running on port 3000. Shut down? (yes/no)"
    IF yes: Kill server
</step>

<step name="git_branch_management" subagent="git-workflow">
  USE: git-workflow subagent

  PROMPT: "Manage git branch for spec: {SELECTED_SPEC}

  Rules:
  - Extract branch name from spec folder (remove YYYY-MM-DD- prefix)
  - If 'bugfix' in name: use 'bugfix/' prefix
  - Create branch if not exists
  - Switch to branch
  - Handle any uncommitted changes

  Examples:
  - 2026-01-13-multi-delete-projects → multi-delete-projects
  - 2026-01-12-bugfix-login-error → bugfix/login-error
  "

  WAIT: For git-workflow completion
</step>

### Phase Completion

<phase_complete>
  UPDATE: kanban-board.md using template structure
    - Current Phase: 2-complete
    - Next Phase: 3 - Execute Story
    - Last Action: Git branch created/switched
    - Next Action: Select and execute first story
    - Add Change Log entry

  OUTPUT to user:
  ---
  ## ✅ Phase 2 Complete: Git Branch Setup

  **Branch:** [branch-name]
  **Status:** Ready for story execution

  **Next Phase:** Execute First Story

  ---
  **👉 To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 3
</phase_complete>

</phase>

---

## Phase 3: Execute Story (Repeats for Each Story)

<phase number="3" name="execute_story">

### Purpose
Execute ONE user story completely, including quality gates.
This phase repeats for each story in the backlog.

### Entry Condition
- kanban-board.md exists
- Resume Context shows: Phase 2-complete OR story-complete
- Stories remain in Backlog

### Actions

<step name="load_state">
  READ: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  EXTRACT: Resume Context
  IDENTIFY: Next eligible story from Backlog (respecting dependencies)
</step>

<step name="story_selection">
  ANALYZE: Backlog stories
  CHECK: Dependencies for each story

  FOR each story in Backlog:
    IF dependencies = "None" OR all_dependencies_in_done:
      SELECT: This story
      BREAK

  IF no eligible story:
    ERROR: "All remaining stories have unmet dependencies"
    LIST: Blocked stories and their dependencies
</step>

<step name="update_kanban_in_progress">
  UPDATE: kanban-board.md following template structure
    - MOVE: Selected story from Backlog to "In Progress" section
    - UPDATE Board Status:
      - In Progress: +1
      - Backlog: -1
    - SET Resume Context:
      - Current Story = [story-id]
    - ADD Change Log entry with timestamp

  CRITICAL: Maintain exact template structure for shell script parsing
</step>

<step name="execute_story" subagent="dev-team">
  DETERMINE: Agent type from story

  <agent_selection>
    IF story.type = "Backend": SELECT dev-team__backend-developer-*
    IF story.type = "Frontend": SELECT dev-team__frontend-developer-*
    IF story.type = "DevOps": SELECT dev-team__dev-ops-specialist
    IF story.type = "Test": SELECT dev-team__qa-specialist
  </agent_selection>

  DELEGATE via Task tool:
  "Execute User Story: [Story Title]

  **Story Details:**
  [Full story from user-stories.md]

  **DoD Criteria:**
  [DoD checklist - this is completion criteria]

  **File Organization (CRITICAL):**
  ❌ NO files in project root
  ✅ Reports: agent-os/specs/{SELECTED_SPEC}/implementation-reports/
  ✅ Handovers: agent-os/specs/{SELECTED_SPEC}/handover-docs/
  "

  WAIT: For agent completion
</step>

<step name="architect_review" subagent="dev-team__architect">
  UPDATE: kanban-board.md following template structure
    - MOVE: Story from "In Progress" to "In Review" section
    - UPDATE Board Status:
      - In Progress: -1
      - In Review: +1
    - ADD Change Log entry with timestamp

  DELEGATE: dev-team__architect
  "Review code for Story [story-id].

  Context:
  - Story: agent-os/specs/{SELECTED_SPEC}/user-stories.md
  - Git changes: [git status --short output]

  Review: Architecture, patterns, security, code quality.
  "

  IF rejected:
    DELEGATE_BACK: To original agent with feedback
    REPEAT: Until approved
</step>

<step name="ux_review" condition="story.type includes Frontend" subagent="ux-designer">
  DELEGATE: ux-designer
  "UX Review for Story [story-id].

  Review: UX patterns, accessibility, mobile responsiveness.
  "

  IF rejected:
    DELEGATE_BACK: To frontend developer
    REPEAT: Until approved
</step>

<step name="qa_testing" subagent="dev-team__qa-specialist">
  UPDATE: kanban-board.md following template structure
    - MOVE: Story from "In Review" to "Testing" section
    - UPDATE Board Status:
      - In Review: -1
      - Testing: +1
    - ADD Change Log entry with timestamp

  DELEGATE: dev-team__qa-specialist
  "Test Story [story-id]:
  - Run all tests
  - Verify DoD criteria
  - Perform acceptance testing
  "

  IF rejected:
    DELEGATE_BACK: To original agent
    REPEAT: Until approved
</step>

<step name="story_commit" subagent="git-workflow">
  UPDATE: kanban-board.md following template structure
    - MOVE: Story from "Testing" to "Done" section
    - UPDATE Board Status:
      - Testing: -1
      - Completed: +1
    - ADD Change Log entry with timestamp

  USE: git-workflow subagent
  "Commit story [story-id]:
  - Message: feat/fix: [story-id] [Story Title]
  - Push to remote
  "
</step>

### Phase Completion

<phase_complete>
  CHECK: Remaining stories in Backlog

  IF backlog NOT empty:
    UPDATE: kanban-board.md following template structure
      - Resume Context:
        - Current Phase: story-complete
        - Next Phase: 3 - Execute Story (next)
        - Current Story: None
        - Last Action: Story [story-id] completed
        - Next Action: Execute next story
      - ADD Change Log entry with timestamp

    OUTPUT to user:
    ---
    ## ✅ Story Complete: [story-id] - [Story Title]

    **Progress:**
    - Completed: [X] of [TOTAL] stories
    - Remaining: [Y] stories in Backlog

    **Next:** Execute next story

    ---
    **👉 To continue, run:**
    ```
    /clear
    /execute-tasks
    ```
    ---

    STOP: Do not proceed to next story

  ELSE (backlog empty):
    UPDATE: kanban-board.md following template structure
      - Resume Context:
        - Current Phase: all-stories-done
        - Next Phase: 4 - Finalize
        - Current Story: None
        - Last Action: All stories completed
        - Next Action: Create PR
      - ADD Change Log entry with timestamp

    OUTPUT to user:
    ---
    ## ✅ All Stories Complete!

    **Progress:** [TOTAL] of [TOTAL] stories completed

    **Next Phase:** Finalize (PR creation)

    ---
    **👉 To continue, run:**
    ```
    /clear
    /execute-tasks
    ```
    ---

    STOP: Do not proceed to Phase 4
</phase_complete>

</phase>

---

## Phase 4: Finalize (PR Creation + Summary)

<phase number="4" name="finalize">

### Purpose
Create pull request and provide final summary.

### Entry Condition
- kanban-board.md shows: all-stories-done
- All stories in Done column

### Actions

<step name="final_test_run" subagent="test-runner">
  USE: test-runner subagent
  "Run full test suite to verify no regressions"

  IF failures:
    FIX: Before proceeding
</step>

<step name="create_pr" subagent="git-workflow">
  USE: git-workflow subagent
  "Create PR for spec: {SELECTED_SPEC}

  - Commit any remaining changes (kanban-board.md)
  - Push all commits
  - Create PR to main branch
  - Include summary of all stories
  "

  CAPTURE: PR URL
</step>

<step name="roadmap_check">
  CHECK: Did this spec complete a roadmap item?
  IF yes: UPDATE agent-os/product/roadmap.md
</step>

<step name="completion_sound">
  RUN: afplay /System/Library/Sounds/Glass.aiff
</step>

### Phase Completion

<phase_complete>
  UPDATE: kanban-board.md following template structure
    - Resume Context:
      - Current Phase: complete
      - Next Phase: None
      - Last Action: PR created
      - Next Action: None
    - ADD Change Log entry: Spec execution complete

  OUTPUT to user:
  ---
  ## ✅ Spec Execution Complete!

  ### What's Been Done
  [List all completed stories]

  ### Kanban Board Status
  - Completed: [TOTAL] stories
  - View: agent-os/specs/{SELECTED_SPEC}/kanban-board.md

  ### Pull Request
  [PR URL]

  ---
  **Spec execution finished. No further phases.**
  ---
</phase_complete>

</phase>

---

## Resume Context Structure

<resume_context_schema>
  The Resume Context in kanban-board.md follows the template structure.

  **Template Location**:
  - Global: ~/.agent-os/templates/docs/kanban-board-template.md
  - Project: agent-os/templates/docs/kanban-board-template.md

  The Resume Context MUST contain:

  | Field | Description | Example Values |
  |-------|-------------|----------------|
  | **Current Phase** | Phase identifier | 1-complete, 2-complete, story-complete, all-stories-done, complete |
  | **Next Phase** | What to execute next | 2 - Git Branch, 3 - Execute Story, 4 - Finalize, None |
  | **Spec Folder** | Full path | agent-os/specs/2026-01-13-multi-delete-projects |
  | **Current Story** | Story being worked on | MDP-001 or None |
  | **Last Action** | What just happened | Kanban board created |
  | **Next Action** | What needs to happen | Create git branch |

  **Board Status Metrics** (for shell script parsing):
  | Field | Parse Pattern | Example |
  |-------|---------------|---------|
  | **Total Stories** | `Total Stories.*\*\*.*([0-9]+)` | 4 |
  | **Completed** | `Completed.*\*\*.*([0-9]+)` | 2 |
  | **In Progress** | `In Progress.*\*\*.*([0-9]+)` | 0 |
  | **In Review** | `In Review.*\*\*.*([0-9]+)` | 0 |
  | **Testing** | `Testing.*\*\*.*([0-9]+)` | 0 |
  | **Backlog** | `Backlog.*\*\*.*([0-9]+)` | 2 |

  <update_rules>
    UPDATE kanban-board.md at:
    - End of each phase (Resume Context + Change Log)
    - Before any STOP point
    - After any state change (story movement, status change)

    CRITICAL: Always maintain the template structure exactly.
  </update_rules>
</resume_context_schema>

---

## Error Handling

<error_protocols>
  <blocking_issues>
    UPDATE: kanban-board.md → Story status = Blocked
    UPDATE: Resume Context → Last Action = "Blocked: [reason]"
    NOTIFY: User
    STOP: Phase (user can resume after resolving)
  </blocking_issues>

  <agent_failures>
    RETRY: Up to 2 times
    IF still failing:
      UPDATE: Resume Context → Last Action = "Agent failed: [details]"
      ESCALATE: To user
      STOP: Phase
  </agent_failures>
</error_protocols>

---

## Token Optimization Notes

<token_optimization>
  <why_phases>
    - Each phase starts fresh with minimal context
    - Only Resume Context needed to continue
    - No accumulated conversation history
    - Kanban Board is single source of truth
  </why_phases>

  <expected_savings>
    - Old approach: 50K-100K+ tokens per full execution
    - New approach: ~10-20K tokens per phase
    - Result: 3-5x token reduction
  </expected_savings>

  <user_flow>
    1. /execute-tasks → Phase 1 runs → "Run /clear, then /execute-tasks"
    2. /clear
    3. /execute-tasks → Phase 2 runs → "Run /clear, then /execute-tasks"
    4. /clear
    5. /execute-tasks → Phase 3 (Story 1) runs → "Run /clear, then /execute-tasks"
    6. /clear
    7. ... repeat for each story ...
    8. /execute-tasks → Phase 4 runs → "Complete!"
  </user_flow>
</token_optimization>

---

## Quick Reference

<quick_reference>
  | Phase | Purpose | Subagents Used |
  |-------|---------|----------------|
  | 1 | Initialize | file-creator |
  | 2 | Git Branch | git-workflow |
  | 3 | Execute Story | dev-team__*, architect, ux-designer, qa-specialist, git-workflow |
  | 4 | Finalize | test-runner, git-workflow |

  <resume_command>
    After /clear, simply run /execute-tasks again.
    Phase detection automatically routes to correct phase.
  </resume_command>
</quick_reference>
