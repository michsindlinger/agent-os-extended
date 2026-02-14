---
description: Brainstorm Upselling & Cross-Selling Ideas for Specwright Projects
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Brainstorm Upselling & Cross-Selling Ideas

## Overview

Analyze the current project and generate strategic upselling and cross-selling ideas through interactive discussion. The agent presents opportunities, discusses them with you, and only documents after collaborative refinement.

<pre_flight_check>
  EXECUTE: @~/.specwright/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="gather_project_context">

### Step 1: Gather Project Context

Use the context-fetcher subagent to analyze existing product documentation and codebase to understand the current state.

<analysis_sequence>
  <check_agent_os_docs>
    IF .specwright/product/ directory exists:
      READ: .specwright/product/mission.md (or mission-lite.md)
      READ: .specwright/product/tech-stack.md
      READ: .specwright/product/roadmap.md
      READ: .specwright/product/decisions.md
      STORE: Product context from documentation
    ELSE:
      PROCEED: To codebase analysis
  </check_agent_os_docs>

  <analyze_codebase>
    IF no Specwright documentation found:
      ANALYZE:
        - Project structure and file organization
        - Dependencies (package.json, Gemfile, requirements.txt, etc.)
        - Implemented features and functionality
        - Database schema
        - API endpoints
        - UI/UX patterns
        - Authentication/authorization systems
        - Integration points
        - Configuration files
      STORE: Codebase analysis results
  </analyze_codebase>

  <fallback_to_user>
    IF insufficient information gathered:
      ASK: User for project details
      QUESTIONS:
        - What is the main purpose of this project?
        - Who are the target users?
        - What problem does it solve?
        - What are the key features currently implemented?
        - What industry/domain is this project in?
  </fallback_to_user>
</analysis_sequence>

</step>

<step number="2" name="analyze_current_state">

### Step 2: Analyze Current State & Identify Gaps

Perform comprehensive analysis to identify opportunities for upselling based on current implementation.

<analysis_dimensions>
  <feature_completeness>
    - Identify partially implemented features
    - Find missing components in feature sets
    - Detect incomplete user workflows
    - Spot gaps in user journey
  </feature_completeness>

  <technical_infrastructure>
    - Missing monitoring/logging solutions
    - Absent backup/disaster recovery
    - Lack of performance optimization
    - Missing security hardening
    - Incomplete testing coverage
    - Absent CI/CD pipelines
  </technical_infrastructure>

  <user_experience>
    - Missing mobile/responsive versions
    - Absent accessibility features
    - Lack of internationalization
    - Missing onboarding/tutorials
    - Absent user analytics
  </user_experience>

  <business_capabilities>
    - Missing reporting/analytics dashboards
    - Absent payment/billing systems
    - Lack of admin/management tools
    - Missing integration capabilities
    - Absent API for third-party access
  </business_capabilities>

  <scalability_readiness>
    - Current limitations in architecture
    - Performance bottlenecks
    - Scaling challenges
    - Multi-tenancy gaps
    - Missing caching layers
  </scalability_readiness>
</analysis_dimensions>

<internal_preparation>
  PREPARE: Initial list of 10-15 opportunity ideas
  CATEGORIZE: By type and priority
  ESTIMATE: Rough effort and value
  DO NOT SHARE: Full details yet - prepare for discussion
</internal_preparation>

</step>

<step number="3" name="present_opportunities">

### Step 3: Present High-Level Opportunities

Present a curated list of upselling opportunities to the user for interactive discussion.

<presentation_format>
  ## 🎯 Upselling Opportunities für [PROJECT_NAME]

  Basierend auf meiner Analyse habe ich [COUNT] strategische Möglichkeiten identifiziert:

  ### Quick Wins (1-2 Wochen)
  1. **[OPPORTUNITY_NAME]** - [ONE_LINE_DESCRIPTION]
  2. **[OPPORTUNITY_NAME]** - [ONE_LINE_DESCRIPTION]

  ### Mittelfristige Projekte (3-6 Wochen)
  3. **[OPPORTUNITY_NAME]** - [ONE_LINE_DESCRIPTION]
  4. **[OPPORTUNITY_NAME]** - [ONE_LINE_DESCRIPTION]

  ### Strategische Initiativen (2+ Monate)
  5. **[OPPORTUNITY_NAME]** - [ONE_LINE_DESCRIPTION]
  6. **[OPPORTUNITY_NAME]** - [ONE_LINE_DESCRIPTION]

  Welche dieser Möglichkeiten interessieren dich besonders? Wir können jede einzeln im Detail besprechen.
