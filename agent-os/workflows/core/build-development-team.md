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
  IF .agent-os/product/tech-stack.md exists:
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

<step number="2" subagent="file-creator" name="create_architecture_agent">

### Step 2: Create Architecture Agent (Always Required)

Create the Architecture Agent - required for all projects.

**Agent Configuration:**
```markdown
# Architecture Agent

## Role
Software architect responsible for design decisions, pattern enforcement, and technical quality.

## Skills
- architect-pattern-enforcer
- architect-api-designer
- architect-data-modeler
- architect-security-guardian
- architect-dependency-checker

## Responsibilities
- Enforce architecture patterns (from architecture-decision.md)
- Design API contracts before implementation
- Review data models and relationships
- Ensure security best practices
- Check dependency directions

## When to Involve
- New feature design
- API endpoint design
- Database schema changes
- Cross-cutting concerns
- Code reviews
```

**Output:** `.claude/agents/architecture-agent.md`

</step>

<step number="3" name="select_additional_agents">

### Step 3: Select Additional Agents

Present agent options based on tech stack.

**Prompt User with AskUserQuestion:**
```
Based on your tech stack, I recommend these agents:

Required (already added):
✅ Architecture Agent

Recommended based on [TECH_STACK]:
- Backend Developer Agent ([DETECTED_BACKEND_TECH])
- Frontend Developer Agent ([DETECTED_FRONTEND_TECH])

Optional:
- DevOps Agent (CI/CD, deployment)
- QA Specialist Agent (testing, quality)
- PO Agent (requirements, acceptance)

Which agents would you like to add?
(You can add multiple instances of Backend/Frontend for parallel work)
```

**Options Structure:**
```typescript
{
  question: "Which agents do you want in your team?",
  multiSelect: true,
  options: [
    { label: "Backend Developer", description: "API, services, data access" },
    { label: "Frontend Developer", description: "UI components, state, interactions" },
    { label: "DevOps Specialist", description: "CI/CD, infrastructure, deployment" },
    { label: "QA Specialist", description: "Testing, quality gates" },
    { label: "PO Agent", description: "Requirements, acceptance criteria" }
  ]
}
```

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

<step number="6" name="create_definition_of_done">

### Step 6: Create Definition of Done

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

Please review: .agent-os/product/definition-of-done.md

Key quality gates:
- Code compiles without errors
- Unit test coverage: [X]%
- [DETECTED_LINTER] passes
- Code review by [N] team member(s)
- Architecture compliance verified

Adjust any criteria?
```

**Template:** `@agent-os/templates/documents/definition-of-done.md`
**Output:** `.agent-os/product/definition-of-done.md`

</step>

<step number="7" name="create_definition_of_ready">

### Step 7: Create Definition of Ready

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

Please review: .agent-os/product/definition-of-ready.md

Key readiness criteria:
- User story format complete
- Acceptance criteria defined (3+ criteria)
- Estimated by team
- No blocking dependencies
- [ROLE] approved

Adjust any criteria?
```

**Template:** `@agent-os/templates/documents/definition-of-ready.md`
**Output:** `.agent-os/product/definition-of-ready.md`

</step>

<step number="8" name="symlink_skills">

### Step 8: Set Up Skill Symlinks

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

<step number="9" name="summary">

### Step 9: Team Summary

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
✅ Definition of Done: .agent-os/product/definition-of-done.md
✅ Definition of Ready: .agent-os/product/definition-of-ready.md

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
| Definition of Done | `.agent-os/product/` | Quality standards |
| Definition of Ready | `.agent-os/product/` | Story readiness |

## Execution Summary

**Duration:** 10-15 minutes
**User Interactions:** 2-3 decision points
**Output:** 2-7 agent files + 2 quality documents + skill symlinks
