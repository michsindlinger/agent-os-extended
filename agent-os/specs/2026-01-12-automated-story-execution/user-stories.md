# User Stories: Automated Story Execution

> Spec: Automated Story Execution (Ralph-Style)
> Created: 2026-01-12
> Last Updated: 2026-01-12

## Story Overview

**Total Stories**: 7
**Estimated Effort**: 13 Story Points (XS-S each)

| Story | Titel | Größe | Dependencies |
|-------|-------|-------|--------------|
| 1 | Story-Sizing-Guidelines erstellen | XS | None |
| 2 | user-stories-template.md anpassen (inkl. MCP-Format) | S | Story 1 |
| 3 | create-spec.md PO-Phase anpassen | S | Story 1, 2 |
| 4 | create-spec.md Architect-Phase anpassen | S | Story 3 |
| 5 | MCP-Tool-Check in execute-tasks einbauen | S | Story 4 |
| 6 | MCP-Setup-Guide erstellen | XS | None (parallel zu 1) |
| 7 | setup.sh um neue Docs erweitern | XS | Story 1, 6 |

---

## Story 1: Story-Sizing-Guidelines erstellen

**ID**: ASE-001
**Priority**: High
**Estimated Effort**: XS (1 SP)
**Dependencies**: None

### User Story

Als Benutzer von Agent OS
möchte ich klare Richtlinien für die optimale Story-Größe haben,
damit meine Stories automatisch abgearbeitet werden können.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: agent-os/docs/story-sizing-guidelines.md

**Inhalt-Prüfungen:**
- [ ] CONTAINS: story-sizing-guidelines.md enthält "## Max-Größe pro Story"
- [ ] CONTAINS: story-sizing-guidelines.md enthält "5 Dateien"
- [ ] CONTAINS: story-sizing-guidelines.md enthält "400 LOC"
- [ ] CONTAINS: story-sizing-guidelines.md enthält "## Wann splitten?"
- [ ] CONTAINS: story-sizing-guidelines.md enthält "## Beispiele"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: Markdown-Syntax valide (keine broken links)

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified (None)
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Datei erstellt
- [ ] Alle Content-Sections vorhanden
- [ ] Beispiele mit gutem/schlechtem Format
- [ ] Verlinkung im CLAUDE.md

**Technical Details:**

**WAS:** Story-Sizing-Guidelines Dokument

**WIE:**
- Markdown-Dokument mit klaren Regeln
- Tabelle mit Max-Werten
- Entscheidungsbaum für Splitting
- Good/Bad Beispiele

**WO:**
- agent-os/docs/story-sizing-guidelines.md

**WER:** dev-team__po (oder main agent)

**Abhängigkeiten:** None

**Geschätzte Komplexität:** XS

**Completion Check:**
```bash
# Auto-Verify
test -f agent-os/docs/story-sizing-guidelines.md && echo "FILE OK"
grep -q "Max-Größe" agent-os/docs/story-sizing-guidelines.md && echo "CONTENT OK"
```

---

## Story 2: user-stories-template.md anpassen

**ID**: ASE-002
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: ASE-001

### User Story

Als PO-Agent
möchte ich ein Template mit dem neuen Akzeptanzkriterien-Format haben,
damit ich prüfbare Stories erstellen kann.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: agent-os/templates/docs/user-stories-template.md (updated)

**Inhalt-Prüfungen:**
- [ ] CONTAINS: user-stories-template.md enthält "### Akzeptanzkriterien (Prüfbar)"
- [ ] CONTAINS: user-stories-template.md enthält "FILE_EXISTS:"
- [ ] CONTAINS: user-stories-template.md enthält "CONTAINS:"
- [ ] CONTAINS: user-stories-template.md enthält "LINT_PASS:"
- [ ] CONTAINS: user-stories-template.md enthält "TEST_PASS:"
- [ ] CONTAINS: user-stories-template.md enthält "### Completion Check"
- [ ] CONTAINS: user-stories-template.md enthält "### Required MCP Tools"
- [ ] CONTAINS: user-stories-template.md enthält "MCP_PLAYWRIGHT:"
- [ ] NOT_CONTAINS: user-stories-template.md enthält NICHT das alte generische Format ohne Prefix

