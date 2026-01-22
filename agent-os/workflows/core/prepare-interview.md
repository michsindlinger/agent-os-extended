---
description: Interview-Vorbereitung mit bildlicher Projekt-Darstellung
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Prepare Interview Workflow

## Overview

Erstellt eine detaillierte, bildliche Darstellung der letzten Projekte aus einem Bewerberprofil, um optimale Interview-Vorbereitung zu ermöglichen. Der Workflow analysiert das Profil und die Projektausschreibung, um relevante Aspekte hervorzuheben.

**Ziel:** Der Bewerber soll ein konkretes mentales Bild seiner vergangenen Projekte haben:
- Team-Struktur und Zusammenarbeit
- Technische Architektur und Komponenten
- Agile Prozesse und Meeting-Struktur
- Relevanz zur aktuellen Ausschreibung

<process_flow>

<step number="1" name="input_collection">

### Step 1: Input-Daten sammeln

<mandatory_actions>
  1. ASK user via AskUserQuestion:
     ```
     Question: "Bitte gib den Pfad zum Bewerberprofil an:"

     Options:
     - PDF-Datei auswählen
     - Word-Datei auswählen
     - Pfad manuell eingeben
     ```

  2. WAIT for user to provide file path

  3. READ the profile file (PDF or Word)
     - Extract all project information
     - Note: Claude Code can read PDFs directly

  4. ASK user via AskUserQuestion:
     ```
     Question: "Wie möchtest du die Projektausschreibung bereitstellen?"

     Options:
     - Text direkt eingeben
     - Datei-Pfad angeben (PDF/Word/Text)
     - URL zur Ausschreibung
     ```

  5. COLLECT job description content

  6. ASK user via AskUserQuestion:
     ```
     Question: "Wie viele Projekte sollen aufbereitet werden?"

     Options:
     - 3 Projekte (Standard, empfohlen)
     - 2 Projekte
     - Alle Projekte aus dem Profil
     ```

  7. STORE:
     - profile_content
     - job_description
     - project_count
</mandatory_actions>

</step>

<step number="2" name="project_extraction">

### Step 2: Projekte aus Profil extrahieren

<mandatory_actions>
  1. ANALYZE profile_content

  2. EXTRACT for each project:
     - Projektname / Kundenname
     - Zeitraum (von - bis)
     - Branche des Kunden
     - Projektbeschreibung
     - Eigene Rolle / Position
     - Team-Größe (wenn angegeben)
     - Technologien (alle genannten)
     - Aufgaben / Tätigkeiten
     - Besondere Erfolge / Highlights

  3. SELECT the most recent [project_count] projects

  4. ANALYZE job_description:
     - Required technologies
     - Desired experience areas
     - Industry focus
     - Methodologies mentioned (Scrum, SAFe, etc.)
     - Role requirements

  5. CALCULATE relevance_score for each project:
     - Technology overlap (0-10)
     - Industry relevance (0-10)
     - Role similarity (0-10)
     - Methodology match (0-10)

  6. RANK projects by relevance_score
</mandatory_actions>

<output>
  - Extracted project data
  - Job requirements analysis
  - Relevance rankings
</output>

</step>

<step number="3" name="create_output_folder">

### Step 3: Output-Struktur erstellen

<mandatory_actions>
  1. USE date-checker to get current date (YYYY-MM-DD)

  2. EXTRACT customer_name from job_description
     - Normalize: lowercase, replace spaces with hyphens

  3. CREATE folder structure:
     ```
     .agent-os/interviews/
     └── YYYY-MM-DD-[customer-name]/
         ├── overview.md
         ├── projekt-1/
         │   ├── steckbrief.md
         │   └── interview-karten.md
         ├── projekt-2/
         │   ├── steckbrief.md
         │   └── interview-karten.md
         └── projekt-3/
             ├── steckbrief.md
             └── interview-karten.md
     ```
</mandatory_actions>

</step>

<step number="4" name="create_overview">

### Step 4: Overview-Dokument erstellen

