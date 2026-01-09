---
description: Add Bug to Existing Spec
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Add Bug to Existing Spec

## Overview

Add a bug story to an existing specification's user-stories.md and kanban-board.md for tracking and execution.

<pre_flight_check>
  EXECUTE: @~/.agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="spec_identification">

### Step 1: Identify Target Spec

Identify which specification the bug belongs to.

<user_input>
  REQUIRE: Spec name or path
  FORMAT: "spec-name" or "2025-01-09-feature-name"
  VALIDATE: Spec folder exists at .agent-os/specs/[spec-name]/
</user_input>

<validation>
  IF spec_not_found:
    LIST available specs from .agent-os/specs/
    ASK user to select from list
</validation>

</step>

<step number="2" subagent="dev-team__po" name="bug_details_gathering">

### Step 2: Gather Bug Details

Use dev-team__po agent to gather complete bug information from user through structured questions.

<po_questions>
  ASK user:
    1. "Can you reproduce the bug reliably? (yes/no)"
    2. "What are the steps to reproduce?"
       - Provide numbered list
       - Include specific inputs/actions
    3. "What is the expected behavior?"
       - Describe what should happen
    4. "What is the actual behavior?"
       - Describe what actually happens
       - Include error messages if any
    5. "What is the severity/priority? (High/Medium/Low)"
    6. "Which component or feature is affected?"
</po_questions>

<instructions>
  ACTION: Use dev-team__po agent to gather information
  FORMAT: Structured bug report
  VALIDATE: All required fields completed
</instructions>

</step>

<step number="3" name="complexity_assessment">

### Step 3: Assess Bug Complexity

Determine if bug requires technical analysis from architect.

<complexity_check>
  CHECK for complexity indicators:
    - Multiple components affected
    - Database schema involved
    - API contract changes needed
    - Security implications
    - Performance issues
    - Unknown root cause

  IF any_indicator_present:
    Bug is complex
  ELSE:
    Bug is simple
</complexity_check>

</step>

<step number="4" subagent="dev-team__architect" name="technical_analysis">

### Step 4: Technical Analysis (Conditional)

Use dev-team__architect agent for technical analysis if bug is complex.

<conditional_logic>
  IF bug_complex (from Step 3):
    DELEGATE to dev-team__architect:
      "Analyze bug: [bug description]

      Provide:
      1. Root cause analysis
      2. Affected components
      3. Technical approach to fix
      4. Risks and dependencies
      5. Estimated complexity"
  ELSE:
    SKIP this step
</conditional_logic>

</step>

<step number="5" subagent="file-creator" name="create_bug_story">

### Step 5: Create Bug Story

Use file-creator agent to add bug story to existing user-stories.md.

<bug_story_structure>
  APPEND to: .agent-os/specs/[spec-name]/user-stories.md

  Format:
  ```markdown
  ## 🐛 Bug X: [Bug Title]

  ### Bug Description (vom User)

  [Description from user]

  **Steps to reproduce:**
  1. [Step 1]
  2. [Step 2]
  ...

  **Expected:** [Expected behavior]
  **Actual:** [Actual behavior]

  **Severity:** [High/Medium/Low]
  **Affected Component:** [Component name]

  ---

  ### Technical Analysis (vom Architect - optional)

  [IF Step 4 executed, include technical analysis]

  **Root Cause:** [Cause]

  **DoR (Definition of Ready):**
  - [x] Bug reproducible
  - [x] Expected behavior clear
  - [x] Affected component identified

  **DoD (Definition of Done):**
  - [ ] Bug fixed in [component]
  - [ ] Test added to prevent regression
  - [ ] Tested manually with reproduction steps
  - [ ] No related bugs introduced

  **Technical Details:**

  **WAS:** [Fix description]
  **WIE:** [Technical approach]
  **WO:** [Files to modify]
  **WER:** [Assigned agent type, e.g., Backend Developer]
  **Abhängigkeiten:** [Dependencies or "None"]
  **Priority:** [High/Medium/Low]
  ```
</bug_story_structure>

<instructions>
  ACTION: Use file-creator to append bug story
  PATH: .agent-os/specs/[spec-name]/user-stories.md
  POSITION: End of file
  NUMBERING: Increment bug number (Bug 1, Bug 2, etc.)
</instructions>

</step>

<step number="6" subagent="file-creator" name="update_kanban_board">

### Step 6: Update Kanban Board

Use file-creator agent to add bug to kanban-board.md Backlog if board exists.

<conditional_logic>
  IF kanban-board.md EXISTS at .agent-os/specs/[spec-name]/:
    UPDATE kanban-board.md:
      ADD bug to "🔴 Backlog" section

      Format:
      ```markdown
      - [ ] 🐛 **Bug X**: [Bug Title]
        - **ID**: bug-x
        - **Type**: [Backend/Frontend/DevOps/etc.] Bug
        - **Severity**: [High/Medium/Low]
        - **Assigned**: Pending
        - **Reporter**: User ([User name if available])
        - **Created**: [ISO 8601 timestamp]
        - **Dependencies**: [Dependencies or "None"]
        - **Estimated**: [Story Points]
      ```

      UPDATE Board Status metrics:
        - Increment Backlog count
        - Update Total Stories count

      ADD Change Log entry:
        | [Timestamp] | Bug Added | bug-x | dev-team__po | Bug reported by user |

  ELSE:
    NOTE: "Kanban board will be created when /execute-tasks runs"
</conditional_logic>

</step>

<step number="7" name="execution_decision">

### Step 7: Ask User About Execution

Ask user if they want to fix the bug immediately or leave it in backlog.

<user_prompt>
  "Bug story created successfully!

  **Bug:** [Bug Title]
  **Location:** @.agent-os/specs/[spec-name]/user-stories.md#bug-x
  **Kanban:** [Added to backlog OR Will be added when /execute-tasks runs]

  Would you like to:
  1. Fix this bug immediately (/execute-tasks)
  2. Leave in backlog for later
  3. View the bug story first

  Your choice: [1/2/3]"
</user_prompt>

<execution_flow>
  IF user_choice = 1:
    NOTE: "Starting /execute-tasks..."
    EXECUTE: @~/.agent-os/workflows/core/execute-tasks.md
    FOCUS: On bug-x specifically

  ELSE IF user_choice = 2:
    NOTE: "Bug added to backlog. Run /execute-tasks when ready to fix."
    EXIT

  ELSE IF user_choice = 3:
    DISPLAY: Contents of bug story from user-stories.md
    RETURN: To execution decision
</execution_flow>

</step>

</process_flow>

## Final Checklist

<verify>
  - [ ] Spec identified and validated
  - [ ] Bug details gathered from user
  - [ ] Complexity assessed
  - [ ] Technical analysis completed (if complex)
  - [ ] Bug story added to user-stories.md
  - [ ] Kanban board updated (if exists)
  - [ ] User informed of next steps
</verify>
