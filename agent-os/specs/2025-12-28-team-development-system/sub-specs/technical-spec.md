# Technical Specification: Team-Based Development System

> Spec: Team-Based Development System - Phase B
> Created: 2025-12-28
> Parent Spec: @agent-os/specs/2025-12-28-team-development-system/spec.md

## Architecture Overview

The Team-Based Development System extends Agent OS Extended's task execution with intelligent specialist delegation:

```
User → /execute-tasks
  ↓
execute-tasks.md (modified)
  ↓
Step 5: Task Execution Loop (ENHANCED)
  ↓
Task Type Detection (NEW)
  ├─ API keywords → backend-dev specialist
  ├─ UI keywords → frontend-dev specialist
  ├─ Test keywords → qa-specialist
  ├─ Deploy keywords → devops-specialist
  └─ Unknown → Execute directly (current behavior)
  ↓
Sequential Specialist Execution:
  1. backend-dev → API code + mocks
  2. frontend-dev → UI code (uses mocks)
  3. qa-specialist → Tests (auto-fix loop)
  4. devops-specialist → CI/CD setup
  ↓
git-workflow → Team commit with co-authors
```

## Reusable Components (From Codebase Analysis)

### 1. Market Validation Agent Pattern (HIGHLY REUSABLE)

**Source**: 7 specialist agents in Market Validation System

**Agent Structure Pattern**:
```markdown
---
name: agent-name
description: Brief description
tools: Read, Write, Edit, Grep, Glob, Bash, LSP
color: blue
mcp_integrations: (optional)
---

## Core Responsibilities
## Automatic Skills Integration
## Workflow Process
## Output Format
## Important Constraints
```

**Application to Development Specialists**:
- ✅ Same frontmatter structure
- ✅ Same sections (responsibilities, skills, workflow, output, constraints)
- ✅ Tools: Add LSP for code intelligence, Bash for build commands
- ✅ MCP integrations: Add chrome-devtools for qa-specialist visual testing

### 2. Sequential Coordination Pattern (FROM MARKET VALIDATION)

**Source**: `validate-market.md` (18 steps, 7 specialists)

**Proven Pattern**:
```xml
<step number="X" subagent="specialist-name" name="step_id">
  ### Step X: Description

  Delegate to specialist:
  - Input: [What specialist receives]
  - Process: [What specialist does]
  - Output: [What specialist produces]
  - Handoff: [What next specialist needs]

  <quality_check>
    Must meet:
    - ✅ Criterion 1
    - ✅ Criterion 2

    IF fails: RETURN to specialist
    ELSE: PROCEED to next
  </quality_check>
</step>
```

**Adaptation for Development**:
```xml
<step number="N" subagent="backend-dev" name="api_implementation">
  ### Backend API Implementation

  Delegate to backend-dev:
  - Input: API tasks from filtered tasks.md
  - Skills: java-core-patterns, spring-boot-conventions auto-load
  - Process: Generate controllers, services, repos, DTOs, tests
  - Output: Java code + API mocks
  - Handoff: API mocks for frontend-dev

  <quality_check>
    - ✅ Code compiles (mvn compile)
    - ✅ Tests pass (mvn test)
    - ✅ API mocks generated
    - ✅ Coverage ≥80%
  </quality_check>
</step>
```

### 3. Skills Auto-Activation (NO CHANGES NEEDED)

**Source**: Existing skills system (11 dev skills)

**Current Mechanism** (works perfectly):
```
Agent opens file:
→ UserController.java

Skills auto-activate based on triggers:
→ java-core-patterns (file_extension: .java)
→ spring-boot-conventions (file_contains: @RestController)
→ security-best-practices (task_mentions: authentication)

Agent has patterns in context automatically ✅
```

**For Development Specialists**:
- backend-dev working on .java file → Java/Spring skills auto-load
- frontend-dev working on .tsx file → React/TypeScript skills auto-load
- qa-specialist working on tests → testing-best-practices auto-loads
- No explicit skill loading needed!

