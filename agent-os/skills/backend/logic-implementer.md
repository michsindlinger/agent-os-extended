---
name: logic-implementer
description: Implements business logic in use cases and domain services
version: 1.0
---

# Logic Implementer

Transforms architecture specifications into clean, testable business logic following SOLID principles and the defined architecture pattern.

## Trigger Conditions

```yaml
task_mentions:
  - "implement|create|build|develop"
  - "use case|service|business logic"
  - "domain logic|application logic"
file_extension:
  - .ts
  - .js
  - .java
  - .kt
  - .rb
file_contains:
  - "class.*UseCase"
  - "class.*Service"
  - "@UseCase"
always_active_for_agents:
  - backend-agent
```

## When to Load

- Implementing new use cases
- Creating domain services
- Building application services
- Refactoring business logic

## Core Competencies

### Use Case Pattern

```typescript
// application/use-cases/CreateOrderUseCase.ts
interface CreateOrderInput {
  userId: string;
  items: Array<{ productId: string; quantity: number }>;
}

interface CreateOrderOutput {
  orderId: string;
  total: number;
  status: OrderStatus;
}

class CreateOrderUseCase {
  constructor(
    private readonly orderRepository: OrderRepository,
    private readonly productRepository: ProductRepository,
    private readonly eventPublisher: DomainEventPublisher
  ) {}

  async execute(input: CreateOrderInput): Promise<CreateOrderOutput> {
    // 1. Validate input
    this.validateInput(input);

    // 2. Load required entities
    const products = await this.loadProducts(input.items);

    // 3. Execute domain logic
    const order = Order.create({
      userId: UserId.from(input.userId),
      items: this.createOrderItems(input.items, products)
    });

    // 4. Persist changes
    await this.orderRepository.save(order);

    // 5. Publish events
    await this.eventPublisher.publish(order.domainEvents);

    // 6. Return output
    return this.toOutput(order);
  }

  private validateInput(input: CreateOrderInput): void {
    if (!input.items.length) {
      throw new ValidationError('Order must have at least one item');
    }
  }
}
```

### Domain Service Pattern

```typescript
// domain/services/PricingService.ts
class PricingService {
  calculateOrderTotal(items: OrderItem[], discounts: Discount[]): Money {
    const subtotal = items.reduce(
      (sum, item) => sum.add(item.lineTotal),
      Money.zero()
    );

    const discount = this.applyDiscounts(subtotal, discounts);

    return subtotal.subtract(discount);
  }

  private applyDiscounts(amount: Money, discounts: Discount[]): Money {
    return discounts.reduce(
      (total, discount) => total.add(discount.apply(amount)),
      Money.zero()
    );
  }
}
```

### Command/Query Separation (CQRS)

```typescript
// Commands - modify state
interface Command<T> {
  execute(): Promise<T>;
}

class CreateUserCommand implements Command<UserId> {
  constructor(
    private readonly data: CreateUserData,
    private readonly userRepository: UserRepository
  ) {}

  async execute(): Promise<UserId> {
    const user = User.create(this.data);
    await this.userRepository.save(user);
    return user.id;
  }
}

// Queries - read-only
interface Query<T> {
  execute(): Promise<T>;
}

class GetUserByIdQuery implements Query<UserDTO | null> {
  constructor(
    private readonly userId: string,
    private readonly userReadModel: UserReadModel
  ) {}

  async execute(): Promise<UserDTO | null> {
    return this.userReadModel.findById(this.userId);
  }
}
```

## Best Practices

### SOLID Principles in Practice

| Principle | Application |
|-----------|-------------|
| Single Responsibility | One use case = one business action |
| Open/Closed | Extend via strategy pattern, not modification |
| Liskov Substitution | All repository impls must honor interface contract |
| Interface Segregation | Small, focused port interfaces |
| Dependency Inversion | Depend on abstractions (ports) not concrete impls |

### Error Handling Strategy

```typescript
// Domain errors (expected)
class DomainError extends Error {
  constructor(
    message: string,
    public readonly code: string
  ) {
    super(message);
  }
}

class InsufficientStockError extends DomainError {
  constructor(productId: string, requested: number, available: number) {
    super(
      `Insufficient stock for ${productId}: requested ${requested}, available ${available}`,
      'INSUFFICIENT_STOCK'
    );
  }
}

// Use case error handling
async execute(input: Input): Promise<Result<Output, DomainError>> {
  try {
    // ... business logic
    return Result.ok(output);
  } catch (error) {
    if (error instanceof DomainError) {
      return Result.fail(error);
    }
    throw error; // Re-throw unexpected errors
  }
}
```

### Transaction Management

```typescript
// Unit of Work pattern
class CreateOrderUseCase {
  async execute(input: CreateOrderInput): Promise<CreateOrderOutput> {
    return this.unitOfWork.transaction(async () => {
      // All operations within transaction
      const order = Order.create(/* ... */);
      await this.orderRepository.save(order);
      await this.inventoryService.reserve(order.items);
      return this.toOutput(order);
    });
  }
}
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Fat use case | Too many responsibilities | Split into smaller use cases |
| Anemic domain | Logic in use case, not entity | Move behavior to entities |
| Direct DB access | Bypasses repository abstraction | Always use repository |
| Swallowing errors | Hidden failures | Proper error propagation |
| God service | Single service does everything | Split by bounded context |

## Checklist

### Before Implementation
- [ ] Architecture pattern understood (Hexagonal/Clean/DDD)
- [ ] Use case input/output defined
- [ ] Required ports/interfaces identified
- [ ] Error scenarios documented

### During Implementation
- [ ] Single responsibility maintained
- [ ] Dependencies injected via constructor
- [ ] Domain logic in entities where appropriate
- [ ] Validation at use case entry point
- [ ] Events published for state changes

### After Implementation
- [ ] Unit tests cover happy path
- [ ] Unit tests cover error scenarios
- [ ] Integration points mocked
- [ ] Code reviewed for SOLID violations

## Integration

### Works With
- architect-pattern-enforcer (structure)
- persistence-adapter (data access)
- test-engineer (testing)

### Output
- Use case implementations
- Domain services
- Application services
- Event definitions
