---
description: Build Development Team with specialized Agents and Skills
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
installation: global
---

# Build Development Team Workflow

Set up a development team of specialized AI agents based on the project's tech stack. Creates agent configurations, generates project-specific skills (for Orchestrator extraction), and establishes quality standards (Definition of Done/Ready).

**v2.0 Changes:**
- Skills are generated in `agent-os/skills/` (not `.claude/skills/`)
- Skills are NOT assigned to agents (no `skills:` in YAML frontmatter)
- Skill-Index is generated for Architect/Orchestrator lookup
- Orchestrator extracts relevant patterns on-demand during execution

<pre_flight_check>
  EXECUTE: @agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="analyze_tech_stack">

### Step 1: Analyze Tech Stack

Load and analyze tech-stack.md to determine required agents.

<conditional_logic>
  IF agent-os/product/tech-stack.md exists:
    LOAD: tech-stack.md
    ANALYZE: Technologies in use
    PROCEED to step 2
  ELSE:
    INFORM user: "No tech-stack.md found. Please run /plan-product or /analyze-product first."
    EXIT workflow
</conditional_logic>

**Detection Rules:**
- Java/Spring → Backend Agent with Java skills
- Node.js/Express → Backend Agent with Node skills
- React/Vue/Angular → Frontend Agent with respective skills
- Docker/K8s → DevOps Agent
- PostgreSQL/MongoDB → Database-related skills

</step>

<step number="2" subagent="file-creator" name="create_core_team">

### Step 2: Create Core Team (Always Required)

Create the core team agents that are required for ALL projects: Architect, PO, and Documenter.

**Core Team (Automatically Created):**

**1. dev-team__architect**
- Load template: ~/.agent-os/templates/agents/dev-team/architect-template.md
- Role: Software architect, design decisions, pattern enforcement
- Output: .claude/agents/dev-team/architect.md

**2. dev-team__po**
- Load template: ~/.agent-os/templates/agents/dev-team/po-template.md
- Role: Product owner, requirements, user stories, acceptance
- Output: .claude/agents/dev-team/po.md

**3. dev-team__documenter**
- Load template: ~/.agent-os/templates/agents/dev-team/documenter-template.md
- Role: Documentation specialist, changelog, API docs, user guides
- Output: .claude/agents/dev-team/documenter.md

**NOTE:** Skills are NOT assigned to agents. Skills are generated separately in `agent-os/skills/` for Orchestrator extraction.

**NOTE:** These 3 agents are ALWAYS created. User does not choose - they are mandatory for the DevTeam workflow.

<template_lookup>
  For all agent templates:
  1. TRY: agent-os/templates/agents/dev-team/[agent]-template.md (project)
  2. FALLBACK: ~/.agent-os/templates/agents/dev-team/[agent]-template.md (global)
</template_lookup>

</step>

<step number="3" name="select_additional_agents">

### Step 3: Select Additional Agents

Present agent options based on tech stack.

**Prompt User with AskUserQuestion:**
```
Based on your tech stack, I recommend these development agents:

Core Team (already created automatically):
✅ dev-team__architect
✅ dev-team__po
✅ dev-team__documenter

Additional Development Agents (select which you need):
- Backend Developer → [DETECTED_BACKEND_TECH] detected
- Frontend Developer → [DETECTED_FRONTEND_TECH] detected
- DevOps Specialist → CI/CD, infrastructure, deployment
- QA Specialist → Testing, quality gates, test automation

Which additional agents do you want?
(You can add multiple instances of Backend/Frontend for parallel work)
```

**Options Structure:**
```typescript
{
  question: "Which development agents do you want in your team?",
  header: "Dev Agents",
  multiSelect: true,
  options: [
    { label: "Backend Developer", description: "API, services, data access, business logic" },
    { label: "Frontend Developer", description: "UI components, state, interactions, pages" },
    { label: "DevOps Specialist", description: "CI/CD, infrastructure, deployment, monitoring" },
    { label: "QA Specialist", description: "Testing strategy, test automation, quality gates" }
  ]
}
```

