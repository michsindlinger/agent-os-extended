# Execute Bug Resolution - Core Instructions

## Overview
Execute systematic bug investigation and resolution process. This command guides through debugging, fixing, testing, and documenting the solution for tracked bugs.

## Process Flow

### 1. Bug Selection and Loading
- List available bugs in `.agent-os/bugs/` directory
- Allow user to select by bug ID or directory name
- Load the bug-report.md file and review current status
- Verify bug is not already resolved

### 2. Investigation Phase

#### Code Analysis
- Examine the components mentioned in the bug report
- Search for related code patterns or similar issues
- Review recent changes that might be related
- Analyze error messages and stack traces

#### Reproduction Verification
- Follow the reproduction steps from the bug report
- Attempt to reproduce the issue in the development environment
- Document any variations in the reproduction process
- Update reproduction steps if needed

#### Root Cause Analysis
- Use systematic debugging approaches (logging, debugging tools)
- Trace the execution flow to identify the problem
- Document findings in `investigation/` directory
- Create investigation notes with timestamps

### 3. Solution Development

#### Fix Implementation
- Develop the appropriate fix based on root cause analysis
- Follow existing code conventions and patterns
- Ensure the fix addresses the root cause, not just symptoms
- Consider potential side effects and edge cases

#### Code Review Checklist
- Does the fix address the root cause?
- Are there any breaking changes?
- Is error handling appropriate?
- Are there any performance implications?
- Does it follow the project's coding standards?

### 4. Testing and Validation

#### Test Creation
- Create specific test cases for the bug scenario
- Ensure tests cover edge cases mentioned in the bug report
- Add regression tests to prevent future occurrences

#### Verification Process
- Run the reproduction steps to verify the fix
- Execute relevant test suites
- Perform manual testing if applicable
- Test in different environments if needed

### 5. Documentation and Closure

#### Resolution Documentation
Create resolution documentation in `resolution/` directory:

```markdown
# Bug Resolution - [Bug Title]

**Resolved Date**: [Date]
**Resolution Type**: Fix | Workaround | Won't Fix | Duplicate | Invalid
**Time to Resolution**: [Time spent]

## Root Cause
[Detailed explanation of what caused the bug]

## Solution Implemented
[Description of the fix]

## Files Changed
- [List of modified files with brief description of changes]

## Testing
- [Test cases created/executed]
- [Verification steps performed]

## Prevention Measures
[How to prevent similar issues in the future]

## Knowledge Gained
[Lessons learned from this bug investigation]
```

#### Update Bug Status
- Update the main bug-report.md status to "Resolved"
- Add resolution summary to the main bug file
- Link to detailed resolution documentation

### 6. Integration and Cleanup

#### Code Integration
- Ensure all changes are properly committed
- Create appropriate commit messages referencing the bug ID
- Consider creating a pull request if in team environment

#### Status Update
- Mark bug status as "Resolved" or "Closed"
- Add resolution date and summary
- Update any tracking systems or issue boards

## Interactive Workflow

### Step-by-Step Execution
1. **Load Bug**: Display bug details and current status
2. **Investigate**: Guide through systematic investigation
3. **Reproduce**: Verify the issue can be reproduced
4. **Analyze**: Help identify root cause
5. **Fix**: Implement and review the solution
6. **Test**: Validate the fix works correctly
7. **Document**: Create comprehensive resolution documentation
8. **Close**: Update status and summarize outcome

### User Interaction Points
- Confirm investigation findings
- Review proposed solutions before implementation
- Validate test results
- Approve final resolution documentation

## Directory Structure Management

### During Execution
Create and populate:
```
.agent-os/bugs/YYYY-MM-DD-bug-title/
├── bug-report.md          # Updated with resolution info
├── investigation/
│   ├── analysis-notes.md   # Investigation findings
│   ├── reproduction-log.md # Reproduction attempts
│   └── code-review.md     # Code analysis notes
├── reproduction/
│   ├── test-cases.md      # Test cases for reproduction
│   └── environment.md     # Environment setup notes
└── resolution/
    ├── solution.md        # Detailed solution documentation
    ├── testing.md         # Testing and validation results
    └── prevention.md      # Future prevention measures
```

## Status Tracking

### Status Transitions
- **Open** → **In Progress** (when execution starts)
- **In Progress** → **Resolved** (when fix is implemented and tested)
- **Resolved** → **Closed** (when thoroughly verified and documented)

### Progress Indicators
- Investigation progress (% complete)
- Solution implementation status
- Testing completion status
- Documentation completion status

## Integration with Other Commands

### Changelog Integration
- Resolved bugs are included in changelog generation
- Solution summaries are extracted for release notes
- Time to resolution metrics are tracked

### Knowledge Base
- Resolution documentation contributes to knowledge base
- Common patterns are identified for future prevention
- Best practices are documented and shared

## Error Handling and Edge Cases

### Bug Not Found
- List available bugs
- Provide clear error messages
- Suggest correct bug identifiers

### Cannot Reproduce
- Document attempts to reproduce
- Mark as "Cannot Reproduce" with details
- Provide guidance for gathering more information

### Complex Bugs
- Break down into smaller investigation tasks
- Create sub-issues if needed
- Document progress incrementally

### Dependencies
- Handle bugs that depend on external systems
- Document external dependencies
- Provide guidance for coordination with other teams

## Quality Assurance

### Before Closing Bug
- [ ] Root cause is clearly identified and documented
- [ ] Solution addresses the root cause
- [ ] Fix has been thoroughly tested
- [ ] Regression tests are in place
- [ ] Documentation is complete and accurate
- [ ] Prevention measures are identified
- [ ] All files are properly organized

### Success Criteria
- Bug no longer reproduces with original steps
- All tests pass
- Solution is well-documented
- Knowledge is captured for future reference