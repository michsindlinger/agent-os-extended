# Spec Requirements Document

> Spec: Add Skill Command
> Created: 2025-12-30
> Research: @agent-os/specs/2025-12-30-add-skill-command/research-notes.md
> Version: 1.0
> Status: Planning

## Overview

Command to generate project-specific skills from framework-agnostic templates using either codebase analysis (if code exists) or best practice recommendations (for new projects). Enables automatic population of [CUSTOMIZE] sections in skill templates with project-detected patterns or framework-specific best practices.

## User Stories

### Developer: Generate API Patterns Skill from Existing Codebase

As a **developer with existing backend code**, I want to **automatically generate a skill that captures my project's API patterns**, so that **backend-dev agent generates code following my established conventions**.

**Workflow:**
1. Developer runs `/add-skill api-implementation-patterns`
2. System detects code exists (finds src/main/java/)
3. Explore agent analyzes codebase:
   - Detects: Spring Boot framework (pom.xml found)
   - Finds: Controllers in src/controller/ (non-standard location)
   - Finds: Services with @Transactional
   - Finds: DTOs using Lombok
4. System validates patterns against best practices:
   - ✅ Services well-structured
   - ⚠️ Controllers use old @RequestMapping (recommend @GetMapping)
   - ❌ DTOs missing @Valid annotations
5. System presents improvements:
   - "Replace @RequestMapping with @GetMapping/@PostMapping? (Recommended)"
   - "Add @Valid annotations to DTOs? (Recommended)"
6. Developer selects improvements to apply
7. System generates .claude/skills/herding-api-patterns.md:
   - Controllers in src/controller/ (detected)
   - Use @GetMapping (improved)
   - DTOs with @Valid (improved)
   - All [CUSTOMIZE] sections filled
8. backend-dev now uses this skill automatically

### Developer: Generate Component Patterns for New React Project

As a **developer starting a new React project**, I want to **generate a skill with React best practices**, so that **frontend-dev generates components following current standards**.

**Workflow:**
1. Developer runs `/add-skill component-architecture`
2. System detects no code exists
3. System asks: "Which frontend framework?"
4. Developer selects: React 18 + TypeScript
5. System loads React best practices:
   - Functional components with hooks
   - TypeScript for type safety
   - CSS Modules for styling
   - React Hook Form for forms
   - React Testing Library
6. System fills template with best practices
7. System generates .claude/skills/myproject-component-patterns.md
8. frontend-dev uses this skill for all components

### Tech Lead: Validate and Improve Existing Patterns

As a **tech lead**, I want to **see what patterns my codebase uses and get improvement suggestions**, so that **I can modernize code standards**.

**Workflow:**
1. Tech lead runs `/add-skill api-implementation-patterns`
2. System analyzes existing code
3. System shows report:
   - Current patterns detected
   - Best practice violations
   - Suggested improvements with reasoning
4. Tech lead reviews suggestions
5. Tech lead selects which to adopt
6. Skill generated with improved patterns
7. Future code generated follows improved standards

## Spec Scope

### 1. Skill Type Support

**Supported Skill Types** (from templates):
- `api-implementation-patterns` - Backend API patterns
- `component-architecture` - Frontend component patterns
- `testing-strategies` - Testing & QA patterns
- `deployment-automation` - CI/CD & deployment patterns
- `file-organization` - File structure patterns

Each type uses corresponding template from `agent-os/templates/skills/`

**Template Structure:**
- Framework-agnostic base content
- [CUSTOMIZE] sections for project-specific details
- [PROJECT] placeholder for project name
- Code example placeholders

### 2. Code Analysis Mode (When Code Exists)

**Framework Detection:**

Backend frameworks:
- Spring Boot: Check for `pom.xml` or `build.gradle` with spring-boot dependencies
- Express.js: Check `package.json` for express dependency
- FastAPI: Check `requirements.txt` or `pyproject.toml` for fastapi
- Django: Check for `manage.py` and django in requirements
- Rails: Check for `Gemfile` with rails gem

Frontend frameworks:
- React: Check `package.json` for react dependency
- Angular: Check `package.json` for @angular/core
- Vue: Check `package.json` for vue dependency
- Svelte: Check `package.json` for svelte dependency

Testing frameworks:
- Backend: JUnit (Java), pytest (Python), RSpec (Ruby), Jest (Node.js)
- Frontend: Jest, Vitest, Playwright, Cypress, React Testing Library

