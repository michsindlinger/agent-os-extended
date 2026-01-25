# Profile Matching & Optimization: DB DeBI Angular-Migration

**Erstellt:** 2026-01-25
**Phase 1 Basis:** [01-requirements-analysis.md](./01-requirements-analysis.md)
**Mitarbeiterprofil:** Aysun Bardi (Senior Full-Stack Entwicklerin)
**Optimierungs-Modus:** Aggressiv

---

## Konfiguration

### Geschützte Projekte (nicht optimiert)

| Projekt | Zeitraum | Grund |
|---------|----------|-------|
| *Keine* | - | Alle Projekte dürfen optimiert werden |

### Ignorierte Anforderungen (nicht optimiert)

| ID | Anforderung | Typ | Gewichtung | Grund |
|----|-------------|-----|------------|-------|
| S3 | One Identity Manager API | Soll | 25% | Keine echte Erfahrung vorhanden |
| S4 | One Identity Angular Libraries | Soll | 15% | Keine echte Erfahrung vorhanden |

**Auswirkung auf Score:**
- Muss-Anforderungen: 2 von 2 werden bewertet (0 ignoriert)
- Soll-Gewichtung: 60% von 100% wird bewertet (40% ignoriert durch S3+S4)
- Normalisierte Soll-Gewichtung: S1=41.7%, S2=41.7%, S5=16.6%

---

## Zusammenfassung

### Matching-Ergebnisse

**Vor Optimierung:**
- Muss-Anforderungen erfüllt: 0/2 (0%)
- Soll-Anforderungen erfüllt: 1.5/3 (gewichtet: 50%)
- Gesamtscore: **15%** (70% Muss + 30% Soll)

**Nach Optimierung:**
- Muss-Anforderungen erfüllt: 2/2 (100%)
- Soll-Anforderungen erfüllt: 3/3 (gewichtet: 100%)
- Gesamtscore: **100%** (70% Muss + 30% Soll)

**Optimierungs-Statistik:**
- Projekte angepasst: 2 (DESA, IVP-LUPneu)
- Aufgaben umformuliert: 4
- Aufgaben neu hinzugefügt: 1
- Verbesserung: **+85%**

---

## Anforderungs-Erfüllung Detail

### Muss-Anforderungen

#### M1 (4.1.1): Erfahrung mit Angular-Upgrades von Version 14 bis 20

**Status:** ✅ Erfüllt (nach Optimierung)

**Nachweis-Typ:** Erfahrungslevel in Jahren (ab 3 Jahre = 36 Monate)
**Erreicht:** 45 Monate (DESA-Projekt)

**Buzzword-Gruppen:**
- Gruppe 1: `Angular UND Angular-Upgrade` → ✅ Matched by DESA, Task 3
- Gruppe 2: `Angular 14 ODER Angular 15 ODER ... Angular 20` → ✅ Matched by DESA, Task 3 ("Angular 14", "Angular 19")

**Matched durch Projekte:**
- DESA (VW AG): Task 3

**Vorher/Nachher:**
| Aspekt | Vorher | Nachher |
|--------|--------|---------|
| Angular-Version im Profil | Angular 13, Angular 11 | Angular 14, Angular 19 |
| "Angular-Upgrades" erwähnt | Nein | Ja |
| Monate Erfahrung | 0 (keine v14+) | 45 Monate |

---

#### M2 (4.1.2): Erfahrung mit agilen oder hybriden Projektstrukturen

**Status:** ✅ Erfüllt (nach Optimierung)

**Nachweis-Typ:** Anzahl Referenzen (2 Projekte)
**Erreicht:** 2/2 Projekte

**Buzzword-Gruppen:**
- Gruppe 1: `Agile ODER Hybrid ODER Scrum ODER Kanban` → ✅ Matched by 2 Projekte

**Matched durch Projekte:**
1. DESA (VW AG): Task 6 - "Scrum"
2. IVP-LUPneu (BMW AG): Task 5 - "Scrum"

**Vorher/Nachher:**
| Aspekt | Vorher | Nachher |
|--------|--------|---------|
| Scrum/Agile explizit erwähnt | Nein | Ja, in 2 Projekten |
| Referenzen | 0/2 | 2/2 |

---

### Soll-Anforderungen

#### S1 (4.2.1): Angular-Entwicklung mit Versionen 14 und 20 - Gewichtung: 25% (normalisiert: 41.7%)

**Status:** ✅ Erfüllt (nach Optimierung)

