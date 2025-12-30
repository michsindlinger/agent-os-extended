# Add Skill Command - Lite Summary

Generate project-specific skills from templates to enable agents to learn and apply project patterns consistently.

## Key Points
- **What**: Command that analyzes project code OR applies best practices to generate customized skill files
- **Why**: Reduce context overhead, ensure pattern consistency, enable agents to understand project-specific approaches
- **Two Modes**:
  - **Code Analysis**: Scans existing code to discover patterns, validates against best practices, suggests improvements
  - **Best Practices**: Applies framework-specific best practices without analyzing existing code
- **Skill Types**: API Patterns, Component Patterns, Testing Patterns, Deployment Patterns, File Organization
- **Output**: `.claude/skills/[project]-[type]-patterns.md` files with all customization complete
- **Integration**: Agents automatically load skills via `skills_project` field in team configuration
