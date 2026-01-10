---
description: Rules to initiate execution of a set of tasks using Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Task Execution Rules

## Overview

Initiate execution of one or more tasks for a given spec.

<pre_flight_check>
  EXECUTE: @~/.agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="file-creator" name="kanban_board_management">

### Step 1: Kanban Board Management

Use the file-creator subagent to create or load the kanban board for state persistence and resume capability.

<board_check>
  CHECK: Does kanban-board.md exist in spec folder?
  PATH: agent-os/specs/[SPEC_FOLDER]/kanban-board.md
</board_check>

<decision_tree>
  IF kanban-board.md EXISTS:
    <!-- Resume Mode -->
    <resume_mode>
      ACTION: Load existing kanban-board.md
      ANALYZE: Current board state
      CHECK: Stories in "In Progress" column

      IF stories_in_progress > 0:
        ASK user: "Found {count} stories in progress. Would you like to:
                   1. Resume from where we left off
                   2. Reset and start fresh
                   3. Skip these and continue with next stories"

        IF user_choice = resume:
          LOAD: In Progress stories
          CONTINUE: With those stories
        ELSE IF user_choice = reset:
          MOVE: In Progress stories back to Backlog
          UPDATE: kanban-board.md
          CONTINUE: With fresh start
        ELSE IF user_choice = skip:
          MARK: In Progress stories as "Paused"
          CONTINUE: With next Backlog stories
      ELSE:
        STATE: "Resuming execution from saved state"
        CONTINUE: With next Backlog story
    </resume_mode>
  ELSE:
    <!-- First Run Mode -->
    <first_run_mode>
      ACTION: Use file-creator subagent to create kanban-board.md
      SOURCE: Parse user-stories.md
      INITIALIZE: All stories in Backlog column
      CREATE: Board structure with sections:
        - Board Status (metrics)
        - Backlog
        - In Progress
        - In Review
        - Testing
        - Done
        - Progress Metrics
        - Dependencies Graph
        - Change Log
      TIMESTAMP: Board creation time
    </first_run_mode>
</decision_tree>

<kanban_structure>
  <header>
    # Kanban Board - [Spec Name]

    > Spec: agent-os/specs/[SPEC_FOLDER]/
    > Created: [TIMESTAMP]
    > Last Updated: [TIMESTAMP]
  </header>

  <board_status>
    ## 📊 Board Status

    | Backlog | In Progress | In Review | Testing | Done |
    |---------|-------------|-----------|---------|------|
    | X | Y | Z | A | B |
  </board_status>

  <columns>
    - 🔴 Backlog: Stories not yet started
    - 🟡 In Progress: Currently being worked on
    - 🔵 In Review: Awaiting architect review
    - 🟣 Testing: Awaiting QA sign-off
    - ✅ Done: Completed and verified
  </columns>

  <story_format>
    - [ ] **Story X**: [Title]
      - **ID**: story-x
      - **Type**: Backend/Frontend/DevOps/Test
      - **Assigned**: [Agent name]
      - **Dependencies**: [Story IDs or "None"]
      - **Estimated**: [Story Points]
      - **Progress**: [Current status details]
      - **DoR**: ✅/❌
      - **DoD**: X/Y items complete
  </story_format>

  <metrics>
    ## 📈 Progress Metrics
    - Total Stories: X
    - Completed: Y (Z%)
    - In Progress: A
    - Remaining: B
    - Estimated Total SP: XX
    - Completed SP: YY (ZZ%)
  </metrics>

  <change_log>
    ## 📝 Change Log
    | Timestamp | Event | Story | Agent | Details |
    |-----------|-------|-------|-------|---------|
    | [ISO 8601] | [Event Type] | story-x | [Agent] | [Details] |
  </change_log>
</kanban_structure>

<instructions>
  ACTION: Check for existing kanban-board.md
  IF_EXISTS: Offer resume/reset options
  IF_NEW: Create board from user-stories.md
  INITIALIZE: Board state tracking
  PREPARE: For execution loop integration
</instructions>

</step>

<step number="2" name="story_selection">

### Step 2: Story Selection from Kanban Board

Select the next story to execute from the Kanban Board, respecting dependencies and parallel execution capabilities.

