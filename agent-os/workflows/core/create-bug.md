# Create Bug Report - Core Instructions

## Overview
Create a structured bug report that enables systematic investigation and resolution. This command initiates an interactive process to gather all necessary information for effective bug tracking.

## Process Flow

### 1. Initial Information Gathering
Start by asking the user for:
- **Bug Title**: Short, descriptive title
- **Bug Description**: Detailed description of the issue
- **Severity Level**: Critical, High, Medium, Low
- **Priority**: Urgent, High, Normal, Low

### 2. Interactive Investigation Questions
Ask targeted questions to understand the bug context:

#### Environment & Context
- What environment does this occur in? (development, staging, production)
- What browser/platform/OS are you using?
- When did you first notice this issue?
- Does this happen consistently or intermittently?

#### Reproduction Steps
- What steps lead to this issue?
- What were you trying to accomplish?
- Can you reproduce it reliably?
- Are there any specific conditions needed?

#### Expected vs Actual Behavior
- What did you expect to happen?
- What actually happened instead?
- Are there any error messages or logs?

#### Impact Assessment
- Who is affected by this bug?
- What functionality is broken?
- Are there any workarounds available?

#### Technical Context
- Which components/modules might be involved?
- Are there any recent changes that could be related?
- Have you seen similar issues before?

### 3. Bug File Creation
Create a structured bug file in `agent-os/bugs/YYYY-MM-DD-bug-title/` with:

#### Structure:
```
agent-os/bugs/YYYY-MM-DD-bug-title/
├── bug-report.md          # Main bug documentation
├── investigation/         # Investigation notes and findings
├── reproduction/          # Steps and test cases for reproduction
└── resolution/           # Solution documentation (created during execution)
```

#### bug-report.md Template:
```markdown
# [Bug Title]

**Created**: [Date]
**Status**: Open | In Progress | Resolved | Closed
**Severity**: Critical | High | Medium | Low
**Priority**: Urgent | High | Normal | Low
**Assignee**: [If applicable]

## Summary
[Brief description of the bug]

## Environment
- **Platform**: [OS/Browser/Environment]
- **Version**: [Application/System version]
- **Context**: [Development/Staging/Production]

## Description
[Detailed description of the issue]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]
...

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Impact
- **Users Affected**: [Number or description]
- **Functionality Affected**: [What's broken]
- **Business Impact**: [Revenue, user experience, etc.]

## Error Messages/Logs
```
[Any error messages or relevant log entries]
```

## Additional Context
- **Related Components**: [List of involved modules/files]
- **Recent Changes**: [Any recent deployments or code changes]
- **Workarounds**: [Any available workarounds]

## Investigation Notes
[Space for investigation findings - populated during execute-bug]

## Resolution
[Solution details - populated when bug is resolved]

## Testing
[Test cases to verify the fix]

---
*Bug ID: [Generated unique ID]*
*Created with Agent OS Bug Management System*
```

### 4. Validation and Confirmation
Before creating the bug file:
- Review all gathered information with the user
- Confirm the severity and priority levels
- Ensure reproduction steps are clear
- Verify the bug title is descriptive

### 5. File System Organization
- Create the bug directory with timestamp format: `YYYY-MM-DD-bug-title`
- Generate a unique bug ID for tracking
- Create all necessary subdirectories
- Initialize the bug-report.md file

## Output
Confirm creation with:
- Bug directory path
- Bug ID for future reference
- Summary of key information
- Next steps (suggest using `execute-bug` command)

## Integration Notes
- Bug files are structured to integrate with `update-changelog` command
- Status tracking enables systematic workflow management
- Investigation directory supports collaborative debugging
- Resolution documentation enables knowledge sharing

## Error Handling
If insufficient information is provided:
- Ask clarifying questions
- Provide examples of good bug descriptions
- Guide user through the process step by step
- Don't create incomplete bug reports