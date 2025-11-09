---
description: Effort Estimation Rules for Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Effort Estimation Rules

## Overview

Generate detailed effort estimations for feature specifications using context-aware methods, codebase analysis, and industry benchmarks. Creates both technical and client-facing documentation.

<process_flow>

<step number="1" subagent="context-fetcher" name="spec_selection">

### Step 1: Spec Selection

Identify which specification to estimate.

<option_a_flow>
  <trigger>User specifies spec name or path</trigger>
  <actions>
    1. VALIDATE spec exists in .agent-os/specs/
    2. CHECK for spec.md and tasks.md
    3. PROCEED to estimation
  </actions>
</option_a_flow>

<option_b_flow>
  <trigger>User doesn't specify spec</trigger>
  <actions>
    1. LIST available specs from .agent-os/specs/
    2. PRESENT to user with dates
    3. WAIT for selection
  </actions>
</option_b_flow>

<validation>
  REQUIRED FILES:
    - spec.md (feature specification)
    - tasks.md (task breakdown)

  IF missing:
    ERROR: "Cannot estimate - missing required files"
    SUGGEST: Run /create-spec first
</validation>

</step>

<step number="2" subagent="estimation-specialist" name="codebase_analysis">

### Step 2: Codebase Analysis

Use the estimation-specialist subagent to analyze the existing codebase for patterns, complexity, and reusability.

<analysis_tasks>

  <task name="project_structure">
    ### 2.1 Project Structure Detection

    IDENTIFY:
    - Framework/technology (Next.js, React, Node.js, etc.)
    - Architecture pattern (App Router, Pages, MVC, etc.)
    - Directory structure conventions

    COMMANDS:
    ```bash
    ls -la src/ app/ pages/ 2>/dev/null | head -20
    cat package.json | grep -E "next|react|vue|angular"
    ```

    OUTPUT: Project type and architecture pattern
  </task>

  <task name="similar_features">
    ### 2.2 Similar Feature Search

    Based on spec keywords, SEARCH for similar features:

    EXTRACT keywords from spec:
    - Feature type (auth, payment, dashboard, etc.)
    - Domain terms (user, product, order, etc.)
    - Technology (oauth, stripe, websocket, etc.)

    SEARCH codebase:
    ```bash
    grep -r "keyword1\|keyword2" src/ --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" -l
    ```

    For each match:
    - ANALYZE file structure
    - COUNT lines of code
    - IDENTIFY reusable components

    OUTPUT: Similar features with reusability score (0-100%)
  </task>

  <task name="complexity_metrics">
    ### 2.3 Code Complexity Metrics

    For relevant code sections:

    ```bash
    # Lines of code
    cloc src/relevant/path --json

    # File count
    find src/relevant/path -type f | wc -l

    # Test coverage check
    find src/relevant/path -name "*.test.*" -o -name "*.spec.*" | wc -l
    ```

    CALCULATE:
    - Average lines per file
    - Test file ratio
    - Component complexity indicators

    OUTPUT: Complexity baseline for comparison
  </task>

  <task name="technical_debt">
    ### 2.4 Technical Debt Assessment

    SEARCH for debt indicators:

    ```bash
    # TODO/FIXME comments
    grep -r "TODO\|FIXME\|HACK\|XXX" src/relevant/path --include="*.ts" --include="*.tsx"

    # Security vulnerabilities
    npm audit --json

    # Outdated dependencies
    npm outdated
    ```

    ASSESS impact:
    - High: Major refactoring needed (+30-50%)
    - Medium: Some cleanup needed (+15-25%)
    - Low: Minimal impact (+5-10%)

    OUTPUT: Technical debt impact factor
  </task>

  <task name="dependency_check">
    ### 2.5 Dependency Analysis

    CHECK required dependencies:

    ```bash
    npm list --depth=0
    ```

    COMPARE against spec requirements:
    - Are needed packages installed?
    - Version compatibility?
    - New installs required?

    CALCULATE setup overhead:
    - No new deps: 0 days
    - 1-3 new deps: 0.5 days
    - 4+ new deps: 1-2 days

    OUTPUT: Dependency setup time
  </task>

</analysis_tasks>

