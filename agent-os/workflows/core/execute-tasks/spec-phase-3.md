---
description: Spec Phase 3 - Execute one user story completely
version: 3.0
---

# Spec Phase 3: Execute Story

## Purpose
Execute ONE user story completely, including quality gates.
This phase repeats for each story in the backlog.

## Entry Condition
- kanban-board.md exists
- Resume Context shows: Phase 2-complete OR story-complete
- Stories remain in Backlog

## Actions

<step name="load_state">
  READ: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  EXTRACT: Resume Context
  IDENTIFY: Next eligible story from Backlog (respecting dependencies)
</step>

<step name="story_selection">
  ANALYZE: Backlog stories
  CHECK: Dependencies for each story

  FOR each story in Backlog:
    IF dependencies = "None" OR all_dependencies_in_done:
      SELECT: This story
      BREAK

  IF no eligible story:
    ERROR: "All remaining stories have unmet dependencies"
    LIST: Blocked stories and their dependencies
</step>

<step name="update_kanban_in_progress">
  UPDATE: kanban-board.md
    - MOVE: Selected story from Backlog to "In Progress"
    - UPDATE Board Status: In Progress +1, Backlog -1
    - SET Resume Context: Current Story = [story-id]
    - ADD Change Log entry
</step>

<step name="extract_skill_patterns">
  ### Skill Pattern Extraction

  1. READ: Story file (agent-os/specs/{SELECTED_SPEC}/stories/story-XXX-[slug].md)

  2. FIND: "### Relevante Skills" section
     EXTRACT: Table rows with skill paths

  3. IF NOT found:
     FALLBACK: Use skill-index.md
     READ: agent-os/team/skill-index.md
     MATCH: Story type to skill category
     SELECT: 1-2 default skills

  4. FOR EACH skill:
     READ: Skill file
     FIND: "## Quick Reference" section
     EXTRACT: Content (50-100 lines)

  5. FORMAT:
     ```
     ### Patterns & Guidelines (from skills)

     #### [Skill Name]
     [Quick Reference content]
     ```

  OUTPUT: SKILL_PATTERNS variable
</step>

<step name="execute_story" subagent="dev-team">
  DETERMINE: Agent type from story

  | story.type | Agent |
  |------------|-------|
  | Backend | dev-team__backend-developer-* |
  | Frontend | dev-team__frontend-developer-* |
  | DevOps | dev-team__dev-ops-specialist |
  | Test | dev-team__qa-specialist |

  DELEGATE via Task tool:
  "Execute User Story: [Story Title]

  **Story Details:**
  [Story file content - exclude 'Relevante Skills' section]

  **DoD Criteria:**
  [DoD checklist]

  {SKILL_PATTERNS}

  **File Organization (CRITICAL):**
  - NO files in project root
  - Reports: agent-os/specs/{SELECTED_SPEC}/implementation-reports/
  "

  WAIT: For agent completion
</step>

<step name="architect_review" subagent="dev-team__architect">
  UPDATE: kanban-board.md
    - MOVE: Story to "In Review"
    - UPDATE Board Status

  DELEGATE: dev-team__architect
  "Review code for Story [story-id].
  Context: Story file + git changes
  Review: Architecture, patterns, security, code quality."

  IF rejected: DELEGATE_BACK with feedback, REPEAT
</step>

<step name="ux_review" condition="story.type includes Frontend" subagent="ux-designer">
  DELEGATE: ux-designer
  "UX Review for Story [story-id].
  Review: UX patterns, accessibility, mobile responsiveness."

  IF rejected: DELEGATE_BACK, REPEAT
</step>

<step name="qa_testing" subagent="dev-team__qa-specialist">
  UPDATE: kanban-board.md
    - MOVE: Story to "Testing"
    - UPDATE Board Status

  DELEGATE: dev-team__qa-specialist
  "Test Story [story-id]:
  - Run all tests
  - Verify DoD criteria
  - Perform acceptance testing"

  IF rejected: DELEGATE_BACK, REPEAT
</step>

<step name="story_commit" subagent="git-workflow">
  UPDATE: kanban-board.md
    - MOVE: Story to "Done"
    - UPDATE Board Status: Testing -1, Completed +1

  USE: git-workflow subagent
  "Commit story [story-id]:
  - Message: feat/fix: [story-id] [Story Title]
  - Push to remote"
</step>

## Phase Completion

<phase_complete>
  CHECK: Remaining stories in Backlog

  IF backlog NOT empty:
    UPDATE: kanban-board.md
      - Current Phase: story-complete
      - Next Phase: 3 - Execute Story (next)
      - Current Story: None

    OUTPUT to user:
    ---
    ## Story Complete: [story-id] - [Story Title]

    **Progress:** [X] of [TOTAL] stories
    **Remaining:** [Y] stories

    **Next:** Execute next story

    ---
    **To continue, run:**
    ```
    /clear
    /execute-tasks
    ```
    ---

    STOP: Do not proceed to next story

  ELSE (backlog empty):
    UPDATE: kanban-board.md
      - Current Phase: all-stories-done
      - Next Phase: 4.5 - Integration Validation

    OUTPUT to user:
    ---
    ## All Stories Complete!

    **Progress:** [TOTAL] of [TOTAL] stories

    **Next Phase:** Integration Validation

    ---
    **To continue, run:**
    ```
    /clear
    /execute-tasks
    ```
    ---

    STOP: Do not proceed to Phase 4.5
</phase_complete>
