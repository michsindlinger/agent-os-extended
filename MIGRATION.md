# Migration Guide: v1.x → v2.0

Complete migration guide for Agent OS Extended from v1.x to v2.0.

## Overview

Agent OS Extended v2.0 includes significant improvements in two phases:
- **Phase I**: Structural changes (directory naming, command isolation)
- **Phase II**: Advanced features (profiles, skills, research, verification)

## Prerequisites

- Existing project with Agent OS Extended v1.x installed (`.agent-os/` structure)
- Git repository (recommended for safety)
- Backup of important files (automatic backup is created)

## Migration Process

### Phase I: Structural Migration

**What changes:**
- `.agent-os/` → `agent-os/` (visible directory)
- `agent-os/instructions/` → `agent-os/workflows/`
- `.claude/commands/` → `.claude/commands/agent-os/`
- All `@.agent-os/` references → `@agent-os/`

**How to migrate:**

```bash
cd your-project
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-to-v2.sh | bash
```

**What the script does:**
1. Pre-flight checks (detects v1.x, checks git status)
2. Creates timestamped backup (`.agent-os.backup-YYYY-MM-DD-HHMMSS/`)
3. Renames directories
4. Updates all file references
5. Verifies migration success

**Time**: ~30 seconds

**If issues occur:**
```bash
# Rollback to v1.x
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/rollback-v2-migration.sh | bash
```

**After Phase I:**
- Test your commands: `/create-spec`, `/execute-tasks`, etc.
- Verify files are in correct locations
- Check that references work
- Delete backup if everything works: `rm -rf .agent-os.backup-*`

---

### Phase II: Advanced Features

**What changes:**
- Adds `agent-os/profiles/` (4 profiles: Java, React, Angular, Base)
- Adds `agent-os/skills/` (11 contextual skills)
- Adds research workflows (`agent-os/workflows/research/`)
- Adds verification workflows (`agent-os/workflows/verification/`)
- Creates `agent-os/config.yml` configuration
- Symlinks skills to `.claude/skills/`

**How to add Phase II:**

```bash
cd your-project
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-to-v2-phase2.sh | bash
```

**What the script does:**
1. Validates v2.0 structure exists
2. Downloads profiles (base, java-spring-boot, react-frontend, angular-frontend)
3. Downloads 11 skills (organized by tech stack)
4. Downloads research workflows and templates
5. Downloads verification workflows and templates
6. Creates/updates agent-os/config.yml
7. Creates symlinks in .claude/skills/
8. Updates /create-spec command to v2.0

**Time**: ~2-3 minutes

**After Phase II:**
- Review `agent-os/config.yml` and set your `active_profile`
- Test `/create-spec` to experience enhanced research phase
- Skills activate automatically when working on relevant files

---

## Post-Migration Checklist

### Phase I Verification

- [ ] `agent-os/` directory exists and visible
- [ ] `agent-os/workflows/` exists (not `instructions/`)
- [ ] `.claude/commands/agent-os/` exists
- [ ] Run `/create-spec test` - should work without errors
- [ ] Check one workflow file - references should use `@agent-os/`
- [ ] Old directories removed (`instructions/`, `standards/`, `commands/`, `agents/`)

### Phase II Verification

- [ ] `agent-os/profiles/` contains 4 profiles
- [ ] `agent-os/skills/` contains 11 skills
- [ ] `.claude/skills/` contains 11 symlinks
- [ ] `agent-os/config.yml` exists
- [ ] Research workflows in `agent-os/workflows/research/`
- [ ] Verification workflows in `agent-os/workflows/verification/`
- [ ] `/create-spec` references `create-spec-v2.md`

---

## Configuration

### Setting Your Profile

Edit `agent-os/config.yml`:

```yaml
# Choose your active profile
active_profile: react-frontend  # or java-spring-boot, angular-frontend, base
```

**Available Profiles:**
- `base` - Universal standards only
- `java-spring-boot` - Enterprise Java backend
- `react-frontend` - Modern React apps
- `angular-frontend` - Enterprise Angular apps

### Feature Flags

```yaml
features:
  profile_system: true
  skills_system: true
  enhanced_research: true
  verification_system: true
```

All Phase II features are enabled by default.

---

## What's New in Phase II

### 1. Profile System

**Before (v1.x)**:
- Same standards for all projects
- Manual customization needed

**After (v2.0)**:
```bash
# Java project
active_profile: java-spring-boot
# → Automatically loads Java/Spring Boot patterns

# React project
active_profile: react-frontend
# → Automatically loads React/TypeScript patterns
```

### 2. Skills System

