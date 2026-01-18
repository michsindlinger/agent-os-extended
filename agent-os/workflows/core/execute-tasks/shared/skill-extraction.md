---
description: Skill Path Extraction - shared across phases
version: 4.0
---

# Skill Path Extraction

Extract skill file paths from stories and pass them to sub-agents.
Sub-agents load the complete skill files themselves (not the orchestrator).

## Process

1. **Read Story File**
   - Find "### Relevante Skills" section
   - Extract skill paths from table

2. **Fallback if Not Found**
   - Read `agent-os/team/skill-index.md`
   - Match story type to skill category
   - Select 1-2 default skills

3. **Extract Paths Only**
   - Collect skill file paths
   - Do NOT read skill contents
   - Sub-agent will load complete skills

4. **Format for Task Prompt**
   ```markdown
   **Required Skills (load these files):**
   - [skill-path-1]
   - [skill-path-2]
   ```

## Example

**Story has:**
```markdown
| Skill | Pfad | Grund |
|-------|------|-------|
| Logic Implementing | agent-os/skills/backend-logic-implementing.md | Service Object |
| Test Automation | agent-os/skills/qa-test-automation.md | Unit tests |
```

**Extracted (paths only):**
```markdown
**Required Skills (load these files):**
- agent-os/skills/backend-logic-implementing.md
- agent-os/skills/qa-test-automation.md
```

## Architectural Change (v4.0)

| Version | Approach | Who loads skills? |
|---------|----------|-------------------|
| v3.0 | Orchestrator extracts Quick Reference | Orchestrator |
| v4.0 | Orchestrator passes paths only | **Sub-Agent** |

**Benefits:**
- Sub-agents get complete skill context (patterns, examples, edge cases)
- Orchestrator saves context (doesn't load skill contents)
- More accurate implementation following all skill guidelines