<summary_output>
  PRESENT to user:

  "📊 Codebase Analysis Complete:

  **Project Structure**: [framework + architecture]

  **Similar Features Found**: [count]
  - [Feature 1]: [similarity%] - [LOC] - [reusable components]
  - [Feature 2]: [similarity%] - [LOC] - [reusable components]

  **Reusability Score**: [average%]
  **Technical Debt**: [Low/Medium/High]
  **New Dependencies**: [count]

  This analysis will inform the estimation..."
</summary_output>

</step>

<step number="3" subagent="estimation-specialist" name="method_selection">

### Step 3: Estimation Method Selection

Use the estimation-specialist subagent to select the optimal estimation method based on available data.

<decision_tree>

  CHECK: Historical database exists?
  PATH: .agent-os/estimations/history/index.json

  IF exists AND has >= 10 similar projects:
    PRIMARY_METHOD: "Reference Class Forecasting"
    CONFIDENCE: "High"
    REASON: "Strong historical data available"

  ELSE IF team_velocity_history >= 3 sprints:
    PRIMARY_METHOD: "Planning Poker (Multi-Perspective Analysis)"
    CONFIDENCE: "Medium-High"
    REASON: "Team velocity is established. Story points based on multi-perspective complexity analysis (Backend, Frontend, Testing, Integration). Code analysis provides implicit references."

  ELSE IF spec is complex (>20 tasks):
    PRIMARY_METHOD: "Wideband Delphi"
    CONFIDENCE: "Medium"
    REASON: "Complex spec requires expert judgment"

  ELSE:
    PRIMARY_METHOD: "Task-based Estimation"
    CONFIDENCE: "Medium"
    REASON: "Limited historical data"

  END IF

  IF uncertainty is high (new tech, new domain, high complexity):
    ADDITIONAL_METHOD: "Monte Carlo Simulation"
    PURPOSE: "Quantify uncertainty with probability ranges"
  END IF

</decision_tree>

<inform_user>
  PRESENT method selection:

  "🎯 Estimation Method Selected: [method]

  **Why**: [reason]
  **Confidence Level**: [level]
  **Additional Methods**: [if any]

  Proceeding with estimation..."
</inform_user>

</step>

<step number="4" subagent="estimation-specialist" name="estimation_execution">

### Step 4: Estimation Execution

Use the estimation-specialist subagent to execute the chosen estimation method.