CI/CD platforms:
- GitHub Actions: Check `.github/workflows/`
- GitLab CI: Check `.gitlab-ci.yml`
- Jenkins: Check `Jenkinsfile`
- CircleCI: Check `.circleci/config.yml`

**Pattern Discovery** (via Explore agent):

API patterns:
- Controllers/Routes: Location, naming conventions, HTTP method handling
- Services: Structure, transaction management, error handling
- Data Access: Repository pattern, ORM usage, query patterns
- DTOs/Models: Validation, serialization, mapping patterns
- Error Handling: Exception handling, error responses
- Authentication: Security patterns, token handling

Component patterns:
- Component Structure: Functional vs class, hooks usage
- State Management: Context, Redux, Zustand, local state
- Styling Approach: CSS Modules, Styled Components, Tailwind
- Props Patterns: TypeScript interfaces, prop validation
- Event Handling: Callback patterns, event naming
- File Organization: Co-location, feature folders

Testing patterns:
- Test Location: Co-located vs separate test directories
- Test Frameworks: Unit, integration, e2e tools in use
- Mocking Strategies: Mock patterns, test data setup
- Coverage: What's tested, what's not

Deployment patterns:
- Build Process: Build tools, optimization steps
- Deployment Steps: Pre-deploy, deploy, post-deploy
- Environment Config: How environments differ
- Health Checks: Readiness, liveness patterns

**Pattern Validation:**

Compare detected patterns against framework best practices:
- Current industry standards (2025)
- Framework-specific recommendations
- Security best practices
- Performance considerations
- Maintainability guidelines

**Improvement Suggestions** (Interactive):

Severity levels:
- ❌ **Error**: Critical issues (security, major anti-patterns)
- ⚠️ **Warning**: Outdated or suboptimal patterns
- ℹ️ **Info**: Enhancement opportunities

Suggestion format:
```
⚠️ Controllers use deprecated @RequestMapping

Current pattern:
@RequestMapping(value = "/users", method = RequestMethod.GET)

Recommended pattern:
@GetMapping("/users")

Reason: @GetMapping is more concise and intention-revealing.
Spring Boot 2.0+ recommends specific HTTP method annotations.

Apply this improvement? (y/n)
```

### 3. Best Practices Mode (No Code)

**Framework Selection:**

Interactive prompts based on skill type:

For `api-implementation-patterns`:
```
No existing code detected.

Which backend framework are you using?
1. Spring Boot (Java)
2. Express.js (Node.js)
3. FastAPI (Python)
4. Django (Python)
5. Ruby on Rails (Ruby)

Selection: _
```

For `component-architecture`:
```
No existing code detected.

Which frontend framework are you using?
1. React 18 + TypeScript
2. Angular 17+
3. Vue 3
4. Svelte 5

Selection: _
```

For `testing-strategies`:
```
No existing code detected.

Which testing stack are you using?
1. Jest + React Testing Library (React)
2. Vitest + Testing Library (Vue/Svelte)
3. Playwright (E2E)
4. Cypress (E2E)
5. JUnit + Mockito (Java)
6. pytest (Python)

Selection: _
```

For `deployment-automation`:
```
No existing code detected.

Which CI/CD platform are you using?
1. GitHub Actions
2. GitLab CI
3. Jenkins
4. CircleCI

Selection: _
```

**Best Practice Loading:**

Each framework has curated best practices:

Spring Boot best practices:
- Controller patterns (@RestController, @GetMapping)
- Service layer patterns (@Service, @Transactional)
- Repository patterns (Spring Data JPA)
- DTO validation (@Valid, @Validated)
- Exception handling (@ControllerAdvice)
- Configuration (application.yml structure)

React best practices:
- Functional components with hooks
- TypeScript interfaces for props
- Custom hooks for logic reuse
- Context for global state
- React Hook Form for forms
- React Testing Library for tests
- CSS Modules or Tailwind for styling

**Framework-Specific Templates:**

Each best practice set includes:
- File organization structure
- Naming conventions
- Code examples
- Common patterns
- Anti-patterns to avoid
- Testing approaches

### 4. Skill Generation

**Template Processing:**

Step-by-step:
1. Load base template from `agent-os/templates/skills/[type]-template.md`
2. Identify all [CUSTOMIZE] sections in template
3. For each [CUSTOMIZE] section:
   - If Code Analysis mode: Fill with detected patterns
   - If Best Practices mode: Fill with framework recommendations
