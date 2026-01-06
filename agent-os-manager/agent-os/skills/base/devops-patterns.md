# DevOps Patterns & Best Practices

## Context

Comprehensive DevOps patterns for CI/CD, containerization, and deployment automation. Auto-activated for devops-specialist agents.

## CI/CD Pipeline Design

### Pipeline Stages

**Standard Pipeline Flow**:
```
1. Source → 2. Build → 3. Test → 4. Security Scan → 5. Deploy
```

**Stage Responsibilities**:
- **Source**: Checkout code, verify branch
- **Build**: Compile, bundle, optimize assets
- **Test**: Unit → Integration → E2E (fail fast principle)
- **Security**: Dependency scan, SAST, container scan
- **Deploy**: Environment-specific deployment with smoke tests

### Quality Gates

**Mandatory Gates Before Deployment**:
- ✅ All tests pass (unit, integration, E2E)
- ✅ Build succeeds without errors
- ✅ Code coverage meets threshold (≥80%)
- ✅ No critical security vulnerabilities
- ✅ Linting passes
- ✅ No compilation warnings (treat warnings as errors)

**Conditional Gates**:
- Manual approval for production deployments
- Performance benchmarks meet baseline
- Database migrations validated
- Breaking changes documented

### Parallelization Strategy

**Run in Parallel** (reduce total pipeline time):
```yaml
# Backend and frontend tests simultaneously
jobs:
  backend-tests:
    runs-on: ubuntu-latest
    steps:
      - run: mvn test

  frontend-tests:
    runs-on: ubuntu-latest
    steps:
      - run: npm test
```

**Run Sequentially** (when dependencies exist):
```yaml
# Deploy only after all tests pass
jobs:
  test:
    # ... all test jobs

  deploy:
    needs: [backend-tests, frontend-tests, e2e-tests]
    steps:
      - run: deploy.sh
```

## GitHub Actions Best Practices

### Workflow Organization

**File Structure**:
```
.github/
  workflows/
    ci.yml           # Main CI pipeline (test + build)
    deploy-staging.yml
    deploy-production.yml
    reusable-tests.yml  # Reusable workflow
    security-scan.yml
```

### Reusable Workflows

**Define Once, Use Many Times**:
```yaml
# .github/workflows/reusable-tests.yml
name: Reusable Test Workflow

on:
  workflow_call:
    inputs:
      test-command:
        required: true
        type: string
      coverage-threshold:
        required: false
        type: number
        default: 80

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: ${{ inputs.test-command }}
      - name: Check Coverage
        run: |
          coverage=$(cat coverage.txt)
          if [ $coverage -lt ${{ inputs.coverage-threshold }} ]; then
            echo "Coverage $coverage% below threshold"
            exit 1
          fi
```

**Usage**:
```yaml
# .github/workflows/ci.yml
jobs:
  backend-tests:
    uses: ./.github/workflows/reusable-tests.yml
    with:
      test-command: mvn test
      coverage-threshold: 85
```

### Matrix Builds

**Test Across Multiple Versions**:
```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20, 22]
        java-version: [17, 21]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - uses: actions/setup-java@v3
        with:
          java-version: ${{ matrix.java-version }}
      - run: npm test
```

**When to Use Matrix**:
- ✅ Testing multiple OS platforms
- ✅ Supporting multiple language/runtime versions
- ✅ Testing different database versions
- ❌ NOT for environments (use separate workflows instead)

### Caching Strategies

**Dependency Caching** (speeds up builds):
```yaml
- uses: actions/cache@v3
  with:
    path: |
      ~/.m2/repository
      ~/.npm
      node_modules
    key: ${{ runner.os }}-deps-${{ hashFiles('**/pom.xml', '**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-deps-
```

**Build Artifact Caching**:
```yaml
- uses: actions/cache@v3
  with:
    path: target/
    key: ${{ runner.os }}-build-${{ github.sha }}
```

