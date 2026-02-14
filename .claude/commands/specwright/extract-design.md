# Extract Design System

Extract design system from existing website or UI screenshots to generate project-specific frontend-design skill.

Refer to the instructions located in @specwright/workflows/design/extract-design.md

**Version**: 2.0

**Purpose**:
Analyze existing UI design (from URL or screenshots) and create a project-specific frontend-design skill that combines the official Claude frontend-design framework with extracted UI tokens.

**Use Cases:**
- Maintain design consistency when adding features to existing projects
- Extract design system from competitor websites for inspiration
- Document existing design patterns for new team members
- Prepare design tokens before frontend development tasks

---

## Usage

### Extract from URL

```bash
/extract-design https://your-website.com
```

**What happens:**
1. WebFetch analyzes the website
2. Extracts UI tokens (colors, fonts, spacing, components)
3. Downloads official Claude frontend-design skill template
4. Merges extracted tokens + official framework
5. Saves to `.claude/skills/frontend-design.md`

**Example:**
```bash
/extract-design https://stripe.com
# → Extracts Stripe's design system (#635BFF purple, Inter font, etc.)
# → Generates .claude/skills/frontend-design.md with Stripe-inspired tokens
```

---

### Extract from Screenshots

```bash
/extract-design screenshots/dashboard.png screenshots/forms.png
```

**What happens:**
1. Reads all provided screenshot files
2. Uses general-purpose agent to analyze images
3. Extracts UI tokens (colors, typography, spacing, components)
4. Downloads official Claude frontend-design skill template
5. Merges extracted tokens + official framework
6. Saves to `.claude/skills/frontend-design.md`

**Tips:**
- Provide multiple screenshots for comprehensive extraction
- Include: Dashboard, forms, lists, navigation, detail pages
- More screenshots = more accurate design token extraction

---

### Extract from Current Project (Auto-detect)

```bash
/extract-design
```

**What happens:**
1. Asks for URL or screenshot paths
2. Proceeds with extraction based on user input
3. Generates `.claude/skills/frontend-design.md`

---

## Workflow Process

### Step 1: Load design-system-extractor Skill

**Context**: The design-system-extractor skill provides the extraction framework.

**Location**: `specwright/skills/marketing/design-system-extractor.md`

---

### Step 2: Analyze Design Reference

**IF URL provided**:

<url_extraction>
  ACTION: Use WebFetch to analyze URL
  PROMPT: Follow design-system-extractor skill Step 1 Option A
  EXTRACT:
    - Color palette (primary, secondary, accent, backgrounds, text colors with hex codes)
    - Typography (font families, sizes, weights, line heights)
    - Spacing system (base unit, section padding, container widths, grid gaps)
    - Component styles (buttons, cards, inputs with padding, border-radius, shadows)
    - Visual effects (box-shadows, gradients, backdrop blur, animations)
    - Layout patterns (grid structure, breakpoints, section layouts)

  OUTPUT: Structured design tokens
</url_extraction>

**IF screenshots provided**:

