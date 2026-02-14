# Dienstleistungs-Positionierung entwickeln

## Zweck
Entwickelt eine professionelle Positionierungsstrategie auf Basis vorhandener Projekt-Spezifikationen und Marktforschung, um die optimale Ausrichtung deiner Dienstleistungen zu finden.

## Verwendung
```bash
/develop-positioning [projekt-pfad]
```

**Parameter:**
- `projekt-pfad` (optional): Pfad zum Projekt mit `.specwright/specs/` Ordner (Standard: aktuelles Verzeichnis)

**Beispiel:**
```bash
/develop-positioning ~/Entwicklung/privat/kreis-lippe-audit
```

## Ablauf

### Phase 1: Fähigkeiten-Analyse (10 Min)

**Aufgabe:** Analysiere alle Spezifikationen im `.specwright/specs/` Ordner des angegebenen Projekts.

**Extrahiere:**
- **Technische Kompetenzen**: Technologien, Frameworks, Tools
- **Branchen-Expertise**: Branchenkenntnisse, Domänenwissen
- **Projekt-Erfahrungen**: Art der gelösten Probleme, Projektkomplexität
- **Methodiken**: Besondere Ansätze, Prozesse, Best Practices
- **Differenzierungsmerkmale**: Was hebt die Projekte von Standard-Lösungen ab?

**Format:** Erstelle eine strukturierte Übersicht in `/tmp/positionierung-faehigkeiten.md`

### Phase 2: Marktforschung (15 Min)

**Aufgabe:** Nutze Perplexity für umfassende Marktforschung.

**Recherche-Fragen:**

1. **Marktgröße & -dynamik:**
   ```
   Wie groß ist der Markt für [identifizierte Fähigkeiten]?
   Welche Trends gibt es 2025 in diesem Bereich?
   Welche Branchen investieren am meisten?
   ```

2. **Wettbewerbsanalyse:**
   ```
   Wer sind die Hauptanbieter für [identifizierte Fähigkeiten]?
   Wie positionieren sich erfolgreiche Dienstleister in diesem Bereich?
   Welche Nischen sind unterversorgt?
   ```

3. **Positionierungs-Optionen:**
   ```
   Basierend auf den Fähigkeiten [Liste]:
   - Welche Positionierung ist am erfolgversprechendsten?
   - Breite Positionierung (KI-Integration für Business-Prozesse) vs.
     Spezialisierte Positionierung (Datensichere lokale LLMs)?
   - Welche Zielgruppen zahlen Premium-Preise?
   - Welche Positionierung hat weniger Wettbewerb?
   ```

4. **Zielgruppen-Insights:**
   ```
   Für die empfohlene Positionierung:
   - Was sind die größten Schmerzpunkte der Zielgruppe?
   - Welche Kaufmotivationen haben sie?
   - Auf welchen Kanälen sind sie aktiv?
   ```

**Format:** Dokumentiere Recherche-Ergebnisse in `/tmp/positionierung-marktforschung.md`

### Phase 3: Positionierungs-Empfehlung (5 Min)

**Aufgabe:** Entwickle eine klare Positionierungs-Empfehlung.

**Analysiere:**
- Welche Positionierung passt am besten zu den identifizierten Fähigkeiten?
- Welche verspricht den größten Markterfolg?
- Welche Zielgruppe ist am lukrativsten?
- Was ist die Differenzierung zur Konkurrenz?

**Format:** Erstelle in `/tmp/positionierung-empfehlung.md`:
```markdown
## Empfohlene Positionierung

[Klare, einzeilige Positionierung]

### Begründung
- **Marktpotenzial**: [Größe, Wachstum]
- **Wettbewerbsvorteil**: [Differenzierung]
- **Zielgruppe**: [Lukrativste Kunden]
- **Fähigkeiten-Match**: [Wie gut passt es?]

### Alternative Positionierungen
1. [Alternative 1]: [Pro/Contra]
2. [Alternative 2]: [Pro/Contra]
```

**STOP und frage nach User-Bestätigung**, bevor du mit Phase 4 weitermachst.

### Phase 4: Positionierungs-Entwicklung (20 Min)

**Aufgabe:** Entwickle die vollständige Positionierung basierend auf der bestätigten Empfehlung.

#### 4.1 Elevator Pitch (3 Varianten)

Erstelle 3 Versionen (30 Sek, 60 Sek, 120 Sek) nach der AIDA-Formel:
- **Attention**: Problem definieren
- **Interest**: Lösung präsentieren
- **Desire**: Einzigartigkeit erklären
- **Action**: Call-to-Action

#### 4.2 Value Proposition

