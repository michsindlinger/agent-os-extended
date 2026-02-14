# User Stories

> Spec: Anthropic Skills Format Migration
> Created: 2026-01-12
> Last Updated: 2026-01-12

## Story Overview

This document contains all user stories for the Anthropic Skills Format Migration specification.

**Total Stories**: 6
**Estimated Effort**: S-M (gesamt ca. 12 SP)

---

## Story 1: Migration der Root-Level Skill Templates

**ID**: SKILL-001
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: None

### User Story

Als Specwright Maintainer
moechte ich die Root-Level Skill Templates im neuen Anthropic Format haben,
damit Claude Code die Skills korrekt erkennt und laedt.

### Akzeptanzkriterien (Pruefbar)

**Datei-Pruefungen:**
- [ ] FILE_EXISTS: specwright/templates/skills/api-implementation-patterns/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/component-architecture/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/deployment-automation/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/file-organization-patterns/SKILL.md
- [ ] FILE_NOT_EXISTS: specwright/templates/skills/api-implementation-patterns-template.md

**Inhalt-Pruefungen:**
- [ ] CONTAINS: api-implementation-patterns/SKILL.md enthaelt den originalen Skill-Inhalt

### Business Value

Offizielle Kompatibilitaet mit Claude Code und Zukunftssicherheit durch Nutzung des Anthropic-empfohlenen Formats.

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Lint passes

**Technical Details:**

**WAS:**
- Migration von 5 Root-Level Skill Templates zum Anthropic Format
- Betroffene Skills: api-implementation-patterns, component-architecture, deployment-automation, file-organization-patterns, testing-strategies
- Jeder Skill wird von `skill-name-template.md` zu `skill-name/SKILL.md` konvertiert

**WIE:**
1. Fuer jeden Skill: Ordner mit Skill-Namen erstellen (ohne `-template` Suffix)
2. Vorhandene `-template.md` Datei zu `SKILL.md` im neuen Ordner umbenennen/kopieren
3. YAML Frontmatter beibehalten (name, description, globs bereits vorhanden)
4. Alte `-template.md` Datei loeschen
5. `.md.template` Dateien (api-patterns.md.template etc.) ebenfalls in passende Skill-Ordner verschieben

**WO:**
- Quell-Dateien: `specwright/templates/skills/*-template.md`
- Ziel-Ordner: `specwright/templates/skills/{skill-name}/SKILL.md`
- Zusaetzlich: `specwright/templates/skills/*.md.template` -> entsprechende Skill-Ordner

**WER:** `file-creator` Agent (aus `.claude/agents/file-creator.md`)

**Abhaengigkeiten:** None

**Geschaetzte Komplexitaet:** S

**Completion Check:**
```bash
# Auto-Verify Commands - all must exit with 0
test -f specwright/templates/skills/api-implementation-patterns/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/component-architecture/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/deployment-automation/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/file-organization-patterns/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/testing-strategies/SKILL.md && echo "OK" || exit 1
test ! -f specwright/templates/skills/api-implementation-patterns-template.md && echo "OK" || exit 1
grep -q "name:" specwright/templates/skills/api-implementation-patterns/SKILL.md && echo "OK" || exit 1
```

**Story ist DONE wenn:**
1. Alle FILE_EXISTS checks fuer neue SKILL.md Dateien bestanden
2. Alle FILE_NOT_EXISTS checks fuer alte -template.md Dateien bestanden
3. YAML Frontmatter in allen neuen SKILL.md Dateien vorhanden

---

## Story 2: Migration der Frontend Dev-Team Skills

**ID**: SKILL-002
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: None

### User Story

Als Frontend-Entwickler im Dev-Team
moechte ich die Frontend-Skills im neuen Anthropic Format haben,
damit ich von der erweiterten Ordnerstruktur (scripts, references) profitieren kann.

### Akzeptanzkriterien (Pruefbar)

**Datei-Pruefungen:**
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/frontend/ui-component-architecture/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/frontend/state-management/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/frontend/api-bridge-building/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/frontend/interaction-designing/SKILL.md
- [ ] FILE_NOT_EXISTS: specwright/templates/skills/dev-team/frontend/ui-component-architecture-template.md

