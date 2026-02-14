# WTS-002: Phase-2 Git Strategy & Symlink

> Story ID: WTS-002
> Spec: 2026-01-31-worktree-workflow-support
> Created: 2026-01-31
> Last Updated: 2026-01-31

**Priority**: High
**Type**: Workflow
**Estimated Effort**: M
**Dependencies**: WTS-001
**Status**: Done

---

## Feature

```gherkin
Feature: Phase-2 verarbeitet Git Strategy mit Worktree-Symlink
  Als Entwickler
  möchte ich dass bei Worktree-Auswahl ein Symlink zur Spec erstellt wird,
  damit die Spec-Dateien nur eine Source of Truth haben aber im Worktree sichtbar sind.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: Git Strategy Parameter wird verarbeitet

```gherkin
Scenario: Phase-2 erhält Git Strategy von UI
  Given das Kanban Board sendet gitStrategy "worktree"
  When Phase-2 startet
  Then wird die Git Strategy aus dem Resume Context gelesen
  And die entsprechende Strategie wird angewendet
```

### Szenario 2: Worktree mit Symlink erstellen

```gherkin
Scenario: Worktree-Strategie erstellt Verzeichnis mit Symlink
  Given gitStrategy ist "worktree"
  And die Spec heißt "2026-01-31-my-feature"
  When Phase-2 das Git Setup durchführt
  Then wird ein Worktree erstellt in "specwright/worktrees/my-feature/"
  And ein Feature Branch "feature/my-feature" wird im Worktree erstellt
  And ein Symlink wird erstellt:
    "specwright/worktrees/my-feature/specwright/specs/2026-01-31-my-feature" → "../../../../specwright/specs/2026-01-31-my-feature"
  And der Resume Context wird aktualisiert mit:
    - Git Strategy: worktree
    - Worktree Path: specwright/worktrees/my-feature
```

### Szenario 3: Branch-Strategie ohne Symlink

```gherkin
Scenario: Branch-Strategie arbeitet im Hauptverzeichnis
  Given gitStrategy ist "branch"
  And die Spec heißt "2026-01-31-my-feature"
  When Phase-2 das Git Setup durchführt
  Then wird NUR ein Branch "feature/my-feature" erstellt
  And kein Worktree wird erstellt
  And kein Symlink wird erstellt
  And der Resume Context wird aktualisiert mit:
    - Git Strategy: branch
    - Worktree Path: (none)
```

### Szenario 4: User-Anweisung bei Worktree

```gherkin
Scenario: User erhält Anweisung für Worktree-Start
  Given ein Worktree wurde erstellt in "specwright/worktrees/my-feature"
  And der Agent erkennt seinen Startmodus
  When Phase-2 abgeschlossen ist
  Then wird dem User angezeigt:
    "Worktree erstellt! Für die Story-Execution:"
    - Bei Claude Max: "cd specwright/worktrees/my-feature && claude-anthropic-simple"
    - Bei API-Modus: "cd specwright/worktrees/my-feature && claude --dangerously-skip-permissions"
  And die nächste /execute-tasks muss im Worktree gestartet werden
```

### Szenario 5: Symlink-Struktur für Spec-Zugriff

```gherkin
Scenario: Symlink ermöglicht Spec-Zugriff im Worktree
  Given ein Worktree existiert mit Symlink zur Spec
  When der Agent im Worktree arbeitet
  Then kann er "specwright/specs/[spec-name]/" lesen
  And Änderungen an Story-Dateien landen im Original-Verzeichnis
  And beide Verzeichnisse (Root + Worktree) sehen dieselben Spec-Dateien
```

---

## Technisches Refinement (vom Architect)

### DoR (Definition of Ready)

- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert
- [x] Story ist angemessen geschätzt (max 5 Dateien, 400 LOC)

### DoD (Definition of Done)

- [x] Code implementiert und folgt Style Guide
- [x] Alle Akzeptanzkriterien erfüllt
- [x] Keine Syntax-Fehler im Markdown
- [x] Completion Check Commands erfolgreich

---

### Technical Details

**WAS:**
1. Phase-2 um Git Strategy Verarbeitung erweitern
2. Logik für Worktree-Erstellung mit Symlink hinzufügen
3. Logik für Branch-only Erstellung (ohne Worktree)
4. Resume Context Update mit Git Strategy
5. User-Anweisung bei Worktree-Strategie

**WIE (Architektur-Guidance):**

**Git Strategy Routing:**
```
IF gitStrategy == "worktree":
  1. Worktree erstellen: git worktree add specwright/worktrees/[name] -b feature/[name]
  2. Verzeichnisstruktur erstellen: mkdir -p specwright/worktrees/[name]/specwright/specs
  3. Symlink erstellen: ln -s ../../../../specwright/specs/[spec-name] specwright/worktrees/[name]/specwright/specs/[spec-name]
  4. Resume Context: Git Strategy = worktree, Worktree Path = specwright/worktrees/[name]
  5. Claude Startmodus erkennen (siehe WTS-001)
  6. User-Anweisung ausgeben mit passendem Befehl

ELSE IF gitStrategy == "branch":
  1. Branch erstellen: git checkout -b feature/[name]
  2. Resume Context: Git Strategy = branch, Worktree Path = (none)
  3. Normal fortfahren
```

**Claude Startmodus für User-Anweisung:**
- Erkennung wie in WTS-001 beschrieben
- Bei Claude Max: `cd {WORKTREE_PATH} && claude-anthropic-simple`
- Bei API-Modus: `cd {WORKTREE_PATH} && claude --dangerously-skip-permissions`

**Symlink-Pfad Berechnung:**
- Vom Worktree `specwright/worktrees/[name]/specwright/specs/[spec]`
- Zum Original `specwright/specs/[spec]`
- Relativer Pfad: `../../../../specwright/specs/[spec]`

**WO:**
- `specwright/workflows/core/execute-tasks/spec-phase-2.md` - Hauptänderungen
- `specwright/workflows/core/execute-tasks/shared/resume-context.md` - Schema Update

**Geschätzte Komplexität:** M

---

### Completion Check

```bash
# Phase-2 enthält Git Strategy Routing
grep -q "gitStrategy" specwright/workflows/core/execute-tasks/spec-phase-2.md && echo "PASS: gitStrategy handling" || echo "FAIL: gitStrategy missing"

# Phase-2 enthält Symlink-Erstellung
grep -q "ln -s" specwright/workflows/core/execute-tasks/spec-phase-2.md && echo "PASS: Symlink creation" || echo "FAIL: Symlink missing"

# Phase-2 enthält Branch-Alternative
grep -q "branch" specwright/workflows/core/execute-tasks/spec-phase-2.md && echo "PASS: Branch alternative" || echo "FAIL: Branch handling missing"

# Phase-2 enthält User-Anweisung
grep -qE "(cd.*worktree|claude)" specwright/workflows/core/execute-tasks/spec-phase-2.md && echo "PASS: User instruction" || echo "FAIL: User instruction missing"
```

**Story ist DONE wenn:**
1. Phase-2 unterscheidet zwischen branch und worktree Strategy
2. Bei worktree: Worktree + Branch + Symlink werden erstellt
3. Bei branch: Nur Branch wird erstellt
4. Resume Context enthält Git Strategy
5. User erhält klare Anweisung bei Worktree-Modus