4. Replace [PROJECT] with detected project name
5. Add metadata frontmatter:
   - Framework: detected or selected
   - Language: detected
   - Date: current date
   - Version: 1.0

**[CUSTOMIZE] Section Examples:**

From template:
```markdown
## Controller Structure

[CUSTOMIZE: Describe your controller organization]
```

Filled (Code Analysis - Spring Boot):
```markdown
## Controller Structure

Controllers are located in `src/controller/` directory.
Each controller handles a single resource domain (e.g., UserController, ProductController).

Use `@RestController` with specific HTTP method annotations:
```java
@RestController
@RequestMapping("/api/users")
public class UserController {

    @GetMapping("/{id}")
    public ResponseEntity<UserDto> getUser(@PathVariable Long id) {
        // Implementation
    }

    @PostMapping
    public ResponseEntity<UserDto> createUser(@Valid @RequestBody CreateUserDto dto) {
        // Implementation
    }
}
```

Controllers inject services via constructor injection:
```java
private final UserService userService;

@Autowired
public UserController(UserService userService) {
    this.userService = userService;
}
```
```

Filled (Best Practices - Spring Boot):
```markdown
## Controller Structure

Controllers should be located in `src/main/java/[package]/controller/` directory.
Follow REST conventions with `@RestController` annotation.

Use specific HTTP method annotations for clarity:
```java
@RestController
@RequestMapping("/api/users")
public class UserController {

    @GetMapping("/{id}")
    public ResponseEntity<UserDto> getUser(@PathVariable Long id) {
        // Implementation
    }

    @PostMapping
    public ResponseEntity<UserDto> createUser(@Valid @RequestBody CreateUserDto dto) {
        // Implementation
    }
}
```

Best practices:
- Use constructor injection for dependencies
- Add @Valid annotation for request body validation
- Return ResponseEntity for explicit HTTP status control
- Keep controllers thin - delegate to services
```

**Skill File Creation:**

Naming convention:
- Pattern: `[project-name]-[skill-type]-patterns.md`
- Examples:
  - `herding-api-patterns.md`
  - `rockstardevelopers-component-patterns.md`
  - `myapp-testing-strategies.md`
  - `project-deployment-patterns.md`

Location: `.claude/skills/`

Frontmatter structure:
```yaml
---
name: Herding API Implementation Patterns
description: Spring Boot API patterns for the Herding project
globs:
  - "src/main/java/**/*.java"
  - "src/test/java/**/*.java"
metadata:
  framework: Spring Boot 3.2
  language: Java 17
  generated: 2025-12-30
  version: 1.0
---
```

**Project Name Detection:**

Priority order:
1. **agent-os/config.yml**: Check `project.name` field
2. **package.json**: Check `name` field (for Node.js projects)
3. **pom.xml**: Check `<artifactId>` (for Java projects)
4. **Directory name**: Use parent directory name
5. **User prompt**: Ask if none found

### 5. Validation & Preview

**Pre-Save Validation:**

Frontmatter validation:
- ✅ `name` field present and non-empty
- ✅ `description` field present and non-empty
- ✅ `globs` field present with at least one pattern
- ✅ YAML syntax valid

Content validation:
- ✅ No remaining [CUSTOMIZE] placeholders
- ✅ No remaining [PROJECT] placeholders
- ✅ Code examples have valid syntax highlighting
- ✅ All sections have content (not empty)

**Preview Format:**

```markdown
═══════════════════════════════════════════════════════
Generated Skill Preview
═══════════════════════════════════════════════════════

File: .claude/skills/herding-api-patterns.md
Size: ~850 lines
Framework: Spring Boot 3.2 (detected)
Language: Java 17

Frontmatter: ✅ Valid
  name: Herding API Implementation Patterns
  description: Spring Boot API patterns for the Herding project
  globs: 3 patterns

Key Sections Filled:
  ✅ Framework: Spring Boot 3.2
  ✅ Controllers: src/controller/ (detected)
  ✅ Services: src/service/ with @Transactional
  ✅ Repositories: Spring Data JPA
  ✅ DTOs: Lombok with @Valid (improved)
  ✅ Error Handling: @ControllerAdvice pattern
  ✅ Testing: JUnit 5 + Mockito

Patterns Applied:
  [Detected from codebase]
  - Controllers in src/controller/ directory
  - Service layer with @Transactional
  - Spring Data JPA repositories
  - Lombok for DTOs

  [Improvements Applied]
  - ✅ @GetMapping/@PostMapping instead of @RequestMapping
  - ✅ @Valid annotations on DTOs
  - ✅ ResponseEntity for explicit status codes

═══════════════════════════════════════════════════════

Preview first 50 lines of generated skill? (y/n): _
Save this skill? (y/n): _
```

