# Migration Guide: Agent OS to Specwright

## Why the Rename?

**Agent OS Extended** has been renamed to **Specwright** to establish its own identity as an open-source project. The functionality remains exactly the same - only the names and paths have changed.

## Quick Migration

Run this one-liner in your project root:

```bash
curl -fsSL https://raw.githubusercontent.com/michsindlinger/specwright/main/migrate-to-specwright.sh | bash
```

Or download and run with options:

```bash
curl -fsSL https://raw.githubusercontent.com/michsindlinger/specwright/main/migrate-to-specwright.sh -o migrate.sh
chmod +x migrate.sh

# Preview changes first
./migrate.sh --dry-run

# Run migration
./migrate.sh

# Run without prompts
./migrate.sh --yes

# Migrate only global installation
./migrate.sh --global-only
```

## What Changes

### Directory Renames

| Before | After |
|--------|-------|
| `agent-os/` | `specwright/` |
| `.agent-os/` | `.specwright/` |
| `~/.agent-os/` | `~/.specwright/` |
| `.claude/commands/agent-os/` | `.claude/commands/specwright/` |

### File Content Updates

All references in your project files are updated:
- `agent-os/` paths become `specwright/`
- `.agent-os/` paths become `.specwright/`
- "Agent OS" text becomes "Specwright"

### Slash Commands

Commands like `/agent-os:create-spec` become `/specwright:create-spec`. The commands themselves work exactly the same way.

### MCP Server

The Kanban MCP Server supports both old and new paths during the transition period. Non-migrated projects will continue to work.

## Backward Compatibility

The migration script creates symlinks for a 3-month transition period:
- `agent-os/` -> `specwright/`
- `.agent-os/` -> `.specwright/`
- `.claude/commands/agent-os/` -> `.claude/commands/specwright/`

This means old path references in your custom scripts and configurations will continue to work.

Use `--no-symlinks` if you don't want backward-compatibility symlinks.

## Rollback

The migration script creates a backup before making changes. To rollback:

```bash
# Backup location is shown in migration output
rm -rf specwright .specwright .claude/commands/specwright
mv .specwright-migration-backup-*/agent-os .
mv .specwright-migration-backup-*/.agent-os .
mv .specwright-migration-backup-*/.claude/commands/agent-os .claude/commands/
```

## FAQ

**Q: Do I need to migrate immediately?**
A: No. The MCP server supports both paths during the transition. However, new features and updates will use the new paths.

**Q: Will my existing specs and kanban boards work?**
A: Yes. The migration preserves all data. The MCP server also has dual-path fallback for non-migrated projects.

**Q: What about my custom CLAUDE.md?**
A: The migration script updates all path references in your CLAUDE.md automatically.

**Q: What about GitHub URLs in setup scripts?**
A: GitHub automatically redirects from the old repo URL to the new one. After the GitHub repo rename, all `raw.githubusercontent.com` URLs will redirect.
