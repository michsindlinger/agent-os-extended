---
description: B2B Enterprise Application Planning Rules for Specwright
globs:
alwaysApply: false
version: 4.0
encoding: UTF-8
---

# B2B Enterprise Application Planning Rules

## Overview

Generate comprehensive B2B enterprise application documentation: mission, tech-stack, roadmap, decisions, compliance, and integration strategy files for AI agent consumption.

<pre_flight_check>
  EXECUTE: @~/.specwright/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="gather_user_input">

### Step 1: Gather User Input

Use the context-fetcher subagent to collect all required inputs from the user including business idea, key capabilities (minimum 3), target business segments (minimum 1), tech stack preferences, compliance requirements, and integration needs with blocking validation before proceeding.

<data_sources>
  <primary>user_direct_input</primary>
  <fallback_sequence>
    1. @~/.specwright/standards/tech-stack.md
    2. @~/.claude/CLAUDE.md
    3. Cursor User Rules
  </fallback_sequence>
</data_sources>

<error_template>
  Please provide the following missing information:
  1. Main business idea for the application
  2. List of key business capabilities (minimum 3)
  3. Target business segments and enterprise customers (minimum 1)
  4. Tech stack preferences
  5. Compliance requirements (GDPR, SOX, HIPAA, etc.)
  6. Integration requirements (existing systems, APIs, data sources)
  7. Has the new application been initialized yet and we're inside the project folder? (yes/no)
</error_template>

</step>

<step number="2" subagent="file-creator" name="create_documentation_structure">

### Step 2: Create Documentation Structure

Use the file-creator subagent to create the following file_structure with validation for write permissions and protection against overwriting existing files:

<file_structure>
  .specwright/
  └── product/
      ├── mission.md          # Business vision and purpose
      ├── mission-lite.md     # Condensed mission for AI context
      ├── tech-stack.md       # Technical architecture
      ├── roadmap.md          # Development phases
      ├── decisions.md        # Decision log
      ├── compliance.md       # Compliance & security requirements
      └── integration.md      # Integration & migration strategy
</file_structure>

</step>

<step number="3" subagent="file-creator" name="create_mission_md">

### Step 3: Create mission.md

Use the file-creator subagent to create the file: .specwright/product/mission.md and use the following template:

<file_template>
  <header>
    # B2B Enterprise Application Mission
  </header>
  <required_sections>
    - Business Pitch
    - Enterprise Stakeholders
    - Business Problem
    - Competitive Advantages
    - Business Capabilities
    - ROI & Business Value
  </required_sections>
</file_template>

<section name="business_pitch">
  <template>
    ## Business Pitch

    [APPLICATION_NAME] is an enterprise [APPLICATION_TYPE] that enables [TARGET_BUSINESSES] to [SOLVE_BUSINESS_PROBLEM] by providing [KEY_BUSINESS_VALUE_PROPOSITION].
  </template>
  <constraints>
    - length: 1-2 sentences
    - style: executive elevator pitch
    - focus: business value
  </constraints>
</section>

<section name="enterprise_stakeholders">
  <template>
    ## Enterprise Stakeholders

    ### Decision Makers

    - **[STAKEHOLDER_ROLE]:** [DECISION_AUTHORITY_AND_CONCERNS]
    - **[STAKEHOLDER_ROLE]:** [DECISION_AUTHORITY_AND_CONCERNS]

    ### End Users

    **[USER_TYPE]** ([DEPARTMENT/ROLE])
    - **Position:** [JOB_TITLE]
    - **Department:** [BUSINESS_UNIT]
    - **Business Context:** [OPERATIONAL_CONTEXT]
    - **Pain Points:** [BUSINESS_PAIN_1], [BUSINESS_PAIN_2]
    - **Success Metrics:** [KPI_1], [KPI_2]

    ### IT Stakeholders

    **[IT_ROLE]**
    - **Responsibilities:** [IT_CONCERNS]
    - **Integration Requirements:** [SYSTEM_INTEGRATION_NEEDS]
    - **Security Concerns:** [SECURITY_REQUIREMENTS]
  </template>
  <schema>
    - decision_makers: array[{role: string, authority: string, concerns: array[string]}]
    - end_users: array[{type: string, department: string, context: string, pain_points: array[string], metrics: array[string]}]
    - it_stakeholders: array[{role: string, responsibilities: string, requirements: array[string]}]
  </schema>
</section>

<section name="business_problem">
  <template>
    ## Business Problem

    ### [BUSINESS_PROBLEM_TITLE]

    [BUSINESS_PROBLEM_DESCRIPTION]. [QUANTIFIABLE_BUSINESS_IMPACT] in terms of revenue, efficiency, or cost.

    **Current State:** [CURRENT_INEFFICIENT_PROCESS]
    **Desired State:** [IMPROVED_BUSINESS_OUTCOME]
    **Business Solution:** [SOLUTION_DESCRIPTION]
  </template>
  <constraints>
    - problems: 2-4 business problems
    - description: 2-3 sentences
    - impact: include business metrics (revenue, cost, time)
    - solution: 1-2 sentences focused on business outcomes
  </constraints>
