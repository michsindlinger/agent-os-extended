# Extend Setup Command

## Purpose
Modular extension system for base setups that allows intelligent addition of features, integrations, and capabilities to existing projects. Provides AI-guided extension selection and conflict resolution.

## Command Syntax
```bash
/extend-setup [module-name] [--template template-name] [--preview] [--force]
```

## Options
- `module-name`: Specific extension module to install
- `--template`: Specify base template for compatibility checking
- `--preview`: Show what changes will be made without executing
- `--force`: Override compatibility warnings and conflicts

## Behavior

### Without Module Name
Lists all available extension modules:
- Module categories and descriptions
- Compatibility with current project
- Installation complexity indicators
- Dependency requirements

### With Module Name
Installs the specified extension:
- Validates compatibility with current setup
- Resolves configuration conflicts
- Executes module-specific installation
- Updates project documentation

## Extension Categories

### 1. Authentication & Security
- **Auth0 Integration**: Complete authentication flow with Auth0
- **Clerk Integration**: Modern authentication with Clerk
- **NextAuth.js Setup**: Flexible authentication for Next.js
- **OAuth Providers**: Google, GitHub, Discord, etc.
- **Role-Based Access**: RBAC implementation
- **API Key Management**: Secure API key handling

### 2. Database & Storage
- **Prisma ORM**: Advanced database operations with Prisma
- **Drizzle ORM**: Lightweight TypeScript ORM
- **Redis Caching**: In-memory caching layer
- **S3 File Upload**: AWS S3 integration for file storage
- **Cloudinary Media**: Image and video management
- **Database Migrations**: Advanced migration strategies

### 3. UI & Styling Enhancements
- **Dark Mode Toggle**: Complete theming system
- **Animation Library**: Framer Motion integration
- **Chart Components**: Data visualization with Chart.js/Recharts
- **Table Components**: Advanced data tables
- **Form Builder**: Dynamic form generation
- **Component Variants**: Extended component library

### 4. Development Tools
- **Storybook Setup**: Component development environment
- **Testing Suite**: Jest, React Testing Library, Playwright
- **Bundle Analyzer**: Performance monitoring tools
- **Code Quality**: Additional linting and formatting rules
- **Git Hooks**: Pre-commit and pre-push automation
- **CI/CD Pipeline**: GitHub Actions or similar

### 5. Integrations & APIs
- **Stripe Payments**: Complete payment processing
- **Email Service**: Resend, SendGrid, or similar
- **Analytics**: Google Analytics, PostHog integration  
- **Monitoring**: Sentry error tracking
- **Search Engine**: Algolia or ElasticSearch
- **Notification System**: Push notifications and alerts

### 6. Performance & SEO
- **PWA Features**: Service worker and offline support
- **SEO Optimization**: Meta tags and structured data
- **Image Optimization**: Advanced image processing
- **Caching Strategy**: Multi-layer caching implementation
- **CDN Integration**: Content delivery optimization
- **Performance Monitoring**: Web vitals tracking

## Implementation Strategy

### Extension Discovery Process
1. **Module Repository**: Fetch available extensions from dedicated repository
2. **Compatibility Matrix**: Check extension compatibility with base templates
3. **Dependency Analysis**: Analyze module dependencies and conflicts
4. **Installation Planning**: Create execution plan with conflict resolution

### Extension Installation Process
1. **Compatibility Check**: Verify extension works with current project
2. **Conflict Detection**: Identify potential configuration conflicts
3. **Backup Creation**: Create restoration point before changes
4. **Module Installation**: Execute extension-specific installation
5. **Configuration Merge**: Integrate extension config with existing setup
6. **Validation**: Run tests to ensure functionality

### Conflict Resolution System
1. **File Conflicts**: Smart merging of configuration files
2. **Dependency Conflicts**: Version resolution and compatibility fixes
3. **Configuration Conflicts**: Interactive conflict resolution wizard
4. **Port Conflicts**: Automatic port assignment for services
5. **Route Conflicts**: API and page route collision detection

