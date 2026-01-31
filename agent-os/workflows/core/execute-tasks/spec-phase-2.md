---
description: Spec Phase 2 - Git Strategy Setup (Worktree or Branch)
version: 3.2
---

# Spec Phase 2: Git Strategy Setup

## What's New in v3.2

**Git Strategy Routing:**
- Phase-2 now routes based on Git Strategy (worktree vs branch)
- Worktree strategy: Creates worktree + symlink to spec folder
- Branch strategy: Creates branch only, works in main directory
- User receives clear instructions for worktree mode with correct Claude command

## Purpose

Setup git environment based on chosen strategy:
- **Worktree:** Isolated directory for parallel execution
- **Branch:** Work directly in main directory

## Entry Condition

- kanban-board.md exists
- Resume Context shows: Phase 1-complete

## Actions

<step name="load_resume_context">
  READ: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  EXTRACT: Resume Context section
  VALIDATE: Phase 1 is complete
  EXTRACT: Git Strategy (if already set in Phase 1)
</step>

<step name="ask_git_strategy">
  ### Ask Git Strategy (if not already set)

  IF Git Strategy is already set in Resume Context:
    USE: That value (worktree or branch)
    SKIP: AskUserQuestion

  ELSE:
    ASK via AskUserQuestion:
    "Welche Git-Strategie möchtest du für diese Spec verwenden?"

    **Options:**
    1. "Worktree (Recommended)" - Isoliertes Verzeichnis für paralleles Arbeiten. Spec wird per Symlink verlinkt.
    2. "Branch" - Arbeitet direkt im Hauptverzeichnis auf einem Feature-Branch.

    SET: GIT_STRATEGY based on user choice
</step>

<step name="extract_names">
  ### Extract Worktree and Branch Names

  FROM: SELECTED_SPEC (e.g., "2026-01-31-my-feature")
  EXTRACT: Worktree name by removing date prefix

  ```bash
  # Example: 2026-01-31-my-feature → my-feature
  WORKTREE_NAME=$(echo "$SELECTED_SPEC" | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}-//')
  ```

  SET: BRANCH_NAME
  - IF "bugfix" in name: prefix with "bugfix/"
  - ELSE: prefix with "feature/"
  - Example: my-feature → feature/my-feature
  - Example: bugfix-login-error → bugfix/login-error
</step>

<git_strategy_routing>
  ## Git Strategy Routing

  ROUTE based on GIT_STRATEGY:

  IF GIT_STRATEGY = "worktree":
    GOTO: worktree_setup

  ELSE IF GIT_STRATEGY = "branch":
    GOTO: branch_setup
</git_strategy_routing>

---

## Worktree Strategy

<step name="worktree_setup">
  ### Worktree Strategy Setup

  **Goal:** Create isolated worktree with symlink to spec folder.

  <substep name="check_dev_server">
    RUN: lsof -i :3000 2>/dev/null | head -5

    IF server running:
      ASK: "Dev server running on port 3000. Shut down? (yes/no)"
      IF yes: Kill server
  </substep>

  <substep name="create_worktree">
    ### Create Git Worktree

    ```bash
    # Variables
    WORKTREE_BASE="agent-os/worktrees"
    WORKTREE_PATH="${WORKTREE_BASE}/${WORKTREE_NAME}"
    BRANCH_NAME="feature/${WORKTREE_NAME}"  # or bugfix/ prefix

    # Create base directory
    mkdir -p "${WORKTREE_BASE}"

    # Create worktree with new branch
    git worktree add "${WORKTREE_PATH}" -b "${BRANCH_NAME}"

    # Verify creation
    git worktree list
    ```

    Handle Edge Cases:
    - Worktree exists: Verify and use existing
    - Branch exists: Create worktree with existing branch using `git worktree add ${WORKTREE_PATH} ${BRANCH_NAME}` (without -b)
    - Uncommitted changes: Commit or stash first
  </substep>

  <substep name="create_symlink">
    ### Create Symlink to Spec Folder

    **Purpose:** Allow agent in worktree to access spec files at the same relative path.

    ```bash
    # Create directory structure in worktree
    mkdir -p "${WORKTREE_PATH}/agent-os/specs"

    # Calculate relative symlink path
    # From: agent-os/worktrees/my-feature/agent-os/specs/2026-01-31-my-feature
    # To:   agent-os/specs/2026-01-31-my-feature
    # Relative: ../../../../agent-os/specs/2026-01-31-my-feature

    SYMLINK_TARGET="../../../../agent-os/specs/${SELECTED_SPEC}"
    SYMLINK_LOCATION="${WORKTREE_PATH}/agent-os/specs/${SELECTED_SPEC}"

    # Create symlink
    ln -s "${SYMLINK_TARGET}" "${SYMLINK_LOCATION}"

    # Verify symlink
    ls -la "${SYMLINK_LOCATION}"
    ```

    **Result:** Agent can access `agent-os/specs/{SELECTED_SPEC}/` from within worktree.
  </substep>

  <substep name="detect_claude_mode">
    ### Detect Claude Startup Mode

    **Purpose:** Determine correct command for user instructions.

    Check environment:
    - If `ANTHROPIC_API_KEY` is set → API mode
    - If started with `--dangerously-skip-permissions` → API mode
    - Otherwise → Claude Max mode

    SET: CLAUDE_CMD based on detected mode
    - Claude Max: `claude`
    - API Mode: `claude --dangerously-skip-permissions`
  </substep>

  GOTO: phase_complete_worktree
