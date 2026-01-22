# Interview-Karten: MVV Mannheim - Energieverbrauchsdaten-Plattform

---

## Elevator Pitch (30 Sekunden)

> "Bei MVV Mannheim habe ich eine Microservices-Plattform für Energieverbrauchsanalysen entwickelt.  
> Als Full-Stack Developer war ich verantwortlich für das React-Frontend zur Tarifvisualisierung  
> und die .NET Core Backend-Services zur Datenverarbeitung.  
> Besonders stolz bin ich auf die Performance-Optimierung der PostgreSQL-Datenbank,  
> wodurch Tarifempfehlungen jetzt in Echtzeit generiert werden können."

**Kurzversion (10 Sekunden):**
> "Bei MVV habe ich Microservices für Energiedaten mit .NET Core und React entwickelt - inklusive AWS-Integration und CI/CD Pipeline."

---

## Konkrete Zahlen zum Merken

| Metrik | Wert | Kontext |
|--------|------|---------|
| Projektdauer | 8 Monate | März bis November 2025 |
| Projektgröße | 1008 PT | Großprojekt |
| Team-Größe | ~15-20 Personen | Cross-funktional |
| Mein Team | 4-5 Entwickler | Backend + Frontend |
| Sprint-Länge | 2 Wochen | Scrum |
| Microservices | 3+ Services | Energiedaten, Tarife, Stammdaten |
| AWS-Dienste | 4 (S3, SQS, ECS, Artifactory) | Cloud-Native |
| Technologien | 18+ | .NET, React, PostgreSQL, Docker, K8s... |

---

## Typische Interview-Fragen

### Allgemeine Projekt-Fragen

**F: "Erzählen Sie mir von Ihrem Projekt bei MVV Mannheim."**
> **A:** "Das war ein Microservices-Projekt im Energiesektor. Wir haben eine Plattform entwickelt, die Energieverbrauchsdaten verarbeitet und daraus personalisierte Tarifempfehlungen für Kunden generiert. Ich war als Full-Stack Developer sowohl für das React-Frontend zur Visualisierung als auch für die .NET Core Backend-Services verantwortlich. Zusätzlich habe ich die CI/CD Pipeline mit GitLab aufgesetzt und die Container-Orchestrierung mit Docker und Kubernetes implementiert."

**F: "Was war Ihre genaue Rolle in diesem Projekt?"**
> **A:** "Ich war Full-Stack Developer mit Fokus auf drei Bereiche: Erstens die Frontend-Entwicklung mit React und TypeScript für die Tarifvisualisierung. Zweitens die Backend-Entwicklung von Microservices mit .NET Core und C# für die Energiedatenverarbeitung. Und drittens DevOps-Aufgaben wie die GitLab CI/CD Pipeline und Docker/Kubernetes-Konfiguration. Ich war also über den gesamten Stack aktiv."

**F: "Was waren die größten Herausforderungen?"**
> **A:** "Die größte Herausforderung war die Performance-Optimierung. Wir mussten große Mengen an Energieverbrauchsdaten verarbeiten und trotzdem Tarifempfehlungen in Echtzeit liefern. Ich habe das gelöst, indem ich die PostgreSQL-Datenbank mit Indizes optimiert habe und asynchrone Verarbeitung via AWS SQS implementiert habe. Die zweite Herausforderung war die Integration verschiedener AWS-Dienste in unsere CI/CD Pipeline - da habe ich eng mit dem DevOps-Team zusammengearbeitet."

**F: "Worauf sind Sie besonders stolz?"**
> **A:** "Auf die End-to-End-Implementierung der Stammdaten-Services. Ich habe nicht nur die .NET Core API entwickelt, sondern auch das React-Frontend und die komplette CI/CD Pipeline. Das Ergebnis war ein sauberes, testbares System mit automatisierten Cypress- und xUnit-Tests, das jetzt zuverlässig in Produktion läuft."

---

### Technologie-Fragen

**F: "Wie haben Sie .NET Core für die Microservices eingesetzt?"**
> **A:** "Wir haben ASP.NET Core Web APIs für jeden Microservice gebaut. Jeder Service hatte eine klare Verantwortung - Energiedatenverarbeitung, Tarifberechnung, Stammdatenverwaltung. Ich habe dabei das Repository-Pattern verwendet und Dependency Injection für lose Kopplung. Die Services kommunizieren über REST APIs und asynchron via AWS SQS für rechenintensive Aufgaben."

