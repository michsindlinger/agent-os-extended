---
description: Spec Phase 1 - Initialize and create Kanban Board
version: 3.0
---

# Spec Phase 1: Initialize

## Purpose
Select specification and create Kanban Board. One-time setup phase.

## Entry Condition
- No kanban-board.md exists for target spec

## Actions

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

  Source: Parse story files in stories/ directory
  Output: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  Template: agent-os/templates/docs/kanban-board-template.md

  CRITICAL STEPS:
  1. LIST all story files in agent-os/specs/{SELECTED_SPEC}/stories/
  2. FOR EACH story file:
     - READ the story file
     - VALIDATE DoR:
       * CHECK: All DoR checkboxes are marked [x]
       * IF any [ ] unchecked: STORY_STATUS = BLOCKED
       * IF all [x]: STORY_STATUS = Ready
     - EXTRACT: Story ID, Title, Type, Dependencies, Points

  3. CREATE kanban board with:
     - All valid stories in Backlog
     - Blocked stories marked with status

  Template Variables to Replace:
  - {{SPEC_NAME}} → Spec folder name
  - {{TOTAL_STORIES}} → Count from story files
  - {{COMPLETED_COUNT}} → 0
  - {{IN_PROGRESS_COUNT}} → 0
  - {{BACKLOG_COUNT}} → Count of READY stories
  - {{BLOCKED_COUNT}} → Count of BLOCKED stories
  - {{CURRENT_PHASE}} → 1-complete
  - {{NEXT_PHASE}} → 2 - Git Worktree

  Story Table Format:
  | Story ID | Title | Type | Dependencies | DoR Status | Points |
  |----------|-------|------|--------------|------------|--------|"

  WAIT: For file-creator completion
</step>

## Phase Completion

<phase_complete>
  UPDATE: kanban-board.md Resume Context
    - Current Phase: 1-complete
    - Next Phase: 2 - Git Worktree

  OUTPUT to user:
  ---
  ## Phase 1 Complete: Initialization

  **Created:**
  - Kanban Board: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  - Stories loaded: [X] stories in Backlog

  **Next Phase:** Git Worktree Setup

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 2
</phase_complete>