**Inhalt-Pruefungen:**
- [ ] CONTAINS: ui-component-architecture/SKILL.md enthaelt "Component Architecture"

### Business Value

Einheitliches Format fuer alle Dev-Team Rollen und bessere Organisation der Frontend-Patterns.

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Lint passes

**Technical Details:**

**WAS:**
- Migration von 4 Frontend Dev-Team Skill Templates zum Anthropic Format
- Betroffene Skills: ui-component-architecture, state-management, api-bridge-building, interaction-designing
- Ordnerstruktur: `dev-team/frontend/{skill-name}/SKILL.md`

**WIE:**
1. Fuer jeden Frontend-Skill: Ordner mit Skill-Namen erstellen
2. Vorhandene `{skill}-template.md` Datei zu `SKILL.md` im neuen Ordner verschieben
3. YAML Frontmatter pruefen und ggf. ergaenzen (name, description)
4. Alte `-template.md` Datei loeschen
5. Bestehende Ordnerstruktur `dev-team/frontend/` beibehalten

**WO:**
- Quell-Dateien: `specwright/templates/skills/dev-team/frontend/*-template.md`
- Ziel-Ordner: `specwright/templates/skills/dev-team/frontend/{skill-name}/SKILL.md`

**WER:** `file-creator` Agent (aus `.claude/agents/file-creator.md`)

**Abhaengigkeiten:** None (kann parallel zu SKILL-001, SKILL-003, SKILL-004, SKILL-005 ausgefuehrt werden)

**Geschaetzte Komplexitaet:** S

**Completion Check:**
```bash
# Auto-Verify Commands - all must exit with 0
test -f specwright/templates/skills/dev-team/frontend/ui-component-architecture/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/frontend/state-management/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/frontend/api-bridge-building/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/frontend/interaction-designing/SKILL.md && echo "OK" || exit 1
test ! -f specwright/templates/skills/dev-team/frontend/ui-component-architecture-template.md && echo "OK" || exit 1
grep -qi "component" specwright/templates/skills/dev-team/frontend/ui-component-architecture/SKILL.md && echo "OK" || exit 1
```

**Story ist DONE wenn:**
1. Alle 4 Frontend SKILL.md Dateien existieren
2. Alle alten -template.md Dateien geloescht
3. Inhalt "Component Architecture" in ui-component-architecture/SKILL.md vorhanden

---

## Story 3: Migration der Backend Dev-Team Skills

**ID**: SKILL-003
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: None

### User Story

Als Backend-Entwickler im Dev-Team
moechte ich die Backend-Skills im neuen Anthropic Format haben,
damit die Skills konsistent mit dem Frontend-Team strukturiert sind.

### Akzeptanzkriterien (Pruefbar)

**Datei-Pruefungen:**
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/backend/logic-implementing/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/backend/persistence-adapter/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/backend/integration-adapter/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/backend/test-engineering/SKILL.md
- [ ] FILE_NOT_EXISTS: specwright/templates/skills/dev-team/backend/logic-implementing-template.md

**Inhalt-Pruefungen:**
- [ ] CONTAINS: logic-implementing/SKILL.md enthaelt den originalen Skill-Inhalt

### Business Value

Konsistente Skill-Struktur ueber alle Dev-Team Rollen hinweg.

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Lint passes

**Technical Details:**

**WAS:**
- Migration von 4 Backend Dev-Team Skill Templates zum Anthropic Format
- Betroffene Skills: logic-implementing, persistence-adapter, integration-adapter, test-engineering
- Ordnerstruktur: `dev-team/backend/{skill-name}/SKILL.md`

**WIE:**
1. Fuer jeden Backend-Skill: Ordner mit Skill-Namen erstellen
2. Vorhandene `{skill}-template.md` Datei zu `SKILL.md` im neuen Ordner verschieben
3. YAML Frontmatter pruefen und ggf. ergaenzen (name, description)
4. Alte `-template.md` Datei loeschen
5. Bestehende Ordnerstruktur `dev-team/backend/` beibehalten

**WO:**
- Quell-Dateien: `specwright/templates/skills/dev-team/backend/*-template.md`
- Ziel-Ordner: `specwright/templates/skills/dev-team/backend/{skill-name}/SKILL.md`

**WER:** `file-creator` Agent (aus `.claude/agents/file-creator.md`)

