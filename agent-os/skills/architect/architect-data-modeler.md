---
name: architect-data-modeler
description: Designs database schemas and data models with performance optimization
version: 1.0
---

# Architect Data Modeler

Focuses on data persistence layer, database schemas, entity relationships, and ensures clean separation between domain entities and database models.

## Trigger Conditions

```yaml
task_mentions:
  - "database|schema|migration"
  - "entity|model|table"
  - "relationship|foreign key|index"
  - "data model|er diagram"
file_extension:
  - .sql
  - .prisma
file_contains:
  - "CREATE TABLE"
  - "@Entity"
  - "model "
always_active_for_agents:
  - architecture-agent
```

## When to Load

- Feature requires data storage
- Database schema changes
- Performance optimization
- Migration planning

## Core Competencies

### Entity-Relationship Design

```
┌──────────────┐       ┌──────────────┐
│    User      │       │    Order     │
├──────────────┤       ├──────────────┤
│ id (PK)      │───┐   │ id (PK)      │
│ email        │   │   │ user_id (FK) │◄──┘
│ name         │   │   │ status       │
│ created_at   │   └──►│ total        │
└──────────────┘       │ created_at   │
                       └──────────────┘
                              │
                              │ 1:N
                              ▼
                       ┌──────────────┐
                       │  OrderItem   │
                       ├──────────────┤
                       │ id (PK)      │
                       │ order_id (FK)│
                       │ product_id   │
                       │ quantity     │
                       │ price        │
                       └──────────────┘
```

### Normalization Rules

| Normal Form | Rule | Example Violation |
|-------------|------|-------------------|
| 1NF | Atomic values, no repeating groups | tags: "a,b,c" in single column |
| 2NF | No partial dependencies | order_item.product_name (depends on product_id, not full PK) |
| 3NF | No transitive dependencies | order.customer_address (depends on customer, not order) |

### Domain vs Database Models

```typescript
// Domain Entity (Clean, no DB annotations)
class User {
  readonly id: UserId;
  readonly email: Email;  // Value Object
  private name: string;

  changeName(newName: string): void {
    // Business logic
  }
}

// Database Model (Infrastructure)
@Entity('users')
class UserEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  email: string;

  @Column()
  name: string;

  @CreateDateColumn()
  created_at: Date;
}

// Mapper (Infrastructure)
class UserMapper {
  toDomain(entity: UserEntity): User { ... }
  toPersistence(user: User): UserEntity { ... }
}
```

## Best Practices

### Schema Design
1. Use UUIDs or ULIDs for primary keys (not auto-increment for distributed systems)
2. Always include created_at, updated_at
3. Use soft deletes (deleted_at) for important data
4. Keep domain entities separate from DB models
5. Use migrations for all schema changes

### Indexing Strategy
```sql
-- Primary key (automatic)
-- Foreign keys
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Frequently queried columns
CREATE INDEX idx_orders_status ON orders(status);

-- Composite for common query patterns
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

-- Partial index for active records
CREATE INDEX idx_active_users ON users(email) WHERE deleted_at IS NULL;
```

### Performance Patterns

| Pattern | Use Case | Implementation |
|---------|----------|----------------|
| Denormalization | Read-heavy, complex joins | Store calculated fields |
| Materialized Views | Reporting, dashboards | CREATE MATERIALIZED VIEW |
| Partitioning | Large tables, time-series | PARTITION BY RANGE |
| Sharding | Horizontal scaling | By tenant_id or region |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| ORM annotations in domain | Coupling | Separate DB models |
| Missing indexes on FKs | Slow joins | Always index FKs |
| Over-normalization | Too many joins | Strategic denormalization |
| No migration versioning | Schema drift | Use migration tools |
| Storing JSON blobs | Unqueryable | Proper columns or document DB |

## Migration Strategy

### Migration Best Practices
```sql
-- migrations/20240101120000_create_users.sql

-- UP
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email) WHERE deleted_at IS NULL;

-- DOWN
DROP TABLE users;
```

### Zero-Downtime Migrations
1. Add new column (nullable)
2. Deploy code that writes to both
3. Backfill old data
4. Make column NOT NULL
5. Deploy code that only uses new column
6. Drop old column

## Checklist

### Schema Design
- [ ] Primary keys defined (UUID recommended)
- [ ] Foreign keys with proper indexes
- [ ] created_at, updated_at included
- [ ] Soft delete if needed
- [ ] Appropriate normalization level
- [ ] Performance indexes planned

### Domain Separation
- [ ] Domain entities have no DB annotations
- [ ] Separate DB models in infrastructure
- [ ] Mappers for conversion
- [ ] Repository interface in domain

## Integration

### Works With
- architect-pattern-enforcer (folder structure)
- persistence-adapter (implementation)
- test-engineer (test data)

### Output
- ER diagrams
- Migration files
- Index definitions
- Domain entity interfaces
