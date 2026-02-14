# Interview-Karten: Uniklinik Mannheim - Therapeutische VR-Umgebung

---

## Elevator Pitch (30 Sekunden)

> "Bei der Uniklinik Mannheim habe ich an einem Forschungsprojekt für eine therapeutische VR-Anwendung mitgearbeitet.
> Als Full-Stack Developer war ich für React/TypeScript-Dashboards zur KPI-Visualisierung,
> C#/.NET Core Backend-Services für die VR-Umgebung und Python-basierte Datenerfassung verantwortlich.
> Besonders stolz bin ich auf die DSGVO-konforme Verarbeitung sensibler Patientendaten
> und die CI/CD-Pipeline mit Docker und Kubernetes auf AWS."

**Kurzversion (10 Sekunden):**
> "Bei einem Forschungsprojekt mit der Uniklinik Mannheim habe ich eine VR-Therapieanwendung mit React, C# und Python entwickelt - mit DSGVO-konformer Patientendatenverarbeitung."

---

## Konkrete Zahlen zum Merken

| Metrik | Wert | Kontext |
|--------|------|---------|
| Projektdauer | 8 Monate | September 2023 - Mai 2024 |
| Projektgröße | 1008 PT | Forschungsprojekt |
| Team-Größe | ~15 Personen | Cross-funktional + Medizin |
| AWS-Dienste | 4 | S3, CloudFront, Route 53, CloudWatch |
| Compliance | DSGVO | Sensible Patientendaten |
| Tech-Stack | 3 Sprachen | C#, TypeScript, Python |

---

## Typische Interview-Fragen

### Allgemeine Projekt-Fragen

**F: "Erzählen Sie mir von Ihrem Projekt bei der Uniklinik Mannheim."**
> **A:** "Das war ein Forschungsprojekt zur Entwicklung einer VR-Anwendung für Patienten, die Angst oder Unwohlsein während medizinischer Eingriffe haben. Ich war als Full-Stack Developer für drei Bereiche verantwortlich: React-Dashboards für Therapeuten zur KPI-Visualisierung, C#/.NET Core Backend für die VR-Umgebung, und Python-Services für die anonymisierte Datenerfassung. Die besondere Herausforderung war die DSGVO-konforme Verarbeitung sensibler Patientendaten."

**F: "Was war Ihre genaue Rolle?"**
> **A:** "Ich war Full-Stack Developer mit Fokus auf drei Bereiche: Erstens Frontend - React/TypeScript-Dashboards zur Feedback-Integration und KPI-Visualisierung für Therapeuten. Zweitens Backend - C#/.NET Core für die VR-Umgebungsoptimierung mit Fokus auf niedrige Latenz. Drittens Data Services - Python-basierte Dienste für DSGVO-konforme Datenerfassung. Zusätzlich habe ich die CI/CD-Pipeline mit Docker und Kubernetes aufgesetzt."

**F: "Was waren die größten Herausforderungen?"**
> **A:** "Zwei Hauptherausforderungen: Erstens die Performance - VR erfordert sehr niedrige Latenz für eine reibungslose Erfahrung, sonst wird Patienten übel. Ich habe die .NET Core Services optimiert und AWS CloudFront für die Asset-Auslieferung eingesetzt. Zweitens der Datenschutz - Patientendaten sind besonders sensibel. Ich habe die Python-Services so konzipiert, dass Daten direkt bei der Erfassung anonymisiert werden."

---

### Technologie-Fragen

**F: "Wie haben Sie die DSGVO-Compliance sichergestellt?"**
> **A:** "Mehrschichtiger Ansatz: Erstens Privacy by Design - die Python-Services anonymisieren Daten direkt bei der Erfassung, bevor sie gespeichert werden. Zweitens minimale Datenhaltung - nur für die Forschung notwendige Daten werden erfasst. Drittens Zugriffskontrollen - strikte Rollenbasierte Zugriffe auf Patientendaten. Die gesamte Architektur wurde mit dem Legal-Team abgestimmt und dokumentiert."

