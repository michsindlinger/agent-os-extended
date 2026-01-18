---
description: Backlog Phase 2 - Execute one backlog story
version: 4.0
---

# Backlog Phase 2: Execute Story

## Purpose
Execute ONE backlog story. Simpler than spec execution (no git worktree, no integration phase).

## Entry Condition
- kanban-[TODAY].md exists
- Resume Context shows: Phase 1-complete OR story-complete
- Stories remain in Backlog

## Actions

<step name="load_state">
  READ: agent-os/backlog/kanban-{TODAY}.md
  EXTRACT: Resume Context
  IDENTIFY: Next story from Backlog
</step>

<step name="story_selection">
  SELECT: First story from Backlog section
  (Backlog stories have no dependencies - execute in order)
</step>

<step name="update_kanban_in_progress">
  UPDATE: kanban-{TODAY}.md
    - MOVE: Selected story from Backlog to "In Progress"
    - UPDATE Board Status
    - SET Resume Context: Current Story = [story-id]
    - ADD Change Log entry
</step>

<step name="extract_skill_paths_backlog">
  ### Skill Path Extraction for Backlog (v4.0)

  REFERENCE: agent-os/workflows/core/execute-tasks/shared/skill-extraction.md

  1. READ: Story file (agent-os/backlog/{STORY_FILE})

  2. FIND: "### Relevante Skills" section
     IF found: EXTRACT skill paths from table (Pfad column)

     FALLBACK: Use agent-os/team/skill-index.md (if exists)
     MATCH: story.type to default skills

     IF NO skills found:
       SKIP: Skill extraction (backlog tasks often simpler)
       SET: SKILL_PATHS = ""

  3. COLLECT: Skill file paths only
     DO NOT: Read skill contents
     (Sub-agent will load complete skills)

  4. FORMAT (if skills found):
     ```
     **Required Skills (load these files):**
     - [skill-path-1]
     - [skill-path-2]
     ```

  OUTPUT: SKILL_PATHS variable (may be empty)
</step>

<step name="execute_story" subagent="dev-team">
  DETERMINE: Agent type from story.type

  | story.type | Agent |
  |------------|-------|
  | Backend | dev-team__backend-developer-* |
  | Frontend | dev-team__frontend-developer-* |
  | DevOps | dev-team__dev-ops-specialist |
  | Test | dev-team__qa-specialist |

  DELEGATE via Task tool:
  "Execute Backlog Story: [Story Title]

  **Story File:** agent-os/backlog/{STORY_FILE}

  **DoD Criteria:**
  [DoD checklist from story file]

  {SKILL_PATHS}

  **INSTRUCTIONS:**
  - Load each skill file listed above completely (if any)
  - Follow patterns and guidelines from the skills
  - Quick task, keep it focused
  - No extensive refactoring
  - Commit when done"

  WAIT: For agent completion
</step>

<step name="quick_review">
  VERIFY: DoD criteria met
  RUN: Completion Check commands from story

  IF all pass: PROCEED to commit
  ELSE: DELEGATE_BACK with feedback
</step>

<step name="story_commit" subagent="git-workflow">
  UPDATE: kanban-{TODAY}.md
    - MOVE: Story from "In Progress" to "Done"
    - UPDATE Board Status
    - ADD Change Log entry

  USE: git-workflow subagent
  "Commit backlog story {STORY_ID}:
  - Message: fix/feat: {STORY_ID} [Story Title]
  - Stage only relevant files
  - Push to current branch"
</step>

## Phase Completion

<phase_complete>
  CHECK: Remaining stories in Backlog

  IF backlog NOT empty:
    UPDATE: kanban-{TODAY}.md Resume Context
      - Current Phase: story-complete
      - Next Phase: 2 - Execute Story (next)
      - Current Story: None

    OUTPUT to user:
    ---
    ## Story Complete: {STORY_ID}

    **Progress:** {COMPLETED} of {TOTAL} stories today

    **Next:** Execute next story

    ---
    **To continue, run:**
    ```
    /clear
    /execute-tasks backlog
    ```
    ---

    STOP: Do not proceed to next story

  ELSE (backlog empty):
    UPDATE: kanban-{TODAY}.md Resume Context
      - Current Phase: all-stories-done
      - Next Phase: 3 - Daily Summary

    OUTPUT to user:
    ---
    ## All Backlog Stories Complete!

    **Today's Progress:** {TOTAL} stories completed

    **Next Phase:** Daily Summary

    ---
    **To continue, run:**
    ```
    /clear
    /execute-tasks backlog
    ```
    ---

    STOP: Do not proceed to Backlog Phase 3
</phase_complete>