### 4. Global + Override Architecture (PROVEN PATTERN)

**Source**: Market Validation System global installation

**Reuse Exactly**:
```
Global Installation (~/.agent-os/, ~/.claude/):
- Skills: testing-best-practices.md, devops-patterns.md
- Agents: backend-dev.md, frontend-dev.md, qa-specialist.md, devops-specialist.md
- Templates: team-development/*

Project Override (projekt/agent-os/, projekt/.claude/):
- Override backend-dev.md for pharma-specific compliance
- Override testing-best-practices.md for company test standards

Lookup Order (config.yml):
team_system:
  lookup_order:
    - project  # Check local first
    - global   # Fallback
```

### 5. Utility Agent Reuse (EXISTING AGENTS)

**Reused Without Modification**:
- **context-fetcher**: Load spec-lite.md, technical-spec.md for team context
- **file-creator**: Generate file structures, apply templates
- **git-workflow**: Create commits with team co-author attribution
- **test-runner**: Execute test suites (delegated by qa-specialist)
- **date-checker**: Timestamp team deliverables

**Utility Integration**:
```
qa-specialist wants to run tests:
→ Delegates to test-runner utility agent
→ test-runner executes: npm test
→ test-runner returns: results, failures, coverage
→ qa-specialist analyzes results
```

### 6. Profile System Integration (EXISTING, NO CHANGES)

**Source**: 4 existing profiles (base, java-spring-boot, react-frontend, angular-frontend)

**Profile-Agent Association**:
```
Project has active_profile: java-spring-boot

backend-dev detects profile:
→ Use Java/Spring patterns
→ Generate Spring Boot code
→ Auto-load: java-core-patterns, spring-boot-conventions, jpa-best-practices

frontend-dev detects profile:
→ No frontend profile active
→ Ask user or check package.json
→ If React dependencies found: Use React patterns
```

**Multi-Profile Projects** (Full-Stack):
```yaml
# config.yml (custom for full-stack)
active_profile: base  # Inherit universal standards

team_system:
  specialists:
    backend_dev:
      stack: java_spring_boot  # Backend uses Java
    frontend_dev:
      framework: react  # Frontend uses React
```

## New Components Needed

### 1. Specialist Agents (5 new)

#### backend-dev.md
**Location**: `.claude/agents/backend-dev.md`

**Frontmatter**:
```yaml
---
name: backend-dev
description: Backend development specialist with Java Spring Boot and Node.js support
tools: Read, Write, Edit, Grep, Glob, Bash, LSP
color: purple
---
```

**Responsibilities**:
- Generate complete REST API implementations (controllers, services, repositories)
- Generate DTOs (request/response objects) with validation
- Generate JPA entities with relationships
- Generate unit tests (JUnit 5, Mockito, >80% coverage)
- Generate API mocks (JSON files) for frontend development
- Follow SOLID principles and design patterns from skills
- Handle database migrations (if needed)
- Provide clear handoff to frontend-dev

**Auto-Loaded Skills** (when working on Java):
- java-core-patterns
- spring-boot-conventions
- jpa-best-practices
- security-best-practices

**Code Generation Example**:
```java
// UserController.java (full implementation)
@RestController
@RequestMapping("/api/users")
@Validated
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    @PostMapping
    public ResponseEntity<UserDTO> createUser(@RequestBody @Valid UserCreateRequest request) {
        User user = userService.createUser(request);
        return ResponseEntity.status(HttpStatus.CREATED)
            .body(UserDTO.from(user));
    }
}
```

**API Mock Generation**:
```json
// api-mocks/users.json
{
  "GET /api/users": {
    "status": 200,
    "body": [
      { "id": 1, "name": "John Doe", "email": "john@example.com", "createdAt": "2025-12-28T10:00:00Z" },
      { "id": 2, "name": "Jane Smith", "email": "jane@example.com", "createdAt": "2025-12-28T10:05:00Z" }
    ]
  },
  "POST /api/users": {
    "status": 201,
    "body": { "id": 3, "name": "New User", "email": "new@example.com", "createdAt": "2025-12-28T12:00:00Z" }
  }
}
```

