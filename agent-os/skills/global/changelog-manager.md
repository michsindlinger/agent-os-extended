---
name: changelog-manager
description: Maintains changelog and release notes following Keep a Changelog
version: 1.0
---

# Changelog Manager

Maintains project changelog following the Keep a Changelog format, generates release notes, and ensures version history is well-documented.

## Trigger Conditions

```yaml
task_mentions:
  - "changelog|release notes"
  - "version|release"
  - "what's new|changes"
file_extension:
  - CHANGELOG.md
  - HISTORY.md
file_contains:
  - "## [Unreleased]"
  - "### Added"
  - "### Changed"
always_active: true
```

## When to Load

- Preparing releases
- Documenting changes
- Generating release notes
- Version bumps

## Core Competencies

### Changelog Format (Keep a Changelog)

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New feature for user profiles
- API endpoint for bulk operations

### Changed
- Improved performance of search queries
- Updated dependencies to latest versions

### Deprecated
- Old authentication method (use OAuth instead)

### Removed
- Legacy API v1 endpoints

### Fixed
- Bug where users couldn't reset passwords
- Memory leak in background worker

### Security
- Patched XSS vulnerability in comments

## [1.2.0] - 2024-01-15

### Added
- User dashboard with analytics
- Export functionality for reports

### Fixed
- Login timeout issue on mobile devices

## [1.1.0] - 2024-01-01

### Added
- Initial release with core features

[Unreleased]: https://github.com/org/repo/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/org/repo/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/org/repo/releases/tag/v1.1.0
```

### Change Categories

| Category | Description | Example |
|----------|-------------|---------|
| Added | New features | "New user dashboard" |
| Changed | Changes in existing functionality | "Improved search algorithm" |
| Deprecated | Soon-to-be removed features | "Legacy API deprecated" |
| Removed | Removed features | "Removed support for IE11" |
| Fixed | Bug fixes | "Fixed login timeout" |
| Security | Vulnerability fixes | "Patched SQL injection" |

### Release Notes Template

```markdown
# Release Notes: v[X.Y.Z]

**Release Date:** [YYYY-MM-DD]

## Highlights

🎉 **[Feature Name]** - [Brief exciting description]

[1-2 sentences about the most important change in this release]

## What's New

### [Feature 1 Name]
[Description with screenshot if applicable]

**How to use:**
1. [Step 1]
2. [Step 2]

### [Feature 2 Name]
[Description]

## Improvements

- **Performance**: [Improvement description]
- **UX**: [Improvement description]
- **API**: [Improvement description]

## Bug Fixes

- Fixed issue where [problem] occurred when [action] (#123)
- Fixed [another issue] (#456)

## Breaking Changes

⚠️ **[Breaking Change Description]**

Migration steps:
1. [Step 1]
2. [Step 2]

See [migration guide](link) for details.

## Deprecations

The following features are deprecated and will be removed in v[X+1].0.0:
- [Deprecated feature 1]
- [Deprecated feature 2]

## Upgrade Instructions

```bash
# Update to latest version
npm install package@latest

# Run migrations if needed
npm run migrate
```

## Contributors

Thanks to all contributors who made this release possible!
- @contributor1
- @contributor2

## Full Changelog

See [CHANGELOG.md](link) for the complete list of changes.
```

## Best Practices

### Writing Good Changelog Entries

```markdown
# Good Examples
- Add user profile page with avatar upload (#123)
- Fix memory leak when processing large files (#456)
- Improve search performance by 50% using index optimization
- Remove deprecated `getUser()` method (use `fetchUser()` instead)

# Bad Examples (avoid)
- Fixed bug
- Updated code
- Various improvements
- Miscellaneous changes
```

### Linking to Issues/PRs

```markdown
### Fixed
- Resolve timeout error during checkout ([#123](link))
- Fix incorrect tax calculation for EU customers ([#456](link), [#457](link))
```

### Automated Changelog Generation

```yaml
# .github/release-drafter.yml
name-template: 'v$RESOLVED_VERSION'
tag-template: 'v$RESOLVED_VERSION'
categories:
  - title: '🚀 Features'
    labels:
      - 'feature'
      - 'enhancement'
  - title: '🐛 Bug Fixes'
    labels:
      - 'fix'
      - 'bugfix'
  - title: '🧰 Maintenance'
    labels:
      - 'chore'
      - 'dependencies'
change-template: '- $TITLE @$AUTHOR (#$NUMBER)'
version-resolver:
  major:
    labels:
      - 'major'
  minor:
    labels:
      - 'minor'
  patch:
    labels:
      - 'patch'
  default: patch
```

### Conventional Commits to Changelog

```bash
# Using standard-version
npm install --save-dev standard-version

# Generate changelog from commits
npx standard-version

# Or specific version
npx standard-version --release-as minor
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| No changelog | Users don't know changes | Maintain CHANGELOG.md |
| Vague entries | Not helpful | Be specific |
| Missing links | Hard to trace | Link issues/PRs |
| Dates missing | Timeline unclear | Always include dates |
| Not updated | Outdated info | Update with each PR |

## Checklist

### For Each Change
- [ ] Entry added to Unreleased section
- [ ] Correct category used
- [ ] Issue/PR linked
- [ ] Description is clear

### For Each Release
- [ ] Unreleased section moved to version
- [ ] Version number correct
- [ ] Date added
- [ ] Comparison links updated
- [ ] Release notes prepared

### Release Notes
- [ ] Highlights section written
- [ ] Breaking changes documented
- [ ] Migration steps provided
- [ ] Contributors acknowledged

## Integration

### Works With
- git-master (commit messages)
- pipeline-engineer (release automation)
- documentation-architect (docs updates)

### Output
- CHANGELOG.md updates
- Release notes
- Version tags
- GitHub releases