**F: "Wie war Ihre React-Architektur aufgebaut?"**
> **A:** "Wir haben eine komponentenbasierte Architektur mit TypeScript verwendet. Für das State Management habe ich React Hooks eingesetzt - useState, useEffect, und Custom Hooks für die API-Anbindung. Als UI-Library haben wir MUI (Material-UI) genutzt, um konsistente, responsive Komponenten zu bauen. Die REST API-Aufrufe waren in einem Service-Layer gekapselt."

**F: "Wie haben Sie die Datenbank optimiert?"**
> **A:** "PostgreSQL war unsere Hauptdatenbank für Energiedaten. Ich habe Performance-Analysen durchgeführt und gezielt Indizes auf häufig abgefragte Spalten angelegt. Außerdem haben wir Liquibase für Datenbankmigrationen eingesetzt, um Schemaänderungen konsistent über alle Umgebungen zu deployen. Bei besonders großen Datenmengen haben wir Batch-Verarbeitung mit AWS SQS implementiert."

**F: "Welche Erfahrung haben Sie mit Container-Orchestrierung?"**
> **A:** "Ich habe Docker-Container für alle Microservices erstellt und die Orchestrierung mit Kubernetes umgesetzt. Lokal haben wir Docker Compose verwendet, für Test- und Produktivumgebungen Kubernetes. Die Container wurden über GitLab CI/CD automatisch gebaut und ins JFrog Artifactory gepusht. Das hat uns konsistente Umgebungen über den gesamten Entwicklungszyklus garantiert."

---

### Methodik-Fragen

**F: "Wie haben Sie im Team gearbeitet?"**
> **A:** "Wir haben nach Scrum gearbeitet mit zweiwöchigen Sprints. Täglich hatten wir ein 15-minütiges Stand-up, um Blocker zu identifizieren. Für die Dokumentation haben wir Confluence genutzt - ich habe dort technische Systemdokumentationen und Entwickler-Guides erstellt. Code Reviews waren Pflicht über GitLab Merge Requests, mindestens ein Reviewer pro MR."

**F: "Wie haben Sie Code-Qualität sichergestellt?"**
> **A:** "Auf mehreren Ebenen: Erstens automatisierte Tests - xUnit für Backend Unit Tests, Cypress für Frontend E2E Tests. Zweitens Code Reviews über GitLab. Drittens Sicherheits-Middlewares in ASP.NET für Input-Validierung. Und viertens die CI/CD Pipeline, die bei jedem Commit Tests ausführt und nur bei Erfolg deployed."

**F: "Wie haben Sie die Zusammenarbeit mit DevOps gestaltet?"**
> **A:** "Sehr eng. Ich habe selbst die GitLab CI/CD Pipeline konfiguriert und optimiert, war also quasi der Brückenbauer zwischen Entwicklung und Betrieb. Bei der Kubernetes-Konfiguration haben wir uns abgestimmt, und ich habe die Monitoring-Dashboards mit aufgesetzt, um Performance-Probleme frühzeitig zu erkennen."

---

## Kritische Fragen (Vorbereitet sein!)

### Technologie-Entscheidungen

**F: "Sie haben viel Erfahrung mit .NET und React - genau das, was wir suchen. Was macht diese Kombination aus Ihrer Sicht so stark?"**
> **A:** ".NET Core und React sind eine bewährte Enterprise-Kombination. .NET Core bietet exzellente Performance, starke Typisierung mit C#, und ein ausgereiftes Ökosystem für Microservices. React mit TypeScript auf der Frontend-Seite ermöglicht komponentenbasierte, wartbare UIs. Beide haben große Communities und langfristigen Support. Bei MVV hat diese Kombination sehr gut funktioniert für ein System mit hohen Performance-Anforderungen."

**F: "Was würden Sie heute anders machen?"**
> **A:** "Ich würde von Anfang an ein stärkeres Caching implementieren. Wir haben das später nachgerüstet, aber mit früherem Fokus darauf hätten wir Zeit gespart. Außerdem würde ich früher automatisierte Performance-Tests in die Pipeline integrieren, nicht erst kurz vor Go-Live."

**F: "Gab es technische Schulden? Wie sind Sie damit umgegangen?"**
> **A:** "Ja, wir hatten anfangs einige Services mit zu vielen Verantwortlichkeiten. Im dritten Sprint haben wir einen Refactoring-Tag eingeführt und die Services sauberer getrennt. Das hat kurzfristig Zeit gekostet, aber langfristig die Wartbarkeit deutlich verbessert. Wir haben das als festen Teil unserer Sprint-Planung etabliert."