**Cache Invalidation Rules**:
- Use `hashFiles()` for dependency files (pom.xml, package-lock.json)
- Include OS in cache key if dependencies are OS-specific
- Use `restore-keys` for fallback to previous cache versions
- Clear cache when build issues occur (delete via GitHub UI)

### Secrets Management

**Store Secrets Securely**:
```yaml
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
  API_KEY: ${{ secrets.API_KEY }}

steps:
  - name: Deploy
    env:
      DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
    run: ./deploy.sh
```

**Security Rules**:
- ❌ NEVER hardcode secrets in workflows
- ❌ NEVER echo secrets in logs
- ✅ Use GitHub Secrets for sensitive values
- ✅ Use environment-specific secrets (staging vs production)
- ✅ Rotate secrets regularly
- ✅ Use OIDC for cloud provider authentication (no long-lived tokens)

## Docker Best Practices

### Multi-Stage Builds

**Reduce Image Size** (Build artifacts != Runtime dependencies):
```dockerfile
# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Benefits**:
- Final image only contains runtime dependencies
- Builder tools (Maven, npm, compilers) not in production image
- Smaller image = faster deployments + reduced attack surface

### Layer Caching Optimization

**Order Matters** (rarely changing → frequently changing):
```dockerfile
# ✅ GOOD: Dependencies before source code
COPY package.json package-lock.json ./
RUN npm ci  # Cached unless package files change

COPY src ./src  # Changes frequently, doesn't invalidate dependency cache
RUN npm run build
```

```dockerfile
# ❌ BAD: Source code before dependencies
COPY . .  # Any code change invalidates ALL subsequent layers
RUN npm ci
RUN npm run build
```

**Layer Caching Rules**:
1. Install dependencies before copying source code
2. Copy only necessary files (use .dockerignore)
3. Combine related RUN commands to reduce layers
4. Use specific COPY paths instead of `COPY . .`

### Security Best Practices

**Base Image Selection**:
```dockerfile
# ✅ GOOD: Official images, specific versions, minimal variants
FROM eclipse-temurin:17-jre-alpine

# ❌ BAD: Latest tag, large base images
FROM openjdk:latest  # Unpredictable, breaks builds
FROM ubuntu:latest   # Unnecessary bloat
```

**Non-Root User**:
```dockerfile
# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Switch to non-root user
USER appuser

# Application runs as non-root
ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Security Checklist**:
- ✅ Use specific image tags (not `latest`)
- ✅ Use minimal base images (alpine, distroless)
- ✅ Run as non-root user
- ✅ Scan images for vulnerabilities (Trivy, Snyk)
- ✅ Use .dockerignore to exclude secrets, .git, node_modules
- ✅ Update base images regularly

### Frontend Docker Example

**React/Angular Production Build**:
```dockerfile
# Build stage
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage with Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Backend Docker Example

**Spring Boot Application**:
```dockerfile
# Build stage
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Add non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

