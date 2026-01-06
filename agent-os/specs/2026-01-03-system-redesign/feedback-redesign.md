# Agent OS Extended - Feedback & Redesign

> Spec ID: 2026-01-03-system-redesign
> Status: Draft
> Created: 2026-01-03

## 1. Command: `validate-market`

### 1.1 Ergebnisse (Output)

**Pflicht-Dokumente:**
| Dokument | Beschreibung |
|----------|--------------|
| `product-brief.md` | Geschärfte Produktdefinition |
| `competitor-analysis.md` | Wettbewerbsanalyse |
| `market-position.md` | Marktpositionierung |

**Optionale Dokumente (nach User-Freigabe):**
| Dokument | Beschreibung |
|----------|--------------|
| `landing-page/index.html` | Validierungs-Landingpage |
| `ad-campaigns.md` | Werbekampagnen-Plan |
| `analytics-setup.md` | Tracking-Setup |
| `validation-plan.md` | Validierungsplan |
| `validation-results.md` | Ergebnisse nach Kampagne |

### 1.2 Prozess-Anforderungen

**User-Review-Gates:**
```
1. User-Idee eingeben
       ↓
2. Idee "schärfen" (interaktiv bis Template-vollständig)
       ↓
3. ⏸️ USER-REVIEW: product-brief.md freigeben
       ↓
4. competitor-analysis.md + market-position.md erstellen
       ↓
5. ⏸️ USER-REVIEW: market-position.md freigeben
       ↓
6. [OPTIONAL] User entscheidet: Landingpage erstellen?
       ↓
   6a. Design-Token-Extractor (Screenshot/URL → design-system.md)
   6b. web-developer erstellt Landingpage
       ↓
7. [OPTIONAL] Restliche Dokumente erstellen
```

**Templates:**
- Für alle Ergebnis-Dokumente sollen Templates existieren
- Einheitliche Struktur über alle Durchläufe

### 1.3 Installation
- **Global** (`~/.agent-os/`) mit optionalem **Projekt-Override**

---

## 2. Command: `plan-product`

### 2.1 Ergebnisse (Output)

| Dokument | Beschreibung | Besonderheit |
|----------|--------------|--------------|
| `product-brief.md` | Produktdefinition | Ersetzt `mission.md`, gleiches Template wie validate-market |
| `product-brief-lite.md` | Kurzversion | Ersetzt `mission-lite.md` |
| `tech-stack.md` | Technologie-Stack | KI-Empfehlung, User kann anpassen |
| `roadmap.md` | Entwicklungs-Roadmap | Vorschlag auf Basis product-brief, User-Anpassung möglich |
| `architecture-decision.md` | Architektur-Entscheidung | Hexagonal, DDD, etc. - KI-Vorschlag, User bestätigt |
| `boilerplate/` | Ordnerstruktur | Auf Basis Architektur + Demo-Modul |
| `architecture-structure.md` | Strukturbeschreibung | Welche Files wohin gehören |

### 2.2 Prozess-Anforderungen

**Fallunterscheidung product-brief.md:**
```
IF product-brief.md existiert (von validate-market):
  → Verwenden ohne Neuerstellung
ELSE:
  → Gleicher Schärfungs-Prozess wie validate-market
  → User-Review-Gate vor Weiterarbeit
```

**Interaktive Entscheidungen:**
- Tech-Stack: KI-Empfehlung → User-Anpassung
- Roadmap: KI-Vorschlag → User-Anpassung
- Architektur: KI-Vorschlag → User-Bestätigung/Anpassung

### 2.3 Installation
- **Global** (`~/.agent-os/`) mit optionalem **Projekt-Override**

---

## 3. Command: `analyze-product`

### 3.1 Zweck
`plan-product` für **bereits existierende Projekte**

### 3.2 Ergebnisse (Output)

| Dokument | Beschreibung | Besonderheit |
|----------|--------------|--------------|
| `product-brief.md` | Produktdefinition | Codebase-Analyse + User-Befragung |
| `product-brief-lite.md` | Kurzversion | |
| `tech-stack.md` | Technologie-Stack | KI-Analyse + User-Befragung |
| `roadmap.md` | Entwicklungs-Roadmap | Phase 0 = aktueller Stand (abgeschlossen) |
| `architecture-decision.md` | Architektur-Entscheidung | KI analysiert Codebase, bei Unklarheit User fragen |
| `boilerplate/` | Ordnerstruktur | Demo-Modul für zukünftige Features |
| `architecture-structure.md` | Strukturbeschreibung | |

### 3.3 Besondere Anforderungen

**Refactoring-Entscheidung:**
```
IF bestehender Code ≠ neue Vorgaben:
  → Analyse: Refactoring sinnvoll?
  → ODER: Legacy belassen, nur neue Features nach Standard
```

---

## 4. Command: `validate-market-for-existing`

### 4.1 Zweck
Nachträgliche Marktvalidierung für **bereits bestehende Projekte**

### 4.2 Ergebnisse (Output)

| Dokument | Beschreibung | Besonderheit |
|----------|--------------|--------------|
| `product-brief.md` | Produktdefinition | Nur falls noch nicht vorhanden |
| `competitor-analysis.md` | Wettbewerbsanalyse | |
| `market-position.md` | Marktpositionierung | |

---

## 5. Command: `build-development-team`

### 5.1 Prozess

```
1. Analyse tech-stack.md
       ↓
2. Architecture Agent hinzufügen (basierend auf Template)
       ↓
3. ⏸️ USER-AUSWAHL: Weitere Agents?
   - Frontend-Dev-Agent (mehrfach möglich)
   - Backend-Dev-Agent (mehrfach möglich)
   - DevOps-Agent
   - UX-Agent
   - PO-Agent
       ↓
4. Definition of Done erstellen (Template-basiert, User-anpassbar)
       ↓
5. Definition of Ready erstellen (Template-basiert, User-anpassbar)
```