**Handoff Format**:
```markdown
## Backend Development Complete ✅

### API Endpoints Implemented
| Method | Endpoint | Request Body | Response | Status Codes |
|--------|----------|--------------|----------|--------------|
| GET | /api/users | - | User[] | 200 |
| POST | /api/users | UserCreateRequest | User | 201, 400 (validation) |
| GET | /api/users/{id} | - | User | 200, 404 |

### For Frontend Developer
- **Mocks**: api-mocks/users.json (use for development)
- **API Docs**: When backend runs: http://localhost:8080/swagger-ui.html
- **Base URL**: http://localhost:8080
- **Auth**: JWT Bearer tokens (get from /api/auth/login)
- **Error Format**: `{ "error": "message", "timestamp": "...", "status": 400 }`

### Database
- Entity: User (id, name, email, createdAt, updatedAt)
- Migrations: src/main/resources/db/migration/V001__create_users_table.sql
- Test Data: See UserRepositoryTest.java for examples

### Tests
- Unit tests: 12 tests, all passing (95% coverage)
- Integration tests: 4 API endpoint tests, all passing
- No N+1 queries (verified with query logging)

### Files Created
- UserController.java, UserService.java, UserRepository.java
- User.java, UserDTO.java, UserCreateRequest.java
- UserControllerTest.java, UserServiceTest.java, UserRepositoryTest.java
- api-mocks/users.json
```

#### frontend-dev.md
**Location**: `.claude/agents/frontend-dev.md`

**Frontmatter**:
```yaml
---
name: frontend-dev
description: Frontend development specialist with React and Angular support
tools: Read, Write, Edit, Grep, Glob, Bash, LSP
color: cyan
---
```

**Responsibilities**:
- Generate complete React/Angular components with TypeScript
- Generate API services (uses backend mocks in development)
- Generate state management (Context API, Redux, NgRx as needed)
- Generate TypeScript interfaces/types
- Generate component unit tests (React Testing Library, Angular Testing Library, >80% coverage)
- Follow component patterns and hooks best practices from skills
- Integrate with API mocks from backend-dev
- Provide clear handoff to qa-specialist

**Auto-Loaded Skills** (React):
- react-component-patterns
- react-hooks-best-practices
- typescript-react-patterns

**Auto-Loaded Skills** (Angular):
- angular-component-patterns
- angular-services-patterns
- rxjs-best-practices

**Code Generation Example** (React):
```typescript
// UserList.tsx (full implementation)
import { useState, useEffect } from 'react';
import { UserService } from '../services/UserService';
import { User } from '../types/User';
import { UserCard } from './UserCard';

interface UserListProps {
  searchQuery?: string;
  onUserClick?: (user: User) => void;
}

export const UserList: React.FC<UserListProps> = ({ searchQuery, onUserClick }) => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    UserService.getUsers()
      .then(setUsers)
      .catch(err => setError(err.message))
      .finally(() => setLoading(false));
  }, []);

  const filteredUsers = users.filter(user =>
    !searchQuery || user.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  if (loading) return <div className="loading">Loading users...</div>;
  if (error) return <div className="error">Error: {error}</div>;
  if (filteredUsers.length === 0) return <div className="empty">No users found</div>;

  return (
    <div className="user-list">
      {filteredUsers.map(user => (
        <UserCard
          key={user.id}
          user={user}
          onClick={() => onUserClick?.(user)}
        />
      ))}
    </div>
  );
};

// Plus: UserCard.tsx, UserService.ts, types/User.ts, UserList.test.tsx
```

**Mock Integration**:
```typescript
// UserService.ts
import mockData from '../../api-mocks/users.json';

const USE_MOCKS = process.env.NODE_ENV === 'development' || process.env.VITE_USE_MOCKS === 'true';
const API_BASE = process.env.VITE_API_URL || 'http://localhost:8080';

export class UserService {
  static async getUsers(): Promise<User[]> {
    if (USE_MOCKS) {
      return mockData['GET /api/users'].body;
    }

    const response = await fetch(`${API_BASE}/api/users`);
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    return response.json();
  }
}
```

