---
description: Backlog Phase 2 - Execute one backlog story (JSON v4.0)
version: 4.0
---

# Backlog Phase 2: Execute Story (Direct Execution)

## What's New in v4.0

- **JSON-Based Kanban**: Liest/schreibt execution-kanban.json
- **Backlog Sync**: Synchronisiert Status zurück nach backlog.json
- **Strukturierte Updates**: JSON-Feld-Updates statt MD-Parsing

## What's New in v3.0

- **No Sub-Agent Delegation**: Main agent implements story directly
- **Skills Load Automatically**: Via glob patterns in .claude/skills/
- **Self-Review**: DoD checklist instead of separate review
- **Self-Learning**: Updates dos-and-donts.md when learning

## Purpose

Execute ONE backlog story. Simpler than spec execution (no git worktree, no integration phase).

## Entry Condition

- executions/kanban-[TODAY].json exists
- resumeContext.currentPhase = "1-complete" OR "item-complete"
- Items remain with executionStatus = "queued"

## Actions

<step name="load_state">
  ### Load State from JSON

  READ: agent-os/backlog/executions/kanban-{TODAY}.json

  EXTRACT:
  - resumeContext (currentPhase, currentItem, progressIndex)
  - items[] array
  - executionOrder[] array
  - boardStatus

  IDENTIFY: Next item from executionOrder where executionStatus = "queued"
</step>

<step name="story_selection">
  ### Select Next Item

  FIND: First item in executionOrder where:
  - items[id].executionStatus = "queued"

  IF no queued items:
    LOG: "All items completed"
    GOTO: phase_complete (all done)

  SET: SELECTED_ITEM = items[selected_id]
</step>

<step name="update_kanban_in_progress">
  ### Update Kanban JSON - In Progress

  READ: agent-os/backlog/executions/kanban-{TODAY}.json

  UPDATE:
  - items[SELECTED_ITEM.id].executionStatus = "in_progress"
  - items[SELECTED_ITEM.id].timing.startedAt = "{NOW}"
  - resumeContext.currentItem = "{SELECTED_ITEM.id}"
  - resumeContext.lastAction = "Started {SELECTED_ITEM.id}"
  - resumeContext.nextAction = "Implement {SELECTED_ITEM.title}"
  - boardStatus.queued -= 1
  - boardStatus.inProgress += 1

  ADD to changeLog[]:
  ```json
  {
    "timestamp": "{NOW}",
    "action": "status_changed",
    "itemId": "{SELECTED_ITEM.id}",
    "from": "queued",
    "to": "in_progress",
    "details": "Started execution"
  }
  ```

  WRITE: kanban-{TODAY}.json
</step>

<step name="load_story">
  ### Load Story Details

  READ: Story file from SELECTED_ITEM.sourceFile
  (Path stored in execution-kanban.json items[].sourceFile)

  EXTRACT:
  - Story ID and Title
  - Feature description
  - Acceptance Criteria
  - DoD Checklist
  - Domain reference (if specified)

  NOTE: Skills load automatically when you edit matching files.
</step>

<step name="implement">
  ### Direct Implementation (v3.0)

  **The main agent implements the story directly.**

  <implementation_process>
    1. UNDERSTAND: Story requirements

    2. IMPLEMENT: The task
       - Create/modify files as needed
       - Skills load automatically when editing matching files
       - Keep it focused (backlog tasks are smaller)

    3. RUN: Tests
       - Ensure tests pass

    4. VERIFY: Acceptance criteria satisfied

    **This is a quick task:**
    - No extensive refactoring
    - Keep changes minimal
    - Focus on the specific requirement
  </implementation_process>
</step>

<step name="self_review">
  ### Self-Review with DoD Checklist

  <review_process>
    1. READ: DoD checklist from story

    2. VERIFY each item:
       - [ ] Implementation complete
       - [ ] Tests passing
       - [ ] Linter passes
       - [ ] Acceptance criteria met

    3. RUN: Completion Check commands from story

    IF all checks pass:
      PROCEED to self_learning_check
    ELSE:
      FIX issues and re-verify
  </review_process>
</step>

<step name="self_learning_check">
  ### Self-Learning Check (v3.0)

  <learning_detection>
    REFLECT: Did you learn something during implementation?

    IF YES:
      1. IDENTIFY: The learning
      2. LOCATE: Target dos-and-donts.md file
         - Frontend: .claude/skills/frontend-[framework]/dos-and-donts.md
         - Backend: .claude/skills/backend-[framework]/dos-and-donts.md
         - DevOps: .claude/skills/devops-[stack]/dos-and-donts.md

      3. APPEND: Learning entry
         ```markdown
         ### [DATE] - [Short Title]
         **Context:** [What you were trying to do]
         **Issue:** [What didn't work]
         **Solution:** [What worked]
         ```

    IF NO learning:
      SKIP: No update needed
  </learning_detection>
