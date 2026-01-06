---
name: test-engineer
description: Creates comprehensive test suites following testing pyramid
version: 1.0
---

# Test Engineer

Designs and implements test strategies following the testing pyramid, ensures code coverage, and maintains test quality.

## Trigger Conditions

```yaml
task_mentions:
  - "test|spec|testing"
  - "unit test|integration test|e2e"
  - "coverage|tdd|bdd"
  - "mock|stub|fixture"
file_extension:
  - .test.ts
  - .spec.ts
  - .test.js
  - .spec.js
  - Test.java
  - _test.go
file_contains:
  - "describe("
  - "it("
  - "@Test"
  - "expect("
always_active_for_agents:
  - backend-agent
  - qa-agent
```

## When to Load

- Writing new tests
- Implementing TDD
- Code review (test coverage)
- Test refactoring

## Core Competencies

### Testing Pyramid

```
        /\
       /  \     E2E Tests (few)
      /----\    - Critical user journeys
     /      \   - Slow, expensive
    /--------\
   /          \ Integration Tests (some)
  /  --------  \- API endpoints
 /              \- Database queries
/----------------\
       Unit Tests (many)
       - Business logic
       - Fast, isolated
```

### Unit Tests

```typescript
// domain/entities/Order.test.ts
describe('Order', () => {
  describe('create', () => {
    it('should create order with valid items', () => {
      const order = Order.create({
        userId: UserId.from('user-123'),
        items: [
          OrderItem.create({
            productId: ProductId.from('prod-1'),
            quantity: 2,
            unitPrice: Money.of(100, 'USD')
          })
        ]
      });

      expect(order.status).toBe(OrderStatus.PENDING);
      expect(order.items).toHaveLength(1);
      expect(order.total.equals(Money.of(200, 'USD'))).toBe(true);
    });

    it('should reject empty order', () => {
      expect(() => Order.create({
        userId: UserId.from('user-123'),
        items: []
      })).toThrow(ValidationError);
    });
  });

  describe('cancel', () => {
    it('should cancel pending order', () => {
      const order = createPendingOrder();

      order.cancel('Customer request');

      expect(order.status).toBe(OrderStatus.CANCELLED);
      expect(order.cancellationReason).toBe('Customer request');
    });

    it('should reject cancellation of shipped order', () => {
      const order = createShippedOrder();

      expect(() => order.cancel('Changed mind'))
        .toThrow(InvalidOperationError);
    });
  });
});
```

### Use Case Tests with Mocks

```typescript
// application/use-cases/CreateOrderUseCase.test.ts
describe('CreateOrderUseCase', () => {
  let useCase: CreateOrderUseCase;
  let orderRepository: jest.Mocked<OrderRepository>;
  let productRepository: jest.Mocked<ProductRepository>;
  let eventPublisher: jest.Mocked<DomainEventPublisher>;

  beforeEach(() => {
    orderRepository = {
      save: jest.fn(),
      findById: jest.fn()
    };
    productRepository = {
      findByIds: jest.fn()
    };
    eventPublisher = {
      publish: jest.fn()
    };

    useCase = new CreateOrderUseCase(
      orderRepository,
      productRepository,
      eventPublisher
    );
  });

  it('should create order and publish event', async () => {
    // Arrange
    const products = [
      createProduct({ id: 'prod-1', price: Money.of(100, 'USD') })
    ];
    productRepository.findByIds.mockResolvedValue(products);
    orderRepository.save.mockResolvedValue(undefined);
    eventPublisher.publish.mockResolvedValue(undefined);

    // Act
    const result = await useCase.execute({
      userId: 'user-123',
      items: [{ productId: 'prod-1', quantity: 2 }]
    });

    // Assert
    expect(result.orderId).toBeDefined();
    expect(result.total).toBe(200);
    expect(orderRepository.save).toHaveBeenCalledTimes(1);
    expect(eventPublisher.publish).toHaveBeenCalledWith(
      expect.arrayContaining([
        expect.objectContaining({ type: 'OrderCreated' })
      ])
    );
  });

  it('should fail if product not found', async () => {
    productRepository.findByIds.mockResolvedValue([]);

    await expect(useCase.execute({
      userId: 'user-123',
      items: [{ productId: 'invalid', quantity: 1 }]
    })).rejects.toThrow(ProductNotFoundError);
  });
});
```

### Integration Tests

