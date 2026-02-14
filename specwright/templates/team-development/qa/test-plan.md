# Test Plan

> Template for documenting comprehensive test strategy
> Use this template when planning testing for a new feature

## Test Plan Overview

**Feature**: [Feature Name]
**Created By**: qa-specialist
**Date**: [Date]
**Version**: 1.0

## Testing Scope

### In Scope

- [ ] Unit tests (backend services, frontend components)
- [ ] Integration tests (API endpoints, database)
- [ ] E2E tests (critical user flows)
- [ ] Performance tests (if applicable)
- [ ] Security tests (if applicable)
- [ ] Accessibility tests (WCAG compliance)

### Out of Scope

- [ ] [Item 1, e.g., Load testing with 10,000+ concurrent users]
- [ ] [Item 2, e.g., Penetration testing]
- [ ] [Item 3, e.g., Localization testing]

---

## Testing Pyramid Strategy

```
         /\
        /E2E\        ← 5-10 tests (critical flows)
       /------\
      /Integr.\     ← 20-30 tests (all API endpoints)
     /----------\
    /   Unit     \  ← 100+ tests (all functions/components)
   /--------------\
```

**Distribution**:
- **Unit Tests**: 70% of total tests (fast, thorough coverage)
- **Integration Tests**: 20% of total tests (API contracts, data flow)
- **E2E Tests**: 10% of total tests (user journeys, critical paths)

---

## Unit Tests

### Backend Unit Tests

**Framework**: JUnit 5 + Mockito (Java) / Jest (Node.js)

**Target**: ≥80% code coverage

**Test Categories**:

#### Service Layer Tests

| Test Case | Purpose | Expected Result |
|-----------|---------|-----------------|
| getAllResources_ReturnsAllItems | Verify method returns all items | Returns list of all resources |
| getResourceById_ExistingId_ReturnsResource | Verify retrieval by ID | Returns matching resource |
| getResourceById_NonExistingId_ThrowsException | Test error handling | Throws ResourceNotFoundException |
| createResource_ValidData_CreatesSuccessfully | Test creation | Resource saved to database |
| createResource_DuplicateField_ThrowsException | Test business rule | Throws DuplicateFieldException |
| updateResource_ExistingId_UpdatesSuccessfully | Test update | Resource updated in database |
| deleteResource_ExistingId_DeletesSuccessfully | Test deletion | Resource removed from database |

**Example Test Case**:
```java
@Test
void getResourceById_ExistingId_ReturnsResource() {
  // Arrange
  Long resourceId = 1L;
  Resource resource = new Resource();
  resource.setId(resourceId);
  when(repository.findById(resourceId)).thenReturn(Optional.of(resource));

  // Act
  ResourceDTO result = service.getResourceById(resourceId);

  // Assert
  assertNotNull(result);
  assertEquals(resourceId, result.id());
}
```

### Frontend Unit Tests

**Framework**: Jest + React Testing Library (React) / Jasmine/Jest (Angular)

**Target**: ≥80% component coverage

**Test Categories**:

#### Component Tests

| Test Case | Purpose | Expected Result |
|-----------|---------|-----------------|
| renders_WithProps_DisplaysCorrectly | Verify rendering | Component displays with props |
| showsLoadingState_WhenDataLoading | Test loading UI | Loading indicator shown |
| showsErrorState_WhenApiFails | Test error handling | Error message displayed |
| showsEmptyState_WhenNoData | Test empty state | Empty message shown |
| callsCallback_WhenUserInteracts | Test user events | Callback invoked with correct params |
| filtersData_WhenSearchTermEntered | Test filtering logic | Filtered results displayed |

**Example Test Case**:
```typescript
it('calls onUserSelect when user clicked', async () => {
  const mockUsers = [{ id: 1, name: 'Alice' }];
  const handleSelect = jest.fn();

  render(<UserList users={mockUsers} onUserSelect={handleSelect} />);

  await userEvent.click(screen.getByText('Alice'));

  expect(handleSelect).toHaveBeenCalledWith(mockUsers[0]);
});
```

---

## Integration Tests

### API Integration Tests

**Framework**: Spring Test + TestContainers (Java) / Supertest (Node.js)

**Target**: Test all API endpoints

**Test Categories**:

#### CRUD Endpoint Tests

