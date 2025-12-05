---
description: Gift Book & Low-Content Book Planning for Amazon KDP
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Gift Book Planning Rules

## Overview

Generate comprehensive planning docs for gift books, fill-in books, activity books, and other low-content books intended for Amazon KDP and other digital distribution platforms. Optimized for seasonal/occasion-based products where buyer ≠ user.

<pre_flight_check>
  EXECUTE: @~/.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="gather_book_details">

### Step 1: Gather Book Details

Collect all required information from the user about the gift book product:

<required_inputs>
  1. Book title and subtitle
  2. Book type (fill-in book, activity book, coloring book, journal, planner, coupon book, etc.)
  3. Target recipient (who receives the book as gift)
  4. Target buyer (who purchases the book)
  5. Primary gift occasion(s) (Mother's Day, Christmas, Birthday, etc.)
  6. Age range of users (if applicable)
  7. Book content overview (sections, activities, prompts)
  8. Current status (idea, in progress, completed, already published)
</required_inputs>

<error_template>
  Please provide the following information about your gift book:
  1. Book title and subtitle
  2. Book type (e.g., fill-in book, activity book, coloring book)
  3. Who receives the book as a gift? (e.g., Mom, Dad, Grandma)
  4. Who buys the book? (e.g., children, spouse, grandchildren)
  5. Primary gift occasion(s) (e.g., Mother's Day, Birthday, Christmas)
  6. Age range of users (if applicable)
  7. Brief description of book content
  8. Current status: idea / in progress / completed / published
</error_template>

</step>

<step number="2" subagent="file-creator" name="create_documentation_structure">

### Step 2: Create Documentation Structure

Create the following file structure for gift book planning:

<file_structure>
  .agent-os/
  └── product/
      ├── book-mission.md           # Book vision, value proposition
      ├── book-mission-lite.md      # Condensed mission for AI context
      ├── buyer-personas.md         # Who buys (NOT who uses)
      ├── market-analysis.md        # Competition, positioning, keywords
      ├── book-content.md           # Sections, pages, content outline
      ├── distribution-strategy.md  # KDP settings, pricing, platforms
      ├── seasonal-marketing.md     # Occasion-based marketing calendar
      ├── listing-optimization.md   # Title, description, keywords, A+
      └── decisions.md              # Decision log
</file_structure>

</step>

<step number="3" subagent="file-creator" name="create_book_mission_md">

### Step 3: Create book-mission.md

<file_template>
  <header>
    # Book Mission: [BOOK_TITLE]
  </header>
  <required_sections>
    - Book Overview
    - Value Proposition
    - Gift Occasion Fit
    - Emotional Appeal
    - Key Features
  </required_sections>
</file_template>

<section name="overview">
  <template>
    ## Book Overview

    **Title:** [BOOK_TITLE]
    **Subtitle:** [BOOK_SUBTITLE]
    **Type:** [BOOK_TYPE]
    **Format:** Paperback / Hardcover
    **Target Dimensions:** [SIZE] (e.g., 8.5" x 11", 6" x 9")
    **Page Count:** [ESTIMATED_PAGES]
  </template>
</section>

<section name="value_proposition">
  <template>
    ## Value Proposition

    ### The Gift Promise
    [BOOK_TITLE] is a [BOOK_TYPE] that allows [GIFT_GIVER] to create a [EMOTIONAL_OUTCOME] gift for [RECIPIENT] by [KEY_ACTIVITY].

    ### Why This Book?
    - **For the Buyer:** [BUYER_BENEFIT - e.g., easy, meaningful, affordable gift]
    - **For the Recipient:** [RECIPIENT_BENEFIT - e.g., personalized keepsake, emotional connection]
    - **For the User:** [USER_BENEFIT - if different from buyer, e.g., fun activity for child]
  </template>
</section>

<section name="occasion_fit">
  <template>
    ## Gift Occasion Fit

    ### Primary Occasions
    | Occasion | Peak Shopping Period | Relevance Score |
    |----------|---------------------|-----------------|
    | [OCCASION_1] | [DATE_RANGE] | High/Medium/Low |
    | [OCCASION_2] | [DATE_RANGE] | High/Medium/Low |

    ### Secondary Occasions
    - [OCCASION]: [WHY_IT_FITS]
  </template>
  <constraints>
    - primary_occasions: 1-3
    - include shopping lead time (2-4 weeks before occasion)
    - secondary_occasions: 2-5
  </constraints>
</section>

<section name="emotional_appeal">
  <template>
    ## Emotional Appeal

    ### Core Emotions
    - **Buyer feels:** [EMOTION - e.g., thoughtful, creative, loving]
    - **Recipient feels:** [EMOTION - e.g., appreciated, loved, special]
    - **During use:** [EMOTION - e.g., fun, bonding, nostalgic]

    ### Keepsake Value
    [DESCRIPTION of long-term emotional value and why recipient keeps it]
  </template>
</section>

<section name="features">
  <template>
    ## Key Features

    ### Content Sections
    - **[SECTION_NAME]:** [DESCRIPTION] ([PAGE_COUNT] pages)

    ### Design Elements
    - [ELEMENT]: [DESCRIPTION]

    ### Unique Selling Points
    1. [USP_1]
    2. [USP_2]
    3. [USP_3]
  </template>
  <constraints>
    - sections: 4-10
    - design_elements: 3-6
    - usps: 3-5
  </constraints>
</section>

</step>

<step number="4" subagent="file-creator" name="create_buyer_personas_md">

### Step 4: Create buyer-personas.md

<file_template>
  <header>
    # Buyer Personas

    > Important: For gift books, the BUYER is often different from the USER and RECIPIENT.
  </header>
</file_template>

<section name="roles">
  <template>
    ## Gift Transaction Roles

    | Role | Who | Age Range | Relationship |
    |------|-----|-----------|--------------|
    | **Buyer** | [WHO_PURCHASES] | [AGE] | [RELATION_TO_RECIPIENT] |
    | **User** | [WHO_FILLS_IN] | [AGE] | [RELATION_TO_RECIPIENT] |
    | **Recipient** | [WHO_RECEIVES] | [AGE] | - |
  </template>
</section>

<section name="buyer_persona">
  <template>
    ## Primary Buyer Persona

    **[PERSONA_NAME]** ([AGE_RANGE])

    ### Demographics
    - **Role:** [e.g., Parent buying for child to give to grandparent]
    - **Shopping Context:** [e.g., Amazon, last-minute, planning ahead]
    - **Budget Range:** [PRICE_RANGE]

    ### Motivations
    - [MOTIVATION_1 - e.g., wants meaningful gift from child]
    - [MOTIVATION_2 - e.g., avoids generic gifts]

    ### Pain Points
    - [PAIN_1 - e.g., hard to find age-appropriate activities]
    - [PAIN_2 - e.g., generic gifts feel impersonal]

    ### Decision Factors
    - [FACTOR_1 - e.g., preview pages look engaging]
    - [FACTOR_2 - e.g., good reviews from other parents]
    - [FACTOR_3 - e.g., arrives before occasion]

    ### Search Behavior
    - **Typical Search Terms:** "[SEARCH_1]", "[SEARCH_2]", "[SEARCH_3]"
    - **Browse Categories:** [CATEGORY_1], [CATEGORY_2]
  </template>
</section>

<section name="secondary_buyers">
  <template>
    ## Secondary Buyer Personas

    ### [PERSONA_NAME_2]
    - **Who:** [DESCRIPTION]
    - **When:** [OCCASION/CONTEXT]
    - **Search Terms:** "[SEARCH_1]", "[SEARCH_2]"
  </template>
  <constraints>
    - secondary_personas: 1-3
  </constraints>
</section>

</step>

<step number="5" subagent="file-creator" name="create_market_analysis_md">

### Step 5: Create market-analysis.md

<file_template>
  <header>
    # Market Analysis
  </header>
</file_template>

<section name="competition">
  <template>
    ## Competitive Analysis

    ### Direct Competitors (Same Niche)
    | Title | BSR | Price | Reviews | Strengths | Weaknesses |
    |-------|-----|-------|---------|-----------|------------|
    | [COMPETITOR_1] | [BSR] | [PRICE] | [COUNT] | [STRENGTH] | [WEAKNESS] |

    ### Indirect Competitors (Alternative Gifts)
    - [ALTERNATIVE_1]: [WHY_COMPETES]

    ### Market Saturation Assessment
    - **Search Volume:** [HIGH/MEDIUM/LOW]
    - **Competition Level:** [HIGH/MEDIUM/LOW]
    - **Opportunity Score:** [1-10]
  </template>
  <constraints>
    - direct_competitors: 3-5
    - indirect_competitors: 2-3
  </constraints>
</section>

<section name="positioning">
  <template>
    ## Positioning Strategy

    ### Differentiation
    Unlike [MAIN_COMPETITOR], our book offers:
    1. [DIFFERENTIATOR_1]
    2. [DIFFERENTIATOR_2]
    3. [DIFFERENTIATOR_3]

    ### Price Position
    - **Market Range:** $[MIN] - $[MAX]
    - **Our Price:** $[PRICE]
    - **Position:** Budget / Mid-range / Premium
    - **Rationale:** [WHY_THIS_PRICE]

    ### Niche Focus
    [DESCRIPTION of specific niche angle, e.g., "German-language Mother's Day fill-in books for children ages 4-10"]
  </template>
</section>

<section name="keywords">
  <template>
    ## Keyword Research

    ### Primary Keywords (High Intent)
    | Keyword | Est. Search Volume | Competition | Relevance |
    |---------|-------------------|-------------|-----------|
    | [KEYWORD_1] | [VOLUME] | [HIGH/MED/LOW] | [1-10] |

    ### Long-Tail Keywords
    - [LONG_TAIL_1]
    - [LONG_TAIL_2]

    ### Seasonal Keywords
    | Keyword | Peak Month(s) | Notes |
    |---------|--------------|-------|
    | [SEASONAL_KW_1] | [MONTH] | [NOTE] |

    ### Backend Keywords (7 slots)
    1. [KEYWORD_PHRASE_1]
    2. [KEYWORD_PHRASE_2]
    3. [KEYWORD_PHRASE_3]
    4. [KEYWORD_PHRASE_4]
    5. [KEYWORD_PHRASE_5]
    6. [KEYWORD_PHRASE_6]
    7. [KEYWORD_PHRASE_7]
  </template>
  <constraints>
    - primary_keywords: 5-10
    - long_tail: 5-10
    - seasonal: 3-5
    - backend: exactly 7 (max 50 chars each)
  </constraints>
</section>

</step>

<step number="6" subagent="file-creator" name="create_book_content_md">

### Step 6: Create book-content.md

<file_template>
  <header>
    # Book Content Outline
  </header>
</file_template>

<section name="structure">
  <template>
    ## Content Structure

    ### Page Breakdown
    | Section | Pages | Content Type | Description |
    |---------|-------|--------------|-------------|
    | Cover | 1 | Design | [COVER_DESCRIPTION] |
    | Title Page | 1 | Standard | Title, subtitle, "For: ___" |
    | [SECTION_1] | [X] | [TYPE] | [DESCRIPTION] |
    | [SECTION_2] | [X] | [TYPE] | [DESCRIPTION] |

    **Total Pages:** [TOTAL]
  </template>
</section>

<section name="content_types">
  <template>
    ## Content Types Used

    ### Fill-In Prompts
    - [ ] Open-ended prompts (e.g., "My favorite memory with mama is...")
    - [ ] Multiple choice (e.g., "Mama's superpower is: cooking / hugging / ...")
    - [ ] Rating scales (e.g., "How much I love mama: ♥♥♥♥♥")
    - [ ] Lists (e.g., "3 things mama does best")

    ### Visual Elements
    - [ ] Coloring pages
    - [ ] Illustration frames
    - [ ] Drawing prompts
    - [ ] Photo placeholders
    - [ ] Decorative borders

    ### Interactive Elements
    - [ ] Certificates/Awards
    - [ ] Coupons/Vouchers
    - [ ] Checklists
    - [ ] Games/Puzzles
  </template>
</section>

<section name="detailed_outline">
  <template>
    ## Detailed Page Outline

    ### Section: [SECTION_NAME]

    **Page [X]:** [PAGE_TITLE]
    - Prompt/Content: "[EXACT_TEXT]"
    - Visual: [DESCRIPTION]
    - User Action: [WHAT_USER_DOES]

    **Page [X+1]:** [PAGE_TITLE]
    ...
  </template>
  <constraints>
    - detail_level: enough for designer/creator to execute
    - include exact prompt text where applicable
  </constraints>
</section>

</step>

<step number="7" subagent="file-creator" name="create_distribution_strategy_md">

### Step 7: Create distribution-strategy.md

<file_template>
  <header>
    # Distribution Strategy
  </header>
</file_template>

<section name="primary_platform">
  <template>
    ## Primary Platform: Amazon KDP

    ### Book Details
    - **Format:** Paperback / Hardcover
    - **Trim Size:** [SIZE]
    - **Interior:** Black & White / Color
    - **Paper Type:** White / Cream
    - **Bleed:** Yes / No
    - **Cover Finish:** Matte / Glossy

    ### Pricing Strategy
    | Market | List Price | Royalty Rate | Est. Royalty |
    |--------|------------|--------------|--------------|
    | Amazon.com (US) | $[PRICE] | [35%/60%] | $[AMOUNT] |
    | Amazon.de (DE) | €[PRICE] | [35%/60%] | €[AMOUNT] |
    | Amazon.co.uk (UK) | £[PRICE] | [35%/60%] | £[AMOUNT] |

    ### KDP Select Decision
    - **Enroll:** Yes / No
    - **Rationale:** [REASON]

    ### Categories (request up to 10)
    1. [CATEGORY_PATH_1]
    2. [CATEGORY_PATH_2]
    3. [CATEGORY_PATH_3]
  </template>
</section>

<section name="expanded_distribution">
  <template>
    ## Expanded Distribution

    ### IngramSpark (Optional)
    - **Use Case:** Bookstore/library access
    - **Decision:** Yes / No / Later
    - **Rationale:** [REASON]

    ### Other Platforms
    | Platform | Priority | Notes |
    |----------|----------|-------|
    | Etsy (PDF version) | [HIGH/MED/LOW] | [NOTE] |
    | Own Website | [HIGH/MED/LOW] | [NOTE] |
    | Local Bookstores | [HIGH/MED/LOW] | [NOTE] |
  </template>
</section>

<section name="isbn">
  <template>
    ## ISBN Strategy

    - **Free KDP ISBN:** Yes / No
    - **Own ISBN:** Yes / No
    - **Rationale:** [REASON - free KDP ISBN limits distribution but sufficient for Amazon-only]
  </template>
</section>

</step>

<step number="8" subagent="file-creator" name="create_seasonal_marketing_md">

### Step 8: Create seasonal-marketing.md

<file_template>
  <header>
    # Seasonal Marketing Calendar
  </header>
</file_template>

<section name="annual_calendar">
  <template>
    ## Annual Marketing Calendar

    ### Peak Sales Periods
    ```
    [OCCASION_1]: [PEAK_DATES]
    ├── Prep Start: [DATE - 8 weeks before]
    ├── Ads Launch: [DATE - 4 weeks before]
    ├── Peak Shopping: [DATE - 2 weeks before]
    └── Last Orders: [DATE - shipping cutoff]
    ```

    ### Monthly Overview
    | Month | Occasion | Action | Priority |
    |-------|----------|--------|----------|
    | Jan | - | Prep for Valentine's/Mother's Day | Low |
    | Feb | Valentine's | [IF_APPLICABLE] | [PRIORITY] |
    | Mar | - | Mother's Day prep | Medium |
    | Apr | - | Mother's Day ads launch | High |
    | May | Mother's Day | Peak season | Critical |
    | ... | ... | ... | ... |
  </template>
</section>

<section name="campaign_strategy">
  <template>
    ## Campaign Strategy per Occasion

    ### [PRIMARY_OCCASION] Campaign

    **Timeline:**
    - T-8 weeks: [ACTION]
    - T-4 weeks: [ACTION]
    - T-2 weeks: [ACTION]
    - T-1 week: [ACTION]
    - Occasion Day: [ACTION]
    - T+1 week: [POST_OCCASION_ACTION]

    **Amazon Ads:**
    - Budget: $[DAILY_BUDGET]/day
    - Keywords: [SEASONAL_KEYWORDS]
    - Bid Strategy: [STRATEGY]

    **Price Strategy:**
    - Regular: $[PRICE]
    - Pre-occasion: $[PRICE] (optional increase)
    - Post-occasion: $[PRICE] (optional discount)
  </template>
</section>

<section name="off_season">
  <template>
    ## Off-Season Strategy

    ### Maintaining Visibility
    - [STRATEGY_1 - e.g., birthday positioning]
    - [STRATEGY_2 - e.g., "just because" gift angle]

    ### Continuous Improvements
    - [ ] Monitor reviews for improvement ideas
    - [ ] A/B test descriptions
    - [ ] Update keywords based on search data
    - [ ] Plan next edition/variation
  </template>
</section>

</step>

<step number="9" subagent="file-creator" name="create_listing_optimization_md">

### Step 9: Create listing-optimization.md

<file_template>
  <header>
    # Listing Optimization
  </header>
</file_template>

<section name="title_subtitle">
  <template>
    ## Title & Subtitle Optimization

    ### Title (max 200 chars, front-loaded keywords)
    ```
    [OPTIMIZED_TITLE]
    ```

    ### Subtitle (if applicable)
    ```
    [OPTIMIZED_SUBTITLE]
    ```

    ### Title Analysis
    - Primary Keyword: [KEYWORD] - Position: [1st/2nd/3rd]
    - Secondary Keywords: [LIST]
    - Emotional Trigger: [WORD]
    - Gift Indicator: [WORD - e.g., "Gift", "For Mom"]
  </template>
</section>

<section name="description">
  <template>
    ## Book Description (max 4000 chars)

    ### Structure: Hook → Problem → Solution → Features → CTA

    ```html
    <h2>[HOOK - emotional opening]</h2>

    <p>[PROBLEM - why generic gifts don't work]</p>

    <p>[SOLUTION - what this book offers]</p>

    <h3>What's Inside:</h3>
    <ul>
    <li>[FEATURE_1]</li>
    <li>[FEATURE_2]</li>
    <li>[FEATURE_3]</li>
    </ul>

    <h3>Perfect For:</h3>
    <ul>
    <li>[OCCASION_1]</li>
    <li>[OCCASION_2]</li>
    </ul>

    <p><strong>[CTA - Order now, make memories]</strong></p>
    ```
  </template>
  <constraints>
    - use basic HTML formatting allowed by KDP
    - front-load important info
    - include keywords naturally
    - max 4000 characters
  </constraints>
</section>

<section name="a_plus_content">
  <template>
    ## A+ Content Strategy

    ### Module Plan
    | Module Type | Content | Purpose |
    |-------------|---------|---------|
    | Hero Image | [DESCRIPTION] | First impression |
    | Comparison Chart | [DESCRIPTION] | Show book variations |
    | Image Gallery | Interior previews | Show content quality |
    | Text Block | [KEY_MESSAGE] | Address buyer concerns |

    ### Interior Preview Images
    1. [PAGE_TYPE]: [WHY_SHOW_THIS]
    2. [PAGE_TYPE]: [WHY_SHOW_THIS]
    3. [PAGE_TYPE]: [WHY_SHOW_THIS]
  </template>
  <constraints>
    - preview_images: 3-7
    - show variety of content types
    - high quality, readable thumbnails
  </constraints>
</section>

<section name="backend_optimization">
  <template>
    ## Backend Optimization

    ### 7 Keyword Slots
    1. `[KEYWORD_PHRASE]` (chars: [X]/50)
    2. `[KEYWORD_PHRASE]` (chars: [X]/50)
    3. `[KEYWORD_PHRASE]` (chars: [X]/50)
    4. `[KEYWORD_PHRASE]` (chars: [X]/50)
    5. `[KEYWORD_PHRASE]` (chars: [X]/50)
    6. `[KEYWORD_PHRASE]` (chars: [X]/50)
    7. `[KEYWORD_PHRASE]` (chars: [X]/50)

    ### Category Requests
    Primary Categories (auto-assigned):
    1. [CATEGORY]
    2. [CATEGORY]

    Additional Categories (request via KDP support):
    3. [CATEGORY]
    4. [CATEGORY]
    ...
  </template>
</section>

</step>

<step number="10" subagent="file-creator" name="create_book_mission_lite_md">

### Step 10: Create book-mission-lite.md

<file_template>
  <header>
    # Book Mission (Lite)
  </header>
</file_template>

<content_template>
  **[BOOK_TITLE]** is a [BOOK_TYPE] for [TARGET_USER_AGE] to create a personalized gift for [RECIPIENT] on [PRIMARY_OCCASIONS].

  The book features [KEY_CONTENT_TYPES] and positions as [PRICE_POSITION] in the [NICHE] category. Primary marketing focus is [PRIMARY_OCCASION] with Amazon Ads launching [X] weeks before.
</content_template>

<constraints>
  - length: 2-4 sentences
  - include: book type, target, occasions, price position
  - purpose: quick AI context loading
</constraints>

</step>

<step number="11" subagent="file-creator" name="create_decisions_md">

### Step 11: Create decisions.md

<file_template>
  <header>
    # Product Decisions Log

    > Override Priority: Highest
  </header>
</file_template>

<initial_decision_template>
  ## [CURRENT_DATE]: Initial Book Planning

  **ID:** DEC-001
  **Status:** Accepted
  **Category:** Product

  ### Decision
  Create "[BOOK_TITLE]" as a [BOOK_TYPE] targeting [OCCASION] gift market on Amazon KDP.

  ### Context
  [WHY_THIS_BOOK - market opportunity, personal motivation, gap identified]

  ### Key Choices Made
  1. **Format:** [CHOICE] - [RATIONALE]
  2. **Price Point:** [CHOICE] - [RATIONALE]
  3. **Primary Platform:** [CHOICE] - [RATIONALE]
  4. **Language:** [CHOICE] - [RATIONALE]

  ### Risks & Mitigations
  - **Risk:** [RISK_1]
    - Mitigation: [MITIGATION]
</initial_decision_template>

</step>

</process_flow>

## Execution Summary

<final_checklist>
  <verify>
    - [ ] All 9 files created in .agent-os/product/
    - [ ] Buyer persona distinguishes buyer/user/recipient
    - [ ] Seasonal calendar includes specific dates
    - [ ] Keywords researched and documented
    - [ ] Listing copy optimized with HTML
    - [ ] A+ content strategy defined
    - [ ] Decisions documented
  </verify>
</final_checklist>

<execution_order>
  1. Gather book details from user
  2. Create directory structure
  3. Generate book-mission.md (vision & features)
  4. Generate buyer-personas.md (buyer ≠ user ≠ recipient)
  5. Generate market-analysis.md (competition & keywords)
  6. Generate book-content.md (detailed outline)
  7. Generate distribution-strategy.md (KDP settings)
  8. Generate seasonal-marketing.md (occasion calendar)
  9. Generate listing-optimization.md (title, description, A+)
  10. Generate book-mission-lite.md (condensed)
  11. Generate decisions.md (initial planning decision)
</execution_order>

<next_steps_template>
  ## Next Steps

  After planning is complete:
  1. **If book not yet created:** Proceed to content creation/design
  2. **If book exists:** Use listing-optimization.md to update KDP listing
  3. **Before peak season:** Execute seasonal-marketing.md campaign plan
  4. **Ongoing:** Monitor BSR, reviews, adjust keywords
</next_steps_template>
