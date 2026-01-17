# DevTeam Skill-Loading Refactoring

> Created: 2026-01-17
> Status: Planning
> Type: Architecture Refactoring

## Problem Statement

### Aktuelles Verhalten
Sub-Agents in Claude Code laden **ALLE deklarierten Skills komplett beim Start** in den Context:

```
Main Agent → Task an dev-team__backend-developer
                    ↓
              Lädt ALLE Skills:
              - logic-implementing (~680 Zeilen)
              - persistence-adapter (~500 Zeilen)
              - integration-adapter (~400 Zeilen)
              - test-engineering (~500 Zeilen)
              ─────────────────────────────
              = ~2080 Zeilen Context SOFORT
```

### Warum ist das problematisch?

1. **Context-Verschwendung**: Skills werden geladen, auch wenn nur einer relevant ist
2. **Kosten**: Mehr Tokens = höhere Kosten (bei jedem Task!)
3. **Context-Limit**: Weniger Platz für eigentlichen Task-Content
4. **Keine Selektion**: Sub-Agent kann nicht wählen welcher Skill relevant ist

### Unterschied Main Agent vs Sub-Agent

| Aspekt | Main Agent | Sub-Agent |
|--------|------------|-----------|
| Skill Loading | On-demand, context-based | Full injection at startup |
| Timing | Wenn relevant (via globs/description) | Sofort bei Erstellung |
| Context Impact | Minimal | Massiv |

## Proposed Solution

### Konzept: "Skills als Wissensbasis für Orchestrator"

```
Orchestrator (Main Agent)
    ↓
1. Liest Story/Task
2. Erkennt: "Backend Service implementieren"
3. Liest on-demand: logic-implementing.md
4. Extrahiert: Nur relevante Patterns (50-100 Zeilen)
5. Erstellt Task-Prompt mit extrahierten Patterns
    ↓
Sub-Agent (dev-team__backend-developer)
    - Erhält schlanken Task-Prompt
    - Hat Rolle/Verantwortlichkeiten
    - Hat KEINE Skills geladen
    - Arbeitet mit den mitgegebenen Anweisungen
```

### Vorteile

- **Effizienz**: Nur relevante Infos werden übergeben
- **Flexibilität**: Orchestrator entscheidet was wichtig ist
- **Kosteneinsparung**: Drastisch weniger Tokens pro Task
- **Bessere Qualität**: Fokussierter Context = bessere Ergebnisse

## Implementation Plan

### Phase 1: Template-Refactoring

**1.1 Agent-Templates anpassen**

Entferne `skills:` aus YAML frontmatter, behalte Rolle und Verantwortlichkeiten:

```yaml
# VORHER
---
name: dev-team__backend-developer
skills: [SKILLS_LIST]
tools: Read, Write, Edit, Bash, Task
---

# NACHHER
---
name: dev-team__backend-developer
tools: Read, Write, Edit, Bash
---
```

**Betroffene Dateien:**
- `agent-os/templates/agents/dev-team/backend-developer-template.md`
- `agent-os/templates/agents/dev-team/frontend-developer-template.md`
- `agent-os/templates/agents/dev-team/devops-specialist-template.md`
- `agent-os/templates/agents/dev-team/qa-specialist-template.md`
- `agent-os/templates/agents/dev-team/po-template.md`
- `agent-os/templates/agents/dev-team/documenter-template.md`
- `agent-os/templates/agents/dev-team/architect-template.md`

**1.2 Agent-Templates erweitern**

Füge "Context-Hints" hinzu, die dem Orchestrator helfen:

```markdown
## Context Requirements

When delegating tasks to this agent, include:
- Relevant patterns from: logic-implementing, persistence-adapter
- Tech-stack specific conventions
- Project-specific learnings from this agent's history

The agent will work with the provided context, not pre-loaded skills.
```

### Phase 2: build-development-team Workflow anpassen

**2.1 Skill-Generation entfernen**

Step 6 (Generate Skills) wird vereinfacht:
- Skills werden NICHT mehr in `.claude/skills/` generiert
- Skill-Templates bleiben als Referenz in `~/.agent-os/templates/skills/`

**2.2 Step 7 (Assign Skills) entfernen**

Keine Skill-Zuweisung mehr nötig.