| Endpoint | Test Case | Request | Expected Response | Status Code |
|----------|-----------|---------|-------------------|-------------|
| GET /api/resources | Get all resources | - | List of resources | 200 |
| GET /api/resources/{id} | Get existing resource | id=1 | Resource object | 200 |
| GET /api/resources/{id} | Get non-existing resource | id=999 | Error response | 404 |
| POST /api/resources | Create with valid data | Valid request body | Created resource | 201 |
| POST /api/resources | Create with invalid data | Invalid email | Validation error | 400 |
| POST /api/resources | Create duplicate | Existing email | Duplicate error | 409 |
| PUT /api/resources/{id} | Update existing resource | id=1, valid data | Updated resource | 200 |
| PUT /api/resources/{id} | Update non-existing resource | id=999 | Error response | 404 |
| DELETE /api/resources/{id} | Delete existing resource | id=1 | - | 204 |
| DELETE /api/resources/{id} | Delete non-existing resource | id=999 | Error response | 404 |

**Example Test Case**:
```java
@Test
void createResource_ValidData_Returns201() {
  // Arrange
  ResourceCreateRequest request = new ResourceCreateRequest("value1", "value2");

  // Act
  ResponseEntity<ResourceDTO> response = restTemplate.postForEntity(
    "/api/resources",
    request,
    ResourceDTO.class
  );

  // Assert
  assertEquals(HttpStatus.CREATED, response.getStatusCode());
  assertNotNull(response.getBody());
  assertEquals("value1", response.getBody().field1());
}
```

### Database Integration Tests

| Test Case | Purpose | Expected Result |
|-----------|---------|-----------------|
| saveEntity_ValidData_PersistedToDatabase | Test persistence | Entity saved and retrievable |
| findByUniqueField_ExistingValue_ReturnsEntity | Test custom queries | Entity found by unique field |
| updateEntity_ExistingEntity_UpdatesInDatabase | Test updates | Changes persisted |
| deleteEntity_ExistingEntity_RemovedFromDatabase | Test deletion | Entity no longer exists |
| customQuery_ReturnsExpectedResults | Test custom @Query methods | Correct data returned |

---

## End-to-End (E2E) Tests

**Framework**: Playwright (preferred) / Cypress

**Target**: 5-10 critical user flows

**Browser Coverage**:
- Chrome (primary)
- Firefox
- Safari (WebKit)

### Critical User Flows

#### Flow 1: User CRUD Operations

**Scenario**: Complete user lifecycle (create, read, update, delete)

**Preconditions**:
- Application running
- Database seeded with test data
- User authenticated (if auth required)

**Test Steps**:
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to /users | User list page loads |
| 2 | Click "Add User" button | Create form opens |
| 3 | Fill email: "test@example.com" | Email input populated |
| 4 | Fill name: "Test User" | Name input populated |
| 5 | Click "Save" button | Form submits |
| 6 | Wait for redirect | Navigates to user list |
| 7 | Verify new user in list | "Test User" visible |
| 8 | Click on "Test User" | Detail page opens |
| 9 | Click "Edit" button | Edit form opens |
| 10 | Change name to "Updated User" | Name input updated |
| 11 | Click "Save" button | Update submits |
| 12 | Verify name changed | "Updated User" visible |
| 13 | Click "Delete" button | Confirmation dialog opens |
| 14 | Click "Confirm" | Delete executes |
| 15 | Verify user removed | "Updated User" not in list |

**Expected Result**: User successfully created, viewed, updated, and deleted

**Playwright Example**:
```typescript
test('complete user CRUD flow', async ({ page }) => {
  // Create
  await page.goto('/users');
  await page.click('text=Add User');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="name"]', 'Test User');
  await page.click('button:has-text("Save")');

  // Verify creation
  await expect(page.locator('text=Test User')).toBeVisible();

  // Update
  await page.click('text=Test User');
  await page.click('text=Edit');
  await page.fill('[name="name"]', 'Updated User');
  await page.click('button:has-text("Save")');

  // Verify update
  await expect(page.locator('text=Updated User')).toBeVisible();

  // Delete
  await page.click('button:has-text("Delete")');
  await page.click('button:has-text("Confirm")');

  // Verify deletion
  await expect(page.locator('text=Updated User')).not.toBeVisible();
});
```

---

#### Flow 2: Search and Filter

**Scenario**: User searches for specific items

