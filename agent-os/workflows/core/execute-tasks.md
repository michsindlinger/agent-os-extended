---
description: Rules to initiate execution of a set of tasks using Agent OS
globs:
alwaysApply: false
version: 2.1
encoding: UTF-8
---

# Task Execution Rules (Phase-Based Architecture)

## Overview

Execute tasks using a **phase-based architecture** optimized for token efficiency.
Each phase is a discrete unit that ends with a pause point for `/clear`.

**Supports two modes:**
- **Spec Mode**: Full feature execution from `agent-os/specs/[spec-name]/`
- **Backlog Mode**: Quick task execution from `agent-os/backlog/`

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

## Execution Mode Detection (Entry Point)

<mode_detection>
  WHEN /execute-tasks is invoked:

  1. CHECK: Was a parameter provided?

     IF parameter = "backlog":
       SET: EXECUTION_MODE = "backlog"
       GOTO: Backlog Mode Detection

     ELSE IF parameter = [spec-name]:
       SET: EXECUTION_MODE = "spec"
       SET: SELECTED_SPEC = [spec-name]
       GOTO: Spec Mode Detection

     ELSE (no parameter):
       GOTO: User Mode Selection

  <user_mode_selection>
    CHECK: Are there active kanban boards?

    ```bash
    # Check for active spec kanbans
    SPEC_KANBANS=$(ls agent-os/specs/*/kanban-board.md 2>/dev/null | head -5)

    # Check for active backlog kanban (today)
    TODAY=$(date +%Y-%m-%d)
    BACKLOG_KANBAN=$(ls agent-os/backlog/kanban-${TODAY}.md 2>/dev/null)

    # Check for pending backlog stories
    BACKLOG_STORIES=$(ls agent-os/backlog/user-story-*.md 2>/dev/null | wc -l)
    ```

    IF active kanban exists (spec or backlog):
      DETECT: Which kanban is active
      RESUME: That execution automatically

    ELSE IF backlog has stories AND specs exist:
      ASK via AskUserQuestion:
      "What would you like to execute?

      Options:
      1. Execute Backlog ([N] quick tasks)
         → Run tasks from agent-os/backlog/
         → Creates daily kanban

      2. Execute Spec
         → Select from available specifications
         → Full feature execution

      3. View status only
         → Show backlog and spec status
         → No execution"

    ELSE IF only backlog has stories:
      SET: EXECUTION_MODE = "backlog"
      GOTO: Backlog Mode Detection

    ELSE IF only specs exist:
      SET: EXECUTION_MODE = "spec"
      GOTO: Spec Mode Detection

    ELSE:
      ERROR: "No tasks to execute. Use /add-todo or /create-spec first."
  </user_mode_selection>
</mode_detection>

---

## Backlog Mode Detection

<backlog_mode_detection>
  WHEN EXECUTION_MODE = "backlog":

  1. USE: date-checker to get current date (YYYY-MM-DD)

  2. CHECK: Does today's kanban exist?
     ```bash
     ls agent-os/backlog/kanban-${TODAY}.md 2>/dev/null
     ```

  3. IF kanban exists:
     READ: Resume Context section
     EXTRACT: Current Phase field
     GOTO: Appropriate backlog phase based on state

  4. IF NO kanban:
     GOTO: Backlog Phase 1 (Initialize Daily Kanban)

  <backlog_phase_routing>
    | Resume Context State | Next Phase |
    |---------------------|------------|
    | No kanban | Backlog Phase 1: Initialize Daily Kanban |
    | Phase: 1-complete | Backlog Phase 2: Execute Story |
    | Phase: story-complete | Backlog Phase 2: Execute Story (next) |
    | Phase: all-stories-done | Backlog Phase 3: Daily Summary |
  </backlog_phase_routing>

  NOTE: Backlog mode does NOT use git worktrees (works on current branch)
</backlog_mode_detection>

---

## Spec Mode Detection

