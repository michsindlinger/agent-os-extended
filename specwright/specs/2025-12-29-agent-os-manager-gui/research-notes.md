# Research Notes

Research and analysis for the spec detailed in @specwright/specs/2025-12-29-specwright-manager-gui/spec.md

> Created: 2025-12-29
> Version: 1.0.0

## Feature Overview

**Specwright Manager GUI - Desktop Application**

A desktop GUI application for managing Specwright components with visual editing capabilities:

- **Primary Purpose**: Visual interface for editing skills, agents, templates, and configuration files
- **Core Functionality**: File management with global vs project override visualization
- **Target Users**: Technical developers who prefer visual management over command-line editing
- **Key Value**: Clear indicators showing which components are global vs project-specific overrides

**Developer Context:**
Since the target audience is technical developers, we can:
- Use Monaco Editor for code/YAML editing
- Show technical details (file paths, frontmatter structure)
- Assume YAML knowledge
- Use developer-friendly terminology

## Codebase Analysis

### Current State

**Finding: Greenfield Project**
- No existing GUI components in codebase
- Pure React + TailwindCSS implementation needed
- Opportunity to design from scratch with modern patterns

**Finding: Tech Stack Available**
- React (latest stable) already in use
- TailwindCSS 4.0+ configured
- Node.js 22 LTS environment
- Vite build system available

**Finding: Well-Defined File Structure**
```
Global locations:
  ~/.specwright/
    skills/
    agents/
    templates/
    config.yml
  ~/.claude/
    skills/ (symlinks to ~/.specwright/skills/)

Project locations:
  specwright/
    skills/
    agents/
    templates/
    config.yml
  .claude/
    skills/ (symlinks to specwright/skills/)
```

### Existing Patterns

**Pattern: Global + Override Architecture**
- Found in: market-validation system, team-system
- Global components in ~/.specwright/ or .claude/
- Project overrides in specwright/ or .claude/
- Clear inheritance hierarchy
- Override indicator pattern to reuse

**Pattern: Frontmatter Metadata**
Skills and agents use YAML frontmatter:
```yaml
---
name: skill-name
type: utility
status: active
---
Content here
```

**Pattern: Symlink Management**
- .claude/skills/ contains symlinks to specwright/skills/
- GUI must handle both real files and symlinks
- Need to resolve symlink targets for editing

### Required Libraries

**Monaco Editor** (@monaco-editor/react)
- Industry-standard code editor
- Syntax highlighting for YAML, Markdown
- IntelliSense capabilities
- Theme support (dark/light)

**Electron** (electron + electron-builder)
- Desktop application framework
- Native file system access
- IPC communication
- Auto-updater support

**YAML Processing** (js-yaml + gray-matter)
- gray-matter: Parse frontmatter
- js-yaml: Validate YAML syntax
- Handle config.yml parsing

**File Operations** (Node.js built-in + optional chokidar)
- fs/promises: Async file operations
- glob: File pattern matching
- chokidar: Optional file watching (deferred for MVP)

## Requirements Clarification

### User Decisions (From Questionnaire)

**1. Target Audience: Developers (Technical)**
- Implication: Can use Monaco Editor
- Implication: Can show technical details
- Implication: Can assume YAML knowledge
- Implication: Can use developer-friendly UI patterns

**2. Deployment: Electron Desktop App**
- Implication: Native file system integration
- Implication: Better performance than web app
- Implication: Can use Node.js APIs directly
- Implication: Cross-platform (macOS, Windows, Linux)

**3. MVP Features: All 4 Selected**
- Skills List & Edit
- Agents List & Edit
- Config Editor (config.yml)
- Templates Manager

**4. File Watching: Manual Refresh**
- Implication: Simpler implementation
- Implication: User clicks reload button
- Implication: No chokidar needed for MVP
- Implication: Reduce complexity and potential race conditions

### Derived Requirements

**Must Handle:**
- Global component locations (~/.specwright/, ~/.claude/)
- Project component locations (specwright/, .claude/)
- Symlink resolution (.claude/skills/ → specwright/skills/)
- Frontmatter parsing and validation
- YAML syntax validation
- File read/write operations with error handling

**Must Display:**
- Clear global vs override indicators
- Component status (active/inactive)
- Component type (utility/specialist/etc)
- File paths (for debugging)
- Validation errors (YAML syntax, missing fields)

**Must Support:**
- Create new components
- Edit existing components
- Delete components (with confirmation)
- Navigate between global and project contexts
- Refresh data manually

## Visual Assets

**No Mockups Provided**

Design will be created during implementation with these guidelines:

**Style Inspiration:**
- VS Code-inspired interface
- Developer-focused aesthetics
- Clean, minimal design
- Dark/light mode support

**Layout Concepts:**
- Sidebar navigation (Skills, Agents, Config, Templates)
- List/detail view pattern
- Split panes for editing
- Status indicators and badges

**Color Scheme:**
- Follow TailwindCSS utility classes
- Dark mode: Dark gray backgrounds, light text
- Light mode: Light backgrounds, dark text
- Accent colors for status (active=green, inactive=gray)

## Technical Constraints

### File System Constraints

**Global vs Project Locations**
- Must detect user home directory (~/)
- Must detect project root (where specwright/ exists)
- Must handle cases where global or project locations don't exist
- Must create directories when needed (with user confirmation)

**Symlink Handling**
- Must distinguish symlinks from real files
- Must resolve symlink targets for editing
- Must update symlinks when moving files
- Must handle broken symlinks gracefully

