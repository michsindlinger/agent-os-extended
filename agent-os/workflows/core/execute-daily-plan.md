---
description: Daily Plan Execution Rules for Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Daily Plan Execution Rules

## Overview

Execute all planned daily work items autonomously, creating git commits after each completed item.

<process_flow>

<step number="1" subagent="date-checker" name="locate_daily_plan">

### Step 1: Locate Daily Plan

Use the date-checker subagent to determine current date and locate the daily plan directory.

<directory_location>
  <determine_date>
    USE: date-checker subagent
    GET: Current date in YYYY-MM-DD format
  </determine_date>

  <plan_directory>
    PATH: .agent-os/daily-plans/YYYY-MM-DD/
    VERIFY: Directory exists
    ALTERNATIVE: Ask user for specific date if needed
  </plan_directory>
</directory_location>

</step>

<step number="2" name="load_work_items">

### Step 2: Load Work Items

Read the daily summary and all individual work item files.

<file_loading>
  <summary_file>
    READ: .agent-os/daily-plans/YYYY-MM-DD/daily-summary.md
    EXTRACT: Execution order and priorities
  </summary_file>

  <work_items>
    LOAD: All feature-*.md files
    LOAD: All bug-*.md files
    LOAD: All task-*.md files
    FILTER: Exclude items with status "Approved"
  </work_items>
</file_loading>

<status_filtering>
  <include>
    - Planning
    - In Progress
    - Review (for re-work)
    - Completed (for re-work)
  </include>
  <exclude>
    - Approved (already accepted by user)
  </exclude>
</status_filtering>

</step>

<step number="3" name="execution_preparation">

### Step 3: Execution Preparation

Prepare the execution environment and confirm readiness.

<environment_check>
  <git_status>
    RUN: git status
    CHECK: Clean working directory
    HANDLE: Stash changes if needed
  </git_status>

  <branch_check>
    CHECK: Current branch
    SUGGEST: Create daily work branch if on main
    FORMAT: daily-work-YYYY-MM-DD
  </branch_check>

  <test_readiness>
    IDENTIFY: Test command from package.json or README
    PREPARE: For running tests after each item
  </test_readiness>
</environment_check>

<user_confirmation>
  MESSAGE: "Ready to execute [X] work items:
           - [Y] Features
           - [Z] Bugs
           - [W] Tasks

           Execution will proceed without interruption.
           Git commits will be created after each item.

           Continue? (yes/no)"
  WAIT: For confirmation
</user_confirmation>

</step>

<step number="4" name="execution_loop">

### Step 4: Main Execution Loop

Execute each work item in order, updating status and creating commits.

<for_each_work_item>

  <update_status_to_in_progress>
    UPDATE: Status to "In Progress" in work item file
    UPDATE: Timestamp in work item file
    UPDATE: daily-summary.md status
  </update_status_to_in_progress>

  <determine_execution_type>
    IF type == "Feature":
      EXECUTE: Feature implementation flow
    ELSE IF type == "Bug":
      EXECUTE: Bug fixing flow
    ELSE IF type == "Task":
      EXECUTE: Task completion flow
  </determine_execution_type>

  <feature_implementation_flow>
    <analyze_requirements>
      READ: Technical requirements from file
      READ: Acceptance criteria
      IDENTIFY: Files to modify/create
    </analyze_requirements>

    <implementation_loop>
      FOR each task in Implementation Tasks:
        <execute_task>
          MARK: Task as in progress
          IMPLEMENT: Task requirements
          RUN: Tests if applicable
          MARK: Task as complete
          UPDATE: Implementation Notes section
        </execute_task>
      END FOR
    </implementation_loop>

    <verify_acceptance_criteria>
      CHECK: Each acceptance criterion
      RUN: Full test suite
      VERIFY: All criteria met
    </verify_acceptance_criteria>
  </feature_implementation_flow>

  <bug_fixing_flow>
    <reproduce_issue>
      FOLLOW: Reproduction steps
      CONFIRM: Bug exists
      DOCUMENT: Observations in Root Cause Analysis
    </reproduce_issue>

    <fix_implementation>
      FOR each task in Fix Tasks:
        <execute_fix_task>
          MARK: Task as in progress
          IMPLEMENT: Fix
          TEST: Fix effectiveness
          MARK: Task as complete
          UPDATE: Implementation Notes
        </execute_fix_task>
      END FOR
    </fix_implementation>

    <verify_fix>
      FOLLOW: Testing instructions
      CONFIRM: Bug no longer reproducible
      CHECK: No regressions introduced
      RUN: Full test suite
    </verify_fix>
  </bug_fixing_flow>

  <task_completion_flow>
    <execute_steps>
      FOR each step in Implementation Steps:
        <execute_step>
          MARK: Step as in progress
          COMPLETE: Step requirements
          VERIFY: Step completion
          MARK: Step as complete
          UPDATE: Implementation Notes
        </execute_step>
      END FOR
    </execute_steps>

    <verify_deliverables>
      CHECK: Each deliverable created
      VERIFY: Acceptance criteria met
      RUN: Any applicable tests
    </verify_deliverables>
  </task_completion_flow>

  <update_work_item_file>
    UPDATE: All completed tasks/steps as checked
    UPDATE: Implementation Notes with details
    UPDATE: Status to "Completed"
    UPDATE: Updated timestamp
  </update_work_item_file>

  <create_git_commit>
    <stage_changes>
      RUN: git add -A
      VERIFY: All changes staged
    </stage_changes>

    <commit_message>
      FORMAT: "[TYPE]: [WORK_ITEM_NAME]

              [DESCRIPTION_OF_CHANGES]

              - Completed tasks: [LIST]
              - Files modified: [COUNT]
              - Tests: [PASS/FAIL STATUS]

              Ref: .agent-os/daily-plans/YYYY-MM-DD/[FILENAME]"
    </commit_message>

    <create_commit>
      RUN: git commit -m "[COMMIT_MESSAGE]"
      CAPTURE: Commit hash
      UPDATE: Work item file with commit hash
    </create_commit>
  </create_git_commit>

  <progress_notification>
    PRINT: "✓ Completed: [WORK_ITEM_NAME]
           Progress: [X]/[TOTAL] items
           Commit: [HASH]"
  </progress_notification>

