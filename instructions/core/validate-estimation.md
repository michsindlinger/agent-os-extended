---
description: Estimation Validation Rules for Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Estimation Validation Rules

## Overview

Validate existing estimations for mathematical consistency, industry alignment, and overall plausibility. Provides independent verification that can be used by clients, stakeholders, or external AI tools.

<process_flow>

<step number="1" name="load_estimation">

### Step 1: Load Estimation Data

Identify and load the estimation to validate.

<spec_selection>
  IF user specifies spec name:
    LOAD from .agent-os/specs/[spec-name]/estimation/
  ELSE:
    LIST available estimations (search for specs with estimation/ directory)
    ASK user to select
</spec_selection>

<file_loading>
  LOCATION: .agent-os/specs/[spec-name]/estimation/

  REQUIRED FILES:
  - estimation-technical.md
  - estimation-client.md
  - estimation-validation.json

  CHECK:
    READ .agent-os/specs/[spec-name]/estimation/estimation-technical.md
    READ .agent-os/specs/[spec-name]/estimation/estimation-client.md
    READ .agent-os/specs/[spec-name]/estimation/estimation-validation.json

  IF any missing:
    ERROR: "Incomplete estimation - missing files in estimation/ directory"
    LIST: Which files are present
    EXIT
</file_loading>

<data_extraction>
  PARSE estimation-validation.json

  EXTRACT:
  - Summary (total weeks, confidence, methods)
  - Breakdown (phases, story points, percentages)
  - Validation data (reference projects, team velocity, monte carlo)
  - Assumptions
  - Risks
  - Industry benchmarks
  - Adjustment factors

  STORE in memory for validation checks
</data_extraction>

</step>

<step number="2" name="mathematical_validation">

### Step 2: Mathematical Consistency Check

Verify all calculations are mathematically consistent.

<check_1>
  ### Story Points Consistency

  FORMULA: total_story_points / team_velocity = estimated_sprints

  CALCULATE:
    expected_sprints = total_story_points / team_velocity

  COMPARE:
    IF abs(expected_sprints - stated_sprints) > 0.5:
      FLAG: "Story point calculation inconsistent"
      DETAIL: "Expected [X] sprints, stated [Y] sprints"
</check_1>

<check_2>
  ### Sprint to Weeks Conversion

  FORMULA: sprints × sprint_length_weeks = estimated_weeks

  CALCULATE:
    expected_weeks = sprints × sprint_length

  COMPARE:
    IF abs(expected_weeks - stated_weeks) > 1:
      FLAG: "Sprint to weeks conversion inconsistent"
      DETAIL: "Expected [X] weeks, stated [Y] weeks"
</check_2>

<check_3>
  ### Percentage Consistency

  REQUIREMENT: All phase percentages must sum to 100%

  CALCULATE:
    total_percentage = Σ(phase.percentage)

  VALIDATE:
    IF abs(total_percentage - 100) > 1:
      FLAG: "Phase percentages don't sum to 100%"
      DETAIL: "Sum is [X]%"
</check_3>

<check_4>
  ### Confidence Interval Ordering

  REQUIREMENT: P10 < P50 < P90

  VALIDATE:
    IF NOT (p10 < p50 < p90):
      FLAG: "Confidence intervals not properly ordered"
      DETAIL: "P10=[X], P50=[Y], P90=[Z]"

  RATIO CHECK:
    ratio = p90 / p10

    IF ratio > 3:
      WARN: "Very wide range ([ratio]x) - high uncertainty"

    IF ratio < 1.2:
      WARN: "Very narrow range ([ratio]x) - may be overconfident"
</check_4>

<check_5>
  ### Monte Carlo Validation (if present)

  IF monte_carlo_data exists:

    VALIDATE:
      mean ≈ p50 (within 10%)

    CALCULATE:
      deviation = abs(mean - p50) / p50

    IF deviation > 0.10:
      WARN: "Monte Carlo mean deviates from P50 by [X]%"
</check_5>

<report>
  SUMMARIZE:
  - Total checks: 5
  - Passed: [count]
  - Failed: [count]
  - Warnings: [count]
</report>

</step>

<step number="3" name="benchmark_validation">

### Step 3: Industry Benchmark Alignment

Compare estimates against industry benchmarks to identify deviations.