<selection_strategy>
  <from_kanban>
    SOURCE: kanban-board.md Backlog section
    PRIORITY: Next story in order (unless dependencies)
  </from_kanban>

  <dependency_check>
    FOR each story in Backlog:
      CHECK: Dependencies field
      IF dependencies = "None" OR all_dependencies_in_done:
        ELIGIBLE: Story can be started
      ELSE:
        BLOCKED: Skip to next story
  </dependency_check>

  <parallel_execution>
    IF multiple_stories_eligible:
      CHECK: Story types
      IF different_types (e.g., backend + frontend):
        CONSIDER: Parallel execution
        ASK user: "Stories X and Y can run in parallel. Execute both? (yes/no)"
        IF yes:
          SELECT: Multiple stories
        ELSE:
          SELECT: First eligible story
      ELSE:
        SELECT: First eligible story
  </parallel_execution>

  <user_override>
    IF user_specifies_story:
      VALIDATE: Story exists and dependencies met
      IF valid:
        SELECT: User-specified story
      ELSE:
        WARN: Dependencies not met
        FALLBACK: Suggest next eligible story
  </user_override>
</selection_strategy>

<instructions>
  ACTION: Load kanban-board.md
  ANALYZE: Backlog stories
  CHECK: Dependencies for each story
  SELECT: Next eligible story (or multiple if parallel)
  CONFIRM: Selection with user
  UPDATE: kanban-board.md → Move selected story to "In Progress"
  LOG: Change to Change Log section
</instructions>

</step>

<step number="3" subagent="context-fetcher" name="context_analysis">

### Step 3: Context Analysis

Use the context-fetcher subagent to gather minimal context for story understanding by loading the selected story from user-stories.md and conditionally loading @agent-os/product/mission-lite.md, spec-lite.md, and sub-specs/technical-spec.md if not already in context.

<instructions>
  ACTION: Use context-fetcher subagent to:
    - REQUEST: "Get product pitch from mission-lite.md"
    - REQUEST: "Get spec summary from spec-lite.md"
    - REQUEST: "Get technical approach from technical-spec.md"
    - REQUEST: "Get selected story details from user-stories.md"
  PROCESS: Returned information
</instructions>


<context_gathering>
  <essential_docs>
    - user-stories.md for selected story details
  </essential_docs>
  <conditional_docs>
    - mission-lite.md for product alignment
    - spec-lite.md for feature summary
    - technical-spec.md for implementation details
  </conditional_docs>
</context_gathering>

</step>

<step number="4" name="development_server_check">

### Step 4: Check for Development Server

Check for any running development server and ask user permission to shut it down if found to prevent port conflicts.

<server_check_flow>
  <if_running>
    ASK user to shut down
    WAIT for response
  </if_running>
  <if_not_running>
    PROCEED immediately
  </if_not_running>
</server_check_flow>

<user_prompt>
  A development server is currently running.
  Should I shut it down before proceeding? (yes/no)
</user_prompt>

<instructions>
  ACTION: Check for running local development server
  CONDITIONAL: Ask permission only if server is running
  PROCEED: Immediately if no server detected
</instructions>

</step>

<step number="5" subagent="git-workflow" name="git_branch_management">

### Step 5: Git Branch Management

Use the git-workflow subagent to manage git branches to ensure proper isolation by creating or switching to the appropriate branch for the spec.

<instructions>
  ACTION: Use git-workflow subagent
  REQUEST: "Check and manage branch for spec: [SPEC_FOLDER]
            - Create branch if needed
            - Switch to correct branch
            - Handle any uncommitted changes"
  WAIT: For branch setup completion
</instructions>

<branch_naming>
  <source>spec folder name</source>
  <format>exclude date prefix</format>
  <example>
    - folder: 2025-03-15-password-reset
    - branch: password-reset
  </example>
</branch_naming>

</step>

<step number="6" name="story_execution_loop">

### Step 6: Story Execution Loop with Kanban Integration

Execute the selected user story using the DevTeam agents with full Kanban Board state tracking and handover document management.

<orchestration_skill>
  LOAD: dev-team__skill__orchestration.md
  PROVIDES:
    - Smart agent assignment
    - Dependency tracking
    - Handover management
    - Quality gate enforcement
</orchestration_skill>

