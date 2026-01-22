# build-development-team Workflow v3.0

> Story ID: DT3-004
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: Critical
**Type**: Workflow
**Estimated Effort**: 5 SP
**Dependencies**: DT3-001, DT3-002, DT3-003

---

## Feature

```gherkin
Feature: Build Development Team v3.0
  Als Entwickler
  möchte ich mit /build-development-team Skills für den Main Agent erstellen,
  damit der Main Agent Stories direkt ausführen kann.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Skills werden in .claude/skills/ erstellt

```gherkin
Scenario: Korrekte Skill-Pfade
  Given ich führe /build-development-team aus
  And mein Tech-Stack enthält Angular
  When der Workflow abgeschlossen ist
  Then existiert .claude/skills/frontend-angular/Skill.md
  And existiert .claude/skills/quality-gates/Skill.md
  And existiert NICHT .claude/agents/dev-team/
```

### Szenario 2: Keine Sub-Agents mehr

```gherkin
Scenario: Keine Agent-Dateien erstellt
  Given ich führe /build-development-team aus
  When der Workflow abgeschlossen ist
  Then existiert KEIN Ordner .claude/agents/dev-team/
  And gibt es keine Referenzen zu Sub-Agents in den Skills
```

### Szenario 3: Domain Skill wird optional erstellt

```gherkin
Scenario: Domain Skill auf Nachfrage
  Given ich führe /build-development-team aus
  When ich gefragt werde ob Domain Skill erstellt werden soll
  And ich "Ja" auswähle
  Then existiert .claude/skills/domain-[projekt]/Skill.md
```

### Szenario 4: Skills haben YAML Frontmatter

```gherkin
Scenario: Generierte Skills sind Standard-konform
  Given /build-development-team wurde ausgeführt
  When ich die generierten Skills prüfe
  Then hat jede Skill.md ein YAML Frontmatter
  And enthält jedes Frontmatter "description:"
  And enthält jedes Frontmatter "globs:"
  And enthält jedes Frontmatter "alwaysApply:"
```

### Szenario 5: Skills enthalten projektspezifische Informationen

```gherkin
Scenario: Kontext wird aus Projekt-Dokumenten extrahiert
  Given agent-os/product/tech-stack.md existiert mit Angular 18
  And agent-os/product/architecture-decision.md existiert
  When /build-development-team ausgeführt wird
  Then enthält .claude/skills/frontend-angular/Skill.md "Angular 18"
  And enthält der Skill die Architecture Patterns aus architecture-decision.md
```

### Szenario 6: Frontend Skills enthalten Design System

```gherkin
Scenario: Design System wird in Frontend Skills integriert
  Given agent-os/product/design-system.md existiert
  And agent-os/product/ux-patterns.md existiert
  When /build-development-team einen Frontend Skill erstellt
  Then enthält der Skill eine "Design System" Section
  And enthält der Skill eine "UX Patterns" Section
  And sind die Werte aus den Quelldateien extrahiert
```

### Szenario 7: Fehlende Dateien werden behandelt

```gherkin
Scenario: Graceful handling bei fehlenden Dokumenten
  Given agent-os/product/design-system.md existiert NICHT
  When /build-development-team einen Frontend Skill erstellt
  Then enthält der Skill einen Hinweis "Not defined - see agent-os/product/design-system.md"
  And wird eine Warnung ausgegeben
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: agent-os/workflows/core/build-development-team.md (aktualisiert)
- [ ] FILE_EXISTS: .claude/commands/agent-os/build-development-team.md (aktualisiert)

### Inhalt-Prüfungen

- [ ] CONTAINS: agent-os/workflows/core/build-development-team.md enthält "version: 3.0"
- [ ] CONTAINS: agent-os/workflows/core/build-development-team.md enthält ".claude/skills/"
- [ ] CONTAINS: agent-os/workflows/core/build-development-team.md enthält "tech-stack.md"
- [ ] CONTAINS: agent-os/workflows/core/build-development-team.md enthält "architecture-decision.md"
- [ ] CONTAINS: agent-os/workflows/core/build-development-team.md enthält "design-system.md"
- [ ] CONTAINS: agent-os/workflows/core/build-development-team.md enthält "ux-patterns.md"
- [ ] NOT_CONTAINS: agent-os/workflows/core/build-development-team.md enthält ".claude/agents/dev-team/"
- [ ] NOT_CONTAINS: agent-os/workflows/core/build-development-team.md enthält "skill-index.md"

