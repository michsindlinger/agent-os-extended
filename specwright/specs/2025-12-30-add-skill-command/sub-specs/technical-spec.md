# Technical Specification

This is the technical specification for the spec detailed in @specwright/specs/2025-12-30-add-skill-command/spec.md

> Created: 2025-12-30
> Version: 1.0.0

## Technical Requirements

### Architecture Components

1. **Command Handler** (`add-skill` command)
   - Entry point that presents mode selection to user
   - Orchestrates workflow execution
   - Handles user interaction for improvement selection

2. **Workflow Orchestration**
   - Coordinates between Explore agent, Template processor, Skill generator
   - Manages state across multi-step process
   - Handles error conditions and user confirmations

3. **Explore Agent Integration**
   - Pattern discovery prompts for each skill type
   - Framework detection logic
   - Pattern validation against best practices

4. **Template Processor**
   - Loads skill templates from template directory
   - Parses `[CUSTOMIZE]` markers
   - Replaces markers with detected/chosen values
   - Validates template completeness

5. **Skill Generator (file-creator agent)**
   - Creates skill files in `.claude/skills/`
   - Ensures proper naming convention
   - Handles overwrite confirmations

## Approach

### Mode A - Code Analysis Flow

```
1. Framework Detection
   ├─ Glob for framework indicators
   ├─ Java Spring Boot: pom.xml + "spring-boot-starter"
   ├─ Node.js Express: package.json + "express"
   ├─ Python FastAPI: requirements.txt + "fastapi"
   ├─ React: package.json + "react"
   ├─ Angular: package.json + "@angular/core"
   └─ If not found → Ask user

2. Skill Type Selection
   └─ User chooses: API, Component, Testing, Deployment, File Organization

3. Pattern Discovery (via Explore Agent)
   ├─ API Patterns: "Find all Controllers/Routes, analyze structure, identify patterns"
   ├─ Component Patterns: "Find all components, analyze props/state/lifecycle patterns"
   ├─ Testing Patterns: "Find test files, identify frameworks, check coverage setup"
   ├─ Deployment Patterns: "Find deployment configs, CI/CD files, analyze patterns"
   └─ File Organization: "Analyze directory structure, naming conventions, module organization"

4. Pattern Validation
   ├─ Compare discovered patterns vs best practices knowledge base
   ├─ Identify deviations and potential improvements
   └─ Generate improvement suggestions list

5. Improvement Selection (Interactive)
   ├─ Present improvements to user
   ├─ Allow selection of which improvements to include
   └─ Combine current patterns + selected improvements

6. Template Processing
   ├─ Load appropriate template
   ├─ Fill [CUSTOMIZE] markers with:
   │  ├─ Detected patterns
   │  ├─ Selected improvements
   │  └─ Framework-specific details
   └─ Validate all markers replaced

7. Skill Generation
   ├─ Check if skill file exists
   ├─ Confirm overwrite if exists
   └─ Create skill file via file-creator agent
```

### Mode B - Best Practices Flow

```
1. Framework Selection
   └─ Interactive Q&A to determine framework

2. Skill Type Selection
   └─ User chooses: API, Component, Testing, Deployment, File Organization

3. Best Practice Loading
   ├─ Load framework-specific best practices from knowledge base
   └─ No pattern discovery needed

4. Template Processing
   ├─ Load appropriate template
   ├─ Fill [CUSTOMIZE] markers with best practices
   └─ Validate all markers replaced

5. Skill Generation
   ├─ Check if skill file exists
   ├─ Confirm overwrite if exists
   └─ Create skill file via file-creator agent
```

## Framework Detection Logic

### Implementation Strategy

```typescript
interface FrameworkIndicator {
  name: string;
  files: string[];          // Files to check for existence
  content?: string[];       // Content patterns to match within files
}

const FRAMEWORK_INDICATORS: FrameworkIndicator[] = [
  {
    name: 'Java Spring Boot',
    files: ['pom.xml'],
    content: ['spring-boot-starter']
  },
  {
    name: 'Node.js Express',
    files: ['package.json'],
    content: ['"express"']
  },
  {
    name: 'Python FastAPI',
    files: ['requirements.txt'],
    content: ['fastapi']
  },
  {
    name: 'React',
    files: ['package.json'],
    content: ['"react"']
  },
  {
    name: 'Angular',
    files: ['package.json'],
    content: ['@angular/core']
  }
];
```

### Detection Process

1. Glob for indicator files
2. If file exists, check content patterns
3. Return matched frameworks
4. Handle multiple matches → ask user for primary
5. Handle no matches → ask user to specify

## Pattern Discovery Prompts

### API Patterns (Explore Agent)