<execution_flow>
  FOR each selected_story from Step 2:

    <!-- Phase 1: Story Preparation -->
    <story_preparation>
      UPDATE kanban-board.md:
        - MOVE: Story from Backlog → "In Progress"
        - SET: Started timestamp
        - UPDATE: Board Status metrics
        - ADD: Change Log entry

      CHECK story.dependencies:
        IF dependencies exist AND handover_required:
          LOAD: handover-docs/[dependency-story-id]-handover.md
          PROVIDE: Handover context to agent
    </story_preparation>

    <!-- Phase 2: Agent Assignment -->
    <agent_assignment>
      ANALYZE: Story "WER" field from user-stories.md
      DETERMINE: Primary agent(s)

      <agent_selection>
        IF story.type = "Backend":
          SELECT: dev-team__backend-developer-X
          LOAD_SKILLS: backend skills for this story
        ELSE IF story.type = "Frontend":
          SELECT: dev-team__frontend-developer-X
          LOAD_SKILLS: frontend skills for this story
        ELSE IF story.type = "DevOps":
          SELECT: dev-team__dev-ops-specialist
          LOAD_SKILLS: devops skills for this story
        ELSE IF story.type = "Test":
          SELECT: dev-team__qa-specialist
          LOAD_SKILLS: qa skills for this story
        ELSE IF story.type = "Backend + Frontend":
          SELECT: backend-dev-X AND frontend-dev-Y
          SEQUENTIAL: Backend first, then frontend
      </agent_selection>

      UPDATE kanban-board.md:
        - SET: Assigned agent(s)
        - UPDATE: Story progress status
        - ADD: Change Log entry
    </agent_assignment>

    <!-- Phase 3: Story Execution -->
    <story_execution>
      DELEGATE: To selected agent(s) via Task tool

      <delegation_prompt>
        "Execute User Story: [Story Title]

        **Story Details:**
        - ID: [story-id]
        - Type: [story-type]
        - Description: [fachliche Beschreibung from user-stories.md]

        **Technical Refinement:**
        [WAS, WIE, WO, WER sections from user-stories.md]

        **DoR (Definition of Ready):**
        [DoR checklist from user-stories.md]

        **DoD (Definition of Done):**
        [DoD checklist from user-stories.md - this is your completion criteria]

        **Dependencies:**
        [If applicable] Handover document: agent-os/specs/[SPEC]/handover-docs/[file]

        **Instructions:**
        1. Implement according to technical specs
        2. Follow DoD checklist strictly
        3. Write tests as specified
        4. Document your work
        5. If this story has dependent stories, create handover document

        **Kanban Update:**
        Your progress will be tracked in kanban-board.md"
      </delegation_prompt>

      MONITOR: Agent execution
      TRACK: Progress updates

      UPDATE kanban-board.md periodically:
        - UPDATE: Progress field with agent status
        - UPDATE: DoD completion count
        - ADD: Change Log entries for milestones
    </story_execution>

    <!-- Phase 4: Quality Gates -->
    <quality_gates>
      WHEN agent_completes:

        <architect_review>
          UPDATE kanban-board.md:
            - MOVE: Story → "In Review"
            - ADD: Change Log entry

          DELEGATE: dev-team__architect
          PROMPT: "Review code for Story [story-id]:
                   - Check pattern enforcement
                   - Verify architecture compliance
                   - Validate API design (if applicable)
                   - Security review"

          IF architect_approves:
            CONTINUE: To QA testing
          ELSE:
            UPDATE kanban-board.md:
              - MOVE: Story → "In Progress"
              - ADD: Review feedback to Progress field
              - ADD: Change Log entry
            DELEGATE_BACK: To original agent with feedback
            REPEAT: Until approved
        </architect_review>

        <qa_testing>
          UPDATE kanban-board.md:
            - MOVE: Story → "Testing"
            - ADD: Change Log entry

          DELEGATE: dev-team__qa-specialist
          PROMPT: "Test Story [story-id]:
                   - Run all tests
                   - Verify DoD criteria
                   - Perform acceptance testing
                   - Report any issues"

          IF qa_approves:
            CONTINUE: To completion
          ELSE:
            UPDATE kanban-board.md:
              - MOVE: Story → "In Progress"
              - ADD: Test failures to Progress field
              - ADD: Change Log entry
            DELEGATE_BACK: To original agent with issues
            REPEAT: Until tests pass
        </qa_testing>
    </quality_gates>

    <!-- Phase 5: Story Completion -->
    <story_completion>
      UPDATE kanban-board.md:
        - MOVE: Story → "Done"
        - SET: Completed timestamp
        - SET: DoD status to ✅
        - UPDATE: Board Status metrics
        - UPDATE: Progress Metrics
        - ADD: Change Log entry

      <handover_check>
        IF story.has_dependent_stories:
          ENSURE: Handover document exists
          PATH: agent-os/specs/[SPEC]/handover-docs/[story-id]-handover.md
          CONTENT:
            - API contracts
            - Data structures
            - Integration points
            - Usage examples
          UPDATE kanban-board.md:
            - ADD: Handover document reference
      </handover_check>

      <dependency_update>
        CHECK kanban-board.md:
          FOR each story in Backlog:
            IF story.dependencies includes completed_story_id:
              UPDATE: Mark dependency as resolved
              CHECK: If all dependencies now resolved
              IF yes:
                STATE: Story now eligible for selection
      </dependency_update>
    </story_completion>

    <!-- Phase 6: Next Story Check -->
    <next_story_check>
      CHECK kanban-board.md Backlog:
        IF backlog_empty:
          STATE: "All stories complete!"
          EXIT: Execution loop
        ELSE:
          ASK user: "Story [story-id] complete. Continue with next story? (yes/no/which)"
          IF yes:
            RETURN: To Step 2 (Story Selection)
          ELSE IF which:
            ALLOW: User to specify story
            RETURN: To Step 2 with user selection
          ELSE:
            PAUSE: Execution
            STATE: "Execution paused. Resume with /execute-tasks"
            EXIT: Execution loop
    </next_story_check>

  END FOR
