# Execute Bug (Shortcut)

Shortcut to execute bug specifications. Filters `specwright/specs/` for bug specs (containing "bugfix" in name) and runs `/execute-tasks` on the selected spec.

**Equivalent to:** `/execute-tasks [bugfix-spec-name]`

**What execute-tasks does for bug specs:**
- Creates `bugfix/[name]` branch
- Uses `fix:` commit prefix
- Assigns agents based on bug type
- Enforces quality gates (Architect + QA)

Refer to the instructions located in @specwright/workflows/core/execute-bug.md