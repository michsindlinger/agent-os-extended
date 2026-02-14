# Verification System

Quality gates for specifications and implementations (v2.0).

## Overview

The verification system provides automatic quality checkpoints throughout the development lifecycle:

1. **Spec Verification** - After spec creation, before task breakdown
2. **Implementation Verification** - After coding, before task completion
3. **Visual Verification** - After UI implementation, before review

## Why Verification Matters

**Without Verification:**
- Incomplete specs lead to rework
- Code quality inconsistent
- Security issues slip through
- UI doesn't match designs
- Technical debt accumulates

**With Verification:**
- Specs are comprehensive upfront
- Code quality is consistent
- Security is validated
- UI matches designs
- Quality is built-in, not bolted-on

## Verification Types

### 1. Spec Verification

**File**: `verify-spec.md`

**When**: After writing spec.md and sub-specs, before creating tasks.md

**Checks**:
- ✓ Business requirements complete
- ✓ Technical specifications detailed
- ✓ Security considerations addressed
- ✓ Testing strategy defined
- ✓ UI/UX specified (if applicable)
- ✓ Dependencies documented

**Output**: Verification report with completeness score (e.g., 92%)

**Action**: Fix critical gaps before proceeding to task creation

**Example Result:**
```markdown
Spec Verification: 85% (26/30 checks)

✅ Complete:
- Business requirements
- User stories
- Technical architecture

⚠ Gaps:
- Performance requirements not specified
- Rate limiting not addressed

Recommendation: Add performance section
```

### 2. Implementation Verification

**File**: `verify-implementation.md`

**When**: After implementing a task, before marking it complete

**Checks**:
- ✓ Standards compliance (naming, formatting)
- ✓ Code pattern reuse (no duplication)
- ✓ Security best practices
- ✓ Tests written and passing
- ✓ Performance optimized
- ✓ Documentation complete

**Output**: Implementation verification report with pass/fail status

**Action**: Fix security and quality issues before completion

**Example Result:**
```markdown
Implementation Verification: PASS WITH WARNINGS

✅ Pass:
- Standards compliance
- Code pattern reuse
- Tests passing (87% coverage)
- Documentation present

⚠ Warnings:
- Rate limiting not implemented
- N+1 query in OrderService:89

Recommendation: Fix N+1 query, consider rate limiting
```

### 3. Visual Verification

**File**: `verify-visual.md`

**When**: After implementing UI, before final review

**Checks**:
- ✓ Layout matches mockup
- ✓ Colors match design tokens
- ✓ Typography matches
- ✓ Interactive states implemented
- ✓ Responsive behavior correct
- ✓ Accessibility features present

**Output**: Visual verification report with side-by-side comparison

**Action**: Fix visual discrepancies or document intentional deviations

**Example Result:**
```markdown
Visual Verification: 85% (32/38 checks)

✅ Match:
- Layout structure
- Primary colors
- Component positioning

⚠ Mismatch:
- Button radius: 4px (should be 8px)
- Text color: gray-700 (should be gray-900)
- Focus indicators: Missing

Recommendation: Fix button radius and focus indicators
```

## Workflow Integration

### In /create-spec

```
Step 10: Write spec.md
Step 11: Write sub-specs
[NEW] Step 12: Verify Specification
  IF verification PASS:
    → Proceed to task creation
  ELSE IF verification has GAPS:
    → Ask user: Fix gaps or proceed anyway?
    → If fix: Update spec and re-verify
    → If proceed: Document accepted gaps
Step 13: Create tasks.md
```

### In /execute-tasks

```
Step 5: Implement task
Step 6: Write tests
[NEW] Step 7: Verify Implementation
  IF verification PASS:
    → Mark task complete
  ELSE IF verification FAIL:
    → Fix issues
    → Re-verify
    → Then mark complete
Step 8: Move to next task
```

### In /orchestrate-tasks (Phase II future)

```
Step 3: Integrate all tasks
[NEW] Step 4: Verify Visual Implementation
  IF UI feature AND mockups provided:
    → Run visual verification
    → Compare with mockups
    → Fix discrepancies
  ELSE:
    → Skip visual verification
Step 5: Final review
```

## Verification Configuration

### Enable in config.yml

