# Spec Tasks

These are the tasks to be completed for the spec detailed in @agent-os/specs/2025-12-29-agent-os-manager-gui/spec.md

> Created: 2025-12-29
> Status: Ready for Implementation

## Tasks

### 1. Project Infrastructure Setup

**Status**: Not Started

#### 1.1. Initialize Electron + React Project
- [ ] Create new directory: `agent-os-manager/`
- [ ] Initialize package.json with project metadata
- [ ] Install Electron (latest stable)
- [ ] Install React 18+ and React DOM
- [ ] Install TypeScript 5+
- [ ] Install Vite 5+ for React bundling
- [ ] Install electron-vite for integrated build setup

#### 1.2. Configure Build Tools
- [ ] Setup Vite config for renderer process (React app)
- [ ] Setup Vite config for main process (Electron main)
- [ ] Setup Vite config for preload script
- [ ] Configure TypeScript for main process (Node.js target)
- [ ] Configure TypeScript for renderer process (DOM target)
- [ ] Configure TypeScript for preload script (isolated context)
- [ ] Add build scripts to package.json (dev, build, preview)

#### 1.3. Setup TailwindCSS 4.0
- [ ] Install TailwindCSS 4.0
- [ ] Install PostCSS and Autoprefixer
- [ ] Create tailwind.config.js with content paths
- [ ] Create PostCSS config
- [ ] Add Tailwind directives to main CSS file
- [ ] Verify TailwindCSS hot reload in dev mode

#### 1.4. Configure electron-builder
- [ ] Install electron-builder
- [ ] Create electron-builder.yml config
- [ ] Configure macOS DMG build settings
- [ ] Configure Windows NSIS installer settings
- [ ] Configure Linux AppImage settings
- [ ] Add package scripts for platform-specific builds
- [ ] Setup build output directory structure

#### 1.5. Create Basic Electron Structure
- [ ] Create `src/main/` directory for main process
- [ ] Create `src/preload/` directory for preload scripts
- [ ] Create `src/renderer/` directory for React app
- [ ] Implement basic main.ts (window creation, app lifecycle)
- [ ] Implement preload.ts (contextBridge API exposure)
- [ ] Create minimal React app entry point (main.tsx)
- [ ] Create index.html template for renderer
- [ ] Verify app launches with window

#### 1.6. Setup Development Environment
- [ ] Install ESLint for TypeScript
- [ ] Install Prettier for code formatting
- [ ] Create .eslintrc configuration
- [ ] Create .prettierrc configuration
- [ ] Add lint and format scripts to package.json
- [ ] Setup .gitignore (node_modules, dist, out, etc.)
- [ ] Create README.md with setup instructions

---

### 2. Backend (Main Process) - File System Operations

**Status**: Not Started

#### 2.1. Path Resolution System
- [ ] Create `src/main/utils/paths.ts`
- [ ] Implement function to get user home directory
- [ ] Implement function to get global Agent OS path (`~/.agent-os/`)
- [ ] Implement function to detect current project root (search for `.agent-os/` or `agent-os/`)
- [ ] Implement function to get project Agent OS path
- [ ] Implement priority resolution (project overrides global)
- [ ] Add unit tests for path resolution edge cases

#### 2.2. Frontmatter Parser
- [ ] Install `gray-matter` package
- [ ] Create `src/main/utils/frontmatter.ts`
- [ ] Implement function to parse frontmatter from markdown
- [ ] Implement function to extract frontmatter fields
- [ ] Implement function to serialize frontmatter + content
- [ ] Implement validation for required frontmatter fields
- [ ] Add unit tests for frontmatter parsing

#### 2.3. Skills CRUD Operations
- [ ] Create `src/main/services/skills.service.ts`
- [ ] Implement `listSkills()` - return all skills with source (global/project)
- [ ] Implement `readSkill(name)` - read skill file with frontmatter
- [ ] Implement `writeSkill(name, content)` - write skill to project
- [ ] Implement `deleteSkill(name)` - delete skill from project
- [ ] Implement `overrideSkillToProject(name)` - copy global to project
- [ ] Implement `revertSkillToGlobal(name)` - delete project override
- [ ] Implement `diffSkill(name)` - compare global vs project versions
- [ ] Add error handling for missing files

