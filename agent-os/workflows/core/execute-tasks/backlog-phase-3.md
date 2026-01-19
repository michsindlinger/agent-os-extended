---
description: Backlog Phase 3 - Daily Summary
version: 3.2
---

# Backlog Phase 3: Daily Summary

## Purpose
Summarize today's work and update story-index.

## Entry Condition
- kanban-{TODAY}.md shows: all-stories-done
- All stories in Done column

## Actions

<step name="verify_stories_marked_done">
  FALLBACK: Verify all completed stories have Status: Done in their files
  (Primary update happens in Phase 2, this is a safety check)

  FOR EACH completed story from kanban Done column:
    READ: Story file (agent-os/backlog/{story-file}.md)
    CHECK: Status field

    IF Status != "Done":
      UPDATE: Status field to "Done"
      WRITE: Updated story file
      LOG: "Fixed missing status update for {story-file}"

  NOTE: This catches any stories that weren't properly marked in Phase 2
</step>

<step name="update_story_index">
  READ: agent-os/backlog/story-index.md

  FOR EACH completed story:
    UPDATE: Status = "Done"
    UPDATE: Completed date

  UPDATE: Totals
    - Completed: +N
    - Ready for Execution: -N

  ADD: Today's kanban to Execution History table

  WRITE: Updated story-index.md
</step>

<step name="archive_completed_stories">
  OPTIONAL: Move completed story files to archive

  FOR EACH completed story from kanban Done column:
    ```bash
    mkdir -p agent-os/backlog/archive/{TODAY}
    mv agent-os/backlog/{STORY_FILENAME} agent-os/backlog/archive/{TODAY}/
    ```

  NOTE: Only move stories that were completed today, not all stories in the directory
</step>

## Phase Completion

<phase_complete>
  UPDATE: kanban-{TODAY}.md Resume Context
    - Current Phase: complete
    - Next Phase: None

  OUTPUT to user:
  ---
  ## Daily Backlog Execution Complete!

  ### Today's Summary ({TODAY})

  **Completed Stories:**
  {LIST_OF_COMPLETED_STORIES}

  **Kanban:** agent-os/backlog/kanban-{TODAY}.md

  ### What's Next?
  1. Add more tasks: `/add-todo "[description]"`
  2. Create spec for larger features: `/create-spec`
  3. Tomorrow: `/execute-tasks backlog` for new daily kanban

  ---
  **Backlog execution finished for today.**
  ---
</phase_complete>
