# Implementation Plan: Agent OS Extended Redesign

> Spec ID: 2026-01-03-system-redesign
> Status: ✅ COMPLETED
> Created: 2026-01-03
> Completed: 2026-01-03
> Related: feedback-redesign.md, COMPLETION-REPORT.md

---

## 1. Gap-Analyse: IST vs. SOLL

### 1.1 Command: `validate-market`

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Pflicht-Outputs** | 8 Dokumente (alle erstellt) | 3 Pflicht + 5 Optional | Logik ändern |
| **User-Review-Gates** | Keine expliziten Gates | 2 Gates (product-brief, market-position) | NEU |
| **Idee schärfen** | Step 5 (product-strategist) | Interaktiv bis Template vollständig | Prozess erweitern |
| **Design-System** | Step 9 (design-token-extractor) | Nur bei Landingpage-Option | Conditional machen |
| **Templates** | Keine separaten Templates | Templates für alle Outputs | NEU erstellen |
| **Installation** | Projekt-lokal | Global + Override | Setup-Script anpassen |

### 1.2 Command: `plan-product`

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Output: mission.md** | Existiert | Ersetzen durch `product-brief.md` | UMBENENNEN |
| **Output: mission-lite.md** | Existiert | Ersetzen durch `product-brief-lite.md` | UMBENENNEN |
| **Output: tech-stack.md** | Existiert | KI-Empfehlung + User-Anpassung | Interaktivität hinzufügen |
| **Output: roadmap.md** | Existiert | KI-Vorschlag + User-Anpassung | Interaktivität hinzufügen |
| **Output: decisions.md** | Existiert | Ersetzen durch `architecture-decision.md` | UMBENENNEN + erweitern |
| **Output: boilerplate/** | FEHLT | Ordnerstruktur + Demo-Modul | NEU erstellen |
| **Output: architecture-structure.md** | FEHLT | Beschreibung der Struktur | NEU erstellen |
| **product-brief Wiederverwendung** | Nicht implementiert | Falls vorhanden, überspringen | Conditional Logic |
| **Installation** | Projekt-lokal | Global + Override | Setup-Script anpassen |

### 1.3 Command: `analyze-product`

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Codebase-Analyse** | Vorhanden (Step 1) | Erweitern für Architektur-Erkennung | Verbessern |
| **Output: architecture-decision.md** | FEHLT | Architektur aus Code ableiten | NEU |
| **Output: boilerplate/** | FEHLT | Für zukünftige Features | NEU |
| **Refactoring-Entscheidung** | FEHLT | Analyse ob Refactoring sinnvoll | NEU |
| **Phase 0 in Roadmap** | Vorhanden (Step 4) | Beibehalten | OK |

### 1.4 Command: `validate-market-for-existing` (NEU)

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Workflow** | EXISTIERT NICHT | Nachträgliche Marktvalidierung | KOMPLETT NEU |
| **Outputs** | - | product-brief (optional), competitor-analysis, market-position | NEU |

### 1.5 Command: `build-development-team` (NEU)

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Workflow** | EXISTIERT NICHT | Team-Aufbau mit Agents/Skills | KOMPLETT NEU |
| **Architecture Agent** | FEHLT | Basierend auf Template | NEU |
| **Definition of Done** | FEHLT | Template-basiert | NEU |
| **Definition of Ready** | FEHLT | Template-basiert | NEU |
| **Mehrfach-Agents** | FEHLT | Frontend/Backend mehrfach möglich | NEU |

### 1.6 Skills-System

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Architect Skills (5)** | FEHLEN | pattern-enforcer, api-designer, data-modeler, security-guardian, dependency-checker | NEU |
| **Backend Skills (4)** | Teilweise (1: api-patterns) | logic-implementer, persistence-adapter, integration-adapter, test-engineer | 3 NEU |
| **Frontend Skills (4)** | Teilweise (3: react/angular) | ui-component-architect, state-manager, api-bridge-builder, interaction-designer | Umbenennen/Erweitern |
| **DevOps Skills (4)** | Teilweise (1: devops-patterns) | infrastructure-provisioner, pipeline-engineer, observability-expert, security-hardener | 3 NEU |
| **PO Skills (4)** | FEHLEN | backlog-strategist, requirements-engineer, acceptance-tester, data-analyst | NEU |
| **Global Skills (4)** | Teilweise (1: git-workflow) | git-master, changelog-manager, documentation-architect, security-vulnerability-scanner | 3 NEU |
| **MCP-Server Integration** | Nur design-system-extractor | Template-Sektion für alle Skills | Template erweitern |

### 1.7 Agents

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **Architecture Agent** | FEHLT | Mit 5 Architect Skills | NEU |
| **PO Agent** | FEHLT | Mit 4 PO Skills | NEU |
| **UX Agent** | FEHLT | Optional im Team-Builder | NEU (optional) |
| **Agent Templates** | 4 vorhanden (backend, frontend, devops, qa) | Alle 5 Rollen | 1 NEU (Architecture) |

### 1.8 Templates

| Aspekt | IST-Zustand | SOLL-Zustand | Gap |
|--------|-------------|--------------|-----|
| **product-brief.md** | FEHLT | Einheitliches Template | NEU |
| **competitor-analysis.md** | FEHLT | Einheitliches Template | NEU |
| **market-position.md** | FEHLT | Einheitliches Template | NEU |
| **architecture-decision.md** | FEHLT | Einheitliches Template | NEU |
| **architecture-structure.md** | FEHLT | Einheitliches Template | NEU |
| **design-system.md** | FEHLT | Einheitliches Template | NEU |
| **definition-of-done.md** | FEHLT | Einheitliches Template | NEU |
| **definition-of-ready.md** | FEHLT | Einheitliches Template | NEU |
| **Skill Template mit MCP** | FEHLT | Template mit MCP-Sektion | NEU |

---

## 2. Änderungsplan

### Phase 1: Foundation (Templates & Grundstruktur)
**Priorität: HOCH | Geschätzter Aufwand: M**

#### 1.1 Dokument-Templates erstellen
```
agent-os/templates/documents/
├── product-brief.md
├── product-brief-lite.md
├── competitor-analysis.md
├── market-position.md
├── tech-stack.md
├── roadmap.md
├── architecture-decision.md
├── architecture-structure.md
├── design-system.md
├── definition-of-done.md
└── definition-of-ready.md
```

**Tasks:**
- [ ] Template-Verzeichnis erstellen
- [ ] product-brief.md Template (basierend auf mission.md Struktur)
- [ ] competitor-analysis.md Template
- [ ] market-position.md Template
- [ ] architecture-decision.md Template
- [ ] architecture-structure.md Template
- [ ] design-system.md Template
- [ ] definition-of-done.md Template
- [ ] definition-of-ready.md Template

#### 1.2 Skill-Template mit MCP-Sektion
```yaml
---
name: skill-name
description: Skill description
globs: ["**/*.ext"]
alwaysApply: false
version: 1.0
---

