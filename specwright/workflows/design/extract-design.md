---
description: Extract design system from URL or screenshots to generate project-specific frontend-design skill
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Design System Extraction Workflow

## Overview

Extract UI design tokens from existing websites or screenshots and generate a project-specific frontend-design skill that combines the official Claude frontend-design framework with your extracted tokens.

**Output**: `.claude/skills/frontend-design.md` (project-specific skill)

**Used By**:
- web-developer agent (Market Validation)
- frontend-dev agent (Team Development)

---

<process_flow>

<step number="1" name="input_collection">

### Step 1: Collect Design Reference

Determine the source of design extraction.

<input_detection>
  IF command arguments provided:
    CHECK first argument:
      - Starts with "http://" or "https://" → URL mode
      - Ends with image extension (.png, .jpg, .jpeg, .gif, .webp) → Screenshot mode
      - Multiple arguments with image extensions → Multiple screenshots mode

  ELSE (no arguments):
    PROMPT user interactively:
      ```
      How would you like to extract the design system?

      Options:
      1. Provide URL of your website or a reference website
      2. Provide screenshot file path(s)
      3. Cancel extraction

      Enter your choice (1/2/3):
      ```

    BASED on user choice:
      1 → Ask for URL, set URL mode
      2 → Ask for file path(s), set Screenshot mode
      3 → Exit workflow
</input_detection>

<instructions>
  ACTION: Determine extraction mode (URL or Screenshot)
  COLLECT: URL or file paths
  VALIDATE: URL is accessible or files exist
  PROCEED: To appropriate extraction step
</instructions>

</step>

<step number="2" name="design_extraction">

### Step 2: Extract Design Tokens

Use design-system-extractor skill to analyze the reference and extract UI tokens.

<conditional_extraction>

  IF URL mode:
    <url_extraction>
      ACTION: Load design-system-extractor skill context

      TOOL: WebFetch
      URL: [USER_PROVIDED_URL]
      PROMPT: "Analyze this website's design system and extract:

      1. **Color Palette**:
         - Primary color (main brand color, used for CTAs)
         - Secondary color (supporting color)
         - Accent color (highlights, links)
         - Background colors (main background, sections)
         - Text colors (headings, body, muted)
         - Provide exact hex codes

      2. **Typography**:
         - Heading font family
         - Body font family
         - Font weights used (light, regular, semibold, bold)
         - Font sizes for h1, h2, h3, body
         - Line heights
         - Letter spacing if notable

      3. **Spacing System**:
         - Base spacing unit (4px, 8px, 16px)
         - Section padding (vertical spacing between sections)
         - Container max-width
         - Grid gaps

      4. **Component Styles**:
         - Button styles (padding, border-radius, hover effects, shadows)
         - Card styles (border, shadow, border-radius, background)
         - Input field styles (border, focus states, border-radius)
         - Border radius values (sharp, slightly rounded, very rounded)

      5. **Visual Effects**:
         - Box shadows used
         - Gradients (if any)
         - Backdrop blur effects
         - Animations (subtle, prominent, none)

      6. **Layout Patterns**:
         - Grid structure (12-column, custom)
         - Section layouts (centered, full-width, asymmetric)
         - Visual hierarchy approach

      Provide specific values (hex codes, pixel values, font names)."

      RECEIVE: Structured design token data
      STORE: In memory for Step 3
    </url_extraction>

  ELIF Screenshot mode:
    <screenshot_extraction>
      ACTION: Load design-system-extractor skill context

      STEP 1: Read all screenshot files
        TOOL: Read
        FILES: [USER_PROVIDED_PATHS]
        VERIFY: Files exist and are readable

      STEP 2: Analyze with general-purpose agent
        TOOL: Task (general-purpose subagent)
        PROMPT: "Analyze these UI screenshots and extract design system tokens:

        Reference images: [ATTACH ALL SCREENSHOTS TO CONTEXT]

        Extract:

        1. **Color Palette**:
           - Identify dominant colors and their usage
           - Primary (CTA buttons, main actions)
           - Secondary (less prominent buttons, accents)
           - Background and surface colors
           - Text colors (heading, body, muted)
           - Provide hex codes (use color picker or estimate from image)

        2. **Typography**:
           - Font families (identify or describe style: serif, sans-serif, monospace)
           - Heading sizes and weights (relative to body text)
           - Body text size and weight
           - Line heights and spacing
           - Letter spacing if notable

        3. **Spacing and Layout**:
           - Base spacing unit (measure consistent gaps)
           - Section padding (vertical spacing)
           - Grid structure (columns, gaps)
           - Container widths
           - Margin and padding patterns

        4. **Component Design**:
           - Button style (padding, radius, shadow, colors, hover states)
           - Card/container style (border, shadow, radius, background)
           - Form input style (border, focus state, radius, padding)
           - Navigation style (layout, spacing, colors)
           - Footer style

        5. **Visual Effects**:
           - Shadows (estimate box-shadow values)
           - Gradients (if present, describe direction and colors)
           - Border radius (sharp 0px, slightly rounded 4-8px, very rounded 12px+)
           - Hover/interaction states visible
           - Animations visible

        6. **Overall Aesthetic**:
           - Design tone (minimal, bold, playful, professional, luxury)
           - Visual hierarchy approach (strong, subtle)
           - Whitespace usage (tight, balanced, generous)

        Look for patterns across multiple screens. Document specific values where possible.

        Save analysis to: design-system-extracted.md"

      RECEIVE: design-system-extracted.md with structured tokens
      READ: design-system-extracted.md
      STORE: Design tokens in memory for Step 3
    </screenshot_extraction>

