# Technical Specification - Agent OS Manager GUI

## Architecture Overview

**Pattern**: Electron Multi-Process Architecture

```
┌─────────────────────────────────────────────┐
│         Electron Main Process               │
│  (Node.js - File System Operations)         │
│                                             │
│  - Read/Write Skills, Agents, Templates    │
│  - Parse frontmatter (gray-matter)         │
│  - Parse/Write YAML (js-yaml)              │
│  - Glob file finding                       │
│  - Path resolution (global vs project)     │
└──────────────────┬──────────────────────────┘
                   │ IPC
                   │ (contextBridge)
┌──────────────────┴──────────────────────────┐
│      Electron Renderer Process              │
│  (React + TailwindCSS + Monaco)             │
│                                             │
│  - Dashboard (component counts)            │
│  - Skills List & Editor                    │
│  - Agents List & Editor                    │
│  - Templates Tree & Editor                 │
│  - Config Editor (form + raw YAML)         │
└─────────────────────────────────────────────┘
```

## Tech Stack

### Frontend (Renderer Process)

**Framework**: React 18 with TypeScript
**Styling**: TailwindCSS 4.0
**Editor**: Monaco Editor (@monaco-editor/react)
**Icons**: Lucide React
**Routing**: React Router 6 (for tabs/navigation within app)
**State**: Context API (lightweight, no Redux needed)
**Build**: Vite

**Dependencies**:
```json
{
  "react": "^18.2.0",
  "react-dom": "^18.2.0",
  "react-router-dom": "^6.20.0",
  "@monaco-editor/react": "^4.6.0",
  "lucide-react": "^0.300.0",
  "tailwindcss": "^4.0.0"
}
```

### Backend (Main Process)

**Runtime**: Node.js (bundled with Electron)
**File Operations**: fs/promises
**Path Resolution**: path module
**File Finding**: glob ^10.0.0
**Frontmatter Parsing**: gray-matter ^4.0.3
**YAML Parsing**: js-yaml ^4.1.0

**Dependencies**:
```json
{
  "electron": "^28.0.0",
  "glob": "^10.3.0",
  "gray-matter": "^4.0.3",
  "js-yaml": "^4.1.0"
}
```

### Build & Package

**Build Tool**: electron-builder
**Dev Tool**: electron-vite or Vite + electron
**TypeScript**: For type safety

## Component Architecture

### Main Process (Electron)

**File**: `electron/main.js`

**Responsibilities**:
- Create BrowserWindow
- Setup IPC handlers
- File system operations (read/write/delete)
- Path resolution (global vs project)

**IPC Handlers**:
```javascript
// Skills
ipcMain.handle('skills:list', async () => { ... })
ipcMain.handle('skills:read', async (event, name) => { ... })
ipcMain.handle('skills:write', async (event, name, content) => { ... })
ipcMain.handle('skills:delete', async (event, name) => { ... })
ipcMain.handle('skills:getGlobal', async (event, name) => { ... })

// Agents (same pattern)
// Templates (same pattern)
// Config
ipcMain.handle('config:read', async () => { ... })
ipcMain.handle('config:write', async (event, content) => { ... })

// System
ipcMain.handle('system:getPaths', async () => { ... })
ipcMain.handle('system:refresh', async () => { ... })
```

### Preload Script

**File**: `electron/preload.js`

**Purpose**: Expose safe IPC to renderer

```javascript
const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electronAPI', {
  skills: {
    list: () => ipcRenderer.invoke('skills:list'),
    read: (name) => ipcRenderer.invoke('skills:read', name),
    write: (name, content) => ipcRenderer.invoke('skills:write', name, content),
    // ...
  },
  // agents, templates, config...
});
```

### Renderer (React App)

**Structure**:
```
src/
├── App.tsx                    # Main app with routing
├── components/
│   ├── Dashboard/
│   │   ├── Dashboard.tsx
│   │   └── ComponentCard.tsx
│   ├── Skills/
│   │   ├── SkillsList.tsx
│   │   └── SkillEditor.tsx
│   ├── Agents/
│   │   ├── AgentsList.tsx
│   │   └── AgentEditor.tsx
│   ├── Templates/
│   │   ├── TemplatesTree.tsx
│   │   └── TemplateEditor.tsx
│   ├── Config/
│   │   ├── ConfigForm.tsx
│   │   └── ConfigRawEditor.tsx
│   ├── common/
│   │   ├── MonacoEditor.tsx
│   │   ├── SourceBadge.tsx    # ✅ Global / 🔶 Project
│   │   └── Layout.tsx
├── types/
│   ├── Skill.ts
│   ├── Agent.ts
│   ├── Template.ts
│   └── Config.ts
└── contexts/
    └── AppContext.tsx          # Global state
```

## Data Models

### Skill

```typescript
interface Skill {
  name: string;
  description: string;
  globs: string[];
  source: 'global' | 'project';
  path: string;                // Actual file path
  globalPath?: string;         // Global version path (if override)
  content: string;             // File content
}
```

### Agent

```typescript
interface Agent {
  name: string;
  description: string;
  tools?: string[];
  color?: string;
  mcp_integrations?: string[];
  source: 'global' | 'project';
  path: string;
  globalPath?: string;
  content: string;
}
```

### Template

```typescript
interface Template {
  name: string;
  path: string;
  category: string;           // 'backend', 'frontend', 'qa', 'devops'
  system: string;             // 'team-development', 'market-validation'
  source: 'global' | 'project';
  content: string;
}
```

### Config

