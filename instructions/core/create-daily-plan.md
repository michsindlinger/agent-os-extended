---
description: Daily Plan Creation Rules for Agent OS
globs:
alwaysApply: false
version: 1.2
encoding: UTF-8
---

# Daily Plan Creation Rules

## Overview

Create or append to a structured daily work plan with features, bugs, and tasks for systematic execution and tracking. Includes interactive plan review before file creation and supports adding items to existing daily plans.

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

<step number="3" name="interactive_plan_review">

### Step 3: Interactive Plan Review

Present implementation approach for each work item and collect feedback BEFORE creating files.

<review_introduction>
  MESSAGE: "
  I will now present my implementation approach for each work item.
  You can approve, adjust, or skip items before I create the documentation.

  Let's review each item:
  "
</review_introduction>

<for_each_work_item>
  <present_plan>
    <header>
      ========================================
      Work Item [X] of [TOTAL]
      Type: [Feature/Bug/Task]
      Name: [ITEM_NAME]
      Priority/Severity: [LEVEL]
      ========================================
    </header>

    <implementation_approach>
      ## Proposed Implementation Approach:

      ### Overview:
      [2-3 sentences describing how I plan to approach this item]

      ### Key Implementation Steps:
      1. [MAJOR_STEP_1]
         - [Brief explanation of why this step is needed]
      2. [MAJOR_STEP_2]
         - [Brief explanation of why this step is needed]
      3. [MAJOR_STEP_3]
         - [Brief explanation of why this step is needed]
      [Additional steps as needed]

      ### Technical Considerations:
      - [TECHNICAL_ASPECT_1]: [How it will be handled]
      - [TECHNICAL_ASPECT_2]: [How it will be handled]
      [Additional considerations as relevant]

      ### Estimated Complexity:
      [Simple/Medium/Complex] - [1-2 sentence justification]

      ### Potential Challenges:
      - [CHALLENGE_1]: [Mitigation approach]
      - [CHALLENGE_2]: [Mitigation approach]
      [If no significant challenges expected, state that]

      ### Success Criteria:
      - [KEY_CRITERION_1]
      - [KEY_CRITERION_2]
      [Main indicators that the item is complete]
    </implementation_approach>

    <feedback_prompt>
      ----------------------------------------
      Please review this approach:

      - Type 'ok' or 'approve' to confirm this plan
      - Provide specific feedback to adjust the approach
      - Type 'skip' to exclude this item from today's plan
      - Type 'simplify' for a simpler approach
      - Type 'expand' for more detailed planning

      Your feedback:
      ----------------------------------------
    </feedback_prompt>
  </present_plan>

  <collect_and_process_feedback>
    WAIT: For user response

    IF response == "ok" OR response == "approve":
      <approve_plan>
        STORE: Plan as approved with current approach
        ADD: To approved items list
        MESSAGE: "✓ Plan approved for: [ITEM_NAME]"
        PROCEED: To next item
      </approve_plan>

    ELSE IF response == "skip":
      <skip_item>
        EXCLUDE: Item from daily plan
        ADD: To skipped items list
        MESSAGE: "⊘ Skipped: [ITEM_NAME]"
        NOTE: Reason if provided
        PROCEED: To next item
      </skip_item>

    ELSE IF response == "simplify":
      <simplify_approach>
        REDUCE: Number of steps
        FOCUS: On core requirements only
        REMOVE: Nice-to-have features
        PRESENT: Simplified plan
        REPEAT: Review process
      </simplify_approach>

    ELSE IF response == "expand":
      <expand_approach>
        ADD: More detailed subtasks
        INCLUDE: Edge cases and testing
        ELABORATE: Technical implementation
        PRESENT: Expanded plan
        REPEAT: Review process
      </expand_approach>

    ELSE:
      <integrate_feedback>
        PARSE: User feedback
        IDENTIFY: Specific changes requested
        ADJUST: Implementation approach accordingly
        UPDATE: Steps, considerations, or criteria
        PRESENT: Updated plan with changes highlighted
        MESSAGE: "I've adjusted the plan based on your feedback:"
        SHOW: What changed
        REPEAT: Review process until approved or skipped
      </integrate_feedback>
  </collect_and_process_feedback>

  <store_approved_plan>
    IF approved:
      SAVE: Final approach with all adjustments
      INCLUDE: User feedback integration
      MARK: As reviewed and approved
      PREPARE: For documentation generation
  </store_approved_plan>