#### 2.4. Agents CRUD Operations
- [ ] Create `src/main/services/agents.service.ts`
- [ ] Implement `listAgents()` - return all agents with source
- [ ] Implement `readAgent(name)` - read agent file with frontmatter
- [ ] Implement `writeAgent(name, content)` - write agent to project
- [ ] Implement `deleteAgent(name)` - delete agent from project
- [ ] Implement `overrideAgentToProject(name)` - copy global to project
- [ ] Implement `revertAgentToGlobal(name)` - delete project override
- [ ] Implement `diffAgent(name)` - compare global vs project versions
- [ ] Validate agent frontmatter (name, description, tools array)

#### 2.5. Templates CRUD Operations
- [ ] Create `src/main/services/templates.service.ts`
- [ ] Implement `listTemplates()` - return tree structure (system → category → templates)
- [ ] Implement `readTemplate(system, category, name)` - read template file
- [ ] Implement `writeTemplate(system, category, name, content)` - write to project
- [ ] Implement `deleteTemplate(system, category, name)` - delete from project
- [ ] Implement `overrideTemplateToProject(system, category, name)` - copy to project
- [ ] Implement `revertTemplateToGlobal(system, category, name)` - delete override
- [ ] Implement `diffTemplate(system, category, name)` - compare versions
- [ ] Handle nested directory creation for new templates

#### 2.6. Config Read/Write Operations
- [ ] Install `js-yaml` package for YAML parsing
- [ ] Create `src/main/services/config.service.ts`
- [ ] Implement `readConfig()` - read and parse config.yml (project first, then global)
- [ ] Implement `writeConfig(config)` - serialize and write to project config.yml
- [ ] Implement YAML validation before write
- [ ] Implement schema validation for config structure
- [ ] Add error handling for malformed YAML
- [ ] Implement `resetConfigSection(section)` - reset section to defaults

#### 2.7. IPC Handlers Setup
- [ ] Create `src/main/ipc/handlers.ts`
- [ ] Register IPC handlers for all skills operations
- [ ] Register IPC handlers for all agents operations
- [ ] Register IPC handlers for all templates operations
- [ ] Register IPC handlers for all config operations
- [ ] Register IPC handler for getting dashboard stats
- [ ] Register IPC handler for getting current paths (global/project)
- [ ] Add comprehensive error handling and error messages
- [ ] Add logging for all IPC operations

#### 2.8. Preload API Exposure
- [ ] Create `src/preload/api.ts`
- [ ] Expose skills API via contextBridge
- [ ] Expose agents API via contextBridge
- [ ] Expose templates API via contextBridge
- [ ] Expose config API via contextBridge
- [ ] Expose dashboard API via contextBridge
- [ ] Create TypeScript definitions for preload API
- [ ] Verify type safety in renderer process

---

### 3. Frontend Foundation

**Status**: Not Started

#### 3.1. React App Structure
- [ ] Install React Router DOM
- [ ] Create `src/renderer/App.tsx` with router setup
- [ ] Create route structure (/dashboard, /skills, /agents, /templates, /config)
- [ ] Create `src/renderer/pages/` directory
- [ ] Create placeholder components for each route
- [ ] Verify routing works with browser navigation

#### 3.2. TailwindCSS Styling Setup
- [ ] Create `src/renderer/styles/globals.css` with Tailwind directives
- [ ] Import globals.css in main.tsx
- [ ] Test Tailwind utility classes work
- [ ] Add custom color palette to tailwind.config.js
- [ ] Add custom spacing/sizing if needed
- [ ] Verify dark mode support (class-based strategy)

#### 3.3. Layout Component
- [ ] Create `src/renderer/components/Layout.tsx`
- [ ] Implement sidebar navigation (fixed left panel)
- [ ] Add navigation items (Dashboard, Skills, Agents, Templates, Config)
- [ ] Implement active route highlighting
- [ ] Create main content area (scrollable)
- [ ] Add header with app title and theme toggle
- [ ] Make layout responsive (collapse sidebar on small screens)

#### 3.4. App State Management
- [ ] Create `src/renderer/context/AppContext.tsx`
- [ ] Create state for current project path
- [ ] Create state for global path
- [ ] Create state for active profile
- [ ] Create state for theme (dark/light)
- [ ] Implement functions to load paths on app init
- [ ] Implement functions to reload/refresh data
- [ ] Wrap App with AppContext provider