**Abhaengigkeiten:** None (kann parallel zu SKILL-001, SKILL-002, SKILL-004, SKILL-005 ausgefuehrt werden)

**Geschaetzte Komplexitaet:** S

**Completion Check:**
```bash
# Auto-Verify Commands - all must exit with 0
test -f specwright/templates/skills/dev-team/backend/logic-implementing/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/backend/persistence-adapter/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/backend/integration-adapter/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/backend/test-engineering/SKILL.md && echo "OK" || exit 1
test ! -f specwright/templates/skills/dev-team/backend/logic-implementing-template.md && echo "OK" || exit 1
grep -q "---" specwright/templates/skills/dev-team/backend/logic-implementing/SKILL.md && echo "OK" || exit 1
```

**Story ist DONE wenn:**
1. Alle 4 Backend SKILL.md Dateien existieren
2. Alle alten -template.md Dateien geloescht
3. YAML Frontmatter in allen neuen Dateien vorhanden

---

## Story 4: Migration der Architect, DevOps, QA und PO Skills

**ID**: SKILL-004
**Priority**: High
**Estimated Effort**: S (3 SP)
**Dependencies**: None

### User Story

Als Architect, DevOps-Engineer, QA-Tester oder Product Owner im Dev-Team
moechte ich meine rollenspezifischen Skills im neuen Anthropic Format haben,
damit alle Team-Rollen einheitlich arbeiten koennen.

### Akzeptanzkriterien (Pruefbar)

**Datei-Pruefungen:**
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/architect/pattern-enforcement/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/devops/pipeline-engineering/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/qa/test-strategy/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/po/requirements-engineering/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/dev-team/documenter/changelog-generation/SKILL.md

**Inhalt-Pruefungen:**
- [ ] CONTAINS: architect/pattern-enforcement/SKILL.md enthaelt "Pattern Enforcement"

### Business Value

Vollstaendige Migration aller Dev-Team Rollen sichert einheitliche Arbeitsweise.

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Lint passes

**Technical Details:**

**WAS:**
- Migration aller verbleibenden Dev-Team Rollen zum Anthropic Format
- Betroffene Rollen und ihre Skills:
  - **Architect**: pattern-enforcement, api-designing, security-guidance, data-modeling, dependency-checking (5 Skills)
  - **DevOps**: pipeline-engineering, infrastructure-provisioning, observability-management, security-hardening (4 Skills)
  - **QA**: test-strategy, test-automation, quality-metrics, regression-testing (4 Skills)
  - **PO**: requirements-engineering, data-analysis, acceptance-testing, backlog-organization (4 Skills)
  - **Documenter**: changelog-generation, api-documentation, user-guide-writing, code-documentation (4 Skills)
- Insgesamt: 21 Skills

**WIE:**
1. Fuer jede Rolle (architect, devops, qa, po, documenter): Skills iterativ migrieren
2. Fuer jeden Skill: Ordner erstellen, Datei zu SKILL.md verschieben
3. YAML Frontmatter pruefen und ggf. ergaenzen
4. Alte `-template.md` Dateien loeschen
5. Ordnerstruktur `dev-team/{role}/{skill-name}/SKILL.md` einhalten

**WO:**
- Quell-Dateien: `specwright/templates/skills/dev-team/{role}/*-template.md`
- Ziel-Ordner: `specwright/templates/skills/dev-team/{role}/{skill-name}/SKILL.md`
- Betroffene Rollen-Ordner: architect, devops, qa, po, documenter

**WER:** `file-creator` Agent (aus `.claude/agents/file-creator.md`)

**Abhaengigkeiten:** None (kann parallel zu SKILL-001, SKILL-002, SKILL-003, SKILL-005 ausgefuehrt werden)

**Geschaetzte Komplexitaet:** S (3 SP wegen Anzahl der Skills)

