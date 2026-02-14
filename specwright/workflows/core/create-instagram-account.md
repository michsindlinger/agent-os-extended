---
description: Instagram Account Strategy Creation for Specwright
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Instagram Account Strategy Rules

## Overview

Generate a comprehensive Instagram marketing strategy for the product/project including account setup, content strategy, competitor analysis, and posting schedule.

<pre_flight_check>
  EXECUTE: @~/.specwright/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="product_analysis">

### Step 1: Product Analysis

Use the context-fetcher subagent to gather product information for Instagram strategy alignment.

<context_sources>
  <primary>
    - @specwright/product/mission.md
    - @specwright/product/mission-lite.md
  </primary>
  <secondary>
    - @specwright/product/tech-stack.md
    - @specwright/product/roadmap.md
  </secondary>
</context_sources>

<extraction_focus>
  - product_name: string
  - value_proposition: string
  - target_users: array[user_persona]
  - key_features: array[string]
  - differentiators: array[string]
  - industry: string
  - brand_voice: string (derive from mission tone)
</extraction_focus>

</step>

<step number="2" subagent="perplexity" name="competitor_research">

### Step 2: Competitor Research

Use perplexity to research successful Instagram accounts in the same industry/niche.

<research_queries>
  1. "Top Instagram accounts in [INDUSTRY] with high engagement rates 2025"
  2. "[INDUSTRY] Instagram marketing case studies successful strategies"
  3. "Best performing Instagram content types for [INDUSTRY] businesses"
</research_queries>

<competitor_analysis>
  <for_each competitor="top_3_5_accounts">
    <analyze>
      - account_name: string
      - follower_count: number
      - engagement_rate: percentage
      - posting_frequency: posts_per_week
      - content_types: array[reels, carousels, stories, single_posts]
      - content_themes: array[string]
      - hashtag_strategy: array[string]
      - best_performing_posts: array[description]
      - bio_structure: string
      - call_to_action: string
    </analyze>
  </for_each>
</competitor_analysis>

<success_patterns>
  IDENTIFY:
    - Common content themes that perform well
    - Posting times with highest engagement
    - Hashtag patterns (branded vs industry vs niche)
    - Visual style patterns
    - Caption length and style
    - Engagement tactics used
</success_patterns>

</step>

<step number="3" name="account_naming">

### Step 3: Account Name Recommendations

Generate 3-5 Instagram username options based on product analysis and industry standards.

<naming_criteria>
  - memorable: easy to remember and spell
  - searchable: contains industry keywords
  - available: check format compatibility
  - consistent: aligns with brand identity
  - length: ideally under 20 characters
</naming_criteria>

<username_patterns>
  <pattern_options>
    1. [brandname] - Direct brand name
    2. [brandname]_[industry] - Brand with industry
    3. [brandname]hq - Brand with HQ suffix
    4. get[brandname] - Action prefix
    5. [brandname]app - Product type suffix
  </pattern_options>
</username_patterns>

<recommendation_template>
  **Recommended Usernames:**

  1. **@[username1]** - [rationale]
  2. **@[username2]** - [rationale]
  3. **@[username3]** - [rationale]

  **Primary Recommendation:** @[best_username]
  **Reason:** [detailed_justification]
</recommendation_template>

</step>

<step number="4" name="bio_optimization">

### Step 4: Bio Optimization

Create an optimized Instagram bio following best practices.

<bio_structure>
  <line_1>Value proposition (what you do)</line_1>
  <line_2>Key benefit for followers</line_2>
  <line_3>Social proof or differentiator</line_3>
  <line_4>Call-to-action with emoji</line_4>
  <link>Website or landing page URL</link>
</bio_structure>

<bio_constraints>
  - total_characters: max 150
  - include_emoji: 2-4 strategic emojis
  - include_cta: clear call-to-action
  - include_keywords: industry-relevant terms
</bio_constraints>

<bio_template>
  [VALUE_PROPOSITION_LINE]
  [KEY_BENEFIT_LINE]
  [SOCIAL_PROOF_OR_DIFFERENTIATOR]
  [EMOJI] [CALL_TO_ACTION]
  [LINK_PLACEHOLDER]
</bio_template>

</step>

<step number="5" name="content_pillars">

### Step 5: Define Content Pillars

Create 4-6 content pillars that organize all Instagram content.

<pillar_categories>
  <educational>
    - How-to guides
    - Tips and tricks
    - Industry insights
    - Tutorials
  </educational>
  <promotional>
    - Product features
    - New releases
    - Special offers
    - Case studies
  </promotional>
  <engagement>
    - Behind-the-scenes
    - Team spotlights
    - Q&A sessions
    - Polls and quizzes
  </engagement>
  <user_generated>
    - Customer testimonials
    - User success stories
    - Community highlights
    - Reposts
  </user_generated>
  <inspirational>
    - Quotes
    - Success stories
    - Industry trends
    - Motivational content
  </inspirational>
  <entertainment>
    - Memes (industry-relevant)
    - Trending formats
    - Relatable content
    - Fun facts
  </entertainment>
