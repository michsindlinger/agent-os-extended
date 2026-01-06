# Repository Layer Class Specification

> Template for documenting repository/DAO layer requirements
> Use this template when planning data access implementation

## Repository Overview

**Repository Name**: `[Resource]Repository`
**Purpose**: Data access layer for [Resource] entity
**Package**: `com.example.[project].repository`
**Extends**: `JpaRepository<[Resource], Long>`

## Responsibilities

1. **CRUD Operations**: Provided by JpaRepository (save, findById, findAll, deleteById)
2. **Custom Queries**: Domain-specific query methods
3. **Data Access**: Abstract database interactions from service layer

## Standard Methods (from JpaRepository)

These methods are automatically provided by extending JpaRepository:

**Create/Update**:
- `save(entity)` - Save or update entity
- `saveAll(entities)` - Batch save

**Read**:
- `findById(id)` - Find by primary key (returns Optional)
- `findAll()` - Find all entities
- `findAll(pageable)` - Find all with pagination
- `existsById(id)` - Check if entity exists
- `count()` - Count total entities

**Delete**:
- `deleteById(id)` - Delete by primary key
- `delete(entity)` - Delete entity instance
- `deleteAll()` - Delete all entities

## Custom Query Methods

### Find by Unique Field

**Purpose**: Find entity by unique field (e.g., email, username)

**Method Name Convention**: `findBy[Field]`

**Signature**:
```java
Optional<[Resource]> findBy[Field](String field);
```

**Example**:
```java
Optional<User> findByEmail(String email);
Optional<Product> findBySku(String sku);
```

**Generated SQL**:
```sql
SELECT * FROM [table] WHERE [field] = ?
```

---

### Check Existence by Field

**Purpose**: Check if entity exists with specific field value

**Method Name Convention**: `existsBy[Field]`

**Signature**:
```java
boolean existsBy[Field](String field);
```

**Example**:
```java
boolean existsByEmail(String email);
boolean existsByUsername(String username);
```

**Generated SQL**:
```sql
SELECT COUNT(*) > 0 FROM [table] WHERE [field] = ?
```

**Use Case**: Validate uniqueness before creating entity

---

### Find by Field (Case-Insensitive)

**Purpose**: Search by field ignoring case

**Method Name Convention**: `findBy[Field]IgnoreCase`

**Signature**:
```java
Optional<[Resource]> findBy[Field]IgnoreCase(String field);
```

**Example**:
```java
Optional<User> findByEmailIgnoreCase(String email);
List<Product> findByNameIgnoreCase(String name);
```

**Generated SQL**:
```sql
SELECT * FROM [table] WHERE LOWER([field]) = LOWER(?)
```

---

### Search by Pattern

**Purpose**: Search entities with field containing pattern

**Method Name Convention**: `findBy[Field]Containing`

**Signature**:
```java
List<[Resource]> findBy[Field]Containing(String pattern);
```

**Example**:
```java
List<User> findByNameContaining(String searchTerm);
List<Product> findByDescriptionContaining(String keyword);
```

**Generated SQL**:
```sql
SELECT * FROM [table] WHERE [field] LIKE %?%
```

---

### Find by Related Entity

**Purpose**: Find entities related to another entity

**Method Name Convention**: `findBy[RelatedEntity]_[Field]`

**Signature**:
```java
List<[Resource]> findBy[RelatedEntity]_Id(Long relatedId);
```

**Example**:
```java
List<Order> findByUser_Id(Long userId);
List<Comment> findByPost_Id(Long postId);
```

**Generated SQL**:
```sql
SELECT * FROM [table] WHERE [related_entity]_id = ?
```

---

### Find with Sorting

**Purpose**: Find entities with custom sorting

**Method Name Convention**: `findBy[Field]OrderBy[SortField][Direction]`

**Signature**:
```java
List<[Resource]> findBy[Field]OrderBy[SortField]Asc(String field);
List<[Resource]> findBy[Field]OrderBy[SortField]Desc(String field);
```

**Example**:
```java
List<Product> findByCategoryOrderByPriceAsc(String category);
List<User> findByRoleOrderByCreatedAtDesc(String role);
```

**Generated SQL**:
```sql
SELECT * FROM [table] WHERE [field] = ? ORDER BY [sort_field] ASC/DESC
```

---

### Custom JPQL Queries

