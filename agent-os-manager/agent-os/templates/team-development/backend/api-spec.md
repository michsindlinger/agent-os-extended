# REST API Endpoint Specification

> Template for documenting REST API endpoint requirements
> Use this template when planning a new API endpoint or resource

## Endpoint Overview

**Resource**: [Resource Name, e.g., User, Product, Order]
**Base Path**: `/api/[resource-plural]`
**Purpose**: [Brief description of what this API manages]

## Endpoints

### List All [Resources]

**Method**: `GET`
**Path**: `/api/[resources]`
**Description**: Retrieve a list of all [resources]

**Query Parameters**:
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| page | integer | No | 1 | Page number (1-based) |
| size | integer | No | 20 | Items per page |
| sort | string | No | id,asc | Sort field and direction |
| search | string | No | - | Search term (filters by name/description) |

**Success Response** (200 OK):
```json
{
  "content": [
    {
      "id": 1,
      "field1": "value1",
      "field2": "value2",
      "createdAt": "2025-01-15T10:30:00Z"
    }
  ],
  "page": 1,
  "size": 20,
  "totalElements": 100,
  "totalPages": 5
}
```

**Error Responses**:
- 400 Bad Request: Invalid query parameters
- 500 Internal Server Error: Server error

---

### Get [Resource] by ID

**Method**: `GET`
**Path**: `/api/[resources]/{id}`
**Description**: Retrieve a single [resource] by ID

**Path Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | integer | Yes | [Resource] ID |

**Success Response** (200 OK):
```json
{
  "id": 1,
  "field1": "value1",
  "field2": "value2",
  "createdAt": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-01-16T12:00:00Z"
}
```

**Error Responses**:
- 404 Not Found: [Resource] not found with given ID
- 500 Internal Server Error: Server error

---

### Create [Resource]

**Method**: `POST`
**Path**: `/api/[resources]`
**Description**: Create a new [resource]

**Request Body**:
```json
{
  "field1": "value1",
  "field2": "value2"
}
```

**Validation Rules**:
| Field | Type | Required | Constraints | Error Message |
|-------|------|----------|-------------|---------------|
| field1 | string | Yes | 2-100 chars | "Field1 is required and must be 2-100 characters" |
| field2 | string | Yes | Valid email | "Field2 must be a valid email" |

**Success Response** (201 Created):
```json
{
  "id": 2,
  "field1": "value1",
  "field2": "value2",
  "createdAt": "2025-01-20T11:00:00Z",
  "updatedAt": "2025-01-20T11:00:00Z"
}
```

**Error Responses**:
- 400 Bad Request: Validation errors (see validation rules)
- 409 Conflict: [Resource] already exists (e.g., duplicate email)
- 500 Internal Server Error: Server error

---

### Update [Resource]

**Method**: `PUT`
**Path**: `/api/[resources]/{id}`
**Description**: Update an existing [resource]

**Path Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | integer | Yes | [Resource] ID to update |

**Request Body**:
```json
{
  "field1": "updated value"
}
```

**Validation Rules**:
| Field | Type | Required | Constraints | Error Message |
|-------|------|----------|-------------|---------------|
| field1 | string | Yes | 2-100 chars | "Field1 is required and must be 2-100 characters" |

**Success Response** (200 OK):
```json
{
  "id": 1,
  "field1": "updated value",
  "field2": "value2",
  "createdAt": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-01-21T14:30:00Z"
}
```

**Error Responses**:
- 400 Bad Request: Validation errors
- 404 Not Found: [Resource] not found with given ID
- 500 Internal Server Error: Server error

---

### Delete [Resource]

**Method**: `DELETE`
**Path**: `/api/[resources]/{id}`
**Description**: Delete a [resource] by ID

**Path Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | integer | Yes | [Resource] ID to delete |

**Success Response** (204 No Content):
```
(No body)
```

**Error Responses**:
- 404 Not Found: [Resource] not found with given ID
- 500 Internal Server Error: Server error

---

## Data Models

### [Resource] DTO (Response)

