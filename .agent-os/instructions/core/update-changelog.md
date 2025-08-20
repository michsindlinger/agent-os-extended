---
description: Changelog Update Rules for Agent OS Extended
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Changelog Update Rules

## Overview

Erstelle oder aktualisiere automatisch zweisprachige Changelogs (Deutsch und Englisch) basierend auf dokumentierten Features in .agent-os/docs/ und gelösten Bugs in .agent-os/bugs/, die seit dem letzten Update hinzugekommen sind.

<pre_flight_check>
  EXECUTE: @~/.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="date-checker" name="current_date_determination">

### Step 1: Aktuelles Datum ermitteln

Use the date-checker subagent to determine today's date for changelog update tracking.

<date_format>YYYY-MM-DD</date_format>

</step>

<step number="2" subagent="context-fetcher" name="existing_changelog_analysis">

### Step 2: Bestehende Changelogs analysieren

Use the context-fetcher subagent to check for existing changelogs and determine last update date.

<changelog_locations>
  - .agent-os/docs/changelog.md (Deutsch)
  - .agent-os/docs/changelog-en.md (English)
</changelog_locations>

<existing_changelog_check>
  FOR each changelog_file in [changelog.md, changelog-en.md]:
    IF changelog_file_exists:
      READ changelog_file
      EXTRACT last_update_date from "Last Updated: YYYY-MM-DD" line
      STORE baseline_date for that language
    ELSE:
      SET baseline_date to null for that language
      PREPARE for new changelog creation
  
  USE most_recent_baseline_date from both files as reference
</existing_changelog_check>

<last_update_extraction>
  <search_pattern>Last Updated: ([0-9]{4}-[0-9]{2}-[0-9]{2})</search_pattern>
  <fallback>
    IF no_last_updated_found:
      SET baseline_date to earliest_possible_date (e.g., 1900-01-01)
  </fallback>
</last_update_extraction>

</step>

<step number="3" subagent="context-fetcher" name="documented_features_scan">

### Step 3: Dokumentierte Features scannen

Use the context-fetcher subagent to identify all documented features in .agent-os/docs/ and their creation dates.

<scan_strategy>
  <main_features>
    SCAN .agent-os/docs/*/feature.md files
    EXTRACT creation_date from "Created: YYYY-MM-DD" line in each file
    EXTRACT feature_name from folder name and first header
  </main_features>
  
  <sub_features>
    SCAN .agent-os/docs/*/sub-features/*.md files
    EXTRACT creation_date from "Created: YYYY-MM-DD" line in each file
    EXTRACT sub_feature_name and parent_feature from file structure
  </sub_features>
</scan_strategy>

<date_extraction>
  <search_pattern>Created: ([0-9]{4}-[0-9]{2}-[0-9]{2})</search_pattern>
  <alternative_patterns>
    - "Last Updated: ([0-9]{4}-[0-9]{2}-[0-9]{2})" (if no Created found)
    - "> Feature Documentation\n> Last Updated: ([0-9]{4}-[0-9]{2}-[0-9]{2})"
  </alternative_patterns>
</date_extraction>

<feature_data_structure>
  {
    "feature_name": "string",
    "creation_date": "YYYY-MM-DD",
    "type": "main_feature|sub_feature",
    "parent_feature": "string (for sub_features)",
    "file_path": "string",
    "description": "string (extracted from feature overview)"
  }
</feature_data_structure>

</step>

<step number="3b" subagent="context-fetcher" name="resolved_bugs_scan">

### Step 3b: Gelöste Bugs scannen

Use the context-fetcher subagent to identify all resolved bugs in .agent-os/bugs/ and their resolution dates.

<bug_scan_strategy>
  <resolved_bugs>
    SCAN .agent-os/bugs/*/bug-report.md files
    FILTER by Status: "Resolved" or "Closed"
    EXTRACT resolution_date from "Resolved Date:" line in resolution/ files
    EXTRACT bug_title from main header
    EXTRACT bug_summary from "Summary" section
  </resolved_bugs>
</bug_scan_strategy>

<bug_date_extraction>
  <search_patterns>
    - "Resolved Date: ([0-9]{4}-[0-9]{2}-[0-9]{2})" (from resolution documentation)
    - "**Status**: Resolved" + look for date in resolution/ directory
    - "**Status**: Closed" + look for date in resolution/ directory
  </search_patterns>
  <fallback>
    IF no_resolution_date_found:
      USE last_modified_date of resolution/ directory
  </fallback>
</bug_date_extraction>

