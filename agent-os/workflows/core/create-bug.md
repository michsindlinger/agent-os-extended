# Create Bug Specification - Core Instructions

## Overview

Create a structured bug specification that integrates with the standard feature workflow. Bug-Specs are created in `agent-os/specs/` and executed via `execute-tasks`, ensuring consistent quality gates, git management, and agent delegation.

**Key Principle:** Bugs are treated as "mini-features" with their own specifications, user-stories, and technical analysis - executed through the same workflow as features.

<pre_flight_check>
  EXECUTE: @~/.agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="initial_information_gathering">

### Step 1: Initial Information Gathering

Orchestrator collects basic bug information from user before delegating to PO Agent.

<information_collection>
  ASK user via AskUserQuestion:

  **Required Information:**
  - **Bug Title**: Short, descriptive title (will become spec name)
  - **Bug Description**: Detailed description of the issue
  - **Severity Level**: Critical | High | Medium | Low
  - **Priority**: Urgent | High | Normal | Low
  - **Environment**: Development | Staging | Production
  - **Bug Type** (for agent assignment): Backend | Frontend | DevOps | Full-Stack

  **Additional Context (ask if not provided):**
  - Reproduction steps
  - Expected vs actual behavior
  - Error messages or logs
  - Affected users/functionality
</information_collection>

<spec_naming>
  CREATE spec folder name:
    FORMAT: YYYY-MM-DD-bugfix-[bug-title-slug]
    EXAMPLE: 2026-01-12-bugfix-login-session-expires

  STORE: SPEC_FOLDER for subsequent steps
</spec_naming>

<instructions>
  ACTION: Gather initial bug information interactively
  CREATE: Spec folder name from bug title
  STORE: Information for PO Agent delegation
  VALIDATE: All required fields collected
</instructions>

</step>

<step number="2" name="po_agent_spec_creation">

### Step 2: PO Agent - Bug Spec Creation

Delegate to PO Agent to create the bug specification with user-stories.

