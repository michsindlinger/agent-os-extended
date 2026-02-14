---
description: Daily Work Review Rules for Specwright
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Daily Work Review Rules

## Overview

Conduct interactive review of completed daily work items with feedback collection for iterative improvement.

<process_flow>

<step number="1" subagent="date-checker" name="locate_completed_work">

### Step 1: Locate Completed Work

Use the date-checker subagent to determine current date and locate the daily plan with completed items.

<directory_location>
  <determine_date>
    USE: date-checker subagent
    GET: Current date in YYYY-MM-DD format
  </determine_date>

  <plan_directory>
    PATH: .specwright/daily-plans/YYYY-MM-DD/
    VERIFY: Directory exists
    ALTERNATIVE: Ask user for specific date if different
  </plan_directory>
</directory_location>

</step>

<step number="2" name="load_completed_items">

### Step 2: Load Completed Items

Read all work items with "Completed" status that need review.

<file_loading>
  <daily_summary>
    READ: daily-summary.md
    EXTRACT: List of all work items
  </daily_summary>

  <filter_for_review>
    LOAD: All work item files
    INCLUDE: Status = "Completed"
    EXCLUDE: Status = "Approved"
    EXCLUDE: Status = "Planning"
    ORDER: By execution order from summary
  </filter_for_review>
</file_loading>

<review_preparation>
  <for_each_item>
    EXTRACT: Implementation notes
    EXTRACT: Git commit hashes
    EXTRACT: Testing instructions
    PREPARE: Changes summary
  </for_each_item>
</review_preparation>

</step>

<step number="3" name="generate_change_summaries">

### Step 3: Generate Change Summaries

Create detailed summaries of what was done for each item.

<for_each_completed_item>
  <git_changes>
    RUN: git show [COMMIT_HASH] --stat
    EXTRACT: Files changed
    EXTRACT: Lines added/removed
    CAPTURE: Key modifications
  </git_changes>

  <implementation_summary>
    COMPILE: Completed tasks/steps
    SUMMARIZE: Technical approach
    LIST: Main changes made
    NOTE: Any deviations from plan
  </implementation_summary>

  <testing_readiness>
    IDENTIFY: How to test the changes
    PREPARE: Step-by-step testing guide
    NOTE: Any special considerations
  </testing_readiness>
</for_each_completed_item>

</step>

<step number="4" name="interactive_review_loop">

### Step 4: Interactive Review Loop

Present each completed item for review and collect feedback.

<review_introduction>
  MESSAGE: "
  ## Daily Work Review Session

  Date: [YYYY-MM-DD]
  Items to Review: [COUNT]

  I'll present each completed item with:
  - What was implemented
  - How to test it
  - Key changes made

  After each item, please provide feedback:
  - 'approved' - Work is satisfactory
  - 'needs work' - Requires changes (please specify)
  - 'skip' - Review later

  Let's begin...
  "
</review_introduction>

