---
description: Daily Plan Creation Rules for Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Daily Plan Creation Rules

## Overview

Create a structured daily work plan with features, bugs, and tasks for systematic execution and tracking.

<process_flow>

<step number="1" name="plan_initiation">

### Step 1: Plan Initiation

Accept user input for daily work items and categorize them appropriately.

<user_input>
  <accepts>
    - Feature descriptions (any format)
    - Bug reports (any detail level)
    - General tasks or ideas
    - Comma-separated lists
    - Numbered lists
    - Free-form text
  </accepts>
  <examples>
    - "I want to implement dark mode and fix the login bug"
    - "1. Add user profile, 2. Fix navigation, 3. Update docs"
    - "Dark mode feature, login bug, refactor auth module"
  </examples>
</user_input>

<categorization>
  <feature>new functionality or enhancement</feature>
  <bug>issue or defect to fix</bug>
  <task>general work item or maintenance</task>
</categorization>

</step>

<step number="2" name="information_gathering">

### Step 2: Information Gathering

Interactively gather missing information for each work item.

<for_each_item>
  <feature_questions>
    - What is the main goal of this feature?
    - What are the key functionalities needed?
    - Are there any UI/UX requirements?
    - What's the expected user workflow?
    - Any specific technical requirements?
    - Priority level? (High/Medium/Low)
  </feature_questions>

  <bug_questions>
    - Can you describe the bug in detail?
    - What are the reproduction steps?
    - What's the expected vs actual behavior?
    - What environment does this occur in?
    - How critical is this bug? (Critical/High/Medium/Low)
    - Are there any error messages?
  </bug_questions>

  <task_questions>
    - What's the specific goal of this task?
    - What are the deliverables?
    - Are there any dependencies?
    - What's the priority? (High/Medium/Low)
    - Any specific requirements or constraints?
  </task_questions>
</for_each_item>

<interactive_flow>
  ASK: Numbered questions for missing information
  WAIT: For user responses
  CLARIFY: Any ambiguous answers
  CONFIRM: Understanding before proceeding
</interactive_flow>

</step>

<step number="3" subagent="date-checker" name="date_determination">

### Step 3: Date Determination

Use the date-checker subagent to determine the current date for folder naming.

<subagent_instructions>
  ACTION: Use date-checker subagent
  PURPOSE: Get current date in YYYY-MM-DD format
  STORE: Date for folder creation
</subagent_instructions>

</step>

<step number="4" subagent="file-creator" name="folder_structure_creation">

### Step 4: Create Folder Structure

Use the file-creator subagent to create the daily plan directory structure.

<directory_structure>
  <base_path>.agent-os/daily-plans/YYYY-MM-DD/</base_path>
  <naming>
    - Use date from step 3
    - Create parent directory if needed
  </naming>
</directory_structure>

</step>

<step number="5" subagent="file-creator" name="create_daily_summary">

### Step 5: Create Daily Summary

Use the file-creator subagent to create the main summary file.

<file_template>
  <path>.agent-os/daily-plans/YYYY-MM-DD/daily-summary.md</path>
  <content>
    # Daily Work Plan

    > Date: [YYYY-MM-DD]
    > Created: [TIMESTAMP]
    > Status: Planning | In Progress | Review | Completed

    ## Overview

    Daily objectives and work items for systematic execution.

    ## Work Items

    ### Features (X items)
    1. **[FEATURE_NAME]** - [STATUS] - Priority: [HIGH/MEDIUM/LOW]
       - File: feature-[KEBAB-CASE].md
       - Description: [ONE_LINE_SUMMARY]

    ### Bugs (Y items)
    1. **[BUG_TITLE]** - [STATUS] - Severity: [CRITICAL/HIGH/MEDIUM/LOW]
       - File: bug-[KEBAB-CASE].md
       - Description: [ONE_LINE_SUMMARY]

    ### Tasks (Z items)
    1. **[TASK_NAME]** - [STATUS] - Priority: [HIGH/MEDIUM/LOW]
       - File: task-[KEBAB-CASE].md
       - Description: [ONE_LINE_SUMMARY]

    ## Execution Order

    Recommended order based on priority and dependencies:
    1. [ITEM_NAME] - [TYPE] - [REASON_FOR_ORDER]
    2. [ITEM_NAME] - [TYPE] - [REASON_FOR_ORDER]

    ## Progress Tracking

    - [ ] Planning completed
    - [ ] Execution started
    - [ ] All items completed
    - [ ] Review conducted
    - [ ] Iterations completed

    ## Notes

    [Any additional context or considerations]
  </content>