**F: "Wie war die VR-Performance-Optimierung?"**
> **A:** "VR erfordert konstante 60-90 FPS, sonst wird es unangenehm. Auf Backend-Seite habe ich die .NET Core APIs auf minimale Latenz optimiert - asynchrone Verarbeitung, Connection Pooling, Response Caching. Für VR-Assets haben wir AWS S3 mit CloudFront als CDN eingesetzt. Die Assets wurden vorgeladen und gecacht, um Ladezeiten zu minimieren."

**F: "Wie haben Sie das KPI-Dashboard für Therapeuten umgesetzt?"**
> **A:** "Mit React und TypeScript. Die Therapeuten brauchten Echtzeit-Einblick in den Therapiefortschritt: Wie reagieren Patienten? Welche VR-Szenen sind effektiv? Ich habe React Hooks für State Management verwendet und die Daten über REST APIs vom Backend geholt. TypeScript Interfaces haben für präzise Typisierung der Messdaten gesorgt."

---

## Kritische Fragen

**F: "Die Anforderungen nennen React - wie haben Sie React bei der Uniklinik eingesetzt?"**
> **A:** "Ich habe die KPI-Dashboards für Therapeuten mit React und TypeScript entwickelt. Die Therapeuten brauchten Echtzeit-Einblick in den Therapiefortschritt - welche VR-Szenen sind effektiv, wie reagieren Patienten. Mit React Hooks habe ich das State Management umgesetzt, TypeScript Interfaces haben für präzise Typisierung der Messdaten gesorgt. Die Komponenten waren modular aufgebaut für einfache Erweiterung."

**F: "Sie haben Python nur als Intermediate eingestuft - wie sicher sind Sie damit?"**
> **A:** "Für Data Engineering und Scripting bin ich sicher - das habe ich bei der Uniklinik bewiesen. Für komplexe Algorithmen oder Machine Learning würde ich mich noch weiter einarbeiten müssen. Aber die Python-Services, die ich gebaut habe - Datenerfassung, Anonymisierung, API-Anbindung - liefen stabil in Production."

**F: "Wie war die Zusammenarbeit mit nicht-technischen Stakeholdern?"**
> **A:** "Bei einem Forschungsprojekt mit der Uniklinik war das essentiell. Medizinische Berater haben die fachlichen Anforderungen definiert - was messen wir, welche KPIs sind relevant für den Therapieerfolg. Ich musste technische Konzepte verständlich erklären und medizinische Anforderungen in Software-Specs übersetzen. Regelmäßige Calls mit der Uniklinik waren Teil meines Alltags."

---

## STAR-Stories

### Story 1: DSGVO-konforme Datenerfassung unter Zeitdruck

**Situation:**
> Kurz vor dem ersten Patientenversuch stellte das Legal-Team fest, dass unsere Datenerfassung die DSGVO-Anforderungen nicht vollständig erfüllte - die Anonymisierung erfolgte zu spät im Prozess.

**Task:**
> Ich sollte die Python-Services so umbauen, dass Daten bereits bei der Erfassung anonymisiert werden - innerhalb von zwei Wochen vor dem geplanten Versuchsstart.

**Action:**
> Ich habe das Data-Flow-Diagramm neu konzipiert: Anonymisierung direkt im Erfassungs-Service, bevor Daten die erste Persistenzschicht erreichen. Pseudonymisierungs-Keys wurden separiert gespeichert. Ich habe das Legal-Team einbezogen, um die Lösung zu validieren, und Tests geschrieben, die die Anonymisierung verifizieren.

**Result:**
> Der Patientenversuch konnte pünktlich starten. Die neue Architektur wurde als Best Practice für zukünftige Projekte dokumentiert. Das Legal-Team hat unseren Ansatz als vorbildlich bezeichnet.

---

### Story 2: VR-Latenz-Optimierung

**Situation:**
> In den ersten Tests berichteten Patienten über gelegentliches Ruckeln in der VR-Umgebung - ein Showstopper, weil das zu Übelkeit führen kann.

**Task:**
> Als Backend-Entwickler sollte ich die Ursache finden und die Latenz reduzieren.

