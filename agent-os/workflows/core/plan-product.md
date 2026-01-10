---
description: Product Planning for new projects with Agent OS
globs:
alwaysApply: false
version: 4.0
encoding: UTF-8
installation: global
---

# Product Planning Workflow

Generate comprehensive product documentation for new projects: product-brief, tech-stack, roadmap, architecture decisions, and boilerplate structure.

<pre_flight_check>
  EXECUTE: @agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="check_existing_product_brief">

### Step 1: Check for Existing Product Brief

Use context-fetcher to check if product-brief.md already exists (e.g., from validate-market).

<conditional_logic>
  IF agent-os/product/product-brief.md exists:
    LOAD: product-brief.md
    INFORM user: "Found existing product-brief.md from validation phase. Using this as base."
    GENERATE: product-brief-lite.md from existing
    SKIP: Steps 2-4
    PROCEED to step 5
  ELSE:
    PROCEED to step 2
</conditional_logic>

</step>

<step number="2" name="product_idea_capture">

### Step 2: Gather Product Information

Request product information from user.

**Prompt User:**
```
Please describe your product:

1. Main idea (elevator pitch)
2. Key features (minimum 3)
3. Target users (who is this for?)
4. What problem does it solve?
```

<data_sources>
  <primary>user_direct_input</primary>
  <fallback_sequence>
    1. @~/.agent-os/standards/tech-stack.md
    2. @CLAUDE.md
  </fallback_sequence>
</data_sources>

</step>

<step number="3" subagent="product-strategist" name="idea_sharpening">

### Step 3: Idea Sharpening (Interactive)

Use product-strategist agent to refine the idea until complete.

**Process:**
1. Analyze user input for completeness
2. Identify missing template fields
3. Ask clarifying questions interactively:
   - Specific target audience
   - Measurable problem
   - Core features (3-5)
   - Value proposition
   - Success metrics
4. Generate product-brief.md when all fields complete

**Template:** `agent-os/templates/product/product-brief-template.md`
**Output:** `agent-os/product/product-brief.md`

<template_lookup>
  PATH: agent-os/templates/product/product-brief-template.md

  LOOKUP STRATEGY (Hybrid):
    1. TRY: Read from project (agent-os/templates/product/product-brief-template.md)
    2. IF NOT FOUND: Read from global (~/.agent-os/templates/product/product-brief-template.md)
    3. IF STILL NOT FOUND: Error - setup-devteam-global.sh not run

  NOTE: Most projects use global templates. Project override only when customizing.
</template_lookup>

<quality_check>
  Product brief must include:
  - Specific target audience
  - Measurable problem
  - 3-5 concrete features
  - Clear value proposition
  - Differentiation

  IF incomplete:
    CONTINUE asking questions
  ELSE:
    PROCEED to step 4
</quality_check>

</step>

<step number="4" name="user_review_product_brief">

### Step 4: User Review Gate - Product Brief

**PAUSE FOR USER APPROVAL**

**Prompt User:**
```
I've created your Product Brief.

Please review: agent-os/product/product-brief.md

Options:
1. Approve and continue
2. Request changes
```

<conditional_logic>
  IF user approves:
    GENERATE: product-brief-lite.md
    PROCEED to step 5
  ELSE:
    MAKE changes
    RETURN to step 4
</conditional_logic>

**Template:** `agent-os/templates/product/product-brief-lite-template.md`

<template_lookup>
  LOOKUP: agent-os/templates/ (project) → ~/.agent-os/templates/ (global fallback)
</template_lookup>

**Output:** `agent-os/product/product-brief-lite.md`

</step>

<step number="5" subagent="tech-architect" name="tech_stack_recommendation">

### Step 5: Tech Stack Recommendation

Use tech-architect agent to analyze product requirements and recommend appropriate tech stack.

<delegation>
  DELEGATE to tech-architect via Task tool:

  PROMPT:
  "Analyze product requirements and recommend tech stack.

  Context:
  - Product Brief: agent-os/product/product-brief.md
  - Product Brief Lite: agent-os/product/product-brief-lite.md

  Tasks:
  1. Load tech-stack-template.md (hybrid lookup: project → global)
  2. Analyze product requirements (platform, scale, complexity, integrations)
  3. Recommend tech stack (backend, frontend, database, hosting, ci/cd)
  4. Present recommendations to user via AskUserQuestion
  5. Fill template with user's choices
  6. Write to agent-os/product/tech-stack.md

  Use hybrid template lookup:
  - TRY: agent-os/templates/product/tech-stack-template.md
  - FALLBACK: ~/.agent-os/templates/product/tech-stack-template.md"

  WAIT for tech-architect completion
  RECEIVE tech-stack.md output
</delegation>

**Template:** `agent-os/templates/product/tech-stack-template.md`
**Output:** `agent-os/product/tech-stack.md`

</step>

<step number="5.5" subagent="tech-architect" name="generate_project_standards">

### Step 5.5: Generate Project-Specific Standards (Optional)

Use tech-architect agent to optionally generate tech-stack-aware coding standards for the project.

<user_choice>
  ASK user:
  "Generate project-specific coding standards?

  YES (Recommended):
  → Standards customized for your tech stack (Rails → Ruby style, React → TS style)
  → Saved to agent-os/standards/code-style.md and best-practices.md
  → Overrides global ~/.agent-os/standards/

  NO:
  → Use global standards from ~/.agent-os/standards/
  → Faster setup, consistent across all your projects

  Your choice: [YES/NO]"
</user_choice>

