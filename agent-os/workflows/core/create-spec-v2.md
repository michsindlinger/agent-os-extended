---
description: Spec Creation Rules for Agent OS v2.0 with Enhanced Research
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Spec Creation Rules (v2.0)

## Overview

Generate detailed feature specifications with integrated research phase for codebase analysis, interactive Q&A, and visual asset integration.

<pre_flight_check>
  EXECUTE: @agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="spec_initiation">

### Step 1: Spec Initiation

Use the context-fetcher subagent to identify spec initiation method by either finding the next uncompleted roadmap item when user asks "what's next?" or accepting a specific spec idea from the user.

<option_a_flow>
  <trigger_phrases>
    - "what's next?"
  </trigger_phrases>
  <actions>
    1. CHECK @agent-os/product/roadmap.md
    2. FIND next uncompleted item
    3. SUGGEST item to user
    4. WAIT for approval
  </actions>
</option_a_flow>

<option_b_flow>
  <trigger>user describes specific spec idea</trigger>
  <accept>any format, length, or detail level</accept>
  <proceed>to context gathering</proceed>
</option_b_flow>

</step>

<step number="2" subagent="context-fetcher" name="context_gathering">

### Step 2: Context Gathering (Conditional)

Use the context-fetcher subagent to read @agent-os/product/mission-lite.md and @agent-os/product/tech-stack.md only if not already in context to ensure minimal context for spec alignment.

<conditional_logic>
  IF both mission-lite.md AND tech-stack.md already read in current context:
    SKIP this entire step
    PROCEED to step 3
  ELSE:
    READ only files not already in context:
      - mission-lite.md (if not in context)
      - tech-stack.md (if not in context)
    CONTINUE with context analysis
</conditional_logic>

</step>

<step number="3" name="research_phase_start">

### Step 3: Research Phase - Initiate

**NEW IN v2.0**: Enhanced research phase with codebase analysis, interactive Q&A, and visual asset collection.

Inform the user that you're entering the research phase:

```markdown
Starting research phase for [Feature Name]...

This includes:
1. Analyzing existing codebase for reusable patterns
2. Interactive Q&A to clarify requirements
3. Visual asset collection (mockups, wireframes)

This helps create a more complete and consistent specification.
```

</step>

<step number="4" name="codebase_analysis">

### Step 4: Research Phase - Codebase Analysis

**Reference**: @agent-os/workflows/research/analyze-codebase-patterns.md

Analyze the existing codebase to find:
- Similar features that can inform the design
- Reusable services, components, utilities
- Architectural patterns already in use
- Naming conventions and code structure
- Libraries and frameworks already integrated

**Process:**

1. **Identify Domain**: Based on feature description, identify the relevant domain (e.g., "invoice export" → look for existing export/file generation code)

2. **Search for Patterns**:
   - Use Grep to find relevant services, controllers, models
   - Read key files to understand implementation
   - Extract reusable patterns

3. **Document Findings**: Create initial research notes

**Example searches:**
```bash
# For an "invoice export" feature:
- Search for: "export|pdf|excel|file generation"
- Find: ReportExporter.java, FileService.java, S3UploadService.java
- Analyze: How do they work? Can they be reused?
```

**Output**: Preliminary findings for research-notes.md

</step>

<step number="5" name="interactive_qa">

### Step 5: Research Phase - Interactive Q&A

**Reference**: @agent-os/templates/research/research-questions.md

Based on initial codebase analysis, ask targeted questions to clarify requirements.

**Question Categories:**
1. **Technical Scope** - Formats, sync/async, performance
2. **Integration** - Which existing components to reuse?
3. **Security & Permissions** - Who can access? What data privacy rules?
4. **UI/UX** - Where in the UI? What interactions?
5. **Business Logic** - What rules apply? What validations?

**Format Questions Using AskUserQuestion Tool:**

```typescript
// Example
AskUserQuestion({
  questions: [
    {
      question: "What export formats should be supported?",
      header: "Export Formats",
      multiSelect: true,
      options: [
        { label: "PDF", description: "Portable Document Format" },
        { label: "Excel", description: "Microsoft Excel spreadsheet" },
        { label: "CSV", description: "Comma-separated values" }
      ]
    },
    {
      question: "Should exports be synchronous or asynchronous?",
      header: "Processing",
      multiSelect: false,
      options: [
        { label: "Always synchronous", description: "User waits for file" },
        { label: "Always asynchronous", description: "Background job, email link" },
        { label: "Conditional", description: "Sync for small, async for large" }
      ]
    }
  ]
})
```

**Document Answers**: Add to research-notes.md under "Requirements Clarification" section

</step>

<step number="6" name="visual_asset_collection">

### Step 6: Research Phase - Visual Asset Collection

**Reference**: @agent-os/workflows/research/visual-assets.md

Ask if user has visual designs:

```markdown
Do you have any visual designs or mockups for this feature?

Please provide if available:
- Mockups (high-fidelity designs)
- Wireframes (structural sketches)
- Screenshots of similar existing UI
- Design system references
- Figma/Sketch/Penpot links

You can provide:
1. File paths (I'll copy them to the spec directory)
2. URLs (I'll document the references)
3. Describe the design (I'll create a text description)
4. Skip if no visuals available
```

**If provided:**
1. Create directories: `mockups/`, `wireframes/`, `screenshots/`
2. Copy or reference assets
3. Analyze visual design (layout, components, colors, states)
4. Document analysis in research-notes.md

**If not provided:**
- Document that feature is backend-only or will be designed during implementation
- Proceed to next step

</step>

<step number="7" name="research_summary">

### Step 7: Research Phase - Summary

Compile all research findings into research-notes.md:

**Reference**: @agent-os/templates/research/research-notes.md