#### qa-specialist.md
**Location**: `.claude/agents/qa-specialist.md`

**Frontmatter**:
```yaml
---
name: qa-specialist
description: Quality assurance specialist with comprehensive testing and auto-fix capabilities
tools: Read, Write, Edit, Grep, Glob, Bash
color: green
---
```

**Responsibilities**:
- Execute unit tests (backend + frontend separately)
- Execute integration tests (API-level with test database)
- Execute E2E tests (Playwright/Cypress for critical flows)
- Analyze test failures and identify root causes
- Delegate fixes to appropriate specialist (backend-dev or frontend-dev)
- Auto-fix loop (max 3 attempts per failure)
- Generate test reports with coverage metrics
- Ensure coverage ≥80% target
- Verify code quality (no linting errors)

**Auto-Loaded Skills**:
- testing-best-practices (NEW)

**Test Execution Flow**:
```
1. Run backend unit tests:
   Command: cd backend && mvn test
   Parse results: X tests, Y failures

2. IF backend failures:
   Analyze error messages
   Identify: Which class, which method, what error
   Delegate to backend-dev: "Fix NullPointerException in UserService.createUser line 42"
   Re-run after fix
   Repeat up to 3 times

3. Run frontend unit tests:
   Command: cd frontend && npm test
   Parse results: X tests, Y failures

4. IF frontend failures:
   Similar auto-fix loop with frontend-dev

5. IF all unit tests pass:
   Run integration tests

6. IF integration tests pass:
   Run E2E tests (if exist)

7. Generate test-report.md with all results
```

**Integration with test-runner**:
```
qa-specialist delegates to test-runner utility agent:
→ test-runner executes: npm test --coverage
→ test-runner returns: {
    total: 150,
    passed: 147,
    failed: 3,
    coverage: 82%,
    failures: [
      { test: "UserService.createUser", error: "NullPointerException at line 42" }
    ]
  }
→ qa-specialist analyzes failures
→ qa-specialist routes fixes to backend-dev
```

#### devops-specialist.md
**Location**: `.claude/agents/devops-specialist.md`

**Frontmatter**:
```yaml
---
name: devops-specialist
description: DevOps and deployment specialist for CI/CD and containerization
tools: Read, Write, Edit, Bash
color: orange
---
```

**Responsibilities**:
- Generate GitHub Actions CI/CD workflows
- Generate Dockerfile for backend (multi-stage build)
- Generate Dockerfile for frontend (Nginx serve)
- Generate docker-compose.yml for local development
- Generate deployment-plan.md with environment setup
- Configure test automation in CI
- Setup secrets management
- Provide deployment instructions

**Auto-Loaded Skills**:
- devops-patterns (NEW)
- security-best-practices (secrets, container security)

**GitHub Actions Generation**:
```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'temurin'
      - name: Build and Test
        run: |
          cd backend
          mvn clean verify
      - name: Upload Coverage
        uses: codecov/codecov-action@v3
        with:
          files: backend/target/site/jacoco/jacoco.xml

  frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install and Test
        run: |
          cd frontend
          npm ci
          npm test -- --coverage
          npm run build
      - name: Upload Coverage
        uses: codecov/codecov-action@v3
        with:
          files: frontend/coverage/lcov.info

  e2e:
    needs: [backend, frontend]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - name: Install Playwright
        run: npx playwright install --with-deps
      - name: Run E2E Tests
        run: npm run test:e2e
```

#### mock-generator.md (NEW UTILITY)
**Location**: `.claude/agents/mock-generator.md`

**Frontmatter**:
```yaml
---
name: mock-generator
description: Generates API mocks from backend code for frontend development
tools: Read, Write, Grep
color: blue
---
```

**Responsibilities**:
- Analyze backend controller code
- Extract API endpoints (method, path, request, response types)
- Generate JSON mock files matching response structures
- Keep mocks in sync with actual API

