---
name: git-master
description: Enforces Git workflow standards and commit conventions
version: 1.0
---

# Git Master

Ensures consistent Git practices across the team including branching strategies, commit conventions, and PR workflows.

## Trigger Conditions

```yaml
task_mentions:
  - "git|commit|branch"
  - "pr|pull request|merge"
  - "version|release|tag"
always_active: true
```

## When to Load

- Creating commits
- Creating branches
- Preparing pull requests
- Release tagging

## Core Competencies

### Commit Message Convention

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### Types
| Type | Description |
|------|-------------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation only |
| style | Formatting, no code change |
| refactor | Code change, no feature/fix |
| perf | Performance improvement |
| test | Adding tests |
| chore | Maintenance tasks |
| ci | CI/CD changes |
| build | Build system changes |

#### Examples
```bash
# Feature
feat(auth): add OAuth2 login support

Implement OAuth2 authentication flow with Google and GitHub providers.
- Add OAuth2 configuration
- Create callback handlers
- Update user model for external providers

Closes #123

# Bug fix
fix(cart): prevent duplicate items on rapid clicks

Add debounce to add-to-cart button to prevent race condition
that caused duplicate cart items.

Fixes #456

# Breaking change
feat(api)!: change user endpoint response format

BREAKING CHANGE: User endpoint now returns camelCase fields
instead of snake_case. Update all clients accordingly.

Migration guide: docs/migrations/v2-api.md
```

### Branching Strategy

#### Git Flow
```
main (production)
  │
  ├── develop (integration)
  │     │
  │     ├── feature/user-auth
  │     ├── feature/payment-integration
  │     └── feature/dashboard-redesign
  │
  ├── release/v1.2.0
  │
  └── hotfix/critical-security-fix
```

#### GitHub Flow (Simpler)
```
main (production)
  │
  ├── feature/add-user-profile
  ├── fix/login-error
  └── chore/update-dependencies
```

### Branch Naming

```
<type>/<ticket-id>-<short-description>

Examples:
feature/PROJ-123-user-authentication
fix/PROJ-456-cart-calculation
chore/PROJ-789-update-deps
hotfix/PROJ-999-security-patch
```

### Pull Request Template

```markdown
## Summary
[Brief description of changes]

## Type of Change
- [ ] Bug fix (non-breaking change fixing an issue)
- [ ] New feature (non-breaking change adding functionality)
- [ ] Breaking change (fix or feature causing existing functionality to change)
- [ ] Documentation update

## Related Issues
Closes #[issue number]

## Changes Made
- [Change 1]
- [Change 2]
- [Change 3]

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing performed

## Screenshots (if applicable)
[Add screenshots for UI changes]

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings introduced
- [ ] All tests pass
```

## Best Practices

### Commit Best Practices

```bash
# Atomic commits - one logical change per commit
git add src/auth/
git commit -m "feat(auth): add login form validation"

git add src/api/auth.ts
git commit -m "feat(auth): add login API endpoint"

# Interactive rebase to clean up before PR
git rebase -i HEAD~5

# Amend last commit (before push)
git commit --amend -m "feat(auth): add login with better message"

# Squash commits during merge
git merge --squash feature/my-feature
```

### Semantic Versioning

```
MAJOR.MINOR.PATCH (e.g., 2.1.3)

MAJOR: Breaking changes
MINOR: New features (backward compatible)
PATCH: Bug fixes (backward compatible)

Pre-release: 2.0.0-alpha.1, 2.0.0-beta.1, 2.0.0-rc.1
```

### Release Workflow

```bash
# Create release branch
git checkout -b release/v1.2.0 develop

# Update version
npm version minor  # or major/patch

# Merge to main
git checkout main
git merge --no-ff release/v1.2.0

# Tag release
git tag -a v1.2.0 -m "Release v1.2.0"
git push origin main --tags

# Merge back to develop
git checkout develop
git merge --no-ff release/v1.2.0

# Clean up
git branch -d release/v1.2.0
```

### Pre-commit Hooks

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: lint
        name: Lint code
        entry: npm run lint
        language: system
        pass_filenames: false

      - id: test
        name: Run tests
        entry: npm test
        language: system
        pass_filenames: false

      - id: commit-msg
        name: Validate commit message
        entry: npx commitlint --edit
        language: system
        stages: [commit-msg]
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| "WIP" commits | Unclear history | Squash before merge |
| Force push to main | Lost history | Protect main branch |
| Large PRs | Hard to review | Keep PRs < 400 lines |
| No PR description | Context missing | Use PR template |
| Merge conflicts left | Broken code | Resolve immediately |

## Checklist

### Before Commit
- [ ] Changes are atomic (one logical change)
- [ ] Commit message follows convention
- [ ] No debug code or console.logs
- [ ] Tests pass locally

### Before PR
- [ ] Branch is up to date with base
- [ ] All commits are clean
- [ ] PR description completed
- [ ] Reviewers assigned
- [ ] Labels added

### Before Merge
- [ ] All checks pass
- [ ] Required reviews obtained
- [ ] Conflicts resolved
- [ ] PR description updated if needed

## Integration

### Works With
- changelog-manager (release notes)
- pipeline-engineer (CI/CD)
- All development skills (version control)

### Output
- Commit messages
- Branch names
- PR descriptions
- Release tags
