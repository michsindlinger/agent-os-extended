# Backend → Frontend Handoff

> Template for documenting completed backend work for frontend team
> Use this template after completing backend API implementation

## Handoff Summary

**Feature**: [Feature Name, e.g., User Management API]
**Backend Developer**: backend-dev
**Date**: [Completion Date]
**Status**: ✅ Complete and tested

---

## API Endpoints Implemented

### [Resource] Endpoints

| Method | Endpoint | Request Body | Response | Status Codes | Notes |
|--------|----------|--------------|----------|--------------|-------|
| GET | /api/[resources] | - | [Resource][] | 200 | Supports pagination (?page=1&size=20) |
| GET | /api/[resources]/{id} | - | [Resource]DTO | 200, 404 | Single resource by ID |
| POST | /api/[resources] | [Resource]CreateRequest | [Resource]DTO | 201, 400, 409 | Create new resource |
| PUT | /api/[resources]/{id} | [Resource]UpdateRequest | [Resource]DTO | 200, 400, 404 | Update existing resource |
| DELETE | /api/[resources]/{id} | - | - | 204, 404 | Delete resource |

**Example Table**:
| Method | Endpoint | Request Body | Response | Status Codes | Notes |
|--------|----------|--------------|----------|--------------|-------|
| GET | /api/users | - | User[] | 200 | Supports ?page=1&size=20&sort=name,asc |
| GET | /api/users/{id} | - | UserDTO | 200, 404 | Returns user by ID |
| POST | /api/users | UserCreateRequest | UserDTO | 201, 400, 409 | Validates email uniqueness |
| PUT | /api/users/{id} | UserUpdateRequest | UserDTO | 200, 400, 404 | Updates user name |
| DELETE | /api/users/{id} | - | - | 204, 404 | Deletes user if no dependencies |

---

## Request/Response Models

### [Resource]DTO (Response)

**Description**: Full resource representation returned by API

**TypeScript Interface**:
```typescript
interface [Resource]DTO {
  id: number;
  field1: string;
  field2: string;
  createdAt: string;  // ISO 8601 format
  updatedAt: string;  // ISO 8601 format
}
```

**Example JSON**:
```json
{
  "id": 1,
  "field1": "value1",
  "field2": "value2",
  "createdAt": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-01-16T12:00:00Z"
}
```

**Example (User)**:
```typescript
interface UserDTO {
  id: number;
  email: string;
  name: string;
  role: string;
  createdAt: string;
  updatedAt: string;
}
```

```json
{
  "id": 1,
  "email": "alice@example.com",
  "name": "Alice Johnson",
  "role": "admin",
  "createdAt": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-01-15T10:30:00Z"
}
```

---

### [Resource]CreateRequest (POST Body)

**Description**: Data required to create new resource

**TypeScript Interface**:
```typescript
interface [Resource]CreateRequest {
  field1: string;  // Validation: 2-100 chars
  field2: string;  // Validation: Valid email format
}
```

**Example JSON**:
```json
{
  "field1": "value1",
  "field2": "value2"
}
```

**Validation Rules**:
| Field | Type | Required | Constraints | Error Message |
|-------|------|----------|-------------|---------------|
| field1 | string | Yes | 2-100 chars | "Field1 must be 2-100 characters" |
| field2 | string | Yes | Valid email | "Field2 must be a valid email" |

**Example (User)**:
```typescript
interface UserCreateRequest {
  email: string;  // Must be valid email, unique
  name: string;   // 2-100 characters
}
```

```json
{
  "email": "bob@example.com",
  "name": "Bob Smith"
}
```

---

### [Resource]UpdateRequest (PUT Body)

**Description**: Data required to update existing resource

**TypeScript Interface**:
```typescript
interface [Resource]UpdateRequest {
  field1: string;  // Validation: 2-100 chars
}
```

**Example JSON**:
```json
{
  "field1": "updated value"
}
```

**Example (User)**:
```typescript
interface UserUpdateRequest {
  name: string;  // 2-100 characters
}
```

```json
{
  "name": "Alice Updated"
}
```

---

### ErrorResponse (Error Body)

**Description**: Standard error response format for all errors

**TypeScript Interface**:
```typescript
interface ErrorResponse {
  status: number;
  message: string;
  timestamp: string;  // ISO 8601 format
}
```

**Example JSON**:
```json
{
  "status": 404,
  "message": "User not found with id: 999",
  "timestamp": "2025-12-28T10:30:00Z"
}
```

**Common Error Responses**:

**404 Not Found**:
```json
{
  "status": 404,
  "message": "[Resource] not found with id: {id}",
  "timestamp": "2025-12-28T10:30:00Z"
}
```

