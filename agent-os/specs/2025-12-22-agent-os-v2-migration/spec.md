# Spec Requirements Document

> Spec: Agent OS Extended - Version 2.0 Migration
> Created: 2025-12-22

## Overview

Migrate Agent OS Extended to incorporate Version 2.0 architectural improvements while maintaining our project-level installation philosophy and enterprise extensions. This migration will be executed in two phases: Phase I focuses on structural alignment with v2.0 conventions, and Phase II introduces advanced features like profile system, Claude Skills-based standards injection, enhanced research workflows, and verification systems.

## User Stories

### Story 1: Seamless Migration for Existing Projects

As a developer using Agent OS Extended in multiple projects, I want to update all my existing projects to the new v2.0 structure with a single command, so that I can benefit from the improvements without manual work in each project.

When I run the update script, it automatically detects my current Agent OS Extended installation, backs up existing configuration, migrates directory structures, updates command locations, and preserves all custom settings and enterprise extensions. The migration is non-destructive and can be rolled back if needed.

### Story 2: Profile-Based Development Experience

As a full-stack developer working on different tech stacks, I want to use profile-specific standards and patterns for each project type, so that I receive relevant guidance without context bloat from irrelevant technologies.

When I initialize a new project or switch profiles, the system automatically activates the appropriate Claude Skills (Java Spring Boot, React, or Angular) that provide contextual guidance only when working on relevant files. This reduces token usage by 60-80% compared to loading all standards upfront.

### Story 3: Enhanced Feature Planning

As a product developer, I want an interactive research phase during spec creation that analyzes existing code patterns and asks clarifying questions, so that I create more complete and consistent specifications.

When I run `/create-spec`, the agent first enters a research phase where it analyzes my codebase for existing patterns, asks targeted questions about unclear requirements, and allows me to attach mockups or wireframes. This results in specifications that are aligned with existing architecture and have fewer gaps.

## Spec Scope

1. **Phase I: Structural Migration** - Rename directories (`.agent-os` → `agent-os`, `instructions/` → `workflows/`), isolate commands (`.claude/commands/agent-os/`), update all setup scripts, and create migration scripts for existing projects
2. **Phase II: Profile System** - Implement profile structure with three initial profiles (Java Spring Boot Backend, React Frontend, Angular Frontend) supporting inheritance and flexible switching
3. **Phase II: Claude Skills Integration** - Convert standards to Claude Code Skills that activate contextually instead of conditional rendering, reducing context usage significantly
4. **Phase II: Enhanced Research Phase** - Extend `/create-spec` with interactive Q&A, codebase pattern analysis, and visual asset integration capabilities
5. **Phase II: Verification System** - Add verification workflows for spec completeness, implementation quality, and visual UI comparison

## Out of Scope

- Central installation in `~/agent-os` (we maintain project-level installation philosophy)
- Compilation architecture from central location (our direct installation approach remains)
- Changes to enterprise extensions (B2B workflows, brainstorming system, custom commands remain unchanged)
- Migration of non-Claude Code tools (Cursor, Gemini) in Phase I/II (can be added in future phases)

## Expected Deliverable

1. Existing Agent OS Extended projects can be migrated to v2.0 structure using `update-to-v2.sh` script with automatic backup and rollback capability
2. New projects installed with updated setup scripts automatically use v2.0 structure (`agent-os/`, `workflows/`, isolated commands)
3. Profile system allows developers to activate Java Spring Boot, React, or Angular profiles with appropriate Claude Skills that provide contextual guidance
4. `/create-spec` command includes interactive research phase with codebase analysis, targeted questions, and mockup integration
5. All major workflows include verification checkpoints that ensure completeness and quality before proceeding to next phase
