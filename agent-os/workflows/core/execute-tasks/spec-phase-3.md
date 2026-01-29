---
description: Spec Phase 3 - Execute one user story (Direct Execution v3.1)
version: 3.1
---

# Spec Phase 3: Execute Story (Direct Execution)

## What's New in v3.1

- **Integration Context**: Reads previous story context before implementation
- **Context Update**: Updates integration-context.md after story completion
- **Better Cross-Session Integration**: No more "orphaned" code after /clear

## What's New in v3.0

- **No Sub-Agent Delegation**: Main agent implements story directly
- **Skills Load Automatically**: Via glob patterns in .claude/skills/
- **Self-Review**: DoD checklist instead of separate review agents
- **Self-Learning**: Updates dos-and-donts.md when learning
- **Domain Updates**: Keeps domain documentation current

## Purpose

Execute ONE user story completely. The main agent implements directly,
maintaining full context throughout the story.

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

<step name="load_integration_context">
  ### Load Integration Context (v3.1)

  **CRITICAL: Read this BEFORE implementing to understand prior work.**

  READ: agent-os/specs/{SELECTED_SPEC}/integration-context.md

  IF file exists:
    EXTRACT and UNDERSTAND:
    - **Completed Stories**: What was already implemented
    - **New Exports & APIs**: Functions, components, services to USE (not recreate)
    - **Integration Notes**: How things connect together
    - **File Change Summary**: Which files were modified

    **USE THIS CONTEXT:**
    - Import and use existing exports instead of creating duplicates
    - Follow established patterns from prior stories
    - Integrate with existing code, don't work in isolation

  IF file doesn't exist:
    NOTE: First story execution - no prior context needed
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
  UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT - see shared/resume-context.md)
    - MOVE: Selected story from Backlog to "In Progress" section
    - UPDATE Board Status table: In Progress +1, Backlog -1
    - UPDATE Resume Context table:
      | **Current Story** | [story-id] |
      | **Last Action** | Started [story-id] execution |
    - ADD Change Log entry

  UPDATE: Story file (agent-os/specs/{SELECTED_SPEC}/stories/{STORY_FILE})
    - FIND: Line containing "Status: Ready"
    - REPLACE WITH: "Status: In Progress"
</step>

<step name="load_story">
  ### Load Story Details

  READ: Story file from agent-os/specs/{SELECTED_SPEC}/stories/story-XXX-[slug].md

  EXTRACT:
  - Story ID and Title
  - Feature description (Gherkin)
  - Acceptance Criteria (Gherkin scenarios)
  - Technical Details (WAS, WIE, WO)
  - DoD Checklist
  - Domain reference (if specified)

  NOTE: Skills are NOT extracted here - they load automatically when you
  edit files matching their glob patterns.
</step>

<step name="implement">
  ### Direct Implementation (v3.0)

  **The main agent implements the story directly.**

  <implementation_process>
    1. READ: Technical requirements from story (WAS, WIE, WO sections)

    2. UNDERSTAND: Architecture guidance from story
       - Which patterns to apply
       - Which constraints to follow
       - Which files to create/modify

    3. IMPLEMENT: The feature
       - Create/modify files as specified in WO section
       - Follow architecture patterns from WIE section
       - Skills load automatically when you edit matching files

    4. RUN: Tests as you implement
       - Unit tests for new code
       - Ensure existing tests pass

    5. VERIFY: Each acceptance criterion
       - Work through each Gherkin scenario
       - Ensure all are satisfied

    **Skills Auto-Loading:**
    When you edit files, relevant skills activate automatically:
    - `src/app/**/*.ts` → frontend skill loads
    - `app/**/*.rb` → backend skill loads
    - `Dockerfile` → devops skill loads

    **File Organization (CRITICAL):**
    - NO files in project root
    - Implementation code: As specified in WO section
    - Reports: agent-os/specs/{SELECTED_SPEC}/implementation-reports/
  </implementation_process>

  OUTPUT: Implementation complete, ready for self-review
