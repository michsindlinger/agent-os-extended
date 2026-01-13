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

<step number="0" name="identify_target_spec">

### Step 0: Identify Target Spec

Determine which specification to execute.

<spec_identification>
  CHECK: Did user provide spec name as parameter?

  IF user provided spec name (e.g., "/execute-tasks bitget-cex-integration"):
    VALIDATE: Spec folder exists at agent-os/specs/[spec-name]/
    IF exists:
      SELECTED_SPEC = [spec-name]
      PROCEED to Step 1
    ELSE:
      ERROR: "Spec not found: [spec-name]"
      LIST available specs
      ASK user to select from list

  ELSE (no parameter provided):
    USE Bash to list spec directories:
      ```bash
      ls -1 agent-os/specs/ | sort -r
      ```

    EXTRACT spec folder names (YYYY-MM-DD-feature-name format)

    IF no specs found:
      ERROR: "No specifications found in agent-os/specs/"
      SUGGEST: "Run /create-spec first to create a feature specification"
      EXIT workflow

    IF 1 spec found:
      SELECTED_SPEC = [only spec]
      CONFIRM with user: "Execute [spec-name]? (yes/no)"
      IF no: EXIT
      PROCEED to Step 1

    IF multiple specs found:
      ASK user via AskUserQuestion:
      "Which specification would you like to execute?

      Options:
      - [Most recent spec] - YYYY-MM-DD-feature-name (Recommended)
      - [Second spec] - YYYY-MM-DD-feature-name
      - [Third spec] - YYYY-MM-DD-feature-name
      (Or type spec folder name)"

      WAIT for user selection
      SELECTED_SPEC = user's choice
</spec_identification>

<instructions>
  ACTION: Identify and validate target spec folder
  STORE: SELECTED_SPEC variable for use in all subsequent steps
  VALIDATE: Spec folder exists and contains user-stories.md
  ERROR: If spec folder or user-stories.md not found
</instructions>

**Output:** SELECTED_SPEC variable containing spec folder name (e.g., "2026-01-10-bitget-cex-integration")

</step>

<step number="1" subagent="file-creator" name="kanban_board_management">

### Step 1: Kanban Board Management

Use the file-creator subagent to create or load the kanban board for state persistence and resume capability.

<board_check>
  CHECK: Does kanban-board.md exist in spec folder?
  PATH: agent-os/specs/{SELECTED_SPEC}/kanban-board.md
  (SELECTED_SPEC from Step 0)
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

    > Spec: agent-os/specs/{SELECTED_SPEC}/
    > Created: [TIMESTAMP]
    > Last Updated: [TIMESTAMP]
  </header>

  <resume_context>
    ## 🔄 Resume Context (Post-Compaction Recovery)

    > **IMPORTANT:** If conversation was compacted, read this section to resume workflow correctly.

    | Field | Value |
    |-------|-------|
    | **Workflow** | /execute-tasks |
    | **Workflow File** | agent-os/workflows/core/execute-tasks.md |
    | **Current Step** | [Step number and name] |
    | **Current Story** | [story-id] - [Story Title] |
    | **Story Status** | [In Progress / In Review / Testing] |
    | **Assigned Agent** | [Agent name or "orchestrator"] |
    | **Last Action** | [Brief description of last completed action] |
    | **Next Action** | [Brief description of next required action] |

    ### Critical Rules (Always Apply):
    1. **DELEGATE** - Use Task tool to delegate to DevTeam agents, never implement directly
    2. **UPDATE BOARD** - Update this kanban-board.md after EVERY state change
    3. **QUALITY GATES** - All stories must pass: Architect Review → UX Review (frontend) → QA Testing
    4. **PERSIST STATE** - This board is the source of truth for execution state

    ### Resume Instructions:
    IF Current Step is incomplete:
      1. Re-read the Workflow File for detailed step instructions
      2. Continue from "Next Action" listed above
      3. Update this Resume Context section after each significant action

    ### Agent Assignment Rules:
    - Backend stories → dev-team__backend-developer-*
    - Frontend stories → dev-team__frontend-developer-*
    - DevOps stories → dev-team__dev-ops-specialist
    - Test stories → dev-team__qa-specialist
    - Reviews → dev-team__architect (code) + ux-designer (frontend UX)
  </resume_context>

  <resume_context_update_rules>
    **MANDATORY:** Update Resume Context table on EVERY kanban-board.md update:

    WHEN updating kanban-board.md:
      1. Update "Last Updated" timestamp in header
      2. Update Resume Context table:
         - Current Step: [current workflow step number + name]
         - Current Story: [story currently being worked on]
         - Story Status: [In Progress | In Review | Testing | Done]
         - Assigned Agent: [agent handling current story]
         - Last Action: [what was just completed]
         - Next Action: [what needs to happen next]
      3. Proceed with other kanban updates (story moves, metrics, etc.)

    TRIGGER POINTS for Resume Context Update:
      - Step 1 complete → Current Step: "Step 2 - Story Selection"
      - Story selected → Current Story: [selected story]
      - Agent assigned → Assigned Agent: [agent name]
      - Story moved to In Review → Story Status: "In Review", Next Action: "Architect Review"
      - Review complete → Next Action: "QA Testing" or "Fix issues"
      - Story moved to Done → Current Story: "None - selecting next"
      - Execution paused → Next Action: "Resume with /execute-tasks"
  </resume_context_update_rules>

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
  <format>exclude date prefix, detect bug specs</format>

  <bug_detection>
    CHECK: Does spec folder name contain "bugfix"?

    IF spec contains "bugfix":
      BRANCH_PREFIX = "bugfix/"
      COMMIT_PREFIX = "fix:"
      EXAMPLE:
        - folder: 2026-01-12-bugfix-login-error
        - branch: bugfix/login-error

    ELSE (feature spec):
      BRANCH_PREFIX = "" (no prefix, just name)
      COMMIT_PREFIX = "feat:" (or appropriate type)
      EXAMPLE:
        - folder: 2025-03-15-password-reset
        - branch: password-reset
  </bug_detection>

  <naming_rules>
    1. Remove date prefix (YYYY-MM-DD-)
    2. If "bugfix-" in name, use "bugfix/" branch prefix
    3. Remove "bugfix-" from branch name after adding prefix
    4. Result: bugfix/[bug-name] or [feature-name]
  </naming_rules>
