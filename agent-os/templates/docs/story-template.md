# [STORY_TITLE]

> Story ID: [STORY_ID]
> Spec: [SPEC_NAME]
> Created: [CREATED_DATE]
> Last Updated: [LAST_UPDATED_DATE]

**Priority**: [PRIORITY]
**Type**: [STORY_TYPE]
**Estimated Effort**: [EFFORT_ESTIMATE]
**Dependencies**: [DEPENDENCIES]

---

## User Story

Als [USER_ROLE]
möchte ich [ACTION],
damit [BENEFIT].

---

## Akzeptanzkriterien (Prüfbar)

### Datei-Prüfungen

- [ ] FILE_EXISTS: [EXACT_FILE_PATH]
- [ ] FILE_NOT_EXISTS: [PATH_THAT_SHOULD_NOT_EXIST]

### Inhalt-Prüfungen

- [ ] CONTAINS: [FILE] enthält "[TEXT_OR_PATTERN]"
- [ ] NOT_CONTAINS: [FILE] enthält NICHT "[TEXT]"

### Funktions-Prüfungen

- [ ] LINT_PASS: [LINT_COMMAND] exits with code 0
- [ ] TEST_PASS: [TEST_COMMAND] exits with code 0
- [ ] BUILD_PASS: [BUILD_COMMAND] exits with code 0

### Browser-Prüfungen (erfordern MCP-Tool)

- [ ] MCP_PLAYWRIGHT: [PAGE_URL] loads without errors
- [ ] MCP_SCREENSHOT: Visual comparison passes

### Manuelle Prüfungen (nur wenn unvermeidbar)

- [ ] MANUAL: [DESCRIPTION_OF_MANUAL_CHECK]

---

## Required MCP Tools

| Tool | Purpose | Blocking |
|------|---------|----------|
| [TOOL_NAME] | [PURPOSE] | Yes/No |

**Pre-Flight Check:**
```bash
claude mcp list | grep -q "[TOOL_NAME]"
```

**If Missing:** Story wird als BLOCKED markiert

---

## Technisches Refinement (vom Architect)

> **⚠️ WICHTIG:** Dieser Abschnitt wird vom Architect ausgefüllt

### DoR (Definition of Ready) - Vom Architect

#### Fachliche Anforderungen
- [x] Fachliche requirements klar definiert
- [x] Akzeptanzkriterien sind spezifisch und prüfbar
- [x] Business Value verstanden

#### Technische Vorbereitung
- [x] Technischer Ansatz definiert (WAS/WIE/WO)
- [x] Abhängigkeiten identifiziert
- [x] Betroffene Komponenten bekannt
- [x] Erforderliche MCP Tools dokumentiert (falls zutreffend)
- [x] Story ist angemessen geschätzt (max 5 Dateien, 400 LOC)

#### Full-Stack Konsistenz (NEU)
- [x] **Alle betroffenen Layer identifiziert** (Frontend/Backend/Database/DevOps)
- [x] **Integration Type bestimmt** (Backend-only/Frontend-only/Full-stack)
- [x] **Kritische Integration Points dokumentiert** (wenn Full-stack)
- [x] **Handover-Dokumente definiert** (bei Multi-Layer: API Contracts, Data Structures)

**Story ist READY wenn alle Checkboxen angehakt sind.**

---

### DoD (Definition of Done) - Vom Architect

#### Implementierung
- [ ] Code implementiert und folgt Style Guide
- [ ] Architektur-Vorgaben eingehalten (WIE section)
- [ ] Security/Performance Anforderungen erfüllt

#### Qualitätssicherung
- [ ] Alle Akzeptanzkriterien erfüllt (via Completion Check verifiziert)
- [ ] Unit Tests geschrieben und bestanden
- [ ] Integration Tests geschrieben und bestanden
- [ ] Code Review durchgeführt und genehmigt

#### Dokumentation
- [ ] Dokumentation aktualisiert
- [ ] Keine Linting Errors
- [ ] Completion Check Commands alle erfolgreich (exit 0)

**Story ist DONE wenn alle Checkboxen angehakt sind.**

---

### Betroffene Layer & Komponenten

> **PFLICHT:** Der Architect MUSS alle betroffenen Layer identifizieren für Full-Stack Konsistenz

**Integration Type:** [Backend-only / Frontend-only / Full-stack]

**Betroffene Komponenten:**

| Layer | Komponenten | Änderung |
|-------|-------------|----------|
| Frontend | [Komponenten/Dateien] | [Was wird geändert/erstellt] |
| Backend | [Services/Controller] | [Was wird geändert/erstellt] |
| Database | [Tabellen/Schema] | [Was wird geändert/erstellt] |
| DevOps | [Config/Pipeline] | [Was wird geändert/erstellt] |

**Kritische Integration Points:**
- [Integration 1]: [Quelle] → [Ziel] (z.B. "Backend API Response → Frontend UserProfile Component")
- [Integration 2]: [Quelle] → [Ziel] (z.B. "Database Schema → Backend Query")