**2.3 Neuer Step: Skill-Referenz-Dokumentation**

Erstellt stattdessen eine Referenz-Datei:

```markdown
# agent-os/team/skill-reference.md

## Verfügbare Skill-Templates

Für Orchestrator-Nutzung bei Task-Delegation.

### Backend Development
- ~/.agent-os/templates/skills/dev-team/backend/logic-implementing/SKILL.md
- ~/.agent-os/templates/skills/dev-team/backend/persistence-adapter/SKILL.md
- ...

### Frontend Development
- ~/.agent-os/templates/skills/dev-team/frontend/ui-component-architecture/SKILL.md
- ...
```

### Phase 3: execute-tasks Workflow anpassen

**3.1 Skill-Extraction vor Delegation**

Bevor ein Task an einen Sub-Agent delegiert wird:

```markdown
<skill_extraction>
  1. ANALYZE story:
     - Type: Backend/Frontend/DevOps/etc.
     - Technologies: Rails, React, etc.
     - Patterns needed: Service Object, Repository, etc.

  2. LOAD relevant skills (on-demand):
     - READ ~/.agent-os/templates/skills/dev-team/[role]/[skill]/SKILL.md
     - EXTRACT only sections matching the task

  3. BUILD task prompt:
     - Story description
     - Extracted patterns (50-150 lines max)
     - Project-specific context
     - Quality requirements from DoD
</skill_extraction>
```

**3.2 Task-Prompt Template**

```markdown
## Task: [STORY_TITLE]

### Story Requirements
[ORIGINAL_STORY_CONTENT]

### Relevant Patterns
<!-- Extracted from skills by Orchestrator -->
[EXTRACTED_PATTERNS]

### Project Context
- Tech Stack: [FROM_TECH_STACK_MD]
- Conventions: [FROM_ARCHITECTURE_DECISION]

### Quality Requirements
[FROM_DOD]

### Files to Modify
[FROM_STORY_WO_FIELD]
```

### Phase 4: Skill-Templates optimieren

**4.1 Skill-Struktur anpassen**

Skills bekommen neue Abschnitte für einfachere Extraktion:

```markdown
# [SKILL_NAME]

## Quick Reference (für Extraktion)
<!-- 20-50 Zeilen mit den wichtigsten Patterns -->

## Detailed Patterns (bei Bedarf)
<!-- Vollständige Dokumentation -->

## Examples (optional)
<!-- Code-Beispiele -->
```

**4.2 Extraktions-Markierungen**

```markdown
<!-- EXTRACT:START:service-object -->
### Service Object Pattern
[Kompakte Beschreibung und Beispiel]
<!-- EXTRACT:END:service-object -->
```

### Phase 5: Migration für bestehende Projekte

**5.1 Migration-Script erstellen**

Neues Script: `migrate-devteam-v2.sh`

```bash
#!/bin/bash
# Migration von DevTeam v1 (mit Skills) zu v2 (ohne Skills)

echo "🔄 DevTeam Migration v1 → v2"

# 1. Backup erstellen
echo "Creating backup..."
cp -r .claude/agents/dev-team .claude/agents/dev-team.backup

# 2. Skills-Ordner archivieren (nicht löschen)
if [[ -d ".claude/skills" ]]; then
  echo "Archiving skills..."
  mv .claude/skills .claude/skills.v1-archive
fi

# 3. Agent-Dateien aktualisieren
echo "Updating agent files..."
for agent in .claude/agents/dev-team/*.md; do
  # Entferne skills: Zeile aus YAML frontmatter
  sed -i '' '/^skills:/d' "$agent"
  # Entferne [SKILLS_LIST] Platzhalter
  sed -i '' 's/\[SKILLS_LIST\]/Skills werden vom Orchestrator bereitgestellt/g' "$agent"
done

# 4. Skill-Referenz erstellen
echo "Creating skill reference..."
mkdir -p agent-os/team
cat > agent-os/team/skill-reference.md << 'EOF'
# Skill Reference

Skills werden vom Orchestrator on-demand geladen und als Context
an Sub-Agents übergeben.

## Verfügbare Skills

Siehe: ~/.agent-os/templates/skills/dev-team/
EOF

echo "✅ Migration complete!"
echo ""
echo "Changes:"
echo "  - Agent backups: .claude/agents/dev-team.backup/"
echo "  - Old skills archived: .claude/skills.v1-archive/"
echo "  - Skill reference: agent-os/team/skill-reference.md"
```