</branch_naming>

</step>

<step number="5.5" name="mcp_tool_check">

### Step 5.5: MCP Tool Requirements Check

Check if required MCP tools are available before starting story execution.

<tool_check>
  READ: Selected story from user-stories.md
  CHECK: "### Required MCP Tools" section exists?

  IF section exists AND has tools listed:
    FOR each required tool with Blocking=Yes:
      RUN: Check if tool is available in MCP configuration

      IF tool NOT available:
        MARK: Story as "BLOCKED" in kanban-board.md
        LOG: "Missing MCP tool: [tool-name]"
        NOTIFY: User with setup instructions:
          "Story [story-id] requires MCP tool '[tool-name]' which is not configured.

           To install:
           1. Add to .mcp.json in project root
           2. Restart Claude Code
           3. Run /execute-tasks again

           See: agent-os/docs/mcp-setup-guide.md"

        SKIP: This story, select next eligible from backlog
        RETURN: To Step 2 (Story Selection)

      ELSE:
        LOG: "MCP tool '[tool-name]' available"
        CONTINUE: To Step 6

  ELSE (no Required MCP Tools section or empty):
    LOG: "No MCP tools required for this story"
    CONTINUE: To Step 6
</tool_check>

<instructions>
  ACTION: Check for Required MCP Tools section in selected story
  IF_FOUND: Verify each blocking tool is available
  IF_MISSING: Mark story as BLOCKED and select next eligible
  IF_ALL_AVAILABLE: Continue to story execution
  REFERENCE: agent-os/docs/mcp-setup-guide.md
