# Profile Matching Analysis: DB InfraGO AG - React Fullstack Entwickler

**Erstellt:** 2026-01-25
**Phase 1 Basis:** 01-requirements-analysis.md
**Mitarbeiterprofil:** Dr. Burkhard Eggers
**Modus:** Nur Analyse (keine Optimierung)

---

## Zusammenfassung

### Matching-Ergebnisse

| Kategorie | Erfüllt | Gesamt | Prozent |
|-----------|---------|--------|---------|
| **Muss-Anforderungen** | 5 | 5 | **100%** |
| **Soll-Anforderungen** | 1 | 5 | 20% |
| **Soll gewichtet** | - | - | **31.25%** |

### Gesamtscore

```
Gesamtscore = (Muss × 70%) + (Soll gewichtet × 30%)
            = (100% × 0.7) + (31.25% × 0.3)
            = 70% + 9.375%
            = 79.4%
```

**Bewertung:** Das Profil erfüllt alle Muss-Anforderungen vollständig. Bei den Soll-Anforderungen bestehen Lücken in den Bereichen Reaktive Programmierung, MUI und Eisenbahn-Domänenwissen.

---

## Profil-Extraktion: Dr. Burkhard Eggers

### Berufserfahrung Übersicht

| # | Arbeitgeber | Position | Zeitraum | Dauer |
|---|-------------|----------|----------|-------|
| 1 | **webstake** | Senior Softwareentwickler | 03/2023 - heute | 35 Monate |
| 2 | **quattec** | Senior Softwareentwickler | 01/2023 - 02/2023 | 2 Monate |
| 3 | **SVA** | Systemengineer | 06/2020 - 12/2022 | 31 Monate |
| 4 | **Market Logic Software** | Head of Frontend Infrastructure | 09/2007 - 04/2020 | 151 Monate |
| 5 | **IST GmbH Darmstadt** | Softwareentwickler/-architekt | 09/2000 - 03/2007 | 79 Monate |

**Gesamterfahrung Softwareentwicklung:** ~25 Jahre (seit 09/2000)

### Technologie-Profil (Selbsteinschätzung aus CV)

```
Legende:
++++ sehr viel Erfahrung
+++  viel Erfahrung
++   einigermaßen vertraut
+    geringe Kenntnisse
-    heute irrelevant
```

**Java:**
- Core Java: ~20 Jahre
- Spring (++++)
- Spring Data JPA (+++)
- Gradle (++++)
- Maven (+++)
- Mockito/JUnit (+++)

**JavaScript/TypeScript:**
- React.js (++++)
- TypeScript (++++)
- Vue.js (++++)
- Redux (+++)
- Node.js (++++)
- Next.js (++)
- Jest (++)
- Material-UI (+)

**Methodiken:**
- Scrum (+++)
- Agile (+++)
- Docker (++)

**Sprachen:**
- Deutsch: Muttersprache
- Englisch: Fließend
- Spanisch: Perfekt

---

## Muss-Anforderungen: Detailanalyse

### M1: 5 Jahre Java-Erfahrung

**Status:** ✅ **ERFÜLLT**

**Nachweis-Berechnung:**

| Projekt | Zeitraum | Monate | Java nachweisbar |
|---------|----------|--------|------------------|
| IST GmbH | 09/2000 - 03/2007 | 79 | ✅ Java explizit |
| Market Logic | 09/2007 - 04/2020 | 151 | ✅ Java, Spring Boot |
| SVA | 06/2020 - 12/2022 | 31 | ✅ Java, Spring, JUnit |
| webstake | 03/2023 - heute | 35 | ✅ Spring |
| **Gesamt** | | **296** | **24+ Jahre** |

**Buzzword-Matching:**
- `Java` → ✅ In allen Projekten ab 2000
- `Spring` → ✅ Market Logic, SVA, webstake
- `Spring Boot` → ✅ Market Logic, SVA

---

### M2: 5 Jahre TypeScript-Erfahrung

**Status:** ✅ **ERFÜLLT**

**Nachweis-Berechnung:**

| Projekt | Zeitraum | Monate | TypeScript nachweisbar |
|---------|----------|--------|------------------------|
| SVA | 06/2020 - 12/2022 | 31 | ✅ TypeScript explizit |
| webstake | 03/2023 - heute | 35 | ✅ React (implizit TS) |
| **Gesamt** | | **66** | **5.5 Jahre** |

