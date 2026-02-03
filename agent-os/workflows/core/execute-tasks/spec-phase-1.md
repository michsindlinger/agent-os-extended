---
description: Spec Phase 1 - Initialize and create Kanban Board (JSON v4.0)
version: 4.0
---

# Spec Phase 1: Initialize

## What's New in v4.0

**JSON-Based Kanban:**
- Creates `kanban.json` statt `kanban-board.md`
- Falls kanban.json bereits existiert (von /create-spec), wird es nur validiert
- Strukturierte Daten für bessere Resumability

## What's New in v3.2

**Hybrid Template Lookup:**
- Templates are now searched in order: local → global
- Local: `agent-os/templates/json/`
- Global: `~/.agent-os/templates/json/`

## What's New in v3.1

**Integration Context:**
- Creates `integration-context.md` for cross-story context preservation
- Enables proper integration when stories execute in separate sessions

## Purpose
Select specification and validate/create Kanban Board. One-time setup phase.

## Entry Condition
- No kanban.json exists OR kanban.json needs initialization

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

<step name="check_existing_kanban_json">
  ### Check for Existing kanban.json

  CHECK: Does kanban.json already exist?
  ```bash
  ls agent-os/specs/${SELECTED_SPEC}/kanban.json 2>/dev/null
  ```

  IF kanban.json EXISTS:
    READ: kanban.json
    VALIDATE: JSON structure is valid

    IF resumeContext.currentPhase != "1-kanban-setup":
      LOG: "kanban.json already initialized by /create-spec"
      GOTO: create_integration_context

    ELSE:
      LOG: "kanban.json exists but needs completion"
      CONTINUE: To story parsing

  ELSE (no kanban.json):
    LOG: "Creating new kanban.json"
    CONTINUE: To create_kanban_json
</step>

<step name="create_kanban_json">
  ### Create/Update Kanban JSON

  **TEMPLATE LOOKUP (Hybrid - v4.0):**
  1. Local: agent-os/templates/json/spec-kanban-template.json
  2. Global: ~/.agent-os/templates/json/spec-kanban-template.json

  READ: Template file

  LIST: All story files in agent-os/specs/{SELECTED_SPEC}/stories/
  ```bash
  ls agent-os/specs/${SELECTED_SPEC}/stories/story-*.md
  ```

  SET: stories_data = []
  SET: total_effort = 0

  FOR EACH story file:
    READ: Story file
    EXTRACT:
    - Story ID (from filename: story-XXX-slug.md)
    - Title
    - Type (frontend/backend/devops/test/docs/integration)
    - Dependencies (array of story IDs)
    - Effort (story points)
    - Priority

    VALIDATE DoR:
    - CHECK: All DoR checkboxes are marked [x]
    - IF any [ ] unchecked: status = "blocked"
    - IF all [x]: status = "ready"

    ADD to stories_data[]:
    ```json
    {
      "id": "{STORY_ID}",
      "title": "{TITLE}",
      "file": "stories/{FILENAME}",
      "type": "{TYPE}",
      "priority": "{PRIORITY}",
      "effort": {EFFORT},
      "status": "ready|blocked",
      "phase": "pending",
      "dependencies": ["{DEP_1}", "{DEP_2}"],
      "blockedBy": [],
      "timing": {
        "createdAt": "{FILE_DATE}",
        "startedAt": null,
        "completedAt": null
      },
      "implementation": {
        "filesModified": [],
        "commits": []
      },
      "verification": {
        "dodChecked": false,
        "integrationVerified": false
      }
    }
    ```

    total_effort += EFFORT

  CREATE: agent-os/specs/{SELECTED_SPEC}/kanban.json

  **JSON Content:**
  ```json
  {
    "$schema": "../../templates/schemas/spec-kanban-schema.json",
    "version": "1.0",

    "spec": {
      "id": "{SELECTED_SPEC}",
      "name": "{SPEC_NAME}",
      "prefix": "{SPEC_PREFIX}",
      "specFile": "spec.md",
      "specLiteFile": "spec-lite.md",
      "createdAt": "{NOW}"
    },

    "resumeContext": {
      "currentPhase": "1-complete",
      "nextPhase": "2-worktree-setup",
      "worktreePath": null,
      "gitBranch": null,
      "gitStrategy": null,
      "currentStory": null,
      "currentStoryPhase": null,
      "lastAction": "Kanban board created",
      "nextAction": "Setup git worktree or branch",
      "progressIndex": 0,
      "totalStories": {STORIES_COUNT}
    },

    "execution": {
      "status": "not_started",
      "startedAt": null,
      "completedAt": null,
      "model": null
    },

    "stories": [STORIES_DATA],

    "boardStatus": {
      "total": {STORIES_COUNT},
      "ready": {READY_COUNT},
      "inProgress": 0,
      "inReview": 0,
      "testing": 0,
      "done": 0,
      "blocked": {BLOCKED_COUNT}
    },

    "statistics": {
      "totalEffort": {total_effort},
      "completedEffort": 0,
      "remainingEffort": {total_effort},
      "progressPercent": 0,
      "byType": {...},
      "byPriority": {...}
    },

    "executionPlan": {
      "strategy": "dependency-aware",
      "phases": []
    },

    "changeLog": [
      {
        "timestamp": "{NOW}",
        "action": "kanban_created",
        "storyId": null,
        "details": "Kanban initialized with {STORIES_COUNT} stories"
      }
    ]
  }
  ```

  WRITE: kanban.json