**Mock Generation Logic**:
```
Input: UserController.java

Extract:
- @GetMapping → GET /api/users
- Return type: List<UserDTO>
- Analyze UserDTO.java fields: id, name, email, createdAt

Generate mock:
{
  "GET /api/users": {
    "status": 200,
    "body": [
      { "id": 1, "name": "Sample User", "email": "sample@example.com", "createdAt": "2025-12-28T12:00:00Z" }
    ]
  }
}
```

### 2. Skills (2 new)

#### testing-best-practices.md
**Location**: `agent-os/skills/base/testing-best-practices.md`

**Content Structure**:
- **Unit Test Patterns**
  - AAA pattern (Arrange-Act-Assert)
  - Given-When-Then for BDD
  - Test isolation (no shared state)
  - Mocking strategies (when to mock, when to use real)
  - Parameterized tests (test multiple scenarios)

- **Integration Test Strategies**
  - TestContainers for database (Java)
  - Test database vs. H2 in-memory
  - API integration tests (full request-response cycle)
  - MSW (Mock Service Worker) for frontend API testing

- **E2E Test Best Practices**
  - Page Object pattern (maintainable selectors)
  - Wait strategies (avoid flaky tests)
  - Test data management (setup/teardown)
  - Critical user flows only (not every edge case)
  - Parallel execution (faster feedback)

- **Coverage Strategies**
  - What to test: Business logic, edge cases, error handling
  - What to skip: Getters/setters, trivial code
  - Coverage targets: 80% overall, 90% for critical paths
  - Mutation testing (advanced)

- **Test Organization**
  - Directory structure (tests mirror source)
  - Naming conventions (UserServiceTest, UserList.test.tsx)
  - Test categorization (@Tag("integration"), describe blocks)

**Triggers**:
```yaml
triggers:
  - task_mentions: "test|spec|coverage|e2e|integration|unit"
  - file_contains: "@Test|describe\\(|it\\(|test\\("
  - file_extension: .test.ts|.test.tsx|.spec.ts|Test.java
```

#### devops-patterns.md
**Location**: `agent-os/skills/base/devops-patterns.md`

**Content Structure**:
- **CI/CD Pipeline Design**
  - Test stages (unit → integration → E2E)
  - Build stages (compile, package, containerize)
  - Deployment gates (manual approval, environment checks)
  - Artifact management (versioning, storage)
  - Pipeline as Code (GitHub Actions, GitLab CI)

- **Docker Best Practices**
  - Multi-stage builds (reduce image size)
  - Layer caching (faster builds)
  - Security scanning (Trivy, Snyk)
  - Base image selection (official, minimal)
  - .dockerignore (exclude unnecessary files)

- **GitHub Actions Patterns**
  - Workflow reuse (composite actions)
  - Matrix builds (test multiple versions)
  - Caching (npm, Maven, Docker layers)
  - Secrets management (GitHub Secrets, environment variables)
  - Conditional execution (skip on [skip ci])

- **Deployment Strategies**
  - Blue-Green deployment (zero downtime)
  - Canary deployment (gradual rollout)
  - Rolling deployment (Kubernetes)
  - Feature flags (LaunchDarkly, env variables)

- **Environment Management**
  - Environment separation (dev, staging, prod)
  - Configuration management (dotenv, ConfigMaps)
  - Secrets rotation
  - Database migrations in CD

**Triggers**:
```yaml
triggers:
  - task_mentions: "ci|cd|deploy|docker|pipeline|kubernetes|github actions"
  - file_contains: "Dockerfile|docker-compose|github/workflows"
  - file_extension: .yml|.yaml (in .github/workflows/)
```

### 3. Templates (12 new)

**Backend Templates** (`agent-os/templates/team-development/backend/`):

