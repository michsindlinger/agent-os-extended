---
description: Add bug to backlog with hypothesis-driven root-cause analysis
globs:
alwaysApply: false
version: 2.2
encoding: UTF-8
---

# Add Bug Workflow

## Overview

Add a bug to the backlog with structured root-cause analysis. Uses hypothesis-driven debugging to identify the actual cause before creating the fix story.

**Key Difference to /add-todo:**
- Includes systematic Root-Cause-Analyse (RCA)
- 3 Hypothesen mit Wahrscheinlichkeiten
- Zuständiger Agent prüft jede Hypothese
- Dokumentierter Analyseprozess

<pre_flight_check>
  EXECUTE: agent-os/workflows/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="backlog_setup">

### Step 1: Backlog Setup

<mandatory_actions>
  1. CHECK: Does agent-os/backlog/ directory exist?
     ```bash
     ls -la agent-os/backlog/ 2>/dev/null
     ```

  2. IF NOT exists:
     CREATE: agent-os/backlog/ directory
     CREATE: agent-os/backlog/story-index.md (from template)

     <template_lookup>
       PATH: backlog-story-index-template.md

       LOOKUP STRATEGY (MUST TRY BOTH):
         1. READ: agent-os/templates/docs/backlog-story-index-template.md
         2. IF file not found OR read error:
            READ: ~/.agent-os/templates/docs/backlog-story-index-template.md
         3. IF both fail: Error - run setup-devteam-global.sh

       ⚠️ WICHTIG: Bei "Error reading file" IMMER den Fallback-Pfad versuchen!
     </template_lookup>

  3. USE: date-checker to get current date (YYYY-MM-DD)

  4. DETERMINE: Next bug index for today
     COUNT: Existing bugs with today's date prefix
     ```bash
     ls agent-os/backlog/ | grep "^bug-$(date +%Y-%m-%d)" | wc -l
     ```
     NEXT_INDEX = count + 1 (formatted as 3 digits: 001, 002, etc.)

  5. GENERATE: Bug ID = YYYY-MM-DD-[INDEX]
     Example: 2025-01-15-001, 2025-01-15-002
</mandatory_actions>

</step>

<step number="2" name="bug_description">

### Step 2: Bug Description (PO Phase)

Gather structured bug information from user.

<mandatory_actions>
  1. IF user provided bug description in command:
     EXTRACT: Bug description from input

  2. ASK structured questions:

     **Symptom:**
     - Was genau passiert? (Fehlermeldung, falsches Verhalten, etc.)

     **Reproduktion:**
     - Wie kann der Bug reproduziert werden?
     - Schritt-für-Schritt Anleitung

     **Expected vs. Actual:**
     - Was sollte passieren? (Expected)
     - Was passiert stattdessen? (Actual)

     **Kontext:**
     - Welche Komponente/Seite ist betroffen?
     - Wann tritt es auf? (immer, manchmal, nach bestimmter Aktion)
     - Gibt es Fehlermeldungen in Console/Logs?

  3. DETERMINE: Bug-Typ
     - Frontend (UI, JavaScript, Styling)
     - Backend (API, Logik, Database)
     - DevOps (Build, Deployment, Infrastructure)
     - Integration (Zusammenspiel mehrerer Komponenten)

  4. DETERMINE: Severity
     - Critical: System unbenutzbar
     - High: Wichtige Funktion kaputt
     - Medium: Funktion eingeschränkt
     - Low: Kosmetisch oder Workaround vorhanden
</mandatory_actions>

</step>

<step number="3" name="hypothesis_driven_rca">

### Step 3: Hypothesis-Driven Root-Cause-Analyse

⚠️ **KERNSTÜCK:** Systematische Fehleranalyse statt blindes Suchen.

