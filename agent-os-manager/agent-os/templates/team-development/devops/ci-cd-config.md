# CI/CD Pipeline Configuration

> Template for GitHub Actions workflow configuration
> Use this template when setting up automated testing and deployment

## Pipeline Overview

**Platform**: GitHub Actions
**Purpose**: Automated testing, building, and deployment
**Triggers**: Push to main/develop, pull requests

---

## Workflow Structure

```
.github/
  workflows/
    ci.yml                    # Main CI pipeline (test + build)
    deploy-staging.yml        # Auto-deploy to staging
    deploy-production.yml     # Manual deploy to production
    reusable-tests.yml        # Reusable test workflow (optional)
```

---

## CI Workflow Template

**File**: `.github/workflows/ci.yml`

**Purpose**: Run tests and build on every push and PR

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  backend-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: 'maven'

      - name: Run unit tests
        run: mvn test

      - name: Run integration tests
        run: mvn verify

      - name: Check code coverage
        run: mvn jacoco:check

      - name: Build JAR
        run: mvn package -DskipTests

      - name: Upload build artifact
        uses: actions/upload-artifact@v3
        with:
          name: backend-jar
          path: target/*.jar
          retention-days: 7

  frontend-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '22'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

      - name: Run unit tests
        run: npm test -- --coverage

      - name: Check code coverage
        run: npm run test:coverage:check

      - name: Build production bundle
        run: npm run build

      - name: Upload build artifact
        uses: actions/upload-artifact@v3
        with:
          name: frontend-dist
          path: dist/
          retention-days: 7

  e2e-tests:
    needs: [backend-tests, frontend-tests]
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '22'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Install Playwright browsers
        run: npx playwright install --with-deps

      - name: Run E2E tests
        run: npx playwright test

      - name: Upload Playwright report
        if: failure()
        uses: actions/upload-artifact@v3
        with:
          name: playwright-report
          path: playwright-report/
          retention-days: 30
```

**Key Features**:
- ✅ Parallel backend and frontend test execution
- ✅ Dependency caching (Maven, npm)
- ✅ E2E tests run only after unit tests pass
- ✅ Build artifacts uploaded for deployment
- ✅ Test reports uploaded on failure

---

## Deployment to Staging Workflow

**File**: `.github/workflows/deploy-staging.yml`

**Purpose**: Automatically deploy to staging when main branch is updated

```yaml
name: Deploy to Staging

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push backend image
        uses: docker/build-push-action@v5
        with:
          context: ./backend
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/myapp-backend:staging
            ${{ secrets.DOCKER_USERNAME }}/myapp-backend:${{ github.sha }}
          cache-from: type=registry,ref=${{ secrets.DOCKER_USERNAME }}/myapp-backend:staging
          cache-to: type=inline

      - name: Build and push frontend image
        uses: docker/build-push-action@v5
        with:
          context: ./frontend
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/myapp-frontend:staging
            ${{ secrets.DOCKER_USERNAME }}/myapp-frontend:${{ github.sha }}
          cache-from: type=registry,ref=${{ secrets.DOCKER_USERNAME }}/myapp-frontend:staging
          cache-to: type=inline

      - name: Deploy to staging server
        env:
          SSH_PRIVATE_KEY: ${{ secrets.STAGING_SSH_KEY }}
          STAGING_HOST: ${{ secrets.STAGING_HOST }}
          STAGING_USER: ${{ secrets.STAGING_USER }}
        run: |
          echo "$SSH_PRIVATE_KEY" > deploy_key
          chmod 600 deploy_key
          ssh -i deploy_key -o StrictHostKeyChecking=no $STAGING_USER@$STAGING_HOST << 'EOF'
            cd /opt/myapp
            docker-compose pull
            docker-compose up -d
            docker-compose logs --tail=50
          EOF

      - name: Run smoke tests
        run: |
          sleep 10
          curl -f https://staging.myapp.com/health || exit 1
          curl -f https://staging.myapp.com/api/health || exit 1

      - name: Notify on failure
        if: failure()
        run: echo "Staging deployment failed!"
```

**Key Features**:
- ✅ Triggers on push to main
- ✅ Builds Docker images with multi-stage builds
- ✅ Tags with staging + commit SHA
- ✅ Uses Docker layer caching for speed
- ✅ Deploys via SSH
- ✅ Runs smoke tests
- ✅ Notification on failure

---

## Deployment to Production Workflow

**File**: `.github/workflows/deploy-production.yml`

**Purpose**: Manual deployment to production with approval

```yaml
name: Deploy to Production

on:
  workflow_dispatch:
    inputs:
      version:
        description: 'Version to deploy (e.g., v1.2.3)'
        required: true
        type: string

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://myapp.com
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          ref: ${{ inputs.version }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push backend image
        uses: docker/build-push-action@v5
        with:
          context: ./backend
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/myapp-backend:latest
            ${{ secrets.DOCKER_USERNAME }}/myapp-backend:${{ inputs.version }}

      - name: Build and push frontend image
        uses: docker/build-push-action@v5
        with:
          context: ./frontend
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/myapp-frontend:latest
            ${{ secrets.DOCKER_USERNAME }}/myapp-frontend:${{ inputs.version }}

      - name: Deploy to production
        env:
          SSH_PRIVATE_KEY: ${{ secrets.PRODUCTION_SSH_KEY }}
          PRODUCTION_HOST: ${{ secrets.PRODUCTION_HOST }}
          PRODUCTION_USER: ${{ secrets.PRODUCTION_USER }}
        run: |
          echo "$SSH_PRIVATE_KEY" > deploy_key
          chmod 600 deploy_key
          ssh -i deploy_key -o StrictHostKeyChecking=no $PRODUCTION_USER@$PRODUCTION_HOST << 'EOF'
            cd /opt/myapp
            docker-compose pull
            docker-compose up -d --no-deps --build
            docker-compose logs --tail=50
          EOF

      - name: Run smoke tests
        run: |
          sleep 15
          curl -f https://myapp.com/health || exit 1
          curl -f https://myapp.com/api/health || exit 1

      - name: Notify success
        if: success()
        run: echo "✅ Production deployment successful"

      - name: Rollback on failure
        if: failure()
        run: |
          echo "❌ Deployment failed, initiating rollback"
          # Add rollback commands here
```

**Key Features**:
- ✅ Manual trigger (workflow_dispatch)
- ✅ Requires version tag input
- ✅ Uses GitHub Environments (manual approval in repo settings)
- ✅ Tags images with version + latest
- ✅ Runs smoke tests
- ✅ Rollback support on failure
- ✅ Success/failure notifications

---

## GitHub Secrets Configuration

**Required Secrets** (GitHub repo → Settings → Secrets and variables → Actions):

### Docker Hub

| Secret | Description | Example Value |
|--------|-------------|---------------|
| `DOCKER_USERNAME` | Docker Hub username | myusername |
| `DOCKER_PASSWORD` | Docker Hub access token | dckr_pat_... |

### Staging Environment

| Secret | Description | Example Value |
|--------|-------------|---------------|
| `STAGING_HOST` | Staging server IP/hostname | staging.myapp.com |
| `STAGING_USER` | SSH username | ubuntu |
| `STAGING_SSH_KEY` | SSH private key | -----BEGIN OPENSSH PRIVATE KEY----- |

### Production Environment

| Secret | Description | Example Value |
|--------|-------------|---------------|
| `PRODUCTION_HOST` | Production server IP/hostname | myapp.com |
| `PRODUCTION_USER` | SSH username | ubuntu |
| `PRODUCTION_SSH_KEY` | SSH private key | -----BEGIN OPENSSH PRIVATE KEY----- |

### Application Secrets

| Secret | Description | Example Value |
|--------|-------------|---------------|
| `DATABASE_URL_STAGING` | PostgreSQL connection string (staging) | postgres://user:pass@host:5432/db |
| `DATABASE_URL_PRODUCTION` | PostgreSQL connection string (production) | postgres://user:pass@host:5432/db |
| `JWT_SECRET` | JWT signing key | random-secure-string |

---

## GitHub Environments Configuration

**Setup** (GitHub repo → Settings → Environments):

### Staging Environment

**Name**: `staging`

**Protection Rules**: None (auto-deploy)

**Environment Secrets**:
- DATABASE_URL (staging database)
- API_URL (staging API endpoint)

### Production Environment

**Name**: `production`

**Protection Rules**:
- [x] Required reviewers: [Your username]
- [x] Wait timer: 0 minutes

**Environment Secrets**:
- DATABASE_URL (production database)
- API_URL (production API endpoint)

---

## Caching Strategy

### Maven Dependency Caching

```yaml
- name: Set up JDK 17
  uses: actions/setup-java@v4
  with:
    java-version: '17'
    distribution: 'temurin'
    cache: 'maven'  # ← Automatic Maven caching
```

**Benefit**: Speeds up builds by ~2-3 minutes

### npm Dependency Caching

```yaml
- name: Set up Node.js
  uses: actions/setup-node@v4
  with:
    node-version: '22'
    cache: 'npm'  # ← Automatic npm caching
```

**Benefit**: Speeds up builds by ~1-2 minutes

### Docker Layer Caching

```yaml
- name: Build and push backend image
  uses: docker/build-push-action@v5
  with:
    cache-from: type=registry,ref=${{ secrets.DOCKER_USERNAME }}/myapp-backend:staging
    cache-to: type=inline
```

**Benefit**: Speeds up Docker builds by ~3-5 minutes

---

## Pipeline Optimization

### Parallel Job Execution

```yaml
jobs:
  backend-tests:
    runs-on: ubuntu-latest
    # ... backend tests

  frontend-tests:
    runs-on: ubuntu-latest
    # ... frontend tests

  # These run in parallel, saving time
```

**Benefit**: Reduces total pipeline time by 50%

### Conditional Job Execution

```yaml
e2e-tests:
  needs: [backend-tests, frontend-tests]  # Only run after both pass
  runs-on: ubuntu-latest
```

**Benefit**: Fail fast - skip E2E if unit tests fail

### Artifact Caching

```yaml
- name: Upload build artifact
  uses: actions/upload-artifact@v3
  with:
    name: backend-jar
    path: target/*.jar
    retention-days: 7  # Auto-cleanup after 7 days
```

**Benefit**: Reduces storage costs, enables artifact reuse

---

## Notification Configuration (Optional)

### Slack Notifications

```yaml
- name: Notify Slack on failure
  if: failure()
  uses: slackapi/slack-github-action@v1
  with:
    channel-id: 'deployments'
    slack-message: |
      ❌ CI Pipeline failed
      Commit: ${{ github.sha }}
      Author: ${{ github.actor }}
      Branch: ${{ github.ref }}
  env:
    SLACK_BOT_TOKEN: ${{ secrets.SLACK_BOT_TOKEN }}
```

### Email Notifications

```yaml
- name: Send email on failure
  if: failure()
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: "CI Pipeline Failed: ${{ github.ref }}"
    body: "Build failed for commit ${{ github.sha }}"
    to: team@example.com
    from: ci@example.com
```

---

## Monitoring and Debugging

### View Workflow Runs

**GitHub UI**: Repository → Actions tab

**See**:
- All workflow runs (past and present)
- Job status (pending, success, failure)
- Step-by-step logs
- Artifacts generated

### Debug Failed Workflows

**Enable Debug Logging**:
```yaml
on:
  workflow_dispatch:
    inputs:
      debug_enabled:
        description: 'Enable debug logging'
        required: false
        default: false

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Enable debug
        if: ${{ github.event.inputs.debug_enabled }}
        run: echo "::debug::Debugging enabled"
```

**SSH into Runner** (for debugging):
```yaml
- name: Setup tmate session
  if: failure()
  uses: mxschmitt/action-tmate@v3
```

---

## Implementation Checklist

**Setup**:
- [ ] Create `.github/workflows/` directory
- [ ] Create `ci.yml` workflow
- [ ] Create `deploy-staging.yml` workflow
- [ ] Create `deploy-production.yml` workflow

**Secrets Configuration**:
- [ ] Add Docker Hub credentials
- [ ] Add staging server credentials
- [ ] Add production server credentials
- [ ] Add application secrets

**Environment Configuration**:
- [ ] Create `staging` environment (no protection)
- [ ] Create `production` environment (with approval)
- [ ] Configure environment secrets

**Testing**:
- [ ] Push to feature branch (trigger CI)
- [ ] Verify all jobs run and pass
- [ ] Merge to main (trigger staging deployment)
- [ ] Verify staging deployment succeeds
- [ ] Manually trigger production deployment
- [ ] Approve production deployment
- [ ] Verify production deployment succeeds

**Optimization**:
- [ ] Verify dependency caching works
- [ ] Verify Docker layer caching works
- [ ] Check total pipeline execution time
- [ ] Optimize slow steps if needed

---

## Troubleshooting

### Common Issues

**Issue**: Tests fail in CI but pass locally
- **Cause**: Environment differences
- **Fix**: Check Node/Java versions match, verify environment variables

**Issue**: Docker build fails
- **Cause**: Missing dependencies or context
- **Fix**: Verify Dockerfile syntax, check .dockerignore

**Issue**: SSH deployment fails
- **Cause**: Invalid SSH key or permissions
- **Fix**: Verify SSH key is valid, check server access

**Issue**: Cache not working
- **Cause**: Cache key mismatch
- **Fix**: Verify cache configuration, clear cache and rebuild

---

## Best Practices

1. **Fail Fast**: Run fast unit tests before slow E2E tests
2. **Parallel Execution**: Run independent jobs in parallel
3. **Caching**: Cache dependencies to speed up builds
4. **Artifact Management**: Upload artifacts with retention policies
5. **Environment Separation**: Use separate environments for staging/production
6. **Manual Approval**: Require approval for production deployments
7. **Smoke Tests**: Verify deployment with health checks
8. **Notifications**: Alert team on failures
9. **Security**: Never commit secrets, use GitHub Secrets
10. **Documentation**: Document workflow purpose and usage

---

## Example: Complete CI/CD Flow

**Developer Workflow**:
1. Developer creates feature branch
2. Developer pushes commits
3. CI runs automatically (tests + build)
4. Developer creates pull request
5. CI runs again on PR
6. Team reviews, approves PR
7. Developer merges to main
8. Staging deployment triggers automatically
9. Staging smoke tests pass
10. Team manually triggers production deployment
11. Production deployment requires approval
12. Approver reviews, approves
13. Production deployment executes
14. Production smoke tests pass
15. Feature live in production ✅

---

**CI/CD Configuration Complete!**

This configuration provides automated testing, building, and deployment with proper quality gates and approval processes.