</file_template>

</step>

<step number="6" subagent="file-creator" name="create_individual_items">

### Step 6: Create Individual Work Item Files

Use the file-creator subagent to create detailed files for each work item.

<for_each_feature>
  <file_template>
    <path>.agent-os/daily-plans/YYYY-MM-DD/feature-[KEBAB-CASE].md</path>
    <content>
      # Feature: [FEATURE_NAME]

      **Type**: Feature
      **Priority**: [High/Medium/Low]
      **Status**: Planning | In Progress | Review | Completed | Approved
      **Created**: [TIMESTAMP]
      **Updated**: [TIMESTAMP]

      ## Description

      [DETAILED_FEATURE_DESCRIPTION]

      ## Objectives

      [WHAT_THIS_FEATURE_SHOULD_ACHIEVE]

      ## Technical Requirements

      - [REQUIREMENT_1]
      - [REQUIREMENT_2]

      ## Implementation Tasks

      - [ ] 1. [TASK_DESCRIPTION]
        - [ ] 1.1 [SUBTASK]
        - [ ] 1.2 [SUBTASK]
      - [ ] 2. [TASK_DESCRIPTION]
        - [ ] 2.1 [SUBTASK]
      - [ ] 2.2 [SUBTASK]

      ## Acceptance Criteria

      Feature is complete when:
      - [ ] [CRITERION_1]
      - [ ] [CRITERION_2]
      - [ ] All tests pass
      - [ ] Code is documented
      - [ ] User can [SPECIFIC_ACTION]

      ## Testing Instructions

      1. [STEP_TO_TEST]
      2. [STEP_TO_TEST]

      ## Implementation Notes

      [NOTES_ADDED_DURING_EXECUTION]

      ## Review Feedback

      ### Iteration 1 - [DATE]
      **Status**: [Pending/Approved/Needs Work]
      **Feedback**: [USER_FEEDBACK]

      ## Git Commits

      - [COMMIT_HASH] - [COMMIT_MESSAGE]
    </content>
  </file_template>
</for_each_feature>

<for_each_bug>
  <file_template>
    <path>.agent-os/daily-plans/YYYY-MM-DD/bug-[KEBAB-CASE].md</path>
    <content>
      # Bug: [BUG_TITLE]

      **Type**: Bug
      **Severity**: [Critical/High/Medium/Low]
      **Status**: Planning | In Progress | Review | Completed | Approved
      **Created**: [TIMESTAMP]
      **Updated**: [TIMESTAMP]

      ## Description

      [DETAILED_BUG_DESCRIPTION]

      ## Environment

      - **Platform**: [OS/Browser/Environment]
      - **Version**: [Application version]
      - **Context**: [Development/Staging/Production]

      ## Reproduction Steps

      1. [STEP_1]
      2. [STEP_2]
      3. [STEP_3]

      ## Expected Behavior

      [WHAT_SHOULD_HAPPEN]

      ## Actual Behavior

      [WHAT_ACTUALLY_HAPPENS]

      ## Root Cause Analysis

      [TO_BE_FILLED_DURING_EXECUTION]

      ## Fix Tasks

      - [ ] 1. Reproduce the issue locally
      - [ ] 2. Identify root cause
      - [ ] 3. [SPECIFIC_FIX_TASK]
      - [ ] 4. Write/update tests
      - [ ] 5. Verify fix works
      - [ ] 6. Test edge cases

      ## Acceptance Criteria

      Bug is resolved when:
      - [ ] Issue no longer reproducible
      - [ ] Root cause identified and fixed
      - [ ] Tests added to prevent regression
      - [ ] No side effects introduced
      - [ ] Original functionality restored

      ## Testing Instructions

      1. [HOW_TO_VERIFY_FIX]
      2. [ADDITIONAL_TEST_STEP]

      ## Implementation Notes

      [NOTES_ADDED_DURING_FIXING]

      ## Review Feedback

      ### Iteration 1 - [DATE]
      **Status**: [Pending/Approved/Still Broken]
      **Feedback**: [USER_FEEDBACK]

      ## Git Commits

      - [COMMIT_HASH] - [COMMIT_MESSAGE]
    </content>
  </file_template>
</for_each_bug>

