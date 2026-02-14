---
description: Instagram Content Plan Creation for Specwright
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Instagram Content Plan Rules

## Overview

Generate a detailed 7-day Instagram content plan with specific posts, captions, hashtags, and optimal posting times based on the existing Instagram strategy.

<pre_flight_check>
  EXECUTE: @~/.specwright/workflows/meta/pre-flight.md
</pre_flight_check>

<prerequisites>
  REQUIRE: @specwright/marketing/instagram/strategy.md
  IF NOT EXISTS:
    PROMPT: "No Instagram strategy found. Please run `/create-instagram-account` first to create your Instagram marketing strategy."
    STOP
</prerequisites>

<process_flow>

<step number="1" subagent="context-fetcher" name="load_strategy">

### Step 1: Load Instagram Strategy

Use the context-fetcher subagent to load the existing Instagram strategy and related documents.

<load_files>
  - @specwright/marketing/instagram/strategy.md
  - @specwright/marketing/instagram/content-pillars.md
  - @specwright/marketing/instagram/hashtag-sets.md
  - @specwright/marketing/instagram/posting-schedule.md
  - @specwright/product/mission-lite.md
</load_files>

<extract>
  - content_pillars: array[pillar]
  - posting_schedule: weekly_template
  - hashtag_sets: array[set]
  - brand_voice: string
  - target_audience: user_persona
</extract>

</step>

<step number="2" subagent="date-checker" name="determine_week">

### Step 2: Determine Content Week

Use the date-checker subagent to get the current date and calculate the 7-day content period.

<week_calculation>
  - start_date: next Monday (or today if Monday)
  - end_date: Sunday of that week
  - format: YYYY-MM-DD
</week_calculation>

<output>
  Content Plan Week: [START_DATE] to [END_DATE]
</output>

</step>

<step number="3" subagent="perplexity" name="trend_research">

### Step 3: Trend Research

Use perplexity to identify current trends and timely content opportunities.

<research_queries>
  1. "Instagram trending audio and sounds this week [INDUSTRY]"
  2. "Trending topics [INDUSTRY] [CURRENT_MONTH] 2025"
  3. "Upcoming events holidays [INDUSTRY] next 7 days"
</research_queries>

<trend_output>
  <trending_audio>
    - [AUDIO_1]: [DESCRIPTION]
    - [AUDIO_2]: [DESCRIPTION]
  </trending_audio>
  <trending_topics>
    - [TOPIC_1]
    - [TOPIC_2]
  </trending_topics>
  <upcoming_events>
    - [DATE]: [EVENT/HOLIDAY]
  </upcoming_events>
</trend_output>

</step>

<step number="4" name="content_ideation">

### Step 4: Content Ideation

Generate 7-10 content ideas distributed across content pillars.

<ideation_rules>
  <distribution>
    - Ensure all content pillars are represented
    - Follow content mix percentages from strategy
    - Include at least 2 Reels (highest reach)
    - Include at least 1 carousel (highest saves)
    - Balance promotional vs value content (80/20 rule)
  </distribution>

  <content_types>
    <reel>
      - Duration: 15-30 seconds optimal
      - Hook: First 3 seconds crucial
      - CTA: End with save/share prompt
    </reel>
    <carousel>
      - Slides: 5-10 slides optimal
      - First slide: Strong hook/headline
      - Last slide: CTA
    </carousel>
    <single_post>
      - High-quality image
      - Strong caption with story
      - Question to drive comments
    </single_post>
    <story>
      - Interactive elements (poll, quiz, question)
      - Behind-the-scenes content
      - Reposts and highlights
    </story>
  </content_types>
</ideation_rules>

<idea_template>
  **Idea [NUMBER]**
  - Pillar: [CONTENT_PILLAR]
  - Type: [REEL/CAROUSEL/POST/STORY]
  - Topic: [TOPIC]
  - Hook: [FIRST_LINE_OR_3_SECONDS]
  - Value: [WHAT_AUDIENCE_GAINS]
  - CTA: [DESIRED_ACTION]
</idea_template>

</step>

<step number="5" name="create_daily_content">

### Step 5: Create Daily Content Details

For each day, create complete post specifications.