## Output Format

### Extension Listing
```
🧩 Available Extensions for nextjs-shadcn-tailwind-supabase:

🔐 AUTHENTICATION & SECURITY:
├── ✅ auth0-integration - Complete Auth0 setup (Compatible)
├── ✅ clerk-integration - Modern auth with Clerk (Compatible)  
├── ⚠️  nextauth-setup - NextAuth.js integration (Minor conflicts)
└── ✅ rbac-system - Role-based access control (Compatible)

💾 DATABASE & STORAGE:
├── ✅ prisma-orm - Enhanced ORM capabilities (Compatible)
├── ✅ redis-caching - In-memory caching (Compatible)
├── ⚠️  drizzle-orm - Alternative ORM (Conflicts with existing)
└── ✅ s3-upload - File upload to AWS S3 (Compatible)

🎨 UI & STYLING:
├── ✅ dark-mode - Theme switching system (Compatible)
├── ✅ framer-motion - Animation library (Compatible)
├── ✅ chart-components - Data visualization (Compatible)
└── ✅ advanced-tables - Enhanced table components (Compatible)

Usage: /extend-setup [module-name] [options]
Legend: ✅ Compatible | ⚠️ Minor conflicts | ❌ Incompatible
```

### Installation Progress
```
🚀 Installing extension: dark-mode

🔍 Analyzing current setup...
✅ Base template detected: nextjs-shadcn-tailwind-supabase
✅ Compatibility verified
✅ No conflicts detected

📦 Installing components...
├── ✅ ThemeProvider component created
├── ✅ Dark mode toggle component added
├── ✅ Tailwind config updated for themes
├── ✅ CSS variables configured
└── ✅ Theme persistence setup

🔧 Updating configuration...
├── ✅ Layout.tsx modified for theme provider
├── ✅ globals.css updated with theme variables
└── ✅ Package.json dependencies added

✅ Extension installed successfully!

📚 Documentation updated:
- Dark mode usage guide: /docs/dark-mode.md
- Component examples: /components/ui/theme-toggle.tsx

🧪 Running validation...
✅ All tests passing
✅ Build successful
✅ Type checking passed

Next steps:
- Import ThemeToggle component where needed
- Customize theme colors in tailwind.config.js
- Test theme switching functionality
```

### Conflict Resolution
```
⚠️  Configuration Conflicts Detected

📄 tailwind.config.js:
Current: Using custom color palette
Extension: Requires theme-aware color system

🔧 Resolution Options:
1. [Recommended] Merge configurations (keeps current + adds theme support)
2. Replace with extension config (may break custom styles)  
3. Manual merge (requires your input)

Choice [1-3]: _
```

## Module Structure Requirements

Each extension module must include:
- `module.json` - Extension metadata and compatibility info
- `install.sh` - Installation script with conflict handling
- `README.md` - Setup instructions and usage examples
- `config/` - Configuration file templates
- `components/` - UI components (if applicable)
- `docs/` - Documentation and examples

## Advanced Features

### Smart Conflict Resolution
- **Configuration Merging**: Intelligent merging of config files
- **Dependency Resolution**: Automatic dependency conflict fixing
- **Migration Scripts**: Database and configuration migrations
- **Rollback Support**: Safe extension removal and rollback

### Extension Ecosystem
- **Module Dependencies**: Extensions that depend on other extensions
- **Module Variants**: Different implementations of same functionality
- **Custom Extensions**: Support for user-created extension modules
- **Extension Updates**: Safe updating of installed extensions

### Integration Points
- **MCP Server Support**: Leverage existing development tools
- **Agent OS Workflow**: Compatible with existing commands
- **Template Integration**: Extension availability based on base template
- **Documentation Generation**: Auto-update project documentation

## Success Criteria
- Seamless extension installation without breaking existing functionality
- Intelligent conflict resolution that preserves user customizations
- Clear visibility into extension compatibility and requirements
- Comprehensive documentation and examples for each extension
- Safe rollback capabilities for problematic extensions