#### 3.5. Source Badge Component
- [ ] Create `src/renderer/components/SourceBadge.tsx`
- [ ] Display "Global" badge with ✅ emoji for global source
- [ ] Display "Project" badge with 🔶 emoji for project source
- [ ] Add appropriate styling (colors, rounded corners)
- [ ] Add tooltip explaining global vs project
- [ ] Make badge size configurable (small, medium, large)

#### 3.6. Common UI Components
- [ ] Create `src/renderer/components/ui/Button.tsx` (primary, secondary, danger variants)
- [ ] Create `src/renderer/components/ui/Card.tsx` (reusable card container)
- [ ] Create `src/renderer/components/ui/Modal.tsx` (overlay dialog)
- [ ] Create `src/renderer/components/ui/Input.tsx` (text input with label)
- [ ] Create `src/renderer/components/ui/Toggle.tsx` (on/off switch)
- [ ] Create `src/renderer/components/ui/Select.tsx` (dropdown select)
- [ ] Create `src/renderer/components/ui/Badge.tsx` (generic badge component)
- [ ] Test all components in isolation

#### 3.7. Dark/Light Mode Implementation
- [ ] Create `src/renderer/hooks/useTheme.ts`
- [ ] Implement theme toggle logic
- [ ] Persist theme preference to localStorage
- [ ] Apply dark/light class to document root
- [ ] Create theme toggle button in header
- [ ] Verify all components look good in both modes
- [ ] Add smooth transition between themes

---

### 4. Dashboard

**Status**: Not Started

#### 4.1. Dashboard Layout
- [ ] Create `src/renderer/pages/Dashboard.tsx`
- [ ] Create grid layout for stats cards
- [ ] Add header section with title and refresh button
- [ ] Add section for current paths display
- [ ] Add section for quick actions
- [ ] Make layout responsive for different screen sizes

#### 4.2. Component Count Calculation
- [ ] Create `src/renderer/hooks/useDashboardStats.ts`
- [ ] Fetch skills count (global + project)
- [ ] Fetch agents count (global + project)
- [ ] Fetch templates count (global + project)
- [ ] Calculate total components count
- [ ] Calculate overrides count (project only)
- [ ] Implement refresh/reload functionality
- [ ] Add loading state while fetching stats

#### 4.3. Stats Cards Display
- [ ] Create `src/renderer/components/StatsCard.tsx`
- [ ] Display total skills count with breakdown (global/project)
- [ ] Display total agents count with breakdown
- [ ] Display total templates count with breakdown
- [ ] Display total overrides count
- [ ] Add icons for each stat type (using Lucide React)
- [ ] Add hover effects on cards
- [ ] Link cards to respective manager pages

#### 4.4. Current Paths Display
- [ ] Create section to display global Agent OS path
- [ ] Display current project path (if detected)
- [ ] Show "No project detected" if not in project
- [ ] Add button to manually select project directory
- [ ] Add button to open global directory in file explorer
- [ ] Add button to open project directory in file explorer

#### 4.5. Quick Actions Section
- [ ] Add "Create New Skill" button → opens skills page with new modal
- [ ] Add "Create New Agent" button → opens agents page with new modal
- [ ] Add "Reload All" button → refreshes all data
- [ ] Add "Open Config" button → navigates to config page
- [ ] Style buttons with appropriate colors and icons

#### 4.6. Active Profile Indicator
- [ ] Fetch active profile from config
- [ ] Display active profile name prominently
- [ ] Add badge/indicator if no profile is active
- [ ] Add link to config page to change profile
- [ ] Display profile description (if available)

---

### 5. Skills Manager

**Status**: Not Started

#### 5.1. Skills List View
- [ ] Create `src/renderer/pages/Skills.tsx`
- [ ] Create table component for skills list
- [ ] Display columns: Name, Description, Source, Actions
- [ ] Fetch and display all skills on page load
- [ ] Add loading spinner while fetching
- [ ] Add empty state message if no skills found
- [ ] Make table rows clickable (navigate to edit view)

