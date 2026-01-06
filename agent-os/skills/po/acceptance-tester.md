---
name: acceptance-tester
description: Validates features against acceptance criteria and business requirements
version: 1.0
---

# Acceptance Tester

Ensures delivered features meet acceptance criteria and business requirements through systematic testing and validation.

## Trigger Conditions

```yaml
task_mentions:
  - "acceptance test|uat|validation"
  - "verify|validate|test"
  - "qa|quality assurance"
  - "demo|review"
file_extension:
  - .md
  - .feature
file_contains:
  - "Scenario:"
  - "Given"
  - "When"
  - "Then"
always_active_for_agents:
  - po-agent
  - qa-agent
```

## When to Load

- Feature completion review
- Sprint review preparation
- User acceptance testing
- Release validation

## Core Competencies

### Test Case Structure

```markdown
# Test Case: TC-[ID]

## Related Story
[US-XXX]: [Story title]

## Objective
[What this test validates]

## Preconditions
1. [User is logged in as admin]
2. [Test data exists: Product "Widget A" with price $99.99]

## Test Steps

| Step | Action | Expected Result | Status |
|------|--------|-----------------|--------|
| 1 | Navigate to /products | Products page loads | ✅ Pass |
| 2 | Click "Add Product" | Add Product form appears | ✅ Pass |
| 3 | Enter name: "Test Product" | Field accepts input | ✅ Pass |
| 4 | Enter price: "-10" | Validation error shown | ❌ Fail |
| 5 | Enter price: "49.99" | Field accepts input | ✅ Pass |
| 6 | Click "Save" | Product created, redirect to list | ✅ Pass |

## Result
❌ **FAIL** - Step 4: Negative price accepted without validation

## Notes
- Bug filed: BUG-123
- Severity: Medium
- Blocker: No

## Evidence
- Screenshot: [link]
- Video: [link]
```

### Acceptance Test Plan

```markdown
# Acceptance Test Plan: [Feature Name]

## Overview
**Feature**: [Feature name]
**Sprint**: [Sprint number]
**Test Lead**: [Name]
**Test Period**: [Start] - [End]

## Scope

### In Scope
- [ ] [Functionality 1]
- [ ] [Functionality 2]
- [ ] [Error handling]

### Out of Scope
- [Performance testing]
- [Security testing]

## Test Scenarios

### Happy Path Tests
| ID | Scenario | Priority | Status |
|----|----------|----------|--------|
| AT-001 | User creates new order | High | Pass |
| AT-002 | User edits existing order | High | Pass |
| AT-003 | User cancels order | Medium | Pass |

### Edge Cases
| ID | Scenario | Priority | Status |
|----|----------|----------|--------|
| AT-004 | Create order with max items (100) | Low | Pass |
| AT-005 | Order with special characters in notes | Low | Pass |

### Error Scenarios
| ID | Scenario | Priority | Status |
|----|----------|----------|--------|
| AT-006 | Submit order with empty cart | High | Fail |
| AT-007 | Submit order with invalid payment | High | Pass |

## Test Data Requirements
| Data | Description | Setup |
|------|-------------|-------|
| Test users | 5 users with different roles | Seed script |
| Products | 20 products in various categories | Seed script |
| Orders | 10 existing orders in various states | Manual |

## Environment
- **URL**: https://staging.example.com
- **Database**: Staging DB (refreshed daily)
- **Test accounts**: See test credentials doc

## Exit Criteria
- [ ] All high priority tests pass
- [ ] No critical/high bugs open
- [ ] 90%+ medium priority tests pass
- [ ] Stakeholder sign-off obtained
```

### Bug Report Template

```markdown
# Bug Report: BUG-[ID]

## Summary
[One-line description of the bug]

## Severity
🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low

## Environment
- **URL**: [URL where bug occurs]
- **Browser**: [Browser and version]
- **User role**: [User type/role]
- **Date**: [When discovered]

## Steps to Reproduce
1. [Navigate to...]
2. [Click on...]
3. [Enter value...]
4. [Observe error]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Evidence
- Screenshot: [Attached/Link]
- Video: [Link]
- Console errors:
```
[Error message]
```

## Impact
[Business impact of this bug]

## Workaround
[Temporary workaround if any, or "None"]

## Related
- Story: [US-XXX]
- Test case: [TC-XXX]
```

## Best Practices

### Test Coverage Matrix

```markdown
## Coverage by Acceptance Criteria

| Criterion | Test Cases | Coverage |
|-----------|------------|----------|
| AC1: User can create order | TC-001, TC-002 | ✅ Full |
| AC2: Validation on required fields | TC-003, TC-004, TC-005 | ✅ Full |
| AC3: Email notification sent | TC-006 | ⚠️ Partial |
| AC4: Order appears in list | TC-007 | ✅ Full |

Overall Coverage: 95%
```

### Exploratory Testing Session

```markdown
# Exploratory Test Session

## Charter
Explore the [feature] looking for [type of issues]
focusing on [specific area].

## Time Box
60 minutes

## Notes (Timestamped)
- **0:05** - Started testing order creation flow
- **0:12** - Found: Cancel button doesn't ask for confirmation
- **0:18** - Question: What happens with concurrent edits?
- **0:25** - Bug: Date picker allows selecting past dates
- **0:35** - Tested mobile view, layout issues found
- **0:50** - Tested with screen reader, missing alt texts

## Issues Found
1. [BUG-123] Cancel without confirmation
2. [BUG-124] Past dates selectable
3. [BUG-125] Mobile layout broken
4. [A11Y-01] Missing alt texts

## Questions for PO
1. Is confirmation dialog needed for cancel?
2. Should past dates be allowed for backdating?

## Debrief
- Areas well tested: [Creation flow, validation]
- Areas needing more testing: [Concurrent access]
- Confidence level: Medium
```

### Definition of Done Verification

```markdown
## DoD Checklist: [US-XXX]

### Functionality
- [x] All acceptance criteria pass
- [x] Edge cases handled
- [x] Error messages are user-friendly

### Quality
- [x] Unit tests written (80%+ coverage)
- [x] Integration tests pass
- [x] No critical/high bugs open
- [ ] Performance acceptable (< 2s load time)

### Documentation
- [x] API documentation updated
- [x] User documentation updated
- [ ] Release notes prepared

### Review
- [x] Code reviewed and approved
- [x] UX review completed
- [ ] Security review (if applicable)

**Status**: ❌ Not complete (Performance, Docs, Security pending)
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| No test cases | Ad-hoc testing | Document all scenarios |
| Only happy path | Misses errors | Include negative tests |
| Testing in production | Risk to users | Use staging environment |
| Verbal sign-off | No record | Written acceptance |
| Testing developer's work | Bias | Independent testing |

## Checklist

### Test Preparation
- [ ] Test plan reviewed
- [ ] Test data prepared
- [ ] Environment verified
- [ ] Access confirmed

### Test Execution
- [ ] All scenarios executed
- [ ] Results documented
- [ ] Bugs reported
- [ ] Evidence captured

### Sign-off
- [ ] All critical tests pass
- [ ] Stakeholder review complete
- [ ] DoD verified
- [ ] Sign-off documented

## Integration

### Works With
- requirements-engineer (acceptance criteria)
- test-engineer (automated tests)
- backlog-strategist (release planning)

### Output
- Test cases
- Bug reports
- Test results
- Acceptance sign-off
