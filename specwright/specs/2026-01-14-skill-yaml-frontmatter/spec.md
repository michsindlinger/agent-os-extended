---
description: Specification for YAML frontmatter in Specwright skills
version: 1.0
encoding: UTF-8
---

# Skill YAML Frontmatter Specification

## Overview

This specification defines the required and optional YAML frontmatter fields for Specwright skills. All skills must have proper YAML frontmatter to be recognized and loaded correctly by Claude Code.

## Reference Example: pptx Skill

```yaml
---
name: pptx
description: "Presentation creation, editing, and analysis. When Claude needs to work with presentations (.pptx files) for: (1) Creating new presentations, (2) Modifying or editing content, (3) Working with layouts, (4) Adding comments or speaker notes, or any other presentation tasks"
license: Proprietary. LICENSE.txt has complete terms
---
```

## Required Fields

### name
- **Type**: String
- **Required**: Yes
- **Format**: Lowercase with hyphens, no special characters
- **Description**: Unique identifier for the skill
- **Example**: `spring-boot-api-patterns`

### description
- **Type**: String
- **Required**: Yes
- **Format**: Free text, can be multiple lines
- **Description**: Human-readable description of when and why this skill should be used
- **Best Practice**: Include specific scenarios and trigger conditions
- **Example**:
  ```yaml
  description: "Spring Boot API patterns for backend development. Use when: (1) Creating REST controllers, (2) Implementing service layer, (3) Working with repositories, (4) Handling exceptions"
  ```

## Optional Fields

### globs
- **Type**: Array of strings
- **Required**: No (but recommended for auto-activation)
- **Description**: File patterns that trigger automatic skill loading
- **Format**: Glob patterns relative to project root
- **Example**:
  ```yaml
  globs:
    - "src/**/*Controller.java"
    - "src/**/*Service.java"
    - "src/**/*Repository.java"
  ```

### version
- **Type**: String
- **Required**: No
- **Description**: Version of the skill or framework
- **Example**: `1.0` or `3.2.0`

### framework
- **Type**: String
- **Required**: No
- **Description**: Framework this skill is for
- **Example**: `spring-boot`, `react`, `playwright`

### always_apply / alwaysApply
- **Type**: Boolean
- **Required**: No
- **Default**: false
- **Description**: Whether skill should always be loaded (ignores globs)
- **Example**: `true`

### license
- **Type**: String
- **Required**: No
- **Description**: License information for the skill
- **Example**: `Proprietary. LICENSE.txt has complete terms`

### encoding
- **Type**: String
- **Required**: No
- **Default**: UTF-8
- **Description**: Character encoding of the skill file
- **Example**: `UTF-8`

### installation
- **Type**: String
- **Required**: No
- **Description**: Installation scope
- **Values**: `global`, `local`, `project`
- **Example**: `global`

### created / updated
- **Type**: String (date)
- **Required**: No
- **Description**: When the skill was created or last updated
- **Format**: YYYY-MM-DD
- **Example**: `2026-01-14`

## Skill Activation Modes

### 1. Auto-Load (via globs)

The skill is automatically loaded when working with files matching the glob patterns:

```yaml
---
name: spring-boot-api-patterns
description: "Spring Boot API patterns"
globs:
  - "src/**/*Controller.java"
  - "src/**/*Service.java"
---
```

**When to use**: Skills for specific file types or frameworks

### 2. Explicit Invocation Only

No `globs` field - skill is only loaded when explicitly referenced:

```yaml
---
name: git-workflow
description: "Git workflow patterns for version control"
---
```

**When to use**: Utility skills that don't relate to specific file types

### 3. Always Active

```yaml
---
name: project-standards
description: "Project coding standards"
always_apply: true
---
```

**When to use**: Skills that should always be available

## Complete Example

```yaml
---
name: my-spring-boot-api-patterns
description: "Spring Boot 3.2.0 API patterns for my-project. Use when: (1) Creating REST controllers with @RestController, (2) Implementing service layer with @Service, (3) Working with JPA repositories, (4) Handling exceptions with @ControllerAdvice, (5) Configuring application properties"
version: 3.2.0
framework: spring-boot
created: 2026-01-14
encoding: UTF-8
globs:
  - "src/**/*Controller.java"
  - "src/**/*Service.java"
  - "src/**/*Repository.java"
  - "src/**/config/**/*.java"
  - "src/**/dto/**/*.java"
---

# Spring Boot API Patterns

> Project: my-project
> Framework: Spring Boot 3.2.0
> Generated: 2026-01-14

## Controller Patterns

[... skill content ...]
```

## Minimum Viable Frontmatter

The absolute minimum for a functional skill:

```yaml
---
name: my-skill
description: "What this skill does and when to use it"
---
```

## Migration Strategy

See `migration-plan.md` for details on updating existing skills.
