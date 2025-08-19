---
description: Changelog Update Rules for Agent OS Extended
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Changelog Update Rules

## Overview

Erstelle oder aktualisiere automatisch ein Changelog basierend auf dokumentierten Features in .agent-os/docs/, die seit dem letzten Update hinzugekommen sind.

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

### Step 2: Bestehenden Changelog analysieren

Use the context-fetcher subagent to check for existing changelog and determine last update date.

<changelog_location>.agent-os/docs/changelog.md</changelog_location>

<existing_changelog_check>
  IF changelog_exists:
    READ changelog.md
    EXTRACT last_update_date from "Last Updated: YYYY-MM-DD" line
    SET baseline_date to last_update_date
  ELSE:
    SET baseline_date to null (include all documented features)
    PREPARE for new changelog creation
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

<step number="4" name="feature_filtering">

### Step 4: Features seit letztem Update filtern

Filter features based on creation date relative to last changelog update.

<filtering_logic>
  IF baseline_date is null:
    INCLUDE all documented features
  ELSE:
    FOR each feature:
      IF feature.creation_date > baseline_date:
        INCLUDE in new_features list
      ELSE IF feature.creation_date == baseline_date:
        CHECK if feature already exists in current changelog
        IF not_in_changelog:
          INCLUDE in new_features list
        ELSE:
          SKIP (already documented)
</filtering_logic>

<same_day_check>
  <duplicate_detection>
    IF feature.creation_date == baseline_date:
      SEARCH existing changelog for feature_name
      IF found:
        SKIP feature
      ELSE:
        INCLUDE feature
  </duplicate_detection>
</same_day_check>

</step>

<step number="5" subagent="context-fetcher" name="feature_description_extraction">

### Step 5: Feature-Beschreibungen extrahieren

Use the context-fetcher subagent to extract concise descriptions from each new feature.

<description_extraction>
  FOR each new_feature:
    READ feature.md or sub-feature.md file
    EXTRACT concise description from overview section
    LIMIT description to 1-2 sentences maximum
    FOCUS on user benefit, not technical details
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
</description_sources>

<description_optimization>
  <length_limit>Maximum 120 characters per feature description</length_limit>
  <content_focus>
    - User-facing benefits
    - Core functionality
    - Avoid technical implementation details
  </content_focus>
  <style>
    - Clear and concise
    - Action-oriented language
    - Professional tone
  </style>
</description_optimization>

</step>

<step number="6" name="changelog_date_grouping">

### Step 6: Features nach Datum gruppieren

Group new features by their creation date for organized changelog presentation.

<grouping_strategy>
  GROUP features by creation_date (descending order)
  WITHIN each date group:
    LIST main features first
    LIST sub-features under their parent features
</grouping_strategy>

<date_structure>
  {
    "2025-08-19": {
      "main_features": [feature1, feature2],
      "sub_features": {
        "Parent-Feature-Name": [sub1, sub2]
      }
    },
    "2025-08-18": {
      "main_features": [feature3],
      "sub_features": {}
    }
  }
</date_structure>

</step>

<step number="7" subagent="file-creator" name="changelog_update">

### Step 7: Changelog erstellen oder aktualisieren

Use the file-creator subagent to create or update the changelog.md file.

<changelog_template>
  <header>
    # Changelog
    
    > Feature Release History
    > Last Updated: [CURRENT_DATE]
    
    Dieses Changelog dokumentiert alle implementierten und dokumentierten Features chronologisch.
  </header>
  
  <entry_format>
    ## [YYYY-MM-DD] - [FORMATTED_DATE]
    
    ### Features
    - **[Feature-Name]**: [concise_description]
    
    ### Sub-Features
    - **[Parent-Feature]** → **[Sub-Feature-Name]**: [concise_description]
  </entry_format>
</changelog_template>

<update_strategy>
  IF existing_changelog:
    UPDATE header with new Last Updated date
    INSERT new date sections at top (after header)
    PRESERVE existing entries below
  ELSE:
    CREATE new changelog with header
    ADD all documented features grouped by date
</update_strategy>

<formatting_rules>
  <date_formatting>
    - Section header: ## YYYY-MM-DD - Readable Date
    - Example: ## 2025-08-19 - 19. August 2025
  </date_formatting>
  
  <feature_formatting>
    - Main features: **[Feature-Name]**: Description
    - Sub-features: **[Parent]** → **[Sub-Feature]**: Description
    - Maintain alphabetical order within each category
  </feature_formatting>
  
  <description_style>
    - Start with action verb where possible
    - Keep under 120 characters
    - Focus on user value
  </description_style>
