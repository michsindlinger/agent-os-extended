# Implementation Tasks: Team-Based Development System

> Spec: Team-Based Development System - Phase B
> Created: 2025-12-28
> Total Estimated Effort: 30-38 hours

## Task Overview

| Category | Tasks | Estimated Effort |
|----------|-------|------------------|
| 1. Skills Creation | 2 skills | 4-5h |
| 2. Template Creation | 12 templates | 4-5h |
| 3. Specialist Agents | 5 agents | 10-12h |
| 4. Workflow Modification | 1 major change | 6-8h |
| 5. Config & Setup | 3 files | 3-4h |
| 6. Documentation | 2 docs | 3-4h |
| 7. Testing & Verification | All components | 2-3h |

---

## Category 1: Skills Creation (4-5h total)

### Task 1.1: Create testing-best-practices.md
**Effort**: 2-2.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/base/testing-best-practices.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: Testing Best Practices
  description: Comprehensive testing patterns for unit, integration, and E2E tests
  triggers:
    - task_mentions: "test|spec|coverage|e2e|integration|unit"
    - file_contains: "@Test|describe\\(|it\\(|test\\("
    - file_extension: .test.ts|.test.tsx|.spec.ts|Test.java
  ---
  ```

- Content sections:
  - **Unit Test Patterns** (AAA, Given-When-Then, test isolation, mocking strategies)
  - **Integration Test Strategies** (TestContainers, test databases, API testing, MSW)
  - **E2E Test Best Practices** (Page Object pattern, wait strategies, test data, critical flows)
  - **Coverage Strategies** (what to test, what to skip, coverage targets 80%+)
  - **Test Organization** (directory structure, naming conventions, categorization)

- Examples: 3+ per pattern (Java JUnit, React Jest, E2E Playwright)
- Checklists: Pre-test, post-test, coverage analysis

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete
- [ ] Minimum 3 examples per test type (unit, integration, E2E)
- [ ] Coverage strategy clearly defined (80% target, what to test/skip)
- [ ] Works with JUnit 5 (Java) and Jest (TypeScript/React)

---

### Task 1.2: Create devops-patterns.md
**Effort**: 2-2.5h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/skills/base/devops-patterns.md`

**Deliverables**:
- Frontmatter with triggers:
  ```yaml
  ---
  name: DevOps Patterns
  description: CI/CD pipeline design and deployment best practices
  triggers:
    - task_mentions: "ci|cd|deploy|docker|pipeline|kubernetes|github actions"
    - file_contains: "Dockerfile|docker-compose|github/workflows"
    - file_extension: .yml|.yaml (in .github/workflows/)
  ---
  ```

- Content sections:
  - **CI/CD Pipeline Design** (test stages, deployment gates, artifact management, GitHub Actions)
  - **Docker Best Practices** (multi-stage builds, layer caching, security, base images, .dockerignore)
  - **GitHub Actions Patterns** (workflow reuse, matrix builds, caching, secrets, conditional execution)
  - **Deployment Strategies** (blue-green, canary, rolling, feature flags)
  - **Environment Management** (dev/staging/prod, config, secrets rotation, DB migrations)

- Examples: GitHub Actions workflow, Dockerfile multi-stage, docker-compose for dev
- Checklists: CI/CD setup, Docker security, deployment readiness

**Acceptance Criteria**:
- [ ] Frontmatter includes correct triggers
- [ ] All 5 content sections complete
- [ ] GitHub Actions workflow examples (CI + CD)
- [ ] Docker multi-stage build example
- [ ] Deployment strategy comparison (pros/cons)

---

## Category 2: Template Creation (4-5h total)

### Task 2.1: Create backend templates (4 templates)
**Effort**: 1.5-2h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/team-development/backend/`

**Templates to Create**:

1. **api-spec.md**:
   - Endpoint specification (method, path, request, response)
   - Headers, body structure, error codes
   - Implementation checklist

2. **service-class.md**:
   - Service layer class template
   - Business logic patterns
   - Transaction management
   - Exception handling

3. **repository-class.md**:
   - Spring Data JPA repository
   - Custom queries
   - Pagination support

4. **backend-handoff.md**:
   - API endpoints table
   - Mock files location
   - Authentication details
   - Error format
   - For frontend developer section

**Acceptance Criteria**:
- [ ] All 4 templates created
- [ ] Placeholders use [VARIABLE] format
- [ ] Examples provided for guidance
- [ ] Checklists included

---

### Task 2.2: Create frontend templates (4 templates)
**Effort**: 1.5-2h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/team-development/frontend/`

**Templates to Create**:

1. **component-spec.md**:
   - Component purpose, props interface
   - State management
   - API integration
   - User interactions
   - Implementation checklist

2. **page-spec.md**:
   - Full page with routing
   - Layout structure
   - Components used
   - Data fetching strategy