**Action:**
> Ich habe die .NET Core Services profiliert und zwei Bottlenecks identifiziert: Synchrone Datenbankzugriffe und große Asset-Downloads. Ich habe asynchrone Verarbeitung implementiert und ein intelligentes Preloading für VR-Assets über CloudFront eingerichtet. Zusätzlich Caching für häufig abgerufene Daten.

**Result:**
> Die Latenz sank um 60%, das Ruckeln verschwand. Kein Patient hat mehr über technische Probleme berichtet. Die Optimierungen wurden dokumentiert und für andere VR-Projekte wiederverwendet.

---

## Technologie-Deep-Dives

### AWS-Infrastruktur (S3, CloudFront, Route 53, CloudWatch)

**Erwartbare Detailfragen:**

1. **"Wie haben Sie CloudFront für VR-Assets konfiguriert?"**
   > "VR-Assets sind groß - 3D-Modelle, Texturen, Audio. Wir haben S3 als Origin mit CloudFront davor für globale Edge-Distribution. Cache-Control-Header für lange Cache-Zeiten bei immutablen Assets. Preloading der Assets während der Patientenvorbereitung, damit in der Session alles gecacht ist."

2. **"Wie war das Monitoring aufgebaut?"**
   > "CloudWatch für alle kritischen Metriken: API-Latenz, Error-Rates, VR-Session-Stabilität. Alerts bei Latenz-Spikes oder erhöhten Fehlerraten. Dashboards für das Dev-Team und separate, vereinfachte Dashboards für die Uniklinik."

**Buzzwords:** Edge Caching, S3 Origin, Cache-Control, CloudWatch Alarms, CloudWatch Dashboards

---

### Docker & Kubernetes CI/CD

**Erwartbare Detailfragen:**

1. **"Wie sah die CI/CD-Pipeline aus?"**
   > "GitLab CI für Build und Test, Docker-Images für jeden Service, Kubernetes für Orchestrierung. Automatische Tests bei jedem Commit, automatisches Deployment in Staging bei Merge. Production-Deployments manuell getriggert nach QA-Freigabe."

2. **"Wie haben Sie die Container strukturiert?"**
   > "Ein Container pro Service - Frontend, Backend-API, Python-Services. Kubernetes Deployments mit Readiness und Liveness Probes. Horizontal Pod Autoscaling für den Backend-Service basierend auf CPU-Auslastung."

**Buzzwords:** GitLab CI, Docker Multi-Stage Builds, K8s Deployments, HPA, Probes

---

## Verbindung zu DB Systel Anforderungen

### Direkte Übertragbarkeit

| DB Systel Anforderung | Nachweis aus diesem Projekt |
|-----------------------|-----------------------------|
| .NET Core / C# | VR-Backend-Optimierung, REST APIs |
| React / TypeScript | KPI-Dashboards für Therapeuten |
| CI/CD Pipeline | Docker + Kubernetes Pipeline |
| Container Orchestration | Kubernetes in Production |
| AWS Cloud | S3, CloudFront, Route 53, CloudWatch |
| Testing (xUnit, Cypress) | Backend- und E2E-Tests |
| Confluence | DSGVO-Dokumentation |

### Unique Selling Points

1. **Datenschutz-Erfahrung:** DSGVO für Patientendaten - strenger als bei Bahn-Daten
2. **Performance-Kritisch:** VR erfordert extreme Latenz-Optimierung
3. **Cross-funktionale Zusammenarbeit:** Mit Medizinern, Legal, Data Science
4. **Forschungsprojekt:** Wissenschaftliche Arbeitsweise, gründliche Dokumentation

---

## Checkliste vor dem Interview

- [ ] Elevator Pitch geübt (30 Sekunden und 10 Sekunden Version)
- [ ] Zahlen: 1008 PT, 15 Personen, 4 AWS-Dienste, DSGVO
- [ ] STAR-Stories: DSGVO-Compliance, VR-Latenz-Optimierung
- [ ] AWS-Setup erklären können (S3, CloudFront, CloudWatch)
- [ ] DSGVO-Ansatz beschreiben können
- [ ] React-Einsatz bei Uniklinik erklären können
- [ ] Forschungskontext als Vorteil framen (Dokumentation, Gründlichkeit)