<method_execution>

  <planning_poker>
    ### Planning Poker Execution (Multi-Perspective Analysis)

    **Note**: This method works WITHOUT existing reference stories by using:
    - Multi-perspective complexity analysis (simulates team voting)
    - Absolute Fibonacci scale mapping (based on time/complexity)
    - Code analysis as implicit references (similar features in codebase)

    FOR each task in tasks.md:

      **Step 1: Multi-Perspective Complexity Analysis**

      ANALYZE from different developer perspectives:
      - Backend complexity (API, database, logic) → Score 1-10
      - Frontend complexity (UI, state, interactions) → Score 1-10
      - Testing effort (unit, integration, e2e) → Score 1-10
      - Integration complexity (APIs, services, external) → Score 1-10

      **Step 2: Map to Fibonacci Scale (Absolute Mapping)**

      For EACH perspective, convert complexity score to Fibonacci:
      - 1: Trivial (< 2 hours) - Complexity 1-2
      - 2: Simple (2-4 hours) - Complexity 2-3
      - 3: Straightforward (4-8 hours) - Complexity 3-4
      - 5: Moderate (1-2 days) - Complexity 4-6
      - 8: Complex (2-4 days) - Complexity 6-8
      - 13: Very complex (1 week) - Complexity 8-10
      - 20: Highly complex (2 weeks) - Complexity >10
      - 40: Epic (1 month) - Multiple high-complexity aspects

      **Step 3: Calculate Consensus**

      CALCULATE median of all perspective estimates
      This simulates team consensus in Planning Poker

      **Step 4: Apply Code Analysis Adjustments**

      IF similar code exists in codebase:
        COMPARE new task with similar features:
        - Similar complexity but less code needed? → Reduce points
        - More complex than existing? → Increase points

      APPLY adjustments:
      - Reusability bonus: -[%] from code analysis
      - Technical debt penalty: +[%] from code analysis
      - Complexity adjustment: ±[%] based on similar features

    **Step 5: Apply AI Productivity Adjustments (Multi-Tier)**

    LOAD: .agent-os/estimations/config/estimation-config.json

    IF ai_productivity_factors.enabled == true:

      **Step 5.1: Determine AI Mode**

      LOAD current mode from config:
        mode = ai_productivity_factors.mode  // "autonomous_agent", "ai_assistant", or "code_completion"

      GET multipliers for current mode:
        multipliers = ai_productivity_factors.available_modes[mode].multipliers
        non_acceleratable = ai_productivity_factors.available_modes[mode].non_acceleratable (if exists)

      **Step 5.2: Classify Each Task**

      FOR each task:

        **Analyze task description** for keywords:

        CHECK task_classification_keywords:
        - IF contains "manual_testing" keywords → task_category = "manual_testing"
        - IF contains "device_testing" keywords → task_category = "device_testing"
        - IF contains "code_only" keywords → task_category = "code_only"
        - IF contains "requires_human_judgment" keywords → task_category = "human_judgment"

        **Map to multiplier type**:

        IDENTIFY specific task type from task_type_mapping:
        - "Hive Model" → database_models
        - "Repository" → crud_operations
        - "Bottom Sheet" → ui_components
        - "BLoC Logic" → state_management
        - "QA Testing" → manual_testing
        - "Device Testing" → device_testing
        - etc.

        **Get appropriate multiplier**:

        IF task_type IN non_acceleratable:
          multiplier = non_acceleratable[task_type]
          reason = "Cannot be significantly accelerated by AI"
        ELSE:
          multiplier = multipliers[task_type]
          reason = "AI can automate this task"

        **Calculate adjusted effort**:

        adjusted_points = original_points × multiplier
        time_saved = original_points - adjusted_points
        speedup_percentage = (1 - multiplier) × 100

        **Document adjustment**:

        IF multiplier < 0.20:  // >80% speedup
          impact = "🚀 MASSIVE AI IMPACT"
        ELSE IF multiplier < 0.50:  // 50-80% speedup
          impact = "⚡ HIGH AI IMPACT"
        ELSE IF multiplier < 0.80:  // 20-50% speedup
          impact = "✓ MODERATE AI IMPACT"
        ELSE:  // <20% speedup
          impact = "⚠️ MINIMAL AI IMPACT - Manual work required"

        CREATE task analysis:
        ```
        Task: [name]
        Type: [task_type]
        Category: [task_category]

        Traditional Estimate: [X] points / [hours]
        AI Mode: [mode_name] (e.g., "Autonomous Agent - Claude Code")
        Multiplier: [Y] ([speedup%] faster)
        AI-Adjusted Estimate: [Z] points / [hours]
        Time Saved: [hours] hours

        [impact emoji] [reason]

        Why this speedup:
        - [Specific explanation based on task type]
        ```

      **Step 5.3: Calculate Total Impact**

      CATEGORIZE all tasks:
        massive_impact_tasks = tasks where multiplier < 0.20
        high_impact_tasks = tasks where multiplier < 0.50
        moderate_impact_tasks = tasks where multiplier < 0.80
        minimal_impact_tasks = tasks where multiplier >= 0.80

      CALCULATE totals:
        total_traditional_hours = Σ(original_points)
        total_ai_adjusted_hours = Σ(adjusted_points)
        total_time_saved = total_traditional_hours - total_ai_adjusted_hours
        overall_speedup = (total_time_saved / total_traditional_hours) × 100
        average_multiplier = total_ai_adjusted_hours / total_traditional_hours

      **Step 5.4: Generate Breakdown**

      CREATE impact breakdown:
      ```
      ⚡ AI PRODUCTIVITY ANALYSIS

      Mode: [Autonomous Agent / AI Assistant / Code Completion]
      Tools: [Claude Code, Cursor Agent / ChatGPT / GitHub Copilot]

      IMPACT BREAKDOWN:
      🚀 Massive Impact (>80% speedup): [count] tasks, [X] hours saved
         Examples: [list top 3]

      ⚡ High Impact (50-80% speedup): [count] tasks, [X] hours saved
         Examples: [list top 3]

      ✓ Moderate Impact (20-50% speedup): [count] tasks, [X] hours saved

      ⚠️ Minimal/No Impact (<20% speedup): [count] tasks
         Reason: Manual testing, device testing, human judgment required
         Examples: [list all]

      TOTALS:
      - Traditional Estimate: [X] hours ([weeks])
      - AI-Adjusted Estimate: [Y] hours ([weeks])
      - Time Saved: [Z] hours ([speedup]%)
      - Effort Reduction: [weeks saved]

      BOTTLENECKS (Cannot be accelerated):
      [List all minimal-impact tasks with explanations]
      ```

      **Step 5.5: Inform User**

      PRESENT analysis:
      "⚡ AI Productivity Applied:

      Mode: [mode_name]
      - [mode_description]

      Overall Impact: [speedup]% faster ([weeks saved] weeks saved)

      Where AI helps most:
      1. [Task category 1]: [X]% faster
      2. [Task category 2]: [Y]% faster
      3. [Task category 3]: [Z]% faster

      Where AI cannot help:
      - [Task category]: [reason]
      - [Task category]: [reason]

      💡 Recommendation:
      [If massive_impact_tasks > 50% of total]
        'This project is highly suited for autonomous AI coding!'
      [If minimal_impact_tasks > 40% of total]
        'Significant portion requires manual work - estimates are conservative'
      "

    ELSE:
      SKIP AI adjustments
      USE traditional estimates
      WARN: "⚠️ AI productivity disabled - using traditional estimates"

    **Step 6: Aggregate to Project Estimate**

    AGGREGATE:
      Total Story Points = Σ(task points)
      Estimated Sprints = Total Points / Team Velocity
      Estimated Weeks = Sprints × Sprint Length

    **Communication to User:**

    "Planning Poker (Multi-Perspective Analysis) used:
    - Each task analyzed from 4 perspectives (Backend, Frontend, Testing, Integration)
    - Fibonacci points assigned based on absolute complexity scale
    - Code analysis provides implicit references where similar features exist
    - No explicit reference stories needed for first estimation"

  </planning_poker>

  <reference_class>
    ### Reference Class Forecasting Execution

    LOAD: .agent-os/estimations/history/index.json

    FILTER similar projects:
      WHERE similarity_score >= 0.7
      AND domain matches OR tech_stack overlaps

    EXTRACT effort data:
      - actual_weeks for each project
      - Calculate P10, P50, P90 percentiles

    ADJUST for current project:
      - Team size difference: ±[%]
      - Complexity difference: ±[%]
      - Reusability potential: -[%]

    OUTPUT:
      - Optimistic (P10): [weeks]
      - Realistic (P50): [weeks]
      - Pessimistic (P90): [weeks]

  </reference_class>

  <monte_carlo>
    ### Monte Carlo Simulation (Optional)

    FOR each task:
      DEFINE three-point estimate:
        - Optimistic: best case
        - Most Likely: expected case
        - Pessimistic: worst case

    SIMULATE 10,000 iterations:
      FOR each iteration:
        SAMPLE effort from Beta-PERT distribution for each task
        SUM total effort for iteration

    CALCULATE percentiles:
      P10 = 10th percentile of results
      P50 = 50th percentile (median)
      P90 = 90th percentile

    OUTPUT confidence intervals

  </monte_carlo>

