# Git Worktrees - EXTERNAL LOCATION

## Important: Worktrees Are Now Created Outside the Project

As of v3.3, worktrees are **no longer created in this directory**.

Worktrees are now created in an external sibling directory:
```
{project-name}-worktrees/
```

## Example

If your project is at:
```
/path/to/projekt-x/
```

Worktrees will be created at:
```
/path/to/projekt-x-worktrees/feature-name/
```

## Why External?

1. **Cleaner project directory** - No worktree artifacts in the repo
2. **No symlinks needed** - Worktree contains full `.claude/` and `specwright/`
3. **Better isolation** - Worktrees are completely separate from main project
4. **Simpler cleanup** - Delete the `-worktrees` folder when done

## Lifecycle

1. **Created**: During `/execute-tasks` Phase 2 (Git Strategy Setup)
2. **Used**: During story execution (Phase 3)
3. **Removed**: After PR merge (Phase 5 - Finalize)

## Cleanup

After PR merge, worktrees are automatically removed. Manual cleanup:
```bash
# From main project directory
git worktree remove ../projekt-x-worktrees/feature-name
```

## This Directory

This directory exists only for backwards compatibility documentation.
It may be removed in future versions.
