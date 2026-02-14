# Requirements Analysis: Deutsche Bahn - Developer Angular Entwicklung

**Erstellt:** 2026-01-26
**Quelle:** BA-0002534_Developer_Senior_DigLB.pdf
**Projekt:** DeBI (Identity & Access Management) - Frontend-Migration von WebDesigner zu Angular
**Kunde:** Deutsche Bahn AG
**Standort:** Frankfurt am Main
**Laufzeit:** 2026-2027 (205 PT + 110 PT)

---

## Zusammenfassung

- **Anzahl Muss-Anforderungen:** 3
- **Anzahl Soll-Anforderungen:** 4
- **Gesamt Buzzwords extrahiert:** 45
- **Buzzword-Gruppen gebildet:** 15
- **Intelligente Ergänzungen:** 12

**Extraktionsmethode:** Extracted from dedicated sections only (Abschnitt 4.1 und 4.2)

---

## Muss-Anforderungen

### Anforderung M1: Erfahrung mit Aufsetzen von Angular-Projekten mit mehreren Entwicklern

**Bereich:** Technologie & Projektmanagement
**Nachweis:** Erfahrungslevel in Jahren ab 5 Jahre

**Buzzwords:**
- Angular
- Angular-Projekt
- Multi-Developer-Setup
- Projektaufbau
- Team-Entwicklung
- Frontend-Architektur
- Projektstruktur

**Buzzword-Gruppen:**
- `Angular UND Projektaufbau`
- `Multi-Developer-Setup UND Team-Entwicklung`
- `Frontend-Architektur`