#### 5.2. Search and Filter
- [ ] Add search input at top of page
- [ ] Implement search filter by skill name
- [ ] Implement search filter by description
- [ ] Add dropdown filter for source (All, Global, Project)
- [ ] Add filter for overridden skills only
- [ ] Update table in real-time as filters change
- [ ] Add clear filters button

#### 5.3. Source Indicators
- [ ] Add SourceBadge component to each table row
- [ ] Show Global badge for global skills
- [ ] Show Project badge for project skills
- [ ] Highlight overridden skills (project version exists for global skill)
- [ ] Add tooltip explaining override status

#### 5.4. Skills Editor Modal
- [ ] Install `@monaco-editor/react` package
- [ ] Create `src/renderer/components/SkillEditor.tsx`
- [ ] Implement Monaco Editor with markdown syntax highlighting
- [ ] Load skill content into editor when skill selected
- [ ] Display frontmatter fields visually above editor (name, description, etc.)
- [ ] Add save button with keyboard shortcut (Cmd+S / Ctrl+S)
- [ ] Add cancel button to close without saving
- [ ] Implement modal overlay (dim background)

#### 5.5. Frontmatter Validation
- [ ] Create `src/renderer/utils/validation.ts`
- [ ] Implement frontmatter validation for skills (name, description required)
- [ ] Show validation errors inline in editor
- [ ] Prevent save if validation fails
- [ ] Display error messages clearly
- [ ] Highlight invalid frontmatter lines

#### 5.6. Save and Cancel Actions
- [ ] Implement save handler (call backend IPC)
- [ ] Show success notification on save
- [ ] Show error notification if save fails
- [ ] Implement cancel handler (close modal, discard changes)
- [ ] Add confirmation dialog if unsaved changes exist
- [ ] Refresh skills list after save

#### 5.7. Override to Project Button
- [ ] Add "Override to Project" button in editor (global skills only)
- [ ] Implement handler to copy global skill to project
- [ ] Show confirmation dialog before override
- [ ] Update source badge after override
- [ ] Show success notification
- [ ] Refresh skills list

#### 5.8. Revert to Global Button
- [ ] Add "Revert to Global" button in editor (project overrides only)
- [ ] Implement handler to delete project override
- [ ] Show confirmation dialog before revert
- [ ] Update source badge after revert
- [ ] Show success notification
- [ ] Refresh skills list

#### 5.9. Diff View (Compare Global vs Project)
- [ ] Add "Show Diff" button (visible only for overridden skills)
- [ ] Create `src/renderer/components/DiffViewer.tsx`
- [ ] Implement side-by-side diff view (global on left, project on right)
- [ ] Highlight differences between versions
- [ ] Add option to accept global changes (revert override)
- [ ] Add option to keep project changes
- [ ] Close diff view and return to editor

---

### 6. Agents Manager

**Status**: Not Started

#### 6.1. Agents List View
- [ ] Create `src/renderer/pages/Agents.tsx`
- [ ] Create table component for agents list
- [ ] Display columns: Name, Description, Tools, Source, Actions
- [ ] Fetch and display all agents on page load
- [ ] Add loading spinner while fetching
- [ ] Add empty state message if no agents found
- [ ] Make table rows clickable (navigate to edit view)

#### 6.2. Search and Filter
- [ ] Add search input at top of page
- [ ] Implement search filter by agent name
- [ ] Implement search filter by description
- [ ] Add dropdown filter for source (All, Global, Project)
- [ ] Add filter for overridden agents only
- [ ] Update table in real-time as filters change
- [ ] Add clear filters button

#### 6.3. Agents Editor Modal
- [ ] Create `src/renderer/components/AgentEditor.tsx`
- [ ] Implement Monaco Editor with markdown syntax highlighting
- [ ] Load agent content into editor when agent selected
- [ ] Display frontmatter fields visually above editor
- [ ] Add save button with keyboard shortcut
- [ ] Add cancel button to close without saving
- [ ] Implement modal overlay

#### 6.4. Frontmatter Validation for Agents
- [ ] Implement frontmatter validation (name, description, tools required)
- [ ] Validate tools field is an array
- [ ] Show validation errors inline in editor
- [ ] Prevent save if validation fails
- [ ] Display error messages clearly
- [ ] Highlight invalid frontmatter lines