<daily_content_structure>
  <for_each day="Monday-Sunday">

  ## [DAY], [DATE]

  ### Post [NUMBER]: [TYPE]

  **Pillar:** [CONTENT_PILLAR]
  **Posting Time:** [TIME] [TIMEZONE]

  #### Content

  <if type="reel">
    **Hook (0-3 sec):** [ATTENTION_GRABBER]
    **Script/Concept:**
    ```
    [SCENE_BY_SCENE_BREAKDOWN]
    ```
    **Audio:** [TRENDING_AUDIO_OR_VOICEOVER]
    **Text Overlays:** [KEY_TEXT_ON_SCREEN]
    **Duration:** [SECONDS]
  </if>

  <if type="carousel">
    **Slide 1 (Cover):** [HEADLINE/HOOK]
    **Slide 2:** [CONTENT]
    **Slide 3:** [CONTENT]
    **Slide 4:** [CONTENT]
    **Slide 5:** [CONTENT]
    **Slide 6 (CTA):** [CALL_TO_ACTION]
  </if>

  <if type="single_post">
    **Image Concept:** [DESCRIPTION]
    **Visual Style:** [STYLE_NOTES]
  </if>

  #### Caption

  ```
  [HOOK_LINE]

  [BODY_CONTENT]

  [CALL_TO_ACTION]

  .
  .
  .

  [HASHTAGS]
  ```

  #### Hashtags

  Using Set: [SET_NUMBER]
  ```
  [COPY_PASTE_HASHTAGS]
  ```

  #### Story Tie-In

  - [TIME]: [STORY_IDEA_TO_PROMOTE_POST]
  - [TIME]: [ENGAGEMENT_STORY]

  </for_each>
</daily_content_structure>

</step>

<step number="6" name="caption_writing">

### Step 6: Write Engaging Captions

Create captions following proven engagement patterns.

<caption_structure>
  <hook>
    - First line visible before "more"
    - Must stop the scroll
    - Examples: Question, bold statement, statistic, story start
  </hook>

  <body>
    - Value-driven content
    - Easy to scan (short paragraphs)
    - Use line breaks for readability
    - Include emojis strategically (not excessive)
  </body>

  <cta>
    - Clear action request
    - Examples: "Save this for later", "Tag someone who needs this", "Drop a [emoji] if you agree"
  </cta>

  <hashtag_placement>
    - Add 5 dots with line breaks
    - Paste hashtag set below
    - Keeps caption clean
  </hashtag_placement>
</caption_structure>

<caption_formulas>
  <educational>
    [NUMBER] [TOPIC] tips you need to know:

    1. [TIP_1]
    2. [TIP_2]
    3. [TIP_3]

    Which one are you trying first? Comment below!
  </educational>

  <storytelling>
    I used to [OLD_WAY]...

    Then I discovered [NEW_APPROACH].

    Here's what changed:
    [TRANSFORMATION]

    Have you experienced this? Share below.
  </storytelling>

  <promotional>
    Introducing [FEATURE/PRODUCT]

    [PROBLEM_IT_SOLVES]

    [KEY_BENEFITS]

    Ready to try it? Link in bio.
  </promotional>

  <engagement>
    Hot take: [CONTROVERSIAL_OPINION]

    Here's why:
    [REASONING]

    Agree or disagree? Let's discuss.
  </engagement>
</caption_formulas>

</step>

<step number="7" name="story_planning">

### Step 7: Plan Daily Stories

Create a story plan to complement feed posts.

<daily_stories>
  <morning slot="9-10am">
    - Good morning engagement (poll, question)
    - Behind-the-scenes peek
  </morning>

  <midday slot="12-1pm">
    - Tease upcoming feed post
    - Quick tip or value add
  </midday>

  <afternoon slot="5-6pm">
    - Promote new feed post
    - Interactive element (quiz, slider)
  </afternoon>

  <evening slot="8-9pm">
    - Recap or highlight
    - User-generated content repost
    - Next day tease
  </evening>
</daily_stories>

<story_ideas>
  <interactive>
    - This or That polls
    - Quiz about [TOPIC]
    - Question sticker: "What's your biggest [CHALLENGE]?"
    - Slider: "Rate your [TOPIC] level"
  </interactive>
  <behind_scenes>
    - Work in progress shots
    - Team moments
    - Day in the life
    - Process reveals
  </behind_scenes>
  <value_add>
    - Quick tips (text on photo)
    - Did you know facts
    - Tool/resource shares
    - Trend commentary
  </value_add>
</story_ideas>

</step>

<step number="8" subagent="file-creator" name="create_content_plan_folder">

### Step 8: Create Content Plan Files

Use the file-creator subagent to create the content plan structure.

<file_structure>
  .specwright/marketing/instagram/content-plans/
  └── [YYYY-MM-DD]-to-[YYYY-MM-DD]/
      ├── overview.md         # Week summary
      ├── monday.md           # Daily detail
      ├── tuesday.md
      ├── wednesday.md
      ├── thursday.md
      ├── friday.md
      ├── saturday.md
      └── sunday.md
</file_structure>

</step>

<step number="9" subagent="file-creator" name="create_overview">

### Step 9: Create Week Overview

Use the file-creator subagent to create the overview file.