3. **state-management.md**:
   - Redux/NgRx setup
   - Actions, reducers, selectors
   - Store configuration

4. **frontend-handoff.md**:
   - Components implemented
   - API service integration notes
   - Mock usage instructions
   - For QA specialist section (E2E test scenarios)

**Acceptance Criteria**:
- [ ] All 4 templates created
- [ ] Support both React and Angular (note framework differences)
- [ ] Integration with API mocks documented
- [ ] Test scenarios suggested

---

### Task 2.3: Create QA templates (2 templates)
**Effort**: 45 min
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/templates/team-development/qa/`

**Templates to Create**:

1. **test-plan.md**:
   - Test scope (unit, integration, E2E)
   - Test cases list
   - Coverage goals
   - Test data requirements
   - Execution plan

2. **test-report.md**:
   - Test summary table (total, passed, failed, coverage)
   - Failure details (test name, error, root cause, status)
   - Coverage analysis (backend %, frontend %, critical paths %)
   - Quality gates checklist
   - Ready for deployment: YES/NO

**Acceptance Criteria**:
- [ ] Both templates created
- [ ] Test summary table format defined
- [ ] Failure tracking structure clear
- [ ] Quality gates listed

---

### Task 2.4: Create DevOps templates (2 templates)
**Effort**: 45 min
**Priority**: MEDIUM
**Dependencies**: None

**Location**: `agent-os/templates/team-development/devops/`

**Templates to Create**:

1. **ci-cd-config.md**:
   - Pipeline stages (test, build, deploy)
   - GitHub Actions workflow structure
   - Environment variables needed
   - Secrets configuration

2. **deployment-plan.md**:
   - Environment setup (staging, production)
   - Deployment steps
   - Rollback procedure
   - Health checks
   - Secrets/config needed

**Acceptance Criteria**:
- [ ] Both templates created
- [ ] GitHub Actions examples included
- [ ] Deployment checklist provided
- [ ] Secrets management documented

---

## Category 3: Specialist Agents (10-12h total)

### Task 3.1: Create backend-dev.md agent
**Effort**: 3-3.5h
**Priority**: CRITICAL
**Dependencies**: Task 1.1 (testing-best-practices skill)

**Location**: `.claude/agents/backend-dev.md`

**Deliverables**:
- Frontmatter (name, description, tools: Read/Write/Edit/Grep/Glob/Bash/LSP, color)
- Core Responsibilities section:
  - Generate REST controllers (@RestController, endpoints)
  - Generate service layer (@Service, business logic)
  - Generate repositories (Spring Data JPA)
  - Generate DTOs (request/response with validation)
  - Generate JPA entities (@Entity, relationships)
  - Generate unit tests (JUnit 5, Mockito, >80% coverage)
  - Generate API mocks (JSON for frontend)
  - Handle exceptions (@ControllerAdvice, custom exceptions)

- Automatic Skills Integration section:
  - List: java-core-patterns, spring-boot-conventions, jpa-best-practices, security-best-practices
  - Trigger conditions: .java files, @RestController, @Service annotations

- Workflow Process section:
  - Step 1: Receive API tasks from execute-tasks routing
  - Step 2: Load relevant specs (spec-lite.md, technical-spec.md)
  - Step 3: Generate controller (endpoint methods)
  - Step 4: Generate service (business logic)
  - Step 5: Generate repository (data access)
  - Step 6: Generate DTOs (request/response)
  - Step 7: Generate entity (if new)
  - Step 8: Generate unit tests for all classes
  - Step 9: Generate API mocks for frontend
  - Step 10: Run tests (verify all pass)
  - Step 11: Generate handoff summary

- API Mock Generation section:
  - How to extract endpoint info from controller
  - Mock JSON structure
  - Example responses

- Output Format section (handoff template)
- Important Constraints section:
  - Follow SOLID principles (from java-core-patterns)
  - Use dependency injection (from spring-boot-conventions)
  - Prevent N+1 queries (from jpa-best-practices)
  - Validate inputs (from security-best-practices)

**Acceptance Criteria**:
- [ ] Frontmatter complete
- [ ] All responsibilities documented
- [ ] Step-by-step workflow (11 steps)
- [ ] API mock generation explained
- [ ] Handoff format defined
- [ ] Examples for each code type (controller, service, repo, DTO, entity, test)

---

### Task 3.2: Create frontend-dev.md agent
**Effort**: 3-3.5h
**Priority**: CRITICAL
**Dependencies**: Task 1.1 (testing-best-practices skill)

**Location**: `.claude/agents/frontend-dev.md`

**Deliverables**:
- Frontmatter (tools: Read/Write/Edit/Grep/Glob/Bash/LSP)
- Core Responsibilities section:
  - Generate React/Angular components (functional components, TypeScript)
  - Generate custom hooks (React) or services (Angular)
  - Generate API services (uses backend mocks)
  - Generate TypeScript interfaces/types
  - Generate state management (Context API, Redux, NgRx)
  - Generate forms (validation, error handling)
  - Generate component tests (RTL, Angular Testing Library, >80%)
  - Follow component patterns from skills

- Multi-Framework Support section:
  - React detection (package.json has "react")
  - Angular detection (package.json has "@angular/core")
  - Profile-based (active_profile: react-frontend or angular-frontend)

- Workflow Process section:
  - Step 1: Receive UI tasks from routing
  - Step 2: Receive backend handoff (API mocks)
  - Step 3: Load specs
  - Step 4: Generate component files
  - Step 5: Generate API service (integrates mocks)
  - Step 6: Generate types/interfaces
  - Step 7: Generate tests
  - Step 8: Run tests (verify pass)
  - Step 9: Generate handoff summary

- Mock Integration section:
  - How to use api-mocks/ from backend
  - Development vs. production mode switching
  - MSW setup example (React)

**Acceptance Criteria**:
- [ ] Supports both React and Angular
- [ ] Mock integration clearly explained
- [ ] Component generation examples (both frameworks)
- [ ] Test generation examples
- [ ] Handoff format defined

---

### Task 3.3: Create qa-specialist.md agent
**Effort**: 2.5-3h
**Priority**: CRITICAL
**Dependencies**: Task 1.1 (testing-best-practices), test-runner utility agent (exists)

**Location**: `.claude/agents/qa-specialist.md`

**Deliverables**:
- Frontmatter
- Core Responsibilities section:
  - Execute unit tests (backend: mvn test, frontend: npm test)
  - Execute integration tests (API-level)
  - Execute E2E tests (Playwright/Cypress)
  - Analyze test failures (error messages, stack traces)
  - Identify root cause and responsible specialist
  - Delegate fixes to backend-dev or frontend-dev
  - Auto-fix loop (max 3 attempts)
  - Generate test reports
  - Verify coverage ≥80%

- Integration with test-runner section:
  - Delegates actual execution to test-runner utility
  - Receives results, analyzes
  - Makes decisions (fix or proceed)

- Auto-Fix Loop section:
  ```
  WHILE tests failing AND attempts < 3:
    1. Analyze failures
    2. Identify specialist (backend/frontend)
    3. Delegate fix with error details
    4. Specialist fixes
    5. Re-run tests
    6. Increment attempts

  IF still failing:
    Report to user, pause workflow
  ```

- Test Failure Analysis section:
  - How to parse JUnit XML output
  - How to parse Jest JSON output
  - Common error patterns (NullPointer, validation, 404, etc.)
  - Mapping errors to specialists

**Acceptance Criteria**:
- [ ] All 3 test types handled (unit, integration, E2E)
- [ ] Auto-fix loop clearly defined (max 3 attempts)
- [ ] test-runner integration explained
- [ ] Failure analysis patterns documented
- [ ] Test report generation specified

---

### Task 3.4: Create devops-specialist.md agent
**Effort**: 2-2.5h
**Priority**: HIGH
**Dependencies**: Task 1.2 (devops-patterns skill)

**Location**: `.claude/agents/devops-specialist.md`

**Deliverables**:
- Frontmatter
- Core Responsibilities section:
  - Generate GitHub Actions CI workflow (test + build)
  - Generate GitHub Actions CD workflow (deploy to staging)
  - Generate Dockerfile (backend: Java, frontend: Node + Nginx)
  - Generate docker-compose.yml (local multi-container dev)
  - Generate deployment-plan.md (environment setup, secrets)
  - Test CI/CD locally (validate workflow syntax)

- CI/CD Generation section:
  - GitHub Actions workflow structure (jobs, steps, matrix)
  - Test stage (backend + frontend parallel)
  - Build stage (artifacts, caching)
  - Deployment stage (conditional on branch)

- Containerization section:
  - Dockerfile multi-stage builds
  - Backend: Maven build → JRE runtime
  - Frontend: npm build → Nginx serve
  - Layer optimization, security scanning

**Acceptance Criteria**:
- [ ] GitHub Actions workflows generated (ci.yml, deploy-staging.yml)
- [ ] Dockerfiles for backend + frontend
- [ ] docker-compose.yml for local dev
- [ ] Deployment plan with secrets list
- [ ] Examples for Spring Boot + React

---

### Task 3.5: Create mock-generator.md utility agent
**Effort**: 1.5-2h
**Priority**: MEDIUM
**Dependencies**: None

**Location**: `.claude/agents/mock-generator.md`

**Deliverables**:
- Frontmatter (tools: Read, Write, Grep)
- Core Responsibilities section:
  - Analyze backend controller code
  - Extract API endpoints (method, path, return type)
  - Analyze DTO/Entity classes for response structure
  - Generate JSON mock files matching structure
  - Keep mocks in sync with API changes

- Mock Generation Logic section:
  ```
  Input: UserController.java

  Step 1: Find @RestController class
  Step 2: Find @GetMapping/@PostMapping methods
  Step 3: Extract paths, return types
  Step 4: Analyze return type (UserDTO → fields: id, name, email)
  Step 5: Generate sample data (realistic values)
  Step 6: Create JSON structure

  Output: api-mocks/users.json
  ```

- Sample Data Generation section:
  - Realistic values (not "test", "foo", "bar")
  - Consistent IDs (1, 2, 3...)
  - Valid formats (emails, dates, UUIDs)

**Acceptance Criteria**:
- [ ] Analyzes Spring Boot controllers correctly
- [ ] Extracts all endpoint info (method, path, types)
- [ ] Generates valid JSON
- [ ] Sample data is realistic
- [ ] Supports common types (List, Page, Optional)

---

## Category 4: Workflow Modification (6-8h total)

### Task 4.1: Extend execute-tasks.md with task routing
**Effort**: 6-8h
**Priority**: CRITICAL
**Dependencies**: All agents (3.1-3.5)

**Location**: `agent-os/workflows/core/execute-tasks.md`

**Modifications**:

**Add after Step 4** (before current Step 5 task execution):
```xml
<step number="4.5" name="load_team_system_config">
  ### Step 4.5: Load Team System Configuration

  Load team_system section from config.yml

  <conditional_logic>
    IF team_system.enabled == false:
      SET use_team_routing = false
      PROCEED to Step 5 (execute directly)

    ELSE:
      SET use_team_routing = true
      LOAD routing rules from config
      PROCEED to Step 5 (with routing)
  </conditional_logic>
