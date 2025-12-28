# Design System Extractor

## Context

Extract UI design tokens from website URLs or screenshots and generate a project-specific frontend-design skill with extracted tokens. Used in Market Validation System to create landing pages matching user's preferred design style.

## Purpose

This skill analyzes design references (URLs or images) and creates a customized `frontend-design.md` skill that combines:
1. The official Claude frontend-design skill framework (design thinking, best practices)
2. Extracted UI tokens from the user's reference (colors, fonts, spacing, components)

The generated skill is saved to `.claude/skills/frontend-design.md` for use by the web-developer agent.

## Workflow

### Step 1: Analyze Design Reference

#### Option A: URL Analysis

**Tool**: WebFetch

**Prompt Template**:
```
Analyze this website's design system and extract:

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

Provide specific values (hex codes, pixel values, font names).
```

**Example Analysis Output**:
```yaml
colors:
  primary: "#FF5A5F"
  secondary: "#00A699"
  accent: "#FC642D"
  background: "#FFFFFF"
  surface: "#F7F7F7"
  text_primary: "#222222"
  text_secondary: "#717171"

typography:
  heading_font: "Circular, -apple-system, sans-serif"
  body_font: "system-ui, -apple-system, sans-serif"
  heading_weight: 600
  body_weight: 400
  h1_size: "48px"
  h2_size: "32px"
  h3_size: "24px"
  body_size: "16px"
  line_height: 1.5

spacing:
  base_unit: "8px"
  section_padding: "80px"
  container_max_width: "1200px"
  grid_gap: "24px"

components:
  button:
    padding: "12px 24px"
    border_radius: "8px"
    shadow: "0 1px 3px rgba(0,0,0,0.12)"
    hover_transform: "translateY(-2px)"
  card:
    border_radius: "12px"
    shadow: "0 2px 8px rgba(0,0,0,0.08)"
    border: "1px solid #E5E5E5"
  input:
    border: "1px solid #DDDDDD"
    border_radius: "4px"
    focus_border: "#FF5A5F"

effects:
  primary_shadow: "0 4px 12px rgba(0,0,0,0.15)"
  subtle_shadow: "0 1px 3px rgba(0,0,0,0.12)"
  gradient: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
  backdrop_blur: "blur(10px)"

layout:
  grid: "12-column"
  breakpoints:
    mobile: "640px"
    tablet: "768px"
    desktop: "1024px"
  section_layout: "centered with max-width"
```

---

#### Option B: Screenshot/Image Analysis

**Tool**: Read (for image file)

**Process**:
1. Read the image file (Claude can analyze images)
2. Extract the same design tokens as Option A
3. Use Task tool with general-purpose subagent for detailed analysis

**Prompt Template for Subagent**:
```
Analyze this screenshot/mockup and extract design system tokens:

Reference images: [ATTACHED_IMAGES]

Extract:

1. **Color Palette**:
   - Identify dominant colors and their usage
   - Primary (CTA buttons, main actions)
   - Secondary (less prominent buttons, accents)
   - Background and surface colors
   - Text colors (heading, body, muted)
   - Provide hex codes (use color picker or estimate)

2. **Typography**:
   - Font families (identify or describe style: serif, sans-serif, monospace)
   - Heading sizes and weights
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
   - Button style (padding, radius, shadow, colors)
   - Card/container style (border, shadow, radius)
   - Form input style (border, focus state, radius)
   - Navigation style
   - Footer style

5. **Visual Effects**:
   - Shadows (box-shadow values)
   - Gradients (if present)
   - Border radius (sharp, rounded, very rounded)
   - Hover/interaction states
   - Animations visible

6. **Overall Aesthetic**:
   - Design tone (minimal, bold, playful, professional, luxury)
   - Visual hierarchy approach
   - Whitespace usage (tight, balanced, generous)

Look for patterns across multiple screens. Document specific values.
Save output as: design-system-extracted.md
```

---

### Step 2: Load Official Frontend-Design Skill Template

**Source**: Official Claude Code frontend-design skill

**Download**:
```
URL: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/frontend-design/skills/frontend-design/SKILL.md
```