<spec_mode_detection>
  WHEN EXECUTION_MODE = "spec":

  1. CHECK: Does kanban-board.md exist for target/any spec?
     ```bash
     ls agent-os/specs/*/kanban-board.md 2>/dev/null | head -1
     ```

  2. IF kanban-board.md EXISTS:
     READ: Resume Context section
     EXTRACT: Current Phase field
     GOTO: Appropriate spec phase based on state

  3. IF NO kanban-board.md:
     GOTO: Spec Phase 1 (Initialize)

  <spec_phase_routing>
    | Resume Context State | Next Phase |
    |---------------------|------------|
    | No kanban board | Phase 1: Initialize |
    | Phase: 1-complete | Phase 2: Git Worktree |
    | Phase: 2-complete | Phase 3: Execute Story |
    | Phase: story-complete | Phase 3: Execute Story (next) |
    | Phase: all-stories-done | Phase 4.5: Integration Validation |
    | Phase: 5-ready | Phase 5: Finalize |
  </spec_phase_routing>
</spec_mode_detection>

---

# BACKLOG MODE PHASES

---

## Backlog Phase 1: Initialize Daily Kanban

<backlog_phase number="1" name="initialize_daily_kanban">

### Purpose
Create today's Kanban Board for backlog execution. Daily kanbans keep tasks organized.

### Entry Condition
- EXECUTION_MODE = "backlog"
- No kanban-[TODAY].md exists in agent-os/backlog/

### Actions

<step name="get_today_date">
  USE: date-checker to get current date
  SET: TODAY = YYYY-MM-DD
</step>

<step name="collect_ready_stories">
  LIST: All ready stories in backlog
  ```bash
  ls agent-os/backlog/user-story-*.md 2>/dev/null
  ```

  FOR EACH story file:
    READ: Story file
    CHECK: DoR status (all [x] checked?)
    IF DoR complete:
      ADD: To ready_stories list
    ELSE:
      ADD: To blocked_stories list
</step>

<step name="create_daily_kanban" subagent="file-creator">
  USE: file-creator subagent

  PROMPT: "Create daily kanban board for backlog execution.

  Output: agent-os/backlog/kanban-{TODAY}.md

  Content Structure:
  ```markdown
  # Backlog Kanban - {TODAY}

  > Daily task execution board
  > Created: {TODAY}

  ## Resume Context

  | Field | Value |
  |-------|-------|
  | **Execution Mode** | Backlog |
  | **Current Phase** | 1-complete |
  | **Next Phase** | 2 - Execute Story |
  | **Current Story** | None |
  | **Last Action** | Daily kanban created |
  | **Next Action** | Execute first story |

  ---

  ## Board Status

  - **Total Stories**: {TOTAL}
  - **Completed**: 0
  - **In Progress**: 0
  - **Backlog**: {READY_COUNT}
  - **Blocked**: {BLOCKED_COUNT}

  ---

  ## Backlog

  | Story ID | Title | Type | Priority | Points |
  |----------|-------|------|----------|--------|
  {READY_STORIES_TABLE}

  ---

  ## In Progress

  <!-- Currently executing story -->

  ---

  ## Done

  <!-- Completed stories today -->

  ---

  ## Blocked

  {BLOCKED_STORIES_TABLE}

  ---

  ## Change Log

  | Time | Action |
  |------|--------|
  | {TIMESTAMP} | Daily kanban created with {TOTAL} stories |
  ```

  Replace placeholders with actual values from collected stories."

  WAIT: For file-creator completion
</step>

### Phase Completion

<phase_complete>
  OUTPUT to user:
  ---
  ## ✅ Backlog Phase 1 Complete: Daily Kanban Created

  **Date:** {TODAY}
  **Stories Ready:** {READY_COUNT}
  **Blocked:** {BLOCKED_COUNT}

  **Kanban:** agent-os/backlog/kanban-{TODAY}.md

  **Next Phase:** Execute First Story

  ---
  **👉 To continue, run:**
  ```
  /clear
  /execute-tasks backlog
  ```
  ---

  STOP: Do not proceed to Backlog Phase 2
</phase_complete>

</backlog_phase>

---

## Backlog Phase 2: Execute Story (Repeats for Each Story)

<backlog_phase number="2" name="execute_backlog_story">