</for_each_work_item>

<review_summary>
  <after_all_items>
    MESSAGE: "
    ## Plan Review Complete!

    Summary:
    - Approved items: [X] ([LIST_NAMES])
    - Skipped items: [Y] ([LIST_NAMES])
    - Total for today: [X] items

    [IF any_items_skipped]
    Skipped items can be reconsidered for future daily plans.

    [IF all_items_approved]
    All items have been approved with implementation approaches.

    Proceeding to create documentation for approved items...
    "
  </after_all_items>
</review_summary>

</step>

<step number="4" subagent="date-checker" name="date_determination">

### Step 4: Date Determination

Use the date-checker subagent to determine the current date for folder naming.

<subagent_instructions>
  ACTION: Use date-checker subagent
  PURPOSE: Get current date in YYYY-MM-DD format
  STORE: Date for folder creation
</subagent_instructions>

</step>

<step number="5" name="check_existing_plan">

### Step 5: Check for Existing Daily Plan

Check if a daily plan already exists for today and load existing items if present.

<existing_plan_check>
  <check_directory>
    PATH: .agent-os/daily-plans/YYYY-MM-DD/
    CHECK: Does directory exist?
  </check_directory>

  IF directory_exists:
    <load_existing_items>
      <load_summary>
        READ: .agent-os/daily-plans/YYYY-MM-DD/daily-summary.md
        EXTRACT: Existing work items
        COUNT: Existing features, bugs, tasks
      </load_summary>

      <load_individual_files>
        READ: All existing feature-*.md files
        READ: All existing bug-*.md files
        READ: All existing task-*.md files
        STORE: Existing items for reference
      </load_individual_files>

      <inform_user>
        MESSAGE: "
        Found existing daily plan for [DATE] with:
        - [X] existing features
        - [Y] existing bugs
        - [Z] existing tasks

        I will add your new items to the existing plan.
        "
      </inform_user>

      <check_duplicates>
        FOR each new approved item:
          CHECK: Does similar item already exist?
          IF duplicate found:
            ASK: "Item '[NAME]' seems similar to existing '[EXISTING]'.
                  Add as new item anyway? (yes/skip)"
            WAIT: For user response
          END IF
        END FOR
      </check_duplicates>
    </load_existing_items>

    SET: append_mode = true
    SET: next_item_numbers based on existing counts

  ELSE:
    <create_new_plan>
      MESSAGE: "Creating new daily plan for [DATE]"
      SET: append_mode = false
      SET: next_item_numbers start at 1
    </create_new_plan>
  END IF
</existing_plan_check>

</step>

<step number="6" subagent="file-creator" name="folder_structure_creation">

### Step 6: Create or Verify Folder Structure

Use the file-creator subagent to create the daily plan directory structure if it doesn't exist.

<directory_structure>
  <base_path>.agent-os/daily-plans/YYYY-MM-DD/</base_path>
  <naming>
    - Use date from step 4
    - Create parent directory if needed
  </naming>
  <condition>
    IF append_mode == false:
      CREATE: New directory structure
    ELSE:
      VERIFY: Directory exists
      SKIP: Creation (already exists)
  </condition>
</directory_structure>

</step>

<step number="7" name="create_or_update_daily_summary">

### Step 7: Create or Update Daily Summary

Create new or update existing summary file with approved items.

