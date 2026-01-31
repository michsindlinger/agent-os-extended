---
description: Spec Phase 5 - Finalize with PR creation
version: 3.2
---

# Spec Phase 5: Finalize

## Purpose
Create pull request and provide final summary.

## Entry Condition
- kanban-board.md shows: 5-ready or all-stories-done
- All stories in Done column

## Actions

<step name="final_test_run" subagent="test-runner">
  USE: test-runner subagent
  "Run full test suite to verify no regressions"

  IF failures: FIX before proceeding
</step>

<step name="create_pr" subagent="git-workflow">
  USE: git-workflow subagent
  "Create PR for spec: {SELECTED_SPEC}

  **WORKING_DIR:** {PROJECT_ROOT} (or {WORKTREE_PATH} if USE_WORKTREE = true)
  (Use this as the git repository root - do NOT operate in nested repos)

  - Commit any remaining changes (kanban-board.md)
  - Push all commits
  - Create PR to main branch
  - Include summary of all stories"

  CAPTURE: PR URL
</step>

<step name="roadmap_check">
  CHECK: Did this spec complete a roadmap item?
  IF yes: UPDATE agent-os/product/roadmap.md
</step>

<step name="completion_sound">
  RUN: afplay /System/Library/Sounds/Glass.aiff
</step>

<step name="worktree_cleanup" subagent="git-workflow" condition="Git Strategy = worktree">
  CHECK: Resume Context for "Git Strategy" value

  IF "Git Strategy" != "worktree" OR WORKTREE_PATH = "(none)" OR WORKTREE_PATH empty:
    SKIP: This step
    LOG: "No worktree cleanup needed (branch strategy or none created)"
    UPDATE: kanban-board.md - Last Action: Skipped worktree cleanup (none created)

  ELSE:
    USE: git-workflow subagent

    PROMPT: "Clean up git worktree: {SELECTED_SPEC}

    **WORKING_DIR:** {PROJECT_ROOT}
    (Use this as the git repository root - do NOT operate in nested repos)

    Read Resume Context for WORKTREE_PATH (external location, e.g., ../projekt-x-worktrees/feature-name)

    Cleanup:
    1. Verify PR was created
    2. Remove worktree: git worktree remove [WORKTREE_PATH]
       Note: WORKTREE_PATH is external (e.g., ../projekt-x-worktrees/feature-name)
    3. Verify: git worktree list
    4. Optionally remove empty worktrees directory if no other worktrees exist

    Edge Cases:
    - PR not created: Skip cleanup, warn
    - Uncommitted changes: Warn, don't remove
    - Path doesn't exist: Continue"

    WAIT: For completion
    UPDATE: kanban-board.md - Last Action: Worktree cleaned up
</step>

## Phase Completion

<phase_complete>
  UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT - see shared/resume-context.md)
    Resume Context table fields:
    | **Current Phase** | complete |
    | **Next Phase** | None |
    | **Current Story** | None |
    | **Last Action** | PR created - [PR URL] |
    | **Next Action** | Review and merge PR |

    Add Change Log entry: Spec execution complete - PR created

  OUTPUT to user:
  ---
  ## Spec Execution Complete!

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
