# Specwright - Complete Workflow Diagram

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
flowchart TB
 subgraph Overview["🎯 AGENT OS - COMPLETE WORKFLOW OVERVIEW"]
    direction LR
        OV1["1️⃣ Setup Phase:<br>/plan-product<br>→ Product Brief + Tech Stack"]
        OV2["2️⃣ Team Setup:<br>/build-development-team<br>→ DevTeam Agents + Skills"]
        OV3["3️⃣ Planning Phase:<br>/create-spec<br>→ User Stories + DoR/DoD"]
        OV3B["🐛 Bug Management:<br>/add-bug or /create-bug<br>→ Bug Stories"]
        OV4["4️⃣ Execution Phase:<br>/execute-tasks<br>→ Implementation"]
  end
 subgraph PF1["Pre-Flight"]
        PF["Execute pre-flight.md"]
  end
 subgraph PP1["Step 1: Check Brief"]
        PP1A["🤖 context-fetcher<br>Check product-brief.md"]
        PP1B{"exists?"}
  end
 subgraph PP2["Step 2-4: Product Strategy"]
        PP2A["🤖 product-strategist<br>Gather info from user"]
        PP2B["Refine idea iteratively"]
        PP2C{"Complete?"}
        PP2D["👤 User Review"]
        PP2E{"Approved?"}
  end
 subgraph PP5["Step 5: Tech Stack"]
        PP5A["🤖 tech-architect<br>Recommend tech stack"]
        PP5B{"Accepted?"}
        PP5C["Generate tech-stack.md"]
  end
 subgraph PP5B["Step 5.5: Generate Standards (Optional)"]
        PP5BA["👤 Generate project standards?"]
        PP5BB{"User choice?"}
        PP5BC["🤖 tech-architect<br>Generate code-style.md<br>best-practices.md<br>(tech-stack aware)"]
        PP5BD["Skip - Use global standards<br>from ~/.specwright/standards/"]
  end
 subgraph PP6["Step 6: Roadmap"]
        PP6A["🤖 product-strategist<br>Generate roadmap"]
        PP6B{"Approved?"}
        PP6C["Generate roadmap.md"]
  end
 subgraph PP7["Step 7: Architecture"]
        PP7A["🤖 tech-architect<br>Recommend architecture"]
        PP7B{"Accepted?"}
        PP7C["Generate architecture-decision.md"]
  end
 subgraph PP8["Step 8: Boilerplate"]
        PP8A["🤖 file-creator<br>Generate project structure"]
        PP8B["✅ Planning Complete"]
  end
 subgraph Phase1["═══════════════ PHASE 1: PRODUCT PLANNING (/plan-product) ═══════════════"]
    direction TB
        PF1
        PP1
        PP2
        PP5
        PP5B
        PP6
        PP7
        PP8
  end
 subgraph DT1["Prerequisites"]
        DT1A["🚀 Start"]
        DT1B{"tech-stack.md<br>exists?"}
        DT1C["❌ Run /plan-product first"]
        DT1D["📄 Load Tech Stack"]
  end
 subgraph DT2["Architect Setup"]
        DT2A["Load template:<br>dev-team__architect"]
        DT2B["Create Agent:<br>dev-team__architect"]
        DT2C["Create Architect Skills:<br>• pattern-enforcement<br>• api-designing<br>• security-guidance<br>• data-modeling<br>• dependency-checking"]
  end
 subgraph DT3["Quality Standards"]
        DT3A["📋 Create dod.md"]
        DT3B["👤 Review DoD"]
        DT3C["📋 Create dor.md"]
        DT3D["👤 Review DoR"]
  end
 subgraph DT4["Agent Selection"]
        DT4A{"👤 Which Agents?"}
        DT4B["Backend Developer"]
        DT4C["Frontend Developer"]
        DT4D["DevOps Specialist"]
        DT4E["QA Specialist"]
        DT4F["Product Owner"]
  end
 subgraph DT5["Multi-Instance"]
        DT5A{"Backend<br>instances?"}
        DT5B{"Frontend<br>instances?"}
        DT5C["1-3 Instances"]
        DT5D["1-3 Instances"]
  end
 subgraph DT6["Create Agents"]
        DT6A["Create:<br>backend-developer-1..3.md"]
        DT6B["Create:<br>frontend-developer-1..3.md"]
        DT6C["Create:<br>dev-ops-specialist.md"]
        DT6D["Create:<br>qa-specialist.md"]
        DT6E["Create:<br>po.md"]
  end
 subgraph DT7["Skill Generation"]
        DT7A["Backend Skills:<br>logic-implementing<br>persistence-adapter<br>integration-adapter<br>test-engineering"]
        DT7B["Frontend Skills:<br>ui-component-architecture<br>state-management<br>api-bridge-building<br>interaction-designing"]
        DT7C["DevOps Skills:<br>pipeline-engineering<br>infrastructure-provisioning<br>observability-management<br>security-hardening"]
        DT7D["QA Skills:<br>test-strategy<br>test-automation<br>quality-metrics<br>regression-testing"]
        DT7E["PO Skills:<br>backlog-organization<br>requirements-engineering<br>acceptance-testing<br>data-analysis"]
  end
 subgraph DT8["Team Ready"]
        DT8A["✅ DevTeam Complete"]
  end
 subgraph Phase2["═══════════════ PHASE 2: DEV-TEAM SETUP (/build-development-team) ═══════════════"]
    direction TB
        DT1
        DT2
        DT3
        DT4
        DT5
        DT6
        DT7
        DT8
        DT8SYNC{" "}
  end
 subgraph CS1["1. Initiierung"]
        CS1A["User: /create-spec"]
        CS1B{"Input?"}
        CS1C["User-Thema"]
        CS1D["Nächstes aus roadmap.md"]
        CS1E["Thema festgelegt"]
  end
 subgraph CS2["2. PO Phase"]
        CS2A["🤖 dev-team__po"]
        CS2B["Fachlichen Hintergrund laden"]
        CS2C["Fragen mit User klären"]
        CS2D{"Weitere<br>Fragen?"}
        CS2E["Erstelle spec.md"]
        CS2F["Erstelle spec-lite.md"]
        CS2G["Erstelle user-stories.md"]
        CS2H["Schreibe fachliche User Stories"]
  end
 subgraph CS3["3. Architect Refinement"]
        CS3A["🤖 dev-team__architect"]
        CS3B["Lade User Stories"]
        CS3C["Pro Story:"]
        CS3D["Technische Details<br>hinzufügen"]
        CS3E["DoR prüfen"]
        CS3F["DoD definieren"]
        CS3G["WAS muss gemacht werden?"]
        CS3H["WIE sollte es gemacht werden?"]
        CS3I["WO Files erstellen?"]
        CS3J["WER macht es?"]
        CS3K{"Abhängigkeiten?"}
        CS3L["Als parallel markieren"]
        CS3M["Reihenfolge definieren"]
        CS3N["Handover-Dokumente definieren"]
        CS3O{"Weitere<br>Stories?"}
  end
 subgraph CS4["4. Output"]
        CS4A["✅ Spec Ready"]
        CS4B["📄 spec.md"]
        CS4C["📄 spec-lite.md"]
        CS4D["📄 user-stories.md"]
        CS4E["📄 handover-docs/"]
        CS4F["📄 sub-specs/<br>cross-cutting-decisions.md<br>(optional)"]
  end
 subgraph Phase3["═══════════════ PHASE 3: SPEC CREATION (/create-spec) ═══════════════"]
    direction TB
        CS1
        CS2
        CS3
        CS4
  end
 subgraph BUG1["Bug Entry Point"]
        BUG1A["👤 User: Bug gefunden"]
        BUG1B{Bug wo?}
        BUG1C["User: /add-bug [spec-name]"]
        BUG1D["User: /create-bug"]
  end
 subgraph BUG2["/add-bug - Add to existing Spec"]
        BUG2A["🤖 dev-team__po"]
        BUG2B["PO fragt User:<br>• Reproduzierbar?<br>• Steps to reproduce?<br>• Expected behavior?<br>• Actual behavior?"]
        BUG2C["Erstelle Bug-Story<br>in user-stories.md"]
        BUG2D{Bug<br>komplex?}
        BUG2E["🤖 dev-team__architect<br>Quick Technical Analysis<br>(optional)"]
        BUG2F["Bug auf kanban-board.md<br>im Backlog"]
  end
 subgraph BUG3["/create-bug - Standalone Bug Spec"]
        BUG3A["🤖 dev-team__po"]
        BUG3B["PO fragt User:<br>• Bug Details<br>• Reproduktion<br>• Erwartung vs. Realität"]
        BUG3C["Erstelle Bug-Spec:<br>.specwright/bugs/<br>YYYY-MM-DD-bug-name/"]
        BUG3D["Erstelle:<br>• bug-description.md<br>• user-stories.md (1 Bug)<br>• kanban-board.md"]
        BUG3E{Bug<br>komplex?}
        BUG3F["🤖 dev-team__architect<br>Quick Technical Analysis<br>(optional)"]
        BUG3G["Bug Spec Ready"]
  end
 subgraph BUG4["Bug Execution"]
        BUG4A{User<br>Entscheidung?}
        BUG4B["Sofort: /execute-tasks"]
        BUG4C["Später: Bleibt im Backlog"]
        BUG4D["Bug wird wie Story<br>behandelt im Execution"]
  end
 subgraph BugPhase["═══════════════ PHASE 3B: BUG MANAGEMENT (/add-bug | /create-bug) ═══════════════"]
    direction TB
        BUG1
        BUG2
        BUG3
        BUG4
  end
 subgraph EX0["0. Orchestrator Init"]
        EX0A["User: /execute-tasks"]
        EX0B["🧠 Claude Code<br>+ Orchestration Skill"]
        EX0C["Skill provides:<br>• Smart agent assignment<br>• Dependency tracking<br>• Handover management<br>• Quality gates"]
  end
 subgraph EX1["1. Kanban Board Management"]
        EX1A{"kanban-board.md<br>exists?"}
        EX1B["🔄 RESUME MODE<br>Load existing board"]
        EX1C{"Stories in<br>Progress?"}
        EX1D["👤 Ask User:<br>1. Resume<br>2. Reset<br>3. Skip"]
        EX1E["🆕 FIRST RUN<br>Create kanban-board.md"]
        EX1F["Parse user-stories.md"]
        EX1G["Init Board:<br>All stories → Backlog"]
        EX1H["Board Ready"]
  end
 subgraph EX2["2. Story Selection"]
        EX2A["Load Backlog from<br>kanban-board.md"]
        EX2B["Check each story"]
        EX2C{"Dependencies<br>met?"}
        EX2D["Story eligible"]
        EX2E["Story blocked<br>Skip to next"]
        EX2F{"Multiple<br>eligible?"}
        EX2G["👤 Parallel execution?"]
        EX2H["Select story/stories"]
        EX2I["UPDATE kanban-board.md:<br>Story → In Progress"]
  end
 subgraph EX3["3. Context Analysis"]
        EX3A["🤖 context-fetcher"]
        EX3B["Load selected story<br>from user-stories.md"]
        EX3C["Load product-brief-lite.md<br>spec-lite.md<br>cross-cutting-decisions.md<br>(if not in context)"]
  end
 subgraph EX4["4. Dev Server Check"]
        EX4A{"Server<br>running?"}
        EX4B["👤 Shut down?"]
        EX4C["Proceed"]
  end
 subgraph EX5["5. Git Branch"]
        EX5A["🤖 git-workflow"]
        EX5B["Create/switch branch"]
  end
 subgraph EX6["6. Story Execution - Phase 1: Prep"]
        EX6A["Load story details"]
        EX6B{"Handover<br>needed?"}
        EX6C["Load handover-docs/"]
        EX6D["Analyze WER field"]
        EX6E["Determine agent(s)"]
        EX6F["UPDATE kanban:<br>Assign agent(s)"]
  end
 subgraph EX7["6. Story Execution - Phase 2: Implementation"]
        EX7A{"Story<br>Type?"}
        EX7B["🤖 backend-dev<br>+ backend skills"]
        EX7C["🤖 frontend-dev<br>+ frontend skills"]
        EX7D["🤖 devops<br>+ devops skills"]
        EX7E["🤖 qa<br>+ qa skills"]
        EX7F["Agent implements<br>per DoD checklist"]
        EX7G["UPDATE kanban:<br>Progress updates"]
  end
 subgraph EX8["6. Story Execution - Phase 3: Architect Review"]
        EX8A["UPDATE kanban:<br>Story → In Review"]
        EX8B["🤖 architect"]
        EX8C["Review:<br>• Pattern enforcement<br>• Architecture<br>• API design<br>• Security"]
        EX8D{"Review<br>OK?"}
        EX8E["UPDATE kanban:<br>Add feedback<br>Story → In Progress"]
        EX8F["Continue to QA"]
  end
 subgraph EX9["6. Story Execution - Phase 4: QA Testing"]
        EX9A["UPDATE kanban:<br>Story → Testing"]
        EX9B["🤖 qa-specialist"]
        EX9C["Test:<br>• Run all tests<br>• Verify DoD<br>• Acceptance testing"]
        EX9D{"Tests<br>pass?"}
        EX9E["UPDATE kanban:<br>Add failures<br>Story → In Progress"]
        EX9F["Continue to completion"]
  end
 subgraph EX10["6. Story Execution - Phase 5: Completion"]
        EX10A["UPDATE kanban:<br>Story → Done"]
        EX10B["Set completed timestamp"]
        EX10C["Set DoD ✅"]
        EX10CA["🤖 dev-team__documenter<br>Collect story context:<br>• Load story details<br>• Load git diff<br>• Load DoD checklist"]
        EX10CB["Generate documentation:<br>• CHANGELOG.md entry<br>• API docs (if backend)<br>• README updates"]
        EX10CC["🤖 architect<br>Review documentation"]
        EX10CD{"Docs<br>OK?"}
        EX10CE["Update docs<br>based on feedback"]
        EX10CF["UPDATE kanban:<br>Add docs reference"]
        EX10CG["🤖 git-workflow<br>Commit story changes"]
        EX10CH["Git commit (local):<br>• Conventional commit format<br>• Reference Story ID<br>• Include DoD confirmation<br>• Add commit SHA to kanban"]
        EX10D{"Has dependent<br>stories?"}
        EX10E["Create handover doc"]
        EX10F["Update dependencies<br>Unblock waiting stories"]
        EX10G["Update metrics"]
  end
 subgraph EX11["6. Story Execution - Phase 6: Next Story"]
        EX11A{"Backlog<br>empty?"}
        EX11B["✅ All stories done!"]
        EX11C["👤 Continue?"]
        EX11D["Return to EX2<br>(Story Selection)"]
        EX11E["Pause execution"]
  end
 subgraph EX12["7. Test Suite"]
        EX12A["🤖 test-runner"]
        EX12B["Run full test suite"]
        EX12C{"All pass?"}
        EX12D["Fix failures"]
  end
 subgraph EX13["8. Git Workflow"]
        EX13A["🤖 git-workflow"]
        EX13B["Git push<br>(all story commits)"]
        EX13C["Push to GitHub"]
        EX13D["Create Pull Request"]
  end
 subgraph EX14["9-11. Completion"]
        EX14A["Check roadmap"]
        EX14B["Play notification"]
        EX14C["Summary with:<br>• Completed stories<br>• Kanban status<br>• Resume instructions<br>• PR link"]
  end
 subgraph Phase4["═══════════════ PHASE 4: TASK EXECUTION (/execute-tasks) ═══════════════"]
    direction TB
        EX0
        EX1
        EX2
        EX3
        EX4
        EX5
        EX6
        EX7
        EX8
        EX9
        EX10
        EX11
        EX12
        EX13
        EX14
  end
 subgraph CMP1["📄 Agent Templates"]
        T1["architect-template"]
        T2["backend-dev-template"]
        T3["frontend-dev-template"]
        T4["devops-template"]
        T5["qa-template"]
        T6["po-template"]
        T7["documenter-template"]
  end
 subgraph CMP2["🤖 Created Agents"]
        A1["dev-team__architect"]
        A2["dev-team__backend-dev-1..3"]
        A3["dev-team__frontend-dev-1..3"]
        A4["dev-team__devops"]
        A5["dev-team__qa"]
        A6["dev-team__po"]
        A7["dev-team__documenter"]
  end
 subgraph CMP3["🔧 Skills (tech-stack specific)"]
        S1["Architect Skills (5)"]
        S2["Backend Skills (4)"]
        S3["Frontend Skills (4)"]
        S4["DevOps Skills (4)"]
        S5["QA Skills (4)"]
        S6["PO Skills (4)"]
        S7["🌟 Orchestration Skill:<br>• Agent assignment<br>• Dependency tracking<br>• Handover mgmt<br>• Quality gates"]
        S8["Global Skills (4):<br>git, changelog, docs, security"]
        S9["Documenter Skills (4):<br>• changelog-generation<br>• api-documentation<br>• user-guide-writing<br>• code-documentation"]
  end
 subgraph CMP4["🔨 Tools"]
        TO1["Base Tools:<br>Read/Write/Edit<br>Bash/Glob/Grep<br>Task/WebFetch"]
        TO2["MCP Tools:<br>database-inspector<br>api-tester<br>deployment-manager"]
        TO3["NN-Workflows:<br>code-reviewer<br>test-generator<br>doc-generator"]
  end
 subgraph CMP5["📊 Execution State"]
        ST1["kanban-board.md<br>• Backlog<br>• In Progress<br>• In Review<br>• Testing<br>• Done<br>• Change Log<br>• Metrics<br>• Commit SHAs"]
        ST2["user-stories.md<br>• Fachliche Stories<br>• DoR/DoD<br>• WAS/WIE/WO/WER<br>• Dependencies"]
        ST3["handover-docs/<br>• API contracts<br>• Data structures<br>• Integration points"]
        ST4["cross-cutting-decisions.md<br>• External dependencies<br>• Global patterns<br>• Performance/Security<br>(optional)"]
        ST5["Documentation Output:<br>• CHANGELOG.md<br>• docs/api/<br>• .specwright/docs/<br>• README.md"]
        ST6["Git Commits:<br>• 1 commit per story<br>• Atomic changes<br>• Conventional format<br>• Story references"]
  end
 subgraph CMP6["📚 Global Standards (Installed)"]
        STD1["~/.specwright/standards/<br>• code-style.md (global)<br>• best-practices.md (global)<br>• Fallback for all projects"]
  end
 subgraph CMP7["📚 Project Standards (Optional)"]
        STD2[".specwright/standards/<br>• code-style.md (project)<br>• best-practices.md (project)<br>• Overrides global if exists"]
  end
 subgraph Components["═══════════════ SYSTEM COMPONENTS (DevTeam Structure) ═══════════════"]
    direction LR
        CMP1
        CMP2
        CMP3
        CMP4
        CMP5
        CMP6
        CMP7
  end
    OV1 --> OV2
    OV2 --> OV3
    OV3 --> OV4
    OV3 -.-> OV3B
    OV3B -.-> OV4
    PF --> PP1A
    PP1A --> PP1B
    PP1B -- No --> PP2A
    PP1B -- Yes --> PP5A
    PP2A --> PP2B
    PP2B --> PP2C
    PP2C -- No --> PP2B
    PP2C -- Yes --> PP2D
    PP2D --> PP2E
    PP2E -- No --> PP2B
    PP2E -- Yes --> PP5A
    PP5A --> PP5B
    PP5B -- No --> PP5A
    PP5B -- Yes --> PP5C
    PP5C --> PP5BA
    PP5BA --> PP5BB
    PP5BB -- Yes --> PP5BC
    PP5BB -- No --> PP5BD
    PP5BC --> PP6A
    PP5BD --> PP6A
    PP6A --> PP6B
    PP6B -- No --> PP6A
    PP6B -- Yes --> PP6C
    PP6C --> PP7A
    PP7A --> PP7B
    PP7B -- No --> PP7A
    PP7B -- Yes --> PP7C
    PP7C --> PP8A
    PP8A --> PP8B
    DT1A --> DT1B
    DT1B -- No --> DT1C
    DT1B -- Yes --> DT1D
    DT1D --> DT2A
    DT2A --> DT2B
    DT2B --> DT2C
    DT2C --> DT3A & DT4A
    DT3A --> DT3B
    DT3B --> DT3C
    DT3C --> DT3D
    DT3D --> DT8SYNC
    DT4A --> DT4B & DT4C & DT4D & DT4E & DT4F
    DT4B --> DT5A
    DT4C --> DT5B
    DT5A --> DT5C
    DT5B --> DT5D
    DT5C --> DT6A
    DT5D --> DT6B
    DT4D --> DT6C
    DT4E --> DT6D
    DT4F --> DT6E
    DT6A --> DT7A
    DT6B --> DT7B
    DT6C --> DT7C
    DT6D --> DT7D
    DT6E --> DT7E
    DT7A --> DT8SYNC
    DT7B --> DT8SYNC
    DT7C --> DT8SYNC
    DT7D --> DT8SYNC
    DT7E --> DT8SYNC
    DT8SYNC --> DT8A
    CS1A --> CS1B
    CS1B -- Thema --> CS1C
    CS1B -- Kein Thema --> CS1D
    CS1C --> CS1E
    CS1D --> CS1E
    CS1E --> CS2A
    CS2A --> CS2B
    CS2B --> CS2C
    CS2C --> CS2D
    CS2D -- Ja --> CS2C
    CS2D -- Nein --> CS2E
    CS2E --> CS2F
    CS2F --> CS2G
    CS2G --> CS2H
    CS2H --> CS3A
    CS3A --> CS3B
    CS3B --> CS3C
    CS3C --> CS3D
    CS3D --> CS3E
    CS3E --> CS3F
    CS3F --> CS3G
    CS3G --> CS3H
    CS3H --> CS3I
    CS3I --> CS3J
    CS3J --> CS3K
    CS3K -- Parallel --> CS3L
    CS3K -- Sequentiell --> CS3M
    CS3M --> CS3N
    CS3L --> CS3O
    CS3N --> CS3O
    CS3O -- Ja --> CS3C
    CS3O -- Nein --> CS4A
    CS4A --> CS4B & CS4C & CS4D & CS4E & CS4F
    BUG1A --> BUG1B
    BUG1B -- "In aktiver Spec" --> BUG1C
    BUG1B -- "Production/Legacy" --> BUG1D
    BUG1C --> BUG2A
    BUG1D --> BUG3A
    BUG2A --> BUG2B
    BUG2B --> BUG2C
    BUG2C --> BUG2D
    BUG2D -- Ja --> BUG2E
    BUG2D -- Nein --> BUG2F
    BUG2E --> BUG2F
    BUG3A --> BUG3B
    BUG3B --> BUG3C
    BUG3C --> BUG3D
    BUG3D --> BUG3E
    BUG3E -- Ja --> BUG3F
    BUG3E -- Nein --> BUG3G
    BUG3F --> BUG3G
    BUG2F --> BUG4A
    BUG3G --> BUG4A
    BUG4A -- Sofort --> BUG4B
    BUG4A -- Später --> BUG4C
    BUG4B --> BUG4D
    EX0A --> EX0B
    EX0B --> EX0C
    EX0C --> EX1A
    EX1A -- Yes --> EX1B
    EX1A -- No --> EX1E
    EX1B --> EX1C
    EX1C -- Yes --> EX1D
    EX1C -- No --> EX1H
    EX1D --> EX1H
    EX1E --> EX1F
    EX1F --> EX1G
    EX1G --> EX1H
    EX1H --> EX2A
    EX2A --> EX2B
    EX2B --> EX2C
    EX2C -- Yes --> EX2D
    EX2C -- No --> EX2E
    EX2E --> EX2B
    EX2D --> EX2F
    EX2F -- Yes --> EX2G
    EX2F -- No --> EX2H
    EX2G --> EX2H
    EX2H --> EX2I
    EX2I --> EX3A
    EX3A --> EX3B
    EX3B --> EX3C
    EX3C --> EX4A
    EX4A -- Yes --> EX4B
    EX4A -- No --> EX4C
    EX4B --> EX4C
    EX4C --> EX5A
    EX5A --> EX5B
    EX5B --> EX6A
    EX6A --> EX6B
    EX6B -- Yes --> EX6C
    EX6B -- No --> EX6D
    EX6C --> EX6D
    EX6D --> EX6E
    EX6E --> EX6F
    EX6F --> EX7A
    EX7A -- Backend --> EX7B
    EX7A -- Frontend --> EX7C
    EX7A -- DevOps --> EX7D
    EX7A -- Test --> EX7E
    EX7B --> EX7F
    EX7C --> EX7F
    EX7D --> EX7F
    EX7E --> EX7F
    EX7F --> EX7G
    EX7G --> EX8A
    EX8A --> EX8B
    EX8B --> EX8C
    EX8C --> EX8D
    EX8D -- No --> EX8E
    EX8E --> EX7F
    EX8D -- Yes --> EX8F
    EX8F --> EX9A
    EX9A --> EX9B
    EX9B --> EX9C
    EX9C --> EX9D
    EX9D -- No --> EX9E
    EX9E --> EX7F
    EX9D -- Yes --> EX9F
    EX9F --> EX10A
    EX10A --> EX10B
    EX10B --> EX10C
    EX10C --> EX10CA
    EX10CA --> EX10CB
    EX10CB --> EX10CC
    EX10CC --> EX10CD
    EX10CD -- No --> EX10CE
    EX10CE --> EX10CB
    EX10CD -- Yes --> EX10CF
    EX10CF --> EX10CG
    EX10CG --> EX10CH
    EX10CH --> EX10D
    EX10D -- Yes --> EX10E
    EX10D -- No --> EX10F
    EX10E --> EX10F
    EX10F --> EX10G
    EX10G --> EX11A
    EX11A -- Yes --> EX11B
    EX11A -- No --> EX11C
    EX11C -- Yes --> EX11D
    EX11C -- No/Pause --> EX11E
    EX11D --> EX2A
    EX11B --> EX12A
    EX12A --> EX12B
    EX12B --> EX12C
    EX12C -- No --> EX12D
    EX12D --> EX12B
    EX12C -- Yes --> EX13A
    EX13A --> EX13B
    EX13B --> EX13C
    EX13C --> EX13D
    EX13D --> EX14A
    EX14A --> EX14B
    EX14B --> EX14C
    T1 -.-> A1
    T2 -.-> A2
    T3 -.-> A3
    T4 -.-> A4
    T5 -.-> A5
    T6 -.-> A6
    T7 -.-> A7
    S1 -.-> A1
    S2 -.-> A2
    S3 -.-> A3
    S4 -.-> A4
    S5 -.-> A5
    S6 -.-> A6
    S7 -.-> EX0B
    S8 -.-> A1 & A2 & A3 & A4 & A5 & A6
    S9 -.-> A7
    TO1 -.-> A1 & A2 & A3 & A4 & A5 & A6 & A7
    TO2 -.-> S1 & S2 & S3 & S4 & S5 & S6 & S9
    TO3 -.-> S1 & S2 & S3 & S4 & S5 & S6 & S9
    ST1 -.-> EX1H & EX2I & EX7G & EX8A & EX9A & EX10A & EX10CF & EX10CH
    ST2 -.-> EX3B & BUG2C & EX10CA
    ST3 -.-> EX6C & EX10E
    ST4 -.-> EX3C
    ST5 -.-> EX10CB & EX10CC
    ST6 -.-> EX10CH & EX13B
    STD1 -.-> DT3A & DT3C
    STD2 -.-> DT3A & DT3C
    PP5BC -.-> STD2
    PP8B -. "Provides tech-stack.md" .-> DT1D
    DT8A -. DevTeam ready .-> CS1A
    CS4A -. "user-stories.md ready" .-> EX0A
    BUG4D -.-> EX0A
    BUG2A -.-> A6
    BUG3A -.-> A6
    BUG2E -.-> A1
    BUG3F -.-> A1
    EX10CA -.-> A7
    EX10CB -.-> A7
    EX10CC -.-> A1
    EX10CG -.-> EX5A
    EX10CH -.-> EX5A
    EX13B -.-> EX5A

    style OV1 fill:#E3F2FD,stroke:#1976D2
    style OV2 fill:#E8F5E9,stroke:#388E3C
    style OV3 fill:#F3E5F5,stroke:#7B1FA2
    style OV3B fill:#FFEBEE,stroke:#C62828
    style OV4 fill:#FFF3E0,stroke:#F57C00
    style PP8B fill:#4CAF50,color:#fff
    style PP5BC fill:#81C784,stroke:#2E7D32
    style PP5BD fill:#B0BEC5,stroke:#455A64
    style DT8A fill:#4CAF50,color:#fff
    style DT8SYNC fill:#FF9800,color:#fff
    style CS4A fill:#4CAF50,color:#fff
    style BUG1A fill:#FFEBEE,stroke:#C62828
    style BUG2F fill:#FF9800,color:#fff
    style BUG3G fill:#FF9800,color:#fff
    style BUG4B fill:#4CAF50,color:#fff
    style BUG4D fill:#4CAF50,color:#fff
    style EX0B fill:#9C27B0,color:#fff
    style EX0C fill:#9C27B0,color:#fff
    style EX1B fill:#2196F3,color:#fff
    style EX1E fill:#4CAF50,color:#fff
    style EX1H fill:#4CAF50,color:#fff
    style EX2I fill:#FF9800,color:#fff
    style EX7G fill:#FF9800,color:#fff
    style EX8A fill:#FF9800,color:#fff
    style EX9A fill:#FF9800,color:#fff
    style EX10A fill:#4CAF50,color:#fff
    style EX10CA fill:#E1F5FE,stroke:#0277BD
    style EX10CB fill:#E1F5FE,stroke:#0277BD
    style EX10CC fill:#F3E5F5,stroke:#7B1FA2
    style EX10CF fill:#E1F5FE,stroke:#0277BD
    style EX10CG fill:#C8E6C9,stroke:#2E7D32
    style EX10CH fill:#C8E6C9,stroke:#2E7D32
    style EX11B fill:#4CAF50,color:#fff
    style EX13B fill:#C8E6C9,stroke:#2E7D32
    style EX14C fill:#4CAF50,color:#fff
    style S7 fill:#9C27B0,color:#fff
    style S9 fill:#E1F5FE,stroke:#0277BD
    style ST1 fill:#FFF9C4,stroke:#F9A825
    style ST5 fill:#E1F5FE,stroke:#0277BD
    style ST6 fill:#C8E6C9,stroke:#2E7D32
    style STD1 fill:#E8EAF6,stroke:#3F51B5
    style STD2 fill:#E8EAF6,stroke:#3F51B5
    style A7 fill:#E1F5FE,stroke:#0277BD
    style Overview fill:#FFD700,stroke:#FF8C00,stroke-width:4px,color:#000
    style Phase1 fill:#E3F2FD,stroke:#1976D2,stroke-width:3px
    style Phase2 fill:#E8F5E9,stroke:#388E3C,stroke-width:3px
    style Phase3 fill:#F3E5F5,stroke:#7B1FA2,stroke-width:3px
    style BugPhase fill:#FFEBEE,stroke:#C62828,stroke-width:3px
    style Phase4 fill:#FFF3E0,stroke:#F57C00,stroke-width:3px
    style Components fill:#FFFDE7,stroke:#FBC02D,stroke-width:3px
```