**NOTE:** PO removed from options - it's created automatically in Step 2.

**Store:** Selected agents for creation

</step>

<step number="4" name="configure_agent_count">

### Step 4: Configure Agent Instances

For selected developer agents, ask about multiple instances.

**Prompt User (if Backend or Frontend selected):**
```
You selected [AGENT_TYPE] Agent.

For parallel development, you can have multiple instances:
- 1 instance: Sequential development
- 2 instances: Parallel feature development
- 3+ instances: Large team simulation

How many [AGENT_TYPE] agents do you want?
```

**Store:** Instance count per agent type

</step>

<step number="5" subagent="file-creator" name="create_selected_agents">

### Step 5: Create Selected Agents

Create agent configurations for each selected agent.

**Agent Creation Process:**

For each selected agent:
1. Load template from `~/.agent-os/templates/agents/dev-team/[agent]-template.md`
2. Fill placeholders: [PROJECT_NAME], [TIMESTAMP]
3. Write to `.claude/agents/dev-team/[agent].md`

**NOTE:** Agents are created WITHOUT skills assignment. The `## Skill-Context` section in templates explains that:
- Architect selects relevant skills per story (from skill-index.md)
- Orchestrator extracts patterns and provides them in task prompts

**Output:** `.claude/agents/dev-team/[agent-name].md` for each selected agent

</step>

<step number="6" subagent="file-creator" name="generate_skills">

### Step 6: Generate Tech-Stack-Specific Skills (for Orchestrator Extraction)

Generate project-specific skills in `agent-os/skills/`. These skills are NOT loaded by sub-agents, but read on-demand by the Orchestrator during task execution.

**Output Directory:** `agent-os/skills/` (flat structure, no subfolders)

