# Init Base Setup Command

## Purpose
Initialize a new project with pre-configured base setups from the agent-os-extended-base-setups repository. Provides intelligent template discovery and installation with AI-guided setup validation.

## Command Syntax
```bash
/init-base-setup [template-name]
```

## Behavior

### Without Template Name
Lists all available templates from the GitHub repository:
- Template names with status indicators
- Technology stack descriptions
- Setup complexity and requirements
- Usage recommendations

### With Template Name
Installs the specified template:
- Validates template availability
- Executes template-specific installation
- Runs AI-powered validation
- Provides post-installation guidance

## Implementation

### Template Discovery Process
1. **Repository Access**: Clone or fetch from `git@github.com:michsindlinger/agent-os-extended-base-setups.git`
2. **Template Scanning**: Discover available templates from directory structure
3. **Metadata Extraction**: Parse README files and package.json for template information
4. **Status Classification**: Categorize templates by readiness level

### Template Installation Process
1. **Pre-Installation Validation**: Verify template exists and current directory is suitable
2. **Directory Analysis**: Check for empty directory vs. existing files conflict resolution
3. **Template Installation**: Execute template's `install.sh` script
4. **Post-Installation Fixes**: Apply automatic fixes for common issues:
   - Fix Tailwind config: `darkMode: ["class"]` → `darkMode: "class"`
   - Clean unused imports (Users, Globe, etc.) to prevent build errors
   - Replace `any` types with proper TypeScript types
   - Remove unused variables (like `err` in catch blocks)
5. **Environment Configuration**: Create `.env.local` with functional placeholder URLs
6. **Code Quality**: Run automatic lint fix and build validation
7. **Final Verification**: Ensure successful build before completion

### Error Handling
- **Template Not Found**: Display available templates with suggestions
- **Directory Conflicts**: Warn about existing files and offer resolution
- **Installation Failures**: Provide detailed error context and recovery steps
- **Network Issues**: Handle repository access failures gracefully

## Integration Points

### MCP Server Integration
- Leverage existing file system tools for template installation
- Use git workflow agents for repository operations
- Integrate with validation specialists for quality assurance

### Agent OS Workflow
- Compatible with existing `create-spec` and `document-feature` commands
- Supports extension through `extend-setup` command
- Maintains Agent OS directory structure and conventions

## Template Structure Requirements

Each template must include:
- `README.md` - Template description and tech stack details
- `install.sh` - Automated installation script
- `package.json` - Dependencies and project metadata
- `.env.local.sample` - Environment configuration template

## Output Format

### Template Listing
```
📦 Available Base Setup Templates:

✅ nextjs-shadcn-tailwind-supabase (Production Ready)
   Tech Stack: Next.js 14, shadcn/ui, Tailwind CSS, Supabase
   Description: Full-stack web application with modern UI components
   
🚧 react-native-expo (Coming Soon)
   Tech Stack: React Native, Expo, TypeScript
   Description: Mobile app development setup
   
🔄 python-fastapi-postgres (In Development)
   Tech Stack: FastAPI, PostgreSQL, SQLAlchemy
   Description: Backend API with database integration

Usage: /init-base-setup [template-name]
```

### Installation Progress
```
🚀 Installing template: nextjs-shadcn-tailwind-supabase

✅ Repository cloned successfully
✅ Template files installed
✅ Dependencies installed
🔧 Applying post-installation fixes...
  ├── Fixed Tailwind config (darkMode: "class")
  ├── Cleaned unused imports (Users, Globe)
  ├── Improved TypeScript types
  └── Removed unused variables
✅ Environment configured with functional placeholders
✅ Lint fixes applied
✅ Build validation successful
🔍 Running comprehensive AI validation...

✅ Base setup completed successfully!

Next steps:
- Configure your actual Supabase URLs in .env.local
- Run: npm run dev
- Visit: http://localhost:3000

Build Status: ✅ All checks passed
```

## Success Criteria
- Template discovery works without manual maintenance
- Installation process guarantees a working build on completion
- All common setup issues are automatically fixed during installation
- Environment files contain functional placeholder URLs
- Code quality issues (unused imports, any types) are resolved automatically
- Integration with existing Agent OS workflow is seamless
- Error messages are helpful and actionable

## Common Issues & Auto-Fixes

### Tailwind Configuration
**Problem**: `darkMode: ["class"]` causes TypeScript compatibility issues
**Fix**: Automatically convert to `darkMode: "class"`

### TypeScript Issues
**Problem**: Unused imports (Users, Globe) cause build failures with strict settings
**Fix**: Automatically remove unused imports during post-installation

### Build Errors
**Problem**: `any` types not allowed in strict TypeScript mode
**Fix**: Replace with proper type definitions

### Environment Setup
**Problem**: Placeholder Supabase URLs cause static generation failures
**Fix**: Use functional development URLs that don't break builds

### Code Quality
**Problem**: Unused variables (like `err`) cause linting failures
**Fix**: Automatic lint fix with proper variable handling