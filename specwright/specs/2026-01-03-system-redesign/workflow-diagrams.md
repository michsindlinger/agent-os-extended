# Workflow Diagramme

Diese Datei enthält Mermaid-Diagramme für alle aktualisierten Workflows.

---

## 1. validate-market Workflow

```mermaid
flowchart TD
    subgraph Phase1["Phase 1: Ideenvalidierung"]
        A[🚀 Start] --> B{product-brief.md\nexistiert?}
        B -->|Ja| D[📄 Lade product-brief]
        B -->|Nein| C[💡 Produkt-Idee eingeben]
        C --> E[🤖 product-strategist:\nIdee schärfen]
        E --> F[📝 Generiere product-brief.md]
    end

    subgraph Gate1["🚦 User Review Gate 1"]
        D --> G{👤 User prüft\nproduct-brief.md}
        F --> G
        G -->|Änderungen| E
        G -->|✅ Genehmigt| H[Weiter]
    end

    subgraph Phase2["Phase 2: Marktanalyse"]
        H --> I[🔍 market-researcher:\nCompetitor Analysis]
        I --> J[📊 competitor-analysis.md]
        J --> K[🎯 Positionierung entwickeln]
        K --> L[📍 market-position.md]
    end

    subgraph Gate2["🚦 User Review Gate 2"]
        L --> M{👤 User prüft\nMarktanalyse}
        M -->|Änderungen| I
        M -->|✅ Fertig| N[Core Complete]
        M -->|🌐 Landing Page| O[Weiter Optional]
    end

    subgraph Optional["Phase 3: Optional - Landing Page & Marketing"]
        O --> P[🎨 Design-System extrahieren]
        P --> Q[✍️ content-creator: Copywriting]
        Q --> R[🔎 seo-specialist: SEO]
        R --> S[💻 web-developer: Landing Page]
        S --> T[📢 Campaign Planning]
    end

    N --> Z[✅ Ende]
    T --> Z

    style A fill:#4CAF50,color:#fff
    style Z fill:#4CAF50,color:#fff
    style Gate1 fill:#FFF3CD
    style Gate2 fill:#FFF3CD
    style Optional fill:#E8E8E8
```

**Outputs:**
- 📄 product-brief.md (Pflicht)
- 📊 competitor-analysis.md (Pflicht)
- 📍 market-position.md (Pflicht)
- 🎨 design-system.md (Optional)
- 🌐 landing-page/index.html (Optional)
- 📢 ad-campaigns.md (Optional)

---

## 2. plan-product Workflow

```mermaid
flowchart TD
    subgraph Check["Prüfung bestehender Daten"]
        A[🚀 Start] --> B{product-brief.md\nexistiert?}
        B -->|Ja| C[📄 Lade existierenden Brief]
        B -->|Nein| D[💡 Produkt-Info sammeln]
    end

    subgraph Brief["Product Brief erstellen"]
        D --> E[🤖 product-strategist:\nIdee schärfen]
        E --> F[📝 product-brief.md]
        F --> G{👤 User Review}
        G -->|Änderungen| E
        G -->|✅ OK| H[Generiere Lite-Version]
    end

    subgraph TechStack["Tech Stack"]
        C --> I[📊 Tech Stack Empfehlung]
        H --> I
        I --> J{👤 User wählt\nTechnologien}
        J --> K[⚙️ tech-stack.md]
    end

    subgraph Roadmap["Roadmap"]
        K --> L[📅 Roadmap generieren]
        L --> M{👤 User prüft\nPhasen}
        M -->|Anpassung| L
        M -->|✅ OK| N[roadmap.md]
    end

    subgraph Architecture["Architektur"]
        N --> O[🏗️ Architektur-Empfehlung]
        O --> P{👤 User wählt\nPattern}
        P --> Q[📐 architecture-decision.md]
    end

    subgraph Boilerplate["Projekt-Struktur"]
        Q --> R[📁 file-creator:\nBoilerplate generieren]
        R --> S[🗂️ boilerplate/]
        S --> T[📋 architecture-structure.md]
    end

    T --> Z[✅ Ende]

    style A fill:#4CAF50,color:#fff
    style Z fill:#4CAF50,color:#fff
```

**Outputs:**
- 📄 product-brief.md
- 📄 product-brief-lite.md
- ⚙️ tech-stack.md
- 📅 roadmap.md
- 📐 architecture-decision.md
- 📋 architecture-structure.md
- 📁 boilerplate/ (Ordnerstruktur)

---

## 3. analyze-product Workflow

