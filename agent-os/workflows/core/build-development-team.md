---
description: Build Development Team with specialized Agents and Skills
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
installation: global
---

# Build Development Team Workflow

Set up a development team of specialized AI agents based on the project's tech stack. Creates agent configurations, assigns relevant skills, and establishes quality standards (Definition of Done/Ready).

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
- Skills: pattern-enforcement, api-designing, security-guidance, data-modeling, dependency-checking
- Output: .claude/agents/dev-team/architect.md

**2. dev-team__po**
- Load template: ~/.agent-os/templates/agents/dev-team/po-template.md
- Role: Product owner, requirements, user stories, acceptance
- Skills: backlog-organization, requirements-engineering, acceptance-testing, data-analysis
- Output: .claude/agents/dev-team/po.md

**3. dev-team__documenter**
- Load template: ~/.agent-os/templates/agents/dev-team/documenter-template.md
- Role: Documentation specialist, changelog, API docs, user guides
- Skills: changelog-generation, api-documentation, user-guide-writing, code-documentation
- Output: .claude/agents/dev-team/documenter.md

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

**Backend Developer Agent:**
```markdown
# Backend Developer Agent

## Role
Backend development specialist for API and service implementation.

## Skills
- logic-implementer
- persistence-adapter
- integration-adapter
- test-engineer

## Tech Stack Skills (Auto-loaded based on tech-stack.md)
[IF Java/Spring]: java-core-patterns, spring-boot-conventions, jpa-best-practices
[IF Node/Express]: node-patterns, express-conventions
[IF Python/Django]: python-patterns, django-conventions

## Global Skills
- git-master
- security-best-practices
- testing-best-practices
```

**Frontend Developer Agent:**
```markdown
# Frontend Developer Agent

## Role
Frontend development specialist for UI and user experience.

## Skills
- ui-component-architect
- state-manager
- api-bridge-builder
- interaction-designer

## Tech Stack Skills (Auto-loaded)
[IF React]: react-component-patterns, react-hooks-best-practices, typescript-react-patterns
[IF Angular]: angular-component-patterns, angular-services-patterns, rxjs-best-practices
[IF Vue]: vue-component-patterns, vue-composition-api

## Global Skills
- git-master
- security-best-practices
- testing-best-practices
```

**DevOps Specialist Agent:**
```markdown
# DevOps Specialist Agent

## Role
Infrastructure and deployment automation specialist.

## Skills
- infrastructure-provisioner
- pipeline-engineer
- observability-expert
- security-hardener

## Global Skills
- git-master
- security-best-practices
```

**QA Specialist Agent:**
```markdown
# QA Specialist Agent

## Role
Quality assurance and testing specialist.

## Skills
- test-engineer
- testing-best-practices

## Responsibilities
- Test strategy definition
- Test execution and analysis
- Quality gate enforcement
- Auto-fix coordination
```

**PO Agent:**
```markdown
# PO Agent

## Role
Product ownership and requirements management.

## Skills
- backlog-strategist
- requirements-engineer
- acceptance-tester
- data-analyst

## Responsibilities
- User story creation
- Backlog prioritization
- Acceptance testing
- Success metrics tracking
```

**Output:** `.claude/agents/[agent-name].md` for each selected agent

</step>

<step number="6" subagent="file-creator" name="generate_skills">

### Step 6: Generate Tech-Stack-Specific Skills

Use file-creator agent to generate skills for each created agent from skill templates.

