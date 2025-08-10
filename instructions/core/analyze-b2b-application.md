---
description: Analyze Current B2B Enterprise Application & Install Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Analyze Current B2B Enterprise Application & Install Agent OS

## Overview

Install Agent OS into an existing B2B enterprise codebase, analyze current application state, compliance posture, and integration capabilities. Builds on plan-b2b-application.md with enterprise-specific considerations.

<pre_flight_check>
  EXECUTE: @~/.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="analyze_existing_codebase">

### Step 1: Analyze Existing Codebase

Perform a comprehensive enterprise codebase analysis to understand current state, compliance implementation, and integration architecture.

<analysis_areas>
  <project_structure>
    - Directory organization
    - File naming patterns
    - Module structure
    - Build configuration
    - Environment configuration
  </project_structure>
  <technology_stack>
    - Frameworks in use
    - Dependencies (package.json, Gemfile, requirements.txt, etc.)
    - Database systems
    - Infrastructure configuration
    - Monitoring and logging tools
    - Security libraries
  </technology_stack>
  <implementation_progress>
    - Completed business capabilities
    - Work in progress
    - Authentication/authorization state
    - API endpoints and business logic
    - Database schema and data models
    - Integration points
  </implementation_progress>
  <enterprise_features>
    - Security implementation (authentication, authorization, encryption)
    - Compliance features (audit logging, data protection)
    - Integration patterns (APIs, webhooks, data sync)
    - Scalability considerations (caching, load balancing)
    - Monitoring and observability
  </enterprise_features>
  <code_patterns>
    - Coding style in use
    - Naming conventions
    - File organization patterns
    - Testing approach
    - Error handling patterns
    - Security patterns
  </code_patterns>
</analysis_areas>

<instructions>
  ACTION: Thoroughly analyze the existing B2B enterprise codebase
  DOCUMENT: Current technologies, business capabilities, and enterprise patterns
  IDENTIFY: Architectural and business decisions already made
  NOTE: Development progress, compliance implementation, and integration status
  ASSESS: Enterprise readiness and security posture
</instructions>

</step>

<step number="2" subagent="context-fetcher" name="gather_business_context">

### Step 2: Gather Business Context

Use the context-fetcher subagent to supplement codebase analysis with business context, compliance requirements, and enterprise integration needs.

<context_questions>
  Based on my analysis of your B2B enterprise codebase, I can see you're building [OBSERVED_APPLICATION_TYPE].

  To properly set up Agent OS for enterprise development, I need to understand:

  1. **Business Vision**: What business problem does this solve? Which enterprise segments are you targeting?

  2. **Current Business State**: Are there business capabilities I should know about that aren't obvious from the code?

  3. **Compliance Requirements**: What regulatory standards must this application meet? (GDPR, SOX, HIPAA, etc.)

  4. **Integration Landscape**: What existing enterprise systems does this need to integrate with?

  5. **Enterprise Roadmap**: What business capabilities are planned next? Any major enterprise features or compliance milestones?

  6. **Business Decisions**: Are there important business, technical, or compliance decisions I should document?

  7. **Enterprise Standards**: Any enterprise coding standards, security practices, or compliance patterns the team follows?

  8. **Migration Strategy**: Is this replacing existing systems? What's the migration approach?
</context_questions>

<instructions>
  ACTION: Ask user for comprehensive business and enterprise context
  COMBINE: Merge user input with codebase analysis
  PREPARE: Information for plan-b2b-application.md execution
  FOCUS: Enterprise-specific requirements and constraints
</instructions>

</step>

<step number="3" name="execute_plan_b2b_application">

### Step 3: Execute Plan-B2B-Application with Context

Execute our B2B enterprise planning flow for installing Agent OS in existing enterprise applications.

