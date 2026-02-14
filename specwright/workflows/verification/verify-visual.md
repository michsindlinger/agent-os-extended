---
description: Verify UI implementation matches visual designs
globs:
alwaysApply: false
version: 2.0
encoding: UTF-8
---

# Verify Visual Implementation

Compare implemented UI with mockups and design specifications.

## Purpose

For UI features, verify that the implementation matches the design by comparing:
- Layout structure and positioning
- Colors, typography, spacing
- Component variants and states
- Interactive behavior
- Responsive design

## When to Run

Run this verification after implementing UI tasks, when mockups were provided in the spec.

**Workflow Integration:**
```
implement UI → [VERIFY VISUAL] → mark complete
```

**Only run if:**
- Feature includes UI components
- Mockups or design specs were provided
- Application is runnable locally

## Prerequisites

### Required Setup

1. **Application Running**: Dev server must be running
   ```bash
   # Examples
   npm run dev          # Vite/React
   ng serve             # Angular
   mvn spring-boot:run  # Spring Boot
   ```

2. **Mockups Available**:
   ```
   specwright/specs/YYYY-MM-DD-feature-name/mockups/
   ```

3. **Optional: Playwright MCP**: For automated screenshot comparison
   - If available: Automated visual testing
   - If not: Manual comparison with guidance

## Verification Process

### Step 1: Load Mockups

Load the design mockups from the spec:

```markdown
Loading mockups for comparison:
- specwright/specs/2025-12-22-invoice-export/mockups/export-button.png
- specwright/specs/2025-12-22-invoice-export/mockups/export-modal.png
```

### Step 2: Access Implemented UI

**Manual Approach:**
```markdown
Please open your browser to view the implementation:
URL: http://localhost:3000/invoices/1

I'll guide you through the comparison checklist.
```

**Automated Approach (with Playwright MCP):**
```typescript
// If Playwright MCP available
use MCP to:
  1. Navigate to http://localhost:3000/invoices/1
  2. Take screenshot: actual-invoice-page.png
  3. Store in specwright/specs/.../screenshots/
```

### Step 3: Visual Comparison

Compare mockup vs implementation across categories:

#### A. Layout Structure ✓

**Checklist:**
- [ ] **Grid/Flexbox**: Layout structure matches mockup
- [ ] **Positioning**: Components in correct locations
- [ ] **Alignment**: Elements properly aligned
- [ ] **Spacing**: Padding and margins match design
- [ ] **Sizing**: Component dimensions appropriate

**Example:**
```markdown
Mockup: Export button in top-right of invoice header
Implementation: ✓ Button correctly positioned top-right

Mockup: Modal centered with 600px width
Implementation: ⚠ Modal is 500px width (should be 600px)
```

#### B. Colors & Typography ✓

**Checklist:**
- [ ] **Colors**: Match design tokens
  - Primary colors (buttons, links)
  - Background colors
  - Text colors
  - Border colors
- [ ] **Typography**: Font family, sizes, weights match
- [ ] **Contrast**: Text readable on backgrounds (WCAG AA minimum)

**Design Token Comparison:**
```markdown
Design Tokens from Mockup:
- Primary: #3B82F6 (blue-500)
- Background: #FFFFFF
- Text: #1F2937 (gray-900)
- Font: Inter, 16px base

Implementation:
✓ Primary button: bg-blue-500 (#3B82F6) - MATCH
⚠ Body text: #374151 (gray-700) - MISMATCH (should be gray-900)
✓ Font family: Inter - MATCH
✓ Font size: 16px - MATCH
```

#### C. Components & Variants ✓

**Checklist:**
- [ ] **Button Variants**: All button types match (primary, secondary, danger)
- [ ] **Form Inputs**: Input styling matches mockup
- [ ] **Icons**: Correct icons used (size, color)
- [ ] **Badges/Tags**: Styling matches
- [ ] **Cards/Containers**: Border, shadow, radius match

**Example:**
```markdown
Mockup shows:
- Primary button: Blue background, white text, 8px radius
- Secondary button: Gray background, dark text, 8px radius

Implementation:
✓ Primary button matches
⚠ Secondary button has 4px radius (should be 8px)
```

#### D. Interactive States ✓

**Checklist:**
- [ ] **Default State**: Correct initial appearance
- [ ] **Hover State**: Hover effects present
- [ ] **Focus State**: Focus indicators visible (accessibility)
- [ ] **Loading State**: Loading spinner/skeleton shown
- [ ] **Error State**: Error message displayed correctly
- [ ] **Success State**: Success feedback shown
- [ ] **Disabled State**: Disabled appearance correct
- [ ] **Empty State**: Empty state shown when no data

**Example:**
```markdown
Button States:
✓ Default: Blue background
✓ Hover: Darker blue
⚠ Focus: No focus ring (accessibility issue!)
✓ Loading: Spinner shown, button disabled
✓ Disabled: Gray, cursor not-allowed

Modal States:
✓ Open animation: Fade in
⚠ Close animation: None (should fade out)
```

#### E. Responsive Behavior ✓

**Checklist:**
- [ ] **Desktop (>1024px)**: Layout as designed
- [ ] **Tablet (768-1024px)**: Appropriate adjustments
- [ ] **Mobile (<768px)**: Mobile-friendly layout
- [ ] **Breakpoints**: Match design specifications

