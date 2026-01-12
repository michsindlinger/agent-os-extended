# Automated Story Execution (Lite)

> Kurzbeschreibung: Anpassungen am create-spec Workflow, damit User Stories automatisch (ohne Benutzerinteraktion) abgearbeitet werden können - inspiriert von Ralph Wiggum.

## Kernänderungen

1. **Story-Sizing-Regeln**: Max 5 Dateien, 400 LOC, Komplexität S
2. **Prüfbare Akzeptanzkriterien**: FILE_EXISTS, CONTAINS, LINT_PASS, MCP_PLAYWRIGHT Format
3. **Completion-Check**: Bash-Commands die verifizieren wann Story "fertig"
4. **MCP-Tool-Check**: Vor Story-Start werden Required Tools geprüft (Blocking bei Fehlen)
5. **Setup-Integration**: Neue Docs werden bei Installation mitgeliefert

## 7 Stories

| ID | Was | Größe | Parallel |
|----|-----|-------|----------|
| ASE-001 | Story-Sizing-Guidelines.md erstellen | XS | Ja (mit 006) |
| ASE-002 | user-stories-template.md anpassen (inkl. MCP) | S | - |
| ASE-003 | create-spec.md PO-Phase anpassen | S | - |
| ASE-004 | create-spec.md Architect-Phase anpassen | S | - |
| ASE-005 | MCP-Tool-Check in execute-tasks | S | - |
| ASE-006 | MCP-Setup-Guide erstellen | XS | Ja (mit 001) |
| ASE-007 | setup.sh um neue Docs erweitern | XS | Nach 001+006 |

## Ziel

Claude Code kann eine Story nehmen und weiß durch die prüfbaren Kriterien exakt, wann sie fertig ist - ohne nachfragen zu müssen. Bei Frontend-Stories mit Browser-Verification werden MCP-Tools (Playwright) automatisch geprüft und bei Fehlen blockiert.