### Purpose
Execute ONE backlog story. Simpler than spec execution (no git worktree, no integration phase).

### Entry Condition
- kanban-[TODAY].md exists
- Resume Context shows: Phase 1-complete OR story-complete
- Stories remain in Backlog

### Actions

<step name="load_state">
  READ: agent-os/backlog/kanban-{TODAY}.md
  EXTRACT: Resume Context
  IDENTIFY: Next story from Backlog
</step>

<step name="story_selection">
  SELECT: First story from Backlog section
  (Backlog stories have no dependencies - execute in order)
</step>

<step name="update_kanban_in_progress">
  UPDATE: kanban-{TODAY}.md
    - MOVE: Selected story from Backlog to "In Progress"
    - UPDATE Board Status
    - SET Resume Context: Current Story = [story-id]
    - ADD Change Log entry
</step>

<step name="execute_story" subagent="dev-team">
  DETERMINE: Agent type from story.type

  <agent_selection>
    IF story.type = "Backend": SELECT dev-team__backend-developer-*
    IF story.type = "Frontend": SELECT dev-team__frontend-developer-*
    IF story.type = "DevOps": SELECT dev-team__dev-ops-specialist
    IF story.type = "Test": SELECT dev-team__qa-specialist
  </agent_selection>

  DELEGATE via Task tool:
  "Execute Backlog Story: [Story Title]

  **Story File:** agent-os/backlog/user-story-{STORY_ID}-[slug].md

  **DoD Criteria:**
  [DoD checklist from story file]

  **IMPORTANT:**
  - This is a quick task, keep it focused
  - No extensive refactoring
  - Commit when done
  "

  WAIT: For agent completion
</step>

<step name="quick_review">
  VERIFY: DoD criteria met
  RUN: Completion Check commands from story

  IF all pass:
    PROCEED: To commit
  ELSE:
    DELEGATE_BACK: To agent with feedback
</step>

<step name="story_commit" subagent="git-workflow">
  UPDATE: kanban-{TODAY}.md
    - MOVE: Story from "In Progress" to "Done"
    - UPDATE Board Status
    - ADD Change Log entry

  USE: git-workflow subagent
  "Commit backlog story {STORY_ID}:
  - Message: fix/feat: {STORY_ID} [Story Title]
  - Stage only relevant files
  - Push to current branch
  "
</step>

### Phase Completion

<phase_complete>
  CHECK: Remaining stories in Backlog

  IF backlog NOT empty:
    UPDATE: kanban-{TODAY}.md Resume Context
      - Current Phase: story-complete
      - Next Phase: 2 - Execute Story (next)
      - Current Story: None

    OUTPUT to user:
    ---
    ## ✅ Story Complete: {STORY_ID}

    **Progress:** {COMPLETED} of {TOTAL} stories today

    **Next:** Execute next story

    ---
    **👉 To continue, run:**
    ```
    /clear
    /execute-tasks backlog
    ```
    ---

    STOP: Do not proceed to next story

  ELSE (backlog empty):
    UPDATE: kanban-{TODAY}.md Resume Context
      - Current Phase: all-stories-done
      - Next Phase: 3 - Daily Summary

    OUTPUT to user:
    ---
    ## ✅ All Backlog Stories Complete!

    **Today's Progress:** {TOTAL} stories completed

    **Next Phase:** Daily Summary

    ---
    **👉 To continue, run:**
    ```
    /clear
    /execute-tasks backlog
    ```
    ---

    STOP: Do not proceed to Backlog Phase 3
</phase_complete>

</backlog_phase>

---

## Backlog Phase 3: Daily Summary

<backlog_phase number="3" name="daily_summary">

### Purpose
Summarize today's work and update story-index.

### Entry Condition
- kanban-{TODAY}.md shows: all-stories-done
- All stories in Done column

### Actions

<step name="update_story_index">
  READ: agent-os/backlog/story-index.md

  FOR EACH completed story:
    UPDATE: Status = "Done"
    UPDATE: Completed date

  UPDATE: Totals
    - Completed: +N
    - Ready for Execution: -N

  ADD: Today's kanban to Execution History table

  WRITE: Updated story-index.md
