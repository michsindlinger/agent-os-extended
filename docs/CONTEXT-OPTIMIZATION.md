# Context Window Optimization Guide

## Das Problem

Wenn du in CLAUDE.md `@`-Referenzen verwendest, werden diese Dateien **sofort beim Start** in den Kontext geladen - nicht lazy bei Bedarf.

### Beispiel: Typische problematische CLAUDE.md

```markdown
## Agent OS Workflows
- **Plan Product**: @agent-os/workflows/core/plan-product.md
- **Plan Platform**: @agent-os/workflows/core/plan-platform.md
- **Create Spec**: @agent-os/workflows/core/create-spec.md
- **Execute Tasks**: @agent-os/workflows/core/execute-tasks.md
```

**Folge:** ~20.000 Tokens werden beim Start geladen, bevor du überhaupt eine Frage stellst!

## Die Lösung: Lazy Loading Pattern

### 1. Workflows NIEMALS in CLAUDE.md referenzieren

Die Workflows werden **automatisch** geladen, wenn du `/plan-product`, `/execute-tasks` etc. aufrufst. Das passiert über das Command-System in `.claude/commands/`.

**Falsch:**
```markdown
- **Plan Product**: @agent-os/workflows/core/plan-product.md
```

**Richtig:**
```markdown
## Available Commands (loaded on demand)
- `/plan-product` - Single-product planning
- `/execute-tasks` - Task execution
```

### 2. Product-Dokumente nur bei Bedarf laden

Statt:
```markdown
- **Product Vision**: @agent-os/product/product-brief.md
```

Verwende:
```markdown
## Document Locations (load via context-fetcher when needed)
- **Product Vision**: agent-os/product/product-brief.md
```

Und lade bei Bedarf mit dem context-fetcher Subagent.

### 3. Lite-Versionen bevorzugen

Wenn du Kontext brauchst, lade die Lite-Version:
- `product-brief-lite.md` statt `product-brief.md`
- `spec-lite.md` statt `spec.md`

## Token-Vergleich

| Konfiguration | Tokens beim Start |
|--------------|-------------------|
| CLAUDE.md mit allen @-Referenzen | ~20.000+ |
| CLAUDE.md ohne @-Referenzen | ~500 |
| **Ersparnis** | **~19.500 Tokens** |

## Migration bestehender Projekte

### Schritt 1: CLAUDE.md bereinigen

Ersetze alle `@`-Referenzen durch reine Pfadangaben:

```bash
# Vorher
@agent-os/workflows/core/plan-product.md

# Nachher (kein @, nur Pfad als Dokumentation)
agent-os/workflows/core/plan-product.md
```

### Schritt 2: Template verwenden

Kopiere das optimierte Template:
```bash
cp agent-os/templates/CLAUDE-LITE.md CLAUDE.md
```

### Schritt 3: Projekt-spezifische Anpassungen

Bearbeite die neue CLAUDE.md und füge nur essentielle, wirklich immer benötigte Informationen hinzu.

## Best Practices

### DO:
- Commands/Skills nutzen (`/plan-product`, `/execute-tasks`)
- context-fetcher für on-demand Loading verwenden
- Lite-Versionen von Dokumenten bevorzugen
- Kurze, prägnante CLAUDE.md halten

### DON'T:
- `@`-Referenzen zu großen Dateien in CLAUDE.md
- Workflows in CLAUDE.md referenzieren (sind bereits als Commands verfügbar)
- Komplette Dokumentation in CLAUDE.md einbetten

## Technischer Hintergrund

Claude Code lädt `@`-Referenzen **synchron und vollständig** beim Konversationsstart. Das ist by design, da CLAUDE.md als "immer verfügbarer Kontext" gedacht ist.

Für Lazy Loading muss man:
1. Die `@`-Referenzen entfernen
2. Das Command/Skill-System nutzen (lädt bei Aufruf)
3. Oder den context-fetcher Subagent für manuelles Loading verwenden
