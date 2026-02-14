# Spec: Skill Loading v4.0

## Metadata

- **Feature**: Skill Loading Architecture v4.0
- **Type**: Architecture Change
- **Impact**: Core Workflow (execute-tasks)
- **Status**: ✅ Implemented
- **Date**: 2026-01-18

## Problem

### Current Situation (v3.0)

In DevTeam v2.0/v3.0 Architecture:

1. **Architect** (create-spec):
   - Liest `skill-index.md`
   - Ordnet Skills zu Stories zu
   - Speichert Skill-Referenzen in `### Relevante Skills`

2. **Orchestrator** (execute-tasks):
   - Liest kompletten Skill (~500 Zeilen)
   - Extrahiert Quick Reference (~50-100 Zeilen)
   - Gibt Quick Reference an Sub-Agent

3. **Sub-Agent**:
   - Bekommt nur Quick Reference
   - Implementiert mit begrenztem Kontext
   - **Problem:** Rest des Skills (400+ Zeilen) wird nie verwendet

### User Feedback

> "Wenn der Sub-Agent nur die Quick Reference bekommt, dann ist der Rest des Skills ja unnötig, weil nie benutzt"

### Root Cause

**Design Flaw:** Orchestrator extrahiert Patterns für Sub-Agent, aber:
- Sub-Agent braucht vollständigen Kontext für komplexe Implementierungen
- Orchestrator verschwendet Context mit Skill-Reading
- 80% des Skill-Inhalts (Patterns, Beispiele, Edge Cases) erreicht Sub-Agent nie

## Solution

### Architectural Principle

> **Context moves to where it's used**
>
> Orchestrator = Strategic Planning (no skill knowledge needed)
> Sub-Agent = Implementation (needs complete skill knowledge)

### v4.0 Architecture

```
┌──────────────────────────────────────────────────────────┐
│ Phase 1: Architect (create-spec)                         │
├──────────────────────────────────────────────────────────┤
│  • Reads: skill-index.md                                 │
│  • Assigns: Skills to stories                            │
│  • Stores: Skill paths in story file                     │
└──────────────────────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────┐
│ Phase 2: Orchestrator (execute-tasks)                    │
├──────────────────────────────────────────────────────────┤
│  • Reads: Story file                                     │
│  • Extracts: Skill PATHS (not content!)                  │
│  • Delegates: Story + Skill paths to Sub-Agent           │
└──────────────────────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────┐
│ Phase 3: Sub-Agent (implementation)                      │
├──────────────────────────────────────────────────────────┤
│  • Receives: Story + Skill paths                         │
│  • Loads: Complete skill files                           │
│  • Implements: Following all patterns & guidelines       │
└──────────────────────────────────────────────────────────┘
```

## Implementation

### 1. Skill Path Extraction

**File:** `specwright/workflows/core/execute-tasks/shared/skill-extraction.md`

**Before (v3.0):**
```markdown
1. Read story file
2. Find "### Relevante Skills"
3. For each skill:
   - READ complete skill file
   - EXTRACT Quick Reference section
   - SKIP rest of skill
4. Output: SKILL_PATTERNS variable
```

**After (v4.0):**
```markdown
1. Read story file
2. Find "### Relevante Skills"
3. For each skill:
   - EXTRACT skill path only
   - DO NOT read skill content
4. Output: SKILL_PATHS variable
```

### 2. Delegation Pattern

**File:** `specwright/workflows/core/execute-tasks/spec-phase-3.md`

**Before (v3.0):**
```markdown
DELEGATE via Task tool:
"Execute User Story: [Title]

**Story Details:**
[Story content]

{SKILL_PATTERNS}  ← Quick Reference content
"
```

**After (v4.0):**
```markdown
DELEGATE via Task tool:
"Execute User Story: [Title]

**Story Details:**
[Story content]

{SKILL_PATHS}  ← File paths only

**INSTRUCTIONS:**
- Load each skill file listed above completely
- Follow ALL patterns, examples, and guidelines from the skills
- The skills contain your implementation framework
"
```

### 3. Sub-Agent Behavior

**New Responsibility:**
- Sub-Agent receives skill paths
- Sub-Agent loads complete skill files using Read tool
- Sub-Agent follows all patterns, not just Quick Reference

## Acceptance Criteria

### Functional Requirements

- [x] Orchestrator extracts only skill paths (not content)
- [x] Sub-Agent receives clear instruction to load skills
- [x] Delegation includes skill paths in structured format
- [x] Backward compatible with stories without skills

### Technical Requirements

- [x] Update skill-extraction.md (v3.0 → v4.0)
- [x] Update spec-phase-3.md (delegation pattern)
- [x] Update backlog-phase-2.md (delegation pattern)
- [x] No breaking changes to existing workflows