```typescript
// infrastructure/persistence/PostgresOrderRepository.integration.test.ts
describe('PostgresOrderRepository', () => {
  let repository: PostgresOrderRepository;
  let dataSource: DataSource;

  beforeAll(async () => {
    dataSource = await createTestDataSource();
    repository = new PostgresOrderRepository(dataSource, new OrderMapper());
  });

  beforeEach(async () => {
    await dataSource.query('TRUNCATE orders, order_items CASCADE');
  });

  afterAll(async () => {
    await dataSource.destroy();
  });

  it('should save and retrieve order with items', async () => {
    const order = Order.create({
      userId: UserId.from('user-123'),
      items: [createOrderItem()]
    });

    await repository.save(order);
    const retrieved = await repository.findById(order.id);

    expect(retrieved).not.toBeNull();
    expect(retrieved!.id.equals(order.id)).toBe(true);
    expect(retrieved!.items).toHaveLength(1);
  });

  it('should return null for non-existent order', async () => {
    const result = await repository.findById(
      OrderId.from('non-existent')
    );

    expect(result).toBeNull();
  });
});
```

### API Integration Tests

```typescript
// presentation/rest/OrderController.integration.test.ts
describe('OrderController', () => {
  let app: Express;
  let authToken: string;

  beforeAll(async () => {
    app = await createTestApp();
    authToken = await getTestAuthToken();
  });

  describe('POST /api/v1/orders', () => {
    it('should create order', async () => {
      const response = await request(app)
        .post('/api/v1/orders')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          items: [
            { productId: 'prod-1', quantity: 2 }
          ]
        });

      expect(response.status).toBe(201);
      expect(response.body.data.orderId).toBeDefined();
      expect(response.body.data.status).toBe('pending');
    });

    it('should return 400 for empty order', async () => {
      const response = await request(app)
        .post('/api/v1/orders')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ items: [] });

      expect(response.status).toBe(400);
      expect(response.body.error.code).toBe('VALIDATION_ERROR');
    });

    it('should return 401 without auth', async () => {
      const response = await request(app)
        .post('/api/v1/orders')
        .send({ items: [{ productId: 'prod-1', quantity: 1 }] });

      expect(response.status).toBe(401);
    });
  });
});
```

## Best Practices

### Test Naming Convention

```typescript
// Pattern: should_[expectedBehavior]_when_[condition]
describe('Order.cancel', () => {
  it('should set status to cancelled when order is pending', () => {});
  it('should record cancellation reason when provided', () => {});
  it('should throw error when order is already shipped', () => {});
});
```

### Test Data Builders

```typescript
// tests/builders/OrderBuilder.ts
class OrderBuilder {
  private props: OrderProps = {
    id: OrderId.generate(),
    userId: UserId.from('default-user'),
    items: [],
    status: OrderStatus.PENDING,
    createdAt: new Date()
  };

  withId(id: string): this {
    this.props.id = OrderId.from(id);
    return this;
  }

  withItems(items: OrderItem[]): this {
    this.props.items = items;
    return this;
  }

  withStatus(status: OrderStatus): this {
    this.props.status = status;
    return this;
  }

  build(): Order {
    return Order.reconstitute(this.props);
  }
}

// Usage
const order = new OrderBuilder()
  .withItems([createOrderItem()])
  .withStatus(OrderStatus.SHIPPED)
  .build();
```

### Test Coverage Goals

| Layer | Target Coverage | Focus |
|-------|----------------|-------|
| Domain Entities | 90%+ | All business rules |
| Use Cases | 85%+ | Happy path + error cases |
| Repositories | 80%+ | CRUD + edge cases |
| Controllers | 70%+ | Request/response mapping |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Testing implementation | Brittle tests | Test behavior, not internals |
| Shared test state | Flaky tests | Isolate each test |
| Mock everything | Tests don't catch bugs | Use real deps where possible |
| Giant test methods | Hard to maintain | One assertion focus |
| No error case tests | Incomplete coverage | Test failure scenarios |

## Checklist

### Unit Tests
- [ ] All domain entities tested
- [ ] All use cases tested
- [ ] Edge cases covered
- [ ] Error scenarios tested
- [ ] Mocks verify interactions

### Integration Tests
- [ ] Database operations tested
- [ ] API endpoints tested
- [ ] External service integration tested
- [ ] Test database properly seeded/cleaned

### General
- [ ] Tests run in isolation
- [ ] Tests are deterministic
- [ ] Test names describe behavior
- [ ] Coverage meets targets

## Integration

### Works With
- logic-implementer (testing use cases)
- persistence-adapter (integration tests)
- qa-specialist (test strategy)

### Output
- Unit test files
- Integration test files
- Test fixtures and builders
- Coverage reports
