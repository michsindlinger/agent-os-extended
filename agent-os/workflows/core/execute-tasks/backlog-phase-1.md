---
description: Backlog Phase 1 - Initialize Daily Kanban (JSON v4.0)
version: 4.0
---

# Backlog Phase 1: Initialize Daily Kanban

## What's New in v4.0

**JSON-Based Kanban:**
- Creates `executions/kanban-${TODAY}.json` statt `.md`
- Liest Items aus `backlog.json`
- Strukturierte Daten für bessere Resumability

## Purpose
Create today's Kanban Board for backlog execution.

## Entry Condition
- EXECUTION_MODE = "backlog"
- No executions/kanban-[TODAY].json exists

## Actions

<step name="get_today_date">
  USE: date-checker to get current date
  SET: TODAY = YYYY-MM-DD
  SET: NOW = ISO-8601 timestamp
</step>

<step name="read_backlog_json">
  ### Read Backlog JSON

  READ: agent-os/backlog/backlog.json

  IF file NOT exists:
    ERROR: "backlog.json nicht gefunden. Führe erst /add-bug oder /add-todo aus."
    STOP

  EXTRACT: All items from items[] array
  FILTER: items where status = "ready"

  SET: ready_items = filtered items
  SET: blocked_items = items where status = "blocked"
  SET: TOTAL_ITEMS = ready_items.length
</step>

<step name="create_daily_kanban_json">
  ### Create Daily Kanban JSON

  CREATE: agent-os/backlog/executions/ directory if not exists
  ```bash
  mkdir -p agent-os/backlog/executions
  ```

  **TEMPLATE LOOKUP (Hybrid):**
  1. Local: agent-os/templates/json/execution-kanban-template.json
  2. Global: ~/.agent-os/templates/json/execution-kanban-template.json

  READ: Template file

  CREATE: agent-os/backlog/executions/kanban-{TODAY}.json

  **JSON Content:**
  ```json
  {
    "$schema": "../../templates/schemas/execution-kanban-schema.json",
    "version": "1.0",

    "execution": {
      "id": "kanban-{TODAY}",
      "date": "{TODAY}",
      "startedAt": "{NOW}",
      "completedAt": null,
      "status": "executing"
    },

    "resumeContext": {
      "currentPhase": "1-complete",
      "currentItem": null,
      "currentStoryPhase": null,
      "worktreePath": null,
      "gitBranch": null,
      "lastAction": "Execution kanban created",
      "nextAction": "Execute first item",
      "progressIndex": 0,
      "totalItems": {TOTAL_ITEMS}
    },

    "sourceBacklog": {
      "path": "../backlog.json",
      "snapshotAt": "{NOW}"
    },

    "items": [
      // COPY: Each ready_item with executionStatus = "queued"
      {
        "id": "{item.id}",
        "title": "{item.title}",
        "type": "{item.type}",
        "priority": "{item.priority}",
        "effort": {item.effort},
        "category": "{item.category}",
        "sourceFile": "{item.sourceFile}",
        "executionStatus": "queued",
        "timing": {
          "queuedAt": "{NOW}",
          "startedAt": null,
          "completedAt": null
        }
      }
    ],

    "boardStatus": {
      "total": {TOTAL_ITEMS},
      "queued": {TOTAL_ITEMS},
      "inProgress": 0,
      "inReview": 0,
      "testing": 0,
      "done": 0,
      "blocked": 0,
      "skipped": 0
    },

    "executionOrder": [
      // IDs in execution order (by priority, then by creation date)
    ],

    "changeLog": [
      {
        "timestamp": "{NOW}",
        "action": "kanban_created",
        "itemId": null,
        "details": "Execution kanban created with {TOTAL_ITEMS} items"
      }
    ]
  }
  ```

  **Sort executionOrder by:**
  1. Priority: critical > high > medium > low
  2. Creation date (oldest first)
</step>

<step name="update_backlog_json">
  ### Update Backlog JSON

  READ: agent-os/backlog/backlog.json

  UPDATE:
  - resumeContext.activeKanban = "kanban-{TODAY}"
  - resumeContext.currentPhase = "executing"
  - resumeContext.lastExecution = "{TODAY}"
  - resumeContext.lastAction = "Execution started"
  - resumeContext.nextAction = "Execute items from kanban-{TODAY}"

  ADD to executions[]:
  ```json
  {
    "id": "kanban-{TODAY}",
    "date": "{TODAY}",
    "status": "active",
    "itemCount": {TOTAL_ITEMS}
  }
  ```

  ADD to changeLog[]:
  ```json
  {
    "timestamp": "{NOW}",
    "action": "execution_started",
    "itemId": null,
    "details": "Started execution kanban-{TODAY} with {TOTAL_ITEMS} items"
  }
  ```

  WRITE: backlog.json
</step>

## Phase Completion

<phase_complete>
  OUTPUT to user:
  ---
  ## Backlog Phase 1 Complete: Daily Kanban Created

  **Date:** {TODAY}
  **Items Ready:** {TOTAL_ITEMS}
  **Blocked:** {blocked_items.length}

  **Execution Kanban:** agent-os/backlog/executions/kanban-{TODAY}.json
  **Backlog Updated:** agent-os/backlog/backlog.json

  **Next Phase:** Execute First Item

  ---
  **To continue, run:**
  ```
  /clear
  /execute-tasks backlog
  ```
  ---

  STOP: Do not proceed to Backlog Phase 2
</phase_complete>