</method_execution>

<industry_validation>
  ### Industry Benchmark Validation

  LOAD: .agent-os/estimations/config/industry-benchmarks.json

  FOR each major component:
    LOOKUP benchmark for component type
    COMPARE our_estimate vs benchmark_range

    IF deviation > 50%:
      FLAG: "Requires justification"
      DOCUMENT: Why deviation is reasonable

    IF deviation > 100%:
      WARNING: "Estimate significantly outside industry norms"
      RECOMMEND: Review estimate

  DOCUMENT all benchmarks in output
</industry_validation>

<bias_detection>
  ### Cognitive Bias Check

  CHECK for common estimation biases:

  **Planning Fallacy**:
  IF "new technology" in spec AND no learning_buffer:
    WARN: "New tech adds 20-30% typically"
    SUGGEST: Add learning curve buffer

  **Integration Underestimation**:
  IF "integration" in spec AND integration_effort < 20%:
    WARN: "Integrations often underestimated by 40%"
    SUGGEST: Increase integration buffer

  **Missing Testing**:
  IF testing_effort < 10% of total:
    WARN: "Testing should be 10-15% of effort"
    AUTO_ADD: Testing buffer

  **Optimism Bias**:
  IF all estimates at P50 or below:
    WARN: "Estimates may be optimistic"
    SUGGEST: Review pessimistic scenarios