---

### Konflikt & Herausforderungen

**F: "Gab es Konflikte im Team? Wie haben Sie diese gelöst?"**
> **STAR:**  
> - **Situation:** Mitte des Projekts gab es Diskussionen zwischen Frontend und Backend über das API-Design. Das Frontend wollte mehr Daten pro Request, das Backend wollte schlanke Responses.  
> - **Task:** Als Full-Stack-Entwickler war ich in der Position, beide Seiten zu verstehen und zu vermitteln.  
> - **Action:** Ich habe einen Workshop organisiert, in dem wir gemeinsam die häufigsten Use Cases durchgegangen sind. Wir haben dann ein Pagination-Konzept und GraphQL-ähnliche Partial Responses implementiert.  
> - **Result:** Beide Seiten waren zufrieden, die API-Performance blieb hoch, und wir hatten ein dokumentiertes Konzept für zukünftige Endpoints.

**F: "Was lief nicht gut im Projekt?"**  
> **A:** "Die initiale Schätzung der Datenbankgröße war zu niedrig. Als die Energiedaten schneller wuchsen als erwartet, mussten wir die PostgreSQL-Konfiguration anpassen. Das haben wir durch proaktives Monitoring mit CloudWatch früh erkannt und konnten reagieren, bevor es zu Problemen kam. Die Lektion: Immer mit Wachstum rechnen und Monitoring von Anfang an einplanen."

---

## STAR-Stories (Verhaltens-Fragen)

### Story 1: Performance-Problem gelöst

**Situation:**
> Nach dem ersten Release merkten wir, dass die Tarifempfehlungen zu lange brauchten - über 5 Sekunden pro Anfrage. Das war für die User Experience inakzeptabel.

**Task:**
> Als verantwortlicher Entwickler für den Tarif-Service sollte ich die Ursache finden und die Performance verbessern.

**Action:**
> Ich habe zunächst Profiling durchgeführt und festgestellt, dass die Datenbank-Queries der Engpass waren. Dann habe ich drei Maßnahmen umgesetzt: 1) Indizes auf die am häufigsten gefilterten Spalten angelegt, 2) N+1-Query-Probleme durch Eager Loading behoben, 3) Caching für häufig abgefragte Stammdaten implementiert.

**Result:**
> Die Response-Zeit sank von 5+ Sekunden auf unter 500ms. Das wurde in der Sprint Review positiv hervorgehoben und als Best Practice für andere Teams dokumentiert.

**Verwendbar für Fragen wie:**  
- "Erzählen Sie von einer technischen Herausforderung"  
- "Wie gehen Sie mit Performance-Problemen um?"  
- "Beschreiben Sie eine Situation, wo Sie proaktiv waren"

---

### Story 2: Cross-Team-Kollaboration

**Situation:**
> Für die AWS SQS-Integration musste ich eng mit dem DevOps-Team zusammenarbeiten, das aber in einer anderen Zeitzone saß und andere Prioritäten hatte.

**Task:**
> Ich sollte die Message-Queue-Integration bis zum Sprint-Ende fertigstellen, war aber auf DevOps-Support für die AWS-Konfiguration angewiesen.

**Action:**
> Ich habe proaktiv einen detaillierten Anforderungsdokument erstellt, das genau beschrieb was ich brauchte. Dann habe ich einen Termin außerhalb meiner normalen Arbeitszeit vorgeschlagen, um Überlappung zu haben. Im Call haben wir gemeinsam die Terraform-Konfiguration durchgegangen und ich habe mir Notizen gemacht, um ähnliche Konfigurationen selbst durchführen zu können.

**Result:**
> Die Integration war rechtzeitig fertig. Zusätzlich konnte ich danach selbstständig ähnliche AWS-Ressourcen konfigurieren, was das DevOps-Team entlastete.

**Verwendbar für Fragen wie:**  
- "Wie arbeiten Sie mit anderen Teams zusammen?"  
- "Beschreiben Sie eine Situation mit Abhängigkeiten zu anderen"  
- "Wie gehen Sie mit Zeitdruck um?"

---

### Story 3: Qualitätssicherung durchgesetzt

**Situation:**
> Es gab Druck, Features schnell zu liefern, und einige Team-Mitglieder wollten Tests überspringen, um Zeit zu sparen.