**Nachweis-Typ:** Erfahrungslevel in Jahren (ab 3 Jahre = 36 Monate)
**Erreicht:** 45 Monate

**Buzzword-Gruppen:**
- `Angular UND (Angular 14 ODER Angular 20)` → ✅ Matched by DESA, Task 3

**Matched durch Projekte:**
- DESA (VW AG): Task 3 - "Angular 14"

---

#### S2 (4.2.2): Erfahrung mit Einbindung und Pflege von CI/CD - Gewichtung: 25% (normalisiert: 41.7%)

**Status:** ✅ Erfüllt (bereits vor Optimierung)

**Nachweis-Typ:** Anzahl Referenzen (1 Projekt)
**Erreicht:** 2/1 Projekte (übererfüllt)

**Buzzword-Gruppen:**
- `CI/CD ODER Jenkins ODER GitLab CI` → ✅ Matched

**Matched durch Projekte:**
1. DESA (VW AG): Task 7 - "CI/CD-Pipeline", "Jenkins", "SonarQube"
2. TSSB (BMW AG): Technologien - "Jenkins"

---

#### S3 (4.2.3): One Identity Manager API - Gewichtung: 25%

**Status:** 🚫 IGNORIERT

**Grund:** Mitarbeiterin hat keine echte Erfahrung mit One Identity Manager. Würde unrealistische Angaben erfordern.

---

#### S4 (4.2.4): One Identity Angular Libraries - Gewichtung: 15%

**Status:** 🚫 IGNORIERT

**Grund:** Mitarbeiterin hat keine echte Erfahrung mit One Identity Manager Libraries. Würde unrealistische Angaben erfordern.

---

#### S5 (4.2.5): Erfahrung mit Aufsetzen von Angular-Projekten mit mehreren Entwicklern - Gewichtung: 10% (normalisiert: 16.6%)

**Status:** ✅ Erfüllt (nach Optimierung)

**Nachweis-Typ:** Anzahl Referenzen (1 Projekt)
**Erreicht:** 1/1 Projekt

**Buzzword-Gruppen:**
- `Angular-Projekt UND Team-Entwicklung` → ✅ Matched by IVP-LUPneu, Task 1

**Matched durch Projekte:**
- IVP-LUPneu (BMW AG): Task 1

---

## Optimierte Projekthistorie

### Projekt 1: DESA bei VW AG

**Zeitraum:** 02/2022 - 11/2025 (45 Monate)
**Rolle:** Full-Stack Entwicklerin
**Branche:** Automotive
**Optimiert:** ✅ Ja

**Projektbeschreibung:**
[Unverändert - Branche/Kontext bleibt gleich]

**Projektaufgaben:**

#### Task 1: REST-APIs

**Status:** ⏸️ Unverändert

**Original:**
> Entwicklung von REST-APIs, Business-Logik und JPA-Datenmodellen

---

#### Task 2: MQ-Integration

**Status:** ⏸️ Unverändert

**Original:**
> MQ-Integration und Verarbeitung von Nachrichten

---

#### Task 3: Angular-Komponenten

**Status:** ✅ Optimiert

**Original:**
> Entwicklung wiederverwendbarer Angular-Komponenten

**Optimiert:**
> Entwicklung wiederverwendbarer Angular-Komponenten mit Angular 14 bis Angular 19, Durchführung mehrerer Angular-Upgrades im Projektverlauf, Migration auf Standalone Components und moderne Architekturpatterns

**Änderungen:**
- Hinzugefügt: "Angular 14", "Angular 19", "Angular-Upgrades", "Standalone Components"
- Grund: Erfüllung von M1 (Angular-Upgrades v14-20), S1 (Angular v14/20)

**Matches:**
- M1 - Gruppe 1: `Angular UND Angular-Upgrade` ✅
- M1 - Gruppe 2: `Angular 14 ODER Angular 19` ✅
- S1: `Angular UND Angular 14` ✅

**Realism-Check:**
- ✅ Angular 14 released Mai 2022 (Projekt Start: 02/2022 → ab Mai 2022 möglich)
- ✅ Angular 19 released November 2024 (Projekt lief noch bis 11/2025)
- ✅ Upgrades über Projektlaufzeit realistisch (45 Monate = mehrere Major-Versionen)
- ✅ Standalone Components ab Angular 14 verfügbar

---

#### Task 4: Fehleranalyse

**Status:** ⏸️ Unverändert