<determine_agent>
  BASED ON bug_type (from Step 2):

  IF bug_type = "Frontend":
    AGENT = dev-team__frontend-developer-*
  ELSE IF bug_type = "Backend":
    AGENT = dev-team__backend-developer-*
  ELSE IF bug_type = "DevOps":
    AGENT = dev-team__devops-specialist
  ELSE IF bug_type = "Integration":
    AGENT = dev-team__architect

  FALLBACK: If specific agent not available, use dev-team__architect
</determine_agent>

<delegation>
  DELEGATE to [AGENT] via Task tool:

  PROMPT:
  "Führe eine Hypothesis-Driven Root-Cause-Analyse durch.

  **Bug-Symptom:**
  [Bug description from Step 2]

  **Reproduktionsschritte:**
  [Steps from Step 2]

  **Expected:** [Expected behavior]
  **Actual:** [Actual behavior]

  **Betroffene Komponente:** [Component]

  ---

  ## Deine Aufgabe: Root-Cause-Analyse

  ### Phase 1: Hypothesen aufstellen

  Basierend auf dem Symptom, stelle 3 wahrscheinliche Ursachen auf.
  Ordne jeder Hypothese eine Wahrscheinlichkeit zu (muss 100% ergeben).

  FORMAT:
  | # | Hypothese | Wahrscheinlichkeit | Prüfmethode |
  |---|-----------|-------------------|-------------|
  | 1 | [Vermutung] | XX% | [Wie prüfen - konkret] |
  | 2 | [Vermutung] | XX% | [Wie prüfen - konkret] |
  | 3 | [Vermutung] | XX% | [Wie prüfen - konkret] |

  REGELN für Hypothesen:
  - Beginne mit der wahrscheinlichsten Ursache (höchster %)
  - Hypothesen müssen prüfbar sein
  - Prüfmethode muss konkret sein (Datei lesen, Log prüfen, Code analysieren)
  - Keine vagen Vermutungen ('irgendwo im Code')

  ### Phase 2: Hypothesen prüfen

  Prüfe jede Hypothese der Reihe nach (höchste Wahrscheinlichkeit zuerst).

  FORMAT für jede Prüfung:
  ```
  **Hypothese X prüfen:** [Hypothese]
  - Aktion: [Was du konkret geprüft hast]
  - Befund: [Was du gefunden hast - Code-Snippets, Logs, etc.]
  - Ergebnis: ❌ Ausgeschlossen / ✅ BESTÄTIGT
  - Begründung: [Warum ausgeschlossen oder bestätigt]
  ```

  REGELN für Prüfung:
  - Prüfe TATSÄCHLICH (lies Code, prüfe Logs, analysiere Daten)
  - Dokumentiere konkrete Befunde (Zeilen, Werte, Fehlermeldungen)
  - Stoppe wenn Root Cause gefunden (✅ BESTÄTIGT)
  - Wenn H1 ausgeschlossen → H2 prüfen → H3 prüfen

  ### Phase 3: Root Cause dokumentieren

  Wenn Root Cause gefunden:

  ```
  ## ROOT CAUSE

  **Ursache:** [Klare Beschreibung der Ursache]

  **Beweis:** [Konkreter Nachweis - Code, Logs, etc.]

  **Betroffene Dateien:**
  - [Datei 1]: [Was ist dort falsch]
  - [Datei 2]: [Was ist dort falsch]

  **Fix-Ansatz:** [Kurze Beschreibung wie zu beheben]
  ```

  ### Falls KEINE Hypothese bestätigt:

  Wenn alle 3 Hypothesen ausgeschlossen:
  1. Stelle 3 NEUE Hypothesen auf (andere Richtung)
  2. Wiederhole Prüfung
  3. Maximal 2 Runden, dann eskalieren an User

  ---

  WICHTIG:
  - Sei gründlich aber effizient
  - Dokumentiere jeden Schritt
  - Finde die ECHTE Ursache, nicht nur Symptome
  - Gib mir am Ende den vollständigen Analyse-Bericht zurück"

  WAIT for agent completion

  RECEIVE: Root-Cause-Analyse Bericht
</delegation>

