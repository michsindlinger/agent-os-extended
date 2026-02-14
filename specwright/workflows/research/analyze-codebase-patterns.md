---
description: Analyze existing codebase patterns for feature planning
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Analyze Codebase Patterns

Systematically analyze existing code patterns to inform new feature development.

## Purpose

Before creating a new feature, understand what patterns, services, and conventions already exist in the codebase. This ensures:
- Consistency with existing architecture
- Reuse of existing components and services
- Alignment with established conventions
- Reduced duplication and technical debt

## Analysis Process

### Step 1: Identify Feature Domain

Based on the feature description, identify the relevant domain area:
- User management → Look for existing User services, models, controllers
- Payment processing → Look for existing Payment, Order, Transaction code
- Reporting → Look for existing Export, Report, PDF generation code
- Authentication → Look for existing Auth, Security, Session code

### Step 2: Search for Existing Patterns

Use systematic searches to find related code:

**Services/Business Logic:**
```bash
# Search for services in the domain
grep -r "class.*Service" --include="*.java" --include="*.ts"
grep -r "Service.*{" --include="*.java" --include="*.ts"
```

**Controllers/API Endpoints:**
```bash
# Search for controllers
grep -r "@RestController\|@Controller" --include="*.java"
grep -r "Controller.*{" --include="*.ts"
```

**Data Models:**
```bash
# Search for entities/models
grep -r "@Entity\|interface.*{" --include="*.java" --include="*.ts"
```

**Utility Functions:**
```bash
# Search for relevant utilities
grep -r "export function\|public static" --include="*.java" --include="*.ts"
```

### Step 3: Analyze Patterns

For each found component, document:

**Architecture Patterns:**
- Layering (Controller → Service → Repository)
- Naming conventions
- Package/directory structure
- Design patterns in use (Factory, Builder, Strategy, etc.)

**Code Patterns:**
- Error handling approach
- Validation strategy
- Logging conventions
- Testing patterns

**Technology Choices:**
- Libraries/frameworks already in use
- Database access patterns
- API design style (REST, GraphQL)
- Authentication/authorization approach

### Step 4: Extract Reusable Components

Identify components that can be reused:

**Example findings:**
```markdown
## Existing Patterns Found

### Payment Processing
- **Service**: `PaymentService.java` (line 45)
  - Uses Stripe API for credit card processing
  - Implements retry logic with exponential backoff
  - Pattern: Factory pattern for payment method selection

- **Model**: `Payment.java` (line 12)
  - Stores payment status, amount, currency
  - Uses enum for payment status (PENDING, COMPLETED, FAILED)

- **Utility**: `CurrencyFormatter.java` (line 78)
  - Formats currency amounts by locale
  - Can be reused for invoice amounts

### File Generation
- **Service**: `ReportExporter.java` (line 120)
  - Uses Apache POI for Excel generation
  - Uses iText for PDF generation
  - Pattern: Strategy pattern for different export formats
  - **Reusable**: Can extend for invoice export

### File Storage
- **Service**: `S3UploadService.java` (line 200)
  - Uploads files to AWS S3
  - Generates signed URLs with expiry
  - **Reusable**: Can use for invoice file storage
```

### Step 5: Document Conventions

Extract conventions from existing code:

**Naming Conventions:**
```markdown
Controllers: `{Entity}Controller.java`
Services: `{Entity}Service.java`
Repositories: `{Entity}Repository.java`
DTOs: `{Entity}Dto.java` or `{Action}{Entity}Request.java`
```

**Package Structure:**
```
com.company.project/
  ├── controller/
  ├── service/
  ├── repository/
  ├── model/
  └── dto/
```

### Step 6: Identify Gaps

Document what's missing that the new feature might need:
- New services to create
- New models/entities required
- New utilities needed
- Integration points to consider

## Output Format

Create research-notes.md with findings:

```markdown
# Codebase Analysis for [Feature Name]

## Existing Patterns

### Similar Features
[List features that are similar and what can be learned]

### Reusable Components
[List specific classes/functions that can be reused]

### Architectural Patterns
[Document patterns observed in the codebase]

## Conventions

### Naming
[Document naming conventions]

### Structure
[Document file/package organization]

### Testing
[Document testing approaches used]

## Recommendations

### Reuse
[Specific components to reuse]

### New Development
[What needs to be created from scratch]

### Integration Points
[How to integrate with existing code]

## Questions Raised
[Any uncertainties or decisions needed]
```

## Best Practices

1. **Be Thorough** - Search multiple related terms
2. **Document Locations** - Include file paths and line numbers
3. **Extract Examples** - Copy relevant code snippets
4. **Note Dependencies** - Document what components depend on what
5. **Identify Owners** - If possible, note who wrote the code (git blame)

## Checklist

Before completing pattern analysis:
- [ ] Searched for similar features in codebase
- [ ] Identified reusable services/components
- [ ] Documented naming conventions
- [ ] Documented package/directory structure
- [ ] Extracted architectural patterns
- [ ] Noted testing approaches
- [ ] Identified integration points
- [ ] Listed questions for user clarification