**api-spec.md**:
```markdown
# API Specification

## Endpoint: [METHOD] [PATH]

### Request
**Headers**:
- Authorization: Bearer [token]
- Content-Type: application/json

**Body** (if POST/PUT):
```json
{
  "field1": "value",
  "field2": "value"
}
```

### Response
**Success (200/201)**:
```json
{
  "id": 1,
  "field1": "value"
}
```

**Errors**:
- 400: Validation error
- 401: Unauthorized
- 404: Not found
- 500: Server error

### Implementation Checklist
- [ ] Controller method created
- [ ] Service logic implemented
- [ ] Repository method (if needed)
- [ ] DTO classes created
- [ ] Validation added (@Valid)
- [ ] Unit tests (>80% coverage)
- [ ] Integration test
- [ ] API mock generated
```

**Frontend Templates** (`agent-os/templates/team-development/frontend/`):

**component-spec.md**:
```markdown
# Component Specification

## Component: [ComponentName]

### Purpose
[What this component does]

### Props
```typescript
interface Props {
  propName: Type;
  optional?: Type;
}
```

### State
- [State variable 1]: [Purpose]
- [State variable 2]: [Purpose]

### API Integration
- Endpoint: GET /api/[resource]
- Service: [ServiceName].ts
- Mock: api-mocks/[resource].json

### User Interactions
- [Action 1]: [What happens]
- [Action 2]: [What happens]

### Implementation Checklist
- [ ] Component created
- [ ] Props interface defined
- [ ] API service integration
- [ ] Error handling
- [ ] Loading states
- [ ] Unit tests (>80% coverage)
```

**QA Templates** (`agent-os/templates/team-development/qa/`):

**test-report.md**:
```markdown
# Test Execution Report

> Generated: [DATE]
> Feature: [FEATURE_NAME]

## Test Summary

| Test Type | Total | Passed | Failed | Skipped | Coverage |
|-----------|-------|--------|--------|---------|----------|
| Backend Unit | [#] | [#] | [#] | [#] | [%] |
| Frontend Unit | [#] | [#] | [#] | [#] | [%] |
| Integration | [#] | [#] | [#] | [#] | - |
| E2E | [#] | [#] | [#] | [#] | - |

## Test Failures

### Failure 1
- **Test**: [Test name]
- **Error**: [Error message]
- **Root Cause**: [Analysis]
- **Fixed By**: [Specialist]
- **Status**: [Fixed/Pending]

## Coverage Analysis

- **Backend**: [%] coverage ([Above/Below] 80% target)
- **Frontend**: [%] coverage ([Above/Below] 80% target)
- **Critical Paths**: [%] coverage

## Quality Gates

- [ ] All tests passing
- [ ] Coverage ≥80%
- [ ] No linting errors
- [ ] Build successful

## Ready for Deployment: [YES/NO]
```

### 4. Task Type Detection Logic

**Implementation** (in execute-tasks.md):

```javascript
function detectTaskType(taskDescription, filePaths) {
  const desc = taskDescription.toLowerCase();

  // API/Backend detection
  const apiKeywords = ['api', 'endpoint', 'controller', 'service', 'repository', 'rest', 'graphql', 'database', 'migration'];
  if (apiKeywords.some(kw => desc.includes(kw))) {
    return 'backend';
  }

  // Check file paths for backend indicators
  if (filePaths?.some(path => path.includes('/controller/') || path.includes('/service/') || path.endsWith('.java'))) {
    return 'backend';
  }

  // UI/Frontend detection
  const uiKeywords = ['component', 'page', 'view', 'ui', 'frontend', 'react', 'angular', 'state', 'redux', 'form'];
  if (uiKeywords.some(kw => desc.includes(kw))) {
    return 'frontend';
  }

  // Check file paths for frontend indicators
  if (filePaths?.some(path => path.includes('/components/') || path.endsWith('.tsx') || path.endsWith('.component.ts'))) {
    return 'frontend';
  }

  // Test detection
  const testKeywords = ['test', 'spec', 'coverage', 'e2e', 'integration', 'unit', 'playwright', 'cypress', 'jest', 'junit'];
  if (testKeywords.some(kw => desc.includes(kw))) {
    return 'qa';
  }

  // Deployment detection
  const deployKeywords = ['deploy', 'ci', 'cd', 'docker', 'pipeline', 'github actions', 'kubernetes', 'ci/cd'];
  if (deployKeywords.some(kw => desc.includes(kw))) {
    return 'devops';
  }

  // Unknown - execute directly or ask user
  return null;
}

function routeToSpecialist(taskType) {
  const routing = {
    'backend': 'backend-dev',
    'frontend': 'frontend-dev',
    'qa': 'qa-specialist',
    'devops': 'devops-specialist'
  };

  return routing[taskType] || null;
}
```

