---
name: SEO Optimization Patterns
description: Apply on-page SEO best practices for search visibility and rankings
triggers:
  - task_mentions: "seo|search engine optimization|meta tags|keywords"
  - file_contains: "landing-page|<meta"
---

# SEO Optimization Patterns

Apply proven on-page SEO techniques to improve search visibility, rankings, and organic traffic.

## 1. On-Page SEO Checklist

### Meta Tags Optimization

**Title Tag** (`<title>`):
```html
<title>Invoice Automation for Freelancers - InvoiceSnap</title>
```

**Requirements**:
- Length: 50-60 characters (longer gets truncated in search results)
- Include primary keyword ("invoice automation")
- Include brand name
- Benefit-driven (not generic)

**Formula**:
```
[Primary Keyword] for [Target Audience] - [Brand]
```

**Examples**:
```
✅ "Invoicing Software for Freelancers - Fast & Simple | InvoiceSnap"
✅ "SEO Tools for Small Businesses - Affordable & Effective"
❌ "Welcome to InvoiceSnap - Home Page" (generic, waste of space)
❌ "InvoiceSnap | Invoicing | Billing | Accounting | Time Tracking" (keyword stuffing)
```

**Meta Description** (`<meta name="description">`):
```html
<meta name="description" content="Create professional invoices in 60 seconds. InvoiceSnap automates invoicing for freelancers. No accounting knowledge required. Start free trial.">
```

**Requirements**:
- Length: 150-160 characters (longer gets truncated)
- Include primary + secondary keywords
- Include call-to-action
- Compelling (this shows in search results)

**Formula**:
```
[Main benefit]. [How it works]. [Unique advantage]. [CTA].
```

**Examples**:
```
✅ "Automate invoicing in 60 seconds. For freelancers who hate accounting. €5/month, no setup. Start free trial today."

❌ "InvoiceSnap is a software tool for creating and managing invoices for freelancers and small businesses." (boring, no CTA)
```

### Heading Hierarchy (H1-H6)

**Structure**:
```html
<h1>Main Page Topic (One H1 Only)</h1>

<h2>Major Section</h2>
<h3>Subsection</h3>
<h4>Detail</h4>

<h2>Another Major Section</h2>
<h3>Subsection</h3>
```

