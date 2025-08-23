# /init-base-setup Command

Initialize your project with pre-configured base setups from the agent-os-extended-base-setups repository.

## Usage

```bash
# List all available templates
/init-base-setup

# Install specific template
/init-base-setup nextjs-shadcn-tailwind-supabase
```

## What it does

**Without template name:**
- Shows all available templates from the GitHub repository
- Displays technology stacks and status for each template
- Provides usage recommendations and requirements

**With template name:**
- Validates template availability
- Installs the complete base setup
- Configures environment and dependencies
- Runs AI-powered validation to ensure proper setup

## Available Templates

- **nextjs-shadcn-tailwind-supabase** (Production Ready)
  - Next.js 14 with App Router
  - shadcn/ui component library
  - Tailwind CSS for styling
  - Supabase for backend services

- More templates coming soon...

## Related Commands

- `/validate-base-setup` - Validate your installation
- `/extend-setup` - Add modules to your base setup