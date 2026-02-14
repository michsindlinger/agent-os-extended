# Research Notes: Team-Based Development System

> Created: 2025-12-28
> Feature: Team-Based Development System (Phase B)
> Research Phase: v2.0 Enhanced

## 1. Feature Overview

Implement a **Team-Based Development System** that extends `/execute-tasks` with smart task routing to specialized development agents (backend-dev, frontend-dev, qa-specialist, devops-specialist). This system enables coordinated feature development where each specialist focuses on their domain while the system manages handoffs, integration, and quality gates.

**Vision**:
```
User runs: /execute-tasks

System analyzes tasks.md:
- Task 1: "Create POST /api/users endpoint" → backend-dev
- Task 2: "Create UserList component" → frontend-dev
- Task 3: "Add integration tests" → qa-specialist
- Task 4: "Setup CI/CD pipeline" → devops-specialist

Specialists execute sequentially:
1. backend-dev implements API + generates mocks for frontend
2. frontend-dev implements UI using mocks
3. qa-specialist runs unit + integration + E2E tests
4. devops-specialist configures deployment

Output: Fully tested, deployable feature
```

**Priority**: Phase B MVP - Development Team only (Product/Marketing teams in later phases)

## 2. Codebase Analysis

### 2.1 Existing Agent Patterns (HIGHLY REUSABLE)

**Source**: Market Validation System (7 specialist agents)

**Key Findings**:
- ✅ Agent frontmatter pattern established (name, description, tools, color, mcp_integrations)
- ✅ Clear role boundaries ("What you DO" / "What you DON'T DO")
- ✅ Automatic skills integration (no manual loading)
- ✅ Handoff summaries (explicit output for next agent)
- ✅ Quality gates (checklist before proceeding)
- ✅ Error handling patterns (fallbacks, retries)

**Reusable Agent Structure**:
```markdown
---
name: agent-name
description: Role description
tools: Read, Write, Edit, Grep, Glob, Bash, LSP
color: blue
---

## Core Responsibilities
## Automatic Skills Integration
## Workflow Process
## Output Format
## Important Constraints
```

**Application to Development Specialists**:
- ✅ backend-dev: Same structure, tools include Bash (for npm/mvn commands)
- ✅ frontend-dev: Same structure, tools include LSP (for code intelligence)
- ✅ qa-specialist: Same structure, reuses test-runner utility agent
- ✅ devops-specialist: Same structure, tools include Bash (for docker/kubectl)

### 2.2 Subagent Coordination Patterns (ADAPT FROM MARKET VALIDATION)

**Source**: `specwright/workflows/validation/validate-market.md` (18 steps, 7 specialists coordinated)

**Current Pattern**: Sequential execution
```xml
<step number="5" subagent="product-strategist">
<step number="6" subagent="market-researcher">
<step number="7" subagent="content-creator">
...
```

**Adaptation for Development**:
```xml
<step number="X" subagent="backend-dev" name="api_implementation">
  ### Backend API Implementation

  Delegate to backend-dev:
  - Input: API tasks from tasks.md
  - Process: Generate controllers, services, repositories
  - Output: API code + mocks for frontend
  - Handoff: API mocks to frontend-dev
</step>

<step number="X+1" subagent="frontend-dev" name="ui_implementation">
  ### Frontend UI Implementation

  Delegate to frontend-dev:
  - Input: UI tasks from tasks.md + API mocks
  - Process: Generate components, state management
  - Output: UI code
  - Handoff: Code to qa-specialist
</step>
```

**Key Difference**: Development needs **dependency management** (API mocks, running servers) vs. research (stateless)

### 2.3 Skills System (LEVERAGE EXISTING 11 SKILLS)

**Source**: `specwright/skills/` (11 existing tech skills + 7 market validation skills)

**Existing Development Skills**:
- **Base**: security-best-practices.md, git-workflow-patterns.md
- **Java**: java-core-patterns.md, spring-boot-conventions.md, jpa-best-practices.md
- **React**: react-component-patterns.md, react-hooks-best-practices.md, typescript-react-patterns.md
- **Angular**: angular-component-patterns.md, angular-services-patterns.md, rxjs-best-practices.md

**Skills Needed** (2 new):
- testing-best-practices.md (Unit, Integration, E2E test patterns)
- devops-patterns.md (CI/CD, Docker, deployment strategies)