</step>

<step name="archive_completed_stories">
  OPTIONAL: Move completed story files to archive
  ```bash
  mkdir -p agent-os/backlog/archive/{TODAY}
  mv agent-os/backlog/user-story-{TODAY}-*.md agent-os/backlog/archive/{TODAY}/
  ```

  NOTE: Keep story files accessible for reference
</step>

### Phase Completion

<phase_complete>
  UPDATE: kanban-{TODAY}.md Resume Context
    - Current Phase: complete
    - Next Phase: None

  OUTPUT to user:
  ---
  ## ✅ Daily Backlog Execution Complete!

  ### Today's Summary ({TODAY})

  **Completed Stories:**
  {LIST_OF_COMPLETED_STORIES}

  **Kanban:** agent-os/backlog/kanban-{TODAY}.md

  ### What's Next?
  1. Add more tasks: `/add-todo "[description]"`
  2. Create spec for larger features: `/create-spec`
  3. Tomorrow: `/execute-tasks backlog` for new daily kanban

  ---
  **Backlog execution finished for today.**
  ---
</phase_complete>

</backlog_phase>

---

# SPEC MODE PHASES

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

  Source: Parse story files in stories/ directory (NOT user-stories.md)
  Output: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  Template: agent-os/templates/docs/kanban-board-template.md (global) or agent-os/templates/docs/kanban-board-template.md (project)

  CRITICAL STEPS:
  1. LIST all story files in agent-os/specs/{SELECTED_SPEC}/stories/
  2. FOR EACH story file:
     - READ the story file
     - VALIDATE DoR for each story:
       * CHECK: All DoR checkboxes are marked [x] (checked)
       * IF any DoR checkbox is [ ] (unchecked):
         - STORY_STATUS: BLOCKED - Incomplete DoR
         - ADD_NOTE: 'Missing DoR items. Please run /create-spec again to complete technical refinement.'
       * IF all DoR checkboxes are [x]:
         - STORY_STATUS: Ready
     - EXTRACT: Story ID, Title, Type, Dependencies, Points

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
  - {{TOTAL_STORIES}} → Count from story files
  - {{COMPLETED_COUNT}} → 0
  - {{IN_PROGRESS_COUNT}} → 0
  - {{IN_REVIEW_COUNT}} → 0
  - {{TESTING_COUNT}} → 0
  - {{BACKLOG_COUNT}} → Count of READY stories (excluding blocked)
  - {{BLOCKED_COUNT}} → Count of BLOCKED stories (incomplete DoR)
  - {{CURRENT_PHASE}} → 1-complete
  - {{NEXT_PHASE}} → 2 - Git Worktree
  - {{WORKTREE_PATH}} → Pending (set in Phase 2)
  - {{GIT_BRANCH}} → Pending (set in Phase 2)
  - {{CURRENT_STORY}} → None
  - {{LAST_ACTION}} → Kanban board created
  - {{NEXT_ACTION}} → Create git worktree for parallel execution
  - {{BACKLOG_STORIES}} → All READY stories from story files in table format
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
  - Count total stories from story files
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
    - Next Phase: 2 - Git Worktree

  OUTPUT to user:
  ---
  ## ✅ Phase 1 Complete: Initialization

  **Created:**
  - Kanban Board: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  - Stories loaded: [X] stories in Backlog

  **Next Phase:** Git Worktree Setup (for parallel execution)

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

