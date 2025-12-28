# Service Layer Class Specification

> Template for documenting service layer class requirements
> Use this template when planning business logic implementation

## Service Overview

**Service Name**: `[Resource]Service`
**Purpose**: [Brief description of business logic responsibility]
**Package**: `com.example.[project].service`

## Responsibilities

1. **[Responsibility 1]**: [e.g., Manage user CRUD operations]
2. **[Responsibility 2]**: [e.g., Validate business rules]
3. **[Responsibility 3]**: [e.g., Coordinate with repositories]
4. **[Responsibility 4]**: [e.g., Map entities to DTOs]

## Dependencies

**Repositories**:
- `[Resource]Repository` - Data access for [resource]
- `[Related]Repository` - (if needed) Data access for related entities

**Other Services** (if needed):
- `EmailService` - Send notification emails
- `ValidationService` - Complex validation logic

## Methods

### getAllResources()

**Purpose**: Retrieve all [resources] with optional pagination and filtering

**Signature**:
```java
@Transactional(readOnly = true)
public Page<[Resource]DTO> getAllResources(int page, int size, String sort)
```

**Parameters**:
- `page` (int): Page number (0-based)
- `size` (int): Items per page
- `sort` (String): Sort criteria (e.g., "name,asc")

**Returns**: `Page<[Resource]DTO>` - Paginated list of resources

**Business Logic**:
1. Create Pageable from page, size, sort parameters
2. Call repository.findAll(pageable)
3. Map entities to DTOs
4. Return paginated result

**Error Handling**:
- Invalid page/size: Throw IllegalArgumentException
- Invalid sort field: Use default sort (id,asc)

**Example**:
```java
@Transactional(readOnly = true)
public Page<UserDTO> getAllUsers(int page, int size, String sort) {
  Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
  Page<User> users = userRepository.findAll(pageable);
  return users.map(this::toDTO);
}
```

---

### getResourceById()

**Purpose**: Retrieve a single [resource] by ID

**Signature**:
```java
@Transactional(readOnly = true)
public [Resource]DTO getResourceById(Long id)
```

**Parameters**:
- `id` (Long): Resource ID

**Returns**: `[Resource]DTO` - Resource data

**Business Logic**:
1. Call repository.findById(id)
2. If not found, throw [Resource]NotFoundException
3. Map entity to DTO
4. Return DTO

**Error Handling**:
- Resource not found: Throw `[Resource]NotFoundException(id)`

**Example**:
```java
@Transactional(readOnly = true)
public UserDTO getUserById(Long id) {
  User user = userRepository.findById(id)
    .orElseThrow(() -> new UserNotFoundException(id));
  return toDTO(user);
}
```

---

### createResource()

**Purpose**: Create a new [resource]

**Signature**:
```java
@Transactional
public [Resource]DTO createResource([Resource]CreateRequest request)
```

**Parameters**:
- `request` ([Resource]CreateRequest): Creation data (already validated by @Valid)

**Returns**: `[Resource]DTO` - Created resource

**Business Logic**:
1. **Validate business rules**:
   - Check for duplicates (e.g., email already exists)
   - Verify related entities exist (if applicable)
   - Apply domain-specific validations
2. **Create entity**:
   - Instantiate new [Resource] entity
   - Set fields from request
   - Set audit fields (createdAt, updatedAt)
3. **Save entity**:
   - Call repository.save(entity)
4. **Map to DTO**:
   - Convert saved entity to DTO
5. **Return DTO**

**Error Handling**:
- Duplicate found: Throw `Duplicate[Field]Exception(value)`
- Related entity not found: Throw `Related[Entity]NotFoundException(id)`
- Validation error: Throw `ValidationException(message)`

**Example**:
```java
@Transactional
public UserDTO createUser(UserCreateRequest request) {
  // Business rule: Email must be unique
  if (userRepository.existsByEmail(request.email())) {
    throw new DuplicateEmailException(request.email());
  }

  // Create entity
  User user = new User();
  user.setEmail(request.email());
  user.setName(request.name());

  // Save
  User savedUser = userRepository.save(user);

  // Return DTO
  return toDTO(savedUser);
}
```

---

### updateResource()

**Purpose**: Update an existing [resource]

**Signature**:
```java
@Transactional
public [Resource]DTO updateResource(Long id, [Resource]UpdateRequest request)
```

**Parameters**:
- `id` (Long): Resource ID to update
- `request` ([Resource]UpdateRequest): Update data (already validated by @Valid)

