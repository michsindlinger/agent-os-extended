# DevTeam Skill-Loading Refactoring

> Created: 2026-01-17
> Completed: 2026-01-17
> Status: Complete
> Type: Architecture Refactoring

## Completion Summary

All 8 phases have been implemented:

| Phase | Description | Commit |
|-------|-------------|--------|
| Phase 1 | Remove skills from agent templates | `9eacc23` |
| Phase 2 | Update build-development-team workflow to v2.0 | `cbbca60` |
| Phase 3 | Add skill selection to create-spec v2.4 | `ec8f2a8` |
| Phase 4 | Add skill extraction to execute-tasks v2.2 | `8df29d4` |
| Phase 5 | Create skill-index template + Quick Reference | `d1198a9` |
| Phase 6 | Update setup scripts | `c02ba9a` |
| Phase 7 | Create /migrate-devteam-v2 command | `8e81df4` |
| Phase 8 | Documentation (this update) | current |

---

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

### Konzept: "Skill-Index + Architect-Selektion + Orchestrator-Extraktion"

```
┌─────────────────────────────────────────────────────────────────────────┐
│ Phase 1: build-development-team                                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  Generiert:                                                             │
│  ├── agent-os/skills/backend-logic-implementing.md (projekt-spezifisch) │
│  ├── agent-os/skills/backend-persistence-adapter.md                     │
│  ├── agent-os/skills/frontend-ui-component.md                           │
│  └── ...                                                                │
│                                                                         │
│  Generiert auch:                                                        │
│  └── agent-os/team/skill-index.md (Übersicht aller Skills + Trigger)    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│ Phase 2: create-spec (Architect beim Technical Refinement)              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  1. Architect LIEST skill-index.md                                      │
│  2. Pro Story: Wählt relevante Skills aus dem Index                     │
│  3. Trägt in Story ein:                                                 │
│                                                                         │
│     ### Relevante Skills                                                │
│     - backend-logic-implementing (Service Object Pattern)               │
│     - backend-test-engineering (Unit Tests)                             │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│ Phase 3: execute-tasks (Orchestrator)                                   │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  1. Liest Story → Findet "Relevante Skills" Sektion                     │
│  2. Liest NUR die angegebenen Skill-Dateien                             │
│  3. Extrahiert relevante Patterns (Quick Reference Sektion)             │
│  4. Baut Task-Prompt mit extrahierten Patterns                          │
│  5. Delegiert an Sub-Agent (der KEINE skills: Deklaration hat)          │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### Vorteile

- **Effizienz**: Nur relevante Infos werden übergeben
- **Projekt-spezifisch**: Skills werden weiterhin generiert mit echtem Tech-Stack
- **Klare Verantwortung**: Architect wählt, Orchestrator extrahiert
- **Kein Suchen**: Orchestrator weiß exakt welche Skills zu lesen sind
- **Kosteneinsparung**: Drastisch weniger Tokens pro Task

## Implementation Plan

### Phase 1: Agent-Templates anpassen

**1.1 Skills-Deklaration entfernen**

Entferne `skills:` aus YAML frontmatter:

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

Füge Hinweis hinzu:

```markdown
## Skill-Context

Dieser Agent erhält task-spezifische Patterns vom Orchestrator.
Skills werden NICHT automatisch geladen, sondern:
1. Architect wählt relevante Skills pro Story (aus skill-index.md)
2. Orchestrator extrahiert Patterns und übergibt sie im Task-Prompt

Siehe: agent-os/team/skill-index.md
```

### Phase 2: build-development-team Workflow anpassen

**2.1 Skills weiterhin generieren**

Skills werden weiterhin generiert, aber in `agent-os/skills/` (nicht `.claude/skills/`):

```
agent-os/skills/
├── backend-logic-implementing.md
├── backend-persistence-adapter.md
├── backend-integration-adapter.md
├── backend-test-engineering.md
├── frontend-ui-component.md
├── frontend-state-management.md
├── frontend-api-bridge.md
├── frontend-interaction-design.md
├── devops-infrastructure.md
├── devops-pipeline.md
├── qa-test-strategy.md
├── qa-test-automation.md
├── architect-pattern-enforcement.md
├── architect-api-design.md
└── ...
```

**2.2 NEUER Step: Skill-Index generieren**

Nach der Skill-Generierung wird `agent-os/team/skill-index.md` erstellt:

```markdown
# Skill Index