If user chooses preview:
```markdown
═══════════════════════════════════════════════════════
Skill Content Preview (first 50 lines)
═══════════════════════════════════════════════════════

---
name: Herding API Implementation Patterns
description: Spring Boot API patterns for the Herding project
globs:
  - "src/main/java/**/*.java"
  - "src/test/java/**/*.java"
metadata:
  framework: Spring Boot 3.2
  language: Java 17
  generated: 2025-12-30
  version: 1.0
---

# Herding API Implementation Patterns

## Framework Context

This project uses:
- **Framework**: Spring Boot 3.2
- **Language**: Java 17
- **Build Tool**: Maven
- **Database**: PostgreSQL with Spring Data JPA

## Controller Structure

Controllers are located in `src/controller/` directory.
Each controller handles a single resource domain.

...

═══════════════════════════════════════════════════════

Save this skill? (y/n): _
```

### 6. Agent Delegation

**Explore Agent Responsibilities:**

When code exists, delegate to Explore agent:
- **Framework detection**: Analyze project files to identify framework
- **Pattern discovery**: Find code patterns across the codebase
- **Structure analysis**: Understand file organization
- **Convention identification**: Extract naming and structural conventions

Explore agent workflow:
1. Receive skill type and project path
2. Detect framework from project files
3. Scan relevant directories based on framework
4. Extract patterns from code
5. Return structured findings

**File-Creator Agent Responsibilities:**

Delegate skill file creation to file-creator agent:
- **Template processing**: Load and process template
- **Placeholder replacement**: Fill [CUSTOMIZE] and [PROJECT] sections
- **File writing**: Create skill file in .claude/skills/
- **Validation**: Verify frontmatter and content

File-creator agent workflow:
1. Receive processed content and metadata
2. Validate frontmatter structure
3. Verify no placeholders remain
4. Write skill file
5. Confirm creation success

## Out of Scope (v1.0)

**Not Included:**
- ❌ **Auto-update existing skills**: If skill exists, must regenerate manually (no merging)
- ❌ **Skill versioning**: No tracking of changes over time
- ❌ **Diff view**: No comparison of old vs new skill
- ❌ **Merge conflicts**: Regeneration replaces existing skill entirely
- ❌ **Multi-framework projects**: Choose one primary framework per skill
- ❌ **Custom templates**: Only use provided skill templates
- ❌ **Template editing**: Cannot modify base templates
- ❌ **Skill combining**: Cannot merge multiple skills into one
- ❌ **Pattern learning**: No ML-based pattern detection
- ❌ **Cross-project patterns**: No sharing patterns between projects

**Future Enhancements (v2.0+):**
- Skill versioning and change tracking
- Merge existing skill with updates
- Diff view before regenerating
- Multi-framework support (detect multiple frameworks)
- Custom template creation
- Pattern import/export between projects
- Auto-update when codebase changes detected

## Expected Deliverables

### 1. Command File

**File**: `.claude/commands/agent-os/add-skill.md`

Purpose: User-facing command to generate project-specific skills

Structure:
```markdown
---
name: add-skill
description: Generate a project-specific skill from template using codebase analysis or best practices
args:
  - name: skill-type
    description: Type of skill to generate
    required: true
    options:
      - api-implementation-patterns
      - component-architecture
      - testing-strategies
      - deployment-automation
      - file-organization
---

# Add Skill Command

Generate a project-specific skill from a framework-agnostic template.
...
```

### 2. Workflow File

**File**: `agent-os/workflows/skill/add-skill.md`

Purpose: Internal workflow for skill generation logic

Structure:
```markdown
# Add Skill Workflow

## Purpose
Generate project-specific skills from templates using codebase analysis or best practices.

## Process

### Step 1: Validate Skill Type
...

### Step 2: Detect Code Existence
...

### Step 3: Framework Detection / Selection
...

### Step 4: Pattern Analysis / Best Practices
...

### Step 5: Template Processing
...

### Step 6: Validation & Preview
...

### Step 7: File Creation
...
```

### 3. Generated Skills