<screenshot_extraction>
  ACTION: Read all screenshot files

  THEN: Use Task tool with general-purpose subagent
  PROMPT: Follow design-system-extractor skill Step 1 Option B
  ATTACH: All screenshot images to subagent context
  ANALYZE:
    - Color palette (identify hex codes from dominant colors)
    - Typography (font styles, sizes, weights - describe if can't identify exact font)
    - Spacing and layout (measure consistent gaps and patterns)
    - Component design (buttons, cards, forms, navigation)
    - Visual effects (shadows, gradients, border radius)
    - Overall aesthetic (minimal, bold, playful, professional, etc.)

  SAVE: design-system-extracted.md (intermediate documentation)
  OUTPUT: Structured design tokens
</screenshot_extraction>

**IF no input (interactive mode)**:

<interactive_mode>
  PROMPT user:
    ```
    How would you like to extract the design system?

    Options:
    1. Provide URL of your website or a reference website
    2. Provide screenshot file paths (space-separated)
    3. Cancel extraction

    Enter your choice (1/2/3):
    ```

  BASED on choice:
    - Option 1: Ask for URL, proceed with URL extraction
    - Option 2: Ask for file paths, proceed with screenshot extraction
    - Option 3: Exit command
</interactive_mode>

---

### Step 3: Load Official Frontend-Design Skill Template

**Source**: Official Claude Code frontend-design skill

**Action**:
```
URL: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/frontend-design/skills/frontend-design/SKILL.md

USE: WebFetch to download template
SAVE: Temporarily to memory (don't write to file yet)
```

**Template Contains**:
- Frontmatter (name, description, globs)
- Design Thinking Phase
- Aesthetic Direction
- Implementation Principles (Typography, Color, Motion, Spatial, Visual)
- Critical Guardrails

---

### Step 4: Merge Template + Extracted Tokens

**Process**:

```markdown
1. START with official frontend-design skill template (complete)

2. INSERT new section after frontmatter:
   ## Project Design System (Extracted from Reference)

   **Source**: [URL or Screenshot filenames]
   **Extracted**: [Current date]

   ### Color Palette
   [Extracted colors with CSS variables and usage notes]

   ### Typography System
   [Extracted fonts with sizes, weights, line heights]

   ### Spacing System
   [Extracted spacing scale and layout values]

   ### Component Design Tokens
   [Extracted button, card, input styles]

   ### Visual Effects
   [Extracted shadows, gradients, animations]

   ### Layout Guidelines
   [Extracted grid, breakpoints, container widths]

3. KEEP all original sections:
   - Design Thinking Phase (unchanged)
   - Aesthetic Direction (unchanged)
   - Implementation Principles (updated examples to reference extracted tokens)
   - Critical Guardrails (unchanged)

4. UPDATE examples in Implementation Principles:
   - Typography section: "Use var(--font-heading) from extracted tokens"
   - Color section: "Use var(--color-primary) from extracted palette"
   - Spacing section: "Use var(--space-unit) for consistent spacing"
```

**Result**: Complete frontend-design skill with:
- Official Claude design framework (thinking, principles, guardrails)
- Your project-specific design tokens (colors, fonts, spacing)

---

### Step 5: Save Project-Specific Skill

**Location**: `.claude/skills/frontend-design.md`

**Format**: Complete SKILL.md file with frontmatter

**Frontmatter**:
```yaml
---
name: frontend-design
description: [Project name] design system with extracted UI tokens
globs: ["**/*.{html,css,tsx,jsx,vue,svelte}"]
---
```

**Verification**:
- File exists at `.claude/skills/frontend-design.md`
- Contains frontmatter with `name: frontend-design`
- Contains "Project Design System" section with extracted tokens
- Contains all original frontend-design skill sections

---

### Step 6: Confirmation

**Output to user**:

```
✅ Design system extracted successfully!

Extracted from: [URL or screenshot filenames]
Saved to: .claude/skills/frontend-design.md

Design Tokens Extracted:
- Colors: [Number] colors (primary, secondary, accent, etc.)
- Typography: [Number] font definitions
- Spacing: Base unit [value], [Number] spacing values
- Components: Buttons, cards, inputs with specific styles
- Effects: Shadows, gradients, animations

This skill will be automatically used by:
- web-developer (Market Validation landing pages)
- frontend-dev (Team Development production apps)

Next steps:
1. Review .claude/skills/frontend-design.md
2. Adjust tokens if needed (edit the "Project Design System" section)
3. Run /execute-tasks - frontend specialists use this design automatically

To update the design system:
- Re-run /extract-design with new URL or screenshots
- Or manually edit .claude/skills/frontend-design.md
```

---

## Examples

### Example 1: Extract from Your Live App

```bash
/extract-design https://your-app.com

# Analyzes your-app.com
# Extracts: #1a73e8 (primary), Roboto font, 8px spacing, etc.
# Generates: .claude/skills/frontend-design.md
# Result: New features match existing design!
```

---

### Example 2: Extract from Screenshots

```bash
/extract-design screenshots/dashboard.png screenshots/form.png screenshots/list.png

# Analyzes all 3 screenshots
# Extracts common patterns
# Generates: .claude/skills/frontend-design.md with your UI tokens
```

---

### Example 3: Extract from Competitor (Inspiration)

```bash
/extract-design https://stripe.com

# Extracts Stripe's design system
# Generates: .claude/skills/frontend-design.md with Stripe-inspired tokens
# Note: Use for inspiration, not copying (add your own differentiators)
```

---

### Example 4: Interactive Mode

```bash
/extract-design

# Prompts:
# "How would you like to extract the design system?"
# "1. URL"
# "2. Screenshots"
# "3. Cancel"
#
# User selects option
# Proceeds with extraction
```

---

## Integration with Workflows

### Market Validation System

In `/validate-market` workflow Step 9:
- User chooses design reference
- Internally uses same extraction process as `/extract-design`
- Generates `.claude/skills/frontend-design.md`
- web-developer uses it in Step 10

### Team Development System

Before running `/execute-tasks` with frontend tasks:
- Run `/extract-design` to setup design system (one-time)
- frontend-dev auto-loads `.claude/skills/frontend-design.md`
- All generated components match your design

---

## Advanced Usage

### Update Existing Design System

```bash
# After design refresh or rebrand
/extract-design https://your-app.com

# Overwrites .claude/skills/frontend-design.md
# Next frontend tasks use updated tokens
```

---

### Multiple Projects, Same Design

```bash
# In project A
cd project-a
/extract-design https://company-website.com
# Generates: project-a/.claude/skills/frontend-design.md

# In project B
cd project-b
/extract-design https://company-website.com
# Generates: project-b/.claude/skills/frontend-design.md

# Both projects now use same company design system
```

---

### Custom Tokens (Manual Override)

```bash
# Extract base design
/extract-design https://your-app.com

# Then manually adjust
vim .claude/skills/frontend-design.md

# Edit "Project Design System" section:
# - Adjust colors (slightly different shade)
# - Change spacing scale
# - Update button styles
# - etc.

# frontend-dev uses your customized version
```

---

## Output Files

**Primary Output**:
- `.claude/skills/frontend-design.md` - Project-specific frontend-design skill

**Optional Intermediate**:
- `design-system-extracted.md` - Raw extraction data (if from screenshots)

---

## Skill Dependencies

**Requires**:
- `design-system-extractor.md` skill (specwright/skills/marketing/)
- Official Claude frontend-design skill template (fetched from GitHub)

**Auto-Loaded By**:
- web-developer agent (Market Validation)
- frontend-dev agent (Team Development)

---

## Troubleshooting

**URL Analysis Fails**:
- Check URL is accessible (not behind login)
- Try alternative URL (homepage vs specific page)
- Use screenshots instead

**Screenshot Analysis Incomplete**:
- Provide more screenshots (different pages/states)
- Include close-ups of components (buttons, forms)
- Ensure screenshots are clear and high-resolution

**Generated Skill Missing Tokens**:
- Re-run with more specific reference
- Manually add tokens to "Project Design System" section
- Check extraction output for errors

---

**Status**: Ready to use

**Next Steps**: Run `/extract-design` in your project to setup design system
