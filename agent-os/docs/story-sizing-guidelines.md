# Story-Sizing-Guidelines

> Richtlinien für die optimale Größe von User Stories für automatisierte Abarbeitung mit Claude Code
> Version: 1.0
> Created: 2026-01-12

## Übersicht

Diese Guidelines definieren, wie User Stories geschnitten werden müssen, damit sie in einer einzelnen Claude Code Session (~15-30 Minuten) vollständig abgearbeitet werden können.

---

## Max-Größe pro Story

| Kriterium | Max-Wert | Beschreibung |
|-----------|----------|--------------|
| **Dateien** | 5 | Neue oder geänderte Dateien |
| **LOC** | 400 | Lines of Code (geschätzt) |
| **Komplexität** | S (Small) | Story Points: 1-3 SP |
| **Typ** | Single-Concern | 1 Feature, 1 Fix, ODER 1 Refactor |
| **Dependencies** | 0-1 | Externe Abhängigkeiten |

---

## Min-Größe pro Story

| Kriterium | Min-Wert | Beschreibung |
|-----------|----------|--------------|
| **LOC** | 50 | Vermeidet zu granulare Stories |
| **Sinnhaftigkeit** | Atomic | Story muss eigenständig wertvoll sein |

---

## Wann splitten?

### MANDATORY SPLIT (Story MUSS aufgeteilt werden)

- [ ] Story ändert **mehr als 5 Dateien**
- [ ] Story hat geschätzt **mehr als 400 LOC**
- [ ] Story-Komplexität ist **M (Medium) oder größer**
- [ ] Story hat **mehr als 1 Concern** (z.B. Backend + Frontend + DevOps)
- [ ] Story benötigt **mehr als 1 externes Tool** (z.B. Playwright + Chrome DevTools)

### CONSIDER SPLIT (Splitting empfohlen)

- [ ] Story hat Dependencies auf **noch nicht abgeschlossene Stories**
- [ ] Story erfordert **mehr als 2 Review-Zyklen** (Architect + UX + QA)
- [ ] Story hat **komplexe Akzeptanzkriterien** (> 10 Kriterien)

---

## Splitting-Strategien

### 1. Layer-basiertes Splitting

```
Große Story: "Implementiere User-Profil-Seite"
                    ↓
Split in:
├── Story A: Backend-API für User-Profil (3 Dateien, ~150 LOC)
├── Story B: Frontend-Komponente für Profil (3 Dateien, ~200 LOC)
└── Story C: E2E-Tests für Profil-Flow (2 Dateien, ~100 LOC)
```

### 2. Feature-basiertes Splitting

```
Große Story: "Implementiere komplettes Auth-System"
                    ↓
Split in:
├── Story A: Login-Funktionalität
├── Story B: Registration-Funktionalität
├── Story C: Password-Reset-Funktionalität
└── Story D: Session-Management
```

### 3. CRUD-basiertes Splitting

```
Große Story: "CRUD für Produkte"
                    ↓
Split in:
├── Story A: Create Produkt
├── Story B: Read/List Produkte
├── Story C: Update Produkt
└── Story D: Delete Produkt
```

---

## Beispiele

### SCHLECHT - Zu große Story

```markdown
## Story: Komplettes Dashboard implementieren

**Geschätzte Dateien:** 15
**Geschätzte LOC:** 2000
**Komplexität:** XL

### Akzeptanzkriterien
- [ ] Sidebar mit Navigation
- [ ] Header mit User-Menu
- [ ] Dashboard-Widgets (5 verschiedene)
- [ ] Responsive Design
- [ ] Dark Mode Support
- [ ] API-Integration für alle Widgets
- [ ] Loading States
- [ ] Error Handling
- [ ] Unit Tests
- [ ] E2E Tests
```

**Problem:** Zu viele Concerns, zu viele Dateien, zu viele LOC

---

### GUT - Richtig gesplittet

```markdown
## Story: Dashboard-Sidebar implementieren

**Geschätzte Dateien:** 3
**Geschätzte LOC:** 150
**Komplexität:** S (2 SP)

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: src/components/Dashboard/Sidebar.tsx
- [ ] FILE_EXISTS: src/components/Dashboard/Sidebar.test.tsx

**Inhalt-Prüfungen:**
- [ ] CONTAINS: Sidebar.tsx enthält "NavigationItem"
- [ ] CONTAINS: Sidebar.tsx enthält "export default Sidebar"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: npm run lint exits with 0
- [ ] TEST_PASS: npm test -- Sidebar passes
```

**Warum gut:**
- Single Concern (nur Sidebar)
- 3 Dateien
- ~150 LOC
- Prüfbare Akzeptanzkriterien

---

## Checkliste vor Story-Erstellung

Bevor eine Story finalisiert wird, prüfe:

- [ ] **Max 5 Dateien?** Wenn nein → SPLIT
- [ ] **Max 400 LOC?** Wenn nein → SPLIT
- [ ] **Max Komplexität S?** Wenn nein → SPLIT
- [ ] **Single Concern?** Wenn nein → SPLIT
- [ ] **Prüfbare ACs?** Wenn nein → Umformulieren
- [ ] **Completion Check möglich?** Wenn nein → Konkretisieren

---

## Referenzen

- **Akzeptanzkriterien-Format:** Siehe user-stories-template.md
- **MCP-Tool-Requirements:** Siehe mcp-setup-guide.md
- **Workflow:** Siehe create-spec.md
