# Agent OS Manager GUI - Spec Summary

> Quick reference for the Agent OS Manager GUI specification
> Full spec: @agent-os/specs/2025-12-29-agent-os-manager-gui/spec.md

## What

Desktop GUI application (Electron) for managing Agent OS Extended components with visual distinction between global and project-specific overrides.

## Why

- Visual overview of all components (skills, agents, templates, config)
- Easy editing with Monaco Editor
- Clear global vs project distinction (✅ vs 🔶)
- Simplified configuration management (forms instead of YAML)
- One-click override creation
- Better onboarding for teams

## Key Features

1. **Dashboard** - Component counts, global/project breakdown, quick actions
2. **Skills Manager** - List, edit, override, revert skills with Monaco Editor
3. **Agents Manager** - List, edit, override, revert agents
4. **Templates Manager** - Hierarchical tree view, edit templates
5. **Config Editor** - Visual form + raw YAML mode with validation
6. **Override System** - One-click copy global → project, diff view, revert

## Target Users

Technical developers who want visual management of Agent OS components

## Tech Stack

- Frontend: React 18 + TypeScript + TailwindCSS 4.0
- Editor: Monaco Editor (@monaco-editor/react)
- Desktop: Electron (latest) + electron-builder
- Icons: Lucide React
- Parsing: gray-matter (frontmatter), js-yaml (config)

## Success Metrics

- Launch app, see accurate component counts
- Edit and save components successfully
- Override global → project in one click
- Config form validates and saves YAML correctly
- Clear visual distinction (global vs project)

## Timeline

MVP: 6-8 weeks (Infrastructure, Core UI, Editors, Config, Polish, Package)