Create file: `agent-os/specs/YYYY-MM-DD-feature-name/research-notes.md`

**Sections:**
1. Feature Overview
2. Codebase Analysis
   - Existing similar features
   - Reusable components
   - Architectural patterns
   - Technology stack in use
3. Requirements Clarification
   - Questions asked and answered
   - Decisions made
4. Visual Assets (if any)
   - Mockup analysis
   - Design tokens extracted
5. Technical Constraints
6. Recommendations
   - Reuse strategy
   - Implementation approach
7. Open Questions

**Present Summary to User:**

```markdown
Research phase complete! Here's what I found:

**Reusable Components:**
- ExistingService.java - Can be extended for [purpose]
- UtilityClass.java - Provides [functionality] we need

**Patterns to Follow:**
- [Pattern 1]: Used in [location]
- [Pattern 2]: Used in [location]

**Key Decisions:**
- Export formats: PDF and Excel
- Processing: Asynchronous for files >50 items
- Storage: AWS S3 with 24h signed URLs

**Visual Design:**
- [Mockup analyzed / No mockups provided]

Saved research notes: @agent-os/specs/YYYY-MM-DD-feature-name/research-notes.md

Ready to proceed with formal specification?
```

Wait for user confirmation before proceeding.

</step>

<step number="8" subagent="date-checker" name="date_determination">

### Step 8: Date Determination

Use the date-checker subagent to determine the current date in YYYY-MM-DD format for folder naming.

</step>

<step number="9" subagent="file-creator" name="spec_folder_creation">

### Step 9: Spec Folder Creation

Use the file-creator subagent to create directory: agent-os/specs/YYYY-MM-DD-spec-name/ using the date from step 8.

Create additional subdirectories:
- `sub-specs/` - For technical, database, API specs
- `mockups/` - For visual designs (if collected)
- `wireframes/` - For sketches (if collected)
- `screenshots/` - For reference images (if collected)

</step>

<step number="10" subagent="file-creator" name="create_spec_md">

### Step 10: Create spec.md

**Enhanced with research findings**: Incorporate insights from research phase into the specification.

Create file: `agent-os/specs/YYYY-MM-DD-spec-name/spec.md`

**Template** (same as v1.1, but informed by research):

```markdown
# Spec Requirements Document

> Spec: [SPEC_NAME]
> Created: [CURRENT_DATE]
> Research: @agent-os/specs/YYYY-MM-DD-spec-name/research-notes.md

## Overview

[1-2 sentence goal - informed by research findings]

## User Stories

### [STORY_TITLE]

As a [USER_TYPE], I want to [ACTION], so that [BENEFIT].

[Workflow description - informed by visual assets if provided]

## Spec Scope

1. **[FEATURE]** - [Description]
2. **[FEATURE]** - [Description]

[Informed by Q&A session and codebase analysis]

## Out of Scope

- [Excluded functionality - clarified in Q&A]

## Expected Deliverable

1. [Testable outcome - aligned with mockups if provided]
2. [Testable outcome]

## Research References

This spec was informed by:
- Codebase analysis of existing patterns
- Interactive requirements clarification
- [Visual design analysis / No visual designs provided]

See: @agent-os/specs/YYYY-MM-DD-spec-name/research-notes.md
```

</step>

<step number="11" subagent="file-creator" name="create_spec_lite_md">

### Step 11: Create spec-lite.md

(Same as v1.1)

</step>

<step number="12" subagent="file-creator" name="create_technical_spec">

### Step 12: Create Technical Specification

**Enhanced with research insights**: Include reusable components identified and architectural recommendations from research.

Create file: `sub-specs/technical-spec.md`

Include sections:
- Technical Requirements (informed by research)
- Reusable Components (from codebase analysis)
- New Components Needed
- Integration Points (identified in research)
- External Dependencies (if new ones needed)

</step>

<step number="13" subagent="file-creator" name="create_database_schema">

### Step 13: Create Database Schema (Conditional)

(Same as v1.1)

</step>

<step number="14" subagent="file-creator" name="create_api_spec">

### Step 14: Create API Specification (Conditional)

(Same as v1.1)

</step>

<step number="15" name="user_review">

### Step 15: User Review

Request user review of all created documents:
- spec.md
- spec-lite.md
- research-notes.md
- technical-spec.md
- [Other sub-specs]

</step>

<step number="16" subagent="file-creator" name="create_tasks">

### Step 16: Create tasks.md

**Enhanced with research insights**: Tasks informed by identified reusable components and architectural decisions.

(Same structure as v1.1, but task descriptions reference specific components to reuse)

</step>

<step number="17" name="decision_documentation">

### Step 17: Decision Documentation (Conditional)

(Same as v1.1)

</step>

<step number="18" name="execution_readiness">

### Step 18: Execution Readiness Check

(Same as v1.1)

</step>

</process_flow>

## v2.0 Enhancements

### Research Phase Benefits

1. **Codebase Awareness**
   - Automatic discovery of reusable components
   - Alignment with existing architecture
   - Reduced duplication

2. **Better Requirements**
   - Targeted questions based on context
   - Clarification of ambiguities upfront
   - Visual design integration

3. **Complete Specifications**
   - Informed by existing patterns
   - Grounded in technical reality
   - Visual references included

### Research Output

All research artifacts stored in spec directory:
```
agent-os/specs/YYYY-MM-DD-feature-name/
├── research-notes.md          # Comprehensive analysis
├── spec.md                    # Formal specification
├── spec-lite.md               # Summary
├── sub-specs/
│   ├── technical-spec.md      # Technical details
│   ├── database-schema.md     # Database changes
│   └── api-spec.md            # API specification
├── mockups/                   # Visual designs
├── wireframes/                # Structural sketches
└── screenshots/               # Reference images
```

## Execution Standards

(Same as v1.1)