**Funktions-Prüfungen:**
- [ ] LINT_PASS: Markdown-Syntax valide

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified (ASE-001)
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Template aktualisiert
- [ ] Neue AC-Sections eingefügt
- [ ] Completion Check Section hinzugefügt
- [ ] Beispiele aktualisiert
- [ ] Alte Beispiele mit neuem Format ersetzt

**Technical Details:**

**WAS:** Aktualisiertes User-Stories-Template

**WIE:**
- Edit bestehende Datei
- Neues AC-Format mit Prefixes (FILE_EXISTS, CONTAINS, etc.)
- Completion Check Section am Ende jeder Story
- Beispiele im neuen Format

**WO:**
- agent-os/templates/docs/user-stories-template.md

**WER:** dev-team__po (oder main agent)

**Abhängigkeiten:** ASE-001 (für Referenz auf Guidelines)

**Geschätzte Komplexität:** S

**Completion Check:**
```bash
# Auto-Verify
grep -q "FILE_EXISTS:" agent-os/templates/docs/user-stories-template.md && echo "FORMAT OK"
grep -q "Completion Check" agent-os/templates/docs/user-stories-template.md && echo "SECTION OK"
```

---

## Story 3: create-spec.md PO-Phase anpassen

**ID**: ASE-003
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: ASE-001, ASE-002

### User Story

Als Agent OS
möchte ich dass der PO-Agent die Story-Sizing-Regeln automatisch anwendet,
damit Stories session-ready erstellt werden.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: agent-os/workflows/core/create-spec.md (updated)

**Inhalt-Prüfungen:**
- [ ] CONTAINS: create-spec.md enthält "STORY SIZING RULES"
- [ ] CONTAINS: create-spec.md enthält "Max 5 Dateien"
- [ ] CONTAINS: create-spec.md enthält "Max 400 LOC"
- [ ] CONTAINS: create-spec.md enthält "MANDATORY SPLIT"
- [ ] CONTAINS: create-spec.md enthält Referenz zu "story-sizing-guidelines.md"
- [ ] CONTAINS: create-spec.md Step 2 enthält das neue AC-Format

**Funktions-Prüfungen:**
- [ ] LINT_PASS: Workflow-Syntax valide (YAML frontmatter korrekt)

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Step 2 (PO Phase) aktualisiert
- [ ] Story-Sizing-Regeln im Prompt
- [ ] AC-Format-Anweisung im Prompt
- [ ] Referenz zu Guidelines
- [ ] Keine Breaking Changes für bestehende Funktionalität

**Technical Details:**

**WAS:** Aktualisierter create-spec Workflow (Step 2)

**WIE:**
- Edit Step 2 in create-spec.md
- Füge Story-Sizing-Rules zum PO-Prompt hinzu
- Füge AC-Format-Anweisung hinzu
- Referenziere story-sizing-guidelines.md

**WO:**
- agent-os/workflows/core/create-spec.md (Step 2)

**WER:** dev-team__architect (oder main agent)

**Abhängigkeiten:**
- ASE-001 (Guidelines müssen existieren)
- ASE-002 (Template muss aktualisiert sein)

**Geschätzte Komplexität:** S

**Completion Check:**
```bash
# Auto-Verify
grep -q "STORY SIZING RULES" agent-os/workflows/core/create-spec.md && echo "SIZING OK"
grep -q "FILE_EXISTS" agent-os/workflows/core/create-spec.md && echo "FORMAT OK"
```

---

## Story 4: create-spec.md Architect-Phase anpassen

**ID**: ASE-004
**Priority**: High
**Estimated Effort**: S (3 SP)
**Dependencies**: ASE-003

### User Story

Als Agent OS
möchte ich dass der Architect-Agent Completion-Checks hinzufügt,
damit Claude die Story-Fertigstellung automatisch verifizieren kann.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: agent-os/workflows/core/create-spec.md (updated)

**Inhalt-Prüfungen:**
- [ ] CONTAINS: create-spec.md Step 3 enthält "Completion Check"
- [ ] CONTAINS: create-spec.md Step 3 enthält "Auto-Verify Commands"
- [ ] CONTAINS: create-spec.md Step 3 enthält "Story ist DONE wenn"
- [ ] CONTAINS: create-spec.md enthält Beispiel für bash verify commands

