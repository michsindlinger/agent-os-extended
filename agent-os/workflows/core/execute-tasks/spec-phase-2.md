---
description: Spec Phase 2 - Git Worktree Setup for parallel execution
version: 3.1
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

<step name="ask_worktree_preference">
  ASK via AskUserQuestion:
  "Möchtest du einen Git Worktree für diese Spec erstellen?"

  **Options:**
  1. "Ja, Worktree erstellen" - Ermöglicht paralleles Arbeiten in separatem Verzeichnis
  2. "Nein, im Hauptverzeichnis arbeiten" - Arbeitet direkt im aktuellen Branch

  IF user chooses "Nein":
    SET: USE_WORKTREE = false
    SET: WORKTREE_PATH = ""
    SET: GIT_BRANCH = current branch
    SKIP: Steps check_dev_server and git_worktree_creation
    GOTO: Phase Completion (No Worktree)

  ELSE:
    SET: USE_WORKTREE = true
    CONTINUE: With next steps
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

  **WORKING_DIR:** {PROJECT_ROOT}
  (Use this as the git repository root - do NOT operate in nested repos)

  Rules:
  1. Extract worktree name from spec folder (remove YYYY-MM-DD- prefix)
     - Example: 2026-01-13-multi-delete-projects → multi-delete-projects

  2. Extract branch name (same as worktree name)
     - If 'bugfix' in name: use 'bugfix/' prefix
     - Example: bugfix-login-error → branch: bugfix/login-error

  3. Create git worktree (use -C for correct repo):
     ```bash
     WORKTREE_BASE='agent-os/worktrees'
     mkdir -p '$WORKTREE_BASE'
     git -C '$PROJECT_ROOT' worktree add '$WORKTREE_BASE/$WORKTREE_NAME' -b '$BRANCH_NAME'
     ```

  4. Verify: git -C '$PROJECT_ROOT' worktree list

  5. Return: WORKTREE_PATH and GIT_BRANCH

  Handle Edge Cases:
  - Worktree exists: Verify and use it
  - Branch exists: Create worktree with existing branch
  - Uncommitted changes: Commit or stash first"

  WAIT: For git-workflow completion
  CAPTURE: WORKTREE_PATH and GIT_BRANCH values
</step>

## Phase Completion

<phase_complete_no_worktree condition="USE_WORKTREE = false">
  UPDATE: kanban-board.md
    - Current Phase: 2-complete
    - Next Phase: 3 - Execute Story
    - Worktree Path: (none)
    - Git Branch: [current branch]
    - Use Worktree: false
    - Last Action: Skipped worktree creation (user preference)
    - Next Action: Execute first story
    - Add Change Log entry

  OUTPUT to user:
  ---
  ## Phase 2 Complete: Worktree Setup Skipped

  **Working Directory:** Current project directory
  **Branch:** [current-branch]
  **Status:** Ready for story execution (no worktree)

  **Next Phase:** Execute First Story

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 3
</phase_complete_no_worktree>

<phase_complete_with_worktree condition="USE_WORKTREE = true">
  UPDATE: kanban-board.md
    - Current Phase: 2-complete
    - Next Phase: 3 - Execute Story
    - Worktree Path: [captured value]
    - Git Branch: [captured value]
    - Use Worktree: true
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
</phase_complete_with_worktree>