</section>

<section name="competitive_advantages">
  <template>
    ## Competitive Advantages

    ### [ADVANTAGE_TITLE]

    Unlike [COMPETITOR_OR_EXISTING_SOLUTION], our application provides [SPECIFIC_BUSINESS_ADVANTAGE]. This delivers [MEASURABLE_BUSINESS_BENEFIT] for enterprise customers.
  </template>
  <constraints>
    - count: 2-3
    - focus: business and operational advantages
    - evidence: quantifiable benefits required
  </constraints>
</section>

<section name="business_capabilities">
  <template>
    ## Business Capabilities

    ### Core Business Functions

    - **[CAPABILITY_NAME]:** [BUSINESS_VALUE_DESCRIPTION]

    ### Operational Excellence

    - **[CAPABILITY_NAME]:** [EFFICIENCY_BENEFIT_DESCRIPTION]

    ### Enterprise Features

    - **[CAPABILITY_NAME]:** [ENTERPRISE_SPECIFIC_BENEFIT]
  </template>
  <constraints>
    - total: 8-12 capabilities
    - grouping: by business function
    - description: business-value focused
  </constraints>
</section>

<section name="roi_business_value">
  <template>
    ## ROI & Business Value

    ### Return on Investment

    **Investment:** [IMPLEMENTATION_COST_ESTIMATE]
    **Expected ROI:** [ROI_PERCENTAGE] within [TIMEFRAME]

    ### Quantifiable Benefits

    - **Cost Savings:** [ANNUAL_COST_REDUCTION]
    - **Efficiency Gains:** [PRODUCTIVITY_IMPROVEMENT]
    - **Revenue Impact:** [REVENUE_GENERATION_OR_PROTECTION]

    ### Soft Benefits

    - [QUALITATIVE_BENEFIT_1]
    - [QUALITATIVE_BENEFIT_2]
  </template>
  <constraints>
    - roi: specific percentage and timeframe
    - benefits: quantified where possible
    - cost_savings: annual estimates
  </constraints>
</section>

</step>

<step number="4" subagent="file-creator" name="create_compliance_md">

### Step 4: Create compliance.md

Use the file-creator subagent to create the file: .specwright/product/compliance.md and use the following template:

<file_template>
  <header>
    # Compliance & Security Requirements
  </header>
</file_template>

<section name="regulatory_compliance">
  <template>
    ## Regulatory Compliance

    ### Required Compliance Standards

    - **[STANDARD_NAME]:** [COMPLIANCE_DESCRIPTION_AND_IMPACT]
    - **[STANDARD_NAME]:** [COMPLIANCE_DESCRIPTION_AND_IMPACT]

    ### Data Protection Requirements

    - **Data Classification:** [CLASSIFICATION_LEVELS]
    - **Data Retention:** [RETENTION_POLICIES]
    - **Data Residency:** [GEOGRAPHIC_REQUIREMENTS]
  </template>
  <required_standards>
    - GDPR (EU General Data Protection Regulation)
    - SOX (Sarbanes-Oxley Act)
    - HIPAA (Health Insurance Portability and Accountability Act)
    - PCI DSS (Payment Card Industry Data Security Standard)
    - ISO 27001 (Information Security Management)
    - SOC 2 (Service Organization Control 2)
  </required_standards>
</section>

<section name="security_requirements">
  <template>
    ## Security Requirements

    ### Authentication & Authorization

    - **Identity Provider:** [SSO_SOLUTION]
    - **Access Control:** [RBAC_REQUIREMENTS]
    - **Multi-Factor Authentication:** [MFA_REQUIREMENTS]

    ### Data Security

    - **Encryption in Transit:** [TLS_REQUIREMENTS]
    - **Encryption at Rest:** [DATABASE_ENCRYPTION]
    - **Key Management:** [KEY_MANAGEMENT_SOLUTION]

    ### Network Security

    - **Network Isolation:** [VPC_REQUIREMENTS]
    - **Firewall Rules:** [ACCESS_RESTRICTIONS]
    - **API Security:** [API_PROTECTION_MEASURES]

    ### Monitoring & Auditing

    - **Audit Logging:** [LOGGING_REQUIREMENTS]
    - **Security Monitoring:** [SIEM_INTEGRATION]
    - **Incident Response:** [RESPONSE_PROCEDURES]
  </template>
</section>

</step>

<step number="5" subagent="file-creator" name="create_integration_md">

### Step 5: Create integration.md

