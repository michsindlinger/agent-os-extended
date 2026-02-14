# Spec Requirements Document

> Spec: Anthropic Skills Format Migration
> Created: 2026-01-12
> Status: Planning

## Overview

Migration aller Specwright Skill-Templates vom aktuellen flachen Dateiformat (skill-name.md) zum offiziellen Anthropic Skills Format mit Ordnerstruktur (skill-name/SKILL.md). Zusaetzlich wird ein Migrations-Script bereitgestellt, das bestehende Dev-Team Skills in Projekten automatisch konvertiert.

## User Stories

See: @specwright/specs/2026-01-12-anthropic-skills-format-migration/user-stories.md

## Spec Scope

- Migration aller Skill-Templates in specwright/templates/skills/ zum neuen Format
- Erstellung eines Migrations-Scripts fuer bestehende Projekte mit Dev-Team
- Aktualisierung der Skill-Referenzen in betroffenen Workflows
- Dokumentation des neuen Formats fuer zukuenftige Skill-Erstellung

## Out of Scope

- Inhaltliche Aenderungen an den Skills selbst
- Migration von Skills ausserhalb des specwright Templates-Ordners
- Automatische Migration ohne User-Bestaetigung
- Backward-Compatibility mit dem alten Format
- Aenderungen an der Claude Code CLI selbst

## Expected Deliverable

- Alle Skill-Templates im specwright/templates/skills/ Ordner folgen dem Anthropic Format (Ordner mit SKILL.md)
- Ein ausfuehrbares Migrations-Script (migrate-skills-format.sh), das:
  - Bestehende flache Skills erkennt
  - Automatisch in das neue Format konvertiert
  - Fehlermeldungen bei Problemen ausgibt
- Aktualisierte Workflow-Dateien, die auf das neue Format verweisen

## Spec Documentation

- Tasks: @specwright/specs/2026-01-12-anthropic-skills-format-migration/tasks.md
- Technical Specification: @specwright/specs/2026-01-12-anthropic-skills-format-migration/sub-specs/technical-spec.md
- User Stories: @specwright/specs/2026-01-12-anthropic-skills-format-migration/user-stories.md
