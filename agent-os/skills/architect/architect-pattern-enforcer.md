---
name: architect-pattern-enforcer
description: Enforces architecture patterns and creates proper folder structures
version: 1.0
---

# Architect Pattern Enforcer

Ensures code follows the defined architecture pattern (Hexagonal, Clean, DDD, Layered) and creates proper folder structures for new features.

## Trigger Conditions

```yaml
task_mentions:
  - "new feature|create feature|implement feature"
  - "architecture|structure|organize"
  - "hexagonal|clean architecture|ddd|layered"
file_extension:
  - .md  # When reading architecture-decision.md
always_active_for_agents:
  - architecture-agent
```

## When to Load

- Feature initialization (before development starts)
- New module creation
- Architecture compliance checks
- Code reviews

## Core Competencies

### Architecture Patterns

#### Hexagonal Architecture (Ports & Adapters)
```
domain/           # Core business logic (no external dependencies)
  ├── entities/   # Domain entities
  ├── value-objects/
  ├── services/   # Domain services
  └── ports/      # Interfaces (repository, external)

application/      # Use cases, orchestration
  ├── use-cases/
  ├── commands/
  └── queries/

infrastructure/   # Adapters (implements ports)
  ├── persistence/
  ├── external/
  └── messaging/

presentation/     # API, UI
  ├── rest/
  ├── graphql/
  └── websocket/
```

#### Clean Architecture
```
entities/         # Enterprise business rules
use-cases/        # Application business rules
interface-adapters/  # Controllers, presenters, gateways
frameworks/       # External frameworks, tools
```

#### Domain-Driven Design (DDD)
```
bounded-contexts/
  └── [context]/
      ├── domain/
      │   ├── aggregates/
      │   ├── entities/
      │   ├── value-objects/
      │   └── domain-events/
      ├── application/
      └── infrastructure/
```

## Best Practices

### Folder Creation
1. Always read architecture-decision.md first
2. Create complete folder structure before implementation
3. Include placeholder files (__init__.py, index.ts)
4. Add README.md in each major folder

### Dependency Rules
1. Domain layer has NO external dependencies
2. Application layer depends only on Domain
3. Infrastructure implements Domain interfaces
4. Presentation calls Application layer

### File Placement
| File Type | Hexagonal | Clean | DDD |
|-----------|-----------|-------|-----|
| Entity | domain/entities/ | entities/ | domain/aggregates/ |
| Use Case | application/use-cases/ | use-cases/ | application/services/ |
| Repository Interface | domain/ports/ | use-cases/ | domain/repositories/ |
| Repository Impl | infrastructure/persistence/ | frameworks/ | infrastructure/persistence/ |
| Controller | presentation/rest/ | interface-adapters/ | presentation/api/ |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Domain imports Infrastructure | Violates dependency rule | Use dependency injection |
| Business logic in Controller | Mixing concerns | Move to Use Case |
| Entity with DB annotations | Domain coupled to ORM | Use separate DB models |
| Cross-bounded context imports | Context coupling | Use events or API calls |

## Checklist

### Before Feature Implementation
- [ ] Read architecture-decision.md
- [ ] Identify affected bounded context (if DDD)
- [ ] Create folder structure
- [ ] Define interfaces/ports first
- [ ] Create placeholder files

### During Code Review
- [ ] No dependency rule violations
- [ ] Files in correct folders
- [ ] Interfaces defined before implementations
- [ ] No business logic in infrastructure

## Examples

### Creating New Feature Structure
```bash
# For Hexagonal Architecture
feature-name/
├── domain/
│   ├── entities/
│   │   └── FeatureEntity.ts
│   └── ports/
│       └── FeatureRepository.ts  # Interface
├── application/
│   └── use-cases/
│       ├── CreateFeatureUseCase.ts
│       └── GetFeatureUseCase.ts
├── infrastructure/
│   └── persistence/
│       └── FeatureRepositoryImpl.ts
└── presentation/
    └── rest/
        └── FeatureController.ts
```

## Integration

### Works With
- architect-api-designer (API contracts)
- architect-data-modeler (database schemas)
- architect-dependency-checker (import validation)

### References
- architecture-decision.md
- architecture-structure.md