---

## Technisches Refinement (vom Architect)

### DoR (Definition of Ready) - Vom Architect

#### Fachliche Anforderungen
- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Business Value verstanden

#### Technische Vorbereitung
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert (DT3-001, DT3-002, DT3-003)
- [x] Betroffene Komponenten bekannt
- [x] Story ist angemessen geschätzt

**Story ist READY.**

---

### DoD (Definition of Done) - Vom Architect

#### Implementierung
- [ ] Workflow komplett neu geschrieben für v3.0
- [ ] Erstellt Skills in .claude/skills/ (nicht agent-os/skills/)
- [ ] Erstellt KEINE Agents mehr
- [ ] Erstellt KEINE skill-index.md mehr
- [ ] Quality Gates Skill wird immer erstellt
- [ ] Domain Skill wird optional erstellt

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt

#### Dokumentation
- [ ] Workflow Summary am Ende zeigt neue Struktur

---

### Technical Details

**WAS:**
- Komplette Neuschreibung des build-development-team.md Workflows
- Entferne alle Agent-Erstellung
- Entferne skill-index.md Erstellung
- Füge Skill-Erstellung in .claude/skills/ hinzu
- Füge Kontext-Extraktion aus Projekt-Dokumenten hinzu

**WIE (Architektur-Guidance):**
- Tech-Stack Detection bleibt gleich
- Quality Gates wird IMMER erstellt
- Tech-Skills werden basierend auf Detection erstellt
- Domain Skill wird per AskUserQuestion angeboten
- Alle Skills nutzen Templates aus agent-os/templates/skills/

**Kontext-Extraktion (NEU):**
Der Workflow MUSS folgende Dateien lesen und Informationen extrahieren:

1. **agent-os/product/tech-stack.md** → Für ALLE Skills
   - Framework-Versionen
   - Libraries und Dependencies
   - Testing Frameworks
   - Build Tools

2. **agent-os/product/architecture-decision.md** → Für ALLE Tech-Skills
   - Service Layer Patterns
   - API Design Patterns
   - Data Access Patterns
   - Error Handling Patterns

3. **agent-os/product/architecture-structure.md** → Für ALLE Tech-Skills
   - Ordnerstruktur
   - Naming Conventions
   - File Organization

4. **agent-os/product/design-system.md** → NUR für Frontend-Skills
   - Colors
   - Typography
   - Spacing
   - Component Patterns

5. **agent-os/product/ux-patterns.md** → NUR für Frontend-Skills
   - Navigation Patterns
   - User Flows
   - Feedback States (Loading, Error, Empty, Success)
   - Accessibility Requirements

**Platzhalter-Ersetzung:**
Die extrahierten Informationen werden in die Skill Templates eingesetzt:
- [ANGULAR_VERSION], [REACT_VERSION], etc. → aus tech-stack.md
- [ARCHITECTURE_PATTERNS] → aus architecture-decision.md
- [PROJECT_STRUCTURE] → aus architecture-structure.md
- [DESIGN_COLORS], [DESIGN_TYPOGRAPHY], etc. → aus design-system.md
- [UX_NAVIGATION], [UX_FEEDBACK_STATES], etc. → aus ux-patterns.md

**Fallback wenn Datei nicht existiert:**
- Platzhalter mit "Not defined - see agent-os/product/[filename].md" ersetzen
- Warnung ausgeben dass Datei fehlt

**WO:**
- agent-os/workflows/core/build-development-team.md (überschreiben)
- .claude/commands/agent-os/build-development-team.md (aktualisieren)

**Workflow Steps (v3.0):**
1. Analyze Tech Stack
2. Create Quality Gates Skill (always)
3. Create Tech Skills (based on detection)
4. Ask about Domain Skill
5. Create Domain Skill (if yes)
6. Create DoD/DoR (unchanged)
7. Summary

**Geschätzte Komplexität:** L

---

### Completion Check

```bash
# Verify workflow version
grep -q "version: 3.0" agent-os/workflows/core/build-development-team.md && echo "Version OK"

# Verify no agent references
! grep -q ".claude/agents/dev-team" agent-os/workflows/core/build-development-team.md && echo "No agents OK"

# Verify skill path
grep -q ".claude/skills/" agent-os/workflows/core/build-development-team.md && echo "Skill path OK"
```