<summary_handling>
  IF append_mode == true:
    <update_existing_summary>
      READ: Existing daily-summary.md
      PRESERVE:
        - Existing work items
        - Existing progress tracking
        - Previous planning notes

      <merge_items>
        <features>
          APPEND: New approved features to existing list
          RENUMBER: Starting from [existing_count + 1]
          UPDATE: Total count in section header
        </features>

        <bugs>
          APPEND: New approved bugs to existing list
          RENUMBER: Starting from [existing_count + 1]
          UPDATE: Total count in section header
        </bugs>

        <tasks>
          APPEND: New approved tasks to existing list
          RENUMBER: Starting from [existing_count + 1]
          UPDATE: Total count in section header
        </tasks>
      </merge_items>

      <update_execution_order>
        PRESERVE: Existing execution order for old items
        APPEND: New items to execution order
        RECALCULATE: Priorities considering all items
        SUGGEST: Revised order if needed
      </update_execution_order>

      <add_update_note>
        ADD: Update timestamp and note about new items
        FORMAT: "## Update - [TIMESTAMP]
                Added [X] new items to the daily plan"
      </add_update_note>
    </update_existing_summary>

  ELSE:
    <create_new_summary>
      <file_template>
        <path>.agent-os/daily-plans/YYYY-MM-DD/daily-summary.md</path>
        <content>
          # Daily Work Plan

          > Date: [YYYY-MM-DD]
          > Created: [TIMESTAMP]
          > Status: Planning | In Progress | Review | Completed

          ## Overview

          Daily objectives and work items for systematic execution.
          [INCLUDE: Brief note about user-reviewed approach]

          ## Work Items

          [ONLY INCLUDE SECTIONS WITH APPROVED ITEMS]

          ### Features ([X] items)
          [FOR EACH APPROVED FEATURE]
          1. **[FEATURE_NAME]** - [STATUS] - Priority: [HIGH/MEDIUM/LOW]
             - File: feature-[KEBAB-CASE].md
             - Description: [ONE_LINE_SUMMARY]
             - Approach: [BRIEF_APPROVED_APPROACH]

          ### Bugs ([Y] items)
          [FOR EACH APPROVED BUG]
          1. **[BUG_TITLE]** - [STATUS] - Severity: [CRITICAL/HIGH/MEDIUM/LOW]
             - File: bug-[KEBAB-CASE].md
             - Description: [ONE_LINE_SUMMARY]
             - Approach: [BRIEF_APPROVED_APPROACH]

          ### Tasks ([Z] items)
          [FOR EACH APPROVED TASK]
          1. **[TASK_NAME]** - [STATUS] - Priority: [HIGH/MEDIUM/LOW]
             - File: task-[KEBAB-CASE].md
             - Description: [ONE_LINE_SUMMARY]
             - Approach: [BRIEF_APPROVED_APPROACH]

          ## Execution Order

          Recommended order based on priority and dependencies:
          [ONLY APPROVED ITEMS]
          1. [ITEM_NAME] - [TYPE] - [REASON_FOR_ORDER]
          2. [ITEM_NAME] - [TYPE] - [REASON_FOR_ORDER]

          ## Progress Tracking

          - [x] Planning completed
          - [ ] Execution started
          - [ ] All items completed
          - [ ] Review conducted
          - [ ] Iterations completed

          ## Planning Notes

          [INCLUDE: Any significant feedback or adjustments from review]
          [IF items_skipped: Note which items were skipped and why]
        </content>
      </file_template>
    </create_new_summary>
  END IF
</summary_handling>

</step>

<step number="8" subagent="file-creator" name="create_individual_items">

### Step 8: Create Individual Work Item Files

Use the file-creator subagent to create detailed files for each NEW APPROVED work item, incorporating the reviewed approach.

<item_file_creation>
  <naming_strategy>
    IF append_mode == true:
      <avoid_duplicates>
        FOR each new item:
          CHECK: Does file with same kebab-case name exist?
          IF exists:
            APPEND: Number suffix to filename
            EXAMPLE: feature-dark-mode-2.md
          ELSE:
            USE: Standard name
          END IF
        END FOR
      </avoid_duplicates>
    ELSE:
      USE: Standard naming without checks
    END IF
  </naming_strategy>

  <skip_existing>
    NOTE: Only create files for NEW approved items
    SKIP: Any items that already existed before this session
  </skip_existing>
</item_file_creation>

