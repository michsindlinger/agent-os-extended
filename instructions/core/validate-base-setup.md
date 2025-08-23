# Validate Base Setup Command

## Purpose
AI-powered validation of base setup installations to ensure project integrity, proper configuration, and readiness for development. Provides intelligent analysis and actionable recommendations for setup optimization.

## Command Syntax
```bash
/validate-base-setup [--template template-name] [--deep] [--fix]
```

## Options
- `--template`: Specify template type for targeted validation rules
- `--deep`: Perform comprehensive validation including security and performance checks
- `--fix`: Automatically resolve detected issues where safe to do so

## Validation Categories

### 1. Project Structure Validation
- **Directory Structure**: Verify expected folders and file organization
- **Configuration Files**: Check presence and validity of essential config files
- **Package Dependencies**: Validate package.json and lock files consistency
- **Environment Setup**: Confirm .env files and environment variable configuration

### 2. Code Quality Validation  
- **Syntax Checking**: Verify code compilation and syntax correctness
- **Type Safety**: Ensure TypeScript configuration and type definitions
- **Linting Rules**: Check ESLint, Prettier, and other code quality tools
- **Import Resolution**: Validate module imports and path mappings

### 3. Infrastructure Validation
- **Database Connection**: Test database connectivity and schema validity
- **API Endpoints**: Verify API routes and authentication setup
- **Asset Pipeline**: Check build system and static asset configuration
- **Development Server**: Confirm local development environment starts correctly

### 4. Security Validation
- **Environment Secrets**: Ensure sensitive data is properly configured
- **Dependency Vulnerabilities**: Scan for known security issues
- **CORS Configuration**: Validate cross-origin resource sharing setup
- **Authentication Flow**: Test auth integration and user flows

### 5. Performance Validation
- **Bundle Analysis**: Check bundle size and optimization opportunities
- **Loading Performance**: Analyze initial page load metrics
- **Database Queries**: Review query efficiency and N+1 problems
- **Caching Strategy**: Validate caching configuration and effectiveness

## Implementation Strategy

### AI-Powered Analysis
1. **Context Understanding**: Analyze project structure to infer template type
2. **Rule Application**: Apply template-specific validation rules
3. **Issue Detection**: Identify configuration problems and missing components
4. **Solution Generation**: Provide specific fixes with implementation guidance
5. **Priority Assessment**: Rank issues by severity and impact

### Validation Process
1. **Environment Scanning**: Collect project metadata and configuration
2. **Template Detection**: Identify base setup template automatically
3. **Rule Execution**: Run validation rules against project structure
4. **Issue Aggregation**: Collect and categorize all detected problems
5. **Report Generation**: Create comprehensive validation report with fixes

## Output Format

### Standard Validation Report
```
🔍 Base Setup Validation Report

📊 Project Overview:
Template: nextjs-shadcn-tailwind-supabase
Node Version: 18.17.0
Package Manager: npm

✅ PASSING CHECKS (8):
├── Package dependencies resolved
├── TypeScript configuration valid
├── Database connection established
├── Environment variables loaded
├── ESLint rules configured
├── Tailwind CSS compiled
├── shadcn/ui components installed
└── Supabase client initialized

⚠️  WARNINGS (2):
├── Missing .env.local.sample template
└── Development server port conflicts possible

❌ CRITICAL ISSUES (1):
└── Supabase database URL not configured

🔧 Recommended Actions:
1. Copy .env.local.sample to .env.local
2. Configure SUPABASE_URL and SUPABASE_ANON_KEY
3. Run database migrations: npm run db:migrate

Overall Status: ⚠️  Needs Attention (3 issues)
```

### Deep Validation Report
```
🔬 Deep Validation Analysis

🛡️  SECURITY SCAN:
✅ No vulnerable dependencies detected
✅ API routes properly authenticated
⚠️  CORS configuration allows all origins (development only)

⚡ PERFORMANCE ANALYSIS:
✅ Bundle size within recommended limits (245KB)
✅ Image optimization enabled
❌ Missing service worker for offline support

🏗️  ARCHITECTURE REVIEW:
✅ Component structure follows best practices
✅ State management properly configured
⚠️  Database indexes missing for main queries

📈 RECOMMENDATIONS:
- Implement service worker for PWA features
- Add database indexes for user queries
- Configure production CORS settings
- Consider implementing Redis caching
```

## Auto-Fix Capabilities

### Safe Automatic Fixes
- **Missing Files**: Create standard configuration files
- **Package Updates**: Update outdated dependencies
- **Format Issues**: Apply consistent code formatting
- **Environment Templates**: Generate .env.local from sample

### Manual Fix Guidance  
- **Database Configuration**: Step-by-step database setup
- **API Key Setup**: Instructions for service integrations
- **Build Configuration**: Custom webpack or Vite settings
- **Deployment Settings**: Platform-specific configuration

## Integration Points

### MCP Server Integration
- File system analysis for project structure validation
- Network connectivity testing for external services
- Git integration for version control validation
- Package manager operations for dependency checks

### Agent OS Workflow
- Complements `init-base-setup` command for installation validation
- Integrates with `extend-setup` for extension compatibility
- Supports `create-spec` workflow for project documentation

## Template-Specific Rules

### Next.js + shadcn + Tailwind + Supabase
- Next.js configuration and routing setup
- shadcn/ui component library installation
- Tailwind CSS configuration and build process
- Supabase client setup and database connection

### Future Templates
- React Native + Expo validation rules
- FastAPI + PostgreSQL validation rules  
- Custom validation rule extensibility

## Success Criteria
- Accurate detection of setup issues across all supported templates
- Clear, actionable recommendations for problem resolution
- Safe automatic fixes that don't break existing functionality
- Performance analysis that identifies optimization opportunities
- Security validation that catches common vulnerabilities