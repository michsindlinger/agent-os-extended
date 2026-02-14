# Projekt-Steckbrief: [PROJEKTNAME]

**Kunde:** [KUNDENNAME]
**Branche:** [BRANCHE]
**Zeitraum:** [START] - [ENDE] ([DAUER])
**Meine Rolle:** [ROLLE]

---

## Projekt auf einen Blick

**Was war das Ziel?**
[PROJEKTZIEL]

**Was war mein Beitrag?**
[EIGENER_BEITRAG]

**Was war das Ergebnis?**
[PROJEKTERGEBNIS]

---

## Team-Struktur

```mermaid
graph TD
    subgraph "Projekt-Team"
        PL[Projektleiter<br/>1 Person]

        subgraph "Entwicklung"
            BE[Backend-Team<br/>[BACKEND_SIZE] Personen]
            FE[Frontend-Team<br/>[FRONTEND_SIZE] Personen]
            QA[QA/Testing<br/>[QA_SIZE] Personen]
        end

        subgraph "Fachseite"
            PO[Product Owner<br/>1 Person]
            BA[Business Analyst<br/>[BA_SIZE] Personen]
        end

        ICH[**MEINE POSITION**<br/>[MEINE_ROLLE]]
    end

    PL --> BE
    PL --> FE
    PL --> QA
    PO --> PL
    BA --> PO

    ICH -.-> [MEIN_TEAM]

    style ICH fill:#90EE90,stroke:#006400,stroke-width:3px
```

**Team-Details:**
- **Gesamtgröße:** [TEAM_GESAMT] Personen
- **Mein direktes Team:** [DIREKTES_TEAM] Personen
- **Zusammenarbeit mit:** [ZUSAMMENARBEIT]
- **Berichtsstruktur:** [BERICHTSSTRUKTUR]

---

## Technische Architektur

```mermaid
graph TB
    subgraph "Frontend"
        UI[Web-Anwendung<br/>[FRONTEND_TECH]]
        Mobile[Mobile App<br/>[MOBILE_TECH]]
    end

    subgraph "Backend"
        API[REST API<br/>[API_TECH]]
        Services[Microservices<br/>[SERVICE_TECH]]
        Queue[Message Queue<br/>[QUEUE_TECH]]
    end

    subgraph "Datenbank"
        DB1[([HAUPTDB_NAME]<br/>[HAUPTDB_TYP])]
        DB2[([CACHE_NAME]<br/>[CACHE_TYP])]
    end

    subgraph "Externe Systeme"
        EXT1[[EXTERNAL_1]]
        EXT2[[EXTERNAL_2]]
    end

    UI --> API
    Mobile --> API
    API --> Services
    Services --> Queue
    Services --> DB1
    Services --> DB2
    Services --> EXT1
    Services --> EXT2
```

**Architektur-Highlights:**
- **Architekturstil:** [ARCHITEKTURSTIL]
- **Besonderheiten:** [BESONDERHEITEN]
- **Herausforderungen:** [HERAUSFORDERUNGEN]

---

## Technologie-Stack

### Übersicht nach Kategorien

| Kategorie | Technologien | Meine Erfahrung |
|-----------|--------------|-----------------|
| **Programmiersprachen** | [SPRACHEN] | [ERFAHRUNG_STARS] |
| **Frontend** | [FRONTEND_TECH] | [ERFAHRUNG_STARS] |
| **Backend** | [BACKEND_TECH] | [ERFAHRUNG_STARS] |
| **Datenbanken** | [DB_TECH] | [ERFAHRUNG_STARS] |
| **DevOps/Cloud** | [DEVOPS_TECH] | [ERFAHRUNG_STARS] |
| **Testing** | [TEST_TECH] | [ERFAHRUNG_STARS] |
| **Tools** | [TOOLS] | [ERFAHRUNG_STARS] |

### Technologie-Deep-Dive

**[HAUPTTECH_1]:**
- Eingesetzt für: [EINSATZBEREICH_1]
- Besonderheit: [BESONDERHEIT_1]
- Erfahrungslevel: [LEVEL_1]

**[HAUPTTECH_2]:**
- Eingesetzt für: [EINSATZBEREICH_2]
- Besonderheit: [BESONDERHEIT_2]
- Erfahrungslevel: [LEVEL_2]

---

## Agile Arbeitsweise

### Methodik
- **Framework:** [AGILE_FRAMEWORK]
- **Sprint-Länge:** [SPRINT_LÄNGE]
- **Release-Zyklus:** [RELEASE_ZYKLUS]

### Meeting-Struktur

| Meeting | Frequenz | Dauer | Meine Rolle |
|---------|----------|-------|-------------|
| Daily Stand-up | Täglich | 15 min | [ROLLE] |
| Sprint Planning | [FREQUENZ] | [DAUER] | [ROLLE] |
| Sprint Review | [FREQUENZ] | [DAUER] | [ROLLE] |
| Retrospektive | [FREQUENZ] | [DAUER] | [ROLLE] |
| Refinement | [FREQUENZ] | [DAUER] | [ROLLE] |

### Team-Abstimmung

**Wie wurde kommuniziert?**
- **Synchron:** [SYNC_TOOLS]
- **Asynchron:** [ASYNC_TOOLS]
- **Code-Review:** [CODE_REVIEW_PROZESS]
- **Dokumentation:** [DOKU_PROZESS]

**Typischer Arbeitstag:**
> [TYPISCHER_TAG_BESCHREIBUNG]

---

## Relevanz für [ZIELKUNDE]

### Direkte Übertragbarkeit

| Anforderung aus Ausschreibung | Erfahrung aus diesem Projekt |
|-------------------------------|------------------------------|
| [ANFORDERUNG_1] | [ERFAHRUNG_MAPPING_1] |
| [ANFORDERUNG_2] | [ERFAHRUNG_MAPPING_2] |
| [ANFORDERUNG_3] | [ERFAHRUNG_MAPPING_3] |

### Key Talking Points für Interview

1. **[TALKING_POINT_1]:** [DETAILS_1]
2. **[TALKING_POINT_2]:** [DETAILS_2]
3. **[TALKING_POINT_3]:** [DETAILS_3]

---

## Projekt-Kennzahlen

- **Projektbudget:** [BUDGET]
- **Team-Größe:** [TEAM_SIZE] Personen
- **Codebase:** [CODEBASE_SIZE]
- **User/Kunden:** [USER_COUNT]
- **Uptime/SLA:** [SLA]
- **Deployment-Frequenz:** [DEPLOY_FREQUENZ]