#### 6.5. Override and Revert Functionality
- [ ] Add "Override to Project" button (global agents only)
- [ ] Add "Revert to Global" button (project overrides only)
- [ ] Implement override handler (copy global to project)
- [ ] Implement revert handler (delete project override)
- [ ] Show confirmation dialogs
- [ ] Update source badge after actions
- [ ] Refresh agents list

#### 6.6. Display Agent Frontmatter Visually
- [ ] Create `src/renderer/components/AgentFrontmatterDisplay.tsx`
- [ ] Display agent name as heading
- [ ] Display description in card
- [ ] Display tools list as badges or chips
- [ ] Display other frontmatter fields (if any)
- [ ] Make frontmatter display editable (sync with editor)

---

### 7. Templates Manager

**Status**: Not Started

#### 7.1. Hierarchical Tree View
- [ ] Create `src/renderer/pages/Templates.tsx`
- [ ] Install tree view component library or build custom
- [ ] Display templates in tree structure: System → Category → Templates
- [ ] Fetch templates tree structure from backend
- [ ] Implement expand/collapse for tree nodes
- [ ] Add loading spinner while fetching
- [ ] Add empty state message if no templates found

#### 7.2. Template Selection
- [ ] Make template names clickable in tree
- [ ] Load template content when selected
- [ ] Display template path breadcrumb (System / Category / Template)
- [ ] Highlight selected template in tree
- [ ] Add keyboard navigation (arrow keys to navigate tree)

#### 7.3. Template Editor with Monaco
- [ ] Create `src/renderer/components/TemplateEditor.tsx`
- [ ] Implement Monaco Editor with markdown syntax highlighting
- [ ] Load template content into editor when selected
- [ ] Add save button with keyboard shortcut
- [ ] Add cancel button to close without saving
- [ ] Display template metadata (system, category, name)

#### 7.4. Markdown Preview Mode
- [ ] Install markdown rendering library (e.g., react-markdown)
- [ ] Add "Preview" toggle button in editor
- [ ] Implement split view (editor on left, preview on right)
- [ ] Render markdown with proper styling
- [ ] Sync scroll between editor and preview
- [ ] Add "Edit" / "Preview" / "Split" mode toggle

#### 7.5. Override and Revert for Templates
- [ ] Add "Override to Project" button (global templates only)
- [ ] Add "Revert to Global" button (project overrides only)
- [ ] Implement override handler (copy global to project)
- [ ] Implement revert handler (delete project override)
- [ ] Show confirmation dialogs
- [ ] Update source badge in tree after actions
- [ ] Refresh templates tree

#### 7.6. Handle Nested Directory Structure
- [ ] Implement create new template in specific category
- [ ] Implement create new category under system
- [ ] Automatically create nested directories when saving
- [ ] Handle deletion of empty directories
- [ ] Validate path before creating templates

---

### 8. Config Editor

**Status**: Not Started

#### 8.1. Config Page Layout
- [ ] Create `src/renderer/pages/Config.tsx`
- [ ] Create accordion layout for config sections
- [ ] Add sections: General, Profiles, Skills, Team System, Market Validation
- [ ] Add header with save button and reset button
- [ ] Add loading spinner while fetching config
- [ ] Add success/error notifications

#### 8.2. Visual Form for Config Sections
- [ ] Create `src/renderer/components/config/GeneralSection.tsx`
- [ ] Create `src/renderer/components/config/ProfilesSection.tsx`
- [ ] Create `src/renderer/components/config/SkillsSection.tsx`
- [ ] Create `src/renderer/components/config/TeamSystemSection.tsx`
- [ ] Create `src/renderer/components/config/MarketValidationSection.tsx`
- [ ] Map config fields to appropriate form inputs

#### 8.3. Form Field Types
- [ ] Implement toggle switches for boolean fields
- [ ] Implement dropdown selects for enum fields
- [ ] Implement number inputs for numeric fields
- [ ] Implement text inputs for string fields
- [ ] Implement array inputs (add/remove items)
- [ ] Implement nested object inputs (recursive form fields)

#### 8.4. Section Accordion Implementation
- [ ] Implement expand/collapse for each section
- [ ] Add section headings with description
- [ ] Persist expanded/collapsed state to localStorage
- [ ] Add expand all / collapse all buttons
- [ ] Show validation errors per section

