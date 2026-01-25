# Requirements Analysis: DB DeBI Angular-Migration

**Erstellt:** 2026-01-25
**Quelle:** BA-0002534_Developer_Intermediate_DigLB.pdf
**Projekt:** DeBI - Identity & Access Management (IAM) Frontend-Migration
**Kunde:** Deutsche Bahn AG

---

## Zusammenfassung

- **Anzahl Muss-Anforderungen:** 2
- **Anzahl Soll-Anforderungen:** 5
- **Gesamt Buzzwords extrahiert:** 47
- **Buzzword-Gruppen gebildet:** 7
- **Intelligente Ergänzungen:** 13

**Projektkontext:**
Migration des DeBI-Frontends von abgekündigtem WebDesigner auf Angular. Nutzung der One Identity Manager API und Angular-Libraries. Hybride Projektstruktur (Wasserfall & Agile).

---

## Muss-Anforderungen

### Anforderung M1 (4.1.1): Erfahrung mit Angular-Upgrades von Version 14 bis 20

**Bereich:** Technologie
**Nachweis:** Erfahrungslevel in Jahren - ab 3 Jahre

**Buzzwords:**
- Angular
- Angular 14
- Angular 15
- Angular 16
- Angular 17
- Angular 18
- Angular 19
- Angular 20
- Angular-Upgrade
- Angular-Migration
- Frontend-Migration

**Buzzword-Gruppen:**
- `Angular UND Angular-Upgrade`
- `Angular 14 ODER Angular 15 ODER Angular 16 ODER Angular 17 ODER Angular 18 ODER Angular 19 ODER Angular 20`

**Intelligente Ergänzungen:**
- **Standalone Components** - Ab Angular 14, grundlegender Architekturwechsel für moderne Angular-Projekte
- **Typed Reactive Forms** - Ab Angular 14, verbesserte Type-Safety für Formulare
- **inject() function** - Ab Angular 14, moderne Dependency Injection ohne Constructor
- **Signals** - Ab Angular 16, reaktives State-Management als Alternative zu RxJS
- **@defer (Deferrable Views)** - Ab Angular 17, Lazy-Loading von Template-Teilen
- **Built-in Control Flow (@if, @for, @switch)** - Ab Angular 17, neue Template-Syntax
- **Zoneless Angular** - Ab Angular 18, Performance-Optimierung ohne Zone.js
- **Partial Hydration** - Ab Angular 18, SSR-Optimierung
- **Esbuild/Vite** - Ab Angular 16+, modernes Build-Tooling

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular UND Angular-Upgrade UND (Angular 14 ODER Angular 20)`
- `(Standalone Components ODER Signals ODER @defer ODER Built-in Control Flow ODER Zoneless ODER Esbuild ODER Vite)` [Ergänzungen]

---

### Anforderung M2 (4.1.2): Erfahrung mit agilen oder hybriden Projektstrukturen

**Bereich:** Methodik
**Nachweis:** Anzahl Referenzen - 2

**Buzzwords:**
- Agile
- Agile Methoden
- Hybrid
- Hybride Projektstrukturen
- Scrum
- Kanban
- Wasserfall

**Buzzword-Gruppen:**
- `(Agile ODER Hybrid ODER Scrum ODER Kanban)`

**Intelligente Ergänzungen:**
- Keine spezifischen Ergänzungen (Standard-Methodiken)

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `(Agile ODER Hybrid ODER Scrum ODER Kanban ODER Wasserfall)`

---

## Soll-Anforderungen

### Anforderung S1 (4.2.1): Angular-Entwicklung mit Versionen 14 und 20 (Gewichtung: 25%)

**Bereich:** Technologie
**Nachweis:** Erfahrungslevel in Jahren - ab 3 Jahre

**Buzzwords:**
- Angular
- Angular 14
- Angular 20
- Angular-Entwicklung
- Frontend-Entwicklung
- TypeScript

**Buzzword-Gruppen:**
- `Angular UND (Angular 14 ODER Angular 20)`

**Intelligente Ergänzungen:**
- Siehe M1 (identische Technologie-Ergänzungen)

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular UND TypeScript UND (Angular 14 ODER Angular 20)`
- `(Standalone Components ODER Signals ODER @defer ODER Built-in Control Flow)` [Ergänzungen]

