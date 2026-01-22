# Interview-Karten: KIA Gebrauchtwagenplattform

---

## Elevator Pitch (30 Sekunden)

> "Bei KIA habe ich eine Gebrauchtwagenplattform von Grund auf mitentwickelt.
> Als Full-Stack Developer war ich für das React-Frontend der Fahrzeugsuche und
> die C#/.NET Backend-Services zur Datenaggregation von 8+ externen APIs aus 6 Ländern verantwortlich.
> Besonders stolz bin ich auf das Monitoring-Setup mit Grafana und Prometheus,
> das uns ermöglicht hat, Performance-Probleme proaktiv zu identifizieren."

**Kurzversion (10 Sekunden):**
> "Bei KIA habe ich eine Gebrauchtwagenplattform mit React und C# entwickelt - mit Integration von 8+ externen APIs und Echtzeit-Monitoring."

---

## Konkrete Zahlen zum Merken

| Metrik | Wert | Kontext |
|--------|------|---------|
| Projektdauer | 8 Monate | Juni 2024 - Februar 2025 |
| Projektgröße | 1344 PT | Großprojekt |
| Team-Größe | ~20-25 Personen | Cross-funktional |
| Externe APIs | 8+ | Aus 6 verschiedenen Ländern |
| Länder | 6 | Internationale Skalierung |
| Microservices | 5+ | BFFs, Aggregation, Leads, Dealer |

---

## Typische Interview-Fragen

### Allgemeine Projekt-Fragen

**F: "Erzählen Sie mir von Ihrem Projekt bei KIA."**
> **A:** "Das war eine Eigenentwicklung einer Gebrauchtwagenplattform für den europäischen Markt. Wir haben eine Such- und Vergleichsfunktion für Gebrauchtwagen gebaut, ein Händlerportal zur Fahrzeugverwaltung, und einen Lead-Service für Kundenanfragen. Die besondere Herausforderung war die Integration von über 8 externen Fahrzeug-APIs aus 6 verschiedenen Ländern - jede mit anderem Format. Ich war Full-Stack für React-Frontend und C#-Backend zuständig."

**F: "Was war Ihre genaue Rolle?"**
> **A:** "Ich war Full-Stack Developer mit Schwerpunkt auf UI-Entwicklung und Backend-Integration. Im Frontend habe ich Figma-Designs pixelgenau in React-Komponenten umgesetzt. Im Backend habe ich Microservices mit C# und ASP.NET Core entwickelt, insbesondere für die Datenaggregation der externen APIs. Zusätzlich habe ich das Monitoring mit Grafana, Loki und Prometheus aufgesetzt."

**F: "Was waren die größten Herausforderungen?"**
> **A:** "Die Standardisierung der verschiedenen API-Formate war die größte Herausforderung. Jedes Land hatte andere Datenstrukturen für Fahrzeuginformationen. Ich habe ein Mapping-Layer entwickelt, das alle Formate in ein einheitliches internes Schema überführt. Die zweite Herausforderung war die Performance - wir haben Caching und BFF-Pattern implementiert, um die Antwortzeiten zu optimieren."

---

### Technologie-Fragen

**F: "Wie haben Sie die externen APIs integriert?"**
> **A:** "Wir haben einen Datenaggregations-Service in C# entwickelt, der die 8+ externen APIs abfragt. Jede API hatte einen eigenen Adapter mit Mapping-Logik. Die Daten wurden dann in ein einheitliches Format transformiert und in PostgreSQL persistiert. Für die Synchronisation haben wir Scheduled Jobs und Change Detection implementiert."

**F: "Wie haben Sie das Monitoring aufgesetzt?"**
> **A:** "Grafana als Visualisierung, Loki mit Promtail für das Logging, Prometheus für Echtzeitmetriken. Wir haben Dashboards für die wichtigsten KPIs erstellt: Response-Zeiten, Error-Rates, API-Verfügbarkeit. Alerts haben uns bei Problemen sofort benachrichtigt. Das hat uns ermöglicht, Performance-Engpässe proaktiv zu identifizieren."

**F: "Wie war die Frontend-Architektur?"**
> **A:** "React mit TypeScript und Functional Components. Hooks für State Management - useState, useEffect, Custom Hooks für API-Calls. Die Designs kamen aus Figma und wurden pixelgenau umgesetzt. Für die Integration ins CMS haben wir die SPAs in Adobe AEM eingebunden."

