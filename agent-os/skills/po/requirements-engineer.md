---
name: requirements-engineer
description: Transforms business needs into detailed technical requirements
version: 1.0
---

# Requirements Engineer

Bridges business and technical teams by transforming stakeholder needs into clear, actionable requirements that development teams can implement.

## Trigger Conditions

```yaml
task_mentions:
  - "requirement|spec|specification"
  - "user story|acceptance criteria"
  - "business logic|rules"
  - "functional|non-functional"
file_extension:
  - .md
file_contains:
  - "## Requirements"
  - "## Acceptance Criteria"
  - "Given"
  - "When"
  - "Then"
always_active_for_agents:
  - po-agent
  - product-agent
```

## When to Load

- Writing user stories
- Defining acceptance criteria
- Documenting business rules
- Creating specifications

## Core Competencies

### Requirements Hierarchy

```
Epic (Large initiative, spans multiple sprints)
├── Feature (Deliverable functionality)
│   ├── User Story (Single user value)
│   │   ├── Acceptance Criteria
│   │   └── Technical Tasks
│   └── User Story
└── Feature
```

### User Story Template

```markdown
# US-[ID]: [Title]

## Story
As a **[user persona]**,
I want to **[action/capability]**,
So that **[business value/benefit]**.

## Context
[Background information, why this is needed]

## Acceptance Criteria

### Scenario 1: [Happy Path]
```gherkin
Given [initial context]
  And [additional context]
When [action is taken]
Then [expected outcome]
  And [additional outcome]
```

### Scenario 2: [Alternative Path]
```gherkin
Given [initial context]
When [alternative action]
Then [different outcome]
```

### Scenario 3: [Error Handling]
```gherkin
Given [initial context]
When [invalid action]
Then [error message is shown]
  And [system state is preserved]
```

## Business Rules
1. [Rule 1]: [Description]
2. [Rule 2]: [Description]

## UI/UX Notes
- [Design considerations]
- [Wireframe/mockup links]

## Data Requirements
| Field | Type | Validation | Required |
|-------|------|------------|----------|
| email | string | valid email format | Yes |
| name | string | 1-100 chars | Yes |

## Non-Functional Requirements
- Performance: [Response time expectations]
- Security: [Access control requirements]
- Accessibility: [WCAG level]

## Out of Scope
- [Explicitly excluded functionality]

## Dependencies
- [US-XXX]: [Description]
- [External system]: [Integration point]

## Open Questions
- [ ] [Question 1]
- [ ] [Question 2]
```

### Gherkin Best Practices

```gherkin
# Good: Specific, testable, business-focused
Feature: User Authentication

  Scenario: Successful login with valid credentials
    Given I am on the login page
    And I have a registered account with email "user@example.com"
    When I enter email "user@example.com"
    And I enter password "validPassword123"
    And I click the "Sign In" button
    Then I should be redirected to the dashboard
    And I should see "Welcome back, User"

  Scenario: Login fails with incorrect password
    Given I am on the login page
    And I have a registered account with email "user@example.com"
    When I enter email "user@example.com"
    And I enter password "wrongPassword"
    And I click the "Sign In" button
    Then I should see error message "Invalid email or password"
    And I should remain on the login page

  Scenario: Account lockout after failed attempts
    Given I am on the login page
    And I have failed to login 4 times
    When I attempt to login with incorrect password
    Then my account should be locked for 15 minutes
    And I should see "Account locked. Please try again later."
```

### Non-Functional Requirements

```markdown
## Performance Requirements
| Metric | Target | Measurement |
|--------|--------|-------------|
| Page load time | < 2 seconds | 95th percentile |
| API response time | < 200ms | 95th percentile |
| Concurrent users | 1000+ | Load test |
| Uptime | 99.9% | Monthly SLA |

## Security Requirements
- All data encrypted at rest (AES-256)
- All connections over TLS 1.3
- Session timeout after 30 minutes inactivity
- Multi-factor authentication for admin users
- Password policy: min 8 chars, 1 uppercase, 1 number

## Accessibility Requirements
- WCAG 2.1 Level AA compliance
- Screen reader compatible
- Keyboard navigation support
- Color contrast ratio minimum 4.5:1

## Compatibility Requirements
| Browser | Version |
|---------|---------|
| Chrome | Last 2 versions |
| Firefox | Last 2 versions |
| Safari | Last 2 versions |
| Edge | Last 2 versions |
```

## Best Practices

### INVEST Criteria for Stories

| Criterion | Description | Example |
|-----------|-------------|---------|
| Independent | No dependencies on other stories | Can be developed in isolation |
| Negotiable | Details can be discussed | Not a contract |
| Valuable | Delivers user/business value | Solves real problem |
| Estimable | Can be sized by team | Clear enough to estimate |
| Small | Fits in one sprint | 1-5 story points |
| Testable | Has clear acceptance criteria | Can verify completion |

### Requirements Validation

```markdown
## Validation Checklist

### Clarity
- [ ] No ambiguous terms (avoid "should", "might", "etc.")
- [ ] Measurable success criteria
- [ ] Clear scope boundaries

### Completeness
- [ ] All scenarios covered (happy path, errors, edge cases)
- [ ] Non-functional requirements specified
- [ ] Data requirements documented

### Consistency
- [ ] No contradictions with other requirements
- [ ] Aligned with existing functionality
- [ ] Terminology consistent with glossary

### Feasibility
- [ ] Technically possible
- [ ] Within budget/timeline
- [ ] Team has necessary skills
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Vague acceptance criteria | Can't verify completion | Use Gherkin format |
| Missing edge cases | Unexpected behavior | Document all scenarios |
| Solution in requirements | Constrains implementation | Focus on what, not how |
| No business value | Wasted effort | Always state the "so that" |
| Too large | Can't estimate or test | Split into smaller stories |

## Checklist

### Story Quality
- [ ] Follows user story format
- [ ] Has clear acceptance criteria
- [ ] Includes error scenarios
- [ ] Defines data requirements
- [ ] Lists dependencies

### Specification Complete
- [ ] All stakeholders reviewed
- [ ] Technical feasibility confirmed
- [ ] Design assets linked
- [ ] Open questions resolved

## Integration

### Works With
- backlog-strategist (prioritization)
- acceptance-tester (test cases)
- architect-api-designer (API specs)

### Output
- User stories
- Acceptance criteria
- Business rules documentation
- Specification documents
