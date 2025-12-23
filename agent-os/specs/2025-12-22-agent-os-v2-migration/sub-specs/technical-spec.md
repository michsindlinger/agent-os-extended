# Technical Specification

This is the technical specification for the spec detailed in @agent-os/specs/2025-12-22-agent-os-v2-migration/spec.md

## Phase I: Structural Migration

### Directory Structure Changes

**Current Structure:**
```
.agent-os/
├── instructions/
│   ├── core/
│   └── meta/
├── standards/
├── specs/
├── docs/
└── bugs/

.claude/
├── commands/
│   ├── create-spec.md
│   ├── execute-tasks.md
│   └── ...
└── agents/
```

**New Structure:**
```
agent-os/
├── workflows/              # Renamed from instructions/
│   ├── core/
│   └── meta/
├── standards/
├── profiles/               # NEW: Profile definitions
├── skills/                 # NEW: Claude Code Skills
├── specs/
├── docs/
└── bugs/

.claude/
├── commands/
│   └── agent-os/          # NEW: Isolated namespace
│       ├── create-spec.md
│       ├── execute-tasks.md
│       └── ...
├── agents/
└── skills/                # NEW: Skills linked to agent-os/skills/
```

### Migration Script Requirements

**Script Name:** `update-to-v2.sh`

**Functionality:**
1. **Pre-flight Check**
   - Detect existing Agent OS Extended installation
   - Verify version (check for `.agent-os/` existence)
   - Check for uncommitted git changes (warn user)

2. **Backup Creation**
   - Create timestamped backup: `.agent-os.backup-YYYY-MM-DD-HHMMSS/`
   - Copy entire `.agent-os/` directory
   - Copy `.claude/commands/` directory
   - Store backup manifest with file list

3. **Directory Migration**
   - Rename `.agent-os/` → `agent-os/`
   - Rename `agent-os/instructions/` → `agent-os/workflows/`
   - Create `agent-os/profiles/` directory
   - Create `agent-os/skills/` directory

4. **Command Isolation**
   - Create `.claude/commands/agent-os/` directory
   - Move all Agent OS commands to new location
   - Update command references if needed

5. **Reference Updates**
   - Update all `@.agent-os/` references to `@agent-os/`
   - Update all `instructions/` references to `workflows/`
   - Update CLAUDE.md template references

6. **Verification**
   - Verify all files moved successfully
   - Check for broken references
   - Test one command execution
   - Display migration summary

7. **Rollback Capability**
   - Provide `rollback-v2-migration.sh` script
   - Restore from backup with single command

### Setup Script Updates

**Modified Files:**
- `setup.sh` - Base setup with new structure
- `setup-claude-code.sh` - Claude Code specific setup
- `update-agent-os.sh` - Update existing installations

**Changes:**
- Install to `agent-os/` instead of `.agent-os/`
- Install workflows to `agent-os/workflows/`
- Install commands to `.claude/commands/agent-os/`
- Install initial profiles to `agent-os/profiles/`
- Create skills structure in Phase II

## Phase II: Advanced Features

### Profile System Architecture

**Profile Definition Format:**
```yaml
# agent-os/profiles/java-spring-boot.md
---
name: "Java Spring Boot Backend"
inherits: null
description: "Enterprise Java backend with Spring Boot framework"
tech_stack:
  language: "Java 17+"
  framework: "Spring Boot 3.x"
  build_tool: "Maven/Gradle"
  database: "PostgreSQL"
skills:
  - java-core-patterns
  - spring-boot-conventions
  - jpa-best-practices
  - rest-api-design
---
```

**Profile Structure:**
```
agent-os/profiles/
├── base.md                    # Base profile (optional)
├── java-spring-boot.md
├── react-frontend.md
└── angular-frontend.md
```

**Profile Selection:**
- Configured in `agent-os/config.yml` per project
- Can be switched via command: `/switch-profile <profile-name>`
- Profile determines which skills are available

### Claude Skills System

**Skill Definition Format:**
```markdown
# .claude/skills/java-core-patterns.md
---
name: Java Core Patterns
description: Apply Java best practices and design patterns
triggers:
  - file_extension: .java
  - task_mentions: "java|spring|backend"
---

## Java Coding Standards

### Naming Conventions
- Classes: PascalCase
- Methods: camelCase
- Constants: UPPER_SNAKE_CASE

### Design Patterns
- Use dependency injection via Spring
- Prefer composition over inheritance
- Apply SOLID principles
...
```

