---
name: integration-adapter
description: Implements external service integrations and API clients
version: 1.0
---

# Integration Adapter

Implements adapters for external services (payment gateways, email providers, third-party APIs) following the ports and adapters pattern.

## Trigger Conditions

```yaml
task_mentions:
  - "integration|external|third-party"
  - "api client|http client|sdk"
  - "payment|email|notification|sms"
  - "webhook|callback"
file_extension:
  - .ts
  - .js
  - .java
file_contains:
  - "axios|fetch|HttpClient"
  - "implements.*Gateway"
  - "implements.*Provider"
always_active_for_agents:
  - backend-agent
```

## When to Load

- Integrating external APIs
- Implementing payment gateways
- Building notification services
- Creating webhook handlers

## Core Competencies

### Port Definition (Domain Layer)

```typescript
// domain/ports/PaymentGateway.ts
interface PaymentGateway {
  charge(request: ChargeRequest): Promise<ChargeResult>;
  refund(paymentId: string, amount: Money): Promise<RefundResult>;
  getPaymentStatus(paymentId: string): Promise<PaymentStatus>;
}

interface ChargeRequest {
  amount: Money;
  currency: Currency;
  customerId: string;
  paymentMethodId: string;
  metadata?: Record<string, string>;
}

interface ChargeResult {
  success: boolean;
  paymentId: string;
  status: PaymentStatus;
  error?: PaymentError;
}
```

### Adapter Implementation

```typescript
// infrastructure/external/StripePaymentGateway.ts
import Stripe from 'stripe';
import { PaymentGateway, ChargeRequest, ChargeResult } from '../../domain/ports/PaymentGateway';

export class StripePaymentGateway implements PaymentGateway {
  private readonly stripe: Stripe;

  constructor(private readonly config: StripeConfig) {
    this.stripe = new Stripe(config.secretKey, {
      apiVersion: '2023-10-16'
    });
  }

  async charge(request: ChargeRequest): Promise<ChargeResult> {
    try {
      const paymentIntent = await this.stripe.paymentIntents.create({
        amount: request.amount.toCents(),
        currency: request.currency.code.toLowerCase(),
        customer: request.customerId,
        payment_method: request.paymentMethodId,
        confirm: true,
        metadata: request.metadata
      });

      return {
        success: paymentIntent.status === 'succeeded',
        paymentId: paymentIntent.id,
        status: this.mapStatus(paymentIntent.status),
        error: undefined
      };
    } catch (error) {
      return this.handleStripeError(error);
    }
  }

  async refund(paymentId: string, amount: Money): Promise<RefundResult> {
    const refund = await this.stripe.refunds.create({
      payment_intent: paymentId,
      amount: amount.toCents()
    });

    return {
      success: refund.status === 'succeeded',
      refundId: refund.id,
      status: this.mapRefundStatus(refund.status)
    };
  }

  private mapStatus(stripeStatus: string): PaymentStatus {
    const mapping: Record<string, PaymentStatus> = {
      'succeeded': PaymentStatus.COMPLETED,
      'processing': PaymentStatus.PENDING,
      'requires_action': PaymentStatus.REQUIRES_ACTION,
      'canceled': PaymentStatus.FAILED
    };
    return mapping[stripeStatus] ?? PaymentStatus.UNKNOWN;
  }

  private handleStripeError(error: unknown): ChargeResult {
    if (error instanceof Stripe.errors.StripeCardError) {
      return {
        success: false,
        paymentId: '',
        status: PaymentStatus.FAILED,
        error: {
          code: error.code ?? 'CARD_ERROR',
          message: error.message,
          declineCode: error.decline_code
        }
      };
    }
    throw error;
  }
}
```

### HTTP Client Wrapper

```typescript
// infrastructure/http/HttpClient.ts
interface HttpClient {
  get<T>(url: string, config?: RequestConfig): Promise<T>;
  post<T>(url: string, data: unknown, config?: RequestConfig): Promise<T>;
  put<T>(url: string, data: unknown, config?: RequestConfig): Promise<T>;
  delete<T>(url: string, config?: RequestConfig): Promise<T>;
}

// With retry, timeout, and circuit breaker
class ResilientHttpClient implements HttpClient {
  constructor(
    private readonly axios: AxiosInstance,
    private readonly circuitBreaker: CircuitBreaker,
    private readonly config: HttpClientConfig
  ) {
    this.setupInterceptors();
  }

  async get<T>(url: string, config?: RequestConfig): Promise<T> {
    return this.circuitBreaker.execute(async () => {
      const response = await this.axios.get<T>(url, {
        ...config,
        timeout: this.config.timeout
      });
      return response.data;
    });
  }

  private setupInterceptors(): void {
    // Retry interceptor
    axiosRetry(this.axios, {
      retries: this.config.retries,
      retryDelay: axiosRetry.exponentialDelay,
      retryCondition: (error) => {
        return axiosRetry.isNetworkOrIdempotentRequestError(error) ||
          error.response?.status === 429;
      }
    });

    // Logging interceptor
    this.axios.interceptors.request.use((config) => {
      this.logger.debug('HTTP Request', {
        method: config.method,
        url: config.url
      });
      return config;
    });
  }
}
```

