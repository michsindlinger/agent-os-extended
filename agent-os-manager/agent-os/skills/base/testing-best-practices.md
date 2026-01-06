---
name: Testing Best Practices
description: Comprehensive testing patterns for unit, integration, and E2E tests across all tech stacks
triggers:
  - task_mentions: "test|spec|coverage|e2e|integration|unit|testing"
  - file_contains: "@Test|describe\\(|it\\(|test\\("
  - file_extension: .test.ts|.test.tsx|.spec.ts|Test.java|.test.js
---

# Testing Best Practices

Apply proven testing patterns for unit, integration, and E2E tests to ensure code quality and catch bugs early.

## 1. Unit Test Patterns

### AAA Pattern (Arrange-Act-Assert)

**Structure**:
```
Arrange: Set up test data and dependencies
Act: Execute the code under test
Assert: Verify the outcome
```

**Java (JUnit 5) Example**:
```java
@Test
void createUser_WithValidData_ReturnsCreatedUser() {
    // Arrange
    UserCreateRequest request = new UserCreateRequest("John Doe", "john@example.com");
    User expectedUser = new User(1L, "John Doe", "john@example.com");
    when(userRepository.save(any(User.class))).thenReturn(expectedUser);

    // Act
    User result = userService.createUser(request);

    // Assert
    assertThat(result.getName()).isEqualTo("John Doe");
    assertThat(result.getEmail()).isEqualTo("john@example.com");
    verify(userRepository).save(any(User.class));
}
```

**TypeScript (Jest) Example**:
```typescript
describe('UserService', () => {
  it('should create user with valid data', async () => {
    // Arrange
    const request = { name: 'John Doe', email: 'john@example.com' };
    const expectedUser = { id: 1, ...request };
    mockApi.post.mockResolvedValue({ data: expectedUser });

    // Act
    const result = await UserService.createUser(request);

    // Assert
    expect(result).toEqual(expectedUser);
    expect(mockApi.post).toHaveBeenCalledWith('/api/users', request);
  });
});
```

### Given-When-Then (BDD Style)

**Pattern**: Behavior-Driven Development naming

**Java Example**:
```java
@Test
void givenValidUser_whenCreating_thenUserIsSaved() {
    // Given
    UserCreateRequest request = new UserCreateRequest("Jane", "jane@example.com");

    // When
    User user = userService.createUser(request);

    // Then
    assertThat(user).isNotNull();
    assertThat(user.getId()).isPositive();
    verify(userRepository).save(any(User.class));
}
```

**Use When**: BDD approach preferred, tests as documentation

### Test Isolation (No Shared State)

**Problem**: Tests depend on each other = flaky tests

**Bad Example**:
```java
// ❌ Shared state between tests
private static User testUser;

@Test
void test1_createUser() {
    testUser = userService.createUser(...);  // Sets shared state
}

@Test
void test2_findUser() {
    User found = userService.findById(testUser.getId());  // Depends on test1
}
```

**Good Example**:
```java
// ✅ Each test independent
@Test
void createUser_ShouldSaveToDatabase() {
    User user = userService.createUser(new UserCreateRequest("John", "john@example.com"));
    assertThat(user.getId()).isNotNull();
}

@Test
void findUser_WithValidId_ReturnsUser() {
    User user = userService.createUser(new UserCreateRequest("Jane", "jane@example.com"));
    User found = userService.findById(user.getId());
    assertThat(found).isEqualTo(user);
}
```

**Rules**:
- ✅ Each test creates own data (@BeforeEach or in test)
- ✅ Each test cleans up (@AfterEach or transaction rollback)
- ✅ Tests run in any order
- ✅ Tests can run in parallel

### Mocking Strategies

**When to Mock**:
- ✅ External dependencies (databases, APIs, file system)
- ✅ Slow operations (network calls, complex calculations)
- ✅ Non-deterministic behavior (current time, random values)

**When NOT to Mock**:
- ❌ Simple POJOs/DTOs (use real objects)
- ❌ Logic under test (defeats the purpose)
- ❌ Everything (integration tests need some real components)

**Java (Mockito) Example**:
```java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserService userService;

    @Test
    void createUser_CallsRepository() {
        // Arrange
        UserCreateRequest request = new UserCreateRequest("John", "john@example.com");
        User savedUser = new User(1L, "John", "john@example.com");
        when(userRepository.save(any(User.class))).thenReturn(savedUser);

        // Act
        User result = userService.createUser(request);

        // Assert
        verify(userRepository).save(argThat(user ->
            user.getName().equals("John") &&
            user.getEmail().equals("john@example.com")
        ));
    }
}
```