</presentation_format>

<interaction_guidelines>
  - Present 6-10 opportunities initially
  - Group by effort/timeline
  - Keep descriptions concise (one line)
  - Wait for user response
  - Be ready to explain any opportunity in detail
  - Allow user to ask about specific ones
</interaction_guidelines>

</step>

<step number="4" name="interactive_discussion">

### Step 4: Interactive Discussion & Refinement

Engage in detailed discussion about selected opportunities, refining ideas based on user feedback.

<discussion_approach>
  <when_user_selects_opportunity>
    FOR each selected opportunity:
      EXPLAIN in detail:
        - What exactly would be built
        - Why it's valuable for the client
        - Technical approach and complexity
        - Estimated effort and timeline
        - Business value and ROI potential

      ASK clarifying questions:
        - Does this align with client priorities?
        - Are there any constraints we should consider?
        - Would you modify this approach in any way?
        - Should we bundle this with other opportunities?
  </when_user_selects_opportunity>

  <exploration_questions>
    - "Möchtest du mehr Details zu [OPPORTUNITY_NAME]?"
    - "Gibt es andere Bereiche, die ich nicht erwähnt habe?"
    - "Welche dieser Ideen passen am besten zum aktuellen Kundenfokus?"
    - "Sollen wir einige Ideen zu Paketen bündeln?"
    - "Gibt es Budget- oder Zeitbeschränkungen, die ich berücksichtigen sollte?"
  </exploration_questions>

  <refinement_process>
    BASED ON user feedback:
      - Adjust scope and complexity
      - Modify technical approach
      - Refine value proposition
      - Update effort estimates
      - Identify dependencies or risks
      - Consider bundling strategies
  </refinement_process>
</discussion_approach>

<conversational_style>
  - Be consultative, not salesy
  - Listen to user's priorities
  - Adapt ideas based on feedback
  - Build on user's insights
  - Ask follow-up questions
  - Validate understanding
</conversational_style>

</step>

<step number="5" name="collaborative_prioritization">

### Step 5: Collaborative Prioritization

Work with the user to prioritize and select opportunities for documentation.

<prioritization_discussion>
  Nach unserer Diskussion, lass uns die vielversprechendsten Opportunities priorisieren:

  **Kriterien zur Bewertung:**
  - Geschäftswert für den Kunden
  - Technische Machbarkeit
  - Zeitlicher Aufwand
  - Strategische Passung
  - Quick Wins vs. langfristige Investments

  Welche 3-5 Opportunities sollen wir dokumentieren und weiter ausarbeiten?
</prioritization_discussion>

<selection_process>
  WAIT for user to select opportunities

  FOR each selected opportunity:
    CONFIRM:
      - Final scope and approach
      - Key value propositions
      - Effort estimate
      - Target client persona (if applicable)
      - Next steps

  ASK: "Soll ich diese [COUNT] Opportunities jetzt dokumentieren?"
  WAIT: For explicit confirmation before proceeding
</selection_process>

</step>

<step number="6" subagent="file-creator" name="create_documentation">

### Step 6: Create Documentation

ONLY AFTER user confirmation: Use the file-creator subagent to create structured documentation.

<documentation_trigger>
  ONLY proceed when:
    - User has selected specific opportunities
    - Discussion has refined the ideas
    - User explicitly asks for documentation
</documentation_trigger>

<file_location>.specwright/business/upselling-ideas-[CURRENT_DATE].md</file_location>

