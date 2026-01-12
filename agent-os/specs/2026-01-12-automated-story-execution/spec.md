# Automated Story Execution (Ralph-Style)

> Created: 2026-01-12
> Status: Draft

## Overview

Ermöglicht die automatische Abarbeitung von User Stories durch Claude Code, indem Stories so geschnitten und formuliert werden, dass sie in einer einzelnen Session abgeschlossen werden können.

## Ziele

1. **Story-Sizing**: Stories sind klein genug für 1 Claude Code Session (~15-30 Min)
2. **Glasklare Akzeptanzkriterien**: Claude weiß exakt, wann eine Story "fertig" ist
3. **Automatische Ausführung**: Stories können ohne Benutzerinteraktion abgearbeitet werden
4. **Resume-Fähigkeit**: Bei Abbruch kann nahtlos fortgesetzt werden

## Scope

### In Scope
- Anpassung des `create-spec` Workflows für bessere Story-Granularität
- Neue Richtlinien für Akzeptanzkriterien-Formulierung
- Optional: Neues `/auto-execute` Command für nicht-interaktive Ausführung
- Story-Sizing-Heuristiken

### Out of Scope
- Integration von Ralph Wiggum selbst (nur Prinzipien übernehmen)
- Änderungen am grundlegenden Agent-System
- Neue Subagents

## Kernkonzepte

### 1. Story-Sizing-Regel: "One Session, One Story"

Eine Story ist "session-ready" wenn sie diese Kriterien erfüllt:

| Kriterium | Beschreibung | Max-Wert |
|-----------|--------------|----------|
| **Dateien** | Neue/geänderte Dateien | 3-5 Dateien |
| **LOC** | Lines of Code (geschätzt) | ~200-400 LOC |
| **Komplexität** | Story Points | XS-S (1-3 SP) |
| **Typ** | Single-Concern | 1 Feature/Fix/Refactor |
| **Dependencies** | Externe Abhängigkeiten | 0-1 |

### 2. Akzeptanzkriterien-Format: "Prüfbar & Automatisierbar"

Jedes Kriterium muss:
- **Konkret**: Exakter Dateiname/Pfad/Wert
- **Prüfbar**: Kann mit Bash/Test verifiziert werden
- **Atomar**: Ein Kriterium = eine Prüfung

**Beispiel - SCHLECHT:**
```markdown
- [ ] Alle Templates erstellt
- [ ] Code funktioniert
```

**Beispiel - GUT:**
```markdown
- [ ] FILE_EXISTS: agent-os/templates/api-spec.md
- [ ] CONTAINS: api-spec.md hat Section "## Endpoint Specification"
- [ ] LINT_PASS: npm run lint exits with code 0
- [ ] TEST_PASS: npm test -- --grep "api-spec" passes
```

### 3. Story-Completion-Signale

Claude erkennt "fertig" durch:
1. Alle Akzeptanzkriterien abgehakt
2. DoD-Checkliste vollständig
3. Tests bestanden (falls definiert)
4. Keine offenen TODOs im Code

### 4. MCP-Tool-Requirements (für Frontend/E2E Stories)

Stories die Browser-Verification oder E2E-Tests benötigen, müssen ihre Tool-Anforderungen deklarieren.

**Verfügbare MCP-Tools für Verification:**

| Tool | MCP Server | Purpose |
|------|------------|---------|
| Playwright | `@anthropics/playwright-mcp` | Browser-Automation, E2E-Tests |
| Chrome DevTools | `chrome-devtools-mcp` | DOM-Inspection, Network-Analyse |
| Puppeteer | `puppeteer-mcp` | Alternative Browser-Automation |

**Tool-Requirement-Format in Stories:**

```markdown
### Required MCP Tools

| Tool | Purpose | Blocking |
|------|---------|----------|
| playwright | UI-Verification nach Implementation | Yes |

**Pre-Flight Check:**
```bash
claude mcp list | grep -q "playwright"
```

**If Missing:** Story wird als BLOCKED markiert
```

**Blocking-Strategie:**
- Vor Story-Start prüft execute-tasks die Tool-Requirements
- Fehlt ein Required Tool → Story Status = "BLOCKED"
- Benutzer muss Tool installieren
- Nach Installation: Story wird automatisch "unblocked"

**MCP-Setup für Playwright:**
```json
// In .mcp.json hinzufügen:
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@anthropics/mcp-server-playwright"]
    }
  }
}
```

## Technische Änderungen

### Änderung 1: Story-Sizing im PO-Agent

**Datei**: `agent-os/workflows/core/create-spec.md` (Step 2)

Neue Anweisung für dev-team__po:
```
STORY SIZING RULES:
- Max 5 Dateien pro Story
- Max 400 LOC pro Story
- Wenn Story > 5 Dateien: SPLIT in Sub-Stories
- Komplexität max "S" (Small)
- Bei "M" oder größer: MANDATORY SPLIT
```

### Änderung 2: Akzeptanzkriterien-Format im PO-Agent

