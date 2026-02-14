# Story Index - Worktree Workflow Support

**Spec:** 2026-01-31-worktree-workflow-support
**Created:** 2026-01-31
**Status:** Ready for Execution

## Story Summary

| ID | Title | Type | Priority | Effort | Status | Dependencies | DoR |
|----|-------|------|----------|--------|--------|--------------|-----|
| WTS-001 | Entry-Point CWD Check | Workflow | High | S | Ready | None | Complete |
| WTS-002 | Phase-2 Git Strategy & Symlink | Workflow | High | M | Ready | WTS-001 | Complete |

## Dependency Graph

```
WTS-001 (Entry-Point CWD Check)
    ↓
WTS-002 (Phase-2 Git Strategy & Symlink)
```

## Execution Plan

**Phase 1:**
- WTS-001: Entry-Point CWD Check

**Phase 2 (Nach Phase 1):**
- WTS-002: Phase-2 Git Strategy & Symlink

## Total Estimated Effort

| Effort | Count | Hours (Human) |
|--------|-------|---------------|
| S | 1 | 2-4h |
| M | 1 | 4-8h |
| **Total** | 2 | ~6-12h |

## Story Files

- `stories/story-001-entry-point-cwd-check.md`
- `stories/story-002-phase-2-git-strategy-symlink.md`

---

*Updated: 2026-01-31*
