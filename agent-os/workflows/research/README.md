# Research Workflows

Enhanced research capabilities for feature planning (v2.0).

## Overview

The research phase helps create better specifications by:
1. Analyzing existing codebase for reusable patterns
2. Asking targeted questions to clarify requirements
3. Collecting and analyzing visual designs
4. Documenting findings for reference

## When Research Phase Runs

The research phase is automatically integrated into `/create-spec` v2.0 workflow.

**Traditional Flow (v1.x):**
```
User describes feature → Claude writes spec → Done
```

**Enhanced Flow (v2.0):**
```
User describes feature →
Research Phase (analyze + Q&A + visuals) →
Claude writes informed spec →
Done
```

## Research Workflows

### 1. Analyze Codebase Patterns

**File**: `analyze-codebase-patterns.md`

**What it does:**
- Searches for similar existing features
- Identifies reusable services and utilities
- Extracts architectural patterns
- Documents naming conventions

**Example:**
```
Feature: "Add invoice export"

Analysis finds:
- ReportExporter.java (PDF generation with iText)
- DataExporter.java (Excel generation with Apache POI)
- S3UploadService.java (File storage)

Recommendation: Extend ReportExporter pattern for invoices
```

**Output**: Initial research findings

### 2. Interactive Q&A

**Template**: `../templates/research/research-questions.md`

**What it does:**
- Asks targeted questions based on feature type
- Uses AskUserQuestion tool for structured input
- Clarifies ambiguous requirements
- Documents decisions

**Question Categories:**
- Technical Scope (formats, performance, sync/async)
- Integration (which components to reuse)
- Security & Permissions
- UI/UX requirements
- Business logic rules

**Example:**
```
Q: What export formats should be supported?
☑ PDF
☑ Excel
☐ CSV

Q: Should exports be asynchronous?
☐ Always synchronous
☐ Always asynchronous
☑ Conditional (async for large files)

Answer: Use async for exports with >50 items
```

**Output**: Clarified requirements documented in research notes

### 3. Visual Asset Collection

**File**: `visual-assets.md`

**What it does:**
- Asks for mockups/wireframes/screenshots
- Copies assets to spec directory
- Analyzes visual designs
- Extracts design tokens (colors, fonts, spacing)
- Documents component structure

**Supported Assets:**
- High-fidelity mockups (PNG, JPG)
- Wireframes/sketches
- Screenshots of existing UI
- Figma/Sketch/Penpot links
- Text descriptions (if no visuals available)

**Example:**
```
Mockup provided: invoice-export-button.png

Analysis:
- Button placement: Top-right of invoice header
- Style: Primary button (blue-500 background)
- Icon: Download icon (Lucide)
- Interaction: Click opens format dropdown
- States: Default, hover, loading, success
```

**Output**: Visual assets stored and analyzed in research notes

## Research Output

All research is documented in:

```
agent-os/specs/YYYY-MM-DD-feature-name/
├── research-notes.md          # Complete research findings
├── mockups/                   # (if provided)
│   └── design-file.png
├── wireframes/                # (if provided)
└── screenshots/               # (if provided)
```

## Using Research Findings

Research findings inform:

1. **spec.md** - References to reusable components, aligned with patterns
2. **technical-spec.md** - Specific components to reuse, architectural decisions
3. **tasks.md** - Tasks reference existing code to extend/modify
4. **api-spec.md** - API design follows existing conventions

## Benefits

**Without Research:**
- Specs may duplicate existing code
- May miss reusable components
- Architecture may be inconsistent
- Requirements may be incomplete
- May reinvent existing patterns

**With Research:**
- Specs aligned with existing architecture
- Reuses proven components
- Consistent with codebase conventions
- Complete requirements upfront
- Follows established patterns

## Example: Complete Research Flow

```markdown
User: "Add invoice export feature with PDF and Excel formats"

┌─────────────────────────────────────────┐
│ Step 4: Codebase Analysis               │
└─────────────────────────────────────────┘

Agent: Analyzing existing export functionality...

Found:
✓ ReportExporter.java (PDF with iText)
✓ DataExporter.java (Excel with Apache POI)
✓ S3UploadService.java (AWS S3 uploads)
✓ BackgroundJobService.java (Async processing)

┌─────────────────────────────────────────┐
│ Step 5: Interactive Q&A                 │
└─────────────────────────────────────────┘

Agent: I have some questions to clarify the requirements:

Q1: Should we reuse ReportExporter for PDFs?
☑ Yes, extend existing service

Q2: Export formats needed?
☑ PDF
☑ Excel
☐ CSV

Q3: Processing approach?
☑ Async for invoices with >50 items

Q4: Storage location?
☑ AWS S3 with signed URLs (24h expiry)

┌─────────────────────────────────────────┐
│ Step 6: Visual Assets                   │
└─────────────────────────────────────────┘

Agent: Do you have mockups for the UI?

User: [uploads invoice-export-button.png]

Agent: ✓ Mockup analyzed:
- Export button in invoice header (top-right)
- Dropdown for format selection
- Loading indicator during generation
- Success toast with download link

┌─────────────────────────────────────────┐
│ Step 7: Research Summary                │
└─────────────────────────────────────────┘

Agent: Research complete!

Reusable Components:
- ReportExporter.java (extend for invoices)
- S3UploadService.java (file storage)
- BackgroundJobService.java (async processing)

Decisions:
- Formats: PDF + Excel
- Processing: Conditional async (>50 items)
- Storage: S3 with signed URLs (24h)

Visual Design:
- Button analyzed from mockup
- Matches existing design system

Ready to create formal specification?
User: Yes

[Proceeds to create spec.md with all insights]
```

## Configuration

Enable enhanced research in `agent-os/config.yml`:

```yaml
features:
  enhanced_research: true
```

## Troubleshooting

**Q: Research phase takes too long?**
A: You can skip codebase analysis for small features or when you know there's nothing to reuse.

**Q: No similar patterns found?**
A: Document this finding - it may indicate this is a genuinely new feature requiring fresh architecture.

**Q: Visual assets not available?**
A: Skip visual collection - spec can still be created with text descriptions.

## Resources

- [Research Questions Template](../../templates/research/research-questions.md)
- [Research Notes Template](../../templates/research/research-notes.md)
- [Codebase Analysis Guide](analyze-codebase-patterns.md)
- [Visual Assets Guide](visual-assets.md)
