# Optimize Profile

Analysiert eine Projektausschreibung und extrahiert strukturierte Anforderungen mit Buzzwords für die Profil-Optimierung.

Refer to the instructions located in specwright/workflows/core/optimize-profile.md

**Features (Phase 1):**
- Extrahiert Muss- und Soll-Anforderungen aus Projektausschreibungen
- Identifiziert Buzzwords (Kern-Begriffe) pro Anforderung
- Bildet logische Buzzword-Gruppen mit UND/ODER-Verknüpfung
- Ergänzt intelligente Buzzwords basierend auf Technologie-Versionen
- Erkennt implizite Requirements (z.B. Angular 14-20 → Signals, Zoneless)

**Output:**
- Strukturierte Requirements-Analyse in `.specwright/profile-optimization/`
- Buzzword-Gruppen mit logischen Verknüpfungen
- Intelligente Ergänzungen mit Begründungen
- Alphabetische Buzzword-Übersicht
- Gesicherte Input-Dateien für spätere Phasen

**Nächster Schritt:**
- Phase 2: `/optimize-profile-match` - Matched Profil gegen diese Anforderungen und optimiert es