**Skills Structure:**
```
.claude/skills/                  # Symlinked to agent-os/skills/
├── java-core-patterns.md
├── spring-boot-conventions.md
├── jpa-best-practices.md
├── react-component-patterns.md
├── react-hooks-best-practices.md
├── angular-component-patterns.md
└── angular-services-patterns.md
```

**Skill Activation:**
- Claude Code automatically detects when skills should activate
- Based on file type, task description, or explicit context
- Multiple skills can be active simultaneously
- No manual injection needed - reduces context by 60-80%

### Enhanced Research Workflow

**New `/create-spec` Flow:**

1. **Spec Initiation** (unchanged)
2. **Context Gathering** (unchanged)
3. **Research Phase** (NEW)
   - Codebase pattern analysis
   - Interactive Q&A session
   - Visual asset collection
   - Technical constraint discovery
4. **Requirements Clarification** (enhanced with research data)
5. **Spec Writing** (informed by research)
6. **Verification** (NEW)

**Research Phase Implementation:**

Create new workflow: `agent-os/workflows/research/analyze-codebase-patterns.md`

**Functionality:**
- Search for existing services/components matching feature domain
- Analyze architectural patterns in use
- Identify reusable code patterns
- Extract naming conventions
- Document findings in `research-notes.md`

**Interactive Q&A Implementation:**

Extend `/create-spec` with structured question templates:
```markdown
## Research Questions

### Technical Scope
Q: What are the supported output formats?
Q: Should this be synchronous or asynchronous?
Q: What are the performance requirements?

### Integration Points
Q: Which existing services should be reused?
Q: Are there external APIs to integrate?

### Security & Authorization
Q: Who can access this feature?
Q: What data privacy considerations exist?
```

**Visual Asset Integration:**

- Accept file paths, URLs, or uploaded mockups
- Store in `specs/YYYY-MM-DD-feature/mockups/`
- Reference in spec documentation
- Use for visual verification in Phase II verification system

### Verification System

**Three Verification Types:**

1. **Spec Verification** - `agent-os/workflows/verify-spec.md`
   - Business requirements completeness
   - Technical specification completeness
   - Security considerations
   - Testing strategy defined

2. **Implementation Verification** - `agent-os/workflows/verify-implementation.md`
   - Standards compliance check
   - Code pattern reuse verification
   - Security best practices
   - Test coverage check
   - Performance considerations

3. **Visual Verification** - `agent-os/workflows/verify-visual.md`
   - Compare implementation with mockups
   - Accessibility checks
   - Responsive behavior
   - (Note: Requires Playwright MCP - optional)

**Integration Points:**
- Spec verification: After spec writing, before tasks creation
- Implementation verification: After each task completion
- Visual verification: During orchestration phase (if mockups provided)

## Technical Requirements

### Phase I Requirements

- **Bash scripting** for migration and rollback scripts
- **Directory operations** must be atomic where possible
- **Backup storage** must include manifest for verification
- **Git integration** for detecting uncommitted changes
- **Error handling** with clear user messages and recovery options

### Phase II Requirements

- **YAML parsing** for profile definitions (or use markdown frontmatter)
- **Skill detection** via Claude Code's native skill system
- **Pattern analysis** using existing Grep/Read tools for codebase analysis
- **Markdown parsing** for extracting and organizing research data
- **File organization** for mockups and visual assets

### External Dependencies

**Phase I:**
- No new external dependencies
- Uses existing bash, git

**Phase II:**
- No new external dependencies
- Uses Claude Code's built-in Skills functionality
- Optional: Playwright MCP for visual verification (not required for core functionality)

### Performance Considerations

- Migration script should complete in <30 seconds for typical project
- Backup creation should be fast (direct copy, no compression needed)
- Profile switching should be instant (just configuration change)
- Skills activation is handled by Claude Code (no performance impact on our side)

### Backward Compatibility

- Migration is one-way (`.agent-os/` → `agent-os/`)
- Rollback script provided for reverting if needed
- Existing specs/docs/bugs preserved as-is
- Custom user modifications preserved during migration