<load_benchmarks>
  READ: .agent-os/estimations/config/industry-benchmarks.json

  IF not found:
    WARN: "Industry benchmarks not available - skipping this check"
    PROCEED to next step
</load_benchmarks>

<component_comparison>
  FOR each component in estimation breakdown:

    IDENTIFY component type (auth, payment, crud, etc.)

    LOOKUP benchmark for component type

    IF benchmark found:

      CALCULATE deviation:
        deviation = (our_estimate - benchmark_typical) / benchmark_typical

      ASSESS:
        IF within_range (benchmark_min to benchmark_max):
          STATUS: ✅ "Within industry range"

        ELSE IF deviation between 0.5 and 1.0:
          STATUS: ⚠️ "Outside range but justified"
          REQUIRE: Justification documented

        ELSE IF deviation > 1.0:
          STATUS: ❌ "Significantly outside range"
          FLAG: "Requires review - [X]% deviation"

    ELSE:
      STATUS: ⚠️ "No benchmark available"

  END FOR
</component_comparison>

<benchmark_source_validation>
  FOR each cited benchmark:

    CHECK:
    - Is source credible (Stack Overflow, OWASP, IEEE, etc.)?
    - Is source recent (< 2 years old)?
    - Is scope appropriate for component?

    IF any fails:
      WARN: "Benchmark source may not be reliable"
</benchmark_source_validation>

<overall_assessment>
  CALCULATE:
    benchmarks_aligned = count(within_range) / total_components

  IF benchmarks_aligned >= 0.80:
    RESULT: ✅ "Good benchmark alignment ([X]%)"

  ELSE IF benchmarks_aligned >= 0.60:
    RESULT: ⚠️ "Moderate benchmark alignment ([X]%)"

  ELSE:
    RESULT: ❌ "Poor benchmark alignment ([X]%)"
    RECOMMEND: "Review estimates - many components outside norms"
</overall_assessment>

</step>

<step number="4" name="assumption_validation">

### Step 4: Assumptions Plausibility Check

Validate that all assumptions are properly documented and reasonable.

<completeness_check>
  FOR each assumption:

    REQUIRED FIELDS:
    - assumption (text)
    - criticality (low/medium/high)
    - validation_method
    - impact_if_false
    - mitigation (for critical assumptions)

    IF any missing:
      FLAG: "Assumption [X] incomplete"
</completeness_check>

<validation_method_check>
  FOR each assumption:

    CHECK validation method:
    - Is it specific and actionable?
    - Can it be performed before/during project?
    - Is timeline mentioned?

    GOOD: "Validate API in first 2 days"
    BAD: "API should work"

    IF vague:
      WARN: "Assumption [X] has vague validation method"
</validation_method_check>

<impact_quantification>
  FOR each assumption:

    CHECK impact_if_false:
    - Is it quantified (e.g., +50% effort)?
    - Is range provided (e.g., +1-2 weeks)?

    IF not quantified:
      WARN: "Assumption [X] impact not quantified"
</impact_quantification>

<criticality_alignment>
  FOR each assumption marked "high" criticality:

    REQUIRE:
    - Mitigation strategy documented
    - Validation method is concrete
    - Impact is significant (>20%)

    IF mitigation missing:
      FLAG: "Critical assumption [X] without mitigation"
</criticality_alignment>

<summary>
  REPORT:
  - Total assumptions: [count]
  - Critical: [count]
  - With validation methods: [count]
  - With mitigations: [count]
  - Quality score: [percentage]
</summary>

</step>

<step number="5" name="reference_project_validation">

### Step 5: Reference Projects Check (if used)

Validate reference projects used for estimation.

