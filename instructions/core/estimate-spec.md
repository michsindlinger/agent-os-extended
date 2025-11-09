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
    PRIMARY_METHOD: "Planning Poker"
    CONFIDENCE: "Medium-High"
    REASON: "Team velocity is established"

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
    ### Planning Poker Execution

    FOR each task in tasks.md:

      ANALYZE from multiple perspectives:
      - Backend complexity (API, database, logic)
      - Frontend complexity (UI, state, interactions)
      - Testing effort (unit, integration, e2e)
      - Integration complexity (APIs, services, external)

      MAP to Fibonacci scale:
      - 1: Trivial (< 2 hours)
      - 2: Simple (2-4 hours)
      - 3: Straightforward (4-8 hours)
      - 5: Moderate (1-2 days)
      - 8: Complex (2-4 days)
      - 13: Very complex (1 week)
      - 20: Highly complex (2 weeks)
      - 40: Epic (1 month)

      CALCULATE consensus (median of perspectives)

      APPLY codebase adjustments:
      - Reusability bonus: -[%] from code analysis
      - Technical debt penalty: +[%] from code analysis
      - Complexity adjustment: ±[%] based on similar features

    AGGREGATE:
      Total Story Points = Σ(task points)
      Estimated Sprints = Total Points / Team Velocity
      Estimated Weeks = Sprints × Sprint Length

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
    - Base Estimate: [weeks]
    - Reusability Bonus: -[%] = -[weeks]
    - Technical Debt Penalty: +[%] = +[weeks]
    - Complexity Adjustment: ±[%] = ±[weeks]
    - Net Adjustment: [weeks]
    - Final Estimate: [weeks]

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

    ## 💡 Kosten sparen (optionale Reduktionen)
    [List of optional reductions with trade-offs]

    ## ✅ Validierung & Transparenz
    [Explain how estimate can be verified]

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
