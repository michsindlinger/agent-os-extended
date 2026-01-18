---
description: Resume Context Schema - shared across all phases
version: 3.0
---

# Resume Context Schema

The Resume Context in kanban-board.md enables phase recovery.

## Required Fields

| Field | Description | Example Values |
|-------|-------------|----------------|
| **Current Phase** | Phase identifier | 1-complete, 2-complete, story-complete, all-stories-done, 5-ready, complete |
| **Next Phase** | What to execute next | 2 - Git Worktree, 3 - Execute Story, 4.5 - Integration Validation, 5 - Finalize, None |
| **Spec Folder** | Full path | agent-os/specs/2026-01-13-feature-name |
| **Worktree Path** | Git worktree path | agent-os/worktrees/feature-name or Pending |
| **Git Branch** | Branch name | feature-name or Pending |
| **Current Story** | Story being worked on | STORY-001 or None |
| **Last Action** | What just happened | Kanban board created |
| **Next Action** | What needs to happen | Create git worktree |

## Board Status Metrics

For shell script parsing:

| Field | Parse Pattern | Example |
|-------|---------------|---------|
| **Total Stories** | `Total Stories.*\*\*.*([0-9]+)` | 4 |
| **Completed** | `Completed.*\*\*.*([0-9]+)` | 2 |
| **In Progress** | `In Progress.*\*\*.*([0-9]+)` | 0 |
| **In Review** | `In Review.*\*\*.*([0-9]+)` | 0 |
| **Testing** | `Testing.*\*\*.*([0-9]+)` | 0 |
| **Backlog** | `Backlog.*\*\*.*([0-9]+)` | 2 |

## Update Rules

UPDATE kanban-board.md at:
- End of each phase (Resume Context + Change Log)
- Before any STOP point
- After any state change (story movement, status change)

CRITICAL: Always maintain the template structure exactly.