> Generated: [TIMESTAMP]
> Project: [PROJECT_NAME]
> Tech Stack: [TECH_STACK_SUMMARY]

## Verwendung

1. **Architect** (create-spec): Wählt relevante Skills pro Story aus diesem Index
2. **Orchestrator** (execute-tasks): Liest die vom Architect angegebenen Skills

## Backend Skills

| Skill | Pfad | Trigger-Keywords | Beschreibung |
|-------|------|------------------|--------------|
| logic-implementing | agent-os/skills/backend-logic-implementing.md | service, business logic, domain, use case, validation, workflow | Service Objects, Domain Logic, Validation |
| persistence-adapter | agent-os/skills/backend-persistence-adapter.md | database, query, migration, model, repository, ActiveRecord, SQL | Database Access, Queries, Migrations |
| integration-adapter | agent-os/skills/backend-integration-adapter.md | API call, external service, webhook, HTTP client, integration | External API Integration |
| test-engineering | agent-os/skills/backend-test-engineering.md | test, spec, RSpec, unit test, fixture, mock, factory | Backend Testing Patterns |

## Frontend Skills

| Skill | Pfad | Trigger-Keywords | Beschreibung |
|-------|------|------------------|--------------|
| ui-component | agent-os/skills/frontend-ui-component.md | component, view, layout, render, JSX, template | Component Architecture |
| state-management | agent-os/skills/frontend-state-management.md | state, store, context, reducer, hook, zustand | State Management Patterns |
| api-bridge | agent-os/skills/frontend-api-bridge.md | fetch, API client, axios, data fetching, SWR | API Integration |
| interaction-design | agent-os/skills/frontend-interaction-design.md | form, input, validation, UX, user interaction | User Interaction Patterns |

## DevOps Skills

| Skill | Pfad | Trigger-Keywords | Beschreibung |
|-------|------|------------------|--------------|
| infrastructure | agent-os/skills/devops-infrastructure.md | deploy, server, Docker, Kubernetes, infrastructure | Infrastructure Setup |
| pipeline | agent-os/skills/devops-pipeline.md | CI/CD, GitHub Actions, pipeline, automation | CI/CD Pipelines |

## QA Skills

| Skill | Pfad | Trigger-Keywords | Beschreibung |
|-------|------|------------------|--------------|
| test-strategy | agent-os/skills/qa-test-strategy.md | test plan, coverage, quality gates | Test Strategy |
| test-automation | agent-os/skills/qa-test-automation.md | E2E, Playwright, integration test, automation | Test Automation |

## Architect Skills

| Skill | Pfad | Trigger-Keywords | Beschreibung |
|-------|------|------------------|--------------|
| pattern-enforcement | agent-os/skills/architect-pattern-enforcement.md | architecture, pattern, structure, design | Architecture Patterns |
| api-design | agent-os/skills/architect-api-design.md | API design, endpoint, REST, GraphQL | API Design |

---

## Beispiel: Skill-Auswahl für eine Story

Story: "Implement User Registration Service"

**Relevante Skills (vom Architect auszuwählen):**
- backend-logic-implementing (Service Object für Registration)
- backend-persistence-adapter (User Model speichern)
- backend-test-engineering (Unit Tests für Service)
```

**2.3 Step 7 (Assign Skills to Agents) ENTFERNEN**

Keine Skill-Zuweisung an Agents mehr nötig.

### Phase 3: create-spec Workflow anpassen

**3.1 Architect erhält Zugriff auf Skill-Index**

Im Architect-Prompt (Step 3) hinzufügen:

```markdown
LOAD: agent-os/team/skill-index.md

FOR EACH story:
  ANALYZE: Story content (WAS, fachliche Beschreibung)
  MATCH: Keywords gegen skill-index.md Trigger-Keywords
  SELECT: 1-3 relevante Skills

  ADD to story:
    ### Relevante Skills
    - [skill-name] ([warum relevant])
    - [skill-name] ([warum relevant])
```

**3.2 Story-Template erweitern**

Neue Sektion in `story-template.md`:

```markdown
### Relevante Skills
<!-- Vom Architect ausgefüllt basierend auf skill-index.md -->
- [SKILL_1] ([REASON])
- [SKILL_2] ([REASON])

