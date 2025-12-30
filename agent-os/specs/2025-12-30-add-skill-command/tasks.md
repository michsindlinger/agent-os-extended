# Spec Tasks

These are the tasks to be completed for the spec detailed in @agent-os/specs/2025-12-30-add-skill-command/spec.md

> Created: 2025-12-30
> Status: Ready for Implementation
> Estimated Timeline: 4-6 weeks

## Phase 1: Command & Workflow Setup (Week 1)

### 1.1 Command File Creation
- [ ] Create `.claude/commands/agent-os/add-skill.md` command file
- [ ] Define command metadata (name, description, tags)
- [ ] Document command usage and examples
- [ ] Define command arguments:
  - [ ] `--analyze` flag for Mode A (analyze existing code)
  - [ ] `--best-practices` flag for Mode B (use framework best practices)
  - [ ] `--type` option (api, component, testing, deployment)
  - [ ] `--framework` option (optional override)
- [ ] Add help text and usage examples
- [ ] Test command registration with Agent OS Manager

### 1.2 Workflow File Creation
- [ ] Create `agent-os/workflows/skill/add-skill.md` workflow file
- [ ] Define workflow structure with clear phases
- [ ] Document Mode A workflow (analyze existing code)
- [ ] Document Mode B workflow (use best practices)
- [ ] Add decision tree for mode selection
- [ ] Define inputs and outputs for each phase
- [ ] Add error handling procedures

### 1.3 Workflow Steps Definition
- [ ] Define detection phase steps
- [ ] Define analysis phase steps (Mode A)
- [ ] Define best practices selection steps (Mode B)
- [ ] Define pattern validation steps
- [ ] Define improvement selection steps
- [ ] Define template processing steps
- [ ] Define generation and preview steps
- [ ] Add validation checkpoints between phases

## Phase 2: Framework Detection (Week 1-2)

### 2.1 Backend Framework Detection
- [ ] Create `agent-os/workflows/skill/utils/detect-backend.md` utility
- [ ] Implement Spring Boot detection:
  - [ ] Check for `pom.xml` or `build.gradle`
  - [ ] Check for Spring annotations (`@SpringBootApplication`)
  - [ ] Detect version from dependencies
- [ ] Implement Express detection:
  - [ ] Check `package.json` for express dependency
  - [ ] Check for `app.js` or `server.js` patterns
  - [ ] Detect version from package.json
- [ ] Implement FastAPI detection:
  - [ ] Check `requirements.txt` or `pyproject.toml`
  - [ ] Check for FastAPI imports
  - [ ] Detect version from dependencies
- [ ] Implement Django detection:
  - [ ] Check for `manage.py` and `settings.py`
  - [ ] Check for Django imports
  - [ ] Detect version from dependencies
- [ ] Implement Rails detection:
  - [ ] Check `Gemfile` for rails gem
  - [ ] Check for `config/application.rb`
  - [ ] Detect version from Gemfile.lock

### 2.2 Frontend Framework Detection
- [ ] Create `agent-os/workflows/skill/utils/detect-frontend.md` utility
- [ ] Implement React detection:
  - [ ] Check `package.json` for react dependency
  - [ ] Check for JSX/TSX files
  - [ ] Detect version and if using TypeScript
- [ ] Implement Angular detection:
  - [ ] Check `package.json` for @angular dependencies
  - [ ] Check for `angular.json` config file
  - [ ] Detect version from dependencies
- [ ] Implement Vue detection:
  - [ ] Check `package.json` for vue dependency
  - [ ] Check for `.vue` files
  - [ ] Detect version (Vue 2 vs Vue 3)
- [ ] Implement Svelte detection:
  - [ ] Check `package.json` for svelte dependency
  - [ ] Check for `.svelte` files
  - [ ] Detect version and if using SvelteKit

