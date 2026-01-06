---
name: [SKILL_NAME]
description: [SHORT_DESCRIPTION]
version: 1.0
encoding: UTF-8
---

# [SKILL_NAME]

> [LONGER_DESCRIPTION_OF_WHAT_THIS_SKILL_PROVIDES]

## Trigger Conditions

This skill is automatically activated when:

### File Extension Triggers
```yaml
file_extension:
  - .[EXT_1]
  - .[EXT_2]
```

### Content Triggers
```yaml
file_contains:
  - "[PATTERN_1]"
  - "[PATTERN_2]"
```

### Task Mention Triggers
```yaml
task_mentions:
  - "[KEYWORD_1]"
  - "[KEYWORD_2]"
  - "[KEYWORD_1]|[KEYWORD_2]|[KEYWORD_3]"  # OR pattern
```

### Always Active
```yaml
always_active: false  # Set to true if always loaded
always_active_for_agents:
  - "[AGENT_NAME_1]"
  - "[AGENT_NAME_2]"
```

---

## MCP Server Integration

### Required MCP Servers

| Server | Purpose | Required |
|--------|---------|----------|
| [MCP_SERVER_1] | [PURPOSE] | Yes/No |
| [MCP_SERVER_2] | [PURPOSE] | Yes/No |

### MCP Tools Used

```yaml
mcp_tools:
  - server: [MCP_SERVER_NAME]
    tools:
      - [TOOL_NAME_1]  # [BRIEF_DESCRIPTION]
      - [TOOL_NAME_2]  # [BRIEF_DESCRIPTION]
```

### MCP Configuration

```json
{
  "mcpServers": {
    "[MCP_SERVER_NAME]": {
      "command": "[COMMAND]",
      "args": ["[ARG_1]", "[ARG_2]"],
      "env": {
        "[ENV_VAR]": "[VALUE]"
      }
    }
  }
}
```

### MCP Usage Examples

**Using [MCP_TOOL_1]:**
```
mcp__[server]__[tool] with parameters:
- param1: [DESCRIPTION]
- param2: [DESCRIPTION]
```

---

## Core Competencies

### [COMPETENCY_1]

[DESCRIPTION_OF_COMPETENCY]

**Key Principles:**
- [PRINCIPLE_1]
- [PRINCIPLE_2]
- [PRINCIPLE_3]

### [COMPETENCY_2]

[DESCRIPTION_OF_COMPETENCY]

**Key Principles:**
- [PRINCIPLE_1]
- [PRINCIPLE_2]

---

## Best Practices

### [CATEGORY_1]

1. **[PRACTICE_1]**
   - [DETAIL]
   - [DETAIL]

2. **[PRACTICE_2]**
   - [DETAIL]

### [CATEGORY_2]

1. **[PRACTICE_1]**
   - [DETAIL]

---

## Anti-Patterns

### What to Avoid

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| [ANTI_PATTERN_1] | [WHY_IT_IS_BAD] | [WHAT_TO_DO_INSTEAD] |
| [ANTI_PATTERN_2] | [WHY_IT_IS_BAD] | [WHAT_TO_DO_INSTEAD] |
| [ANTI_PATTERN_3] | [WHY_IT_IS_BAD] | [WHAT_TO_DO_INSTEAD] |

---

## Code Examples

### Example 1: [EXAMPLE_NAME]

**Context:** [WHEN_TO_USE_THIS]

```[LANGUAGE]
// [DESCRIPTION]
[CODE_EXAMPLE]
```

### Example 2: [EXAMPLE_NAME]

**Context:** [WHEN_TO_USE_THIS]

```[LANGUAGE]
// [DESCRIPTION]
[CODE_EXAMPLE]
```

---

## Checklists

### Before Starting

- [ ] [PREREQUISITE_1]
- [ ] [PREREQUISITE_2]
- [ ] [PREREQUISITE_3]

### During Implementation

- [ ] [CHECK_1]
- [ ] [CHECK_2]
- [ ] [CHECK_3]

### Before Completion

- [ ] [FINAL_CHECK_1]
- [ ] [FINAL_CHECK_2]
- [ ] [FINAL_CHECK_3]

---

## Integration with Other Skills

### Works Well With

| Skill | Relationship |
|-------|--------------|
| [SKILL_1] | [HOW_THEY_WORK_TOGETHER] |
| [SKILL_2] | [HOW_THEY_WORK_TOGETHER] |

### Conflicts With

| Skill | Conflict | Resolution |
|-------|----------|------------|
| [SKILL_1] | [CONFLICT_DESCRIPTION] | [HOW_TO_RESOLVE] |

---

## References

- [DOCUMENTATION_LINK_1]
- [DOCUMENTATION_LINK_2]
- Related Skills: [SKILL_1], [SKILL_2]
