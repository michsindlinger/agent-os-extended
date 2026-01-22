# Setup Scripts Update

> Story ID: DT3-009
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: Medium
**Type**: DevOps
**Estimated Effort**: 2 SP
**Dependencies**: DT3-001, DT3-002, DT3-003

---

## Feature

```gherkin
Feature: Setup Scripts für v3.0
  Als Framework-Nutzer
  möchte ich dass die Setup Scripts die neuen Skill Templates installieren,
  damit ich das v3.0 DevTeam nutzen kann.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Neue Skill Templates werden installiert

```gherkin
Scenario: setup-devteam-global.sh installiert v3.0 Templates
  Given ich führe setup-devteam-global.sh aus
  When das Script abgeschlossen ist
  Then existiert ~/.agent-os/templates/skills/frontend/angular/Skill.md
  And existiert ~/.agent-os/templates/skills/backend/rails/Skill.md
  And existiert ~/.agent-os/templates/skills/quality-gates/Skill.md
  And existiert ~/.agent-os/templates/skills/domain/Skill.md
```

### Szenario 2: Alte Agent Templates werden entfernt

```gherkin
Scenario: Keine alten Agent Templates
  Given ich führe setup-devteam-global.sh aus
  When das Script abgeschlossen ist
  Then existiert NICHT ~/.agent-os/templates/agents/dev-team/
```

### Szenario 3: Neue Commands werden installiert

```gherkin
Scenario: Neue Commands verfügbar
  Given ich führe setup-claude-code.sh aus
  When das Script abgeschlossen ist
  Then existiert .claude/commands/agent-os/add-learning.md
  And existiert .claude/commands/agent-os/add-domain.md
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: setup-devteam-global.sh (aktualisiert)

### Inhalt-Prüfungen

- [ ] CONTAINS: setup-devteam-global.sh enthält "skills/frontend/angular"
- [ ] CONTAINS: setup-devteam-global.sh enthält "skills/backend/rails"
- [ ] CONTAINS: setup-devteam-global.sh enthält "skills/quality-gates"
- [ ] CONTAINS: setup-devteam-global.sh enthält "skills/domain"
- [ ] CONTAINS: setup-claude-code.sh enthält "add-learning.md"
- [ ] CONTAINS: setup-claude-code.sh enthält "add-domain.md"

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
- [ ] setup-devteam-global.sh aktualisiert
- [ ] setup-claude-code.sh aktualisiert
- [ ] Alte Agent Template Pfade entfernt
- [ ] Neue Skill Template Pfade hinzugefügt
- [ ] Neue Command Pfade hinzugefügt

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt
- [ ] Scripts sind ausführbar

---

### Technical Details

**WAS:**
- Aktualisiere setup-devteam-global.sh für neue Skill Template Struktur
- Aktualisiere setup-claude-code.sh für neue Commands
- Entferne alte Agent Template Referenzen

**WIE (Architektur-Guidance):**

**setup-devteam-global.sh Änderungen:**
```bash
# NEU: Skill Templates
SKILL_TEMPLATES=(
  "skills/quality-gates/Skill.md"
  "skills/frontend/angular/Skill.md"
  "skills/frontend/angular/components.md"
  "skills/frontend/angular/state-management.md"
  "skills/frontend/angular/api-integration.md"
  "skills/frontend/angular/forms-validation.md"
  "skills/frontend/angular/dos-and-donts.md"
  "skills/frontend/react/Skill.md"
  # ... weitere
  "skills/backend/rails/Skill.md"
  "skills/backend/rails/services.md"
  # ... weitere
  "skills/domain/Skill.md"
  "skills/domain/process.md"
)

# ENTFERNEN: Alte Agent Templates
# rm -rf ~/.agent-os/templates/agents/dev-team/
```

**setup-claude-code.sh Änderungen:**
```bash
# NEU: Commands
COMMANDS=(
  # ... bestehende
  "add-learning.md"
  "add-domain.md"
)
```

**WO:**
- setup-devteam-global.sh (aktualisieren)
- setup-claude-code.sh (aktualisieren)

**Geschätzte Komplexität:** S

---

### Completion Check

```bash
# Verify skill templates in setup script
grep -q "skills/frontend/angular" setup-devteam-global.sh && echo "Angular path OK"
grep -q "skills/quality-gates" setup-devteam-global.sh && echo "Quality gates path OK"
grep -q "skills/domain" setup-devteam-global.sh && echo "Domain path OK"

# Verify new commands in setup script
grep -q "add-learning.md" setup-claude-code.sh && echo "add-learning OK"
grep -q "add-domain.md" setup-claude-code.sh && echo "add-domain OK"
```