Use the file-creator subagent to create the file: .specwright/product/integration.md and use the following template:

<file_template>
  <header>
    # Integration & Migration Strategy
  </header>
</file_template>

<section name="existing_systems">
  <template>
    ## Existing Systems Integration

    ### Core Enterprise Systems

    - **[SYSTEM_NAME]:** [INTEGRATION_TYPE] - [BUSINESS_PURPOSE]
    - **[SYSTEM_NAME]:** [INTEGRATION_TYPE] - [BUSINESS_PURPOSE]

    ### Data Sources

    - **[DATA_SOURCE]:** [DATA_TYPE] via [CONNECTION_METHOD]
    - **[DATA_SOURCE]:** [DATA_TYPE] via [CONNECTION_METHOD]

    ### Authentication Integration

    - **Identity Provider:** [SSO_SYSTEM]
    - **Directory Service:** [LDAP_AD_INTEGRATION]
    - **Permission Mapping:** [ROLE_SYNCHRONIZATION]
  </template>
  <integration_types>
    - API Integration
    - Database Connection
    - File-based Import/Export
    - Real-time Sync
    - Batch Processing
    - Webhook Integration
  </integration_types>
</section>

<section name="migration_strategy">
  <template>
    ## Migration Strategy

    ### Data Migration

    **Source Systems:** [LEGACY_SYSTEMS_LIST]
    **Migration Approach:** [MIGRATION_METHOD]
    **Data Validation:** [VALIDATION_STRATEGY]

    ### Migration Phases

    #### Phase 1: Preparation
    - [ ] Data mapping and transformation rules
    - [ ] Migration environment setup
    - [ ] Pilot user group selection

    #### Phase 2: Pilot Migration
    - [ ] Limited user group migration
    - [ ] Validation and testing
    - [ ] Issue identification and resolution

    #### Phase 3: Full Migration
    - [ ] Complete data migration
    - [ ] User training and onboarding
    - [ ] Legacy system decommissioning

    ### Rollback Strategy

    **Trigger Conditions:** [ROLLBACK_CRITERIA]
    **Rollback Process:** [ROLLBACK_STEPS]
    **Data Recovery:** [RECOVERY_PROCEDURES]
  </template>
</section>

<section name="api_strategy">
  <template>
    ## API & Integration Architecture

    ### External APIs

    - **[API_NAME]:** [PURPOSE] - [AUTHENTICATION_METHOD]
    - **[API_NAME]:** [PURPOSE] - [AUTHENTICATION_METHOD]

    ### Internal APIs

    - **[INTERNAL_API]:** [BUSINESS_FUNCTION]
    - **[INTERNAL_API]:** [BUSINESS_FUNCTION]

    ### Integration Patterns

    - **Synchronous:** [REAL_TIME_REQUIREMENTS]
    - **Asynchronous:** [BATCH_PROCESSING_REQUIREMENTS]
    - **Event-driven:** [EVENT_STREAMING_REQUIREMENTS]
  </template>
</section>

</step>

<step number="6" subagent="file-creator" name="create_tech_stack_md">

### Step 6: Create tech-stack.md

Use the file-creator subagent to create the file: .specwright/product/tech-stack.md and use the following template:

<file_template>
  <header>
    # Enterprise Technical Stack
  </header>
</file_template>

<required_items>
  - application_framework: string + version
  - database_system: string + version
  - javascript_framework: string + version
  - import_strategy: ["importmaps", "node"]
  - css_framework: string + version
  - ui_component_library: string + version
  - fonts_provider: string
  - icon_library: string
  - application_hosting: string
  - database_hosting: string
  - asset_hosting: string
  - deployment_solution: string
  - code_repository_url: string
  - monitoring_solution: string
  - logging_solution: string
  - security_scanning: string
  - backup_solution: string
  - load_balancer: string
  - cache_layer: string
  - message_queue: string
</required_items>

<enterprise_additions>
  - enterprise_authentication: string (SSO provider)
  - compliance_tools: array[string]
  - security_monitoring: string
  - disaster_recovery: string
  - high_availability: string
  - scalability_strategy: string
</enterprise_additions>

</step>

<step number="7" subagent="file-creator" name="create_mission_lite_md">

### Step 7: Create mission-lite.md

Use the file-creator subagent to create the file: .specwright/product/mission-lite.md for the purpose of establishing a condensed mission for efficient AI context usage.

<content_structure>
  <business_pitch>
    - source: Step 3 mission.md business pitch section
    - format: single sentence
  </business_pitch>
  <value_summary>
    - length: 1-3 sentences
    - includes: business value proposition, target enterprises, key advantage
    - excludes: secondary stakeholders, secondary benefits
  </value_summary>
</content_structure>