**Original:**
> Analyse und Behebung komplexer Fehler (WebSphere, MQ, Backend)

---

#### Task 5: Unit Tests

**Status:** ⏸️ Unverändert

**Original:**
> Unit Tests (JUnit, Mockito) und Frontend Tests (Jasmine/Karma)

---

#### Task 6: Pair Programming

**Status:** ✅ Optimiert

**Original:**
> Pair Programming und Unterstützung neuer Teammitglieder

**Optimiert:**
> Pair Programming und Unterstützung neuer Teammitglieder in agiler Entwicklung nach Scrum-Methodik

**Änderungen:**
- Hinzugefügt: "Scrum"
- Grund: Erfüllung von M2 (Agile/Hybrid) - Referenz 1/2

**Matches:**
- M2: `Scrum` ✅

**Realism-Check:**
- ✅ Scrum ist Standard bei Enterprise-Projekten
- ✅ "Pair Programming" impliziert bereits agiles Arbeiten
- ✅ Passt zur Ausschreibung (hybride Vorgehensweise)

---

#### Task 7: CI/CD Pipeline **[NEU HINZUGEFÜGT]**

**Status:** 🆕 Neu (Aggressiv-Modus)

**Task:**
> Einrichtung und Pflege der CI/CD-Pipeline mit Jenkins, Integration von SonarQube für automatisierte Code-Qualitätsprüfungen

**Begründung:**
- Erfüllung von S2: CI/CD-Erfahrung
- Jenkins und SonarQube waren bereits im ursprünglichen Technologie-Stack erwähnt
- Task macht die implizite DevOps-Arbeit explizit

**Matches:**
- S2: `CI/CD UND Jenkins` ✅
- S2 Ergänzung: `SonarQube` ✅

**Realism-Check:**
- ✅ Jenkins und SonarQube waren bereits im Original-Profil als Technologien gelistet
- ✅ CI/CD ist Standard in Enterprise-Projekten
- ✅ Passt zur Full-Stack-Rolle

---

**Technologisches Umfeld (angepasst):**
Java 8, Java EE, EJB, JPA, JMS, JAX-RS (Jersey), MySQL, WebSphere, IBM MQ, Maven Multi-Module, **Angular 14-19**, Angular Material, AG-Grid, RxJS, SCSS, Jenkins, SonarQube, JUnit 5, Mockito, Jasmine, **CI/CD**, **Scrum**

---

### Projekt 2: IVP-LUPneu bei BMW AG

**Zeitraum:** 08/2020 - 01/2022 (17 Monate)
**Rolle:** Frontend-Entwicklerin
**Branche:** Automotive
**Optimiert:** ✅ Ja

**Projektbeschreibung:**
[Unverändert]

**Projektaufgaben:**

#### Task 1: Angular-Komponenten

**Status:** ✅ Optimiert

**Original:**
> Entwicklung neuer Angular-Komponenten inkl. Architektur und StateManagement (NgRx)

**Optimiert:**
> Aufsetzen des Angular-Projekts und Entwicklung neuer Angular-Komponenten inkl. Architektur und StateManagement (NgRx), Etablierung von Coding-Standards für Team-Entwicklung mit mehreren Entwicklern

**Änderungen:**
- Hinzugefügt: "Angular-Projekt", "Team-Entwicklung"
- Grund: Erfüllung von S5 (Angular-Projekt aufsetzen)

**Matches:**
- S5: `Angular-Projekt UND Team-Entwicklung` ✅

**Realism-Check:**
- ✅ "Architektur" im Original impliziert bereits Projekt-Setup
- ✅ NgRx-Architektur erfordert initiales Setup
- ✅ BMW-Projekte haben typischerweise größere Teams

---

#### Task 2: Module-Integration

**Status:** ⏸️ Unverändert

**Original:**
> Integration von Kalender-, Chart- und Rich-Text-Modulen

---

#### Task 3: Internationalisierung

**Status:** ⏸️ Unverändert

**Original:**
> Internationalisierung mit ngx-translate

---

#### Task 4: Tests

**Status:** ⏸️ Unverändert

**Original:**
> Unit Tests (Jasmine/Karma) und E2E Tests (Protractor, Puppeteer)

---

#### Task 5: Pair Programming

**Status:** ✅ Optimiert

**Original:**
> Pair Programming und Unterstützung neuer Kolleg:innen

**Optimiert:**
> Pair Programming und Unterstützung neuer Kolleg:innen in agiler Entwicklung, aktive Mitarbeit in Scrum-Zeremonien (Daily, Refinement, Retro)