**Returns**: `[Resource]DTO` - Updated resource

**Business Logic**:
1. **Find existing entity**:
   - Call repository.findById(id)
   - If not found, throw [Resource]NotFoundException
2. **Validate business rules**:
   - Check for duplicate fields (if updating unique fields)
   - Verify related entities exist (if applicable)
3. **Update entity**:
   - Update fields from request
   - Leave unchanged fields as-is
   - Update audit field (updatedAt)
4. **Save entity**:
   - Call repository.save(entity)
5. **Map to DTO**:
   - Convert updated entity to DTO
6. **Return DTO**

**Error Handling**:
- Resource not found: Throw `[Resource]NotFoundException(id)`
- Duplicate field: Throw `Duplicate[Field]Exception(value)`
- Validation error: Throw `ValidationException(message)`

**Example**:
```java
@Transactional
public UserDTO updateUser(Long id, UserUpdateRequest request) {
  // Find existing
  User user = userRepository.findById(id)
    .orElseThrow(() -> new UserNotFoundException(id));

  // Update fields
  user.setName(request.name());

  // Save
  User updatedUser = userRepository.save(user);

  // Return DTO
  return toDTO(updatedUser);
}
```

---

### deleteResource()

**Purpose**: Delete a [resource] by ID

**Signature**:
```java
@Transactional
public void deleteResource(Long id)
```

**Parameters**:
- `id` (Long): Resource ID to delete

**Returns**: void

**Business Logic**:
1. **Check existence**:
   - Call repository.existsById(id)
   - If not found, throw [Resource]NotFoundException
2. **Validate deletion rules**:
   - Check for dependencies (e.g., cannot delete user with active orders)
   - Apply business rules
3. **Delete entity**:
   - Call repository.deleteById(id)

**Error Handling**:
- Resource not found: Throw `[Resource]NotFoundException(id)`
- Deletion not allowed: Throw `CannotDelete[Resource]Exception(reason)`

**Example**:
```java
@Transactional
public void deleteUser(Long id) {
  // Check existence
  if (!userRepository.existsById(id)) {
    throw new UserNotFoundException(id);
  }

  // Business rule: Cannot delete user with active orders
  if (orderRepository.existsByUserId(id)) {
    throw new CannotDeleteUserException("User has active orders");
  }

  // Delete
  userRepository.deleteById(id);
}
```

---

## Helper Methods

### toDTO()

**Purpose**: Convert entity to DTO

**Signature**:
```java
private [Resource]DTO toDTO([Resource] entity)
```

**Example**:
```java
private UserDTO toDTO(User user) {
  return new UserDTO(
    user.getId(),
    user.getEmail(),
    user.getName(),
    user.getCreatedAt(),
    user.getUpdatedAt()
  );
}
```

---

### fromCreateRequest()

**Purpose**: Convert create request to entity (alternative to manual mapping)

**Signature**:
```java
private [Resource] fromCreateRequest([Resource]CreateRequest request)
```

**Example**:
```java
private User fromCreateRequest(UserCreateRequest request) {
  User user = new User();
  user.setEmail(request.email());
  user.setName(request.name());
  return user;
}
```

---

## Business Rules to Implement

1. **[Rule 1]**: [e.g., Email must be unique across all users]
   - Validation: Check `repository.existsByEmail(email)`
   - Exception: `DuplicateEmailException`

2. **[Rule 2]**: [e.g., Cannot delete user with active orders]
   - Validation: Check `orderRepository.existsByUserId(id)`
   - Exception: `CannotDeleteUserException`

3. **[Rule 3]**: [e.g., Name is case-insensitive for search]
   - Implementation: Use `repository.findByNameIgnoreCase(name)`

---

## Exception Classes Needed

**Custom Exceptions**:
```java
public class [Resource]NotFoundException extends RuntimeException {
  public [Resource]NotFoundException(Long id) {
    super("[Resource] not found with id: " + id);
  }
}

public class Duplicate[Field]Exception extends RuntimeException {
  public Duplicate[Field]Exception(String value) {
    super("[Resource] already exists with [field]: " + value);
  }
}

public class CannotDelete[Resource]Exception extends RuntimeException {
  public CannotDelete[Resource]Exception(String reason) {
    super("Cannot delete [resource]: " + reason);
  }
}
```

---

## Full Service Template

