# create-spec Story Template Update

> Story ID: DT3-008
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: Medium
**Type**: Workflow
**Estimated Effort**: 2 SP
**Dependencies**: None

---

## Feature

```gherkin
Feature: Story Template ohne Agent-Feld
  Als PO/Architect
  möchte ich Stories ohne "WER" (Agent) Feld erstellen,
  damit das neue Direct Execution Modell unterstützt wird.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Kein WER Feld im Template

```gherkin
Scenario: Story Template ohne Agent-Zuweisung
  Given das Story Template existiert
  When ich das Template prüfe
  Then enthält es KEIN "WER:" Feld
  And enthält es KEINE "Relevante Skills" Section
```

### Szenario 2: Domain Referenz hinzugefügt

```gherkin
Scenario: Domain Feld im Template
  Given das Story Template existiert
  When ich das Template prüfe
  Then enthält es ein optionales "Domain:" Feld
  And verweist auf den entsprechenden Domain-Bereich
```

### Szenario 3: Vereinfachte Technical Details

```gherkin
Scenario: Technical Details ohne WER
  Given das Story Template existiert
  When ich die Technical Details Section prüfe
  Then enthält sie WAS, WIE, WO
  And enthält sie NICHT WER
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: specwright/templates/docs/story-template.md (aktualisiert)

### Inhalt-Prüfungen

- [ ] NOT_CONTAINS: specwright/templates/docs/story-template.md enthält "**WER:**"
- [ ] NOT_CONTAINS: specwright/templates/docs/story-template.md enthält "Relevante Skills"
- [ ] NOT_CONTAINS: specwright/templates/docs/story-template.md enthält "skill-index.md"
- [ ] CONTAINS: specwright/templates/docs/story-template.md enthält "**Domain:**"

---

## Technisches Refinement (vom Architect)

### DoR (Definition of Ready) - Vom Architect

#### Fachliche Anforderungen
- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Business Value verstanden

#### Technische Vorbereitung
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert (None)
- [x] Betroffene Komponenten bekannt
- [x] Story ist angemessen geschätzt

**Story ist READY.**

---

### DoD (Definition of Done) - Vom Architect

#### Implementierung
- [ ] WER Feld entfernt
- [ ] Relevante Skills Section entfernt
- [ ] Domain Feld hinzugefügt (optional)
- [ ] Template Usage Instructions aktualisiert

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt

---

### Technical Details

**WAS:**
- Aktualisiere story-template.md für v3.0
- Entferne Agent-bezogene Felder
- Füge Domain-Referenz hinzu

**WIE (Architektur-Guidance):**

**Entfernen:**
- `**WER:** [Agent]` Feld
- `### Relevante Skills` Section
- Referenzen zu skill-index.md

**Hinzufügen:**
- `**Domain:** [DOMAIN_AREA] (optional)` Feld

**Technical Details Section (neu):**
```markdown
### Technical Details

**WAS:** [Komponenten/Features]

**WIE (Architektur-Guidance):**
- Pattern-Vorgaben
- Constraints
- Security/Performance

**WO:** [Dateipfade]

**Domain:** [Optional - Bereich aus domain-*/]

**Abhängigkeiten:** [Story IDs oder "None"]

**Geschätzte Komplexität:** [XS/S/M/L/XL]
```

**WO:**
- specwright/templates/docs/story-template.md (aktualisieren)

**Geschätzte Komplexität:** S

---

### Completion Check

```bash
# Verify no WER field
! grep -q '^\*\*WER:\*\*' specwright/templates/docs/story-template.md && echo "No WER OK"

# Verify no Relevante Skills
! grep -q "Relevante Skills" specwright/templates/docs/story-template.md && echo "No Skills section OK"

# Verify Domain field exists
grep -q '^\*\*Domain:\*\*' specwright/templates/docs/story-template.md && echo "Domain field OK"
```
