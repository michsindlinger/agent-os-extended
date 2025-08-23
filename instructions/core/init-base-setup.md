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
1. **Validation**: Verify template exists and current directory is suitable
2. **Backup Check**: Ensure no existing project files will be overwritten
3. **Installation**: Execute template's `install.sh` script
4. **Configuration**: Set up environment files and dependencies
5. **Verification**: Run AI validation to confirm successful setup

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
✅ Dependencies installed
✅ Environment configured
✅ Database schema applied
🔍 Running AI validation...

✅ Base setup completed successfully!

Next steps:
- Review .env.local configuration
- Run: npm run dev
- Visit: http://localhost:3000
```

## Success Criteria
- Template discovery works without manual maintenance
- Installation process is reliable and user-friendly
- AI validation catches common setup issues
- Integration with existing Agent OS workflow is seamless
- Error messages are helpful and actionable