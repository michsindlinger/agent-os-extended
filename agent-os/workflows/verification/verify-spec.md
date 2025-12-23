---
description: Verify specification completeness before implementation
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Verify Specification

Systematically verify that a specification is complete before creating tasks.

## Purpose

Ensure specifications are comprehensive and ready for implementation by checking:
- All business requirements are documented
- Technical details are complete
- Security considerations addressed
- Testing strategy defined
- No critical gaps or ambiguities

## When to Run

Run this verification after creating spec.md and all sub-specs, before creating tasks.md.

**Workflow Integration:**
```
create-spec → write spec.md → [VERIFY SPEC] → create tasks.md
```

## Verification Checklist

### 1. Business Requirements ✓

**Check for:**
- [ ] **Overview**: Clear 1-2 sentence goal stated
- [ ] **User Stories**: At least 1 user story with "As a... I want... so that..."
- [ ] **Success Criteria**: Measurable outcomes defined
- [ ] **Business Value**: Why this feature matters (in user stories or overview)
- [ ] **Scope**: Clearly defined what IS included
- [ ] **Out of Scope**: Explicitly states what is NOT included (if applicable)

**Questions to Ask:**
- Can a developer understand WHY this feature is needed?
- Are success criteria testable/measurable?
- Is it clear what the feature should and shouldn't do?

**If gaps found:**
```markdown
⚠ Business Requirements Incomplete:
- Missing: Clear success criteria
- Missing: Business value justification

Should I update the spec to include these?
```

### 2. Technical Completeness ✓

**Check for:**
- [ ] **Architecture**: High-level architecture described or referenced
- [ ] **Data Model**: Entities/tables specified (if database changes needed)
- [ ] **API Contracts**: Endpoints, requests, responses documented (if API changes needed)
- [ ] **Dependencies**: External libraries/services identified
- [ ] **Integration Points**: How this connects to existing system
- [ ] **Performance Requirements**: Response times, load expectations, data volume

**Questions to Ask:**
- Does technical-spec.md exist and is it complete?
- If database changes: Is database-schema.md created?
- If API changes: Is api-spec.md created?
- Are integration points with existing code clear?

**If gaps found:**
```markdown
⚠ Technical Specification Incomplete:
- Missing: database-schema.md (feature requires new tables)
- Missing: Performance requirements not specified
- Missing: Integration with PaymentService not documented

Should I create missing sub-specs and add details?
```

### 3. Security & Privacy ✓

**Check for:**
- [ ] **Authentication**: Who can access this feature?
- [ ] **Authorization**: What permissions are required?
- [ ] **Data Privacy**: Any PII or sensitive data? GDPR/compliance considerations?
- [ ] **Input Validation**: Validation rules specified?
- [ ] **Rate Limiting**: Any throttling or rate limits needed?
- [ ] **Audit Logging**: Should actions be logged?

**Questions to Ask:**
- Are authentication/authorization requirements clear?
- Is sensitive data handled appropriately?
- Are security best practices applied?

**If gaps found:**
```markdown
⚠ Security Considerations Incomplete:
- Missing: Authorization rules not specified
- Missing: No mention of input validation
- Missing: Rate limiting not addressed

Should I add security requirements section?
```

### 4. Testing Strategy ✓

**Check for:**
- [ ] **Test Scenarios**: Key scenarios to test documented
- [ ] **Acceptance Criteria**: How to verify feature works (in Expected Deliverable)
- [ ] **Edge Cases**: Known edge cases documented
- [ ] **Error Scenarios**: Error handling approach specified

**Questions to Ask:**
- Can QA understand what to test?
- Are acceptance criteria clear and testable?
- Are edge cases identified?

**If gaps found:**
```markdown
⚠ Testing Strategy Incomplete:
- Missing: Edge cases not documented
- Missing: Error scenarios not specified

Should I add a testing section to technical-spec?
```

### 5. UI/UX (If Applicable) ✓

**Check for:**
- [ ] **Mockups/Wireframes**: Visual designs provided or referenced (in mockups/)
- [ ] **User Flows**: Step-by-step user journey documented
- [ ] **Accessibility**: Any a11y requirements?
- [ ] **Responsive Design**: Mobile/tablet behavior specified?
- [ ] **Visual States**: Loading, error, empty, success states defined

**Questions to Ask:**
- For UI features: Are visual designs available?
- Is the user flow clear?
- Are all visual states considered?

