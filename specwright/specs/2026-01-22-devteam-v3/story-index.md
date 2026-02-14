# Story Index: DevTeam v3.0

> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Total Stories: 9
> Total Story Points: 30

## Story Overview

| ID | Titel | Type | Abhängigkeiten | Punkte | Status |
|----|-------|------|----------------|--------|--------|
| DT3-001 | [Technologie Skill Templates](stories/story-001-skill-templates.md) | Framework | None | 5 | Ready |
| DT3-002 | [Quality Gates Skill](stories/story-002-quality-gates-skill.md) | Framework | None | 2 | Ready |
| DT3-003 | [Domain Skill Templates](stories/story-003-domain-skill-templates.md) | Framework | None | 3 | Ready |
| DT3-004 | [build-development-team v3.0](stories/story-004-build-development-team.md) | Workflow | DT3-001, DT3-002, DT3-003 | 5 | Ready |
| DT3-005 | [execute-tasks Direct Execution](stories/story-005-execute-tasks-direct.md) | Workflow | DT3-004 | 5 | Ready |
| DT3-006 | [add-learning Command](stories/story-006-add-learning-command.md) | Workflow | DT3-004 | 3 | Ready |
| DT3-007 | [add-domain Command](stories/story-007-add-domain-command.md) | Workflow | DT3-003, DT3-004 | 3 | Ready |
| DT3-008 | [create-spec Story Template Update](stories/story-008-create-spec-update.md) | Workflow | None | 2 | Ready |
| DT3-009 | [Setup Scripts Update](stories/story-009-setup-scripts.md) | DevOps | DT3-001, DT3-002, DT3-003 | 2 | Ready |

## Dependency Graph

```
DT3-001 (Skill Templates) ─────┐
                               │
DT3-002 (Quality Gates) ───────┼──► DT3-004 (build-development-team) ──► DT3-005 (execute-tasks)
                               │              │                                    │
DT3-003 (Domain Templates) ────┤              │                                    │
        │                      │              ▼                                    │
        │                      │      DT3-006 (add-learning) ◄─────────────────────┘
        │                      │
        └──────────────────────┼──► DT3-007 (add-domain)
                               │
                               └──► DT3-009 (Setup Scripts)

DT3-008 (Story Template) ──────── (keine Abhängigkeiten)
```

## Empfohlene Ausführungsreihenfolge

### Phase 1: Templates (parallel ausführbar)
1. **DT3-001** - Technologie Skill Templates
2. **DT3-002** - Quality Gates Skill
3. **DT3-003** - Domain Skill Templates
4. **DT3-008** - Story Template Update

### Phase 2: Core Workflows (sequenziell)
5. **DT3-004** - build-development-team v3.0
6. **DT3-005** - execute-tasks Direct Execution

### Phase 3: Erweiterungen (parallel ausführbar)
7. **DT3-006** - add-learning Command
8. **DT3-007** - add-domain Command

### Phase 4: Deployment
9. **DT3-009** - Setup Scripts Update

## Story Points nach Typ

| Type | Stories | Points |
|------|---------|--------|
| Framework | 3 | 10 |
| Workflow | 5 | 18 |
| DevOps | 1 | 2 |
| **Total** | **9** | **30** |
