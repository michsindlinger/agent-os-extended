# Agent OS Extended

> **Note**: This repository is based on the original [Agent OS](https://github.com/buildermethods/agent-os) by Builder Methods. This extended version includes enhancements specifically designed for enterprise project development.

Agent OS Extended is a project-level implementation of the Agent OS system, designed to improve AI coding workflows through structured context and guidance. Unlike the original global installation, this version installs configuration files directly within each project.

## Key Differences from Original Agent OS

- **Project-level installation** instead of global `~/.agent-os/` installation
- **Enterprise-focused enhancements** for complex project development
- **Project-specific customization** allowing different standards per project

## Quick Start

### Base Installation
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash
```

### Tool-Specific Setup

#### Claude Code
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-claude-code.sh | bash
```

#### Cursor
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup-cursor.sh | bash
```

## Update Scripts

Update only standards:
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-standards.sh | bash
```

Update only instructions:
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-instructions.sh | bash
```

Update everything:
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-all.sh | bash
```

### Feature Management System Updates
Update Agent OS Extended installations with new Feature Management capabilities:
```bash
curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/update-agent-os.sh | bash
```

## Project Structure

After installation, your project will contain:

```
your-project/
├── CLAUDE.md (Claude Code configuration)
├── .agent-os/
│   ├── specs/ (Feature specifications - timestamped)
│   ├── docs/ (User documentation - hierarchical)
│   ├── standards/
│   │   ├── tech-stack.md
│   │   ├── code-style.md
│   │   ├── best-practices.md
│   │   └── code-style/
│   │       ├── javascript-style.md
│   │       ├── css-style.md
│   │       └── html-style.md
│   │   instructions/
│   │   ├── core/
│   │   │   ├── analyze-product.md
│   │   │   ├── analyze-b2b-application.md
│   │   │   ├── create-spec.md
│   │   │   ├── update-feature.md
│   │   │   ├── document-feature.md
│   │   │   ├── retroactive-doc.md
│   │   │   ├── execute-task.md
│   │   │   ├── execute-tasks.md
│   │   │   ├── plan-product.md
│   │   │   └── plan-b2b-application.md
│   │   └── meta/
│   │       └── pre-flight.md
│   ├── commands/ (Claude Code)
│   │   ├── plan-product.md
│   │   ├── plan-b2b-application.md
│   │   ├── create-spec.md
│   │   ├── update-feature.md
│   │   ├── document-feature.md
│   │   ├── retroactive-doc.md
│   │   ├── execute-tasks.md
│   │   ├── analyze-product.md
│   │   └── analyze-b2b-application.md
│   └── agents/ (Claude Code)
│       ├── test-runner.md
│       ├── context-fetcher.md
│       ├── git-workflow.md
│       ├── file-creator.md
│       └── date-checker.md
└── .cursor/rules/ (Cursor)
    ├── plan-product.mdc
    ├── plan-b2b-application.mdc
    ├── create-spec.mdc
    ├── execute-tasks.mdc
    ├── analyze-product.mdc
    └── analyze-b2b-application.mdc
```

## Usage

### With Claude Code
Use commands like:
- `/plan-product`, `/analyze-product` - Product planning and analysis
- `/create-spec`, `/update-feature`, `/document-feature`, `/retroactive-doc` - Feature lifecycle management
- `/execute-tasks` - Implementation execution
- `/plan-b2b-application`, `/analyze-b2b-application` - B2B application workflows

### With Cursor
Use commands like `@plan-product`, `@create-spec`, `@execute-tasks`, `@analyze-product`, `@plan-b2b-application`, and `@analyze-b2b-application`.

## Feature Management System

Agent OS Extended includes a comprehensive Feature Lifecycle Management System:

### 🔄 Complete Workflows

1. **New Feature Development**
   ```
   /create-spec → Development → /document-feature
   ```
   - Creates timestamped spec in `.agent-os/specs/YYYY-MM-DD-feature-name/`
   - Generates user documentation in `.agent-os/docs/Feature-Name/`

2. **Feature Updates**
   ```
   /update-feature → Development → /document-feature
   ```
   - Adds comprehensive change tracking in `specs/feature/changes/`
   - Updates existing documentation with new capabilities

3. **Retroactive Documentation**
   ```
   /retroactive-doc
   ```
   - Perfect for existing projects with undocumented features
   - Analyzes existing code to generate both specs and user documentation
   - Ideal for documenting legacy features step by step

### 📁 Directory Structure

- **`.agent-os/specs/`** - Development-oriented specifications (timestamped, includes change history)
- **`.agent-os/docs/`** - User-oriented documentation (hierarchical, feature-focused)

## Customization

### CLAUDE.md Configuration
The setup script installs a `CLAUDE.md` template that needs project-specific customization:

- Replace `[PROJECT_NAME]` with your project name
- Add your specific development agents and tech stack
- Configure MCP server integrations  
- Define production safety rules
- Add essential project commands

If you already have a `CLAUDE.md`, the script creates `CLAUDE.md.template` for reference.

## Enterprise Features

This extended version provides additional capabilities for enterprise development:

- **Project-specific configuration management** - Each project maintains its own Agent OS configuration
- **B2B Enterprise Planning** - Specialized workflows for B2B application development
- **Compliance & Security Integration** - Built-in support for regulatory requirements (GDPR, SOX, HIPAA)
- **Enterprise Integration Strategy** - Structured approach to system integration and migration
- **Enhanced workflow automation** - Enterprise-grade development processes
- **Scalable team collaboration patterns** - Multi-stakeholder coordination support

## Original Agent OS

For more information about the original Agent OS concept, visit [buildermethods.com/agent-os](https://buildermethods.com/agent-os).

## License

This project maintains the same open-source license as the original Agent OS project.