</step>

<step number="3.5" name="fix_impact_layer_analysis">

### Step 3.5: Fix-Impact Layer Analysis (NEU)

⚠️ **PFLICHT:** Basierend auf RCA analysieren, welche Layer vom Fix betroffen sind.

<mandatory_actions>
  1. EXTRACT from RCA (Step 3):
     - Root Cause (confirmed hypothesis)
     - Betroffene Dateien (from analysis)
     - Fix-Ansatz (proposed fix)

  2. ANALYZE fix impact across layers:
     ```
     Fix-Impact Layer Checklist:
     - [ ] Frontend (UI behavior, components, state)
     - [ ] Backend (API response, services, logic)
     - [ ] Database (data integrity, queries)
     - [ ] Integration (connections between layers)
     - [ ] Tests (affected test files)
     ```

  3. FOR EACH potentially affected layer:
     ASSESS:
     - Direct impact: Layer where bug originates
     - Indirect impact: Layers that depend on the fix
     - Test coverage: Tests that verify the fix

  4. IDENTIFY Integration Points:
     IF bug fix affects data flow between layers:
       DOCUMENT: Connection points that need verification
       Example: "Backend API response change → Frontend must handle new field"

  5. DETERMINE Fix Scope:
     - IF only 1 layer affected: "[Layer]-only fix"
     - IF 2+ layers affected: "Full-stack fix"
       ⚠️ WARNING: "Full-stack bug fix - ensure all layers are updated"

  6. GENERATE Fix-Impact Summary:
     ```
     Fix Type: [Backend-only / Frontend-only / Full-stack]
     Affected Layers:
       - [Layer 1]: [Direct/Indirect] - [Impact description]
       - [Layer 2]: [Direct/Indirect] - [Impact description]
     Critical Integration Points:
       - [Point 1]: [Source] → [Target] - [Needs verification]
     Required Tests:
       - [Test scope per layer]
     ```

  7. PASS Fix-Impact Summary to:
     - Step 4 (Bug Story File creation)
     - Step 5 (Architect Refinement)
</mandatory_actions>

<output>
  Fix-Impact Summary:
  - Fix Type (scope)
  - Affected Layers with direct/indirect impact
  - Critical Integration Points
  - Required test coverage per layer
</output>

</step>

<step number="4" name="create_bug_story">

### Step 4: Create Bug Story File