</step>
```

**Replace Step 5** (current task execution):
```xml
<step number="5" name="task_execution_loop">
  ### Step 5: Task Execution (Enhanced with Team Routing)

  <conditional_logic>
    IF use_team_routing == false:
      <!-- EXISTING BEHAVIOR: Execute directly -->
      FOR each task IN tasks.md:
        Execute task directly (current logic unchanged)
      NEXT task

    ELSE (use_team_routing == true):
      <!-- NEW BEHAVIOR: Smart routing -->

      <!-- Group tasks by type -->
      <task_grouping>
        backend_tasks = filter_tasks(tasks, type="backend")
        frontend_tasks = filter_tasks(tasks, type="frontend")
        qa_tasks = filter_tasks(tasks, type="qa")
        devops_tasks = filter_tasks(tasks, type="devops")
        other_tasks = filter_tasks(tasks, type="unknown")
      </task_grouping>

      <!-- Phase 1: Backend -->
      IF backend_tasks.length > 0:
        DELEGATE to backend-dev subagent
        RECEIVE: Code + mocks + handoff
        UPDATE: team-progress.md, team-handoffs.md

      <!-- Phase 2: Frontend -->
      IF frontend_tasks.length > 0:
        DELEGATE to frontend-dev subagent
        PROVIDE: Backend handoff (mocks)
        RECEIVE: UI code + handoff
        UPDATE: team-progress.md, team-handoffs.md

      <!-- Phase 3: QA (auto if code generated) -->
      IF qa_tasks.length > 0 OR backend/frontend code generated:
        DELEGATE to qa-specialist subagent
        qa runs tests, auto-fixes failures
        RECEIVE: Test report
        UPDATE: team-progress.md

      <!-- Phase 4: DevOps -->
      IF devops_tasks.length > 0:
        DELEGATE to devops-specialist subagent
        RECEIVE: CI/CD config
        UPDATE: team-progress.md

      <!-- Phase 5: Other tasks -->
      IF other_tasks.length > 0:
        FOR each task IN other_tasks:
          EXECUTE directly (current logic)

  </conditional_logic>