**Example:**
```markdown
Responsive Verification:

Desktop (1920x1080):
✓ 3-column layout
✓ Sidebar visible

Tablet (768x1024):
✓ 2-column layout
✓ Sidebar collapsible

Mobile (375x667):
⚠ Single column layout (correct)
⚠ Export button full-width (design shows compact button)
```

#### F. Accessibility ✓

**Checklist:**
- [ ] **Keyboard Navigation**: All interactive elements keyboard accessible
- [ ] **Focus Indicators**: Visible focus states
- [ ] **ARIA Labels**: Screen reader support
- [ ] **Color Contrast**: WCAG AA compliant (4.5:1 for text)
- [ ] **Alt Text**: Images have descriptive alt text

**Tools:**
```bash
# Check contrast ratios
# Check with browser DevTools Lighthouse
# Test keyboard navigation manually
```

## Verification Report

**File**: `specwright/specs/YYYY-MM-DD-feature-name/visual-verification-report.md`

```markdown
# Visual Implementation Verification

**Feature**: Invoice Export UI
**Date**: [Date]
**Mockups**: mockups/export-button.png, mockups/export-modal.png
**Implementation URL**: http://localhost:3000/invoices/1

## Comparison Results

### Layout Structure (5/5) ✅
- [x] Grid structure matches
- [x] Component positioning correct
- [x] Alignment proper
- [x] Spacing matches
- [x] Sizing appropriate

### Colors & Typography (4/5) ⚠
- [x] Primary colors match
- [ ] Text color mismatch (gray-700 vs gray-900)
- [x] Font family matches
- [x] Font sizes match
- [x] Font weights match

### Components (7/8) ⚠
- [x] Primary button matches
- [ ] Secondary button radius mismatch
- [x] Icons correct
- [x] Modal structure matches
- [x] Form inputs match
- [x] Badges match
- [x] Cards match
- [x] Dropdowns match

### Interactive States (7/8) ⚠
- [x] Default state
- [x] Hover state
- [ ] Focus state missing ring
- [x] Loading state
- [x] Error state
- [x] Success state
- [x] Disabled state
- [x] Empty state

### Responsive Design (5/6) ⚠
- [x] Desktop layout correct
- [x] Tablet layout correct
- [ ] Mobile button should be compact, not full-width
- [x] Breakpoints match
- [x] Images responsive
- [x] Text reflows properly

### Accessibility (4/5) ⚠
- [x] Keyboard navigation works
- [ ] Focus indicators weak
- [x] ARIA labels present
- [x] Color contrast sufficient
- [x] Alt text on images

## Issues Summary

**Critical** (Must fix):
- None

**Important** (Should fix):
- Focus indicators not visible enough (accessibility)
- Text color mismatch (gray-700 vs gray-900)

**Minor** (Nice to fix):
- Secondary button radius (4px vs 8px)
- Mobile button sizing

## Screenshots

**Mockup**:
![Mockup](../mockups/export-button.png)

**Implementation**:
![Actual](../screenshots/actual-export-button.png)

## Overall Score

**Visual Accuracy**: 85% (32/38 checks)
**Status**: PASS WITH WARNINGS

**Recommendation**: Fix focus indicators and text color, then ready for review

## Sign-off

Visual implementation verified: [APPROVED / NEEDS REVISION]
```

## Playwright MCP Integration (Optional)

If Playwright MCP is available, automate screenshots:

```javascript
// Pseudocode for MCP usage
await playwright.goto('http://localhost:3000/invoices/1');
await playwright.screenshot('actual-invoice.png');

// Compare with mockup
const similarity = await compareImages(
  'mockups/invoice-page.png',
  'actual-invoice.png'
);

if (similarity < 0.95) {
  highlightDifferences();
}
```

## Manual Verification Guide

Without automation, provide checklist for user:

```markdown
Please verify the following while viewing http://localhost:3000/invoices/1:

Layout:
□ Export button in top-right corner?
□ Modal centered on screen?
□ Dropdown opens below button?

Colors (compared to mockup):
□ Button background: Blue (#3B82F6)?
□ Text color: Dark gray (#1F2937)?

Interactions:
□ Button hover changes to darker blue?
□ Click opens dropdown?
□ Selecting format shows loading indicator?
□ Success shows green toast notification?

Responsive:
□ On mobile, button is appropriately sized?
□ Modal is full-width on mobile?

Please respond: [All good ✓] or [Issues found: list them]
```

## Configuration

Enable visual verification in `specwright/config.yml`:

```yaml
verification:
  visual_verification: true
```

## When to Skip

Skip visual verification if:
- Feature is backend-only (no UI)
- No mockups were provided
- Application not runnable locally
- Prototype/POC where visual accuracy doesn't matter

## Best Practices

1. **Compare Side-by-Side** - Open mockup and implementation together
2. **Test All States** - Default, hover, loading, error, success
3. **Check All Breakpoints** - Desktop, tablet, mobile
4. **Use Design Tokens** - Compare extracted colors/fonts from mockup
5. **Document Deviations** - Explain why differences exist if intentional
6. **Get Designer Approval** - For significant UI features, designer should review

## Benefits

- Ensures design implementation fidelity
- Catches visual bugs early
- Validates responsive behavior
- Confirms accessibility features
- Documents design compliance