</conditional_extraction>

<instructions>
  ACTION: Extract design tokens using appropriate method (URL or Screenshot)
  FOLLOW: design-system-extractor skill guidelines
  OUTPUT: Structured design token data
  VERIFY: All major categories extracted (colors, typography, spacing, components)
</instructions>

</step>

<step number="3" name="load_official_template">

### Step 3: Load Official Frontend-Design Skill Template

Fetch the official Claude frontend-design skill template from GitHub.

<template_fetching>
  SOURCE: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/frontend-design/skills/frontend-design/SKILL.md

  TOOL: WebFetch
  URL: [SOURCE]
  PROMPT: "Extract the complete frontend-design skill content including:
           - Frontmatter (---...---)
           - All section headings and content
           - Design Thinking Phase
           - Aesthetic Direction
           - Implementation Principles (Typography, Color, Motion, Spatial, Visual)
           - Critical Guardrails

           Return the complete skill file content."

  RECEIVE: Official skill template content
  STORE: In memory for merging in Step 4
</template_fetching>

<instructions>
  ACTION: Fetch official frontend-design skill template
  VERIFY: Template includes frontmatter and all sections
  PREPARE: For merging with extracted tokens
</instructions>

</step>

<step number="4" name="merge_and_generate">

### Step 4: Merge Template + Extracted Tokens

Create project-specific frontend-design skill by merging official template with extracted design tokens.

<merging_process>
  STRUCTURE:
    1. Official frontmatter (keep as-is, update description if needed):
       ---
       name: frontend-design
       description: [Project name] design system with extracted UI tokens
       globs: ["**/*.{html,css,tsx,jsx,vue,svelte}"]
       ---

    2. INSERT new section immediately after frontmatter:
       ## Project Design System (Extracted from Reference)

       **Source**: [URL or Screenshot filenames]
       **Extracted**: [Current date YYYY-MM-DD]

       [Extracted tokens in structured CSS format]

    3. KEEP all original sections from official skill:
       - Design Thinking Phase (unchanged)
       - Aesthetic Direction (unchanged)
       - Implementation Principles:
         - Typography (add note: "Use extracted fonts from Project Design System")
         - Color & Theme (add note: "Use extracted palette from Project Design System")
         - Motion (add note: "Match animation style from reference")
         - Spatial Composition (add note: "Follow extracted spacing system")
         - Visual Details (add note: "Apply extracted effects")
       - Critical Guardrails (unchanged)

    4. ADD usage instructions at end:
       ## Usage Instructions

       For web-developer and frontend-dev agents:
       - Read "Project Design System" section first
       - Use extracted tokens (CSS variables) consistently
       - Apply official principles for excellence
       - Match reference aesthetic while optimizing for goals
</merging_process>

<extracted_tokens_format>
  FORMAT as CSS variables with comments:

  ### Color Palette
  ```css
  /* Primary Colors */
  --color-primary: #[HEX];        /* [Usage description] */
  --color-secondary: #[HEX];      /* [Usage description] */

  /* [More categories...] */
  ```

  ### Typography System
  ```css
  --font-heading: "[Font name]", sans-serif;
  --font-body: "[Font name]", sans-serif;
  --text-h1: [size];
  /* [More definitions...] */
  ```

  [Continue for all extracted categories]
</extracted_tokens_format>

<instructions>
  ACTION: Merge official skill template with extracted tokens
  STRUCTURE: Frontmatter → Project Tokens → Official Framework → Usage
  FORMAT: CSS variables for all design tokens
  VERIFY: Complete skill with both extracted data and official guidance
</instructions>

</step>

<step number="5" name="save_skill">

### Step 5: Save Project-Specific Skill

Write the generated frontend-design skill to project.

<file_output>
  LOCATION: .claude/skills/frontend-design.md
  FORMAT: Complete markdown file with frontmatter

  OVERWRITE: If file already exists (update design system)

  VERIFY after save:
    - File exists at .claude/skills/frontend-design.md
    - Contains valid frontmatter with name: frontend-design
    - Contains "Project Design System" section
    - Contains all official frontend-design framework sections
    - Total size reasonable (5-15KB)
</file_output>

<instructions>
  ACTION: Write merged skill to .claude/skills/frontend-design.md
  VERIFY: File is complete and valid
  CONFIRM: Skill will be auto-loaded by frontend agents
</instructions>

</step>

<step number="6" name="completion_summary">

### Step 6: Provide Summary to User

Confirm successful extraction and provide next steps.