**Zusätzlicher Nachweis:**
- Profil-Selbsteinschätzung: "TypeScript (++++)" = sehr viel Erfahrung
- Market Logic (React-Migration ab ~2015): Wahrscheinlich TypeScript, aber nicht explizit

**Buzzword-Matching:**
- `TypeScript` → ✅ SVA explizit, Profil-Skills

---

### M3: 3 Jahre React, davon 2 Jahre in letzten 3 Jahren

**Status:** ✅ **ERFÜLLT**

**Nachweis-Berechnung:**

| Projekt | Zeitraum | Monate | React nachweisbar |
|---------|----------|--------|-------------------|
| Market Logic | 2015 - 04/2020 | ~60 | ✅ React.js (Migration von GWT) |
| SVA | 06/2020 - 12/2022 | 31 | ✅ React.js, Next.js |
| webstake | 03/2023 - heute | 35 | ✅ React.js |
| **Gesamt** | | **~126** | **10+ Jahre** |

**Aktualität (2023-2026):**
- webstake: 35 Monate React → ✅ **2+ Jahre aktuell**

**Buzzword-Matching:**
- `React` → ✅ Market Logic, SVA, webstake
- `Redux` → ✅ Market Logic, webstake
- `React Hooks` → Nicht explizit, aber impliziert durch moderne React-Projekte

---

### M4: 3 Jahre Spring Boot, davon 2 Jahre in letzten 3 Jahren

**Status:** ✅ **ERFÜLLT**

**Nachweis-Berechnung:**

| Projekt | Zeitraum | Monate | Spring Boot nachweisbar |
|---------|----------|--------|-------------------------|
| Market Logic | 09/2007 - 04/2020 | 151 | ✅ Spring Boot |
| SVA | 06/2020 - 12/2022 | 31 | ✅ Spring Boot explizit |
| webstake | 03/2023 - heute | 35 | ✅ Spring |
| **Gesamt** | | **217** | **18+ Jahre** |

**Aktualität (2023-2026):**
- webstake: 35 Monate Spring → ✅ **2+ Jahre aktuell**

**Buzzword-Matching:**
- `Spring Boot` → ✅ Market Logic, SVA, webstake
- `Spring Data JPA` → ✅ SVA explizit
- `REST API` → Impliziert durch Spring-Projekte

---

### M5: Deutsch Muttersprachler/C2

**Status:** ✅ **ERFÜLLT**

**Nachweis:**
- Profil: "Deutsch: Muttersprache" ✅

**Buzzword-Matching:**
- `Muttersprachler` → ✅ Explizit im Profil

---

## Soll-Anforderungen: Detailanalyse

### S1: Reaktive Programmierung (25%)

**Status:** ❌ **NICHT ERFÜLLT**

**Gesuchte Buzzwords:**
- Reaktive Programmierung
- Reactive Programming
- RxJS
- RxJava
- WebFlux
- Project Reactor

**Profil-Analyse:**
- **Keine** dieser Technologien wird im Profil erwähnt
- Redux ist **KEIN** reaktives Framework (es ist ein State-Management-Pattern)
- Keine Observable/Reactive Streams Konzepte genannt

**Gap:**
- Vollständige Lücke
- Benötigt: 24 Monate Erfahrung
- Vorhanden: 0 Monate nachweisbar

**Empfehlung:**
- RxJS-Erfahrung aus React-Projekten könnte vorhanden sein, ist aber nicht dokumentiert
- WebFlux/Project Reactor im Spring-Kontext ggf. ergänzen wenn zutreffend

---

### S2: MUI / Material-UI (25%)

**Status:** ⚠️ **TEILWEISE ERFÜLLT**

**Gesuchte Buzzwords:**
- MUI
- Material-UI
- Material Design

**Profil-Analyse:**
- Profil: "material-ui (+)" = geringe Kenntnisse
- Nicht klar, in welchem Projekt MUI verwendet wurde
- Wahrscheinlich SVA oder webstake (React-Projekte)

**Bewertung:**
- Technologie ist bekannt, aber nicht als fundierte Erfahrung dokumentiert
- Benötigt: 24 Monate Erfahrung
- Vorhanden: Unklar, aber self-rated als "geringe Kenntnisse"

**Gap:**
- Quantitative Lücke (nicht genug Erfahrung)
- Oder: Erfahrung vorhanden, aber nicht dokumentiert

---

