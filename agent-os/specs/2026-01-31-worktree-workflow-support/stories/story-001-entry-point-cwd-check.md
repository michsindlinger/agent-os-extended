# WTS-001: Entry-Point CWD Check

> Story ID: WTS-001
> Spec: 2026-01-31-worktree-workflow-support
> Created: 2026-01-31
> Last Updated: 2026-01-31

**Priority**: High
**Type**: Workflow
**Estimated Effort**: S
**Dependencies**: None
**Status**: Done

---

## Feature

```gherkin
Feature: Entry-Point prüft Working Directory bei Worktree-Strategie
  Als Agent
  möchte ich beim Start von /execute-tasks gewarnt werden wenn ich nicht im richtigen Verzeichnis bin,
  damit ich im korrekten Worktree arbeite.
```

---

## Akzeptanzkriterien (Gherkin-Szenarien)

### Szenario 1: CWD Check bei Worktree-Strategie

```gherkin
Scenario: Agent arbeitet nicht im Worktree-Verzeichnis
  Given eine Spec hat Git Strategy "worktree" im Resume Context
  And Worktree Path ist "agent-os/worktrees/my-feature"
  And das aktuelle Working Directory ist das Hauptprojektverzeichnis
  When /execute-tasks aufgerufen wird
  Then wird eine Warnung angezeigt: "Du arbeitest nicht im Worktree-Verzeichnis!"
  And der Agent erkennt seinen Startmodus (Claude Max vs. API)
  And es wird der passende Befehl angezeigt:
    - Bei Claude Max: "cd agent-os/worktrees/my-feature && claude-anthropic-simple"
    - Bei API-Modus: "cd agent-os/worktrees/my-feature && claude --dangerously-skip-permissions"
  And die Execution wird GESTOPPT
```

### Szenario 2: CWD Check bei Branch-Strategie

```gherkin
Scenario: Branch-Strategie erlaubt Hauptverzeichnis
  Given eine Spec hat Git Strategy "branch" im Resume Context
  And das aktuelle Working Directory ist das Hauptprojektverzeichnis
  When /execute-tasks aufgerufen wird
  Then wird KEINE Warnung angezeigt
  And die Execution wird normal fortgesetzt
```

### Szenario 3: Korrektes Worktree-Verzeichnis

```gherkin
Scenario: Agent arbeitet im korrekten Worktree
  Given eine Spec hat Git Strategy "worktree" im Resume Context
  And Worktree Path ist "agent-os/worktrees/my-feature"
  And das aktuelle Working Directory ist "agent-os/worktrees/my-feature"
  When /execute-tasks aufgerufen wird
  Then wird KEINE Warnung angezeigt
  And die Execution wird normal fortgesetzt
```

### Szenario 4: Keine Git Strategy gesetzt (Legacy)

```gherkin
Scenario: Alte Specs ohne Git Strategy
  Given eine Spec hat KEINE Git Strategy im Resume Context
  When /execute-tasks aufgerufen wird
  Then wird die Execution normal fortgesetzt (Rückwärtskompatibilität)
```

### Szenario 5: Claude Startmodus erkennen

```gherkin
Scenario: Agent erkennt seinen Startmodus
  Given der Agent läuft
  When er seinen Startmodus prüft
  Then erkennt er anhand der Auth-Methode:
    - "Login method: Claude Max" → Standard-Modus (claude)
    - "Auth token: ANTHROPIC_AUTH_TOKEN" → API-Modus (claude --dangerously-skip-permissions)
  And verwendet den entsprechenden Befehl in der Worktree-Anweisung
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
1. Entry-Point um CWD-Check erweitern
2. Git Strategy und Worktree Path aus Resume Context lesen
3. Bei Worktree-Strategy: Prüfen ob CWD == Worktree Path
4. Claude Startmodus erkennen (Max vs. API)
5. Bei Mismatch: Warnung + passender Befehl + STOP
6. Bei Match oder Branch-Strategy: Normal fortfahren

**WIE (Architektur-Guidance):**
- Nach `EXTRACT: "Current Phase" from Resume Context` zusätzlich extrahieren:
  - `Git Strategy` (branch | worktree | nicht gesetzt)
  - `Worktree Path` (Pfad oder leer)
- CWD ermitteln via `pwd` oder aus Kontext
- Pfad-Vergleich: Worktree Path könnte relativ oder absolut sein

**Claude Startmodus Erkennung:**
Der Agent kann seinen Startmodus über interne Informationen erkennen:
- **Claude Max Account:** Hat "Login method: Claude Max Account" im Status
- **API-Modus (GLM etc.):** Hat "Auth token: ANTHROPIC_AUTH_TOKEN" oder custom "base URL"

Basierend darauf den richtigen Befehl generieren:
```
IF Claude Max Account:
  COMMAND = "claude-anthropic-simple"
ELSE (API-Modus):
  COMMAND = "claude --dangerously-skip-permissions"

OUTPUT: "cd {WORKTREE_PATH} && {COMMAND}"
```

- Bei Warnung: User-freundliche Anleitung mit Copy-Paste Befehl

**WO:**
- `agent-os/workflows/core/execute-tasks/entry-point.md` - CWD Check hinzufügen
- `agent-os/workflows/core/execute-tasks/shared/resume-context.md` - Git Strategy Feld dokumentieren

**Geschätzte Komplexität:** S

---

### Completion Check

```bash
# Entry-Point enthält CWD Check
grep -q "Git Strategy" agent-os/workflows/core/execute-tasks/entry-point.md && echo "PASS: Git Strategy check" || echo "FAIL: Git Strategy missing"

# Entry-Point enthält Worktree Warning
grep -q "worktree" agent-os/workflows/core/execute-tasks/entry-point.md && echo "PASS: Worktree handling" || echo "FAIL: Worktree handling missing"

# Resume Context dokumentiert Git Strategy
grep -q "Git Strategy" agent-os/workflows/core/execute-tasks/shared/resume-context.md && echo "PASS: Resume Context updated" || echo "FAIL: Resume Context missing Git Strategy"
```

**Story ist DONE wenn:**
1. Entry-Point prüft Git Strategy aus Resume Context
2. Bei Worktree-Strategy wird CWD geprüft
3. Bei Mismatch wird Warnung + Anleitung angezeigt
4. Resume Context Schema ist dokumentiert