**Intelligente Ergänzungen:**
- **Monorepo (Nx/Angular CLI Workspaces)** - Bei Multi-Developer-Projekten sind Monorepo-Strukturen Standard für Code-Sharing und konsistente Dependencies
- **Standalone Components** - Ab Angular 14 die moderne Architektur-Basis für neue Projekte
- **Module Federation** - Für Micro-Frontend-Architekturen in großen Teams
- **Angular CLI Schematics** - Für konsistente Code-Generierung im Team
- **ESLint + Prettier** - Standard Code-Quality-Tools in professionellen Angular-Teams

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular UND Projektaufbau`
- `Multi-Developer-Setup UND (Team-Entwicklung ODER Monorepo ODER Module Federation)`
- `(Standalone Components ODER Angular CLI Schematics)`
- `(ESLint ODER Prettier)`

---

### Anforderung M2: Erfahrung mit Einbindung und Pflege von CI/CD

**Bereich:** DevOps & Automatisierung
**Nachweis:** Anzahl Referenzen: 2

**Buzzwords:**
- CI/CD
- Continuous Integration
- Continuous Deployment
- Pipeline
- Jenkins
- GitLab CI
- GitHub Actions
- Automatisierung
- Build-Prozess
- Testing-Automation

**Buzzword-Gruppen:**
- `CI/CD UND Pipeline`
- `(Jenkins ODER GitLab CI ODER GitHub Actions)`
- `Build-Prozess UND Automatisierung`
- `Testing-Automation`

**Intelligente Ergänzungen:**
- **Docker** - Standard für containerisierte Builds in modernen CI/CD-Pipelines
- **Angular Build Optimization** - Wichtig für Performance (Esbuild, Vite ab v16+)
- **Automated Testing (Karma/Jest/Cypress)** - Integraler Bestandteil jeder CI/CD-Pipeline
- **Code Coverage Reports** - Standard-Qualitätssicherung in CI/CD

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `CI/CD UND Pipeline`
- `(Jenkins ODER GitLab CI ODER GitHub Actions) UND Docker`
- `Build-Prozess UND (Esbuild ODER Vite)`
- `(Testing-Automation ODER Karma ODER Jest ODER Cypress)`
- `Code Coverage`

---

### Anforderung M3: Erfahrung mit agilen oder hybriden Projektstrukturen

**Bereich:** Methodik
**Nachweis:** Anzahl Referenzen: 2

**Buzzwords:**
- Agil
- Scrum
- Kanban
- Hybrid
- Wasserfall
- Sprint
- Agile Entwicklung
- Projektmanagement

**Buzzword-Gruppen:**
- `(Agil ODER Scrum ODER Kanban)`
- `(Hybrid UND Wasserfall)`
- `Sprint`
- `Agile Entwicklung`

**Intelligente Ergänzungen:**
- **Daily Standup** - Standard in agilen Teams
- **Sprint Planning/Review/Retrospective** - Kern-Scrum-Ceremonies
- **User Stories** - Standardisierte Anforderungsdefinition in agilen Projekten
- **Definition of Done** - Qualitätssicherung in agilen Teams

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `(Scrum ODER Kanban) UND Agile Entwicklung`
- `(Sprint ODER Daily Standup ODER Sprint Planning)`
- `(User Stories ODER Definition of Done)`
- `Hybrid`

---

## Soll-Anforderungen

### Anforderung S1: Angular-Entwicklung mit Versionen 14 und 20

**Bereich:** Technologie
**Nachweis:** Erfahrungslevel in Jahren ab 5 Jahre
**Gewichtung:** 30%

**Buzzwords:**
- Angular
- Angular 14
- Angular 20
- Angular-Entwicklung
- Frontend-Development
- TypeScript
- RxJS
- Component-Development

**Buzzword-Gruppen:**
- `Angular UND (Angular 14 ODER Angular 20)`
- `TypeScript UND Frontend-Development`
- `RxJS`
- `Component-Development`

**Intelligente Ergänzungen (Fokus v14-v20):**

**Angular 14-15 Features:**
- **Standalone Components** - Neue modullose Architektur ab v14
- **inject() Function** - Dependency Injection außerhalb von Konstruktoren
- **Typed Forms (Reactive Forms)** - Typsichere Form-Validierung ab v14

**Angular 16-17 Features:**
- **Signals** - Neues Reaktivitätssystem ab v16
- **Deferrable Views (@defer)** - Lazy Loading von Template-Teilen ab v17
- **Built-in Control Flow (@if, @for, @switch)** - Neue Template-Syntax ab v17
- **Partial Hydration** - SSR-Optimierung ab v16
- **Esbuild** - Neuer Standard-Builder ab v16

**Angular 18-20 Features:**
- **Zoneless Angular** - Zone.js-freie Architektur ab v18
- **Vite** - Alternative zu Webpack/Esbuild
- **SSR Improvements** - Verbesserte Server-Side Rendering

**Begründung:**
Die explizite Anforderung von Angular 14 und 20 zeigt, dass moderne Angular-Features und aktuelle Architekturkonzepte erwartet werden. Der Sprung von v14 auf v20 umfasst fundamentale Änderungen (Signals, Zoneless, neue Control Flow, Deferrable Views), die charakteristisch für die aktuelle Angular-Evolution sind.

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular UND TypeScript UND RxJS`
- `(Angular 14 ODER Angular 20)`
- `(Standalone Components ODER inject() ODER Typed Forms)` [v14-15]
- `(Signals ODER @defer ODER @if ODER @for ODER @switch)` [v16-17]
- `(Esbuild ODER Vite)`
- `(Zoneless Angular ODER Partial Hydration)` [v18-20]

---

### Anforderung S2: Erfahrung mit Angular-Upgrades von Version 14 bis 20

**Bereich:** Technologie & Migration
**Nachweis:** Erfahrungslevel in Jahren ab 3 Jahre
**Gewichtung:** 30%

**Buzzwords:**
- Angular-Upgrade
- Migration
- Version 14
- Version 20
- Breaking Changes
- Refactoring
- Compatibility
- ng update
- Deprecation Handling

**Buzzword-Gruppen:**
- `Angular-Upgrade UND Migration`
- `(Version 14 ODER Version 20)`
- `Breaking Changes UND Refactoring`
- `ng update`
- `Deprecation Handling`