```typescript
interface Config {
  active_profile: string;
  profiles: {
    inheritance: boolean;
    auto_load_skills: boolean;
  };
  skills: {
    enabled: boolean;
    path: string;
    symlink_to_claude: boolean;
  };
  team_system?: {
    enabled: boolean;
    specialists: {
      backend_dev: SpecialistConfig;
      frontend_dev: SpecialistConfig;
      qa_specialist: QAConfig;
      devops_specialist: DevOpsConfig;
    };
    quality_gates: QualityGates;
  };
  // ... other sections
}
```

## File Operations Logic

### Path Resolution

```typescript
// Resolve skill location
function resolveSkill(name: string): SkillLocation {
  // 1. Check project location
  const projectPath = path.join(cwd, '.claude/skills', `${name}.md`);
  if (fs.existsSync(projectPath)) {
    return { source: 'project', path: projectPath };
  }

  // 2. Check global location (search multiple subdirectories)
  const globalBase = process.env.HOME + '/.agent-os/skills';
  const found = glob.sync(`${globalBase}/**/${name}.md`);
  if (found.length > 0) {
    return { source: 'global', path: found[0] };
  }

  // 3. Check agent-os-extended repo (if running from there)
  const repoPath = path.join(__dirname, '../../agent-os/skills/**', `${name}.md`);
  const repoFound = glob.sync(repoPath);
  if (repoFound.length > 0) {
    return { source: 'global', path: repoFound[0] };
  }

  throw new Error(`Skill not found: ${name}`);
}
```

### Override Creation

```typescript
async function overrideToProject(name: string, type: 'skill' | 'agent'): Promise<void> {
  // 1. Resolve global location
  const global = resolveComponent(name, type);
  if (global.source === 'project') {
    throw new Error('Already a project override');
  }

  // 2. Read global content
  const content = await fs.readFile(global.path, 'utf-8');

  // 3. Determine project path
  const projectDir = type === 'skill' ? '.claude/skills' : '.claude/agents';
  const projectPath = path.join(cwd, projectDir, `${name}.md`);

  // 4. Ensure directory exists
  await fs.mkdir(path.dirname(projectPath), { recursive: true });

  // 5. Write to project
  await fs.writeFile(projectPath, content, 'utf-8');

  return projectPath;
}
```

### Frontmatter Validation

```typescript
import matter from 'gray-matter';

function validateSkillFrontmatter(content: string): ValidationResult {
  try {
    const { data } = matter(content);

    const errors: string[] = [];

    if (!data.name) errors.push('Missing required field: name');
    if (!data.description) errors.push('Missing required field: description');
    if (!data.globs || !Array.isArray(data.globs)) {
      errors.push('Missing or invalid field: globs (must be array)');
    }

    return { valid: errors.length === 0, errors };
  } catch (err) {
    return { valid: false, errors: ['Invalid frontmatter YAML'] };
  }
}
```

## UI/UX Specifications

### Color Scheme

**Light Mode**:
- Background: #ffffff
- Surface: #f8f9fa
- Border: #e0e0e0
- Text Primary: #202124
- Text Secondary: #5f6368
- Primary: #1a73e8
- Success (Global): #34a853
- Warning (Project): #fbbc04

**Dark Mode**:
- Background: #1e1e1e
- Surface: #252526
- Border: #3e3e42
- Text Primary: #cccccc
- Text Secondary: #969696
- Primary: #4a9eff
- Success (Global): #4caf50
- Warning (Project): #ff9800

### Typography

- Font Family: System fonts (system-ui, -apple-system)
- Headings: 600 weight
- Body: 400 weight
- Code/Editor: Monaco's default (Menlo, Consolas)

### Component Design

**Source Badges**:
```tsx
// Global badge
<Badge color="green">✅ Global</Badge>

// Project override badge
<Badge color="orange">🔶 Project</Badge>
```

**Action Buttons**:
- Edit: Blue button
- Override: Orange button (only for global components)
- Revert: Red button (only for project overrides)
- Save: Green button
- Cancel: Gray button

## Performance Targets

- App startup: <2 seconds
- Component list load: <500ms
- File open in editor: <300ms
- File save: <200ms
- Manual refresh: <500ms

## Error Handling

**File System Errors**:
- File not found → Show error toast
- Permission denied → Show error with path
- Invalid YAML → Show validation errors inline
- Parse error → Highlight line with error

**User Errors**:
- Invalid frontmatter → Red error box with specific issues
- Missing required fields → Form validation
- YAML syntax error → Monaco editor error markers

## Build & Distribution

**Development**:
```bash
npm run dev
# → Vite dev server for React
# → Electron in dev mode
# → Hot reload enabled
```

**Production Build**:
```bash
npm run build
# → Vite build (React bundle)
# → Electron build
# → Code signing (macOS)
# → Create installers (DMG, EXE, AppImage)
```

**Package**:
- macOS: DMG installer (arm64 + x64 universal)
- Windows: EXE installer + portable
- Linux: AppImage

## Security Considerations

- No remote code execution (all local files)
- IPC validation (validate all inputs from renderer)
- Path sanitization (prevent directory traversal)
- YAML safe load (js-yaml safeLoad)

## Testing Strategy

**Unit Tests**:
- Path resolution logic
- Frontmatter parsing
- YAML validation
- Override creation logic

**Integration Tests**:
- IPC communication
- File read/write operations
- Config save/load

**E2E Tests** (optional for MVP):
- Launch app, verify dashboard
- Edit skill, save, verify file written
- Create override, verify file copied