</pillar_categories>

<pillar_template>
  ## Content Pillar: [PILLAR_NAME]

  **Purpose:** [WHY_THIS_PILLAR]
  **Content Types:** [REELS, CAROUSELS, STORIES, POSTS]
  **Frequency:** [X_TIMES_PER_WEEK]
  **Examples:**
  - [EXAMPLE_POST_1]
  - [EXAMPLE_POST_2]
  - [EXAMPLE_POST_3]
</pillar_template>

<content_mix_recommendation>
  - Educational: 30-40%
  - Promotional: 20%
  - Engagement: 20%
  - User-generated: 10-15%
  - Entertainment: 10-15%
</content_mix_recommendation>

</step>

<step number="6" name="posting_schedule">

### Step 6: Define Posting Schedule

Create an optimal posting schedule based on industry research and competitor analysis.

<schedule_components>
  <weekly_frequency>
    - feed_posts: 3-5 per week
    - reels: 3-4 per week
    - stories: 1-2 per day
    - carousels: 2-3 per week
  </weekly_frequency>

  <optimal_times>
    <research_based>
      - General best times: 11am-1pm, 7pm-9pm
      - Best days: Tuesday, Wednesday, Thursday
      - Avoid: Late night, early morning
    </research_based>
    <customize_for_audience>
      - Consider target user timezone
      - Consider user behavior patterns
      - Consider industry-specific patterns
    </customize_for_audience>
  </optimal_times>
</schedule_components>

<weekly_schedule_template>
  ## Weekly Posting Schedule

  | Day | Time | Content Type | Pillar |
  |-----|------|--------------|--------|
  | Monday | [TIME] | [TYPE] | [PILLAR] |
  | Tuesday | [TIME] | [TYPE] | [PILLAR] |
  | Wednesday | [TIME] | [TYPE] | [PILLAR] |
  | Thursday | [TIME] | [TYPE] | [PILLAR] |
  | Friday | [TIME] | [TYPE] | [PILLAR] |
  | Saturday | [TIME] | [TYPE] | [PILLAR] |
  | Sunday | [TIME] | [TYPE] | [PILLAR] |

  **Stories Schedule:** Daily at [TIME_1] and [TIME_2]
</weekly_schedule_template>

</step>

<step number="7" name="hashtag_strategy">

### Step 7: Hashtag Strategy

Create a comprehensive hashtag strategy with categorized hashtag sets.

<hashtag_categories>
  <branded>
    - Create 1-2 unique branded hashtags
    - Example: #[BrandName]Community, #[BrandName]Tips
  </branded>
  <industry>
    - 5-10 industry-specific hashtags
    - Medium competition (10K-500K posts)
  </industry>
  <niche>
    - 5-10 niche-specific hashtags
    - Lower competition (1K-50K posts)
  </niche>
  <trending>
    - 2-3 currently trending relevant hashtags
    - Rotate based on trends
  </trending>
</hashtag_categories>

<hashtag_sets>
  <create_sets count="3-5">
    - Each set: 20-30 hashtags
    - Mix: 1 branded + 5 industry + 10 niche + 2 trending
    - Rotate sets to avoid shadowbanning
  </create_sets>
</hashtag_sets>

<hashtag_template>
  ## Hashtag Set 1: [THEME]

  **Branded:** #[BRANDED_1] #[BRANDED_2]
  **Industry:** #[INDUSTRY_1] #[INDUSTRY_2] ...
  **Niche:** #[NICHE_1] #[NICHE_2] ...
  **Trending:** #[TRENDING_1] #[TRENDING_2]

  Copy-paste set:
  ```
  #hashtag1 #hashtag2 #hashtag3 ...
  ```
</hashtag_template>

</step>

<step number="8" name="engagement_tactics">

### Step 8: Engagement Tactics

Define specific tactics to boost engagement and grow followers.

<engagement_strategies>
  <community_building>
    - Respond to all comments within 1 hour
    - Like and comment on follower posts
    - Feature user-generated content weekly
    - Host monthly Q&A sessions
  </community_building>

  <growth_tactics>
    - Collaborate with micro-influencers (1K-10K followers)
    - Cross-promote with complementary brands
    - Run engagement-boosting contests
    - Use interactive story features (polls, quizzes, questions)
  </growth_tactics>

  <content_optimization>
    - Use strong hooks in first 3 seconds of Reels
    - End Reels with CTA for saves/shares
    - Ask questions in captions
    - Use carousel posts for higher saves
  </content_optimization>
