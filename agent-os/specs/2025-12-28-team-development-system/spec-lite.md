# Team-Based Development System - Phase B (Development Team)

> Quick Reference | Created: 2025-12-28
> Full Spec: @agent-os/specs/2025-12-28-team-development-system/spec.md

## What Is This?

A **smart task routing system** that extends `/execute-tasks` to automatically delegate tasks to specialized development agents. Instead of you writing all the code, the system coordinates backend-dev, frontend-dev, qa-specialist, and devops-specialist to build features together.

## The Problem

Building full-stack features requires expertise across multiple domains (backend APIs, frontend UI, testing, deployment). Doing everything yourself is slow and error-prone. You need specialists but coordinating a team is complex.

## The Solution

**Smart Task Routing in `/execute-tasks`**:
```
You create tasks.md:
- Task 1: Create POST /api/users endpoint
- Task 2: Create UserList component
- Task 3: Add comprehensive tests
- Task 4: Setup CI/CD pipeline

You run: /execute-tasks

System automatically:
1. Routes Task 1 → backend-dev (detects "api", "endpoint")
2. Routes Task 2 → frontend-dev (detects "component")
3. Routes Task 3 → qa-specialist (detects "tests")
4. Routes Task 4 → devops-specialist (detects "CI/CD")

Specialists execute sequentially:
→ backend-dev: Full Spring Boot code + API mocks
→ frontend-dev: Full React code using mocks
→ qa-specialist: Unit + Integration + E2E tests (auto-fixes failures)
→ devops-specialist: GitHub Actions CI/CD

Output: Fully implemented, tested, deployable feature
```

## Key Features

### 1. Smart Task Routing (Automatic)
- Analyzes task descriptions for keywords
- Routes to appropriate specialist automatically
- Transparent to user (just run `/execute-tasks`)
- Backward compatible (disable team_system → current behavior)

### 2. Full Code Generation
- **backend-dev**: Complete Spring Boot code (controllers, services, repos, DTOs, tests)
- **frontend-dev**: Complete React/Angular code (components, hooks/services, types, tests)
- **qa-specialist**: Full test suite (unit, integration, E2E)
- **devops-specialist**: Complete CI/CD pipeline (GitHub Actions, Docker)

