# Spec Tasks

These are the tasks to be completed for the spec detailed in @agent-os/specs/2025-12-30-add-skill-command/spec.md

> Created: 2025-12-30
> Status: Ready for Implementation
> Estimated Timeline: 4-6 weeks

## Phase 1: Command & Workflow Setup (Week 1)

### 1.1 Command File Creation
- [x] Create `.claude/commands/agent-os/add-skill.md` command file
- [x] Define command metadata (name, description, tags)
- [x] Document command usage and examples
- [x] Define command arguments:
  - [x] `--analyze` flag for Mode A (analyze existing code)
  - [x] `--best-practices` flag for Mode B (use framework best practices)
  - [x] `--type` option (api, component, testing, deployment)
  - [x] `--framework` option (optional override)
- [x] Add help text and usage examples
- [x] Test command registration with Agent OS Manager

### 1.2 Workflow File Creation
- [x] Create `agent-os/workflows/skill/add-skill.md` workflow file
- [x] Define workflow structure with clear phases
- [x] Document Mode A workflow (analyze existing code)
- [x] Document Mode B workflow (use best practices)
- [x] Add decision tree for mode selection
- [x] Define inputs and outputs for each phase
- [x] Add error handling procedures

### 1.3 Workflow Steps Definition
- [x] Define detection phase steps
- [x] Define analysis phase steps (Mode A)
- [x] Define best practices selection steps (Mode B)
- [x] Define pattern validation steps
- [x] Define improvement selection steps
- [x] Define template processing steps
- [x] Define generation and preview steps
- [x] Add validation checkpoints between phases

## Phase 2: Framework Detection (Week 1-2)

### 2.1 Backend Framework Detection
- [x] Create `agent-os/workflows/skill/utils/detect-backend.md` utility
- [x] Implement Spring Boot detection:
  - [x] Check for `pom.xml` or `build.gradle`
  - [x] Check for Spring annotations (`@SpringBootApplication`)
  - [x] Detect version from dependencies
- [x] Implement Express detection:
  - [x] Check `package.json` for express dependency
  - [x] Check for `app.js` or `server.js` patterns
  - [x] Detect version from package.json
- [x] Implement FastAPI detection:
  - [x] Check `requirements.txt` or `pyproject.toml`
  - [x] Check for FastAPI imports
  - [x] Detect version from dependencies
- [x] Implement Django detection:
  - [x] Check for `manage.py` and `settings.py`
  - [x] Check for Django imports
  - [x] Detect version from dependencies
- [x] Implement Rails detection:
  - [x] Check `Gemfile` for rails gem
  - [x] Check for `config/application.rb`
  - [x] Detect version from Gemfile.lock

### 2.2 Frontend Framework Detection
- [x] Create `agent-os/workflows/skill/utils/detect-frontend.md` utility
- [x] Implement React detection:
  - [x] Check `package.json` for react dependency
  - [x] Check for JSX/TSX files
  - [x] Detect version and if using TypeScript
- [x] Implement Angular detection:
  - [x] Check `package.json` for @angular dependencies
  - [x] Check for `angular.json` config file
  - [x] Detect version from dependencies
- [x] Implement Vue detection:
  - [x] Check `package.json` for vue dependency
  - [x] Check for `.vue` files
  - [x] Detect version (Vue 2 vs Vue 3)
- [x] Implement Svelte detection:
  - [x] Check `package.json` for svelte dependency
  - [x] Check for `.svelte` files
  - [x] Detect version and if using SvelteKit

### 2.3 Testing Framework Detection
- [x] Create `agent-os/workflows/skill/utils/detect-testing.md` utility
- [x] Implement Playwright detection:
  - [x] Check `package.json` for @playwright/test
  - [x] Check for `playwright.config.ts/js`
  - [x] Detect configuration patterns
- [x] Implement Jest detection:
  - [x] Check for jest dependency
  - [x] Check for `jest.config.js`
  - [x] Detect test file patterns
- [x] Implement Pytest detection:
  - [x] Check for pytest in dependencies
  - [x] Check for `pytest.ini` or `pyproject.toml` config
  - [x] Detect test file patterns
- [x] Implement RSpec detection:
  - [x] Check Gemfile for rspec-rails
  - [x] Check for `spec/` directory
  - [x] Detect test patterns