<step name="git_worktree_creation" subagent="git-workflow">
  USE: git-workflow subagent

  PROMPT: "Create git worktree for parallel spec execution: {SELECTED_SPEC}

  **CRITICAL: Use Git Worktree for Parallel Execution**

  This enables multiple specs to execute simultaneously without branch conflicts.

  Rules:
  1. Extract worktree name from spec folder (remove YYYY-MM-DD- prefix)
     - Example: 2026-01-13-multi-delete-projects → multi-delete-projects
     - Example: 2026-01-12-bugfix-login-error → bugfix-login-error

  2. Extract branch name (same as worktree name)
     - If 'bugfix' in worktree name: use 'bugfix/' prefix for branch
     - Example: bugfix-login-error → branch: bugfix/login-error

  3. Create git worktree:
     ```bash
     # Base directory for worktrees
     WORKTREE_BASE='agent-os/worktrees'

     # Create worktree directory
     mkdir -p '$WORKTREE_BASE'

     # Create worktree with new branch
     git worktree add '$WORKTREE_BASE/$WORKTREE_NAME' -b '$BRANCH_NAME'
     ```

  4. Verify worktree was created:
     ```bash
     git worktree list
     ```

  5. Return these values for Resume Context:
     - WORKTREE_PATH: agent-os/worktrees/$WORKTREE_NAME
     - GIT_BRANCH: $BRANCH_NAME

  **Handle Edge Cases:**
  - If worktree already exists: Verify it matches the spec, use it
  - If branch already exists: Create worktree with existing branch
  - If uncommitted changes in main repo: Commit or stash first

  **Examples:**
  - Spec: 2026-01-13-multi-delete-projects
    → Worktree: agent-os/worktrees/multi-delete-projects
    → Branch: multi-delete-projects

  - Spec: 2026-01-12-bugfix-login-error
    → Worktree: agent-os/worktrees/bugfix-login-error
    → Branch: bugfix/login-error

  - Spec: 2026-01-14-user-authentication
    → Worktree: agent-os/worktrees/user-authentication
    → Branch: user-authentication
  "

  WAIT: For git-workflow completion

  CAPTURE: WORKTREE_PATH and GIT_BRANCH values for Resume Context
</step>

### Phase Completion

<phase_complete>
  UPDATE: kanban-board.md using template structure
    - Current Phase: 2-complete
    - Next Phase: 3 - Execute Story
    - Worktree Path: [captured from git-workflow]
    - Git Branch: [captured from git-workflow]
    - Last Action: Git worktree created for parallel execution
    - Next Action: Select and execute first story
    - Add Change Log entry

  OUTPUT to user:
  ---
  ## ✅ Phase 2 Complete: Git Worktree Setup

  **Worktree:** [worktree-path]
  **Branch:** [branch-name]
  **Status:** Ready for parallel story execution

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
  [Read story file from agent-os/specs/{SELECTED_SPEC}/stories/story-XXX-[slug].md]

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
  - Story: agent-os/specs/{SELECTED_SPEC}/stories/story-XXX-[slug].md
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
        - Next Phase: 4.5 - Integration Validation
        - Current Story: None
        - Last Action: All stories completed
        - Next Action: Validate integration before PR
      - ADD Change Log entry with timestamp

    OUTPUT to user:
    ---
    ## ✅ All Stories Complete!

    **Progress:** [TOTAL] of [TOTAL] stories completed

    **Next Phase:** Integration Validation (before PR)

    ---
    **👉 To continue, run:**
    ```
    /clear
    /execute-tasks
    ```
    ---

    STOP: Do not proceed to Phase 4.5
</phase_complete>

</phase>

---

## Phase 4.5: Integration Validation (Before PR)

<phase number="4.5" name="integration_validation">

### Purpose
Validate that the complete system works end-to-end AFTER all stories complete, BEFORE creating the PR.
This prevents the "stories are done but system doesn't work" problem.

### Entry Condition
- kanban-board.md shows: all-stories-done
- All stories in Done column
- Next Phase: 5 - Finalize (PR Creation)

### Actions

<step name="load_spec_integration_requirements">
  READ: agent-os/specs/{SELECTED_SPEC}/spec.md
  EXTRACT: Integration Requirements section
  CHECK: Does spec have integration requirements defined?
</step>

<step name="check_mcp_tools">
  CHECK: Which MCP tools are available?

  RUN: claude mcp list

  EXTRACT: Available MCP tools (e.g., playwright, browser automation)
  NOTE: Tests that require unavailable MCP tools will be skipped
</step>