### 5. Handoff System

**Handoff File**: `team-handoffs.md` (auto-generated in spec directory)

**Structure**:
```markdown
# Team Handoffs

> Feature: [FEATURE_NAME]
> Started: [DATE]

## backend-dev → frontend-dev

**Completed**: [TIMESTAMP]

### API Endpoints Ready
[Table of endpoints]

### API Mocks
- Location: api-mocks/users.json
- Structure: Matches actual API responses
- Usage: Import in UserService.ts

### For Frontend Developer
- Base URL: http://localhost:8080 (when backend runs)
- Auth: JWT Bearer tokens
- Error format: { error, timestamp, status }
- Swagger: http://localhost:8080/swagger-ui.html

---

## frontend-dev → qa-specialist

**Completed**: [TIMESTAMP]

### Components Implemented
[List of components]

### Integration Notes
- API Service: Uses mocks (switch to real API with VITE_API_URL)
- State Management: Context API (UserContext.tsx)
- Forms: React Hook Form with Zod validation

### For QA Specialist
- Run frontend tests: cd frontend && npm test
- Run E2E: npm run test:e2e
- Critical flows: User creation, user list, user delete

---

## qa-specialist → devops-specialist

**Completed**: [TIMESTAMP]

### Test Results
- All tests passing ✅
- Coverage: Backend 87%, Frontend 82%

### Quality Gates Met
- ✅ Unit tests: 155/155 passing
- ✅ Integration tests: 12/12 passing
- ✅ E2E tests: 5/5 passing
- ✅ No linting errors
- ✅ Build successful

### For DevOps Specialist
- Code is production-ready
- Setup CI to run: mvn verify (backend), npm test (frontend), npm run test:e2e
- Deploy to staging after CI passes on main branch
```

### 6. Integration with execute-tasks.md

**Current execute-tasks.md Step 5**:
```xml
<step number="5" name="task_execution_loop">
  ### Step 5: Task Execution

  FOR each task IN tasks.md:
    Execute task
  NEXT task
</step>
```

**Modified execute-tasks.md Step 5** (with team routing):
```xml
<step number="5" name="task_execution_loop">
  ### Step 5: Task Execution (Enhanced with Team Routing)

  Load team_system config from agent-os/config.yml

  <conditional_logic>
    IF team_system.enabled == false:
      EXECUTE all tasks directly (current behavior)
      EXIT this conditional

    ELSE (team_system.enabled == true):
      PROCEED with smart routing
  </conditional_logic>

  <!-- Group tasks by type -->
  <task_grouping>
    backend_tasks = []
    frontend_tasks = []
    qa_tasks = []
    devops_tasks = []
    other_tasks = []

    FOR each task IN tasks.md:
      task_type = detect_task_type(task.description, task.files)

      IF task_type == "backend":
        backend_tasks.add(task)
      ELIF task_type == "frontend":
        frontend_tasks.add(task)
      ELIF task_type == "qa":
        qa_tasks.add(task)
      ELIF task_type == "devops":
        devops_tasks.add(task)
      ELSE:
        other_tasks.add(task)
  </task_grouping>

  <!-- Execute by specialist -->
  <specialist_execution>

    <!-- Phase 1: Backend -->
    IF backend_tasks.length > 0:
      <step subagent="backend-dev" name="backend_implementation">
        Delegate backend_tasks to backend-dev
        backend-dev generates code + mocks
        Store handoff in team-handoffs.md
      </step>

    <!-- Phase 2: Frontend -->
    IF frontend_tasks.length > 0:
      <step subagent="frontend-dev" name="frontend_implementation">
        Delegate frontend_tasks to frontend-dev
        frontend-dev receives backend handoff (mocks)
        frontend-dev generates UI code
        Store handoff in team-handoffs.md
      </step>

    <!-- Phase 3: QA -->
    IF qa_tasks.length > 0 OR (backend_tasks.length > 0 OR frontend_tasks.length > 0):
      <step subagent="qa-specialist" name="qa_testing">
        Delegate qa_tasks (or auto-test if code generated)
        qa-specialist runs all tests
        IF failures: Auto-fix loop with specialists
        Generate test-report.md
        Store handoff in team-handoffs.md
      </step>

    <!-- Phase 4: DevOps -->
    IF devops_tasks.length > 0:
      <step subagent="devops-specialist" name="devops_setup">
        Delegate devops_tasks to devops-specialist
        devops-specialist generates CI/CD, Docker config
        Store handoff in team-handoffs.md
      </step>

    <!-- Phase 5: Other tasks (direct execution) -->
    IF other_tasks.length > 0:
      FOR each task IN other_tasks:
        EXECUTE directly (current execute-tasks behavior)

  </specialist_execution>

</step>
```

