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
  1. CREATE spec.md (load template with hybrid lookup):
     - Overview (1-2 sentences goal)
     - User stories list
     - Spec scope (what's included)
     - Out of scope (what's excluded)
     - Expected deliverable (testable outcomes)

  2. CREATE spec-lite.md (load template with hybrid lookup):
     - 1-3 sentence summary of core goal

  3. CREATE user-stories.md with FACHLICHE stories only:
     For each story from clarification:
     - Story title
     - Als [User] möchte ich [Aktion], damit [Nutzen]
     - Fachliche acceptance criteria (user-facing, 3-5 items)
     - Business value explanation
     - Leave section marker: [ARCHITECT ADDS TECHNICAL REFINEMENT HERE]

  Templates (hybrid lookup):
  - TRY: agent-os/templates/docs/spec-template.md
  - FALLBACK: ~/.agent-os/templates/docs/spec-template.md
  (Same for spec-lite-template.md, user-stories-template.md)

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
  - Reference: agent-os/templates/docs/user-stories-template.md

  IMPORTANT:
  - Write ONLY fachliche (business) content
  - NO technical details (WAS/WIE/WO/WER)
  - NO DoR/DoD (Architect adds this)
  - NO dependencies
  - Focus on WHAT user needs, not HOW to implement
  - Stories must be small enough for single Claude Code session
</mandatory_actions>

</substep>

**Output:**
- `agent-os/specs/YYYY-MM-DD-spec-name/requirements-clarification.md` (approved)
- `agent-os/specs/YYYY-MM-DD-spec-name/spec.md`
- `agent-os/specs/YYYY-MM-DD-spec-name/spec-lite.md`
- `agent-os/specs/YYYY-MM-DD-spec-name/user-stories.md` (fachlich only)

</step>

<step number="3" subagent="dev-team__architect" name="architect_technical_refinement">

### Step 3: Architect Phase - Technical Refinement

Use dev-team__architect agent to add technical refinement to fachliche user stories.

<delegation>
  DELEGATE to dev-team__architect via Task tool:

  PROMPT:
  "Add technical refinement to user stories.

  ⚠️ **CRITICAL: Technical Refinement Placement**
  The technical refinement MUST be inserted DIRECTLY after each fachliche user story,
  specifically AFTER the '---' separator that follows the 'Required MCP Tools' section.
  Do NOT append all technical refinements at the end of the document.

  Context:
  - Spec: agent-os/specs/[YYYY-MM-DD-spec-name]/spec.md
  - User Stories: agent-os/specs/[YYYY-MM-DD-spec-name]/user-stories.md
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
  FOR EACH user story in user-stories.md:

    1. Read fachliche story from PO
    2. Find the '---' separator after 'Required MCP Tools' section
    3. INSERT technical refinement section IMMEDIATELY after that separator

       ---

       ### Technisches Refinement (vom Architect)

       **DoR (Definition of Ready):**
       - [x] Fachliche requirements clear
       - [x] Technical approach defined
       - [x] Dependencies identified
       - [x] Affected components known

       **DoD (Definition of Done):**
       - [ ] Code implemented
       - [ ] Tests written and passing
       - [ ] Code review by architect
       - [ ] QA testing completed
       - [ ] Documentation generated

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

    3. Analyze dependencies:
       - Can stories run in parallel?
       - Must some finish before others start?
       - Document dependency chain

    4. For dependent stories, note required handover documents:
       - API contracts
       - Data structures
       - Integration points

    5. Evaluate cross-cutting concerns:
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

  Templates (hybrid lookup):
  - user-stories-template.md (for structure reference)
  - cross-cutting-decisions-template.md (if needed)

  IMPORTANT:
  - Add ONLY technical sections (WAS/WIE/WO/WER/DoR/DoD)
  - Do NOT modify fachliche descriptions
  - **MUST mark ALL DoR checkboxes as [x] complete**
  - Define clear DoD per story
  - Map ALL dependencies
  - Add Completion Check section with bash verify commands
  - Keep stories small (automated validation in Step 3.5)
  - **DoR validation will run in Step 3.4 - all checkboxes must be [x]**
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
    - Updated user-stories.md (fachlich + technisch)
    - Optional: sub-specs/cross-cutting-decisions.md
</delegation>

**Output:**
- `agent-os/specs/[spec-name]/user-stories.md` (COMPLETE with technical refinement)
- `agent-os/specs/[spec-name]/sub-specs/cross-cutting-decisions.md` (optional)

</step>

<step number="3.4" name="dor_validation">

### Step 3.4: Definition of Ready (DoR) Validation

Validate that all stories have complete DoR before proceeding to execution.

<validation_process>
  READ: agent-os/specs/[spec-name]/user-stories.md

  FOR EACH story in user-stories.md:
    <extract_dor_checkboxes>
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
       → Opens user-stories.md for editing
       → You can manually complete DoR items
       → Re-run validation after edits

    3. Proceed anyway (NOT RECOMMENDED)
       → Stories with incomplete DoR will fail during execution
       → Risk: Blocked stories, missing requirements, unclear implementation"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Return to Architect":
        DELEGATE: To dev-team__architect with prompt:
        "Complete all DoR checkboxes for stories in agent-os/specs/[spec-name]/user-stories.md

        For EACH story with incomplete DoR:
        1. Review the unchecked DoR items
        2. Complete the required analysis/design
        3. Mark all DoR items as [x] complete

        Return: Updated user-stories.md with all DoR items checked"

        WAIT for architect completion
        REPEAT: Step 3.4 (DoR Validation)

      ELSE IF choice = "Review and manually edit":
        INFORM: "Please edit: agent-os/specs/[spec-name]/user-stories.md"
        INFORM: "Mark all DoR checkboxes as [x] complete"
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
  CHECK: Each story's DoR section
  REQUIRE: All checkboxes must be checked before execution
  BLOCK: Stories with incomplete DoR from starting
  REFERENCE: agent-os/team/dor.md (if exists)
</instructions>

**Output:**
- DoR validation report (if issues found)
- User decision on how to proceed
- Updated user-stories.md (if DoR completed)

</step>

<step number="3.5" name="story_size_validation">

### Step 3.5: Story Size Validation

Validate that all stories comply with size guidelines to prevent mid-execution context compaction.

<validation_process>
  READ: agent-os/specs/[spec-name]/user-stories.md
  READ: agent-os/standards/story-size-guidelines.md (for reference thresholds)

  FOR EACH story in user-stories.md:
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
       → Opens user-stories.md for editing
       → Re-run validation after edits

    2. Proceed anyway
       → Accept higher token costs
       → Risk mid-story compaction
       → Continue to execution

    3. Auto-split flagged stories
       → System suggests splits based on content
       → User reviews and approves splits
       → Stories updated automatically"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Review and manually edit":
        INFORM: "Please edit: agent-os/specs/[spec-name]/user-stories.md"
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
            UPDATE: user-stories.md with sub-stories
            UPDATE: Dependencies (sub-stories link to each other)
            MARK: Original story as "Split into [IDs]"

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
- Updated user-stories.md (if stories were split)

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
  - user-stories.md - User stories (fachlich + technisch)
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
     → agent-os/specs/[spec-name]/user-stories.md

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
  - [ ] user-stories.md has fachlich + technical
  - [ ] **Technical refinement directly under each story (not at end)**
  - [ ] All stories have DoR/DoD
  - [ ] **All DoR checkboxes are marked [x] complete**
  - [ ] Dependencies identified
  - [ ] Cross-cutting decisions (if applicable)
  - [ ] **DoR validation passed (Step 3.4)**
  - [ ] **Story size validation passed (Step 3.5)**
  - [ ] Ready for /execute-tasks
</verify>