# Skill Name

## Trigger Conditions
- file_extension: .ext
- task_mentions: "keyword1|keyword2"
- file_contains: "pattern1|pattern2"

## MCP Server Integration
- **Server**: server-name
- **Tools Used**: tool1, tool2
- **Configuration**:
  ```json
  { "setting": "value" }
  ```

## Core Competencies
...

## Best Practices
...

## Anti-Patterns
...

## Examples
...
```

---

### Phase 2: Workflow-Refactoring
**Priorität: HOCH | Geschätzter Aufwand: L**

#### 2.1 validate-market.md überarbeiten

**Strukturänderungen:**
```
VORHER (18 Steps, alle Outputs):
Step 1-5: Vorbereitung + product-brief
Step 6-10: Competitive Analysis + Landingpage
Step 11-18: Campaigns + Results

NACHHER (mit User-Review-Gates):
Step 1-2: Idee eingeben
Step 3: Idee schärfen (interaktiv)
Step 4: ⏸️ USER-REVIEW: product-brief.md
Step 5-6: Competitive Analysis + Market Position
Step 7: ⏸️ USER-REVIEW: market-position.md
Step 8: [OPTIONAL] User-Entscheidung: Landingpage?
  Step 8a: Design-Token-Extractor
  Step 8b: Landingpage erstellen
Step 9-12: [OPTIONAL] Campaigns + Analytics
Step 13-16: [OPTIONAL] Results + GO/NO-GO
```

**Tasks:**
- [ ] User-Review-Gate nach product-brief hinzufügen
- [ ] User-Review-Gate nach market-position hinzufügen
- [ ] Optional-Block für Landingpage + Marketing
- [ ] Idee-Schärfung interaktiver machen
- [ ] Templates referenzieren statt inline

#### 2.2 plan-product.md überarbeiten

**Strukturänderungen:**
```
VORHER:
- mission.md
- mission-lite.md
- tech-stack.md
- roadmap.md
- decisions.md