**Purpose**: Complex queries not covered by method naming

**Annotation**: `@Query`

**Signature**:
```java
@Query("SELECT e FROM [Entity] e WHERE [condition]")
List<[Resource]> customQuery(@Param("param") Type param);
```

**Examples**:

**Simple Query**:
```java
@Query("SELECT u FROM User u WHERE u.name LIKE %:search%")
List<User> searchByName(@Param("search") String search);
```

**Join Query**:
```java
@Query("SELECT o FROM Order o JOIN FETCH o.user WHERE o.status = :status")
List<Order> findOrdersByStatus(@Param("status") String status);
```

**Aggregation Query**:
```java
@Query("SELECT COUNT(u) FROM User u WHERE u.role = :role")
long countByRole(@Param("role") String role);
```

**Native SQL Query**:
```java
@Query(value = "SELECT * FROM users WHERE created_at > :date", nativeQuery = true)
List<User> findCreatedAfter(@Param("date") LocalDateTime date);
```

---

### Prevent N+1 Queries

**Problem**: Loading related entities triggers multiple queries

**Solution**: Use @EntityGraph or JOIN FETCH

**EntityGraph Example**:
```java
@EntityGraph(attributePaths = {"relatedEntity"})
@Query("SELECT e FROM [Entity] e")
List<[Resource]> findAllWithRelatedEntity();
```

**JOIN FETCH Example**:
```java
@Query("SELECT u FROM User u JOIN FETCH u.orders WHERE u.id = :id")
Optional<User> findByIdWithOrders(@Param("id") Long id);
```

**Use Case**: When you need related entities, fetch them in one query instead of lazy loading

---

## Full Repository Template

```java
package com.example.project.repository;

import com.example.project.entity.[Resource];
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface [Resource]Repository extends JpaRepository<[Resource], Long> {

  // Find by unique field
  Optional<[Resource]> findBy[UniqueField](String field);

  // Check existence
  boolean existsBy[UniqueField](String field);

  // Case-insensitive search
  Optional<[Resource]> findBy[Field]IgnoreCase(String field);

  // Pattern search
  List<[Resource]> findBy[Field]Containing(String pattern);

  // Find by related entity
  List<[Resource]> findBy[RelatedEntity]_Id(Long relatedId);

  // Sorted results
  List<[Resource]> findBy[Field]OrderBy[SortField]Asc(String field);

  // Custom JPQL query
  @Query("SELECT e FROM [Entity] e WHERE e.[field] LIKE %:search%")
  List<[Resource]> customSearch(@Param("search") String search);

  // Join fetch to prevent N+1
  @Query("SELECT e FROM [Entity] e JOIN FETCH e.relatedEntity WHERE e.id = :id")
  Optional<[Resource]> findByIdWithRelated(@Param("id") Long id);

  // Pagination with filtering
  Page<[Resource]> findBy[Field](String field, Pageable pageable);

  // Count by condition
  long countBy[Field](String field);

  // Date range query
  List<[Resource]> findByCreatedAtBetween(LocalDateTime start, LocalDateTime end);
}
```

---

## Common Query Method Keywords

**Logical Operators**:
- `And` - Combine conditions with AND
- `Or` - Combine conditions with OR

**Comparison**:
- `Is`, `Equals` - Equality check
- `IsNot`, `Not` - Inequality check
- `IsNull`, `Null` - NULL check
- `IsNotNull`, `NotNull` - NOT NULL check

**String**:
- `Like` - SQL LIKE
- `Containing` - LIKE %value%
- `StartingWith` - LIKE value%
- `EndingWith` - LIKE %value
- `IgnoreCase` - Case-insensitive comparison

**Comparison**:
- `GreaterThan`, `After` - Greater than
- `LessThan`, `Before` - Less than
- `GreaterThanEqual` - Greater than or equal
- `LessThanEqual` - Less than or equal
- `Between` - Between two values

**Collection**:
- `In` - IN clause
- `NotIn` - NOT IN clause

**Boolean**:
- `True` - Boolean true
- `False` - Boolean false

**Sorting**:
- `OrderBy[Field]Asc` - Ascending order
- `OrderBy[Field]Desc` - Descending order

---

## Real-World Examples

### User Repository

