# Agent OS Manager

Desktop GUI application for managing Agent OS Extended components (skills, agents, templates, configuration).

## Features

- 📊 Visual dashboard with component counts
- ✏️ Monaco Editor for editing skills, agents, templates
- 🎨 Design system extraction and management
- ⚙️ Visual config editor (form-based + raw YAML)
- 🔄 Global vs Project override management
- 🌓 Dark/Light mode support

## Tech Stack

- **Desktop**: Electron
- **Frontend**: React 18 + TypeScript + TailwindCSS 4.0
- **Editor**: Monaco Editor
- **Build**: Vite + electron-builder

## Development

```bash
# Install dependencies
npm install

# Run in development mode
npm run dev

# Build for production
npm run build

# Package for distribution
npm run package        # All platforms
npm run package:mac    # macOS DMG
npm run package:win    # Windows installer
npm run package:linux  # Linux AppImage
```

## Project Structure

```
src/
├── main/          # Electron main process (Node.js)
├── preload/       # Preload script (IPC bridge)
└── renderer/      # React app (UI)
```

## Status

🚧 In Development - Phase 1: Infrastructure Setup Complete