**TypeScript (Jest) Example**:
```typescript
// UserService.test.ts
jest.mock('../api/UserApi');

describe('UserService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should fetch users from API', async () => {
    const mockUsers = [{ id: 1, name: 'John' }];
    (UserApi.getUsers as jest.Mock).mockResolvedValue(mockUsers);

    const users = await UserService.getUsers();

    expect(users).toEqual(mockUsers);
    expect(UserApi.getUsers).toHaveBeenCalledTimes(1);
  });
});
```

### Parameterized Tests (Test Multiple Scenarios)

**Java (JUnit 5 @ParameterizedTest)**:
```java
@ParameterizedTest
@CsvSource({
    "john@example.com, true",
    "invalid-email, false",
    "missing@, false",
    "@example.com, false"
})
void validateEmail_WithVariousInputs(String email, boolean expected) {
    boolean result = ValidationUtils.isValidEmail(email);
    assertThat(result).isEqualTo(expected);
}
```

**TypeScript (Jest test.each)**:
```typescript
describe('validateEmail', () => {
  test.each([
    ['john@example.com', true],
    ['invalid-email', false],
    ['missing@', false],
    ['@example.com', false]
  ])('should validate %s as %s', (email, expected) => {
    expect(validateEmail(email)).toBe(expected);
  });
});
```

**Use When**: Testing multiple inputs for same logic

---

## 2. Integration Test Strategies

### TestContainers for Database (Java)

**Purpose**: Real database in tests (not H2 in-memory)

**Setup**:
```java
@Testcontainers
@SpringBootTest
class UserRepositoryIntegrationTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:15")
        .withDatabaseName("testdb")
        .withUsername("test")
        .withPassword("test");

    @DynamicPropertySource
    static void setProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Autowired
    private UserRepository userRepository;

    @Test
    void saveUser_ShouldPersistToDatabase() {
        User user = new User(null, "John", "john@example.com");

        User saved = userRepository.save(user);

        assertThat(saved.getId()).isNotNull();
        assertThat(userRepository.findById(saved.getId())).isPresent();
    }
}
```

**Benefits**:
- Real PostgreSQL (catches DB-specific issues)
- Test migrations
- Isolated (container destroyed after tests)

### API Integration Tests (Full Request-Response)

**Java (Spring MockMvc)**:
```java
@SpringBootTest
@AutoConfigureMockMvc
class UserControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private UserRepository userRepository;

    @Test
    void createUser_WithValidRequest_Returns201() throws Exception {
        String requestBody = """
            {
              "name": "John Doe",
              "email": "john@example.com"
            }
            """;

        mockMvc.perform(post("/api/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestBody))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.id").exists())
            .andExpect(jsonPath("$.name").value("John Doe"))
            .andExpect(jsonPath("$.email").value("john@example.com"));

        assertThat(userRepository.count()).isEqualTo(1);
    }

    @Test
    void createUser_WithInvalidEmail_Returns400() throws Exception {
        String requestBody = """
            {
              "name": "John",
              "email": "invalid-email"
            }
            """;

        mockMvc.perform(post("/api/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestBody))
            .andExpect(status().isBadRequest())
            .andExpect(jsonPath("$.error").exists());
    }
}
```

### Mock Service Worker for Frontend API Testing

**Setup** (React + MSW):
```typescript
// src/mocks/handlers.ts
import { rest } from 'msw';

export const handlers = [
  rest.get('/api/users', (req, res, ctx) => {
    return res(
      ctx.status(200),
      ctx.json([
        { id: 1, name: 'John Doe', email: 'john@example.com' },
        { id: 2, name: 'Jane Smith', email: 'jane@example.com' }
      ])
    );
  }),

  rest.post('/api/users', async (req, res, ctx) => {
    const body = await req.json();
    return res(
      ctx.status(201),
      ctx.json({ id: 3, ...body })
    );
  })
];

// src/mocks/server.ts
import { setupServer } from 'msw/node';
import { handlers } from './handlers';

export const server = setupServer(...handlers);

// src/setupTests.ts
import { server } from './mocks/server';

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

**Component Test Using MSW**:
```typescript
// UserList.test.tsx
import { render, screen, waitFor } from '@testing-library/react';
import { UserList } from './UserList';