</instructions>

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
        [If applicable] Handover document: agent-os/specs/{SELECTED_SPEC}/handover-docs/[file]

        **Instructions:**
        1. Implement according to technical specs
        2. Follow DoD checklist strictly
        3. Write tests as specified
        4. Document your work
        5. If this story has dependent stories, create handover document

        **CRITICAL - File Organization:**
        ❌ DO NOT create any .md files in project root
        ❌ DO NOT create implementation reports like [STORY-ID]-IMPLEMENTATION.md in root
        ❌ DO NOT create testing checklists in root

        ✅ IF you need to create implementation reports or documentation:
           Create in: agent-os/specs/{SELECTED_SPEC}/implementation-reports/[story-id]-[type].md
           Examples:
           - agent-os/specs/{SELECTED_SPEC}/implementation-reports/[story-id]-backend.md
           - agent-os/specs/{SELECTED_SPEC}/implementation-reports/[story-id]-frontend.md
           - agent-os/specs/{SELECTED_SPEC}/implementation-reports/[story-id]-testing.md

        ✅ For handover documents:
           Create in: agent-os/specs/{SELECTED_SPEC}/handover-docs/[story-id]-[topic].md

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

          BEFORE delegating to architect:
            RUN: git status --short
            RUN: git diff --stat
            CAPTURE: List of modified/created files
            CAPTURE: Lines changed per file

          DELEGATE: dev-team__architect via Task tool

          PROMPT: "Review code for Story [story-id].

          Context:
          - Story: agent-os/specs/{SELECTED_SPEC}/user-stories.md#[story-id]
          - Tech Stack: agent-os/product/tech-stack.md
          - Architecture Decision: agent-os/product/architecture-decision.md
          - Architecture Structure: agent-os/product/architecture-structure.md
          - DoD: agent-os/team/dod.md
          - Implementation Reports: [List of implementation report files]

          Git Changes (from this story):
          ```
          [Output of git status --short]

          [Output of git diff --stat]
          ```

          Files Created/Modified:
          [List extracted from git status]

          Review Checklist:
          0. File Placement (CRITICAL):
             - Are all files in correct locations per architecture-structure.md?
             - Do file paths match WO field from story technical refinement?
             - No files in unexpected locations?
             - Folder structure compliance verified?
          1. Architecture Compliance:
             - Follows architecture pattern (from architecture-decision.md)?
             - Respects folder structure (from architecture-structure.md)?
             - Proper layer separation (domain, application, infrastructure)?
             - Dependencies point in correct direction?

          2. Pattern Enforcement:
             - Follows established patterns?
             - No architectural anti-patterns?
             - Consistent with tech stack conventions?

          3. API Design (if applicable):
             - RESTful or GraphQL best practices?
             - Type safety (TypeScript interfaces)?
             - Error handling consistent?

          4. Security Review:
             - No security vulnerabilities?
             - Proper input validation?
             - No exposed secrets or credentials?
             - Authentication/authorization correct?

          5. Code Quality:
             - Follows code-style.md?
             - No TypeScript 'any' types?
             - Proper error handling?
             - Well-documented complex logic?

          Deliverable:
          - If APPROVED: Green light to QA testing
          - If REJECTED: Specific feedback with file locations and fixes needed

          Provide detailed review with rationale."

          WAIT for dev-team__architect completion

          IF architect_approves:
            CONTINUE: To UX review (if frontend) or QA testing
          ELSE:
            UPDATE kanban-board.md:
              - MOVE: Story → "In Progress"
              - ADD: Review feedback to Progress field
              - ADD: Change Log entry
            DELEGATE_BACK: To original agent with feedback
            REPEAT: Until approved
        </architect_review>

        <ux_review>
          IF story.type includes "Frontend":
            UPDATE kanban-board.md:
              - ADD: UX Review in progress (still "In Review")
              - ADD: Change Log entry

            DELEGATE: ux-designer via Task tool

            PROMPT: "UX Review for Story [story-id].

            Context:
            - Story: agent-os/specs/{SELECTED_SPEC}/user-stories.md#[story-id]
            - UX Patterns: agent-os/product/ux-patterns.md
            - Design System: agent-os/product/design-system.md (if exists)
            - Implementation files: [git status --short output]

            Git Changes (from this story):
            ```
            [Output of git status --short for frontend files]
            ```

            Review Checklist:
            1. UX Pattern Compliance:
               - Follows defined navigation patterns?
               - User flows intuitive and efficient?
               - Interaction patterns consistent?
               - Feedback patterns implemented (loading, success, error)?

            2. User Experience:
               - Clear call-to-action placement?
               - Intuitive element placement?
               - Consistent with existing UI?
               - Empty states friendly and helpful?

            3. Accessibility:
               - Semantic HTML used?
               - ARIA labels where needed?
               - Keyboard navigation works?
               - Focus indicators visible?
               - Color contrast meets WCAG level?
               - Screen reader compatible?

            4. Mobile/Responsive (if applicable):
               - Touch targets minimum 44x44px?
               - Content reflows on small screens?
               - No horizontal scrolling?
               - Mobile patterns followed?

            5. Error Handling:
               - Error messages clear and actionable?
               - Validation feedback inline?
               - Error recovery possible?

            Deliverable:
            - If APPROVED: Green light to QA testing
            - If REJECTED: Specific UX feedback with file locations and fixes needed

            Provide detailed UX review with rationale."

            WAIT for ux-designer completion

            IF ux_designer_approves:
              UPDATE kanban-board.md:
                - ADD: UX Review approved
                - ADD: Change Log entry
              CONTINUE: To QA testing
            ELSE:
              UPDATE kanban-board.md:
                - MOVE: Story → "In Progress"
                - ADD: UX Review feedback to Progress field
                - ADD: Change Log entry
              DELEGATE_BACK: To frontend developer with UX feedback
              REPEAT: Until UX approved
          ELSE:
            NOTE: "Non-frontend story, skipping UX review"
            CONTINUE: To QA testing
        </ux_review>

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
          PATH: agent-os/specs/{SELECTED_SPEC}/handover-docs/[story-id]-handover.md
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

    <!-- Phase 5.4: Agent Self-Learning -->
    <agent_learning>
      TRIGGER: After story completion, before git commit

      <reflection>
        PROMPT executing agent to reflect:
        "Reflect on the story execution you just completed.

        Consider:
        1. Did you encounter any ERRORS that you had to fix?
           - Build errors, test failures, lint issues?
           - What was the root cause and solution?

        2. Did you discover any PROJECT-SPECIFIC PATTERNS?
           - File naming conventions?
           - Code organization patterns?
           - API/component patterns?

        3. Did you find any WORKAROUNDS or CONFIGS?
           - Framework quirks?
           - Tool configurations?
           - Environment specifics?

        4. Did you learn something about the CODEBASE STRUCTURE?
           - Unexpected file locations?
           - Architecture decisions?

        IF you learned something valuable that would help in future stories:
          DOCUMENT it in your agent file."
      </reflection>

      <learning_evaluation>
        FOR each potential learning:
          EVALUATE:
            - Is this likely to recur in future stories?
            - Is this specific and actionable?
            - Would this prevent mistakes for future sessions?

          IF valuable:
            DOCUMENT: Add to agent's Project Learnings section
          ELSE:
            SKIP: Don't document trivial or one-time fixes
      </learning_evaluation>

      <documentation>
        IF learning_identified:
          READ: Agent's own file from .claude/agents/dev-team/[agent-name].md

          IF "## Project Learnings" section exists:
            APPEND: New learning at TOP of section (newest first)
          ELSE:
            CREATE: "## Project Learnings (Auto-Generated)" section
            ADD: First learning

          FORMAT:
          ```markdown
          ### [YYYY-MM-DD]: [Short Title]
          - **Kategorie:** [Error-Fix | Pattern | Workaround | Config | Structure]
          - **Problem:** [What was the problem?]
          - **Lösung:** [How was it solved?]
          - **Kontext:** [Story-ID], [affected files]
          - **Vermeiden:** [What to avoid in future]
          ```

          UPDATE kanban-board.md:
            - ADD: Change Log entry: "Learning documented: [title]"

          LOG: "Agent learning documented: [title]"
      </documentation>

      <learning_limits>
        CHECK: Number of learnings in agent file
        IF learnings > 30:
          ARCHIVE: Oldest learnings to agent-os/team/learnings-archive/[agent-name].md
          KEEP: 20 most recent learnings in agent file
      </learning_limits>

      REFERENCE: agent-os/docs/agent-learning-guide.md
    </agent_learning>

    <!-- Phase 5.5: Per-Story Git Commit -->
    <per_story_commit>
      CHECK: agent-os/config.yml → workflows.auto_commit_per_story

      IF auto_commit_per_story = true (DEFAULT):
        USE: git-workflow subagent

        DETERMINE commit prefix:
          IF SPEC_IS_BUGFIX (from Step 5 bug_detection):
            PREFIX = "fix:"
          ELSE:
            PREFIX = "feat:" (or appropriate type based on story)

        COMMIT:
          FILES: All changed files for this story
          MESSAGE: "[PREFIX] [story-id] [Story Title]

                   - [Brief description of changes]
                   - DoD: All criteria met
                   - Tests: Passing

                   Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"

        EXAMPLE (bug fix):
          "fix: story-1 Investigate and Fix Root Cause

           - Root cause: Session token not refreshed
           - Files changed: 3
           - DoD: All criteria met
           - Tests: Passing

           Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"

        PUSH: To spec branch (origin)

        UPDATE kanban-board.md:
          - ADD: Commit hash to story entry
          - ADD: Change Log entry: "Committed [story-id]"

        LOG: "Story [story-id] committed: [commit-hash]"

      ELSE:
        LOG: "Per-story commits disabled, deferring to Step 8"
        SKIP: Commit (will be done in Step 8)

      BENEFIT: Each story is a checkpoint for resumability
      BENEFIT: Clear git history per story
      BENEFIT: Automated sessions can resume from last commit
    </per_story_commit>

    <!-- Phase 6: Next Story Check -->
    <next_story_check>
      CHECK kanban-board.md Backlog:
        IF backlog_empty:
          STATE: "All stories complete!"
          EXIT: Execution loop
        ELSE:
          ASK user: "Story [story-id] complete. Continue with next story? (yes/no/which)"
          IF yes:
            CONTINUE: To Phase 6.5 (Context Management Checkpoint)
          ELSE IF which:
            ALLOW: User to specify story
            CONTINUE: To Phase 6.5 (Context Management Checkpoint)
          ELSE:
            PAUSE: Execution
            STATE: "Execution paused. Resume with /execute-tasks"
            EXIT: Execution loop
    </next_story_check>

    <!-- Phase 6.5: Context Management Checkpoint (Token Optimization) -->
    <context_checkpoint>
      <purpose>
        Prevent mid-story auto-compaction by proactively managing context.
        Based on Claude Code 1M token optimization best practices.
      </purpose>

      <checkpoint_trigger>
        CALCULATE: Stories completed in current session
        COUNT: completed_stories_count

        IF completed_stories_count is MULTIPLE of 2:
          TRIGGER: Context checkpoint (every 2 stories)
          SHOW: Token optimization recommendation
        ELSE:
          SKIP: Checkpoint
          PROCEED: To Step 2 (Story Selection)
      </checkpoint_trigger>

      <checkpoint_message>
        WHEN triggered, present to user:

        ---
        💡 **Context Management Checkpoint**

        **Stories completed this session:** [count]

        **Token Optimization Recommendation:**

        Running `/compact` now will:
        ✅ Preserve current progress (saved in Resume Context + Kanban Board)
        ✅ Clear old conversation history
        ✅ Reduce token costs (stay under 200K threshold)
        ✅ Prevent mid-story auto-compaction
        ✅ Maintain perfect continuity via TODO list + Resume Context

        **Benefits:**
        - Faster agent responses
        - Lower costs ($3/M vs $6/M above 200K)
        - No risk of losing context mid-story

        **What gets preserved:**
        - ✅ Kanban Board state (all progress)
        - ✅ Resume Context (workflow state)
        - ✅ TODO list (current tasks)
        - ✅ Git commits (all code)
        - ✅ CLAUDE.md files (project context)

        **What gets cleared:**
        - ❌ Old conversation history (not needed)
        - ❌ Previous file reads (cached in git)
        - ❌ Completed story discussions

        ---

        Would you like to `/compact` now before continuing?

        Options:
        1. **Yes, compact now (Recommended)**
           → Run `/compact` manually in terminal
           → Then type 'done' to continue

        2. **No, continue without compacting**
           → Accept higher token usage
           → Risk of auto-compaction during next story

        3. **Check current token usage first**
           → Run `/context` to see current usage
           → Then decide
        ---
      </checkpoint_message>

      <user_choice_handling>
        ASK user via AskUserQuestion:
        "Context Management: Would you like to compact now?

        Options:
        - Yes, compact now (Recommended)
        - No, continue without compacting
        - Check token usage first"

        WAIT for user choice

        IF choice = "Yes, compact now":
          INFORM: "
          Please run this command in your terminal:

          → /compact

          This will:
          - Compress conversation history
          - Preserve Resume Context + Kanban Board
          - Keep TODO list intact

          After compacting, the system will automatically:
          1. Read the Resume Context from kanban-board.md
          2. Continue from exactly where you left off
          3. Select the next story from backlog

          Type 'done' when you've completed the compact."

          WAIT for user confirmation ("done")

          LOG: "Context compacted by user at checkpoint"
          NOTE: "Resume Context in kanban-board.md will guide continuation"
          PROCEED: To Step 2 (Story Selection)

        ELSE IF choice = "Check token usage first":
          INFORM: "
          Run this command to check your current token usage:

          → /context

          Look for:
          - Total context: Should be under 150K for optimal cost
          - Messages: Shows conversation history size
          - If Total > 100K: Strongly recommend /compact
          - If Total > 150K: Definitely /compact

          After checking, we'll ask again if you want to compact."

          WAIT for user to check

          ASK: "After checking /context, would you like to compact? (yes/no)"
          IF yes:
            EXECUTE: "Yes, compact now" flow from above
          ELSE:
            PROCEED: To Step 2 with warning

        ELSE IF choice = "No, continue without compacting":
          WARN: "⚠️ Continuing without compacting
                 - Token usage will continue to grow
                 - Auto-compaction may occur mid-story
                 - Resume Context will preserve state if needed"
          LOG: "User declined context checkpoint"
          PROCEED: To Step 2 (Story Selection)
      </user_choice_handling>

      <reference>
        See: agent-os/docs/story-sizing-guidelines.md
        Context Budget: Aim to stay under 100-150K tokens
        Checkpoint Frequency: Every 2 completed stories
        Threshold: 200K tokens (cost doubles above this)
      </reference>
    </context_checkpoint>

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
    DEFAULT: Commit after EACH story completion (Phase 5.5)
    CONFIG: agent-os/config.yml → workflows.auto_commit_per_story
    MESSAGE: "[story-id] [Story Title]"
    PUSH: After each commit to enable session resume
    BENEFIT: Clear checkpoints for automated execution
  </git_commits>
