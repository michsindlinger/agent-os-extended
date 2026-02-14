# Domain Skill Templates erstellen

> Story ID: DT3-003
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: High
**Type**: Framework
**Estimated Effort**: 3 SP
**Dependencies**: None

---

## Feature

```gherkin
Feature: Domain Skill Templates
  Als Main Agent
  möchte ich fachliche Domain-Dokumentation als Skill haben,
  damit ich Geschäftslogik verstehe und die Dokumentation aktuell halte.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Domain Index Template existiert

```gherkin
Scenario: Domain Skill Index Template ist vollständig
  Given das Specwright Framework ist installiert
  When ich das Domain Template prüfe
  Then existiert specwright/templates/skills/domain/Skill.md
  And enthält "Domain Areas" Tabelle
  And enthält "Self-Updating Rule" Section
```

### Szenario 2: Domain Process Template existiert

```gherkin
Scenario: Domain Process Template ist vollständig
  Given das Specwright Framework ist installiert
  When ich das Process Template prüfe
  Then existiert specwright/templates/skills/domain/process.md
  And enthält "Process Flow" Section
  And enthält "Business Rules" Section
  And enthält "Related Code" Section
```

### Szenario 3: Domain Skill ist selbst-aktualisierend

```gherkin
Scenario: Domain Skill Anweisung zur Selbst-Aktualisierung
  Given ein Domain Skill existiert
  When der Agent Geschäftslogik ändert
  Then enthält die Skill.md eine Anweisung die Dokumentation zu aktualisieren
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: specwright/templates/skills/domain/Skill.md
- [ ] FILE_EXISTS: specwright/templates/skills/domain/process.md

### Inhalt-Prüfungen

- [ ] CONTAINS: specwright/templates/skills/domain/Skill.md enthält "Domain Areas"
- [ ] CONTAINS: specwright/templates/skills/domain/Skill.md enthält "Self-Updating"
- [ ] CONTAINS: specwright/templates/skills/domain/process.md enthält "Process Flow"
- [ ] CONTAINS: specwright/templates/skills/domain/process.md enthält "Business Rules"
- [ ] CONTAINS: specwright/templates/skills/domain/process.md enthält "Related Code"

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
- [ ] Domain Skill.md Template erstellt
- [ ] Domain process.md Template erstellt
- [ ] Self-Updating Anweisungen klar formuliert

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt

---

### Technical Details

**WAS:**
- Erstelle Domain Skill Templates
- Skill.md als Index aller fachlichen Bereiche
- process.md als Template für einzelne Geschäftsprozesse

**WIE (Architektur-Guidance):**
- Domain Skill.md enthält Tabelle aller Bereiche
- Klare Anweisung: "Wenn du Geschäftslogik änderst, aktualisiere dieses Dokument"
- process.md enthält strukturierte Prozessbeschreibung
- "Related Code" Section verlinkt zu relevanten Code-Dateien

**WO:**
```
specwright/templates/skills/domain/
├── Skill.md       # Index Template
└── process.md     # Einzelprozess Template
```

**Inhalt Skill.md:**
```yaml
---
description: Domain knowledge and business processes for [PROJECT_NAME]
globs:
  - "src/**/*"
alwaysApply: false
---

# Domain Knowledge: [PROJECT_NAME]

## Self-Updating Rule

**WICHTIG:** Wenn du Code änderst der Geschäftslogik betrifft:
1. Prüfe ob die Änderung bestehende Prozesse betrifft
2. Aktualisiere das entsprechende Prozess-Dokument
3. Füge neue Prozesse hinzu wenn nötig

## Domain Areas

| Area | File | Description |
|------|------|-------------|
<!-- Auto-populated by /add-domain -->
```

**Geschätzte Komplexität:** M

---

### Completion Check

```bash
# Verify Domain templates exist
test -f specwright/templates/skills/domain/Skill.md && echo "Skill.md OK"
test -f specwright/templates/skills/domain/process.md && echo "process.md OK"

# Verify Self-Updating rule
grep -q "Self-Updating" specwright/templates/skills/domain/Skill.md && echo "Self-Updating OK"

# Verify process.md structure
grep -q "Process Flow" specwright/templates/skills/domain/process.md && echo "Process Flow OK"
grep -q "Business Rules" specwright/templates/skills/domain/process.md && echo "Business Rules OK"
```