**Completion Check:**
```bash
# Auto-Verify Commands - all must exit with 0
# Architect Skills
test -f specwright/templates/skills/dev-team/architect/pattern-enforcement/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/architect/api-designing/SKILL.md && echo "OK" || exit 1
# DevOps Skills
test -f specwright/templates/skills/dev-team/devops/pipeline-engineering/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/devops/infrastructure-provisioning/SKILL.md && echo "OK" || exit 1
# QA Skills
test -f specwright/templates/skills/dev-team/qa/test-strategy/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/dev-team/qa/test-automation/SKILL.md && echo "OK" || exit 1
# PO Skills
test -f specwright/templates/skills/dev-team/po/requirements-engineering/SKILL.md && echo "OK" || exit 1
# Documenter Skills
test -f specwright/templates/skills/dev-team/documenter/changelog-generation/SKILL.md && echo "OK" || exit 1
# Verify old files removed
test ! -f specwright/templates/skills/dev-team/architect/pattern-enforcement-template.md && echo "OK" || exit 1
# Verify content
grep -qi "pattern" specwright/templates/skills/dev-team/architect/pattern-enforcement/SKILL.md && echo "OK" || exit 1
```

**Story ist DONE wenn:**
1. Alle 21 SKILL.md Dateien in den entsprechenden Rollen-Ordnern existieren
2. Alle alten -template.md Dateien geloescht
3. Inhalt "Pattern Enforcement" in architect/pattern-enforcement/SKILL.md vorhanden

---

## Story 5: Migration der Platform und Orchestration Skills

**ID**: SKILL-005
**Priority**: Medium
**Estimated Effort**: S (1 SP)
**Dependencies**: None

### User Story

Als Platform-Architekt
moechte ich die Platform- und Orchestration-Skills im neuen Anthropic Format haben,
damit auch diese spezialisierten Skills dem Standard entsprechen.

### Akzeptanzkriterien (Pruefbar)

**Datei-Pruefungen:**
- [ ] FILE_EXISTS: specwright/templates/skills/platform/dependency-management/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/platform/modular-architecture/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/platform/platform-scalability/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/platform/system-integration-patterns/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/orchestration/orchestration/SKILL.md

**Inhalt-Pruefungen:**
- [ ] CONTAINS: platform/dependency-management/SKILL.md enthaelt "Dependency Management"

### Business Value

Vollstaendige Abdeckung aller Skill-Kategorien im neuen Format.

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Lint passes

**Technical Details:**

**WAS:**
- Migration der Platform und Orchestration Skill Templates zum Anthropic Format
- Betroffene Skills:
  - **Platform**: dependency-management, modular-architecture, platform-scalability, system-integration-patterns (4 Skills)
  - **Orchestration**: orchestration (1 Skill)
- Insgesamt: 5 Skills

**WIE:**
1. Fuer Platform-Skills: `platform/{skill-name}/SKILL.md` Struktur erstellen
2. Fuer Orchestration: `orchestration/orchestration/SKILL.md` Struktur erstellen
3. Vorhandene `-template.md` Dateien zu SKILL.md verschieben
4. YAML Frontmatter pruefen und ggf. ergaenzen
5. Alte `-template.md` Dateien loeschen

**WO:**
- Quell-Dateien Platform: `specwright/templates/skills/platform/*-template.md`
- Quell-Dateien Orchestration: `specwright/templates/skills/orchestration/*-template.md`
- Ziel-Ordner Platform: `specwright/templates/skills/platform/{skill-name}/SKILL.md`
- Ziel-Ordner Orchestration: `specwright/templates/skills/orchestration/orchestration/SKILL.md`

**WER:** `file-creator` Agent (aus `.claude/agents/file-creator.md`)

**Abhaengigkeiten:** None (kann parallel zu SKILL-001 bis SKILL-004 ausgefuehrt werden)

**Geschaetzte Komplexitaet:** XS

**Completion Check:**
```bash
# Auto-Verify Commands - all must exit with 0
# Platform Skills
test -f specwright/templates/skills/platform/dependency-management/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/platform/modular-architecture/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/platform/platform-scalability/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/platform/system-integration-patterns/SKILL.md && echo "OK" || exit 1
# Orchestration Skills
test -f specwright/templates/skills/orchestration/orchestration/SKILL.md && echo "OK" || exit 1
# Verify old files removed
test ! -f specwright/templates/skills/platform/dependency-management-template.md && echo "OK" || exit 1
test ! -f specwright/templates/skills/orchestration/orchestration-template.md && echo "OK" || exit 1
# Verify content
grep -qi "dependency" specwright/templates/skills/platform/dependency-management/SKILL.md && echo "OK" || exit 1
```

