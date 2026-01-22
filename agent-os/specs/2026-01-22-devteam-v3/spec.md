# Spec Requirements Document

> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Status: Planning

## Overview

Diese Spec implementiert eine grundlegende Architekturänderung des DevTeam-Systems. Statt Sub-Agents für die Story-Ausführung zu verwenden (was zu Context-Verlust und Integrationsproblemen führt), führt der Main Agent Stories direkt aus und lädt die benötigten Skills automatisch.

Zusätzlich wird ein Self-Learning-Mechanismus eingeführt: Der Agent dokumentiert seine Erkenntnisse in `dos-and-donts.md` Dateien und hält fachliche Domain-Dokumentation automatisch aktuell.

## User Stories

Siehe: Stories in `agent-os/specs/2026-01-22-devteam-v3/stories/`

| ID | Titel | Type | Abhängigkeiten | Punkte |
|----|-------|------|----------------|--------|
| DT3-001 | Technologie Skill Templates | Framework | None | 5 |
| DT3-002 | Quality Gates Skill | Framework | None | 2 |
| DT3-003 | Domain Skill Templates | Framework | None | 3 |
| DT3-004 | build-development-team v3.0 | Workflow | DT3-001, DT3-002, DT3-003 | 5 |
| DT3-005 | execute-tasks Direct Execution | Workflow | DT3-004 | 5 |
| DT3-006 | add-learning Command | Workflow | DT3-004 | 3 |
| DT3-007 | add-domain Command | Workflow | DT3-003, DT3-004 | 3 |
| DT3-008 | create-spec Story Template Update | Workflow | None | 2 |
| DT3-009 | Setup Scripts Update | DevOps | DT3-001, DT3-002, DT3-003 | 2 |

## Spec Scope

**Included:**
- Neue Skill-Struktur in `.claude/skills/[name]/Skill.md`
- Skill Templates pro Technologie (Angular, React, Rails, NestJS, etc.)
- Quality Gates Skill (universal, alwaysApply: true)
- Domain Skills für fachliche Dokumentation
- Self-Learning Mechanismus (dos-and-donts.md)
- Überarbeiteter build-development-team Workflow (v3.0)
- Überarbeiteter execute-tasks Workflow (Direct Execution)
- Neuer /add-learning Command
- Neuer /add-domain Command
- Angepasstes Story Template (ohne Agent-Feld)
- Aktualisierte Setup Scripts

**Key Changes:**
- Skills werden in `.claude/skills/` angelegt (Standard-konform)
- Ein Skill pro Technologie mit Sub-Dokumenten
- Skill.md als Index, Detail-Dokumente zum Nachladen
- Main Agent führt Stories selbst aus (keine Delegation)
- Automatisches Skill-Loading via glob patterns

## Out of Scope

- Migration bestehender v2.0 Projekte (separate Migration Spec)
- Parallele Story-Ausführung (bleibt bei separaten Worktrees)
- Änderungen an create-spec Workflow (nur Story Template)
- Änderungen an anderen Workflows (plan-product, etc.)
- MCP-Server Integrationen

## Expected Deliverable

Ein vollständig überarbeitetes DevTeam-System mit:

1. **Skill Templates** (in `agent-os/templates/skills/`)
   - Frontend Templates (Angular, React, Vue)
   - Backend Templates (Rails, NestJS, Spring)
   - DevOps Templates
   - Domain Templates
   - Quality Gates Template

2. **Workflows** (in `agent-os/workflows/core/`)
   - build-development-team.md (v3.0)
   - execute-tasks.md (Direct Execution)
   - add-learning.md (neu)
   - add-domain.md (neu)

3. **Commands** (in `.claude/commands/agent-os/`)
   - build-development-team.md (aktualisiert)
   - execute-tasks.md (aktualisiert)
   - add-learning.md (neu)
   - add-domain.md (neu)

4. **Templates** (in `agent-os/templates/docs/`)
   - story-template.md (ohne Agent-Feld)

5. **Setup Scripts** (aktualisiert)
   - setup-devteam-global.sh

## Integration Requirements

> Diese Integration Tests stellen sicher, dass das neue System korrekt funktioniert.

**Integration Type:** Framework-only (keine Runtime-Integration)

- [ ] **Integration Test 1:** Skill Template Validierung
   - Command: `ls -la agent-os/templates/skills/frontend/angular/ | wc -l`
   - Validates: Alle Angular Skill-Dateien existieren
   - Requires MCP: no

- [ ] **Integration Test 2:** Build-Development-Team generiert korrekte Struktur
   - Command: `test -d .claude/skills && echo "OK"`
   - Validates: Skills werden in korrektem Pfad erstellt
   - Requires MCP: no

- [ ] **Integration Test 3:** Execute-Tasks lädt Skills
   - Command: `grep -q "globs:" .claude/skills/*/Skill.md`
   - Validates: Skills haben YAML Frontmatter mit globs
   - Requires MCP: no

**Integration Scenarios:**
- [ ] Scenario 1: Neues Projekt setup mit /build-development-team erstellt Skills in .claude/skills/
- [ ] Scenario 2: /execute-tasks führt Story ohne Sub-Agent Delegation aus
- [ ] Scenario 3: /add-learning fügt Eintrag zu dos-and-donts.md hinzu

## Spec Documentation

- Stories: @agent-os/specs/2026-01-22-devteam-v3/stories/
- Architektur-Diagramm: Siehe Overview in diesem Dokument

---

## Architektur-Übersicht

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DevTeam v3.0 Architektur                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Main Agent                                                                 │
│      │                                                                      │
│      ├── Lädt Skills automatisch (.claude/skills/)                          │
│      │       ├── Technologie-Skills (frontend-angular/, backend-rails/)     │
│      │       ├── Fachliche Skills (domain-[projekt]/)                       │
│      │       └── Quality Gates (quality-gates/)                             │
│      │                                                                      │
│      ├── Implementiert Stories selbst                                       │
│      │                                                                      │
│      └── LERNT: Aktualisiert Skills bei Erkenntnissen                       │
│              ├── dos-and-donts.md (technische Learnings)                    │
│              └── domain-*.md (fachliche Änderungen)                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Skill-Struktur

```
.claude/skills/
│
├── quality-gates/                    # Universal (alwaysApply: true)
│   └── Skill.md
│
├── frontend-[framework]/             # z.B. frontend-angular/
│   ├── Skill.md                      # Index + Quick Reference
│   ├── components.md                 # Component Patterns
│   ├── state-management.md           # State Patterns
│   ├── api-integration.md            # API/HTTP Patterns
│   ├── forms-validation.md           # Forms Patterns
│   └── dos-and-donts.md              # Self-Learning
│
├── backend-[framework]/              # z.B. backend-rails/
│   ├── Skill.md                      # Index + Quick Reference
│   ├── services.md                   # Service Patterns
│   ├── models.md                     # Model Patterns
│   ├── api-design.md                 # API Design
│   ├── testing.md                    # Testing Patterns
│   └── dos-and-donts.md              # Self-Learning
│
└── domain-[projekt]/                 # Fachliche Skills
    ├── Skill.md                      # Index der Bereiche
    ├── [prozess-1].md                # z.B. user-registration.md
    └── [prozess-n].md
```
