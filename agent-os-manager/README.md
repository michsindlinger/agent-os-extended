# Agent OS Manager

Desktop GUI application for visual management of Agent OS Extended components (skills, agents, templates, configuration).

## Features

- 📊 **Dashboard** - Component counts with global/project breakdown
- 📝 **Skills Manager** - View, edit, override, revert skills with Monaco Editor
- 🤖 **Agents Manager** - Manage specialist agents with color indicators
- 📄 **Templates Manager** - Hierarchical tree view of all templates
- ⚙️ **Config Editor** - Visual form editor + raw YAML mode
- 🔄 **Override System** - One-click global → project copy
- 🌓 **Dark/Light Mode** - Automatic theme switching
- 🎯 **Source Indicators** - ✅ Global (green) vs 🔶 Project (orange)

## Tech Stack

- **Desktop**: Electron 39.2.7
- **Frontend**: React 19 + TypeScript 5.9 + TailwindCSS 4.0
- **Editor**: Monaco Editor 4.7.0 (VS Code's editor)
- **Icons**: Lucide React 0.562.0
- **Parsing**: gray-matter 4.0.3, js-yaml 4.1.1
- **Build**: Vite 7.3.0 + electron-builder 26.0.12
- **Testing**: Jest 30.2.0 + Testing Library

## Quick Start

### Development

```bash
# Install dependencies
npm install

# Run in development mode (hot reload)
npm run dev

# Run tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
```

### Production Build

```bash
# Build for production
npm run build

# Package for distribution
npm run package        # All platforms
npm run package:mac    # macOS DMG (universal, arm64, x64)
npm run package:win    # Windows installer
npm run package:linux  # Linux AppImage
```

## Project Structure

```
agent-os-manager/
├── src/
│   ├── main/              # Electron main process (Node.js)
│   │   ├── index.ts       # App entry, window creation, IPC handlers
│   │   ├── services/      # Business logic
│   │   │   ├── skills.service.ts
│   │   │   ├── agents.service.ts
│   │   │   ├── templates.service.ts
│   │   │   └── config.service.ts
│   │   ├── utils/         # Utilities
│   │   │   ├── paths.ts   # Path resolution (global/project)
│   │   │   └── frontmatter.ts  # Frontmatter parsing/validation
│   │   └── __tests__/     # Unit tests
│   ├── preload/           # IPC bridge (contextBridge)
│   │   └── index.ts
│   └── renderer/          # React app (UI)
│       ├── main.tsx       # React entry
│       ├── App.tsx        # Router + AppProvider
│       ├── components/    # UI components
│       │   ├── common/    # Badge, Button, Card
│       │   ├── layout/    # Layout with sidebar
│       │   ├── skills/    # SkillsList, SkillEditor
│       │   ├── agents/    # AgentsList, AgentEditor
│       │   ├── templates/ # TemplatesTree, TemplateEditor
│       │   └── config/    # ConfigForm, ConfigRawEditor
│       ├── pages/         # Page components
│       │   ├── Dashboard.tsx
│       │   ├── Skills.tsx
│       │   ├── Agents.tsx
│       │   ├── Templates.tsx
│       │   └── Config.tsx
│       ├── contexts/      # State management
│       │   └── AppContext.tsx
│       ├── types/
│       └── assets/
├── build/                 # Build resources (icons, etc.)
├── electron-builder.yml   # Packaging configuration
├── jest.config.js         # Testing configuration
└── package.json
```

## Usage

### Dashboard

![Dashboard](./docs/screenshots/dashboard.png)

- View total component counts
- See global vs project breakdown (✅ vs 🔶)
- View global and project file locations
- Quick statistics at a glance

### Skills Manager

![Skills Manager](./docs/screenshots/skills.png)

**Features**:
- List all skills with source indicators
- Search by name or description
- Edit skills with Monaco Editor (Markdown + YAML frontmatter)
- Override global skill to project (one-click copy)
- Revert project override to global (with confirmation)
- Frontmatter validation before save

**Workflow**:
1. Browse skills list
2. Click "Edit" → Monaco Editor opens
3. Modify skill content
4. Click "Save" → Validates frontmatter, writes to project
5. Or click "Override" → Copies global to project, opens editor

### Agents Manager

![Agents Manager](./docs/screenshots/agents.png)

**Features**:
- All agents with color indicators (colored dot)
- Tools display (first 3 tools shown)
- Edit, override, revert functionality
- Agent-specific frontmatter validation

**Agent-Specific**:
- Color dot shows agent.color from frontmatter
- Tools list displayed (Read, Write, Edit, etc.)
- MCP integrations visible

### Templates Manager

![Templates Manager](./docs/screenshots/templates.png)

**Features**:
- Hierarchical tree view (System > Category > Template)
- Expand/collapse folders
- Template counts per folder
- Edit templates with Monaco Editor
- Source indicators per template

**Structure Example**:
```
📁 team-development (12)
  📁 backend (4)
    📄 api-spec.md ✅ Global [Edit]
    📄 service-class.md ✅ Global [Edit]
  📁 frontend (4)
  📁 qa (2)
  📁 devops (2)
📁 market-validation (7)
```

### Config Editor

![Config Editor](./docs/screenshots/config.png)

**Dual Mode**:

**Visual Form Mode**:
- Accordion sections (General, Skills, Team System, Market Validation)
- Toggle switches for booleans
- Dropdowns for options (profile, stack, framework)
- Number inputs for thresholds (coverage %, auto-fix attempts)
- Help text for each field

**Raw YAML Mode**:
- Monaco Editor with YAML syntax highlighting
- Full config.yml editing
- Real-time YAML validation
- Syntax error highlighting

**Features**:
- Toggle between form ↔ YAML
- Auto-sync changes between modes
- Validation before save
- Unsaved changes warning

---

## File Locations

### Global Installation

Components installed globally (used by all projects):

```
~/.agent-os/
├── skills/
│   ├── base/
│   ├── java/
│   ├── react/
│   └── ...
└── templates/
    ├── team-development/
    └── market-validation/

~/.claude/
├── agents/
└── skills/ (symlinks)
```

### Project Installation

Project-specific overrides:

```
your-project/
├── agent-os/
│   ├── config.yml
│   └── templates/ (overrides)
└── .claude/
    ├── agents/ (overrides)
    └── skills/ (overrides)
```

### Lookup Order

When viewing a component, the app shows which file is actually used:

1. **Project override** (if exists) → 🔶 Project
2. **Global default** → ✅ Global

---

## Keyboard Shortcuts

- `Ctrl+S` (in Monaco Editor) - Save changes
- `Esc` (in modals) - Close modal
- Theme toggle in sidebar

---

## Development

### Running Tests

```bash
# Run all tests
npm test

# Watch mode (auto-run on changes)
npm run test:watch

# Coverage report
npm run test:coverage
```

**Test Results**:
- 15 unit tests (frontmatter parsing, validation)
- Coverage: 70%+ target
- Run time: <1 second

### Code Quality

```bash
# Lint code
npm run lint

# Format code
npm run format
```

---

## Troubleshooting

### App Won't Build

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

### IPC Not Working

- Check preload script loaded correctly
- Verify contextBridge API exposed
- Check console for errors

### Monaco Editor Not Loading

- Check internet connection (CDN fallback)
- Clear browser cache (Ctrl+Shift+R in dev mode)

### Config Won't Save

- Check YAML syntax in raw mode
- Ensure config.yml exists in project
- Verify project path detected correctly

---

## Requirements

**System**:
- macOS 10.13+ (High Sierra or later)
- Windows 10/11
- Linux (Ubuntu 18.04+, Fedora, etc.)

**Disk Space**:
- ~200 MB for app installation
- ~500 MB for development (with node_modules)

**RAM**:
- Minimum: 4 GB
- Recommended: 8 GB+

---

## Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Run tests: `npm test`
5. Build: `npm run build`
6. Submit pull request

---

## License

MIT License - See LICENSE file

---

## Version History

**v1.0.0** (2025-12-29)
- Initial release
- Dashboard with component stats
- Skills Manager (list, edit, override, revert)
- Agents Manager (with color/tools display)
- Templates Manager (hierarchical tree)
- Config Editor (visual form + raw YAML)
- Dark/Light mode
- Monaco Editor integration
- Testing framework (Jest)

---

**Status**: ✅ Production Ready (MVP Complete)

For detailed installation instructions, see [INSTALLATION.md](./INSTALLATION.md)
