# CLAUDE.md

> [PROJECT_NAME] Development Guide
> Last Updated: [CURRENT_DATE]

## Purpose
Essential guidance for Claude Code development in the [PROJECT_NAME] repository. All detailed standards and product information are maintained in Agent OS structure.

## Agent OS References

### Product Information
- **Mission & Features**: @.agent-os/product/mission.md
- **Technical Architecture**: @.agent-os/product/tech-stack.md  
- **Development Roadmap**: @.agent-os/product/roadmap.md
- **Architectural Decisions**: @.agent-os/product/decisions.md

### Development Standards
- **Tech Stack Defaults**: @.agent-os/standards/tech-stack.md
- **Code Style Preferences**: @.agent-os/standards/code-style.md
- **Best Practices Philosophy**: @.agent-os/standards/best-practices.md

### Agent OS Commands
- **Plan Features**: @.agent-os/instructions/create-spec.md
- **Execute Tasks**: @.agent-os/instructions/execute-tasks.md


## Critical Rules
- **FOLLOW ALL INSTRUCTIONS** - These are mandatory, not optional
- **ASK FOR CLARIFICATION** - If uncertain about any requirement
- **MINIMIZE CHANGES** - Edit only what's necessary
- **PRODUCTION SAFETY** - [CUSTOMIZE: Add your production safety context]

## Sub-Agents
**MANDATORY DELEGATION** - Sub-agents have separate context windows. You are the strategic brain that makes high-level decisions.

**Delegation Strategy:**
- **Strategic Planning** → You decide WHAT needs to be done
- **Implementation Planning** → Delegate to Core Development specialists  
- **Execution Tasks** → Delegate to Utility & Support agents
- **Context Optimization** → Use sub-agents to keep routine tasks out of your main context

**Rule:** Never do what a specialist can do better. Always delegate when sub-agents are available.

### Core Development
<!-- CUSTOMIZE: Add your project-specific development agents -->
- **[ROLE-NAME]** - [TECHNOLOGY_DESCRIPTION]
- **[ROLE-NAME]** - [TECHNOLOGY_DESCRIPTION]

### Quality & Infrastructure
<!-- CUSTOMIZE: Add your project-specific quality agents -->
- **testing-specialist** - [YOUR_TESTING_STACK]
- **security-specialist** - [YOUR_SECURITY_SETUP]
- **devops-specialist** - [YOUR_DEPLOYMENT_PLATFORM]

### Utility & Support
- **context-fetcher** - Retrieve and extract relevant information from Agent OS documentation
- **date-checker** - Determine today's date including current year, month and day
- **file-creator** - Create files, directories, and apply templates for Agent OS workflows
- **git-workflow** - Handle git operations, branch management, commits, and PR creation
- **debugger** - Immediate bug fixes and runtime errors
- **analyzer** - Strategic problem analysis (5-Why methodology)


## Essential Commands

```bash
# CUSTOMIZE: Add your project-specific commands
# Development
[COMMAND]                # [DESCRIPTION]
[COMMAND]                # [DESCRIPTION]

# Testing
[COMMAND]                # [DESCRIPTION]
[COMMAND]                # [DESCRIPTION]
```

## MCP Server Integration

<!-- CUSTOMIZE: Add your MCP server integrations -->
- **[MCP_NAME]** - [DESCRIPTION]
- **[MCP_NAME]** - [DESCRIPTION]

## Quality Requirements

**Mandatory Checks:**
- Run linting after ALL code changes
- ALL lint errors must be fixed before task completion
- Follow TypeScript strict mode (no `any` types)
<!-- CUSTOMIZE: Add your project-specific quality requirements -->

## Production Safety Rules

**CRITICAL RESTRICTIONS:**
<!-- CUSTOMIZE: Add your production safety rules -->
- Never modify [CRITICAL_SYSTEM] without approval
- Never deploy [SENSITIVE_COMPONENT] without approval  
- Never create automatic Git commits
- Always ask before infrastructure changes

## Development Notes

<!-- CUSTOMIZE: Add your project-specific development context -->
- **Platform:** [YOUR_PLATFORM_DESCRIPTION]
- **Current Focus:** [CURRENT_DEVELOPMENT_PRIORITIES]
- **Architecture Notes:** [IMPORTANT_ARCHITECTURAL_DECISIONS]

---

**Remember:** This is a [PRODUCTION/DEVELOPMENT] system serving [TARGET_AUDIENCE]. Quality, [KEY_REQUIREMENTS], and reliability are paramount. Always refer to Agent OS documentation for detailed guidance.