<for_each_approved_feature>
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

      ## Approved Implementation Approach

      [USER_REVIEWED_AND_APPROVED_APPROACH]

      ### Key Steps:
      [APPROVED_IMPLEMENTATION_STEPS]

      ### Technical Considerations:
      [APPROVED_TECHNICAL_ASPECTS]

      ## Objectives

      [WHAT_THIS_FEATURE_SHOULD_ACHIEVE]

      ## Technical Requirements

      - [REQUIREMENT_1_FROM_APPROVED_PLAN]
      - [REQUIREMENT_2_FROM_APPROVED_PLAN]

      ## Implementation Tasks

      [BASED ON APPROVED APPROACH]
      - [ ] 1. [TASK_DESCRIPTION]
        - [ ] 1.1 [SUBTASK]
        - [ ] 1.2 [SUBTASK]
      - [ ] 2. [TASK_DESCRIPTION]
        - [ ] 2.1 [SUBTASK]
        - [ ] 2.2 [SUBTASK]

      ## Acceptance Criteria

      Feature is complete when:
      [FROM APPROVED SUCCESS CRITERIA]
      - [ ] [CRITERION_1]
      - [ ] [CRITERION_2]
      - [ ] All tests pass
      - [ ] Code is documented
      - [ ] User can [SPECIFIC_ACTION]

      ## Testing Instructions

      1. [STEP_TO_TEST]
      2. [STEP_TO_TEST]

      ## Planning Review Notes

      [USER_FEEDBACK_DURING_PLANNING_IF_ANY]

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
</for_each_approved_feature>

<for_each_approved_bug>
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

      ## Approved Fix Approach

      [USER_REVIEWED_AND_APPROVED_APPROACH]

      ### Key Steps:
      [APPROVED_FIX_STEPS]

      ### Technical Considerations:
      [APPROVED_TECHNICAL_ASPECTS]

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

      [BASED ON APPROVED APPROACH]
      - [ ] 1. Reproduce the issue locally
      - [ ] 2. Identify root cause
      - [ ] 3. [SPECIFIC_FIX_TASK_FROM_PLAN]
      - [ ] 4. Write/update tests
      - [ ] 5. Verify fix works
      - [ ] 6. Test edge cases

      ## Acceptance Criteria

      Bug is resolved when:
      [FROM APPROVED SUCCESS CRITERIA]
      - [ ] Issue no longer reproducible
      - [ ] Root cause identified and fixed
      - [ ] Tests added to prevent regression
      - [ ] No side effects introduced
      - [ ] Original functionality restored

      ## Testing Instructions

      1. [HOW_TO_VERIFY_FIX]
      2. [ADDITIONAL_TEST_STEP]

      ## Planning Review Notes

      [USER_FEEDBACK_DURING_PLANNING_IF_ANY]

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
</for_each_approved_bug>

<for_each_approved_task>
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

      ## Approved Implementation Approach

      [USER_REVIEWED_AND_APPROVED_APPROACH]

      ### Key Steps:
      [APPROVED_IMPLEMENTATION_STEPS]

      ### Technical Considerations:
      [APPROVED_TECHNICAL_ASPECTS]

      ## Objectives

      [WHAT_THIS_TASK_SHOULD_ACHIEVE]

      ## Implementation Steps

      [BASED ON APPROVED APPROACH]
      - [ ] 1. [STEP_DESCRIPTION]
        - [ ] 1.1 [SUBSTEP]
        - [ ] 1.2 [SUBSTEP]
      - [ ] 2. [STEP_DESCRIPTION]
        - [ ] 2.1 [SUBSTEP]

      ## Acceptance Criteria

      Task is complete when:
      [FROM APPROVED SUCCESS CRITERIA]
      - [ ] [CRITERION_1]
      - [ ] [CRITERION_2]
      - [ ] All objectives met

      ## Deliverables

      - [DELIVERABLE_1]
      - [DELIVERABLE_2]

      ## Testing/Verification

      1. [HOW_TO_VERIFY]
      2. [ADDITIONAL_CHECK]

      ## Planning Review Notes

      [USER_FEEDBACK_DURING_PLANNING_IF_ANY]

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
</for_each_approved_task>

