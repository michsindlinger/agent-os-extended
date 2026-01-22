# execute-tasks Direct Execution

> Story ID: DT3-005
> Spec: DevTeam v3.0 - Direct Execution Architecture
> Created: 2026-01-22
> Last Updated: 2026-01-22

**Priority**: Critical
**Type**: Workflow
**Estimated Effort**: 5 SP
**Dependencies**: DT3-004

---

## Feature

```gherkin
Feature: Execute Tasks Direct Execution
  Als Main Agent
  möchte ich Stories direkt ausführen ohne an Sub-Agents zu delegieren,
  damit ich den vollen Kontext behalte und bessere Integration liefere.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Keine Sub-Agent Delegation

```gherkin
Scenario: Main Agent implementiert selbst
  Given ich führe /execute-tasks aus
  And eine Story ist bereit zur Ausführung
  When Phase 3 (Execute Story) läuft
  Then wird KEIN Task tool mit dev-team__ Agent aufgerufen
  And implementiert der Main Agent die Story selbst
```

### Szenario 2: Skills werden automatisch geladen

```gherkin
Scenario: Skill Auto-Loading
  Given ich führe /execute-tasks aus
  And die Story betrifft Frontend-Dateien
  When ich src/app/components/*.ts Dateien bearbeite
  Then wird der frontend-angular Skill automatisch geladen
  And sehe ich die Quick Reference Patterns
```

### Szenario 3: Self-Learning bei Schwierigkeiten

```gherkin
Scenario: Agent lernt aus Fehlern
  Given ich führe /execute-tasks aus
  And die Implementierung braucht mehrere Anläufe
  When die Story erfolgreich abgeschlossen ist
  Then wird die Erkenntnis in dos-and-donts.md dokumentiert
```

### Szenario 4: Domain Updates bei Logik-Änderungen

```gherkin
Scenario: Domain Dokumentation wird aktualisiert
  Given ich führe /execute-tasks aus
  And die Story ändert Geschäftslogik
  When die Story abgeschlossen ist
  Then wird das entsprechende Domain-Dokument aktualisiert
```

### Szenario 5: Self-Review statt Agent-Reviews

```gherkin
Scenario: Self-Review mit DoD Checklist
  Given ich führe /execute-tasks aus
  When die Implementierung fertig ist
  Then führe ich einen Self-Review durch
  And prüfe ich alle DoD Checkboxen
  And gibt es KEINE separate Architect-Review Phase
```

---

## Technische Verifikation (Automated Checks)

### Datei-Prüfungen

- [ ] FILE_EXISTS: agent-os/workflows/core/execute-tasks.md (aktualisiert)

### Inhalt-Prüfungen

- [ ] NOT_CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "dev-team__backend-developer"
- [ ] NOT_CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "dev-team__frontend-developer"
- [ ] NOT_CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "DELEGATE via Task tool"
- [ ] NOT_CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "extract_skill_patterns"
- [ ] CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "self_review"
- [ ] CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "self_learning_check"
- [ ] CONTAINS: agent-os/workflows/core/execute-tasks.md enthält "dos-and-donts.md"

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
- [ ] Phase 3 komplett überarbeitet für Direct Execution
- [ ] Alle Sub-Agent Delegations entfernt
- [ ] Skill-Pattern-Extraction entfernt (Skills laden automatisch)
- [ ] Self-Review Step hinzugefügt
- [ ] Self-Learning Check Step hinzugefügt
- [ ] Domain Update Check hinzugefügt

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt
- [ ] Workflow ist logisch konsistent

---

### Technical Details

**WAS:**
- Überarbeite Phase 3 (Execute Story) für Direct Execution
- Entferne alle Sub-Agent Delegation
- Entferne Skill-Pattern-Extraction (nicht mehr nötig)
- Füge Self-Review, Self-Learning, Domain-Update Steps hinzu

**WIE (Architektur-Guidance):**

**Entfernen:**
- `<step name="extract_skill_patterns">`
- `<agent_selection>` Block
- `DELEGATE via Task tool` für Implementierung
- Separate Review-Steps (Architect, UX, QA)

**Hinzufügen:**
- `<step name="implement">` - Main Agent implementiert selbst
- `<step name="self_review">` - DoD Checklist durchgehen
- `<step name="self_learning_check">` - Learnings dokumentieren
- `<step name="domain_update_check">` - Domain Docs aktualisieren

**Phase 3 Neu:**
```
1. Load State (unverändert)
2. Story Selection (unverändert)
3. Update Kanban In-Progress (unverändert)
4. Implement (NEU - Main Agent selbst)
5. Self-Review (NEU - DoD Checklist)
6. Self-Learning Check (NEU - dos-and-donts.md)
7. Domain Update Check (NEU - Domain Docs)
8. Story Commit (git-workflow bleibt Sub-Agent)
```

**WO:**
- agent-os/workflows/core/execute-tasks.md (Phase 3 überschreiben)

**Geschätzte Komplexität:** L

---

### Completion Check

```bash
# Verify no sub-agent delegation
! grep -q "dev-team__backend-developer" agent-os/workflows/core/execute-tasks.md && echo "No backend agent OK"
! grep -q "dev-team__frontend-developer" agent-os/workflows/core/execute-tasks.md && echo "No frontend agent OK"

# Verify new steps exist
grep -q "self_review" agent-os/workflows/core/execute-tasks.md && echo "Self-review OK"
grep -q "self_learning_check" agent-os/workflows/core/execute-tasks.md && echo "Self-learning OK"
```