<execution_parameters>
  <business_idea>[DERIVED_FROM_ANALYSIS_AND_USER_INPUT]</business_idea>
  <key_capabilities>[IDENTIFIED_IMPLEMENTED_AND_PLANNED_CAPABILITIES]</key_capabilities>
  <target_enterprises>[FROM_USER_CONTEXT]</target_enterprises>
  <tech_stack>[DETECTED_FROM_CODEBASE]</tech_stack>
  <compliance_requirements>[FROM_USER_INPUT]</compliance_requirements>
  <integration_requirements>[FROM_ANALYSIS_AND_USER_INPUT]</integration_requirements>
</execution_parameters>

<execution_prompt>
  @~/.agent-os/instructions/core/plan-b2b-application.md

  I'm installing Agent OS into an existing B2B enterprise application. Here's what I've gathered:

  **Business Idea**: [SUMMARY_FROM_ANALYSIS_AND_CONTEXT]

  **Key Business Capabilities**:
  - Already Implemented: [LIST_FROM_ANALYSIS]
  - Planned: [LIST_FROM_USER]

  **Target Enterprises**: [FROM_USER_RESPONSE]

  **Tech Stack**: [DETECTED_STACK_WITH_VERSIONS]

  **Compliance Requirements**: [REGULATORY_STANDARDS_NEEDED]

  **Integration Requirements**: [EXISTING_SYSTEMS_AND_APIS]

  **Migration Considerations**: [LEGACY_SYSTEM_REPLACEMENT_STRATEGY]
</execution_prompt>

<instructions>
  ACTION: Execute plan-b2b-application.md with gathered enterprise information
  PROVIDE: All business and technical context as structured input
  ALLOW: plan-b2b-application.md to create enhanced .agent-os/product/ structure
  ENSURE: Enterprise-specific documentation is created
</instructions>

</step>

<step number="4" name="customize_enterprise_documentation">

### Step 4: Customize Enterprise Documentation

Refine the generated documentation to ensure accuracy for the existing B2B enterprise application by updating compliance status, integration mappings, and business decisions based on actual implementation.

<customization_tasks>
  <roadmap_adjustment>
    - Mark completed business capabilities as done
    - Move implemented features to "Phase 0: Already Completed"
    - Adjust future phases based on actual enterprise progress
    - Include compliance milestones in timeline
  </roadmap_adjustment>
  <tech_stack_verification>
    - Verify detected versions are correct
    - Add any missing enterprise infrastructure details
    - Document actual deployment and security setup
    - Include monitoring and compliance tools
  </tech_stack_verification>
  <compliance_documentation>
    - Document current compliance implementation status
    - Identify compliance gaps that need addressing
    - Map existing security features to compliance requirements
    - Plan compliance roadmap items
  </compliance_documentation>
  <integration_mapping>
    - Document existing system integrations
    - Map current API connections and data flows
    - Identify integration patterns in use
    - Plan future integration requirements
  </integration_mapping>
  <decisions_documentation>
    - Add historical business and technical decisions
    - Document why certain enterprise technologies were chosen
    - Capture compliance-driven architectural decisions
    - Document integration strategy decisions
  </decisions_documentation>
</customization_tasks>

<enterprise_roadmap_template>
  ## Phase 0: Already Completed

  The following business capabilities have been implemented:

  - [x] [BUSINESS_CAPABILITY_1] - [DESCRIPTION_FROM_CODE]
  - [x] [BUSINESS_CAPABILITY_2] - [DESCRIPTION_FROM_CODE]
  - [x] [BUSINESS_CAPABILITY_3] - [DESCRIPTION_FROM_CODE]

  ### Compliance Implementation

  - [x] [COMPLIANCE_FEATURE_1] - [REGULATORY_STANDARD]
  - [x] [COMPLIANCE_FEATURE_2] - [REGULATORY_STANDARD]

  ### Integration Status

  - [x] [INTEGRATION_1] - [SYSTEM_CONNECTION]
  - [x] [INTEGRATION_2] - [SYSTEM_CONNECTION]

  ## Phase 1: Current Enterprise Development

  - [ ] [IN_PROGRESS_CAPABILITY] - [BUSINESS_DESCRIPTION]

  [CONTINUE_WITH_STANDARD_ENTERPRISE_PHASES]