#### 8.5. YAML Validation Before Save
- [ ] Create `src/renderer/utils/yamlValidation.ts`
- [ ] Validate YAML structure before save
- [ ] Validate required fields exist
- [ ] Validate field types match schema
- [ ] Show validation errors inline
- [ ] Prevent save if validation fails

#### 8.6. Raw YAML Editor Mode
- [ ] Add "Raw YAML" toggle button
- [ ] Implement Monaco Editor with YAML syntax highlighting
- [ ] Load raw config.yml into editor
- [ ] Parse YAML in real-time as user types
- [ ] Show YAML syntax errors inline
- [ ] Sync changes between visual form and raw editor

#### 8.7. Reset to Defaults Per Section
- [ ] Add "Reset Section" button for each section
- [ ] Implement handler to reset section to default values
- [ ] Show confirmation dialog before reset
- [ ] Update form fields with default values
- [ ] Show success notification

#### 8.8. Show Validation Errors Inline
- [ ] Display validation errors next to invalid fields
- [ ] Highlight invalid fields with red border
- [ ] Show error icon next to invalid fields
- [ ] Add tooltip with error message
- [ ] Scroll to first error on validation failure

---

### 9. Testing

**Status**: Not Started

#### 9.1. Unit Tests - Path Resolution
- [ ] Install Vitest for testing
- [ ] Create `src/main/utils/__tests__/paths.test.ts`
- [ ] Test getting home directory
- [ ] Test getting global Agent OS path
- [ ] Test detecting project root (various scenarios)
- [ ] Test priority resolution (project overrides global)
- [ ] Test edge cases (no project, no global)

#### 9.2. Unit Tests - Frontmatter Parsing
- [ ] Create `src/main/utils/__tests__/frontmatter.test.ts`
- [ ] Test parsing frontmatter from markdown
- [ ] Test extracting specific frontmatter fields
- [ ] Test serializing frontmatter + content
- [ ] Test validation for required fields
- [ ] Test edge cases (no frontmatter, empty frontmatter)

#### 9.3. Unit Tests - YAML Validation
- [ ] Create `src/main/services/__tests__/config.test.ts`
- [ ] Test parsing valid YAML config
- [ ] Test detecting invalid YAML syntax
- [ ] Test validating config schema
- [ ] Test handling missing required fields
- [ ] Test edge cases (empty config, malformed YAML)

#### 9.4. Integration Tests - IPC Communication
- [ ] Create `src/__tests__/integration/ipc.test.ts`
- [ ] Test skills IPC handlers (list, read, write, delete)
- [ ] Test agents IPC handlers
- [ ] Test templates IPC handlers
- [ ] Test config IPC handlers
- [ ] Test dashboard stats IPC handler
- [ ] Test error handling in IPC handlers

#### 9.5. E2E Test - Dashboard Load
- [ ] Install Playwright for E2E testing
- [ ] Create `e2e/dashboard.spec.ts`
- [ ] Test launching app
- [ ] Test dashboard page loads
- [ ] Test stats cards display correctly
- [ ] Test navigation to other pages works
- [ ] Test theme toggle works

#### 9.6. E2E Test - Edit and Save Skill
- [ ] Create `e2e/skills.spec.ts`
- [ ] Test navigating to skills page
- [ ] Test opening skill editor
- [ ] Test editing skill content
- [ ] Test saving skill
- [ ] Test verification that file was written to disk
- [ ] Test closing editor

#### 9.7. E2E Test - Create Override
- [ ] Create `e2e/override.spec.ts`
- [ ] Test selecting global skill
- [ ] Test clicking "Override to Project" button
- [ ] Test confirmation dialog appears
- [ ] Test confirming override
- [ ] Test verification that file was copied to project
- [ ] Test source badge updates to "Project"

---

### 10. Packaging & Distribution

**Status**: Not Started

#### 10.1. Configure electron-builder for All Platforms
- [ ] Update electron-builder.yml with app metadata
- [ ] Set app ID, product name, version
- [ ] Configure file associations (if any)
- [ ] Configure protocols (if any)
- [ ] Set build output directories
- [ ] Configure compression settings