### Webhook Handler

```typescript
// infrastructure/webhooks/StripeWebhookHandler.ts
export class StripeWebhookHandler {
  constructor(
    private readonly stripe: Stripe,
    private readonly orderService: OrderService,
    private readonly config: StripeConfig
  ) {}

  async handle(payload: Buffer, signature: string): Promise<void> {
    // Verify webhook signature
    const event = this.stripe.webhooks.constructEvent(
      payload,
      signature,
      this.config.webhookSecret
    );

    // Process event
    switch (event.type) {
      case 'payment_intent.succeeded':
        await this.handlePaymentSucceeded(event.data.object);
        break;
      case 'payment_intent.payment_failed':
        await this.handlePaymentFailed(event.data.object);
        break;
      case 'charge.refunded':
        await this.handleRefund(event.data.object);
        break;
      default:
        this.logger.warn('Unhandled webhook event', { type: event.type });
    }
  }

  private async handlePaymentSucceeded(paymentIntent: Stripe.PaymentIntent): Promise<void> {
    const orderId = paymentIntent.metadata.orderId;
    await this.orderService.markAsPaid(orderId, paymentIntent.id);
  }
}
```

## Best Practices

### Configuration Management

```typescript
// config/external-services.ts
interface ExternalServicesConfig {
  stripe: {
    secretKey: string;
    webhookSecret: string;
    apiVersion: string;
  };
  sendgrid: {
    apiKey: string;
    fromEmail: string;
    templates: Record<string, string>;
  };
}

// Load from environment
const config: ExternalServicesConfig = {
  stripe: {
    secretKey: process.env.STRIPE_SECRET_KEY!,
    webhookSecret: process.env.STRIPE_WEBHOOK_SECRET!,
    apiVersion: '2023-10-16'
  }
};
```

### Error Handling

```typescript
// Wrap external errors in domain errors
class ExternalServiceError extends Error {
  constructor(
    public readonly service: string,
    public readonly operation: string,
    public readonly originalError: unknown,
    public readonly retryable: boolean
  ) {
    super(`${service} ${operation} failed`);
  }
}

// Usage in adapter
async charge(request: ChargeRequest): Promise<ChargeResult> {
  try {
    // ... stripe call
  } catch (error) {
    if (this.isRetryable(error)) {
      throw new ExternalServiceError('Stripe', 'charge', error, true);
    }
    throw new ExternalServiceError('Stripe', 'charge', error, false);
  }
}
```

### Circuit Breaker Pattern

```typescript
class CircuitBreaker {
  private state: 'CLOSED' | 'OPEN' | 'HALF_OPEN' = 'CLOSED';
  private failures = 0;
  private lastFailure?: Date;

  async execute<T>(operation: () => Promise<T>): Promise<T> {
    if (this.state === 'OPEN') {
      if (this.shouldAttemptReset()) {
        this.state = 'HALF_OPEN';
      } else {
        throw new CircuitOpenError();
      }
    }

    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }

  private onSuccess(): void {
    this.failures = 0;
    this.state = 'CLOSED';
  }

  private onFailure(): void {
    this.failures++;
    this.lastFailure = new Date();
    if (this.failures >= this.threshold) {
      this.state = 'OPEN';
    }
  }
}
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Direct SDK in use case | Tight coupling | Use port/adapter |
| No timeout | Hung requests | Always set timeouts |
| No retry logic | Transient failures | Implement retries |
| Sync webhooks | Slow processing | Queue for async |
| Hardcoded config | Environment issues | Use config files |

## Checklist

### Adapter Implementation
- [ ] Implements domain port interface
- [ ] Configuration externalized
- [ ] Error mapping to domain errors
- [ ] Timeout configured
- [ ] Retry logic for transient failures

### Resilience
- [ ] Circuit breaker implemented
- [ ] Fallback behavior defined
- [ ] Health check endpoint
- [ ] Metrics/logging in place

### Webhooks
- [ ] Signature verification
- [ ] Idempotency handling
- [ ] Async processing (queue)
- [ ] Error handling and DLQ

## Integration

### Works With
- logic-implementer (use cases)
- architect-security-guardian (secrets)
- observability-expert (monitoring)

### Output
- Adapter implementations
- HTTP client wrappers
- Webhook handlers
- Configuration schemas
