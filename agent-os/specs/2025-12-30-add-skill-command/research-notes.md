# Research Notes - Add Skill Command

> Spec: Add Skill Command
> Created: 2025-12-30
> Status: Research Complete

## Feature Overview

Command to generate project-specific skills from templates with intelligent pattern detection and best practice recommendations.

**Two Operating Modes:**
1. **Code Analysis Mode** - If codebase exists, analyze actual patterns
2. **Best Practices Mode** - If new project, use framework best practices

**Key Capabilities:**
- Deep codebase analysis using Explore agent
- Framework auto-detection
- Pattern extraction from existing code
- Best practice validation
- Interactive improvement selection
- Project-prefixed skill file generation

## User Decisions from Q&A Session

### 1. Skill Types to Support
**Decision:** All 4 skill types
- API Patterns (controllers, routes, error handling)
- Component Patterns (React/Vue/etc components)
- Testing Patterns (unit, integration, E2E)
- Deployment Patterns (CI/CD, infrastructure)

**Rationale:** Each addresses distinct development areas

### 2. Code Analysis Depth
**Decision:** Deep Analysis with Explore agent
- Not just file scanning
- Understand relationships and patterns
- Validate against best practices
- Suggest improvements

**Rationale:** More valuable than simple template filling

### 3. Improvement Suggestions
**Decision:** Interactive selection (user chooses)
- Agent detects patterns
- Agent suggests improvements
- User selects which to apply
- Generate skill with selected improvements

**Rationale:** User maintains control over their patterns

### 4. Naming Convention
**Decision:** Project name prefix
- Format: `[project-name]-[skill-type]-patterns.md`
- Examples:
  - `herding-api-patterns.md`
  - `rockstardevelopers-component-patterns.md`
  - `taskflow-testing-patterns.md`

**Rationale:** Clear ownership, easy to identify

## Codebase Analysis

### Existing Reference Implementation
**File:** `@.claude/skills/design-system-extractor.md`
- Similar pattern detection approach
- Analyzes existing code structure
- Generates structured documentation
- Good template for our implementation

### Existing Skill Templates (5)
Located in: `@.agent-os/templates/skills/`
1. `api-patterns.md` - API design and routing
2. `component-patterns.md` - UI component architecture
3. `testing-patterns.md` - Test organization and practices
4. `deployment-patterns.md` - CI/CD and infrastructure
5. `file-organization-patterns.md` - Project structure

**Template Structure:**
- Contains `[CUSTOMIZE]` placeholders
- Framework-agnostic base patterns
- Sections for specific pattern categories
- Examples and anti-patterns

### Existing Agent Integration
**Observation:** Refactored agents already reference project-specific skills
- Agents have `skills_project` field
- Auto-load `[project]-*-patterns.md` skills
- Agents stay small, skills contain knowledge

**Pattern:**
1. Load template
2. Fill `[CUSTOMIZE]` sections
3. Generate skill file
4. Agents auto-discover via naming convention

## Technical Approach

### Mode A: Code Analysis (Codebase Exists)

**Step 1: Framework Detection**
```
Analyze project files:
- pom.xml → Spring Boot (Java)
- package.json + react → React
- requirements.txt + FastAPI → Python/FastAPI
- Gemfile + rails → Ruby on Rails
```

**Step 2: Pattern Discovery with Explore Agent**
```
Use Explore agent to:
- Find controllers in src/controller/
- Find services in src/service/
- Analyze routing patterns
- Detect error handling approach
- Identify common structures
```

**Step 3: Pattern Validation**
```
Compare detected patterns against best practices:
- Is error handling consistent?
- Are naming conventions followed?
- Are there anti-patterns present?
```

**Step 4: Improvement Suggestions**
```
Generate recommendations:
✓ Current: @RequestMapping(method = RequestMethod.GET)
  Suggested: Use @GetMapping for better readability

✓ Current: Mixed error handling approaches
  Suggested: Standardize on @ControllerAdvice pattern

✓ Current: Services in multiple locations
  Suggested: Consolidate under src/service/
```

**Step 5: Interactive Selection**
```
Present to user:
[ ] Use @GetMapping instead of @RequestMapping
[x] Standardize error handling with @ControllerAdvice
[ ] Consolidate service location
[x] Add request/response DTO patterns
```

**Step 6: Skill Generation**
```
Load template: api-patterns.md
Fill [CUSTOMIZE] sections with:
- Detected patterns
- Selected improvements
- Framework-specific examples

Save to: .claude/skills/[project]-api-patterns.md
```

### Mode B: Best Practices (No Code)