</step>

<step name="self_review">
  ### Self-Review with DoD Checklist (v3.0)

  Replaces separate Architect/UX/QA review agents.

  <review_process>
    1. READ: DoD checklist from story file

    2. VERIFY each item:

       **Implementation:**
       - [ ] Code implemented and follows style guide
       - [ ] Architecture patterns followed (WIE section)
       - [ ] Security/performance requirements met

       **Quality:**
       - [ ] All acceptance criteria satisfied
       - [ ] Unit tests written and passing
       - [ ] Integration tests written and passing
       - [ ] Linter passes (run lint command)

       **Documentation:**
       - [ ] Code is self-documenting or has necessary comments
       - [ ] No debug code left in

    3. RUN: Verification commands from story
       ```bash
       # Run commands from Completion Check section
       [VERIFY_COMMAND_1]
       [VERIFY_COMMAND_2]
       ```

    4. FIX: Any issues found before proceeding

    IF all checks pass:
      PROCEED to self_learning_check
    ELSE:
      FIX issues and re-verify
  </review_process>
</step>

<step name="self_learning_check">
  ### Self-Learning Check (v3.0)

  Update dos-and-donts.md if you learned something during implementation.

  <learning_detection>
    REFLECT: On the implementation process

    DID any of these occur?
    - Initial approach didn't work
    - Had to refactor/retry
    - Discovered unexpected behavior
    - Found a better pattern than first tried
    - Encountered framework quirk

    IF YES:
      1. IDENTIFY: The learning
         - What was the context?
         - What didn't work?
         - What worked?

      2. DETERMINE: Category
         - Technical → dos-and-donts.md in relevant tech skill
         - Domain → domain skill process document

      3. LOCATE: Target file
         - Frontend: .claude/skills/frontend-[framework]/dos-and-donts.md
         - Backend: .claude/skills/backend-[framework]/dos-and-donts.md
         - DevOps: .claude/skills/devops-[stack]/dos-and-donts.md

      4. APPEND: Learning entry
         ```markdown
         ### [DATE] - [Short Title]
         **Context:** [What you were trying to do]
         **Issue:** [What didn't work]
         **Solution:** [What worked]
         ```

      5. ADD to appropriate section:
         - Dos ✅ (positive pattern discovered)
         - Don'ts ❌ (anti-pattern discovered)
         - Gotchas ⚠️ (unexpected behavior)

    IF NO learning:
      SKIP: No update needed
  </learning_detection>
</step>

<step name="domain_update_check">
  ### Domain Update Check (v3.0)

  Keep domain documentation current when business logic changes.

  <domain_check>
    ANALYZE: Did this story change business logic?

    CHECK: Story has Domain field?
    - IF yes: Domain area is specified
    - IF no: Check if changes affect business processes

    IF business logic changed:
      1. LOCATE: Domain skill
         .claude/skills/domain-[project]/

      2. FIND: Relevant process document
         .claude/skills/domain-[project]/[process].md

      3. CHECK: Is description still accurate?
         - Does the process flow still match?
         - Are business rules still correct?
         - Is related code section up to date?

      4. IF outdated:
         UPDATE: The process document
         - Correct any inaccurate descriptions
         - Update process flow if changed
         - Update Related Code section

      5. LOG: "Domain doc updated: [process].md"

    IF no domain skill exists:
      SKIP: No domain documentation to update

    IF no business logic changed:
      SKIP: No domain update needed
  </domain_check>
</step>

<step name="mark_story_done">
  UPDATE: Story file (agent-os/specs/{SELECTED_SPEC}/stories/{STORY_FILE})
    - FIND: Line containing "Status: In Progress"
    - REPLACE WITH: "Status: Done"
    - CHECK: All DoD items marked as [x]
</step>