</execution_flow>

<error_handling>
  <blocking_issues>
    UPDATE kanban-board.md:
      - MOVE: Story → "Blocked" (new status)
      - SET: Blocker details in Progress field
      - ADD: Change Log entry
    NOTIFY: User of blocker
    ASK: How to proceed
  </blocking_issues>

  <agent_failures>
    LOG: Failure in Change Log
    RETRY: Up to 2 times
    IF still_failing:
      ESCALATE: To user
      OFFER: Skip story or abort
  </agent_failures>
</error_handling>

<persistence>
  <auto_save>
    UPDATE: kanban-board.md after EVERY state change
    ENSURE: Always resumable state
  </auto_save>

  <git_commits>
    OPTIONAL: Auto-commit kanban-board.md periodically
    MESSAGE: "Kanban update: Story [story-id] → [new-status]"
  </git_commits>
</persistence>

<instructions>
  ACTION: Load orchestration skill
  FOR_EACH: Selected story from Step 2
  EXECUTE: 6-phase execution flow
  TRACK: State in kanban-board.md
  ENFORCE: Quality gates (Architect + QA)
  MANAGE: Dependencies and handovers
  UPDATE: Board after every state change
  PERSIST: Progress for resumability
  LOOP: Until all stories complete or user pauses
</instructions>

</step>

<step number="7" subagent="test-runner" name="test_suite_verification">

### Step 7: Run All Tests

Use the test-runner subagent to run the entire test suite to ensure no regressions and fix any failures until all tests pass.

<instructions>
  ACTION: Use test-runner subagent
  REQUEST: "Run the full test suite"
  WAIT: For test-runner analysis
  PROCESS: Fix any reported failures
  REPEAT: Until all tests pass
</instructions>

<test_execution>
  <order>
    1. Run entire test suite
    2. Fix any failures
  </order>
  <requirement>100% pass rate</requirement>
</test_execution>

<failure_handling>
  <action>troubleshoot and fix</action>
  <priority>before proceeding</priority>
</failure_handling>

</step>

<step number="8" subagent="git-workflow" name="git_workflow">

### Step 8: Git Workflow

Use the git-workflow subagent to create git commit, push to GitHub, and create pull request for the implemented features.

<instructions>
  ACTION: Use git-workflow subagent
  REQUEST: "Complete git workflow for [SPEC_NAME] feature:
            - Spec: [SPEC_FOLDER_PATH]
            - Changes: All modified files
            - Target: main branch
            - Description: [SUMMARY_OF_IMPLEMENTED_FEATURES]"
  WAIT: For workflow completion
  PROCESS: Save PR URL for summary
</instructions>

<commit_process>
  <commit>
    <message>descriptive summary of changes</message>
    <format>conventional commits if applicable</format>
  </commit>
  <push>
    <target>spec branch</target>
    <remote>origin</remote>
  </push>
  <pull_request>
    <title>descriptive PR title</title>
    <description>functionality recap</description>
  </pull_request>