### 2.4 CI/CD Platform Detection
- [x] Create `agent-os/workflows/skill/utils/detect-cicd.md` utility
- [x] Implement GitHub Actions detection:
  - [x] Check for `.github/workflows/` directory
  - [x] Parse workflow YAML files
  - [x] Extract deployment patterns
- [x] Implement GitLab CI detection:
  - [x] Check for `.gitlab-ci.yml`
  - [x] Parse pipeline configuration
  - [x] Extract deployment patterns
- [x] Implement Jenkins detection:
  - [x] Check for `Jenkinsfile`
  - [x] Parse pipeline definition
  - [x] Extract deployment patterns
- [x] Implement Docker detection:
  - [x] Check for `Dockerfile`
  - [x] Check for `docker-compose.yml`
  - [x] Parse container configuration

### 2.5 Detection Utility Functions
- [x] Create consolidated detection function
- [x] Implement confidence scoring for detections
- [x] Add support for multi-framework projects
- [x] Create detection result data structure
- [x] Add detection caching for performance
- [x] Implement detection validation
- [x] Create detection report generator

## Phase 3: Code Analysis Integration - Mode A (Week 2-3)

### 3.1 Explore Agent Integration
- [x] Review Explore agent capabilities in `agent-os/workflows/utils/explore.md`
- [x] Create integration wrapper for Explore agent
- [x] Define search patterns for different skill types
- [x] Implement pattern discovery orchestration
- [x] Add error handling for Explore agent failures
- [x] Create pattern discovery result parser