test('renders user list from API', async () => {
  render(<UserList />);

  // MSW intercepts fetch, returns mock data
  await waitFor(() => {
    expect(screen.getByText('John Doe')).toBeInTheDocument();
    expect(screen.getByText('Jane Smith')).toBeInTheDocument();
  });
});
```

---

## 3. E2E Test Best Practices

### Page Object Pattern (Maintainable Selectors)

**Purpose**: Centralize selectors, reduce duplication

**Bad Example** (selectors scattered):
```typescript
// ❌ Multiple tests repeat selectors
test('login', async () => {
  await page.fill('input[name="email"]', 'user@example.com');
  await page.fill('input[name="password"]', 'password123');
  await page.click('button[type="submit"]');
});

test('login with invalid', async () => {
  await page.fill('input[name="email"]', 'invalid');
  await page.fill('input[name="password"]', 'short');
  await page.click('button[type="submit"]');
});
```

**Good Example** (Page Object):
```typescript
// pages/LoginPage.ts
export class LoginPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/login');
  }

  async fillEmail(email: string) {
    await this.page.fill('[data-testid="email-input"]', email);
  }

  async fillPassword(password: string) {
    await this.page.fill('[data-testid="password-input"]', password);
  }

  async submit() {
    await this.page.click('[data-testid="login-submit"]');
  }

  async login(email: string, password: string) {
    await this.fillEmail(email);
    await this.fillPassword(password);
    await this.submit();
  }

  async getErrorMessage() {
    return this.page.textContent('[data-testid="error-message"]');
  }
}

// tests/login.spec.ts
import { LoginPage } from '../pages/LoginPage';

test('successful login', async ({ page }) => {
  const loginPage = new LoginPage(page);
  await loginPage.goto();
  await loginPage.login('user@example.com', 'password123');

  await expect(page).toHaveURL('/dashboard');
});

test('login with invalid email', async ({ page }) => {
  const loginPage = new LoginPage(page);
  await loginPage.goto();
  await loginPage.login('invalid', 'password123');

  const error = await loginPage.getErrorMessage();
  expect(error).toContain('Invalid email');
});
```

**Benefits**:
- Change selector once → all tests updated
- Reusable methods
- Self-documenting (login.fillEmail() vs. fill('input[name=email]'))

### Wait Strategies (Avoid Flaky Tests)

**The Problem**: Element not ready when test tries to interact

**Bad Example** (hard-coded waits):
```typescript
// ❌ Flaky - might be too short or too long
await page.click('button');
await page.waitForTimeout(3000);  // Fixed 3 second wait
await expect(page.locator('.result')).toBeVisible();
```

**Good Example** (smart waits):
```typescript
// ✅ Wait for specific condition
await page.click('button');
await page.waitForSelector('.result', { state: 'visible' });
await expect(page.locator('.result')).toHaveText('Success');

// Or use Playwright auto-waiting
await page.click('button');
await expect(page.locator('.result')).toBeVisible();  // Auto-waits up to 30s
```

**Playwright Auto-Waiting** (built-in):
```typescript
// These automatically wait:
await page.click('button');  // Waits for button to be visible, enabled
await page.fill('input', 'text');  // Waits for input to be editable
await expect(page.locator('.element')).toBeVisible();  // Waits for element
```

**Custom Wait Functions**:
```typescript
async function waitForApiCall(page: Page, url: string) {
  return page.waitForResponse(resp => resp.url().includes(url) && resp.status() === 200);
}

// Usage
await page.click('[data-testid="load-users"]');
await waitForApiCall(page, '/api/users');
await expect(page.locator('.user-list')).toBeVisible();
```

### Test Data Management (Setup/Teardown)

**Database Seeding for E2E**:
```typescript
// tests/helpers/db.ts
export async function seedDatabase() {
  await db.users.create({ name: 'Test User', email: 'test@example.com' });
  await db.products.create({ name: 'Test Product', price: 100 });
}

export async function cleanDatabase() {
  await db.users.deleteMany();
  await db.products.deleteMany();
}

// tests/users.spec.ts
import { seedDatabase, cleanDatabase } from './helpers/db';

test.beforeEach(async () => {
  await seedDatabase();
});

test.afterEach(async () => {
  await cleanDatabase();
});

