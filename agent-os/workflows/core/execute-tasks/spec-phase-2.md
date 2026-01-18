---
description: Spec Phase 2 - Git Worktree Setup for parallel execution
version: 3.0
---

# Spec Phase 2: Git Worktree Setup

## Purpose
Create git worktree for parallel spec execution.

## Entry Condition
- kanban-board.md exists
- Resume Context shows: Phase 1-complete

## Actions

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

  Rules:
  1. Extract worktree name from spec folder (remove YYYY-MM-DD- prefix)
     - Example: 2026-01-13-multi-delete-projects → multi-delete-projects

  2. Extract branch name (same as worktree name)
     - If 'bugfix' in name: use 'bugfix/' prefix
     - Example: bugfix-login-error → branch: bugfix/login-error

  3. Create git worktree:
     ```bash
     WORKTREE_BASE='agent-os/worktrees'
     mkdir -p '$WORKTREE_BASE'
     git worktree add '$WORKTREE_BASE/$WORKTREE_NAME' -b '$BRANCH_NAME'
     ```

  4. Verify: git worktree list

  5. Return: WORKTREE_PATH and GIT_BRANCH

  Handle Edge Cases:
  - Worktree exists: Verify and use it
  - Branch exists: Create worktree with existing branch
  - Uncommitted changes: Commit or stash first"

  WAIT: For git-workflow completion
  CAPTURE: WORKTREE_PATH and GIT_BRANCH values
</step>

## Phase Completion

<phase_complete>
  UPDATE: kanban-board.md
    - Current Phase: 2-complete
    - Next Phase: 3 - Execute Story
    - Worktree Path: [captured value]
    - Git Branch: [captured value]
    - Last Action: Git worktree created
    - Next Action: Execute first story
    - Add Change Log entry

  OUTPUT to user:
  ---
  ## Phase 2 Complete: Git Worktree Setup

  **Worktree:** [worktree-path]
  **Branch:** [branch-name]
  **Status:** Ready for story execution

  **Next Phase:** Execute First Story

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 3
</phase_complete>
