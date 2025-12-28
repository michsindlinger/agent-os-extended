---
name: Copywriting Style
description: Personal copywriting style and voice for landing pages and marketing materials (PROJECT-CUSTOMIZABLE)
triggers:
  - task_mentions: "landing page copy|ad copy|write copy|copywriting"
  - file_contains: "landing-page|ad-campaigns"
always_active_for_agents: ["content-creator"]
---

# Copywriting Style Guide

This skill defines your personal copywriting style, tone, and voice preferences. **Override this file in your project** to use your own writing style.

## Purpose

Landing pages and ad copy should reflect YOUR brand voice, not generic marketing speak. This skill allows you to:
- Define your preferred tone (casual, professional, playful, authoritative)
- Specify words/phrases you love or avoid
- Set style preferences (emoji usage, punctuation, sentence structure)
- Provide example copy that represents your style

## Default Style (Override This!)

**This is a generic default style. Copy this file to your project and customize it to match your brand voice.**

### Tone & Voice

**Tone**: Professional yet approachable
- Not too corporate (avoid jargon)
- Not too casual (maintain credibility)
- Balanced between friendly and authoritative

**Voice Characteristics**:
- **Clear**: Simple language, short sentences
- **Benefit-driven**: Focus on outcomes, not features
- **Specific**: Use numbers, avoid vague claims
- **Conversational**: Write like you're talking to a friend

### Writing Preferences

**Sentence Structure**:
- Short sentences: 10-15 words average
- One idea per sentence
- Active voice preferred ("We help you" not "You are helped")
- Vary length for rhythm (mix short punchy with medium explanatory)

**Paragraph Length**:
- 2-4 sentences maximum
- Break up long blocks
- Use white space generously

**Punctuation**:
- **Periods**: End most sentences (not exclamation points everywhere)
- **Exclamation Points**: Sparingly (1-2 per page, for emphasis only)
- **Em Dashes**: Use for emphasis (like this — see?)
- **Colons**: Use for lists and explanations

**Numbers**:
- Write out one through nine (one, two, three)
- Use numerals for 10+ (10, 50, 1000)
- Use specific numbers ("Save 2 hours" not "Save time")

### Emoji Usage

**Default**: Minimal emoji usage
- ✅ In feature icons (⚡, 🔔, 📱) - visual, scannable
- ❌ In body text - keep professional
- ❌ In headlines - unless very casual brand

**Override for playful brands**: Use emoji freely if it matches your brand

### Words to Prefer

**Action Verbs**:
- Get, Start, Create, Save, Build, Discover
- Avoid: Leverage, utilize, optimize (jargony)

**Benefit Words**:
- Simple, Fast, Easy, Automatic, Instant
- Avoid: Revolutionary, game-changing, disruptive (overused)

**Trust Words**:
- Free, Risk-free, No credit card, Cancel anytime
- Avoid: Guaranteed (unless you mean it legally)

### Words to Avoid

**Jargon**:
- ❌ Synergies, leverage, paradigm shift, thought leader
- ✅ Work together, use, new approach, expert

**Vague Claims**:
- ❌ Best in class, world-class, cutting-edge
- ✅ Rated 4.9/5 by 200 users, fastest in tests, latest version

**Overused Marketing**:
- ❌ Revolutionary, game-changing, groundbreaking
- ✅ New, different, improved

## Customization Guide

### How to Override This Skill

**Step 1**: Copy to your project
```bash
mkdir -p agent-os/skills/marketing
cp ~/.agent-os/skills/marketing/copywriting-style.md agent-os/skills/marketing/
```

**Step 2**: Edit to match your brand voice
```bash
vim agent-os/skills/marketing/copywriting-style.md
```

**Step 3**: Define your style
```markdown
### Tone & Voice

**Tone**: [Your tone - e.g., "Playful and energetic" or "Serious and trustworthy"]

**Voice Characteristics**:
- [Your characteristic 1]
- [Your characteristic 2]
- [Your characteristic 3]

### Example Copy (Your Style)

[Paste 2-3 examples of copy you've written that represents your style]

Example Headline:
"[Your example headline]"

Example Feature Description:
"[Your example feature copy]"

Example CTA:
"[Your preferred CTA style]"
```