COPY --from=builder /app/target/*.jar app.jar

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/actuator/health || exit 1

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## Deployment Strategies

### Rolling Deployment

**Gradual Instance Replacement**:
```
Old: [v1] [v1] [v1] [v1]
     [v2] [v1] [v1] [v1]  ← Replace one instance
     [v2] [v2] [v1] [v1]  ← Replace another
     [v2] [v2] [v2] [v1]
     [v2] [v2] [v2] [v2]  ← All updated
```

**Use Cases**:
- ✅ Standard deployments with backward-compatible changes
- ✅ Cost-effective (no extra infrastructure needed)
- ❌ Avoid for breaking API changes
- ❌ Avoid for database schema changes

### Blue-Green Deployment

**Two Identical Environments**:
```
Blue (current):  [v1] [v1] [v1] ← Live traffic
Green (staging): [v2] [v2] [v2] ← Deploy + test

Switch traffic:
Blue:  [v1] [v1] [v1] ← Idle (can rollback)
Green: [v2] [v2] [v2] ← Live traffic
```

**Use Cases**:
- ✅ Zero-downtime deployments
- ✅ Instant rollback capability
- ✅ Breaking changes (test before switching)
- ❌ Requires double infrastructure (higher cost)

### Canary Deployment

**Gradual Traffic Shift**:
```
Step 1: 95% → [v1], 5% → [v2]   (monitor errors)
Step 2: 50% → [v1], 50% → [v2]  (if stable)
Step 3: 0% → [v1], 100% → [v2]  (full rollout)
```

**Use Cases**:
- ✅ High-risk changes (monitor real user impact)
- ✅ A/B testing new features
- ✅ Gradual feature rollout
- ❌ Requires traffic routing logic (load balancer, service mesh)

## Environment Management

### Environment Structure

**Standard Environments**:
```
Local → Development → Staging → Production
        (CI tests)    (Pre-prod) (Live users)
```

**Environment Characteristics**:

| Env | Purpose | Data | Auto-Deploy | Approval |
|-----|---------|------|-------------|----------|
| **Local** | Developer testing | Mock/seed data | Manual | No |
| **Development** | Integration testing | Synthetic data | On push (main) | No |
| **Staging** | Pre-production validation | Anonymized prod data | On merge | Optional |
| **Production** | Live users | Real data | Manual trigger | Required |

### Environment Configuration

**Environment-Specific Variables**:
```yaml
# .env.development
DATABASE_URL=postgres://localhost:5432/myapp_dev
API_URL=http://localhost:8080
LOG_LEVEL=debug
FEATURE_FLAGS={"newFeature": true}

# .env.production
DATABASE_URL=${{ secrets.PROD_DATABASE_URL }}
API_URL=https://api.myapp.com
LOG_LEVEL=error
FEATURE_FLAGS={"newFeature": false}
```

**Configuration Best Practices**:
- ✅ Use environment variables (never hardcode)
- ✅ Validate required variables on startup
- ✅ Use different databases per environment
- ✅ Feature flags for gradual rollouts
- ❌ Never commit .env files (add to .gitignore)

### Smoke Tests

**Post-Deployment Validation**:
```yaml
- name: Smoke Tests
  run: |
    # Wait for app to be ready
    timeout 60 bash -c 'until curl -f http://localhost:8080/health; do sleep 2; done'

    # Test critical endpoints
    curl -f http://localhost:8080/api/users || exit 1
    curl -f http://localhost:8080/api/health || exit 1

    # Verify database connection
    curl -f http://localhost:8080/api/health/db || exit 1
```

**What to Test**:
- ✅ Application starts successfully
- ✅ Health check endpoint responds
- ✅ Database connection works
- ✅ Critical API endpoints respond
- ✅ External service connections work
- ❌ NOT full functional tests (use E2E tests instead)

## Monitoring & Logging

### Logging Best Practices

**Structured Logging** (JSON format for parsing):
```json
{
  "timestamp": "2025-12-28T10:30:00Z",
  "level": "error",
  "message": "Failed to process payment",
  "userId": "user-123",
  "orderId": "order-456",
  "errorCode": "PAYMENT_GATEWAY_TIMEOUT"
}
```

**Log Levels** (use appropriately):
- **ERROR**: Critical issues requiring immediate attention
- **WARN**: Potentially harmful situations
- **INFO**: Important business events (user login, order placed)
- **DEBUG**: Detailed information for troubleshooting (only in dev)

### Health Checks

**Readiness vs Liveness**:
```yaml
# Kubernetes example
livenessProbe:
  httpGet:
    path: /health/live
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /health/ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
```

**Difference**:
- **Liveness**: Is the app running? (if fails → restart container)
- **Readiness**: Can the app serve traffic? (if fails → stop routing traffic)

## Docker Compose for Local Development

**Multi-Container Setup**:
```yaml
version: '3.9'

services:
  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.dev
    ports:
      - "8080:8080"
    environment:
      DATABASE_URL: postgres://postgres:password@db:5432/myapp
      REDIS_URL: redis://redis:6379
    depends_on:
      - db
      - redis
    volumes:
      - ./backend/src:/app/src  # Hot reload

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    environment:
      VITE_API_URL: http://localhost:8080
    volumes:
      - ./frontend/src:/app/src  # Hot reload
      - /app/node_modules  # Prevent overwrite

  db:
    image: postgres:17-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"

volumes:
  postgres-data:
```

**Usage**:
```bash
# Start all services
docker-compose up

# Rebuild specific service
docker-compose build backend

# View logs
docker-compose logs -f backend

# Stop all services
docker-compose down
```

## Common Patterns

### Database Migrations in CI/CD

**Safe Migration Strategy**:
```yaml
jobs:
  deploy:
    steps:
      - name: Run Migrations
        run: |
          # Backup database first
          ./backup-db.sh

          # Run migrations (backward-compatible only)
          mvn flyway:migrate

          # Verify migration success
          mvn flyway:validate || rollback

      - name: Deploy Application
        run: ./deploy.sh
```

**Migration Rules**:
- ✅ Always backward-compatible (support old + new code)
- ✅ Run migrations before deploying new code
- ✅ Test migrations in staging first
- ✅ Backup database before migrations
- ❌ Never delete columns in same release as code removal

### Zero-Downtime Deployment Checklist

**Pre-Deployment**:
- [ ] All tests pass (unit, integration, E2E)
- [ ] Staging environment validated
- [ ] Database migrations are backward-compatible
- [ ] Feature flags configured for gradual rollout
- [ ] Rollback plan documented

**During Deployment**:
- [ ] Health checks pass before routing traffic
- [ ] Monitor error rates (should not increase)
- [ ] Monitor response times (should not degrade)
- [ ] Database connection pool healthy

**Post-Deployment**:
- [ ] Smoke tests pass
- [ ] Key metrics stable (error rate, latency, throughput)
- [ ] Logs show no critical errors
- [ ] Rollback plan ready if issues detected

## Automation Checklist

**CI Pipeline**:
- [ ] Automated tests on every push
- [ ] Code quality checks (linting, formatting)
- [ ] Security scanning (dependencies, SAST)
- [ ] Build artifacts stored
- [ ] Test coverage tracked

**CD Pipeline**:
- [ ] Automated deployment to staging
- [ ] Manual approval for production
- [ ] Database migrations automated
- [ ] Smoke tests after deployment
- [ ] Automatic rollback on failure

**Infrastructure**:
- [ ] Docker images versioned and tagged
- [ ] Secrets managed securely (no hardcoding)
- [ ] Environment variables documented
- [ ] Monitoring and alerting configured
- [ ] Backup and disaster recovery plan

---

## Quick Reference

### GitHub Actions Workflow Template

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, staging]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run build

  deploy-staging:
    if: github.ref == 'refs/heads/main'
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Staging
        env:
          DEPLOY_TOKEN: ${{ secrets.STAGING_DEPLOY_TOKEN }}
        run: ./deploy.sh staging

  deploy-production:
    if: github.ref == 'refs/heads/main'
    needs: test
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Production
        env:
          DEPLOY_TOKEN: ${{ secrets.PROD_DEPLOY_TOKEN }}
        run: ./deploy.sh production
```

### Dockerfile Template (Node.js)

```dockerfile
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:22-alpine
WORKDIR /app
RUN addgroup -S app && adduser -S app -G app
USER app
COPY --from=builder --chown=app:app /app/dist ./dist
COPY --from=builder --chown=app:app /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### Dockerfile Template (Java Spring Boot)

```dockerfile
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
RUN addgroup -S spring && adduser -S spring -G spring
USER spring
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```