**Skill-Referenz:** agent-os/team/skill-index.md
```

### Phase 4: execute-tasks Workflow anpassen

**4.1 Skill-Reading vor Delegation**

```markdown
<skill_reading>
  1. READ story file

  2. FIND section "### Relevante Skills"
     EXTRACT: List of skill names

     IF section not found OR empty:
       FALLBACK: Use skill-index.md to match based on story type (WER field)
       - Backend story → backend-logic-implementing
       - Frontend story → frontend-ui-component
       - etc.

  3. FOR EACH selected skill:
     READ: agent-os/skills/[skill-name].md
     EXTRACT: "## Quick Reference" section (50-100 lines)

     IF "Quick Reference" not found:
       EXTRACT: First 100 lines of skill

  4. BUILD task prompt:
     - Story description
     - Extracted skill patterns
     - Project context (tech-stack.md)
     - Quality requirements (dod.md)
</skill_reading>
```

**4.2 Task-Prompt Template**

```markdown
## Task: [STORY_TITLE]

### Story Requirements
[ORIGINAL_STORY_CONTENT - ohne "Relevante Skills" Sektion]

### Patterns & Guidelines
<!-- Extrahiert aus den relevanten Skills -->

#### [SKILL_1_NAME]
[EXTRACTED_QUICK_REFERENCE_1]

#### [SKILL_2_NAME]
[EXTRACTED_QUICK_REFERENCE_2]

### Project Context
- Tech Stack: [FROM_TECH_STACK_MD]
- Architecture: [FROM_ARCHITECTURE_DECISION_MD]

### Quality Requirements
[FROM_DOD_MD]

### Files to Modify
[FROM_STORY_WO_FIELD]
```

### Phase 5: Skill-Templates optimieren

**5.1 Quick Reference Sektion hinzufügen**

Jedes Skill bekommt eine kompakte Zusammenfassung am Anfang:

```markdown
# Backend Logic Implementing

## Quick Reference
<!-- Diese Sektion wird vom Orchestrator extrahiert -->

**Wann nutzen:** Service Objects, Business Logic, Domain Operations

**Kern-Patterns:**
1. **Service Object:** Eine Klasse pro Use Case
   - Methode `call` als Einstiegspunkt
   - Dependency Injection für Abhängigkeiten
   - Result Object für Rückgabe

2. **Validation:** Am Anfang der `call` Methode
   - Fail fast bei ungültigen Inputs
   - Aussagekräftige Fehlermeldungen

3. **Error Handling:**
   - Custom Exceptions für Business Errors
   - Transaction Rollback bei Fehlern

**Beispiel (Rails):**
```ruby
class Users::Register
  def initialize(user_repo: UserRepository.new)
    @user_repo = user_repo
  end

  def call(params)
    validate!(params)
    user = @user_repo.create(params)
    Result.success(user: user)
  rescue ValidationError => e
    Result.failure(errors: e.messages)
  end
end
```

---

## Detailed Patterns
[... Rest des Skills ...]
```

**5.2 Alle Skills aktualisieren**

- `agent-os/templates/skills/dev-team/backend/*.md`
- `agent-os/templates/skills/dev-team/frontend/*.md`
- `agent-os/templates/skills/dev-team/devops/*.md`
- `agent-os/templates/skills/dev-team/qa/*.md`
- `agent-os/templates/skills/dev-team/architect/*.md`

### Phase 6: Migration für bestehende Projekte

**6.1 Migration-Script: `migrate-devteam-v2.sh`**

```bash
#!/bin/bash
# Migration von DevTeam v1 (Skills in .claude/skills/) zu v2 (Skills in agent-os/skills/)

set -e

echo "🔄 DevTeam Migration v1 → v2"
echo ""

# Check if migration needed
if [[ ! -d ".claude/skills" ]] && [[ -f "agent-os/team/skill-index.md" ]]; then
  echo "✓ Already on v2 or fresh install. No migration needed."
  exit 0
fi

# 1. Backup erstellen
echo "1. Creating backups..."
if [[ -d ".claude/agents/dev-team" ]]; then
  cp -r .claude/agents/dev-team .claude/agents/dev-team.v1-backup
  echo "   ✓ Agent backup: .claude/agents/dev-team.v1-backup/"
fi

# 2. Skills von .claude/skills/ nach agent-os/skills/ migrieren
echo "2. Migrating skills..."
mkdir -p agent-os/skills

if [[ -d ".claude/skills" ]]; then
  # Kopiere alle Skill-Dateien
  for skill_dir in .claude/skills/*/; do
    if [[ -f "${skill_dir}SKILL.md" ]]; then
      skill_name=$(basename "$skill_dir")
      # Extrahiere den Skill-Typ aus dem Namen (z.B. "myproject-backend-logic-implementing" → "backend-logic-implementing")
      clean_name=$(echo "$skill_name" | sed 's/^[^-]*-//')
      cp "${skill_dir}SKILL.md" "agent-os/skills/${clean_name}.md"
      echo "   ✓ Migrated: $clean_name"
    fi
  done

  # Archiviere alte Skills
  mv .claude/skills .claude/skills.v1-archive
  echo "   ✓ Old skills archived: .claude/skills.v1-archive/"
