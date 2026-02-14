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
- **Build Validation**: Ensure project builds successfully without errors
- **Type Safety**: Check TypeScript strict mode compatibility and proper type definitions
- **Import Analysis**: Detect unused imports (Users, Globe, etc.) that cause build failures
- **Variable Usage**: Identify unused variables (like `err` in catch blocks)
- **Anti-Pattern Detection**: Find `any` types that should be properly typed
- **Linting Compliance**: Verify ESLint, Prettier, and other code quality tools

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

✅ PASSING CHECKS (10):
├── Package dependencies resolved
├── Project builds successfully
├── TypeScript strict mode compatible
├── Environment variables loaded
├── ESLint rules configured
├── Tailwind config properly formatted
├── shadcn/ui components installed
├── Supabase client initialized
├── No unused imports detected
└── All variables properly used

⚠️  WARNINGS (1):
└── Development server port conflicts possible

❌ CRITICAL ISSUES RESOLVED:
├── ✅ Fixed Tailwind darkMode configuration
├── ✅ Removed unused imports (Users, Globe)
├── ✅ Replaced any types with proper definitions
├── ✅ Environment configured with functional URLs
└── ✅ Unused variables cleaned up

🔧 Recommended Actions:
1. Configure your actual Supabase URLs in .env.local
2. Run: npm run dev to test development server
3. Customize components and styling as needed

Overall Status: ✅ Ready for Development (0 critical issues)
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
- **Tailwind Config**: Fix `darkMode: ["class"]` → `darkMode: "class"`
- **Unused Imports**: Remove unused imports (Users, Globe, etc.)
- **TypeScript Issues**: Replace `any` types with proper type definitions
- **Variable Cleanup**: Remove or properly handle unused variables
- **Lint Issues**: Run automatic lint fixes for code quality
- **Environment Setup**: Create `.env.local` with functional placeholder URLs
- **Build Validation**: Ensure project builds successfully after fixes

### Common Issue Detection & Resolution
- **Build Failures**: Detect and fix TypeScript/ESLint strict mode issues
- **Import Errors**: Identify and clean unused dependencies causing build failures
- **Configuration Problems**: Automatically fix common config file issues
- **Environment Variables**: Validate placeholder URLs don't break static generation

### Manual Fix Guidance  
- **Production Environment**: Configure actual Supabase URLs for production
- **Database Schema**: Apply database migrations and schema updates
- **API Configuration**: Custom API endpoint and authentication setup
- **Deployment Settings**: Platform-specific configuration for Vercel/Netlify

## Integration Points

### MCP Server Integration
- File system analysis for project structure validation
- Network connectivity testing for external services
- Git integration for version control validation
- Package manager operations for dependency checks

### Specwright Workflow
- Complements `init-base-setup` command for installation validation
- Integrates with `extend-setup` for extension compatibility
- Supports `create-spec` workflow for project documentation

## Template-Specific Rules

### Next.js + shadcn + Tailwind + Supabase
- **Build System**: Verify Next.js builds without errors
- **Tailwind Config**: Check `darkMode: "class"` (not array format)
- **Component Library**: Validate shadcn/ui components work correctly  
- **TypeScript**: Ensure strict mode compatibility and proper typing
- **Import Hygiene**: No unused imports that cause build failures
- **Environment**: Functional Supabase URLs for development builds
- **Code Quality**: ESLint compliance with no unused variables

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