**Auto-Activation** (existing pattern works perfectly):
```
backend-dev opens UserService.java:
→ java-core-patterns activates (file_extension: .java)
→ spring-boot-conventions activates (file_contains: @Service)
→ security-best-practices activates (task_mentions: authentication)

frontend-dev opens UserList.tsx:
→ react-component-patterns activates (file_extension: .tsx)
→ typescript-react-patterns activates (file_contains: interface)
→ react-hooks-best-practices activates (file_contains: useState)
```

**No New Skills Mechanism Needed**: Reuse existing trigger system!

### 2.4 Config System (EXTEND LIKE MARKET VALIDATION)

**Source**: `specwright/config.yml` with `market_validation` section (56 lines)

**Pattern to Follow**:
```yaml
team_system:
  enabled: true

  lookup_order:
    - project
    - global

  coordination_mode: sequential  # MVP

  specialists:
    backend_dev:
      enabled: true
      tech_stacks: [java_spring_boot, nodejs_express]
      default_stack: java_spring_boot

    frontend_dev:
      enabled: true
      tech_stacks: [react, angular]
      default_stack: react

    qa_specialist:
      enabled: true
      test_types: [unit, integration, e2e]

    devops_specialist:
      enabled: true
      platforms: [github_actions, docker]
```

**Integration Config**:
```yaml
  integration:
    execute_tasks_routing: true  # Enable smart routing
    auto_delegate_by_type: true

  task_routing_rules:
    api_keywords: [endpoint, controller, service, repository, api, rest]
    ui_keywords: [component, page, view, ui, frontend, react, angular]
    test_keywords: [test, spec, coverage, e2e, integration]
    deployment_keywords: [deploy, ci, cd, docker, pipeline]
```

### 2.5 Setup Scripts (REPLICATE MARKET VALIDATION PATTERN)

**Source**: `setup-market-validation-global.sh` (180 lines, proven to work)

**Pattern**:
```bash
#!/bin/bash
# Component - Global Installation
# Installs to ~/.specwright/ and ~/.claude/

REPO_URL="..."

# Download skills
download_file "$REPO_URL/specwright/skills/base/testing-best-practices.md" \
  ~/.specwright/skills/base/testing-best-practices.md "skill"

# Download agents
download_file "$REPO_URL/.claude/agents/backend-dev.md" \
  ~/.claude/agents/backend-dev.md "agent"

# Create symlinks
ln -sf ~/.specwright/skills/base/testing-best-practices.md \
  ~/.claude/skills/testing-best-practices.md
```

**Team System Setup Scripts**:
- `setup-team-system-global.sh` - Installs agents, skills, templates, workflow to global
- `setup-team-system-project.sh` - Creates project directories for team deliverables

### 2.6 Template System (NEW FOR DEVELOPMENT)

**Source**: `specwright/templates/market-validation/` (7 templates for validation)

**Team Development Templates Needed**:

**Backend Templates**:
- `api-spec.md` - REST API endpoint specification
- `service-class.md` - Service layer class template
- `repository-class.md` - Repository/DAO template
- `backend-handoff.md` - API mocks + docs for frontend

**Frontend Templates**:
- `component-spec.md` - React/Angular component specification
- `page-spec.md` - Full page with routing
- `state-management.md` - Redux/NgRx state setup
- `frontend-handoff.md` - UI screenshots + integration notes

**QA Templates**:
- `test-plan.md` - Test cases and coverage goals
- `test-report.md` - Test execution results
- `bug-report.md` - Issues found during testing

**DevOps Templates**:
- `ci-cd-config.md` - GitHub Actions/CI pipeline spec
- `docker-setup.md` - Dockerfile and compose configuration
- `deployment-plan.md` - Environment setup, deployment steps

**Integration Templates**:
- `team-progress.md` - Overall team progress tracking
- `integration-checklist.md` - Cross-specialist verification
- `handoff-notes.md` - Specialist-to-specialist communication

### 2.7 Profile System (LEVERAGE EXISTING)

**Source**: `specwright/profiles/` (4 existing profiles)

**Existing Profiles**:
- `base.md` - Universal standards (inherited by all)
- `java-spring-boot.md` - Java 17+, Spring Boot 3.x, JPA
- `react-frontend.md` - React 18+, TypeScript, Vite
- `angular-frontend.md` - Angular 17+, TypeScript, RxJS

