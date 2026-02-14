# Spec Requirements Document

> Spec: Specwright Manager GUI
> Created: 2025-12-29
> Research: @specwright/specs/2025-12-29-specwright-manager-gui/research-notes.md
> Version: 1.0

## Overview

Desktop GUI application for managing Specwright components (skills, agents, templates, configuration) with visual distinction between global and project-specific overrides. Targets technical developers who want visual overview and easy editing capabilities.

## User Stories

### Developer: Visual Component Management

As a **developer**, I want to **visually see which components are global vs project-specific**, so that **I understand my project's customization at a glance and can easily manage overrides**.

**Workflow**:
1. Developer opens Specwright Manager GUI
2. Dashboard shows: 24 skills (21 global ✅, 3 project 🔶)
3. Developer clicks "Skills" tab
4. List shows all skills with source indicators (global/project)
5. Developer clicks on "spring-boot-conventions" (🔶 project override)
6. Monaco editor opens with skill content
7. Developer edits skill, saves
8. File written to projekt/.claude/skills/spring-boot-conventions.md
9. Change immediately reflected (after manual refresh)

### Tech Lead: Configuration Management

As a **tech lead**, I want to **configure team_system settings visually**, so that **I can enable/disable specialists and adjust thresholds without YAML hand-editing**.

**Workflow**:
1. Tech lead opens Config tab
2. Sees form with all config sections
3. Toggles "QA Specialist Enabled" → true
4. Adjusts "Coverage Target" slider → 90%
5. Clicks "Save Configuration"
6. GUI validates YAML structure
7. Writes to specwright/config.yml
8. Shows success confirmation

### Developer: Override Creation

As a **developer**, I want to **easily create project-specific overrides**, so that **I can customize components for this project without affecting global installation**.

**Workflow**:
1. Developer views skills list
2. Sees "backend-dev" agent (✅ global)
3. Clicks "Override for This Project" button
4. GUI copies global version to projekt/.claude/agents/backend-dev.md
5. Monaco editor opens with copied content
6. Developer customizes for project-specific patterns
7. Saves override
8. Future: This project uses custom backend-dev, others use global

## Spec Scope

### 1. Dashboard (Overview)

**Component Counts**:
- Display total counts: Skills, Agents, Templates, Workflows
- Show breakdown: Global vs Project (with badges)
- Visual indicators: ✅ Global, 🔶 Project override

**Current Project Info**:
- Project path display
- Global location display
- Active profile indicator

**Quick Actions**:
- Create new skill button
- Create new agent button
- Reload all components button

### 2. Skills Manager

**Skills List View**:
- Table with columns: Name, Description, Source (Global/Project), Actions
- Visual badges: ✅ Green for global, 🔶 Orange for project
- Search/filter by name or description
- Sort by name, source, category

**Skill Editor**:
- Monaco Editor integration
- Syntax highlighting (Markdown + YAML frontmatter)
- Frontmatter validation (name, description, globs required)
- Save button with validation
- Cancel button
- Show file path (global or project)

**Skill Actions**:
- Edit skill (opens Monaco editor)
- Override to project (copies global → project, opens editor)
- Revert to global (deletes project override, ask confirmation)
- Show in file system (opens folder in Finder/Explorer)

### 3. Agents Manager

**Agent List View**:
- Table: Name, Description, Source, Actions
- Visual badges for source
- Search/filter capabilities

**Agent Editor**:
- Monaco Editor with Markdown + YAML
- Frontmatter validation (name, description, tools)
- Display frontmatter fields visually (name, description, tools, color, mcp_integrations)

**Agent Actions**:
- Edit agent
- Override to project
- Revert to global
- Show in file system

### 4. Templates Manager

**Template Tree View**:
- Hierarchical display:
  - team-development/
    - backend/ (4 templates)
    - frontend/ (4 templates)
    - qa/ (2 templates)
    - devops/ (2 templates)
  - market-validation/ (7 templates)
  - research/ (3 templates)

**Template Editor**:
- Monaco Editor
- Markdown syntax highlighting
- Preview mode (rendered markdown)
- Save/Cancel actions

**Template Actions**:
- Edit template
- Override to project
- Revert to global

### 5. Config Editor

**Visual Config Form**:
- Section accordion: General, Profiles, Skills, Team System, Market Validation
- Form fields instead of raw YAML editing:
  - Toggle switches for booleans (enabled: true/false)
  - Dropdowns for options (default_stack: java_spring_boot)
  - Number inputs for thresholds (coverage_target: 80)
  - Text inputs for strings
- Live validation
- Reset to defaults button per section
- Save button (validates before writing)

**Raw YAML View** (advanced):
- Toggle to view/edit raw config.yml
- Monaco Editor with YAML syntax
- Syntax validation

### 6. File System Integration

**Automatic Path Resolution**:
- Detect global location: ~/.specwright/ or specwright/specwright/
- Detect project location: current working directory
- Display both paths prominently

