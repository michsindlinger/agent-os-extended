# Kanban Board

> Spec: [SPEC_NAME]
> Created: [CREATED_DATE]
> Last Updated: [LAST_UPDATED_DATE]

## Board Overview

**Total Stories**: [TOTAL_STORIES]
**Completed**: [COMPLETED_COUNT]
**In Progress**: [IN_PROGRESS_COUNT]
**Remaining**: [REMAINING_COUNT]

**Progress**: [PROGRESS_PERCENTAGE]%

---

## Backlog

Stories ready to be picked up for work.

### [STORY_ID]: [STORY_TITLE]

**Priority**: [PRIORITY]
**Effort**: [EFFORT_ESTIMATE]
**Dependencies**: [DEPENDENCIES]
**Assigned To**: [ASSIGNEE]

**Description**: [BRIEF_DESCRIPTION]

**DoR Status**: [READY_NOT_READY]

---

[ADDITIONAL_BACKLOG_STORIES]

---

## In Progress

Stories currently being worked on.

### [STORY_ID]: [STORY_TITLE]

**Priority**: [PRIORITY]
**Effort**: [EFFORT_ESTIMATE]
**Started**: [START_DATE]
**Assigned To**: [ASSIGNEE]

**Description**: [BRIEF_DESCRIPTION]

**Progress Notes**: [PROGRESS_NOTES]

**Blockers**: [BLOCKERS_IF_ANY]

---

[ADDITIONAL_IN_PROGRESS_STORIES]

---

## In Review

Stories completed and awaiting review/testing.

### [STORY_ID]: [STORY_TITLE]

**Priority**: [PRIORITY]
**Effort**: [EFFORT_ESTIMATE]
**Completed**: [COMPLETION_DATE]
**Assigned To**: [ASSIGNEE]
**Reviewer**: [REVIEWER]

**Description**: [BRIEF_DESCRIPTION]

**PR Link**: [PR_URL]

**Review Status**: [REVIEW_STATUS]

---

[ADDITIONAL_REVIEW_STORIES]

---

## Done

Stories fully completed and deployed.

### [STORY_ID]: [STORY_TITLE]

**Priority**: [PRIORITY]
**Effort**: [EFFORT_ESTIMATE]
**Completed**: [COMPLETION_DATE]
**Deployed**: [DEPLOYMENT_DATE]
**Assigned To**: [ASSIGNEE]

**Description**: [BRIEF_DESCRIPTION]

**Outcome**: [OUTCOME_NOTES]

---

[ADDITIONAL_DONE_STORIES]

---

## Blocked

Stories that cannot proceed due to dependencies or issues.

### [STORY_ID]: [STORY_TITLE]

**Priority**: [PRIORITY]
**Effort**: [EFFORT_ESTIMATE]
**Blocked Since**: [BLOCKED_DATE]
**Assigned To**: [ASSIGNEE]

**Description**: [BRIEF_DESCRIPTION]

**Blocker Details**: [BLOCKER_DESCRIPTION]

**Resolution Plan**: [RESOLUTION_PLAN]

**Expected Unblock**: [UNBLOCK_DATE]

---

[ADDITIONAL_BLOCKED_STORIES]

---

## Board Metrics

### Velocity

- **Sprint 1**: [SPRINT_1_VELOCITY] points
- **Sprint 2**: [SPRINT_2_VELOCITY] points
- **Sprint 3**: [SPRINT_3_VELOCITY] points
- **Average**: [AVERAGE_VELOCITY] points

### Cycle Time

- **Average**: [AVERAGE_CYCLE_TIME] days
- **Fastest**: [FASTEST_CYCLE_TIME] days ([STORY_ID])
- **Slowest**: [SLOWEST_CYCLE_TIME] days ([STORY_ID])

### Lead Time

- **Average**: [AVERAGE_LEAD_TIME] days from Backlog to Done

---

## Template Usage Instructions

### Placeholders

**Board Overview**:
- `[SPEC_NAME]`: Parent specification name
- `[CREATED_DATE]`: ISO date format (YYYY-MM-DD)
- `[LAST_UPDATED_DATE]`: ISO date format (YYYY-MM-DD)
- `[TOTAL_STORIES]`: Total number of stories in spec
- `[COMPLETED_COUNT]`: Number of stories in Done
- `[IN_PROGRESS_COUNT]`: Number of stories in In Progress
- `[REMAINING_COUNT]`: Number of stories not started
- `[PROGRESS_PERCENTAGE]`: Completion percentage

