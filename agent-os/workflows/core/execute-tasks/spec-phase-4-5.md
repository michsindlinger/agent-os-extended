---
description: Spec Phase 4.5 - Integration Validation before PR
version: 3.0
---

# Spec Phase 4.5: Integration Validation

## Purpose
Validate complete system works end-to-end AFTER all stories complete, BEFORE creating PR.
Prevents "stories done but system doesn't work" problem.

## Entry Condition
- kanban-board.md shows: all-stories-done
- All stories in Done column

## Actions

<step name="load_spec_integration_requirements">
  READ: agent-os/specs/{SELECTED_SPEC}/spec.md
  EXTRACT: Integration Requirements section
  CHECK: Does spec have integration requirements defined?
</step>

<step name="check_mcp_tools">
  RUN: claude mcp list
  EXTRACT: Available MCP tools (playwright, browser automation)
  NOTE: Tests requiring unavailable MCP tools will be skipped
</step>

<step name="detect_integration_type">
  ANALYZE: Integration Type from spec.md

  | Integration Type | Action |
  |------------------|--------|
  | Backend-only | API + DB integration tests |
  | Frontend-only | Component tests, optional browser |
  | Full-stack | All tests + E2E |
  | Not defined | Basic smoke tests |
</step>

<step name="run_integration_tests" subagent="test-runner">
  USE: test-runner subagent

  PROMPT: "Run integration validation for spec: {SELECTED_SPEC}

  **Integration Requirements from spec.md:**
  [EXTRACT integration test commands]

  **Test Execution Strategy:**
  1. Skip tests requiring unavailable MCP tools
  2. Execute in order: Backend → Frontend → E2E
  3. Report: PASSED / FAILED / SKIPPED

  **Important:**
  - Not about unit tests (ran during story execution)
  - About validating components work TOGETHER"
</step>

<step name="handle_integration_failures">
  CHECK: Integration test results

  IF all tests PASSED:
    LOG: "Integration validation passed"
    PROCEED: To Phase 5

  ELSE (some FAILED):
    GENERATE: Integration Fix Report

    CREATE: Integration fix story
    - File: agent-os/specs/{SELECTED_SPEC}/stories/story-999-integration-fix.md

    UPDATE: kanban-board.md
    - Add integration-fix story to Backlog
    - Set Phase: 4.5 (Integration Fix Needed)

    ASK via AskUserQuestion:
    "Integration validation failed. Options:
    1. Execute integration-fix story now (Recommended)
    2. Review and manually fix
    3. Skip and create PR anyway (NOT RECOMMENDED)"

    | Choice | Action |
    |--------|--------|
    | 1 | Execute fix story, repeat Phase 4.5 |
    | 2 | Stop, wait for manual fix |
    | 3 | Warn and proceed to Phase 5 |
</step>

## Phase Completion

<phase_complete>
  UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT - see shared/resume-context.md)
    Resume Context table fields:
    | **Current Phase** | 5-ready |
    | **Next Phase** | 5 - Finalize |
    | **Current Story** | None |
    | **Last Action** | Integration validation: PASSED |
    | **Next Action** | Create pull request |

  OUTPUT to user:
  ---
  ## Phase 4.5 Complete: Integration Validation

  **Integration Tests:** All passed

  **System Status:** Fully functional and integrated

  **Next Phase:** Create Pull Request

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 5
</phase_complete>
