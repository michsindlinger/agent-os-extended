# Implementierungsplan: Kanban JSON Migration

> Migration von Markdown-basierten Kanban-Boards zu JSON
> Erstellt: 2026-02-03
> Status: ✅ COMPLETED

## Übersicht

Migration des Kanban-Systems von fehleranfälligem Markdown-Tabellen-Parsing zu strukturiertem JSON als Single Source of Truth.

## Betroffene Systeme

| System | Aktuell | Neu | Commands |
|--------|---------|-----|----------|
| **Backlog** | `story-index.md` | `backlog.json` | `/add-bug`, `/add-todo` |
| **Backlog Execution** | Daily MD Kanbans | `executions/kanban-*.json` | `/execute-tasks backlog` |
| **Spec Kanban** | `kanban-board.md` | `kanban.json` | `/create-spec`, `/add-story`, `/execute-tasks [spec]` |

---

## Phase 1: Schema & Templates (Foundation) ✅

### 1.1 JSON Schema Files erstellen
- [x] `agent-os/templates/schemas/backlog-schema.json`
- [x] `agent-os/templates/schemas/execution-kanban-schema.json`
- [x] `agent-os/templates/schemas/spec-kanban-schema.json`

### 1.2 TypeScript Interface Dokumentation
- [ ] `agent-os/docs/schemas/kanban-types.md` - Referenzdokumentation (optional, types in schema files)

### 1.3 Template Files erstellen
- [x] `agent-os/templates/json/backlog-template.json`
- [x] `agent-os/templates/json/execution-kanban-template.json`
- [x] `agent-os/templates/json/spec-kanban-template.json`

---

## Phase 2: Backlog System Migration ✅

### 2.1 Workflow: /add-bug anpassen
- [x] `agent-os/workflows/core/add-bug.md` - JSON statt MD (v3.0)
- [x] Step 1: backlog.json laden/erstellen
- [x] Step 6: In backlog.json schreiben statt story-index.md

### 2.2 Workflow: /add-todo anpassen
- [x] `agent-os/workflows/core/add-todo.md` - JSON statt MD (v2.0)
- [x] Step 1: backlog.json laden/erstellen
- [x] Step 5: In backlog.json schreiben statt story-index.md

### 2.3 Backlog Story-Index Template aktualisieren
- [ ] `agent-os/templates/docs/backlog-story-index-template.md` → Optional: View-Only oder entfernen

---

## Phase 3: Spec Kanban Migration ✅

### 3.1 Workflow: /create-spec anpassen
- [x] `agent-os/workflows/core/create-spec.md` - kanban.json statt kanban-board.md (v3.3)
- [x] Kanban-Generierung auf JSON umstellen

### 3.2 Workflow: /add-story anpassen
- [x] `agent-os/workflows/core/add-story.md` - JSON Update (v2.0)
- [x] Step 6: kanban.json statt kanban-board.md

### 3.3 Kanban Template aktualisieren
- [ ] `agent-os/templates/docs/kanban-board-template.md` → Entfernen oder deprecaten (backward compat)

---

## Phase 4: Execute-Tasks Integration ✅

### 4.1 Workflow: /execute-tasks anpassen
- [x] `agent-os/workflows/core/execute-tasks/entry-point.md` (v4.0)
- [x] Backlog-Modus: backlog.json → execution-kanban.json
- [x] Spec-Modus: kanban.json lesen/schreiben
- [x] Resume-Context aus JSON

### 4.2 Recovery-Logik
- [x] Resume nach /clear aus JSON (entry-point updated)
- [x] Status-Updates in JSON

**Note:** Phase-Dateien (backlog-phase-*.md, spec-phase-*.md) benötigen noch Updates für vollständige JSON-Integration.

---

## Phase 5: Setup Scripts & Installation ✅

### 5.1 Setup Scripts aktualisieren
- [ ] `setup.sh` - Neue Template-Pfade (optional, uses global)
- [x] `setup-devteam-global.sh` - JSON Templates kopieren (v4.0)

### 5.2 Ordnerstruktur dokumentieren
- [x] Neue Struktur in implementation-plan.md

---

## Phase 6: Migration & Cleanup

### 6.1 Migration bestehender Daten (Optional)
- [ ] Konverter-Script für alte MD-Kanbans
- [ ] Oder: Alte Specs behalten, neue nutzen JSON

### 6.2 Cleanup
- [ ] Alte MD-Templates deprecaten
- [ ] Dokumentation aktualisieren

---

## Reihenfolge der Implementierung

```
Phase 1 (Foundation)
    │
    ├── 1.1 Schemas ──────────────────┐
    ├── 1.2 Type Docs                 │
    └── 1.3 Templates ────────────────┤
                                      │
Phase 2 (Backlog) ◄───────────────────┤
    │                                 │
    ├── 2.1 /add-bug                  │
    ├── 2.2 /add-todo                 │
    └── 2.3 Templates                 │
                                      │
Phase 3 (Spec Kanban) ◄───────────────┤
    │                                 │
    ├── 3.1 /create-spec              │
    ├── 3.2 /add-story                │
    └── 3.3 Templates                 │
                                      │
Phase 4 (Execute) ◄───────────────────┘
    │
    ├── 4.1 /execute-tasks
    └── 4.2 Recovery

Phase 5 (Setup)
    │
    ├── 5.1 Scripts
    └── 5.2 Docs

Phase 6 (Cleanup)
    │
    ├── 6.1 Migration
    └── 6.2 Cleanup
```

---

## Risiken & Mitigationen

| Risiko | Mitigation |
|--------|------------|
| Bestehende Specs brechen | Alte MD-Parser als Fallback behalten |
| Komplexe JSON-Manipulation | Klare Schemas, Validierung |
| Workflows werden komplex | Schrittweise Migration, testen |

---

## Erfolgskriterien

- [ ] Alle neuen Specs nutzen JSON
- [ ] /add-bug und /add-todo schreiben in backlog.json
- [ ] /execute-tasks kann aus JSON resumieren
- [ ] Keine MD-Tabellen-Parsing-Fehler mehr
- [ ] Model-Änderungen funktionieren zuverlässig
