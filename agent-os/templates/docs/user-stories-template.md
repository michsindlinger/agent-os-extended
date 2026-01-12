# User Stories

> Spec: [SPEC_NAME]
> Created: [CREATED_DATE]
> Last Updated: [LAST_UPDATED_DATE]

## Story Overview

This document contains all user stories for the [SPEC_NAME] specification.

**Total Stories**: [STORY_COUNT]
**Estimated Effort**: [TOTAL_EFFORT]

---

## Story [STORY_NUMBER]: [STORY_TITLE]

**ID**: [STORY_ID]
**Priority**: [PRIORITY]
**Estimated Effort**: [EFFORT_ESTIMATE]
**Dependencies**: [DEPENDENCIES]

### User Story

Als [USER_ROLE]
möchte ich [ACTION],
damit [BENEFIT].

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: [EXACT_FILE_PATH]
- [ ] FILE_NOT_EXISTS: [PATH_THAT_SHOULD_NOT_EXIST]

**Inhalt-Prüfungen:**
- [ ] CONTAINS: [FILE] enthält "[TEXT_OR_PATTERN]"
- [ ] NOT_CONTAINS: [FILE] enthält NICHT "[TEXT]"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: [LINT_COMMAND] exits with code 0
- [ ] TEST_PASS: [TEST_COMMAND] exits with code 0
- [ ] BUILD_PASS: [BUILD_COMMAND] exits with code 0

**Browser-Prüfungen (erfordern MCP-Tool):**
- [ ] MCP_PLAYWRIGHT: [PAGE_URL] loads without errors
- [ ] MCP_PLAYWRIGHT: Element "[SELECTOR]" is visible
- [ ] MCP_SCREENSHOT: Visual comparison passes

**Manuelle Prüfungen (nur wenn unvermeidbar):**
- [ ] MANUAL: [DESCRIPTION_OF_MANUAL_CHECK]

### Required MCP Tools

| Tool | Purpose | Blocking |
|------|---------|----------|
| [TOOL_NAME] | [PURPOSE] | Yes/No |

**Pre-Flight Check:**
```bash
claude mcp list | grep -q "[TOOL_NAME]"
```

**If Missing:** Story wird als BLOCKED markiert

### Definition of Ready (DoR)

- [ ] User story is clearly defined
- [ ] Acceptance criteria are specific and testable (using FILE_EXISTS, CONTAINS, etc.)
- [ ] Dependencies identified and resolved
- [ ] Technical approach discussed with team
- [ ] UI/UX designs available (if applicable)
- [ ] Required MCP tools documented (if applicable)
- [ ] Story is estimated and sized appropriately (max 5 files, 400 LOC)

### Definition of Done (DoD)

- [ ] Code implemented and follows style guide
- [ ] All acceptance criteria met (verified via Completion Check)
- [ ] Unit tests written and passing
- [ ] Integration tests written and passing
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] No linting errors
- [ ] Completion Check commands all pass

### Technical Notes

[TECHNICAL_NOTES]

### Completion Check

```bash
# Auto-Verify - All commands must exit with 0
[VERIFY_COMMAND_1]
[VERIFY_COMMAND_2]
```

**Story ist DONE wenn:**
1. Alle FILE_EXISTS/CONTAINS checks bestanden
2. Alle *_PASS commands exit 0
3. Git diff zeigt nur erwartete Änderungen

---

[ADDITIONAL_STORIES]

---

## Template Usage Instructions

### Placeholders

**Document Level**:
- `[SPEC_NAME]`: Name of the parent specification
- `[CREATED_DATE]`: ISO date format (YYYY-MM-DD)
- `[LAST_UPDATED_DATE]`: ISO date format (YYYY-MM-DD)
- `[STORY_COUNT]`: Total number of stories
- `[TOTAL_EFFORT]`: Sum of all story estimates

**Story Level**:
- `[STORY_NUMBER]`: Sequential number (1, 2, 3...)
- `[STORY_TITLE]`: Brief descriptive title
- `[STORY_ID]`: Unique identifier (e.g., PROF-001)
- `[PRIORITY]`: Critical, High, Medium, Low
- `[EFFORT_ESTIMATE]`: Story points (max S/3 SP for automation)
- `[DEPENDENCIES]`: Other story IDs or "None"
- `[USER_ROLE]`: The persona using this feature
- `[ACTION]`: What the user wants to do
- `[BENEFIT]`: Why this matters to the user

**Acceptance Criteria Prefixes**:
- `FILE_EXISTS:` - Verify file exists at path
- `FILE_NOT_EXISTS:` - Verify file does NOT exist
- `CONTAINS:` - Verify file contains text/pattern
- `NOT_CONTAINS:` - Verify file does NOT contain text
- `LINT_PASS:` - Verify lint command passes
- `TEST_PASS:` - Verify test command passes
- `BUILD_PASS:` - Verify build command passes
- `MCP_PLAYWRIGHT:` - Browser verification (requires MCP tool)
- `MCP_SCREENSHOT:` - Visual comparison (requires MCP tool)
- `MANUAL:` - Manual verification required (avoid if possible)

### Guidelines

**Story Sizing** (for automated execution):
- Max 5 files per story
- Max 400 LOC per story
- Max complexity: S (Small, 1-3 SP)
- Single concern per story
- See: agent-os/docs/story-sizing-guidelines.md

**Acceptance Criteria**:
- MUST use prefix format (FILE_EXISTS, CONTAINS, etc.)
- MUST be verifiable via bash commands
- MUST include exact file paths
- Avoid MANUAL criteria when possible

**MCP Tools**:
- Document required tools in "Required MCP Tools" section
- Include Pre-Flight Check command
- See: agent-os/docs/mcp-setup-guide.md

**Completion Check**:
- Include bash commands that verify story completion
- All commands must exit with code 0 for story to be DONE

### Example

```markdown
## Story 1: Create User Profile API

**ID**: PROF-001
**Priority**: High
**Estimated Effort**: S (2 SP)
**Dependencies**: None

### User Story

Als registered user
möchte ich meine Profildaten via API abrufen,
damit ich mein Profil in der App anzeigen kann.

### Akzeptanzkriterien (Prüfbar)

**Datei-Prüfungen:**
- [ ] FILE_EXISTS: src/api/profile/route.ts
- [ ] FILE_EXISTS: src/api/profile/route.test.ts

**Inhalt-Prüfungen:**
- [ ] CONTAINS: route.ts enthält "export async function GET"
- [ ] CONTAINS: route.ts enthält "currentUser"

**Funktions-Prüfungen:**
- [ ] LINT_PASS: npm run lint exits with 0
- [ ] TEST_PASS: npm test -- profile passes

### Required MCP Tools

_No MCP tools required for this story._

### Completion Check

\`\`\`bash
# Auto-Verify
test -f src/api/profile/route.ts && echo "FILE OK"
grep -q "export async function GET" src/api/profile/route.ts && echo "EXPORT OK"
npm run lint --quiet && echo "LINT OK"
npm test -- --grep "profile" && echo "TEST OK"
\`\`\`

**Story ist DONE wenn:**
1. Alle FILE_EXISTS/CONTAINS checks bestanden
2. Alle *_PASS commands exit 0
3. Git diff zeigt nur erwartete Änderungen
```
