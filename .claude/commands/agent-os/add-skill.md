# Add Skill

Interaktiv einen neuen Custom Skill im Anthropic Folder Format anlegen.

Refer to the instructions located in agent-os/workflows/core/add-skill.md

## Command Arguments

Parse the following arguments from the user's command:

- `skill-name`: Optional - Name des Skills (wird sonst interaktiv abgefragt)
- `--category <category>`: Optional - Kategorie/Ordner (default: interaktiv)
- `--agent <agent-name>`: Optional - Agent dem der Skill zugewiesen wird

## Usage Examples

```bash
# Interaktiv (empfohlen)
/add-skill

# Mit Skill-Name
/add-skill api-error-handling

# Direkt einem Agent zuweisen
/add-skill form-validation --agent backend-dev

# Projektweiter Skill
/add-skill form-validation --category project
```

## Output

### Für Agent-Skills:
```
.claude/skills/dev-team/{agent-role}/{skill-name}/
└── SKILL.md

.claude/agents/{agent-name}.md (aktualisiert mit neuem Skill)
```

### Für Project-Skills:
```
.claude/skills/{category}/{skill-name}/
└── SKILL.md
```

## Features

- **Interaktiv**: Führt durch alle Schritte mit AskUserQuestion
- **Agent-Integration**: Weist Skills automatisch DevTeam-Agents zu
- **Templates**: Standard, Minimal, oder Pattern-focused
- **Auto-Aktivierung**: Konfigurierbare Glob-Patterns für Dateitypen
- **YAML Frontmatter**: Generiert korrektes Anthropic Skills Format