### S3: CI/CD-Prozesse (20%)

**Status:** ⚠️ **TEILWEISE ERFÜLLT (implizit)**

**Gesuchte Buzzwords:**
- CI/CD
- Continuous Integration
- Continuous Deployment
- Pipeline
- GitLab CI
- Jenkins

**Profil-Analyse:**
- **Build-Tools:** Gradle (++++) und Maven (+++) = viel Erfahrung
- **Docker:** (++) = einigermaßen vertraut
- **Nexus:** (+++) = viel Erfahrung (Artifact Repository)
- **Kein explizites CI/CD** dokumentiert

**Bewertung:**
- Bei ~25 Jahren Erfahrung ist CI/CD-Nutzung sehr wahrscheinlich
- Nexus deutet auf Pipeline-Integration hin
- Aber: Nicht explizit als Aufgabe/Kompetenz genannt

**Gap:**
- Dokumentationslücke, nicht zwingend Kompetenzlücke
- Benötigt: 12 Monate Erfahrung
- Vorhanden: Implizit vorhanden, aber nicht dokumentiert

---

### S4: Agile/SCRUM/SAFe (20%)

**Status:** ✅ **ERFÜLLT**

**Gesuchte Buzzwords:**
- Agile
- SCRUM
- SAFe
- Kanban

**Profil-Analyse:**
- Profil: "Scrum (+++)" = viel Erfahrung
- Profil: "agile (+++)" = viel Erfahrung

**Nachweis:**
- Market Logic (13 Jahre): Startup → Scaleup, typischerweise agil
- SVA (2.5 Jahre): Kundenprojekte
- webstake (3 Jahre): Aktuelle Projekte

**Buzzword-Matching:**
- `Scrum` → ✅ Explizit im Profil
- `Agile` → ✅ Explizit im Profil
- `SAFe` → ❌ Nicht explizit

**Bewertung:** Erfüllt durch Scrum/Agile-Erfahrung

---

### S5: Eisenbahnbetrieb/Bahnindustrie (10%)

**Status:** ❌ **NICHT ERFÜLLT**

**Gesuchte Buzzwords:**
- Eisenbahnbetrieb
- Bahnindustrie
- Deutsche Bahn
- DB
- ÖPNV
- Verkehrssektor
- Leitsysteme
- Disposition

**Profil-Analyse:**
- **Keine** Bahn- oder Verkehrsprojekte im Profil
- Branchen im Profil: IT/Software, Telekom, Finanzen (Deloitte)

**Gap:**
- Vollständige Lücke
- Benötigt: 12 Monate Erfahrung
- Vorhanden: 0 Monate

**Bewertung:**
- Diese Anforderung kann durch Profil-Optimierung nicht erfüllt werden
- Erfordert tatsächliche Projekterfahrung in der Branche

---

## Gap-Zusammenfassung

### Kritische Gaps (Soll-Anforderungen)

| ID | Anforderung | Gewicht | Gap-Typ | Handlungsempfehlung |
|----|-------------|---------|---------|---------------------|
| **S1** | Reaktive Programmierung | 25% | **Vollständig** | Prüfen ob RxJS/WebFlux in Projekten verwendet wurde, aber nicht dokumentiert |
| **S2** | MUI | 25% | **Dokumentation** | MUI-Nutzung in React-Projekten explizit benennen wenn zutreffend |
| **S3** | CI/CD | 20% | **Dokumentation** | CI/CD-Erfahrung (GitLab, Jenkins) explizit dokumentieren |
| **S5** | Eisenbahn | 10% | **Nicht behebbar** | Keine Bahn-Erfahrung vorhanden |

### Nicht-kritische Gaps

| Bereich | Status | Anmerkung |
|---------|--------|-----------|
| SAFe | ⚠️ Teilweise | Scrum/Agile vorhanden, SAFe nicht explizit genannt |
| Docker/Containerisierung | ⚠️ Teilweise | Docker (++) vorhanden, aber nicht im CI/CD-Kontext |

---

## Stärken des Profils

1. **Sehr lange Java-Erfahrung** (~25 Jahre)
2. **Starke React-Expertise** (++++) mit aktueller Erfahrung
3. **TypeScript-Kompetenz** (++++)
4. **Spring-Ökosystem** vollständig abgedeckt
5. **Deutsch Muttersprachler** - Muss-Anforderung erfüllt
6. **Fullstack-Profil** - Sowohl Frontend als auch Backend abgedeckt
7. **Architektur-Erfahrung** - "Head of Frontend Infrastructure" bei Market Logic