**Before (v1.x)**:
- All standards loaded at once (~15k tokens)
- Relevant + irrelevant mixed

**After (v2.0)**:
```
Working on UserService.java
  → java-core-patterns activates
  → spring-boot-conventions activates
  → security-best-practices activates

Only ~3-5k tokens (60-80% reduction!)
```

### 3. Enhanced Research Phase

**Before (v1.x)**:
```
/create-spec "Invoice Export"
→ Spec created (may be incomplete)
```

**After (v2.0)**:
```
/create-spec "Invoice Export"
→ Research Phase:
  1. Analyzes codebase for similar features
  2. Asks targeted questions
  3. Collects mockups/wireframes
→ Informed, complete spec created
```

### 4. Verification System

**Before (v1.x)**:
- Manual quality checks
- Inconsistent standards enforcement

**After (v2.0)**:
```
Spec created
  → Automatic verification (30 checkpoints)
  → Gap identification

Code implemented
  → Implementation verification (24 checkpoints)
  → Security, performance, standards checks

UI completed
  → Visual verification (38 checkpoints)
  → Compare with mockups
```

---

## Common Issues & Solutions

### Issue: Commands show "404: Not Found"

**Cause**: Setup scripts used wrong GitHub URLs (fixed in latest version)

**Solution**:
```bash
# Re-run setup with fixed scripts
rm -rf agent-os .claude
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash
```

### Issue: Skills not activating

**Cause**: Symlinks not created or broken

**Solution**:
```bash
# Check symlinks
ls -la .claude/skills/

# Recreate if needed
bash setup-claude-code.sh  # Re-run Claude Code setup
```

### Issue: Old references still present

**Cause**: Migration script didn't catch all references

**Solution**:
```bash
# Find remaining old references
grep -r "@\.agent-os/" agent-os/ 2>/dev/null

# Manually update or re-run migration
```

---

## Rollback Procedures

### Rollback Phase I

If Phase I migration causes issues:

```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/rollback-v2-migration.sh | bash
```

**What happens:**
- Removes `agent-os/` directory
- Removes `.claude/commands/agent-os/`
- Restores `.agent-os/` from backup
- Restores `.claude/commands/` from backup

### Rollback Phase II

Phase II is additive (doesn't modify existing files):

```bash
# Simply remove Phase II additions
rm -rf agent-os/profiles
rm -rf agent-os/skills
rm -rf agent-os/workflows/research
rm -rf agent-os/workflows/verification
rm -rf agent-os/templates
rm -rf .claude/skills
rm agent-os/config.yml
```

---

## Testing Your Migration

### Quick Test

```bash
# Test basic command
/create-spec "Test Feature"

# Should:
# 1. Start research phase
# 2. Ask clarifying questions
# 3. Create spec in agent-os/specs/2025-XX-XX-test-feature/
```

### Comprehensive Test

1. Create a test spec: `/create-spec "Migration Test"`
2. Verify research phase works (codebase analysis, Q&A)
3. Check created files are in `agent-os/specs/`
4. Verify skills activate (create a `.java` file, check if skills appear)
5. Test verification (if enabled in config)

---

## Getting Help

### Resources

- **Documentation**: `agent-os/profiles/README.md`, `agent-os/skills/README.md`
- **GitHub**: [agent-os-extended repository](https://github.com/michsindlinger/agent-os-extended)
- **Original Agent OS**: [buildermethods.com/agent-os](https://buildermethods.com/agent-os)

### Reporting Issues

If you encounter problems:
1. Check this migration guide
2. Review GitHub issues
3. Create new issue with:
   - Your migration step (Phase I or Phase II)
   - Error messages
   - Output of migration script

---

## Success Criteria

Your migration is successful when:

✅ `/create-spec` works with research phase
✅ Skills activate automatically (check in .claude/skills/)
✅ Profile set in agent-os/config.yml
✅ All old directories removed
✅ Commands work without "404: Not Found" errors
✅ Verification system available (if enabled)

---

## Next Steps After Migration

1. **Set Your Profile**: Edit `agent-os/config.yml`
2. **Try Enhanced Features**: Run `/create-spec` with a real feature
3. **Explore Skills**: Create files in your tech stack, watch skills activate
4. **Use Verification**: Enable verification in config, see quality gates
5. **Customize**: Add custom profiles or skills as needed

---

**Congratulations on migrating to Agent OS Extended v2.0!** 🎉

You now have:
- Clearer structure (visible `agent-os/` directory)
- Profile-based development (tech-stack-specific guidance)
- Automatic skills (context-aware best practices)
- Enhanced planning (research phase in specs)
- Quality gates (verification system)

Enjoy the improved development experience!