test('user list shows seeded users', async ({ page }) => {
  await page.goto('/users');
  await expect(page.locator('.user-item')).toHaveCount(1);
  await expect(page.locator('.user-item')).toContainText('Test User');
});
```

### Critical User Flows Only (Not Every Edge Case)

**E2E Tests Are Slow**: Test critical paths only

**Priority 1: Happy Paths** (must work):
```
✅ User registration → email confirmation → login → dashboard
✅ Add product to cart → checkout → payment → order confirmation
✅ Create post → publish → view on site
```

**Priority 2: Critical Error Cases**:
```
✅ Login with wrong password → error message shown
✅ Payment fails → user can retry
✅ Form validation errors → user can correct
```

**Skip in E2E** (cover in unit/integration instead):
```
❌ Every validation rule (test in unit tests)
❌ Every error case (test in integration tests)
❌ Edge cases (user clicks 100 times, extreme values)
```

**Rule**: If <5% of users encounter it, don't E2E test it.

### Parallel Execution (Faster Feedback)

**Playwright Configuration**:
```typescript
// playwright.config.ts
export default defineConfig({
  workers: 4,  // Run 4 tests in parallel
  fullyParallel: true,
  retries: 2,  // Retry flaky tests
  timeout: 30000,  // 30 second timeout per test
});
```

**Isolation Between Parallel Tests**:
```typescript
// Each test gets fresh database state
test.beforeEach(async ({ context }) => {
  // Create isolated database for this test
  const dbName = `test_${Date.now()}_${Math.random()}`;
  await createTestDatabase(dbName);
});
```

---

## 4. Coverage Strategies

### What to Test

**Always Test**:
- ✅ Business logic (calculations, validations, workflows)
- ✅ Edge cases (null, empty, boundary values)
- ✅ Error handling (exceptions, error responses)
- ✅ Public APIs (all public methods)
- ✅ Critical paths (core features, payment flows)

**Skip Testing** (low value):
- ❌ Getters/Setters (unless they have logic)
- ❌ Trivial code (one-line delegations)
- ❌ Generated code (mappers, builders from libraries)
- ❌ Configuration classes (no logic)
- ❌ DTOs with no methods

**Example Decision Tree**:
```
Method: public User createUser(UserCreateRequest request)
→ Business logic: Yes (creates user, validation, persistence)
→ Test: ✅ YES (multiple scenarios)

Method: public String getName() { return name; }
→ Business logic: No (simple getter)
→ Test: ❌ SKIP

Method: public void setEmail(String email) {
    if (!email.contains("@")) throw new IllegalArgumentException();
    this.email = email;
}
→ Business logic: Yes (validation)
→ Test: ✅ YES (valid email, invalid email cases)
```

### Coverage Targets

**Overall Target**: 80% line coverage

**By Layer**:
- **Services/Business Logic**: 90%+ (most important)
- **Controllers**: 80% (API contract verification)
- **Repositories**: 70% (basic CRUD, complex queries)
- **Entities/DTOs**: 50% (mostly trivial code)
- **Components**: 80% (React/Angular components)
- **Utilities**: 95% (shared code, high reuse)

**Coverage Reports**:
```bash
# Java (JaCoCo)
mvn test jacoco:report
# Report: target/site/jacoco/index.html

# TypeScript (Jest)
npm test -- --coverage
# Report: coverage/lcov-report/index.html
```

### What to Skip (Don't Chase 100%)

**Framework Code**:
```java
// ❌ Don't test Spring Boot generated code
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);  // Framework code
    }
}
```

**Simple Getters**:
```java
// ❌ Don't test trivial getters
public String getName() { return name; }
public void setName(String name) { this.name = name; }
```

**Third-Party Library Wrappers**:
```typescript
// ❌ Don't test library code
export function formatDate(date: Date): string {
  return format(date, 'yyyy-MM-dd');  // date-fns library handles this
}
```

**Focus**: Test YOUR logic, trust frameworks/libraries.

### Mutation Testing (Advanced)

**Purpose**: Test the tests (are they actually catching bugs?)

**Tool**: PITest (Java), Stryker (JavaScript)

**Example**:
```java
// Original code
if (age >= 18) {
    return "adult";
}

// Mutation: >= changed to >
if (age > 18) {  // Mutant
    return "adult";
}

// If tests still pass with mutant → tests are weak!
```

**When to Use**: Critical business logic, after 80% coverage reached

---

## 5. Test Organization

### Directory Structure (Mirror Source)

**Backend (Java/Maven)**:
```
src/
├── main/java/com/company/app/
│   ├── controller/
│   │   └── UserController.java
│   ├── service/
│   │   └── UserService.java
│   └── repository/
│       └── UserRepository.java
└── test/java/com/company/app/
    ├── controller/
    │   └── UserControllerTest.java  ← Mirrors main
    ├── service/
    │   └── UserServiceTest.java
    └── repository/
        └── UserRepositoryTest.java