</engagement_strategies>

</step>

<step number="9" name="kpi_definition">

### Step 9: Define KPIs and Success Metrics

Establish measurable goals for Instagram performance.

<kpi_categories>
  <growth_metrics>
    - Follower growth rate (target: +5-10% monthly)
    - Reach growth (target: +10% monthly)
    - Profile visits (track weekly)
  </growth_metrics>

  <engagement_metrics>
    - Engagement rate (target: 3-6% for business accounts)
    - Save rate (target: 2-5%)
    - Share rate (target: 1-3%)
    - Comment rate (target: 1-2%)
  </engagement_metrics>

  <conversion_metrics>
    - Link clicks (track via UTM)
    - Website traffic from Instagram
    - Lead generation (if applicable)
  </conversion_metrics>
</kpi_categories>

<milestone_targets>
  <month_1>
    - Establish consistent posting schedule
    - Reach 500 followers
    - Average 3% engagement rate
  </month_1>
  <month_3>
    - Reach 2,000 followers
    - First viral reel (10K+ views)
    - Establish 2 brand collaborations
  </month_3>
  <month_6>
    - Reach 5,000+ followers
    - Consistent 5%+ engagement rate
    - Trackable website traffic from Instagram
  </month_6>
</milestone_targets>

</step>

<step number="10" subagent="date-checker" name="date_determination">

### Step 10: Date Determination

Use the date-checker subagent to determine the current date in YYYY-MM-DD format for file naming.

</step>

<step number="11" subagent="file-creator" name="create_strategy_folder">

### Step 11: Create Strategy Folder

Use the file-creator subagent to create the documentation structure.

<file_structure>
  .specwright/marketing/instagram/
  ├── strategy.md           # Main strategy document
  ├── content-pillars.md    # Detailed content pillars
  ├── hashtag-sets.md       # All hashtag sets
  ├── posting-schedule.md   # Weekly schedule template
  └── kpis.md               # Goals and metrics tracking
</file_structure>

</step>

<step number="12" subagent="file-creator" name="create_strategy_md">

### Step 12: Create strategy.md

Use the file-creator subagent to create the main strategy document.

<file_template>
  # Instagram Marketing Strategy

  > Product: [PRODUCT_NAME]
  > Created: [CURRENT_DATE]
  > Status: Active

  ## Account Setup

  **Recommended Username:** @[USERNAME]
  **Account Type:** Business

  ### Bio

  ```
  [OPTIMIZED_BIO]
  ```

  ## Target Audience

  [FROM_PRODUCT_ANALYSIS]

  ## Competitor Analysis Summary

  [FROM_COMPETITOR_RESEARCH]

  ## Content Strategy Overview

  [CONTENT_PILLARS_SUMMARY]

  ## Posting Schedule

  [SCHEDULE_OVERVIEW]

  ## Success Metrics

  [KPI_SUMMARY]
</file_template>

</step>

<step number="13" name="user_review">

### Step 13: User Review

Present the complete Instagram strategy for user approval.

<review_request>
  I've created your Instagram marketing strategy:

  - Main Strategy: @specwright/marketing/instagram/strategy.md
  - Content Pillars: @specwright/marketing/instagram/content-pillars.md
  - Hashtag Sets: @specwright/marketing/instagram/hashtag-sets.md
  - Posting Schedule: @specwright/marketing/instagram/posting-schedule.md
  - KPIs: @specwright/marketing/instagram/kpis.md

  **Key Recommendations:**
  - Username: @[RECOMMENDED_USERNAME]
  - Posting Frequency: [X] posts/week
  - Primary Content Type: [REELS/CAROUSELS]

  Please review and let me know if any adjustments are needed.

  When ready, use `/create-content-plan` to generate your first 7-day content plan.
</review_request>

</step>

</process_flow>

## Execution Standards

<standards>
  <follow>
    - @specwright/product/mission.md for brand alignment
    - Instagram best practices 2025
    - Competitor success patterns
  </follow>
  <maintain>
    - Consistency with brand voice
    - Realistic and achievable goals
    - Data-driven recommendations
  </maintain>
  <create>
    - Actionable strategy documents
    - Copy-paste ready hashtag sets
    - Clear weekly schedules
  </create>
</standards>

<final_checklist>
  <verify>
    - [ ] Product thoroughly analyzed
    - [ ] 3-5 competitors researched
    - [ ] Username options provided
    - [ ] Bio optimized (under 150 chars)
    - [ ] 4-6 content pillars defined
    - [ ] Weekly schedule created
    - [ ] 3-5 hashtag sets prepared
    - [ ] KPIs and milestones set
    - [ ] All strategy files created
    - [ ] User reviewed and approved
  </verify>
</final_checklist>