**Story ist DONE wenn:**
1. Alle 5 SKILL.md Dateien (4 Platform + 1 Orchestration) existieren
2. Alle alten -template.md Dateien geloescht
3. Inhalt "Dependency Management" in platform/dependency-management/SKILL.md vorhanden

---

## Story 6: Migrations-Script fuer bestehende Projekte

**ID**: SKILL-006
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: SKILL-001 bis SKILL-005 (als Referenz)

### User Story

Als Nutzer von Specwright mit bestehendem Dev-Team
moechte ich ein Script haben, das meine bestehenden Skills automatisch migriert,
damit ich nicht manuell jede Skill-Datei umstrukturieren muss.

### Akzeptanzkriterien (Pruefbar)

**Datei-Pruefungen:**
- [ ] FILE_EXISTS: specwright/scripts/migrate-skills-format.sh
- [ ] FILE_EXISTS: specwright/templates/skills/generic-skill/SKILL.md
- [ ] FILE_EXISTS: specwright/templates/skills/skill/SKILL.md

**Inhalt-Pruefungen:**
- [ ] CONTAINS: migrate-skills-format.sh enthaelt "#!/bin/bash"
- [ ] CONTAINS: migrate-skills-format.sh enthaelt "SKILL.md"
- [ ] CONTAINS: migrate-skills-format.sh enthaelt Fehlerbehandlung mit "echo" oder "exit"

**Funktions-Pruefungen:**
- [ ] LINT_PASS: shellcheck specwright/scripts/migrate-skills-format.sh exits with 0

### Business Value

Automatisierte Migration spart Zeit und verhindert Fehler bei der manuellen Konvertierung. Ermoeglicht einfache Adoption des neuen Formats in bestehenden Projekten.

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Lint passes

**Technical Details:**

**WAS:**
- Bash-Script zur automatischen Migration von alten Skill-Dateien zum Anthropic Format
- Migration von `generic-skill-template.md` zu `generic-skill/SKILL.md`
- Migration von `skill-template.md` zu `skill/SKILL.md`
- Script soll in beliebigen Projekten mit bestehendem Dev-Team einsetzbar sein

**WIE:**
1. Script erkennt alle `-template.md` Dateien im Zielverzeichnis
2. Fuer jede gefundene Datei:
   - Extrahiert Skill-Namen (entfernt `-template` Suffix)
   - Erstellt neuen Ordner mit Skill-Namen
   - Verschiebt/kopiert Datei zu `SKILL.md` im neuen Ordner
   - Loescht alte Datei (optional mit --delete Flag)
3. Fehlerbehandlung: Ausgabe bei Problemen (Ordner existiert bereits, Datei nicht lesbar, etc.)
4. Trockenlauf-Modus (--dry-run) fuer Vorschau
5. Verbose-Modus (--verbose) fuer detaillierte Ausgabe

**Script-Struktur:**
```bash
#!/bin/bash
# migrate-skills-format.sh
# Migriert Skills vom alten flachen Format zum Anthropic Ordner-Format

usage() { ... }
migrate_skill() { ... }
main() { ... }
```

**WO:**
- Script-Datei: `specwright/scripts/migrate-skills-format.sh`
- Generische Skill-Templates: `specwright/templates/skills/generic-skill/SKILL.md` und `specwright/templates/skills/skill/SKILL.md`

**WER:** `devops-specialist` Agent (aus `.claude/agents/devops-specialist.md`) - fuer Shell-Script-Erstellung

**Abhaengigkeiten:** SKILL-001 bis SKILL-005 als Referenz (muessen nicht abgeschlossen sein, dienen aber als Beispiel fuer das Zielformat)

**Geschaetzte Komplexitaet:** S