</step>

<step name="move_story_to_done">
  ### Move Story File to Done

  MOVE: Story file to done/ folder
  ```bash
  mkdir -p agent-os/backlog/done
  mv agent-os/backlog/{STORY_FILE} agent-os/backlog/done/
  ```
  NOTE: This prevents the story from being picked up in future kanbans
</step>

<step name="update_kanban_json_done">
  ### Update Kanban JSON - Done

  READ: agent-os/backlog/executions/kanban-{TODAY}.json

  UPDATE:
  - items[SELECTED_ITEM.id].executionStatus = "done"
  - items[SELECTED_ITEM.id].timing.completedAt = "{NOW}"
  - resumeContext.currentItem = null
  - resumeContext.progressIndex += 1
  - resumeContext.lastAction = "Completed {SELECTED_ITEM.id}"
  - boardStatus.inProgress -= 1
  - boardStatus.done += 1

  ADD to changeLog[]:
  ```json
  {
    "timestamp": "{NOW}",
    "action": "status_changed",
    "itemId": "{SELECTED_ITEM.id}",
    "from": "in_progress",
    "to": "done",
    "details": "Item completed"
  }
  ```

  WRITE: kanban-{TODAY}.json
</step>

<step name="update_backlog_json_done">
  ### Update Backlog JSON - Item Done

  READ: agent-os/backlog/backlog.json

  FIND: Item in items[] where id = SELECTED_ITEM.id

  UPDATE:
  - items[id].status = "done"
  - items[id].completedAt = "{NOW}"
  - statistics.byStatus.ready -= 1
  - statistics.byStatus.done += 1
  - statistics.completedEffort += SELECTED_ITEM.effort

  ADD to changeLog[]:
  ```json
  {
    "timestamp": "{NOW}",
    "action": "status_changed",
    "itemId": "{SELECTED_ITEM.id}",
    "from": "ready",
    "to": "done",
    "details": "Completed in kanban-{TODAY}"
  }
  ```

  WRITE: backlog.json
</step>

<step name="story_commit" subagent="git-workflow">
  ### Commit Changes

  USE: git-workflow subagent
  "Commit backlog item {SELECTED_ITEM.id}:

  **WORKING_DIR:** {PROJECT_ROOT}

  - Message: fix/feat: {SELECTED_ITEM.id} {SELECTED_ITEM.title}
  - Stage all changes including:
    - Implementation files
    - Moved story file in done/
    - kanban-{TODAY}.json
    - backlog.json
    - Any dos-and-donts.md updates
  - Push to current branch"
</step>

## Phase Completion

<phase_complete>
  ### Check Remaining Items

  READ: agent-os/backlog/executions/kanban-{TODAY}.json
  COUNT: Items where executionStatus = "queued"

  IF queued items remain:
    UPDATE: kanban-{TODAY}.json
    - resumeContext.currentPhase = "item-complete"
    - resumeContext.nextAction = "Execute next item"

    WRITE: kanban-{TODAY}.json

    OUTPUT to user:
    ---
    ## Item Complete: {SELECTED_ITEM.id}

    **Progress:** {boardStatus.done} of {boardStatus.total} items today

    **Self-Learning:** [Updated/No updates]

    **Next:** Execute next item

    ---
    **To continue, run:**
    ```
    /clear
    /execute-tasks backlog
    ```
    ---

    STOP: Do not proceed to next item

  ELSE (all items done):
    UPDATE: kanban-{TODAY}.json
    - resumeContext.currentPhase = "all-items-done"
    - resumeContext.nextAction = "Generate daily summary"
    - execution.status = "completed"
    - execution.completedAt = "{NOW}"

    WRITE: kanban-{TODAY}.json

    UPDATE: agent-os/backlog/backlog.json
    - resumeContext.currentPhase = "execution-complete"
    - resumeContext.lastAction = "Execution completed"
    - executions[kanban-{TODAY}].status = "completed"

    WRITE: backlog.json

    OUTPUT to user:
    ---
    ## All Backlog Items Complete!

    **Today's Progress:** {boardStatus.total} items completed

    **Next Phase:** Daily Summary

    ---
    **To continue, run:**
    ```
    /clear
    /execute-tasks backlog
    ```
    ---

    STOP: Do not proceed to Backlog Phase 3
</phase_complete>

---

## Quick Reference: v3.0 Changes

| v2.x (Sub-Agents) | v3.0 (Direct Execution) |
|-------------------|-------------------------|
| extract_skill_paths_backlog | Skills auto-load via globs |
| DELEGATE to dev-team__* | Main agent implements |
| quick_review (separate) | Self-review with DoD |
| - | self_learning_check (NEW) |

**Benefits:**
- Full context for each task
- Faster execution (no delegation overhead)
- Self-learning improves backlog workflow too
