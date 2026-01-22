# add-learning Command erstellen

> Story ID: DT3-006
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: High
**Type**: Workflow
**Estimated Effort**: 3 SP
**Dependencies**: DT3-004

---

## Feature

```gherkin
Feature: Add Learning Command
  Als Entwickler
  möchte ich mit /add-learning Erkenntnisse manuell dokumentieren,
  damit das Team von meinen Erfahrungen lernen kann.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Learning interaktiv hinzufügen

```gherkin
Scenario: Interaktiver Modus
  Given ich führe /add-learning aus
  When ich nach der Erkenntnis gefragt werde
  And ich "OnPush Change Detection immer verwenden" eingebe
  And ich "Frontend Technical" als Kategorie wähle
  Then wird der Eintrag zu .claude/skills/frontend-angular/dos-and-donts.md hinzugefügt
```

### Szenario 2: Learning als Parameter

```gherkin
Scenario: Quick Add Modus
  Given ich führe /add-learning "Immer try-catch bei API calls" aus
  When ich die Kategorie auswähle
  Then wird der Eintrag zum entsprechenden Skill hinzugefügt
  And ist der Eintrag mit Datum versehen
```

### Szenario 3: Learning zu Domain hinzufügen

```gherkin
Scenario: Domain Learning
  Given ich führe /add-learning aus
  When ich "Domain/Business Logic" als Kategorie wähle
  And ich einen Domain-Bereich auswähle
  Then wird der Eintrag zum Domain-Dokument hinzugefügt
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: agent-os/workflows/core/add-learning.md
- [ ] FILE_EXISTS: .claude/commands/agent-os/add-learning.md

### Inhalt-Prüfungen

- [ ] CONTAINS: agent-os/workflows/core/add-learning.md enthält "dos-and-donts.md"
- [ ] CONTAINS: agent-os/workflows/core/add-learning.md enthält "AskUserQuestion"
- [ ] CONTAINS: .claude/commands/agent-os/add-learning.md enthält "@agent-os/workflows/core/add-learning.md"

---

## Technisches Refinement (vom Architect)

### DoR (Definition of Ready) - Vom Architect

#### Fachliche Anforderungen
- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Business Value verstanden

#### Technische Vorbereitung
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert (DT3-004)
- [x] Betroffene Komponenten bekannt
- [x] Story ist angemessen geschätzt

**Story ist READY.**

---

### DoD (Definition of Done) - Vom Architect

#### Implementierung
- [ ] Workflow erstellt
- [ ] Command erstellt
- [ ] Interaktiver und Quick-Add Modus funktioniert
- [ ] Korrekte Kategorisierung (Technical vs Domain)

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt

---

### Technical Details

**WAS:**
- Neuer Workflow: add-learning.md
- Neuer Command: add-learning.md
- Ermöglicht manuelles Hinzufügen von Learnings zu Skills

**WIE (Architektur-Guidance):**

**Workflow Steps:**
1. Gather Learning (Parameter oder AskUserQuestion)
2. Categorize (Frontend/Backend/DevOps/Domain)
3. Select Target (welcher Skill/Domain-Bereich)
4. Format Entry (mit Datum, Context, Issue, Solution)
5. Append to File (dos-and-donts.md oder domain doc)
6. Confirm

**Entry Format:**
```markdown
### [DATE] - [Short Title]
**Context:** [Was du versucht hast]
**Issue:** [Was nicht funktioniert hat]
**Solution:** [Was funktioniert hat]
```

**WO:**
- agent-os/workflows/core/add-learning.md (neu)
- .claude/commands/agent-os/add-learning.md (neu)

**Geschätzte Komplexität:** M

---

### Completion Check

```bash
# Verify workflow exists
test -f agent-os/workflows/core/add-learning.md && echo "Workflow OK"

# Verify command exists
test -f .claude/commands/agent-os/add-learning.md && echo "Command OK"

# Verify workflow references dos-and-donts
grep -q "dos-and-donts.md" agent-os/workflows/core/add-learning.md && echo "dos-and-donts reference OK"
```
