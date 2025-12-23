---
description: Collect and analyze visual assets for feature specifications
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Visual Asset Collection

Collect mockups, wireframes, and screenshots to inform feature development.

## Purpose

Visual assets provide concrete reference points for:
- UI design and layout
- User interaction flows
- Component composition
- Visual states (loading, error, success)
- Responsive behavior

## Asset Types

### 1. Mockups (High-Fidelity)

**What**: Detailed visual designs showing final look
**When**: For new UI features or major redesigns
**Format**: PNG, JPG, Figma links

**Store in**: `agent-os/specs/YYYY-MM-DD-feature-name/mockups/`

**Example naming:**
- `desktop-main-view.png`
- `mobile-checkout-flow.png`
- `modal-confirmation-dialog.png`

### 2. Wireframes (Low-Fidelity)

**What**: Simple sketches showing structure and layout
**When**: Early planning, structural decisions
**Format**: PNG, JPG, hand-drawn photos

**Store in**: `agent-os/specs/YYYY-MM-DD-feature-name/wireframes/`

**Example naming:**
- `wireframe-user-profile.png`
- `wireframe-settings-page.png`

### 3. Screenshots (Existing UI)

**What**: Current state of the application
**When**: For context, showing what exists
**Format**: PNG, JPG

**Store in**: `agent-os/specs/YYYY-MM-DD-feature-name/screenshots/`

**Example naming:**
- `current-dashboard.png`
- `existing-user-list.png`

### 4. Design System References

**What**: Component library screenshots or links
**When**: To ensure consistency with existing design
**Format**: PNG, JPG, URLs

**Store in**: `agent-os/specs/YYYY-MM-DD-feature-name/design-system/`

## Collection Process

### Step 1: Ask for Visual Assets

```markdown
Do you have any visual designs for this feature?

Please provide:
- [ ] Mockups (high-fidelity designs)
- [ ] Wireframes (low-fidelity sketches)
- [ ] Screenshots of similar existing features
- [ ] Design system references
- [ ] Figma/Sketch links

You can:
1. Provide file paths to existing assets
2. Provide URLs to design tools (Figma, Sketch, etc.)
3. Describe the visual design (I'll create a text-based description)
```

### Step 2: Process Provided Assets

**For file paths:**
```bash
# Copy to spec directory
cp /path/to/mockup.png agent-os/specs/YYYY-MM-DD-feature-name/mockups/
```

**For URLs:**
```markdown
# Store reference in research notes
Design Assets:
- Figma: https://figma.com/file/abc123
- Mockup: https://example.com/mockup.png
```

**For descriptions:**
```markdown
# Document description
Visual Description:
- Main view: Dashboard with 3-column layout
- Left sidebar: Navigation menu
- Center: Data table with filters
- Right sidebar: Activity feed
```

### Step 3: Analyze Visual Assets

For each asset, extract:

**Layout Information:**
- Grid structure (columns, rows)
- Component placement
- Spacing and alignment
- Responsive breakpoints

**Components Identified:**
- Buttons (style, variants)
- Forms (fields, validation display)
- Tables/Lists (headers, rows, pagination)
- Modals/Dialogs
- Navigation elements

**Visual States:**
- Default state
- Loading state
- Error state
- Success state
- Empty state

**Interactions:**
- Click targets
- Hover effects
- Focus states
- Animations/transitions

### Step 4: Document in Research Notes

```markdown
## Visual Asset Analysis

### Mockup: Main Dashboard View

**File**: `mockups/dashboard-main.png`

**Layout:**
- 3-column grid layout
- Header: Fixed navigation bar (60px height)
- Sidebar: 250px wide, collapsible
- Main content: Fluid width, max 1200px
- Footer: 40px height

**Components:**
- **Header**:
  - Logo (top-left)
  - Search bar (center)
  - User menu (top-right)

- **Sidebar**:
  - Navigation menu items
  - Active state: Blue highlight
  - Icons: Lucide icon set

- **Main Content**:
  - Page title (H1, 32px)
  - Action buttons (top-right)
  - Data table with 5 columns
  - Pagination (bottom)

**Design Tokens:**
- Primary color: #3B82F6 (blue-500)
- Success color: #10B981 (green-500)
- Error color: #EF4444 (red-500)
- Font: Inter (from Google Fonts)
- Border radius: 8px
- Spacing scale: 4px base (Tailwind default)

**States Shown:**
- Default view with data
- Empty state: "No data available" message with illustration
- Loading state: Skeleton loaders

**Responsive Behavior:**
- Desktop (>1024px): 3-column layout
- Tablet (768px-1024px): 2-column (sidebar collapsible)
- Mobile (<768px): Single column, sidebar as drawer
```

## Visual Verification Support

For later use in verification phase, document:

**Comparison Points:**
- Layout matches mockup
- Colors match design tokens
- Typography matches (font, sizes, weights)
- Spacing matches (padding, margins)
- Component variants match (button styles, etc.)
- States implemented (loading, error, empty)
- Responsive breakpoints match

## Best Practices

1. **Organize by view** - Separate mockups for different screens
2. **Name descriptively** - Include context in filename
3. **Include annotations** - Note important details
4. **Version mockups** - If design changes, keep history
5. **Link to design system** - Reference component library if used

## Checklist

For each visual asset:
- [ ] Asset stored in appropriate subdirectory
- [ ] Filename is descriptive and consistent
- [ ] Analysis documented in research notes
- [ ] Key components identified
- [ ] Layout structure documented
- [ ] Design tokens extracted (colors, fonts, spacing)
- [ ] Interactive states identified
- [ ] Responsive behavior noted
- [ ] Reference to existing components noted