<bug_data_structure>
  {
    "bug_title": "string",
    "resolution_date": "YYYY-MM-DD",
    "type": "bug_fix",
    "severity": "Critical|High|Medium|Low",
    "file_path": "string",
    "summary": "string (extracted from bug summary)",
    "solution_summary": "string (extracted from resolution)"
  }
</bug_data_structure>

</step>

<step number="4" name="content_filtering">

### Step 4: Features und Bugs seit letztem Update filtern

Filter features and bugs based on their dates relative to last changelog update.

<filtering_logic>
  IF baseline_date is null:
    INCLUDE all documented features and resolved bugs
  ELSE:
    FOR each feature:
      IF feature.creation_date > baseline_date:
        INCLUDE in new_features list
      ELSE IF feature.creation_date == baseline_date:
        CHECK if feature already exists in current changelog
        IF not_in_changelog:
          INCLUDE in new_features list
    
    FOR each bug:
      IF bug.resolution_date > baseline_date:
        INCLUDE in resolved_bugs list
      ELSE IF bug.resolution_date == baseline_date:
        CHECK if bug already exists in current changelog
        IF not_in_changelog:
          INCLUDE in resolved_bugs list
</filtering_logic>

<same_day_check>
  <duplicate_detection>
    IF item.date == baseline_date:
      SEARCH existing changelog for item_name
      IF found:
        SKIP item
      ELSE:
        INCLUDE item
  </duplicate_detection>
</same_day_check>

</step>

<step number="5" subagent="context-fetcher" name="content_description_extraction">

### Step 5: Feature- und Bug-Beschreibungen extrahieren (Zweisprachig)

Use the context-fetcher subagent to extract concise descriptions from each new feature and resolved bug in both German and English.

<description_extraction>
  FOR each new_feature:
    READ feature.md or sub-feature.md file
    EXTRACT concise description from overview section
    CREATE German description (primary)
    TRANSLATE to English description (secondary)
    LIMIT both descriptions to 1-2 sentences maximum
    FOCUS on user benefit, not technical details
  
  FOR each resolved_bug:
    READ bug-report.md and resolution files
    EXTRACT concise description from summary and solution
    CREATE German description (primary)
    TRANSLATE to English description (secondary)
    LIMIT both descriptions to 1-2 sentences maximum
    FOCUS on user impact and fix benefit
</description_extraction>

<description_sources>
  <main_features>
    EXTRACT from "## Overview" section first paragraph
    FALLBACK to "## What This Feature Does" summary
  </main_features>
  
  <sub_features>
    EXTRACT from "## Purpose" section
    FALLBACK to first paragraph of file
  </sub_features>
  
  <resolved_bugs>
    EXTRACT from "## Summary" and "## Solution Implemented"
    COMBINE bug impact and fix description
    FOCUS on "Fixed issue where..." format
  </resolved_bugs>
</description_sources>

<description_optimization>
  <length_limit>Maximum 120 characters per item description (both DE and EN)</length_limit>
  <content_focus>
    - User-facing benefits (features)
    - Issue resolution (bugs)
    - Core functionality
    - Avoid technical implementation details
  </content_focus>
  <style>
    - Clear and concise
    - Action-oriented language
    - Professional tone
    - "Fixed:" prefix for bug fixes
    - "Added:" prefix for new features
  </style>
  <translation_quality>
    - Maintain meaning and tone across languages
    - Use appropriate technical terminology per language
    - Ensure cultural appropriateness
  </translation_quality>
</description_optimization>

</step>

<step number="6" name="changelog_date_grouping">

### Step 6: Features und Bugs nach Datum gruppieren

Group new features and resolved bugs by their dates for organized changelog presentation.

<grouping_strategy>
  GROUP features by creation_date and bugs by resolution_date (descending order)
  WITHIN each date group:
    LIST new features first
    LIST resolved bugs second
    LIST sub-features under their parent features
</grouping_strategy>

<date_structure>
  {
    "2025-08-19": {
      "features": {
        "main_features": [feature1, feature2],
        "sub_features": {
          "Parent-Feature-Name": [sub1, sub2]
        }
      },
      "bugs": [
        {
          "title": "Bug Title",
          "severity": "High",
          "summary": "Fixed issue where..."
        }
      ]
    },
    "2025-08-18": {
      "features": {
        "main_features": [feature3],
        "sub_features": {}
      },
      "bugs": []
    }
  }
</date_structure>

</step>

<step number="7" subagent="file-creator" name="changelog_update">

### Step 7: Zweisprachige Changelogs erstellen oder aktualisieren

Use the file-creator subagent to create or update both German and English changelog files including features and bug fixes.

