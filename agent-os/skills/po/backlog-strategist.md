---
name: backlog-strategist
description: Manages product backlog prioritization and sprint planning
version: 1.0
---

# Backlog Strategist

Strategically manages product backlog, prioritizes features using value-based frameworks, and plans sprints aligned with business objectives.

## Trigger Conditions

```yaml
task_mentions:
  - "backlog|prioritize|priority"
  - "sprint planning|sprint|iteration"
  - "roadmap|release planning"
  - "user story|epic|feature"
file_extension:
  - .md
file_contains:
  - "## User Story"
  - "## Epic"
  - "Priority:"
always_active_for_agents:
  - po-agent
  - product-agent
```

## When to Load

- Backlog refinement sessions
- Sprint planning
- Priority decisions
- Roadmap updates

## Core Competencies

### Prioritization Frameworks

#### RICE Scoring
```
RICE = (Reach × Impact × Confidence) / Effort

| Factor | Scale | Definition |
|--------|-------|------------|
| Reach | Users/quarter | How many users affected |
| Impact | 0.25-3 | 0.25=minimal, 0.5=low, 1=medium, 2=high, 3=massive |
| Confidence | 0-100% | Data confidence level |
| Effort | Person-weeks | Development effort |
```

#### MoSCoW Method
```
M - Must Have    (Non-negotiable, critical for release)
S - Should Have  (Important but not vital)
C - Could Have   (Nice to have, if time permits)
W - Won't Have   (Explicitly excluded from scope)
```

#### Value vs. Effort Matrix
```
         HIGH VALUE
              │
    ┌─────────┼─────────┐
    │ Quick   │ Major   │
    │ Wins    │ Projects│
LOW ├─────────┼─────────┤ HIGH
EFFORT│ Fill-   │ Time    │ EFFORT
    │ ins     │ Sinks   │
    └─────────┼─────────┘
              │
         LOW VALUE
```

### User Story Format

```markdown
# Feature: [Feature Name]

## Epic
[Parent epic if applicable]

## User Story
As a [user type],
I want to [action/goal],
So that [benefit/value].

## Acceptance Criteria
- [ ] Given [precondition], when [action], then [result]
- [ ] Given [precondition], when [action], then [result]
- [ ] Given [precondition], when [action], then [result]

## Business Value
- **Impact**: [High/Medium/Low]
- **Reach**: [Number of users affected]
- **Revenue Impact**: [Direct/Indirect/None]

## Technical Notes
[Any technical considerations from architecture review]

## Dependencies
- [Dependency 1]
- [Dependency 2]

## Story Points
[Estimate from development team]

## Priority
RICE Score: [X]
MoSCoW: [M/S/C/W]
```

### Sprint Planning

```markdown
# Sprint [N] Planning

## Sprint Goal
[One sentence describing what this sprint achieves]

## Capacity
- Team capacity: [X] story points
- Available days: [Y] days
- Holidays/PTO: [List]

## Committed Items

### High Priority (Must Complete)
| ID | Story | Points | Owner |
|----|-------|--------|-------|
| US-001 | [Story title] | 5 | @dev1 |
| US-002 | [Story title] | 3 | @dev2 |

### Medium Priority (Should Complete)
| ID | Story | Points | Owner |
|----|-------|--------|-------|
| US-003 | [Story title] | 8 | @dev1 |

### Stretch Goals (If Capacity Allows)
| ID | Story | Points | Owner |
|----|-------|--------|-------|
| US-004 | [Story title] | 2 | TBD |

## Total Committed: [X] points

## Risks & Dependencies
- [Risk 1]: Mitigation plan
- [Dependency 1]: Status

## Definition of Done
[Link to DoD document]
```

## Best Practices

### Backlog Health Indicators

| Indicator | Healthy | Unhealthy |
|-----------|---------|-----------|
| Refinement rate | 2 sprints ahead | < 1 sprint |
| Story readiness | 80%+ meet DoR | < 60% ready |
| Estimation | All stories pointed | Many unestimated |
| Acceptance criteria | Clear, testable | Vague, missing |
| Dependencies | Mapped, managed | Unknown, blocking |

### Story Splitting Techniques

```
1. Workflow Steps
   "User can complete checkout" →
   - User can add shipping address
   - User can select payment method
   - User can review order
   - User can confirm purchase

2. Business Rules
   "Apply discounts" →
   - Apply percentage discount
   - Apply fixed amount discount
   - Apply buy-one-get-one discount

3. Data Variations
   "Import contacts" →
   - Import from CSV
   - Import from Excel
   - Import from vCard

4. Interface Complexity
   "Search products" →
   - Basic keyword search
   - Advanced filters
   - Search suggestions
```

### Stakeholder Communication

```markdown
## Release Notes Template

### [Version X.Y.Z] - [Date]

#### New Features
- **[Feature Name]**: [User-friendly description]
  - Benefit: [What users gain]
  - How to use: [Brief instructions]

#### Improvements
- [Improvement 1]
- [Improvement 2]

#### Bug Fixes
- Fixed issue where [problem] occurred when [action]

#### Coming Soon
- [Upcoming feature preview]
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| No prioritization | Everything is "urgent" | Use RICE/MoSCoW |
| Huge stories | Can't fit in sprint | Split stories |
| Missing acceptance criteria | Unclear done | Require AC before sprint |
| Scope creep | Sprint bloat | Protect sprint scope |
| No stakeholder input | Misaligned priorities | Regular stakeholder sync |

## Checklist

### Backlog Refinement
- [ ] Stories have clear acceptance criteria
- [ ] Stories are estimated
- [ ] Dependencies identified
- [ ] Technical feasibility confirmed
- [ ] 2 sprints worth of stories ready

### Sprint Planning
- [ ] Sprint goal defined
- [ ] Capacity calculated
- [ ] Stories assigned
- [ ] Dependencies resolved
- [ ] Team committed

### Release Planning
- [ ] Release scope defined
- [ ] Critical path identified
- [ ] Risks documented
- [ ] Stakeholders informed

## Integration

### Works With
- requirements-engineer (story details)
- acceptance-tester (acceptance criteria)
- data-analyst (metrics)

### Output
- Prioritized backlog
- Sprint plans
- Release notes
- Stakeholder updates