<step name="detect_integration_type">
  ANALYZE: Integration Type from spec.md

  <integration_detection>
    IF Integration Type = "Backend-only":
      SKIP: Browser/UI tests
      RUN: API integration tests, database integration tests

    IF Integration Type = "Frontend-only":
      SKIP: Backend integration tests
      RUN: Component integration tests
      OPTIONAL: Browser tests (if Playwright MCP available)

    IF Integration Type = "Full-stack":
      RUN: All integration tests
      RUN: API + UI integration tests
      OPTIONAL: End-to-end browser tests (if Playwright MCP available)

    IF no Integration Requirements defined:
      CHECK: Does spec have Backend + Frontend stories?
      IF yes:
        LOG: "⚠️ Integration Requirements not defined but spec has multiple layers"
        LOG: "Running basic integration checks..."
        RUN: Basic smoke tests (build passes, tests pass)
      ELSE:
        LOG: "✅ No integration validation needed (single-layer spec)"
        PROCEED: To Phase 5 (PR Creation)
  </integration_detection>
</step>

<step name="run_integration_tests" subagent="test-runner">
  USE: test-runner subagent

  PROMPT: "Run integration validation for spec: {SELECTED_SPEC}

  **Integration Requirements from spec.md:**
  [EXTRACT integration test commands from spec.md]

  **Test Execution Strategy:**
  1. Filter tests by available MCP tools:
     - Skip tests marked with 'Requires MCP: yes' if tool not available
     - Run all other tests

  2. Execute integration tests in order:
     - Backend integration tests first
     - Frontend integration tests second
     - End-to-end tests last (if MCP available)

  3. Report results:
     - PASSED: All integration tests passed
     - FAILED: [List of failed tests with details]
     - SKIPPED: [List of tests skipped due to missing MCP tools]

  **Expected Exit Codes:**
  - 0: All integration tests passed
  - 1: One or more integration tests failed

  **Important:**
  - This is not about unit tests (those ran during story execution)
  - This is about validating that components work TOGETHER
  - Examples: UI connects to API, API writes to DB correctly, etc."
</step>