<document_structure>
  # Upselling Opportunities für [PROJECT_NAME]

  > Erstellt: [CURRENT_DATE]
  > Diskutiert mit: [USER_NAME or "Team"]
  > Analysierte Basis: [WHAT_WAS_ANALYZED]

  ## Zusammenfassung

  **Projekt-Kontext:**
  [BRIEF_PROJECT_DESCRIPTION]

  **Aktueller Stand:**
  - Implementierte Features: [COUNT]
  - Tech Stack: [SUMMARY]
  - Entwicklungsphase: [PHASE]

  **Ausgewählte Opportunities:**
  - Anzahl: [COUNT]
  - Quick Wins: [COUNT]
  - Mittelfristige Projekte: [COUNT]
  - Strategische Initiativen: [COUNT]

  ---

  ## Detaillierte Opportunities

  [FOR each selected and discussed opportunity:]

  ### [NUMBER]. [OPPORTUNITY_NAME]

  **Kategorie:** [CATEGORY]
  **Priorität:** [High|Medium|Low]
  **Aufwand:** [EFFORT_ESTIMATE]
  **Wert:** [VALUE_ESTIMATE]

  #### Was wird gebaut?
  [DETAILED_DESCRIPTION_FROM_DISCUSSION]

  #### Geschäftswert
  - **Für den Kunden:** [CLIENT_BENEFITS]
  - **Für End-User:** [USER_BENEFITS]
  - **ROI-Indikatoren:** [METRICS]

  #### Technischer Ansatz
  - **Komplexität:** [XS|S|M|L|XL]
  - **Technologien:** [TECH_STACK]
  - **Abhängigkeiten:** [DEPENDENCIES]

  **Implementierungs-Schritte:**
  1. [STEP_1]
  2. [STEP_2]
  3. [STEP_3]

  #### Sales Positioning
  - **Pain Point:** [PROBLEM_THIS_SOLVES]
  - **Value Proposition:** [WHY_CLIENT_SHOULD_BUY]
  - **Bester Zeitpunkt:** [TIMING_RECOMMENDATION]

  #### Aus der Diskussion
  [KEY_INSIGHTS_FROM_USER_DISCUSSION]

  ---

  ## Empfohlene Nächste Schritte

  ### Sofort präsentieren
  - [OPPORTUNITY_1]: [WHY_NOW]
  - [OPPORTUNITY_2]: [WHY_NOW]

  ### Nach aktuellem Projekt
  - [OPPORTUNITY_3]: [WHY_NEXT]

  ### Langfristige Diskussion
  - [OPPORTUNITY_4]: [WHY_LATER]

  ## Bundles & Pakete

  [IF discussed during session:]

  ### Paket: [PACKAGE_NAME]
  - [OPPORTUNITY_A]
  - [OPPORTUNITY_B]
  - **Kombinierter Wert:** [TOTAL_VALUE]
  - **Synergien:** [BUNDLING_BENEFITS]

  ## Notizen aus der Diskussion

  [CAPTURE key insights, constraints, or special considerations mentioned during discussion]
</document_structure>

<additional_outputs>
  <create_summary>
    ALSO CREATE: .specwright/business/upselling-summary-[CURRENT_DATE].md

    FORMAT: Client-facing summary (1-2 pages)
    INCLUDE: Top 3-5 opportunities only
    TONE: Professional, benefit-focused
    LANGUAGE: Adjust based on user preference (DE/EN)
  </create_summary>

  <optional_proposals>
    IF user requests:
      CREATE: Individual proposal templates in .specwright/business/proposals/
      FOR: Top 2-3 opportunities
      INCLUDE: Detailed scope, timeline, pricing structure
  </optional_proposals>
</additional_outputs>

</step>

<step number="7" name="review_and_iterate">

### Step 7: Review & Iterate

Present the documentation to the user for review and refinement.

<review_process>
  AFTER creating documentation:
    SHARE: Location of created files
    SUMMARIZE: What was documented
    ASK: "Möchtest du Anpassungen an der Dokumentation?"

  IF user requests changes:
    ITERATE: Update documentation based on feedback
    CONFIRM: Changes implemented

  IF user is satisfied:
    SUMMARIZE: Next steps for using the documentation
    SUGGEST: How to present to client
</review_process>

<next_steps_guidance>
  ## Wie du diese Opportunities nutzen kannst:

  1. **Review:** Gehe die Dokumentation durch und passe sie an deinen Stil an
  2. **Priorisierung:** Entscheide, welche du zuerst präsentieren möchtest
  3. **Timing:** Wähle den richtigen Moment für die Präsentation
  4. **Anpassung:** Personalisiere für den spezifischen Kunden
  5. **Follow-up:** Plane, wie du nach der Präsentation nachfasst

  Brauchst du Unterstützung bei einem dieser Schritte?
</next_steps_guidance>

</step>

</process_flow>

## Opportunity Categories