**400 Validation Error**:
```json
{
  "status": 400,
  "message": "Field1 must be 2-100 characters, Field2 must be a valid email",
  "timestamp": "2025-12-28T10:30:00Z"
}
```

**409 Duplicate**:
```json
{
  "status": 409,
  "message": "[Resource] already exists with [field]: {value}",
  "timestamp": "2025-12-28T10:30:00Z"
}
```

---

## Pagination Support

**Endpoints with Pagination**:
- `GET /api/[resources]`

**Query Parameters**:
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| page | integer | No | 1 | Page number (1-based for frontend, 0-based internally) |
| size | integer | No | 20 | Items per page |
| sort | string | No | id,asc | Sort field and direction (e.g., "name,desc") |

**Response Format**:
```typescript
interface PaginatedResponse<T> {
  content: T[];
  page: number;
  size: number;
  totalElements: number;
  totalPages: number;
  first: boolean;
  last: boolean;
}
```

**Example Response**:
```json
{
  "content": [
    { "id": 1, "field1": "value1", "field2": "value2" },
    { "id": 2, "field1": "value3", "field2": "value4" }
  ],
  "page": 1,
  "size": 20,
  "totalElements": 50,
  "totalPages": 3,
  "first": true,
  "last": false
}
```

---

## Integration Notes

### Base URL

**Development** (when backend runs locally):
```
http://localhost:8080
```

**Environment Variable**:
```typescript
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080';
```

### Headers

**Content-Type**:
```
Content-Type: application/json
```

**All requests and responses use JSON**

### Authentication

**Current Implementation**: Not implemented in this iteration

**Future Implementation**: JWT Bearer tokens
```typescript
headers: {
  'Authorization': `Bearer ${token}`,
  'Content-Type': 'application/json'
}
```

### CORS Configuration

**Development**: All origins allowed (`*`)

**Production**: Configure allowed origins in `application.yml`:
```yaml
cors:
  allowed-origins: https://myapp.com
  allowed-methods: GET,POST,PUT,DELETE
  allowed-headers: '*'
```

### Error Handling

**All errors return ErrorResponse format**:
```typescript
try {
  const response = await fetch(`${API_BASE_URL}/api/users/999`);
  if (!response.ok) {
    const error: ErrorResponse = await response.json();
    throw new Error(error.message);
  }
  return await response.json();
} catch (err) {
  console.error('API error:', err);
  throw err;
}
```

---

## API Mocks for Development

**Location**: `api-mocks/[resources].json`

**Purpose**: Frontend can develop without running backend server

**Usage** (in frontend service):
```typescript
const USE_MOCKS = import.meta.env.MODE === 'development';
const mockData = USE_MOCKS ? require('../../api-mocks/users.json') : null;

export class UserService {
  static async getUsers(): Promise<User[]> {
    if (USE_MOCKS && mockData) {
      return mockData['GET /api/users'].body;
    }

    const response = await fetch(`${API_BASE_URL}/api/users`);
    return response.json();
  }
}
```

**Mock File**: `api-mocks/[resources].json` (see attached file)

**Coverage**:
- ✅ All success cases (200, 201, 204)
- ✅ All error cases (400, 404, 409)
- ✅ Validation error examples
- ✅ Realistic sample data

**Switch to Real API**:
```bash
# Use mocks (default in development)
MODE=development npm run dev

# Use real backend API
VITE_API_URL=http://localhost:8080 npm run dev
```

---

## Backend Test Results

### Unit Tests

**Framework**: JUnit 5 + Mockito

**Results**:
- Total Tests: [Number, e.g., 24]
- Passed: [Number, e.g., 24]
- Failed: 0
- Coverage: [Percentage, e.g., 92%] (target: ≥80%)

**Test Files**:
- `[Resource]ServiceTest.java` - [Number] tests
- `[Resource]ControllerTest.java` - [Number] tests (if applicable)

**Coverage Report**: `target/site/jacoco/index.html`

**Run Tests**:
```bash
mvn test
mvn jacoco:report  # Generate coverage report
```

---

### Integration Tests

**Framework**: Spring Test + TestContainers

**Results**:
- Total Tests: [Number, e.g., 12]
- Passed: [Number, e.g., 12]
- Failed: 0

**Test Coverage**:
- ✅ All API endpoints tested
- ✅ All success cases verified
- ✅ All error cases verified (404, 400, 409)
- ✅ Pagination tested
- ✅ Validation rules tested

**Run Integration Tests**:
```bash
mvn verify
```

---

