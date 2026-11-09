# Playbook: feature work (plan → implement → review → mr)

Each step shows the provider route and the builtin fallback. A provider runs
only when pinned AND detected; absence degrades with a one-line skip note.

1. **plan (intake)** — `mp:triage` → `mp:to-spec` → `mp:to-tickets` (or
   `pstack:poteto-mode`); builtin fallback: inline frontier interview +
   spec synthesis. Exit: spec naming every shared datum, seam, and
   acceptance condition.
2. **implement** — `mp:tdd` / `pstack:tdd` at pre-agreed seams (non-Go);
   builtin fallback: inline red-green-refactor. Exit: sensor chain clean +
   e2e outcome test passing.
3. **review** — review-pipeline.md: phase 0 deterministic sensors → phase 1
   author pre-review → phase 2 two-axis (mp:code-review or builtin) → phase 3
   optional adversarial (pstack:interrogate) → phase 4 human gate. Exit:
   P0/P1 fixed or human-waived; findings bound to SHA.
4. **mr / babysit** — `$babysit` (builtin — pstack ships no mr skill): declare
   mode, work the merge frontier, conflicts → threads → CI, terminal states
   per mr-loop.md. Exit: merged / closed / merge-ready / retries-exhausted /
   human-needed — reported with evidence.

**Sensors throughout**: prehook.sh before material changes, posthook.sh after,
prepush.sh only immediately before a user-authorized push. Re-read tracker
state and re-run sensors before every merge claim.