</step>

<step number="9" name="priority_ordering">

### Step 9: Determine Execution Order

Analyze priorities and dependencies to suggest optimal execution order for all items (existing + new).

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
    - User feedback from review
    - Balance between old and new items
  </considerations>

  <append_mode_handling>
    IF append_mode == true:
      CONSIDER: Existing items' progress status
      PRIORITIZE: In-progress items before new items
      SUGGEST: Integrating new items naturally into workflow
    ELSE:
      STANDARD: Order all items by priority
    END IF
  </append_mode_handling>
</ordering_criteria>

<update_summary>
  ACTION: Update daily-summary.md with execution order
  INCLUDE: Reasoning for the suggested order
  NOTE: Includes ALL approved items (existing + new)
</update_summary>

</step>

<step number="10" name="user_confirmation">

### Step 10: Final Confirmation

Present the created or updated plan for final review.

<confirmation_message>
  IF append_mode == true:
    ## Daily Plan Updated Successfully

    Updated daily work plan for [DATE]:

    ### Previous Items:
    - [X] Features (existing)
    - [Y] Bugs (existing)
    - [Z] Tasks (existing)

    ### Newly Added:
    - [A] Features (new)
    - [B] Bugs (new)
    - [C] Tasks (new)
    [IF any_skipped: - [N] Items skipped during review]

    ### Total Items Now:
    - [X+A] Features
    - [Y+B] Bugs
    - [Z+C] Tasks

    Files updated/created in: .agent-os/daily-plans/YYYY-MM-DD/

    ### Implementation Approaches:
    All new items include your reviewed and approved implementation plans.

    ### Updated Execution Order:
    [SHOW integrated order with existing and new items]
    1. [ITEM_1] - [STATUS] - [REASON]
    2. [ITEM_2] - [STATUS] - [REASON]

    ### Next Steps:
    - Continue with `execute-daily-plan` to work on all items
    - Items already in progress will be prioritized
    - Use `review-daily-work` after completion for feedback

  ELSE:
    ## Daily Plan Created Successfully

    Created daily work plan for [DATE] with:
    - [X] Features (approved)
    - [Y] Bugs (approved)
    - [Z] Tasks (approved)
    [IF any_skipped: - [N] Items skipped during review]

    Files created in: .agent-os/daily-plans/YYYY-MM-DD/

    ### Implementation Approaches:
    All items include your reviewed and approved implementation plans.

    ### Suggested Execution Order:
    1. [ITEM_1] - [REASON]
    2. [ITEM_2] - [REASON]

    ### Next Steps:
    - Review the detailed plans in the created files
    - Make any final adjustments if needed
    - Run `execute-daily-plan` to start working
    - Use `review-daily-work` after completion for feedback

  END IF

  Ready to [continue/start] execution with `execute-daily-plan`?
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
    - User-reviewed approaches
    - Measurable acceptance criteria
    - Detailed task breakdowns
    - Space for review feedback
    - Git commit tracking
  </content_requirements>
</file_organization>

## Integration Points

<command_integration>
  <with_execute_daily_plan>
    - Reads approved work items
    - Follows reviewed approaches
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

  <no_approved_items>
    IF all items skipped:
      MESSAGE: "No items were approved for today's plan.
               You can run this command again with different items."
      EXIT: Without creating files
  </no_approved_items>
</validation>

<final_checklist>
  <verify>
    - [ ] All work items categorized correctly
    - [ ] Required information gathered
    - [ ] Interactive review completed for each item
    - [ ] User feedback integrated into plans
    - [ ] Existing plan checked and loaded if present
    - [ ] Duplicates identified and handled
    - [ ] Only approved items included in files
    - [ ] Folder structure created/verified with correct date
    - [ ] Daily summary file created or updated
    - [ ] Individual item files created for new items only
    - [ ] File naming conflicts resolved
    - [ ] Execution order determined for all items
    - [ ] User confirmation received
  </verify>
</final_checklist>