**Test Steps**:
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to /users | User list shows all users (20 items) |
| 2 | Type "Alice" in search input | Search input populated |
| 3 | Wait 300ms (debounce) | Search executes |
| 4 | Verify results | Only users with "Alice" shown |
| 5 | Clear search input | Search cleared |
| 6 | Verify results | All users shown again |

**Playwright Example**:
```typescript
test('search filters users', async ({ page }) => {
  await page.goto('/users');

  // Initial count
  await expect(page.locator('.user-card')).toHaveCount(20);

  // Search
  await page.fill('[placeholder="Search users..."]', 'Alice');
  await page.waitForTimeout(300); // Debounce

  // Filtered results
  await expect(page.locator('text=Alice')).toBeVisible();
  await expect(page.locator('.user-card')).toHaveCount(1);

  // Clear search
  await page.fill('[placeholder="Search users..."]', '');
  await page.waitForTimeout(300);

  // All results again
  await expect(page.locator('.user-card')).toHaveCount(20);
});
```

---

#### Flow 3: Form Validation

**Scenario**: Test client-side validation rules

**Test Steps**:
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to /users | User list loads |
| 2 | Click "Add User" | Form opens |
| 3 | Click "Save" (empty form) | Validation errors shown |
| 4 | Verify errors | "Email is required", "Name is required" |
| 5 | Enter invalid email: "not-an-email" | Email validation error |
| 6 | Verify error | "Email must be valid" |
| 7 | Enter valid email: "test@example.com" | Email error clears |
| 8 | Enter short name: "A" | Name validation error |
| 9 | Verify error | "Name must be at least 2 characters" |
| 10 | Enter valid name: "Alice" | Name error clears |
| 11 | Click "Save" | Form submits successfully |

---

#### Flow 4: Pagination

**Scenario**: Navigate through paginated results

**Test Steps**:
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to /users | Page 1 displayed |
| 2 | Verify pagination | "Page 1 of 5" shown |
| 3 | Click "Next" button | Page 2 loads |
| 4 | Verify URL | /users?page=2 |
| 5 | Verify different data | New set of users shown |
| 6 | Click "Previous" button | Page 1 loads |
| 7 | Verify URL | /users?page=1 |
| 8 | Verify original data | Original users shown |

---

#### Flow 5: Error Handling

**Scenario**: Test error recovery

**Test Steps**:
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Stop backend server | Backend unavailable |
| 2 | Navigate to /users | Page attempts to load |
| 3 | Wait for timeout | Error message shown |
| 4 | Verify error | "Failed to load users" |
| 5 | Verify retry button | "Retry" button visible |
| 6 | Start backend server | Backend available |
| 7 | Click "Retry" button | Data loads successfully |
| 8 | Verify success | Users displayed |

---

## Performance Tests (If Applicable)

### Load Time Tests

| Page | Target Load Time | Acceptable Range |
|------|------------------|------------------|
| /users | < 1s | 0.5s - 1.5s |
| /users/:id | < 500ms | 200ms - 800ms |

### API Performance Tests

| Endpoint | Target Response Time | Acceptable Range |
|----------|---------------------|------------------|
| GET /api/users | < 200ms | 100ms - 300ms |
| POST /api/users | < 300ms | 200ms - 500ms |

**Tools**: JMeter, k6, or Lighthouse

---

## Accessibility Tests

### WCAG 2.1 AA Compliance

**Test Categories**:

| Test | Requirement | Tool |
|------|-------------|------|
| Keyboard navigation | All interactions possible via keyboard | Manual testing |
| Screen reader | All content accessible to screen readers | NVDA/JAWS |
| Color contrast | Contrast ratio ≥4.5:1 | Lighthouse |
| Focus indicators | Visible focus states on all interactive elements | Manual testing |
| Alt text | All images have descriptive alt text | axe DevTools |
| ARIA attributes | Proper ARIA labels where needed | axe DevTools |
| Semantic HTML | Use of semantic elements (header, nav, main) | Manual testing |

**Tools**:
- axe DevTools (browser extension)
- Lighthouse (Chrome DevTools)
- WAVE (Web Accessibility Evaluation Tool)
- NVDA/JAWS (screen readers)

---

## Test Execution Schedule