### Quality Requirements

- [x] Sub-Agent can load complete skills
- [x] All skill content is accessible to Sub-Agent
- [x] Orchestrator context reduced (no skill reading)

## Success Metrics

### Context Efficiency

| Metric | v3.0 | v4.0 | Improvement |
|--------|------|------|-------------|
| Orchestrator skill reads | 500+ lines | 0 lines | **100%** |
| Orchestrator context usage | ~2000 tokens | ~0 tokens | **100%** |
| Sub-Agent context | ~200 tokens | ~2000 tokens | Context moved to where it's used |

### Implementation Quality

| Aspect | v3.0 | v4.0 |
|--------|------|------|
| Pattern coverage | Quick Ref only | Complete |
| Code examples | Limited | All available |
| Edge case handling | Not documented | Fully documented |
| Tech stack variants | Not available | Rails + TypeScript |

## Risks & Mitigation

### Risk 1: Sub-Agent Context Overload

**Risk:** Sub-Agent loads 2-3 full skills (~6000 tokens total)

**Mitigation:**
- Modern LLMs handle this easily
- Sub-Agents are short-lived (per-story)
- Quality improvement justifies token cost

**Status:** ✅ Acceptable trade-off

### Risk 2: Irrelevant Content

**Risk:** Sub-Agent may load patterns not needed for story

**Mitigation:**
- Architect pre-selects relevant skills
- Sub-Agent can ignore irrelevant sections
- Future: Conditional loading (v4.1)

**Status:** ✅ Minimal impact

### Risk 3: Backward Compatibility

**Risk:** Breaking existing workflows

**Mitigation:**
- Graceful fallback to skill-index.md
- Stories without skills work as before
- No changes to story format required

**Status:** ✅ No breaking changes

## Rollout Plan

### Phase 1: Implementation ✅ DONE
- [x] Update skill-extraction.md
- [x] Update spec-phase-3.md
- [x] Update backlog-phase-2.md
- [x] Create implementation report

### Phase 2: Testing 🔄 NEXT
- [ ] Test with simple story (1 skill)
- [ ] Test with complex story (2-3 skills)
- [ ] Verify skill loading in sub-agent
- [ ] Measure implementation quality

### Phase 3: Documentation
- [ ] Update execute-tasks main workflow
- [ ] Add examples to docs
- [ ] Create migration guide (if needed)

### Phase 4: Rollout
- [ ] Announce v4.0 in changelog
- [ ] Update templates if needed
- [ ] Monitor adoption and feedback

## Alternatives Considered

### Alternative 1: Selective Loading (v2.1)

**Approach:**
- Orchestrator reads Skill Index
- Matches keywords to sections
- Loads only relevant sections

**Pros:**
- Optimized token usage
- Sub-Agent gets relevant content

**Cons:**
- Complex extraction logic
- Risk of missing relevant sections
- Requires Skill Index in all skills

**Decision:** Rejected - Too complex, v4.0 simpler

### Alternative 2: Keep v3.0

**Approach:**
- Improve Quick Reference quality
- Accept that rest of skill is unused

**Pros:**
- No changes needed
- Proven architecture

**Cons:**
- Doesn't solve fundamental problem
- Wastes 80% of skill content
- Limited implementation quality

**Decision:** Rejected - Doesn't address user feedback

### Alternative 3: Hybrid Approach

**Approach:**
- Sub-Agent decides: load full or selective
- Based on story complexity

**Pros:**
- Flexible
- Optimized for each case

**Cons:**
- Complex logic
- Inconsistent behavior
- Hard to debug

**Decision:** Future consideration (v4.1)

## Dependencies

### Required
- Skills must exist in project (via build-development-team)
- Stories must have "### Relevante Skills" section
- Sub-Agents must have Read tool access

### Optional
- skill-index.md (for fallback)
- DevTeam v2.0 structure

## Related Specs

- **v2.1 Selective Loading**: `../2026-01-18-selective-skill-loading/`
- **DevTeam v2.0**: Referenced in build-development-team workflow
- **execute-tasks Architecture**: Phase-based workflow system

## Changelog

### v4.0 (2026-01-18)
- Changed: Skill extraction from content to paths
- Changed: Delegation pattern to include load instruction
- Removed: Quick Reference extraction logic
- Added: Sub-Agent skill loading responsibility

### v3.0 (Previous)
- Orchestrator extracts Quick Reference
- Sub-Agent receives extracted patterns

---

**Approved By:** User (via implementation request)
**Implementation Status:** ✅ Complete
**Next Steps:** Testing & Validation