```mermaid
flowchart TD
    subgraph Analysis["Phase 1: Codebase-Analyse"]
        A[🚀 Start] --> B[🔍 Deep Codebase Analysis]
        B --> C[📦 Projekt-Struktur]
        B --> D[🔧 Tech Detection]
        B --> E[🏗️ Architektur Detection]
        B --> F[📊 Features erkennen]
    end

    subgraph Context["Phase 2: Kontext sammeln"]
        C --> G[👤 User-Interview]
        D --> G
        E --> G
        F --> G
        G --> H[❓ Vision, Roadmap,\nArchitektur-Intent]
    end

    subgraph Documentation["Phase 3: Dokumentation"]
        H --> I[📝 product-brief.md\ngenerieren]
        I --> J{👤 User prüft}
        J -->|Korrektur| I
        J -->|✅ OK| K[📄 product-brief-lite.md]
        K --> L[⚙️ tech-stack.md\naus Detection]
    end

    subgraph Roadmap["Phase 4: Roadmap"]
        L --> M[📅 Roadmap mit Phase 0]
        M --> N[✅ Erkannte Features\nin Phase 0]
        N --> O[📋 Geplante Features\nin Phase 1+]
    end

    subgraph Architecture["Phase 5: Architektur"]
        O --> P[🏗️ Architektur analysieren]
        P --> Q{Pattern erkannt?}
        Q -->|Ja| R[📐 Pattern dokumentieren]
        Q -->|Nein| S[👤 User wählt Pattern]
        R --> T{Compliance\nprüfen}
        S --> T
        T --> U{Refactoring\nnötig?}
    end

    subgraph Refactoring["Optional: Refactoring"]
        U -->|Ja| V[📋 Refactoring-Plan]
        V --> W[Zur Roadmap hinzufügen]
        U -->|Nein| X[Weiter]
        W --> X
    end

    subgraph Output["Finale Outputs"]
        X --> Y[📁 boilerplate/ generieren]
        Y --> Z[📋 architecture-structure.md]
    end

    Z --> END[✅ Specwright installiert]

    style A fill:#4CAF50,color:#fff
    style END fill:#4CAF50,color:#fff
    style N fill:#90EE90
```

**Besonderheit:** Phase 0 enthält bereits implementierte Features!

---

## 4. validate-market-for-existing Workflow

```mermaid
flowchart TD
    A[🚀 Start] --> B{product-brief.md\nexistiert?}

    subgraph CreateBrief["Optional: Brief erstellen"]
        B -->|Nein| C[👤 Produkt beschreiben]
        C --> D[🤖 product-strategist]
        D --> E[📝 product-brief.md]
    end

    subgraph Analysis["Marktanalyse"]
        B -->|Ja| F[📄 Lade Brief]
        E --> F
        F --> G[🔍 market-researcher:\nCompetitor Analysis]
        G --> H[📊 5-10 Wettbewerber\nanalysieren]
        H --> I[📈 Feature Matrix]
        I --> J[🎯 Market Gaps\nidentifizieren]
        J --> K[📝 competitor-analysis.md]
    end

    subgraph Positioning["Positionierung"]
        K --> L[🎯 Positionierung\nentwickeln]
        L --> M[💬 Messaging\nFramework]
        M --> N[⚔️ Battle Cards\nvs. Wettbewerber]
        N --> O[📍 market-position.md]
    end

    subgraph Review["Review"]
        O --> P{👤 User prüft\nErgebnisse}
        P -->|Mehr Analyse| G
        P -->|Wettbewerber\nhinzufügen| G
        P -->|✅ OK| Q[Summary]
    end

    Q --> Z[✅ Retroaktive\nValidation Complete]

    style A fill:#4CAF50,color:#fff
    style Z fill:#4CAF50,color:#fff
    style CreateBrief fill:#E8E8E8
```

**Use Cases:**
- 🚀 Produkt ohne Validierung gestartet
- 🔄 Pivot-Validierung
- 📢 Marketing-Refresh
- 💰 Investment-Vorbereitung

---

## 5. build-development-team Workflow

```mermaid
flowchart TD
    subgraph Check["Voraussetzung"]
        A[🚀 Start] --> B{tech-stack.md\nexistiert?}
        B -->|Nein| C[❌ Erst /plan-product\noder /analyze-product]
        B -->|Ja| D[📄 Lade Tech Stack]
    end

    subgraph Architecture["Architecture Agent"]
        D --> E[🏗️ Architecture Agent\nerstellen - IMMER]
        E --> F[5 Architect Skills\nzuweisen]
    end

    subgraph Selection["Agent-Auswahl"]
        F --> G{👤 Welche Agents?}
        G --> H[Backend Developer]
        G --> I[Frontend Developer]
        G --> J[DevOps Specialist]
        G --> K[QA Specialist]
        G --> L[PO Agent]
    end

    subgraph Instances["Multi-Instanzen"]
        H --> M{Anzahl Backend?}
        I --> N{Anzahl Frontend?}
        M --> O[1-3 Instanzen]
        N --> P[1-3 Instanzen]
    end

    subgraph Create["Agents erstellen"]
        O --> Q[📁 .claude/agents/\nbackend-dev-1.md\nbackend-dev-2.md]
        P --> R[📁 .claude/agents/\nfrontend-dev-1.md]
        J --> S[📁 devops-agent.md]
        K --> T[📁 qa-agent.md]
        L --> U[📁 po-agent.md]
    end

    subgraph Quality["Quality Standards"]
        Q --> V[📋 Definition of Done]
        R --> V
        S --> V
        T --> V
        U --> V
        V --> W{👤 DoD prüfen}
        W --> X[📋 Definition of Ready]
        X --> Y{👤 DoR prüfen}
    end

    subgraph Skills["Skill Setup"]
        Y --> Z[🔗 Symlinks erstellen\n.claude/skills/]
        Z --> AA[Tech-spezifische Skills]
        Z --> AB[Rollen-spezifische Skills]
        Z --> AC[Globale Skills]
    end

    AA --> END[✅ Team Ready]
    AB --> END
    AC --> END

    style A fill:#4CAF50,color:#fff
    style END fill:#4CAF50,color:#fff
    style E fill:#9C27B0,color:#fff
```

