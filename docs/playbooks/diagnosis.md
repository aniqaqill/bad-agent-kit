# Playbook: diagnosis

For "diagnose this" / "it's broken" / "it's slow". Provider route first,
builtin fallback after the arrow.

1. **diagnosing-bugs** (`mp:diagnosing-bugs` → builtin diagnosis loop):
   reproduce, bisect, root-cause, smallest fix.
2. **grilling** (`mp:grilling` / `$grill-with-docs` → builtin frontier
   interview): stress-test the proposed fix against the docs before
   implementing.
3. **prototype** (`mp:prototype` → builtin throwaway probe): when the fix's
   shape is uncertain.
4. **review** (`mp:code-review` / `$go-review` for Go → builtin two-axis):
   standards + spec axes after the fix.
5. **mr / babysit** (`$babysit`): re-read tracker/sensor state fresh before
   merge — stale-context guard; conflicts → threads → CI order.

Sensors: the failing sensor gets re-run after every fix; flaky/always-green
sensors are weak evidence.