<mandatory_actions>
  CREATE overview.md with:

  <overview_template>
  # Interview-Vorbereitung: [KUNDENNAME]

  **Erstellt:** [DATUM]
  **Bewerber:** [NAME aus Profil]
  **Position:** [Position aus Ausschreibung]

  ---

  ## Ausschreibungs-Analyse

  ### Gesuchte Technologien
  | Technologie | Priorität | Abdeckung im Profil |
  |-------------|-----------|---------------------|
  | [Tech 1]    | Must-have | ✅ Projekt 1, 2     |
  | [Tech 2]    | Must-have | ✅ Projekt 3        |
  | [Tech 3]    | Nice-to-have | ⚠️ Randerwähnung  |
  | [Tech 4]    | Nice-to-have | ❌ Nicht vorhanden |

  ### Gesuchte Erfahrungsbereiche
  - [Bereich 1] → Projekt [X]
  - [Bereich 2] → Projekt [X]
  - [Bereich 3] → Projekt [X]

  ### Methodiken / Arbeitsweisen
  - [Methodik 1] → [Wo im Profil abgedeckt]
  - [Methodik 2] → [Wo im Profil abgedeckt]

  ---

  ## Projekt-Übersicht (nach Relevanz sortiert)

  | # | Projekt | Zeitraum | Relevanz | Highlights für dieses Interview |
  |---|---------|----------|----------|--------------------------------|
  | 1 | [Name]  | [Zeit]   | ⭐⭐⭐⭐⭐ | [2-3 Key Points]              |
  | 2 | [Name]  | [Zeit]   | ⭐⭐⭐⭐   | [2-3 Key Points]              |
  | 3 | [Name]  | [Zeit]   | ⭐⭐⭐     | [2-3 Key Points]              |

  ---

  ## Quick-Reference: Top Talking Points

  Für dieses Interview besonders betonen:

  1. **[Thema 1]**: [Kurze Erklärung warum relevant + in welchem Projekt]
  2. **[Thema 2]**: [Kurze Erklärung warum relevant + in welchem Projekt]
  3. **[Thema 3]**: [Kurze Erklärung warum relevant + in welchem Projekt]
  4. **[Thema 4]**: [Kurze Erklärung warum relevant + in welchem Projekt]
  5. **[Thema 5]**: [Kurze Erklärung warum relevant + in welchem Projekt]

  ---

  ## Projekt-Details

  → [projekt-1/steckbrief.md](projekt-1/steckbrief.md)
  → [projekt-2/steckbrief.md](projekt-2/steckbrief.md)
  → [projekt-3/steckbrief.md](projekt-3/steckbrief.md)
  </overview_template>
</mandatory_actions>

</step>

<step number="5" name="create_project_steckbrief">

### Step 5: Projekt-Steckbriefe erstellen

FOR EACH selected project, CREATE steckbrief.md:

<steckbrief_template>
# Projekt-Steckbrief: [PROJEKTNAME]

**Kunde:** [Kundenname]
**Branche:** [Branche]
**Zeitraum:** [MM/YYYY] - [MM/YYYY] ([X Monate])
**Meine Rolle:** [Rolle/Position]

---

## 🎯 Projekt auf einen Blick

**Was war das Ziel?**
[2-3 Sätze: Das Kernziel des Projekts in einfachen Worten]

**Was war mein Beitrag?**
[2-3 Sätze: Meine konkrete Rolle und Verantwortung]

**Was war das Ergebnis?**
[2-3 Sätze: Messbares Ergebnis oder Impact]

---

## 👥 Team-Struktur

```mermaid
graph TD
    subgraph "Projekt-Team"
        PL[Projektleiter<br/>1 Person]

        subgraph "Entwicklung"
            BE[Backend-Team<br/>X Personen]
            FE[Frontend-Team<br/>X Personen]
            QA[QA/Testing<br/>X Personen]
        end

        subgraph "Fachseite"
            PO[Product Owner<br/>1 Person]
            BA[Business Analyst<br/>X Personen]
        end

        ICH[**MEINE POSITION**<br/>[Rolle]]
    end

    PL --> BE
    PL --> FE
    PL --> QA
    PO --> PL
    BA --> PO

    ICH -.-> BE

    style ICH fill:#90EE90,stroke:#006400,stroke-width:3px
```

**Team-Details:**
- **Gesamtgröße:** [X Personen]
- **Mein direktes Team:** [X Personen]
- **Zusammenarbeit mit:** [Andere Teams/Abteilungen]
- **Berichtsstruktur:** [An wen reported]

---

## 🏗️ Technische Architektur