</step>
```

**Add task detection helper** (in workflow):
```xml
<task_type_detection>
  FUNCTION detect_task_type(task_description, file_paths):

    description_lower = task_description.toLowerCase()

    # Backend keywords
    backend_keywords = [api, endpoint, controller, service, repository, rest, graphql, database, migration, entity]
    IF any(keyword IN description_lower for keyword IN backend_keywords):
      RETURN "backend"

    # Backend file paths
    IF any(".java" IN path OR "/controller/" IN path OR "/service/" IN path for path IN file_paths):
      RETURN "backend"

    # Frontend keywords
    frontend_keywords = [component, page, view, ui, frontend, react, angular, state, redux, ngrx, form]
    IF any(keyword IN description_lower for keyword IN frontend_keywords):
      RETURN "frontend"

    # Frontend file paths
    IF any(".tsx" IN path OR ".component.ts" IN path OR "/components/" IN path for path IN file_paths):
      RETURN "frontend"

    # Test keywords
    test_keywords = [test, spec, coverage, e2e, integration, unit, playwright, cypress, jest, junit]
    IF any(keyword IN description_lower for keyword IN test_keywords):
      RETURN "qa"

    # DevOps keywords
    devops_keywords = [deploy, ci, cd, docker, pipeline, github actions, kubernetes, ci/cd, dockerfile]
    IF any(keyword IN description_lower for keyword IN devops_keywords):
      RETURN "devops"

    # Unknown - execute directly
    RETURN null
