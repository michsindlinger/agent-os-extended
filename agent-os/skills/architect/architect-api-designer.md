---
name: architect-api-designer
description: Designs API contracts and specifications before implementation
version: 1.0
---

# Architect API Designer

Defines API contracts, endpoints, request/response schemas before implementation begins. Ensures Backend and Frontend teams work against the same specification.

## Trigger Conditions

```yaml
task_mentions:
  - "api design|api contract|api specification"
  - "endpoint|rest api|graphql schema"
  - "openapi|swagger|api-first"
file_extension:
  - .yaml
  - .json
file_contains:
  - "openapi:"
  - "swagger:"
always_active_for_agents:
  - architecture-agent
```

## When to Load

- Before implementing new API endpoints
- When defining service contracts
- API versioning decisions
- Integration planning

## Core Competencies

### OpenAPI/Swagger Specifications

```yaml
openapi: 3.0.3
info:
  title: [Service] API
  version: 1.0.0

paths:
  /api/v1/[resource]:
    get:
      summary: List [resources]
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/[Resource]List'
        '401':
          $ref: '#/components/responses/Unauthorized'

    post:
      summary: Create [resource]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Create[Resource]Request'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/[Resource]'
        '400':
          $ref: '#/components/responses/BadRequest'
        '422':
          $ref: '#/components/responses/ValidationError'
```

### REST Design Principles

#### URL Structure
```
GET    /api/v1/users           # List users
POST   /api/v1/users           # Create user
GET    /api/v1/users/{id}      # Get user
PUT    /api/v1/users/{id}      # Update user (full)
PATCH  /api/v1/users/{id}      # Update user (partial)
DELETE /api/v1/users/{id}      # Delete user

# Nested resources
GET    /api/v1/users/{id}/orders
POST   /api/v1/users/{id}/orders

# Actions (when CRUD doesn't fit)
POST   /api/v1/users/{id}/activate
POST   /api/v1/orders/{id}/cancel
```

#### HTTP Status Codes
| Code | Meaning | When to Use |
|------|---------|-------------|
| 200 | OK | GET, PUT, PATCH success |
| 201 | Created | POST success |
| 204 | No Content | DELETE success |
| 400 | Bad Request | Malformed request |
| 401 | Unauthorized | Missing/invalid auth |
| 403 | Forbidden | No permission |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Duplicate, version conflict |
| 422 | Unprocessable | Validation errors |
| 500 | Server Error | Internal error |

### Response Schemas

#### Success Response
```json
{
  "data": { ... },
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 150
  }
}
```

#### Error Response
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
}
```

## Best Practices

### API Design
1. Use nouns for resources, not verbs
2. Use plural names (/users not /user)
3. Version APIs in URL (/api/v1/)
4. Use query params for filtering/pagination
5. Return consistent error format

### Schema Design
1. Use $ref for reusable components
2. Define required fields explicitly
3. Include examples in schemas
4. Document all possible error codes
5. Use meaningful enum values

### Versioning Strategy
| Strategy | Pros | Cons |
|----------|------|------|
| URL (/v1/) | Clear, cacheable | URL changes |
| Header | Clean URLs | Less visible |
| Query param | Simple | Non-standard |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Verbs in URLs | /getUsers | GET /users |
| Ignoring HTTP methods | POST for everything | Use proper methods |
| Inconsistent naming | user_id vs userId | Pick one convention |
| No pagination | Memory issues | Always paginate lists |
| 200 for errors | Hides issues | Use proper status codes |

## Checklist

### Before Implementation
- [ ] OpenAPI spec defined
- [ ] All endpoints documented
- [ ] Request/response schemas complete
- [ ] Error responses defined
- [ ] Examples provided
- [ ] Pagination specified for lists

### API Review
- [ ] Consistent naming conventions
- [ ] Proper HTTP methods
- [ ] Correct status codes
- [ ] Versioning in place
- [ ] Security requirements documented

## Integration

### Works With
- architect-pattern-enforcer (folder structure)
- architect-security-guardian (auth requirements)
- backend skills (implementation)
- frontend skills (API consumption)

### Output
- `api/openapi.yaml` or `api/swagger.json`
- Mock server configuration
- Client SDK generation config
