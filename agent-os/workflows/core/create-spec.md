---
description: Create Feature Specification with DevTeam (PO + Architect)
globs:
alwaysApply: false
version: 2.1
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

<step number="2" subagent="dev-team__po" name="po_fachliche_requirements">

### Step 2: PO Phase - Fachliche Requirements

Use dev-team__po agent to gather fachliche (business) requirements from user and create user stories.

<delegation>
  DELEGATE to dev-team__po via Task tool:

  PROMPT:
  "Create fachliche specification for: [SPEC_IDEA]

  Context:
  - Product Brief: agent-os/product/product-brief-lite.md
  - Roadmap: agent-os/product/roadmap.md (if from roadmap)

  Tasks:
  1. Clarify fachliche requirements with user:
     - What is the feature? (user perspective)
     - Who needs it? (target users)
     - Why is it valuable? (business value)
     - What are acceptance criteria? (user-facing)
     - What is in scope? What is out of scope?

  2. Use date-checker to get current date (YYYY-MM-DD)

  3. Create spec folder: agent-os/specs/YYYY-MM-DD-spec-name/

  4. Create spec.md (load template with hybrid lookup):
     - Overview (1-2 sentences goal)
     - User stories list
     - Spec scope (what's included)
     - Out of scope (what's excluded)
     - Expected deliverable (testable outcomes)

  5. Create spec-lite.md (load template with hybrid lookup):
     - 1-3 sentence summary of core goal

  6. Create user-stories.md with FACHLICHE stories only:
     For each feature:
     - Story title
     - Als [User] möchte ich [Aktion], damit [Nutzen]
     - Fachliche acceptance criteria (user-facing, 3-5 items)
     - Business value explanation
     - Leave section marker: [ARCHITECT ADDS TECHNICAL REFINEMENT HERE]

  Templates (hybrid lookup):
  - TRY: agent-os/templates/docs/spec-template.md
  - FALLBACK: ~/.agent-os/templates/docs/spec-template.md
  (Same for spec-lite-template.md, user-stories-template.md)

  STORY SIZING RULES (for automated execution):
  - Max 5 Dateien pro Story
  - Max 400 LOC pro Story
  - Wenn Story > 5 Dateien: MANDATORY SPLIT in Sub-Stories
  - Komplexität max 'S' (Small, 1-3 SP)
  - Bei 'M' oder größer: MANDATORY SPLIT
  - Reference: agent-os/docs/story-sizing-guidelines.md

  ACCEPTANCE CRITERIA FORMAT (for automated verification):
  - Use prefix format: FILE_EXISTS:, CONTAINS:, LINT_PASS:, TEST_PASS:
  - Each criterion must be verifiable via bash command
  - Include exact file paths
  - For browser tests: MCP_PLAYWRIGHT: prefix (document in Required MCP Tools section)
  - Avoid MANUAL: criteria when possible
  - Reference: agent-os/templates/docs/user-stories-template.md

  IMPORTANT:
  - Write ONLY fachliche (business) content
  - NO technical details (WAS/WIE/WO/WER)
  - NO DoR/DoD (Architect adds this)
  - NO dependencies
  - Focus on WHAT user needs, not HOW to implement
  - Stories must be small enough for single Claude Code session"

  WAIT for dev-team__po completion
  RECEIVE:
    - agent-os/specs/YYYY-MM-DD-spec-name/spec.md
    - agent-os/specs/YYYY-MM-DD-spec-name/spec-lite.md
    - agent-os/specs/YYYY-MM-DD-spec-name/user-stories.md (fachlich only)
</delegation>

**Output:**
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

    2. Add technical refinement section after fachliche description:

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

       **WAS:** [What needs to be implemented - components/features]

       **WIE:** [How - technical approach, patterns, frameworks]

       **WO:** [Where - file paths and components]

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
  - Ensure DoR met for all stories
  - Define clear DoD per story
  - Map ALL dependencies
  - Add Completion Check section with bash verify commands
  - Ensure story complexity max 'S' (split if larger)
  - Reference: agent-os/docs/story-sizing-guidelines.md"

  WAIT for dev-team__architect completion
  RECEIVE:
    - Updated user-stories.md (fachlich + technisch)
    - Optional: sub-specs/cross-cutting-decisions.md
</delegation>

**Output:**
- `agent-os/specs/[spec-name]/user-stories.md` (COMPLETE with technical refinement)
- `agent-os/specs/[spec-name]/sub-specs/cross-cutting-decisions.md` (optional)

</step>

<step number="4" name="spec_complete">

### Step 4: Spec Ready for Execution

Present completed specification to user.

<summary_template>
  ✅ Specification complete!

  **Location:** agent-os/specs/[YYYY-MM-DD-spec-name]/

  **Files:**
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
  - [ ] spec.md complete (all sections)
  - [ ] spec-lite.md concise
  - [ ] user-stories.md has fachlich + technical
  - [ ] All stories have DoR/DoD
  - [ ] Dependencies identified
  - [ ] Cross-cutting decisions (if applicable)
  - [ ] Ready for /execute-tasks
</verify>