```
Find all API controllers, routes, or endpoints in this project.

Analyze:
- Controller/Route naming conventions
- Request/Response patterns
- Validation approaches
- Error handling patterns
- Authentication/Authorization patterns

Provide:
- Example controller/route structure
- Common patterns used
- Deviations from best practices
```

### Component Patterns (Explore Agent)

```
Find all UI components in this project.

Analyze:
- Component naming conventions
- Props patterns
- State management approaches
- Lifecycle/hooks usage
- Styling approaches

Provide:
- Example component structure
- Common patterns used
- Deviations from best practices
```

### Testing Patterns (Explore Agent)

```
Find all test files in this project.

Analyze:
- Test file naming conventions
- Testing frameworks used
- Test structure patterns
- Mocking approaches
- Coverage configuration

Provide:
- Example test structure
- Common patterns used
- Deviations from best practices
```

## Template Processing

### Template Structure

```markdown
# [Project Name] - [Type] Patterns

> Skill: [project]-[type]-patterns
> Generated: [DATE]

## [Section 1]
[CUSTOMIZE: Description of pattern]

Example:
[CUSTOMIZE: Code example from project or best practice]

## [Section 2]
[CUSTOMIZE: Another pattern]
```

### Marker Replacement Logic

1. Parse template file
2. Identify all `[CUSTOMIZE: ...]` markers
3. Map markers to discovered patterns or best practices
4. Replace markers with actual values
5. Validate no markers remain
6. If markers remain → error state

## Skill File Structure

### Naming Convention

`.claude/skills/[project-name]-[skill-type]-patterns.md`

Examples:
- `.claude/skills/ecommerce-api-patterns.md`
- `.claude/skills/dashboard-component-patterns.md`
- `.claude/skills/backend-testing-patterns.md`

### Frontmatter

```yaml
---
name: [project]-[type]-patterns
description: "Project-specific [type] patterns for [project]"
generated: 2025-12-30
mode: [code-analysis | best-practices]
framework: [detected-framework]
---
```

### Content Sections (from templates)

All `[CUSTOMIZE]` markers filled with:
- Detected patterns (Mode A) or Best practices (Mode B)
- Code examples from project or best practice library
- Framework-specific guidance

## Error Handling

### No Framework Detected

```
Action: Present interactive framework selection
Message: "No framework detected. Please select your framework:"
Options: [List of supported frameworks]
Fallback: Allow custom framework input
```

### Multiple Frameworks Detected

```
Action: Ask user to select primary framework
Message: "Multiple frameworks detected: [list]. Which is primary for [skill-type]?"
Options: [Detected frameworks]
```

### Conflicting Patterns

```
Action: Show conflict to user
Message: "Found conflicting patterns for [pattern-name]:"
Display: Side-by-side comparison
Options: "Choose pattern to use" or "Combine both"
```

### Skill File Exists

```
Action: Confirm overwrite
Message: "Skill file already exists: [filename]. Overwrite?"
Options: [Yes] [No] [Merge]
If Merge: Combine existing + new patterns
```

### Template Processing Failure

```
Action: Show unfilled markers
Message: "Unable to fill markers: [list of markers]"
Options: "Fill manually" or "Use placeholder" or "Cancel"
```

## External Dependencies

### Agent Dependencies

1. **Explore Agent**
   - Pattern discovery across codebase
   - Framework detection file scanning
   - Best practice validation

2. **file-creator Agent**
   - Skill file creation
   - Directory structure management
   - Overwrite handling

### Resource Dependencies

1. **Skill Templates** (5 templates required)
   - `api-patterns-template.md`
   - `component-patterns-template.md`
   - `testing-patterns-template.md`
   - `deployment-patterns-template.md`
   - `file-organization-template.md`

2. **Best Practices Knowledge Base**
   - Framework-specific best practices
   - Pattern libraries
   - Code examples

### Tool Dependencies

1. **AskUserQuestion**
   - Mode selection
   - Framework selection
   - Improvement selection
   - Overwrite confirmation

2. **Glob**
   - Framework detection file scanning
   - Pattern discovery file finding

3. **Read**
   - Template loading
   - Configuration file reading
   - Existing skill file reading (for merge)

## Implementation Phases

### Phase 1: Core Infrastructure
- Command handler setup
- Workflow orchestration
- Framework detection logic
- Template processor

### Phase 2: Mode A - Code Analysis
- Explore agent integration
- Pattern discovery prompts
- Pattern validation
- Improvement suggestion system

### Phase 3: Mode B - Best Practices
- Framework Q&A system
- Best practices loading
- Template filling without analysis

### Phase 4: Integration
- file-creator agent integration
- Error handling
- User confirmation flows
- Skill file generation

### Phase 5: Templates
- Create 5 skill templates
- Populate best practices knowledge base
- Test template processing
