# Technologie Skill Templates erstellen

> Story ID: DT3-001
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: Critical
**Type**: Framework
**Estimated Effort**: 5 SP
**Dependencies**: None

---

## Feature

```gherkin
Feature: Technologie Skill Templates
  Als Framework-Entwickler
  möchte ich Skill Templates für verschiedene Technologien haben,
  damit bei /build-development-team projektspezifische Skills generiert werden können.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Frontend Angular Template existiert

```gherkin
Scenario: Angular Skill Template ist vollständig
  Given das Specwright Framework ist installiert
  When ich die Angular Templates prüfe
  Then existiert specwright/templates/skills/frontend/angular/Skill.md
  And existiert specwright/templates/skills/frontend/angular/components.md
  And existiert specwright/templates/skills/frontend/angular/state-management.md
  And existiert specwright/templates/skills/frontend/angular/api-integration.md
  And existiert specwright/templates/skills/frontend/angular/forms-validation.md
  And existiert specwright/templates/skills/frontend/angular/dos-and-donts.md
```

### Szenario 2: Backend Rails Template existiert

```gherkin
Scenario: Rails Skill Template ist vollständig
  Given das Specwright Framework ist installiert
  When ich die Rails Templates prüfe
  Then existiert specwright/templates/skills/backend/rails/Skill.md
  And existiert specwright/templates/skills/backend/rails/services.md
  And existiert specwright/templates/skills/backend/rails/models.md
  And existiert specwright/templates/skills/backend/rails/api-design.md
  And existiert specwright/templates/skills/backend/rails/testing.md
  And existiert specwright/templates/skills/backend/rails/dos-and-donts.md
```

### Szenario 3: Skill.md hat korrektes Format

```gherkin
Scenario: Skill.md enthält YAML Frontmatter
  Given ein Skill Template existiert
  When ich die Skill.md Datei prüfe
  Then beginnt sie mit "---"
  And enthält "description:"
  And enthält "globs:"
  And enthält "alwaysApply:"
  And hat eine "## Quick Reference" Section
  And hat eine "## Available Modules" Tabelle
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: specwright/templates/skills/frontend/angular/Skill.md
- [ ] FILE_EXISTS: specwright/templates/skills/frontend/angular/components.md
- [ ] FILE_EXISTS: specwright/templates/skills/frontend/angular/state-management.md
- [ ] FILE_EXISTS: specwright/templates/skills/frontend/angular/api-integration.md
- [ ] FILE_EXISTS: specwright/templates/skills/frontend/angular/forms-validation.md
- [ ] FILE_EXISTS: specwright/templates/skills/frontend/angular/dos-and-donts.md
- [ ] FILE_EXISTS: specwright/templates/skills/frontend/react/Skill.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/rails/Skill.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/rails/services.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/rails/models.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/rails/api-design.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/rails/testing.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/rails/dos-and-donts.md
- [ ] FILE_EXISTS: specwright/templates/skills/backend/nestjs/Skill.md

### Inhalt-Prüfungen

- [ ] CONTAINS: specwright/templates/skills/frontend/angular/Skill.md enthält "globs:"
- [ ] CONTAINS: specwright/templates/skills/frontend/angular/Skill.md enthält "## Quick Reference"
- [ ] CONTAINS: specwright/templates/skills/frontend/angular/Skill.md enthält "## Available Modules"
- [ ] CONTAINS: specwright/templates/skills/backend/rails/Skill.md enthält "globs:"

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
- [ ] Alle Template-Dateien erstellt
- [ ] YAML Frontmatter korrekt formatiert
- [ ] Platzhalter konsistent benannt

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt
- [ ] Templates haben sinnvolle Inhalte (nicht nur Platzhalter)

#### Dokumentation
- [ ] Template Usage Instructions in Skill.md

---

### Technical Details

**WAS:**
- Erstelle Skill Template Ordnerstruktur in specwright/templates/skills/
- Frontend Templates: angular/, react/, vue/
- Backend Templates: rails/, nestjs/, spring/
- Jedes Template enthält: Skill.md (Index), Sub-Dokumente, dos-and-donts.md

**WIE (Architektur-Guidance):**
- Skill.md MUSS YAML Frontmatter haben mit description, globs, alwaysApply
- Skill.md enthält Quick Reference (50-100 Zeilen) und Available Modules Tabelle
- Sub-Dokumente enthalten detaillierte Patterns
- dos-and-donts.md startet mit leerer Struktur (Dos/Don'ts/Gotchas Sections)
- Platzhalter Format: [PLACEHOLDER_NAME]

**WO:**
```
specwright/templates/skills/
├── frontend/
│   ├── angular/
│   │   ├── Skill.md
│   │   ├── components.md
│   │   ├── state-management.md
│   │   ├── api-integration.md
│   │   ├── forms-validation.md
│   │   └── dos-and-donts.md
│   ├── react/
│   │   └── ... (gleiche Struktur)
│   └── vue/
│       └── ... (gleiche Struktur)
├── backend/
│   ├── rails/
│   │   ├── Skill.md
│   │   ├── services.md
│   │   ├── models.md
│   │   ├── api-design.md
│   │   ├── testing.md
│   │   └── dos-and-donts.md
│   ├── nestjs/
│   │   └── ... (gleiche Struktur)
│   └── spring/
│       └── ... (gleiche Struktur)
└── devops/
    └── docker-github/
        └── ...
```

**Geschätzte Komplexität:** L (viele Dateien, aber repetitiv)

---

### Completion Check

```bash
# Verify Angular templates exist
test -f specwright/templates/skills/frontend/angular/Skill.md && echo "Angular Skill.md OK"
test -f specwright/templates/skills/frontend/angular/components.md && echo "Angular components OK"
test -f specwright/templates/skills/frontend/angular/dos-and-donts.md && echo "Angular dos-and-donts OK"

# Verify Rails templates exist
test -f specwright/templates/skills/backend/rails/Skill.md && echo "Rails Skill.md OK"
test -f specwright/templates/skills/backend/rails/services.md && echo "Rails services OK"

# Verify YAML frontmatter
head -1 specwright/templates/skills/frontend/angular/Skill.md | grep -q "^---" && echo "YAML OK"
```

**Story ist DONE wenn:**
1. Alle Template-Dateien existieren
2. Skill.md hat korrektes YAML Frontmatter
3. Available Modules Tabelle verweist auf Sub-Dokumente