```yaml
verification:
  enabled: true
  spec_verification: true
  implementation_verification: true
  visual_verification: true  # Requires mockups
```

### Selective Verification

```yaml
# Only enable certain types
verification:
  enabled: true
  spec_verification: true
  implementation_verification: true
  visual_verification: false  # Skip visual checks
```

### Per-Spec Override

Add to spec.md frontmatter:

```yaml
---
skip_verification: true
reason: "Prototype - full verification not needed"
---
```

Or selective:

```yaml
---
verification:
  spec: true
  implementation: false  # Skip for this spec
  visual: false
---
```

## Verification Reports

All verification reports stored in spec directory:

```
specwright/specs/YYYY-MM-DD-feature-name/
├── verification-reports/
│   ├── spec-verification.md
│   ├── implementation-verification-task-1.md
│   ├── implementation-verification-task-2.md
│   └── visual-verification.md
├── screenshots/                    # For visual verification
│   ├── actual-page-1.png
│   └── actual-page-2.png
└── mockups/                        # Original designs
    └── design-page-1.png
```

## Verification Thresholds

### Spec Verification
- **95-100%**: Excellent - proceed confidently
- **80-94%**: Good - minor gaps acceptable
- **60-79%**: Fair - address major gaps
- **<60%**: Poor - significant work needed

### Implementation Verification
- **PASS**: All critical checks passed, minor warnings OK
- **PASS WITH WARNINGS**: Non-critical issues identified
- **FAIL**: Critical issues (security, correctness) must be fixed

### Visual Verification
- **95-100%**: Pixel-perfect match
- **85-94%**: Good match, minor deviations
- **70-84%**: Fair, noticeable differences
- **<70%**: Significant discrepancies

## Best Practices

1. **Run Systematically** - Don't skip verification
2. **Fix Critical Issues** - Security and correctness issues must be addressed
3. **Document Deviations** - If intentional, document why
4. **Iterate** - Re-verify after fixes
5. **Save Reports** - Keep verification history

## Benefits by Phase

**Spec Verification:**
- Catches incomplete requirements early
- Reduces implementation rework
- Ensures security considered upfront

**Implementation Verification:**
- Enforces code quality standards
- Catches security vulnerabilities
- Ensures test coverage
- Reduces technical debt

**Visual Verification:**
- Ensures design fidelity
- Catches visual bugs early
- Validates responsive behavior
- Confirms accessibility

## Example: Full Verification Flow

```markdown
Feature: Invoice Export

┌──────────────────────────┐
│ 1. Create Spec           │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 2. Verify Spec (92%)     │
│ ⚠ Missing: Rate limiting │
└──────────────────────────┘
         ↓
User: "Add rate limiting to spec"
         ↓
┌──────────────────────────┐
│ 3. Update Spec           │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 4. Re-verify (100%) ✅   │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 5. Create Tasks          │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 6. Implement Task 1      │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 7. Verify Implementation │
│ ⚠ N+1 query detected     │
└──────────────────────────┘
         ↓
User: "Fix the N+1 query"
         ↓
┌──────────────────────────┐
│ 8. Fix Code              │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 9. Re-verify (PASS) ✅   │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 10. Implement UI         │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 11. Verify Visual (85%)  │
│ ⚠ Focus indicators weak  │
└──────────────────────────┘
         ↓
User: "Fix focus indicators"
         ↓
┌──────────────────────────┐
│ 12. Update Styles        │
└──────────────────────────┘
         ↓
┌──────────────────────────┐
│ 13. Re-verify (95%) ✅   │
└──────────────────────────┘
         ↓
Feature Complete!
```

## Troubleshooting

**Q: Verification too strict?**
A: Adjust thresholds in config or skip non-critical checks

**Q: Takes too long?**
A: Focus on critical checks (security, correctness), skip nice-to-haves

**Q: False positives?**
A: Document intentional deviations, update verification criteria

**Q: Automation available?**
A: Visual verification can use Playwright MCP if available

## Resources

- [Spec Verification Workflow](verify-spec.md)
- [Implementation Verification Workflow](verify-implementation.md)
- [Visual Verification Workflow](verify-visual.md)
- [Verification Report Template](../../templates/verification/) _(coming soon)_
