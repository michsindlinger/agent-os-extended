# Worktree Workflow Support

**Spec:** 2026-01-31-worktree-workflow-support
**Created:** 2026-01-31
**Status:** Ready for Execution

## Summary

Erweitert den `/execute-tasks` Workflow um Git Strategy Support (Branch vs. Worktree).
Wenn Worktree gewählt wird, muss Claude Code im Worktree-Verzeichnis gestartet werden.

## Problem

Aktuell arbeitet der Agent immer im Hauptprojektverzeichnis. Bei Worktree-Nutzung:
- Der Worktree wird erstellt
- Der Worktree-Pfad wird im Resume Context gespeichert
- ABER: Der Agent arbeitet weiterhin im Hauptverzeichnis (falsch!)

## Solution

1. **Entry-Point** prüft Git Strategy aus Resume Context
2. **Bei Worktree-Strategie:**
   - Symlink erstellen: `worktree/agent-os/specs/[spec]` → `root/agent-os/specs/[spec]`
   - User informieren: "Claude Code im Worktree starten"
   - CWD-Check: Warnung wenn nicht im Worktree-Verzeichnis
3. **Bei Branch-Strategie:** Normaler Flow (im Hauptverzeichnis)

## Key Changes

| File | Change |
|------|--------|
| entry-point.md | CWD-Check für Worktree hinzufügen |
| spec-phase-2.md | Git Strategy verarbeiten, Symlink erstellen |
| shared/resume-context.md | Git Strategy Feld dokumentieren |

## Stories

| ID | Title | Type | Effort |
|----|-------|------|--------|
| WTS-001 | Entry-Point CWD Check | Workflow | S |
| WTS-002 | Phase-2 Git Strategy & Symlink | Workflow | M |