**Step 4**: Use in validation
```bash
/validate-market "Your product"
# content-creator automatically uses YOUR copywriting-style (from project)
# Instead of global default
```

### Example: Casual Playful Brand

```markdown
### Tone & Voice

**Tone**: Casual, playful, energetic
- Like talking to a friend over coffee
- Lots of personality, not robotic
- Enthusiastic but not salesy

**Voice Characteristics**:
- **Fun**: Use emoji, casual language, occasional humor
- **Energetic**: Short punchy sentences, exclamation points OK
- **Relatable**: "You" language, conversational contractions (don't, won't, it's)

### Emoji Usage

✅ Use freely in headlines: "🚀 Launch Your Product in 30 Days!"
✅ Use in body text for emphasis: "It's that easy! 💪"
✅ Use in features: Every feature gets an emoji

### Words to Prefer

- Awesome, Amazing, Super, Totally, Literally
- Get started, Jump in, Let's go, Boom!
- No more [pain], Say goodbye to [problem]

### Example Copy

Headline: "🚀 From Idea to Launched Product in 30 Days!"
Subheadline: "No coding, no complexity. Just you + our AI = awesome products."
CTA: "Let's Go! 🎉"

Feature:
"⚡ Lightning-Fast Setup
Literally 60 seconds and you're done. We're not kidding! ⏱️"
```

### Example: Professional Authoritative Brand

```markdown
### Tone & Voice

**Tone**: Professional, authoritative, trustworthy
- Expert guidance, not friend chat
- Data-driven, not emotional
- Confident but not arrogant

**Voice Characteristics**:
- **Authoritative**: Speak with expertise and confidence
- **Data-Driven**: Use statistics, case studies, research
- **Formal**: Proper grammar, no slang, complete sentences

### Emoji Usage

❌ No emoji in headlines or body text
⚠️ Sparingly in features (✓ checkmarks only)

### Words to Prefer

- Proven, Validated, Research-backed, Industry-leading
- Increase, Reduce, Optimize, Streamline
- Enterprise-grade, Professional, Reliable

### Example Copy

Headline: "Increase Revenue by 30% with Data-Driven Product Validation"
Subheadline: "Enterprise market validation platform trusted by 500+ companies."
CTA: "Request Demo"

Feature:
"Comprehensive Competitive Analysis
Our AI-powered research engine analyzes 50+ data points across competitors,
identifying market gaps with 95% accuracy. Validated through 200+ successful launches."
```

### Example: Minimalist Simple Brand

```markdown
### Tone & Voice

**Tone**: Minimal, clear, no fluff
- Say more with less
- Cut unnecessary words
- Crystal clear, no ambiguity

**Voice Characteristics**:
- **Concise**: Maximum clarity, minimum words
- **Direct**: No marketing fluff, straight to value
- **Honest**: No superlatives, just facts

### Emoji Usage

❌ No emoji (clean, minimal aesthetic)

### Words to Avoid

All superlatives: Best, greatest, amazing, incredible
All fluff: Really, very, quite, just

### Example Copy

Headline: "Invoice in 60 seconds"
Subheadline: "For freelancers"
CTA: "Start"

Feature:
"One-Click Generation
Timesheet to invoice. Instantly."
```

## Integration with content-creator

The **content-creator** agent automatically loads this skill and applies your style preferences when writing:

- Headlines: Match your preferred style (playful vs. professional)
- Body copy: Use your tone and voice
- CTAs: Follow your preference (energetic vs. minimal)
- Features: Match your format preference

**If you don't override**: Default professional-yet-approachable style is used.

**If you override**: YOUR style is used automatically.

---

**To use your own copywriting style:**

1. Copy this file to your project
2. Replace "Default Style" section with YOUR preferences
3. Add examples of your actual copy
4. content-creator will match your style automatically

**This makes every landing page sound like YOU, not generic marketing.**
