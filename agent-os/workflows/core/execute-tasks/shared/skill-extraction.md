---
description: Skill Pattern Extraction - shared across phases
version: 3.0
---

# Skill Pattern Extraction

Extract only "Quick Reference" sections from skills to minimize context usage.

## Process

1. **Read Story File**
   - Find "### Relevante Skills" section
   - Extract skill paths from table

2. **Fallback if Not Found**
   - Read `agent-os/team/skill-index.md`
   - Match story type to skill category
   - Select 1-2 default skills

3. **Extract Quick Reference**
   - For each skill, find "## Quick Reference" section
   - Extract content (typically 50-100 lines)
   - Skip full skill content (often 600+ lines)

4. **Format for Task Prompt**
   ```markdown
   ### Patterns & Guidelines (from skills)

   #### [Skill Name]
   [Quick Reference content]
   ```

## Example

**Story has:**
```markdown
| Skill | Pfad | Grund |
|-------|------|-------|
| Logic Implementing | agent-os/skills/backend-logic-implementing.md | Service Object |
```

**Extracted (15 lines instead of 600+):**
```markdown
## Quick Reference
**When to use:** Service Objects, Business Logic

**Key Patterns:**
1. Service Object: One class per use case
2. Validation: Fail fast at start
3. Error Handling: Custom exceptions
```

## Token Savings

| Approach | Tokens |
|----------|--------|
| Full skill file | ~2000-3000 |
| Quick Reference only | ~200-400 |
| **Savings** | **85-90%** |