<for_each_task>
  <file_template>
    <path>.agent-os/daily-plans/YYYY-MM-DD/task-[KEBAB-CASE].md</path>
    <content>
      # Task: [TASK_NAME]

      **Type**: Task
      **Priority**: [High/Medium/Low]
      **Status**: Planning | In Progress | Review | Completed | Approved
      **Created**: [TIMESTAMP]
      **Updated**: [TIMESTAMP]

      ## Description

      [DETAILED_TASK_DESCRIPTION]

      ## Objectives

      [WHAT_THIS_TASK_SHOULD_ACHIEVE]

      ## Implementation Steps

      - [ ] 1. [STEP_DESCRIPTION]
        - [ ] 1.1 [SUBSTEP]
        - [ ] 1.2 [SUBSTEP]
      - [ ] 2. [STEP_DESCRIPTION]
        - [ ] 2.1 [SUBSTEP]

      ## Acceptance Criteria

      Task is complete when:
      - [ ] [CRITERION_1]
      - [ ] [CRITERION_2]
      - [ ] All objectives met

      ## Deliverables

      - [DELIVERABLE_1]
      - [DELIVERABLE_2]

      ## Testing/Verification

      1. [HOW_TO_VERIFY]
      2. [ADDITIONAL_CHECK]

      ## Implementation Notes

      [NOTES_ADDED_DURING_EXECUTION]

      ## Review Feedback

      ### Iteration 1 - [DATE]
      **Status**: [Pending/Approved/Needs Work]
      **Feedback**: [USER_FEEDBACK]

      ## Git Commits

      - [COMMIT_HASH] - [COMMIT_MESSAGE]
    </content>
  </file_template>
</for_each_task>

</step>

<step number="7" name="priority_ordering">

### Step 7: Determine Execution Order

Analyze priorities and dependencies to suggest optimal execution order.

<ordering_criteria>
  <priority_levels>
    1. Critical bugs (blocking issues)
    2. High priority items
    3. Dependencies for other items
    4. Medium priority items
    5. Low priority items
  </priority_levels>

  <considerations>
    - Technical dependencies
    - User impact
    - Complexity (simple wins first)
    - Related items grouped
  </considerations>
</ordering_criteria>

<update_summary>
  ACTION: Update daily-summary.md with execution order
  INCLUDE: Reasoning for the suggested order
</update_summary>

</step>

<step number="8" name="user_confirmation">

### Step 8: User Confirmation

Present the created plan for review and confirmation.

<confirmation_message>
  ## Daily Plan Created Successfully

  Created daily work plan for [DATE] with:
  - [X] Features
  - [Y] Bugs
  - [Z] Tasks

  Files created in: .agent-os/daily-plans/YYYY-MM-DD/

  ### Suggested Execution Order:
  1. [ITEM_1] - [REASON]
  2. [ITEM_2] - [REASON]

  ### Next Steps:
  - Review the plan in daily-summary.md
  - Make any adjustments needed
  - Run `execute-daily-plan` to start working
  - Use `review-daily-work` after completion for feedback

  Would you like to review the plan or start execution?
</confirmation_message>

</step>

</process_flow>

## Plan Structure Standards

<file_organization>
  <naming_conventions>
    - Features: feature-[kebab-case].md
    - Bugs: bug-[kebab-case].md
    - Tasks: task-[kebab-case].md
    - Keep names concise (max 5 words)
  </naming_conventions>

  <status_tracking>
    - Planning: Initial state
    - In Progress: Being worked on
    - Review: Awaiting user review
    - Completed: Work done, not reviewed
    - Approved: User approved the work
  </status_tracking>

  <content_requirements>
    - Clear descriptions
    - Measurable acceptance criteria
    - Detailed task breakdowns
    - Space for review feedback
    - Git commit tracking
  </content_requirements>
</file_organization>

## Integration Points

<command_integration>
  <with_execute_daily_plan>
    - Reads all work items
    - Updates status during execution
    - Adds implementation notes
    - Records git commits
  </with_execute_daily_plan>

  <with_review_daily_work>
    - Presents completed work
    - Collects user feedback
    - Updates review sections
    - Marks items as approved
  </with_review_daily_work>
</command_integration>

## Error Handling

<validation>
  <required_information>
    - At least one work item
    - Basic description for each item
    - Priority/severity levels
  </required_information>

  <missing_info_handling>
    - Ask clarifying questions
    - Provide examples
    - Use sensible defaults with confirmation
  </missing_info_handling>
</validation>

<final_checklist>
  <verify>
    - [ ] All work items categorized correctly
    - [ ] Required information gathered
    - [ ] Folder structure created with correct date
    - [ ] Daily summary file created
    - [ ] Individual item files created
    - [ ] Execution order determined
    - [ ] User confirmation received
  </verify>
</final_checklist>