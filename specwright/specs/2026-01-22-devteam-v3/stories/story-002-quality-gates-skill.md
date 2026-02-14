# Quality Gates Skill Template erstellen

> Story ID: DT3-002
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: Critical
**Type**: Framework
**Estimated Effort**: 2 SP
**Dependencies**: None

---

## Feature

```gherkin
Feature: Quality Gates Skill
  Als Main Agent
  möchte ich einen universellen Quality Gates Skill haben,
  damit ich bei jeder Implementierung die Qualitätsstandards einhalte.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Quality Gates Template existiert

```gherkin
Scenario: Quality Gates Skill Template ist vollständig
  Given das Specwright Framework ist installiert
  When ich das Quality Gates Template prüfe
  Then existiert specwright/templates/skills/quality-gates/Skill.md
  And hat alwaysApply: true im Frontmatter
  And enthält "Before Every Commit" Checklist
  And enthält "Self-Learning Rule" Section
```

### Szenario 2: Quality Gates wird immer geladen

```gherkin
Scenario: Quality Gates ist immer aktiv
  Given ein Projekt hat /build-development-team ausgeführt
  When ich .claude/skills/quality-gates/Skill.md prüfe
  Then ist alwaysApply auf true gesetzt
  And globs ist leer (weil immer aktiv)
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: specwright/templates/skills/quality-gates/Skill.md

### Inhalt-Prüfungen

- [ ] CONTAINS: specwright/templates/skills/quality-gates/Skill.md enthält "alwaysApply: true"
- [ ] CONTAINS: specwright/templates/skills/quality-gates/Skill.md enthält "Before Every Commit"
- [ ] CONTAINS: specwright/templates/skills/quality-gates/Skill.md enthält "Self-Learning Rule"
- [ ] CONTAINS: specwright/templates/skills/quality-gates/Skill.md enthält "dos-and-donts.md"

---

## Technisches Refinement (vom Architect)

### DoR (Definition of Ready) - Vom Architect

#### Fachliche Anforderungen
- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Business Value verstanden

#### Technische Vorbereitung
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert
- [x] Betroffene Komponenten bekannt
- [x] Story ist angemessen geschätzt

**Story ist READY.**

---

### DoD (Definition of Done) - Vom Architect

#### Implementierung
- [ ] Quality Gates Template erstellt
- [ ] alwaysApply: true gesetzt
- [ ] Alle Checklists definiert

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt

---

### Technical Details

**WAS:**
- Erstelle Quality Gates Skill Template
- Universeller Skill der bei JEDER Implementierung aktiv ist
- Enthält Commit-Checklists, Code Review Points, Self-Learning Rules

**WIE (Architektur-Guidance):**
- alwaysApply: true (immer aktiv)
- globs: [] (leer, da immer aktiv)
- Enthält klare Anweisungen wann dos-and-donts.md aktualisiert werden soll
- Enthält klare Anweisungen wann Domain-Dokumente aktualisiert werden sollen

**WO:**
```
specwright/templates/skills/quality-gates/
└── Skill.md
```

**Inhalt Skill.md:**
```yaml
---
description: Universal quality standards and checklists
globs: []
alwaysApply: true
---

# Quality Gates

## Before Every Commit
- [ ] Code compiles without errors
- [ ] All tests pass
- [ ] Linter passes
- [ ] No console.log / debug statements
- [ ] No hardcoded secrets

## Code Review Checklist
...

## Self-Learning Rule
When you learn something during implementation:
1. Technical learning → Add to relevant dos-and-donts.md
2. Domain change → Update relevant domain-*/[process].md
...
```

**Geschätzte Komplexität:** S

---

### Completion Check

```bash
# Verify Quality Gates template exists
test -f specwright/templates/skills/quality-gates/Skill.md && echo "OK"

# Verify alwaysApply is true
grep -q "alwaysApply: true" specwright/templates/skills/quality-gates/Skill.md && echo "alwaysApply OK"

# Verify Self-Learning Rule exists
grep -q "Self-Learning" specwright/templates/skills/quality-gates/Skill.md && echo "Self-Learning OK"
```