</task_type_detection>
```

**Acceptance Criteria**:
- [ ] Backward compatible (team_system: false → unchanged behavior)
- [ ] Task grouping logic implemented
- [ ] Specialist delegation for each phase
- [ ] Handoff tracking (team-handoffs.md updates)
- [ ] Progress tracking (team-progress.md updates)
- [ ] Fallback to direct execution for unknown tasks
- [ ] All current execute-tasks.md functionality preserved

---

## Category 5: Config & Setup (3-4h total)

### Task 5.1: Update agent-os/config.yml
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: None

**Location**: `agent-os/config.yml`

**Add New Section**:
```yaml
# Team-Based Development System (Phase B)
team_system:
  # Enable team system
  enabled: true

  # File lookup order (project first, global fallback)
  lookup_order:
    - project
    - global

  # Coordination mode
  coordination_mode: sequential  # MVP (parallel in Phase C)

  # Task routing
  task_routing:
    enabled: true  # Enable in /execute-tasks
    auto_delegate: true  # Automatically route by type

  # Specialist configuration
  specialists:
    backend_dev:
      enabled: true
      default_stack: java_spring_boot  # Options: java_spring_boot, nodejs_express
      code_generation: full  # Options: full, scaffolding, guidance

    frontend_dev:
      enabled: true
      default_framework: react  # Options: react, angular
      code_generation: full

    qa_specialist:
      enabled: true
      test_types: [unit, integration, e2e]
      coverage_target: 80  # Percentage
      auto_fix_attempts: 3

    devops_specialist:
      enabled: true
      ci_platform: github_actions
      containerization: docker

  # Quality gates
  quality_gates:
    unit_tests_required: true
    integration_tests_required: true
    coverage_minimum: 80
    build_success_required: true
    linting_required: true

  # Task routing rules (keywords for detection)
  routing_rules:
    backend_keywords: [api, endpoint, controller, service, repository, rest, graphql, database, migration, entity]
    frontend_keywords: [component, page, view, ui, frontend, react, angular, state, redux, ngrx, form]
    qa_keywords: [test, spec, coverage, e2e, integration, unit, playwright, cypress, jest, junit]
    devops_keywords: [deploy, ci, cd, docker, pipeline, github actions, kubernetes, ci/cd]
```

**Update features section**:
```yaml
features:
  profile_system: true
  skills_system: true
  enhanced_research: true
  verification_system: true
  market_validation: true  # Phase A
  team_system: true  # Phase B - NEW
```

**Acceptance Criteria**:
- [ ] team_system section added
- [ ] All configuration options documented
- [ ] Default values reasonable
- [ ] Features flag added
- [ ] YAML syntax valid

---

### Task 5.2: Create setup-team-system-global.sh
**Effort**: 1.5-2h
**Priority**: HIGH
**Dependencies**: All skills (1.1-1.2), all templates (2.1-2.4), all agents (3.1-3.5)

**Location**: `setup-team-system-global.sh`

**Pattern**: Copy from `setup-market-validation-global.sh`

**Script Structure**:
```bash
#!/bin/bash
# Team-Based Development System - Global Installation

REPO_URL="https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main"

# Create directories
mkdir -p ~/.agent-os/skills/base
mkdir -p ~/.agent-os/templates/team-development/backend
mkdir -p ~/.agent-os/templates/team-development/frontend
mkdir -p ~/.agent-os/templates/team-development/qa
mkdir -p ~/.agent-os/templates/team-development/devops
mkdir -p ~/.claude/agents

# Download skills (2 new)
download_file "$REPO_URL/agent-os/skills/base/testing-best-practices.md" ~/.agent-os/skills/base/testing-best-practices.md "skill"
download_file "$REPO_URL/agent-os/skills/base/devops-patterns.md" ~/.agent-os/skills/base/devops-patterns.md "skill"

# Download templates (12 new, 4 per category)
# Backend templates
download_file "$REPO_URL/agent-os/templates/team-development/backend/api-spec.md" ...
# [All 12 templates]