fi

# 3. Agent-Dateien aktualisieren
echo "3. Updating agent files..."
for agent in .claude/agents/dev-team/*.md; do
  if [[ -f "$agent" ]]; then
    # Entferne skills: Zeile aus YAML frontmatter
    if grep -q "^skills:" "$agent"; then
      sed -i '' '/^skills:/d' "$agent"
      echo "   ✓ Removed skills: from $(basename $agent)"
    fi
  fi
done

# 4. Skill-Index generieren
echo "4. Generating skill-index.md..."
mkdir -p agent-os/team

cat > agent-os/team/skill-index.md << 'SKILLINDEX'
# Skill Index

> Generated: $(date +%Y-%m-%d)
> Migration: v1 → v2

## Verwendung

1. **Architect** (create-spec): Wählt relevante Skills pro Story
2. **Orchestrator** (execute-tasks): Liest die angegebenen Skills

## Verfügbare Skills

| Skill | Pfad | Beschreibung |
|-------|------|--------------|
SKILLINDEX

# Liste alle migrierten Skills
for skill in agent-os/skills/*.md; do
  if [[ -f "$skill" ]]; then
    skill_name=$(basename "$skill" .md)
    echo "| $skill_name | $skill | TODO: Add description |" >> agent-os/team/skill-index.md
  fi
done

cat >> agent-os/team/skill-index.md << 'FOOTER'

---

**Hinweis:** Bitte ergänze die Beschreibungen und Trigger-Keywords manuell
oder führe `/build-development-team` erneut aus für vollständige Generierung.
FOOTER

echo "   ✓ Created: agent-os/team/skill-index.md"

# 5. Summary
echo ""
echo "════════════════════════════════════════"
echo "✅ Migration Complete!"
echo "════════════════════════════════════════"
echo ""
echo "Changes:"
echo "  • Skills moved: .claude/skills/ → agent-os/skills/"
echo "  • Agent backups: .claude/agents/dev-team.v1-backup/"
echo "  • Old skills archived: .claude/skills.v1-archive/"
echo "  • Skill index created: agent-os/team/skill-index.md"
echo ""
echo "Next steps:"
echo "  1. Review agent-os/team/skill-index.md"
echo "  2. Add descriptions and trigger keywords"
echo "  3. Or run /build-development-team to regenerate"
echo ""
```

**6.2 Migration-Command: `/migrate-devteam-v2`**

```markdown
# Migrate DevTeam to v2

Migrate from skill-loading in sub-agents to orchestrator-based skill extraction.

**What changes:**
- Skills move from `.claude/skills/` to `agent-os/skills/`
- Agents no longer have `skills:` in YAML frontmatter
- Skill-index.md is created for Architect/Orchestrator use

**Backups created:**
- `.claude/agents/dev-team.v1-backup/`
- `.claude/skills.v1-archive/`

Refer to: @agent-os/workflows/core/migrate-devteam-v2.md
```

### Phase 7: Setup-Scripts aktualisieren

**7.1 setup-claude-code.sh**

- Agents werden weiterhin installiert (ohne skills:)
- Keine Skill-Installation in `.claude/skills/` mehr
- Hinweis auf `/build-development-team` für Skill-Generierung

**7.2 build-development-team generiert Skills in agent-os/skills/**

- Neuer Output-Pfad: `agent-os/skills/` statt `.claude/skills/`
- Generiert `agent-os/team/skill-index.md`

### Phase 8: Dokumentation aktualisieren

**8.1 CLAUDE.md Template**

```markdown
## Sub-Agents & Skills

Sub-Agents erhalten fokussierten Context vom Orchestrator.
Skills werden NICHT automatisch geladen:

1. **build-development-team** generiert Skills in `agent-os/skills/`
2. **Architect** wählt relevante Skills pro Story (aus `skill-index.md`)
3. **Orchestrator** extrahiert Patterns und übergibt sie im Task-Prompt

Skill-Index: agent-os/team/skill-index.md
```

**8.2 README.md Architecture-Diagramm**

```
┌────────────────────────────────────────────────────────────────┐
│                        Main Agent                               │
│                       (Orchestrator)                            │
│                                                                 │
│  1. Liest Story mit "Relevante Skills" Sektion                  │
│  2. Liest nur die angegebenen Skills aus agent-os/skills/       │
│  3. Extrahiert Quick Reference (50-100 Zeilen)                  │
│  4. Baut Task-Prompt mit extrahierten Patterns                  │
└──────────────────────────┬─────────────────────────────────────┘
                           │
                           ↓
┌────────────────────────────────────────────────────────────────┐
│                      Sub-Agent                                  │
│              (z.B. dev-team__backend-developer)                 │
│                                                                 │
│  - Hat KEINE skills: Deklaration                                │
│  - Erhält task-spezifische Patterns im Prompt                   │
│  - Arbeitet fokussiert mit relevantem Context                   │
└────────────────────────────────────────────────────────────────┘
```

## Betroffene Dateien

### Framework (agent-os-extended)

| Datei | Änderung |
|-------|----------|
| `agent-os/templates/agents/dev-team/*.md` | `skills:` entfernen, Hinweis hinzufügen |
| `agent-os/workflows/core/build-development-team.md` | Output → `agent-os/skills/`, skill-index.md generieren |
| `agent-os/workflows/core/create-spec.md` | Architect liest skill-index.md, trägt Skills in Story ein |
| `agent-os/workflows/core/execute-tasks.md` | Skill-Reading + Extraction vor Delegation |
| `agent-os/templates/docs/story-template.md` | "Relevante Skills" Sektion hinzufügen |
| `agent-os/templates/skills/dev-team/**/*.md` | Quick Reference Sektion hinzufügen |
| `.claude/commands/agent-os/migrate-devteam-v2.md` | NEU |
| `agent-os/workflows/core/migrate-devteam-v2.md` | NEU |
| `migrate-devteam-v2.sh` | NEU |

### Bestehende Projekte (nach Migration)

| Datei | Änderung |
|-------|----------|
| `.claude/agents/dev-team/*.md` | `skills:` Zeile entfernt |
| `.claude/skills/` | → Archiviert zu `.claude/skills.v1-archive/` |
| `agent-os/skills/*.md` | NEU (migrierte Skills) |
| `agent-os/team/skill-index.md` | NEU |

## Execution Order

1. **Phase 1**: Agent-Templates anpassen
2. **Phase 5**: Skill-Templates mit Quick Reference erweitern
3. **Phase 2**: build-development-team anpassen (Output-Pfad, skill-index.md)
4. **Phase 3**: create-spec anpassen (Architect nutzt skill-index.md)
5. **Phase 4**: execute-tasks anpassen (Skill-Reading + Extraction)
6. **Phase 6**: Migration-Script erstellen
7. **Phase 7**: Setup-Scripts aktualisieren
8. **Phase 8**: Dokumentation

## Success Metrics

- [x] Agent-Templates haben keine `skills:` Deklaration
- [x] build-development-team generiert Skills in `agent-os/skills/`
- [x] build-development-team generiert `agent-os/team/skill-index.md`
- [x] create-spec: Architect trägt "Relevante Skills" in Stories ein
- [x] execute-tasks: Orchestrator liest angegebene Skills und extrahiert Patterns
- [x] Migration-Script funktioniert für bestehende Projekte
- [x] Dokumentation aktualisiert
- [x] Context-Verbrauch pro Task reduziert (~95% reduction)

## Design Decisions (Confirmed)

1. **Komplett ohne Skills für Sub-Agents** - Orchestrator gibt alles task-spezifisch mit
2. **Skills werden weiterhin generiert** - In `agent-os/skills/` (projekt-spezifisch)
3. **Skill-Index als Lookup-Tabelle** - Architect und Orchestrator nutzen ihn
4. **Architect wählt Skills pro Story** - Trägt "Relevante Skills" Sektion ein
5. **Orchestrator extrahiert nur Quick Reference** - 50-100 Zeilen statt 600+
6. **Manuelle Migration** - Via `/migrate-devteam-v2` Command
