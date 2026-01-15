---
description: Create Feature Specification with DevTeam (PO + Architect)
globs:
alwaysApply: false
version: 2.3
encoding: UTF-8
---

# Create Spec Workflow

## Overview

Create detailed feature specifications using DevTeam collaboration: PO gathers fachliche requirements, Architect adds technical refinement.

<pre_flight_check>
  EXECUTE: agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="spec_initiation">

### Step 1: Feature Selection from Roadmap

ALWAYS present roadmap features as options to user, even if they provided a custom idea.

<mandatory_actions>
  1. READ agent-os/product/roadmap.md

  2. EXTRACT uncompleted features from all phases (MVP, Growth, Scale)

  3. PRESENT to user via AskUserQuestion:
     ```
     Question: "What feature would you like to create a specification for?"

     Options:
     - [Roadmap Feature 1] - [One-line description]
     - [Roadmap Feature 2] - [One-line description]
     - [Roadmap Feature 3] - [One-line description]
     - [Roadmap Feature 4] - [One-line description]

     (User can also type custom feature via "Other" option)
     ```

  4. WAIT for user selection

  5. STORE selected feature for Step 2
</mandatory_actions>

<instructions>
  ACTION: Always show roadmap features first
  FORMAT: Use AskUserQuestion tool with roadmap features as options
  ALLOW: User can choose "Other" to enter custom feature
  PROCEED: To Step 2 with selected feature
</instructions>

</step>

<step number="2" name="po_fachliche_requirements_dialog">

### Step 2: PO Phase - Dialog-Based Requirements Gathering

⚠️ **NEW APPROACH:** For larger/complex features, engage in iterative dialog with user
to fully understand requirements BEFORE generating user stories.

<process_overview>
  1. **Requirements Dialog** (Iterative clarification)
  2. **Clarification Document** (Summary for approval)
  3. **User Approval** (User confirms or requests changes)
  4. **User Story Generation** (Only after approval)
</process_overview>

<substep number="2.1" name="requirements_dialog">

### Step 2.1: Requirements Dialog (Iterative)