**Intelligente Ergänzungen:**
- **Migration zu Standalone Components** - Kernthema bei Upgrade von v14 → v20
- **Migration zu Built-in Control Flow** - Pflicht ab v17 (Ersatz für *ngIf, *ngFor)
- **Zone.js Removal Strategy** - Wichtig für v18+ Zoneless-Architektur
- **ESLint Migration** - TSLint → ESLint ist Standard seit v12/v13
- **Webpack → Esbuild/Vite Migration** - Build-Tool-Wechsel ab v16
- **RxJS Interop with Signals** - Integration alter RxJS-Code mit neuen Signals

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular-Upgrade UND Migration`
- `(Version 14 ODER Version 20) UND ng update`
- `Breaking Changes UND (Refactoring ODER Deprecation Handling)`
- `(Migration zu Standalone Components ODER Built-in Control Flow)`
- `(Zoneless Angular ODER Zone.js Removal)`
- `(ESLint Migration ODER Webpack zu Esbuild)`
- `(Signals ODER RxJS Interop)`

---

### Anforderung S3: Erfahrung mit Nutzung der API des One Identity Manager 9.2.2 bei Frontendmigration

**Bereich:** Spezifische Technologie
**Nachweis:** Anzahl Referenzen: 2
**Gewichtung:** 20%

**Buzzwords:**
- One Identity Manager
- Identity Manager 9.2.2
- API
- Frontend-Migration
- IAM (Identity & Access Management)
- REST API
- API Integration
- Backend-Integration

**Buzzword-Gruppen:**
- `One Identity Manager UND API`
- `Identity Manager 9.2.2`
- `Frontend-Migration UND API Integration`
- `IAM`
- `REST API`

**Intelligente Ergänzungen:**
- **OAuth2/OpenID Connect** - Standard-Authentifizierung für IAM-Systeme
- **JWT (JSON Web Tokens)** - Token-basierte Authentifizierung
- **RBAC (Role-Based Access Control)** - Kern-Konzept in IAM-Systemen
- **HttpClient (Angular)** - Standard für API-Calls in Angular
- **RxJS Operators** - Für komplexe API-Datenstrom-Verarbeitung

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `One Identity Manager UND API UND Identity Manager 9.2.2`
- `Frontend-Migration UND REST API`
- `IAM UND (RBAC ODER OAuth2 ODER OpenID Connect)`
- `(JWT ODER Token-basierte Authentifizierung)`
- `HttpClient UND RxJS`

---

### Anforderung S4: Erfahrung mit Nutzung und Customizing der Angular-Libraries des One Identity Manager ab 9.2.2 bei Frontendmigration

**Bereich:** Spezifische Technologie
**Nachweis:** Anzahl Referenzen: 2
**Gewichtung:** 20%

**Buzzwords:**
- Angular-Libraries
- One Identity Manager
- Customizing
- Library-Integration
- Frontend-Migration
- Component Library
- UI-Komponenten
- Angular Modules
- npm Packages

**Buzzword-Gruppen:**
- `Angular-Libraries UND One Identity Manager`
- `Customizing UND Library-Integration`
- `Frontend-Migration`
- `Component Library UND UI-Komponenten`
- `(Angular Modules ODER npm Packages)`

**Intelligente Ergänzungen:**
- **Component Inheritance/Extension** - Für Customizing von Library-Komponenten
- **Angular Material** - Oft Basis für Enterprise UI-Libraries
- **Theme Customization** - Anpassung von Library-Styles
- **Dependency Injection Override** - Für Custom-Services in Libraries
- **Module Federation** - Für dynamisches Laden von Library-Chunks
- **Nx Monorepo** - Standard für Library-Management in Enterprise-Projekten

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular-Libraries UND One Identity Manager`
- `Customizing UND (Component Library ODER UI-Komponenten)`
- `(Component Inheritance ODER Component Extension)`
- `(Angular Material ODER Theme Customization)`
- `(Dependency Injection Override ODER Module Federation)`
- `(npm Packages ODER Nx Monorepo)`

