# Agent OS Manager - Installation Guide

## Development Setup

### Prerequisites

- Node.js 22+ (LTS)
- npm or yarn
- Git

### Installation Steps

1. **Clone repository** (if not already cloned):
   ```bash
   git clone https://github.com/michsindlinger/agent-os-extended.git
   cd agent-os-extended/agent-os-manager
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Run in development mode**:
   ```bash
   npm run dev
   ```

   The app will launch in Electron with hot reload enabled.

---

## Building for Production

### Build All Platforms

```bash
npm run build
npm run package
```

This creates installers in `dist-electron/`:
- macOS: `Agent OS Manager-1.0.0-universal.dmg`
- Windows: `Agent OS Manager-Setup-1.0.0.exe`
- Linux: `Agent OS Manager-1.0.0-x86_64.AppImage`

### Build Platform-Specific

**macOS**:
```bash
npm run package:mac
```

**Windows** (from macOS/Linux, requires Wine):
```bash
npm run package:win
```

**Linux**:
```bash
npm run package:linux
```

---

## Installing from DMG (macOS)

1. Download `Agent OS Manager-1.0.0-universal.dmg`
2. Open the DMG file
3. Drag "Agent OS Manager" to Applications folder
4. Launch from Applications

**Note**: If you see "App can't be opened" warning:
```bash
xattr -cr "/Applications/Agent OS Manager.app"
```

---

## Installing from EXE (Windows)

1. Download `Agent OS Manager-Setup-1.0.0.exe`
2. Run the installer
3. Follow installation wizard
4. Launch from Start Menu or Desktop shortcut

---

## Installing from AppImage (Linux)

1. Download `Agent OS Manager-1.0.0-x86_64.AppImage`
2. Make executable:
   ```bash
   chmod +x Agent-OS-Manager-1.0.0-x86_64.AppImage
   ```
3. Run:
   ```bash
   ./Agent-OS-Manager-1.0.0-x86_64.AppImage
   ```

---

## First Launch

### No Project Detected

If you see "No project detected" in the Dashboard:

1. **Option A**: Open the app from a project directory:
   ```bash
   cd your-project-with-agent-os
   open "/Applications/Agent OS Manager.app"
   ```

2. **Option B**: The app will still show global components
   - You can view and edit global skills/agents
   - Project-specific features disabled until project detected

### With Project

If launched from a directory with `agent-os/` or `.agent-os/`:
- Dashboard shows project location
- Can create project-specific overrides
- Full functionality enabled

---

## Usage

### Dashboard

- View component counts (Skills, Agents, Templates)
- See global vs project breakdown
- View global and project locations

### Skills Manager

1. Click "Skills" in sidebar
2. See all skills (global + project)
3. Search for specific skill
4. Click "Edit" to modify with Monaco Editor
5. Click "Override" (global skills) to copy to project
6. Click "Revert" (project skills) to delete override

### Agents Manager

1. Click "Agents" in sidebar
2. See all agents with color indicators
3. Tools displayed for each agent
4. Edit, override, revert same as skills

### Templates Manager

1. Click "Templates" in sidebar
2. Expand hierarchical tree (system > category > template)
3. Click "Edit" to modify template
4. Saves to project location

### Config Editor

1. Click "Config" in sidebar
2. **Visual Form Mode**:
   - Toggle Team System enabled
   - Adjust specialist settings (backend stack, frontend framework)
   - Change quality gates (coverage thresholds)
3. **Raw YAML Mode**:
   - Click "Raw YAML" button
   - Edit config.yml directly with Monaco Editor
   - YAML validation in real-time
4. Click "Save Changes" to write config.yml

---

## Troubleshooting

### App Won't Launch

**macOS**: Remove quarantine attribute:
```bash
xattr -cr "/Applications/Agent OS Manager.app"
```

**Windows**: Run as Administrator if installation fails

### No Components Showing

- Ensure global installation exists: `ls ~/.agent-os/` or check `agent-os/` directory
- Click "Refresh" button in each tab
- Check console for errors

### Error: "No project found"

- App must be launched from a directory containing `agent-os/` or `.agent-os/`
- Global components still viewable
- Project-specific features require project context

### YAML Parse Error in Config

- Switch to "Visual Form" mode
- Or fix YAML syntax in "Raw YAML" mode
- Look for indentation errors, missing colons

---

## Uninstallation

**macOS**:
```bash
rm -rf "/Applications/Agent OS Manager.app"
rm -rf ~/Library/Application\ Support/agent-os-manager
```

**Windows**:
- Use "Add/Remove Programs"
- Or run uninstaller from installation directory

**Linux**:
```bash
rm Agent-OS-Manager-*.AppImage
rm -rf ~/.config/agent-os-manager
```

---

## Support

For issues or feature requests:
- GitHub Issues: https://github.com/michsindlinger/agent-os-extended/issues
- Documentation: See README.md in repo

---

**Version**: 1.0.0
**Last Updated**: 2025-12-29