<changelog_templates>
  <german_template>
    # Changelog
    
    > Feature Release History & Bug Fixes
    > Last Updated: [CURRENT_DATE]
    
    Dieses Changelog dokumentiert alle implementierten Features und gelösten Bugs chronologisch.
    
    ## [YYYY-MM-DD] - [FORMATTED_DATE_DE]
    
    ### Features
    - **[Feature-Name]**: [german_description]
    
    ### Sub-Features
    - **[Parent-Feature]** → **[Sub-Feature-Name]**: [german_description]
    
    ### Bug Fixes
    - **[Bug-Title]** ([Severity]): [german_fix_description]
  </german_template>
  
  <english_template>
    # Changelog
    
    > Feature Release History & Bug Fixes
    > Last Updated: [CURRENT_DATE]
    
    This changelog documents all implemented features and resolved bugs chronologically.
    
    ## [YYYY-MM-DD] - [FORMATTED_DATE_EN]
    
    ### Features
    - **[Feature-Name]**: [english_description]
    
    ### Sub-Features
    - **[Parent-Feature]** → **[Sub-Feature-Name]**: [english_description]
    
    ### Bug Fixes
    - **[Bug-Title]** ([Severity]): [english_fix_description]
  </english_template>
</changelog_templates>

<update_strategy>
  FOR each language [de, en]:
    IF existing_changelog_for_language:
      UPDATE header with new Last Updated date
      INSERT new date sections at top (after header)
      PRESERVE existing entries below
    ELSE:
      CREATE new changelog with appropriate language template
      ADD all documented features and resolved bugs grouped by date
</update_strategy>

<formatting_rules>
  <date_formatting>
    <german>
      - Section header: ## YYYY-MM-DD - Readable Date (German)
      - Example: ## 2025-08-19 - 19. August 2025
    </german>
    <english>
      - Section header: ## YYYY-MM-DD - Readable Date (English)  
      - Example: ## 2025-08-19 - August 19, 2025
    </english>
  </date_formatting>
  
  <content_formatting>
    - Features: **[Feature-Name]**: Description
    - Sub-features: **[Parent]** → **[Sub-Feature]**: Description
    - Bug fixes: **[Bug-Title]** ([Severity]): Fixed description
    - Maintain alphabetical order within each category
    - Use same names across both languages
  </content_formatting>
  
  <section_order>
    1. Features (new functionality)
    2. Sub-Features (enhancements to existing features)
    3. Bug Fixes (issue resolutions)
  </section_order>
  
  <description_style>
    - Features: Start with action verb where possible
    - Bug fixes: Start with "Fixed issue where..." or similar
    - Keep under 120 characters per language
    - Focus on user value and impact
    - Maintain consistency in terminology across languages
  </description_style>
  
  <file_locations>
    - German: .agent-os/docs/changelog.md
    - English: .agent-os/docs/changelog-en.md
  </file_locations>
</formatting_rules>

</step>

<step number="8" name="changelog_validation">

### Step 8: Zweisprachige Changelogs validieren

Validate both updated changelogs for completeness and accuracy including bug fixes.

<validation_checks>
  <content_validation>
    FOR each language [de, en]:
      - [ ] All new features included
      - [ ] All resolved bugs included
      - [ ] Descriptions are concise and user-focused
      - [ ] Dates are properly formatted for language
      - [ ] No duplicate entries
      - [ ] Translation quality maintained
      - [ ] Bug severity levels are included
  </content_validation>
  
  <format_validation>
    FOR each language [de, en]:
      - [ ] Header contains correct Last Updated date
      - [ ] Date sections in descending order
      - [ ] Consistent formatting throughout
      - [ ] Sub-features properly nested under parents
      - [ ] Bug fixes properly formatted with severity
      - [ ] Language-appropriate date formatting
      - [ ] Section order: Features → Sub-Features → Bug Fixes
  </format_validation>
  
  <completeness_validation>
    - [ ] All documented features since baseline_date included in both files
    - [ ] All resolved bugs since baseline_date included in both files
    - [ ] No items missed from same-day check
    - [ ] Existing changelog entries preserved in both files
    - [ ] Item names consistent across languages
    - [ ] Same feature and bug count in both changelogs
  </completeness_validation>
  
  <cross_language_validation>
    - [ ] Both changelogs contain identical feature and bug sets
    - [ ] Descriptions convey same meaning across languages
    - [ ] Date formatting appropriate for each language
    - [ ] No missing translations
    - [ ] Bug severity levels translated appropriately
  </cross_language_validation>
</validation_checks>

</step>

<step number="9" name="user_summary">

### Step 9: Benutzer-Zusammenfassung

Present summary of bilingual changelog update to user including features and bug fixes.