<mandatory_actions>
  1. LOAD context:
     - Product Brief: agent-os/product/product-brief-lite.md
     - Roadmap: agent-os/product/roadmap.md (if from roadmap)
     - Existing specs: agent-os/specs/ (for context)

  2. INITIAL questions to user:
     - What is the feature? (user's perspective)
     - Who needs it? (target users)
     - Why is it valuable? (business value)
     - What problem does it solve?

  3. ITERATIVE clarification (CONTINUE until complete):
     - What are the edge cases?
     - Where does this feature affect the system? (explore dependencies)
     - What existing features/components are related?
     - What should happen in error scenarios?
     - What is IN scope? What is OUT of scope?
     - Are there permissions/security considerations?
     - Are there performance requirements?

  4. DEEP-DIVE based on complexity:
     - If complex: Ask follow-up about integration points
     - If affects multiple components: Map the relationships
     - If unclear: Request examples or use cases
     - If risky: Discuss mitigation strategies

  5. CONTINUE asking questions until:
     - All aspects are clear
     - Dependencies are mapped
     - Edge cases are identified
     - User confirms "no more questions"
</mandatory_actions>

<instructions>
  ACTION: Engage in dialog with user
  FORMAT: Ask questions one section at a time
  WAIT: For user answers before proceeding
  PROBE: Deeper into unclear areas
  DOCUMENT: Keep track of all answers
  STOP: Only when user says requirements are complete
</instructions>

</substep>

<substep number="2.2" name="clarification_document">

### Step 2.2: Create Clarification Document

Before generating user stories, create a summary document for user approval.

<mandatory_actions>
  1. Use date-checker to get current date (YYYY-MM-DD)

  2. Create spec folder: agent-os/specs/YYYY-MM-DD-spec-name/

  3. CREATE requirements-clarification.md:

     <clarification_template>
       # Requirements Clarification - [SPEC_NAME]

       **Created:** [DATE]
       **Status:** Pending User Approval

       ## Feature Overview
       [1-2 sentence summary of the feature]

       ## Target Users
       [Who will use this feature]

       ## Business Value
       [Why this feature matters]

       ## Functional Requirements
       [List of WHAT the feature should do - user-facing]

       ## Affected Areas & Dependencies
       [Where this feature impacts the system]
       - [Component 1] - [Impact description]
       - [Component 2] - [Impact description]
       - [External System] - [Integration point]

       ## Edge Cases & Error Scenarios
       [What happens when things go wrong]
       - [Edge case 1] - [Expected behavior]
       - [Edge case 2] - [Expected behavior]

       ## Security & Permissions
       [Who can access what]

       ## Performance Considerations
       [Any performance requirements]

       ## Scope Boundaries
       **IN SCOPE:**
       - [Item 1]
       - [Item 2]

       **OUT OF SCOPE:**
       - [Item 1]
       - [Item 2]

       ## Open Questions (if any)
       - [Question 1]
       - [Question 2]

       ## Proposed User Stories (High Level)
       [List of story titles with brief descriptions - NOT full stories yet]
       1. [Story 1 Title] - [Brief description]
       2. [Story 2 Title] - [Brief description]
       3. [Story 3 Title] - [Brief description]

       ---
       *Review this document carefully. Once approved, detailed user stories will be generated.*
     </clarification_template>

  4. PRESENT clarification document to user
</mandatory_actions>

</substep>

<substep number="2.3" name="user_approval">

### Step 2.3: User Approval

<mandatory_actions>
  1. ASK user via AskUserQuestion:

     ```
     Question: "I've created a Requirements Clarification document based on our discussion.
                Please review it before I generate the detailed user stories."

     Options:
     1. Approve & Generate Stories
        → Requirements are correct
        → Proceed to generate full user stories

     2. Request Changes
        → Need to modify the clarification
        → I'll update based on your feedback

     3. Continue Discussion
        → Need to explore more aspects
        → Return to dialog mode
     ```

  2. BASED on user choice:
     - If "Approve": Proceed to Step 2.4
     - If "Request Changes": Update clarification, re-ask approval
     - If "Continue": Return to Step 2.1 with focused questions
</mandatory_actions>

</substep>

<substep number="2.4" name="generate_stories">

### Step 2.4: Generate User Stories (After Approval)

<mandatory_actions>
  1. USE date-checker to get current date (YYYY-MM-DD)

  2. CREATE spec folder structure:
     ```
     agent-os/specs/YYYY-MM-DD-spec-name/
     ├── stories/              # NEW: Individual story files
     │   ├── story-001-[slug].md
     │   ├── story-002-[slug].md
     │   └── ...
     ├── spec.md
     ├── spec-lite.md
     ├── story-index.md       # NEW: Story overview
     └── requirements-clarification.md
     ```

  3. CREATE spec.md (load template with hybrid lookup):
     - Overview (1-2 sentences goal)
     - User stories list
     - Spec scope (what's included)
     - Out of scope (what's excluded)
     - Expected deliverable (testable outcomes)
     - **Integration Requirements** (NEW - critical for end-to-end validation):
       * Integration Type: Backend-only, Frontend-only, or Full-stack
       * Integration Test Commands (bash commands to run)
       * End-to-End Scenarios (user journeys to validate)
       * For each test: mark if MCP tool required (e.g., Playwright)

  **INTEGRATION REQUIREMENTS GUIDELINES:**
  - If spec has Backend + Frontend stories: Integration Type = "Full-stack"
  - If spec only affects one layer: Integration Type = "Backend-only" or "Frontend-only"
  - Include at least 1-2 integration tests that verify the complete feature works
  - Integration tests should be bash commands that exit 0 if successful
  - Mark Playwright/browser tests with "Requires MCP: yes" (they will be optional)
  - These tests will be executed automatically in Phase 4.5 of execute-tasks

  4. CREATE spec-lite.md (load template with hybrid lookup):
     - 1-3 sentence summary of core goal

  5. CREATE stories/ directory

  6. CREATE individual story files (stories/story-XXX-[slug].md):
     FOR EACH story from clarification:
     - Generate story ID: [SPEC_PREFIX]-### (e.g., PROF-001, PROF-002)
     - Create file: stories/story-###-[slug].md
       where [slug] = title lowercase with hyphens
     - Use template: agent-os/templates/docs/story-template.md
     - Fill with FACHLICHE content:
       * Story title
       * Als [User] möchte ich [Aktion], damit [Nutzen]
       * Fachliche acceptance criteria (user-facing, 3-5 items)
       * Business value explanation
       * Required MCP Tools (if applicable)
     - Leave technical sections EMPTY (Architect fills in Step 3):
       * DoR/DoD checkboxes (unchecked)
       * WAS/WIE/WO/WER fields
       * Completion Check commands

  7. CREATE story-index.md (load template with hybrid lookup):
     - Use template: agent-os/templates/docs/story-index-template.md
     - Fill with:
       * Story Summary table (all stories)
       * Dependency Graph (initially all "None")
       * Execution Plan (initially all parallel)
       * List of story files
       * Blocked Stories section (initially empty)

  Templates (hybrid lookup):
  - TRY: agent-os/templates/docs/[template].md
  - FALLBACK: ~/.agent-os/templates/docs/[template].md

  STORY SIZING:
  - Keep stories small (max 5 files, max 400 LOC)
  - Automated validation occurs in Step 3.5
  - Full guidelines: agent-os/docs/story-sizing-guidelines.md

  ACCEPTANCE CRITERIA FORMAT (for automated verification):
  - Use prefix format: FILE_EXISTS:, CONTAINS:, LINT_PASS:, TEST_PASS:
  - Each criterion must be verifiable via bash command
  - Include exact file paths
  - For browser tests: MCP_PLAYWRIGHT: prefix
  - Avoid MANUAL: criteria when possible
  - Reference: agent-os/templates/docs/story-template.md

  IMPORTANT:
  - Write ONLY fachliche (business) content
  - NO technical details (WAS/WIE/WO/WER)
  - NO DoR/DoD (Architect adds this in Step 3)
  - NO dependencies (Architect adds this in Step 3)
  - Focus on WHAT user needs, not HOW to implement
  - Stories must be small enough for single Claude Code session
  - Each story gets its OWN file for better context efficiency
</mandatory_actions>

</substep>

**Output:**
- `agent-os/specs/YYYY-MM-DD-spec-name/requirements-clarification.md` (approved)
- `agent-os/specs/YYYY-MM-DD-spec-name/spec.md`
- `agent-os/specs/YYYY-MM-DD-spec-name/spec-lite.md`
- `agent-os/specs/YYYY-MM-DD-spec-name/story-index.md` (NEW)
- `agent-os/specs/YYYY-MM-DD-spec-name/stories/story-001-[slug].md` (NEW - fachlich only)
- `agent-os/specs/YYYY-MM-DD-spec-name/stories/story-002-[slug].md` (NEW - fachlich only)
- ... (one file per story)

</step>

<step number="3" subagent="dev-team__architect" name="architect_technical_refinement">

### Step 3: Architect Phase - Technical Refinement

Use dev-team__architect agent to add technical refinement to fachliche user stories.

<delegation>
  DELEGATE to dev-team__architect via Task tool:

  PROMPT:
  "Add technical refinement to user stories.

  ⚠️ **NEW: Individual Story Files**
  Each story now has its OWN file in the stories/ directory.
  You must edit EACH story file individually to add technical refinement.

  Context:
  - Spec: agent-os/specs/[YYYY-MM-DD-spec-name]/spec.md
  - Story Index: agent-os/specs/[YYYY-MM-DD-spec-name]/story-index.md
  - Story Files: agent-os/specs/[YYYY-MM-DD-spec-name]/stories/*.md
  - Tech Stack: agent-os/product/tech-stack.md
  - Architecture Decision: agent-os/product/architecture-decision.md
  - Architecture Structure: agent-os/product/architecture-structure.md (folder structure)
  - DoD: agent-os/team/dod.md (if exists, otherwise use standard DoD)
  - DoR: agent-os/team/dor.md (if exists, otherwise use standard DoR)

  Available DevTeam Agents (for WER field):
  - List agents from .claude/agents/dev-team/
  - Typical agents: dev-team__backend-developer, dev-team__frontend-developer,
    dev-team__devops-specialist, dev-team__qa-specialist
  - Use agent names as they appear in .claude/agents/dev-team/ folder

  Tasks:
  1. LIST all story files: ls agent-os/specs/[spec-name]/stories/

  2. FOR EACH story file in stories/ directory:

     a. READ the story file to understand fachliche requirements

     b. FIND the '## Technisches Refinement (vom Architect)' section
        (This section should already exist but be EMPTY/incomplete)

     c. FILL IN the following sections:

        **DoR (Definition of Ready):**
        - Mark ALL checkboxes as [x] complete when done
        - Fachliche requirements clear
        - Technical approach defined
        - Dependencies identified
        - Affected components known
        - Required MCP Tools documented (if applicable)
        - Story is appropriately sized (max 5 files, 400 LOC)

        **DoD (Definition of Done):**
        - Define completion criteria (all start unchecked [ ])
        - Code implemented and follows Style Guide
        - Architecture requirements met
        - Security/Performance requirements satisfied
        - All acceptance criteria met
        - Tests written and passing
        - Code review approved
        - Documentation updated
        - No linting errors
        - Completion Check commands successful

        **Technical Details:**

        **WAS:** [What components/features need to be created or modified - NO code]

        **WIE (Architecture Guidance ONLY):**
        - Which architectural patterns to apply (e.g., "Use Repository Pattern", "Apply Service Object")
        - Constraints to respect (e.g., "No direct DB calls from controllers", "Must use existing AuthService")
        - Existing patterns to follow (e.g., "Follow pattern from existing UserController")
        - Security/Performance considerations (e.g., "Requires rate limiting", "Use caching")

        ⚠️ IMPORTANT: NO implementation code, NO pseudo-code, NO detailed algorithms.
        The implementing agent decides HOW to write the code - you only set guardrails.

        **WO:** [Which files/folders to modify or create - paths only, no content]

        **WER:** [Which agent - check .claude/agents/dev-team/ for available agents]
        Examples: dev-team__backend-developer, dev-team__frontend-developer

        **Abhängigkeiten:** [Story IDs this depends on, or \"None\"]

        **Geschätzte Komplexität:** [XS/S/M/L/XL]

        **Completion Check:**
        ```bash
        # Auto-Verify Commands - all must exit with 0
        [VERIFY_COMMAND_1]
        [VERIFY_COMMAND_2]
        ```

        **Story ist DONE wenn:**
        1. Alle FILE_EXISTS/CONTAINS checks bestanden
        2. Alle *_PASS commands exit 0
        3. Git diff zeigt nur erwartete Änderungen

     d. UPDATE the story file with filled technical sections

     e. UPDATE story-index.md:
        - Mark story status as "Ready" if DoR is complete
        - Mark story status as "Blocked" if DoR is incomplete
        - Update Dependencies column
        - Update Type column (Backend/Frontend/DevOps/Test)

  3. AFTER all stories are refined:

     a. ANALYZE dependencies across ALL stories:
        - Can stories run in parallel?
        - Must some finish before others start?
        - Document dependency chain

     b. UPDATE story-index.md:
        - Update Dependency Graph
        - Update Execution Plan (parallel vs sequential)
        - Update Total Estimated Effort

     c. For dependent stories, note required handover documents:
        - API contracts
        - Data structures
        - Integration points

  4. EVALUATE cross-cutting concerns:
     - New external dependencies?
     - Global technical patterns needed?
     - Security patterns?
     - Performance requirements?

     If YES, create:
     agent-os/specs/[spec-name]/sub-specs/cross-cutting-decisions.md

     Include:
     - External dependencies (with justification)
     - Global patterns (auth, error handling)
     - Performance requirements
     - Security patterns

  5. ⚠️ **INTEGRATION STORY REQUIREMENT** (CRITICAL for multi-story specs):

     CHECK: Does this spec have multiple stories that need integration?

     IF (Backend stories + Frontend stories) OR (Multiple dependent stories):

       CREATE an additional Integration & Validation story:
       - Story ID: [PREFIX]-999 (last story to execute)
       - Title: "Integration & End-to-End Validation"
       - Type: Test/Integration
       - Dependencies: All other stories in this spec

       Fill this story with:
       **User Story:**
       Als Systemadministrator
       möchte ich dass alle Komponenten dieser Spec zusammenwirken,
       damit das Feature vollständig funktioniert.

       **Akzeptanzkriterien:**
       - [ ] INTEGRATION_PASS: All integration tests from spec.md pass
       - [ ] END_TO_END: Complete user journey works
       - [ ] COMPONENT_INTEGRATION: Backend and Frontend are connected
       - [ ] [Optional MCP_PLAYWRIGHT]: UI flow works end-to-end

       **Technical Details:**
       - WAS: Integration validation of all stories in this spec
       - WIE: Run integration tests defined in spec.md Integration Requirements
       - WO: Integration test scripts or manual test procedures
       - WER: dev-team__qa-specialist or test-runner
       - Abhängigkeiten: All other stories in this spec
       - Geschätzte Komplexität: S

       **Completion Check:**
       ```bash
       # Run integration tests from spec.md
       [INTEGRATION_TEST_COMMANDS_FROM_SPEC]
       ```

       UPDATE story-index.md to include this story as the LAST story

       MARK: This story ensures the complete system works, not just individual parts

  Templates (hybrid lookup):
  - story-template.md (for structure reference)
  - story-index-template.md (for index structure)
  - cross-cutting-decisions-template.md (if needed)

  IMPORTANT:
  - Add ONLY technical sections (WAS/WIE/WO/WER/DoR/DoD)
  - Do NOT modify fachliche descriptions
  - **MUST mark ALL DoR checkboxes as [x] complete** when story is ready
  - Define clear DoD per story
  - Map ALL dependencies
  - Add Completion Check section with bash verify commands
  - Keep stories small (automated validation in Step 3.5)
  - **DoR validation will run in Step 3.4 - all checkboxes must be [x]**
  - Update story-index.md after refining each story
  - **Create Integration Story for multi-story specs (Backend + Frontend)**
  - Reference: agent-os/docs/story-sizing-guidelines.md

  ARCHITECTURE GUIDANCE RULES:
  - WIE = Architectural constraints and patterns ONLY
  - NO code snippets, NO pseudo-code, NO implementation details
  - Focus on: What patterns to use, what to avoid, what to reuse
  - Let implementing agents decide the actual code
  - Example GOOD: 'Use Service Object pattern, follow UserService as template'
  - Example BAD: 'Create a method that takes user_id, calls find(), then updates...'
  - If you find yourself writing code, you're doing the implementer's job"

  WAIT for dev-team__architect completion
  RECEIVE:
    - Updated story files in stories/ directory (fachlich + technisch)
    - Updated story-index.md
    - Optional: sub-specs/cross-cutting-decisions.md
</delegation>

**Output:**
- `agent-os/specs/[spec-name]/stories/*.md` (COMPLETE with technical refinement)
- `agent-os/specs/[spec-name]/story-index.md` (updated with dependencies and status)
- `agent-os/specs/[spec-name]/sub-specs/cross-cutting-decisions.md` (optional)

</step>

<step number="3.4" name="dor_validation">

### Step 3.4: Definition of Ready (DoR) Validation

Validate that all stories have complete DoR before proceeding to execution.

<validation_process>
  LIST all story files: ls agent-os/specs/[spec-name]/stories/

  FOR EACH story file in stories/ directory:
    <extract_dor_checkboxes>
      READ: The story file
      FIND: "### Technisches Refinement (vom Architect)" section
      FIND: "DoR (Definition of Ready)" subsection
      EXTRACT: All checkbox lines starting with "- [" or "- [x]"
    </extract_dor_checkboxes>

    <check_completion>
      COUNT: Total number of DoR checkboxes
      COUNT: Number of checked checkboxes [x]

      IF checked_count < total_count:
        FLAG: Story as "DoR Incomplete"
        LIST: Unchecked DoR items
        SEVERITY: Critical - Story cannot start execution
    </check_completion>
</validation_process>

<decision_tree>
  IF all stories have complete DoR:
    LOG: "✅ All stories have complete DoR - Ready for execution"
    PROCEED: To Step 3.5 (Story Size Validation)

  ELSE (stories with incomplete DoR):
    GENERATE: DoR Validation Report

    <dor_report_format>
      ⚠️ Definition of Ready Validation - INCOMPLETE

      **Stories with Incomplete DoR:**

      **Story [ID]: [Title]**
      - Total DoR items: [N]
      - Checked: [N]
      - Unchecked: [N]

      **Missing DoR Items:**
      - [ ] [Unchecked item 1]
      - [ ] [Unchecked item 2]
      - [ ] [Unchecked item 3]

      ---

      **Summary:**
      - Total stories: [N]
      - Stories with complete DoR: [N]
      - Stories with incomplete DoR: [N] ⚠️

      **IMPORTANT:** Stories with incomplete DoR cannot start execution.
      The Architect must complete all DoR items before /execute-tasks can run.
    </dor_report_format>

    PRESENT: DoR Validation Report to user

    INFORM: "The Architect must complete all DoR checkboxes before stories can be executed.
             Incomplete DoR means stories are not ready for implementation."

    ASK user via AskUserQuestion:
    "How would you like to proceed?

    Options:
    1. Return to Architect to complete DoR
       → Architect will complete all unchecked DoR items
       → Validation will run again after completion

    2. Review and manually complete DoR
       → You can manually complete DoR items in story files
       → Re-run validation after edits

    3. Proceed anyway (NOT RECOMMENDED)
       → Stories with incomplete DoR will fail during execution
       → Risk: Blocked stories, missing requirements, unclear implementation"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Return to Architect":
        DELEGATE: To dev-team__architect with prompt:
        "Complete all DoR checkboxes for stories in agent-os/specs/[spec-name]/stories/

        For EACH story file with incomplete DoR:
        1. Read the story file
        2. Review the unchecked DoR items
        3. Complete the required analysis/design
        4. Mark all DoR items as [x] complete
        5. Update story-index.md to mark story as 'Ready'

        Return: Updated story files with all DoR items checked"

        WAIT for architect completion
        REPEAT: Step 3.4 (DoR Validation)

      ELSE IF choice = "Review and manually edit":
        INFORM: "Please edit the story files in: agent-os/specs/[spec-name]/stories/"
        INFORM: "Mark all DoR checkboxes as [x] complete in each story file"
        PAUSE: Wait for user to edit
        ASK: "Ready to re-validate? (yes/no)"
        IF yes:
          REPEAT: Step 3.4 (DoR Validation)
        ELSE:
          PROCEED: To Step 3.5 with warning flag

      ELSE IF choice = "Proceed anyway":
        WARN: "⚠️ Proceeding with incomplete DoR
               - Stories may be blocked during execution
               - Missing requirements may cause implementation issues
               - Architect should complete DoR before execution"

        LOG: DoR validation bypassed by user
        PROCEED: To Step 3.5
    </user_choice_handling>
</decision_tree>

<instructions>
  ACTION: Validate all DoR checkboxes are marked [x]
  CHECK: Each story file's DoR section
  REQUIRE: All checkboxes must be checked before execution
  BLOCK: Stories with incomplete DoR from starting
  REFERENCE: agent-os/team/dor.md (if exists)
</instructions>

**Output:**
- DoR validation report (if issues found)
- User decision on how to proceed
- Updated story files (if DoR completed)

</step>

<step number="3.5" name="story_size_validation">

### Step 3.5: Story Size Validation

Validate that all stories comply with size guidelines to prevent mid-execution context compaction.

<validation_process>
  LIST all story files: ls agent-os/specs/[spec-name]/stories/
  READ: agent-os/standards/story-size-guidelines.md (for reference thresholds)

  FOR EACH story file in stories/ directory:
    <extract_metrics>
      ANALYZE: WO (Where) field
        COUNT: Number of file paths mentioned
        EXTRACT: File paths list

      ANALYZE: Geschätzte Komplexität field
        EXTRACT: Complexity rating (XS/S/M/L/XL)

      ANALYZE: WAS (What) field
        ESTIMATE: Lines of code based on components mentioned
        HEURISTIC:
          - Each new file/component ~100-150 lines
          - Each modified file ~50-100 lines
          - Tests ~50-100 lines per test file
    </extract_metrics>

    <check_thresholds>
      CHECK: Number of files
        IF files > 5:
          FLAG: Story as "Too Large - File Count"
          SEVERITY: High

      CHECK: Complexity rating
        IF complexity in [M, L, XL]:
          FLAG: Story as "Too Complex"
          SEVERITY: High

      CHECK: Estimated LOC
        IF estimated_loc > 600:
          FLAG: Story as "Too Large - Code Volume"
          SEVERITY: Medium
        ELSE IF estimated_loc > 400:
          FLAG: Story as "Watch - Approaching Limit"
          SEVERITY: Low

      CHECK: Cross-layer detection
        IF WO contains backend AND frontend paths:
          FLAG: Story as "Multi-Layer"
          SEVERITY: Medium
          SUGGEST: "Split by layer (backend/frontend)"
    </check_thresholds>

    <record_issues>
      IF any flags raised:
        ADD to validation_report:
          - Story ID
          - Story Title
          - Issue(s) detected
          - Current metrics (files, complexity, LOC)
          - Recommended action
          - Suggested split pattern
    </record_issues>
</validation_process>

<decision_tree>
  IF no stories flagged:
    LOG: "✅ All stories pass size validation"
    PROCEED: To Step 4 (Spec Complete)

  ELSE (stories flagged):
    GENERATE: Validation Report

    <validation_report_format>
      ⚠️ Story Size Validation Issues

      **Stories Exceeding Guidelines:**

      **Story [ID]: [Title]**
      - Files: [count] (recommended: max 5) ❌
      - Complexity: [rating] (recommended: max S) ❌
      - Est. LOC: ~[count] (recommended: max 400-600) ⚠️
      - Issue: [description]

      **Recommendation:** Split into [N] stories:
      [Suggested split pattern based on story content]

      ---

      **Story [ID]: [Title]**
      ...

      **Summary:**
      - Total stories: [N]
      - Stories passing validation: [N]
      - Stories flagged: [N]
        - High severity: [N]
        - Medium severity: [N]
        - Low severity: [N]

      **Impact if proceeding with large stories:**
      - Higher token consumption per story
      - Risk of mid-story auto-compaction
      - Potential context loss during execution
      - Higher costs (possibly crossing 200K threshold)
    </validation_report_format>

    PRESENT: Validation Report to user

    ASK user via AskUserQuestion:
    "Story Size Validation detected issues. How would you like to proceed?

    Options:
    1. Review and manually edit stories (Recommended)
       → Edit the story files in stories/ directory
       → Re-run validation after edits

    2. Proceed anyway
       → Accept higher token costs
       → Risk mid-story compaction
       → Continue to execution

    3. Auto-split flagged stories
       → System suggests splits based on content
       → User reviews and approves splits
       → New story files created automatically"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Review and manually edit":
        INFORM: "Please edit the story files in: agent-os/specs/[spec-name]/stories/"
        INFORM: "Split large stories following patterns in:
                 agent-os/standards/story-size-guidelines.md"
        PAUSE: Wait for user to edit
        ASK: "Ready to re-validate? (yes/no)"
        IF yes:
          REPEAT: Step 3.5 (this validation step)
        ELSE:
          PROCEED: To Step 4 with warning flag

      ELSE IF choice = "Proceed anyway":
        WARN: "⚠️ Proceeding with oversized stories
               - Expect higher token costs
               - Mid-story compaction likely
               - Resume Context will preserve state if needed"
        LOG: Validation bypassed by user
        PROCEED: To Step 4

      ELSE IF choice = "Auto-split flagged stories":
        FOR EACH flagged_story:
          <suggest_split>
            ANALYZE: Story content (WAS/WIE/WO fields)

            DETERMINE: Split pattern
              IF multi_layer (backend + frontend):
                SUGGEST: "Split by layer"
                SUB_STORIES:
                  - Story [ID].1: Backend implementation
                  - Story [ID].2: Frontend implementation
                  - Story [ID].3: Integration

              ELSE IF high_file_count:
                SUGGEST: "Split by component"
                SUB_STORIES:
                  - Story [ID].1: Core component
                  - Story [ID].2: Supporting components
                  - Story [ID].3: Tests

              ELSE IF complex_feature:
                SUGGEST: "Split by vertical slice"
                SUB_STORIES:
                  - Story [ID].1: Basic functionality
                  - Story [ID].2: Advanced features
                  - Story [ID].3: Edge cases + tests
          </suggest_split>

          PRESENT: Suggested split to user
          ASK: "Accept this split for Story [ID]? (yes/no/custom)"

          IF yes:
            CREATE: New story files for sub-stories
            UPDATE: story-index.md with new stories
            UPDATE: Dependencies (sub-stories link to each other)
            MARK: Original story file as "Split into [IDs]"

          ELSE IF custom:
            ALLOW: User to describe custom split
            UPDATE: Based on user input

        AFTER all splits:
          INFORM: "Stories have been split. Re-running validation..."
          REPEAT: Step 3.5 (this validation step)
    </user_choice_handling>
</decision_tree>

<instructions>
  ACTION: Validate all stories against size guidelines
  CHECK: File count, complexity, estimated LOC, cross-layer detection
  REPORT: Any issues found with specific recommendations
  OFFER: Three options (edit, proceed, auto-split)
  ENFORCE: Validation loop until passed or user explicitly bypasses
  REFERENCE: agent-os/docs/story-sizing-guidelines.md
</instructions>

**Output:**
- Validation report (if issues found)
- User decision on how to proceed
- Updated story files (if stories were split)
- Updated story-index.md (if stories were split)

</step>

<step number="4" name="spec_complete">

### Step 4: Spec Ready for Execution

Present completed specification to user.

<summary_template>
  ✅ Specification complete!

  **Location:** agent-os/specs/[YYYY-MM-DD-spec-name]/

  **Files:**
  - requirements-clarification.md - Approved requirements summary
  - spec.md - Full specification
  - spec-lite.md - Quick reference summary
  - story-index.md - Story overview and dependency mapping
  - stories/ - Individual story files (fachlich + technisch)
    * story-001-[slug].md, story-002-[slug].md, etc.
    * Fachliche descriptions (PO)
    * Technical refinement (Architect): WAS/WIE/WO/WER/DoR/DoD
    * Dependencies mapped

  [IF cross-cutting exists:]
  - sub-specs/cross-cutting-decisions.md - Spec-wide technical decisions

  **Story Summary:**
  - Total stories: [N]
  - Can run parallel: [N]
  - Sequential dependencies: [N]
  - Total complexity: [Sum of story points]

  **Next Steps:**

  1. Review specification:
     → agent-os/specs/[spec-name]/story-index.md (overview)
     → agent-os/specs/[spec-name]/stories/ (individual stories)

  2. When ready, execute:
     → /execute-tasks
     → Creates kanban-board.md
     → Executes stories via DevTeam
     → Quality gates enforced
     → Docs generated per story
     → Per-story commits
     → Final PR

  What would you like to do?
  1. Review the spec first
  2. Start execution (/execute-tasks)
  3. Add more stories
</summary_template>

</step>

</process_flow>

## Final Checklist

<verify>
  - [ ] Spec folder created (YYYY-MM-DD prefix)
  - [ ] requirements-clarification.md created and approved by user
  - [ ] spec.md complete (all sections)
  - [ ] spec-lite.md concise
  - [ ] story-index.md created with all stories listed
  - [ ] stories/ directory created with individual story files
  - [ ] Each story file has fachlich + technical content
  - [ ] All stories have DoR/DoD
  - [ ] **All DoR checkboxes are marked [x] complete**
  - [ ] Dependencies identified in story-index.md
  - [ ] Cross-cutting decisions (if applicable)
  - [ ] **DoR validation passed (Step 3.4)**
  - [ ] **Story size validation passed (Step 3.5)**
  - [ ] Ready for /execute-tasks
</verify>