<if_method_is_reference_class>

  FOR each reference_project:

    VALIDATE:

    <similarity_score>
      REQUIREMENT: similarity_score >= 0.5

      IF similarity_score < 0.5:
        WARN: "Project [X] has low similarity ([score])"
        RECOMMEND: "Exclude from reference class"

      IF similarity_score < 0.7 AND is_primary_reference:
        FLAG: "Primary reference has questionable similarity"
    </similarity_score>

    <actual_data>
      REQUIRE:
      - actual_weeks or actual_effort documented
      - estimated_weeks documented
      - MRE calculated

      IF missing:
        FLAG: "Reference project [X] missing actual data"
    </actual_data>

    <mre_calculation>
      FORMULA: MRE = |actual - estimated| / actual

      VERIFY:
        calculated_mre = abs(actual - estimated) / actual

      IF calculated_mre != stated_mre:
        FLAG: "MRE miscalculated for project [X]"
    </mre_calculation>

    <lessons_learned>
      REQUIRE: Lessons learned documented

      IF missing:
        WARN: "No lessons learned from project [X]"
    </lessons_learned>

  END FOR

  <statistical_validity>
    REQUIREMENT: At least 3-5 reference projects for reliability

    IF count(reference_projects) < 3:
      WARN: "Few reference projects ([count]) - lower confidence"

    IF count(reference_projects) >= 10:
      ✅: "Strong reference class ([count] projects)"
  </statistical_validity>

  <historical_accuracy>
    CALCULATE:
      average_mre = mean(reference_projects.mre)

    ASSESS:
      IF average_mre < 0.15:
        ✅: "Excellent historical accuracy ([X]% MRE)"

      ELSE IF average_mre < 0.25:
        ✅: "Good historical accuracy ([X]% MRE)"

      ELSE IF average_mre < 0.40:
        ⚠️: "Moderate historical accuracy ([X]% MRE)"

      ELSE:
        ❌: "Poor historical accuracy ([X]% MRE)"
        RECOMMEND: "Review estimation method"
  </historical_accuracy>

</if_method_is_reference_class>

</step>

<step number="6" name="adjustment_factor_validation">

### Step 6: Adjustment Factors Reasonableness

Validate that adjustment factors applied are within reasonable bounds.

<factor_ranges>
  REASONABLE RANGES:
  - Reusability bonus: -10% to -60%
  - Technical debt penalty: +10% to +50%
  - Complexity adjustment: -30% to +50%
  - Integration complexity: +10% to +30%
  - New technology: +20% to +40%
</factor_ranges>

<individual_factor_check>
  FOR each adjustment_factor:

    CHECK against reasonable ranges

    IF factor < range_min OR factor > range_max:
      FLAG: "[Factor] is [value] - outside typical range"
      REQUIRE: Strong justification

    IF factor > ±60% (any single factor):
      ❌: "[Factor] is extreme ([value])"
      RECOMMEND: "Review - unusual adjustment"
</individual_factor_check>

<net_adjustment_check>
  CALCULATE:
    net_adjustment = Π(all factors) - 1

  ASSESS:
    IF abs(net_adjustment) > 1.0 (i.e., ±100%):
      ❌: "Net adjustment is [X]% - estimation may be unreliable"
      RECOMMEND: "Consider breaking down into smaller components"

    ELSE IF abs(net_adjustment) > 0.5:
      ⚠️: "Net adjustment is [X]% - significant changes applied"

    ELSE:
      ✅: "Net adjustment is [X]% - reasonable"
</net_adjustment_check>

<contradictory_adjustments>
  CHECK for contradictions:
  - Large reusability bonus AND large complexity penalty?
  - High technical debt BUT low effort estimate?

  IF contradictions found:
    WARN: "Contradictory adjustments detected"
    DETAIL: Explain contradiction
</contradictory_adjustments>

</step>

<step number="7" name="risk_assessment_validation">

### Step 7: Risk Assessment Check

Validate risk identification and mitigation strategies.

<risk_completeness>
  FOR each risk:

    REQUIRED FIELDS:
    - risk (description)
    - probability (0-1 or percentage)
    - impact (quantified in time/effort)
    - mitigation

    IF any missing:
      FLAG: "Risk [X] incomplete"
</risk_completeness>

<probability_validation>
  FOR each risk:

    CHECK: 0 <= probability <= 1

    IF outside range:
      FLAG: "Risk [X] probability invalid ([value])"

  SUM all probabilities:

    IF sum > 2.0:
      WARN: "Many high-probability risks - consider if realistic"
</probability_validation>

<impact_quantification>
  FOR each risk:

    REQUIRE: Impact quantified (weeks, percentage, etc.)

    IF not quantified:
      WARN: "Risk [X] impact not quantified"
</impact_quantification>

<expected_risk_impact>
  CALCULATE:
    total_expected_impact = Σ(probability × impact) for all risks

  COMPARE with contingency buffer:
    buffer = p90 - p50

  IF total_expected_impact > buffer:
    WARN: "Expected risk impact ([X] weeks) exceeds buffer ([Y] weeks)"
    RECOMMEND: "Increase pessimistic estimate"

  ELSE:
    ✅: "Contingency buffer covers expected risks"