```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

  // Authentication
  Optional<User> findByEmail(String email);
  Optional<User> findByUsername(String username);

  // Uniqueness checks
  boolean existsByEmail(String email);
  boolean existsByUsername(String username);

  // Search
  List<User> findByNameContaining(String search);
  List<User> findByRoleOrderByCreatedAtDesc(String role);

  // Admin queries
  long countByRole(String role);
  List<User> findByCreatedAtAfter(LocalDateTime date);

  // Fetch with relationships
  @Query("SELECT u FROM User u JOIN FETCH u.profile WHERE u.id = :id")
  Optional<User> findByIdWithProfile(@Param("id") Long id);
}
```

### Product Repository

```java
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

  // Find by SKU
  Optional<Product> findBySku(String sku);
  boolean existsBySku(String sku);

  // Category filtering
  Page<Product> findByCategory(String category, Pageable pageable);
  List<Product> findByCategoryOrderByPriceAsc(String category);

  // Price filtering
  List<Product> findByPriceBetween(Double minPrice, Double maxPrice);
  List<Product> findByPriceLessThan(Double maxPrice);

  // Search
  @Query("SELECT p FROM Product p WHERE p.name LIKE %:search% OR p.description LIKE %:search%")
  List<Product> search(@Param("search") String searchTerm);

  // Inventory
  List<Product> findByStockQuantityLessThan(Integer threshold);
  long countByCategory(String category);
}
```

### Order Repository

```java
@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

  // Find by user
  List<Order> findByUser_Id(Long userId);
  Page<Order> findByUser_Id(Long userId, Pageable pageable);

  // Status filtering
  List<Order> findByStatus(String status);
  List<Order> findByStatusOrderByCreatedAtDesc(String status);

  // Date range
  List<Order> findByCreatedAtBetween(LocalDateTime start, LocalDateTime end);

  // Business queries
  boolean existsByUser_Id(Long userId);
  long countByStatus(String status);

  // Fetch with items
  @Query("SELECT o FROM Order o JOIN FETCH o.items WHERE o.id = :id")
  Optional<Order> findByIdWithItems(@Param("id") Long id);
}
```

---

## Performance Considerations

**Indexing**:
```java
@Entity
@Table(name = "users", indexes = {
  @Index(name = "idx_email", columnList = "email"),
  @Index(name = "idx_username", columnList = "username")
})
public class User {
  // Entity definition
}
```

**Pagination** (always use for large datasets):
```java
Page<User> findByRole(String role, Pageable pageable);
```

**JOIN FETCH** (prevent N+1 queries):
```java
@Query("SELECT u FROM User u JOIN FETCH u.orders WHERE u.id = :id")
Optional<User> findByIdWithOrders(@Param("id") Long id);
```

**Projection** (fetch only needed fields):
```java
@Query("SELECT u.id, u.name FROM User u")
List<Object[]> findAllNamesAndIds();
```

---

## Testing Requirements

**Integration Tests** (with @DataJpaTest):
```java
@DataJpaTest
class [Resource]RepositoryTest {

  @Autowired
  private [Resource]Repository repository;

  @Test
  void findBy[Field]_ExistingValue_ReturnsEntity() {
    // Arrange
    [Resource] entity = new [Resource]();
    entity.setField("value");
    repository.save(entity);

    // Act
    Optional<[Resource]> result = repository.findByField("value");

    // Assert
    assertTrue(result.isPresent());
    assertEquals("value", result.get().getField());
  }

  @Test
  void existsBy[Field]_ExistingValue_ReturnsTrue() {
    // Arrange
    [Resource] entity = new [Resource]();
    entity.setField("value");
    repository.save(entity);

    // Act
    boolean exists = repository.existsByField("value");

    // Assert
    assertTrue(exists);
  }

  @Test
  void customQuery_ReturnsExpectedResults() {
    // Test custom @Query methods
  }
}
```

---

## Implementation Checklist

- [ ] Create repository interface extending JpaRepository
- [ ] Add @Repository annotation
- [ ] Define findBy methods for unique fields
- [ ] Define existsBy methods for uniqueness checks
- [ ] Add search methods (containing, ignoreCase)
- [ ] Add sorting methods if needed
- [ ] Write custom @Query methods for complex queries
- [ ] Use @EntityGraph or JOIN FETCH to prevent N+1 queries
- [ ] Add pagination support for list methods
- [ ] Consider indexing frequently queried fields
- [ ] Write integration tests for custom queries
- [ ] Document query performance considerations