### 5.2 Agent-Konzept
- Agents bleiben **schlank**
- Referenzieren Skills über Claude Skills
- Mehrfach-Instanziierung möglich (für Parallelisierung)

---

## 6. Skill-Definitionen nach Agent-Rolle

### 6.1 Architecture Agent Skills

| Skill | Kernkompetenz | Wann laden? |
|-------|---------------|-------------|
| `architect-pattern-enforcer` | Hexagonale Architektur, DDD, Clean Architecture | Analysis/Design-Phase, Feature-Initialisierung |
| `architect-api-designer` | OpenAPI/Swagger, REST, JSON-Schemas | Parallel zu Pattern-Enforcer |
| `architect-data-modeler` | SQL-Normalisierung, ER-Diagramme, Migrations | Wenn Feature Daten speichern muss |
| `architect-security-guardian` | OAuth2/JWT, OWASP Top 10, RBAC | Finaler Design-Review vor "Ready for Dev" |
| `architect-dependency-checker` | Dependency Injection, IoC, Import-Graphen | Code-Review (Teil der DoD) |

### 6.2 Backend Developer Agent Skills

| Skill | Kernkompetenz | Wann laden? |
|-------|---------------|-------------|
| `logic-implementer` | Algorithmen, Geschäftsregeln, Validierung | Nach Interface-Definition durch Architekt |
| `persistence-adapter` | SQL, NoSQL, ORM, Query-Optimierung | Wenn Daten-Persistenz erforderlich |
| `integration-adapter` | HTTP-Clients, Webhooks, Message Queues | Bei Third-Party-Integrationen |
| `test-engineer` | TDD, Mocking, Unit/Integration-Tests | Vor/während Code-Schreiben |

### 6.3 Frontend Developer Agent Skills

| Skill | Kernkompetenz | Wann laden? |
|-------|---------------|-------------|
| `ui-component-architect` | CSS/Tailwind, Headless UI, Storybook, A11y | Neue UI-Elemente, Design-System-Erweiterung |
| `state-manager` | React Context, Redux, Zustand, TanStack Query | Interaktionen über Komponenten hinaus |
| `api-bridge-builder` | Axios/Fetch, OpenAPI-Client, Caching | Sobald API-Spec steht |
| `interaction-designer` | Formular-Validierung, Animationen, Routing | UI mit Logik verbinden |

### 6.4 DevOps Agent Skills

| Skill | Kernkompetenz | Wann laden? |
|-------|---------------|-------------|
| `infrastructure-provisioner` | Terraform, CloudFormation, Pulumi, Ansible | Neue Infrastruktur benötigt |
| `pipeline-engineer` | GitHub Actions, GitLab CI, Docker | Neue Build-Schritte/Tests |
| `observability-expert` | Prometheus, Grafana, ELK-Stack, Datadog | Nach Deployment |
| `security-hardener` | IAM, TLS/SSL, Secret Management, Scanning | Vor Release, Netzwerk-Änderungen |

### 6.5 PO Agent Skills

| Skill | Kernkompetenz | Wann laden? |
|-------|---------------|-------------|
| `backlog-strategist` | ROI-Analyse, Stakeholder-Management, Roadmap | Planungszyklus-Beginn |
| `requirements-engineer` | User Story Mapping, INVEST-Prinzip | Refinement-Prozess |
| `acceptance-tester` | UAT, Feedback-Loop-Management | Ticket in Testing/Review |
| `data-analyst` | A/B-Testing, Event-Tracking, Feedback-Analyse | 1-2 Wochen nach Release |

---

## 7. Globale/Übergreifende Skills

| Skill | Aufgabe | Nutzen |
|-------|---------|--------|
| `git-master` | Feature-Branches, Conventional Commits, PRs, Merge-Konflikte | Jeder Code-ändernde Agent |
| `changelog-manager` | CHANGELOG.md automatisch aktualisieren (Added/Changed/Fixed) | Transparenz über Änderungen |
| `documentation-architect` | README.md, API-Docs, ADRs pflegen | Onboarding neuer Agents |
| `security-vulnerability-scanner` | Hardcoded Keys, unsichere Libraries, Schwachstellen | Passives Sicherheitsnetz |

---

## 8. Technische Anforderungen

### 8.1 MCP-Server Integration
- Skills können MCP-Server nutzen
- MCP-Server werden im Skill **explizit gelistet**
- Template muss MCP-Server-Sektion vorsehen

### 8.2 Templates erforderlich für

**Dokument-Templates:**
- `product-brief.md`
- `competitor-analysis.md`
- `market-position.md`
- `tech-stack.md`
- `roadmap.md`
- `architecture-decision.md`
- `architecture-structure.md`
- `design-system.md`
- `definition-of-done.md`
- `definition-of-ready.md`

**Agent-Templates:**
- Architecture Agent
- Backend Developer Agent
- Frontend Developer Agent
- DevOps Agent
- PO Agent

**Skill-Templates:**
- Mit MCP-Server-Sektion
- Mit Trigger-Bedingungen ("Wann laden?")

---

## 9. Zusammenfassung: Command-Übersicht

| Command | Zweck | Installation |
|---------|-------|--------------|
| `validate-market` | Marktvalidierung vor Entwicklung | Global + Override |
| `plan-product` | Produktplanung (neu) | Global + Override |
| `analyze-product` | Produktplanung (bestehend) | Global + Override |
| `validate-market-for-existing` | Nachträgliche Marktvalidierung | Global + Override |
| `build-development-team` | Team-Aufbau mit Agents/Skills | Global + Override |
