# Playbook: diagnosis

For "diagnose this" / "it's broken" / "it's slow":

1. **diagnosing-bugs** — the diagnosis loop: reproduce, bisect, root-cause,
   smallest fix.
2. **grilling** (or `grill-with-docs`) — stress-test the proposed fix against
   the docs before implementing.
3. **prototype** — when the fix's shape is uncertain, throwaway prototype to
   answer the design question.
4. **code-review** — after the fix, review standards + spec axes.

Sensors: the failing sensor gets re-run after every fix; flaky/always-green
sensors are weak evidence.