**Funktions-Prüfungen:**
- [ ] LINT_PASS: Workflow-Syntax valide

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Step 3 (Architect Phase) aktualisiert
- [ ] Completion Check Section im Technical Refinement
- [ ] Auto-Verify Commands Beispiel
- [ ] Done-Kriterien definiert
- [ ] Konsistent mit PO-Phase (Step 2)

**Technical Details:**

**WAS:** Aktualisierter create-spec Workflow (Step 3)

**WIE:**
- Edit Step 3 in create-spec.md
- Füge Completion Check Sektion zum Architect-Output hinzu
- Definiere Auto-Verify Command Format
- Definiere Done-Kriterien

**WO:**
- agent-os/workflows/core/create-spec.md (Step 3)

**WER:** dev-team__architect (oder main agent)

**Abhängigkeiten:** ASE-003 (PO-Phase muss erst angepasst sein)

**Geschätzte Komplexität:** S

**Completion Check:**
```bash
# Auto-Verify
grep -q "Completion Check" agent-os/workflows/core/create-spec.md && echo "SECTION OK"
grep -q "Auto-Verify" agent-os/workflows/core/create-spec.md && echo "VERIFY OK"
grep -q "Story ist DONE" agent-os/workflows/core/create-spec.md && echo "DONE OK"
```

---

## Story 5: MCP-Tool-Check in execute-tasks einbauen

**ID**: ASE-005
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: ASE-004

### User Story

Als Agent OS
möchte ich dass execute-tasks vor Story-Start die MCP-Tool-Verfügbarkeit prüft,
damit Stories mit fehlenden Tools automatisch geblockt werden.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: agent-os/workflows/core/execute-tasks.md (updated)

**Inhalt-Prüfungen:**
- [ ] CONTAINS: execute-tasks.md enthält "Step 5.5" oder "mcp_tool_check"
- [ ] CONTAINS: execute-tasks.md enthält "Required MCP Tools"
- [ ] CONTAINS: execute-tasks.md enthält "BLOCKED"
- [ ] CONTAINS: execute-tasks.md enthält "claude mcp list" oder äquivalent

**Funktions-Prüfungen:**
- [ ] LINT_PASS: Workflow-Syntax valide

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Neuer Step 5.5 eingefügt
- [ ] Tool-Check-Logik implementiert
- [ ] BLOCKED-Status-Handling
- [ ] Keine Breaking Changes

**Technical Details:**

**WAS:** MCP-Tool-Requirement-Check vor Story-Execution

**WIE:**
- Neuer Step zwischen Branch-Management und Story-Execution
- Parse "### Required MCP Tools" Section aus Story
- Prüfe jedes Tool mit `claude mcp list`
- Bei fehlendem Tool: Status = BLOCKED, skip to next

**WO:**
- agent-os/workflows/core/execute-tasks.md (neuer Step 5.5)

**WER:** dev-team__architect (oder main agent)

**Abhängigkeiten:** ASE-004 (Template muss MCP-Section haben)

**Geschätzte Komplexität:** S

**Completion Check:**
```bash
# Auto-Verify
grep -q "mcp_tool_check\|Step 5.5" agent-os/workflows/core/execute-tasks.md && echo "STEP OK"
grep -q "BLOCKED" agent-os/workflows/core/execute-tasks.md && echo "BLOCKING OK"
```

---

## Story 6: MCP-Setup-Guide erstellen

**ID**: ASE-006
**Priority**: Medium
**Estimated Effort**: XS (1 SP)
**Dependencies**: None (parallel zu ASE-001)

### User Story

Als Benutzer von Agent OS
möchte ich eine Anleitung haben wie ich MCP-Tools für Browser-Tests installiere,
damit ich Frontend-Stories automatisch verifizieren kann.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: agent-os/docs/mcp-setup-guide.md

**Inhalt-Prüfungen:**
- [ ] CONTAINS: mcp-setup-guide.md enthält "## Playwright MCP"
- [ ] CONTAINS: mcp-setup-guide.md enthält ".mcp.json"
- [ ] CONTAINS: mcp-setup-guide.md enthält "@anthropics/mcp-server-playwright" oder äquivalent
- [ ] CONTAINS: mcp-setup-guide.md enthält "## Verification"
- [ ] CONTAINS: mcp-setup-guide.md enthält "claude mcp list"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: Markdown-Syntax valide

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified (None)
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] Guide erstellt
- [ ] Playwright-Setup dokumentiert
- [ ] Verification-Schritte dokumentiert
- [ ] JSON-Snippets für .mcp.json