# Download specialist agents (5 new)
download_file "$REPO_URL/.claude/agents/backend-dev.md" ~/.claude/agents/backend-dev.md "agent"
download_file "$REPO_URL/.claude/agents/frontend-dev.md" ~/.claude/agents/frontend-dev.md "agent"
download_file "$REPO_URL/.claude/agents/qa-specialist.md" ~/.claude/agents/qa-specialist.md "agent"
download_file "$REPO_URL/.claude/agents/devops-specialist.md" ~/.claude/agents/devops-specialist.md "agent"
download_file "$REPO_URL/.claude/agents/mock-generator.md" ~/.claude/agents/mock-generator.md "agent"

# Create skill symlinks
ln -sf ~/.agent-os/skills/base/testing-best-practices.md ~/.claude/skills/testing-best-practices.md
ln -sf ~/.agent-os/skills/base/devops-patterns.md ~/.claude/skills/devops-patterns.md

echo "✅ Team System (Global) installed!"
```

**Acceptance Criteria**:
- [ ] Downloads all 2 skills
- [ ] Downloads all 12 templates
- [ ] Downloads all 5 agents
- [ ] Creates skill symlinks
- [ ] Error handling for failed downloads
- [ ] Success message with usage instructions

---

### Task 5.3: Create setup-team-system-project.sh
**Effort**: 45 min
**Priority**: HIGH
**Dependencies**: Task 5.2

**Location**: `setup-team-system-project.sh`

**Pattern**: Copy from `setup-market-validation-project.sh`

**Script Structure**:
```bash
#!/bin/bash
# Team-Based Development System - Project Setup

# Check global installation
if [[ ! -d ~/.claude/agents/backend-dev.md ]]; then
    echo "❌ Global installation not found"
    echo "Run: setup-team-system-global.sh first"
    exit 1
fi

# Create project directories
mkdir -p agent-os/team-deliverables
mkdir -p .claude/agents  # For overrides

# Create config if not exists
if [[ -f agent-os/config.yml ]]; then
    # Add team_system section if missing
    if ! grep -q "team_system:" agent-os/config.yml; then
        cat >> agent-os/config.yml << 'EOF'

# Team System (uses global installation)
team_system:
  enabled: true
  lookup_order:
    - project
    - global
EOF
    fi
fi

echo "✅ Project ready for team-based development!"
echo "Usage: /execute-tasks (with team routing)"
```

**Acceptance Criteria**:
- [ ] Checks for global installation
- [ ] Creates team deliverables directory
- [ ] Updates config.yml if needed
- [ ] Clear usage instructions

---

## Category 6: Documentation (3-4h total)

### Task 6.1: Update README.md
**Effort**: 1.5-2h
**Priority**: HIGH
**Dependencies**: All implementation tasks

**Location**: `README.md`

**Add Section**: "Team-Based Development System (Phase B)"

**Content**:
```markdown
## Team-Based Development System (Phase B) 🆕

**Coordinate specialized development agents for full-stack feature implementation.**

### Installation

```bash
# Global installation (once)
curl -sSL https://raw.../setup-team-system-global.sh | bash

# Per project
cd your-project
curl -sSL https://raw.../setup-team-system-project.sh | bash
```

### How It Works

```bash
# Create tasks.md with mixed tasks
cat > tasks.md << 'EOF'
- Create POST /api/users endpoint with validation
- Create UserList component with search
- Add comprehensive tests
- Setup GitHub Actions CI/CD
EOF

# Run execute-tasks (system routes automatically)
/execute-tasks

# System delegates:
# Task 1 → backend-dev (generates Spring Boot API + mocks)
# Task 2 → frontend-dev (generates React component using mocks)
# Task 3 → qa-specialist (runs unit + integration + E2E, auto-fixes failures)
# Task 4 → devops-specialist (generates CI/CD pipeline)

# Result: Fully implemented, tested, deployable feature
```

### Specialists (4)

1. **backend-dev** - Java Spring Boot + Node.js backend (auto-loads Java/Spring skills)
2. **frontend-dev** - React + Angular frontend (auto-loads React/Angular skills)
3. **qa-specialist** - Comprehensive testing with auto-fix
4. **devops-specialist** - CI/CD and containerization

### Features

- Smart task routing (automatic specialist delegation)
- Full code generation (production-ready implementations)
- API mock generation (frontend develops independently)
- Auto-fix test failures (QA delegates fixes to specialists)
- Multi-stack support (Java/Node.js backend, React/Angular frontend)
- Sequential coordination (clear handoffs)

### Integration

- Transparent extension of /execute-tasks
- Backward compatible (enable/disable with config flag)
- Skills auto-activate (Java skills for backend-dev, React skills for frontend-dev)
- Global + override pattern (customize per project)