</bias_detection>

</step>

<step number="5" subagent="estimation-specialist" name="documentation">

### Step 5: Create Documentation (Triple Output)

Use the estimation-specialist subagent to create three estimation documents.

<output_files>

  <file_1>
    ### estimation-technical.md

    LOCATION: .agent-os/specs/[spec-name]/estimation-technical.md

    CONTENT STRUCTURE:
    ```markdown
    ---
    estimated_date: [YYYY-MM-DD]
    method: [primary method]
    confidence: [low/medium/high]
    status: active
    ---

    # Technical Estimation: [Feature Name]

    ## Summary
    - Total Story Points: [points]
    - Estimated Sprints: [sprints]
    - Estimated Weeks: [weeks]
    - Confidence Intervals: P10: [x], P50: [x], P90: [x]

    ## Methodology
    - Primary Method: [method + why]
    - Additional Methods: [if any]
    - Codebase Analysis: [summary]

    ## Task Breakdown
    [Table with: Task | Story Points | Hours | Complexity Factors | Notes]

    ## Code Analysis
    - Similar Features: [list with LOC, reusability]
    - Reusability Factor: [%]
    - Technical Debt: [impact]
    - Complexity Comparison: [vs average]

    ## Adjustment Factors
    - Base Estimate (Traditional): [weeks]
    - Reusability Bonus: -[%] = -[weeks]
    - Technical Debt Penalty: +[%] = +[weeks]
    - Complexity Adjustment: ±[%] = ±[weeks]
    - **AI Productivity Adjustment: -[%] = -[weeks]**
      - Tools: Claude Code, Cursor, GitHub Copilot
      - Boilerplate/CRUD: 60% faster (0.40 multiplier)
      - Testing: 65% faster (0.35 multiplier)
      - UI Components: 55% faster (0.45 multiplier)
      - Complex Logic: 25% faster (0.75 multiplier)
      - Average Speedup: [X]% across all tasks
    - Net Adjustment: [weeks]
    - **Final Estimate (AI-Adjusted)**: [weeks]

    ## Assumptions
    [Numbered list with: Assumption | Validation | Risk if False | Mitigation]

    ## Risks
    [List with: Risk | Probability | Impact | Mitigation]

    ## Reference Projects
    [If used: Project | Similarity | Estimated | Actual | Lessons]

    ## Industry Benchmarks
    [Component | Our Estimate | Benchmark | Source | Deviation]
    ```
  </file_1>

  <file_2>
    ### estimation-client.md

    LOCATION: .agent-os/specs/[spec-name]/estimation-client.md

    CONTENT STRUCTURE (Business-Friendly):
    ```markdown
    ---
    project: [Feature Name]
    date: [YYYY-MM-DD]
    status: Proposal
    ---

    # Aufwandsschätzung: [Feature Name]

    ## 📋 Zusammenfassung
    **Geschätzter Gesamtaufwand**: [min]-[max] Wochen
    **Empfohlene Planung**: [realistic] Wochen
    **Preis-Range**: €[min] - €[max] (bei €[rate]/Woche)
    **Konfidenz**: [%] Wahrscheinlichkeit

    ## 💰 Aufwandsverteilung
    [Table: Phase | Beschreibung | Wochen | Kosten | Anteil]

    ## 🎯 Was ist enthalten?
    ### ✅ Im Scope
    [Clear bullet points of deliverables]

    ### ❌ Nicht im Scope
    [What's excluded - optional features]

    ## 📊 Warum diese Aufwände?
    [For each major phase:
      - What wird gemacht
      - Warum [X] Wochen
      - Industry Benchmark validation
      - Code reuse explanation
    ]

    ## 📈 Risiken & Unsicherheiten
    [List: Risk | Probability | Impact | Mitigation]

    ## 🎯 Wie sicher ist diese Schätzung?
    ### Schätzungs-Methodik
    [Explain methods used in plain language]

    ### Konfidenz-Level
    - Optimistisch ([%]): [weeks]
    - Realistisch ([%]): [weeks]
    - Pessimistisch ([%]): [weeks]

    ## ⚡ AI-Assisted Development Berücksichtigt

    Diese Schätzung berücksichtigt moderne AI-Tools:

    **Verwendete AI-Tools**: Claude Code, Cursor, GitHub Copilot

    **Produktivitäts-Steigerungen eingerechnet**:
    - ✅ Boilerplate & CRUD: **60% schneller** (z.B. Datenbank-Models, API-Endpoints)
    - ✅ Testing: **65% schneller** (AI generiert Unit Tests automatisch)
    - ✅ UI-Komponenten: **55% schneller** (Forms, Buttons, Layouts)
    - ✅ Refactoring: **50% schneller** (AI unterstützt bei Code-Umstrukturierung)
    - ✅ Documentation: **70% schneller** (AI schreibt Docs automatisch)
    - ⚠️ Komplexe Algorithmen: **25% schneller** (AI hilft, aber menschliche Expertise nötig)

    **Durchschnittliche Beschleunigung**: [X]% über alle Tasks

    **Warum nicht noch schneller?**
    - Review & Quality Control: AI-generierter Code muss geprüft werden
    - Komplexe Geschäftslogik: Benötigt menschliches Verständnis
    - Integration Testing: Kann nicht vollständig automatisiert werden
    - Client-spezifische Anforderungen: Müssen individuell umgesetzt werden

    **Vergleich Traditional vs. AI-Assisted**:
    | Phase | Traditional | Mit AI-Tools | Speedup |
    |-------|------------|--------------|---------|
    | Backend CRUD | [X] Wochen | [Y] Wochen | [Z]% |
    | Testing | [X] Wochen | [Y] Wochen | [Z]% |
    | UI Development | [X] Wochen | [Y] Wochen | [Z]% |

    **Wissenschaftliche Basis**:
    - GitHub Copilot Study (2023): 55% durchschnittliche Beschleunigung
    - McKinsey Report (2024): 35-50% Produktivitätsgewinn mit Generative AI
    - Unsere eigene Erfahrung: [X]% average speedup (basierend auf historischen Daten)

    **Sie können AI deaktivieren**:
    Wenn Sie traditionelle Schätzungen bevorzugen (ohne AI-Adjustment), teilen Sie uns das mit.

    ## 💡 Kosten sparen (optionale Reduktionen)
    [List of optional reductions with trade-offs]

    ## ✅ Validierung & Transparenz
    [Explain how estimate can be verified]
    [Note: Includes both traditional benchmarks AND AI-adjusted estimates]

    ## 📞 Nächste Schritte
    [Clear action items]
    ```
  </file_2>

  <file_3>
    ### estimation-validation.json

    LOCATION: .agent-os/specs/[spec-name]/estimation-validation.json

    CONTENT STRUCTURE (Machine-Readable):
    ```json
    {
      "metadata": {
        "project": "[feature-name]",
        "version": "1.0",
        "date": "[YYYY-MM-DD]",
        "estimator": "estimation-specialist-v1.0",
        "validation_status": "ready_for_review"
      },
      "summary": {
        "total_weeks": {
          "optimistic_p10": X,
          "realistic_p50": X,
          "pessimistic_p90": X
        },
        "confidence_level": 0.X,
        "methodology": ["method1", "method2"]
      },
      "breakdown": [
        {
          "phase": "name",
          "weeks": X,
          "story_points": X,
          "percentage": X,
          "justification": {
            "complexity_factors": {},
            "industry_benchmarks": [],
            "code_analysis": {}
          }
        }
      ],
      "validation_data": {
        "reference_projects": [],
        "team_velocity": {},
        "monte_carlo_simulation": {}
      },
      "assumptions": [],
      "risks": [],
      "industry_benchmarks": [],
      "transparency": {
        "methods_used": [],
        "adjustment_factors": {}
      },
      "validation_instructions_for_ai": {
        "how_to_validate": "Steps for external AI validation",
        "steps": [],
        "red_flags": []
      }
    }
    ```
  </file_3>

