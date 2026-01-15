---
description: Add quick task to backlog with lightweight PO + Architect refinement
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Add Todo Workflow

## Overview

Add a lightweight task to the backlog without full spec creation. Uses same story template as create-spec but with minimal overhead.

**Use Cases:**
- Small UI tweaks (e.g., "Add loading state to modal")
- Minor bug fixes
- Quick enhancements
- Tasks that don't warrant full specification

<pre_flight_check>
  EXECUTE: agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="backlog_setup">

### Step 1: Backlog Setup

<mandatory_actions>
  1. CHECK: Does agent-os/backlog/ directory exist?
     ```bash
     ls -la agent-os/backlog/ 2>/dev/null
     ```

  2. IF NOT exists:
     CREATE: agent-os/backlog/ directory
     CREATE: agent-os/backlog/story-index.md (from template)

  3. USE: date-checker to get current date (YYYY-MM-DD)

  4. DETERMINE: Next story index for today
     COUNT: Existing stories with today's date prefix
     ```bash
     ls agent-os/backlog/ | grep "^$(date +%Y-%m-%d)" | wc -l
     ```
     NEXT_INDEX = count + 1 (formatted as 3 digits: 001, 002, etc.)

  5. GENERATE: Story ID = YYYY-MM-DD-[INDEX]
     Example: 2025-01-15-001, 2025-01-15-002
</mandatory_actions>

</step>

<step number="2" name="po_quick_dialog">

### Step 2: PO Phase - Quick Requirements Dialog

⚠️ **LIGHTWEIGHT:** Unlike create-spec, this is a brief dialog (2-4 questions max).

<mandatory_actions>
  1. IF user provided task description in command:
     EXTRACT: Task description from input

  2. ASK quick clarifying questions (only if needed):
     - What exactly should be done? (if unclear)
     - Where in the app? (which component/page)
     - Any special acceptance criteria?

  3. DETERMINE: Story type
     - Frontend (UI changes)
     - Backend (API/Logic changes)
     - DevOps (Infrastructure)
     - Test (Test additions)

  4. KEEP IT BRIEF:
     - No extensive requirements gathering
     - No clarification document
     - Direct to story creation
</mandatory_actions>

</step>

<step number="3" name="create_story_file">

### Step 3: Create User Story File

<mandatory_actions>
  1. GENERATE: File name
     FORMAT: user-story-[YYYY-MM-DD]-[INDEX]-[slug].md
     Example: user-story-2025-01-15-001-loading-state-modal.md

  2. USE: story-template.md (same as create-spec)
     Template: agent-os/templates/docs/story-template.md

  3. FILL fachliche content (PO perspective):
     - Story Title
     - Als [User] möchte ich [Aktion], damit [Nutzen]
     - Fachliche acceptance criteria (2-4 items, keep brief)
     - Priority: Low/Medium/High
     - Type: Frontend/Backend/DevOps/Test

  4. LEAVE technical sections EMPTY:
     - DoR/DoD checkboxes (unchecked)
     - WAS/WIE/WO/WER fields
     - Completion Check commands

  5. WRITE: Story file to agent-os/backlog/
</mandatory_actions>

<story_file_structure>
  agent-os/backlog/user-story-YYYY-MM-DD-[INDEX]-[slug].md
</story_file_structure>

</step>

<step number="4" subagent="dev-team__architect" name="architect_refinement">

### Step 4: Architect Phase - Technical Refinement

<delegation>
  DELEGATE to dev-team__architect via Task tool:

  PROMPT:
  "Add technical refinement to backlog story.

  Story File: agent-os/backlog/user-story-[YYYY-MM-DD]-[INDEX]-[slug].md

  Context:
  - Tech Stack: agent-os/product/tech-stack.md
  - Architecture: agent-os/product/architecture-decision.md (if exists)
  - Architecture Structure: agent-os/product/architecture-structure.md (if exists)

  Available DevTeam Agents:
  - List agents from .claude/agents/dev-team/

  Tasks:
  1. READ the story file
  2. ANALYZE the fachliche requirements
  3. FILL technical sections:

     **DoR (Definition of Ready):**
     - Mark ALL checkboxes as [x] when complete

     **DoD (Definition of Done):**
     - Define completion criteria (start unchecked [ ])

     **Technical Details:**
     - WAS: Components to create/modify (brief)
     - WIE: Architecture guidance only (NO code)
     - WO: File paths to modify
     - WER: Which agent (e.g., dev-team__frontend-developer)
     - Abhängigkeiten: None (backlog stories are independent)
     - Geschätzte Komplexität: XS or S (if larger, suggest create-spec)

     **Completion Check:**
     - Add bash verify commands

  4. IF story seems too large (>5 files, >400 LOC):
     WARN: 'This task may be too complex for /add-todo. Consider /create-spec instead.'
     ASK: 'Proceed anyway or switch to /create-spec?'

  IMPORTANT:
  - Keep it lightweight - this is a quick task
  - Add ONLY technical sections
  - Do NOT modify fachliche descriptions
  - Mark ALL DoR checkboxes as [x] complete
  - Backlog stories should be XS or S complexity"

  WAIT for dev-team__architect completion
</delegation>

</step>

<step number="5" name="update_story_index">

### Step 5: Update Backlog Story Index

<mandatory_actions>
  1. READ: agent-os/backlog/story-index.md

  2. ADD new story to Story Summary table:
     | Story ID | Title | Type | Priority | Dependencies | Status | Points |

  3. UPDATE totals:
     - Total Stories: +1
     - Backlog Count: +1

  4. UPDATE: Last Updated date

  5. WRITE: Updated story-index.md
</mandatory_actions>

</step>

<step number="6" name="completion_summary">

### Step 6: Task Added Confirmation

<summary_template>
  ✅ Task added to backlog!

  **Story ID:** [YYYY-MM-DD-INDEX]
  **File:** agent-os/backlog/user-story-[YYYY-MM-DD]-[INDEX]-[slug].md

  **Summary:**
  - Title: [Story Title]
  - Type: [Frontend/Backend/etc.]
  - Complexity: [XS/S]
  - Status: Ready

  **Backlog Status:**
  - Total tasks: [N]
  - Ready for execution: [N]

  **Next Steps:**
  1. Add more tasks: /add-todo "[description]"
  2. Execute backlog: /execute-tasks backlog
  3. View backlog: agent-os/backlog/story-index.md
</summary_template>

</step>

</process_flow>

## Final Checklist

<verify>
  - [ ] Backlog directory exists
  - [ ] Story file created with correct naming
  - [ ] Story ID format: YYYY-MM-DD-[INDEX]
  - [ ] Fachliche content complete (brief)
  - [ ] Technical refinement complete
  - [ ] All DoR checkboxes marked [x]
  - [ ] Story-index.md updated
  - [ ] Ready for /execute-tasks backlog
</verify>

## When NOT to Use /add-todo

Suggest /create-spec instead when:
- Task requires multiple stories
- Task needs clarification document
- Estimated complexity > S
- Task affects >5 files
- Task needs extensive requirements gathering
- Task is a major feature