**Learn More**: See agent-os/workflows/team/README.md
```

**Acceptance Criteria**:
- [ ] Section added to README.md
- [ ] Installation instructions clear
- [ ] Example usage provided
- [ ] Features highlighted
- [ ] Integration explained

---

### Task 6.2: Create team/README.md guide
**Effort**: 1.5-2h
**Priority**: HIGH
**Dependencies**: All implementation tasks

**Location**: `agent-os/workflows/team/README.md` (NOTE: Workflow doesn't exist yet - this is a guide)

**Content Outline** (2,000-2,500 words):

1. **Introduction** - What is team-based development
2. **Installation** - Global + project setup
3. **How Task Routing Works** - Keyword detection examples
4. **Specialist Agents** - Each specialist's role and capabilities
5. **Example Feature** - Full walkthrough (API + UI + tests + CI/CD)
6. **Customization** - Override agents, config thresholds
7. **Troubleshooting** - Common issues (routing fails, tests fail, build errors)
8. **Best Practices** - Task naming for good routing, when to override
9. **FAQ** - 10 common questions

**Acceptance Criteria**:
- [ ] All 9 sections complete
- [ ] Example walkthrough detailed (step-by-step)
- [ ] Troubleshooting covers common issues
- [ ] FAQ answers key questions

---

## Category 7: Testing & Verification (2-3h total)

### Task 7.1: Test specialist agents individually
**Effort**: 1h
**Priority**: HIGH
**Dependencies**: All agents (3.1-3.5)

**Test Cases**:

**backend-dev**:
```
Input: Task "Create POST /api/products endpoint"
Expected Output:
- ProductController.java (with @PostMapping)
- ProductService.java
- ProductRepository.java
- Product.java (entity)
- ProductDTO.java, ProductCreateRequest.java
- Unit tests (ProductControllerTest.java, etc.)
- api-mocks/products.json
- Handoff summary

Verify: Code compiles, tests pass, mock generated
```

**frontend-dev**:
```
Input: Task "Create ProductList component with filters"
+ Backend handoff (api-mocks/products.json)

Expected Output:
- ProductList.tsx
- ProductCard.tsx
- ProductService.ts (uses mocks)
- types/Product.ts
- ProductList.test.tsx
- Handoff summary

Verify: npm test passes, coverage >80%
```

**qa-specialist**:
```
Input: Failing test (inject NullPointerException in code)

Expected Behavior:
1. Detect failure
2. Analyze error
3. Delegate to backend-dev
4. backend-dev fixes
5. Re-run tests
6. All pass ✅

Verify: Auto-fix loop works, max 3 attempts enforced
```

**devops-specialist**:
```
Input: Task "Setup CI/CD pipeline"

Expected Output:
- .github/workflows/ci.yml
- Dockerfile (backend)
- Dockerfile (frontend)
- docker-compose.yml
- deployment-plan.md

Verify: Workflow syntax valid (GitHub Actions validator)
```

**Acceptance Criteria**:
- [ ] All 4 specialists tested
- [ ] Outputs match expected formats
- [ ] Skills activate correctly
- [ ] Generated code compiles/runs

---

### Task 7.2: Integration test complete workflow
**Effort**: 1-1.5h
**Priority**: CRITICAL
**Dependencies**: Task 4.1 (execute-tasks.md modified)

**Test Case**: Full-stack user management feature

**Setup**:
```markdown
# tasks.md
- Create GET /api/users endpoint
- Create POST /api/users endpoint with email validation
- Create UserList component with search functionality
- Create UserForm component for adding users
- Add unit tests for UserService and UserRepository
- Add component tests for UserList
- Add E2E test for user creation flow
- Setup GitHub Actions CI pipeline
```

**Expected Flow**:
```
1. /execute-tasks runs
2. System groups tasks:
   - backend: 2 API tasks
   - frontend: 2 UI tasks
   - qa: 3 test tasks
   - devops: 1 CI/CD task

3. backend-dev executes:
   - Generates UserController.java (GET, POST)
   - Generates UserService.java, UserRepository.java
   - Generates User.java, UserDTO.java, UserCreateRequest.java
   - Generates unit tests (8 tests)
   - Generates api-mocks/users.json
   - Handoff to frontend

4. frontend-dev executes:
   - Receives mocks
   - Generates UserList.tsx, UserForm.tsx, UserCard.tsx
   - Generates UserService.ts (uses mocks)
   - Generates types/User.ts
   - Generates tests (6 tests)
   - Handoff to QA

5. qa-specialist executes:
   - Runs backend tests: mvn test → 8/8 passing
   - Runs frontend tests: npm test → 6/6 passing
   - Runs E2E test generation + execution
   - All green ✅
   - Handoff to DevOps

6. devops-specialist executes:
   - Generates .github/workflows/ci.yml
   - Generates Dockerfile × 2
   - Generates docker-compose.yml
   - Pipeline ready ✅

7. git-workflow commits all code
   Co-Authored-By: backend-dev, frontend-dev, qa-specialist, devops-specialist
