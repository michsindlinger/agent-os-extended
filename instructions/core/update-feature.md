---
description: Feature Update Rules for Agent OS Extended
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Feature Update Rules

## Overview

Update existing features with changes, enhancements, or bug fixes while maintaining comprehensive change history in the specs/ directory.

<pre_flight_check>
  EXECUTE: @~/.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="spec_identification">

### Step 1: Spec Identification

Use the context-fetcher subagent to identify existing spec folders in .agent-os/specs/ to locate the feature that needs updating.

<search_pattern>
  <location>.agent-os/specs/</location>
  <format>YYYY-MM-DD-spec-name</format>
  <method>list directories and present to user</method>
</search_pattern>

<user_interaction>
  IF multiple_specs_found:
    PRESENT numbered list of available specs
    WAIT for user selection
  ELSE IF single_spec_found:
    CONFIRM with user
  ELSE IF no_specs_found:
    SUGGEST using create-spec command instead
    EXIT process
</user_interaction>

</step>

<step number="2" subagent="context-fetcher" name="spec_analysis">

### Step 2: Spec Analysis

Use the context-fetcher subagent to read the selected spec's main files to understand current scope and implementation.

<required_reads>
  <spec_md>@.agent-os/specs/[SELECTED_SPEC]/spec.md</spec_md>
  <spec_lite>@.agent-os/specs/[SELECTED_SPEC]/spec-lite.md</spec_lite>
  <tasks_md>@.agent-os/specs/[SELECTED_SPEC]/tasks.md (if exists)</tasks_md>
</required_reads>

<conditional_reads>
  <changelog>@.agent-os/specs/[SELECTED_SPEC]/changelog.md (if exists)</changelog>
  <changes_folder>@.agent-os/specs/[SELECTED_SPEC]/changes/ (list contents)</changes_folder>
</conditional_reads>

<analysis_output>
  <current_scope>summarize existing feature scope</current_scope>
  <implementation_status>determine if feature is complete or in progress</implementation_status>
  <change_history>list existing changes if any</change_history>
</analysis_output>

</step>

<step number="3" subagent="context-fetcher" name="update_requirements">

### Step 3: Update Requirements Clarification

Use the context-fetcher subagent to clarify what changes are needed to the existing feature.

<clarification_areas>
  <change_type>
    - enhancement: new functionality
    - modification: change existing behavior  
    - bug_fix: fix existing issues
    - refactoring: improve code without changing behavior
  </change_type>
  <scope_impact>
    - new_features: additions to spec scope
    - modified_features: changes to existing scope items
    - removed_features: items to remove from scope
  </scope_impact>
  <technical_impact>
    - api_changes: new or modified endpoints
    - database_changes: schema modifications
    - ui_changes: interface modifications
    - dependencies: new or updated libraries
  </technical_impact>
</clarification_areas>

<decision_tree>
  IF clarification_needed:
    ASK numbered_questions
    WAIT for_user_response
  ELSE:
    PROCEED to_date_determination
</decision_tree>

</step>

<step number="4" subagent="date-checker" name="date_determination">

### Step 4: Date Determination

Use the date-checker subagent to determine the current date in YYYY-MM-DD format for change file naming.

<date_usage>
  <purpose>create timestamped change files</purpose>
  <format>YYYY-MM-DD-change-description</format>
  <storage>store date for use in subsequent steps</storage>
</date_usage>

</step>

<step number="5" subagent="file-creator" name="changes_folder_setup">

### Step 5: Changes Folder Setup

Use the file-creator subagent to ensure the changes/ directory exists within the selected spec folder.

<directory_structure>
  <target>.agent-os/specs/[SELECTED_SPEC]/changes/</target>
  <create_if_missing>true</create_if_missing>
</directory_structure>

</step>

<step number="6" subagent="file-creator" name="create_change_file">

### Step 6: Create Change File

Use the file-creator subagent to create a new change file documenting the specific update.

<file_naming>
  <format>YYYY-MM-DD-change-description.md</format>
  <description_rules>
    - max_words: 4
    - style: kebab-case  
    - descriptive: true
  </description_rules>
</file_naming>

