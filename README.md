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

## Project Structure

After installation, your project will contain:

```
your-project/
├── standards/
│   ├── tech-stack.md
│   ├── code-style.md
│   ├── best-practices.md
│   └── code-style/
│       ├── javascript-style.md
│       ├── css-style.md
│       └── html-style.md
├── instructions/
│   ├── core/
│   │   ├── analyze-product.md
│   │   ├── create-spec.md
│   │   ├── execute-task.md
│   │   ├── execute-tasks.md
│   │   └── plan-product.md
│   └── meta/
│       └── pre-flight.md
├── commands/ (Claude Code)
│   ├── plan-product.md
│   ├── create-spec.md
│   ├── execute-tasks.md
│   └── analyze-product.md
├── agents/ (Claude Code)
│   ├── test-runner.md
│   ├── context-fetcher.md
│   ├── git-workflow.md
│   ├── file-creator.md
│   └── date-checker.md
└── .cursor/rules/ (Cursor)
    ├── plan-product.mdc
    ├── create-spec.mdc
    ├── execute-tasks.mdc
    └── analyze-product.mdc
```

## Usage

### With Claude Code
Use commands like `/plan-product`, `/create-spec`, `/execute-tasks`, and `/analyze-product`.

### With Cursor
Use commands like `@plan-product`, `@create-spec`, `@execute-tasks`, and `@analyze-product`.

## Enterprise Features

This extended version provides additional capabilities for enterprise development:

- Project-specific configuration management
- Enhanced workflow automation
- Scalable team collaboration patterns
- Advanced development standards enforcement

## Original Agent OS

For more information about the original Agent OS concept, visit [buildermethods.com/agent-os](https://buildermethods.com/agent-os).

## License

This project maintains the same open-source license as the original Agent OS project.