</expected_risk_impact>

<mitigation_strategies>
  FOR each risk with probability > 0.3:

    REQUIRE: Mitigation strategy documented

    ASSESS mitigation:
    - Is it actionable?
    - Is it preventive or reactive?
    - Is contingency included?

    IF vague:
      WARN: "Risk [X] mitigation is vague"
</mitigation_strategies>

</step>

<step number="8" name="generate_validation_report">

### Step 8: Generate Comprehensive Validation Report

Compile all validation results into a comprehensive report.

<create_report>

  FILE: .agent-os/specs/[spec-name]/estimation/estimation-validation-report.md

  STRUCTURE:

  ```markdown
  # Estimation Validation Report

  **Project**: [Feature Name]
  **Estimated**: [weeks range]
  **Validation Date**: [YYYY-MM-DD]
  **Validator**: [tool/person]

  ---

  ## 📊 Overall Confidence Score: [X]/100

  **Status**: [✅ Robust | ⚠️ Reasonable with concerns | ❌ Needs revision]

  ---

  ## ✅ Passed Checks ([count]/[total])

  [List all passed validations]

  ---

  ## ⚠️ Warnings ([count])

  [List all warnings with details and recommendations]

  ---

  ## ❌ Red Flags ([count])

  [List all critical issues that need addressing]

  ---

  ## 📈 Detailed Validation Results

  ### 1. Mathematical Consistency
  [Results from step 2]

  ### 2. Industry Benchmark Alignment
  [Results from step 3]

  ### 3. Assumptions Quality
  [Results from step 4]

  ### 4. Reference Projects Validity
  [Results from step 5]

  ### 5. Adjustment Factors Reasonableness
  [Results from step 6]

  ### 6. Risk Assessment Completeness
  [Results from step 7]

  ---

  ## 💡 Recommendations

  [List of actionable recommendations for improvement]

  ---

  ## 🎯 Final Verdict

  [Overall assessment and recommendation]

  ---

  *Validation performed by: [validator]*
  *Validation standard: IEEE 1045-1992*
  *Next review: [when]*
  ```

</create_report>

<calculate_confidence_score>

  SCORING:
  - Mathematical Consistency: 20 points
  - Benchmark Alignment: 20 points
  - Assumptions Quality: 15 points
  - Reference Projects: 15 points (if applicable)
  - Adjustment Factors: 15 points
  - Risk Assessment: 15 points

  DEDUCTIONS:
  - Each failed check: -5 points
  - Each warning: -2 points
  - Each red flag: -10 points

  CALCULATE: total_score / 100

  CATEGORIZE:
  - 80-100: ✅ Robust and defensible
  - 60-79: ⚠️ Reasonable with minor concerns
  - <60: ❌ Needs revision

</calculate_confidence_score>

<present_to_user>

  OUTPUT summary:

  "📊 Validation Complete!

  **Overall Confidence**: [score]/100 - [status]

  **Passed Checks**: [count]/[total]
  **Warnings**: [count]
  **Red Flags**: [count]

  **Key Findings**:
  - [Most important finding 1]
  - [Most important finding 2]
  - [Most important finding 3]

  **Recommendation**: [overall recommendation]

  Full report saved to:
  .agent-os/specs/[spec-name]/estimation/estimation-validation-report.md"

</present_to_user>

</step>

</process_flow>

## Validation Standards

This validation follows:
- IEEE 1045-1992 (Software Productivity Metrics)
- PMBOK estimation guidelines
- Industry best practices for software estimation

## Success Criteria

A validation is successful when:
- ✅ All mathematical checks performed
- ✅ Industry benchmarks compared
- ✅ Assumptions reviewed
- ✅ Risks assessed
- ✅ Confidence score calculated
- ✅ Actionable recommendations provided
- ✅ Report generated

## Usage Notes

**For Teams**:
- Run validation after creating estimation
- Use to identify potential issues early
- Review warnings and address before client presentation

**For Clients/Stakeholders**:
- Use validation-report.md to understand estimation quality
- Check confidence score for reliability assessment
- Review red flags before approving budget

**For External AI Review**:
- Use estimation-validation.json as input
- Follow validation steps systematically
- Compare results with this tool's output