### 3.2 API Pattern Discovery
- [x] Create `agent-os/workflows/skill/analysis/discover-api-patterns.md`
- [x] Implement Controller pattern discovery:
  - [x] Search for controller files (*/controllers/*, *Controller.java, etc.)
  - [x] Extract routing patterns
  - [x] Extract request/response handling patterns
  - [x] Extract validation patterns
- [x] Implement Service pattern discovery:
  - [x] Search for service files
  - [x] Extract business logic patterns
  - [x] Extract transaction handling
  - [x] Extract error handling patterns
- [x] Implement Repository pattern discovery:
  - [x] Search for repository/DAO files
  - [x] Extract data access patterns
  - [x] Extract query patterns
  - [x] Extract ORM usage patterns
- [x] Create API pattern aggregation function
- [x] Generate API pattern summary report

### 3.3 Component Pattern Discovery
- [x] Create `agent-os/workflows/skill/analysis/discover-component-patterns.md`
- [x] Implement Component structure discovery:
  - [x] Search for component files (*.jsx, *.tsx, *.vue, *.svelte)
  - [x] Extract component organization patterns
  - [x] Extract props/interface patterns
  - [x] Extract composition patterns
- [x] Implement State management discovery:
  - [x] Detect state management library (Redux, Zustand, Pinia, etc.)
  - [x] Extract state patterns
  - [x] Extract action/mutation patterns
  - [x] Extract selector patterns
- [x] Implement Styling discovery:
  - [x] Detect styling approach (CSS Modules, Styled Components, Tailwind)
  - [x] Extract styling patterns
  - [x] Extract theme usage
  - [x] Extract responsive patterns
- [x] Create component pattern aggregation function
- [x] Generate component pattern summary report

### 3.4 Testing Pattern Discovery
- [x] Create `agent-os/workflows/skill/analysis/discover-testing-patterns.md`
- [x] Implement test file discovery:
  - [x] Search for test files (*.test.*, *.spec.*, *_test.*, test_*.*)
  - [x] Map tests to source files
  - [x] Calculate test coverage by file type
- [x] Implement test framework usage discovery:
  - [x] Extract test setup patterns
  - [x] Extract assertion patterns
  - [x] Extract mocking patterns
  - [x] Extract fixture patterns
- [x] Implement test organization discovery:
  - [x] Extract test suite structure
  - [x] Extract test naming conventions
  - [x] Extract test helper patterns
- [x] Calculate test coverage metrics
- [x] Generate testing pattern summary report

### 3.5 Deployment Pattern Discovery
- [x] Create `agent-os/workflows/skill/analysis/discover-deployment-patterns.md`
- [x] Implement CI/CD workflow discovery:
  - [x] Parse workflow/pipeline files
  - [x] Extract build steps
  - [x] Extract test execution steps
  - [x] Extract deployment steps
- [x] Implement Docker pattern discovery:
  - [x] Parse Dockerfile patterns
  - [x] Extract multi-stage build patterns
  - [x] Extract environment configuration
  - [x] Extract service orchestration
- [x] Implement deployment configuration discovery:
  - [x] Extract environment-specific configs
  - [x] Extract secrets management patterns
  - [x] Extract infrastructure as code patterns
- [x] Generate deployment pattern summary report

### 3.6 Pattern Extraction Functions
- [x] Create `agent-os/workflows/skill/utils/extract-patterns.md`
- [x] Implement code snippet extraction
- [x] Implement pattern frequency analysis
- [x] Implement pattern consistency checking
- [x] Create pattern normalization functions
- [x] Add pattern deduplication logic
- [x] Create pattern ranking by usage frequency

## Phase 4: Pattern Validation (Week 3)

### 4.1 Best Practices Definition
- [x] Create `agent-os/workflows/skill/validation/best-practices/` directory
- [x] Define Spring Boot best practices:
  - [x] Controller best practices (REST conventions, status codes)
  - [x] Service layer best practices (transactions, error handling)
  - [x] Repository best practices (query optimization, pagination)
  - [x] Security best practices (authentication, authorization)
- [x] Define Express best practices:
  - [x] Routing best practices (middleware, error handling)
  - [x] Controller best practices (async/await, validation)
  - [x] Service organization best practices
  - [x] Security best practices (helmet, CORS, rate limiting)
- [x] Define React best practices:
  - [x] Component best practices (composition, props, hooks)
  - [x] State management best practices
  - [x] Performance best practices (memoization, lazy loading)
  - [x] Accessibility best practices
- [x] Define Angular best practices:
  - [x] Component best practices (templates, change detection)
  - [x] Service best practices (dependency injection)
  - [x] Module organization best practices
  - [x] RxJS best practices
- [x] Define testing best practices:
  - [x] Test structure best practices (AAA pattern, naming)
  - [x] Coverage best practices (unit, integration, e2e)
  - [x] Mocking best practices
  - [x] Assertion best practices

### 4.2 Pattern Comparison Logic
- [x] Create `agent-os/workflows/skill/validation/compare-patterns.md`
- [x] Implement pattern matching algorithm
- [x] Implement similarity scoring
- [x] Implement gap analysis (missing best practices)
- [x] Implement anti-pattern detection
- [x] Create comparison result data structure
- [x] Add detailed comparison reporting

### 4.3 Improvement Suggestions Generation
- [x] Create `agent-os/workflows/skill/validation/generate-improvements.md`
- [x] Implement improvement categorization:
  - [x] ❌ Critical (security issues, major bugs)
  - [x] ⚠️ Warning (performance issues, deprecated patterns)
  - [x] ℹ️ Info (style improvements, minor optimizations)
- [x] Create improvement templates:
  - [x] Current pattern description
  - [x] Issue explanation
  - [x] Recommended pattern
  - [x] Before/after code examples
  - [x] Impact assessment
- [x] Implement improvement prioritization
- [x] Add rationale for each improvement
- [x] Create improvement summary report

### 4.4 Validation Reports
- [x] Create `agent-os/workflows/skill/validation/create-report.md`
- [x] Design validation report structure:
  - [x] Executive summary (overall score, critical issues)
  - [x] Framework detection results
  - [x] Pattern analysis results
  - [x] Improvements by severity
  - [x] Recommendations summary
- [x] Implement report formatting (Markdown)
- [x] Add visual indicators (✅ Good, ⚠️ Warning, ❌ Critical)
- [x] Create actionable improvement checklist
- [x] Add links to relevant best practices documentation

## Phase 5: Interactive Improvement Selection (Week 4)

### 5.1 AskUserQuestion Integration
- [x] Review AskUserQuestion agent capabilities
- [x] Create wrapper for improvement selection questions
- [x] Design question format for improvements
- [x] Implement multi-select question support
- [x] Add skip/accept all options
- [x] Handle user response parsing

### 5.2 Improvement Presentation
- [x] Create `agent-os/workflows/skill/interactive/present-improvements.md`
- [x] Design improvement display format:
  - [x] Show severity badge
  - [x] Show current pattern (before)
  - [x] Show recommended pattern (after)
  - [x] Show impact description
  - [x] Show code examples
- [x] Implement pagination for many improvements
- [x] Group improvements by category
- [x] Add filtering options (by severity, by type)
- [x] Create clear accept/reject UI text

### 5.3 Before/After Examples
- [x] Generate side-by-side code comparisons
- [x] Highlight specific changes
- [x] Add inline comments explaining changes
- [x] Show impact metrics (performance, maintainability)
- [x] Create visual diff representation
- [x] Add context around code snippets

### 5.4 Apply Selected Improvements
- [x] Create `agent-os/workflows/skill/interactive/apply-improvements.md`
- [x] Implement improvement application logic:
  - [x] Parse selected improvements
  - [x] Update pattern definitions
  - [x] Merge improvements into templates
  - [x] Validate updated patterns
- [x] Handle partial selections (some accepted, some rejected)
- [x] Create improvement application log
- [x] Validate applied improvements

### 5.5 Skip Rejected Improvements
- [x] Implement rejection tracking
- [x] Update pattern list to exclude rejected improvements
- [x] Log rejection reasons (if provided by user)
- [x] Create rejected improvements summary
- [x] Preserve original patterns for rejected improvements

## Phase 6: Best Practices Mode - Mode B (Week 4-5)

### 6.1 Framework Selection Q&A
- [x] Create `agent-os/workflows/skill/best-practices/framework-selection.md`
- [x] Design framework selection questions:
  - [x] "What type of skill are you creating?" (API, Component, Testing, Deployment)
  - [x] "What backend framework?" (if API skill)
  - [x] "What frontend framework?" (if Component skill)
  - [x] "What testing framework?" (if Testing skill)
  - [x] "What CI/CD platform?" (if Deployment skill)
- [x] Implement framework version selection
- [x] Add "Detect automatically" option
- [x] Handle unknown/custom frameworks
- [x] Validate framework compatibility

### 6.2 Best Practices Knowledge Base - Spring Boot
- [x] Create `agent-os/workflows/skill/validation/best-practices/spring-boot.md`
- [x] Document Controller patterns (REST endpoints, validation, responses)
- [x] Document Service patterns (transactions, business logic, error handling)
- [x] Document Repository patterns (JPA, queries, pagination)
- [x] Document Exception handling (@ControllerAdvice)
- [x] Document Security patterns (authentication, authorization)
- [x] Add code examples for each pattern
- [x] Include common pitfalls and anti-patterns

### 6.3 Best Practices Knowledge Base - Express
- [x] Create `agent-os/workflows/skill/validation/best-practices/express.md`
- [x] Document Routing patterns (Router, middleware, error handling)
- [x] Document Controller patterns (async/await, responses, status codes)
- [x] Document Service patterns (business logic, DI, error handling)
- [x] Document Validation patterns (express-validator, Joi)
- [x] Document Security patterns (helmet, CORS, rate limiting)
- [x] Add code examples for each pattern

### 6.4 Best Practices Knowledge Base - React
- [x] Create `agent-os/workflows/skill/validation/best-practices/react.md`
- [x] Document Component patterns (functional, hooks, composition)
- [x] Document State management (useState, useReducer, Context, Redux)
- [x] Document Performance patterns (useMemo, useCallback, React.memo)
- [x] Document Props and TypeScript interfaces
- [x] Document Styling patterns (Tailwind, CSS Modules)
- [x] Document Event handling patterns
- [x] Add code examples and anti-patterns

### 6.5 Best Practices Knowledge Base - Angular
- [x] Create `agent-os/workflows/skill/validation/best-practices/angular.md`
- [x] Document Component patterns (decorators, templates, change detection)
- [x] Document Service patterns (DI, providedIn, RxJS, HTTP client)
- [x] Document Module patterns (feature, shared, lazy loading)
- [x] Document Standalone components patterns
- [x] Document Lifecycle hooks and reactive programming
- [x] Add code examples for each pattern

### 6.6 Best Practices Knowledge Base - Playwright
- [x] Create `agent-os/workflows/skill/validation/best-practices/playwright.md`
- [x] Document Test structure (describe, test, fixtures, naming)
- [x] Document Selector patterns (getByRole, accessibility-first)
- [x] Document Assertion patterns (auto-waiting, visual regression)
- [x] Document Page Object Model patterns
- [x] Document Test isolation (setup/teardown, data management)
- [x] Add code examples and debugging practices

### 6.7 Best Practices Knowledge Base - GitHub Actions
- [x] Create `agent-os/workflows/skill/validation/best-practices/github-actions.md`
- [x] Document Workflow structure (triggers, jobs, steps)
- [x] Document Build patterns (caching, artifacts, matrix builds)
- [x] Document Test patterns (execution, coverage, reporting)
- [x] Document Deployment patterns (environments, secrets, rollback)
- [x] Document Security practices (OIDC, secrets management)
- [x] Add workflow examples for each pattern

## Phase 7: Template Processing (Week 5)

### 7.1 Template Loading
- [x] Create `agent-os/templates/skills/` directory structure
- [x] Create API skill template (`api-patterns.md.template`)
- [x] Create Component skill template (`component-patterns.md.template`)
- [x] Create Testing skill template (`testing-patterns.md.template`)
- [x] Create Deployment skill template (`deployment-patterns.md.template`)
- [x] Implement template loader function
- [x] Add template validation
- [x] Handle missing template errors

### 7.2 Template Marker Parsing
- [x] Create `agent-os/workflows/skill/utils/parse-template.md`
- [x] Implement [CUSTOMIZE] marker detection
- [x] Implement [PROJECT] marker detection
- [x] Implement conditional section markers
- [x] Create marker replacement data structure
- [x] Add marker validation (detect unmatched markers)
- [x] Create marker extraction function

### 7.3 Pattern-Based Marker Replacement
- [x] Create `agent-os/workflows/skill/utils/replace-markers.md`
- [x] Implement replacement for detected patterns:
  - [x] [CUSTOMIZE:CONTROLLER_PATTERN] → extracted controller patterns
  - [x] [CUSTOMIZE:SERVICE_PATTERN] → extracted service patterns
  - [x] [CUSTOMIZE:COMPONENT_PATTERN] → extracted component patterns
  - [x] [CUSTOMIZE:TEST_PATTERN] → extracted test patterns
  - [x] [CUSTOMIZE:DEPLOYMENT_PATTERN] → extracted deployment patterns
- [x] Handle multiple pattern instances
- [x] Format patterns for template insertion
- [x] Add code formatting (indentation, syntax highlighting)

### 7.4 Best Practices Marker Replacement
- [x] Implement replacement for best practices:
  - [x] [CUSTOMIZE:FRAMEWORK_BEST_PRACTICES] → selected framework patterns
  - [x] [CUSTOMIZE:EXAMPLE_CODE] → framework-specific examples
  - [x] [CUSTOMIZE:COMMON_PITFALLS] → framework-specific anti-patterns
  - [x] [CUSTOMIZE:RECOMMENDATIONS] → improvement suggestions
- [x] Format best practices for template insertion
- [x] Add references to documentation

### 7.5 Project Marker Replacement
- [x] Implement [PROJECT] marker replacement:
  - [x] [PROJECT:NAME] → detected project name
  - [x] [PROJECT:FRAMEWORK] → detected framework name and version
  - [x] [PROJECT:PATH] → project directory path
- [x] Format project information for template insertion
- [x] Handle missing project information

### 7.6 Section Validation
- [x] Validate all required sections are filled
- [x] Check for remaining [CUSTOMIZE] markers
- [x] Validate code examples syntax
- [x] Validate file path globs
- [x] Check for empty sections
- [x] Create validation error report

## Phase 8: Project Name Detection (Week 5)

### 8.1 Agent OS Config Detection
- [x] Create `agent-os/workflows/skill/utils/detect-project-name.md`
- [x] Check for `agent-os/config.yml` file
- [x] Parse YAML configuration
- [x] Extract `project.name` field
- [x] Validate project name format
- [x] Handle missing config file

### 8.2 Package.json Detection
- [x] Check for `package.json` file
- [x] Parse JSON configuration
- [x] Extract `name` field
- [x] Clean npm scope (remove @scope/)
- [x] Validate package name format
- [x] Handle missing package.json

### 8.3 Directory Name Fallback
- [x] Extract current directory name
- [x] Clean directory name (remove special characters)
- [x] Convert to lowercase
- [x] Replace spaces with hyphens
- [x] Validate directory name

### 8.4 User Prompt
- [x] Implement AskUserQuestion for project name
- [x] Provide detected name as default
- [x] Validate user input
- [x] Format user-provided name
- [x] Save to agent-os/config.yml for future use

### 8.5 Name Formatting
- [x] Create name normalization function:
  - [x] Convert to lowercase
  - [x] Replace spaces with hyphens
  - [x] Remove special characters (except hyphens)
  - [x] Trim leading/trailing hyphens
  - [x] Validate final format (alphanumeric + hyphens only)
- [x] Add name validation rules
- [x] Handle edge cases (empty, too long, invalid characters)

## Phase 9: Skill File Generation (Week 6)

### 9.1 Frontmatter Generation
- [x] Create `agent-os/workflows/skill/utils/generate-frontmatter.md`
- [x] Generate skill name:
  - [x] Format: `[project]-[type]-patterns`
  - [x] Example: `my-app-api-patterns`
- [x] Generate skill description:
  - [x] Based on skill type and framework
  - [x] Include version information
  - [x] Mention analyzed patterns or best practices used
- [x] Generate file globs:
  - [x] API: `src/**/*Controller.java`, `src/**/*Service.java`, etc.
  - [x] Component: `src/**/*.tsx`, `src/**/*.jsx`, etc.
  - [x] Testing: `**/*.test.ts`, `**/*.spec.ts`, etc.
  - [x] Deployment: `.github/workflows/**/*.yml`, `Dockerfile`, etc.
- [x] Add metadata (created date, version, framework)
- [x] Validate frontmatter YAML syntax

### 9.2 Content Assembly
- [x] Create `agent-os/workflows/skill/utils/assemble-skill.md`
- [x] Combine frontmatter + template content
- [x] Insert framework-specific sections
- [x] Add pattern examples with code snippets
- [x] Add improvement recommendations section
- [x] Add common pitfalls section
- [x] Add references to documentation
- [x] Format final Markdown content

### 9.3 Skill Structure Validation
- [x] Validate frontmatter structure:
  - [x] Required fields present (name, description, globs)
  - [x] Valid YAML syntax
  - [x] Glob patterns are valid
- [x] Validate content structure:
  - [x] Required sections present
  - [x] No empty sections
  - [x] No unresolved markers
  - [x] Code examples have syntax highlighting
- [x] Validate file name format
- [x] Create validation report

### 9.4 Preview Generation
- [x] Create skill preview function
- [x] Format preview with sections:
  - [x] Frontmatter overview
  - [x] Key patterns (first 3)
  - [x] Improvements applied count
  - [x] File globs covered
  - [x] Estimated coverage
- [x] Add syntax highlighting for code examples
- [x] Include statistics (number of patterns, examples, etc.)
- [x] Format for terminal display

### 9.5 File Path Determination
- [x] Create skill file path:
  - [x] Base path: `.claude/skills/`
  - [x] File name: `[project]-[type]-patterns.md`
  - [x] Example: `.claude/skills/my-app-api-patterns.md`
- [x] Check if file already exists
- [x] Handle file name conflicts (append number or prompt)
- [x] Create `.claude/skills/` directory if needed
- [x] Validate file path is writable

### 9.6 File Saving
- [x] Implement save function
- [x] Write file with UTF-8 encoding
- [x] Preserve line endings (LF)
- [x] Set appropriate file permissions
- [x] Verify file was written successfully
- [x] Create backup of existing file (if overwriting)
- [x] Log save operation

## Phase 10: Preview & Confirmation (Week 6)

### 10.1 Skill Preview Display
- [x] Create `agent-os/workflows/skill/interactive/preview-skill.md`
- [x] Display preview to user:
  - [x] Header with skill name and description
  - [x] Frontmatter section
  - [x] Key patterns summary (top 5)
  - [x] Improvements summary
  - [x] File globs covered
  - [x] Code examples (abbreviated)
- [x] Format preview for readability:
  - [x] Use markdown formatting
  - [x] Syntax highlight code blocks
  - [x] Add separators between sections
  - [x] Include statistics
- [x] Add option to view full content

### 10.2 Key Sections Display
- [x] Show filled template sections:
  - [x] Framework configuration
  - [x] Pattern definitions
  - [x] Code examples
  - [x] Best practices
  - [x] Common pitfalls
  - [x] Recommendations
- [x] Highlight customized sections
- [x] Show section completion status
- [x] Add section navigation

### 10.3 Improvements Summary
- [x] Create improvements summary:
  - [x] Total improvements found
  - [x] Improvements applied (user accepted)
  - [x] Improvements skipped (user rejected)
  - [x] Breakdown by severity (Critical, Warning, Info)
  - [x] Breakdown by category (Structure, Performance, Security, etc.)
- [x] Show impact summary
- [x] List key improvements applied

### 10.4 User Confirmation
- [x] Implement confirmation question using AskUserQuestion:
  - [x] "Review the skill preview above. Would you like to save this skill?"
  - [x] Options: "Yes, save it", "No, cancel", "Show full content first"
- [x] Handle "Show full content" option:
  - [x] Display complete skill file
  - [x] Ask confirmation again
- [x] Handle "Yes" option:
  - [x] Proceed to save
  - [x] Show success message
- [x] Handle "No" option:
  - [x] Cancel operation
  - [x] Offer to make changes
  - [x] Ask if user wants to start over

### 10.5 Save on Approval
- [x] Save skill file to determined path
- [x] Confirm file was written successfully
- [x] Display success message:
  - [x] Show file path
  - [x] Show skill name
  - [x] Show patterns count
  - [x] Show next steps
- [x] Log operation to Agent OS activity log
- [x] Update project skill registry (if exists)

### 10.6 Post-Save Actions
- [x] Display next steps:
  - [x] How to use the skill in .claude/claude.json
  - [x] How to test the skill
  - [x] How to update the skill later
- [x] Offer to:
  - [x] Create another skill
  - [x] Add skill to claude.json automatically
  - [x] Run validation on the skill
- [x] Create success summary report

## Cross-Cutting Concerns

### Error Handling
- [ ] Implement comprehensive error handling for all phases
- [ ] Create error message templates
- [ ] Add error recovery suggestions
- [ ] Log errors for debugging
- [ ] Provide helpful error messages to users

### Logging & Debugging
- [ ] Add logging throughout workflow
- [ ] Create debug mode for verbose output
- [ ] Log all agent interactions
- [ ] Log all file operations
- [ ] Create execution trace for troubleshooting

### Testing
- [ ] Create unit tests for utility functions
- [ ] Create integration tests for workflow phases
- [ ] Test with different frameworks
- [ ] Test Mode A vs Mode B workflows
- [ ] Test error conditions
- [ ] Create test fixtures and sample projects

### Documentation
- [ ] Document all utility functions
- [ ] Create workflow phase documentation
- [ ] Add inline comments to complex logic
- [ ] Create troubleshooting guide
- [ ] Create user guide with examples
- [ ] Add architecture decision records

### Performance Optimization
- [ ] Optimize pattern detection (cache results)
- [ ] Optimize Explore agent queries
- [ ] Optimize file reading operations
- [ ] Add progress indicators for long operations
- [ ] Implement parallel processing where applicable

---

## Timeline Summary

- **Week 1**: Phase 1-2 (Command setup, Framework detection)
- **Week 2**: Phase 3 (Code analysis, Mode A)
- **Week 3**: Phase 4 (Pattern validation)
- **Week 4**: Phase 5-6 (Interactive improvements, Mode B)
- **Week 5**: Phase 7-8 (Template processing, Project detection)
- **Week 6**: Phase 9-10 (File generation, Preview & confirmation)

## Success Criteria

- [ ] Command registered and discoverable in Agent OS Manager
- [ ] Both Mode A and Mode B workflows functional
- [ ] All supported frameworks detected accurately
- [ ] Pattern analysis produces meaningful results
- [ ] Interactive improvement selection works smoothly
- [ ] Generated skills are valid and useful
- [ ] Documentation is complete and clear
- [ ] All tests pass
- [ ] User can successfully create skills for their projects