---

## Alle Buzzwords (Alphabetisch)

```
@
- @defer (Deferrable Views)
- @if, @for, @switch (Built-in Control Flow)

A
- Agil
- Agile Entwicklung
- Angular
- Angular 14
- Angular 20
- Angular CLI Schematics
- Angular Material
- Angular Modules
- Angular-Entwicklung
- Angular-Libraries
- Angular-Projekt
- Angular-Upgrade
- API
- API Integration
- Automated Testing
- Automatisierung

B
- Backend-Integration
- Breaking Changes
- Build-Prozess
- Built-in Control Flow

C
- CI/CD
- Code Coverage
- Component Development
- Component Extension
- Component Inheritance
- Component Library
- Continuous Deployment
- Continuous Integration
- Customizing
- Cypress

D
- Daily Standup
- Definition of Done
- Dependency Injection Override
- Deprecation Handling
- Docker

E
- Esbuild
- ESLint
- ESLint Migration

F
- Frontend-Architektur
- Frontend-Development
- Frontend-Migration

G
- GitHub Actions
- GitLab CI

H
- HttpClient
- Hybrid

I
- IAM (Identity & Access Management)
- Identity Manager 9.2.2
- inject() Function

J
- Jenkins
- Jest
- JWT (JSON Web Tokens)

K
- Kanban
- Karma

L
- Library-Integration

M
- Migration
- Migration zu Built-in Control Flow
- Migration zu Standalone Components
- Module Federation
- Monorepo
- Multi-Developer-Setup

N
- ng update
- npm Packages
- Nx Monorepo

O
- OAuth2
- One Identity Manager
- OpenID Connect

P
- Partial Hydration
- Pipeline
- Prettier
- Projektaufbau
- Projektmanagement
- Projektstruktur

R
- RBAC (Role-Based Access Control)
- Refactoring
- REST API
- RxJS
- RxJS Interop
- RxJS Operators

S
- Scrum
- Signals
- Sprint
- Sprint Planning
- Standalone Components
- SSR Improvements

T
- Team-Entwicklung
- Testing-Automation
- Theme Customization
- Token-basierte Authentifizierung
- TSLint
- TypeScript
- Typed Forms

U
- UI-Komponenten
- User Stories

V
- Version 14
- Version 20
- Vite

W
- Wasserfall
- Webpack
- Webpack zu Esbuild Migration

Z
- Zone.js Removal
- Zoneless Angular
```

---

## Alle Buzzword-Gruppen (Übersicht)

### Technologie-Stack (Core)
- `Angular UND TypeScript UND RxJS`
- `(Angular 14 ODER Angular 20)`
- `Frontend-Development UND Component Development`

### Moderne Angular Features (v14-v20)
- `(Standalone Components ODER inject() ODER Typed Forms)` [v14-15]
- `(Signals ODER @defer ODER @if ODER @for ODER @switch)` [v16-17]
- `(Zoneless Angular ODER Partial Hydration)` [v18-20]
- `(Esbuild ODER Vite)` [Build Tools]

### Projektaufbau & Team
- `Angular UND Projektaufbau`
- `Multi-Developer-Setup UND (Team-Entwicklung ODER Monorepo ODER Module Federation)`
- `(Angular CLI Schematics ODER Nx Monorepo)`
- `(ESLint ODER Prettier)`

### CI/CD & DevOps
- `CI/CD UND Pipeline`
- `(Jenkins ODER GitLab CI ODER GitHub Actions) UND Docker`
- `Build-Prozess UND (Esbuild ODER Vite)`
- `(Testing-Automation ODER Karma ODER Jest ODER Cypress)`
- `Code Coverage`

### Migration & Upgrade
- `Angular-Upgrade UND Migration UND ng update`
- `Breaking Changes UND (Refactoring ODER Deprecation Handling)`
- `(Migration zu Standalone Components ODER Built-in Control Flow)`
- `(Zoneless Angular ODER Zone.js Removal)`
- `(ESLint Migration ODER Webpack zu Esbuild)`

