---
name: observability-expert
description: Implements logging, monitoring, and alerting systems
version: 1.0
---

# Observability Expert

Sets up comprehensive observability including structured logging, metrics collection, distributed tracing, and alerting using modern tools.

## Trigger Conditions

```yaml
task_mentions:
  - "monitoring|observability|metrics"
  - "logging|tracing|alerting"
  - "prometheus|grafana|datadog"
  - "sentry|newrelic|honeycomb"
file_extension:
  - .yml
  - .yaml
  - .ts
file_contains:
  - "logger"
  - "metrics"
  - "span"
  - "trace"
always_active_for_agents:
  - devops-agent
```

## When to Load

- Setting up monitoring
- Implementing structured logging
- Creating dashboards
- Configuring alerts

## Core Competencies

### Structured Logging

```typescript
// lib/logger.ts
import pino from 'pino';

const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  formatters: {
    level: (label) => ({ level: label }),
    bindings: (bindings) => ({
      pid: bindings.pid,
      host: bindings.hostname,
      service: process.env.SERVICE_NAME || 'api',
      version: process.env.APP_VERSION || 'unknown'
    })
  },
  timestamp: pino.stdTimeFunctions.isoTime,
  redact: ['password', 'token', 'authorization', 'cookie']
});

// Request context logger
export function createRequestLogger(requestId: string, userId?: string) {
  return logger.child({
    requestId,
    userId
  });
}

// Usage
const log = createRequestLogger(req.id, req.user?.id);
log.info({ orderId: order.id, total: order.total }, 'Order created');
log.error({ err, orderId }, 'Failed to process order');
```

### Metrics Collection

```typescript
// lib/metrics.ts
import { Counter, Histogram, Gauge, Registry } from 'prom-client';

const registry = new Registry();

// HTTP request metrics
export const httpRequestDuration = new Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.01, 0.05, 0.1, 0.5, 1, 5],
  registers: [registry]
});

export const httpRequestTotal = new Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code'],
  registers: [registry]
});

// Business metrics
export const ordersCreated = new Counter({
  name: 'orders_created_total',
  help: 'Total orders created',
  labelNames: ['status', 'payment_method'],
  registers: [registry]
});

export const orderValue = new Histogram({
  name: 'order_value_dollars',
  help: 'Order value distribution',
  buckets: [10, 50, 100, 250, 500, 1000],
  registers: [registry]
});

// Active connections gauge
export const activeConnections = new Gauge({
  name: 'active_connections',
  help: 'Number of active connections',
  registers: [registry]
});

// Metrics endpoint
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', registry.contentType);
  res.end(await registry.metrics());
});
```

### Express Middleware

```typescript
// middleware/observability.ts
export function metricsMiddleware(req: Request, res: Response, next: NextFunction) {
  const start = process.hrtime();

  res.on('finish', () => {
    const [seconds, nanoseconds] = process.hrtime(start);
    const duration = seconds + nanoseconds / 1e9;

    const route = req.route?.path || req.path;
    const labels = {
      method: req.method,
      route,
      status_code: res.statusCode.toString()
    };

    httpRequestDuration.observe(labels, duration);
    httpRequestTotal.inc(labels);
  });

  next();
}

export function loggingMiddleware(req: Request, res: Response, next: NextFunction) {
  const requestId = req.headers['x-request-id'] as string || crypto.randomUUID();
  req.id = requestId;
  res.setHeader('x-request-id', requestId);

  const log = createRequestLogger(requestId, req.user?.id);
  req.log = log;

  const start = Date.now();

  res.on('finish', () => {
    const duration = Date.now() - start;
    log.info({
      method: req.method,
      url: req.url,
      statusCode: res.statusCode,
      duration,
      userAgent: req.headers['user-agent']
    }, 'Request completed');
  });

  next();
}
```

### Distributed Tracing