#### 10.2. macOS DMG Installer Setup
- [ ] Configure mac section in electron-builder.yml
- [ ] Set category (Utility or Developer Tools)
- [ ] Configure DMG background image (optional)
- [ ] Configure DMG window size and icon position
- [ ] Set icon file (.icns)
- [ ] Configure target (dmg, zip)

#### 10.3. Code Signing for macOS
- [ ] Obtain Apple Developer certificate
- [ ] Configure signing identity in electron-builder.yml
- [ ] Configure entitlements (com.apple.security.app-sandbox, etc.)
- [ ] Configure hardened runtime
- [ ] Configure notarization credentials
- [ ] Test signing locally
- [ ] Test notarization

#### 10.4. Windows EXE Installer Setup
- [ ] Configure win section in electron-builder.yml
- [ ] Set target (nsis for installer)
- [ ] Configure NSIS installer options
- [ ] Set icon file (.ico)
- [ ] Configure installation directory
- [ ] Configure Start Menu shortcut
- [ ] Configure desktop shortcut

#### 10.5. Linux AppImage Setup
- [ ] Configure linux section in electron-builder.yml
- [ ] Set target (AppImage)
- [ ] Set category (Utility)
- [ ] Set icon file (.png)
- [ ] Configure AppImage name
- [ ] Test AppImage on various distros (Ubuntu, Fedora, etc.)

#### 10.6. Auto-Update Mechanism (Optional)
- [ ] Install electron-updater package
- [ ] Configure update server URL
- [ ] Implement auto-update logic in main process
- [ ] Add "Check for Updates" menu item
- [ ] Show update notification to user
- [ ] Test update flow (download, install, restart)

#### 10.7. Create Installation Instructions
- [ ] Create INSTALL.md with platform-specific instructions
- [ ] Add macOS installation steps (download DMG, drag to Applications)
- [ ] Add Windows installation steps (download EXE, run installer)
- [ ] Add Linux installation steps (download AppImage, make executable)
- [ ] Add troubleshooting section
- [ ] Add system requirements

#### 10.8. Build and Test All Platforms
- [ ] Run build for macOS (on macOS machine or CI)
- [ ] Run build for Windows (on Windows machine or CI)
- [ ] Run build for Linux (on Linux machine or CI)
- [ ] Test installed app on each platform
- [ ] Verify all features work in packaged app
- [ ] Verify file paths resolve correctly in packaged app
- [ ] Document any platform-specific issues

---

## Notes

- **Development Priority**: Build infrastructure and backend first, then frontend incrementally
- **Testing Strategy**: Unit tests for critical logic (paths, parsing), E2E tests for user workflows
- **UI/UX**: Focus on simplicity and clarity - power users will appreciate directness over fancy animations
- **Performance**: Monaco Editor is heavy - consider lazy loading for editor components
- **Error Handling**: Always show clear error messages to users, never fail silently
- **File Watching**: Consider adding file system watchers to auto-reload when files change externally
- **Keyboard Shortcuts**: Power users appreciate shortcuts (Cmd+S to save, Cmd+K to search, etc.)

## Dependencies

### Core Dependencies
- Electron (latest stable)
- React 18+
- TypeScript 5+
- Vite 5+
- TailwindCSS 4.0
- React Router DOM
- @monaco-editor/react
- gray-matter (frontmatter parsing)
- js-yaml (YAML parsing)
- lucide-react (icons)
- electron-builder (packaging)

### Dev Dependencies
- Vitest (unit testing)
- Playwright (E2E testing)
- ESLint
- Prettier
- TypeScript type definitions (@types/node, @types/react, etc.)

## Estimated Timeline

- **Phase 1 (Infrastructure)**: 1-2 weeks
- **Phase 2 (Backend)**: 2-3 weeks
- **Phase 3 (Frontend Foundation)**: 1-2 weeks
- **Phase 4-8 (Feature Pages)**: 3-4 weeks
- **Phase 9 (Testing)**: 1-2 weeks
- **Phase 10 (Packaging)**: 1 week

**Total Estimated Time**: 9-14 weeks (2-3.5 months) for single developer

---

**Last Updated**: 2025-12-29
**Status**: Ready for implementation
**Next Step**: Begin with Phase 1 - Project Infrastructure Setup
