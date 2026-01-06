---
name: pipeline-engineer
description: Designs and implements CI/CD pipelines for automated deployments
version: 1.0
---

# Pipeline Engineer

Creates robust CI/CD pipelines for automated testing, building, and deployment using GitHub Actions, GitLab CI, or other CI/CD platforms.

## Trigger Conditions

```yaml
task_mentions:
  - "ci/cd|pipeline|workflow"
  - "github actions|gitlab ci|jenkins"
  - "deploy|build|release"
  - "continuous integration|continuous deployment"
file_extension:
  - .yml
  - .yaml
file_contains:
  - "on:"
  - "jobs:"
  - "stages:"
  - "pipeline"
always_active_for_agents:
  - devops-agent
```

## When to Load

- Setting up CI/CD pipelines
- Optimizing build times
- Adding deployment stages
- Implementing release workflows

## Core Competencies

### GitHub Actions Workflow Structure

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

env:
  NODE_VERSION: '20'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  lint:
    name: Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

  test:
    name: Test
    runs-on: ubuntu-latest
    needs: lint

    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: test
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test -- --coverage
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/test

      - name: Upload coverage
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.CODECOV_TOKEN }}

  build:
    name: Build
    runs-on: ubuntu-latest
    needs: test
    if: github.event_name == 'push'

    permissions:
      contents: read
      packages: write

    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=sha,prefix=
            type=raw,value=latest,enable=${{ github.ref == 'refs/heads/main' }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

### Deployment Workflow

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy to'
        required: true
        type: choice
        options:
          - staging
          - production

  push:
    branches:
      - main

jobs:
  deploy-staging:
    name: Deploy to Staging
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' || github.event.inputs.environment == 'staging'
    environment:
      name: staging
      url: https://staging.example.com

    steps:
      - uses: actions/checkout@v4

      - name: Deploy to staging
        uses: digitalocean/app_action@v1
        with:
          app_name: myapp-staging
          token: ${{ secrets.DO_TOKEN }}

      - name: Run smoke tests
        run: |
          ./scripts/smoke-test.sh https://staging.example.com

      - name: Notify Slack
        if: always()
        uses: slackapi/slack-github-action@v1
        with:
          payload: |
            {
              "text": "Staging deployment ${{ job.status }}"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}

  deploy-production:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: deploy-staging
    if: github.event.inputs.environment == 'production'
    environment:
      name: production
      url: https://example.com

    steps:
      - uses: actions/checkout@v4

      - name: Deploy to production
        uses: digitalocean/app_action@v1
        with:
          app_name: myapp-production
          token: ${{ secrets.DO_TOKEN }}

      - name: Run smoke tests
        run: |
          ./scripts/smoke-test.sh https://example.com

      - name: Create release
        uses: softprops/action-gh-release@v1
        with:
          tag_name: v${{ github.run_number }}
          generate_release_notes: true
```

### Reusable Workflows

```yaml
# .github/workflows/reusable-test.yml
name: Reusable Test Workflow

on:
  workflow_call:
    inputs:
      node-version:
        required: false
        type: string
        default: '20'
    secrets:
      codecov-token:
        required: false

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
          cache: 'npm'

      - run: npm ci
      - run: npm test -- --coverage

      - name: Upload coverage
        if: ${{ secrets.codecov-token != '' }}
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.codecov-token }}

# Usage in another workflow
# jobs:
#   test:
#     uses: ./.github/workflows/reusable-test.yml
#     with:
#       node-version: '20'
#     secrets:
#       codecov-token: ${{ secrets.CODECOV_TOKEN }}
```

## Best Practices

### Caching Strategies

```yaml
# Node.js caching
- uses: actions/setup-node@v4
  with:
    node-version: '20'
    cache: 'npm'

# Docker layer caching
- uses: docker/build-push-action@v5
  with:
    cache-from: type=gha
    cache-to: type=gha,mode=max

# Custom caching
- uses: actions/cache@v4
  with:
    path: |
      ~/.gradle/caches
      ~/.gradle/wrapper
    key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*') }}
    restore-keys: |
      ${{ runner.os }}-gradle-
```

### Security Best Practices

```yaml
# Pin action versions
- uses: actions/checkout@v4.1.1  # Specific version

# Minimal permissions
permissions:
  contents: read
  packages: write

# Environment protection rules (in GitHub settings)
# - Required reviewers
# - Wait timer
# - Branch restrictions

# Secret scanning
- name: Scan for secrets
  uses: trufflesecurity/trufflehog@main
  with:
    extra_args: --only-verified
```

### Parallel Jobs

```yaml
jobs:
  # Run in parallel
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: npm run lint

  type-check:
    runs-on: ubuntu-latest
    steps:
      - run: npm run type-check

  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:unit

  # Run after all parallel jobs
  integration-tests:
    needs: [lint, type-check, unit-tests]
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:integration
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| No caching | Slow builds | Cache dependencies |
| Sequential jobs | Slow pipeline | Parallelize independent jobs |
| Secrets in logs | Security risk | Mask secrets, use `::add-mask::` |
| No concurrency control | Wasted resources | Use concurrency groups |
| Unpinned actions | Security/stability | Pin to specific versions |

## Checklist

### Pipeline Setup
- [ ] Caching configured
- [ ] Parallel jobs where possible
- [ ] Concurrency control
- [ ] Environment protection

### Security
- [ ] Secrets management
- [ ] Minimal permissions
- [ ] Action versions pinned
- [ ] Secret scanning enabled

### Operations
- [ ] Deployment notifications
- [ ] Rollback capability
- [ ] Smoke tests after deploy
- [ ] Release automation

## Integration

### Works With
- infrastructure-provisioner (deployment targets)
- security-hardener (security checks)
- git-master (release workflow)

### Output
- GitHub Actions workflows
- Deployment scripts
- Release automation
- Notification configs
