# BAK Routing Matrix

Use this matrix as a decision aid, not a reason to invoke every matching skill.
Explicit user skill mentions and current skill trigger rules win. Prefer one
top-level workflow plus only the supporting disciplines it needs.

## Matt Pocock engineering and productivity routes

| Intent | Primary route | Supporting route or constraint |
|---|---|---|
| Configure a repo for this suite | `$setup-matt-pocock-skills` | Run once per repo; confirm tracker and labels before writing |
| Ask which Matt workflow fits | `$ask-matt` | Use only when explicitly requested; `chief` otherwise routes directly |
| Stress-test a code plan while building domain docs | `$grill-with-docs` | May use `$grilling` and `$domain-modeling` |
| Stress-test a general plan | `$grill-me` or `$grilling` | Interview before implementation |
| Triage issues or external PRs | `$triage` | Requires configured tracker and label vocabulary |
| Synthesize an already-discussed spec | `$to-spec` | Do not add a new interview unless required by the skill |
| Split scope into tracer-bullet tickets | `$to-tickets` | Preserve blocking edges and configured tracker |
| Implement an accepted spec or tickets | `$implement` | Use `$tdd` at agreed seams and `$code-review` before close |
| Map a task larger than one session | `$wayfinder` or `$decision-mapping` | Use tracker-backed decision tickets when configured |
| Prototype a state, logic, or UI question | `$prototype` | Throwaway evidence, not production code |
| Diagnose broken, failing, flaky, or slow behavior | `$diagnosing-bugs` | Reproduce before fixing; add regression coverage |
| Build or fix test-first | `$tdd` | Red, green, refactor in vertical slices |
| Establish terminology or record decisions | `$domain-modeling` | Update `CONTEXT.md` or ADRs only when the repo owns them |
| Design deep module seams/interfaces | `$codebase-design` | Prefer narrow interfaces with hidden complexity |
| Scan for architectural deepening opportunities | `$improve-codebase-architecture` | Use for an explicit architecture audit, not routine edits |
| Review a diff against standards and spec | `$code-review` | Its parallel-agent behavior still requires applicable permission |
| Run a conversational QA session and file findings | `$qa` | Treat publication as external mutation and require its configured tracker |
| Plan a safe incremental refactor | `$request-refactor-plan` | Interview, design tiny commits, and publish only with authority |
| Resolve an active merge or rebase | `$resolving-merge-conflicts` | Resolve by intent and primary history; do not abort silently |
| Produce continuation context | `$handoff` | Use when the user asks or continuity materially needs it |
| Teach over multiple sessions | `$teach` | Keep state in the teaching workspace |
| Write or revise a skill | `$skill-creator` plus `$writing-great-skills` | Validate and forward-test when permitted |

## Engineering, documentation, and extension routes

| Intent | Route |
|---|---|
| Current docs for non-OpenAI developer technology | `$find-docs`, then the Context7 contract in `documentation-routing.md` |
| OpenAI or Codex behavior/docs | `$openai-docs` |
| Research from primary sources into Markdown | `$research` |
| Browser debugging, automation, performance, network inspection | `$chrome-devtools` |
| UI/product flow critique | `$product-design:index`, which selects `$product-design:audit` or its own subflow |
| Visual variants or bitmap generation/editing | `$imagegen`; use `$product-design:ideate` for product-design exploration |
| Implement a screenshot/mockup | `$product-design:image-to-code` |
| Clone a live frontend URL | `$product-design:url-to-code` |
| Create/update a reusable skill | `$skill-creator` |
| Discover/install skills | `$find-skills` or `$skill-installer` |
| Create/package a stable Codex plugin | `$plugin-creator` |
| Set up Husky pre-commit checks | `$setup-pre-commit` |
| Add Claude Code destructive-git hooks | `$git-guardrails-claude-code` |
| Migrate tests to shoehorn | `$migrate-to-shoehorn` |
| Scaffold course exercises | `$scaffold-exercises` |
| Operate or debug Hatchet workflows | `$hatchet-cli` |
| Create a manual setup wizard | `$wizard` |
| Explore, shape, or edit prose | `$writing-fragments` -> `$writing-beats` -> `$writing-shape`; `$edit-article` for revision |

## Connected-service and plugin routes

| Intent | Route |
|---|---|
| General GitHub repository, issue, or PR context | `$github:github` |
| Fix GitHub Actions checks | `$github:gh-fix-ci` |
| Address PR review comments | `$github:gh-address-comments` |
| Commit, push, and open a draft PR | `$github:yeet`, only with explicit publication authority |
| Gmail search, summary, drafting, or triage | `$gmail:gmail` or `$gmail:gmail-inbox-triage` |
| Calendar scheduling or briefs | The narrowest `$google-calendar:*` skill |
| Drive, Docs, Sheets, Slides, or Drive comments | The narrowest `$google-drive:*` skill |
| Notion CLI setup/authentication, general page or data-source CRUD, comments, files, terminal automation, or explicit no-MCP work | `$notion-cli` |
| Notion capture, research, meeting prep, or spec implementation through the connected Notion app | The narrowest `$notion:*` skill; requires its MCP/app tools |
| Sales workflow | `$sales:index` first, then its selected focused skill |
| Obsidian knowledge search or capture | `$obsidian-vault` |

### Choose the Notion transport

1. Honor an explicitly named skill or transport first. `$notion-cli`, `ntn`,
   terminal, automation, and no-MCP requests route to `$notion-cli`; an explicit
   `$notion:*` request keeps that specialist workflow and its connector.
2. For an unqualified general read/write task, use `$notion-cli` when its
   advertised skill and authenticated CLI are available. It owns direct page,
   block, property, data-source, comment, and file operations.
3. Use the narrowest `$notion:*` skill when its semantic workflow—knowledge
   capture, research synthesis, meeting intelligence, or spec-to-implementation—
   materially improves the task and the connected Notion app is available.
   Prove availability from callable Notion tools in the current session or a
   successful tool call; an advertised skill alone is not evidence of a live
   connector.
4. Do not select both transports for the same operation or silently switch after
   an auth/tool failure. Follow the selected skill's setup flow or ask before
   changing transports; authentication and mutation authority do not transfer.
5. Account for capability differences: hosted Notion MCP can search connected
   external sources when the workspace plan permits it, while `$notion-cli`
   follows the official CLI and public API surface.

## Go routes

| Intent | Primary route | Supporting route or constraint |
|---|---|---|
| Plan a Go feature or change | `$go-plan` | Grill before implementation; every shared datum named and owned |
| Implement an accepted Go spec | `$go-tdd` | Use `$go-review` before close; sensor gates at every phase exit |
| Review Go changes | `$go-review` | Two-axis: standards (GO_RULES.md) and spec |

Go triggers (`race`, `goroutine`, `channel`, `mutex`, `deadlock`, `leak`, or a
`go.mod` in the active repo) route to the `go-*` family; bak remains the sole
phase orchestrator — the go skills delegate to grilling/to-spec/tdd/code-review,
they do not replace them.

## Fallback rules

1. Use an explicitly named skill even if the matrix suggests another route.
2. Use the advertised skill catalog before scanning disk. Disk discovery may
   find unavailable, disabled, stale, or malformed skills; verify before use.
3. If two routes overlap, choose the more specific one and use the other only
   for a distinct supporting job.
4. If no skill materially improves the task, proceed directly with ordinary
   reasoning and the relevant tools.
5. Do not use a connector unless it is present and authorized in the current
   session. Do not substitute public web search for private connected data.