Neues Format für Akzeptanzkriterien:
```markdown
### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: [exakter Pfad]
- [ ] FILE_NOT_EXISTS: [Pfad der nicht existieren soll]

**Inhalt-Prüfungen:**
- [ ] CONTAINS: [Datei] enthält "[Text/Pattern]"
- [ ] NOT_CONTAINS: [Datei] enthält NICHT "[Text]"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: [lint command] beendet mit exit 0
- [ ] TEST_PASS: [test command] beendet mit exit 0
- [ ] BUILD_PASS: [build command] beendet mit exit 0

**Manuelle Prüfungen (nur wenn unvermeidbar):**
- [ ] MANUAL: [Beschreibung der manuellen Prüfung]
```

### Änderung 3: Architect fügt Completion-Check hinzu

**Datei**: `agent-os/workflows/core/create-spec.md` (Step 3)

Neue Sektion im Technical Refinement:
```markdown
### Completion Check (vom Architect)

**Auto-Verify Commands:**
```bash
# Diese Commands müssen alle exit 0 liefern
[command 1]
[command 2]
```

**Story ist DONE wenn:**
1. Alle FILE_EXISTS/CONTAINS checks bestanden
2. Alle *_PASS commands exit 0
3. Git diff zeigt nur erwartete Änderungen
```

### Änderung 4: MCP-Tool-Requirement-Check in execute-tasks

**Datei**: `agent-os/workflows/core/execute-tasks.md` (vor Step 6)

Neuer Pre-Execution Check:
```markdown
<step number="5.5" name="mcp_tool_check">

### Step 5.5: MCP Tool Requirements Check

Prüfe ob alle Required MCP Tools für die ausgewählte Story verfügbar sind.

<tool_check>
  READ: Selected story from user-stories.md
  CHECK: "### Required MCP Tools" section exists?

  IF section exists:
    FOR each required tool:
      RUN: claude mcp list | grep -q "[tool-name]"
      IF exit code != 0:
        MARK: Story as "BLOCKED"
        LOG: "Missing MCP tool: [tool-name]"
        NOTIFY: User with setup instructions
        SKIP: This story, select next eligible
</tool_check>

</step>
```

### Änderung 5: Browser-Verification Akzeptanzkriterien

Neue AC-Typen für Frontend-Stories:
```markdown
**Browser-Prüfungen (erfordern MCP-Tool):**
- [ ] MCP_PLAYWRIGHT: Page "http://localhost:3000/feature" loads without errors
- [ ] MCP_PLAYWRIGHT: Element "[data-testid='button']" is visible
- [ ] MCP_PLAYWRIGHT: Click on button triggers expected action
- [ ] MCP_SCREENSHOT: Visual comparison passes (optional)
```

### Änderung 6: Neues /auto-execute Command (Optional)

Erstellt ein neues Command das execute-tasks ohne Benutzerinteraktion ausführt:
- Überspringt alle `AskUserQuestion` Prompts
- Wählt automatisch nächste Story aus Kanban
- Prüft MCP-Tool-Requirements vor jeder Story
- Stoppt bei Fehlern, BLOCKED Stories, oder wenn alle Stories done
- Ideal für Batch-Ausführung

## Deliverables

1. **Aktualisiertes create-spec.md** mit Story-Sizing-Regeln
2. **Aktualisiertes user-stories-template.md** mit neuem AC-Format
3. **Story-Sizing-Guidelines** als Referenz-Dokument
4. **Aktualisiertes execute-tasks.md** mit MCP-Tool-Check
5. **MCP-Setup-Guide** für Browser-Tools
6. **Aktualisiertes setup.sh** mit neuen Docs-Downloads
7. **Optional: auto-execute.md** Workflow

## Akzeptanzkriterien für diese Spec

- [ ] Story-Sizing-Regeln sind in create-spec.md dokumentiert
- [ ] Neues Akzeptanzkriterien-Format ist im Template (inkl. MCP_PLAYWRIGHT)
- [ ] PO-Agent nutzt neue Sizing-Regeln
- [ ] Architect fügt Completion-Check hinzu
- [ ] execute-tasks enthält MCP-Tool-Check (Step 5.5)
- [ ] MCP-Setup-Guide für Playwright dokumentiert
- [ ] setup.sh lädt neue Docs herunter
- [ ] Mindestens 1 Test-Spec mit neuem Format erstellt

## Risiken & Mitigationen

| Risiko | Mitigation |
|--------|------------|
| Stories werden zu klein/fragmentiert | Min-Größe definieren (mind. 50 LOC) |
| AC-Format zu starr | MANUAL-Typ für Ausnahmen erlauben |
| Existing Specs inkompatibel | Nur für neue Specs, keine Migration |

## Nächste Schritte

1. Review dieser Spec
2. Story-Sizing-Guidelines als separates Dokument
3. Anpassung create-spec.md
4. Anpassung user-stories-template.md
5. Test mit einer echten Feature-Spec