</commit_process>

</step>

<step number="9" name="roadmap_progress_check">

### Step 9: Roadmap Progress Check (Conditional)

Check @agent-os/product/roadmap.md (if not in context) and update roadmap progress only if the executed tasks may have completed a roadmap item and the spec completes that item.

<conditional_execution>
  <preliminary_check>
    EVALUATE: Did executed tasks potentially complete a roadmap item?
    IF NO:
      SKIP this entire step
      PROCEED to step 9
    IF YES:
      CONTINUE with roadmap check
  </preliminary_check>
</conditional_execution>

<conditional_loading>
  IF roadmap.md NOT already in context:
    LOAD agent-os/product/roadmap.md
  ELSE:
    SKIP loading (use existing context)
</conditional_loading>

<roadmap_criteria>
  <update_when>
    - spec fully implements roadmap feature
    - all related tasks completed
    - tests passing
  </update_when>
  <caution>only mark complete if absolutely certain</caution>
</roadmap_criteria>

<instructions>
  ACTION: First evaluate if roadmap check is needed
  SKIP: If tasks clearly don't complete roadmap items
  CHECK: If roadmap.md already in context
  LOAD: Only if needed and not in context
  EVALUATE: If current spec completes roadmap goals
  UPDATE: Mark roadmap items complete if applicable
  VERIFY: Certainty before marking complete
</instructions>

</step>

<step number="10" name="completion_notification">

### Step 10: Task Completion Notification

Play a system sound to alert the user that tasks are complete.

<notification_command>
  afplay /System/Library/Sounds/Glass.aiff
</notification_command>

<instructions>
  ACTION: Play completion sound
  PURPOSE: Alert user that task is complete
</instructions>

</step>

<step number="11" name="completion_summary">

### Step 11: Completion Summary

Create a structured summary message with emojis showing what was done, any issues, testing instructions, and PR link.

<summary_template>
  ## ✅ What's been done

  1. **[STORY_1]** - [ONE_SENTENCE_DESCRIPTION]
  2. **[STORY_2]** - [ONE_SENTENCE_DESCRIPTION]

  ## 📊 Kanban Board Status

  - **Completed Stories**: [X] of [TOTAL]
  - **Progress**: [XX%]
  - **Remaining in Backlog**: [Y]
  - **View Board**: agent-os/specs/[SPEC]/kanban-board.md

  ## ⚠️ Issues encountered

  [ONLY_IF_APPLICABLE]
  - **[ISSUE_1]** - [DESCRIPTION_AND_REASON]

  ## 👀 Ready to test in browser

  [ONLY_IF_APPLICABLE]
  1. [STEP_1_TO_TEST]
  2. [STEP_2_TO_TEST]

  ## 📦 Pull Request

  View PR: [GITHUB_PR_URL]

  ## 🔄 Resume Execution

  To continue with remaining stories, run: `/execute-tasks`
  (Will automatically resume from kanban-board.md state)
</summary_template>

<summary_sections>
  <required>
    - functionality recap
    - pull request info
  </required>
  <conditional>
    - issues encountered (if any)
    - testing instructions (if testable in browser)
  </conditional>
</summary_sections>

<instructions>
  ACTION: Create comprehensive summary
  INCLUDE: All required sections
  ADD: Conditional sections if applicable
  FORMAT: Use emoji headers for scannability
</instructions>

</step>

</process_flow>

## Error Handling

<error_protocols>
  <blocking_issues>
    - document in tasks.md
    - mark with ⚠️ emoji
    - include in summary
  </blocking_issues>
  <test_failures>
    - fix before proceeding
    - never commit broken tests
  </test_failures>
  <technical_roadblocks>
    - attempt 3 approaches
    - document if unresolved
    - seek user input
  </technical_roadblocks>
</error_protocols>

<final_checklist>
  <verify>
    - [ ] kanban-board.md created/updated
    - [ ] Stories executed per DoD criteria
    - [ ] All tests passing
    - [ ] Architect review completed
    - [ ] QA testing completed
    - [ ] kanban-board.md reflects final state
    - [ ] Handover documents created (if needed)
    - [ ] Code committed and pushed
    - [ ] Pull request created
    - [ ] Roadmap checked/updated
    - [ ] Summary with Kanban status provided
  </verify>
</final_checklist>