### One Identity Manager (Spezifisch)
- `One Identity Manager UND API UND Identity Manager 9.2.2`
- `Frontend-Migration UND REST API`
- `Angular-Libraries UND One Identity Manager`
- `Customizing UND (Component Library ODER UI-Komponenten)`

### IAM & Security
- `IAM UND (RBAC ODER OAuth2 ODER OpenID Connect)`
- `(JWT ODER Token-basierte Authentifizierung)`
- `HttpClient UND RxJS`

### Library Management
- `(Component Inheritance ODER Component Extension)`
- `(Angular Material ODER Theme Customization)`
- `(Dependency Injection Override ODER Module Federation)`
- `(npm Packages ODER Nx Monorepo)`

### Agile Methoden
- `(Scrum ODER Kanban) UND Agile Entwicklung`
- `(Sprint ODER Daily Standup ODER Sprint Planning)`
- `(User Stories ODER Definition of Done)`
- `Hybrid`

---

## Projekt-Kontext (aus Job Description)

### Projektbeschreibung
Bei der Deutschen Bahn wird DeBI konzernweit als Identity & Access Management (IAM)-Tool eingesetzt. Es basiert auf dem Identity Manager von One Identity, wurde aber deutlich angepasst.

**Hauptaufgabe:** Das Frontend basiert auf dem abgekündigten WebDesigner und muss auf Angular migriert werden.

**Unterstützung:** Der Hersteller stellt eine API und ein Angular-Projekt für den Standard zur Verfügung.

**Parallel:** Zu dieser Migration erfolgt für DeBI Betrieb, Fehlerbehebung und fachliche Weiterentwicklung.

### Arbeitsweise
- Mehrere Projektteams nach Teilprojekten organisiert
- Hybride Modelle (Wasserfall & agile Vorgehensweise)
- Projektsprache: Deutsch (C1/C2 verhandlungssicher)

### Scope (Aus Sektion 3.1)
- Programmierung/Implementierung/Customizing technischer Komponenten
- Beheben von Fehlern aus Testphasen
- Dokumentation der technischen Komponenten
- Erstellen von Systemdokumentationen
- Erstellen von Lieferpaketen

---

## Nächste Schritte

**Phase 2 (zukünftig):**
- Profil-Analyse von Hossein Samadipour gegen diese Anforderungen
- Matching-Score berechnen (Muss vs. Soll)
- Gap-Analyse durchführen
- Optimierungsvorschläge generieren

**Datei-Struktur:**
- Input-Dateien: `inputs/job-description.pdf`, `inputs/employee-profile.pdf`
- Phase 1 Output: `01-requirements-analysis.md` (diese Datei)
- Phase 2 Output: `02-profile-matching.md` (zukünftig)

---

## Besondere Highlights

✓ **Moderne Angular-Versionen:** Explizite Anforderung von v14-v20 deutet auf hochmoderne Architektur hin (Signals, Zoneless, neue Control Flow)

✓ **Enterprise-Projekt:** Deutsche Bahn Konzernprojekt mit hohen Qualitätsanforderungen

✓ **Spezifisches IAM-Know-how:** One Identity Manager 9.2.2 ist Spezialtechnologie - Erfahrung damit ist wertvoll

✓ **Frontend-Migration:** Kritisches Projekt - Ablösung deprecated WebDesigner zu Angular

✓ **Hybride Methodik:** Kombination aus Wasserfall & Agil erfordert methodische Flexibilität

✓ **CI/CD obligatorisch:** DevOps-Kenntnisse sind Muss-Anforderung, nicht nur Nice-to-have

⚠ **Onsite-Anteil:** 22 PT (2026) + 12 PT (2027) in Frankfurt am Main erforderlich

⚠ **Lange Laufzeit:** Bis zu 315 PT über 2 Jahre - stabiles, langfristiges Engagement