**File Parsing**
- Must parse YAML frontmatter correctly (gray-matter)
- Must validate YAML syntax (js-yaml)
- Must handle malformed frontmatter gracefully
- Must preserve exact formatting when possible

### Error Handling

**Critical Operations:**
- File read failures (permissions, not found)
- File write failures (permissions, disk full)
- YAML parsing errors (syntax, structure)
- Symlink resolution errors (broken links)

**User Feedback:**
- Clear error messages (not technical stack traces)
- Actionable suggestions (e.g., "Check file permissions")
- Non-blocking warnings (e.g., "YAML formatting improved")

### Performance Constraints

**File Operations:**
- Must not block UI during file reads
- Must debounce auto-save operations
- Must handle large files efficiently (Monaco handles this)
- Must limit initial file scanning

**Memory:**
- Don't load all files into memory at once
- Load file content on-demand (when user clicks)
- Release memory when switching files

## Recommendations

### Reuse Strategy

**No Existing Components to Reuse**
- Greenfield project (no GUI components exist)
- Follow Specwright tech stack: React + TailwindCSS
- Use Instrumental Components if applicable for desktop UI
- Create reusable components for future features

**Patterns to Follow:**
- Global + Override pattern (from market-validation, team-system)
- Frontmatter metadata pattern (from existing skills/agents)
- Component structure pattern (name, type, status)

### Implementation Approach

**Architecture: Electron Multi-Process**

**Main Process (Node.js):**
- File system operations (read, write, delete, list)
- Symlink resolution
- Configuration management
- IPC handlers for renderer requests

**Renderer Process (React):**
- UI components (lists, editors, navigation)
- Monaco Editor integration
- State management (Context API or Zustand)
- User input validation

**IPC Communication:**
```
Renderer → Main:
  - listSkills(location: 'global' | 'project')
  - readSkill(path: string)
  - writeSkill(path: string, content: string)
  - deleteSkill(path: string)

Main → Renderer:
  - skillsLoaded(skills: Skill[])
  - skillSaved(success: boolean)
  - error(message: string)
```

**State Management:**
- Context API for simple global state (current location, theme)
- Zustand for complex state (if needed)
- Local component state for UI-only state

### Tech Stack Decisions

**Frontend Stack:**
- React 18 (latest stable)
- TypeScript (type safety for complex file operations)
- TailwindCSS 4.0+ (styling)
- Instrumental Components (if desktop-compatible)

**Editor:**
- Monaco Editor (@monaco-editor/react)
- Language: markdown, yaml
- Theme: vs-dark, vs-light
- Features: syntax highlighting, validation, IntelliSense

**Desktop Framework:**
- Electron (latest stable)
- electron-builder (packaging for macOS, Windows, Linux)
- Electron Forge (alternative, evaluate during implementation)

**Build System:**
- Vite (already in use)
- electron-vite (Vite + Electron integration)
- Hot reload for development

**Icons:**
- Lucide React (consistent with Specwright standards)
- Developer-friendly iconography

**YAML Processing:**
- gray-matter (frontmatter parsing)
- js-yaml (YAML validation and parsing)

**File Operations:**
- Node.js fs/promises (async file ops)
- glob (file pattern matching for listing)
- chokidar (optional, deferred for MVP - file watching)

### Development Phases

**Phase 1: Core Infrastructure**
- Electron setup with Vite
- IPC communication architecture
- File system operations (read, list)
- Basic React app structure

**Phase 2: Skills Management**
- Skills list view (global + project)
- Skills editor with Monaco
- Frontmatter parsing
- Override indicators

**Phase 3: Agents Management**
- Agents list view
- Agents editor
- Reuse Skills components (similar structure)

**Phase 4: Config Editor**
- config.yml editor
- YAML validation
- Global vs project config

**Phase 5: Templates Manager**
- Templates list
- Template editor
- Template variables preview

**Phase 6: Polish**
- Dark/light mode
- Error handling refinement
- Performance optimization
- User testing

## Open Questions

### Future Enhancements

**Auto-Update Mechanism:**
- Q: Should the GUI auto-update global components when Specwright releases updates?
- Consideration: Version management, user control, conflict resolution
- Decision: Deferred to post-MVP (manual updates for now)

**Multi-Project Management:**
- Q: Should users be able to switch between multiple projects in the same window?
- Consideration: Project detection, workspace management, recent projects list
- Decision: Deferred to post-MVP (single project focus for MVP)

**Export/Import Configuration:**
- Q: Should users be able to export/import entire configurations?
- Consideration: Backup, sharing, migration
- Decision: Nice-to-have, consider for Phase 2

**Conflict Resolution:**
- Q: What happens if both global and project components are edited simultaneously?
- Consideration: Merge strategies, user choice, last-write-wins
- Current: Manual refresh means user sees state when they reload
- Decision: Document expected behavior, no automatic merging in MVP

### Technical Decisions to Make

**State Management:**
- Q: Context API or Zustand?
- Lean: Start with Context API, migrate to Zustand if complexity grows

**Packaging:**
- Q: electron-builder or Electron Forge?
- Lean: electron-builder (more popular, better docs)

**Testing Strategy:**
- Q: Unit tests, integration tests, E2E tests?
- Lean: Focus on IPC integration tests, critical file operations

**Distribution:**
- Q: Code signing, notarization (macOS), installer formats?
- Lean: Deferred to post-MVP (development builds only)

## Next Steps

1. Review research notes with stakeholders
2. Update spec.md with any missing requirements
3. Create technical-spec.md with detailed architecture
4. Define tasks.md with implementation steps
5. Begin Phase 1: Core Infrastructure

---

**Research completed:** 2025-12-29
**Ready for:** Technical specification and task planning