```

**Frontend (React/TypeScript)**:
```
src/
├── components/
│   ├── UserList.tsx
│   └── UserList.test.tsx  ← Colocated with component
├── services/
│   ├── UserService.ts
│   └── UserService.test.ts
└── types/
    └── User.ts  (no test needed - pure type)

tests/
└── e2e/
    └── user-management.spec.ts  ← E2E tests separate
```

### Naming Conventions

**Java (JUnit)**:
```
Class: UserService
Test: UserServiceTest

Method: createUser()
Tests:
- createUser_WithValidData_ReturnsUser()
- createUser_WithNullName_ThrowsException()
- createUser_WithDuplicateEmail_ThrowsException()

Pattern: methodName_scenario_expectedBehavior
```

**TypeScript (Jest)**:
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', () => { ... });
    it('should throw error with null name', () => { ... });
    it('should throw error with duplicate email', () => { ... });
  });
});

// Pattern: describe(class/component) → describe(method) → it(scenario)
```

### Test Categorization

**Java (@Tag)**:
```java
@Tag("unit")
class UserServiceTest { ... }

@Tag("integration")
class UserControllerIntegrationTest { ... }

@Tag("slow")
class UserE2ETest { ... }

// Run only unit tests (fast):
mvn test -Dgroups="unit"

// Run all tests:
mvn test
```

**TypeScript (Jest)**:
```typescript
// package.json
{
  "scripts": {
    "test": "jest",
    "test:unit": "jest --testPathPattern=src/.*\\.test\\.tsx?$",
    "test:integration": "jest --testPathPattern=tests/integration",
    "test:e2e": "playwright test"
  }
}
```

---

## Application Checklist

When testing a feature:

**Unit Tests**:
- [ ] All services/business logic tested
- [ ] All public methods covered
- [ ] Edge cases tested (null, empty, boundary values)
- [ ] Error cases tested (exceptions, validations)
- [ ] Mocks used for external dependencies
- [ ] Tests isolated (no shared state)
- [ ] Coverage ≥80% (line coverage)

**Integration Tests**:
- [ ] All API endpoints tested (happy path)
- [ ] Request validation tested (400 errors)
- [ ] Authentication tested (401/403 errors)
- [ ] Database integration tested (if applicable)
- [ ] Full request-response cycle verified

**E2E Tests**:
- [ ] Critical user flows identified (3-5 max)
- [ ] Page Object pattern used
- [ ] Smart waits (no fixed timeouts)
- [ ] Test data managed (setup/teardown)
- [ ] Parallel execution configured
- [ ] Retries configured (for flaky tests)

**Coverage Report**:
- [ ] Generated after test run
- [ ] Reviewed for gaps
- [ ] Critical paths at 90%+
- [ ] Overall at 80%+

---

## Common Testing Mistakes to Avoid

❌ **Testing Implementation Details**:
```typescript
// Bad: Tests internal state
expect(component.state.count).toBe(5);

// Good: Tests behavior
expect(screen.getByText('Count: 5')).toBeInTheDocument();
```

❌ **Brittle Selectors**:
```typescript
// Bad: Breaks if styling changes
await page.click('.btn.btn-primary.mt-3');

// Good: Stable data-testid
await page.click('[data-testid="submit-button"]');
```

❌ **Testing Too Much in One Test**:
```java
// Bad: Tests create, update, delete, list in one test (300 lines)
@Test
void userCRUD() { ... }

// Good: One behavior per test
@Test void createUser_SavesUser() { ... }
@Test void updateUser_UpdatesFields() { ... }
@Test void deleteUser_RemovesFromDatabase() { ... }
```

❌ **Mocking Everything**:
```java
// Bad: Mocks own class
@Mock UserService userService;  // Testing UserService, why mock it?

// Good: Mock dependencies only
@Mock UserRepository userRepository;  // External dependency
@InjectMocks UserService userService;  // Real service under test
```

❌ **No Assertions**:
```java
// Bad: Test runs but doesn't verify anything
@Test
void createUser() {
    userService.createUser(new UserCreateRequest("John", "john@example.com"));
    // No assertions! Test always passes
}

// Good: Verify behavior
@Test
void createUser_SavesUser() {
    User user = userService.createUser(new UserCreateRequest("John", "john@example.com"));
    assertThat(user.getId()).isNotNull();
    verify(userRepository).save(any(User.class));
}
```

---

**Use this skill when**: Writing tests, analyzing test failures, or ensuring code quality through comprehensive testing strategies.