**Completion Check:**
```bash
# Auto-Verify Commands - all must exit with 0
# Script existiert
test -f specwright/scripts/migrate-skills-format.sh && echo "OK" || exit 1
# Script ist ausfuehrbar oder hat shebang
grep -q "#!/bin/bash" specwright/scripts/migrate-skills-format.sh && echo "OK" || exit 1
# Script referenziert SKILL.md
grep -q "SKILL.md" specwright/scripts/migrate-skills-format.sh && echo "OK" || exit 1
# Script hat Fehlerbehandlung
grep -qE "(echo|exit)" specwright/scripts/migrate-skills-format.sh && echo "OK" || exit 1
# Generic skill templates migriert
test -f specwright/templates/skills/generic-skill/SKILL.md && echo "OK" || exit 1
test -f specwright/templates/skills/skill/SKILL.md && echo "OK" || exit 1
# Shellcheck (wenn installiert, sonst skip)
command -v shellcheck >/dev/null 2>&1 && shellcheck specwright/scripts/migrate-skills-format.sh && echo "OK" || echo "SKIP: shellcheck not installed"
```

**Story ist DONE wenn:**
1. migrate-skills-format.sh existiert und syntaktisch korrekt ist
2. Script enthaelt shebang, SKILL.md-Referenz und Fehlerbehandlung
3. generic-skill/SKILL.md und skill/SKILL.md existieren
4. Shellcheck meldet keine Fehler (falls installiert)

---

## Zusammenfassung

| Story ID | Titel | Prioritaet | Aufwand | Agent |
|----------|-------|------------|---------|-------|
| SKILL-001 | Root-Level Skill Templates | High | S (2 SP) | file-creator |
| SKILL-002 | Frontend Dev-Team Skills | High | S (2 SP) | file-creator |
| SKILL-003 | Backend Dev-Team Skills | High | S (2 SP) | file-creator |
| SKILL-004 | Architect, DevOps, QA, PO Skills | High | S (3 SP) | file-creator |
| SKILL-005 | Platform und Orchestration Skills | Medium | S (1 SP) | file-creator |
| SKILL-006 | Migrations-Script | High | S (2 SP) | devops-specialist |

---

## Abhaengigkeitsanalyse (vom Architect)

### Parallelisierbarkeit

**Parallel ausfuehrbar (Wave 1):**
- SKILL-001, SKILL-002, SKILL-003, SKILL-004, SKILL-005

Diese Stories migrieren unterschiedliche Skill-Kategorien und haben keine gegenseitigen Abhaengigkeiten. Sie koennen vollstaendig parallel von mehreren Agents ausgefuehrt werden.

**Sequenziell nach Wave 1 (Wave 2):**
- SKILL-006 (Migrations-Script)

Das Migrations-Script kann parallel entwickelt werden, nutzt aber idealerweise die migrierten Skills als Referenz fuer das Zielformat.

### Abhaengigkeitsgraph

```
SKILL-001 ──┐
SKILL-002 ──┤
SKILL-003 ──┼──> (alle parallel) ──> SKILL-006 (nutzt als Referenz)
SKILL-004 ──┤
SKILL-005 ──┘
```

### Empfohlene Ausfuehrungsreihenfolge

**Option A - Maximale Parallelisierung:**
1. Starte SKILL-001 bis SKILL-005 gleichzeitig (5 parallele Streams)
2. Nach Abschluss aller: SKILL-006

**Option B - Sequenzielle Ausfuehrung mit fruehen Referenzen:**
1. SKILL-001 (Root-Level als erstes Beispiel)
2. SKILL-006 (nutzt SKILL-001 als Referenz)
3. SKILL-002 bis SKILL-005 (parallel oder sequenziell)

**Empfehlung:** Option A fuer schnellste Fertigstellung, da alle Migration-Stories unabhaengig sind.

### Cross-Cutting Concerns

**Neue Patterns etabliert durch diese Migration:**
1. **Ordnerstruktur pro Skill**: `{skill-name}/SKILL.md`
2. **YAML Frontmatter Standard**: `name`, `description`, optional `globs`
3. **Namenskonvention**: Skill-Ordner ohne `-template` Suffix

**Auswirkungen auf andere Workflows:**
- `build-development-team` Workflow muss nach Migration das neue Format verwenden
- Skill-Referenzen in Agent-Templates muessen angepasst werden (separate Story falls notwendig)

### Agent-Zuweisung

| Agent | Stories | Grund |
|-------|---------|-------|
| `file-creator` | SKILL-001 bis SKILL-005 | Spezialisiert auf Datei-/Ordner-Erstellung und -Verschiebung |
| `devops-specialist` | SKILL-006 | Spezialisiert auf Shell-Script-Erstellung und Automatisierung |