<mandatory_actions>
  1. GENERATE: File name
     FORMAT: bug-[YYYY-MM-DD]-[INDEX]-[slug].md
     Example: bug-2025-01-15-001-login-after-reset.md

  2. CREATE bug story file with RCA included:

     <bug_story_template>
       # 🐛 [BUG_TITLE]

       > Bug ID: [BUG_ID]
       > Created: [DATE]
       > Severity: [SEVERITY]
       > Status: Ready

       **Priority**: [PRIORITY]
       **Type**: Bug - [Frontend/Backend/DevOps]
       **Affected Component**: [COMPONENT]

       ---

       ## Bug Description

       ### Symptom
       [Bug symptom description]

       ### Reproduktion
       1. [Step 1]
       2. [Step 2]
       3. [Step 3]

       ### Expected vs. Actual
       - **Expected:** [What should happen]
       - **Actual:** [What happens instead]

       ---

       ## Root-Cause-Analyse

       ### Hypothesen (vor Analyse)

       | # | Hypothese | Wahrscheinlichkeit | Prüfmethode |
       |---|-----------|-------------------|-------------|
       | 1 | [H1] | XX% | [Method] |
       | 2 | [H2] | XX% | [Method] |
       | 3 | [H3] | XX% | [Method] |

       ### Prüfung

       **Hypothese 1 prüfen:** [H1]
       - Aktion: [What was checked]
       - Befund: [What was found]
       - Ergebnis: [❌/✅]
       - Begründung: [Why]

       [... weitere Hypothesen ...]

       ### Root Cause

       **Ursache:** [Root cause description]

       **Beweis:** [Evidence]

       **Betroffene Dateien:**
       - [File 1]
       - [File 2]

       ---

       ## User Story (Fix)

       Als [USER_ROLE]
       möchte ich dass [BUG] behoben wird,
       damit [BENEFIT/EXPECTED_BEHAVIOR].

       ---

       ## Akzeptanzkriterien

       - [ ] BUG_FIXED: [Description of fix verification]
       - [ ] TEST_PASS: Regression test added and passing
       - [ ] LINT_PASS: No linting errors
       - [ ] MANUAL: Bug no longer reproducible with original steps

       ---

       ## Technisches Refinement (vom Architect)

       > **⚠️ WICHTIG:** Dieser Abschnitt wird vom Architect ausgefüllt

       ### DoR (Definition of Ready) - Vom Architect

       #### Bug-Analyse
       - [x] Bug reproduzierbar
       - [x] Root Cause identifiziert
       - [x] Betroffene Dateien bekannt

       #### Technische Vorbereitung
       - [ ] Fix-Ansatz definiert (WAS/WIE/WO)
       - [ ] Abhängigkeiten identifiziert
       - [ ] Risiken bewertet

       **Bug ist READY wenn alle Checkboxen angehakt sind.**

       ---

       ### DoD (Definition of Done) - Vom Architect

       - [ ] Bug behoben gemäß Root Cause
       - [ ] Regression Test hinzugefügt
       - [ ] Keine neuen Bugs eingeführt
       - [ ] Code Review durchgeführt
       - [ ] Original Reproduktionsschritte führen nicht mehr zum Bug

       **Bug ist DONE wenn alle Checkboxen angehakt sind.**

       ---

       ### Betroffene Layer & Komponenten (Fix-Impact)

       > **PFLICHT:** Basierend auf Fix-Impact Analysis (Step 3.5)

       **Fix Type:** [Backend-only / Frontend-only / Full-stack]

       **Betroffene Komponenten:**

       | Layer | Komponenten | Impact | Änderung |
       |-------|-------------|--------|----------|
       | [Layer] | [components] | Direct/Indirect | [Fix description] |

       **Kritische Integration Points:**
       - [Point]: [Source] → [Target] - [Verification needed]

       ---

       ### Technical Details

       **WAS:** [What needs to be fixed - based on Root Cause]

       **WIE (Architektur-Guidance ONLY):**
       - [Fix approach based on RCA]
       - [Constraints to respect]

       **WO:** [Files to modify - MUST cover ALL layers from Fix-Impact Analysis!]

       **WER:** [Agent based on bug type]

       **Abhängigkeiten:** None

       **Geschätzte Komplexität:** [XS/S/M based on RCA]

       ---

       ### Completion Check

       ```bash
       # Verify bug is fixed
       [VERIFY_COMMAND based on bug type]
       ```

       **Bug ist DONE wenn:**
       1. Original Reproduktionsschritte funktionieren korrekt
       2. Regression Test besteht
       3. Keine verwandten Fehler auftreten
     </bug_story_template>

  3. FILL in all fields from:
     - Step 2 (Bug Description)
     - Step 3 (RCA - vollständig übernehmen)

  4. LEAVE Architect sections partially empty (Step 5 fills them)

  5. WRITE: Bug file to agent-os/backlog/
</mandatory_actions>

</step>

<step number="5" subagent="dev-team__architect" name="architect_refinement">

### Step 5: Architect Phase - Technical Refinement