**Rules**:
- ✅ One H1 per page (primary keyword)
- ✅ Multiple H2s (section keywords)
- ✅ Logical hierarchy (don't skip levels)
- ❌ Don't use headings for styling (use CSS)

**Example** (Invoice landing page):
```html
<h1>Automated Invoicing for Freelance Creatives</h1>

<h2>Features That Save Time</h2>
<h3>One-Click Invoice Generation</h3>
<h3>Automatic Payment Reminders</h3>

<h2>Pricing</h2>
<h3>Simple, Transparent Pricing</h3>

<h2>What Customers Say</h2>
```

### Alt Text for Images

**Purpose**:
- Accessibility (screen readers)
- SEO (Google indexes alt text)
- Fallback (if image doesn't load)

**Formula**:
```
alt="[What's in image] + [context if not obvious]"
```

**Examples**:
```html
✅ <img src="hero.jpg" alt="Freelance designer creating invoice on laptop in 60 seconds">
✅ <img src="feature.jpg" alt="InvoiceSnap dashboard showing one-click invoice generation">
❌ <img src="img1.jpg" alt="Image"> (useless)
❌ <img src="hero.jpg" alt=""> (missing)
```

**Keyword Integration**:
```
Natural: "Screenshot of invoice automation software dashboard"
Stuffing: "invoice invoicing automation software tool freelancer" (bad!)
```

### Schema Markup (Structured Data)

**JSON-LD Format** (Google recommended):
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "InvoiceSnap",
  "applicationCategory": "BusinessApplication",
  "offers": {
    "@type": "Offer",
    "price": "5.00",
    "priceCurrency": "EUR"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.9",
    "ratingCount": "200"
  }
}
</script>
```

**Benefits**:
- Rich snippets in search results (star ratings, price)
- Higher click-through rate from search
- Better understanding for Google

**Types for Landing Pages**:
- **Product**: For products/services
- **Organization**: For company info
- **FAQ**: For FAQ sections
- **BreadcrumbList**: For navigation

## 2. Keyword Research Process

### Keyword Research Tools

**Free Tools**:
- **Google Keyword Planner**: Search volume, competition
- **Google Search Console**: What you already rank for
- **Google Autocomplete**: "invoice..." → suggestions
- **Answer the Public**: Question-based keywords
- **Ubersuggest**: Limited free searches

**Paid Tools** (optional):
- **Ahrefs**: Comprehensive keyword data
- **SEMrush**: Competitor keyword analysis
- **Moz**: Keyword difficulty scores

### Search Intent Identification

**Four Types of Intent**:

1. **Informational**: Learning, research
   - Example: "how to create an invoice"
   - Target: Blog content, guides

2. **Navigational**: Looking for specific site
   - Example: "freshbooks login"
   - Target: Brand keywords

3. **Commercial**: Comparing options
   - Example: "best invoicing software for freelancers"
   - Target: Comparison pages, reviews

4. **Transactional**: Ready to buy
   - Example: "invoice software free trial"
   - Target: Landing pages, pricing pages

**Match Content to Intent**:
```
Landing page keyword: "invoice automation software" (commercial/transactional)
NOT: "what is invoicing" (informational - wrong intent)
```

### Long-Tail Keyword Targeting

**Short-Tail** (1-2 words):
- Example: "invoice software"
- Volume: High (10,000 searches/month)
- Competition: High (impossible to rank)
- Conversion: Low (vague intent)

**Long-Tail** (3-5+ words):
- Example: "simple invoice software for freelance designers"
- Volume: Medium (500 searches/month)
- Competition: Low (easier to rank)
- Conversion: High (specific intent)

**Strategy**: Target 5-10 long-tail keywords instead of 1 short-tail

**Examples** (Invoice automation):
```
✅ "invoice automation for freelancers"
✅ "simple invoicing software creatives"
✅ "invoice generator from time tracking"
✅ "invoicing tool without accounting knowledge"
✅ "cheap invoice software for designers"
```

### Keyword Difficulty Assessment

**Difficulty Indicators**:
- **Low** (<30): Small blogs, forums in top 10
- **Medium** (30-60): Established sites, some authority
- **High** (60-80): Major brands, high domain authority
- **Very High** (80+): Wikipedia, major corporations

**Strategy for New Sites**:
```
Focus on: Low difficulty (< 30)
Avoid: High difficulty (> 60)

Example:
"invoice software" - Difficulty: 85 (avoid)
"invoice automation for photographers" - Difficulty: 25 (target)
```

## 3. Meta Tag Optimization

### Title Tag Best Practices

**Length Guidelines**:
- Desktop: ~60 characters
- Mobile: ~50 characters (less space)
- Truncated: "..." appears if too long

**Keyword Placement**:
```
✅ Front-Load: "Invoice Automation for Freelancers | InvoiceSnap"
❌ Back-Load: "InvoiceSnap | The Best Invoicing Automation Software for Freelancers"
→ Important keywords at start (in case of truncation)
```

**Brand Inclusion**:
```
Known Brand: "Brand | Keyword" (brand recognition)
Unknown Brand: "Keyword - Brand" (keyword first)

Example:
Apple: "iPad Pro - Apple" (brand known)
Startup: "Invoice Automation - InvoiceSnap" (keyword first)
```

### Meta Description Best Practices

**Persuasive Description**:
```
Formula: [Benefit] + [How] + [Social Proof] + [CTA]

Example:
"Create invoices in 60 seconds with InvoiceSnap. Automated invoicing for freelancers. Trusted by 5,000+ creatives. Start free trial today."
```

**Include Keywords** (bolded in search results):
```
Searcher types: "invoice automation freelancers"
Your description includes: "...automated invoicing for freelancers..."
→ "freelancers" appears bold in results
→ Higher click-through rate
```

**Call-to-Action**:
```
✅ "Start free trial", "Get instant access", "Try risk-free"
❌ No CTA (missed opportunity)
```

### Open Graph Tags (Social Sharing)

**Essential OG Tags**:
```html
<meta property="og:title" content="From Timesheet to Invoice in 60 Seconds">
<meta property="og:description" content="Automated invoicing for freelancers who hate accounting. €5/month, no setup required.">
<meta property="og:image" content="https://invoicesnap.com/og-image.jpg">
<meta property="og:url" content="https://invoicesnap.com">
<meta property="og:type" content="website">
```

**OG Image Specs**:
- Size: 1200 × 630 px (Facebook recommended)
- Format: JPG or PNG
- File size: <1MB
- Include: Product screenshot + value prop text

**Twitter Cards**:
```html
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Invoice in 60 Seconds - InvoiceSnap">
<meta name="twitter:description" content="Automated invoicing for freelancers. €5/month.">
<meta name="twitter:image" content="https://invoicesnap.com/twitter-image.jpg">
```

## 4. Technical SEO Basics

### Responsive Design (Mobile-First Indexing)

**Viewport Meta Tag** (required):
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

**Mobile-Friendly Test**:
- Google Search Console → Mobile Usability
- Or: Google Mobile-Friendly Test tool

**Common Issues**:
❌ Text too small (< 16px)
❌ Tap targets too close (< 44px)
❌ Content wider than screen
❌ Horizontal scrolling required

### Page Speed Optimization

**Core Web Vitals** (Google ranking factors):

1. **LCP (Largest Contentful Paint)**: <2.5 seconds
   - Measures: When main content loads
   - Optimize: Compress hero image, use CDN

2. **FID (First Input Delay)**: <100 milliseconds
   - Measures: Time until page is interactive
   - Optimize: Minimize JavaScript, defer non-critical scripts

3. **CLS (Cumulative Layout Shift)**: <0.1
   - Measures: Visual stability (elements don't jump)
   - Optimize: Set image dimensions, avoid inserting content

**Testing Tool**: Google PageSpeed Insights

**Quick Optimizations**:
```html
<!-- Compress images -->
<img src="hero.webp" width="800" height="600" loading="lazy">

<!-- Defer JavaScript -->
<script src="script.js" defer></script>

<!-- Inline critical CSS -->
<style>
  /* Critical above-fold styles here */
</style>

<!-- Lazy load below-fold resources -->
<link rel="stylesheet" href="non-critical.css" media="print" onload="this.media='all'">
```

### Semantic HTML

**Use Semantic Elements**:
```html
✅ Semantic:
<header>
  <nav>...</nav>
</header>
<main>
  <article>...</article>
</main>
<footer>...</footer>

❌ Non-Semantic:
<div class="header">
  <div class="nav">...</div>
</div>
<div class="content">
  <div class="post">...</div>
</div>
```

**Benefits**:
- Better accessibility (screen readers)
- Better SEO (Google understands content structure)
- Cleaner code

### Clean URL Structure

**URL Best Practices**:
```
✅ "invoicesnap.com/features"
✅ "invoicesnap.com/pricing"
✅ "invoicesnap.com/invoice-automation-for-freelancers"

❌ "invoicesnap.com/page?id=123&ref=home"
❌ "invoicesnap.com/INDEX.HTML"
❌ "invoicesnap.com/this_is_a_really_long_url_with_many_words"
```

**Rules**:
- Lowercase only
- Hyphens (not underscores) for word separation
- Descriptive (not generic IDs)
- Short (< 60 characters)
- Include keyword if natural

## 5. Content Optimization

### Keyword Density

**Natural Integration**:
```
Keyword: "invoice automation"
Target Density: 1-2% of content

Example (100 words):
Mention "invoice automation" 1-2 times naturally
Mention variations 2-3 times:
- "automated invoicing"
- "invoice generation"
- "invoicing tool"

Total keyword presence: ~5% (including variations)
```

**Keyword Stuffing** (avoid):
```
❌ "Invoice automation software for invoice automation and automated invoicing.
    Our invoice automation tool provides the best invoice automation."
→ Penalty from Google, reads terribly
```

**Natural Integration**:
```
✅ "InvoiceSnap automates your invoicing workflow.
    Create professional invoices in 60 seconds from time tracking.
    The simplest invoicing tool for freelancers."
→ Keywords present but reads naturally
```

### Readability Optimization

**Flesch Reading Ease Score**:
```
90-100: Very Easy (5th grade)
60-70: Easy (8th-9th grade) ← Target for most content
30-50: Difficult (college level)
0-30: Very Difficult (professional)
```

**Readability Tips**:
- Short sentences (< 20 words average)
- Short paragraphs (2-4 sentences)
- Simple words (use "use" not "utilize")
- Active voice ("We create" not "Invoices are created")
- Transition words (However, Therefore, Additionally)

**Example Comparison**:
```
❌ Difficult:
"The utilization of our sophisticated invoice generation mechanism facilitates the expeditious creation of professional billing documentation."

✅ Easy:
"Create professional invoices quickly with our simple tool."
```

### Internal Linking Strategy

**Best Practices**:
- Link to related pages (3-5 internal links per page)
- Use descriptive anchor text (not "click here")
- Link from high-authority pages to new pages
- Create logical site structure

**Example**:
```html
✅ <a href="/pricing">See pricing plans</a>
✅ <a href="/features">Explore invoice automation features</a>

❌ <a href="/pricing">click here</a>
❌ <a href="/page2">page 2</a>
```

**Site Structure**:
```
Homepage
  ├── Features
  ├── Pricing
  ├── Blog
  │   ├── How to Invoice Clients
  │   └── Invoicing Best Practices
  └── About
```

### Content-Length Guidelines

**Landing Pages**: 500-1,000 words
- Enough for SEO (Google prefers >300 words)
- Not too long (users won't read 3,000 words)
- Focus on scannable content (bullets, headings)

**Blog Posts**: 1,000-2,000 words
- Comprehensive coverage
- Better ranking potential
- More keyword opportunities

**Minimum Viable**: 300 words
- Below 300 words = "thin content" (Google penalty risk)

## Application Checklist

When optimizing a landing page for SEO:

**Meta Tags**:
- [ ] Title tag: 50-60 chars, keyword-rich, benefit-driven
- [ ] Meta description: 150-160 chars, includes CTA
- [ ] OG tags: title, description, image (1200×630px)
- [ ] Twitter Card tags
- [ ] Favicon present

**Content**:
- [ ] H1 heading with primary keyword
- [ ] 3-5 H2 headings with related keywords
- [ ] 500-1,000 words total
- [ ] Keyword density 1-2% (natural)
- [ ] Readability score 60-70 (easy)
- [ ] No keyword stuffing

**Technical**:
- [ ] Responsive (viewport meta tag)
- [ ] Page speed <3 sec (PageSpeed Insights)
- [ ] Semantic HTML (header, main, article, footer)
- [ ] Alt text on all images
- [ ] Clean URL structure
- [ ] HTTPS (SSL certificate)

**Images**:
- [ ] Compressed (<500KB each)
- [ ] WebP format (or optimized JPG)
- [ ] Width/height attributes set
- [ ] Loading="lazy" for below-fold images
- [ ] Descriptive alt text with keywords

**Schema Markup** (optional but recommended):
- [ ] Product/Service schema
- [ ] Organization schema
- [ ] FAQ schema (if FAQ section)

## Common SEO Mistakes to Avoid

❌ **Keyword Stuffing**: "Invoice invoice invoicing invoice tool"
✅ **Natural Integration**: "Create invoices quickly with our simple invoicing tool"

❌ **Duplicate Title Tags**: Same title on all pages
✅ **Unique Titles**: Each page has specific, unique title

❌ **Missing H1**: No main heading
✅ **Clear H1**: One H1 per page with primary keyword

❌ **Broken Images**: Images without alt text
✅ **Accessible Images**: All images have descriptive alt text

❌ **Slow Loading**: 5+ second load time
✅ **Fast Loading**: <3 seconds on mobile

❌ **Non-Responsive**: Desktop-only design
✅ **Mobile-First**: Works great on all devices

❌ **Thin Content**: 100 words only
✅ **Sufficient Content**: 500+ words with value

## Example: Complete SEO Implementation

**Landing Page** (Invoice Automation):

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Primary Meta Tags -->
  <title>Invoice Automation for Freelancers - Simple & Fast | InvoiceSnap</title>
  <meta name="description" content="Create professional invoices in 60 seconds. InvoiceSnap automates invoicing for freelancers. No accounting knowledge required. €5/month. Start free trial.">

  <!-- Open Graph Tags -->
  <meta property="og:type" content="website">
  <meta property="og:title" content="From Timesheet to Invoice in 60 Seconds">
  <meta property="og:description" content="Automated invoicing for freelancers who hate accounting. €5/month, no setup.">
  <meta property="og:image" content="https://invoicesnap.com/og-image.jpg">
  <meta property="og:url" content="https://invoicesnap.com">

  <!-- Twitter Card Tags -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Invoice in 60 Seconds - InvoiceSnap">
  <meta name="twitter:description" content="Automated invoicing for freelancers. €5/month.">
  <meta name="twitter:image" content="https://invoicesnap.com/twitter-image.jpg">

  <!-- Schema Markup -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    "name": "InvoiceSnap",
    "applicationCategory": "BusinessApplication",
    "offers": {
      "@type": "Offer",
      "price": "5.00",
      "priceCurrency": "EUR"
    }
  }
  </script>

  <style>
    /* Critical CSS inline */
  </style>
</head>
<body>
  <header>
    <nav><!-- Navigation --></nav>
  </header>

  <main>
    <article>
      <h1>Automated Invoicing for Freelance Creatives</h1>

      <p>Stop wasting 2 hours every week on manual invoicing. InvoiceSnap generates professional invoices in 60 seconds from your time tracking.</p>

      <img src="hero.webp"
           alt="Freelance designer creating invoice in InvoiceSnap dashboard"
           width="800"
           height="600"
           loading="lazy">

      <section>
        <h2>Features That Save Time</h2>

        <h3>One-Click Invoice Generation</h3>
        <p>Turn your timesheet into a professional invoice instantly. No manual data entry, no calculations, no errors.</p>

        <h3>Automatic Payment Reminders</h3>
        <p>Never chase clients again. InvoiceSnap sends reminders automatically before due dates.</p>
      </section>

      <section>
        <h2>Simple Pricing for Freelancers</h2>
        <p>€5 per month for unlimited invoices. That's less than one hour of billable time.</p>
      </section>
    </article>
  </main>

  <footer>
    <a href="/privacy">Privacy Policy</a>
    <a href="/terms">Terms of Service</a>
  </footer>

  <!-- Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXX"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-XXXXXX');
  </script>
</body>
</html>
```

**SEO Checklist for This Page**:
- ✅ Title tag: 58 chars, keyword-rich ("Invoice Automation for Freelancers")
- ✅ Meta description: 156 chars, includes CTA
- ✅ H1: Primary keyword ("Automated Invoicing for Freelance Creatives")
- ✅ H2-H3: Related keywords (Features, Pricing)
- ✅ Alt text: Descriptive with keywords
- ✅ OG tags: Complete (title, description, image)
- ✅ Schema: SoftwareApplication type
- ✅ Responsive: Viewport meta tag
- ✅ Semantic HTML: header, main, article, footer
- ✅ Content: ~500 words, keyword-optimized

**Expected Results**:
- Ranks for "invoice automation for freelancers" (long-tail)
- Ranks for "simple invoicing software creatives" (long-tail)
- Rich snippet in search results (price from schema)
- High CTR from search (compelling title/description)

---

**Use this skill when**: Optimizing landing pages for SEO, conducting keyword research, or implementing technical SEO best practices.
