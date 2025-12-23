# Agent OS Profiles

Profiles provide tech-stack-specific standards, patterns, and best practices for different types of projects.

## Available Profiles

### Base Profile
- **File**: `base.md`
- **Inherits**: None
- **Description**: Universal standards applicable to all projects
- **Use Case**: Foundation for all other profiles

### Java Spring Boot Backend
- **File**: `java-spring-boot.md`
- **Inherits**: `base`
- **Description**: Enterprise Java backend with Spring Boot
- **Skills**: java-core-patterns, spring-boot-conventions, jpa-best-practices, rest-api-design

### React Frontend
- **File**: `react-frontend.md`
- **Inherits**: `base`
- **Description**: Modern React applications with TypeScript
- **Skills**: react-component-patterns, react-hooks-best-practices, typescript-react-patterns

### Angular Frontend
- **File**: `angular-frontend.md`
- **Inherits**: `base`
- **Description**: Enterprise Angular applications with TypeScript
- **Skills**: angular-component-patterns, rxjs-best-practices, ngrx-state-management

## Using Profiles

### Setting Active Profile

Edit `agent-os/config.yml`:

```yaml
active_profile: react-frontend
```

### Profile Inheritance

Profiles can inherit from other profiles:

```
base (universal standards)
 ├── java-spring-boot (Java + Spring Boot specific)
 ├── react-frontend (React + TypeScript specific)
 └── angular-frontend (Angular + TypeScript specific)
```

When you activate `react-frontend`, you automatically get:
- All standards from `base` profile
- React-specific standards and patterns
- Associated Claude Code Skills

## Creating Custom Profiles

Create a new `.md` file in this directory:

```markdown
---
name: "My Custom Profile"
inherits: base
description: "Custom profile description"
version: "2.0.0"
tech_stack:
  language: "Python"
  framework: "Django"
skills:
  - django-patterns
  - python-best-practices
---

# My Custom Profile

[Profile content here...]
```

### Profile Structure

1. **YAML Frontmatter** (required)
   - `name`: Display name
   - `inherits`: Parent profile or `null`
   - `description`: Brief description
   - `version`: Profile version
   - `tech_stack`: Key technologies
   - `skills`: List of Claude Code Skills

2. **Markdown Content**
   - Standards and best practices
   - Code examples
   - Testing patterns
   - Project structure

## Profile Features (v2.0)

### Automatic Skill Loading

When a profile is active, its associated Skills are automatically available in Claude Code.

### Context-Aware Standards

Standards are injected based on:
- Active profile
- Current file type
- Task context

### Inheritance Chain

Profiles inherit all standards from their parent profiles, creating a layered approach to development guidelines.

## Switching Profiles

### During Development

```bash
# Edit agent-os/config.yml
active_profile: angular-frontend
```

### For Monorepos

Different directories can use different profiles:

```
my-monorepo/
├── backend/           # Uses java-spring-boot profile
│   └── agent-os/
│       └── config.yml  (active_profile: java-spring-boot)
├── frontend/          # Uses react-frontend profile
│   └── agent-os/
│       └── config.yml  (active_profile: react-frontend)
└── mobile/            # Uses react-native profile
    └── agent-os/
        └── config.yml  (active_profile: react-native)
```

## Profile Versioning

Profiles follow semantic versioning:
- **Major**: Breaking changes to profile structure
- **Minor**: New skills or standards added
- **Patch**: Fixes to existing content

Current version: **2.0.0**

## Contributing Profiles

To add a new profile to Agent OS Extended:

1. Create profile file in `agent-os/profiles/`
2. Follow the structure of existing profiles
3. Document all skills referenced
4. Add profile to this README
5. Submit pull request

## Resources

- [Agent OS Documentation](https://buildermethods.com/agent-os)
- [Agent OS Extended Repository](https://github.com/michsindlinger/agent-os-extended)
- [Profile Schema Reference](../docs/profile-schema.md) _(coming soon)_