<delegation>
  DELEGATE to dev-team__architect via Task tool:

  PROMPT:
  "Add technical refinement to bug story.

  Bug File: agent-os/backlog/bug-[YYYY-MM-DD]-[INDEX]-[slug].md

  **Fix-Impact Summary (aus Step 3.5):**
  [FIX_IMPACT_SUMMARY]
  - Fix Type: [TYPE]
  - Affected Layers: [LAYERS with direct/indirect impact]
  - Critical Integration Points: [POINTS]
  - Required Tests: [TEST_COVERAGE]

  Context:
  - Root Cause bereits identifiziert (in Bug Story)
  - Fix-Impact Analysis abgeschlossen (Step 3.5)
  - Tech Stack: agent-os/product/tech-stack.md
  - Architecture: agent-os/product/architecture-decision.md (if exists)
  - Definition of Ready: agent-os/team/dor.md (if exists)
  - Definition of Done: agent-os/team/dod.md (if exists)

  Tasks:
  1. READ the bug story file (especially Root Cause section)
  1.5. REVIEW Fix-Impact Summary - ensure ALL layers are addressed
  2. LOAD project quality definitions:
     - DoR from agent-os/team/dor.md (if exists)
     - DoD from agent-os/team/dod.md (if exists)
  3. BASED ON the identified Root Cause AND Fix-Impact Summary:

     **Betroffene Layer & Komponenten ausfüllen (NEU - PFLICHT):**
     Based on Fix-Impact Summary, fill out:
     - Fix Type: [Backend-only / Frontend-only / Full-stack]
     - Betroffene Komponenten Table with Direct/Indirect impact
     - Kritische Integration Points (if Full-stack fix)

     ⚠️ WICHTIG: If Fix Type = "Full-stack":
       - ENSURE WO section covers ALL affected layers
       - DOCUMENT integration points that need verification
       - Consider if fix should be split into multiple bugs (one per layer)

     **DoR vervollständigen:**
     - Apply relevant DoR criteria from project dor.md
     - Mark technical preparation items as [x]
     - Mark Full-Stack Konsistenz items as [x] (NEW)

     **Technical Details ausfüllen:**
     - WAS: What needs to be fixed (based on Root Cause)
     - WIE: Fix approach (architecture guidance only, NO code)
     - WO: Files to modify (MUST cover ALL layers from Fix-Impact Analysis!)
     - WER: Which agent (based on bug type)
     - Geschätzte Komplexität: XS/S/M (bugs should be small)

     **Completion Check:**
     - Add specific bash commands to verify fix

  3. IF bug seems too complex (>3 files, requires architectural changes):
     WARN: 'This bug may require a full spec. Consider /create-spec instead.'
     ASK: 'Proceed as bug or create spec?'

  IMPORTANT:
  - Root Cause is already identified - don't re-analyze
  - Focus on HOW to fix, not WHAT is wrong
  - Keep it lightweight - this is a bug fix, not a feature
  - Mark ALL DoR checkboxes as [x] when complete"

  WAIT for dev-team__architect completion
</delegation>

</step>

<step number="5.5" name="bug_size_validation">

### Step 5.5: Bug Size Validation

Validate that the bug fix complies with size guidelines for single-session execution.