**Backward Compatibility Verification**:
```
Scenario 1: team_system.enabled: false
→ All tasks execute directly
→ Zero changes to current behavior ✅

Scenario 2: team_system.enabled: true, no tasks match types
→ All tasks in other_tasks[]
→ Execute directly
→ Graceful fallback ✅

Scenario 3: team_system.enabled: true, mixed tasks
→ Route to specialists where matched
→ Execute directly where not matched
→ Best of both worlds ✅
```

---

## External Dependencies

### Required
- **LSP Servers**: For code intelligence (Java, TypeScript)
- **Build Tools**: Maven/Gradle (backend), npm (frontend)
- **Test Frameworks**: JUnit, Jest, Playwright/Cypress

### Optional
- **Chrome DevTools MCP**: For qa-specialist visual testing (like web-developer uses)
- **Perplexity MCP**: Not needed (no research in dev team)

### Not Required (User Provides)
- GitHub repository (for Actions)
- Docker installed (for containerization)
- Test databases (TestContainers handles)

---

## Performance Requirements

### Task Routing
- Detection latency: <1 second per task
- Routing overhead: <10% vs. direct execution

### Code Generation
- Backend: <5 minutes for CRUD API (controller + service + repo + DTOs + tests)
- Frontend: <5 minutes for component (component + service + types + tests)
- Total: ~15-20 minutes for full-stack feature (4 specialists)

### Test Execution
- Unit tests: <2 minutes (backend + frontend)
- Integration tests: <5 minutes
- E2E tests: <10 minutes (5 scenarios)
- Auto-fix loop: +5-10 minutes per fix iteration

---

## Testing Strategy

### Unit Testing (Per Component)
- Each specialist agent tested independently with sample tasks
- Skills tested for trigger activation
- Templates tested for valid output

### Integration Testing
- Full /execute-tasks workflow with mixed task types
- Verify routing to correct specialists
- Verify handoffs work (mocks passed correctly)
- Verify auto-fix loop works (inject failing test)

### User Acceptance Testing
- Real full-stack feature implementation
- Verify generated code compiles
- Verify tests pass
- Verify CI/CD works

---

## Deployment Strategy

### Phase B Rollout
1. Create skills (week 1)
2. Create templates (week 1)
3. Create specialist agents (week 2-3)
4. Modify execute-tasks workflow (week 3)
5. Create setup scripts (week 3)
6. Documentation (week 4)
7. Testing (week 4)

### Distribution
- **GitHub**: Push to agent-os-extended repository
- **Global Installation**: `setup-team-system-global.sh`
- **Project Setup**: `setup-team-system-project.sh`
- **Documentation**: README.md + team/README.md

---

**Technical Specification Complete**

**Next**: Create tasks.md with detailed implementation breakdown