<file_template>
  <header>
    # Feature Change: [CHANGE_TITLE]
    
    > Change: [CHANGE_DESCRIPTION]
    > Date: [CURRENT_DATE]
    > Related Spec: @.agent-os/specs/[SELECTED_SPEC]/spec.md
  </header>
  
  <required_sections>
    - Change Summary
    - Modified Scope Items
    - New Requirements (if applicable)
    - Technical Changes
    - Impact Assessment
  </required_sections>
</file_template>

<change_summary_section>
  <template>
    ## Change Summary
    
    [1-2_SENTENCE_DESCRIPTION_OF_WHAT_IS_CHANGING_AND_WHY]
  </template>
  <constraints>
    - length: 1-2 sentences
    - content: what and why
  </constraints>
</change_summary_section>

<modified_scope_section>
  <template>
    ## Modified Scope Items
    
    ### Added Features
    - [NEW_FEATURE_1] - [DESCRIPTION]
    - [NEW_FEATURE_2] - [DESCRIPTION]
    
    ### Modified Features  
    - [EXISTING_FEATURE_1] - [CHANGE_DESCRIPTION]
    
    ### Removed Features
    - [REMOVED_FEATURE_1] - [REMOVAL_REASON]
  </template>
  <conditional_subsections>
    - only include subsections that apply
    - omit empty subsections
  </conditional_subsections>
</modified_scope_section>

<new_requirements_section>
  <template>
    ## New Requirements (Conditional)
    
    [ONLY_IF_NEW_TECHNICAL_REQUIREMENTS_NEEDED]
    
    - [TECHNICAL_REQUIREMENT_1]
    - [TECHNICAL_REQUIREMENT_2]
  </template>
  <conditional_logic>
    IF change_adds_new_technical_requirements:
      INCLUDE this section
    ELSE:
      OMIT section entirely
  </conditional_logic>
</new_requirements_section>

<technical_changes_section>
  <template>
    ## Technical Changes
    
    ### API Changes (Conditional)
    - [API_MODIFICATION_1]
    
    ### Database Changes (Conditional)
    - [SCHEMA_MODIFICATION_1]
    
    ### UI/UX Changes (Conditional)
    - [INTERFACE_MODIFICATION_1]
    
    ### Dependencies (Conditional)
    - [DEPENDENCY_CHANGE_1]
  </template>
  <subsection_rules>
    - only include applicable subsections
    - omit subsections with no changes
  </subsection_rules>
</technical_changes_section>

<impact_assessment_section>
  <template>
    ## Impact Assessment
    
    ### Breaking Changes
    - [BREAKING_CHANGE_1] - [MITIGATION]
    
    ### Backward Compatibility
    - [COMPATIBILITY_CONSIDERATION_1]
    
    ### Testing Impact
    - [TEST_MODIFICATION_1]
  </template>
  <assessment_areas>
    - breaking_changes: any incompatible modifications
    - compatibility: existing functionality preservation
    - testing: required test updates
  </assessment_areas>
</impact_assessment_section>

</step>

<step number="7" subagent="file-creator" name="update_changelog">

### Step 7: Update/Create Changelog

Use the file-creator subagent to update or create changelog.md in the spec folder to track all changes chronologically.

<changelog_logic>
  IF changelog.md exists:
    PREPEND new entry to existing changelog
  ELSE:
    CREATE new changelog.md with first entry
</changelog_logic>

<changelog_template>
  <header>
    # Feature Change History
    
    > Changelog for: [SPEC_NAME]
    > Spec Location: @.agent-os/specs/[SELECTED_SPEC]/spec.md
  </header>
  
  <entry_format>
    ## [CURRENT_DATE] - [CHANGE_TITLE]
    
    **Type:** [enhancement/modification/bug_fix/refactoring]
    **Change File:** @.agent-os/specs/[SELECTED_SPEC]/changes/[CHANGE_FILE].md
    
    [BRIEF_CHANGE_SUMMARY]
    
    ### Modified Scope
    - [SCOPE_CHANGE_1]
    - [SCOPE_CHANGE_2]
  </entry_format>
</changelog_template>

<chronological_ordering>
  <rule>newest entries at top</rule>
  <format>reverse chronological order</format>
</chronological_ordering>

</step>

<step number="8" subagent="file-creator" name="create_updated_tasks">

### Step 8: Create Updated Tasks

Use the file-creator subagent to create a new tasks file specifically for the changes being implemented.

<task_file_naming>
  <format>tasks-[CURRENT_DATE].md</format>
  <purpose>separate task lists for each change</purpose>
