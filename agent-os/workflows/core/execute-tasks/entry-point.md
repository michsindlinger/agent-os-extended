---
description: Entry point for task execution - routes to appropriate phase
globs:
alwaysApply: false
version: 3.0
encoding: UTF-8
---

# Task Execution Entry Point

## What's New in v3.0

**Phase Files Updated:**
- `spec-phase-3.md` → Direct Execution (no sub-agents)
- `backlog-phase-2.md` → Direct Execution (no sub-agents)

**Key Changes:**
- Main agent implements stories directly
- Skills auto-load via glob patterns
- Self-review replaces separate review agents
- Self-learning mechanism added

---

# Task Execution Entry Point

## Overview

Lightweight router that detects current state and loads ONLY the relevant phase.
This reduces context usage by ~70-80% compared to loading the full workflow.

**Phase Files Location:** `agent-os/workflows/core/execute-tasks/`

---

## Execution Mode Detection

<mode_detection>
  WHEN /execute-tasks is invoked:

  1. CHECK: Was a parameter provided?

     IF parameter = "backlog":
       SET: EXECUTION_MODE = "backlog"
       GOTO: Backlog State Detection

     ELSE IF parameter = [spec-name]:
       SET: EXECUTION_MODE = "spec"
       SET: SELECTED_SPEC = [spec-name]
       GOTO: Spec State Detection

     ELSE (no parameter):
       GOTO: Auto-Detection

  <auto_detection>
    CHECK: Are there active kanban boards?

    ```bash
    # Check for active spec kanbans
    SPEC_KANBANS=$(ls agent-os/specs/*/kanban-board.md 2>/dev/null | head -5)

    # Check for active backlog kanban (today)
    TODAY=$(date +%Y-%m-%d)
    BACKLOG_KANBAN=$(ls agent-os/backlog/kanban-${TODAY}.md 2>/dev/null)

    # Check for pending backlog stories
    BACKLOG_STORIES=$(ls agent-os/backlog/user-story-*.md agent-os/backlog/bug-*.md 2>/dev/null | wc -l)
    ```

    IF active kanban exists (spec or backlog):
      DETECT: Which kanban is active
      RESUME: That execution automatically

    ELSE IF backlog has stories AND specs exist:
      ASK via AskUserQuestion:
      "What would you like to execute?
      1. Execute Backlog ([N] quick tasks)
      2. Execute Spec (select from available)
      3. View status only"

    ELSE IF only backlog has stories:
      SET: EXECUTION_MODE = "backlog"

    ELSE IF only specs exist:
      SET: EXECUTION_MODE = "spec"

    ELSE:
      ERROR: "No tasks to execute. Use /add-todo or /create-spec first."
  </auto_detection>
</mode_detection>

---

## Backlog State Detection

<backlog_routing>
  USE: date-checker to get current date (YYYY-MM-DD)

  CHECK: Does today's kanban exist?
  ```bash
  ls agent-os/backlog/kanban-${TODAY}.md 2>/dev/null
  ```

  IF NO kanban:
    LOAD: @agent-os/workflows/core/execute-tasks/backlog-phase-1.md
    STOP: After loading

  IF kanban exists:
    READ: agent-os/backlog/kanban-${TODAY}.md
    EXTRACT: "Current Phase" from Resume Context

    | Current Phase | Load Phase File |
    |---------------|-----------------|
    | 1-complete | backlog-phase-2.md |
    | story-complete | backlog-phase-2.md |
    | all-stories-done | backlog-phase-3.md |
    | complete | INFORM: "Backlog execution complete for today" |

    LOAD: Appropriate phase file
    STOP: After loading
</backlog_routing>

---

## Spec State Detection

<spec_routing>
  IF SELECTED_SPEC not set:
    LIST: Available specs
    ```bash
    ls -1 agent-os/specs/ | sort -r
    ```
    IF 1 spec: SET SELECTED_SPEC automatically
    IF multiple: ASK user via AskUserQuestion

  CHECK: Does kanban-board.md exist?
  ```bash
  ls agent-os/specs/${SELECTED_SPEC}/kanban-board.md 2>/dev/null
  ```

  IF NO kanban-board.md:
    LOAD: @agent-os/workflows/core/execute-tasks/spec-phase-1.md
    STOP: After loading

  IF kanban-board.md exists:
    READ: agent-os/specs/${SELECTED_SPEC}/kanban-board.md
    EXTRACT: "Current Phase" from Resume Context

    | Current Phase | Load Phase File |
    |---------------|-----------------|
    | 1-complete | spec-phase-2.md |
    | 2-complete | spec-phase-3.md |
    | story-complete | spec-phase-3.md |
    | all-stories-done | spec-phase-4-5.md |
    | 5-ready | spec-phase-5.md |
    | complete | INFORM: "Spec execution complete. PR created." |

    LOAD: Appropriate phase file
    STOP: After loading
</spec_routing>

---

## Phase File Reference

| Mode | Phase | File | Purpose |
|------|-------|------|---------|
| Spec | 1 | spec-phase-1.md | Initialize + Kanban |
| Spec | 2 | spec-phase-2.md | Git Worktree |
| Spec | 3 | spec-phase-3.md | Execute Story |
| Spec | 4.5 | spec-phase-4-5.md | Integration Validation |
| Spec | 5 | spec-phase-5.md | Finalize + PR |
| Backlog | 1 | backlog-phase-1.md | Daily Kanban |
| Backlog | 2 | backlog-phase-2.md | Execute Story |
| Backlog | 3 | backlog-phase-3.md | Daily Summary |

---

## Shared Resources

Common resources used across phases:

| Resource | Location |
|----------|----------|
| Resume Context Schema | shared/resume-context.md |
| Error Handling | shared/error-handling.md |
| Skill Extraction | shared/skill-extraction.md |