</output_files>

<confirmation>
  INFORM user:

  "✅ Estimation Complete! Created:

  1. **estimation-technical.md** - Full technical details for your team
  2. **estimation-client.md** - Business-friendly version for clients
  3. **estimation-validation.json** - Machine-readable for external review

  All files saved in: .agent-os/specs/[spec-name]/"
</confirmation>

</step>

<step number="6" subagent="estimation-specialist" name="tracking_setup">

### Step 6: Setup Estimation Tracking

Create tracking file for actual vs. estimated comparison.

<tracking_file>
  LOCATION: .agent-os/estimations/active/[YYYY-MM-DD]-[feature-name].json

  CONTENT:
  ```json
  {
    "metadata": {
      "spec_path": ".agent-os/specs/[spec-name]/",
      "estimated_date": "[YYYY-MM-DD]",
      "estimated_by": "estimation-specialist",
      "status": "active"
    },
    "classification": {
      "domain": "[auth/payment/etc]",
      "tech_stack": ["Tech1", "Tech2"],
      "complexity": "low/medium/high",
      "feature_type": "new_feature/enhancement/refactor"
    },
    "estimation": {
      "method": "[method]",
      "total_story_points": X,
      "estimated_weeks": X,
      "confidence_intervals": {
        "p10": X,
        "p50": X,
        "p90": X
      },
      "task_breakdown": []
    },
    "assumptions": [],
    "risks": [],
    "reference_projects": []
  }
  ```

  INFORM user:
  "📊 Tracking setup complete. As tasks are completed, actual effort will be tracked for continuous learning."