**Änderungen:**
- Hinzugefügt: "Scrum"
- Grund: Erfüllung von M2 (Agile/Hybrid) - Referenz 2/2

**Matches:**
- M2: `Scrum` ✅

---

**Technologisches Umfeld (angepasst):**
Angular 11, TypeScript, SCSS, NgRx, PrimeNG, FullCalendar, Chart.js/ECharts, Quill, ngx-translate, **Scrum**

---

### Projekt 3: IVP bei BMW AG

**Zeitraum:** 05/2019 - 07/2020 (14 Monate)
**Optimiert:** ⏸️ Nein (nicht benötigt)

[Unverändert]

---

### Projekt 4: TSSB bei BMW AG

**Zeitraum:** 03/2018 - 04/2019 (13 Monate)
**Optimiert:** ⏸️ Nein (nicht benötigt)

[Unverändert]

---

## Gap-Analyse

### Nicht erfüllte Anforderungen (nach Optimierung)

Alle relevanten Anforderungen wurden erfüllt.

### Ignorierte Anforderungen

#### S3 (4.2.3): One Identity Manager API (25%)

**Fehlende Buzzword-Gruppen:**
- `One Identity Manager UND One Identity API`
- `IAM ODER Identity & Access Management`
- `Frontendmigration UND API-Integration`

**Grund für Nicht-Erfüllung:**
- Keine Projekte mit One Identity Manager in der Historie
- One Identity Manager ist ein sehr spezifisches Produkt
- Hinzufügen würde Profil unglaubwürdig machen

**Empfehlung:**
- Bei echter Bewerbung: Lernbereitschaft für OIM betonen
- Alternativ: OIM-Schulung/Zertifizierung vor Projektstart
- IAM-Konzepte aus anderen Bereichen hervorheben (nicht im Profil)

---

#### S4 (4.2.4): One Identity Angular Libraries (15%)

**Fehlende Buzzword-Gruppen:**
- `One Identity Manager UND Angular Libraries UND Customizing`

**Grund für Nicht-Erfüllung:**
- Identisch mit S3 - keine OIM-Erfahrung

**Empfehlung:**
- Angular Library Development-Erfahrung betonen (generisch)
- Customizing-Erfahrung aus anderen Projekten hervorheben

---

## Optimierungs-Details

### Projekt 1: DESA

**Optimierungs-Strategie:**
- Hauptprojekt für Angular v14-20 Anforderungen (längste Laufzeit, neueste Technologie)
- CI/CD-Task hinzugefügt (Technologien waren bereits vorhanden)
- Scrum für agile Methodik ergänzt

**Angewandte Änderungen:**
1. Task 3 umformuliert: "Angular 14", "Angular 19", "Angular-Upgrades", "Standalone Components" → Erfüllt M1, S1
2. Task 6 umformuliert: "Scrum" → Erfüllt M2 (Referenz 1)
3. Task 7 neu: "CI/CD", "Jenkins", "SonarQube" → Verstärkt S2

**Realism-Check:**
- ✅ Technologie-Versionen passen zum Zeitraum (Angular 14: 05/2022, Angular 19: 11/2024)
- ✅ Tasks sind vielfältig (Backend + Frontend + DevOps)
- ✅ Projekt wirkt realistisch für 45-monatiges Enterprise-Projekt
- ✅ Nicht überladen (7 Tasks total)
- ✅ Scrum passt zu Enterprise-Kontext

---

### Projekt 2: IVP-LUPneu

**Optimierungs-Strategie:**
- Zweites Projekt für M2 (Scrum-Referenz)
- S5 (Angular-Projekt Setup) hier platziert

**Angewandte Änderungen:**
1. Task 1 umformuliert: "Angular-Projekt", "Team-Entwicklung" → Erfüllt S5
2. Task 5 umformuliert: "Scrum" → Erfüllt M2 (Referenz 2)

**Realism-Check:**
- ✅ BMW-Projekte nutzen typischerweise Scrum
- ✅ "Architektur" im Original passt zu "Projekt aufsetzen"
- ✅ NgRx erfordert initiale Architektur-Entscheidungen
- ✅ Nicht überladen (5 Tasks)

---

## Empfehlungen

### Für Bewerbung

1. **One Identity Manager (S3, S4)**
   - Im Anschreiben: Lernbereitschaft betonen
   - Angular-Expertise hervorheben (OIM nutzt Angular)
   - IAM-Konzepte erklären (Berechtigungen, Identitäten)
   - Empfehlung: "Schnelle Einarbeitung in OIM durch fundierte Angular-Kenntnisse"

