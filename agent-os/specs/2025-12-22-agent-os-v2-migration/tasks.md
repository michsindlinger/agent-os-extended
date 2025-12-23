# Spec Tasks

## Phase I: Structural Migration

- [ ] 1. Create Migration Script (update-to-v2.sh)
  - [ ] 1.1 Write tests for migration script functionality
  - [ ] 1.2 Implement pre-flight checks (detect version, check git status)
  - [ ] 1.3 Implement backup creation with timestamped directory
  - [ ] 1.4 Implement directory renaming (.agent-os → agent-os)
  - [ ] 1.5 Implement workflows rename (instructions → workflows)
  - [ ] 1.6 Implement command isolation (.claude/commands/agent-os/)
  - [ ] 1.7 Implement reference updates (@.agent-os/ → @agent-os/)
  - [ ] 1.8 Implement verification and summary report
  - [ ] 1.9 Verify all tests pass

- [ ] 2. Create Rollback Script (rollback-v2-migration.sh)
  - [ ] 2.1 Write tests for rollback functionality
  - [ ] 2.2 Implement backup detection and validation
  - [ ] 2.3 Implement restoration from backup
  - [ ] 2.4 Implement cleanup of v2 directories
  - [ ] 2.5 Verify all tests pass

- [ ] 3. Update Setup Scripts
  - [ ] 3.1 Write tests for updated setup scripts
  - [ ] 3.2 Update setup.sh for new directory structure
  - [ ] 3.3 Update setup-claude-code.sh for new directory structure
  - [ ] 3.4 Update paths to use agent-os/ and workflows/
  - [ ] 3.5 Update command installation to .claude/commands/agent-os/
  - [ ] 3.6 Verify all tests pass

- [ ] 4. Update Documentation
  - [ ] 4.1 Update README.md with new structure
  - [ ] 4.2 Update CLAUDE.md.template with new paths
  - [ ] 4.3 Create migration guide (MIGRATION.md)
  - [ ] 4.4 Update all workflow documentation references
  - [ ] 4.5 Verify documentation accuracy

- [ ] 5. Migrate Agent OS Extended Repository
  - [ ] 5.1 Run migration script on agent-os-extended repo
  - [ ] 5.2 Verify all commands still work
  - [ ] 5.3 Test setup scripts with fresh installation
  - [ ] 5.4 Commit migrated structure to repository
  - [ ] 5.5 Tag release as v2.0.0-phase1

## Phase II: Advanced Features

- [ ] 6. Implement Profile System
  - [ ] 6.1 Write tests for profile loading and switching
  - [ ] 6.2 Create profile directory structure (agent-os/profiles/)
  - [ ] 6.3 Define profile schema (YAML frontmatter in markdown)
  - [ ] 6.4 Create Java Spring Boot profile
  - [ ] 6.5 Create React Frontend profile
  - [ ] 6.6 Create Angular Frontend profile
  - [ ] 6.7 Implement profile configuration (agent-os/config.yml)
  - [ ] 6.8 Create /switch-profile command
  - [ ] 6.9 Verify all tests pass

- [ ] 7. Implement Claude Skills System
  - [ ] 7.1 Write tests for skill structure and activation
  - [ ] 7.2 Create skills directory structure (agent-os/skills/)
  - [ ] 7.3 Create Java core patterns skill
  - [ ] 7.4 Create Spring Boot conventions skill
  - [ ] 7.5 Create JPA best practices skill
  - [ ] 7.6 Create React component patterns skill
  - [ ] 7.7 Create React hooks best practices skill
  - [ ] 7.8 Create Angular component patterns skill
  - [ ] 7.9 Create Angular services patterns skill
  - [ ] 7.10 Create symlinks in .claude/skills/ to agent-os/skills/
  - [ ] 7.11 Document skill creation guidelines
  - [ ] 7.12 Verify all tests pass

- [ ] 8. Convert Existing Standards to Skills
  - [ ] 8.1 Analyze current standards structure
  - [ ] 8.2 Convert tech-stack.md to profile-specific configs
  - [ ] 8.3 Convert code-style.md to language-specific skills
  - [ ] 8.4 Convert best-practices.md to contextual skills
  - [ ] 8.5 Test skill activation with sample projects
  - [ ] 8.6 Verify context reduction (measure token usage)

- [ ] 9. Enhance /create-spec with Research Phase
  - [ ] 9.1 Write tests for research workflow
  - [ ] 9.2 Create analyze-codebase-patterns workflow
  - [ ] 9.3 Implement pattern detection logic (using Grep/Read)
  - [ ] 9.4 Create interactive Q&A template system
  - [ ] 9.5 Implement visual asset collection and storage
  - [ ] 9.6 Create research-notes.md template
  - [ ] 9.7 Integrate research phase into create-spec workflow
  - [ ] 9.8 Update create-spec command documentation
  - [ ] 9.9 Verify all tests pass

- [ ] 10. Implement Verification System
  - [ ] 10.1 Write tests for verification workflows
  - [ ] 10.2 Create verify-spec workflow with completeness checklist
  - [ ] 10.3 Create verify-implementation workflow with quality checks
  - [ ] 10.4 Create verify-visual workflow (with optional Playwright)
  - [ ] 10.5 Integrate spec verification into create-spec
  - [ ] 10.6 Integrate implementation verification into execute-tasks
  - [ ] 10.7 Document verification usage and benefits
  - [ ] 10.8 Verify all tests pass

- [ ] 11. Update All Setup Scripts for Phase II
  - [ ] 11.1 Update setup.sh to install profiles and skills
  - [ ] 11.2 Update setup-claude-code.sh to create skills symlinks
  - [ ] 11.3 Add profile selection during setup
  - [ ] 11.4 Test fresh installation with all profiles
  - [ ] 11.5 Verify all tests pass

- [ ] 12. Migration Testing and Documentation
  - [ ] 12.1 Test migration on sample projects
  - [ ] 12.2 Test profile switching functionality
  - [ ] 12.3 Test skill activation in real development scenarios
  - [ ] 12.4 Measure and document context reduction
  - [ ] 12.5 Update all documentation for Phase II features
  - [ ] 12.6 Create video tutorial or guide for new features
  - [ ] 12.7 Tag release as v2.0.0
