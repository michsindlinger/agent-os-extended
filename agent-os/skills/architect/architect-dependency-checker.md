---
name: architect-dependency-checker
description: Validates dependency directions and prevents architecture violations
version: 1.0
---

# Architect Dependency Checker

Analyzes import graphs to ensure dependencies flow in the correct direction. Prevents architecture violations like domain importing infrastructure.

## Trigger Conditions

```yaml
task_mentions:
  - "dependency check|import analysis|dependency injection"
  - "architecture violation|clean architecture"
  - "code review|review"
file_contains:
  - "import "
  - "from "
  - "require("
always_active_for_agents:
  - architecture-agent
```

## When to Load

- Code review (part of Definition of Done)
- After significant refactoring
- Architecture compliance audits
- Before merging feature branches

## Core Competencies

### Dependency Direction Rules

#### Hexagonal/Clean Architecture
```
ALLOWED:
presentation → application → domain
infrastructure → application
infrastructure → domain

FORBIDDEN:
domain → infrastructure ❌
domain → application ❌
domain → presentation ❌
application → infrastructure ❌
application → presentation ❌
```

#### Visual Dependency Flow
```
┌─────────────────────────────────────────────────┐
│                 Presentation                     │
│            (Controllers, Views)                  │
└─────────────────────┬───────────────────────────┘
                      │ depends on
                      ▼
┌─────────────────────────────────────────────────┐
│                 Application                      │
│           (Use Cases, Services)                  │
└─────────────────────┬───────────────────────────┘
                      │ depends on
                      ▼
┌─────────────────────────────────────────────────┐
│                    Domain                        │
│     (Entities, Value Objects, Interfaces)        │
└─────────────────────────────────────────────────┘
                      ▲
                      │ implements
┌─────────────────────┴───────────────────────────┐
│                Infrastructure                    │
│      (Database, External APIs, Messaging)        │
└─────────────────────────────────────────────────┘
```

### Dependency Injection

#### Interface in Domain
```typescript
// domain/ports/UserRepository.ts
interface UserRepository {
  findById(id: UserId): Promise<User | null>;
  save(user: User): Promise<void>;
}
```

#### Implementation in Infrastructure
```typescript
// infrastructure/persistence/PostgresUserRepository.ts
import { UserRepository } from '../../domain/ports/UserRepository';

class PostgresUserRepository implements UserRepository {
  async findById(id: UserId): Promise<User | null> {
    // Implementation
  }
}
```

#### Wiring in Composition Root
```typescript
// main.ts or composition-root.ts
const userRepository = new PostgresUserRepository(db);
const createUserUseCase = new CreateUserUseCase(userRepository);
const userController = new UserController(createUserUseCase);
```

### Import Analysis Patterns

#### TypeScript/JavaScript
```typescript
// Analyze imports
// domain/entities/User.ts
import { Email } from '../value-objects/Email';  // ✅ OK (domain → domain)
import { UserEntity } from '../../infrastructure/persistence/UserEntity';  // ❌ VIOLATION

// application/use-cases/CreateUser.ts
import { User } from '../../domain/entities/User';  // ✅ OK (application → domain)
import { UserRepository } from '../../domain/ports/UserRepository';  // ✅ OK (interface)
```

#### Java/Kotlin
```java
// domain/User.java
package com.example.domain;

import com.example.infrastructure.UserEntity;  // ❌ VIOLATION
import com.example.domain.UserId;  // ✅ OK
```

## Best Practices

### Detection Strategy
1. Parse import statements in all files
2. Categorize files by layer (path-based)
3. Build dependency graph
4. Check against allowed dependencies
5. Report violations with specific file:line

### ESLint Configuration
```javascript
// .eslintrc.js
module.exports = {
  rules: {
    'import/no-restricted-paths': [
      'error',
      {
        zones: [
          // Domain cannot import from infrastructure
          {
            target: './src/domain/**/*',
            from: './src/infrastructure/**/*',
            message: 'Domain cannot depend on Infrastructure'
          },
          // Domain cannot import from application
          {
            target: './src/domain/**/*',
            from: './src/application/**/*',
            message: 'Domain cannot depend on Application'
          },
          // Application cannot import from infrastructure
          {
            target: './src/application/**/*',
            from: './src/infrastructure/**/*',
            message: 'Application cannot depend on Infrastructure'
          }
        ]
      }
    ]
  }
};
```

### ArchUnit (Java)
```java
@AnalyzeClasses(packages = "com.example")
class ArchitectureTest {
  @ArchTest
  static final ArchRule domain_should_not_depend_on_infrastructure =
    noClasses()
      .that().resideInAPackage("..domain..")
      .should().dependOnClassesThat()
      .resideInAPackage("..infrastructure..");
}
```

## Anti-Patterns

| Anti-Pattern | Detection | Solution |
|--------------|-----------|----------|
| Framework leakage | ORM annotations in domain | Separate DB models |
| Circular dependencies | A → B → A | Extract shared interface |
| Package cycles | pkg1 → pkg2 → pkg1 | Restructure or events |
| Anemic domain | Domain only has data | Add behavior to entities |
| Service locator | Runtime dependency lookup | Constructor injection |

## Checklist

### Code Review
- [ ] No domain imports from infrastructure
- [ ] No domain imports from application
- [ ] No application imports from infrastructure
- [ ] All external dependencies injected via interfaces
- [ ] No circular dependencies
- [ ] Framework-specific code in infrastructure only

### Automated Checks
- [ ] ESLint/ArchUnit rules configured
- [ ] CI fails on violations
- [ ] Dependency graph visualized

## Integration

### Works With
- architect-pattern-enforcer (structure)
- git-master (pre-commit hooks)
- test-engineer (architecture tests)

### Output
- Dependency violation report
- Dependency graph visualization
- Suggested refactoring for violations