**Template Structure**:
```markdown
---
name: frontend-design
description: Build distinctive, production-grade interfaces
globs: ["**/*.{html,css,tsx,jsx,vue,svelte}"]
---

# Frontend Design Skill

## Design Thinking Phase
[Framework for establishing context and direction]

## Aesthetic Direction
[Guidance on choosing bold positioning]

## Implementation Principles

### Typography
[Font selection and pairing guidance]

### Color & Theme
[Color palette and CSS variable guidance]

### Motion
[Animation and transition guidance]

### Spatial Composition
[Layout and composition guidance]

### Visual Details
[Atmosphere building guidance]

## Critical Guardrails
[Warnings against generic patterns]
```

---

### Step 3: Merge Template + Extracted Tokens

**Process**:

1. Take official frontend-design skill content (framework and principles)
2. Add new section after frontmatter: **"Project Design System"**
3. Insert extracted UI tokens in structured format
4. Keep all original guidance and guardrails
5. Save to `.claude/skills/frontend-design.md`

**Generated Skill Structure**:

```markdown
---
name: frontend-design
description: Build distinctive, production-grade interfaces matching extracted design system
globs: ["**/*.{html,css,tsx,jsx,vue,svelte}"]
---

# Frontend Design Skill

## Project Design System (Extracted from Reference)

**Source**: [URL or Screenshot filename]
**Extracted**: [Date]

### Color Palette

Use these extracted colors for consistency with reference design:

```css
/* Primary Colors */
--color-primary: #FF5A5F;        /* Main brand color - use for CTAs, primary actions */
--color-secondary: #00A699;      /* Supporting color - use for secondary actions */
--color-accent: #FC642D;         /* Accent - use for highlights, hover states */

/* Backgrounds */
--color-background: #FFFFFF;     /* Main background */
--color-surface: #F7F7F7;        /* Cards, sections */

/* Text */
--color-text-primary: #222222;   /* Headings, primary text */
--color-text-secondary: #717171; /* Body text, descriptions */
--color-text-muted: #999999;     /* Captions, meta info */

/* Functional */
--color-success: #00A699;
--color-error: #D93900;
--color-warning: #FC642D;
```

**Usage**:
- CTA buttons: Use `--color-primary`
- Text links: Use `--color-accent`
- Section backgrounds: Alternate `--color-background` and `--color-surface`

---

### Typography System

Use these extracted typography values:

```css
/* Font Families */
--font-heading: "Circular", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
--font-body: system-ui, -apple-system, sans-serif;

/* Font Sizes (fluid typography) */
--text-h1: clamp(36px, 5vw, 48px);
--text-h2: clamp(28px, 4vw, 32px);
--text-h3: clamp(20px, 3vw, 24px);
--text-body: 16px;
--text-small: 14px;

/* Font Weights */
--weight-heading: 600;
--weight-body: 400;
--weight-bold: 700;

/* Line Heights */
--line-height-tight: 1.2;
--line-height-normal: 1.5;
--line-height-relaxed: 1.7;

/* Letter Spacing */
--letter-spacing-tight: -0.02em;
--letter-spacing-normal: 0;
--letter-spacing-wide: 0.05em;
```

**Usage**:
- Hero headlines: Use `--font-heading` with `--text-h1` and `--weight-heading`
- Section titles: Use `--text-h2` with `--weight-heading`
- Body content: Use `--font-body` with `--text-body` and `--weight-body`

---

### Spacing System

Use this extracted spacing scale:

```css
/* Base Unit: 8px */
--space-1: 8px;    /* Tiny - icon gaps, inline spacing */
--space-2: 16px;   /* Small - between related elements */
--space-3: 24px;   /* Medium - component padding, grid gaps */
--space-4: 32px;   /* Large - between sections (mobile) */
--space-5: 48px;   /* XL - between sections (tablet) */
--space-6: 80px;   /* XXL - between sections (desktop) */

/* Container */
--container-max-width: 1200px;
--container-padding: var(--space-3);

/* Section Padding (responsive) */
--section-padding-y: clamp(48px, 8vw, 80px);
```

**Usage**:
- Component padding: Use `--space-3` (24px)
- Section spacing: Use `--section-padding-y`
- Grid gaps: Use `--space-3` or `--space-4`

---

### Component Design Tokens

#### Buttons

```css
/* Primary Button (extracted style) */
.button-primary {
  padding: 12px 24px;
  border-radius: 8px;
  background: var(--color-primary);
  color: white;
  font-weight: 600;
  box-shadow: 0 1px 3px rgba(0,0,0,0.12);
  transition: all 0.2s ease;
}