**Lookup Order Visualization**:
- When viewing component, show which file is actually used
- Display: "Using: projekt/.claude/skills/frontend-design.md (project override)"
- Or: "Using: ~/.specwright/skills/base/testing-best-practices.md (global)"

**Override Management**:
- One-click "Override for This Project" button
- Copies global file to project location
- Opens in editor for customization
- Shows diff with global version

## Out of Scope

**Not in MVP (v1.0):**
- ❌ Multi-project switcher (focus on current project)
- ❌ Live file watching (manual refresh button instead)
- ❌ Git integration (commit/push from GUI)
- ❌ Component usage analytics (which components are actually loaded)
- ❌ Dependency graph (which agents use which skills)
- ❌ Auto-update mechanism (update global components from GUI)
- ❌ Export/import configuration profiles
- ❌ Conflict resolution UI (if file edited externally and in GUI)
- ❌ Command palette (VS Code-style)

**Future Enhancements (v2.0+):**
- Live file watching with chokidar
- Multi-project management (switch between projects)
- Visual dependency graph
- Usage analytics (which skills/agents loaded in recent tasks)
- Built-in terminal (execute /execute-tasks from GUI)
- Workflow execution viewer (see specialist execution in real-time)

## Expected Deliverable

### Desktop Application (Electron)

**Platform Support**:
- macOS (primary)
- Windows
- Linux

**Package**:
- DMG installer (macOS)
- EXE installer (Windows)
- AppImage (Linux)

### Features Delivered

1. **Dashboard** - Overview with component counts and quick actions
2. **Skills Manager** - List, edit, override, revert skills
3. **Agents Manager** - List, edit, override, revert agents
4. **Templates Manager** - Hierarchical view, edit, override templates
5. **Config Editor** - Visual form-based config editing with validation
6. **File System Integration** - Automatic path detection, override management

### Technical Deliverables

1. **Electron App Structure**:
   - main.js (Electron main process - file operations)
   - preload.js (IPC bridge)
   - renderer/ (React frontend)

2. **React Application**:
   - Dashboard component
   - Skills list and editor components
   - Agents list and editor components
   - Templates tree and editor components
   - Config editor component
   - Monaco Editor integration

3. **Build Configuration**:
   - electron-builder config
   - Vite config for React
   - TypeScript configuration

4. **Package Scripts**:
   - npm run dev (development mode)
   - npm run build (production build)
   - npm run package (create installers)

## Research References

This spec was informed by:
- ✅ **User Q&A session** (target audience, deployment, MVP features, file watching)
- ✅ **Codebase analysis** (greenfield project, tech stack available)
- ✅ **Technical constraints** (global/project paths, frontmatter parsing, YAML validation)
- ❌ **Visual design analysis** - No mockups provided (design during implementation)

Comprehensive research documentation: @specwright/specs/2025-12-29-specwright-manager-gui/research-notes.md

## Success Criteria

**Functional Success**:
- [ ] Launch app, see dashboard with accurate component counts
- [ ] View skills list with correct global/project source indicators
- [ ] Edit global skill, save, see changes reflected
- [ ] Override skill to project (one-click), edit, save to project location
- [ ] Revert project override to global (deletes project file)
- [ ] View agents list, edit agent, save successfully
- [ ] View templates in hierarchical tree
- [ ] Edit config visually (form fields), save to config.yml with valid YAML
- [ ] Manual refresh updates all lists after external file changes

**Quality Success**:
- [ ] Monaco Editor works correctly (syntax highlighting, editing)
- [ ] Frontmatter validation catches errors (missing name, invalid globs)
- [ ] Config validation prevents invalid YAML
- [ ] File paths resolve correctly (global ~/.specwright/ and project specwright/)
- [ ] Override mechanism works (copy global → project)
- [ ] Diff view shows differences between global and project versions

**UX Success**:
- [ ] Clear visual distinction (✅ global, 🔶 project)
- [ ] Intuitive navigation (tabs, breadcrumbs)
- [ ] Fast loading (<2s startup)
- [ ] Responsive UI (resize works correctly)
- [ ] Error messages clear and actionable
- [ ] Dark/light mode support (matches system preference)

**Technical Success**:
- [ ] Electron app packages successfully (macOS, Windows, Linux)
- [ ] IPC communication works (renderer ↔ main process)
- [ ] File operations handle errors gracefully
- [ ] Symlinks detected correctly
- [ ] YAML parsing reliable
- [ ] TypeScript type safety throughout

## Spec Documentation

- Tasks: @specwright/specs/2025-12-29-specwright-manager-gui/tasks.md
- Technical Specification: @specwright/specs/2025-12-29-specwright-manager-gui/sub-specs/technical-spec.md
- Research Notes: @specwright/specs/2025-12-29-specwright-manager-gui/research-notes.md
