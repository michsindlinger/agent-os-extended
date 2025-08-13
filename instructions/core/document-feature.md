---
description: Feature Documentation Rules for Agent OS Extended
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Feature Documentation Rules

## Overview

Create comprehensive user-facing documentation for completed features in the hierarchical docs/ structure, transforming development specs into application documentation.

<pre_flight_check>
  EXECUTE: @~/.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="spec_selection">

### Step 1: Completed Spec Selection

Use the context-fetcher subagent to identify completed specs in .agent-os/specs/ that are ready for user documentation.

<selection_criteria>
  <completion_indicators>
    - tasks.md with all items completed
    - implementation finished
    - testing completed
    - user confirmation of completion
  </completion_indicators>
  <documentation_status>
    - not yet documented in docs/ structure
    - existing docs/ entry that needs updating
  </documentation_status>
</selection_criteria>

<user_interaction>
  IF multiple_completed_specs:
    PRESENT numbered list of completed specs
    WAIT for user selection
  ELSE IF single_completed_spec:
    CONFIRM with user
  ELSE IF no_completed_specs:
    SUGGEST completing implementation first
    EXIT process
</user_interaction>

</step>

<step number="2" subagent="context-fetcher" name="spec_analysis">

### Step 2: Spec Analysis

Use the context-fetcher subagent to thoroughly analyze the selected completed spec and any related changes.