<idea_categories>
  <direct_feature_enhancements>
    - Natural extensions of existing features
    - Feature completeness improvements
    - Advanced versions of basic functionality
    - Premium feature tiers
  </direct_feature_enhancements>

  <new_products>
    - Complementary tools/applications
    - Mobile apps (iOS/Android)
    - Desktop applications
    - Browser extensions
    - API products
  </new_products>

  <infrastructure_improvements>
    - Performance optimization packages
    - Security audit and hardening
    - Monitoring and alerting systems
    - DevOps automation
    - Disaster recovery solutions
  </infrastructure_improvements>

  <integration_services>
    - Third-party integrations
    - Custom API development
    - Webhook systems
    - Data import/export tools
    - Migration services
  </integration_services>

  <analytics_reporting>
    - Custom dashboards
    - Business intelligence tools
    - Advanced reporting
    - Data visualization
    - Predictive analytics
  </analytics_reporting>

  <user_experience_upgrades>
    - Mobile-first redesign
    - Accessibility compliance
    - Internationalization
    - Custom branding
    - White-label solutions
  </user_experience_upgrades>

  <training_support>
    - Training materials/courses
    - Documentation creation
    - Support systems
    - Knowledge base
    - Onboarding programs
  </training_support>
</idea_categories>

## Ideation Strategies

<ideation_techniques>
  <feature_ladder>
    Basic → Standard → Premium → Enterprise
    - Identify current tier
    - Propose upgrades to next tier
  </feature_ladder>

  <workflow_completion>
    - Map existing workflows
    - Find incomplete paths
    - Propose missing steps
  </workflow_completion>

  <integration_expansion>
    - List current integrations
    - Research popular tools in industry
    - Propose new integration opportunities
  </integration_expansion>

  <platform_expansion>
    Web → Mobile → Desktop → API → Embedded
    - Identify current platforms
    - Propose platform extensions
  </platform_expansion>

  <industry_benchmarking>
    - Research competitor features
    - Identify industry standards
    - Find gaps in current offering
  </industry_benchmarking>
</ideation_techniques>

## Discussion Best Practices

<facilitation_guidelines>
  <active_listening>
    - Pay attention to user's priorities
    - Note budget and timeline constraints
    - Understand client relationship dynamics
    - Identify strategic vs tactical needs
  </active_listening>

  <consultative_approach>
    - Ask "why" before proposing "what"
    - Understand business goals
    - Connect technical solutions to business outcomes
    - Be honest about complexity and risks
  </consultative_approach>

  <adaptive_thinking>
    - Adjust ideas based on feedback
    - Combine opportunities when sensible
    - Scale up or down based on appetite
    - Suggest alternatives if needed
  </adaptive_thinking>

  <documentation_timing>
    - NEVER document before discussion
    - ALWAYS wait for user confirmation
    - ONLY document selected opportunities
    - INCLUDE discussion insights
  </documentation_timing>
</facilitation_guidelines>

## Success Metrics

<session_goals>
  - Identified: 10-15 initial opportunities
  - Discussed: 5-8 opportunities in detail
  - Selected: 3-5 opportunities for documentation
  - Documented: ONLY after user confirmation
  - Output: Actionable, client-ready materials
</session_goals>

<quality_indicators>
  - User actively engaged in discussion
  - Ideas refined based on real constraints
  - Clear prioritization emerged
  - Documentation reflects collaborative insights
  - User confident in presenting to client
</quality_indicators>

## Execution Summary

<final_checklist>
  <verify>
    - [ ] Project context gathered thoroughly
    - [ ] Current state analyzed across all dimensions
    - [ ] Initial opportunities prepared (not yet shared in detail)
    - [ ] High-level opportunities presented to user
    - [ ] Interactive discussion conducted
    - [ ] User feedback incorporated
    - [ ] Opportunities collaboratively prioritized
    - [ ] User explicitly confirmed documentation
    - [ ] Documentation created ONLY after confirmation
    - [ ] Review and iteration offered
  </verify>
</final_checklist>

<important_reminders>
  ⚠️ **CRITICAL**: Do NOT create documentation files until:
    1. You have discussed opportunities with the user
    2. User has selected which opportunities to document
    3. User explicitly confirms they want documentation created

  The goal is COLLABORATIVE EXPLORATION first, DOCUMENTATION second.
</important_reminders>