```mermaid
graph TB
    subgraph "Frontend"
        UI[Web-Anwendung<br/>[Framework]]
        Mobile[Mobile App<br/>[Framework]]
    end

    subgraph "Backend"
        API[REST API<br/>[Framework]]
        Services[Microservices<br/>[Technologie]]
        Queue[Message Queue<br/>[Technologie]]
    end

    subgraph "Datenbank"
        DB1[(Haupt-DB<br/>[Typ])]
        DB2[(Cache<br/>[Typ])]
    end

    subgraph "Externe Systeme"
        EXT1[System 1]
        EXT2[System 2]
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
- **Architekturstil:** [Monolith / Microservices / Serverless / etc.]
- **Besonderheiten:** [Was macht diese Architektur besonders?]
- **Herausforderungen:** [Technische Herausforderungen und wie gelöst]

---

## 💻 Technologie-Stack

### Übersicht nach Kategorien

| Kategorie | Technologien | Meine Erfahrung |
|-----------|--------------|-----------------|
| **Programmiersprachen** | [Sprachen] | ⭐⭐⭐⭐⭐ |
| **Frontend** | [Frameworks, Libraries] | ⭐⭐⭐⭐ |
| **Backend** | [Frameworks, Libraries] | ⭐⭐⭐⭐⭐ |
| **Datenbanken** | [DBs, ORMs] | ⭐⭐⭐⭐ |
| **DevOps/Cloud** | [Tools, Plattformen] | ⭐⭐⭐ |
| **Testing** | [Frameworks, Tools] | ⭐⭐⭐⭐ |
| **Tools** | [IDEs, Collaboration] | ⭐⭐⭐⭐⭐ |

### Technologie-Deep-Dive

**[Haupttechnologie 1]:**
- Eingesetzt für: [Konkrete Anwendung]
- Besonderheit: [Was war speziell an der Nutzung?]
- Erfahrungslevel: [Beginner/Intermediate/Expert]

**[Haupttechnologie 2]:**
- Eingesetzt für: [Konkrete Anwendung]
- Besonderheit: [Was war speziell an der Nutzung?]
- Erfahrungslevel: [Beginner/Intermediate/Expert]

---

## 🔄 Agile Arbeitsweise

### Methodik
- **Framework:** [Scrum / Kanban / SAFe / etc.]
- **Sprint-Länge:** [X Wochen]
- **Release-Zyklus:** [Wie oft wurde deployed?]

### Meeting-Struktur

| Meeting | Frequenz | Dauer | Meine Rolle |
|---------|----------|-------|-------------|
| Daily Stand-up | Täglich | 15 min | Teilnehmer |
| Sprint Planning | Alle X Wochen | X h | [Rolle] |
| Sprint Review | Alle X Wochen | X h | [Rolle] |
| Retrospektive | Alle X Wochen | X h | [Rolle] |
| Refinement | [Frequenz] | X h | [Rolle] |
| [Weitere] | [Frequenz] | X h | [Rolle] |

### Team-Abstimmung

**Wie wurde kommuniziert?**
- **Synchron:** [Tools: Slack, Teams, etc.]
- **Asynchron:** [Tools: Confluence, Jira, etc.]
- **Code-Review:** [Prozess beschreiben]
- **Dokumentation:** [Wo und wie]

**Typischer Arbeitstag:**
> Stell dir vor, du kommst morgens ins Büro...
>
> [Beschreibung eines typischen Tages: Wann Daily, wann Fokuszeit,
> wie Abstimmung mit Kollegen, wie Deployment, etc.]

---

## 🎯 Relevanz für [KUNDENNAME]

### Direkte Übertragbarkeit

| Anforderung aus Ausschreibung | Erfahrung aus diesem Projekt |
|-------------------------------|------------------------------|
| [Anforderung 1] | ✅ [Konkrete Erfahrung] |
| [Anforderung 2] | ✅ [Konkrete Erfahrung] |
| [Anforderung 3] | ⚠️ [Teilweise Erfahrung] |

### Key Talking Points für Interview

1. **[Thema]:** [Warum relevant und was erzählen]
2. **[Thema]:** [Warum relevant und was erzählen]
3. **[Thema]:** [Warum relevant und was erzählen]

---

## 📊 Projekt-Kennzahlen

- **Projektbudget:** [Wenn bekannt]
- **Team-Größe:** [X Personen]
- **Codebase:** [Ca. X Lines of Code / X Repositories]
- **User/Kunden:** [X aktive Nutzer]
- **Uptime/SLA:** [Wenn relevant]
- **Deployment-Frequenz:** [X mal pro Woche/Monat]
</steckbrief_template>

<instructions>
  - Fill ALL sections with concrete, specific information
  - If information not in profile, make reasonable inferences based on:
    - Technology stack → typical architecture patterns
    - Team size → typical team structure
    - Industry → typical compliance/security needs
    - Time period → typical methodologies used then
  - Mermaid diagrams should be syntactically correct
  - Relevanz section MUST reference actual job requirements
  - Be specific, avoid generic statements
</instructions>

</step>

<step number="6" name="create_interview_cards">

### Step 6: Interview-Karten erstellen

FOR EACH selected project, CREATE interview-karten.md:

<interview_cards_template>
# Interview-Karten: [PROJEKTNAME]

---

## 🎤 Elevator Pitch (30 Sekunden)

> "[Projektname] war ein [Typ]-Projekt für [Kunde] im Bereich [Branche].
> Als [Rolle] war ich verantwortlich für [Hauptverantwortung].
> Besonders stolz bin ich auf [Highlight], wodurch wir [messbares Ergebnis] erreicht haben."

**Kurzversion (10 Sekunden):**
> "Bei [Kunde] habe ich [Kernaufgabe] mit [Haupttechnologie] umgesetzt."

---

## 📊 Konkrete Zahlen zum Merken

| Metrik | Wert | Kontext |
|--------|------|---------|
| Projektdauer | [X Monate] | [Einordnung] |
| Team-Größe | [X Personen] | [Struktur] |
| Mein Team | [X Personen] | [Rolle im Team] |
| Sprints | [X Sprints] | [Sprint-Länge] |
| Releases | [X Releases] | [Frequenz] |
| Code-Beitrag | ~[X] LOC / [X] Commits | [Kontext] |
| Nutzer | [X] User | [Wachstum?] |

---

## ❓ Typische Interview-Fragen

### Allgemeine Projekt-Fragen

**F: "Erzählen Sie mir von Ihrem Projekt bei [Kunde]."**
> **A:** "[Strukturierte Antwort mit Situation, Aufgabe, Ergebnis]"

**F: "Was war Ihre genaue Rolle in diesem Projekt?"**
> **A:** "[Konkrete Rolle mit Verantwortlichkeiten und Beispielen]"

**F: "Was waren die größten Herausforderungen?"**
> **A:** "[Challenge 1 und wie gelöst], [Challenge 2 und wie gelöst]"

**F: "Worauf sind Sie besonders stolz?"**
> **A:** "[Konkretes Achievement mit messbarem Impact]"

---

### Technologie-Fragen

**F: "Warum haben Sie [Technologie X] verwendet?"**
> **A:** "[Begründung: Anforderungen, Alternativen abgewogen, Entscheidungskriterien]"

**F: "Wie haben Sie [Technologie X] eingesetzt?"**
> **A:** "[Konkreter Use Case, Patterns, Best Practices angewendet]"

**F: "Welche Erfahrung haben Sie mit [Technologie aus Ausschreibung]?"**
> **A:** "[Direkte Erfahrung oder transferierbare Erfahrung erklären]"

**F: "Wie war Ihre Architektur aufgebaut?"**
> **A:** "[Architekturstil, Komponenten, Kommunikation zwischen Services]"

---

### Methodik-Fragen

**F: "Wie haben Sie im Team gearbeitet?"**
> **A:** "[Scrum/Kanban Details, Meetings, Kommunikation, Tools]"

**F: "Wie haben Sie Code-Qualität sichergestellt?"**
> **A:** "[Code Reviews, Testing-Strategie, CI/CD, Standards]"

**F: "Wie sind Sie mit Deadlines umgegangen?"**
> **A:** "[Sprint-Planung, Priorisierung, Kommunikation bei Risiken]"

---

## ⚠️ Kritische Fragen (Vorbereitet sein!)

### Technologie-Entscheidungen

**F: "Warum [Technologie X] statt [Alternative Y]?"**
> **A:** "[Objektive Begründung: Performance, Team-Expertise, Ecosystem, Support, Kosten]"
>
> **Vorbereitung:** Kenne die Vor- und Nachteile beider Technologien!

**F: "Was würden Sie heute anders machen?"**
> **A:** "[Ehrliche Reflexion + was gelernt + wie es heute besser wäre]"
>
> **Tip:** Zeige Lernfähigkeit, nicht Selbstkritik!

**F: "Gab es technische Schulden? Wie sind Sie damit umgegangen?"**
> **A:** "[Beispiel für Tech Debt, Priorisierung, Refactoring-Strategie]"

---

### Konflikt & Herausforderungen

**F: "Gab es Konflikte im Team? Wie haben Sie diese gelöst?"**
> **A:** "[Konkretes Beispiel mit Lösung - STAR Format]"
>
> **STAR:**
> - **Situation:** [Was war der Kontext?]
> - **Task:** [Was war meine Aufgabe?]
> - **Action:** [Was habe ich konkret getan?]
> - **Result:** [Was war das Ergebnis?]

**F: "Was lief nicht gut im Projekt?"**
> **A:** "[Ehrliches Problem + wie reagiert + was gelernt]"
>
> **Tip:** Nie das Team oder den Kunden beschuldigen!

**F: "Hatten Sie Meinungsverschiedenheiten mit dem Product Owner/Architekten?"**
> **A:** "[Konstruktives Beispiel zeigen + sachliche Diskussion + Kompromiss]"

---

### Wissenslücken

**F: "Sie haben wenig Erfahrung mit [Technologie aus Ausschreibung]. Wie gehen Sie damit um?"**
> **A:** "[Transferierbare Skills betonen + Lernbereitschaft + konkrete Lernstrategie]"
>
> **Beispiel:** "Ich habe zwar noch nicht direkt mit [X] gearbeitet, aber meine
> Erfahrung mit [ähnliche Technologie] ist direkt übertragbar. In meinem letzten
> Projekt habe ich mich in [neue Technologie] innerhalb von [Zeitraum] eingearbeitet."

---

## 🌟 STAR-Stories (Verhaltens-Fragen)

### Story 1: [Titel - z.B. "Performance-Problem gelöst"]

**Situation:**
> [Kontext setzen: Projekt, Phase, Umstände]

**Task:**
> [Was war meine konkrete Aufgabe/Verantwortung?]

**Action:**
> [Was habe ICH konkret getan? (Ich-Form, konkret, detailliert)]

**Result:**
> [Messbares Ergebnis, Impact, Feedback]

**Verwendbar für Fragen wie:**
- "Erzählen Sie von einer technischen Herausforderung"
- "Wie gehen Sie mit Problemen um?"
- "Beschreiben Sie eine Situation, wo Sie proaktiv waren"

---

### Story 2: [Titel - z.B. "Teamkonflikt gelöst"]

**Situation:**
> [Kontext setzen]

**Task:**
> [Meine Aufgabe]

**Action:**
> [Meine konkreten Schritte]

**Result:**
> [Ergebnis]

**Verwendbar für Fragen wie:**
- "Wie gehen Sie mit Konflikten um?"
- "Beschreiben Sie Ihre Teamfähigkeit"
- "Wie kommunizieren Sie schwierige Themen?"

---

### Story 3: [Titel - z.B. "Unter Druck geliefert"]

**Situation:**
> [Kontext setzen]

**Task:**
> [Meine Aufgabe]

**Action:**
> [Meine konkreten Schritte]

**Result:**
> [Ergebnis]

**Verwendbar für Fragen wie:**
- "Wie arbeiten Sie unter Druck?"
- "Erzählen Sie von einer Deadline-Situation"
- "Wie priorisieren Sie?"

---

## 🔬 Technologie-Deep-Dives

### [Haupttechnologie 1]

**Erwartbare Detailfragen:**

1. **"Wie haben Sie [Pattern/Konzept] implementiert?"**
   > [Konkrete Antwort mit Code-Konzepten, nicht Code]

2. **"Welche Probleme hatten Sie mit [Technologie]?"**
   > [Echtes Problem + Lösung]

3. **"Wie haben Sie [Performance/Security/Scalability] sichergestellt?"**
   > [Konkrete Maßnahmen]

**Buzzwords/Konzepte zum Erwähnen:**
- [Konzept 1]
- [Konzept 2]
- [Konzept 3]

---

### [Haupttechnologie 2]

**Erwartbare Detailfragen:**

1. **"[Frage]?"**
   > [Antwort]

2. **"[Frage]?"**
   > [Antwort]

**Buzzwords/Konzepte zum Erwähnen:**
- [Konzept 1]
- [Konzept 2]

---

## 🚫 Don'ts - Was NICHT sagen

- ❌ "Das war nicht meine Verantwortung" → ✅ "Mein Fokus lag auf X, aber ich habe eng mit dem Team für Y zusammengearbeitet"
- ❌ "Der Kunde wusste nicht, was er wollte" → ✅ "Wir haben iterativ die Anforderungen geschärft"
- ❌ "Die Architektur war schlecht" → ✅ "Wir haben Legacy-Herausforderungen pragmatisch gelöst"
- ❌ "Ich habe alles alleine gemacht" → ✅ "Ich habe X geleitet/umgesetzt in Zusammenarbeit mit dem Team"
- ❌ Zu technisch ohne Kontext → ✅ Erst Business-Kontext, dann technische Details

---

## ✅ Checkliste vor dem Interview

- [ ] Elevator Pitch geübt (laut sprechen!)
- [ ] Zahlen auswendig gelernt
- [ ] 3 STAR-Stories parat
- [ ] Kritische Fragen durchgegangen
- [ ] Technologie-Deep-Dives vorbereitet
- [ ] Architektur-Diagramm im Kopf
- [ ] Team-Struktur erklärbar
- [ ] Relevanz zur Ausschreibung klar
</interview_cards_template>

<instructions>
  - STAR stories must be CONCRETE and SPECIFIC
  - Critical questions must anticipate REAL interview challenges
  - Technology deep-dives should match job requirements
  - All answers should be in first person, ready to speak
  - Don'ts section should reflect common mistakes
  - Make answers conversational, not robotic
</instructions>

</step>

<step number="7" name="final_summary">

### Step 7: Zusammenfassung präsentieren

<mandatory_actions>
  1. CALCULATE total preparation materials created

  2. PRESENT summary to user:

  <summary_template>
  ✅ Interview-Vorbereitung erstellt!

  **Speicherort:** .agent-os/interviews/[YYYY-MM-DD-customer-name]/

  **Erstellte Materialien:**

  📋 **Overview**
  - [overview.md](overview.md) - Relevanz-Matrix & Quick-Reference

  📁 **Projekt 1: [Name]** (Relevanz: ⭐⭐⭐⭐⭐)
  - [steckbrief.md](projekt-1/steckbrief.md) - Team, Architektur, Tech-Stack
  - [interview-karten.md](projekt-1/interview-karten.md) - Fragen & STAR-Stories

  📁 **Projekt 2: [Name]** (Relevanz: ⭐⭐⭐⭐)
  - [steckbrief.md](projekt-2/steckbrief.md)
  - [interview-karten.md](projekt-2/interview-karten.md)

  📁 **Projekt 3: [Name]** (Relevanz: ⭐⭐⭐)
  - [steckbrief.md](projekt-3/steckbrief.md)
  - [interview-karten.md](projekt-3/interview-karten.md)

  ---

  **Empfohlene Interview-Vorbereitung:**

  1. 📖 Lies zuerst die **Overview** für den Gesamtüberblick
  2. 🎯 Fokussiere auf **Projekt 1** (höchste Relevanz)
  3. 🎤 Übe die **Elevator Pitches** laut
  4. ⚠️ Gehe die **kritischen Fragen** durch
  5. 🌟 Präge dir die **STAR-Stories** ein

  **Viel Erfolg beim Interview!** 🍀
  </summary_template>

  3. ASK user:
     ```
     Question: "Möchtest du noch etwas anpassen?"

     Options:
     - Alles perfekt, fertig
     - Mehr Details zu einem Projekt
     - Andere Projekte auswählen
     - Zusätzliche Fragen hinzufügen
     ```
</mandatory_actions>

</step>

</process_flow>

## Hybrid Template Lookup

Templates werden in folgender Reihenfolge gesucht:
1. Projekt-lokal: `agent-os/templates/interview/`
2. Global: `~/.agent-os/templates/interview/`

Wenn Templates nicht gefunden werden, wird der eingebettete Template-Inhalt aus diesem Workflow verwendet.

## Final Checklist

<verify>
  - [ ] Profil eingelesen
  - [ ] Ausschreibung analysiert
  - [ ] Relevanz-Matrix erstellt
  - [ ] Alle Projekt-Steckbriefe mit Mermaid-Diagrammen
  - [ ] Alle Interview-Karten mit STAR-Stories
  - [ ] Kritische Fragen inkludiert
  - [ ] Technologie-Deep-Dives für relevante Techs
  - [ ] Overview mit Quick-Reference
</verify>