</formatting_rules>

</step>

<step number="8" name="changelog_validation">

### Step 8: Changelog validieren

Validate the updated changelog for completeness and accuracy.

<validation_checks>
  <content_validation>
    - [ ] All new features included
    - [ ] Descriptions are concise and user-focused
    - [ ] Dates are properly formatted
    - [ ] No duplicate entries
  </content_validation>
  
  <format_validation>
    - [ ] Header contains correct Last Updated date
    - [ ] Date sections in descending order
    - [ ] Consistent formatting throughout
    - [ ] Sub-features properly nested under parents
  </format_validation>
  
  <completeness_validation>
    - [ ] All documented features since baseline_date included
    - [ ] No features missed from same-day check
    - [ ] Existing changelog entries preserved
  </completeness_validation>
</validation_checks>

</step>

<step number="9" name="user_summary">

### Step 9: Benutzer-Zusammenfassung

Present summary of changelog update to user.

<summary_template>
  Changelog wurde erfolgreich aktualisiert:
  
  **Neue Features hinzugefügt:** [COUNT]
  **Neue Sub-Features hinzugefügt:** [COUNT]
  **Zeitraum:** [OLDEST_NEW_DATE] bis [NEWEST_NEW_DATE]
  
  **Hinzugefügte Features:**
  [LIST_OF_NEW_FEATURES_WITH_DATES]
  
  **Changelog-Datei:** @.agent-os/docs/changelog.md
  
  Das Changelog ist jetzt auf dem aktuellen Stand mit allen dokumentierten Features.
</summary_template>

<no_updates_scenario>
  IF no_new_features_found:
    OUTPUT: "Keine neuen Features seit dem letzten Changelog-Update ([LAST_UPDATE_DATE]) gefunden. Das Changelog ist bereits aktuell."
</no_updates_scenario>

</step>

</process_flow>

## Changelog Standards

<content_standards>
  <user_focus>
    - Beschreibungen für Endbenutzer, nicht Entwickler
    - Fokus auf praktischen Nutzen und Vorteilen
    - Vermeidung technischer Implementierungsdetails
  </user_focus>
  
  <conciseness>
    - Maximale Beschreibungslänge: 120 Zeichen
    - Kernfunktionalität in einem Satz
    - Aktive Sprache verwenden
  </conciseness>
  
  <chronological_organization>
    - Neueste Features zuerst
    - Gruppierung nach Erstellungsdatum
    - Konsistente Datumsformatierung
  </chronological_organization>
</content_standards>

<integration_rules>
  <feature_detection>
    - Nur dokumentierte Features in .agent-os/docs/ berücksichtigen
    - Features ohne "Created:" Datum ignorieren oder nachfragen
    - Sub-Features ihren Hauptfeatures zuordnen
  </feature_detection>
  
  <duplicate_prevention>
    - Bei gleichem Datum: Existing changelog auf Duplikate prüfen
    - Feature-Namen als Identifikation verwenden
    - Case-insensitive Vergleich für robuste Erkennung
  </duplicate_prevention>
</integration_rules>

<error_handling>
  <missing_dates>
    IF feature_has_no_creation_date:
      LOG warning
      ASK user for clarification
      SUGGEST adding creation date to feature documentation
  </missing_dates>
  
  <malformed_docs>
    IF feature_documentation_incomplete:
      LOG warning
      INCLUDE feature with generic description
      SUGGEST improving feature documentation
  </malformed_docs>
  
  <file_access_errors>
    IF cannot_read_docs_directory:
      ERROR: "Kann .agent-os/docs/ nicht lesen. Stelle sicher, dass Dokumentationsstruktur existiert."
      SUGGEST running document-feature command first
  </file_access_errors>
</error_handling>

<final_checklist>
  <verify>
    - [ ] Aktuelles Datum korrekt ermittelt
    - [ ] Bestehendes Changelog analysiert
    - [ ] Alle dokumentierten Features gescannt
    - [ ] Features seit letztem Update gefiltert
    - [ ] Beschreibungen extrahiert und optimiert
    - [ ] Features nach Datum gruppiert
    - [ ] Changelog korrekt aktualisiert
    - [ ] Validierung erfolgreich
    - [ ] Benutzer-Zusammenfassung präsentiert
  </verify>
</final_checklist>