```java
package com.example.project.service;

import com.example.project.dto.*;
import com.example.project.entity.[Resource];
import com.example.project.repository.[Resource]Repository;
import com.example.project.exception.*;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class [Resource]Service {

  private final [Resource]Repository [resource]Repository;

  public [Resource]Service([Resource]Repository [resource]Repository) {
    this.[resource]Repository = [resource]Repository;
  }

  @Transactional(readOnly = true)
  public Page<[Resource]DTO> getAll[Resources](int page, int size, String sort) {
    Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
    Page<[Resource]> [resources] = [resource]Repository.findAll(pageable);
    return [resources].map(this::toDTO);
  }

  @Transactional(readOnly = true)
  public [Resource]DTO get[Resource]ById(Long id) {
    [Resource] [resource] = [resource]Repository.findById(id)
      .orElseThrow(() -> new [Resource]NotFoundException(id));
    return toDTO([resource]);
  }

  public [Resource]DTO create[Resource]([Resource]CreateRequest request) {
    // Business rule validations
    if ([resource]Repository.existsByField(request.field())) {
      throw new DuplicateFieldException(request.field());
    }

    // Create entity
    [Resource] [resource] = new [Resource]();
    [resource].setField1(request.field1());
    [resource].setField2(request.field2());

    // Save
    [Resource] saved[Resource] = [resource]Repository.save([resource]);

    // Return DTO
    return toDTO(saved[Resource]);
  }

  public [Resource]DTO update[Resource](Long id, [Resource]UpdateRequest request) {
    // Find existing
    [Resource] [resource] = [resource]Repository.findById(id)
      .orElseThrow(() -> new [Resource]NotFoundException(id));

    // Update fields
    [resource].setField1(request.field1());

    // Save
    [Resource] updated[Resource] = [resource]Repository.save([resource]);

    // Return DTO
    return toDTO(updated[Resource]);
  }

  public void delete[Resource](Long id) {
    // Check existence
    if (![resource]Repository.existsById(id)) {
      throw new [Resource]NotFoundException(id);
    }

    // Business rule checks
    // ... add checks here

    // Delete
    [resource]Repository.deleteById(id);
  }

  private [Resource]DTO toDTO([Resource] [resource]) {
    return new [Resource]DTO(
      [resource].getId(),
      [resource].getField1(),
      [resource].getField2(),
      [resource].getCreatedAt(),
      [resource].getUpdatedAt()
    );
  }
}
```

---

## Testing Requirements

**Unit Tests** (with Mockito):
```java
@ExtendWith(MockitoExtension.class)
class [Resource]ServiceTest {

  @Mock
  private [Resource]Repository [resource]Repository;

  @InjectMocks
  private [Resource]Service [resource]Service;

  @Test
  void get[Resource]ById_ExistingId_ReturnsDTO() {
    // Arrange
    [Resource] [resource] = new [Resource]();
    [resource].setId(1L);
    when([resource]Repository.findById(1L)).thenReturn(Optional.of([resource]));

    // Act
    [Resource]DTO result = [resource]Service.get[Resource]ById(1L);

    // Assert
    assertNotNull(result);
    assertEquals(1L, result.id());
  }

  @Test
  void get[Resource]ById_NonExistingId_ThrowsException() {
    // Arrange
    when([resource]Repository.findById(999L)).thenReturn(Optional.empty());

    // Act & Assert
    assertThrows([Resource]NotFoundException.class, () -> {
      [resource]Service.get[Resource]ById(999L);
    });
  }

  @Test
  void create[Resource]_ValidData_CreatesSuccessfully() {
    // Test implementation
  }

  @Test
  void create[Resource]_DuplicateField_ThrowsException() {
    // Test implementation
  }

  @Test
  void update[Resource]_ExistingId_UpdatesSuccessfully() {
    // Test implementation
  }

  @Test
  void delete[Resource]_ExistingId_DeletesSuccessfully() {
    // Test implementation
  }
}
```

**Coverage Target**: ≥80%

---

## Implementation Checklist

- [ ] Create service class with @Service annotation
- [ ] Add constructor injection for repositories
- [ ] Implement getAllResources() with pagination
- [ ] Implement getResourceById() with error handling
- [ ] Implement createResource() with business rule validation
- [ ] Implement updateResource() with error handling
- [ ] Implement deleteResource() with dependency checks
- [ ] Create helper method toDTO()
- [ ] Add @Transactional annotations
- [ ] Create custom exception classes
- [ ] Write unit tests for all methods (>80% coverage)
- [ ] Test all error cases (not found, duplicate, validation)
- [ ] Document business rules in comments