```typescript
// lib/tracing.ts
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-node';
import { SimpleSpanProcessor } from '@opentelemetry/sdk-trace-base';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { HttpInstrumentation } from '@opentelemetry/instrumentation-http';
import { ExpressInstrumentation } from '@opentelemetry/instrumentation-express';
import { PgInstrumentation } from '@opentelemetry/instrumentation-pg';

export function initTracing() {
  const provider = new NodeTracerProvider({
    resource: new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: 'api-service',
      [SemanticResourceAttributes.SERVICE_VERSION]: process.env.APP_VERSION
    })
  });

  const exporter = new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT
  });

  provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
  provider.register();

  registerInstrumentations({
    instrumentations: [
      new HttpInstrumentation(),
      new ExpressInstrumentation(),
      new PgInstrumentation()
    ]
  });

  return provider;
}

// Manual span creation
import { trace, SpanStatusCode } from '@opentelemetry/api';

const tracer = trace.getTracer('order-service');

async function processOrder(orderId: string) {
  return tracer.startActiveSpan('processOrder', async (span) => {
    span.setAttribute('order.id', orderId);

    try {
      const result = await doProcessing();
      span.setStatus({ code: SpanStatusCode.OK });
      return result;
    } catch (error) {
      span.setStatus({ code: SpanStatusCode.ERROR, message: error.message });
      span.recordException(error);
      throw error;
    } finally {
      span.end();
    }
  });
}
```

### Alerting Rules (Prometheus)

```yaml
# prometheus/alerts.yml
groups:
  - name: api-alerts
    rules:
      - alert: HighErrorRate
        expr: |
          sum(rate(http_requests_total{status_code=~"5.."}[5m])) /
          sum(rate(http_requests_total[5m])) > 0.05
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          description: "Error rate is {{ $value | humanizePercentage }} over the last 5 minutes"

      - alert: HighLatency
        expr: |
          histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 1
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High latency detected"
          description: "P95 latency is {{ $value | humanizeDuration }}"

      - alert: ServiceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Service is down"
          description: "{{ $labels.instance }} has been down for more than 1 minute"

      - alert: HighMemoryUsage
        expr: |
          process_resident_memory_bytes / 1024 / 1024 > 512
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "High memory usage"
          description: "Memory usage is {{ $value | humanize }}MB"
```

## Best Practices

### The Three Pillars

| Pillar | Purpose | Tools |
|--------|---------|-------|
| Logs | Event records, debugging | Pino, Winston, Loki |
| Metrics | Numeric measurements | Prometheus, Datadog |
| Traces | Request flow tracking | Jaeger, Honeycomb |

### Log Levels

| Level | When to Use |
|-------|-------------|
| error | Errors that need immediate attention |
| warn | Potential issues, degraded state |
| info | Key business events, state changes |
| debug | Detailed diagnostic information |
| trace | Very detailed tracing (dev only) |

### Key Metrics

```typescript
// RED Method (for services)
// - Rate: requests per second
// - Errors: failed requests per second
// - Duration: request latency

// USE Method (for resources)
// - Utilization: % time resource is busy
// - Saturation: queue length
// - Errors: error count
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Logging PII | Compliance violation | Redact sensitive data |
| Too many metrics | Cardinality explosion | Limit label values |
| Missing context | Hard to correlate | Include request ID, user ID |
| Alert fatigue | Ignored alerts | Tune thresholds, aggregate |
| No retention policy | Storage costs | Set appropriate retention |

## Checklist

### Logging
- [ ] Structured JSON logs
- [ ] Request ID propagation
- [ ] PII redaction
- [ ] Appropriate log levels

### Metrics
- [ ] RED metrics for services
- [ ] Business metrics
- [ ] Cardinality controlled
- [ ] Dashboards created

### Alerting
- [ ] Critical path alerts
- [ ] Appropriate thresholds
- [ ] Runbooks linked
- [ ] On-call rotation

## Integration

### Works With
- pipeline-engineer (deployment alerts)
- infrastructure-provisioner (infra metrics)
- security-hardener (security logging)

### Output
- Logger configuration
- Metrics definitions
- Alert rules
- Grafana dashboards