<summary_template>
  ✅ Design system extracted successfully!

  **Source**: [URL or Screenshot filenames]
  **Saved to**: `.claude/skills/frontend-design.md`

  **Extracted Design Tokens**:
  - Colors: [Number] colors ([List primary, secondary, accent])
  - Typography: [Font names for heading/body]
  - Spacing: Base unit [value], [Number] spacing values
  - Components: [List extracted component styles]
  - Effects: [List shadows, gradients, etc.]

  **This skill will be automatically used by**:
  - `web-developer` agent (Market Validation landing pages)
  - `frontend-dev` agent (Team Development production apps)

  **Next Steps**:
  1. Review `.claude/skills/frontend-design.md` (optional)
  2. Adjust tokens if needed (edit "Project Design System" section)
  3. Run `/execute-tasks` with frontend tasks
     → Specialists automatically use your design system

  **To update the design system**:
  - Re-run `/extract-design` with new URL or screenshots
  - Or manually edit `.claude/skills/frontend-design.md`

  **Example usage**:
  ```
  # In tasks.md
  1. Create user profile component

  # Run
  /execute-tasks

  # → frontend-dev auto-loads .claude/skills/frontend-design.md
  # → Generates component with YOUR colors, fonts, spacing
  # → Matches existing design automatically!
  ```
</summary_template>

<instructions>
  ACTION: Display summary with extracted token overview
  INCLUDE: Next steps and usage examples
  PROVIDE: Update instructions
</instructions>

</step>

</process_flow>

---

## Error Handling

<error_protocols>
  <url_not_accessible>
    - ERROR: "Could not access URL: [URL]"
    - SUGGEST: Check URL is public (not behind login)
    - SUGGEST: Try alternative URL or use screenshots instead
  </url_not_accessible>

  <screenshots_not_found>
    - ERROR: "Screenshot file not found: [PATH]"
    - SUGGEST: Verify file path is correct
    - SUGGEST: Use absolute path or path relative to current directory
  </screenshots_not_found>

  <extraction_incomplete>
    - WARNING: "Some design tokens could not be extracted"
    - CONTINUE: Generate skill with available tokens
    - SUGGEST: User can manually add missing tokens to generated skill
  </extraction_incomplete>

  <template_fetch_failed>
    - ERROR: "Could not load official frontend-design skill template"
    - SUGGEST: Check internet connection
    - FALLBACK: Use embedded template (if available)
  </template_fetch_failed>
</error_protocols>

---

## Integration Points

### Market Validation System

Used in `/validate-market` workflow Step 9:
- Same extraction logic
- Generates `.claude/skills/frontend-design.md`
- web-developer uses it in Step 10

### Team Development System

Standalone usage before development:
- Run `/extract-design` to setup design system (one-time)
- frontend-dev auto-loads skill for all frontend tasks
- All components match project design

---

## Skill Dependencies

**Requires**:
- `design-system-extractor.md` skill (provides extraction framework)
- Internet access (to fetch official template from GitHub)
- WebFetch tool (for URL analysis)
- Read tool (for screenshot analysis)
- Task tool with general-purpose agent (for screenshot analysis)

**Generates**:
- `.claude/skills/frontend-design.md` (project-specific skill)
- `design-system-extracted.md` (intermediate, if from screenshots)

---

## Example Executions

### Example 1: Extract from Live App

```bash
/extract-design https://your-app.com
```

**Process**:
1. WebFetch analyzes your-app.com
2. Extracts: #1a73e8 (primary), Roboto font, 8px spacing, etc.
3. Fetches official frontend-design template
4. Merges tokens + framework
5. Saves to .claude/skills/frontend-design.md

**Result**: frontend-dev uses your app's design for new features

---

### Example 2: Extract from Screenshots

```bash
/extract-design screenshots/dashboard.png screenshots/form.png
```

**Process**:
1. Reads dashboard.png and form.png
2. general-purpose agent analyzes images
3. Extracts common patterns and specific values
4. Generates design-system-extracted.md
5. Fetches official frontend-design template
6. Merges extracted data + framework
7. Saves to .claude/skills/frontend-design.md

**Result**: frontend-dev matches screenshot aesthetic

---

### Example 3: Interactive Mode

```bash
/extract-design
```

**Process**:
1. Prompts user for input method
2. User selects: "1. URL"
3. Prompts for URL
4. User enters: https://stripe.com
5. Proceeds with URL extraction
6. Generates .claude/skills/frontend-design.md with Stripe-inspired tokens

---

## Quality Checklist

Before completing:

- [ ] Design tokens extracted (colors, typography, spacing, components)
- [ ] Official frontend-design template fetched
- [ ] Tokens merged with official framework
- [ ] CSS variables formatted correctly
- [ ] Frontmatter valid (name: frontend-design)
- [ ] File saved to .claude/skills/frontend-design.md
- [ ] User notified of success
- [ ] Next steps provided

---

## Notes

- This workflow is standalone (can run independently)
- Also integrated into /validate-market Step 9
- Generated skill persists (use for all future frontend work)
- Can re-run to update design system
- Skill auto-loads for web-developer and frontend-dev agents