Nutze das Value Proposition Template:
```markdown
## Value Proposition

**Für:** [Zielgruppe]
**Die:** [Problem/Bedürfnis haben]
**Ist unser Service:** [Kategorie]
**Der:** [Hauptnutzen]
**Anders als:** [Konkurrenz]
**Wir:** [Differenzierung]

### Gain Creators (Nutzenstifter)
- [Was schafft Mehrwert?]

### Pain Killers (Problemlöser)
- [Was löst Schmerzpunkte?]
```

#### 4.3 Buyer Personas (2-3 Profile)

Für jede Persona:
```markdown
## Persona: [Name]

**Bild**: [Emoji/Beschreibung]

### Demografisch
- Rolle: [Jobtitel]
- Unternehmensgröße: [z.B. 50-200 MA]
- Branche: [z.B. Öffentliche Verwaltung]

### Psychografisch
- Ziele: [Was will die Person erreichen?]
- Herausforderungen: [Was hält sie davon ab?]
- Motivationen: [Was treibt sie an?]

### Kaufverhalten
- Entscheidungskriterien: [Was ist wichtig?]
- Budget: [Preissensitivität]
- Informationsquellen: [Wo sucht sie nach Lösungen?]

### Jobs-to-be-Done
- [Welche "Jobs" will sie mit deinem Service erledigen?]
```

#### 4.4 Messaging Framework

```markdown
## Messaging Framework

### Kommunikativer Leitgedanke
[Die Kern-Idee, mit der du kommunizierst]

### Kernbotschaften

**Primäre Botschaft:**
[Die wichtigste Botschaft - was ist der #1 Vorteil?]

**Sekundäre Botschaften:**
1. [Unterstützende Botschaft 1]
2. [Unterstützende Botschaft 2]
3. [Unterstützende Botschaft 3]

### Reason Why
[Warum sollte man dir glauben?]

### Tone of Voice
- [Wie sprichst du? z.B. Professionell aber zugänglich]
- [Welche Emotionen willst du auslösen?]
```

### Phase 5: Sichtbarkeits-Plan (15 Min)

**Aufgabe:** Entwickle einen kompakten, umsetzbaren Plan für die ersten 3 Monate.

#### 5.1 Kanalstrategie

Basierend auf der Zielgruppen-Recherche:
```markdown
## Kanalstrategie

### Primäre Kanäle (Fokus)
1. **[Kanal 1]** (z.B. LinkedIn)
   - Warum: [Zielgruppe ist dort aktiv]
   - Frequenz: [z.B. 3x pro Woche]
   - Content-Type: [z.B. Thought Leadership Posts]

2. **[Kanal 2]** (z.B. Eigene Website)
   - Warum: [...]
   - Frequenz: [...]
   - Content-Type: [...]

### Sekundäre Kanäle (Optional)
- [Kanal]: [Geringer Aufwand, z.B. Newsletter 1x/Monat]
```

#### 5.2 Content-Strategie (3 Monate)

```markdown
## Content-Strategie

### Monat 1: Foundation (Awareness)
**Ziel**: Bekanntheit aufbauen, Expertise zeigen

**Woche 1-2:**
- [ ] LinkedIn Profil optimieren (About, Header, Featured)
- [ ] Website Hero-Section aktualisieren
- [ ] 1. Case Study veröffentlichen (Kreis Lippe Projekt)

**Woche 3-4:**
- [ ] 4 LinkedIn Posts (Thought Leadership)
  - Thema 1: [z.B. "Warum lokale LLMs für Behörden?"]
  - Thema 2: [...]
- [ ] 1 Blogartikel: [Thema]

### Monat 2: Engagement (Consideration)
**Ziel**: Vertrauen aufbauen, Interaktion fördern

**Content-Themen:**
- [ ] 8 LinkedIn Posts (Mix: Insights, Projekte, Learnings)
- [ ] 2 Case Studies
- [ ] 1 How-To Guide / Whitepaper

### Monat 3: Conversion (Decision)
**Ziel**: Leads generieren

**Content-Themen:**
- [ ] 8 LinkedIn Posts (inkl. Success Stories)
- [ ] 1 Webinar / Workshop ankündigen
- [ ] Lead Magnet erstellen (z.B. "Checkliste: KI-Readiness für Behörden")
```

#### 5.3 Personal Branding Maßnahmen

```markdown
## Personal Branding

### Quick Wins (Woche 1)
- [ ] LinkedIn Headline optimieren
- [ ] Professionelles Foto + Header-Bild
- [ ] About-Sektion mit Value Proposition

### Fortlaufend
- [ ] Regelmäßig eigene Insights teilen
- [ ] Kommentare auf relevante Posts (10 Min/Tag)
- [ ] Artikel teilen mit eigenem Take
- [ ] Bei Fragen in der Community helfen
```

