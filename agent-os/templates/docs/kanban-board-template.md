# Kanban Board: {{SPEC_NAME}}

## Resume Context

> **CRITICAL**: This section is used for phase recovery after /clear or conversation compaction.
> **NEVER** change the field names or format.

| Field | Value |
|-------|-------|
| **Current Phase** | {{CURRENT_PHASE}} |
| **Next Phase** | {{NEXT_PHASE}} |
| **Spec Folder** | agent-os/specs/{{SPEC_FOLDER}} |
| **Current Story** | {{CURRENT_STORY}} |
| **Last Action** | {{LAST_ACTION}} |
| **Next Action** | {{NEXT_ACTION}} |

---

## Board Status

| Metric | Value |
|--------|-------|
| **Total Stories** | {{TOTAL_STORIES}} |
| **Completed** | {{COMPLETED_COUNT}} |
| **In Progress** | {{IN_PROGRESS_COUNT}} |
| **In Review** | {{IN_REVIEW_COUNT}} |
| **Testing** | {{TESTING_COUNT}} |
| **Backlog** | {{BACKLOG_COUNT}} |

---

## Backlog

<!-- Stories that have not started yet -->

{{BACKLOG_STORIES}}

---

## In Progress

<!-- Stories currently being worked on -->

{{IN_PROGRESS_STORIES}}

---

## In Review

<!-- Stories awaiting architecture/UX review -->

{{IN_REVIEW_STORIES}}

---

## Testing

<!-- Stories being tested -->

{{TESTING_STORIES}}

---

## Done

<!-- Stories that are complete -->

{{DONE_STORIES}}

---

## Change Log

<!-- Track all changes to the board -->

| Timestamp | Story | From | To | Notes |
|-----------|-------|------|-----|-------|
{{CHANGE_LOG_ENTRIES}}