**Technical Details:**

**WAS:** MCP-Setup-Guide für Browser-Tools

**WIE:**
- Markdown-Dokument
- Step-by-Step für Playwright
- .mcp.json Konfiguration
- Verification mit `claude mcp list`

**WO:**
- agent-os/docs/mcp-setup-guide.md

**WER:** dev-team__po (oder main agent)

**Abhängigkeiten:** None

**Geschätzte Komplexität:** XS

**Completion Check:**
```bash
# Auto-Verify
test -f agent-os/docs/mcp-setup-guide.md && echo "FILE OK"
grep -q "Playwright" agent-os/docs/mcp-setup-guide.md && echo "PLAYWRIGHT OK"
grep -q ".mcp.json" agent-os/docs/mcp-setup-guide.md && echo "CONFIG OK"
```

---

## Story 7: setup.sh um neue Docs erweitern

**ID**: ASE-007
**Priority**: Medium
**Estimated Effort**: XS (1 SP)
**Dependencies**: ASE-001, ASE-006

### User Story

Als Agent OS Maintainer
möchte ich dass die neuen Dokumentationsdateien bei der Installation mitgeliefert werden,
damit Benutzer sofort Zugriff auf Story-Sizing-Guidelines und MCP-Setup-Guide haben.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: setup.sh (updated)

**Inhalt-Prüfungen:**
- [ ] CONTAINS: setup.sh enthält "agent-os/docs/story-sizing-guidelines.md"
- [ ] CONTAINS: setup.sh enthält "agent-os/docs/mcp-setup-guide.md"
- [ ] CONTAINS: setup.sh enthält "mkdir -p agent-os/docs"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: shellcheck setup.sh (keine Errors)
- [ ] TEST_PASS: setup.sh --help funktioniert weiterhin

---

### Technisches Refinement (vom Architect)

**DoR (Definition of Ready):**
- [x] Fachliche Requirements clear
- [x] Technical approach defined
- [x] Dependencies identified
- [x] Affected components known

**DoD (Definition of Done):**
- [ ] mkdir für agent-os/docs hinzugefügt
- [ ] Download-Zeilen für beide Docs hinzugefügt
- [ ] Docs-Sektion in Summary ergänzt
- [ ] Keine Breaking Changes

**Technical Details:**

**WAS:** setup.sh erweitern um neue Docs

**WIE:**
- Neuen mkdir-Befehl: `mkdir -p agent-os/docs`
- Zwei neue download_file Aufrufe:
  ```bash
  download_file "$REPO_URL/agent-os/docs/story-sizing-guidelines.md" "agent-os/docs/story-sizing-guidelines.md" "docs"
  download_file "$REPO_URL/agent-os/docs/mcp-setup-guide.md" "agent-os/docs/mcp-setup-guide.md" "docs"
  ```
- Summary-Sektion aktualisieren

**WO:**
- setup.sh (Root)

**WER:** dev-team__devops-specialist (oder main agent)

**Abhängigkeiten:**
- ASE-001 (story-sizing-guidelines.md muss existieren)
- ASE-006 (mcp-setup-guide.md muss existieren)

**Geschätzte Komplexität:** XS

**Completion Check:**
```bash
# Auto-Verify
grep -q "story-sizing-guidelines.md" setup.sh && echo "GUIDELINES OK"
grep -q "mcp-setup-guide.md" setup.sh && echo "MCP-GUIDE OK"
grep -q "agent-os/docs" setup.sh && echo "DOCS DIR OK"
```

---

## Execution Order

```
ASE-001 (Guidelines) ──────────→ ASE-002 (Template) → ASE-003 (PO) → ASE-004 (Architect) → ASE-005 (Tool-Check)
       ↓                               ↑
ASE-006 (MCP-Guide) ──────────────────┘
       ↓
       └───────────────────────────────→ ASE-007 (setup.sh)
```

**Parallelisierbar:**
- ASE-001 + ASE-006 können parallel laufen (keine Dependencies)

**Abhängigkeiten:**
- ASE-007 wartet auf ASE-001 und ASE-006 (die Docs müssen erst existieren)

Alle Stories sind "session-ready":
- Max 2-3 Dateien pro Story
- Klare FILE_EXISTS/CONTAINS Checks
- Completion Check mit Bash Commands