### Phase 6: Marketing-Texte (10 Min)

**Aufgabe:** Erstelle die vom User gewünschten Marketing-Texte.

#### 6.1 LinkedIn About-Text (max. 2600 Zeichen)

**Struktur:**
1. **Hook** (erste 2 Zeilen - sichtbar ohne "mehr anzeigen")
2. **Problem & Lösung** (Value Proposition)
3. **Credibility** (Expertise, Projekte)
4. **Call-to-Action**

#### 6.2 Website Hero-Section

**Format:**
```markdown
## Website Hero-Section

### Headline (H1)
[Problemlösungs-orientierte Headline, max. 10 Wörter]

### Subline (H2)
[Erklärt die Lösung, max. 20 Wörter]

### CTA Button
[Text]: [z.B. "Kostenloses Erstgespräch"]

### Social Proof (optional)
[z.B. "Vertraut von 15+ Kommunen und Behörden"]
```

#### 6.3 Case Study Template

**Struktur:**
```markdown
# Case Study: [Projekt-Name]

## Challenge (Problem)
[Was war die Herausforderung des Kunden?]

## Solution (Lösung)
[Wie hast du es gelöst?]

## Results (Ergebnisse)
- [Messbares Ergebnis 1]
- [Messbares Ergebnis 2]
- [Messbares Ergebnis 3]

## Technologies
[Verwendete Tech]

## Client Testimonial
> "[Zitat vom Kunden]"
> — [Name, Position]
```

### Phase 7: Finales Deliverable

**Aufgabe:** Kombiniere alle Ergebnisse in einem strukturierten Dokument.

**Erstelle:**
`.specwright/docs/Marketing/Positionierung-[DATUM].md`

**Struktur:**
```markdown
# Positionierungsstrategie
> Entwickelt am: [DATUM]

## Executive Summary
[1-2 Absätze: Kernpositionierung + wichtigste Maßnahmen]

## 1. Positionierungs-Empfehlung
[Aus Phase 3]

## 2. Value Proposition
[Aus Phase 4.2]

## 3. Buyer Personas
[Aus Phase 4.3]

## 4. Messaging Framework
[Aus Phase 4.4]

## 5. Elevator Pitches
[Aus Phase 4.1]

## 6. Sichtbarkeits-Plan (3 Monate)
[Aus Phase 5]

## 7. Marketing-Texte
[Aus Phase 6]

## Next Steps
- [ ] User-Feedback einholen
- [ ] LinkedIn Profil aktualisieren
- [ ] Website anpassen
- [ ] Erste Content-Piece erstellen
```

## Best Practices

### Für die Analyse
- Fokussiere auf konkrete Projekte und messbare Ergebnisse aus den Specs
- Suche nach Mustern: Was wiederholst du? Was ist deine "Superpower"?
- Identifiziere nicht nur Tech-Skills, sondern auch Soft Skills (z.B. Kommunikation mit Behörden)

### Für die Marktforschung
- Nutze spezifische Perplexity-Anfragen mit konkreten Zahlen/Daten
- Recherchiere nicht nur Marktgröße, sondern auch Zahlungsbereitschaft
- Identifiziere aktuelle Trends (2025!) und zukünftige Entwicklungen

### Für die Positionierung
- Wähle eine Positionierung, die sowohl zu den Fähigkeiten passt ALS AUCH Marktpotenzial hat
- Sei spezifisch genug, um dich abzuheben, aber nicht zu eng, um Kunden auszuschließen
- Validiere die Positionierung mit realen Projekten (z.B. Kreis Lippe)

### Für den Sichtbarkeits-Plan
- Priorisiere 1-2 Kanäle statt viele halbherzig zu bespielen
- Plane realistisch: Qualität > Quantität
- Baue auf vorhandenen Assets auf (z.B. bestehende Projekte als Case Studies)

## Hinweise

**Zeit-Investment:** Ca. 75 Minuten für den kompletten Prozess

**Abhängigkeiten:**
- Perplexity MCP Server für Marktforschung
- `.specwright/specs/` Ordner mit aussagekräftigen Spezifikationen

**Iteration:**
- Die Positionierung ist nicht in Stein gemeißelt
- Validiere mit ersten Kunden-Gesprächen
- Passe basierend auf Feedback an

**Kritischer Erfolgsfaktor:**
- Die Positionierung muss authentisch sein und zu dir passen
- Sie muss auf echten Fähigkeiten basieren, nicht auf Wunschdenken
- Sie muss ein reales Kundenproblem lösen