| Phase | Tests | Duration | Responsible |
|-------|-------|----------|-------------|
| Unit Testing | Backend + Frontend | 2-3 hours | Automated (CI) |
| Integration Testing | API endpoints | 1-2 hours | Automated (CI) |
| E2E Testing | Critical flows | 2-3 hours | Automated (CI) |
| Manual Testing | Exploratory, edge cases | 4-6 hours | QA specialist |
| Accessibility Testing | WCAG compliance | 2-3 hours | QA specialist |
| Performance Testing | Load time, API response | 1-2 hours | QA specialist |

**Total Estimated Time**: 12-19 hours

---

## Test Environment

### Test Data

**Database Seeding**:
- 50 test users with varied data
- 5 admin users
- 10 users with edge cases (long names, special characters)

**Mock Data**:
- API mocks for frontend development
- Consistent test data across environments

### Environment Setup

**Development**:
- Local database (PostgreSQL)
- Backend: http://localhost:8080
- Frontend: http://localhost:3000
- Use API mocks by default

**Staging**:
- Staging database (separate from production)
- Backend: https://staging-api.myapp.com
- Frontend: https://staging.myapp.com
- Real API integration

**Production**:
- Production database
- Backend: https://api.myapp.com
- Frontend: https://myapp.com
- Real user data

---

## Pass/Fail Criteria

### Unit Tests

**Pass Criteria**:
- ✅ All unit tests pass (0 failures)
- ✅ Code coverage ≥80%
- ✅ No compilation errors
- ✅ No linting errors

**Fail Criteria**:
- ❌ Any unit test fails
- ❌ Code coverage <80%
- ❌ Compilation errors present
- ❌ Linting errors present

### Integration Tests

**Pass Criteria**:
- ✅ All API endpoint tests pass
- ✅ All database integration tests pass
- ✅ All responses match expected format
- ✅ All error cases handled correctly

**Fail Criteria**:
- ❌ Any integration test fails
- ❌ API responses don't match spec
- ❌ Error handling missing

### E2E Tests

**Pass Criteria**:
- ✅ All critical user flows pass
- ✅ Tests pass on Chrome, Firefox, Safari
- ✅ No flaky tests (pass consistently)

**Fail Criteria**:
- ❌ Any critical flow fails
- ❌ Browser incompatibility detected
- ❌ Flaky tests (inconsistent results)

### Accessibility

**Pass Criteria**:
- ✅ WCAG 2.1 AA compliant (axe DevTools)
- ✅ Keyboard navigation works
- ✅ Screen reader compatible
- ✅ Color contrast ≥4.5:1

**Fail Criteria**:
- ❌ WCAG violations detected
- ❌ Keyboard navigation broken
- ❌ Screen reader issues

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Unit tests fail after merge | Medium | High | Run tests in CI before merge |
| E2E tests flaky | Medium | Medium | Use proper wait strategies, retry logic |
| Performance degradation | Low | High | Monitor response times, set thresholds |
| Accessibility regression | Medium | Medium | Automated axe tests in CI |
| Browser compatibility issue | Low | Medium | Test on multiple browsers |

---

## Test Deliverables

**Artifacts**:
- [ ] Unit test suite (≥80% coverage)
- [ ] Integration test suite (all API endpoints)
- [ ] E2E test suite (5-10 critical flows)
- [ ] Test execution report
- [ ] Code coverage report
- [ ] Accessibility audit report
- [ ] Bug reports for any issues found

---

## Implementation Checklist

**Preparation**:
- [ ] Review feature requirements
- [ ] Identify testable units
- [ ] Define test data
- [ ] Setup test environments

**Unit Tests**:
- [ ] Write backend unit tests (services, repositories)
- [ ] Write frontend unit tests (components, hooks)
- [ ] Achieve ≥80% coverage
- [ ] All tests passing

**Integration Tests**:
- [ ] Write API endpoint tests
- [ ] Write database integration tests
- [ ] Test error cases (404, 400, 409)
- [ ] All tests passing

**E2E Tests**:
- [ ] Write tests for critical flows
- [ ] Test on multiple browsers
- [ ] Verify tests are stable (not flaky)
- [ ] All tests passing

**Quality Verification**:
- [ ] Run all tests in CI
- [ ] Verify coverage reports
- [ ] Manual exploratory testing
- [ ] Accessibility audit
- [ ] Performance testing (if applicable)

**Documentation**:
- [ ] Update test plan with results
- [ ] Document any bugs found
- [ ] Create test report