<required_reads>
  <spec_files>
    - @.agent-os/specs/[SELECTED_SPEC]/spec.md
    - @.agent-os/specs/[SELECTED_SPEC]/spec-lite.md
    - @.agent-os/specs/[SELECTED_SPEC]/sub-specs/technical-spec.md (if exists)
  </spec_files>
  <change_history>
    - @.agent-os/specs/[SELECTED_SPEC]/changelog.md (if exists)
    - @.agent-os/specs/[SELECTED_SPEC]/changes/*.md (all change files)
  </change_history>
  <implementation_status>
    - @.agent-os/specs/[SELECTED_SPEC]/tasks.md
    - @.agent-os/specs/[SELECTED_SPEC]/tasks-*.md (any dated task files)
  </implementation_status>
</required_reads>

<analysis_output>
  <feature_summary>synthesize complete feature description</feature_summary>
  <user_benefits>identify end-user value proposition</user_benefits>
  <functionality_scope>determine all implemented capabilities</functionality_scope>
  <sub_features>identify logical feature groupings</sub_features>
</analysis_output>

</step>

<step number="3" subagent="context-fetcher" name="documentation_structure_planning">

### Step 3: Documentation Structure Planning

Use the context-fetcher subagent to determine optimal documentation structure based on feature complexity and scope.

<structure_decision_tree>
  IF feature_has_multiple_distinct_capabilities:
    PLAN hierarchical structure with sub-features
    CREATE main feature.md + sub-features/ folder
  ELSE IF feature_is_cohesive_single_capability:
    PLAN single document structure
    CREATE single feature.md
  ELSE IF feature_extends_existing_documented_feature:
    PLAN update to existing documentation
    UPDATE existing docs/ structure
</structure_decision_tree>

<folder_naming>
  <main_feature>
    - format: Feature-Name (PascalCase with hyphens)
    - location: .agent-os/docs/Feature-Name/
    - main_file: feature.md
  </main_feature>
  <sub_features>
    - location: .agent-os/docs/Feature-Name/sub-features/
    - format: sub-feature-name.md (kebab-case)
    - purpose: specific functionality within main feature
  </sub_features>
</folder_naming>

<naming_examples>
  <single_feature>
    .agent-os/docs/Password-Reset/feature.md
  </single_feature>
  <hierarchical_feature>
    .agent-os/docs/User-Management/feature.md
    .agent-os/docs/User-Management/sub-features/registration.md
    .agent-os/docs/User-Management/sub-features/profile-editing.md
    .agent-os/docs/User-Management/sub-features/account-deletion.md
  </hierarchical_feature>
</naming_examples>

</step>

<step number="4" subagent="file-creator" name="docs_structure_creation">

### Step 4: Documentation Structure Creation

Use the file-creator subagent to create the necessary directory structure in .agent-os/docs/.

<directory_creation>
  <main_folder>.agent-os/docs/[FEATURE_NAME]/</main_folder>
  <sub_folder>.agent-os/docs/[FEATURE_NAME]/sub-features/ (if needed)</sub_folder>
</directory_creation>

<creation_logic>
  IF hierarchical_structure_planned:
    CREATE main folder AND sub-features folder
  ELSE:
    CREATE only main folder
</creation_logic>

</step>

<step number="5" subagent="file-creator" name="main_feature_documentation">

### Step 5: Main Feature Documentation

Use the file-creator subagent to create the primary feature.md file with comprehensive user-facing documentation.

<file_template>
  <header>
    # [FEATURE_NAME]
    
    > Feature Documentation
    > Last Updated: [CURRENT_DATE]
    > Implementation: Completed
  </header>
  
  <required_sections>
    - Overview
    - What This Feature Does
    - How to Use
    - Key Benefits
    - Related Features (if applicable)
    - Technical Notes (if relevant to users)
  </required_sections>
</file_template>

<overview_section>
  <template>
    ## Overview
    
    [USER_FOCUSED_DESCRIPTION_OF_FEATURE_PURPOSE_AND_VALUE]
    
    This feature was implemented to [PRIMARY_USER_BENEFIT] and [SECONDARY_BENEFITS].
  </template>
  <writing_style>
    - audience: end users, not developers
    - tone: clear and helpful
    - focus: what the user gains
  </writing_style>
</overview_section>

<what_this_feature_does_section>
  <template>
    ## What This Feature Does
    
    ### Core Functionality
    - [PRIMARY_CAPABILITY_1]: [USER_IMPACT]
    - [PRIMARY_CAPABILITY_2]: [USER_IMPACT]
    
    ### Additional Capabilities
    - [SECONDARY_CAPABILITY_1]: [USER_BENEFIT]
    - [SECONDARY_CAPABILITY_2]: [USER_BENEFIT]
  </template>
  <content_focus>
    - user-visible functionality
    - practical capabilities
    - real-world applications
  </content_focus>
</what_this_feature_does_section>

<how_to_use_section>
  <template>
    ## How to Use
    
    ### Getting Started
    1. [FIRST_STEP_FOR_USER]
    2. [SECOND_STEP_FOR_USER]
    3. [THIRD_STEP_FOR_USER]
    
    ### Step-by-Step Guide
    
    #### [USE_CASE_1]
    1. Navigate to [LOCATION/UI_ELEMENT]
    2. [ACTION_TO_TAKE]
    3. [EXPECTED_RESULT]
    
    #### [USE_CASE_2]
    1. [STEP_1]
    2. [STEP_2]
    3. [EXPECTED_OUTCOME]
  </template>
  <instruction_quality>
    - concrete steps
    - clear outcomes
    - realistic scenarios
  </instruction_quality>
</how_to_use_section>

<key_benefits_section>
  <template>
    ## Key Benefits
    
    ### For Users
    - **[BENEFIT_1]**: [EXPLANATION_OF_VALUE]
    - **[BENEFIT_2]**: [EXPLANATION_OF_VALUE]
    
    ### For Organizations
    - **[ORGANIZATIONAL_BENEFIT_1]**: [BUSINESS_VALUE]
    - **[ORGANIZATIONAL_BENEFIT_2]**: [EFFICIENCY_GAIN]
  </template>
  <benefit_categories>
    - user_experience: direct user advantages
    - efficiency: time and effort savings
    - business_value: organizational benefits
  </benefit_categories>
</key_benefits_section>

<related_features_section>
  <template>
    ## Related Features (Conditional)
    
    [ONLY_IF_FEATURE_INTEGRATES_WITH_OTHER_FEATURES]
    
    This feature works together with:
    - **[RELATED_FEATURE_1]**: [HOW_THEY_WORK_TOGETHER]
    - **[RELATED_FEATURE_2]**: [INTEGRATION_BENEFIT]
    
    See also: @.agent-os/docs/[RELATED_FEATURE]/feature.md
  </template>
  <conditional_logic>
    IF feature_has_integrations_or_dependencies:
      INCLUDE this section with cross-references
    ELSE:
      OMIT section entirely
  </conditional_logic>
</related_features_section>

<technical_notes_section>
  <template>
    ## Technical Notes (Conditional)
    
    [ONLY_IF_USERS_NEED_TECHNICAL_UNDERSTANDING]
    
    ### Important Information
    - [TECHNICAL_CONSIDERATION_1]: [USER_IMPACT]
    - [TECHNICAL_CONSIDERATION_2]: [PRACTICAL_IMPLICATION]
    
    ### Limitations
    - [LIMITATION_1]: [WORKAROUND_IF_AVAILABLE]
  </template>
  <inclusion_criteria>
    - user-facing technical impacts
    - important limitations
    - configuration requirements
    - compatibility considerations
  </inclusion_criteria>
</technical_notes_section>

</step>

<step number="6" subagent="file-creator" name="sub_feature_documentation">

### Step 6: Sub-Feature Documentation (Conditional)

Use the file-creator subagent to create individual sub-feature documentation files if hierarchical structure was planned.

<conditional_execution>
  IF hierarchical_structure_planned AND sub_features_identified:
    CREATE individual .md files for each sub-feature
  ELSE:
    SKIP this step entirely
</conditional_execution>

<sub_feature_template>
  <header>
    # [SUB_FEATURE_NAME]
    
    > Sub-Feature of: [MAIN_FEATURE_NAME]
    > Part of: @.agent-os/docs/[MAIN_FEATURE_NAME]/feature.md
    > Last Updated: [CURRENT_DATE]
  </header>
  
  <focused_sections>
    - Purpose
    - How It Works
    - User Instructions
    - Examples (if helpful)
  </focused_sections>
</sub_feature_template>

<sub_feature_content>
  <purpose_section>
    ## Purpose
    
    [SPECIFIC_PURPOSE_OF_THIS_SUB_FEATURE_WITHIN_MAIN_FEATURE]
  </purpose_section>
  
  <how_it_works_section>
    ## How It Works
    
    [FOCUSED_EXPLANATION_OF_THIS_SPECIFIC_FUNCTIONALITY]
  </how_it_works_section>
  
  <user_instructions_section>
    ## User Instructions
    
    ### To Use This Feature:
    1. [SPECIFIC_STEP_1]
    2. [SPECIFIC_STEP_2]
    3. [EXPECTED_RESULT]
  </user_instructions_section>
  
  <examples_section>
    ## Examples (Conditional)
    
    [ONLY_IF_EXAMPLES_WOULD_BE_HELPFUL]
    
    ### Example Scenario: [SCENARIO_NAME]
    [CONCRETE_EXAMPLE_OF_USAGE]
  </examples_section>
</sub_feature_content>

</step>

<step number="7" subagent="file-creator" name="documentation_index_update">

### Step 7: Documentation Index Update (Conditional)

Use the file-creator subagent to update or create a documentation index if multiple features are now documented.

<index_logic>
  IF multiple_features_documented_in_docs:
    UPDATE or CREATE .agent-os/docs/README.md
  ELSE IF first_feature_documented:
    CREATE .agent-os/docs/README.md
  ELSE:
    SKIP this step
</index_logic>

<index_template>
  <header>
    # Feature Documentation Index
    
    > Application Feature Documentation
    > Generated: [CURRENT_DATE]
  </header>
  
  <feature_listing>
    ## Available Features
    
    ### [CATEGORY_1] (if applicable)
    - **[Feature-Name-1]**: [BRIEF_DESCRIPTION] → @.agent-os/docs/[Feature-Name-1]/feature.md
    - **[Feature-Name-2]**: [BRIEF_DESCRIPTION] → @.agent-os/docs/[Feature-Name-2]/feature.md
    
    ### [CATEGORY_2] (if applicable)
    - **[Feature-Name-3]**: [BRIEF_DESCRIPTION] → @.agent-os/docs/[Feature-Name-3]/feature.md
  </feature_listing>
  
  <navigation_help>
    ## How to Use This Documentation
    
    Each feature has its own folder with comprehensive documentation:
    - **feature.md**: Complete feature overview and instructions
    - **sub-features/**: Detailed documentation for specific capabilities (where applicable)
    
    Documentation is organized by feature, not by development timeline.
  </navigation_help>
</index_template>

<categorization_rules>
  <optional_grouping>
    IF features_have_logical_categories:
      GROUP by functional categories
    ELSE:
      LIST alphabetically without categories
  </optional_grouping>
</categorization_rules>

</step>

<step number="8" name="cross_reference_creation">

### Step 8: Cross-Reference Creation

Create references between the original spec and the new documentation.

<reference_strategy>
  <spec_to_docs>
    ADD reference in original spec.md pointing to docs location
  </spec_to_docs>
  <docs_to_spec>
    ADD reference in feature.md pointing to original spec (optional)
  </docs_to_spec>
</reference_strategy>

<spec_reference_addition>
  <location>End of original spec.md</location>
  <format>
    ---
    
    ## Documentation
    
    User documentation: @.agent-os/docs/[FEATURE_NAME]/feature.md
  </format>
</spec_reference_addition>

</step>

<step number="9" name="user_review">

### Step 9: User Review

Present the completed documentation structure for user review.

<review_presentation>
  I've created the user documentation for [FEATURE_NAME]:
  
  - Main Documentation: @.agent-os/docs/[FEATURE_NAME]/feature.md
  [LIST_SUB_FEATURE_DOCS_IF_CREATED]
  [INDEX_UPDATE_IF_APPLICABLE]
  
  This transforms the development spec into user-facing documentation focused on practical usage and benefits.
  
  Please review the documentation and let me know if any adjustments are needed.
</review_presentation>

<review_outcomes>
  IF user_approves:
    COMPLETE the documentation process
  ELSE IF user_requests_changes:
    UPDATE documentation as needed
    REPEAT review process
  ELSE:
    WAIT for user clarification
</review_outcomes>

</step>

</process_flow>

## Documentation Standards

<writing_principles>
  <user_focused>
    - write for end users, not developers
    - focus on practical benefits and usage
    - avoid technical implementation details
  </user_focused>
  <clarity>
    - use clear, simple language
    - provide concrete examples
    - structure information logically
  </clarity>
  <completeness>
    - cover all user-visible functionality
    - include step-by-step instructions
    - explain the value proposition
  </completeness>
</writing_principles>

<structure_standards>
  <hierarchy>
    - main feature documentation in feature.md
    - detailed sub-features in sub-features/ folder
    - clear navigation between related docs
  </hierarchy>
  <consistency>
    - uniform section structure across features
    - consistent naming conventions
    - standardized cross-references
  </consistency>
</structure_standards>

<final_checklist>
  <verify>
    - [ ] Completed spec selected and analyzed
    - [ ] Documentation structure planned appropriately
    - [ ] Main feature.md created with all sections
    - [ ] Sub-feature docs created if needed
    - [ ] Documentation index updated
    - [ ] Cross-references established
    - [ ] User-focused language throughout
    - [ ] Clear instructions and examples provided
    - [ ] All user-visible functionality covered
  </verify>
</final_checklist>