---

### Anforderung S2 (4.2.2): Erfahrung mit Einbindung und Pflege von CI/CD (Gewichtung: 25%)

**Bereich:** DevOps
**Nachweis:** Anzahl Referenzen - 1

**Buzzwords:**
- CI/CD
- Continuous Integration
- Continuous Deployment
- Jenkins
- GitLab CI
- Azure DevOps
- Pipeline
- Build-Automatisierung

**Buzzword-Gruppen:**
- `CI/CD ODER Continuous Integration ODER Continuous Deployment`
- `(Jenkins ODER GitLab CI ODER Azure DevOps)`

**Intelligente Ergänzungen:**
- **SonarQube** - Oft in Kombination mit CI/CD für Code-Qualität
- **Nexus** - Artifact Repository, häufig in Enterprise CI/CD

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `CI/CD UND (Jenkins ODER GitLab CI ODER Azure DevOps ODER Pipeline)`
- `(SonarQube ODER Nexus)` [Ergänzungen]

---

### Anforderung S3 (4.2.3): Erfahrung mit Nutzung der API des One Identity Manager 9.2.2 bei Frontendmigration (Gewichtung: 25%)

**Bereich:** Technologie/Fachlich
**Nachweis:** Anzahl Referenzen - 2

**Buzzwords:**
- One Identity Manager
- One Identity Manager 9.2.2
- One Identity API
- IAM
- Identity & Access Management
- Identity Management
- Frontendmigration
- API-Integration
- REST API

**Buzzword-Gruppen:**
- `One Identity Manager UND One Identity API`
- `IAM ODER Identity & Access Management ODER Identity Management`
- `Frontendmigration UND API-Integration`

**Intelligente Ergänzungen:**
- **REST API** - One Identity Manager nutzt REST für Frontend-Kommunikation
- **imx-modules** - Standard Angular-Module von One Identity
- **qbm (Query Builder Module)** - Kern-Library des One Identity Managers

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `One Identity Manager UND (One Identity API ODER REST API)`
- `(IAM ODER Identity & Access Management)`
- `(imx-modules ODER qbm)` [Ergänzungen]

---

### Anforderung S4 (4.2.4): Erfahrung mit Nutzung und Customizing der Angular-Libraries des One Identity Manager ab 9.2.2 bei Frontendmigration (Gewichtung: 15%)

**Bereich:** Technologie/Fachlich
**Nachweis:** Anzahl Referenzen - 2

**Buzzwords:**
- One Identity Manager
- One Identity Angular Libraries
- Library Customizing
- Angular Libraries
- Frontendmigration
- Angular-Komponenten
- Custom Components

**Buzzword-Gruppen:**
- `One Identity Manager UND Angular Libraries UND Customizing`
- `Frontendmigration`

**Intelligente Ergänzungen:**
- **imx-modules** - Standard Angular-Libraries von One Identity
- **qbm** - Query Builder Module
- **Angular Material** - Oft Basis für One Identity UI-Komponenten

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `One Identity Manager UND (Angular Libraries ODER imx-modules ODER qbm) UND Customizing`

---

### Anforderung S5 (4.2.5): Erfahrung mit Aufsetzen von Angular-Projekten mit mehreren Entwicklern (Gewichtung: 10%)

**Bereich:** Technologie/Organisation
**Nachweis:** Anzahl Referenzen - 1

**Buzzwords:**
- Angular-Projekt
- Projekt-Setup
- Multi-Developer
- Team-Entwicklung
- Monorepo
- Nx
- Angular CLI
- Workspace

**Buzzword-Gruppen:**
- `Angular-Projekt UND (Projekt-Setup ODER Team-Entwicklung)`
- `(Monorepo ODER Nx ODER Angular CLI ODER Workspace)`

**Intelligente Ergänzungen:**
- **Nx** - Enterprise-Standard für Angular Monorepos
- **Angular Workspace** - Multi-Project Setup
- **ESLint** - Code-Style für Teams