**Team-Optionen:**
| Agent | Required | Skills | Multi-Instanz |
|-------|----------|--------|---------------|
| 🏗️ Architecture | ✅ Ja | 5 | Nein |
| 💻 Backend | Optional | 4+ | Ja (1-3) |
| 🎨 Frontend | Optional | 4+ | Ja (1-3) |
| ⚙️ DevOps | Optional | 4 | Nein |
| 🧪 QA | Optional | 2 | Nein |
| 📋 PO | Optional | 4 | Nein |

---

## 6. Kombinierte Nutzung - Kompletter Lifecycle

```mermaid
flowchart TD
    subgraph NewProject["Neues Projekt"]
        A[💡 Neue Idee] --> B[/validate-market]
        B --> C[📄 product-brief.md\n📊 competitor-analysis.md\n📍 market-position.md]
        C --> D{GO / NO-GO?}
        D -->|NO-GO| E[❌ Idee verwerfen\noder anpassen]
        D -->|GO| F[/plan-product]
    end

    subgraph Planning["Planung"]
        F --> G[📄 Nutzt product-brief.md]
        G --> H[⚙️ tech-stack.md\n📅 roadmap.md\n📐 architecture-decision.md\n📁 boilerplate/]
    end

    subgraph TeamSetup["Team Setup"]
        H --> I[/build-development-team]
        I --> J[🏗️ Architecture Agent\n💻 Backend Agent\n🎨 Frontend Agent\n⚙️ DevOps Agent\n🧪 QA Agent\n📋 PO Agent]
        J --> K[📋 Definition of Done\n📋 Definition of Ready]
    end

    subgraph Development["Entwicklung"]
        K --> L[/create-spec]
        L --> M[Feature Spec]
        M --> N[/execute-tasks]
        N --> O[Implementation]
        O --> P{Tests bestanden?}
        P -->|Nein| N
        P -->|Ja| Q[Feature Complete]
        Q --> L
    end

    subgraph ExistingProject["Bestehendes Projekt"]
        AA[📦 Existierende\nCodebase] --> BB[/analyze-product]
        BB --> CC[📄 product-brief.md\n⚙️ tech-stack.md\n📅 roadmap.md mit Phase 0]
    end

    subgraph RetroValidation["Nachträgliche Validierung"]
        CC --> DD{Marktvalidierung\nnötig?}
        DD -->|Ja| EE[/validate-market-for-existing]
        EE --> FF[📊 competitor-analysis.md\n📍 market-position.md]
        DD -->|Nein| GG[Weiter]
        FF --> GG
    end

    GG --> I

    style A fill:#4CAF50,color:#fff
    style AA fill:#2196F3,color:#fff
    style D fill:#FF9800,color:#fff
    style Q fill:#4CAF50,color:#fff
```

---

## Legende

| Symbol | Bedeutung |
|--------|-----------|
| 🚀 | Start |
| ✅ | Ende / Erfolg |
| ❌ | Abbruch / Fehler |
| 🚦 | User Review Gate |
| 👤 | User-Interaktion |
| 🤖 | Agent-Aktion |
| 📄 | Dokument |
| 📁 | Ordner |
| 🔗 | Symlink |

---

## Workflow-Auswahl Guide

```mermaid
flowchart TD
    A[Wo stehe ich?] --> B{Projekt\nexistiert?}

    B -->|Nein, neue Idee| C{Marktvalidierung\ngewünscht?}
    C -->|Ja| D[/validate-market]
    C -->|Nein, direkt starten| E[/plan-product]
    D --> E

    B -->|Ja, bestehendes Projekt| F[/analyze-product]
    F --> G{Marktvalidierung\nnachträglich?}
    G -->|Ja| H[/validate-market-for-existing]
    G -->|Nein| I[Weiter]
    H --> I

    E --> J[/build-development-team]
    I --> J

    J --> K[🚀 Bereit für Entwicklung]
    K --> L[/create-spec → /execute-tasks]

    style D fill:#FF9800
    style E fill:#2196F3
    style F fill:#9C27B0
    style H fill:#FF9800
    style J fill:#4CAF50
    style K fill:#4CAF50,color:#fff
```