<for_each_item_to_review>

  <present_item>
    <header>
      ==================================================
      REVIEW ITEM [X] of [TOTAL]
      Type: [Feature/Bug/Task]
      Name: [ITEM_NAME]
      Priority: [PRIORITY/SEVERITY]
      ==================================================
    </header>

    <work_summary>
      ## What Was Done:
      [IMPLEMENTATION_SUMMARY]

      ## Technical Changes:
      - Files Modified: [COUNT]
      - Lines Added: [+COUNT]
      - Lines Removed: [-COUNT]

      ### Key Files Changed:
      - [FILE_PATH] - [WHAT_CHANGED]
      - [FILE_PATH] - [WHAT_CHANGED]

      ## Completed Tasks:
      ✓ [TASK_1]
      ✓ [TASK_2]
      ✓ [TASK_3]
    </work_summary>

    <testing_instructions>
      ## How to Test:

      [STEP_BY_STEP_TESTING_GUIDE]

      1. [SPECIFIC_TEST_STEP]
      2. [SPECIFIC_TEST_STEP]
      3. [EXPECTED_RESULT]

      ## Verification Commands:
      ```bash
      [COMMAND_TO_RUN]
      ```

      ## Expected Behavior:
      [WHAT_USER_SHOULD_SEE]
    </testing_instructions>

    <commit_reference>
      ## Git Commit:
      Hash: [COMMIT_HASH]
      Message: [COMMIT_MESSAGE]

      View changes: `git show [COMMIT_HASH]`
      Diff from main: `git diff main..HEAD -- [RELEVANT_FILES]`
    </commit_reference>

    <notes_and_issues>
      ## Implementation Notes:
      [ANY_SPECIAL_NOTES]

      ## Known Limitations:
      [IF_APPLICABLE]

      ## Potential Improvements:
      [IF_IDENTIFIED]
    </notes_and_issues>
  </present_item>

  <collect_feedback>
    PROMPT: "
    --------------------------------------------------
    Please review and test the above implementation.

    Enter your feedback:
    - 'approved' - Implementation is satisfactory
    - 'needs work: [details]' - Specify what needs fixing
    - 'skip' - Will review later

    Your feedback: "

    WAIT: For user input
    PARSE: User response
  </collect_feedback>

  <process_feedback>
    IF feedback == "approved":
      <mark_approved>
        UPDATE: Item status to "Approved"
        UPDATE: Review feedback section with approval
        ADD: Approval timestamp
        ADD: "✓ APPROVED" to item title
      </mark_approved>

    ELSE IF feedback.startsWith("needs work"):
      <mark_needs_work>
        UPDATE: Item status to "Review"
        UPDATE: Review feedback with specific issues
        ADD: Feedback timestamp
        PARSE: Required changes from feedback
        CREATE: List of required fixes
        ADD: "⚠️ NEEDS WORK" to item title
      </mark_needs_work>

    ELSE IF feedback == "skip":
      <defer_review>
        MAINTAIN: Status as "Completed"
        NOTE: Skipped in review feedback
        ADD: "⏸️ REVIEW PENDING" to item title
      </defer_review>
  </process_feedback>

  <update_work_item_file>
    <review_section>
      ## Review Feedback

      ### Iteration [X] - [CURRENT_DATE_TIME]
      **Status**: [Approved/Needs Work/Skipped]
      **Reviewer Feedback**:
      [USER_FEEDBACK_TEXT]

      [IF_NEEDS_WORK]
      **Required Changes**:
      - [ ] [CHANGE_1]
      - [ ] [CHANGE_2]

      **Next Steps**: Re-run /execute-tasks to address feedback
    </review_section>
  </update_work_item_file>

  <progress_update>
    MESSAGE: "
    ✓ Review recorded for: [ITEM_NAME]
    Status: [NEW_STATUS]
    Progress: [X]/[TOTAL] items reviewed
    "
  </progress_update>

</for_each_item_to_review>

</step>

<step number="5" name="review_summary">

### Step 5: Generate Review Summary

Create a comprehensive summary of the review session.

<summary_statistics>
  <count_items>
    TOTAL: All reviewed items
    APPROVED: Count of approved items
    NEEDS_WORK: Count of items needing changes
    SKIPPED: Count of skipped items
  </count_items>

  <calculate_progress>
    COMPLETION_RATE: Approved / Total * 100
    ITERATION_NEEDED: Items needing work > 0
  </calculate_progress>
</summary_statistics>

<update_daily_summary>
  <add_review_section>
    ## Review Session - [TIMESTAMP]

    ### Review Results:
    - ✅ Approved: [COUNT] items
    - ⚠️ Needs Work: [COUNT] items
    - ⏸️ Skipped: [COUNT] items

    ### Approved Items:
    - [ITEM_NAME] - [TYPE]

    ### Items Requiring Changes:
    - [ITEM_NAME] - [SUMMARY_OF_REQUIRED_CHANGES]

    ### Next Iteration Required: [YES/NO]
  </add_review_section>

  <update_progress_tracking>
    - [x] Review conducted
    - [ ] Iterations completed (if needed)
  </update_progress_tracking>
</update_daily_summary>

</step>

<step number="6" name="prepare_next_iteration">

### Step 6: Prepare Next Iteration (If Needed)

Set up for the next execution cycle if items need work.