---

## Empfehlungen für Profil-Optimierung

### Priorität 1: Dokumentationslücken schließen

1. **CI/CD explizit machen:**
   - In welchen Projekten wurde CI/CD verwendet?
   - Welche Tools (GitLab CI, Jenkins)?
   - Beispiel-Formulierung: "Einrichtung und Pflege der CI/CD-Pipeline mit GitLab CI"

2. **MUI-Erfahrung konkretisieren:**
   - In welchem Projekt wurde Material-UI verwendet?
   - Wie lange?
   - Beispiel-Formulierung: "Frontend-Entwicklung mit React und Material-UI Komponenten"

### Priorität 2: Reaktive Programmierung

1. **Prüfen ob RxJS verwendet wurde:**
   - Bei React-Projekten (SVA, webstake, Market Logic)
   - Async-Handling mit Observables?

2. **Prüfen ob WebFlux/Reactor verwendet wurde:**
   - Bei Spring-Boot-Projekten
   - Non-blocking APIs?

### Nicht behebbar

- **Eisenbahn-Erfahrung (S5, 10%):** Keine reale Erfahrung vorhanden, kann nicht "hinzuoptimiert" werden

---

## Scoring-Berechnung

### Aktueller Score

```
MUSS-Anforderungen (70% Gewicht):
  M1 Java:       ✅ 100%
  M2 TypeScript: ✅ 100%
  M3 React:      ✅ 100%
  M4 Spring Boot:✅ 100%
  M5 Deutsch:    ✅ 100%
  ────────────────────────
  Muss-Score:    100%

SOLL-Anforderungen (30% Gewicht):
  S1 Reaktive (25%):   ❌   0% →  0.00%
  S2 MUI (25%):        ⚠️  25% →  6.25%
  S3 CI/CD (20%):      ⚠️  25% →  5.00%
  S4 Agile (20%):      ✅ 100% → 20.00%
  S5 Eisenbahn (10%):  ❌   0% →  0.00%
  ────────────────────────────────────
  Soll-Score gewichtet:     31.25%

GESAMTSCORE:
  = (100% × 0.7) + (31.25% × 0.3)
  = 70.00% + 9.38%
  = 79.38% ≈ 79.4%
```

### Potenzieller Score nach Dokumentations-Optimierung

Wenn CI/CD und MUI vollständig dokumentiert werden können:

```
SOLL-Anforderungen (optimiert):
  S1 Reaktive (25%):   ❌   0% →  0.00%
  S2 MUI (25%):        ✅ 100% → 25.00%
  S3 CI/CD (20%):      ✅ 100% → 20.00%
  S4 Agile (20%):      ✅ 100% → 20.00%
  S5 Eisenbahn (10%):  ❌   0% →  0.00%
  ────────────────────────────────────
  Soll-Score gewichtet:     65.00%

GESAMTSCORE (optimiert):
  = (100% × 0.7) + (65% × 0.3)
  = 70.00% + 19.50%
  = 89.50%
```

**Maximale Verbesserung:** +10.1 Prozentpunkte (79.4% → 89.5%)

---

## Fazit

### Stärken
- **Alle Muss-Anforderungen erfüllt** - Das Profil ist grundsätzlich geeignet
- **Sehr starke Java/React/Spring-Kombination** - Passt perfekt zum Fullstack-Anforderungsprofil
- **Lange Berufserfahrung** - Über 25 Jahre Softwareentwicklung

### Schwächen
- **Reaktive Programmierung** - Nicht dokumentiert, größte Soll-Lücke (25%)
- **Eisenbahn-Domänenwissen** - Nicht vorhanden, aber nur 10% gewichtet
- **Einige Dokumentationslücken** - CI/CD und MUI könnten besser dargestellt sein

### Empfehlung
Das Profil ist für die Stelle **grundsätzlich geeignet** (100% Muss-Erfüllung). Die Soll-Lücken könnten durch:
1. Bessere Dokumentation (CI/CD, MUI) teilweise geschlossen werden
2. Reaktive Programmierung als Lernbereitschaft kommuniziert werden
3. Eisenbahn-Erfahrung fehlt, ist aber mit 10% niedrig gewichtet

**Realistische Bewertung:** 79-90% Gesamterfüllung je nach Dokumentationsoptimierung