### 2.3 Testing Framework Detection
- [ ] Create `agent-os/workflows/skill/utils/detect-testing.md` utility
- [ ] Implement Playwright detection:
  - [ ] Check `package.json` for @playwright/test
  - [ ] Check for `playwright.config.ts/js`
  - [ ] Detect configuration patterns
- [ ] Implement Jest detection:
  - [ ] Check for jest dependency
  - [ ] Check for `jest.config.js`
  - [ ] Detect test file patterns
- [ ] Implement Pytest detection:
  - [ ] Check for pytest in dependencies
  - [ ] Check for `pytest.ini` or `pyproject.toml` config
  - [ ] Detect test file patterns
- [ ] Implement RSpec detection:
  - [ ] Check Gemfile for rspec-rails
  - [ ] Check for `spec/` directory
  - [ ] Detect test patterns

### 2.4 CI/CD Platform Detection
- [ ] Create `agent-os/workflows/skill/utils/detect-cicd.md` utility
- [ ] Implement GitHub Actions detection:
  - [ ] Check for `.github/workflows/` directory
  - [ ] Parse workflow YAML files
  - [ ] Extract deployment patterns
- [ ] Implement GitLab CI detection:
  - [ ] Check for `.gitlab-ci.yml`
  - [ ] Parse pipeline configuration
  - [ ] Extract deployment patterns
- [ ] Implement Jenkins detection:
  - [ ] Check for `Jenkinsfile`
  - [ ] Parse pipeline definition
  - [ ] Extract deployment patterns
- [ ] Implement Docker detection:
  - [ ] Check for `Dockerfile`
  - [ ] Check for `docker-compose.yml`
  - [ ] Parse container configuration

### 2.5 Detection Utility Functions
- [ ] Create consolidated detection function
- [ ] Implement confidence scoring for detections
- [ ] Add support for multi-framework projects
- [ ] Create detection result data structure
- [ ] Add detection caching for performance
- [ ] Implement detection validation
- [ ] Create detection report generator

## Phase 3: Code Analysis Integration - Mode A (Week 2-3)

### 3.1 Explore Agent Integration
- [ ] Review Explore agent capabilities in `agent-os/workflows/utils/explore.md`
- [ ] Create integration wrapper for Explore agent
- [ ] Define search patterns for different skill types
- [ ] Implement pattern discovery orchestration
- [ ] Add error handling for Explore agent failures
- [ ] Create pattern discovery result parser