<delegation>
  DELEGATE: dev-team__po OR product-strategist via Task tool

  PROMPT: "Create Bug Specification for: [Bug Title]

  **Initial Information:**
  - Title: [USER_PROVIDED_TITLE]
  - Description: [USER_PROVIDED_DESCRIPTION]
  - Severity: [SEVERITY]
  - Priority: [PRIORITY]
  - Environment: [ENVIRONMENT]
  - Bug Type: [BUG_TYPE]

  **Spec Folder:** agent-os/specs/[SPEC_FOLDER]/

  **Your Tasks:**

  1. Conduct interactive investigation by asking clarifying questions:
     - Browser/platform/OS being used?
     - When was issue first noticed?
     - Does it happen consistently or intermittently?
     - What steps lead to this issue?
     - What did you expect to happen?
     - What actually happened instead?
     - Any error messages or logs?
     - Who is affected by this bug?
     - Any workarounds available?

  2. Create Bug Spec Structure:

     **spec.md** (agent-os/specs/[SPEC_FOLDER]/spec.md):
     ```markdown
     # Bug Specification: [Bug Title]

     **Type**: Bug Fix
     **Created**: [DATE]
     **Severity**: [SEVERITY]
     **Priority**: [PRIORITY]
     **Status**: Open

     ## Problem Statement
     [Detailed description of the bug and its impact]

     ## Environment
     - Platform: [OS/Browser/Environment]
     - Version: [Application version if known]
     - Context: [Development/Staging/Production]

     ## Reproduction Steps
     1. [Step 1]
     2. [Step 2]
     3. [Step 3]

     ## Expected Behavior
     [What should happen]

     ## Actual Behavior
     [What actually happens]

     ## Impact Assessment
     - Users Affected: [Number or description]
     - Functionality Affected: [What's broken]
     - Business Impact: [Revenue, user experience, etc.]

     ## Error Messages/Logs
     ```
     [Any error messages or relevant log entries]
     ```

     ## Acceptance Criteria
     - [ ] Bug no longer reproducible with original steps
     - [ ] All existing tests pass
     - [ ] New regression test added
     - [ ] No side effects on related functionality
     ```

     **user-stories.md** (agent-os/specs/[SPEC_FOLDER]/user-stories.md):
     ```markdown
     # User Stories - [Bug Title]

     ## Overview
     Bug fix implementation stories for [Bug Title].

     ---

     ## Story 1: Investigate and Fix Root Cause

     ### Beschreibung
     Als Entwickler muss ich die Ursache des Bugs identifizieren und beheben,
     damit [expected behavior] wieder funktioniert.

     ### Fachliche Beschreibung
     Der Bug '[Bug Title]' verursacht [actual behavior] anstatt [expected behavior].
     Die Ursache muss identifiziert und eine Lösung implementiert werden.

     ### Technische Verfeinerung

     #### WAS (Anforderungen)
     - Root-Cause-Analyse durchführen
     - Fix implementieren, der die Ursache behebt (nicht nur Symptome)
     - Sicherstellen, dass keine Side-Effects entstehen

     #### WIE (Implementierung)
     - [To be refined by Architect in technical-spec.md]

     #### WO (Betroffene Dateien)
     - [To be refined by Architect in technical-spec.md]

     #### WER (Zuständigkeit)
     - **Primary**: [BUG_TYPE]-developer
     - **Review**: Architect

     ### Definition of Ready (DoR)
     - [ ] Bug-Beschreibung verstanden
     - [ ] Reproduction Steps verifiziert
     - [ ] Betroffene Komponenten identifiziert
     - [ ] Technical-Spec vom Architekten vorhanden

     ### Definition of Done (DoD)
     - [ ] Root-Cause dokumentiert
     - [ ] Fix implementiert
     - [ ] Bug nicht mehr reproduzierbar
     - [ ] Keine Regression in bestehenden Tests
     - [ ] Architect Review bestanden

     ### Story Points
     [To be estimated]

     ### Dependencies
     None

     ---

     ## Story 2: Add Regression Test

     ### Beschreibung
     Als QA-Spezialist muss ich einen Regression-Test erstellen,
     damit dieser Bug in Zukunft automatisch erkannt wird.

     ### Fachliche Beschreibung
     Ein automatisierter Test muss erstellt werden, der das ursprüngliche
     Bug-Szenario abdeckt und bei Regression fehlschlägt.

     ### Technische Verfeinerung

     #### WAS (Anforderungen)
     - Test erstellen, der das Bug-Szenario reproduziert
     - Test muss fehlschlagen wenn Bug wieder auftritt
     - Test muss bestehen mit dem Fix

     #### WIE (Implementierung)
     - [Based on project test framework]

     #### WO (Betroffene Dateien)
     - [Test file location based on bug type]

     #### WER (Zuständigkeit)
     - **Primary**: QA-Specialist OR [BUG_TYPE]-developer
     - **Review**: Architect

     ### Definition of Ready (DoR)
     - [ ] Story 1 abgeschlossen
     - [ ] Bug-Szenario klar definiert
     - [ ] Test-Strategie festgelegt

     ### Definition of Done (DoD)
     - [ ] Regression-Test implementiert
     - [ ] Test besteht mit Fix
     - [ ] Test schlägt fehl ohne Fix (verifiziert)
     - [ ] Test in CI integriert

     ### Story Points
     [To be estimated]

     ### Dependencies
     - Story 1 (Bug Fix)
     ```

  3. Create spec-lite.md (summary version):
     ```markdown
     # Bug: [Bug Title]

     **Severity**: [SEVERITY] | **Priority**: [PRIORITY] | **Type**: [BUG_TYPE]

     ## Problem
     [One paragraph summary]

     ## Fix Scope
     - 2 Stories: Bug Fix + Regression Test
     - Assigned Agent: [BUG_TYPE]-developer

     ## Acceptance
     - Bug no longer reproducible
     - Regression test added
     ```

  **Deliverable:**
  - Created spec folder with spec.md, user-stories.md, spec-lite.md
  - Report path back to orchestrator"
</delegation>

<po_validation>
  WAIT: For PO Agent completion
  VERIFY: Spec folder created
  VERIFY: spec.md, user-stories.md, spec-lite.md exist
  STORE: SPEC_FOLDER_PATH for Architect step
</po_validation>

<instructions>
  ACTION: Delegate to PO Agent for spec creation
  WAIT: For completion
  VALIDATE: Bug spec created correctly with user-stories
  PROCEED: To Architect technical analysis
</instructions>

</step>

<step number="3" name="architect_technical_analysis">

### Step 3: Architect - Technical Analysis

Delegate to Architect for technical analysis, identifying affected components and refining user-stories.

<delegation>
  DELEGATE: dev-team__architect OR tech-architect via Task tool

  PROMPT: "Technical Analysis for Bug Spec: [Bug Title]

  **Spec Location:** agent-os/specs/[SPEC_FOLDER]/

  **Your Tasks:**

  1. Read the bug spec created by PO Agent:
     - spec.md for bug context
     - user-stories.md for story structure

  2. Conduct Technical Analysis:
     - Identify affected components/modules in codebase
     - Analyze potential root causes
     - Review related code areas
     - Check for similar past issues
     - Assess complexity of fix

  3. Create sub-specs/technical-spec.md:
     ```markdown
     # Technical Specification - [Bug Title]

     ## Root Cause Analysis

     ### Suspected Root Cause
     [Analysis of what's likely causing the bug]

     ### Related Code Areas
     - [File 1]: [Why it's related]
     - [File 2]: [Why it's related]

     ### Similar Past Issues
     - [Any similar bugs or patterns found]

     ## Technical Approach

     ### Investigation Strategy
     1. [Step to verify root cause]
     2. [Step to isolate the issue]

     ### Fix Strategy
     [Recommended approach to fix the bug]

     ### Risk Assessment
     - **Complexity**: Simple | Medium | Complex
     - **Side Effect Risk**: Low | Medium | High
     - **Areas to Test**: [List components that need testing]

     ## Story Refinements

     ### Story 1: Bug Fix
     **WIE (Implementation):**
     - [Specific implementation steps]
     - [Code patterns to follow]

     **WO (Affected Files):**
     - `[file-path-1]` - [what to change]
     - `[file-path-2]` - [what to change]

     ### Story 2: Regression Test
     **WO (Test Files):**
     - `[test-file-path]` - [test to add]

     ## Estimation
     - Story 1 (Bug Fix): [X] Story Points
     - Story 2 (Regression Test): [Y] Story Points
     - Total: [X+Y] Story Points
     ```

  4. Update user-stories.md:
     - Fill in WIE sections with implementation details
     - Fill in WO sections with specific file paths
     - Add Story Point estimates
     - Update DoR to reflect technical readiness

  **Deliverable:**
  - Technical spec created at sub-specs/technical-spec.md
  - User-stories.md updated with technical details
  - Complexity and estimation provided"