**Handover-Dokumente (bei Multi-Layer):**
- API Contracts: [Link oder inline definieren]
- Data Structures: [Link oder inline definieren]
- Shared Types: [Link oder inline definieren]

---

### Technical Details

**WAS:** [Was für Komponenten/Features erstellt oder modifiziert werden müssen - KEIN Code]

**WIE (Architektur-Guidance ONLY):**
- Welche Architektur-Pattern anwenden (z.B. "Use Repository Pattern", "Apply Service Object")
- Constraints zu beachten (z.B. "Keine direkten DB-Aufrufe aus Controllers", "Must use existing AuthService")
- Existierende Patterns folgen (z.B. "Follow pattern from existing UserController")
- Security/Performance Überlegungen (z.B. "Requires rate limiting", "Use caching")

⚠️ **WICHTIG:** KEIN Implementierungscode, KEIN Pseudo-Code, KEIN detaillierte Algorithmen.
Der implementierende Agent entscheidet WIE er den Code schreibt - du setzt nur Guardrails.

**WO:** [Welche Dateien/Ordner zu modifizieren oder erstellen sind - nur Pfade, kein Inhalt]

**WER:** [Welcher Agent - siehe .claude/agents/dev-team/ für verfügbare Agents]
Beispiele: dev-team__backend-developer, dev-team__frontend-developer

**Abhängigkeiten:** [Story IDs von denen diese Story abhängt, oder "None"]

**Geschätzte Komplexität:** [XS/S/M/L/XL]

---

### Relevante Skills

> Vom Architect ausgewählt basierend auf skill-index.md
> Diese Skills werden vom Orchestrator gelesen und Patterns extrahiert

| Skill | Pfad | Grund |
|-------|------|-------|
| [SKILL_NAME_1] | agent-os/skills/[skill-path].md | [Warum relevant für diese Story] |
| [SKILL_NAME_2] | agent-os/skills/[skill-path].md | [Warum relevant für diese Story] |

**Skill-Referenz:** agent-os/team/skill-index.md

---

### Completion Check

```bash
# Auto-Verify Commands - alle müssen mit 0 exiten
[VERIFY_COMMAND_1]
[VERIFY_COMMAND_2]
```

**Story ist DONE wenn:**
1. Alle FILE_EXISTS/CONTAINS checks bestanden
2. Alle *_PASS commands exit 0
3. Git diff zeigt nur erwartete Änderungen

---

## Template Usage Instructions

### Placeholders

**Story Level:**
- `[STORY_ID]`: Unique identifier (e.g., PROF-001)
- `[STORY_TITLE]`: Brief descriptive title
- `[SPEC_NAME]`: Name of the parent specification
- `[CREATED_DATE]`: ISO date format (YYYY-MM-DD)
- `[LAST_UPDATED_DATE]`: ISO date format (YYYY-MM-DD)
- `[PRIORITY]`: Critical, High, Medium, Low
- `[STORY_TYPE]`: Backend, Frontend, DevOps, Test
- `[EFFORT_ESTIMATE]`: Story points (max S/3 SP for automation)
- `[DEPENDENCIES]`: Other story IDs or "None"
- `[USER_ROLE]`: The persona using this feature
- `[ACTION]`: What the user wants to do
- `[BENEFIT]`: Why this matters to the user

**Acceptance Criteria Prefixes:**
- `FILE_EXISTS:` - Verify file exists at path
- `FILE_NOT_EXISTS:` - Verify file does NOT exist
- `CONTAINS:` - Verify file contains text/pattern
- `NOT_CONTAINS:` - Verify file does NOT contain text
- `LINT_PASS:` - Verify lint command passes
- `TEST_PASS:` - Verify test command passes
- `BUILD_PASS:` - Verify build command passes
- `MCP_PLAYWRIGHT:` - Browser verification (requires MCP tool)
- `MCP_SCREENSHOT:` - Visual comparison (requires MCP tool)
- `MANUAL:` - Manual verification required (avoid if possible)

### Guidelines

**Story Sizing** (for automated execution):
- Max 5 files per story
- Max 400 LOC per story
- Max complexity: S (Small, 1-3 SP)
- Single concern per story

**Acceptance Criteria:**
- MUST use prefix format (FILE_EXISTS, CONTAINS, etc.)
- MUST be verifiable via bash commands
- MUST include exact file paths
- Avoid MANUAL criteria when possible

**DoR (Definition of Ready):**
- Architect marks items as done [x] during refinement
- All checkboxes MUST be checked before /execute-tasks
- Story cannot start if DoR is incomplete

**DoD (Definition of Done):**
- Architect defines completion criteria
- All items start unchecked [ ]
- Implementing agent marks as done [x] during execution
- Story is DONE only when all DoD items are checked

**MCP Tools:**
- Document required tools in "Required MCP Tools" section
- Include Pre-Flight Check command

**Completion Check:**
- Include bash commands that verify story completion
- All commands must exit with code 0 for story to be DONE