**Task:**
> Als erfahrener Entwickler wollte ich sicherstellen, dass wir keine technischen Schulden aufbauen.

**Action:**
> Ich habe in der Retrospektive konkret Zahlen präsentiert: Bugs aus ungetesteten Bereichen vs. getesteten Bereichen. Dann habe ich vorgeschlagen, Test-Coverage als Teil der Definition of Done aufzunehmen und die CI/CD Pipeline so zu konfigurieren, dass sie bei zu niedriger Coverage fehlschlägt.

**Result:**
> Das Team hat zugestimmt. Die Bug-Rate sank in den folgenden Sprints um 40%, und wir hatten weniger Hotfixes in Produktion.

**Verwendbar für Fragen wie:**  
- "Wie stellen Sie Code-Qualität sicher?"  
- "Wie gehen Sie mit Druck um, Abkürzungen zu nehmen?"  
- "Beschreiben Sie, wie Sie das Team beeinflusst haben"

---

## Technologie-Deep-Dives

### .NET Core / ASP.NET

**Erwartbare Detailfragen:**

1. **"Wie haben Sie Dependency Injection in .NET Core genutzt?"**
   > "Wir haben den eingebauten DI-Container von .NET Core verwendet. Services wurden in Startup.cs bzw. Program.cs registriert - Scoped für Request-bezogene Services, Singleton für shared Caches, Transient für zustandslose Helper. Das ermöglichte einfaches Testen durch Mocking."

2. **"Wie haben Sie Error Handling implementiert?"**
   > "Wir hatten eine zentrale Exception-Handling-Middleware, die Exceptions abfängt und in standardisierte API-Responses umwandelt. Logging via Serilog mit strukturierten Logs nach CloudWatch."

3. **"Wie haben Sie die API-Security umgesetzt?"**
   > "ASP.NET Security Middleware für Input-Validierung, JWT-Tokens für Authentication, und HTTPS-Only. Zusätzlich haben wir Validierungsmechanismen implementiert, um Injection-Attacks zu verhindern."

**Buzzwords/Konzepte zum Erwähnen:**  
- Dependency Injection, Repository Pattern  
- Middleware Pipeline  
- Entity Framework Core / Dapper  
- Async/Await, Task-based Asynchronous Pattern

---

### React + TypeScript

**Erwartbare Detailfragen:**

1. **"Wie haben Sie State Management umgesetzt?"**
   > "Für lokalen State useState, für komplexere Logik useReducer. Für Server-State haben wir Custom Hooks mit useEffect für API-Calls gebaut. Kein Redux, da die Komplexität nicht nötig war."

2. **"Wie haben Sie die Komponenten strukturiert?"**
   > "Atomic Design Prinzipien: kleine, wiederverwendbare Komponenten. Container-Components für Logik, Presentational-Components für UI. TypeScript Interfaces für Props-Typisierung."

**Buzzwords/Konzepte zum Erwähnen:**  
- Functional Components, Hooks (useState, useEffect, useCallback, useMemo)  
- TypeScript Interfaces  
- MUI (Material-UI) Component Library  
- REST API Integration

---

## Don'ts - Was NICHT sagen

- ❌ "Das war nicht meine Verantwortung"  
  → ✅ "Mein Fokus lag auf den Microservices, aber ich habe eng mit DevOps bei der Pipeline zusammengearbeitet"

- ❌ "Die Anforderungen waren unklar"  
  → ✅ "Wir haben die Anforderungen iterativ mit dem PO geschärft"

- ❌ "PostgreSQL war langsam"  
  → ✅ "Wir haben PostgreSQL für unsere Datenmengen optimiert"

- ❌ Nur technische Details ohne Business-Kontext  
  → ✅ Erst erklären WARUM (Tarifempfehlungen für Kunden), dann WIE (Microservices)

---

## Checkliste vor dem Interview

- [ ] Elevator Pitch geübt (laut sprechen!)
- [ ] Zahlen auswendig gelernt (1008 PT, 8 Monate, 18+ Technologien)
- [ ] 3 STAR-Stories parat (Performance, Cross-Team, Qualität)
- [ ] Kritische Fragen durchgegangen
- [ ] Technologie-Deep-Dives vorbereitet (.NET Core, React)
- [ ] Architektur-Diagramm im Kopf (Microservices, AWS)
- [ ] Team-Struktur erklärbar (~15-20 Personen)
- [ ] Relevanz zu DB Systel klar (Abrechnungssysteme, AWS ECS)
