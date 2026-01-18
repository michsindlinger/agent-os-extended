# Skill Loading v4.0

## TL;DR

**Problem:** Skills wurden vom Orchestrator extrahiert, Sub-Agents bekamen nur Quick Reference (50-100 Zeilen), der Rest (500+ Zeilen) wurde nie genutzt.

**Solution:** Orchestrator extrahiert nur Skill-Pfade, Sub-Agents laden **komplette Skills** selbst.

## Quick Facts

| Metric | v3.0 | v4.0 | Change |
|--------|------|------|--------|
| Orchestrator reads skill | ✅ 500+ lines | ❌ 0 lines | **-100%** |
| Sub-Agent receives | Quick Ref only | Complete skill | **+500%** |
| Implementation quality | Good | Excellent | 📈 |

## Architecture

```
v3.0:
┌─────────────┐
│ Orchestrator│ Reads skill → Extracts Quick Ref
└──────┬──────┘
       │ Passes Quick Ref (50-100 lines)
       ▼
┌─────────────┐
│  Sub-Agent  │ Implements with limited context
└─────────────┘

v4.0:
┌─────────────┐
│ Orchestrator│ Reads story → Extracts paths only
└──────┬──────┘
       │ Passes skill paths
       ▼
┌─────────────┐
│  Sub-Agent  │ Loads complete skills (500+ lines)
└─────────────┘ Implements with full context
```

## Files Changed

```
agent-os/workflows/core/execute-tasks/
├── shared/skill-extraction.md   (v3.0 → v4.0)
├── spec-phase-3.md              (extract_skill_patterns → extract_skill_paths)
└── backlog-phase-2.md           (extract_skill_patterns → extract_skill_paths)
```

## Benefits

1. ✅ **Complete Context**: Sub-Agents see all patterns, examples, edge cases
2. ✅ **Better Quality**: Implementation follows full skill guidelines
3. ✅ **Orchestrator Efficiency**: No skill reading overhead (0 lines vs. 500+)
4. ✅ **Simple Logic**: No complex extraction needed

## Example

**Story:**
```markdown
## User Story: User Registration Service

### Relevante Skills
| Skill | Pfad | Grund |
|-------|------|-------|
| Logic Implementing | agent-os/skills/backend-logic-implementing.md | Service Object |
| Test Automation | agent-os/skills/qa-test-automation.md | Unit Tests |
```

**v3.0 Delegation:**
```markdown
DELEGATE:
"Execute Story

{SKILL_PATTERNS}  ← Only Quick Reference (~100 lines)
"
```

**v4.0 Delegation:**
```markdown
DELEGATE:
"Execute Story

**Required Skills (load these files):**
- agent-os/skills/backend-logic-implementing.md  ← Load completely
- agent-os/skills/qa-test-automation.md          ← Load completely

**INSTRUCTIONS:**
- Load each skill file completely
- Follow ALL patterns, examples, and guidelines
"
```

## Usage

No changes needed! Just use workflows as before:

```bash
/create-spec      # Architect assigns skills to stories
/execute-tasks    # Sub-Agents load skills automatically
```

## Backward Compatibility

✅ Fully compatible
- No breaking changes
- Graceful fallback to skill-index.md
- Works with v2.0 projects

## See Also

- **Full Report**: `implementation-report.md`
- **v2.1 Alternative**: `../2026-01-18-selective-skill-loading/` (Selective section loading)
- **Workflow Docs**: `agent-os/workflows/core/execute-tasks/`

---

**Status:** ✅ Implemented
**Date:** 2026-01-18
**Version:** 4.0
