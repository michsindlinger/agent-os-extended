# /validate-base-setup Command

AI-powered validation of your base setup installation to ensure everything is configured correctly.

## Usage

```bash
# Basic validation
/validate-base-setup

# Specify template for targeted validation
/validate-base-setup --template nextjs-shadcn-tailwind-supabase

# Deep analysis including security and performance
/validate-base-setup --deep

# Auto-fix detected issues where safe
/validate-base-setup --fix
```

## What it validates

**Project Structure:**
- Directory organization
- Configuration files
- Package dependencies
- Environment setup

**Code Quality & Build Issues:**
- Build success validation
- TypeScript strict mode compatibility
- Unused imports detection (Users, Globe, etc.)
- `any` type usage analysis
- Unused variable identification
- Tailwind config format verification

**Infrastructure:**
- Database connectivity
- API endpoints
- Development server
- Build system

**Security & Performance:**
- Environment secrets
- Dependency vulnerabilities
- Bundle optimization
- Loading performance

## Output

You'll get a comprehensive report with:
- ✅ Passing checks (including build success)
- ⚠️ Warnings that should be addressed
- ❌ Critical issues automatically resolved (Tailwind config, unused imports, etc.)
- 🔧 Specific fix recommendations
- Auto-fix capabilities for common setup problems

## Related Commands

- `/init-base-setup` - Initialize base setup
- `/extend-setup` - Add extensions to your setup