**Profile-Agent Association**:
```
Java Spring Boot Project (active_profile: java-spring-boot):
→ backend-dev loads: java-core-patterns, spring-boot-conventions, jpa-best-practices
→ frontend-dev: Not relevant (no frontend in API-only project)

Full-Stack React Project (active_profile: react-frontend):
→ backend-dev loads: java-core-patterns (if Java) or nodejs-patterns (if Node)
→ frontend-dev loads: react-component-patterns, react-hooks-best-practices, typescript-react-patterns
```

**No New Profiles Needed**: Reuse existing 4 profiles!

### 2.8 Existing Utility Agents (REUSE HEAVILY)

**Available Utility Agents**:

1. **context-fetcher** - Loads mission, tech-stack, standards
   - **Reuse**: Load spec-lite.md, technical-spec.md for team context

2. **file-creator** - Creates files/directories, applies templates
   - **Reuse**: Generate backend stubs, frontend components from templates

3. **git-workflow** - Branch management, commits, PRs
   - **Reuse**: Team commits with co-author attribution

4. **test-runner** - Executes tests, analyzes failures
   - **Reuse**: QA-specialist delegates to test-runner

5. **date-checker** - Current date
   - **Reuse**: Timestamped deliverables

**New Utility Agents Needed**:
- **server-manager** (optional for Phase B, defer) - Start/stop dev servers
- **mock-generator** - Generate API mocks from OpenAPI/code

---

## 3. Requirements Clarification (From Q&A)

### 3.1 Tech Stack Support

**Question**: Welche Entwicklungs-Stacks sollen die Specialists unterstützen?
**Answer**: Java Spring Boot (Backend), React (Frontend), Angular (Frontend), Node.js/Express (Backend), Erweiterungen später möglich

**Implementation**:
- **backend-dev**: Multi-stack support (Java Spring Boot primary, Node.js/Express secondary)
- **frontend-dev**: Multi-framework support (React primary, Angular secondary)
- **Profile detection**: Uses `active_profile` from config.yml
- **Extensibility**: Architecture supports adding Python/Go/Vue later

**Stack Selection Logic**:
```yaml
# projekt/specwright/config.yml
active_profile: java-spring-boot

# backend-dev detects: Use Java/Spring patterns
# frontend-dev detects: Check if React/Angular specified (fallback to React if unknown)
```

### 3.2 Coordination Model

**Question**: Wie sollen die Specialists koordiniert werden?
**Answer**: **Sequential (MVP - Recommended)**

**Rationale**:
- Simpler to implement (proven pattern from Market Validation)
- Easier to debug (clear execution order)
- Safe for MVP (no concurrency issues)
- Clear handoffs (backend → frontend → qa → devops)

**Execution Order**:
```
1. backend-dev: Implements API endpoints
   Output: Controllers, Services, Repositories + API mocks

2. frontend-dev: Implements UI components
   Input: API mocks from backend
   Output: Components, pages, state management

3. qa-specialist: Runs all tests
   Input: Backend + Frontend code
   Output: Test results, bug reports (if failures)

   IF tests fail:
     → Auto-fix loop with backend-dev/frontend-dev

4. devops-specialist: Configures deployment
   Input: Tested, working code
   Output: CI/CD pipeline, Docker config
```

**Future Enhancement**: Parallel execution (Phase C)

### 3.3 Integration Strategy

**Question**: Wie soll das Team System in bestehende Workflows integrieren?
**Answer**: **Erweitere /execute-tasks (Recommended)**

**Implementation**: Smart Task Routing

**Task Type Detection**:
```
Analyze task description for keywords:

"Create POST /api/users endpoint"
→ Contains: api, endpoint
→ Route to: backend-dev

"Create UserList component with pagination"
→ Contains: component
→ Route to: frontend-dev

"Add unit tests for UserService"
→ Contains: test
→ Route to: qa-specialist

"Setup GitHub Actions pipeline"
→ Contains: pipeline, GitHub Actions
→ Route to: devops-specialist

"Refactor authentication logic"
→ Contains: authentication (could be backend or frontend)
→ Check file path or ask user
```

**Integration Point**: Modify `execute-tasks.md` Step 5 (task execution loop)

**Transparent to User**: User runs `/execute-tasks` as usual, system routes intelligently

### 3.4 Testing Strategy

**Question**: Welche Testing-Strategie soll qa-specialist nutzen?
**Answer**: **Unit Tests + Integration Tests + E2E Tests**