### 3. API Mock Generation
- backend-dev generates JSON mocks matching API responses
- frontend-dev uses mocks (no backend server needed)
- Faster development (frontend doesn't wait for backend)
- Mocks serve as API contract documentation

### 4. Auto-Fix Test Failures
- qa-specialist runs tests
- If failures: Analyzes errors, delegates fix to backend/frontend-dev
- Loops until green (max 3 attempts)
- Reports to user if can't auto-fix

### 5. Multi-Stack Support
- **Backend**: Java Spring Boot (primary), Node.js/Express (future)
- **Frontend**: React (primary), Angular (secondary)
- Profile detection from config.yml active_profile
- Skills auto-load based on stack

## User Journey

```
You: /execute-tasks
  ↓
System reads tasks.md:
- "Create POST /api/users endpoint with email validation"
- "Create UserList component with pagination"
- "Add E2E test for user creation flow"
  ↓
Task 1 Analysis: Contains "api", "endpoint"
→ Route to: backend-dev
  ↓
backend-dev (auto-loads Java Spring Boot skills):
- Generates UserController.java, UserService.java, UserRepository.java
- Generates User.java (entity), UserDTO.java, UserCreateRequest.java
- Generates unit tests (12 tests, 95% coverage)
- Generates API mocks: api-mocks/users.json
- Handoff: "API ready, mocks available for frontend"
  ↓
Task 2 Analysis: Contains "component"
→ Route to: frontend-dev
  ↓
frontend-dev (auto-loads React skills):
- Receives API mocks from backend handoff
- Generates UserList.tsx, UserCard.tsx components
- Generates UserService.ts (uses mocks in dev mode)
- Generates types/User.ts
- Generates UserList.test.tsx (8 tests, 85% coverage)
- Handoff: "UI ready, needs integration testing"
  ↓
Task 3 Analysis: Contains "test", "e2e"
→ Route to: qa-specialist
  ↓
qa-specialist:
- Runs unit tests (backend): 12/12 passing ✅
- Runs unit tests (frontend): 8/8 passing ✅
- Runs integration tests: 3/4 passing, 1 failure
  → Failure: POST /api/users returns 500 instead of 201
  → Analyzes: Missing @Transactional annotation
  → Delegates to backend-dev: "Add @Transactional to UserService"
  → backend-dev fixes
  → Re-runs: 4/4 passing ✅
- Generates E2E test: tests/e2e/user-creation.spec.ts
- Runs E2E: All passing ✅
- Handoff: "All tests green, ready for deployment"
  ↓
devops-specialist (implicit, if deployment tasks exist):
- Generates .github/workflows/ci.yml
- Generates Dockerfile (backend + frontend)
- Generates docker-compose.yml
- Handoff: "CI/CD ready, push to trigger"
  ↓
git-workflow commits all code:
  Co-Authored-By: backend-dev, frontend-dev, qa-specialist, devops-specialist
  ↓
Feature Complete! ✅
```

## Deliverables

**Per feature development** (in project repository):
- **Backend Code**: Controllers, Services, Repositories, Entities, DTOs, Unit Tests
- **API Mocks**: JSON files in `api-mocks/` directory
- **Frontend Code**: Components, Services, Types, Unit Tests
- **Integration Tests**: API-level tests with test database
- **E2E Tests**: Playwright/Cypress test scenarios
- **CI/CD Pipeline**: GitHub Actions workflows
- **Docker Config**: Dockerfile, docker-compose.yml
- **Team Artifacts**: team-progress.md, team-handoffs.md

## Technical Stack

- **Workflow**: Extends `agent-os/workflows/core/execute-tasks.md`
- **Agents**: 4 specialists + 1 utility (backend-dev, frontend-dev, qa-specialist, devops-specialist, mock-generator)
- **Skills**: 2 new + 11 existing reused (testing-best-practices, devops-patterns, + all Java/React/Angular skills)
- **Templates**: 12 new team development templates
- **Config**: team_system section in agent-os/config.yml
- **Integration**: Transparent smart routing, backward compatible

**Backend Stacks**:
- Java Spring Boot 3.x (primary) - Uses existing java-*, spring-*, jpa-* skills
- Node.js/Express (future) - Would use nodejs-backend-patterns skill (defer)

**Frontend Stacks**:
- React 18+ (primary) - Uses existing react-* skills
- Angular 17+ (secondary) - Uses existing angular-* skills

**Testing**:
- Unit: JUnit 5 (backend), Jest (frontend)
- Integration: TestContainers, MSW
- E2E: Playwright or Cypress

**CI/CD**:
- GitHub Actions (MVP)
- Docker (containerization)

## Integration

**With /execute-tasks**:
- Smart task routing extension (Step 5 modified)
- Backward compatible (enabled flag)
- Falls back to direct execution if task type unknown

**With existing skills**:
- Reuses all 11 development skills (Java, React, Angular, security, git)
- Adds 2 new skills (testing, devops)

**With profiles**:
- active_profile determines stack (java-spring-boot, react-frontend, angular-frontend)
- Specialists auto-detect and adapt

## Out of Scope (Phase B)

- ❌ Parallel execution (sequential only for MVP)
- ❌ Product/Marketing teams (only Development team)
- ❌ Round-table discussions
- ❌ Scrum events (/write-user-stories, etc.)
- ❌ Real server lifecycle management (uses mocks for MVP)
- ❌ Advanced deployment platforms (just GitHub Actions + Docker)

## Success Metrics

- ✅ Task routing accuracy >90% (correct specialist for task)
- ✅ Generated code compiles and builds
- ✅ Test coverage ≥80%
- ✅ All tests pass after auto-fix loop
- ✅ CI/CD pipeline runs successfully
- ✅ Feature complete and deployable

## Estimated Effort

**Implementation**: 30-38 hours total
- Skills: 4-5h (2 comprehensive skills)
- Templates: 4-5h (12 templates)
- Agents: 10-12h (5 agents with full logic)
- Workflow: 6-8h (execute-tasks.md extension)
- Config + Setup: 3-4h
- Documentation: 3-4h
- Testing: 2-3h

## Quick Start (After Implementation)

```bash
# 1. Have tasks.md with mixed task types
cat tasks.md
# - Create POST /api/users endpoint
# - Create UserList component
# - Add E2E tests
# - Setup CI/CD

# 2. Run execute-tasks (system routes automatically)
/execute-tasks

# 3. System executes:
# → backend-dev implements API
# → frontend-dev implements UI (using API mocks)
# → qa-specialist runs all tests (auto-fixes failures)
# → devops-specialist creates CI/CD
# → git-workflow commits with team co-authors

# 4. Feature complete!
# All code generated, tested, and ready to deploy
```

## Why This Matters

**Without Team System**:
- You write backend code
- You write frontend code
- You write tests
- You setup CI/CD
- 40+ hours for full-stack feature
- Error-prone (easy to miss tests, skip best practices)

**With Team System**:
- backend-dev writes backend (follows Java/Spring skills)
- frontend-dev writes frontend (follows React/Angular skills)
- qa-specialist writes + runs tests (ensures quality)
- devops-specialist configures deployment (automates releases)
- 15-20 hours equivalent work (specialists work efficiently)
- High quality (skills enforce best practices)
- Comprehensive (nothing skipped)

**ROI**: 2x faster feature development + higher code quality + nothing forgotten

---

For complete details, see: @agent-os/specs/2025-12-28-team-development-system/spec.md