## Files Modified/Created

### Backend Source Files

**Controllers**:
- `src/main/java/com/example/[project]/controller/[Resource]Controller.java`

**Services**:
- `src/main/java/com/example/[project]/service/[Resource]Service.java`

**Repositories**:
- `src/main/java/com/example/[project]/repository/[Resource]Repository.java`

**Entities**:
- `src/main/java/com/example/[project]/entity/[Resource].java`

**DTOs**:
- `src/main/java/com/example/[project]/dto/[Resource]DTO.java`
- `src/main/java/com/example/[project]/dto/[Resource]CreateRequest.java`
- `src/main/java/com/example/[project]/dto/[Resource]UpdateRequest.java`

**Exceptions**:
- `src/main/java/com/example/[project]/exception/[Resource]NotFoundException.java`
- `src/main/java/com/example/[project]/exception/Duplicate[Field]Exception.java`
- `src/main/java/com/example/[project]/exception/GlobalExceptionHandler.java` (updated)

**Tests**:
- `src/test/java/com/example/[project]/service/[Resource]ServiceTest.java`
- `src/test/java/com/example/[project]/integration/[Resource]IntegrationTest.java` (if applicable)

### API Mocks

**Mock Files**:
- `api-mocks/[resources].json` - Complete API mocks for frontend development

---

## Database Schema

**Table**: `[table_name]`

**Columns**:
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | Resource ID |
| field1 | VARCHAR(100) | NOT NULL | Description |
| field2 | VARCHAR(255) | NOT NULL, UNIQUE | Description |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

**Indexes**:
- `idx_[field]` on `[field]` (for uniqueness checks)

**Migrations**:
- ✅ Migration script: `db/migration/V1__create_[table].sql` (Flyway)
- ✅ Applied successfully

---

## Next Steps for Frontend

### 1. Review API Documentation
- [ ] Review endpoint table
- [ ] Review request/response models
- [ ] Understand error handling

### 2. Setup API Service
- [ ] Create `src/services/[Resource]Service.ts`
- [ ] Implement all API methods (GET, POST, PUT, DELETE)
- [ ] Integrate API mocks for development
- [ ] Handle errors properly

### 3. Create TypeScript Types
- [ ] Create `src/types/[Resource].ts`
- [ ] Define [Resource]DTO interface
- [ ] Define [Resource]CreateRequest interface
- [ ] Define [Resource]UpdateRequest interface
- [ ] Define ErrorResponse interface

### 4. Implement Components
- [ ] Create list component (uses GET /api/[resources])
- [ ] Create detail component (uses GET /api/[resources]/{id})
- [ ] Create form component (uses POST/PUT)
- [ ] Create delete confirmation (uses DELETE)

### 5. Test Integration
- [ ] Test with mocks (development mode)
- [ ] Test with real API (backend running locally)
- [ ] Verify error handling (404, 400, 409 cases)
- [ ] Test pagination (if applicable)

---

## Support & Questions

**Questions about API**:
- Check this handoff document first
- Review API mock file: `api-mocks/[resources].json`
- Review backend code in `src/main/java/...`

**Backend Running Locally**:
```bash
# Start backend server
mvn spring-boot:run

# Backend available at: http://localhost:8080
# API endpoints: http://localhost:8080/api/[resources]
```

**API Testing** (with curl):
```bash
# List all resources
curl http://localhost:8080/api/[resources]

# Get single resource
curl http://localhost:8080/api/[resources]/1

# Create resource
curl -X POST http://localhost:8080/api/[resources] \
  -H "Content-Type: application/json" \
  -d '{"field1": "value1", "field2": "value2"}'

# Update resource
curl -X PUT http://localhost:8080/api/[resources]/1 \
  -H "Content-Type: application/json" \
  -d '{"field1": "updated value"}'

# Delete resource
curl -X DELETE http://localhost:8080/api/[resources]/1
```

---

## Handoff Checklist

**Backend Deliverables**:
- [x] All API endpoints implemented
- [x] Request/response DTOs defined
- [x] Validation rules implemented
- [x] Exception handling configured
- [x] Unit tests written (≥80% coverage)
- [x] Integration tests written
- [x] All tests passing
- [x] API mocks generated
- [x] Database migrations applied
- [x] This handoff document complete

**Frontend Action Items**:
- [ ] Review API documentation
- [ ] Create TypeScript types
- [ ] Implement API service
- [ ] Create components
- [ ] Test with mocks
- [ ] Test with real API

---

**Status**: ✅ Ready for frontend implementation

**Backend Developer**: backend-dev
**Handoff Date**: [Date]