**5.2 Migration-Command erstellen**

Neuer Slash-Command: `/migrate-devteam-v2`

### Phase 6: Setup-Scripts aktualisieren

**6.1 setup-claude-code.sh**

- Entferne Skill-Installation
- Aktualisiere Dokumentation
- Füge Migration-Hinweis für bestehende Projekte hinzu

**6.2 setup-devteam-global.sh**

- Skills bleiben global installiert (für Orchestrator-Nutzung)
- Keine Änderung nötig

**6.3 update-agent-os.sh**

- Füge Migration-Option hinzu
- Automatische Erkennung von v1-Installationen

### Phase 7: Dokumentation aktualisieren

**7.1 CLAUDE.md Template**

Aktualisiere Erklärung der Sub-Agent Nutzung:

```markdown
## Sub-Agents

Sub-Agents erhalten fokussierten Context vom Orchestrator.
Skills werden NICHT direkt geladen, sondern relevante Patterns
werden vom Orchestrator extrahiert und im Task-Prompt bereitgestellt.
```

**7.2 INSTALL.md**

Füge Migration-Sektion hinzu.

**7.3 README.md**

Aktualisiere Architecture-Diagramm.

## Betroffene Dateien

### Framework (agent-os-extended)

| Datei | Änderung |
|-------|----------|
| `agent-os/templates/agents/dev-team/*.md` | Skills-Referenzen entfernen |
| `agent-os/workflows/core/build-development-team.md` | Steps 6, 7 überarbeiten |
| `agent-os/workflows/core/execute-tasks.md` | Skill-Extraction hinzufügen |
| `setup-claude-code.sh` | Skill-Installation entfernen |
| `.claude/commands/agent-os/migrate-devteam-v2.md` | NEU |
| `agent-os/workflows/core/migrate-devteam-v2.md` | NEU |
| `migrate-devteam-v2.sh` | NEU |

### Bestehende Projekte (Migration)

| Datei | Änderung |
|-------|----------|
| `.claude/agents/dev-team/*.md` | Skills-Zeile entfernen |
| `.claude/skills/` | Archivieren |
| `agent-os/team/skill-reference.md` | NEU |

## Risiken und Mitigations

### Risiko 1: Sub-Agents verlieren Spezialisierung

**Mitigation:**
- Agent-Templates behalten Rolle und Verantwortlichkeiten
- Orchestrator gibt task-spezifische Patterns mit
- Project Learnings bleiben in Agent-Dateien

### Risiko 2: Orchestrator-Overhead

**Mitigation:**
- Skill-Extraction ist schnell (nur READ + Pattern-Matching)
- Extrahierte Patterns sind kompakt (50-150 Zeilen vs 2000+)
- Netto-Einsparung ist positiv

### Risiko 3: Migration-Fehler bei bestehenden Projekten

**Mitigation:**
- Automatisches Backup vor Migration
- Skills werden archiviert, nicht gelöscht
- Rollback möglich

## Execution Order

1. **Phase 1**: Agent-Templates anpassen (Breaking Change)
2. **Phase 5**: Migration-Script erstellen
3. **Phase 2**: build-development-team anpassen
4. **Phase 3**: execute-tasks anpassen
5. **Phase 4**: Skill-Templates optimieren (optional)
6. **Phase 6**: Setup-Scripts aktualisieren
7. **Phase 7**: Dokumentation

## Success Metrics

- [ ] Agent-Templates haben keine `skills:` Deklaration
- [ ] build-development-team generiert keine Skills in `.claude/skills/`
- [ ] execute-tasks extrahiert Patterns on-demand
- [ ] Migration-Script funktioniert für bestehende Projekte
- [ ] Dokumentation aktualisiert
- [ ] Context-Verbrauch pro Task reduziert (messbar)

## Design Decisions (Confirmed)

1. **Komplett ohne Skills für Sub-Agents** - Orchestrator gibt alles task-spezifisch mit
2. **Manuelle Migration** - Via `/migrate-devteam-v2` Command, nicht automatisch
3. **Skill-Templates bleiben global** - Als Wissensbasis für Orchestrator-Extraktion
