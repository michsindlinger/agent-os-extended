# Agent OS Skills

Claude Code Skills provide contextual guidance that activates automatically based on file type, task context, or code content.

## What are Skills?

Skills are specialized knowledge modules that Claude Code applies intelligently when relevant. Instead of loading all standards into context at once, skills activate only when needed, reducing token usage by 60-80%.

## Available Skills

### Base Skills (Always Available)

- **security-best-practices** - Security principles for all code
  - Triggers: Always active, especially for auth/security tasks
  - Location: `base/security-best-practices.md`

- **git-workflow-patterns** - Git workflow and commit standards
  - Triggers: Git-related tasks
  - Location: `base/git-workflow-patterns.md`

### Java Spring Boot Skills

- **java-core-patterns** - Core Java design patterns
  - Triggers: `.java` files
  - Location: `java/java-core-patterns.md`

- **spring-boot-conventions** - Spring Boot framework patterns
  - Triggers: Files containing `@SpringBootApplication`, `@RestController`, `@Service`
  - Location: `java/spring-boot-conventions.md`

- **jpa-best-practices** - JPA/Hibernate optimization
  - Triggers: Files containing `@Entity`, `@Repository`, `JpaRepository`
  - Location: `java/jpa-best-practices.md`

### React Skills

- **react-component-patterns** - React component design
  - Triggers: `.tsx`, `.jsx` files
  - Location: `react/react-component-patterns.md`

- **react-hooks-best-practices** - React hooks optimization
  - Triggers: Files containing `useState`, `useEffect`, `useMemo`
  - Location: `react/react-hooks-best-practices.md`

- **typescript-react-patterns** - TypeScript in React
  - Triggers: `.tsx` files with type definitions
  - Location: `react/typescript-react-patterns.md`

### Angular Skills

- **angular-component-patterns** - Angular component design
  - Triggers: Files containing `@Component`, `@Input`, `@Output`
  - Location: `angular/angular-component-patterns.md`

- **angular-services-patterns** - Angular service patterns
  - Triggers: Files containing `@Injectable`, `@Service`
  - Location: `angular/angular-services-patterns.md`

- **rxjs-best-practices** - RxJS reactive programming
  - Triggers: Files containing `Observable`, `Subject`, `pipe`
  - Location: `angular/rxjs-best-practices.md`

## How Skills Work

### Automatic Activation

Skills activate automatically based on:

1. **File Extension**
   ```typescript
   // You open: UserService.java
   // Skills activated: java-core-patterns, spring-boot-conventions
   ```

2. **File Content**
   ```typescript
   // File contains: @Entity, @Repository
   // Skills activated: jpa-best-practices
   ```

3. **Task Context**
   ```typescript
   // Task: "Add authentication to API"
   // Skills activated: security-best-practices, spring-boot-conventions
   ```

### Example Workflow

```
You: "Create a new REST endpoint for user management"

Claude analyzes:
- File: UserController.java
- Content: @RestController
- Task: REST API

Skills activated:
✓ java-core-patterns
✓ spring-boot-conventions
✓ rest-api-design (if exists)
✓ security-best-practices

Result: Claude applies Spring Boot conventions, REST best practices,
        and security standards automatically
```

## Creating Custom Skills

Create a new `.md` file in the appropriate directory:

```markdown
---
name: My Custom Skill
description: What this skill does
triggers:
  - file_extension: .ts
  - task_mentions: "custom|special"
  - file_contains: "SpecialClass"
  - always_active: false
---

# Skill Content

Your guidance and patterns here...
```

### Skill Frontmatter

- **name**: Display name for the skill
- **description**: Brief description of what it does
- **triggers**: Conditions for skill activation
  - `file_extension`: Activate for specific file types
  - `task_mentions`: Activate when task description contains keywords
  - `file_contains`: Activate when file contains specific patterns
  - `always_active`: Always load this skill (use sparingly)

## Skills vs Standards

**Old Approach (v1.x):**
```
All standards loaded at once
→ 15,000 tokens of context
→ Relevant + irrelevant mixed together
```

**New Approach (v2.0 with Skills):**
```
Only relevant skills activated
→ 3,000-5,000 tokens of context
→ 60-80% context reduction
→ More room for actual code
```

## Integration with Profiles

Profiles define which skills are available:

```yaml
# agent-os/profiles/java-spring-boot.md
skills:
  - java-core-patterns
  - spring-boot-conventions
  - jpa-best-practices
  - rest-api-design
```

When you activate the `java-spring-boot` profile, these skills become available and activate based on their trigger conditions.

## Claude Code Integration

Skills are symlinked to `.claude/skills/` so Claude Code can discover them:

```
.claude/skills/
├── security-best-practices.md -> ../../agent-os/skills/base/security-best-practices.md
├── java-core-patterns.md -> ../../agent-os/skills/java/java-core-patterns.md
├── react-component-patterns.md -> ../../agent-os/skills/react/react-component-patterns.md
└── ... (more symlinks)
```

This allows:
- Central management in `agent-os/skills/`
- Claude Code discovery in `.claude/skills/`
- Easy updates (modify source, all symlinks benefit)

## Best Practices

1. **Keep skills focused** - One skill per topic
2. **Use clear triggers** - Be specific about when skill applies
3. **Include examples** - Show good and bad patterns
4. **Add checklists** - Help verify compliance
5. **Update regularly** - Keep skills current with latest practices

## Resources

- [Claude Code Skills Documentation](https://docs.anthropic.com/claude-code/skills)
- [Agent OS Profiles](../profiles/README.md)
- [Creating Custom Skills](../../docs/creating-skills.md) _(coming soon)_