</step>

<step name="create_integration_context" subagent="file-creator">
  USE: file-creator subagent

  PROMPT: "Create integration context file for spec execution.

  Output: agent-os/specs/{SELECTED_SPEC}/integration-context.md

  Content:
  ```markdown
  # Integration Context

  > **Purpose:** Cross-story context preservation for multi-session execution.
  > **Auto-updated** after each story completion.
  > **READ THIS** before implementing the next story.

  ---

  ## Completed Stories

  | Story | Summary | Key Changes |
  |-------|---------|-------------|
  | - | No stories completed yet | - |

  ---

  ## New Exports & APIs

  ### Components
  <!-- New UI components created -->
  _None yet_

  ### Services
  <!-- New service classes/modules -->
  _None yet_

  ### Hooks / Utilities
  <!-- New hooks, helpers, utilities -->
  _None yet_

  ### Types / Interfaces
  <!-- New type definitions -->
  _None yet_

  ---

  ## Integration Notes

  <!-- Important integration information for subsequent stories -->
  _None yet_

  ---

  ## File Change Summary

  | File | Action | Story |
  |------|--------|-------|
  | - | No changes yet | - |
  ```
  "

  WAIT: For file-creator completion
</step>

## Phase Completion

<phase_complete>
  ### Finalize kanban.json

  READ: agent-os/specs/{SELECTED_SPEC}/kanban.json

  UPDATE (if not already set):
  - resumeContext.currentPhase = "1-complete"
  - resumeContext.nextPhase = "2-worktree-setup"
  - resumeContext.lastAction = "Phase 1 complete - Kanban initialized"
  - resumeContext.nextAction = "Setup git strategy (worktree or branch)"

  ADD to changeLog[]:
  ```json
  {
    "timestamp": "{NOW}",
    "action": "phase_completed",
    "storyId": null,
    "details": "Phase 1 complete - {boardStatus.total} stories ready"
  }
  ```

  WRITE: kanban.json

  OUTPUT to user:
  ---
  ## Phase 1 Complete: Initialization

  **Created:**
  - Kanban JSON: agent-os/specs/{SELECTED_SPEC}/kanban.json
  - Integration Context: agent-os/specs/{SELECTED_SPEC}/integration-context.md
  - Stories loaded: {boardStatus.ready} ready, {boardStatus.blocked} blocked

  **Next Phase:** Git Strategy Setup (Worktree or Branch)

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks
  ```
  ---

  STOP: Do not proceed to Phase 2
</phase_complete>
