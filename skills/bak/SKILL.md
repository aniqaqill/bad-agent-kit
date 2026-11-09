---
name: bak
description: Route and orchestrate every workspace task through the smallest complete set of installed skills, plugins, repository guidance, tools, feedback sensors, and durable learning surfaces. Use at the start of every task under your workspace, when the right workflow is unclear, when work crosses repositories or capabilities, or when deciding whether repeated workspace behavior should become an AGENTS.md rule, skill, hook, MCP app, or plugin.
---

# BAK — bad-agent-kit

Thin workspace router, batman-flavored: preserve the user's real objective,
select the right capability, coordinate its workflow, verify the result, and
capture only durable learning. Don't ship the bad agent kit — never mutate on
inspect, never publish without authority. Do not duplicate the detailed
instructions owned by routed skills.

## Route every task

1. Extract the goal, target, constraints, authority, and proof of completion.
2. Identify the active repository or workspace surface. Read the applicable
   instruction chain and inspect repository state only when relevant.
3. Read [routing-matrix.md](references/routing-matrix.md). Select the smallest
   complete route; use no specialist skill when ordinary reasoning or a direct
   edit is sufficient.
4. Treat explicitly named skills as mandatory. Apply system and developer
   trigger rules before this router. Never invent a skill or assume a connector
   is available.
5. Announce the selected skills and their order when a skill is used. Then
   follow each selected `SKILL.md` faithfully.
6. Execute within the user's authority. Do not turn a request to inspect,
   explain, review, or diagnose into an unrequested mutation or publication.
7. Run the feedback loop and verify the actual completion criteria before
   reporting success.

Do not invoke `bak` recursively. Do not chain one user-invoked Matt Pocock
orchestrator into another silently. When such a workflow is the best top-level
route, select it once and let it call only the model-invoked disciplines it
permits.

## Orient before engineering routes

- Find the Git/project root, current branch, dirty state, relevant `AGENTS.md`,
  `CLAUDE.md`, `README.md`, `CONTEXT.md`, ADRs, and commands.
- Preserve unrelated user changes.
- Before using tracker-aware Matt Pocock workflows, check for
  `docs/agents/issue-tracker.md`, `domain.md`, and, when `triage` is installed,
  `triage-labels.md`. If missing or inconsistent, route to
  `$setup-matt-pocock-skills` and honor its confirmation steps.
- Prefer repo-specific terms, commands, and acceptance checks over workspace
  defaults.
- In a Go module (go.mod present): note the module layout and go directive
  version floor before entering any phase; Go triggers route to the `go-*`
  family (see routing matrix).

## Use guides and sensors

Before acting, load the cheapest relevant feedforward guides: instructions,
domain context, ADRs, specifications, examples, and current primary docs.

After acting, run feedback sensors from cheapest and most deterministic to more
expensive and inferential:

1. Formatter, linter, type checker, focused tests, static or structural checks.
2. Broader tests, build, runtime logs, browser or integration checks when the
   blast radius warrants them.
3. Diff/spec review, security and maintainability review, then human review for
   judgment or irreversible decisions.

For material code changes in a child repo under `$HOME/code`, use
`$HOME/code/.codex/hooks/prehook.sh <repo-root>` as an orientation
sensor unless the repo provides a more precise equivalent. After the change,
use `$HOME/code/.codex/hooks/posthook.sh <repo-root>` as a baseline,
then add the repo-specific checks the task requires. Run
`prepush.sh <repo-root>` only immediately before a user-authorized push. These
scripts are sensors, not substitutes for repository instructions or judgment.

## Route current documentation

For library, framework, SDK, API, CLI, or cloud-service questions, read and
follow [documentation-routing.md](references/documentation-routing.md).

## Route GitHub publication

For GitHub authentication, issue/PR publication, sub-issues, or network checks,
read and follow [github-publishing.md](references/github-publishing.md).
Drafting is not publication; obtain explicit user authority before publishing,
pushing, merging, or changing remote state.

## Learn without bloating the harness

- Capture task facts in the repository that owns them. Use the canonical knowledge vault through
  `$obsidian-vault` for cross-workspace research,
  planning, documentation, learning-loop updates, routing lessons, and plugin
  candidates.
- Search before creating; update the narrowest existing note; never store
  secrets, credentials, raw private content, or noisy transcripts.
- Assess the Learn step at the end of every task. Update an existing vault note
  or its learning loop when the result is verified and reusable; do not create
  a note merely to log routine activity.
- After the same meaningful failure happens twice, record the pattern and
  propose the smallest durable control: deterministic tool or hook first when
  mechanically enforceable; repo doc for repo facts; `AGENTS.md` for durable
  conventions; skill for a reusable workflow; MCP/app for live external data;
  plugin for a stable shareable bundle.

## Finish clearly

Report the outcome, changed artifacts, checks run, skipped checks, remaining
risks, and any durable learning captured. A task is complete only when its
actual acceptance conditions are evidenced; otherwise keep working or state the
specific blocker.
