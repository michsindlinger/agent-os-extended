# add-domain Command erstellen

> Story ID: DT3-007
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: High
**Type**: Workflow
**Estimated Effort**: 3 SP
**Dependencies**: DT3-003, DT3-004

---

## Feature

```gherkin
Feature: Add Domain Command
  Als Entwickler
  möchte ich mit /add-domain fachliche Bereiche dokumentieren,
  damit der Agent die Geschäftslogik versteht und aktuell hält.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Domain Bereich hinzufügen

```gherkin
Scenario: Neuen Domain Bereich erstellen
  Given ich führe /add-domain "User Registration" aus
  When ich die Prozessbeschreibung eingebe
  Then wird .claude/skills/domain-[projekt]/user-registration.md erstellt
  And wird die Domain Areas Tabelle in Skill.md aktualisiert
```

### Szenario 2: Domain Skill wird erstellt wenn nicht vorhanden

```gherkin
Scenario: Domain Skill Auto-Erstellung
  Given kein Domain Skill existiert
  When ich /add-domain ausführe
  Then wird .claude/skills/domain-[projekt]/ erstellt
  And wird Skill.md aus Template erstellt
  And wird der neue Bereich hinzugefügt
```

### Szenario 3: Strukturierte Prozessbeschreibung

```gherkin
Scenario: Prozess-Template wird verwendet
  Given ich führe /add-domain aus
  When ich den Bereich beschreibe
  Then verwendet das erstellte Dokument das process.md Template
  And enthält "Process Flow" Section
  And enthält "Business Rules" Section
  And enthält "Related Code" Section
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: agent-os/workflows/core/add-domain.md
- [ ] FILE_EXISTS: .claude/commands/agent-os/add-domain.md

### Inhalt-Prüfungen

- [ ] CONTAINS: agent-os/workflows/core/add-domain.md enthält "domain-"
- [ ] CONTAINS: agent-os/workflows/core/add-domain.md enthält "process.md"
- [ ] CONTAINS: agent-os/workflows/core/add-domain.md enthält "Domain Areas"
- [ ] CONTAINS: .claude/commands/agent-os/add-domain.md enthält "@agent-os/workflows/core/add-domain.md"

---

## Technisches Refinement (vom Architect)

### DoR (Definition of Ready) - Vom Architect

#### Fachliche Anforderungen
- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Business Value verstanden

#### Technische Vorbereitung
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert (DT3-003, DT3-004)
- [x] Betroffene Komponenten bekannt
- [x] Story ist angemessen geschätzt

**Story ist READY.**

---

### DoD (Definition of Done) - Vom Architect

#### Implementierung
- [ ] Workflow erstellt
- [ ] Command erstellt
- [ ] Domain Skill Auto-Erstellung funktioniert
- [ ] Process Template wird korrekt verwendet
- [ ] Index wird aktualisiert

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt

---

### Technical Details

**WAS:**
- Neuer Workflow: add-domain.md
- Neuer Command: add-domain.md
- Ermöglicht Hinzufügen von fachlichen Bereichen zum Domain Skill

**WIE (Architektur-Guidance):**

**Workflow Steps:**
1. Check Domain Skill (erstellen wenn nicht vorhanden)
2. Gather Domain Info (Name und Beschreibung)
3. Create Domain Document (aus process.md Template)
4. Update Index (Domain Areas Tabelle in Skill.md)
5. Confirm

**Domain Skill Struktur:**
```
.claude/skills/domain-[projekt]/
├── Skill.md          # Index mit Domain Areas Tabelle
├── [bereich-1].md    # z.B. user-registration.md
└── [bereich-n].md
```

**WO:**
- agent-os/workflows/core/add-domain.md (neu)
- .claude/commands/agent-os/add-domain.md (neu)

**Geschätzte Komplexität:** M

---

### Completion Check

```bash
# Verify workflow exists
test -f agent-os/workflows/core/add-domain.md && echo "Workflow OK"

# Verify command exists
test -f .claude/commands/agent-os/add-domain.md && echo "Command OK"

# Verify workflow references domain structure
grep -q "domain-" agent-os/workflows/core/add-domain.md && echo "Domain reference OK"
grep -q "process.md" agent-os/workflows/core/add-domain.md && echo "Process template reference OK"
```