</tracking_file>

</step>

<step number="7" name="user_review">

### Step 7: User Review & Optional Adjustments

Present estimation and allow user to review or adjust.

<presentation>
  SUMMARIZE key points:

  "📊 **Estimation Summary**

  **Feature**: [name]
  **Estimated Effort**: [min]-[max] weeks (Realistic: [median] weeks)
  **Method**: [method]
  **Confidence**: [level]

  **Key Assumptions**:
  1. [Assumption 1]
  2. [Assumption 2]
  3. [Assumption 3]

  **Top Risks**:
  1. [Risk 1]: [probability] - [impact]
  2. [Risk 2]: [probability] - [impact]

  **Reusability**: [%] of code can be reused
  **Technical Debt Impact**: [Low/Medium/High]

  Files created:
  - estimation-technical.md (for your team)
  - estimation-client.md (for clients/stakeholders)
  - estimation-validation.json (for external validation)
  "
</presentation>

<user_interaction>
  ASK user:

  "Would you like to:
  1. Accept this estimation
  2. Adjust assumptions and re-estimate
  3. Run external validation check (/validate-estimation)
  4. Explain any specific part in more detail

  What would you like to do?"

  HANDLE user response:
  - If accept: DONE
  - If adjust: GO TO adjustment flow
  - If validate: INVOKE /validate-estimation
  - If explain: PROVIDE detailed explanation
</user_interaction>

</step>

</process_flow>

## Important Notes

### When Estimation is Not Possible

IF spec.md or tasks.md missing:
  ERROR: "Cannot estimate without specification"
  GUIDE: "Please run /create-spec first to create a detailed specification with task breakdown"

IF spec is too vague:
  ERROR: "Specification lacks detail for reliable estimation"
  GUIDE: "Please refine spec with:
    - Clear acceptance criteria
    - Technical requirements
    - Integration points
    - UI/UX requirements"

### Confidence Levels

- **High (80-90%)**: Historical data available, similar projects, stable tech
- **Medium (60-80%)**: Some historical data, established team, known tech
- **Low (40-60%)**: Limited data, new team, new tech, high uncertainty

Always communicate confidence level to user.

### Continuous Improvement

After each completed project:
1. Update historical database
2. Calculate accuracy metrics (MRE)
3. Document lessons learned
4. Adjust future estimates based on patterns

## Success Criteria

An estimation is complete when:
- ✅ All three output files created
- ✅ Industry benchmarks validated
- ✅ Code analysis performed
- ✅ Assumptions documented
- ✅ Risks identified
- ✅ Tracking setup
- ✅ User reviewed and approved (or adjusted)