</delegation>

<architect_validation>
  WAIT: For Architect completion
  VERIFY: technical-spec.md created
  VERIFY: user-stories.md updated with technical details
</architect_validation>

<instructions>
  ACTION: Delegate to Architect for technical analysis
  WAIT: For completion
  VALIDATE: Technical spec complete
  PROCEED: To completion step
</instructions>

</step>

<step number="4" name="completion_summary">

### Step 4: Completion Summary

Provide comprehensive summary to user with next steps.

<summary_template>
  ## ✅ Bug Specification Created

  **Spec Location:** agent-os/specs/[SPEC_FOLDER]/

  ## 📋 Summary

  - **Bug Title:** [Bug Title]
  - **Severity:** [Severity]
  - **Priority:** [Priority]
  - **Type:** [Bug Type]
  - **Complexity:** [Simple/Medium/Complex from Architect]
  - **Estimated:** [X] Story Points

  ## 📁 Created Files

  - `spec.md` - Bug specification
  - `user-stories.md` - Implementation stories (2 stories)
  - `spec-lite.md` - Quick summary
  - `sub-specs/technical-spec.md` - Technical analysis

  ## 📊 Stories

  | # | Story | Agent | Points |
  |---|-------|-------|--------|
  | 1 | Investigate and Fix Root Cause | [BUG_TYPE]-dev | [X] |
  | 2 | Add Regression Test | QA-Specialist | [Y] |

  ## ▶️ Next Steps

  Run `/execute-tasks [SPEC_FOLDER]` to start bug resolution.

  The execute-tasks workflow will:
  - Create git branch: `bugfix/[bug-name]`
  - Assign appropriate agents based on bug type
  - Enforce quality gates (Architect + QA review)
  - Create kanban board for tracking
  - Commit and push changes
</summary_template>

<instructions>
  ACTION: Display completion summary
  INCLUDE: All created artifacts
  HIGHLIGHT: Next steps with execute-tasks command
</instructions>

</step>

</process_flow>

## Directory Structure

Bug specs follow the standard spec structure:

```
agent-os/specs/YYYY-MM-DD-bugfix-[bug-name]/
├── spec.md                    # Bug specification (by PO)
├── spec-lite.md              # Quick summary
├── user-stories.md           # Bug fix stories (by PO)
├── sub-specs/
│   └── technical-spec.md     # Technical analysis (by Architect)
├── kanban-board.md           # Created by execute-tasks
├── implementation-reports/   # Created during execution
└── handover-docs/            # If needed for dependencies
```

## Integration with execute-tasks

When running `/execute-tasks` on a bug spec:

1. **Git Branch**: Creates `bugfix/[bug-name]` instead of feature branch
2. **Agent Assignment**: Uses Bug Type field to select agent
3. **Quality Gates**: Same Architect + QA review as features
4. **Kanban Board**: Tracks bug stories like feature stories
5. **Commits**: Uses `fix:` prefix in commit messages

## Error Handling

<error_protocols>
  <missing_po_agent>
    IF dev-team__po not available:
      USE: product-strategist as fallback
      NOTIFY: User of fallback
  </missing_po_agent>

  <missing_architect>
    IF dev-team__architect not available:
      USE: tech-architect as fallback
      NOTIFY: User of fallback
  </missing_architect>

  <insufficient_information>
    ACTION: Ask clarifying questions
    PROVIDE: Examples of good bug descriptions
    GUIDE: User through process step by step
    RULE: Never create incomplete bug specs
  </insufficient_information>
</error_protocols>

## Quality Checklist

<final_checklist>
  <verify>
    - [ ] Bug information collected completely
    - [ ] Spec folder created with correct naming
    - [ ] spec.md contains full bug context
    - [ ] user-stories.md contains implementation stories
    - [ ] spec-lite.md provides quick summary
    - [ ] technical-spec.md contains Architect analysis
    - [ ] Stories have DoR and DoD defined
    - [ ] Story Points estimated
    - [ ] Next steps provided to user
  </verify>
</final_checklist>