### 3.2 API Pattern Discovery
- [ ] Create `agent-os/workflows/skill/analysis/discover-api-patterns.md`
- [ ] Implement Controller pattern discovery:
  - [ ] Search for controller files (*/controllers/*, *Controller.java, etc.)
  - [ ] Extract routing patterns
  - [ ] Extract request/response handling patterns
  - [ ] Extract validation patterns
- [ ] Implement Service pattern discovery:
  - [ ] Search for service files
  - [ ] Extract business logic patterns
  - [ ] Extract transaction handling
  - [ ] Extract error handling patterns
- [ ] Implement Repository pattern discovery:
  - [ ] Search for repository/DAO files
  - [ ] Extract data access patterns
  - [ ] Extract query patterns
  - [ ] Extract ORM usage patterns
- [ ] Create API pattern aggregation function
- [ ] Generate API pattern summary report

### 3.3 Component Pattern Discovery
- [ ] Create `agent-os/workflows/skill/analysis/discover-component-patterns.md`
- [ ] Implement Component structure discovery:
  - [ ] Search for component files (*.jsx, *.tsx, *.vue, *.svelte)
  - [ ] Extract component organization patterns
  - [ ] Extract props/interface patterns
  - [ ] Extract composition patterns
- [ ] Implement State management discovery:
  - [ ] Detect state management library (Redux, Zustand, Pinia, etc.)
  - [ ] Extract state patterns
  - [ ] Extract action/mutation patterns
  - [ ] Extract selector patterns
- [ ] Implement Styling discovery:
  - [ ] Detect styling approach (CSS Modules, Styled Components, Tailwind)
  - [ ] Extract styling patterns
  - [ ] Extract theme usage
  - [ ] Extract responsive patterns
- [ ] Create component pattern aggregation function
- [ ] Generate component pattern summary report

### 3.4 Testing Pattern Discovery
- [ ] Create `agent-os/workflows/skill/analysis/discover-testing-patterns.md`
- [ ] Implement test file discovery:
  - [ ] Search for test files (*.test.*, *.spec.*, *_test.*, test_*.*)
  - [ ] Map tests to source files
  - [ ] Calculate test coverage by file type
- [ ] Implement test framework usage discovery:
  - [ ] Extract test setup patterns
  - [ ] Extract assertion patterns
  - [ ] Extract mocking patterns
  - [ ] Extract fixture patterns
- [ ] Implement test organization discovery:
  - [ ] Extract test suite structure
  - [ ] Extract test naming conventions
  - [ ] Extract test helper patterns
- [ ] Calculate test coverage metrics
- [ ] Generate testing pattern summary report

### 3.5 Deployment Pattern Discovery
- [ ] Create `agent-os/workflows/skill/analysis/discover-deployment-patterns.md`
- [ ] Implement CI/CD workflow discovery:
  - [ ] Parse workflow/pipeline files
  - [ ] Extract build steps
  - [ ] Extract test execution steps
  - [ ] Extract deployment steps
- [ ] Implement Docker pattern discovery:
  - [ ] Parse Dockerfile patterns
  - [ ] Extract multi-stage build patterns
  - [ ] Extract environment configuration
  - [ ] Extract service orchestration
- [ ] Implement deployment configuration discovery:
  - [ ] Extract environment-specific configs
  - [ ] Extract secrets management patterns
  - [ ] Extract infrastructure as code patterns
- [ ] Generate deployment pattern summary report

### 3.6 Pattern Extraction Functions
- [ ] Create `agent-os/workflows/skill/utils/extract-patterns.md`
- [ ] Implement code snippet extraction
- [ ] Implement pattern frequency analysis
- [ ] Implement pattern consistency checking
- [ ] Create pattern normalization functions
- [ ] Add pattern deduplication logic
- [ ] Create pattern ranking by usage frequency

## Phase 4: Pattern Validation (Week 3)

### 4.1 Best Practices Definition
- [ ] Create `agent-os/workflows/skill/validation/best-practices/` directory
- [ ] Define Spring Boot best practices:
  - [ ] Controller best practices (REST conventions, status codes)
  - [ ] Service layer best practices (transactions, error handling)
  - [ ] Repository best practices (query optimization, pagination)
  - [ ] Security best practices (authentication, authorization)
- [ ] Define Express best practices:
  - [ ] Routing best practices (middleware, error handling)
  - [ ] Controller best practices (async/await, validation)
  - [ ] Service organization best practices
  - [ ] Security best practices (helmet, CORS, rate limiting)
- [ ] Define React best practices:
  - [ ] Component best practices (composition, props, hooks)
  - [ ] State management best practices
  - [ ] Performance best practices (memoization, lazy loading)
  - [ ] Accessibility best practices
- [ ] Define Angular best practices:
  - [ ] Component best practices (templates, change detection)
  - [ ] Service best practices (dependency injection)
  - [ ] Module organization best practices
  - [ ] RxJS best practices
- [ ] Define testing best practices:
  - [ ] Test structure best practices (AAA pattern, naming)
  - [ ] Coverage best practices (unit, integration, e2e)
  - [ ] Mocking best practices
  - [ ] Assertion best practices

### 4.2 Pattern Comparison Logic
- [ ] Create `agent-os/workflows/skill/validation/compare-patterns.md`
- [ ] Implement pattern matching algorithm
- [ ] Implement similarity scoring
- [ ] Implement gap analysis (missing best practices)
- [ ] Implement anti-pattern detection
- [ ] Create comparison result data structure
- [ ] Add detailed comparison reporting

### 4.3 Improvement Suggestions Generation
- [ ] Create `agent-os/workflows/skill/validation/generate-improvements.md`
- [ ] Implement improvement categorization:
  - [ ] ❌ Critical (security issues, major bugs)
  - [ ] ⚠️ Warning (performance issues, deprecated patterns)
  - [ ] ℹ️ Info (style improvements, minor optimizations)
- [ ] Create improvement templates:
  - [ ] Current pattern description
  - [ ] Issue explanation
  - [ ] Recommended pattern
  - [ ] Before/after code examples
  - [ ] Impact assessment
- [ ] Implement improvement prioritization
- [ ] Add rationale for each improvement
- [ ] Create improvement summary report

### 4.4 Validation Reports
- [ ] Create `agent-os/workflows/skill/validation/create-report.md`
- [ ] Design validation report structure:
  - [ ] Executive summary (overall score, critical issues)
  - [ ] Framework detection results
  - [ ] Pattern analysis results
  - [ ] Improvements by severity
  - [ ] Recommendations summary
- [ ] Implement report formatting (Markdown)
- [ ] Add visual indicators (✅ Good, ⚠️ Warning, ❌ Critical)
- [ ] Create actionable improvement checklist
- [ ] Add links to relevant best practices documentation

## Phase 5: Interactive Improvement Selection (Week 4)

### 5.1 AskUserQuestion Integration
- [ ] Review AskUserQuestion agent capabilities
- [ ] Create wrapper for improvement selection questions
- [ ] Design question format for improvements
- [ ] Implement multi-select question support
- [ ] Add skip/accept all options
- [ ] Handle user response parsing

### 5.2 Improvement Presentation
- [ ] Create `agent-os/workflows/skill/interactive/present-improvements.md`
- [ ] Design improvement display format:
  - [ ] Show severity badge
  - [ ] Show current pattern (before)
  - [ ] Show recommended pattern (after)
  - [ ] Show impact description
  - [ ] Show code examples
- [ ] Implement pagination for many improvements
- [ ] Group improvements by category
- [ ] Add filtering options (by severity, by type)
- [ ] Create clear accept/reject UI text

### 5.3 Before/After Examples
- [ ] Generate side-by-side code comparisons
- [ ] Highlight specific changes
- [ ] Add inline comments explaining changes
- [ ] Show impact metrics (performance, maintainability)
- [ ] Create visual diff representation
- [ ] Add context around code snippets

### 5.4 Apply Selected Improvements
- [ ] Create `agent-os/workflows/skill/interactive/apply-improvements.md`
- [ ] Implement improvement application logic:
  - [ ] Parse selected improvements
  - [ ] Update pattern definitions
  - [ ] Merge improvements into templates
  - [ ] Validate updated patterns
- [ ] Handle partial selections (some accepted, some rejected)
- [ ] Create improvement application log
- [ ] Validate applied improvements

### 5.5 Skip Rejected Improvements
- [ ] Implement rejection tracking
- [ ] Update pattern list to exclude rejected improvements
- [ ] Log rejection reasons (if provided by user)
- [ ] Create rejected improvements summary
- [ ] Preserve original patterns for rejected improvements

## Phase 6: Best Practices Mode - Mode B (Week 4-5)

### 6.1 Framework Selection Q&A
- [ ] Create `agent-os/workflows/skill/best-practices/framework-selection.md`
- [ ] Design framework selection questions:
  - [ ] "What type of skill are you creating?" (API, Component, Testing, Deployment)
  - [ ] "What backend framework?" (if API skill)
  - [ ] "What frontend framework?" (if Component skill)
  - [ ] "What testing framework?" (if Testing skill)
  - [ ] "What CI/CD platform?" (if Deployment skill)
- [ ] Implement framework version selection
- [ ] Add "Detect automatically" option
- [ ] Handle unknown/custom frameworks
- [ ] Validate framework compatibility

### 6.2 Best Practices Knowledge Base - Spring Boot
- [ ] Create `agent-os/workflows/skill/best-practices/spring-boot/api-patterns.md`
- [ ] Document Controller patterns:
  - [ ] REST endpoint structure
  - [ ] Request/response DTOs
  - [ ] Validation annotations
  - [ ] Exception handling
  - [ ] Status code conventions
- [ ] Document Service patterns:
  - [ ] Business logic organization
  - [ ] Transaction management (@Transactional)
  - [ ] Error handling
  - [ ] Logging patterns
- [ ] Document Repository patterns:
  - [ ] Spring Data JPA usage
  - [ ] Custom query methods
  - [ ] Pagination and sorting
  - [ ] Specification pattern
- [ ] Add code examples for each pattern
- [ ] Include common pitfalls and anti-patterns

### 6.3 Best Practices Knowledge Base - Express
- [ ] Create `agent-os/workflows/skill/best-practices/express/api-patterns.md`
- [ ] Document Routing patterns:
  - [ ] Router organization
  - [ ] Middleware usage
  - [ ] Error handling middleware
  - [ ] Request validation
- [ ] Document Controller patterns:
  - [ ] Async/await usage
  - [ ] Response formatting
  - [ ] Status codes
  - [ ] Error responses
- [ ] Document Service patterns:
  - [ ] Business logic separation
  - [ ] Dependency injection
  - [ ] Error handling
  - [ ] Promise handling
- [ ] Add code examples for each pattern
- [ ] Include security best practices (helmet, CORS)

### 6.4 Best Practices Knowledge Base - React
- [ ] Create `agent-os/workflows/skill/best-practices/react/component-patterns.md`
- [ ] Document Component patterns:
  - [ ] Functional component structure
  - [ ] Props interface/types
  - [ ] Custom hooks
  - [ ] Component composition
  - [ ] Event handling
- [ ] Document State management patterns:
  - [ ] useState usage
  - [ ] useEffect dependencies
  - [ ] Context API usage
  - [ ] Redux/Zustand patterns (if detected)
- [ ] Document Styling patterns:
  - [ ] CSS Modules usage
  - [ ] Tailwind patterns
  - [ ] Styled Components patterns
  - [ ] Theme usage
- [ ] Document Performance patterns:
  - [ ] useMemo/useCallback usage
  - [ ] React.memo usage
  - [ ] Code splitting/lazy loading
  - [ ] Virtual scrolling
- [ ] Add code examples for each pattern
- [ ] Include accessibility best practices

### 6.5 Best Practices Knowledge Base - Angular
- [ ] Create `agent-os/workflows/skill/best-practices/angular/component-patterns.md`
- [ ] Document Component patterns:
  - [ ] Component decorator configuration
  - [ ] Template syntax
  - [ ] Change detection strategies
  - [ ] Lifecycle hooks usage
- [ ] Document Service patterns:
  - [ ] Dependency injection
  - [ ] providedIn configuration
  - [ ] RxJS observable patterns
  - [ ] HTTP client usage
- [ ] Document Module patterns:
  - [ ] Feature module organization
  - [ ] Shared module patterns
  - [ ] Lazy loading modules
  - [ ] Core module patterns
- [ ] Add code examples for each pattern
- [ ] Include reactive programming best practices

### 6.6 Best Practices Knowledge Base - Playwright
- [ ] Create `agent-os/workflows/skill/best-practices/playwright/testing-patterns.md`
- [ ] Document Test structure patterns:
  - [ ] Test file organization
  - [ ] Page object model
  - [ ] Test fixtures
  - [ ] Test naming conventions
- [ ] Document Selector patterns:
  - [ ] Role-based selectors
  - [ ] Test ID selectors
  - [ ] Locator best practices
  - [ ] Accessibility-first selectors
- [ ] Document Assertion patterns:
  - [ ] Auto-waiting assertions
  - [ ] Visual regression testing
  - [ ] Accessibility testing
  - [ ] Network assertion patterns
- [ ] Document Test isolation patterns:
  - [ ] Setup/teardown
  - [ ] Test data management
  - [ ] Browser context isolation
  - [ ] Parallel execution
- [ ] Add code examples for each pattern
- [ ] Include debugging and reporting best practices

### 6.7 Best Practices Knowledge Base - GitHub Actions
- [ ] Create `agent-os/workflows/skill/best-practices/github-actions/deployment-patterns.md`
- [ ] Document Workflow structure patterns:
  - [ ] Trigger configuration
  - [ ] Job organization
  - [ ] Step composition
  - [ ] Environment variables
- [ ] Document Build patterns:
  - [ ] Dependency caching
  - [ ] Multi-stage builds
  - [ ] Artifact management
  - [ ] Matrix builds
- [ ] Document Test patterns:
  - [ ] Test execution in CI
  - [ ] Coverage reporting
  - [ ] Test result publishing
  - [ ] Parallel test execution
- [ ] Document Deployment patterns:
  - [ ] Environment deployment
  - [ ] Secrets management
  - [ ] Rollback strategies
  - [ ] Deployment approvals
- [ ] Add workflow examples for each pattern
- [ ] Include security best practices (OIDC, secrets)

## Phase 7: Template Processing (Week 5)

### 7.1 Template Loading
- [ ] Create `agent-os/templates/skills/` directory structure
- [ ] Create API skill template (`api-patterns.md.template`)
- [ ] Create Component skill template (`component-patterns.md.template`)
- [ ] Create Testing skill template (`testing-patterns.md.template`)
- [ ] Create Deployment skill template (`deployment-patterns.md.template`)
- [ ] Implement template loader function
- [ ] Add template validation
- [ ] Handle missing template errors

### 7.2 Template Marker Parsing
- [ ] Create `agent-os/workflows/skill/utils/parse-template.md`
- [ ] Implement [CUSTOMIZE] marker detection
- [ ] Implement [PROJECT] marker detection
- [ ] Implement conditional section markers
- [ ] Create marker replacement data structure
- [ ] Add marker validation (detect unmatched markers)
- [ ] Create marker extraction function

### 7.3 Pattern-Based Marker Replacement
- [ ] Create `agent-os/workflows/skill/utils/replace-markers.md`
- [ ] Implement replacement for detected patterns:
  - [ ] [CUSTOMIZE:CONTROLLER_PATTERN] → extracted controller patterns
  - [ ] [CUSTOMIZE:SERVICE_PATTERN] → extracted service patterns
  - [ ] [CUSTOMIZE:COMPONENT_PATTERN] → extracted component patterns
  - [ ] [CUSTOMIZE:TEST_PATTERN] → extracted test patterns
  - [ ] [CUSTOMIZE:DEPLOYMENT_PATTERN] → extracted deployment patterns
- [ ] Handle multiple pattern instances
- [ ] Format patterns for template insertion
- [ ] Add code formatting (indentation, syntax highlighting)

### 7.4 Best Practices Marker Replacement
- [ ] Implement replacement for best practices:
  - [ ] [CUSTOMIZE:FRAMEWORK_BEST_PRACTICES] → selected framework patterns
  - [ ] [CUSTOMIZE:EXAMPLE_CODE] → framework-specific examples
  - [ ] [CUSTOMIZE:COMMON_PITFALLS] → framework-specific anti-patterns
  - [ ] [CUSTOMIZE:RECOMMENDATIONS] → improvement suggestions
- [ ] Format best practices for template insertion
- [ ] Add references to documentation

### 7.5 Project Marker Replacement
- [ ] Implement [PROJECT] marker replacement:
  - [ ] [PROJECT:NAME] → detected project name
  - [ ] [PROJECT:FRAMEWORK] → detected framework name and version
  - [ ] [PROJECT:PATH] → project directory path
- [ ] Format project information for template insertion
- [ ] Handle missing project information

### 7.6 Section Validation
- [ ] Validate all required sections are filled
- [ ] Check for remaining [CUSTOMIZE] markers
- [ ] Validate code examples syntax
- [ ] Validate file path globs
- [ ] Check for empty sections
- [ ] Create validation error report

## Phase 8: Project Name Detection (Week 5)

### 8.1 Agent OS Config Detection
- [ ] Create `agent-os/workflows/skill/utils/detect-project-name.md`
- [ ] Check for `agent-os/config.yml` file
- [ ] Parse YAML configuration
- [ ] Extract `project.name` field
- [ ] Validate project name format
- [ ] Handle missing config file

### 8.2 Package.json Detection
- [ ] Check for `package.json` file
- [ ] Parse JSON configuration
- [ ] Extract `name` field
- [ ] Clean npm scope (remove @scope/)
- [ ] Validate package name format
- [ ] Handle missing package.json

### 8.3 Directory Name Fallback
- [ ] Extract current directory name
- [ ] Clean directory name (remove special characters)
- [ ] Convert to lowercase
- [ ] Replace spaces with hyphens
- [ ] Validate directory name

### 8.4 User Prompt
- [ ] Implement AskUserQuestion for project name
- [ ] Provide detected name as default
- [ ] Validate user input
- [ ] Format user-provided name
- [ ] Save to agent-os/config.yml for future use

### 8.5 Name Formatting
- [ ] Create name normalization function:
  - [ ] Convert to lowercase
  - [ ] Replace spaces with hyphens
  - [ ] Remove special characters (except hyphens)
  - [ ] Trim leading/trailing hyphens
  - [ ] Validate final format (alphanumeric + hyphens only)
- [ ] Add name validation rules
- [ ] Handle edge cases (empty, too long, invalid characters)

## Phase 9: Skill File Generation (Week 6)

### 9.1 Frontmatter Generation
- [ ] Create `agent-os/workflows/skill/utils/generate-frontmatter.md`
- [ ] Generate skill name:
  - [ ] Format: `[project]-[type]-patterns`
  - [ ] Example: `my-app-api-patterns`
- [ ] Generate skill description:
  - [ ] Based on skill type and framework
  - [ ] Include version information
  - [ ] Mention analyzed patterns or best practices used
- [ ] Generate file globs:
  - [ ] API: `src/**/*Controller.java`, `src/**/*Service.java`, etc.
  - [ ] Component: `src/**/*.tsx`, `src/**/*.jsx`, etc.
  - [ ] Testing: `**/*.test.ts`, `**/*.spec.ts`, etc.
  - [ ] Deployment: `.github/workflows/**/*.yml`, `Dockerfile`, etc.
- [ ] Add metadata (created date, version, framework)
- [ ] Validate frontmatter YAML syntax

### 9.2 Content Assembly
- [ ] Create `agent-os/workflows/skill/utils/assemble-skill.md`
- [ ] Combine frontmatter + template content
- [ ] Insert framework-specific sections
- [ ] Add pattern examples with code snippets
- [ ] Add improvement recommendations section
- [ ] Add common pitfalls section
- [ ] Add references to documentation
- [ ] Format final Markdown content

### 9.3 Skill Structure Validation
- [ ] Validate frontmatter structure:
  - [ ] Required fields present (name, description, globs)
  - [ ] Valid YAML syntax
  - [ ] Glob patterns are valid
- [ ] Validate content structure:
  - [ ] Required sections present
  - [ ] No empty sections
  - [ ] No unresolved markers
  - [ ] Code examples have syntax highlighting
- [ ] Validate file name format
- [ ] Create validation report

### 9.4 Preview Generation
- [ ] Create skill preview function
- [ ] Format preview with sections:
  - [ ] Frontmatter overview
  - [ ] Key patterns (first 3)
  - [ ] Improvements applied count
  - [ ] File globs covered
  - [ ] Estimated coverage
- [ ] Add syntax highlighting for code examples
- [ ] Include statistics (number of patterns, examples, etc.)
- [ ] Format for terminal display

### 9.5 File Path Determination
- [ ] Create skill file path:
  - [ ] Base path: `.claude/skills/`
  - [ ] File name: `[project]-[type]-patterns.md`
  - [ ] Example: `.claude/skills/my-app-api-patterns.md`
- [ ] Check if file already exists
- [ ] Handle file name conflicts (append number or prompt)
- [ ] Create `.claude/skills/` directory if needed
- [ ] Validate file path is writable

### 9.6 File Saving
- [ ] Implement save function
- [ ] Write file with UTF-8 encoding
- [ ] Preserve line endings (LF)
- [ ] Set appropriate file permissions
- [ ] Verify file was written successfully
- [ ] Create backup of existing file (if overwriting)
- [ ] Log save operation

## Phase 10: Preview & Confirmation (Week 6)

### 10.1 Skill Preview Display
- [ ] Create `agent-os/workflows/skill/interactive/preview-skill.md`
- [ ] Display preview to user:
  - [ ] Header with skill name and description
  - [ ] Frontmatter section
  - [ ] Key patterns summary (top 5)
  - [ ] Improvements summary
  - [ ] File globs covered
  - [ ] Code examples (abbreviated)
- [ ] Format preview for readability:
  - [ ] Use markdown formatting
  - [ ] Syntax highlight code blocks
  - [ ] Add separators between sections
  - [ ] Include statistics
- [ ] Add option to view full content

### 10.2 Key Sections Display
- [ ] Show filled template sections:
  - [ ] Framework configuration
  - [ ] Pattern definitions
  - [ ] Code examples
  - [ ] Best practices
  - [ ] Common pitfalls
  - [ ] Recommendations
- [ ] Highlight customized sections
- [ ] Show section completion status
- [ ] Add section navigation

### 10.3 Improvements Summary
- [ ] Create improvements summary:
  - [ ] Total improvements found
  - [ ] Improvements applied (user accepted)
  - [ ] Improvements skipped (user rejected)
  - [ ] Breakdown by severity (Critical, Warning, Info)
  - [ ] Breakdown by category (Structure, Performance, Security, etc.)
- [ ] Show impact summary
- [ ] List key improvements applied

### 10.4 User Confirmation
- [ ] Implement confirmation question using AskUserQuestion:
  - [ ] "Review the skill preview above. Would you like to save this skill?"
  - [ ] Options: "Yes, save it", "No, cancel", "Show full content first"
- [ ] Handle "Show full content" option:
  - [ ] Display complete skill file
  - [ ] Ask confirmation again
- [ ] Handle "Yes" option:
  - [ ] Proceed to save
  - [ ] Show success message
- [ ] Handle "No" option:
  - [ ] Cancel operation
  - [ ] Offer to make changes
  - [ ] Ask if user wants to start over

### 10.5 Save on Approval
- [ ] Save skill file to determined path
- [ ] Confirm file was written successfully
- [ ] Display success message:
  - [ ] Show file path
  - [ ] Show skill name
  - [ ] Show patterns count
  - [ ] Show next steps
- [ ] Log operation to Agent OS activity log
- [ ] Update project skill registry (if exists)

### 10.6 Post-Save Actions
- [ ] Display next steps:
  - [ ] How to use the skill in .claude/claude.json
  - [ ] How to test the skill
  - [ ] How to update the skill later
- [ ] Offer to:
  - [ ] Create another skill
  - [ ] Add skill to claude.json automatically
  - [ ] Run validation on the skill
- [ ] Create success summary report

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
