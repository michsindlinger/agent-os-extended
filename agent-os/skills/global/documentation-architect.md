---
name: documentation-architect
description: Creates and maintains comprehensive project documentation
version: 1.0
---

# Documentation Architect

Creates and maintains clear, comprehensive documentation including READMEs, API docs, guides, and architecture documentation.

## Trigger Conditions

```yaml
task_mentions:
  - "documentation|docs|readme"
  - "api docs|swagger|openapi"
  - "guide|tutorial|howto"
file_extension:
  - .md
  - .mdx
  - .rst
file_contains:
  - "## Getting Started"
  - "## Installation"
  - "## API Reference"
always_active: true
```

## When to Load

- Creating new documentation
- Updating existing docs
- API documentation
- Architecture documentation

## Core Competencies

### README Structure

```markdown
# Project Name

> Short tagline describing the project

[![Build Status](badge)](link)
[![npm version](badge)](link)
[![License](badge)](link)

Brief description of what this project does and why it exists (2-3 sentences).

## Features

- ✅ Feature 1 - brief description
- ✅ Feature 2 - brief description
- ✅ Feature 3 - brief description

## Quick Start

```bash
# Install
npm install package-name

# Configure
cp .env.example .env

# Run
npm start
```

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [License](#license)

## Installation

### Prerequisites

- Node.js 18+
- PostgreSQL 14+

### Steps

1. Clone the repository
   ```bash
   git clone https://github.com/org/repo.git
   cd repo
   ```

2. Install dependencies
   ```bash
   npm install
   ```

3. Configure environment
   ```bash
   cp .env.example .env
   # Edit .env with your settings
   ```

4. Start the application
   ```bash
   npm run dev
   ```

## Usage

### Basic Example

```typescript
import { Client } from 'package-name';

const client = new Client({ apiKey: 'your-key' });
const result = await client.doSomething();
```

### Advanced Usage

[Link to detailed guides]

## Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | `3000` |
| `DATABASE_URL` | PostgreSQL connection string | - |
| `API_KEY` | API authentication key | - |

## API Reference

See [API Documentation](./docs/api.md) for full reference.

### Quick Reference

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/users` | GET | List all users |
| `/users/:id` | GET | Get user by ID |
| `/users` | POST | Create user |

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## License

[MIT](./LICENSE)
```

### API Documentation

```markdown
# API Reference

## Authentication

All API requests require authentication using an API key:

```bash
curl -H "Authorization: Bearer YOUR_API_KEY" https://api.example.com/v1/users
```

## Endpoints

### Users

#### List Users

```http
GET /api/v1/users
```

**Query Parameters**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `page` | integer | No | Page number (default: 1) |
| `limit` | integer | No | Items per page (default: 20, max: 100) |
| `status` | string | No | Filter by status (active, inactive) |

**Response**

```json
{
  "data": [
    {
      "id": "usr_123",
      "email": "user@example.com",
      "name": "John Doe",
      "createdAt": "2024-01-15T10:30:00Z"
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 150
  }
}
```

**Example**

```bash
curl -X GET "https://api.example.com/v1/users?page=1&limit=10" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

#### Create User

```http
POST /api/v1/users
```

**Request Body**

```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "role": "user"
}
```

**Response** `201 Created`

```json
{
  "data": {
    "id": "usr_124",
    "email": "user@example.com",
    "name": "John Doe",
    "role": "user",
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

## Error Handling

### Error Response Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request body",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
}
```

### Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `VALIDATION_ERROR` | 400 | Invalid request data |
| `UNAUTHORIZED` | 401 | Invalid or missing API key |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `RATE_LIMITED` | 429 | Too many requests |
| `INTERNAL_ERROR` | 500 | Server error |
```

### Architecture Documentation

```markdown
# Architecture Overview

## System Context

```
┌─────────────────────────────────────────────────────────────┐
│                      External Systems                        │
├─────────────────────────────────────────────────────────────┤
│  Payment Gateway    Email Service    Analytics Platform     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      Our Application                         │
├─────────────────────────────────────────────────────────────┤
│  Web App  │  Mobile App  │  API Clients                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      API Gateway                             │
├─────────────────────────────────────────────────────────────┤
│  Rate Limiting  │  Auth  │  Routing  │  Logging            │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      Microservices                           │
├─────────────────────────────────────────────────────────────┤
│  User Service  │  Order Service  │  Payment Service         │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                              │
├─────────────────────────────────────────────────────────────┤
│  PostgreSQL  │  Redis  │  Elasticsearch  │  S3              │
└─────────────────────────────────────────────────────────────┘
```

## Key Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Architecture | Microservices | Team scaling, independent deployment |
| Database | PostgreSQL | ACID compliance, JSON support |
| Cache | Redis | Performance, pub/sub capability |
| Queue | RabbitMQ | Reliable message delivery |
```

## Best Practices

### Writing Clear Documentation

| Principle | Application |
|-----------|-------------|
| Start with why | Explain purpose before how |
| Use examples | Show, don't just tell |
| Keep current | Update with code changes |
| Be scannable | Use headers, lists, tables |
| Test instructions | Verify steps work |

### Code Examples

```markdown
<!-- Good: Complete, runnable example -->
```typescript
import { createClient } from 'our-package';

// Initialize with your API key
const client = createClient({
  apiKey: process.env.API_KEY,
  timeout: 5000
});

// Make a request
const users = await client.users.list({ limit: 10 });
console.log(users);
```

<!-- Bad: Incomplete snippet -->
```typescript
const users = client.users.list();
```
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| No examples | Hard to understand | Add runnable examples |
| Outdated docs | Confusion, errors | Update with each change |
| Jargon-heavy | Excludes newcomers | Define terms, simplify |
| Wall of text | Hard to scan | Use structure, formatting |
| Missing context | Incomplete picture | Explain why, not just what |

## Checklist

### README
- [ ] Clear project description
- [ ] Installation instructions
- [ ] Quick start example
- [ ] Configuration documented
- [ ] Links to detailed docs

### API Documentation
- [ ] All endpoints documented
- [ ] Request/response examples
- [ ] Error codes explained
- [ ] Authentication described

### Maintenance
- [ ] Docs reviewed with PRs
- [ ] Examples tested
- [ ] Links verified
- [ ] Version specific info noted

## Integration

### Works With
- changelog-manager (release docs)
- git-master (contributing guide)
- architect-api-designer (API docs)

### Output
- README.md
- API documentation
- Architecture diagrams
- User guides