**Test Hierarchy**:
```
Level 1: Unit Tests (Fast, Isolated)
- Backend: JUnit 5 for services/repos
- Frontend: Jest for components/hooks
- Run: After each specialist completes
- Coverage: Target 80%+

Level 2: Integration Tests (Medium, API-level)
- Backend: TestContainers for DB integration
- Frontend: Mock Service Worker for API integration
- Run: After frontend-dev completes
- Coverage: All API endpoints

Level 3: E2E Tests (Slow, Full-stack)
- Tool: Playwright or Cypress
- Scenarios: Critical user flows only (3-5 max for MVP)
- Run: After integration tests pass
- Coverage: Happy paths + critical error cases
```

**qa-specialist Workflow**:
```
1. Run unit tests (backend + frontend separately)
   IF failures:
     → Analyze errors
     → Delegate fix to backend-dev or frontend-dev
     → Re-run until green

2. Run integration tests
   IF failures:
     → Similar auto-fix loop

3. Run E2E tests (if exist)
   IF failures:
     → Identify which layer (backend/frontend/integration)
     → Delegate to appropriate specialist
```

### 3.5 Code Generation Detail Level

**Question**: Wie detailliert sollen die Development Specialists arbeiten?
**Answer**: **Code-Generierung (Full Implementation)**

**Implication**: Specialists write complete, production-ready code

**backend-dev generates**:
```java
// Full implementation, not just stubs

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping
    public ResponseEntity<UserDTO> createUser(@RequestBody @Valid UserCreateRequest request) {
        User user = userService.createUser(request);
        return ResponseEntity.status(HttpStatus.CREATED)
            .body(UserDTO.from(user));
    }
}

// Plus: UserService.java, UserRepository.java, User.java, UserDTO.java, UserCreateRequest.java
// Plus: Unit tests for all classes
```

**frontend-dev generates**:
```typescript
// Full implementation, not just scaffolds

import { useState, useEffect } from 'react';
import { UserService } from '../services/UserService';
import { User } from '../types/User';

export const UserList: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    UserService.getUsers()
      .then(setUsers)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <div>Loading...</div>;

  return (
    <div className="user-list">
      {users.map(user => (
        <UserCard key={user.id} user={user} />
      ))}
    </div>
  );
};

// Plus: UserCard.tsx, UserService.ts, types/User.ts, UserList.test.tsx
```

**Quality Standard**: Production-ready, follows best practices from skills

### 3.6 API Handoff Strategy

**Question**: Wie soll backend-dev mit dem Frontend kommunizieren?
**Answer**: **API Mock Generation (Recommended)**

**Mock Generation**:
```json
// backend-dev generates: api-mocks/users.json
{
  "GET /api/users": {
    "status": 200,
    "body": [
      { "id": 1, "name": "John Doe", "email": "john@example.com" },
      { "id": 2, "name": "Jane Smith", "email": "jane@example.com" }
    ]
  },
  "POST /api/users": {
    "status": 201,
    "body": { "id": 3, "name": "New User", "email": "new@example.com" }
  }
}
```

**Frontend Integration**:
```typescript
// frontend-dev uses mocks during development

// Development mode: Use mocks
if (process.env.NODE_ENV === 'development') {
  import { useMockServer } from './mocks/server';
  useMockServer();  // MSW or similar
}

// Production mode: Real API
const API_URL = process.env.VITE_API_URL || 'http://localhost:8080';
```