</persistence>

<instructions>
  ACTION: Load orchestration skill
  FOR_EACH: Selected story from Step 2
  EXECUTE: 8-phase execution flow:
    1. Story Preparation
    2. Agent Assignment
    3. Story Execution
    4. Quality Gates (Architect + UX + QA)
    5. Story Completion
    5.4. Agent Self-Learning (document learnings)
    5.5. Per-Story Git Commit (if enabled)
    6. Next Story Check
  TRACK: State in kanban-board.md
  ENFORCE: Quality gates (Architect + QA)
  MANAGE: Dependencies and handovers
  LEARN: Agents document discoveries in their own files
  COMMIT: After each story (configurable via config.yml)
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

### Step 8: Git Workflow - PR Creation

Use the git-workflow subagent to create pull request for the implemented features.

Note: If per-story commits are enabled (default), commits were already made in Phase 5.5.
This step focuses on PR creation and any final uncommitted changes.

<instructions>
  ACTION: Use git-workflow subagent
  REQUEST: "Complete git workflow for [SPEC_NAME] feature:
            - Spec: [SPEC_FOLDER_PATH]
            - Branch: [spec-branch-name]
            - Target: main branch
            - Per-story commits: Already pushed (if enabled)
            - Description: [SUMMARY_OF_IMPLEMENTED_FEATURES]"
  WAIT: For workflow completion
  PROCESS: Save PR URL for summary
</instructions>

<workflow_process>
  <check_uncommitted>
    RUN: git status
    IF uncommitted changes exist:
      COMMIT: Final changes (kanban-board.md, docs)
      MESSAGE: "Complete [SPEC_NAME] - Final updates

               - Kanban board finalized
               - All stories completed
               - Ready for review

               Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
  </check_uncommitted>

  <ensure_pushed>
    RUN: git status (check if ahead of remote)
    IF ahead:
      PUSH: All commits to origin
  </ensure_pushed>

  <pull_request>
    CREATE: PR via gh cli
    TITLE: "[SPEC_NAME] - [Brief Description]"
    BODY:
      - Summary of all completed stories
      - Link to kanban-board.md
      - Test instructions (if applicable)
    TARGET: main branch
  </pull_request>
</workflow_process>

<commit_history>
  WITH per-story commits enabled, git log shows:
    - [story-1-id] Story 1 Title
    - [story-2-id] Story 2 Title
    - [story-3-id] Story 3 Title
    - Complete [SPEC_NAME] - Final updates (optional)

  BENEFIT: Clear history, easy rollback per story
</commit_history>

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
  - **View Board**: agent-os/specs/{SELECTED_SPEC}/kanban-board.md

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