**Finale Buzzword-Gruppen (mit Ergänzungen):**
- `Angular-Projekt UND Team-Entwicklung`
- `(Nx ODER Monorepo ODER Angular Workspace)` [Ergänzungen]

---

## Alle Buzzwords (Alphabetisch)

```
A
- Agile
- Agile Methoden
- Angular
- Angular 14
- Angular 15
- Angular 16
- Angular 17
- Angular 18
- Angular 19
- Angular 20
- Angular CLI
- Angular Libraries
- Angular Material
- Angular-Entwicklung
- Angular-Komponenten
- Angular-Migration
- Angular-Projekt
- Angular-Upgrade
- Angular Workspace
- API-Integration
- Azure DevOps

B
- Build-Automatisierung
- Built-in Control Flow (@if, @for, @switch)

C
- CI/CD
- Continuous Deployment
- Continuous Integration
- Custom Components
- Customizing

D
- @defer (Deferrable Views)

E
- Esbuild
- ESLint

F
- Frontend-Entwicklung
- Frontend-Migration
- Frontendmigration

G
- GitLab CI

H
- Hybrid
- Hybride Projektstrukturen

I
- IAM
- Identity & Access Management
- Identity Management
- imx-modules
- inject() function

J
- Jenkins

K
- Kanban

L
- Library Customizing

M
- Monorepo
- Multi-Developer

N
- Nexus
- Nx

O
- One Identity Angular Libraries
- One Identity API
- One Identity Manager
- One Identity Manager 9.2.2

P
- Partial Hydration
- Pipeline
- Projekt-Setup

Q
- qbm (Query Builder Module)

R
- REST API

S
- Scrum
- Signals
- SonarQube
- Standalone Components

T
- Team-Entwicklung
- TypeScript
- Typed Reactive Forms

V
- Vite

W
- Wasserfall
- Workspace

Z
- Zoneless Angular
```

---

## Alle Buzzword-Gruppen (Übersicht)

### Technologie-Stack (Angular)
- `Angular UND TypeScript`
- `Angular UND (Angular 14 ODER Angular 20)`
- `Angular-Upgrade UND Angular-Migration`
- `(Standalone Components ODER Signals ODER @defer ODER Built-in Control Flow)` [Ergänzung v14-20]
- `(Zoneless Angular ODER Partial Hydration ODER Esbuild ODER Vite)` [Ergänzung v16-20]

### One Identity Manager
- `One Identity Manager UND One Identity API`
- `One Identity Manager UND Angular Libraries UND Customizing`
- `(imx-modules ODER qbm)` [Ergänzung]
- `IAM ODER Identity & Access Management`

### DevOps / CI/CD
- `CI/CD UND (Jenkins ODER GitLab CI ODER Azure DevOps)`
- `(SonarQube ODER Nexus)` [Ergänzung]

### Methodiken
- `(Agile ODER Hybrid ODER Scrum ODER Kanban)`

### Projekt-Organisation
- `Angular-Projekt UND Team-Entwicklung`
- `(Nx ODER Monorepo ODER Angular Workspace)` [Ergänzung]

---

## Zusätzliche Anforderungen (aus Kontext)

Folgende Anforderungen wurden aus dem Projektkontext identifiziert (NICHT aus den dedizierten Anforderungssektionen):

| Bereich | Anforderung | Quelle |
|---------|-------------|--------|
| Sprache | Deutsch C1/C2 (verhandlungssicher) | Abschnitt 1.3 |
| Ort | Frankfurt Main, Onshore | Abschnitt 2.1 |
| Zeitraum | 2026: 205 PT, 2027: 110 PT | Abschnitt 2.2 |

---

## Nächste Schritte

**Phase 2: `/optimize-profile-match`**
- Profil-Analyse gegen diese Anforderungen
- Matching-Score berechnen
- Optimierungsvorschläge generieren
- Gap-Analyse erstellen

**Datei-Struktur:**
```
.agent-os/profile-optimization/2026-01-25-db-debi-angular/
├── 01-requirements-analysis.md (diese Datei)
├── 02-profile-matching.md (Phase 2 - zukünftig)
└── inputs/
    ├── job-description.pdf
    └── employee-profile.pdf
```
