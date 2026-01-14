# Git Worktrees for Parallel Spec Execution

## Purpose

This directory contains git worktrees for parallel spec execution. Each spec gets its own isolated worktree, allowing multiple specs to be implemented simultaneously without branch conflicts.

## Structure

```
agent-os/worktrees/
├── feature-a/           # Worktree for feature-a spec
│   ├── .git             # Git worktree link
│   └── [project files] # Working directory for this spec
├── feature-b/           # Worktree for feature-b spec
└── README.md           # This file
```

## Lifecycle

1. **Created**: During `/execute-tasks` Phase 2 (Git Branch Setup)
2. **Used**: During story execution (Phase 3)
3. **Removed**: After PR merge (Phase 4 - Finalize)

## Rules

- Worktree name = Spec folder name (without YYYY-MM-DD prefix)
- Example: `2026-01-14-user-auth` → worktree: `agent-os/worktrees/user-auth`
- Each worktree has its own git branch
- Worktrees are temporary - deleted after PR merge

## Parallel Execution

Multiple specs can execute in parallel because each has:
- Separate worktree directory
- Separate git branch
- Independent working state

## Cleanup

After PR merge, run:
```bash
git worktree remove agent-os/worktrees/[worktree-name]
```