<skill_generation_process>
  CREATE directory: agent-os/skills/ (if not exists)

  FOR EACH created agent, generate skills:

    **dev-team__architect (5 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/architect/:
    1. pattern-enforcement → agent-os/skills/architect-pattern-enforcement.md
    2. api-designing → agent-os/skills/architect-api-designing.md
    3. security-guidance → agent-os/skills/architect-security-guidance.md
    4. data-modeling → agent-os/skills/architect-data-modeling.md
    5. dependency-checking → agent-os/skills/architect-dependency-checking.md

    **dev-team__backend-developer (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/backend/:
    1. logic-implementing → agent-os/skills/backend-logic-implementing.md
    2. persistence-adapter → agent-os/skills/backend-persistence-adapter.md
    3. integration-adapter → agent-os/skills/backend-integration-adapter.md
    4. test-engineering → agent-os/skills/backend-test-engineering.md

    **dev-team__frontend-developer (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/frontend/:
    1. ui-component-architecture → agent-os/skills/frontend-ui-component-architecture.md
    2. state-management → agent-os/skills/frontend-state-management.md
    3. api-bridge-building → agent-os/skills/frontend-api-bridge-building.md
    4. interaction-designing → agent-os/skills/frontend-interaction-designing.md

    **dev-team__devops-specialist (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/devops/:
    1. infrastructure-provisioning → agent-os/skills/devops-infrastructure-provisioning.md
    2. pipeline-engineering → agent-os/skills/devops-pipeline-engineering.md
    3. observability → agent-os/skills/devops-observability.md
    4. security-hardening → agent-os/skills/devops-security-hardening.md

    **dev-team__qa-specialist (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/qa/:
    1. test-strategy → agent-os/skills/qa-test-strategy.md
    2. test-automation → agent-os/skills/qa-test-automation.md
    3. quality-gates → agent-os/skills/qa-quality-gates.md
    4. test-analysis → agent-os/skills/qa-test-analysis.md

    **dev-team__po (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/po/:
    1. backlog-organization → agent-os/skills/po-backlog-organization.md
    2. requirements-engineering → agent-os/skills/po-requirements-engineering.md
    3. acceptance-testing → agent-os/skills/po-acceptance-testing.md
    4. data-analysis → agent-os/skills/po-data-analysis.md

    **dev-team__documenter (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/documenter/:
    1. changelog-generation → agent-os/skills/documenter-changelog-generation.md
    2. api-documentation → agent-os/skills/documenter-api-documentation.md
    3. user-guide-writing → agent-os/skills/documenter-user-guide-writing.md
    4. code-documentation → agent-os/skills/documenter-code-documentation.md
</skill_generation_process>

<skill_content_assembly>
  FOR EACH skill:
    1. LOAD skill template (hybrid lookup: project → global)
    2. READ tech-stack.md for framework information
    3. CUSTOMIZE template content:
       - FILL [TECH_STACK_SPECIFIC] sections with actual patterns for detected framework
       - FILL [SKILL_NAME] placeholder
       - FILL [CURRENT_DATE] with today's date
       - FILL [FRAMEWORK] with detected framework
    4. ENSURE skill has "## Quick Reference" section at top (for Orchestrator extraction)
    5. WRITE to agent-os/skills/[role]-[skill-name].md

    **Final file structure:**
    ```markdown
    # Backend Logic Implementing

    > Project: [PROJECT_NAME]
    > Framework: Ruby on Rails
    > Generated: 2026-01-17

    ## Quick Reference
    <!-- This section is extracted by Orchestrator for task prompts -->

    **When to use:** Service Objects, Business Logic, Domain Operations

    **Key Patterns:**
    1. Service Object: One class per use case, `call` method as entry point
    2. Validation: Fail fast at start of `call` method
    3. Error Handling: Custom exceptions for business errors

    **Example:**
    ```ruby
    class Users::Register
      def call(params)
        validate!(params)
        user = User.create!(params)
        Result.success(user: user)
      end
    end
    ```

    ---

    ## Detailed Patterns
    [... rest of skill content ...]
    ```
</skill_content_assembly>

<template_lookup>
  For all skill templates:
  1. TRY: agent-os/templates/skills/dev-team/[role]/[skill]/SKILL.md
  2. FALLBACK: ~/.agent-os/templates/skills/dev-team/[role]/[skill]/SKILL.md

  For base skill template (if specific not found):
  1. TRY: agent-os/templates/skills/skill/SKILL.md
  2. FALLBACK: ~/.agent-os/templates/skills/skill/SKILL.md
</template_lookup>

<verification>
  AFTER generating all skills:
    1. VERIFY each skill file exists in agent-os/skills/
    2. VERIFY each skill has "## Quick Reference" section
    3. VERIFY no unresolved placeholders remain
    4. REPORT: Number of skills generated, list of skill names
</verification>

**Output:**
- Skills created in `agent-os/skills/[role]-[skill-name].md`
- Each skill is tech-stack-aware (framework-specific patterns)
- Each skill has "## Quick Reference" section for Orchestrator extraction
- Skills are NOT loaded by sub-agents (no globs, no auto-activation)

</step>

<step number="6.5" subagent="tech-architect" name="detect_custom_skills">

### Step 6.5: Detect and Generate Custom Skills (MANDATORY)

ALWAYS use tech-architect agent to analyze tech-stack.md for specialized technologies requiring custom skills.

<custom_skill_detection>
  DELEGATE to tech-architect via Task tool:

  PROMPT:
  "Analyze tech-stack.md for specialized technologies requiring custom skills.

  Context:
  - Tech Stack: agent-os/product/tech-stack.md
  - Standard Skills: 29 skills already generated from templates

  Task:
  1. READ tech-stack.md thoroughly

  2. Identify specialized technologies/libraries:

     **Blockchain/Crypto:**
     - ethers.js, web3.js, @solana/web3.js, wagmi
     - Wallet management, key signing
     - DEX/CEX integrations (Uniswap, CCXT)

     **Desktop/Electron:**
     - Electron framework
     - IPC communication
     - Native modules (node-keytar, better-sqlite3)
     - Electron-specific testing

     **ML/AI:**
     - TensorFlow, PyTorch, OpenAI API
     - Model training, inference
     - Data pipelines

     **IoT:**
     - MQTT, CoAP protocols
     - Device communication
     - Sensor data processing

     **Game Development:**
     - Unity, Unreal Engine
     - Game logic, physics

     **Specialized APIs:**
     - Payment (Stripe, PayPal)
     - Communication (Twilio, SendGrid)
     - Maps/Location (Google Maps, Mapbox)

     **Real-time/WebSockets:**
     - Socket.io, WebRTC
     - Real-time sync patterns

  3. For EACH category found, determine custom skills needed:

     **Blockchain/Crypto found:**
     - → custom-blockchain-integration.md
     - → custom-wallet-management.md
     - → custom-dex-integration.md
     - → custom-crypto-security-testing.md

     **Electron/Desktop found:**
     - → custom-electron-testing.md
     - → custom-native-module-integration.md

     **ML/AI found:**
     - → custom-model-training.md
     - → custom-ml-pipeline.md

  4. ALWAYS ask user (even if nothing detected):
     'I analyzed your tech stack ([DETECTED_TECH]).

     Recommended Custom Skills:
     [IF detected, list recommendations]

     Create these custom skills? (YES/NO)

     If NO or no specialized tech detected:
     Standard skills are sufficient.'

  5. If YES, for each custom skill:
     - Load generic-skill-template.md (hybrid lookup: project → global)
     - Research best practices online (WebSearch for library/framework patterns)
     - Fill [SKILL_NAME] with descriptive name
     - Fill [TECH_STACK_SPECIFIC] with:
       * Framework/library patterns
       * Code examples (from docs or best practices)
       * Testing patterns
       * Security considerations
       * Performance tips
     - Add "## Quick Reference" section at top (for Orchestrator extraction)
     - Create quality checklist specific to technology
     - WRITE to agent-os/skills/custom-[skill-name].md

  6. Return:
     - List of created custom skills
     - Brief description what each skill does"

  WAIT for tech-architect completion
  RECEIVE custom skills (if any)
  NOTE: Custom skills created for specialized technologies
</custom_skill_detection>

<template_lookup>
  Generic skill template:
  1. TRY: agent-os/templates/skills/generic-skill-template.md (project)
  2. FALLBACK: ~/.agent-os/templates/skills/generic-skill-template.md (global)
</template_lookup>

**Examples of Custom Skills:**

**For Crypto Trading Bot (Electron Desktop):**
- agent-os/skills/custom-electron-testing.md
- agent-os/skills/custom-blockchain-integration.md
- agent-os/skills/custom-wallet-management.md
- agent-os/skills/custom-crypto-security-testing.md

**For ML Application:**
- agent-os/skills/custom-model-training.md
- agent-os/skills/custom-data-pipeline.md

**For IoT Platform:**
- agent-os/skills/custom-device-communication.md
- agent-os/skills/custom-sensor-data-processing.md

**Output:**
- Custom skills in `agent-os/skills/custom-[skill-name].md`
- Each skill has "## Quick Reference" section for Orchestrator extraction

</step>

<step number="6.6" subagent="file-creator" name="create_design_system_skill">

### Step 6.6: Create Design System Skill for Frontend (If Applicable)

If design-system.md exists, create a skill for frontend developers.

<conditional_logic>
  IF agent-os/product/design-system.md EXISTS:

    USE file-creator to create design-system skill:

    WRITE to: agent-os/skills/frontend-design-system.md

    Content:
    ```markdown
    # Frontend Design System Skill

    > Project: [PROJECT_NAME]
    > Source: agent-os/product/design-system.md
    > Generated: [CURRENT_DATE]

    ## Quick Reference
    <!-- This section is extracted by Orchestrator for task prompts -->

    **When to use:** UI components, styling, visual elements

    **Key Patterns:**
    1. Use defined color palette (no random colors)
    2. Follow typography scale (no arbitrary font sizes)
    3. Use spacing scale (no magic numbers)
    4. Reuse defined components

    **Reference:** agent-os/product/design-system.md

    ---

    ## Detailed Patterns

    ### Colors
    [Extract from design-system.md]

    ### Typography
    [Extract from design-system.md]

    ### Spacing
    [Extract from design-system.md]

    ### Components
    [Extract component catalog from design-system.md]

    ## Quality Checklist
    - [ ] Uses colors from design-system.md
    - [ ] Follows typography scale
    - [ ] Uses spacing tokens
    - [ ] Matches component patterns
    - [ ] Accessibility maintained (contrast ratios)
    ```

  ELSE:
    NOTE: "No design-system.md found, skipping design system skill"
</conditional_logic>

**Output:** `agent-os/skills/frontend-design-system.md` (if design-system.md exists)

</step>

<step number="6.7" subagent="file-creator" name="create_ux_patterns_skill">

### Step 6.7: Create UX Patterns Skill for Frontend (If Applicable)

If ux-patterns.md exists, create a skill for frontend developers.

<conditional_logic>
  IF agent-os/product/ux-patterns.md EXISTS:

    USE file-creator to create ux-patterns skill:

    WRITE to: agent-os/skills/frontend-ux-patterns.md

    Content:
    ```markdown
    # Frontend UX Patterns Skill

    > Project: [PROJECT_NAME]
    > Source: agent-os/product/ux-patterns.md
    > Generated: [CURRENT_DATE]

    ## Quick Reference
    <!-- This section is extracted by Orchestrator for task prompts -->

    **When to use:** User interfaces, navigation, forms, interactions, loading/error states

    **Key Patterns:**
    1. Follow defined navigation pattern consistently
    2. Provide clear feedback for all states (loading, success, error, empty)
    3. Ensure keyboard navigation works
    4. Meet accessibility requirements (WCAG level)

    **Reference:** agent-os/product/ux-patterns.md

    ---

    ## Detailed Patterns

    ### Navigation Patterns
    [Extract navigation type and structure from ux-patterns.md]

    ### User Flow Patterns
    [Extract key user flows from ux-patterns.md]

    ### Interaction Patterns
    [Extract button, form, and interaction patterns from ux-patterns.md]

    ### Feedback Patterns
    [Extract loading, success, error, and empty state patterns from ux-patterns.md]

    ### Mobile Patterns (if applicable)
    [Extract mobile-specific patterns from ux-patterns.md]

    ### Accessibility Requirements
    [Extract accessibility patterns and WCAG level from ux-patterns.md]

    ## Quality Checklist
    - [ ] Navigation follows defined pattern
    - [ ] User flows intuitive and match specs
    - [ ] Loading states implemented (no blank screens)
    - [ ] Success feedback clear and timely
    - [ ] Error messages helpful and actionable
    - [ ] Empty states friendly with clear next action
    - [ ] Keyboard navigation works
    - [ ] Focus indicators visible
    - [ ] Color contrast meets WCAG level
    - [ ] Touch targets minimum 44x44px (mobile)
    - [ ] Responsive on all screen sizes
    ```

  ELSE:
    NOTE: "No ux-patterns.md found, skipping UX patterns skill"
</conditional_logic>

**Output:** `agent-os/skills/frontend-ux-patterns.md` (if ux-patterns.md exists)

</step>

<step number="7" subagent="file-creator" name="generate_skill_index">

### Step 7: Generate Skill-Index for Orchestrator/Architect

Create a skill-index.md file that serves as a lookup table for the Architect (during technical refinement) and Orchestrator (during task execution).

<skill_index_generation>
  CREATE: agent-os/team/skill-index.md

  CONTENT:
  ```markdown
  # Skill Index

  > Project: [PROJECT_NAME]
  > Generated: [CURRENT_DATE]
  > Purpose: Lookup table for Architect and Orchestrator skill selection

  ## How to Use

  **For Architect (Technical Refinement):**
  1. Review story requirements
  2. Find matching skills by trigger keywords
  3. Add skill paths to story's "Skills" section

  **For Orchestrator (Task Execution):**
  1. Read skill paths from story
  2. Load only "## Quick Reference" section from each skill
  3. Include patterns in task prompt for sub-agent

  ---

  ## Skill Catalog

  ### Backend Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Logic Implementing | agent-os/skills/backend-logic-implementing.md | service objects, business logic, use cases |
  | Persistence Adapter | agent-os/skills/backend-persistence-adapter.md | database, models, queries, migrations |
  | Integration Adapter | agent-os/skills/backend-integration-adapter.md | external APIs, HTTP clients, webhooks |
  | Test Engineering | agent-os/skills/backend-test-engineering.md | unit tests, integration tests, fixtures |

  ### Frontend Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | UI Component Architecture | agent-os/skills/frontend-ui-component-architecture.md | components, props, composition |
  | State Management | agent-os/skills/frontend-state-management.md | state, context, stores, reducers |
  | API Bridge Building | agent-os/skills/frontend-api-bridge-building.md | API calls, data fetching, caching |
  | Interaction Designing | agent-os/skills/frontend-interaction-designing.md | forms, validation, user input |

  ### Architect Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Pattern Enforcement | agent-os/skills/architect-pattern-enforcement.md | architecture review, pattern compliance |
  | API Designing | agent-os/skills/architect-api-designing.md | API design, endpoints, contracts |
  | Security Guidance | agent-os/skills/architect-security-guidance.md | security review, authentication, authorization |
  | Data Modeling | agent-os/skills/architect-data-modeling.md | data models, schemas, relationships |
  | Dependency Checking | agent-os/skills/architect-dependency-checking.md | dependencies, versions, conflicts |

  ### DevOps Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Infrastructure Provisioning | agent-os/skills/devops-infrastructure-provisioning.md | infrastructure, servers, cloud |
  | Pipeline Engineering | agent-os/skills/devops-pipeline-engineering.md | CI/CD, pipelines, deployment |
  | Observability | agent-os/skills/devops-observability.md | logging, monitoring, alerts |
  | Security Hardening | agent-os/skills/devops-security-hardening.md | security, hardening, compliance |

  ### QA Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Test Strategy | agent-os/skills/qa-test-strategy.md | test planning, coverage, strategy |
  | Test Automation | agent-os/skills/qa-test-automation.md | automated tests, E2E, frameworks |
  | Quality Gates | agent-os/skills/qa-quality-gates.md | quality checks, gates, thresholds |
  | Test Analysis | agent-os/skills/qa-test-analysis.md | test results, failures, analysis |

  ### PO Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Backlog Organization | agent-os/skills/po-backlog-organization.md | backlog, prioritization, grooming |
  | Requirements Engineering | agent-os/skills/po-requirements-engineering.md | requirements, user stories, acceptance |
  | Acceptance Testing | agent-os/skills/po-acceptance-testing.md | acceptance tests, validation, sign-off |
  | Data Analysis | agent-os/skills/po-data-analysis.md | analytics, metrics, data |

  ### Documenter Skills

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Changelog Generation | agent-os/skills/documenter-changelog-generation.md | changelog, release notes, versions |
  | API Documentation | agent-os/skills/documenter-api-documentation.md | API docs, endpoints, OpenAPI |
  | User Guide Writing | agent-os/skills/documenter-user-guide-writing.md | user guides, tutorials, how-to |
  | Code Documentation | agent-os/skills/documenter-code-documentation.md | code comments, docstrings, README |

  ### Custom Skills (Project-Specific)

  [Auto-populated from Step 6.5 if custom skills were generated]

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | [custom-skill-1] | agent-os/skills/custom-[name].md | [keywords] |

  ### Design/UX Skills (If Applicable)

  [Auto-populated from Steps 6.6/6.7 if design-system.md or ux-patterns.md exist]

  | Skill | Path | Trigger Keywords |
  |-------|------|------------------|
  | Design System | agent-os/skills/frontend-design-system.md | colors, typography, spacing, components |
  | UX Patterns | agent-os/skills/frontend-ux-patterns.md | navigation, user flows, interactions, states |
  ```
</skill_index_generation>

<dynamic_content>
  ONLY include skill sections for agents that were created:
  - IF no backend-developer → OMIT "### Backend Skills" section
  - IF no frontend-developer → OMIT "### Frontend Skills" section
  - IF no devops-specialist → OMIT "### DevOps Skills" section
  - IF no qa-specialist → OMIT "### QA Skills" section
  - IF no custom skills → OMIT "### Custom Skills" section
  - IF no design-system.md → OMIT Design System row
  - IF no ux-patterns.md → OMIT UX Patterns row
</dynamic_content>

<verification>
  AFTER generating skill-index.md:
    1. VERIFY file exists at agent-os/team/skill-index.md
    2. VERIFY all generated skills are listed
    3. VERIFY paths match actual skill file locations
    4. REPORT: "Skill-Index created with [N] skills catalogued"
</verification>

**Output:** `agent-os/team/skill-index.md`

</step>

<step number="8" subagent="file-creator" name="create_definition_of_done">

### Step 8: Create Definition of Done

Generate Definition of Done based on tech stack and team.

<instructions>
  ACTION: Use file-creator agent to create dod.md

  TARGET DIRECTORY: agent-os/team/ (NOT .agent-os/team/!)

  PROCESS:
    1. CREATE directory: agent-os/team/ (if not exists)
    2. LOAD template with hybrid lookup:
       - TRY: agent-os/templates/docs/dod-template.md
       - FALLBACK: ~/.agent-os/templates/docs/dod-template.md
    3. CUSTOMIZE template:
       - [TESTING_FRAMEWORK]: From tech-stack.md
       - [LINTER]: From tech-stack.md
       - [QUALITY_GATES]: Based on selected agents
       - [ARCHITECTURE_COMPLIANCE]: From architecture-decision.md
    4. WRITE to: agent-os/team/dod.md
    5. VERIFY: File was created in agent-os/team/ (not .agent-os/)

  CRITICAL: Output path is agent-os/team/dod.md (with leading 'a', not dot!)
</instructions>

**Prompt User:**
```
I've created a Definition of Done for your project.

Please review: agent-os/team/dod.md

Key quality gates:
- Code compiles without errors
- Unit test coverage: [X]%
- [DETECTED_LINTER] passes
- Code review by [N] team member(s)
- Architecture compliance verified

Adjust any criteria?
```

**Output:** `agent-os/team/dod.md`

</step>

<step number="9" subagent="file-creator" name="create_definition_of_ready">

### Step 9: Create Definition of Ready

Generate Definition of Ready for user stories.

<instructions>
  ACTION: Use file-creator agent to create dor.md

  TARGET DIRECTORY: agent-os/team/ (NOT .agent-os/team/!)

  PROCESS:
    1. VERIFY directory exists: agent-os/team/
    2. LOAD template with hybrid lookup:
       - TRY: agent-os/templates/docs/dor-template.md
       - FALLBACK: ~/.agent-os/templates/docs/dor-template.md
    3. CUSTOMIZE template:
       - [APPROVER_ROLE]: Based on selected agents (usually Architect)
       - [TECHNICAL_REQUIREMENTS]: From architecture-decision.md
       - [ESTIMATION_REQUIREMENTS]: Team process
    4. WRITE to: agent-os/team/dor.md
    5. VERIFY: File was created in agent-os/team/ (not .agent-os/)

  CRITICAL: Output path is agent-os/team/dor.md (with leading 'a', not dot!)
</instructions>

**Prompt User:**
```
I've created a Definition of Ready for user stories.

Please review: agent-os/team/dor.md

Key readiness criteria:
- User story format complete
- Acceptance criteria defined (3+ criteria)
- Estimated by team
- No blocking dependencies
- [ROLE] approved

Adjust any criteria?
```

**Output:** `agent-os/team/dor.md`

</step>

<step number="10" name="summary">

### Step 10: Team Summary

Present team configuration summary.

**Summary:**
```
Development Team Ready! (v2.0)

Team Composition:
✅ Architecture Agent (required)
✅ PO Agent (required)
✅ Documenter Agent (required)
[✅ Backend Developer Agent x [N]] (if selected)
[✅ Frontend Developer Agent x [N]] (if selected)
[✅ DevOps Specialist Agent] (if selected)
[✅ QA Specialist Agent] (if selected)

Agent Configurations: .claude/agents/dev-team/

Skills Generated: agent-os/skills/
Skill Index: agent-os/team/skill-index.md

Quality Standards:
✅ Definition of Done: agent-os/team/dod.md
✅ Definition of Ready: agent-os/team/dor.md

How Skills Work (v2.0):
1. Architect reads skill-index.md during technical refinement
2. Architect selects relevant skills for each story
3. Orchestrator extracts "Quick Reference" section from selected skills
4. Orchestrator includes patterns in task prompts for sub-agents
5. Sub-agents receive only relevant patterns, not full skills

Next Steps:
1. Review agent configurations in .claude/agents/dev-team/
2. Run /create-spec to start first feature
3. Agents will be involved automatically during development
```

</step>

</process_flow>

## Agent Overview

| Agent | Required | Purpose |
|-------|----------|---------|
| Architect | Yes | Design & patterns |
| PO | Yes | Requirements & acceptance |
| Documenter | Yes | Documentation & changelog |
| Backend Developer | Optional | API & services |
| Frontend Developer | Optional | UI & interactions |
| DevOps Specialist | Optional | CI/CD & infra |
| QA Specialist | Optional | Testing & quality |

## Multiple Instances

Backend and Frontend agents can be instantiated multiple times:
- `backend-dev-1.md`, `backend-dev-2.md`
- `frontend-dev-1.md`, `frontend-dev-2.md`

This enables parallel development of different features.

## Output Files

| File | Location | Description |
|------|----------|-------------|
| Agent configs | `.claude/agents/dev-team/` | Agent definitions (no skills assigned) |
| Skills | `agent-os/skills/` | Project-specific skill patterns |
| Skill Index | `agent-os/team/skill-index.md` | Skill lookup table for Architect/Orchestrator |
| Definition of Done | `agent-os/team/dod.md` | Quality standards |
| Definition of Ready | `agent-os/team/dor.md` | Story readiness |

## Skill Loading Architecture (v2.0)

**Key Change:** Skills are NOT loaded by sub-agents at startup.

**Flow:**
1. `build-development-team` generates skills in `agent-os/skills/`
2. `build-development-team` generates `skill-index.md` as lookup table
3. During `/create-spec`, Architect reads `skill-index.md` and selects relevant skills per story
4. During `/execute-tasks`, Orchestrator reads only "Quick Reference" section from selected skills
5. Orchestrator includes extracted patterns in task prompts for sub-agents
6. Sub-agents receive ~50-100 lines of relevant patterns instead of ~2700 lines of all skills

**Benefits:**
- Reduced context usage (~95% reduction)
- Faster sub-agent startup
- More focused task prompts
- Project-specific patterns preserved

## Execution Summary

**Duration:** 10-15 minutes
**User Interactions:** 2-3 decision points
**Output:** 3-7 agent files + skills + skill-index + 2 quality documents