<step name="handle_integration_failures">
  CHECK: Integration test results

  IF all tests PASSED:
    LOG: "✅ Integration validation passed - System is functional"
    PROCEED: To Phase 5 (PR Creation)

  ELSE (some tests FAILED):
    GENERATE: Integration Fix Report

    <failure_report_format>
      ⚠️ Integration Validation Failed

      **Failed Tests:**
      - [Test 1]: [Failure reason]
      - [Test 2]: [Failure reason]

      **Root Cause Analysis:**
      [Analyze what's missing - e.g., UI not connected to API]

      **Required Fix:**
      [Brief description of what needs to be fixed]

      **Creating Integration Fix Story...**
    </failure_report_format>

    CREATE: Integration fix story
    - File: agent-os/specs/{SELECTED_SPEC}/stories/story-999-integration-fix.md
    - Content: Based on failure analysis

    UPDATE: kanban-board.md
    - Move integration-fix story to Backlog
    - Update Board Status
    - Set Resume Context: Phase 4.5 (Integration Fix Needed)

    INFORM: User about integration failures
    DISPLAY: Failure report and fix story details

    ASK via AskUserQuestion:
    "Integration validation failed. An integration-fix story has been created.
     How would you like to proceed?

     Options:
     1. Execute integration-fix story now (Recommended)
        → Automatically fix the integration issues
        → Re-run integration validation

     2. Review and manually fix
        → You can manually fix the issues
        → Re-run /execute-tasks after fixing

     3. Skip and create PR anyway (NOT RECOMMENDED)
        → System may not be fully functional
        → Risk: Broken deployment"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Execute integration-fix story now":
        EXECUTE: Integration fix story immediately
        REPEAT: Phase 4.5 (Integration Validation)

      ELSE IF choice = "Review and manually fix":
        INFORM: "Please fix the integration issues manually"
        INFORM: "Run /execute-tasks again after fixing"
        STOP: Wait for user to fix

      ELSE IF choice = "Skip and create PR anyway":
        WARN: "⚠️ Proceeding with integration failures"
        WARN: "System may not be fully functional"
        LOG: Integration validation bypassed by user
        PROCEED: To Phase 5 (PR Creation)
    </user_choice_handling>
</step>

### Phase Completion

<phase_complete>
  UPDATE: kanban-board.md Resume Context
    - Current Phase: 5-ready
    - Next Phase: 5 - Finalize (PR Creation)
    - Last Action: Integration validation passed
    - Integration Status: PASSED

  OUTPUT to user:
  ---
  ## ✅ Phase 4.5 Complete: Integration Validation

  **Integration Tests:** All passed ✅

  **System Status:** Fully functional and integrated

  **Next Phase:** Create Pull Request

  ---
  **👉 To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 5
</phase_complete>

</phase>

---

## Phase 5: Finalize (PR Creation + Summary)

<phase number="5" name="finalize">

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

<step name="worktree_cleanup" subagent="git-workflow">
  USE: git-workflow subagent

  PROMPT: "Clean up git worktree after successful PR creation: {SELECTED_SPEC}

  **IMPORTANT: Only clean up worktree AFTER PR is created and merged**

  Read Resume Context from kanban-board.md to get:
  - WORKTREE_PATH: Path to the worktree
  - GIT_BRANCH: Branch name

  Cleanup steps:
  1. Verify PR was created successfully
  2. Remove worktree:
     ```bash
     git worktree remove [WORKTREE_PATH]
     ```
  3. Verify worktree was removed:
     ```bash
     git worktree list
     ```

  **Handle Edge Cases:**
  - If PR not yet created: Skip cleanup, warn user
  - If worktree has uncommitted changes: Warn user, don't remove
  - If worktree path doesn't exist: Already cleaned up, continue

  **Output:**
  - Confirm worktree removal
  - Show remaining worktrees (if any)
  "

  WAIT: For git-workflow completion

  UPDATE: kanban-board.md Resume Context
    - Last Action: Worktree cleaned up after PR
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
  | **Current Phase** | Phase identifier | 1-complete, 2-complete, story-complete, all-stories-done, 5-ready, complete |
  | **Next Phase** | What to execute next | 2 - Git Worktree, 3 - Execute Story, 4.5 - Integration Validation, 5 - Finalize, None |
  | **Spec Folder** | Full path | agent-os/specs/2026-01-13-multi-delete-projects |
  | **Worktree Path** | Path to git worktree for parallel execution | agent-os/worktrees/multi-delete-projects or Pending |
  | **Git Branch** | Branch name for this spec | multi-delete-projects or Pending |
  | **Current Story** | Story being worked on | MDP-001 or None |
  | **Last Action** | What just happened | Kanban board created |
  | **Next Action** | What needs to happen | Create git worktree |

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
    3. /execute-tasks → Phase 2 (Git Worktree) runs → "Run /clear, then /execute-tasks"
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

  ### Command Variants

  | Command | Description |
  |---------|-------------|
  | `/execute-tasks` | Ask user: Backlog or Spec? |
  | `/execute-tasks backlog` | Execute quick tasks from backlog |
  | `/execute-tasks [spec-name]` | Execute specific specification |

  ### Spec Mode Phases

  | Phase | Purpose | Subagents Used |
  |-------|---------|----------------|
  | 1 | Initialize | file-creator |
  | 2 | Git Worktree (parallel execution) | git-workflow |
  | 3 | Execute Story | dev-team__*, architect, ux-designer, qa-specialist, git-workflow |
  | 4.5 | Integration Validation | test-runner |
  | 5 | Finalize (PR Creation) | git-workflow |

  ### Backlog Mode Phases

  | Phase | Purpose | Subagents Used |
  |-------|---------|----------------|
  | 1 | Initialize Daily Kanban | file-creator |
  | 2 | Execute Story | dev-team__*, git-workflow |
  | 3 | Daily Summary | - |

  **Key Differences:**
  - Backlog: No git worktree (works on current branch)
  - Backlog: No integration validation phase
  - Backlog: Daily kanban (kanban-YYYY-MM-DD.md)
  - Backlog: Simpler review process

  <resume_command>
    After /clear, simply run the appropriate command:
    - `/execute-tasks backlog` for backlog
    - `/execute-tasks [spec-name]` for spec
    - `/execute-tasks` to choose

    Phase detection automatically routes to correct phase.
  </resume_command>
</quick_reference>