<step name="story_commit" subagent="git-workflow">
  UPDATE: kanban-board.md
    - MOVE: Story to "Done"
    - UPDATE Board Status: In Progress -1, Completed +1

  USE: git-workflow subagent
  "Commit story [story-id]:

  **WORKING_DIR:** {PROJECT_ROOT} (or {WORKTREE_PATH} if USE_WORKTREE = true)

  - Message: feat/fix: [story-id] [Story Title]
  - Stage all changes including:
    - Implementation files
    - Story file with Status: Done
    - integration-context.md updates
    - Any dos-and-donts.md updates
    - Any domain doc updates
  - Push to remote"
</step>

<step name="update_integration_context">
  ### Update Integration Context (v3.1)

  **CRITICAL: Update context for next story session.**

  READ: agent-os/specs/{SELECTED_SPEC}/integration-context.md

  UPDATE the file with information from THIS story:

  1. **Completed Stories Table** - ADD new row:
     | [STORY-ID] | [Brief 5-10 word summary] | [Key files/functions created] |

  2. **New Exports & APIs** - ADD any new:

     **Components** (if created):
     - `path/to/Component.tsx` → `<ComponentName prop={value} />`

     **Services** (if created):
     - `path/to/service.ts` → `functionName(params)` - brief description

     **Hooks / Utilities** (if created):
     - `path/to/hook.ts` → `useHookName()` - what it returns

     **Types / Interfaces** (if created):
     - `path/to/types.ts` → `InterfaceName` - what it represents

  3. **Integration Notes** - ADD if relevant:
     - How this story's code connects to existing code
     - Important patterns established
     - Things the next story should know

  4. **File Change Summary Table** - ADD rows for each file:
     | [file path] | Created/Modified | [STORY-ID] |

  **IMPORTANT:**
  - Be concise but informative
  - Focus on EXPORTS that other stories might use
  - Include import paths so next session can use them directly
</step>

## Phase Completion

<phase_complete>
  CHECK: Remaining stories in Backlog

  IF backlog NOT empty:
    UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT)
      Resume Context table fields:
      | **Current Phase** | story-complete |
      | **Next Phase** | 3 - Execute Story |
      | **Current Story** | None |
      | **Last Action** | Completed [story-id] - self-review passed |
      | **Next Action** | Execute next story |

    OUTPUT to user:
    ---
    ## Story Complete: [story-id] - [Story Title]

    **Progress:** [X] of [TOTAL] stories
    **Remaining:** [Y] stories

    **Self-Learning:** [Updated/No updates]
    **Domain Docs:** [Updated/No updates]

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
    UPDATE: kanban-board.md (MAINTAIN TABLE FORMAT)
      Resume Context table fields:
      | **Current Phase** | all-stories-done |
      | **Next Phase** | 4.5 - Integration Validation |
      | **Current Story** | None |
      | **Last Action** | Completed final story |
      | **Next Action** | Run integration validation |

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

---

## Quick Reference: v3.1 Changes

| v3.0 | v3.1 |
|------|------|
| No cross-session context | load_integration_context (NEW) |
| Context lost after /clear | update_integration_context (NEW) |
| Stories executed in isolation | Stories build on each other |

## Quick Reference: v3.0 Changes

| v2.x (Sub-Agents) | v3.0 (Direct Execution) |
|-------------------|-------------------------|
| extract_skill_paths | Skills auto-load via globs |
| DELEGATE to dev-team__* | Main agent implements |
| architect_review agent | Self-review with DoD |
| ux_review agent | Self-review with DoD |
| qa_testing agent | Self-review with DoD |
| - | self_learning_check (NEW) |
| - | domain_update_check (NEW) |

**Benefits v3.1:**
- Cross-session context preservation
- Proper integration between stories
- No more "orphaned" functions after /clear
- Existing exports are reused, not recreated

**Benefits v3.0:**
- Full context throughout story
- No "lost in translation" between agents
- Better integration (agent sees all changes)
- Self-learning improves over time
- Domain docs stay current