<validation_process>
  READ: The bug file from agent-os/backlog/bug-[...].md

  <extract_metrics>
    ANALYZE: WO (Where) field
      COUNT: Number of file paths mentioned
      EXTRACT: File paths list

    ANALYZE: Geschätzte Komplexität field
      EXTRACT: Complexity rating (XS/S/M/L/XL)

    ANALYZE: Root Cause section
      ASSESS: Is this a localized bug or systemic issue?
      CHECK: Number of "Betroffene Dateien"

    ANALYZE: WAS (What) field
      ESTIMATE: Lines of code for fix
      HEURISTIC:
        - Simple fix (1-2 files) ~50-100 lines
        - Medium fix (3-4 files) ~150-250 lines
        - Complex fix (5+ files) ~300+ lines
  </extract_metrics>

  <check_thresholds>
    CHECK: Number of affected files
      IF files > 5:
        FLAG: Bug as "Too Large - Affects Too Many Files"
        SEVERITY: High

    CHECK: Complexity rating
      IF complexity in [L, XL]:
        FLAG: Bug as "Too Complex for /add-bug"
        SEVERITY: High
      ELSE IF complexity = M:
        FLAG: Bug as "Borderline Complexity"
        SEVERITY: Medium

    CHECK: Estimated LOC
      IF estimated_loc > 400:
        FLAG: Bug as "Too Large - Code Volume"
        SEVERITY: High
      ELSE IF estimated_loc > 250:
        FLAG: Bug as "Watch - Approaching Limit"
        SEVERITY: Low

    CHECK: Systemic issue detection
      IF Root Cause mentions "architectural", "design flaw", or "multiple components":
        FLAG: Bug as "Systemic Issue"
        SEVERITY: High
        SUGGEST: "Consider /create-spec for architectural fixes"

    CHECK: Full-Stack Fix Coverage (Enhanced)
      EXTRACT: "Betroffene Layer & Komponenten" section
      IF Fix Type = "Full-stack":
        CHECK: WO section covers ALL layers from "Betroffene Komponenten" table
        IF missing_layers detected:
          FLAG: Bug as "Incomplete Full-Stack Fix"
          SEVERITY: Critical
          LIST: "Missing file paths for layers: [missing_layers]"
          WARN: "Bug fix does not cover all affected layers - risk of partial fix!"
          SUGGEST: "Add ALL layer files to WO section OR split into multiple bugs"

        CHECK: Integration Points coverage
        IF Critical Integration Points defined:
          VERIFY: Each integration point has source AND target in WO
          IF missing_connections:
            FLAG: Bug as "Missing Integration Coverage"
            SEVERITY: High
            LIST: "Integration points not fully covered: [points]"
            WARN: "Fix may break integration between layers"
  </check_thresholds>
</validation_process>

<decision_tree>
  IF no flags raised OR only low severity:
    LOG: "✅ Bug passes size validation - appropriate for /add-bug"
    PROCEED: To Step 6 (Update Story Index)

  ELSE (bug flagged with Medium/High severity):
    GENERATE: Validation Report

    <validation_report_format>
      ⚠️ Bug Size Validation - Issues Detected

      **Bug:** 🐛 [Bug Title]
      **File:** [Bug file path]
      **Root Cause:** [Brief RC description]

      **Metrics:**
      - Affected Files: [count] (max recommended: 5) [✅/❌]
      - Complexity: [rating] (max recommended: S, tolerated: M) [✅/⚠️/❌]
      - Est. LOC for Fix: ~[count] (max recommended: 400) [✅/❌]
      - Systemic Issue: [Yes/No] [✅/❌]

      **Issue:** [Description of what exceeds guidelines]

      **Why this matters:**
      - /add-bug is designed for localized, contained bug fixes
      - Systemic issues need proper planning to avoid introducing new bugs
      - Complex fixes benefit from story splitting and integration testing

      **Recommendation:** Use /create-spec instead for:
      - Proper architectural analysis
      - Story splitting for safer implementation
      - Integration story to validate complete fix
      - Better dependency mapping
    </validation_report_format>

    PRESENT: Validation Report to user

    ASK user via AskUserQuestion:
    "This bug fix exceeds /add-bug size guidelines. How would you like to proceed?

    Options:
    1. Switch to /create-spec (Recommended)
       → Full specification with proper planning
       → Story splitting for safer implementation
       → Integration story for validation

    2. Edit bug to reduce scope
       → Focus on most critical part of the fix
       → Create follow-up bugs for remaining issues
       → Re-run validation after edits

    3. Proceed anyway
       → Accept higher context usage
       → Risk mid-execution context compaction
       → Continue with current bug fix"

    WAIT for user choice

    <user_choice_handling>
      IF choice = "Switch to /create-spec":
        INFORM: "Switching to /create-spec workflow.
                 The bug analysis and Root Cause will be preserved as context."

        PRESERVE: Root-Cause-Analyse for create-spec input

        INVOKE: /create-spec with bug description and RCA
        STOP: This workflow

      ELSE IF choice = "Edit bug to reduce scope":
        INFORM: "Please edit the bug file: agent-os/backlog/[bug-file].md"
        INFORM: "Reduce the scope by:
                 - Focus on the most critical affected file
                 - Create separate bugs for other affected areas
                 - Reduce WO section to essential files only"
        PAUSE: Wait for user to edit
        ASK: "Ready to re-validate? (yes/no)"
        IF yes:
          REPEAT: Step 5.5 (this validation step)
        ELSE:
          PROCEED: To Step 6 with warning flag

      ELSE IF choice = "Proceed anyway":
        WARN: "⚠️ Proceeding with oversized bug fix
               - Expect higher token costs
               - Mid-execution compaction possible
               - Consider splitting into multiple bugs next time"
        LOG: Validation bypassed by user
        PROCEED: To Step 6
    </user_choice_handling>