NACHHER:
- product-brief.md (Check: existiert bereits?)
- product-brief-lite.md
- tech-stack.md (KI-Empfehlung + User-Review)
- roadmap.md (KI-Vorschlag + User-Review)
- architecture-decision.md (KI-Vorschlag + User-Bestätigung)
- boilerplate/ (Ordnerstruktur generieren)
- architecture-structure.md
```

**Tasks:**
- [ ] Rename mission.md → product-brief.md
- [ ] Rename mission-lite.md → product-brief-lite.md
- [ ] Rename decisions.md → architecture-decision.md
- [ ] Conditional: product-brief.md überspringen wenn vorhanden
- [ ] User-Review für tech-stack hinzufügen
- [ ] User-Review für roadmap hinzufügen
- [ ] User-Bestätigung für architecture-decision hinzufügen
- [ ] Boilerplate-Generierung implementieren
- [ ] architecture-structure.md Generierung implementieren

#### 2.3 analyze-product.md überarbeiten

**Tasks:**
- [ ] Architektur-Erkennung aus Codebase
- [ ] architecture-decision.md Generierung
- [ ] boilerplate/ Generierung für zukünftige Features
- [ ] Refactoring-Analyse implementieren

#### 2.4 validate-market-for-existing.md (NEU)

**Tasks:**
- [ ] Workflow-Datei erstellen
- [ ] Basierend auf validate-market, aber für bestehende Projekte
- [ ] product-brief.md nur erstellen wenn nicht vorhanden
- [ ] Fokus auf competitor-analysis + market-position

#### 2.5 build-development-team.md (NEU)

**Tasks:**
- [ ] Workflow-Datei erstellen
- [ ] tech-stack.md Analyse
- [ ] Architecture Agent hinzufügen
- [ ] AskUserQuestion für Agent-Auswahl
- [ ] Mehrfach-Instanziierung ermöglichen
- [ ] Definition of Done erstellen
- [ ] Definition of Ready erstellen

---

### Phase 3: Skills-Erweiterung
**Priorität: MITTEL | Geschätzter Aufwand: XL**

#### 3.1 Architect Skills (5 NEU)

```
agent-os/skills/architect/
├── architect-pattern-enforcer.md
├── architect-api-designer.md
├── architect-data-modeler.md
├── architect-security-guardian.md
└── architect-dependency-checker.md
```

**Tasks:**
- [ ] architect-pattern-enforcer.md (Hexagonal, DDD, Clean Architecture)
- [ ] architect-api-designer.md (OpenAPI, REST, JSON-Schemas)
- [ ] architect-data-modeler.md (SQL, ER-Diagramme, Migrations)
- [ ] architect-security-guardian.md (OAuth2, OWASP, RBAC)
- [ ] architect-dependency-checker.md (DI, IoC, Import-Analyse)

#### 3.2 Backend Skills (3 NEU, 1 erweitern)

```
agent-os/skills/backend/
├── logic-implementer.md (NEU)
├── persistence-adapter.md (NEU)
├── integration-adapter.md (NEU)
└── test-engineer.md (erweitern aus testing-best-practices)
```

**Tasks:**
- [ ] logic-implementer.md (Business Logic, Validierung)
- [ ] persistence-adapter.md (SQL, NoSQL, ORM)
- [ ] integration-adapter.md (HTTP, Webhooks, Message Queues)
- [ ] test-engineer.md erweitern (TDD-fokussiert)

#### 3.3 Frontend Skills (Umbenennen/Erweitern)

```
agent-os/skills/frontend/
├── ui-component-architect.md (aus react-component-patterns)
├── state-manager.md (NEU)
├── api-bridge-builder.md (NEU)
└── interaction-designer.md (NEU)
```

**Tasks:**
- [ ] Bestehende React/Angular Skills als Basis
- [ ] ui-component-architect.md (Framework-agnostisch)
- [ ] state-manager.md (React Context, Redux, Zustand)
- [ ] api-bridge-builder.md (Axios, Fetch, OpenAPI-Client)
- [ ] interaction-designer.md (Forms, Animations, Routing)

#### 3.4 DevOps Skills (3 NEU)

```
agent-os/skills/devops/
├── infrastructure-provisioner.md (NEU)
├── pipeline-engineer.md (aus devops-patterns)
├── observability-expert.md (NEU)
└── security-hardener.md (NEU)
```

**Tasks:**
- [ ] infrastructure-provisioner.md (Terraform, CloudFormation)
- [ ] pipeline-engineer.md erweitern (GitHub Actions, Docker)
- [ ] observability-expert.md (Prometheus, Grafana, ELK)
- [ ] security-hardener.md (IAM, TLS, Secrets)

#### 3.5 PO Skills (4 NEU)

```
agent-os/skills/po/
├── backlog-strategist.md
├── requirements-engineer.md
├── acceptance-tester.md
└── data-analyst.md
```

**Tasks:**
- [ ] backlog-strategist.md (ROI, Priorisierung, Roadmap)
- [ ] requirements-engineer.md (User Stories, INVEST)
- [ ] acceptance-tester.md (UAT, Feedback-Loop)
- [ ] data-analyst.md (A/B-Testing, Metriken)

#### 3.6 Globale Skills (3 NEU)

```
agent-os/skills/global/
├── git-master.md (erweitern aus git-workflow-patterns)
├── changelog-manager.md (NEU)
├── documentation-architect.md (NEU)
└── security-vulnerability-scanner.md (NEU)
```

**Tasks:**
- [ ] git-master.md erweitern (Conventional Commits, PRs)
- [ ] changelog-manager.md (CHANGELOG.md automatisch)
- [ ] documentation-architect.md (README, API-Docs, ADRs)
- [ ] security-vulnerability-scanner.md (Keys, Libraries, CVEs)

---

### Phase 4: Agents-Erweiterung
**Priorität: MITTEL | Geschätzter Aufwand: M**

#### 4.1 Architecture Agent (NEU)

```
.claude/agents/architecture-agent.md
```

**Tasks:**
- [ ] Agent-Template erstellen
- [ ] 5 Architect Skills referenzieren
- [ ] Trigger-Bedingungen definieren

#### 4.2 PO Agent (NEU)

```
.claude/agents/po-agent.md
```

**Tasks:**
- [ ] Agent-Template erstellen
- [ ] 4 PO Skills referenzieren
- [ ] Trigger-Bedingungen definieren

#### 4.3 Agent-Templates erweitern

**Tasks:**
- [ ] architecture-agent-template.md
- [ ] po-agent-template.md
- [ ] Bestehende Templates aktualisieren (Skills-Referenzen)

---

### Phase 5: Setup-Scripts & Installation
**Priorität: NIEDRIG | Geschätzter Aufwand: S**

#### 5.1 Globale Installation

**Tasks:**
- [ ] setup-market-validation-global.sh aktualisieren
- [ ] setup-plan-product-global.sh erstellen
- [ ] Symlink-Strategie für Templates

#### 5.2 Projekt-Override

**Tasks:**
- [ ] Override-Mechanismus dokumentieren
- [ ] Projekt-spezifische Template-Erkennung

---

## 3. Priorisierte Reihenfolge

### Sprint 1: Foundation
1. Dokument-Templates erstellen (alle 11)
2. Skill-Template mit MCP-Sektion
3. validate-market.md User-Review-Gates

### Sprint 2: Core Workflows
4. plan-product.md Refactoring (Rename + Conditional)
5. analyze-product.md Erweiterung
6. validate-market-for-existing.md (NEU)

### Sprint 3: Team Building
7. build-development-team.md (NEU)
8. Architecture Agent (NEU)
9. PO Agent (NEU)
10. Definition of Done/Ready Templates

### Sprint 4: Skills
11. Architect Skills (5)
12. PO Skills (4)
13. Globale Skills (3)
14. Backend/Frontend/DevOps Skills erweitern

### Sprint 5: Polish
15. Setup-Scripts
16. Dokumentation
17. Testing

---

## 4. Risiken & Abhängigkeiten

### Risiken
| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| Breaking Changes in Workflows | Hoch | Hoch | Versionierung, Backward Compatibility |
| Template-Inkonsistenz | Mittel | Mittel | Style Guide für Templates |
| Skill-Überladung | Mittel | Niedrig | Klare Trigger-Bedingungen |

### Abhängigkeiten
```
Templates (Phase 1)
    ↓
Workflows (Phase 2) ← benötigt Templates
    ↓
Skills (Phase 3) ← benötigt Workflow-Kontext
    ↓
Agents (Phase 4) ← benötigt Skills
    ↓
Setup (Phase 5) ← benötigt alles
```

---

## 5. Zusammenfassung

| Phase | Items | Aufwand | Priorität |
|-------|-------|---------|-----------|
| 1: Foundation | 12 Templates | M | HOCH |
| 2: Workflows | 5 Workflows | L | HOCH |
| 3: Skills | 18 Skills | XL | MITTEL |
| 4: Agents | 2 Agents + Templates | M | MITTEL |
| 5: Setup | Scripts + Docs | S | NIEDRIG |

**Gesamt:** ~37 neue/überarbeitete Dateien

---

## 6. Nächste Schritte

1. **Sofort:** Feedback-Review mit Stakeholder
2. **Dann:** Phase 1 starten (Templates)
3. **Parallel:** Bestehende Workflows weiter nutzbar halten

---

*Dieser Plan ist ein lebendes Dokument und wird bei Bedarf aktualisiert.*