**If gaps found:**
```markdown
⚠ UI/UX Specification Incomplete:
- Missing: No mockups provided
- Missing: Responsive behavior not specified
- Missing: Loading state not described

Should I:
1. Request mockups from you?
2. Create text-based UI description?
3. Proceed without visual spec?
```

### 6. Dependencies & Integration ✓

**Check for:**
- [ ] **Existing Components**: Components to reuse identified (from research)
- [ ] **New Components**: New components to create listed
- [ ] **External APIs**: Third-party integrations documented
- [ ] **Breaking Changes**: Any breaking changes flagged

**Questions to Ask:**
- Are all dependencies documented?
- Is it clear what's being reused vs created new?
- Are breaking changes identified?

## Verification Process

### Step 1: Run Through Checklist

Go through each category systematically, marking items as complete or identifying gaps.

### Step 2: Calculate Completeness Score

```
Total checks: 30
Passed: 25
Completeness: 83%
```

**Thresholds:**
- 95-100%: Excellent, ready to proceed
- 80-94%: Good, minor gaps acceptable
- 60-79%: Fair, should address major gaps
- <60%: Incomplete, needs significant work

### Step 3: Report Findings

```markdown
## Spec Verification Report

**Spec**: [Spec Name]
**Date**: [Current Date]
**Completeness**: 83% (25/30 checks passed)

### ✅ Complete Sections
- Business Requirements (5/5)
- Technical Specification (4/5)
- Security & Privacy (4/6)

### ⚠ Gaps Identified

**Technical Completeness:**
- Missing: Performance requirements not specified
  Recommendation: Add max response time, expected load

**Security & Privacy:**
- Missing: Rate limiting not addressed
  Recommendation: Specify limits (e.g., 100 requests/hour)
- Missing: Audit logging not mentioned
  Recommendation: Decide if user actions should be logged

### Recommendation

Status: GOOD - Minor gaps can be addressed
Action: Update spec to include performance and rate limiting requirements

Proceed with task creation? [Yes/No/Fix gaps first]
```

### Step 4: User Decision

Ask user if they want to:
1. **Fix gaps first** - Update spec before proceeding
2. **Proceed anyway** - Gaps acceptable, move forward
3. **Defer verification** - Skip for now (not recommended)

### Step 5: Update Spec if Needed

If user chooses to fix gaps:
1. Update relevant spec files
2. Re-run verification
3. Confirm all critical gaps addressed

## Integration with create-spec

Add verification step between spec writing and task creation:

```
Step 10: Write spec.md
Step 11: Write sub-specs
[NEW] Step 12: Verify Specification
  - Run verification checklist
  - Report findings
  - Fix gaps if needed
  - Get user approval
Step 13: Create tasks.md
```

## Verification Bypass

For simple features or prototypes, verification can be skipped:

```yaml
# In spec frontmatter
skip_verification: true
reason: "Simple prototype, full spec not needed"
```

## Checklist Template

Save verification results:

**File**: `agent-os/specs/YYYY-MM-DD-feature-name/verification-report.md`

```markdown
# Specification Verification Report

**Spec**: [Name]
**Date**: [Date]
**Verified By**: Claude Code
**Completeness**: [X]%

## Checklist Results

### Business Requirements (5/5) ✅
- [x] Clear overview
- [x] User stories
- [x] Success criteria
- [x] Scope defined
- [x] Out of scope defined

### Technical Completeness (4/5) ⚠
- [x] Architecture described
- [x] Data model specified
- [x] API contracts documented
- [ ] Performance requirements **MISSING**
- [x] Integration points identified

[... continue for all categories]

## Gaps Summary

**Critical Gaps** (Must fix):
- None

**Important Gaps** (Should fix):
- Performance requirements not specified

**Minor Gaps** (Nice to have):
- Audit logging not mentioned

## Recommendation

Proceed with: [TASK CREATION / FIX GAPS / REVISE SPEC]

## Actions Taken

- [If gaps fixed: List what was updated]
- [If proceeded: Note that gaps were accepted]
```

## Best Practices

1. **Be Thorough** - Don't skip categories
2. **Be Specific** - Point to exact gaps, not generic "incomplete"
3. **Provide Context** - Explain why gap matters
4. **Offer Solutions** - Suggest how to fix gaps
5. **Get Approval** - Don't auto-fix without user input

## Benefits

- Catches incomplete specs before implementation starts
- Reduces rework during development
- Ensures security and performance considered upfront
- Creates accountability and quality gate
- Documentation of what was verified