</decision_tree>

<instructions>
  ACTION: Validate bug against size guidelines
  CHECK: Affected files, complexity, estimated LOC, systemic issue detection
  THRESHOLD: Max 5 files, max M complexity (S preferred), max 400 LOC
  REPORT: Issues found with specific recommendations
  OFFER: Three options (switch to create-spec, edit scope, proceed)
  ENFORCE: Validation before adding to backlog
</instructions>

**Output:**
- Validation report (if issues found)
- User decision on how to proceed
- Bug either validated, edited, or escalated to /create-spec

</step>

<step number="6" name="update_story_index">

### Step 6: Update Backlog Story Index

<mandatory_actions>
  1. READ: agent-os/backlog/story-index.md

  2. ADD new bug to Story Summary table:
     | Bug ID | Title | Type | Priority | Dependencies | Status | Points |
     Note: Use 🐛 emoji prefix for bug entries

  3. UPDATE totals:
     - Total Stories: +1
     - Backlog Count: +1

  4. UPDATE: Last Updated date

  5. WRITE: Updated story-index.md
</mandatory_actions>

</step>

<step number="7" name="completion_summary">

### Step 7: Bug Added Confirmation

⚠️ **Note:** Only reached if bug passed size validation (Step 5.5)

<summary_template>
  ✅ Bug added to backlog with Root-Cause-Analyse!

  **Bug ID:** [YYYY-MM-DD-INDEX]
  **File:** agent-os/backlog/bug-[YYYY-MM-DD]-[INDEX]-[slug].md

  **Summary:**
  - Title: 🐛 [Bug Title]
  - Severity: [Critical/High/Medium/Low]
  - Root Cause: [Brief RC description]
  - Complexity: [XS/S/M]
  - Status: Ready

  **Root-Cause-Analyse:**
  - Hypothesen geprüft: [N]
  - Root Cause gefunden: ✅
  - Betroffene Dateien: [N]

  **Backlog Status:**
  - Total tasks: [N]
  - Bugs: [N]
  - Ready for execution: [N]

  **Next Steps:**
  1. Add more bugs: /add-bug "[description]"
  2. Add quick tasks: /add-todo "[description]"
  3. Execute backlog: /execute-tasks backlog
  4. View backlog: agent-os/backlog/story-index.md
</summary_template>

</step>

</process_flow>

## Final Checklist

<verify>
  - [ ] Backlog directory exists
  - [ ] Bug description gathered (symptom, repro, expected/actual)
  - [ ] Bug type determined (Frontend/Backend/DevOps)
  - [ ] Hypothesis-Driven RCA completed
  - [ ] Root Cause identified and documented
  - [ ] Bug story file created with correct naming
  - [ ] Technical refinement complete
  - [ ] All DoR checkboxes marked [x]
  - [ ] **Bug size validation passed (Step 5.5)**
  - [ ] Story-index.md updated
  - [ ] Ready for /execute-tasks backlog
</verify>

## When NOT to Use /add-bug

Suggest /create-spec instead when:
- Root Cause requires architectural changes
- Fix affects >5 files
- Multiple related bugs need coordinated fix
- Bug reveals larger design issue
- Estimated complexity > M