**Benefits**:
- ✅ Frontend can develop in parallel (doesn't wait for backend server)
- ✅ No port conflicts
- ✅ Faster iteration
- ✅ Mocks also serve as API contract documentation

**Handoff Document**:
```markdown
## Backend → Frontend Handoff

### API Endpoints Ready
| Method | Endpoint | Description | Mock Available |
|--------|----------|-------------|----------------|
| GET | /api/users | List all users | ✅ api-mocks/users.json |
| POST | /api/users | Create user | ✅ api-mocks/users.json |

### For Frontend Developer
- Mocks: See api-mocks/ directory
- Swagger/OpenAPI: http://localhost:8080/swagger-ui.html (when backend running)
- Example requests: See tests in UserControllerTest.java
```

### 3.7 Test Failure Handling

**Question**: Was passiert wenn Tests feilen?
**Answer**: **Auto-Fix Attempt (Recommended)**

**Auto-Fix Loop**:
```
qa-specialist runs tests:
→ 3 failures detected in backend unit tests
→ Analyzes error messages
→ Identifies: NullPointerException in UserService.createUser()
→ Delegates to backend-dev: "Fix NullPointerException in UserService line 42"
→ backend-dev fixes code
→ qa-specialist re-runs tests
→ IF still failing: Repeat (max 3 attempts)
→ IF still failing after 3 attempts: Report to user, pause workflow
```

**Workflow Integration**:
```xml
<step name="qa_testing">

  <test_execution>
    qa-specialist runs all tests
  </test_execution>

  <test_result_handling>
    IF all tests pass:
      PROCEED to devops-specialist

    ELIF failures detected AND attempts < 3:
      qa-specialist analyzes failures
      Identifies responsible specialist (backend-dev/frontend-dev)
      Delegates fix to specialist
      Specialist fixes code
      INCREMENT attempts
      RETRY qa_testing

    ELSE (still failing after 3 attempts):
      REPORT failures to user
      ASK user: "Continue anyway or abort?"
      IF abort: EXIT workflow
      IF continue: PROCEED (risky)
  </test_result_handling>

</step>
```

### 3.8 Team Types Scope

**Question**: Soll das Team System auch Product/Marketing Teams unterstützen?
**Answer**: **Nur Development Team (Phase B MVP)**

**Phase B Scope**:
- ✅ backend-dev (Java Spring Boot, Node.js)
- ✅ frontend-dev (React, Angular)
- ✅ qa-specialist (Unit, Integration, E2E)
- ✅ devops-specialist (CI/CD, Docker)

**Out of Scope (Future Phases)**:
- ❌ product-manager, ux-designer, user-researcher (Phase C)
- ❌ content-creator, seo-specialist, social-media-manager (Phase D - note: these exist for Market Validation, but not integrated into dev team)
- ❌ business-analyst, market-researcher (Phase E - note: these exist for Market Validation)

**Focus**: Code execution and deployment, not product planning or marketing

---

## 4. Visual Assets

**Status**: No visual diagrams provided

**Recommendation**: Create flow diagrams for documentation:
- Team coordination sequence diagram
- Task routing decision tree
- Integration testing flow

**For Spec**: Text-based diagrams (ASCII art) sufficient

---

## 5. Technical Constraints

### 5.1 Multi-Stack Support

**Constraint**: Specialists must support multiple tech stacks

**backend-dev**:
- Primary: Java Spring Boot (reuse 3 existing Java skills)
- Secondary: Node.js/Express (new skill needed: nodejs-backend-patterns.md)
- Detection: Check active_profile or pom.xml/package.json

**frontend-dev**:
- Primary: React (reuse 3 existing React skills)
- Secondary: Angular (reuse 3 existing Angular skills)
- Detection: Check active_profile or package.json dependencies

### 5.2 State Management (Critical for Development vs. Research)

**Challenge**: Code execution is stateful

**State to Manage**:
- **Running Servers**: Backend on port 8080, Frontend on port 3000
- **Database State**: Migrations applied, test data seeded
- **Build Artifacts**: node_modules/, target/, build/
- **Process IDs**: Track running processes to clean up

**Solutions**:
- **Port Detection**: Check before starting servers (lsof -i :8080)
- **Process Cleanup**: Kill servers after testing
- **Database Isolation**: Use test database, rollback after tests
- **Build Coordination**: Backend builds before frontend (API client generation)

**Defer to Phase C**: Full server lifecycle management (MVP uses mocks)

### 5.3 Integration with /execute-tasks

**Constraint**: Must not break existing /execute-tasks behavior

**Approach**: Backward-compatible extension

**Current execute-tasks.md**:
```xml
<step number="5" name="task_execution_loop">
  FOR each task IN tasks.md:
    Execute task directly
  NEXT task
</step>
```

**Extended execute-tasks.md** (with team routing):
```xml
<step number="5" name="task_execution_loop">
  FOR each task IN tasks.md:

    <task_type_detection>
      task_type = analyze_task_keywords(task.description)
    </task_type_detection>

    <conditional_routing>
      IF team_system.enabled AND task_type IN [api, ui, test, deployment]:
        specialist = route_to_specialist(task_type)
        DELEGATE to specialist subagent
        COLLECT specialist output
      ELSE:
        EXECUTE directly (current behavior)
    </conditional_routing>

  NEXT task
</step>
```

**Backward Compatibility**:
```
IF team_system.enabled == false:
  → Execute all tasks directly (current behavior)

IF team_system.enabled == true BUT task type unknown:
  → Execute directly (fallback to current behavior)
```

### 5.4 Task Routing Rules

**API Tasks** (→ backend-dev):
- Keywords: api, endpoint, controller, service, repository, rest, graphql
- File paths: src/main/java/*/controller/, src/main/java/*/service/
- Examples: "Create POST /api/users endpoint", "Add authentication to API"

**UI Tasks** (→ frontend-dev):
- Keywords: component, page, view, ui, frontend, react, angular
- File paths: src/components/, src/pages/, src/app/
- Examples: "Create UserList component", "Add login page"

**Test Tasks** (→ qa-specialist):
- Keywords: test, spec, coverage, e2e, integration, unit
- File paths: src/test/, *.test.ts, *.spec.ts
- Examples: "Add unit tests for UserService", "Create E2E test for login flow"

**Deployment Tasks** (→ devops-specialist):
- Keywords: deploy, ci, cd, docker, pipeline, github actions
- File paths: .github/workflows/, Dockerfile, docker-compose.yml
- Examples: "Setup CI/CD pipeline", "Create Dockerfile"

**Ambiguous Tasks** (→ Ask user or execute directly):
- Example: "Refactor authentication" (could be backend or frontend)
- Action: Check file paths in task or ask user "Which layer: Backend/Frontend/Both?"

---

## 6. Recommendations

### 6.1 Reuse Strategy

**From Market Validation System**:
- ✅ Agent structure pattern (frontmatter, responsibilities, workflow, output format, constraints)
- ✅ Sequential coordination (step-by-step delegation)
- ✅ Quality gates (checklists before proceeding)
- ✅ Skills auto-activation (no changes needed!)
- ✅ Global + Override architecture (same as Market Validation)
- ✅ Setup script pattern (setup-team-system-global.sh)
- ✅ Config pattern (team_system section like market_validation section)

**From Existing Utility Agents**:
- ✅ context-fetcher for loading specs
- ✅ file-creator for scaffolding
- ✅ git-workflow for commits
- ✅ test-runner for test execution

**From Profile System**:
- ✅ Java/React/Angular profiles (no new profiles needed)
- ✅ Auto-skill loading mechanism

### 6.2 Implementation Approach (Phase B MVP)

**Recommended Order**:

**Week 1: Skills & Templates** (8-10h)
- Create 2 new skills:
  - testing-best-practices.md
  - devops-patterns.md
- Create 12 team templates:
  - Backend: api-spec, service-class, repository-class, backend-handoff
  - Frontend: component-spec, page-spec, state-management, frontend-handoff
  - QA: test-plan, test-report
  - DevOps: ci-cd-config, deployment-plan

**Week 2: Specialist Agents** (10-12h)
- Create 4 development specialist agents:
  - backend-dev.md (with Java/Node.js support)
  - frontend-dev.md (with React/Angular support)
  - qa-specialist.md (with test-runner integration)
  - devops-specialist.md (with GitHub Actions/Docker)
- Create 1 utility agent:
  - mock-generator.md (API mock generation)

**Week 3: Workflow Integration** (8-10h)
- Extend execute-tasks.md with task routing
- Add task type detection logic
- Add specialist delegation
- Add auto-fix loop for test failures
- Maintain backward compatibility

**Week 4: Setup & Documentation** (4-6h)
- Create setup-team-system-global.sh
- Create setup-team-system-project.sh
- Update config.yml with team_system section
- Update README.md with Team System section
- Create team-development/README.md guide

**Total Estimated Effort**: 30-38 hours

**Parallel to Market Validation**: 26-32h (very similar scope)

### 6.3 Integration Points

**With /execute-tasks**:
- Modify Step 5: task_execution_loop
- Add task type detection
- Add specialist routing
- Backward compatible (team_system.enabled flag)

**With /plan-product**:
- Team system can inform complexity estimates
- Backend-dev estimates API development time
- Frontend-dev estimates UI development time

**With existing profiles**:
- active_profile determines which skills load
- java-spring-boot → backend-dev gets Java skills
- react-frontend → frontend-dev gets React skills

**With existing skills**:
- All 11 existing dev skills reused (Java, React, Angular)
- 2 new skills added (testing, devops)
- 7 market validation skills remain separate (not used by dev team)

---

## 7. Open Questions

### 7.1 Server Lifecycle Management

**Question**: Should backend-dev start actual backend server for integration testing?

**Options**:
1. **Mocks Only (MVP)**: Frontend uses mocks, no server needed (simpler)
2. **Server on Demand**: backend-dev starts server for integration tests, stops after (complex)
3. **User Runs Server**: User starts server manually, team uses it (hybrid)

**Recommendation for MVP**: **Option 1 (Mocks Only)**
- Simpler implementation
- No port conflicts
- Faster execution
- Phase C can add real server support

### 7.2 Multi-Specialist Tasks

**Question**: What if task requires both backend AND frontend?

**Example**: "Add user authentication" (needs backend API + frontend login form)

**Options**:
1. **Task Splitting**: Auto-split into backend + frontend subtasks
2. **Primary + Secondary**: Route to primary (backend), they delegate to frontend
3. **Ask User**: Ambiguous tasks → ask which specialist

**Recommendation**: **Option 1 (Task Splitting)** with templates

### 7.3 Code Review Integration

**Question**: Should there be a code-review step before committing?

**Options**:
1. **Peer Review**: backend-dev reviews frontend-dev's code and vice versa
2. **No Review**: Trust specialist skills and tests
3. **User Review**: User reviews before commit

**Recommendation for MVP**: **Option 2 (No Review)** - Skills ensure quality, defer peer review to Phase C

### 7.4 Deployment Target

**Question**: What deployment platforms should devops-specialist support?

**MVP Support**:
- GitHub Actions (CI/CD)
- Docker (containerization)
- Simple deployment instructions

**Future**: Kubernetes, AWS, Digital Ocean, etc.

---

## 8. Success Criteria for Phase B

**Functional Success**:
- [ ] User runs `/execute-tasks` with mixed task types (API + UI + tests)
- [ ] System correctly routes API tasks to backend-dev
- [ ] System correctly routes UI tasks to frontend-dev
- [ ] System correctly routes test tasks to qa-specialist
- [ ] backend-dev generates full Java Spring Boot code (controllers, services, repos, DTOs)
- [ ] backend-dev generates API mocks for frontend
- [ ] frontend-dev generates full React code (components, services, types, tests)
- [ ] qa-specialist runs unit + integration + E2E tests
- [ ] qa-specialist auto-fixes test failures (delegates back to specialists)
- [ ] devops-specialist configures GitHub Actions CI/CD

**Quality Success**:
- [ ] Generated code follows skills best practices (SOLID, DRY, patterns)
- [ ] Test coverage ≥80% (unit tests)
- [ ] All integration tests pass
- [ ] E2E tests cover critical user flows
- [ ] Code is production-ready (no TODOs, complete implementations)
- [ ] API mocks match actual API structure

**Integration Success**:
- [ ] /execute-tasks with team routing works transparently
- [ ] Backward compatible (team_system disabled → old behavior)
- [ ] Skills auto-activate for specialists (Java for backend-dev, React for frontend-dev)
- [ ] Profile system works (java-spring-boot → backend-dev uses Java)
- [ ] Global + Override pattern works (can override agents per project)

**Performance Success**:
- [ ] Task routing adds <10% overhead
- [ ] Sequential coordination clear and debuggable
- [ ] Handoffs explicit (API mocks, test results)

---

## 9. Risk Mitigation

**Risk**: Task type detection fails (ambiguous tasks)
- **Mitigation**: Fallback to direct execution (current behavior)
- **Enhancement**: Ask user when ambiguous

**Risk**: Generated code doesn't compile
- **Mitigation**: Skills provide correct patterns, test-runner catches compilation errors
- **Fallback**: qa-specialist detects, delegates fix to specialist

**Risk**: Integration tests fail (frontend expects different API)
- **Mitigation**: API mocks serve as contract, must match actual API
- **Validation**: Backend unit tests verify API behavior matches mocks

**Risk**: Too many specialists (overwhelming for simple features)
- **Mitigation**: Task routing only activates if task matches type
- **Simple features**: Execute directly (current behavior)

**Risk**: Specialists conflict (both modify same file)
- **Mitigation**: Clear boundaries (backend never touches frontend files, vice versa)
- **Phase B MVP**: Sequential execution prevents conflicts

---

## 10. Next Steps

1. **User Review**: Review this research summary and confirm approach
2. **Formal Spec Creation**: Generate spec.md, spec-lite.md, technical-spec.md, tasks.md
3. **Begin Implementation**: Start with skills → templates → agents → workflow integration

---

**Research Phase Complete!** ✅

**Ready to proceed with formal specification?**