**Step 1: Framework Detection via Q&A**
```
Ask user:
"What framework will you use for this API?"
Options:
1. Spring Boot (Java)
2. Express (Node.js)
3. FastAPI (Python)
4. Ruby on Rails
5. Other (specify)
```

**Step 2: Load Best Practices**
```
Retrieve framework best practices:
- Official documentation patterns
- Industry standards
- Common project structures
```

**Step 3: Template Population**
```
Load template: api-patterns.md
Fill [CUSTOMIZE] with framework best practices
No improvements needed (starting fresh)
```

**Step 4: Skill Generation**
```
Save to: .claude/skills/[project]-api-patterns.md
```

## Naming Convention Details

### Format
`[project-name]-[skill-type]-patterns.md`

### Examples by Project Type

**Full-Stack Application:**
- `taskflow-api-patterns.md`
- `taskflow-component-patterns.md`
- `taskflow-testing-patterns.md`
- `taskflow-deployment-patterns.md`

**Backend API Only:**
- `herding-api-patterns.md`
- `herding-testing-patterns.md`
- `herding-deployment-patterns.md`

**Frontend Only:**
- `dashboard-component-patterns.md`
- `dashboard-testing-patterns.md`

### Project Name Detection
```
Priority order:
1. package.json → "name" field
2. .git/config → repository name
3. Current directory name
4. Ask user
```

## Integration with Agent System

### Skill Auto-Loading
**Existing Mechanism:**
```yaml
# Agent configuration
skills_project: true  # Loads [project]-*-patterns.md files
```

**Discovery Pattern:**
1. Agent initializes
2. Checks for skills_project: true
3. Detects project name
4. Loads all matching skill files
5. Merges into agent context

### Agent-Skill Relationship
**Before (monolithic):**
```
Agent file (500 lines):
- Role definition
- API patterns
- Component patterns
- Testing patterns
- Examples
```

**After (modular):**
```
Agent file (100 lines):
- Role definition
- skills_project: true

Skill files:
- herding-api-patterns.md (150 lines)
- herding-component-patterns.md (120 lines)
- herding-testing-patterns.md (100 lines)
```

## Implementation Priority

### Phase 1: Core Command (MVP)
- Command: `add-skill`
- Single skill type: API patterns
- Code analysis mode only
- Basic framework detection (Spring Boot, Express)
- Manual improvement selection
- Project name prefix

### Phase 2: Full Skill Coverage
- Add component patterns
- Add testing patterns
- Add deployment patterns
- Add file organization patterns

### Phase 3: Best Practices Mode
- Framework detection via Q&A
- Best practice loading
- Template population without code analysis

### Phase 4: Advanced Features
- Auto-improvement suggestions
- Pattern conflict detection
- Skill validation
- Skill update/refresh command

## Edge Cases and Considerations

### Multiple Frameworks
**Scenario:** Monorepo with backend + frontend
**Solution:**
- Detect both frameworks
- Generate separate skills
- `myapp-api-patterns.md` (Spring Boot)
- `myapp-component-patterns.md` (React)

### No Framework Detected
**Scenario:** Custom or unknown framework
**Solution:**
- Ask user to specify
- Use generic best practices
- Allow manual customization

### Conflicting Patterns
**Scenario:** Codebase has inconsistent patterns
**Solution:**
- Detect all variants
- Flag inconsistencies
- Suggest standardization
- Let user choose preferred approach

### Existing Skills
**Scenario:** Skill file already exists
**Solution:**
- Ask user: Overwrite, Merge, or Skip
- If merge: Combine patterns, deduplicate
- Preserve user customizations

## Success Metrics

### User Value
- Time saved: 2-4 hours per skill type
- Pattern consistency: 90%+ adherence
- Onboarding speed: 50% faster for new developers

### Technical Quality
- Framework detection: 95%+ accuracy
- Pattern extraction: Captures 80%+ of actual patterns
- Improvement relevance: 70%+ acceptance rate

## Next Steps

1. Review research notes with team
2. Create detailed technical specification
3. Define skill template structure
4. Implement Explore agent integration
5. Build interactive improvement UI
6. Test with real codebases

## References

- Existing skill templates: `@.agent-os/templates/skills/`
- Reference implementation: `@.claude/skills/design-system-extractor.md`
- Agent system: `@.claude/agents/` (all refactored agents)
- Framework detection patterns: TBD (technical spec)

---

**Date:** 2025-12-30
**Status:** Research Complete - Ready for Technical Spec
**Next:** Create sub-specs/technical-spec.md