**Story Cards**:
- `[STORY_ID]`: Unique story identifier
- `[STORY_TITLE]`: Story title
- `[PRIORITY]`: Critical, High, Medium, Low
- `[EFFORT_ESTIMATE]`: Story points or hours
- `[DEPENDENCIES]`: Other stories required
- `[ASSIGNEE]`: Person working on story
- `[BRIEF_DESCRIPTION]`: One-line summary
- `[DOR_STATUS]`: Ready, Not Ready, Blocked
- `[START_DATE]`: When work began
- `[PROGRESS_NOTES]`: Current status update
- `[BLOCKERS_IF_ANY]`: What's blocking progress
- `[COMPLETION_DATE]`: When story completed
- `[REVIEWER]`: Who's reviewing
- `[PR_URL]`: Pull request link
- `[REVIEW_STATUS]`: Pending, Changes Requested, Approved
- `[DEPLOYMENT_DATE]`: When deployed to production
- `[OUTCOME_NOTES]`: Results of completion
- `[BLOCKED_DATE]`: When blocking occurred
- `[BLOCKER_DESCRIPTION]`: Why blocked
- `[RESOLUTION_PLAN]`: How to unblock
- `[UNBLOCK_DATE]`: Expected resolution date

**Metrics**:
- `[SPRINT_X_VELOCITY]`: Points completed in sprint
- `[AVERAGE_VELOCITY]`: Average points per sprint
- `[AVERAGE_CYCLE_TIME]`: Average days from start to done
- `[FASTEST/SLOWEST_CYCLE_TIME]`: Min/max cycle times
- `[AVERAGE_LEAD_TIME]`: Average days from backlog to done

### Column Definitions

**Backlog**:
- Stories ready to start
- All DoR criteria met
- Dependencies resolved
- Prioritized order

**In Progress**:
- Work actively underway
- Should limit WIP (Work In Progress)
- Update progress notes regularly

**In Review**:
- Code complete, awaiting review
- PR submitted
- Tests passing
- Documentation updated

**Done**:
- All DoD criteria met
- Deployed to production
- Product owner accepted

**Blocked**:
- Cannot proceed
- Clear blocker identified
- Resolution plan documented
- Regular updates required

### Workflow Guidelines

**Moving Stories**:
1. Backlog → In Progress: Check DoR, assign developer
2. In Progress → In Review: Submit PR, all criteria met
3. In Review → Done: PR approved, deployed, tested
4. Any → Blocked: Document blocker immediately

**WIP Limits**:
- Recommended: 2-3 stories per developer
- Prevents context switching
- Encourages completion over starting

**Update Frequency**:
- Daily: Update In Progress notes
- Daily: Check for new blockers
- Weekly: Review board in team meeting
- Sprint: Move completed to Done

### Example

```markdown
# Kanban Board

> Spec: User Profile Management
> Created: 2026-01-09
> Last Updated: 2026-01-09

## Board Overview

**Total Stories**: 5
**Completed**: 1
**In Progress**: 2
**Remaining**: 1

**Progress**: 60%

---

## Backlog

Stories ready to be picked up for work.

### PROF-005: Configure Privacy Settings

**Priority**: Medium
**Effort**: 3 story points
**Dependencies**: None
**Assigned To**: Unassigned

**Description**: Allow users to control visibility of profile information.

**DoR Status**: Not Ready (awaiting UI designs)

---

## In Progress

Stories currently being worked on.

### PROF-003: Upload Profile Picture

**Priority**: High
**Effort**: 5 story points
**Started**: 2026-01-08
**Assigned To**: @developer-1

**Description**: Implement profile picture upload with cropping.

**Progress Notes**:
- ActiveStorage integration complete
- Working on Cropper.js client-side implementation
- Variant generation tested and working

**Blockers**: None

---

### PROF-004: Manage Notification Preferences

**Priority**: Medium
**Effort**: 3 story points
**Started**: 2026-01-09
**Assigned To**: @developer-2

**Description**: UI for managing email and push notification settings.

**Progress Notes**:
- Database schema complete
- Building React component for preferences UI

**Blockers**: None

---

## In Review

Stories completed and awaiting review/testing.

### PROF-002: Edit Profile Information

**Priority**: High
**Effort**: 3 story points
**Completed**: 2026-01-08
**Assigned To**: @developer-1
**Reviewer**: @tech-lead

**Description**: Form for editing name, bio, email, and phone number.

**PR Link**: https://github.com/org/repo/pull/123

**Review Status**: Changes Requested (validation feedback needed)

---

## Done

Stories fully completed and deployed.

### PROF-001: View Profile Information

**Priority**: High
**Effort**: 2 story points
**Completed**: 2026-01-07
**Deployed**: 2026-01-07
**Assigned To**: @developer-1

**Description**: Display user profile information on profile page.

**Outcome**: Successfully deployed. Users can now view their complete profile information with responsive layout.

---

## Blocked

No stories currently blocked.

---

## Board Metrics

### Velocity

- **Sprint 1**: 8 points
- **Sprint 2**: 10 points
- **Sprint 3**: [In progress]
- **Average**: 9 points

### Cycle Time

- **Average**: 2.5 days
- **Fastest**: 1 day (PROF-001)
- **Slowest**: 4 days (PROF-002)

### Lead Time

- **Average**: 3 days from Backlog to Done
```