</enterprise_roadmap_template>

</step>

<step number="5" name="final_verification">

### Step 5: Final Verification and Summary

Verify installation completeness and provide clear next steps for the enterprise team to start using Agent OS with their existing B2B application codebase.

<verification_checklist>
  - [ ] .agent-os/product/ directory created with all 7 files
  - [ ] All product documentation reflects actual enterprise codebase
  - [ ] Compliance requirements documented and mapped
  - [ ] Integration strategy reflects existing and planned connections
  - [ ] Roadmap shows completed and planned business capabilities accurately
  - [ ] Tech stack matches installed dependencies and enterprise tools
  - [ ] Business stakeholders and decision makers identified
</verification_checklist>

<summary_template>
  ## ✅ Agent OS Successfully Installed for B2B Enterprise Application

  I've analyzed your [BUSINESS_APPLICATION_TYPE] codebase and set up Agent OS with enterprise documentation that reflects your actual implementation and business requirements.

  ### What I Found

  - **Enterprise Tech Stack**: [SUMMARY_OF_DETECTED_STACK_WITH_ENTERPRISE_TOOLS]
  - **Completed Business Capabilities**: [COUNT] capabilities already implemented
  - **Compliance Status**: [COMPLIANCE_IMPLEMENTATION_SUMMARY]
  - **Integration Points**: [EXISTING_SYSTEM_CONNECTIONS]
  - **Code Style**: [DETECTED_ENTERPRISE_PATTERNS]
  - **Current Business Phase**: [IDENTIFIED_DEVELOPMENT_STAGE]

  ### What Was Created

  - ✓ Enterprise product documentation in `.agent-os/product/`
  - ✓ Compliance & security requirements documentation
  - ✓ Integration & migration strategy documentation
  - ✓ Business roadmap with completed work in Phase 0
  - ✓ Enterprise tech stack reflecting actual dependencies

  ### Next Steps

  1. Review the generated enterprise documentation in `.agent-os/product/`
  2. Validate compliance requirements with your compliance team
  3. Review integration strategy with your enterprise architecture team
  4. Make any necessary adjustments to reflect your business vision
  5. Start using Agent OS for your next business capability:
     ```
     @~/.agent-os/instructions/core/create-spec.md
     ```

  Your B2B enterprise application is now Agent OS-enabled! 🚀
</summary_template>

</step>

</process_flow>

## Error Handling

<error_scenarios>
  <scenario name="no_clear_business_structure">
    <condition>Cannot determine business application type or enterprise architecture</condition>
    <action>Ask user for clarification about business domain and enterprise context</action>
  </scenario>
  <scenario name="conflicting_enterprise_patterns">
    <condition>Multiple enterprise patterns or compliance approaches detected</condition>
    <action>Ask user which enterprise pattern to document as standard</action>
  </scenario>
  <scenario name="missing_compliance_info">
    <condition>Cannot determine compliance requirements from codebase</condition>
    <action>Ask user for specific regulatory and compliance requirements</action>
  </scenario>
  <scenario name="unclear_integration_landscape">
    <condition>Cannot determine full enterprise integration requirements</condition>
    <action>Ask user for existing systems and planned integrations</action>
  </scenario>
</error_scenarios>

## Execution Summary

<final_checklist>
  <verify>
    - [ ] Enterprise codebase analyzed thoroughly
    - [ ] Business and compliance context gathered
    - [ ] plan-b2b-application.md executed with proper enterprise context
    - [ ] Documentation customized for existing B2B application
    - [ ] Compliance and integration requirements documented
    - [ ] Enterprise team can adopt Agent OS workflow
  </verify>
</final_checklist>