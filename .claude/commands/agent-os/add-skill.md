# Add Skill

Generate project-specific Claude Code skills based on existing codebase patterns or framework best practices.

Refer to the instructions located in @agent-os/workflows/skill/add-skill.md

## Command Arguments

Parse the following arguments from the user's command:

- `--type <skill-type>`: **Required** - Type of skill to create
  - `api`: Backend API patterns (controllers, services, repositories)
  - `component`: Frontend component patterns (components, state, styling)
  - `testing`: Testing patterns (unit, integration, e2e)
  - `deployment`: CI/CD and deployment patterns

- `--analyze`: Mode A - Analyze existing codebase patterns
- `--best-practices`: Mode B - Use framework best practices templates
  - **Note**: User must provide one of these two mode flags

- `--framework <framework-name>`: Optional - Override auto-detected framework
  - Backend: `spring-boot`, `express`, `fastapi`, `django`, `rails`
  - Frontend: `react`, `angular`, `vue`, `svelte`
  - Testing: `playwright`, `jest`, `vitest`, `pytest`, `rspec`, `cypress`
  - CI/CD: `github-actions`, `gitlab-ci`, `jenkins`, `docker`

## Usage Examples

```bash
# Mode A: Analyze existing code patterns
/add-skill --analyze --type api
/add-skill --analyze --type component
/add-skill --analyze --type testing

# Mode B: Use framework best practices
/add-skill --best-practices --type api --framework spring-boot
/add-skill --best-practices --type component --framework react
/add-skill --best-practices --type testing --framework playwright

# Auto-detect framework (works for both modes)
/add-skill --analyze --type api
/add-skill --best-practices --type component
```

## Output

The command generates a skill file in `.claude/skills/` with the format:
```
.claude/skills/[project-name]-[type]-patterns.md
```

## Features

- **Auto-Detection**: Automatically detects frameworks, versions, and project structure
- **Pattern Analysis**: Extracts real patterns from your codebase (Mode A)
- **Best Practices**: Includes industry-standard framework best practices (Mode B)
- **Interactive**: Presents improvement suggestions for user selection
- **Customized**: Generates skills tailored to your project
- **Validated**: Ensures patterns follow best practices
- **Documented**: Includes code examples and common pitfalls