<overview_template>
  # Instagram Content Plan

  > Week: [START_DATE] to [END_DATE]
  > Created: [CURRENT_DATE]

  ## Week Summary

  | Day | Post Type | Pillar | Topic | Time |
  |-----|-----------|--------|-------|------|
  | Mon | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |
  | Tue | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |
  | Wed | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |
  | Thu | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |
  | Fri | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |
  | Sat | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |
  | Sun | [TYPE] | [PILLAR] | [TOPIC] | [TIME] |

  ## Content Mix This Week

  - Reels: [COUNT]
  - Carousels: [COUNT]
  - Single Posts: [COUNT]
  - Stories: [COUNT]

  ## Pillar Distribution

  - [PILLAR_1]: [COUNT] posts
  - [PILLAR_2]: [COUNT] posts
  - [PILLAR_3]: [COUNT] posts

  ## Trending Elements Used

  - Audio: [LIST]
  - Topics: [LIST]
  - Events: [LIST]

  ## Notes

  [ANY_SPECIAL_NOTES_FOR_THE_WEEK]
</overview_template>

</step>

<step number="10" subagent="file-creator" name="create_daily_files">

### Step 10: Create Daily Content Files

Use the file-creator subagent to create each daily file.

<daily_file_template>
  # [DAY], [DATE]

  ## Feed Post

  **Type:** [REEL/CAROUSEL/POST]
  **Pillar:** [CONTENT_PILLAR]
  **Posting Time:** [TIME]

  ### Content Details

  [TYPE_SPECIFIC_CONTENT_FROM_STEP_5]

  ### Caption

  ```
  [FULL_CAPTION_WITH_HASHTAGS]
  ```

  ### Visual Notes

  [DESCRIPTION_OF_VISUALS_NEEDED]

  ### Preparation Checklist

  - [ ] Visual assets created
  - [ ] Caption reviewed
  - [ ] Hashtags copied
  - [ ] Scheduled in planner

  ---

  ## Stories Schedule

  | Time | Type | Content |
  |------|------|---------|
  | [TIME] | [TYPE] | [DESCRIPTION] |
  | [TIME] | [TYPE] | [DESCRIPTION] |
  | [TIME] | [TYPE] | [DESCRIPTION] |

  ### Story Content Details

  **Story 1 - [TIME]**
  [DETAILED_DESCRIPTION]

  **Story 2 - [TIME]**
  [DETAILED_DESCRIPTION]

  ---

  ## Engagement Tasks

  - [ ] Respond to comments on previous posts
  - [ ] Engage with 10 accounts in niche
  - [ ] Reply to story mentions
  - [ ] Check DMs

  ## Notes

  [DAY_SPECIFIC_NOTES]
</daily_file_template>

</step>

<step number="11" name="user_review">

### Step 11: User Review

Present the complete content plan for user approval.

<review_summary>
  Your 7-day Instagram content plan is ready!

  **Week:** [START_DATE] to [END_DATE]

  **Content Overview:**
  - [COUNT] Reels
  - [COUNT] Carousels
  - [COUNT] Single Posts
  - [COUNT] Story sequences

  **Files Created:**
  - Overview: @specwright/marketing/instagram/content-plans/[FOLDER]/overview.md
  - Daily plans: monday.md through sunday.md

  **This Week's Highlights:**
  1. [HIGHLIGHT_POST_1]
  2. [HIGHLIGHT_POST_2]
  3. [HIGHLIGHT_POST_3]

  **Trending Elements Incorporated:**
  - [TREND_1]
  - [TREND_2]

  Please review the content plan. Let me know if you'd like to:
  - Swap any content ideas
  - Adjust posting times
  - Change the content mix
  - Add specific topics

  When ready to plan the next week, run `/create-content-plan` again.
</review_summary>

</step>

</process_flow>

## Content Quality Standards

<quality_checklist>
  <for_each post="all_posts">
    <verify>
      - [ ] Hook is attention-grabbing
      - [ ] Value is clear to audience
      - [ ] Brand voice is consistent
      - [ ] CTA is specific and actionable
      - [ ] Hashtags are relevant
      - [ ] Posting time is optimal
      - [ ] Visual concept is described
      - [ ] Story tie-in is planned
    </verify>
  </for_each>
</quality_checklist>

<content_principles>
  - Value first, promotion second
  - Every post should educate, entertain, or inspire
  - Consistency in visual style and voice
  - Engagement-driving CTAs
  - Mobile-first content design
</content_principles>

<final_checklist>
  <verify>
    - [ ] Strategy loaded and followed
    - [ ] Current trends researched
    - [ ] All 7 days planned
    - [ ] Content pillars balanced
    - [ ] All captions written
    - [ ] Hashtag sets assigned
    - [ ] Stories planned
    - [ ] Files created
    - [ ] User reviewed
  </verify>
</final_checklist>