<skill_generation_process>
  FOR EACH created agent:

    **dev-team__architect (5 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/architect/:
    1. pattern-enforcement-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-architect-pattern-enforcement.md
    2. api-designing-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-architect-api-designing.md
    3. security-guidance-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-architect-security-guidance.md
    4. data-modeling-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-architect-data-modeling.md
    5. dependency-checking-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-architect-dependency-checking.md

    **dev-team__backend-developer (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/backend/:
    1. logic-implementing-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-backend-logic-implementing.md
    2. persistence-adapter-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-backend-persistence-adapter.md
    3. integration-adapter-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-backend-integration-adapter.md
    4. test-engineering-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-backend-test-engineering.md

    **dev-team__frontend-developer (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/frontend/:
    1. ui-component-architecture-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-frontend-ui-component-architecture.md
    2. state-management-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-frontend-state-management.md
    3. api-bridge-building-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-frontend-api-bridge-building.md
    4. interaction-designing-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-frontend-interaction-designing.md

    **dev-team__devops-specialist (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/devops/:
    1. infrastructure-provisioning-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-devops-infrastructure-provisioning.md
    2. pipeline-engineering-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-devops-pipeline-engineering.md
    3. observability-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-devops-observability.md
    4. security-hardening-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-devops-security-hardening.md

    **dev-team__qa-specialist (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/qa/:
    1. test-strategy-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-qa-test-strategy.md
    2. test-automation-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-qa-test-automation.md
    3. quality-gates-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-qa-quality-gates.md
    4. test-analysis-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-qa-test-analysis.md

    **dev-team__po (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/po/:
    1. backlog-organization-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-po-backlog-organization.md
    2. requirements-engineering-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-po-requirements-engineering.md
    3. acceptance-testing-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-po-acceptance-testing.md
    4. data-analysis-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-po-data-analysis.md

    **dev-team__documenter (4 skills):**
    Load templates from ~/.agent-os/templates/skills/dev-team/documenter/:
    1. changelog-generation-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-documenter-changelog-generation.md
    2. api-documentation-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-documenter-api-documentation.md
    3. user-guide-writing-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-documenter-user-guide-writing.md
    4. code-documentation-template.md + tech-stack.md → .claude/skills/dev-team/[PROJECT]-documenter-code-documentation.md
</skill_generation_process>

<skill_customization>
  FOR EACH skill template:
    1. LOAD skill template (hybrid lookup: project → global)
    2. READ tech-stack.md for framework information
    3. FILL [TECH_STACK_SPECIFIC] sections with actual patterns:
       - Rails projects → Ruby/RSpec patterns
       - React projects → TypeScript/Jest patterns
       - Node.js projects → JavaScript/TS patterns
    4. FILL [MCP_TOOLS] placeholder (ask user or use recommendations)
    5. WRITE to .claude/skills/dev-team/[PROJECT]-[agent]-[skill].md
</skill_customization>

<template_lookup>
  For all skill templates:
  1. TRY: agent-os/templates/skills/dev-team/[role]/[skill]-template.md
  2. FALLBACK: ~/.agent-os/templates/skills/dev-team/[role]/[skill]-template.md
</template_lookup>

**Output:**
- Created skills in `.claude/skills/dev-team/`
- Each skill is tech-stack-aware
- [PROJECT] is derived from project name or tech stack

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
     - → blockchain-integration.md (ethers.js, web3.js patterns)
     - → wallet-management.md (key storage, signing)
     - → dex-integration.md (Uniswap, PancakeSwap)
     - → crypto-security-testing.md (for QA)

     **Electron/Desktop found:**
     - → electron-testing.md (IPC, main/renderer, E2E with Playwright for Electron)
     - → native-module-integration.md (keytar, sqlite, native bindings)

     **ML/AI found:**
     - → model-training.md
     - → ml-pipeline.md

  4. ALWAYS ask user (even if nothing detected):
     'I analyzed your tech stack ([DETECTED_TECH]).

     Recommended Custom Skills:
     [IF detected, list with MCP recommendations:]

     Example for Electron + Blockchain:
     - electron-testing (QA) → MCP: playwright, electron-test-utils
     - blockchain-integration (Backend) → MCP: none needed
     - wallet-management (Backend) → MCP: none needed
     - crypto-security-testing (QA) → MCP: security-scanner

     MCP Servers to install for these skills:
     - playwright (for E2E testing)
     - electron-test-utils (for Electron testing)

     Create these custom skills? (YES/NO)

     If NO or no specialized tech detected:
     Standard skills are sufficient.'
     'I detected specialized technologies in your tech stack:
     - [Technology 1]: [Purpose]
     - [Technology 2]: [Purpose]

     Create custom skills for these? (YES/NO)'

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
     - Fill [MCP_TOOLS] with SPECIFIC recommendations:
       Examples:
       * electron-testing → playwright, chrome-devtools
       * blockchain-integration → (no MCP needed, use ethers.js directly)
       * crypto-security-testing → security-scanner, vulnerability-db
     - Add installation instructions for MCP tools
     - Create quality checklist specific to technology
     - Write to .claude/skills/dev-team/[PROJECT]-[agent]-[custom-skill].md

  6. Present MCP Installation Guide to user:
     'Custom skills created!

     MCP Servers recommended for your custom skills:
     - playwright (E2E testing for Electron)
       Install: https://github.com/microsoft/playwright
     - security-scanner (Crypto security testing)
       Install: [URL]

     Would you like installation instructions? (yes/no)'

  7. Return:
     - List of created custom skills
     - List of recommended MCP servers with install links
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
- electron-testing.md (QA) → Electron E2E, IPC testing, native modules
  MCP: playwright, electron-test-utils
- blockchain-integration.md (Backend) → ethers.js, web3.js, Solana patterns
  MCP: none needed
- wallet-management.md (Backend) → Key storage, signing, security
  MCP: none needed
- crypto-security-testing.md (QA) → Encryption, keychain, vulnerability testing
  MCP: security-scanner

**For ML Application:**
- model-training.md (TensorFlow/PyTorch patterns)
- data-pipeline.md (ETL, preprocessing)

**For IoT Platform:**
- device-communication.md (MQTT, CoAP)
- sensor-data-processing.md

**Output:**
- Custom skills in `.claude/skills/dev-team/[PROJECT]-[agent]-[custom-skill].md`
- Added to skill list for assignment in Step 7

</step>

<step number="6.6" subagent="file-creator" name="create_design_system_skill">

### Step 6.6: Create Design System Skill for Frontend (If Applicable)

If design-system.md exists, create a skill for frontend developers to use it.

<conditional_logic>
  IF agent-os/product/design-system.md EXISTS:

    USE file-creator to create design-system skill:

    CREATE: .claude/skills/dev-team/[PROJECT]-frontend-design-system.md

    Content:
    ```markdown
    # Frontend Design System Skill

    > Project: [PROJECT_NAME]
    > Source: agent-os/product/design-system.md

    ## Purpose
    Ensures frontend implementation follows the project's design system.

    ## When to Activate
    - Implementing UI components
    - Styling pages and layouts
    - Creating new visual elements

    ## Design System Reference

    **ALWAYS consult:** agent-os/product/design-system.md

    ## Colors
    [Extract from design-system.md]

    ## Typography
    [Extract from design-system.md]

    ## Spacing
    [Extract from design-system.md]

    ## Components
    [Extract component catalog from design-system.md]

    ## Implementation Rules
    - Use defined color palette (no random colors)
    - Follow typography scale (no arbitrary font sizes)
    - Use spacing scale (no magic numbers)
    - Reuse defined components
    - Match component states (hover, active, disabled)

    ## Quality Checklist
    - [ ] Uses colors from design-system.md
    - [ ] Follows typography scale
    - [ ] Uses spacing tokens
    - [ ] Matches component patterns
    - [ ] Accessibility maintained (contrast ratios)
    ```

    ADD this skill to frontend-developer's skills list
    UPDATE frontend-developer.md YAML frontmatter

  ELSE:
    NOTE: "No design-system.md found, skipping design system skill"
</conditional_logic>

</step>

<step number="6.7" subagent="file-creator" name="create_ux_patterns_skill">

### Step 6.7: Create UX Patterns Skill for Frontend (If Applicable)

If ux-patterns.md exists, create a skill for frontend developers to follow UX patterns.

<conditional_logic>
  IF agent-os/product/ux-patterns.md EXISTS:

    USE file-creator to create ux-patterns skill:

    CREATE: .claude/skills/dev-team/[PROJECT]-frontend-ux-patterns.md

    Content:
    ```markdown
    # Frontend UX Patterns Skill

    > Project: [PROJECT_NAME]
    > Source: agent-os/product/ux-patterns.md

    ## Purpose
    Ensures frontend implementation follows the project's UX patterns for navigation, user flows, interactions, and accessibility.

    ## When to Activate
    - Implementing user interfaces
    - Creating user flows and navigation
    - Implementing forms and interactions
    - Handling loading, success, and error states
    - Implementing mobile/responsive layouts

    ## UX Patterns Reference

    **ALWAYS consult:** agent-os/product/ux-patterns.md

    ## Navigation Patterns
    [Extract navigation type and structure from ux-patterns.md]

    ## User Flow Patterns
    [Extract key user flows from ux-patterns.md]

    ## Interaction Patterns
    [Extract button, form, and interaction patterns from ux-patterns.md]

    ## Feedback Patterns
    [Extract loading, success, error, and empty state patterns from ux-patterns.md]

    ## Mobile Patterns (if applicable)
    [Extract mobile-specific patterns from ux-patterns.md]

    ## Accessibility Requirements
    [Extract accessibility patterns and WCAG level from ux-patterns.md]

    ## Implementation Rules
    - Follow defined navigation pattern consistently
    - Implement all user flows as specified
    - Use consistent interaction patterns (buttons, forms)
    - Provide clear feedback for all states (loading, success, error, empty)
    - Ensure keyboard navigation works
    - Meet accessibility requirements (WCAG level)
    - Implement mobile patterns if applicable

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

    ADD this skill to frontend-developer's skills list
    UPDATE frontend-developer.md YAML frontmatter

  ELSE:
    NOTE: "No ux-patterns.md found, skipping UX patterns skill"
</conditional_logic>

</step>

<step number="7" subagent="file-creator" name="assign_skills_to_agents">

### Step 7: Assign Skills to Agents

Use file-creator agent to update each agent with their generated skills in BOTH YAML frontmatter and markdown body.

<assignment_process>
  FOR EACH created agent file in .claude/agents/dev-team/:

    1. READ agent file

    2. COLLECT generated skills for this agent from .claude/skills/dev-team/:
       Example for backend-developer:
       - [PROJECT]-backend-logic-implementing
       - [PROJECT]-backend-persistence-adapter
       - [PROJECT]-backend-integration-adapter
       - [PROJECT]-backend-test-engineering
       (+ any custom skills)

    3. UPDATE YAML frontmatter:
       FIND: `skills: [SKILLS_LIST]`
       REPLACE with actual skill list in YAML array format:
       ```yaml
       skills:
         - [PROJECT]-backend-logic-implementing
         - [PROJECT]-backend-persistence-adapter
         - [PROJECT]-backend-integration-adapter
         - [PROJECT]-backend-test-engineering
       ```

    4. UPDATE Markdown body:
       FIND: `[SKILLS_LIST]` placeholder in "## Available Skills" section
       REPLACE with:
       ```markdown
       **Core Skills:**
       - [PROJECT]-backend-logic-implementing
       - [PROJECT]-backend-persistence-adapter
       - [PROJECT]-backend-integration-adapter
       - [PROJECT]-backend-test-engineering

       **Skill Loading:**
       Skills are loaded dynamically from .claude/skills/dev-team/ when needed.
       ```

    5. SAVE updated agent file
</assignment_process>

<critical>
  BOTH locations must be updated:
  1. YAML frontmatter `skills:` field (for Claude Code to load skills)
  2. Markdown body `## Available Skills` section (for documentation)

  If only markdown is updated, Claude Code won't load the skills!
</critical>

<verification>
  After assignment, each agent file should have:
  - ✅ YAML frontmatter with skills array
  - ✅ Markdown body with skills list
  - ✅ All [SKILLS_LIST] placeholders replaced
  - ✅ Skills reference actual generated files in .claude/skills/dev-team/
</verification>

</step>

<step number="8" name="create_definition_of_done">

### Step 8: Create Definition of Done

Generate Definition of Done based on tech stack and team.

**Process:**
1. Load template
2. Customize based on:
   - Tech stack (testing frameworks, linting tools)
   - Selected agents (quality gates)
   - Architecture (layer compliance)
3. Present for review

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

**Template:** `agent-os/templates/docs/definition-of-done-template.md`

<template_lookup>
  PATH: agent-os/templates/docs/definition-of-done-template.md

  LOOKUP STRATEGY (Hybrid):
    1. TRY: Read from project (agent-os/templates/docs/definition-of-done-template.md)
    2. IF NOT FOUND: Read from global (~/.agent-os/templates/docs/definition-of-done-template.md)
    3. IF STILL NOT FOUND: Error - setup-devteam-global.sh not run

  NOTE: Most projects use global templates. Project override only when customizing.
</template_lookup>

**Output:** `agent-os/team/dod.md`

</step>

<step number="9" name="create_definition_of_ready">

### Step 9: Create Definition of Ready

Generate Definition of Ready for user stories.

**Process:**
1. Load template
2. Customize based on:
   - Team roles (who approves)
   - Architecture (technical requirements)
3. Present for review

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

**Template:** `agent-os/templates/docs/definition-of-ready-template.md`

<template_lookup>
  LOOKUP: agent-os/templates/ (project) → ~/.agent-os/templates/ (global fallback)
</template_lookup>

**Output:** `agent-os/team/dor.md`

</step>

<step number="10" name="symlink_skills">

### Step 10: Set Up Skill Symlinks

Create symlinks for relevant skills in .claude/skills/.

**Process:**
1. Identify all skills needed by selected agents
2. Check if skills exist in agent-os/skills/
3. Create symlinks in .claude/skills/

**Skills to Link:**
```
Base Skills (always):
- security-best-practices
- git-workflow-patterns (→ git-master)
- testing-best-practices

Tech-Specific (based on stack):
[IF Java]: java-core-patterns, spring-boot-conventions, jpa-best-practices
[IF React]: react-component-patterns, react-hooks-best-practices, typescript-react-patterns
[IF Angular]: angular-component-patterns, angular-services-patterns, rxjs-best-practices

Role-Specific (based on agents):
[IF Architecture Agent]: architect-* skills
[IF DevOps Agent]: devops-patterns, infrastructure-*, pipeline-*, etc.
[IF PO Agent]: product-strategy-patterns, business-analysis-*, etc.
```

**Output:** Symlinks in `.claude/skills/`

</step>

<step number="11" name="summary">

### Step 11: Team Summary

Present team configuration summary.

**Summary:**
```
Development Team Ready!

Team Composition:
✅ Architecture Agent (required)
[✅ Backend Developer Agent x [N]] (if selected)
[✅ Frontend Developer Agent x [N]] (if selected)
[✅ DevOps Specialist Agent] (if selected)
[✅ QA Specialist Agent] (if selected)
[✅ PO Agent] (if selected)

Agent Configurations: .claude/agents/
Skills Linked: .claude/skills/

Quality Standards:
✅ Definition of Done: agent-os/team/dod.md
✅ Definition of Ready: agent-os/team/dor.md

How to Use:
1. Agents are automatically available via Task tool
2. Skills auto-activate based on file types and tasks
3. DoD/DoR are referenced during feature development

Next Steps:
1. Review agent configurations
2. Run /create-spec to start first feature
3. Agents will be involved automatically during development
```

</step>

</process_flow>

## Agent Overview

| Agent | Required | Skills Count | Purpose |
|-------|----------|--------------|---------|
| Architecture Agent | Yes | 5 | Design & patterns |
| Backend Developer | Optional | 4+ | API & services |
| Frontend Developer | Optional | 4+ | UI & interactions |
| DevOps Specialist | Optional | 4 | CI/CD & infra |
| QA Specialist | Optional | 2 | Testing & quality |
| PO Agent | Optional | 4 | Requirements & acceptance |

## Multiple Instances

Backend and Frontend agents can be instantiated multiple times:
- `backend-dev-1.md`, `backend-dev-2.md`
- `frontend-dev-1.md`, `frontend-dev-2.md`

This enables parallel development of different features.

## Output Files

| File | Location | Description |
|------|----------|-------------|
| Agent configs | `.claude/agents/` | Agent definitions |
| Skill symlinks | `.claude/skills/` | Linked skills |
| Definition of Done | `agent-os/product/` | Quality standards |
| Definition of Ready | `agent-os/product/` | Story readiness |

## Execution Summary

**Duration:** 10-15 minutes
**User Interactions:** 2-3 decision points
**Output:** 2-7 agent files + 2 quality documents + skill symlinks