---

## Kritische Fragen

**F: "Sie haben umfangreiche React-Erfahrung - wie haben Sie bei KIA die Frontend-Architektur skaliert?"**
> **A:** "Bei KIA haben wir eine komponentenbasierte Architektur mit React und TypeScript aufgebaut. Für die Fahrzeugsuche mit komplexen Filtern haben wir Custom Hooks entwickelt, die die API-Logik kapseln. Die Designs kamen aus Figma und wurden pixelgenau umgesetzt. Für die CMS-Integration haben wir die SPAs in Adobe AEM eingebunden - das erforderte saubere Schnittstellen und modulare Komponenten."

**F: "Wie haben Sie mit Dateninkonsistenzen der externen APIs umgegangen?"**
> **A:** "Wir hatten Validierung auf mehreren Ebenen: Input-Validation im Adapter, Schema-Validation in der Mapping-Schicht, und Constraint-Checks in der Datenbank. Bei Inkonsistenzen wurden die Daten geloggt und ein Fallback auf den letzten validen Datensatz genutzt. Das Team wurde über Alerts informiert."

---

## STAR-Stories

### Story 1: API-Integration in Rekordzeit

**Situation:**
> Kurz vor einem wichtigen Release sollte eine neue Länder-API (Polen) integriert werden - mit komplett anderem Datenformat als die bestehenden.

**Task:**
> Ich sollte die Integration innerhalb einer Woche umsetzen, normalerweise planen wir 2 Wochen pro API.

**Action:**
> Ich habe das bestehende Adapter-Pattern analysiert und einen generischen Basis-Adapter extrahiert. Dann habe ich nur die spezifischen Mappings für Polen implementiert. Parallel habe ich Tests geschrieben, die die Transformationen validieren.

**Result:**
> Die Integration war in 5 Tagen fertig und fehlerfrei. Das generische Pattern haben wir dokumentiert und für zukünftige APIs wiederverwendet - das hat jede folgende Integration auf 3-4 Tage reduziert.

---

### Story 2: Monitoring rettet Production

**Situation:**
> Drei Wochen nach Go-Live zeigten die Grafana-Dashboards plötzlich steigende Latenz bei einer externen API.

**Task:**
> Als Entwickler des Monitoring-Systems sollte ich die Ursache finden und das Team informieren.

**Action:**
> Ich habe die Logs in Loki analysiert und festgestellt, dass die API eines Landes Rate-Limiting eingeführt hatte, ohne uns zu informieren. Ich habe sofort ein Caching implementiert und die Abfragefrequenz reduziert.

**Result:**
> Die Latenz normalisierte sich innerhalb von Stunden. Wir haben das Monitoring um API-spezifische Rate-Limit-Alerts erweitert. Der Kunde hat nie ein Problem bemerkt.

---

## Technologie-Deep-Dives

### Monitoring (Grafana/Prometheus/Loki)

**Erwartbare Detailfragen:**

1. **"Wie haben Sie Prometheus-Metriken strukturiert?"**
   > "Wir haben Standard RED-Metriken (Rate, Errors, Duration) für jeden Service. Zusätzlich Business-Metriken wie Fahrzeugsuchen pro Minute und Lead-Conversions. Labels für Service, Umgebung und Land ermöglichten Drill-Downs."

2. **"Wie war das Alerting aufgebaut?"**
   > "Mehrstufig: Warning bei 90% Threshold, Critical bei 95%. Alerts gingen über Slack an das Team. Für kritische Alerts gab es Eskalation an On-Call. Wir hatten Runbooks in Confluence für jeden Alert-Typ."

**Buzzwords:** RED Metrics, Prometheus Labels, Loki LogQL, Grafana Dashboards

---

## Checkliste vor dem Interview

- [ ] Elevator Pitch geübt
- [ ] Zahlen: 1344 PT, 8+ APIs, 6 Länder
- [ ] STAR-Stories: API-Integration, Monitoring
- [ ] Monitoring-Setup erklären können
- [ ] BFF-Pattern beschreiben können
- [ ] React-Architektur erklären können
