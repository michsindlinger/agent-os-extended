---
description: Verify code quality and standards compliance after implementation
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Verify Implementation

Systematically verify that implemented code meets quality standards before marking tasks complete.

## Purpose

Ensure code quality by checking:
- Standards compliance (naming, formatting, structure)
- Security best practices applied
- Code pattern reuse (not duplication)
- Tests written and passing
- Performance considerations addressed

## When to Run

Run this verification after implementing a task, before marking it complete.

**Workflow Integration:**
```
implement task → write code → write tests → [VERIFY IMPLEMENTATION] → mark complete
```

## Verification Checklist

### 1. Standards Compliance ✓

**Check for:**
- [ ] **Naming Conventions**: Classes, methods, variables follow project standards
- [ ] **Code Style**: Formatting matches code-style.md (indentation, spacing)
- [ ] **File Organization**: Files in correct directories/packages
- [ ] **Imports**: Organized correctly (external first, then internal)
- [ ] **Comments**: Only where necessary, explaining "why" not "what"

**Language-Specific:**

**Java:**
```java
// Check naming
✓ Classes: PascalCase (UserService, OrderController)
✓ Methods: camelCase (findUserById, processOrder)
✓ Constants: UPPER_SNAKE_CASE (MAX_RETRY_COUNT)
✓ Packages: lowercase (com.company.project.service)
```

**TypeScript/React:**
```typescript
// Check naming
✓ Components: PascalCase (UserProfile, LoginForm)
✓ Files: Match component name (UserProfile.tsx)
✓ Hooks: camelCase with 'use' prefix (useAuth)
✓ Types: PascalCase (User, ApiResponse)
```

**If violations found:**
```markdown
⚠ Standards Violations:
- UserService.java:45 - Method name "FindUser" should be "findUser"
- OrderController.java:12 - Missing @RequestMapping on class
- UserDto.java:8 - Fields should be private final (using record?)

Fix these before proceeding? [Yes/No]
```

### 2. Code Pattern Reuse ✓

**Check for:**
- [ ] **Existing Patterns**: Similar code elsewhere was reused (not duplicated)
- [ ] **Services/Utilities**: Used existing utilities where available
- [ ] **Design Patterns**: Follows patterns established in codebase
- [ ] **No Duplication**: No copy-paste code that could be extracted

**Verification Process:**

Search for similar implementations:
```bash
# Find similar patterns
grep -r "similar functionality" --include="*.java"
```

**Example:**
```markdown
✓ Pattern Reuse Analysis:

Implemented: InvoiceExporter.java
Similar to: ReportExporter.java (extends base pattern ✓)

Implemented: generatePDF() method
Found: Similar method in ReportService.java
Status: Reused ReportService instead of duplicating ✓

⚠ Potential Duplication:
- CurrencyFormatter.formatAmount() in InvoiceService
- Similar to MoneyUtils.format() in shared utilities
- Recommendation: Use MoneyUtils.format() instead
```

**If duplication found:**
```markdown
⚠ Code Duplication Detected:
- File: InvoiceService.java:120-145
- Duplicates: OrderService.java:200-225
- Recommendation: Extract to shared utility

Refactor before proceeding? [Yes/No]
```

### 3. Security Best Practices ✓

**Check for:**
- [ ] **Input Validation**: All user inputs validated
- [ ] **SQL Injection Prevention**: Parameterized queries used
- [ ] **XSS Prevention**: User content escaped (for frontend)
- [ ] **Authentication**: Auth checks in place where needed
- [ ] **Authorization**: Permission checks implemented
- [ ] **Sensitive Data**: No hardcoded secrets, proper encryption
- [ ] **Error Handling**: No sensitive info leaked in errors

**Example checks:**

**SQL Injection:**
```java
// ✗ Vulnerable
String sql = "SELECT * FROM users WHERE email = '" + email + "'";

// ✓ Safe
@Query("SELECT u FROM User u WHERE u.email = :email")
Optional<User> findByEmail(@Param("email") String email);
```

**Authorization:**
```java
// ✓ Check permissions
@PreAuthorize("hasRole('ADMIN') or #userId == authentication.principal.id")
public User updateUser(Long userId, UpdateUserRequest request) { }
```

**Secrets:**
```java
// ✗ Hardcoded
String apiKey = "sk-1234567890";

// ✓ Environment variable
String apiKey = env.getProperty("API_KEY");
```

**If security issues found:**
```markdown
🚨 Security Issues Detected:

CRITICAL:
- InvoiceController.java:67 - No authorization check on DELETE endpoint
- UserService.java:123 - SQL injection risk (string concatenation)

IMPORTANT:
- Config.java:34 - API key hardcoded (should use environment variable)

These MUST be fixed before proceeding.
```

### 4. Testing ✓

**Check for:**
- [ ] **Unit Tests Written**: New code has unit tests
- [ ] **Test Coverage**: Critical paths are tested
- [ ] **Tests Pass**: All tests run successfully
- [ ] **Edge Cases**: Edge cases have tests
- [ ] **Error Scenarios**: Error handling is tested
- [ ] **Integration Tests**: If needed, integration tests exist