<conditional_logic>
  IF user_choice = YES:
    DELEGATE to tech-architect via Task tool:

    PROMPT:
    "Generate tech-stack-aware coding standards.

    Context:
    - Tech Stack: agent-os/product/tech-stack.md
    - Global Standards: ~/.agent-os/standards/code-style.md, best-practices.md

    Tasks:
    1. Read tech-stack.md to understand frameworks
    2. Read global standards as base
    3. Enhance with tech-stack-specific rules:
       - Rails → Ruby style, RSpec conventions
       - React → TypeScript style, component patterns
       - Node.js → JavaScript/TS style, async patterns
    4. Write to agent-os/standards/code-style.md
    5. Write to agent-os/standards/best-practices.md

    Generate tech-stack-aware standards that enhance global defaults."

    WAIT for tech-architect completion
    NOTE: "Project-specific standards generated"

  ELSE:
    NOTE: "Using global standards from ~/.agent-os/standards/"
    SKIP standards generation
</conditional_logic>

</step>

<step number="6" name="roadmap_generation">

### Step 6: Roadmap Generation

Generate development roadmap based on product-brief features.

**Process:**
1. Extract features from product-brief.md
2. Categorize by priority (MoSCoW)
3. Organize into phases:
   - Phase 1: MVP (Must Have)
   - Phase 2: Growth (Should Have)
   - Phase 3: Scale (Could Have)
4. Add effort estimates (XS/S/M/L/XL)

**Prompt User:**
```
I've created a development roadmap with [N] phases.

Please review: agent-os/product/roadmap.md

Options:
1. Approve roadmap
2. Adjust priorities or phases
```

<conditional_logic>
  IF user approves:
    PROCEED to step 7
  ELSE:
    APPLY adjustments
    REGENERATE roadmap
    RETURN to review
</conditional_logic>

**Template:** `agent-os/templates/product/roadmap-template.md`

<template_lookup>
  LOOKUP: agent-os/templates/ (project) → ~/.agent-os/templates/ (global fallback)
</template_lookup>

**Output:** `agent-os/product/roadmap.md`

</step>

<step number="7" name="architecture_decision">

### Step 7: Architecture Decision

Recommend and document architecture pattern.

**Process:**
1. Analyze tech-stack.md and product complexity
2. Recommend architecture pattern:
   - Simple CRUD: Layered Architecture
   - Medium Complexity: Clean Architecture
   - Complex Domain: Hexagonal/DDD
   - Microservices: Event-Driven

**Prompt User with AskUserQuestion:**
```
Based on your product, I recommend:

Architecture: [PATTERN_NAME]
Rationale: [WHY_THIS_PATTERN]

Options:
1. Accept recommendation
2. Choose different pattern (Layered | Clean | Hexagonal | DDD | Microservices)
```

<conditional_logic>
  IF user accepts:
    GENERATE: architecture-decision.md with recommendation
  ELSE:
    GENERATE: architecture-decision.md with user's choice
</conditional_logic>

**Template:** `agent-os/templates/product/architecture-decision-template.md`

<template_lookup>
  LOOKUP: agent-os/templates/ (project) → ~/.agent-os/templates/ (global fallback)
</template_lookup>

**Output:** `agent-os/product/architecture-decision.md`

</step>

<step number="8" subagent="file-creator" name="boilerplate_generation">

### Step 8: Boilerplate Structure Generation

Generate project folder structure based on architecture decision.

**Process:**
1. Read architecture-decision.md for chosen pattern
2. Read tech-stack.md for technologies
3. Create boilerplate directory structure
4. Include demo module as example
5. Generate architecture-structure.md documentation

**Folder Structure Example (Hexagonal):**
```
boilerplate/
├── backend/
│   └── src/
│       ├── domain/
│       │   ├── entities/
│       │   ├── value-objects/
│       │   └── repositories/
│       ├── application/
│       │   ├── use-cases/
│       │   └── dtos/
│       ├── infrastructure/
│       │   ├── persistence/
│       │   └── external/
│       └── presentation/
│           └── rest/
├── frontend/
│   └── src/
│       ├── components/
│       ├── pages/
│       ├── services/
│       └── stores/
└── infrastructure/
    └── docker/
```

**Output:**
- `agent-os/product/boilerplate/` (directory structure)
- `agent-os/product/architecture-structure.md`

**Template:** `agent-os/templates/product/boilerplate-structure-template.md`

<template_lookup>
  LOOKUP: agent-os/templates/ (project) → ~/.agent-os/templates/ (global fallback)
</template_lookup>

</step>

<step number="9" name="summary">

### Step 9: Planning Summary

Present summary of all created documentation.

**Summary:**
```
Product Planning Complete!

Created Documentation:
✅ product-brief.md - Product definition
✅ product-brief-lite.md - Condensed version
✅ tech-stack.md - Technology choices
✅ roadmap.md - Development phases
✅ architecture-decision.md - Architecture pattern
✅ architecture-structure.md - Folder conventions
✅ boilerplate/ - Project structure template

Location: agent-os/product/

Next Steps:
1. Review all documentation
2. Run /build-development-team to set up agents
3. Run /create-spec to start first feature
4. Copy boilerplate/ to your project root
```

</step>

</process_flow>

## User Review Gates

1. **Step 4:** Product Brief approval
2. **Step 6:** Roadmap approval
3. **Step 7:** Architecture decision

## Output Files

| File | Description | Template |
|------|-------------|----------|
| product-brief.md | Complete product definition | product-brief.md |
| product-brief-lite.md | Condensed for AI context | product-brief-lite.md |
| tech-stack.md | Technology choices | tech-stack.md |
| roadmap.md | Development phases | roadmap.md |
| architecture-decision.md | Architecture ADRs | architecture-decision.md |
| architecture-structure.md | Folder conventions | architecture-structure.md |
| boilerplate/ | Directory template | Generated |

## Execution Summary

**Duration:** 15-25 minutes
**User Interactions:** 3-4 decision points
**Output:** 6 files + 1 directory structure