</step>

---

## Branch Strategy

<step name="branch_setup">
  ### Branch Strategy Setup

  **Goal:** Create feature branch, work in main directory.

  <substep name="create_branch">
    ### Create Feature Branch

    ```bash
    # Create and switch to feature branch
    git checkout -b "${BRANCH_NAME}"

    # Verify
    git branch --show-current
    ```

    Handle Edge Cases:
    - Branch exists: Check out existing branch with `git checkout ${BRANCH_NAME}`
    - Uncommitted changes: Commit or stash first
  </substep>

  SET: WORKTREE_PATH = "(none)"
  SET: USE_WORKTREE = false

  GOTO: phase_complete_branch
</step>

---

## Phase Completion

<phase_complete_worktree>
  ### Phase Complete: Worktree Strategy

  UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT - see shared/resume-context.md)
    Resume Context table fields:
    | **Current Phase** | 2-complete |
    | **Next Phase** | 3 - Execute Story |
    | **Worktree Path** | agent-os/worktrees/{WORKTREE_NAME} |
    | **Git Branch** | {BRANCH_NAME} |
    | **Git Strategy** | worktree |
    | **Current Story** | None |
    | **Last Action** | Git worktree created with spec symlink |
    | **Next Action** | Switch to worktree and execute first story |

    Add Change Log entry

  DETECT: Claude mode for command suggestion (see detect_claude_mode)

  OUTPUT to user:
  ---
  ## Phase 2 Complete: Worktree Strategy

  **Worktree:** agent-os/worktrees/{WORKTREE_NAME}
  **Branch:** {BRANCH_NAME}
  **Symlink:** Spec folder linked into worktree
  **Git Strategy:** worktree

  ### Next Steps

  **You must switch to the worktree directory to continue:**

  ```bash
  cd agent-os/worktrees/{WORKTREE_NAME} && {CLAUDE_CMD}
  ```

  Then run:
  ```
  /execute-tasks
  ```

  ---
  **Note:** Story execution MUST happen from within the worktree directory.
  The entry point will verify you're in the correct working directory.
  ---

  STOP: Do not proceed to Phase 3 - user must switch directories
</phase_complete_worktree>

<phase_complete_branch>
  ### Phase Complete: Branch Strategy

  UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT - see shared/resume-context.md)
    Resume Context table fields:
    | **Current Phase** | 2-complete |
    | **Next Phase** | 3 - Execute Story |
    | **Worktree Path** | (none) |
    | **Git Branch** | {BRANCH_NAME} |
    | **Git Strategy** | branch |
    | **Current Story** | None |
    | **Last Action** | Feature branch created |
    | **Next Action** | Execute first story |

    Add Change Log entry

  OUTPUT to user:
  ---
  ## Phase 2 Complete: Branch Strategy

  **Working Directory:** Current project directory
  **Branch:** {BRANCH_NAME}
  **Git Strategy:** branch

  **Next Phase:** Execute First Story

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 3
</phase_complete_branch>