<iteration_preparation>
  IF items_need_work > 0:
    <create_iteration_plan>
      <identify_rework_items>
        LIST: All items with status "Review"
        EXTRACT: Required changes for each
        PRIORITIZE: Based on dependencies
      </identify_rework_items>

      <update_work_files>
        <for_each_rework_item>
          RESET: Incomplete tasks to unchecked
          ADD: New tasks for required changes
          UPDATE: Priority if needed
          CLEAR: Old implementation notes
        </for_each_rework_item>
      </update_work_files>

      <iteration_instructions>
        MESSAGE: "
        ## Next Iteration Prepared

        Items requiring work: [COUNT]

        ### Items to Address:
        1. [ITEM_NAME]
           - [REQUIRED_CHANGE_1]
           - [REQUIRED_CHANGE_2]

        ### Next Steps:
        1. Run `/execute-tasks` to address feedback
        2. The command will skip approved items automatically
        3. After completion, run `review-daily-work` again

        Ready to start next iteration? Run: /execute-tasks
        "
      </iteration_instructions>
    </create_iteration_plan>

  ELSE:
    <all_items_approved>
      MESSAGE: "
      ## All Items Approved! 🎉

      Daily work for [DATE] is complete and approved.

      ### Summary:
      - Total Items: [COUNT]
      - All Approved: ✅
      - Commits Created: [COUNT]

      ### Next Steps:
      1. Push changes: `git push origin [BRANCH]`
      2. Create PR if needed
      3. Plan tomorrow's work with `create-daily-plan`

      Great work today!
      "
    </all_items_approved>
</iteration_preparation>

</step>

<step number="7" name="final_documentation">

### Step 7: Update Final Documentation

Ensure all documentation is complete and accurate.

<documentation_updates>
  <verify_all_files>
    CHECK: All work item files updated
    CHECK: Review feedback recorded
    CHECK: Status accurately reflected
    CHECK: Timestamps updated
  </verify_all_files>

  <git_log_reference>
    CREATE: List of all commits from session
    SAVE: In daily-summary.md
    FORMAT: Chronological order
  </git_log_reference>

  <archive_if_complete>
    IF all_approved AND user_confirms:
      SUGGEST: Archive or tag the work
      CREATE: Summary for changelog
      PREPARE: For integration
  </archive_if_complete>
</documentation_updates>

</step>

</process_flow>

## Review Standards

<feedback_handling>
  <approved_criteria>
    - Functionality works as expected
    - Tests pass
    - No regressions
    - Meets acceptance criteria
    - Code quality acceptable
  </approved_criteria>

  <needs_work_triggers>
    - Bugs found during testing
    - Missing functionality
    - Performance issues
    - Code quality concerns
    - Incomplete implementation
  </needs_work_triggers>

  <feedback_format>
    - Be specific about issues
    - Include reproduction steps
    - Suggest improvements
    - Prioritize critical issues
  </feedback_format>
</feedback_handling>

## Iteration Management

<iteration_rules>
  <skip_approved>
    - Never re-execute approved items
    - Preserve their completed state
    - Maintain git history
  </skip_approved>

  <track_iterations>
    - Number each iteration
    - Record feedback history
    - Show progression
    - Maintain context
  </track_iterations>

  <convergence>
    - Each iteration should reduce work
    - Focus on addressing feedback
    - Aim for full approval
    - Document learnings
  </convergence>
</iteration_rules>

## Integration Points

<with_create_daily_plan>
  - Uses created structure
  - Reads item definitions
  - Updates status fields
</with_create_daily_plan>

<with_execute_daily_plan>
  - Reviews execution results
  - Uses commit references
  - Processes implementation notes
  - Triggers re-execution if needed
</with_execute_daily_plan>

## Error Handling

<review_issues>
  <missing_commits>
    CHECK: Git log for changes
    IDENTIFY: Uncommitted work
    SUGGEST: Creating commits
  </missing_commits>

  <unclear_testing>
    PROVIDE: Generic test steps
    ASK: For specific scenarios
    DOCUMENT: For future reference
  </unclear_testing>

  <user_unavailable>
    SAVE: Review progress
    ALLOW: Resume later
    MAINTAIN: State consistency
  </user_unavailable>
</review_issues>

<final_checklist>
  <verify>
    - [ ] All completed items reviewed
    - [ ] Feedback collected and recorded
    - [ ] Status updated appropriately
    - [ ] Review summary generated
    - [ ] Next iteration prepared (if needed)
    - [ ] Documentation updated
    - [ ] User informed of next steps
  </verify>
</final_checklist>