```

**Verify**:
- [ ] Task routing correct (all tasks routed properly)
- [ ] All code generated
- [ ] All tests pass
- [ ] CI/CD config valid
- [ ] Handoffs complete
- [ ] Team progress tracked

---

### Task 7.3: Test backward compatibility
**Effort**: 30 min
**Priority**: HIGH
**Dependencies**: Task 4.1

**Test Cases**:

**Scenario 1**: team_system.enabled: false
```
Expected: All tasks execute directly (current behavior)
No routing, no specialist delegation
Unchanged from current /execute-tasks
```

**Scenario 2**: team_system.enabled: true, but tasks don't match keywords
```
Tasks: "Refactor authentication", "Update README"
Expected: Task type detection returns null
Tasks execute directly (fallback)
No specialist delegation
```

**Scenario 3**: team_system.enabled: true, mixed tasks
```
Tasks: "Create API" (backend), "Update docs" (unknown)
Expected: API task → backend-dev
        Docs task → direct execution
        Both complete successfully
```

**Acceptance Criteria**:
- [ ] All 3 scenarios pass
- [ ] No regressions to current behavior
- [ ] Graceful fallback when routing not possible

---

## Task Dependencies Diagram

```
Category 1 (Skills - Foundation)
  ├── 1.1 testing-best-practices ──┐
  └── 1.2 devops-patterns ─────────┼─► Category 3 (Agents)
                                   │   ├── 3.1 backend-dev
Category 2 (Templates)             │   ├── 3.2 frontend-dev
  ├── 2.1 Backend templates (4) ───┤   ├── 3.3 qa-specialist
  ├── 2.2 Frontend templates (4) ──┤   ├── 3.4 devops-specialist
  ├── 2.3 QA templates (2) ────────┤   └── 3.5 mock-generator
  └── 2.4 DevOps templates (2) ────┘         │
                                              │
Category 4 (Workflow) ◄─────────────────────┤
  └── 4.1 Extend execute-tasks.md           │
        │                                    │
Category 5 (Config & Setup) ◄───────────────┤
  ├── 5.1 Update config.yml                 │
  ├── 5.2 setup-team-system-global.sh ◄─────┤
  └── 5.3 setup-team-system-project.sh      │
        │                                    │
Category 6 (Documentation) ◄────────────────┤
  ├── 6.1 README.md update                  │
  └── 6.2 team/README.md guide              │
        │                                    │
Category 7 (Testing) ◄──────────────────────┘
  ├── 7.1 Test agents individually
  ├── 7.2 Integration test full workflow
  └── 7.3 Test backward compatibility
```

---

## Recommended Implementation Order

**Week 1: Foundation (Skills + Templates)**
- Day 1-2: Tasks 1.1-1.2 (Skills)
- Day 3-4: Tasks 2.1-2.4 (Templates)

**Week 2-3: Agents (Core Implementation)**
- Day 1-2: Task 3.1 (backend-dev - most complex)
- Day 3: Task 3.2 (frontend-dev)
- Day 4: Task 3.3 (qa-specialist)
- Day 5: Task 3.4 (devops-specialist)
- Day 6: Task 3.5 (mock-generator)

**Week 3-4: Integration & Deployment**
- Day 1-3: Task 4.1 (Extend execute-tasks - critical)
- Day 4: Tasks 5.1-5.3 (Config + Setup scripts)
- Day 5-6: Tasks 6.1-6.2 (Documentation)
- Day 7: Tasks 7.1-7.3 (Testing)

**Total Timeline**: 4 weeks part-time or 1-1.5 weeks full-time

---

## Success Criteria (Overall)

**Functional**:
- [ ] User runs /execute-tasks with mixed tasks
- [ ] System routes tasks correctly (>90% accuracy)
- [ ] backend-dev generates working Spring Boot code
- [ ] frontend-dev generates working React code
- [ ] qa-specialist runs all test types
- [ ] qa-specialist auto-fixes failures (3 attempts)
- [ ] devops-specialist generates valid CI/CD config
- [ ] All specialists respect skills guidance

**Quality**:
- [ ] Generated code follows best practices (SOLID, patterns from skills)
- [ ] Test coverage ≥80%
- [ ] All tests pass
- [ ] Code compiles and builds
- [ ] No linting errors
- [ ] API mocks match actual API

**Integration**:
- [ ] Backward compatible (team_system: false works)
- [ ] Skills auto-activate for specialists
- [ ] Profile system works (Java profile → Java code)
- [ ] Global + override pattern works
- [ ] Handoffs clear and complete

**Documentation**:
- [ ] README.md updated
- [ ] Complete team guide written
- [ ] Example project documented
- [ ] Troubleshooting covers issues

---

**Total Tasks**: 23
**Estimated Effort**: 30-38 hours
**Recommended Timeline**: 4 weeks (part-time) or 1.5 weeks (full-time)

**Next Steps**: Begin with Category 1 (Skills Creation) as foundation for specialist expertise.