**Files**: `.claude/skills/[project-name]-[type]-patterns.md`

Examples:

**herding-api-patterns.md** (Spring Boot project):
```markdown
---
name: Herding API Implementation Patterns
description: Spring Boot API patterns for the Herding project
globs:
  - "src/main/java/**/*.java"
metadata:
  framework: Spring Boot 3.2
  language: Java 17
  generated: 2025-12-30
---

# Herding API Implementation Patterns

[Complete skill with detected patterns]
```

**rockstardevelopers-component-patterns.md** (React project):
```markdown
---
name: Rockstar Developers Component Patterns
description: React component patterns for the Rockstar Developers project
globs:
  - "src/**/*.tsx"
  - "src/**/*.ts"
metadata:
  framework: React 18
  language: TypeScript
  generated: 2025-12-30
---

# Rockstar Developers Component Patterns

[Complete skill with detected patterns]
```

**myapp-testing-strategies.md** (Jest + Playwright):
```markdown
---
name: MyApp Testing Strategies
description: Testing patterns and strategies for the MyApp project
globs:
  - "**/*.test.ts"
  - "**/*.spec.ts"
  - "tests/**/*"
metadata:
  frameworks:
    - Jest
    - Playwright
  language: TypeScript
  generated: 2025-12-30
---

# MyApp Testing Strategies

[Complete skill with detected patterns]
```

**project-deployment-patterns.md** (GitHub Actions):
```markdown
---
name: Project Deployment Patterns
description: CI/CD and deployment patterns for the Project
globs:
  - ".github/workflows/**/*.yml"
metadata:
  platform: GitHub Actions
  generated: 2025-12-30
---

# Project Deployment Patterns

[Complete skill with detected patterns]
```

## Success Criteria

### Functional Success

**Code Analysis Path:**
1. ✅ Run `/add-skill api-implementation-patterns` in Spring Boot project
2. ✅ Explore agent analyzes code and finds patterns
3. ✅ System detects framework (Spring Boot)
4. ✅ System identifies non-standard patterns (controllers in src/controller/)
5. ✅ System suggests improvements (@GetMapping, @Valid)
6. ✅ User selects improvements to apply
7. ✅ Skill generated in `.claude/skills/herding-api-patterns.md`
8. ✅ All [CUSTOMIZE] sections filled with detected patterns
9. ✅ backend-dev loads skill automatically on next task

**Best Practices Path:**
1. ✅ Run `/add-skill component-architecture` in new project (no code)
2. ✅ System prompts for framework selection
3. ✅ User selects React 18 + TypeScript
4. ✅ System loads React best practices
5. ✅ Skill generated in `.claude/skills/myproject-component-patterns.md`
6. ✅ All [CUSTOMIZE] sections filled with React best practices
7. ✅ frontend-dev uses skill for component generation

### Quality Success

**Generated Skill Quality:**
- ✅ Valid YAML frontmatter (name, description, globs)
- ✅ All [CUSTOMIZE] sections populated
- ✅ No [PROJECT] placeholders remain
- ✅ Code examples use correct framework syntax
- ✅ Code examples have proper syntax highlighting
- ✅ Globs match project file structure
- ✅ Skill loads without errors in Claude

**User Experience:**
- ✅ Clear progress indicators during analysis
- ✅ Improvement suggestions easy to understand
- ✅ Preview shows relevant information
- ✅ Errors have helpful messages
- ✅ Process completes in under 60 seconds

**Agent Integration:**
- ✅ Generated skill automatically discovered by agents
- ✅ Agents follow patterns in generated skill
- ✅ Skill globs match relevant files
- ✅ Multiple skills can coexist without conflicts

## Spec Documentation

- **Tasks**: @agent-os/specs/2025-12-30-add-skill-command/tasks.md
- **Research Notes**: @agent-os/specs/2025-12-30-add-skill-command/research-notes.md
- **Technical Specification**: @agent-os/specs/2025-12-30-add-skill-command/sub-specs/technical-spec.md

## Research Background

This specification was informed by:
- User Q&A session (4 questions answered)
- Analysis of existing skill templates
- Review of design-system-extractor as reference pattern
- Framework detection patterns from multiple languages
- Best practices for Spring Boot, React, FastAPI, Rails

Key insights:
- Need both code analysis AND best practices modes
- Interactive improvement suggestions are critical
- Preview before save prevents mistakes
- Project name detection must be robust
- Explore agent ideal for pattern discovery