</task_file_naming>

<task_structure>
  <focus>only tasks related to current changes</focus>
  <format>same structure as original create-spec tasks</format>
  <reference>link back to change documentation</reference>
</task_structure>

<task_template>
  <header>
    # Change Implementation Tasks
    
    > Tasks for: [CHANGE_TITLE]
    > Change Details: @.agent-os/specs/[SELECTED_SPEC]/changes/[CHANGE_FILE].md
    > Original Spec: @.agent-os/specs/[SELECTED_SPEC]/spec.md
  </header>
  
  <task_format>
    ## Tasks
    
    - [ ] 1. [MAJOR_CHANGE_TASK_1]
      - [ ] 1.1 Write tests for [MODIFIED_COMPONENT]
      - [ ] 1.2 [IMPLEMENTATION_STEP]
      - [ ] 1.3 Update existing tests if needed
      - [ ] 1.4 Verify all tests pass
    
    - [ ] 2. [MAJOR_CHANGE_TASK_2]
      - [ ] 2.1 [IMPLEMENTATION_STEP]
      - [ ] 2.2 [IMPLEMENTATION_STEP]
  </task_format>
</task_template>

<task_principles>
  <incremental>build on existing implementation</incremental>
  <test_focused>maintain TDD approach</test_focused>
  <backward_compatible>preserve existing functionality</backward_compatible>
</task_principles>

</step>

<step number="9" name="user_review">

### Step 9: User Review

Request user review of all change documentation before proceeding to implementation.

<review_request>
  I've documented the feature update:
  
  - Change Details: @.agent-os/specs/[SELECTED_SPEC]/changes/[CHANGE_FILE].md
  - Updated Changelog: @.agent-os/specs/[SELECTED_SPEC]/changelog.md  
  - Implementation Tasks: @.agent-os/specs/[SELECTED_SPEC]/tasks-[CURRENT_DATE].md
  
  Please review the changes and let me know if any modifications are needed before I begin implementation.
</review_request>

<review_outcomes>
  IF user_approves:
    PROCEED to step 10
  ELSE IF user_requests_changes:
    UPDATE documentation as needed
    REPEAT review process
  ELSE:
    WAIT for user clarification
</review_outcomes>

</step>

<step number="10" name="execution_readiness">

### Step 10: Execution Readiness Check  

Present the first change task and request confirmation to proceed with implementation.

<readiness_summary>
  <present_to_user>
    - Change summary and scope
    - First task from tasks-[CURRENT_DATE].md
    - Expected modifications to existing code
    - Integration with current implementation
  </present_to_user>
</readiness_summary>

<execution_prompt>
  PROMPT: "The feature update planning is complete. The first change task is:
  
  **Task 1:** [FIRST_CHANGE_TASK_TITLE]
  [BRIEF_DESCRIPTION_OF_TASK_1_AND_SUBTASKS]
  
  This will modify the existing [SPEC_NAME] feature. Would you like me to proceed with implementing this change?
  
  Type 'yes' to proceed with the change implementation, or let me know if you'd like to review or modify the plan first."
</execution_prompt>

<execution_flow>
  IF user_confirms_yes:
    REFERENCE: @~/.agent-os/instructions/core/execute-tasks.md
    FOCUS: Only current change tasks
    CONTEXT: Build upon existing implementation
  ELSE:
    WAIT: For user clarification or modifications
</execution_flow>

</step>

</process_flow>

## Execution Standards

<standards>
  <preserve_existing>
    - Do not break existing functionality
    - Maintain backward compatibility where possible
    - Update tests to cover changes
  </preserve_existing>
  <documentation_integrity>
    - Keep original spec.md as reference
    - Document all changes in changes/ folder
    - Maintain chronological changelog
  </documentation_integrity>
  <implementation_approach>
    - Build incrementally on existing code
    - Follow established patterns
    - Test thoroughly before completion
  </implementation_approach>
</standards>

<final_checklist>
  <verify>
    - [ ] Existing spec identified and analyzed
    - [ ] Change requirements clearly defined
    - [ ] Change file created with detailed documentation
    - [ ] Changelog updated with new entry
    - [ ] Task list created for change implementation
    - [ ] User approved all change documentation
    - [ ] Ready to proceed with incremental implementation
  </verify>
</final_checklist>