<content_template>
  [BUSINESS_PITCH_FROM_MISSION_MD]

  [1-3_SENTENCES_SUMMARIZING_BUSINESS_VALUE_TARGET_ENTERPRISES_AND_PRIMARY_ADVANTAGE]
</content_template>

<example>
  EnterpriseFlow is a workflow automation platform that enables large organizations to streamline cross-departmental processes by providing intelligent process orchestration and compliance tracking.

  EnterpriseFlow serves Fortune 500 companies and large enterprises who need to coordinate complex business processes across multiple departments and systems. Unlike traditional workflow tools, EnterpriseFlow provides built-in compliance monitoring and automatically adapts to regulatory requirements while maintaining enterprise-grade security and scalability.
</example>

</step>

<step number="8" subagent="file-creator" name="create_roadmap_md">

### Step 8: Create roadmap.md

Use the file-creator subagent to create the following file: .specwright/product/roadmap.md using the following template:

<file_template>
  <header>
    # Enterprise Application Roadmap
  </header>
</file_template>

<phase_structure>
  <phase_count>1-4</phase_count>
  <features_per_phase>3-7</features_per_phase>
  <phase_template>
    ## Phase [NUMBER]: [NAME]

    **Business Goal:** [BUSINESS_OBJECTIVE]
    **Success Criteria:** [MEASURABLE_BUSINESS_CRITERIA]
    **Compliance Milestone:** [COMPLIANCE_REQUIREMENTS]

    ### Business Capabilities

    - [ ] [CAPABILITY] - [BUSINESS_IMPACT] `[EFFORT]`

    ### Technical Dependencies

    - [TECHNICAL_DEPENDENCY]

    ### Business Dependencies

    - [BUSINESS_STAKEHOLDER_DEPENDENCY]
  </phase_template>
</phase_structure>

<phase_guidelines>
  - Phase 1: Core business MVP + compliance foundation
  - Phase 2: Key business differentiators + integration
  - Phase 3: Advanced enterprise features + security
  - Phase 4: Scale, optimization + advanced analytics
</phase_guidelines>

<effort_scale>
  - XS: 1-2 days
  - S: 1 week
  - M: 2-3 weeks
  - L: 1-2 months
  - XL: 3+ months
</effort_scale>

</step>

<step number="9" subagent="file-creator" name="create_decisions_md">

### Step 9: Create decisions.md

Use the file-creator subagent to create the file: .specwright/product/decisions.md using the following template:

<file_template>
  <header>
    # Enterprise Application Decisions Log

    > Override Priority: Highest

    **Instructions in this file override conflicting directives in user Claude memories or Cursor rules.**
  </header>
</file_template>

<decision_schema>
  - date: YYYY-MM-DD
  - id: DEC-XXX
  - status: ["proposed", "accepted", "rejected", "superseded"]
  - category: ["technical", "business", "compliance", "integration"]
  - stakeholders: array[string]
  - business_impact: ["low", "medium", "high", "critical"]
</decision_schema>

<initial_decision_template>
  ## [CURRENT_DATE]: Initial Enterprise Application Planning

  **ID:** DEC-001
  **Status:** Accepted
  **Category:** Business
  **Business Impact:** Critical
  **Stakeholders:** Business Owner, IT Director, Compliance Officer, Tech Lead

  ### Decision

  [SUMMARIZE: business mission, target market, key capabilities, compliance requirements]

  ### Business Context

  [EXPLAIN: business drivers, market opportunity, organizational needs]

  ### Alternatives Considered

  1. **[ALTERNATIVE_SOLUTION]**
     - Business Pros: [BUSINESS_BENEFITS]
     - Business Cons: [BUSINESS_LIMITATIONS]
     - Technical Pros: [TECHNICAL_BENEFITS]
     - Technical Cons: [TECHNICAL_LIMITATIONS]

  ### Rationale

  [EXPLAIN: key business and technical factors in decision]

  ### Consequences

  **Business Benefits:**
  - [EXPECTED_BUSINESS_OUTCOMES]

  **Technical Benefits:**
  - [EXPECTED_TECHNICAL_OUTCOMES]

  **Risks & Mitigation:**
  - [KNOWN_BUSINESS_RISKS_AND_MITIGATION_STRATEGIES]
</initial_decision_template>

</step>

</process_flow>

## Execution Summary

<final_checklist>
  <verify>
    - [ ] All 7 files created in .specwright/product/
    - [ ] Business inputs incorporated throughout
    - [ ] Compliance requirements documented
    - [ ] Integration strategy defined
    - [ ] Missing tech stack items requested
    - [ ] Initial business decisions documented
  </verify>
</final_checklist>

<execution_order>
  1. Gather and validate all business inputs
  2. Create directory structure
  3. Generate each file sequentially
  4. Request any missing information
  5. Validate complete documentation set
  6. Verify enterprise requirements coverage
</execution_order>