**Verification Commands:**
```bash
# Run tests
npm test          # For JavaScript/TypeScript
mvn test          # For Java/Maven
./gradlew test    # For Java/Gradle

# Check coverage
npm run coverage
mvn jacoco:report
```

**Coverage Thresholds:**
- Critical business logic: >90%
- Services: >80%
- Controllers: >70%
- Utilities: >80%

**If testing gaps found:**
```markdown
⚠ Testing Gaps:

Missing Tests:
- InvoiceExporter.generatePDF() - No unit tests
- InvoiceController.exportInvoice() - No integration test
- Edge case: Export with 0 line items - Not tested

Test Failures:
- UserServiceTest.shouldUpdateUser() - FAILED
  Error: NullPointerException at line 45

Coverage:
- InvoiceService: 65% (below 80% threshold)

Fix tests before proceeding? [Yes/No]
```

### 5. Performance Considerations ✓

**Check for:**
- [ ] **N+1 Queries**: No unintended N+1 query patterns (for database code)
- [ ] **Eager Loading**: Appropriate use of JOIN FETCH or includes()
- [ ] **Indexes**: Database indexes considered for queried fields
- [ ] **Caching**: Caching used for expensive operations where appropriate
- [ ] **Large Data**: Pagination or streaming for large datasets

**Example checks:**

**N+1 Detection:**
```java
// ✗ N+1 problem
List<Order> orders = orderRepository.findAll();  // 1 query
for (Order order : orders) {
    order.getItems();  // N queries!
}

// ✓ Fixed
@Query("SELECT o FROM Order o JOIN FETCH o.items")
List<Order> findAllWithItems();  // 1 query
```

**React Performance:**
```typescript
// ✗ No memoization
function UserList({ users, filter }) {
  const filtered = users.filter(u =>  // Runs every render
    u.name.includes(filter)
  );
}

// ✓ Memoized
const filtered = useMemo(
  () => users.filter(u => u.name.includes(filter)),
  [users, filter]
);
```

**If performance issues found:**
```markdown
⚠ Performance Concerns:

N+1 Query:
- InvoiceService.getInvoicesWithItems() at line 89
- Fetches items in loop (100 invoices = 101 queries)
- Fix: Use JOIN FETCH

Missing Indexes:
- Invoice.customer_id - Frequently queried, not indexed
- Recommendation: Add index in migration

Optimize before proceeding? [Yes/No]
```

### 6. Documentation ✓

**Check for:**
- [ ] **Public API**: Public methods have documentation (JavaDoc, JSDoc, TSDoc)
- [ ] **Complex Logic**: Non-obvious code has explanatory comments
- [ ] **README Updates**: If needed, README updated with new feature
- [ ] **API Docs**: If API changes, API documentation updated

**If documentation gaps found:**
```markdown
⚠ Documentation Gaps:
- InvoiceExporter.export() - Public method, no JavaDoc
- Complex algorithm at InvoiceCalculator:145 - No explanation

Add documentation? [Yes/No]
```

## Verification Report

Generate a verification report:

**File**: `specwright/specs/YYYY-MM-DD-feature-name/implementation-verification-[task-number].md`

```markdown
# Implementation Verification Report

**Task**: Task 1 - Invoice Export Service
**Date**: [Date]
**Status**: [PASS / PASS WITH WARNINGS / FAIL]

## Checklist Results

### Standards Compliance (5/5) ✅
- [x] Naming conventions followed
- [x] Code style matches
- [x] File organization correct
- [x] Imports organized
- [x] Minimal, purposeful comments

### Code Pattern Reuse (3/3) ✅
- [x] Extended ReportExporter base class
- [x] Used S3UploadService for storage
- [x] No code duplication detected

### Security (6/7) ⚠
- [x] Input validation implemented
- [x] SQL injection prevention
- [x] Authentication required
- [x] Authorization checks present
- [ ] Rate limiting NOT implemented ⚠
- [x] No hardcoded secrets
- [x] Secure error handling

### Testing (4/4) ✅
- [x] Unit tests written (coverage: 87%)
- [x] All tests passing
- [x] Edge cases tested
- [x] Error scenarios tested

### Performance (3/3) ✅
- [x] No N+1 queries
- [x] Appropriate caching
- [x] Indexed query fields

### Documentation (2/2) ✅
- [x] Public methods documented
- [x] Complex logic explained

## Issues Found

**Important:**
- Rate limiting not implemented (recommended: 10 exports/hour/user)

**Recommendation:** Add rate limiting before deployment to production

## Overall Assessment

**Status**: PASS WITH WARNINGS
**Completeness**: 92% (22/24 checks)
**Recommendation**: Address rate limiting, then proceed

## Sign-off

Implementation verified and ready for: [MERGE / FURTHER REVIEW / FIXES NEEDED]
```

## Best Practices

1. **Run After Each Task** - Don't batch verification
2. **Be Objective** - Apply same standards to all code
3. **Document Findings** - Save verification reports
4. **Fix Critical Issues** - Security and correctness issues must be fixed
5. **Balance Pragmatism** - Not every warning needs fixing immediately

## Benefits

- Catches issues before code review
- Ensures consistent quality
- Reduces technical debt
- Improves security
- Documents quality checks performed