</for_each_work_item>

</step>

<step number="5" subagent="test-runner" name="final_test_suite">

### Step 5: Run Final Test Suite

Use the test-runner subagent to ensure all changes work together.

<final_testing>
  ACTION: Use test-runner subagent
  REQUEST: "Run full test suite after daily work completion"
  HANDLE: Fix any integration issues
  ENSURE: All tests pass
</final_testing>

</step>

<step number="6" name="update_summary">

### Step 6: Update Daily Summary

Update the daily summary with completion status.

<summary_updates>
  <progress_tracking>
    CHECK: Planning completed ✓
    CHECK: Execution started ✓
    CHECK: All items completed [based on results]
    UPDATE: Progress checkboxes
  </progress_tracking>

  <execution_summary>
    ADD: Execution completed timestamp
    ADD: Total execution time
    ADD: Number of commits created
    ADD: Any issues encountered
  </execution_summary>
</summary_updates>

</step>

<step number="7" name="completion_report">

### Step 7: Generate Completion Report

Create a comprehensive summary of the execution.

<completion_message>
  ## Daily Plan Execution Complete

  ### Summary
  - **Date**: [YYYY-MM-DD]
  - **Items Completed**: [X]/[TOTAL]
  - **Commits Created**: [COUNT]
  - **Execution Time**: [DURATION]

  ### Completed Items:
  #### Features ([X] completed)
  - ✓ [FEATURE_NAME] - [COMMIT_HASH]

  #### Bugs ([Y] completed)
  - ✓ [BUG_NAME] - [COMMIT_HASH]

  #### Tasks ([Z] completed)
  - ✓ [TASK_NAME] - [COMMIT_HASH]

  ### Issues Encountered:
  [LIST_ANY_ISSUES_OR_NONE]

  ### Test Results:
  - Final test suite: [PASS/FAIL]
  - Test coverage: [IF_AVAILABLE]

  ### Next Steps:
  1. Review changes with `git log --oneline`
  2. Run `review-daily-work` to start review process
  3. Push changes when ready: `git push origin [BRANCH]`

  All work items have been updated with implementation notes and commit references.
</completion_message>

</step>

</process_flow>

## Execution Standards

<autonomous_operation>
  <principles>
    - Complete each item fully before moving on
    - Create atomic commits for each item
    - Update documentation in real-time
    - Handle errors gracefully
    - Maintain clean git history
  </principles>

  <quality_checks>
    - Run tests after each implementation
    - Verify acceptance criteria
    - Check for regressions
    - Ensure code quality standards
  </quality_checks>
</autonomous_operation>

## Sub-Agent Usage

<delegation_strategy>
  <specialized_tasks>
    - Use appropriate development agents for complex implementations
    - Use test-runner for comprehensive testing
    - Use git-workflow for complex git operations
    - Use debugger for troubleshooting issues
  </specialized_tasks>

  <when_to_delegate>
    - Complex feature implementations
    - Difficult bug investigations
    - Performance optimizations
    - Security-related changes
  </when_to_delegate>
</delegation_strategy>

## Error Handling

<error_strategies>
  <compilation_errors>
    - Attempt to fix automatically
    - Document error in Implementation Notes
    - Try alternative approach
    - Mark as blocked if unsolvable
  </compilation_errors>

  <test_failures>
    - Analyze failure cause
    - Attempt fix
    - Run tests again
    - Document in notes if persistent
  </test_failures>

  <blocking_issues>
    - Document thoroughly in work item
    - Continue with next item
    - Report in final summary
    - Mark item status as "Blocked"
  </blocking_issues>
</error_strategies>

## Git Commit Standards

<commit_format>
  <types>
    - feat: For features
    - fix: For bug fixes
    - task: For general tasks
    - refactor: For refactoring tasks
    - docs: For documentation tasks
  </types>

  <message_structure>
    - Type prefix
    - Clear description
    - Reference to work item
    - List of changes
  </message_structure>
</commit_format>

## Integration Points

<with_create_daily_plan>
  - Reads plan structure
  - Follows execution order
  - Updates created files
</with_create_daily_plan>

<with_review_daily_work>
  - Provides completed work
  - Includes commit references
  - Ready for review process
</with_review_daily_work>

<final_checklist>
  <verify>
    - [ ] Daily plan located and loaded
    - [ ] Work items filtered (exclude approved)
    - [ ] Execution environment prepared
    - [ ] Each item executed completely
    - [ ] Git commits created for each item
    - [ ] Tests run and passing
    - [ ] Documentation updated
    - [ ] Summary report generated
  </verify>
</final_checklist>