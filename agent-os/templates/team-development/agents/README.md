# Agent Templates - Team Development System

> Templates for creating project-specific agent overrides with consistent structure

## Purpose

These templates provide a **technology-agnostic structure** for customizing Team Development System agents to your project's specific technology stack and patterns.

## Why Use Agent Templates?

**Without Templates**:
- Start from scratch when customizing agents
- Inconsistent agent structure across projects
- Easy to miss important sections
- No guidance on what to customize

**With Templates**:
- Consistent structure across all project-specific agents
- Clear [CUSTOMIZE] markers show what needs adaptation
- Technology-agnostic foundation (works for any stack)
- Faster customization (fill in blanks vs write from scratch)

## Available Templates

### 1. backend-dev-template.md

**For**: Backend API development specialists

**Customize**:
- Tech Stack (Spring Boot, Express, FastAPI, Django, Rails)
- Controller/Route patterns
- Service layer structure
- Data access patterns (JPA, Prisma, ORM)
- Testing frameworks (JUnit, Jest, Pytest)
- Exception handling
- API documentation format

**Use When**: Project uses different backend framework than default (Java Spring Boot)

---

### 2. frontend-dev-template.md

**For**: Frontend application specialists

**Customize**:
- Framework (React, Angular, Vue, Svelte)
- Component structure (functional, class, composition)
- State management (Context, Redux, NgRx, Pinia)
- Styling approach (TailwindCSS, CSS Modules, styled-components)
- Form handling (React Hook Form, Formik, Reactive Forms)
- Testing (Jest, Vitest, Jasmine)

**Use When**: Project uses different frontend framework than default (React)

---

### 3. qa-specialist-template.md

**For**: Testing and quality assurance specialists

**Customize**:
- Backend testing stack (JUnit, Jest, Pytest)
- Frontend testing stack (React Testing Library, Angular)
- E2E framework (Playwright, Cypress, Selenium)
- Quality gate thresholds (coverage %, performance)
- Critical user flows to test
- Test execution commands

**Use When**: Project has specific testing requirements or different test frameworks

---

### 4. devops-specialist-template.md

**For**: CI/CD and deployment specialists

**Customize**:
- CI/CD platform (GitHub Actions, GitLab CI, Jenkins)
- Containerization (Docker, Podman, None)
- Hosting platform (AWS, Azure, GCP, DigitalOcean, Vercel)
- Deployment strategy (Rolling, Blue-Green, Canary)
- Environment setup (dev, staging, production)
- Monitoring tools (Datadog, Sentry, CloudWatch)

**Use When**: Project uses different CI/CD platform or hosting than defaults

---

## How to Use

### Step 1: Override Global Agent

**In Agent OS Manager**:
1. Click "Agents" tab
2. Find agent (e.g., backend-dev)
3. Click "Override" button
4. Agent copied to project: `.claude/agents/backend-dev.md`
5. Monaco Editor opens

**Or Manually**:
```bash
cp agent-os/templates/team-development/agents/backend-dev-template.md \
   .claude/agents/backend-dev.md
```

### Step 2: Customize Template

**Find and replace all [CUSTOMIZE] sections**:

**Tech Stack**:
```markdown
Framework: [e.g., Spring Boot 3.x]
→ Framework: Django 5.0
```

**Patterns**:
```markdown
Controller Pattern: [Describe your controller structure]
→ Controller Pattern: Django ViewSets with Serializers
  - Location: app/views/
  - Base class: ModelViewSet
  - Serializers in: app/serializers/
```

**Commands**:
```markdown
[e.g., mvn test]
→ pytest tests/
```

### Step 3: Add Project-Specific Content

**Skills to Load**:
```markdown
[your-backend-patterns]
→ django-rest-framework-patterns
```

**Quality Checklist**:
```markdown
- [ ] [PROJECT-SPECIFIC REQUIREMENT]
→ - [ ] Django migrations created
  - [ ] All models registered in admin
```

### Step 4: Save

- Save in Agent OS Manager
- Or save file directly
- Agent is now project-optimized!

## Example: Django Backend Project

**Before** (global backend-dev):
- Generates Spring Boot code (Java)
- Uses JPA patterns
- JUnit tests

**After** (using template, customized for Django):
- Framework: Django 5.0
- Controller Pattern: ViewSets + Serializers
- Service Pattern: Service classes in app/services/
- Data Access: Django ORM with custom QuerySets
- Testing: Pytest + Django Test Framework
- Generates Django code (Python)!

## Benefits

✅ **Consistency** - Same structure across all customized agents
✅ **Guidance** - [CUSTOMIZE] markers show exactly what to change
✅ **Flexibility** - Technology-agnostic, works for any stack
✅ **Speed** - Faster than writing from scratch
✅ **Completeness** - Templates ensure nothing is forgotten
✅ **Team Alignment** - Shared structure across team members

## Template Structure

All agent templates follow this structure:

1. **Frontmatter** - name, description, tools, color (filled in)
2. **Core Responsibilities** - Universal, no customization needed
3. **Tech Stack Support** - [CUSTOMIZE] with your stack
4. **Auto-Loaded Skills** - [CUSTOMIZE] with project skills
5. **Code Generation Standards** - [CUSTOMIZE] patterns for each layer
6. **Quality Checklist** - [CUSTOMIZE] with project requirements
7. **Project-Specific Notes** - [ADD] your context

## When NOT to Use Templates

**Skip templates if**:
- Using default tech stack (Java Spring Boot + React)
- Global agents work perfectly as-is
- No project-specific patterns needed
- Quick prototype (don't need customization)

**Just use global agents directly** - only override when needed!

---

## Support

Questions about templates?
- See main README.md for Team Development System docs
- Check agent-os/workflows/team/README.md for complete guide
- GitHub Issues for feature requests

---

**Version**: 1.0
**Created**: 2025-12-30
