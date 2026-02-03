# Handover: Phase-Dateien JSON Migration

> Abgeschlossen
> Stand: 2026-02-03

## Was bereits erledigt ist ✅

### 1. JSON Schemas & Templates
- `agent-os/templates/schemas/backlog-schema.json`
- `agent-os/templates/schemas/execution-kanban-schema.json`
- `agent-os/templates/schemas/spec-kanban-schema.json`
- `agent-os/templates/json/backlog-template.json`
- `agent-os/templates/json/execution-kanban-template.json`
- `agent-os/templates/json/spec-kanban-template.json`

### 2. Workflows aktualisiert
- `/add-bug` (v3.0) - Schreibt in backlog.json
- `/add-todo` (v2.0) - Schreibt in backlog.json
- `/create-spec` (v3.3) - Erstellt kanban.json
- `/add-story` (v2.0) - Updatet kanban.json
- `/execute-tasks` Entry-Point (v4.0) - Liest JSON, MD-Fallback

### 3. Neues Command
- `/migrate-kanban` - Migriert bestehende MD-Kanbans zu JSON

### 4. Setup Scripts
- `setup-devteam-global.sh` (v4.0) - Installiert JSON Templates

### 5. Phase-Dateien ✅ (2026-02-03)
- `backlog-phase-1.md` (v4.0) - Erstellt executions/kanban-{TODAY}.json
- `backlog-phase-2.md` (v4.0) - Liest/schreibt execution-kanban.json, updatet backlog.json
- `backlog-phase-3.md` (v4.0) - Liest execution-kanban.json für Summary
- `spec-phase-1.md` (v4.0) - Erstellt/liest kanban.json
- `spec-phase-2.md` (v4.0) - Updatet kanban.json resumeContext
- `spec-phase-3.md` (v5.0) - Updatet stories[] status in kanban.json
- `spec-phase-4-5.md` (v5.0) - Liest kanban.json für Integration Check
- `spec-phase-5.md` (v5.0) - Updatet kanban.json auf complete

---

## Test-Szenario

Testen mit:
1. `/add-todo "Test Task"` → Prüfen ob backlog.json korrekt
2. `/execute-tasks backlog` → Prüfen ob execution-kanban.json erstellt wird
3. Execution durchführen → Prüfen ob Status-Updates in JSON landen

---

## Implementierte JSON-Felder

### Bei Story-Start (in kanban.json):
```json
{
  "stories[id].status": "in_progress",
  "stories[id].phase": "implementing",
  "stories[id].timing.startedAt": "[NOW]",
  "resumeContext.currentStory": "[STORY_ID]",
  "resumeContext.currentStoryPhase": "implementing",
  "boardStatus.inProgress": "+1",
  "boardStatus.ready": "-1"
}
```

### Bei Story-Completion (in kanban.json):
```json
{
  "stories[id].status": "done",
  "stories[id].phase": "completed",
  "stories[id].timing.completedAt": "[NOW]",
  "stories[id].implementation.filesModified": ["..."],
  "stories[id].implementation.commits": [{"hash": "...", "message": "...", "timestamp": "..."}],
  "stories[id].verification.dodChecked": true,
  "resumeContext.currentStory": null,
  "resumeContext.progressIndex": "+1",
  "boardStatus.done": "+1",
  "boardStatus.inProgress": "-1",
  "statistics.completedEffort": "+effort"
}
```

### changeLog Entry Format:
```json
{
  "timestamp": "[NOW]",
  "action": "status_changed",
  "storyId": "[STORY_ID]",
  "from": "ready",
  "to": "done",
  "details": "Story completed"
}
```
