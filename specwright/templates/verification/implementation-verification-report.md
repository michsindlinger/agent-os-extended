# Implementation Verification Report

**Task**: [Task Number and Description]
**Date**: [Current Date]
**Verified By**: Claude Code
**Version**: 2.0

---

## Checklist Results

### 1. Standards Compliance ([X]/5)

- [ ] Naming conventions followed (classes, methods, variables)
- [ ] Code style matches project standards (formatting, indentation)
- [ ] File organization correct (proper directories/packages)
- [ ] Imports organized (external first, then internal)
- [ ] Comments minimal and purposeful (explain "why" not "what")

**Notes**: [Any violations or observations]

---

### 2. Code Pattern Reuse ([X]/3)

- [ ] Existing patterns reused (not duplicated)
- [ ] Services/helpers used where available
- [ ] DRY principle followed (no copy-paste code)

**Reuse Analysis**:
- Reused: [List components reused]
- New: [List new components created]
- Duplicates: [List any duplicated code]

**Notes**: [Any observations]

---

### 3. Security ([X]/7)

- [ ] Input validation implemented
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (escaped user content)
- [ ] Authentication checks in place
- [ ] Authorization checks implemented
- [ ] No hardcoded secrets
- [ ] Secure error handling (no info leakage)

**Security Analysis**:
[Details of security checks performed]

**Notes**: [Any security concerns]

---

### 4. Testing ([X]/4)

- [ ] Unit tests written
- [ ] Test coverage acceptable (>80% for critical code)
- [ ] All tests passing
- [ ] Edge cases tested
- [ ] Error scenarios tested

**Test Results**:
```
Total Tests: [X]
Passing: [X]
Failing: [X]
Coverage: [X]%
```

**Notes**: [Test observations]

---

### 5. Performance ([X]/3)

- [ ] No N+1 queries (for database code)
- [ ] Appropriate caching implemented
- [ ] Indexes considered for query fields
- [ ] Pagination/streaming for large datasets (if applicable)
- [ ] Expensive computations memoized (if applicable)

**Performance Analysis**:
[Details of performance checks]

**Notes**: [Any performance concerns]

---

### 6. Documentation ([X]/2)

- [ ] Public methods documented (JavaDoc, JSDoc, TSDoc)
- [ ] Complex logic explained with comments

**Notes**: [Documentation observations]

---

## Overall Score

**Total Checks**: [X] / [Total]
**Pass Rate**: [X]%
**Status**: [PASS / PASS WITH WARNINGS / FAIL]

### Status Criteria
- PASS: All critical checks passed (>95%)
- PASS WITH WARNINGS: Minor issues only (85-94%)
- FAIL: Critical issues present (<85% or security/correctness failures)

---

## Issues Found

### 🚨 Critical Issues (Must Fix)
[Issues that must be fixed before proceeding]
- [Issue 1]: [Description, location, fix]
- [Issue 2]: [Description, location, fix]

### ⚠ Important Issues (Should Fix)
[Issues that should be addressed]
- [Issue 1]: [Description, location, recommendation]
- [Issue 2]: [Description, location, recommendation]

### ℹ Minor Issues (Nice to Fix)
[Issues that could be improved]
- [Issue 1]: [Description]
- [Issue 2]: [Description]

---

## Code Examples

### Issues Detected

**Issue 1: [Description]**
```java
// Current implementation (line XX)
[Show problematic code]

// Recommended fix
[Show corrected code]
```

**Issue 2: [Description]**
```java
// Current implementation (line XX)
[Show problematic code]

// Recommended fix
[Show corrected code]
```

---

## Recommendations

### Immediate Actions Required
1. [Action]: [What needs to be done]
2. [Action]: [What needs to be done]

### Before Marking Task Complete
- [ ] Fix all critical issues
- [ ] Address important issues (or document acceptance)
- [ ] Re-run tests after fixes
- [ ] Re-verify implementation

---

## Verification Sign-off

**Verified**: [Date and Time]
**Result**: [APPROVED / NEEDS REVISION / REJECTED]
**Next Step**: [Mark complete / Fix issues / Further review]

---

## Notes

[Any additional observations, patterns noticed, or recommendations for future tasks]
