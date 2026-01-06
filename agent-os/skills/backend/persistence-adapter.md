---
name: persistence-adapter
description: Implements repositories and data access patterns
version: 1.0
---

# Persistence Adapter

Implements repository interfaces defined in domain layer, handles ORM mapping, and optimizes database queries.

## Trigger Conditions

```yaml
task_mentions:
  - "repository|persistence|database"
  - "query|find|save|delete"
  - "orm|typeorm|prisma|sequelize"
file_extension:
  - .ts
  - .js
  - .java
  - .rb
file_contains:
  - "implements.*Repository"
  - "@Repository"
  - "class.*Repository"
always_active_for_agents:
  - backend-agent
```

## When to Load

- Implementing repository interfaces
- Database query optimization
- Entity-to-model mapping
- Migration implementation

## Core Competencies

### Repository Implementation

```typescript
// infrastructure/persistence/PostgresUserRepository.ts
import { UserRepository } from '../../domain/ports/UserRepository';
import { User } from '../../domain/entities/User';
import { UserId } from '../../domain/value-objects/UserId';
import { UserEntity } from './entities/UserEntity';
import { UserMapper } from './mappers/UserMapper';

export class PostgresUserRepository implements UserRepository {
  constructor(
    private readonly dataSource: DataSource,
    private readonly mapper: UserMapper
  ) {}

  async findById(id: UserId): Promise<User | null> {
    const entity = await this.dataSource
      .getRepository(UserEntity)
      .findOne({ where: { id: id.value } });

    return entity ? this.mapper.toDomain(entity) : null;
  }

  async findByEmail(email: Email): Promise<User | null> {
    const entity = await this.dataSource
      .getRepository(UserEntity)
      .findOne({ where: { email: email.value } });

    return entity ? this.mapper.toDomain(entity) : null;
  }

  async save(user: User): Promise<void> {
    const entity = this.mapper.toPersistence(user);
    await this.dataSource.getRepository(UserEntity).save(entity);
  }

  async delete(id: UserId): Promise<void> {
    await this.dataSource
      .getRepository(UserEntity)
      .softDelete({ id: id.value });
  }
}
```

### Entity Mapping

```typescript
// infrastructure/persistence/mappers/UserMapper.ts
export class UserMapper {
  toDomain(entity: UserEntity): User {
    return User.reconstitute({
      id: UserId.from(entity.id),
      email: Email.from(entity.email),
      name: entity.name,
      status: UserStatus.from(entity.status),
      createdAt: entity.created_at,
      updatedAt: entity.updated_at
    });
  }

  toPersistence(user: User): UserEntity {
    const entity = new UserEntity();
    entity.id = user.id.value;
    entity.email = user.email.value;
    entity.name = user.name;
    entity.status = user.status.value;
    return entity;
  }
}
```

### Database Entity (Separate from Domain)

```typescript
// infrastructure/persistence/entities/UserEntity.ts
@Entity('users')
export class UserEntity {
  @PrimaryColumn('uuid')
  id: string;

  @Column({ unique: true })
  email: string;

  @Column()
  name: string;

  @Column({ type: 'enum', enum: ['active', 'inactive', 'suspended'] })
  status: string;

  @CreateDateColumn({ name: 'created_at' })
  created_at: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updated_at: Date;

  @DeleteDateColumn({ name: 'deleted_at' })
  deleted_at: Date | null;

  @OneToMany(() => OrderEntity, order => order.user)
  orders: OrderEntity[];
}
```

### Query Optimization Patterns

```typescript
// Eager loading to prevent N+1
async findOrdersWithItems(userId: UserId): Promise<Order[]> {
  const entities = await this.dataSource
    .getRepository(OrderEntity)
    .find({
      where: { user_id: userId.value },
      relations: ['items', 'items.product'],
      order: { created_at: 'DESC' }
    });

  return entities.map(e => this.mapper.toDomain(e));
}

// Query builder for complex queries
async findActiveOrdersByDateRange(
  startDate: Date,
  endDate: Date,
  status: OrderStatus[]
): Promise<Order[]> {
  const entities = await this.dataSource
    .getRepository(OrderEntity)
    .createQueryBuilder('order')
    .leftJoinAndSelect('order.items', 'items')
    .where('order.created_at BETWEEN :start AND :end', {
      start: startDate,
      end: endDate
    })
    .andWhere('order.status IN (:...statuses)', {
      statuses: status.map(s => s.value)
    })
    .orderBy('order.created_at', 'DESC')
    .getMany();

  return entities.map(e => this.mapper.toDomain(e));
}

// Pagination
async findPaginated(page: number, limit: number): Promise<PaginatedResult<User>> {
  const [entities, total] = await this.dataSource
    .getRepository(UserEntity)
    .findAndCount({
      skip: (page - 1) * limit,
      take: limit,
      order: { created_at: 'DESC' }
    });

  return {
    data: entities.map(e => this.mapper.toDomain(e)),
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit)
    }
  };
}
```

## Best Practices

### Repository Interface Design

```typescript
// domain/ports/UserRepository.ts
interface UserRepository {
  // Single entity operations
  findById(id: UserId): Promise<User | null>;
  findByEmail(email: Email): Promise<User | null>;
  save(user: User): Promise<void>;
  delete(id: UserId): Promise<void>;

  // Collection operations
  findAll(): Promise<User[]>;
  findByStatus(status: UserStatus): Promise<User[]>;

  // Existence checks
  existsByEmail(email: Email): Promise<boolean>;
}
```

### Transaction Handling

```typescript
// Unit of Work pattern
interface UnitOfWork {
  transaction<T>(work: () => Promise<T>): Promise<T>;
  commit(): Promise<void>;
  rollback(): Promise<void>;
}

class TypeORMUnitOfWork implements UnitOfWork {
  async transaction<T>(work: () => Promise<T>): Promise<T> {
    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      const result = await work();
      await queryRunner.commitTransaction();
      return result;
    } catch (error) {
      await queryRunner.rollbackTransaction();
      throw error;
    } finally {
      await queryRunner.release();
    }
  }
}
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Domain in entity | ORM annotations in domain | Separate DB entities |
| N+1 queries | Performance issues | Eager loading, joins |
| Raw SQL everywhere | Hard to maintain | Use query builder |
| No soft deletes | Data loss | Implement soft delete |
| Missing indexes | Slow queries | Index foreign keys, filters |

## Checklist

### Repository Implementation
- [ ] Implements domain port interface
- [ ] Uses separate DB entity (not domain entity)
- [ ] Mapper converts between domain and persistence
- [ ] Soft delete implemented where needed
- [ ] Indexes on foreign keys and common queries

### Query Optimization
- [ ] N+1 queries prevented with eager loading
- [ ] Pagination for list queries
- [ ] Indexes support query patterns
- [ ] Complex queries use query builder

### Testing
- [ ] Integration tests with real database
- [ ] Transaction rollback in tests
- [ ] Edge cases (not found, duplicates)

## Integration

### Works With
- architect-data-modeler (schema design)
- logic-implementer (use cases)
- test-engineer (integration tests)

### Output
- Repository implementations
- Entity definitions
- Mapper classes
- Migration files