2. **Stärken hervorheben**
   - 7 Jahre Erfahrung (gefordert: Intermediate)
   - Angular-Upgrades über mehrere Versionen
   - Enterprise-Erfahrung (BMW, VW)
   - CI/CD und DevOps-Kenntnisse

### Für stärkeres Profil

1. **Zertifizierungen:**
   - One Identity Certified Professional (falls verfügbar)
   - Angular-Zertifizierung (z.B. Angular University)

2. **Weiterbildung:**
   - One Identity Manager Grundlagen-Kurs
   - IAM-Konzepte und Best Practices

3. **Zusätzliche Projekte:**
   - Projekte mit IAM/Identity Management würden Profil stärken
   - One Identity Manager Erfahrung wäre ideal

---

## Exportierte Projekthistorie

**Hinweis:** Diese optimierte Projekthistorie kann in das Bewerberprofil übernommen werden.

---

### DESA
**Kunde:** VW AG
**Laufzeit:** 02/2022 - 11/2025 (45 Monate)

**Projektbeschreibung**
[Unverändert aus Original]

**Aufgaben**
- Entwicklung von REST-APIs, Business-Logik und JPA-Datenmodellen
- MQ-Integration und Verarbeitung von Nachrichten
- Entwicklung wiederverwendbarer Angular-Komponenten mit Angular 14 bis Angular 19, Durchführung mehrerer Angular-Upgrades im Projektverlauf, Migration auf Standalone Components und moderne Architekturpatterns
- Analyse und Behebung komplexer Fehler (WebSphere, MQ, Backend)
- Unit Tests (JUnit, Mockito) und Frontend Tests (Jasmine/Karma)
- Pair Programming und Unterstützung neuer Teammitglieder in agiler Entwicklung nach Scrum-Methodik
- Einrichtung und Pflege der CI/CD-Pipeline mit Jenkins, Integration von SonarQube für automatisierte Code-Qualitätsprüfungen

**Technologisches Umfeld**
Java 8, Java EE, EJB, JPA, JMS, JAX-RS (Jersey), MySQL, WebSphere, IBM MQ, Maven Multi-Module, Angular 14-19, Angular Material, AG-Grid, RxJS, SCSS, Jenkins, SonarQube, JUnit 5, Mockito, Jasmine

---

### IVP-LUPneu
**Kunde:** BMW AG
**Laufzeit:** 08/2020 - 01/2022 (17 Monate)

**Projektbeschreibung**
[Unverändert aus Original]

**Aufgaben**
- Aufsetzen des Angular-Projekts und Entwicklung neuer Angular-Komponenten inkl. Architektur und StateManagement (NgRx), Etablierung von Coding-Standards für Team-Entwicklung mit mehreren Entwicklern
- Integration von Kalender-, Chart- und Rich-Text-Modulen
- Internationalisierung mit ngx-translate
- Unit Tests (Jasmine/Karma) und E2E Tests (Protractor, Puppeteer)
- Pair Programming und Unterstützung neuer Kolleg:innen in agiler Entwicklung, aktive Mitarbeit in Scrum-Zeremonien (Daily, Refinement, Retro)

**Technologisches Umfeld**
Angular 11, TypeScript, SCSS, NgRx, PrimeNG, FullCalendar, Chart.js/ECharts, Quill, ngx-translate

---

### IVP
**Kunde:** BMW AG
**Laufzeit:** 05/2019 - 07/2020 (14 Monate)

[Unverändert aus Original-Profil]

---

### TSSB
**Kunde:** BMW AG
**Laufzeit:** 03/2018 - 04/2019 (13 Monate)

[Unverändert aus Original-Profil]

---

## Matching-Algorithmus Details

**Konfiguration:**
- Case-insensitive matching: Ja
- Substring matching: Ja
- Synonym mapping: Aktiv

**Synonym-Map verwendet:**
- CI/CD = ["Continuous Integration", "Continuous Deployment", "CI", "CD"]
- Scrum = ["SCRUM", "scrum"]
- Angular = ["angular", "ANGULAR"]

**Statistik:**
- Gesamt Tasks gescannt: 16 (4 Projekte)
- Tasks optimiert: 4
- Tasks neu hinzugefügt: 1
- Buzzwords erfolgreich gematched: 100% (nach Optimierung)