```typescript
interface [Resource]DTO {
  id: number;
  field1: string;
  field2: string;
  createdAt: string;  // ISO 8601 format
  updatedAt: string;  // ISO 8601 format
}
```

### [Resource] Create Request

```typescript
interface [Resource]CreateRequest {
  field1: string;  // 2-100 chars
  field2: string;  // Valid email
}
```

### [Resource] Update Request

```typescript
interface [Resource]UpdateRequest {
  field1: string;  // 2-100 chars
}
```

### Error Response

```typescript
interface ErrorResponse {
  status: number;
  message: string;
  timestamp: string;  // ISO 8601 format
}
```

---

## Business Rules

1. **[Rule 1]**: [Description, e.g., Email must be unique across all users]
2. **[Rule 2]**: [Description, e.g., Cannot delete user with active orders]
3. **[Rule 3]**: [Description, e.g., Name is case-insensitive for uniqueness check]

---

## Implementation Checklist

**Controller Layer**:
- [ ] Create `[Resource]Controller.java` with all endpoints
- [ ] Add @RestController and @RequestMapping annotations
- [ ] Use @Valid for request validation
- [ ] Return proper ResponseEntity with status codes

**Service Layer**:
- [ ] Create `[Resource]Service.java` with business logic
- [ ] Implement all CRUD operations
- [ ] Add @Transactional annotations
- [ ] Implement business rule validations
- [ ] Throw custom exceptions for error cases

**Repository Layer**:
- [ ] Create `[Resource]Repository.java` interface
- [ ] Extend JpaRepository<[Resource], Long>
- [ ] Add custom query methods if needed

**Data Layer**:
- [ ] Create `[Resource].java` entity with JPA annotations
- [ ] Create `[Resource]DTO.java` for responses
- [ ] Create `[Resource]CreateRequest.java` for create operations
- [ ] Create `[Resource]UpdateRequest.java` for update operations

**Exception Handling**:
- [ ] Create `[Resource]NotFoundException.java`
- [ ] Create other custom exceptions as needed
- [ ] Add exception handlers to GlobalExceptionHandler

**Testing**:
- [ ] Unit tests for Service layer (>80% coverage)
- [ ] Integration tests for API endpoints
- [ ] Test validation rules
- [ ] Test error cases (404, 400, 409)

**API Mocks**:
- [ ] Generate mocks for all endpoints (success + error cases)
- [ ] Save to `api-mocks/[resources].json`

---

## Example Implementation

**Controller**:
```java
@RestController
@RequestMapping("/api/users")
@Validated
public class UserController {

  private final UserService userService;

  public UserController(UserService userService) {
    this.userService = userService;
  }

  @GetMapping
  public ResponseEntity<Page<UserDTO>> getAllUsers(
    @RequestParam(defaultValue = "1") int page,
    @RequestParam(defaultValue = "20") int size
  ) {
    Page<UserDTO> users = userService.getAllUsers(page - 1, size);
    return ResponseEntity.ok(users);
  }

  @GetMapping("/{id}")
  public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
    UserDTO user = userService.getUserById(id);
    return ResponseEntity.ok(user);
  }

  @PostMapping
  public ResponseEntity<UserDTO> createUser(@Valid @RequestBody UserCreateRequest request) {
    UserDTO user = userService.createUser(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(user);
  }

  @PutMapping("/{id}")
  public ResponseEntity<UserDTO> updateUser(
    @PathVariable Long id,
    @Valid @RequestBody UserUpdateRequest request
  ) {
    UserDTO user = userService.updateUser(id, request);
    return ResponseEntity.ok(user);
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
    userService.deleteUser(id);
    return ResponseEntity.noContent().build();
  }
}
```

---

## Notes

- Use ISO 8601 format for all timestamps
- All endpoints return JSON (Content-Type: application/json)
- Use proper HTTP status codes (200, 201, 204, 400, 404, 409, 500)
- Validate all inputs on both client and server side
- Return consistent error response format
- Include audit fields (createdAt, updatedAt) in all entities