.button-primary:hover {
  background: #E04E53; /* Slightly darker */
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* Secondary Button */
.button-secondary {
  padding: 12px 24px;
  border-radius: 8px;
  background: transparent;
  color: var(--color-primary);
  border: 2px solid var(--color-primary);
  font-weight: 600;
}
```

#### Cards

```css
/* Card Component (extracted style) */
.card {
  background: white;
  border-radius: 12px;
  padding: var(--space-4);
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  border: 1px solid #E5E5E5;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}
```

#### Form Inputs

```css
/* Input Field (extracted style) */
.input {
  padding: 12px 16px;
  border: 1px solid #DDDDDD;
  border-radius: 4px;
  font-size: 16px;
  transition: border-color 0.2s ease;
}

.input:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(255,90,95,0.1);
}
```

---

### Visual Effects

```css
/* Extracted Shadow System */
--shadow-subtle: 0 1px 3px rgba(0,0,0,0.12);
--shadow-medium: 0 2px 8px rgba(0,0,0,0.08);
--shadow-prominent: 0 4px 12px rgba(0,0,0,0.15);
--shadow-large: 0 8px 24px rgba(0,0,0,0.12);

/* Gradients (if present in reference) */
--gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
--gradient-subtle: linear-gradient(180deg, #FFFFFF 0%, #F7F7F7 100%);

/* Backdrop Effects */
--backdrop-blur: blur(10px);
```

---

### Layout Guidelines

**Grid Structure**: 12-column grid with 24px gaps

**Container**:
- Max-width: 1200px
- Horizontal padding: 24px (mobile), 48px (desktop)
- Centered alignment

**Sections**:
- Vertical padding: 48px (mobile) → 80px (desktop)
- Background alternates: white → light gray

**Breakpoints**:
```css
--breakpoint-sm: 640px;  /* Mobile → Tablet */
--breakpoint-md: 768px;  /* Tablet → Desktop */
--breakpoint-lg: 1024px; /* Desktop → Wide */
--breakpoint-xl: 1280px; /* Wide → Ultra-wide */
```

---

## Design Thinking Phase

[KEEP ORIGINAL CONTENT FROM OFFICIAL SKILL]

Before implementation, establish context:

1. **Purpose**: What is this interface for? What's the primary user action?
2. **Audience**: Who uses this? What's their technical comfort level?
3. **Tone**: What feeling should this evoke? (Professional, playful, urgent, calm)
4. **Constraints**: Technical limitations, accessibility requirements, performance budgets
5. **Differentiator**: What makes this memorable? What's the "hook"?

Choose a clear conceptual direction and execute it with precision.

---

## Aesthetic Direction

[KEEP ORIGINAL CONTENT FROM OFFICIAL SKILL]

Select a bold positioning rather than defaulting to neutral:

- **Brutally Minimal**: Stark whitespace, monochrome, geometric precision
- **Maximalist**: Rich textures, layered typography, abundant visual elements
- **Retro-Futuristic**: Nostalgia meets modern, analog warmth with digital polish
- **Luxury-Refined**: Subtle elegance, restrained color, high-end feel
- **Playful-Bold**: Vibrant colors, unexpected interactions, personality-forward

Match aesthetic to extracted design system tokens while maintaining conceptual vision.

---

## Implementation Principles

### 1. Typography

**Extracted Fonts** (use these):
- Headings: [--font-heading from extraction]
- Body: [--font-body from extraction]

**Guidance from Official Skill**:
- Avoid defaults (Arial, Inter) - use characterful, unexpected fonts
- Pair display and body fonts purposefully
- Establish clear visual hierarchy

**Application**:
```css
h1 {
  font-family: var(--font-heading);
  font-size: var(--text-h1);
  font-weight: var(--weight-heading);
  line-height: var(--line-height-tight);
  color: var(--color-text-primary);
}
```

---

### 2. Color & Theme

**Extracted Palette** (use these):
- Primary: [--color-primary from extraction]
- Secondary: [--color-secondary from extraction]
- Accent: [--color-accent from extraction]

**Guidance from Official Skill**:
- Commit to cohesive palettes using CSS variables
- Dominant colors with sharp accents outperform timid distributions
- Avoid generic purple gradients

**Application**:
```css
/* Use extracted colors consistently */
.cta-button {
  background: var(--color-primary);
  color: white;
}

.cta-button:hover {
  background: color-mix(in srgb, var(--color-primary) 85%, black);
}
```

---

### 3. Motion

**Extracted Animation Style** (match reference):
- Duration: [from extraction, e.g., 0.2s]
- Easing: [from extraction, e.g., ease, cubic-bezier]
- Transform patterns: [from extraction, e.g., translateY, scale]

**Guidance from Official Skill**:
- CSS-first animations (avoid JavaScript where possible)
- High-impact moments (orchestrated page loads)
- Staggered reveals more effective than scattered micro-interactions

**Application**:
```css
/* Hero section entrance */
.hero {
  animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Stagger child elements */
.hero > * {
  animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1) backwards;
}

.hero > *:nth-child(1) { animation-delay: 0.1s; }
.hero > *:nth-child(2) { animation-delay: 0.2s; }
.hero > *:nth-child(3) { animation-delay: 0.3s; }
```

---

### 4. Spatial Composition

**Extracted Layout** (follow reference):
- Grid: [from extraction, e.g., 12-column]
- Container: [from extraction, e.g., max-width: 1200px]
- Section spacing: [from extraction]

**Guidance from Official Skill**:
- Employ asymmetry, overlap, diagonal flow
- Grid-breaking elements create unexpected layouts
- Avoid predictable centering

**Application**: Balance extracted precision with creative composition

---

### 5. Visual Details

**Extracted Effects** (use these):
- Shadows: [from extraction]
- Border radius: [from extraction]
- Gradients: [from extraction, if any]

**Guidance from Official Skill**:
- Build atmosphere through gradient meshes, textures, patterns
- Layered transparencies
- Context-specific decorative elements

**Application**: Apply extracted tokens while maintaining visual richness

---

## Critical Guardrails

[KEEP ORIGINAL CONTENT FROM OFFICIAL SKILL]

**Avoid**:
- ❌ Generic font families (Arial, Helvetica, Inter without intention)
- ❌ Clichéd color schemes (especially generic purple gradients)
- ❌ Predictable layouts (centered card, centered text, centered everything)
- ❌ Cookie-cutter patterns lacking contextual character

**Instead**:
- ✅ Use extracted design tokens for consistency
- ✅ Apply official skill principles for excellence
- ✅ Match reference aesthetic while maintaining conversion focus

---

## Quality Checklist

Before completing landing page:

**Design Token Compliance**:
- [ ] Colors match extracted palette
- [ ] Fonts match extracted typography
- [ ] Spacing follows extracted system
- [ ] Components match extracted styles
- [ ] Shadows and effects match reference

**Official Skill Principles**:
- [ ] Clear conceptual direction chosen
- [ ] Bold aesthetic positioning (not neutral)
- [ ] Intentional typography choices
- [ ] Cohesive color palette with CSS variables
- [ ] Motion enhances experience (not distracts)
- [ ] Spatial composition is interesting (not predictable)
- [ ] Visual details build atmosphere

**Conversion Optimization**:
- [ ] Clear CTAs (multiple, prominent)
- [ ] Form visible above fold
- [ ] Social proof included
- [ ] Fast loading (<3s)
- [ ] Mobile responsive

---

## Usage Instructions

**For web-developer agent**:

1. Read this skill before starting landing page implementation
2. Use extracted design tokens for all styling
3. Apply official frontend-design principles for excellence
4. Match reference aesthetic while optimizing for conversion
5. Implement all CSS using extracted values as CSS variables
6. Test visual consistency with reference

**Example CSS Implementation**:

```css
:root {
  /* Extracted Design Tokens */
  --color-primary: #FF5A5F;
  --color-secondary: #00A699;
  --font-heading: "Circular", sans-serif;
  --font-body: system-ui, sans-serif;
  --space-unit: 8px;
  --border-radius: 8px;
  --shadow-medium: 0 2px 8px rgba(0,0,0,0.08);
}

/* Apply extracted tokens */
.hero {
  background: var(--color-background);
  padding: calc(var(--space-unit) * 10) var(--space-unit);
  font-family: var(--font-heading);
}

.cta-button {
  background: var(--color-primary);
  padding: 12px 24px;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-medium);
  font-family: var(--font-heading);
  font-weight: 600;
}
```

---

## Notes

- This skill is **project-specific** (generated from user's design reference)
- Saved to: `.claude/skills/frontend-design.md`
- Used by: web-developer agent in Market Validation System
- Combines: Official Claude frontend-design framework + Extracted design tokens
- Updates: Regenerate if design reference changes