<summary_template>
  Zweisprachige Changelogs wurden erfolgreich aktualisiert:
  
  **Neue Features hinzugefügt:** [FEATURE_COUNT]
  **Neue Sub-Features hinzugefügt:** [SUB_FEATURE_COUNT]
  **Gelöste Bugs hinzugefügt:** [BUG_COUNT]
  **Zeitraum:** [OLDEST_NEW_DATE] bis [NEWEST_NEW_DATE]
  
  **Hinzugefügte Features:**
  [LIST_OF_NEW_FEATURES_WITH_DATES]
  
  **Gelöste Bugs:**
  [LIST_OF_RESOLVED_BUGS_WITH_DATES_AND_SEVERITY]
  
  **Changelog-Dateien:** 
  - Deutsch: @.agent-os/docs/changelog.md
  - English: @.agent-os/docs/changelog-en.md
  
  Beide Changelogs sind jetzt auf dem aktuellen Stand mit allen dokumentierten Features und gelösten Bugs.
</summary_template>

<no_updates_scenario>
  IF no_new_features_and_no_resolved_bugs_found:
    OUTPUT: "Keine neuen Features oder gelösten Bugs seit dem letzten Changelog-Update ([LAST_UPDATE_DATE]) gefunden. Beide Changelogs sind bereits aktuell."
</no_updates_scenario>

</step>

</process_flow>

## Changelog Standards

<content_standards>
  <user_focus>
    - Beschreibungen für Endbenutzer, nicht Entwickler
    - Fokus auf praktischen Nutzen und Vorteilen
    - Vermeidung technischer Implementierungsdetails
    - Bug fixes: Fokus auf gelöste Probleme und Verbesserungen
  </user_focus>
  
  <conciseness>
    - Maximale Beschreibungslänge: 120 Zeichen
    - Kernfunktionalität in einem Satz
    - Aktive Sprache verwenden
    - Bug fixes: "Fixed issue where..." Format verwenden
  </conciseness>
  
  <chronological_organization>
    - Neueste Einträge zuerst
    - Gruppierung nach Datum (Features und Bugs zusammen)
    - Konsistente Datumsformatierung
    - Separate Abschnitte für Features und Bug fixes pro Datum
  </chronological_organization>
</content_standards>

<integration_rules>
  <content_detection>
    - Nur dokumentierte Features in .agent-os/docs/ berücksichtigen
    - Nur gelöste Bugs in .agent-os/bugs/ berücksichtigen (Status: Resolved/Closed)
    - Items ohne Datum ignorieren oder nachfragen
    - Sub-Features ihren Hauptfeatures zuordnen
  </content_detection>
  
  <duplicate_prevention>
    - Bei gleichem Datum: Existing changelog auf Duplikate prüfen
    - Feature-Namen und Bug-Titel als Identifikation verwenden
    - Case-insensitive Vergleich für robuste Erkennung
  </duplicate_prevention>
  
  <bug_integration>
    - Bug fixes in separatem Abschnitt pro Datum
    - Severity level in Klammern nach Titel
    - Fokus auf Lösung und Benutzernutzen
    - Verknüpfung zu Bug-ID für Nachverfolgung
  </bug_integration>
</integration_rules>

<error_handling>
  <missing_dates>
    IF item_has_no_date:
      LOG warning
      ASK user for clarification
      SUGGEST adding date to documentation
  </missing_dates>
  
  <malformed_docs>
    IF documentation_incomplete:
      LOG warning
      INCLUDE item with generic description
      SUGGEST improving documentation
  </malformed_docs>
  
  <file_access_errors>
    IF cannot_read_directories:
      ERROR: "Kann .agent-os/docs/ oder .agent-os/bugs/ nicht lesen."
      SUGGEST running document-feature oder create-bug command first
  </file_access_errors>
  
  <unresolved_bugs>
    IF bug_status_not_resolved:
      SKIP bug from changelog
      LOG info about open bugs not included
  </unresolved_bugs>
</error_handling>

<final_checklist>
  <verify>
    - [ ] Aktuelles Datum korrekt ermittelt
    - [ ] Bestehendes Changelog analysiert
    - [ ] Alle dokumentierten Features gescannt
    - [ ] Alle gelösten Bugs gescannt
    - [ ] Content seit letztem Update gefiltert
    - [ ] Beschreibungen extrahiert und optimiert
    - [ ] Features und Bugs nach Datum gruppiert
    - [ ] Changelog korrekt aktualisiert (Features + Bugs)
    - [ ] Validierung erfolgreich
    - [ ] Benutzer-Zusammenfassung präsentiert
  </verify>
</final_checklist>