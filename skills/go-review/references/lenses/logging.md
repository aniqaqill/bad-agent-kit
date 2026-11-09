# Logging lens (OPTIONAL — judgment only, never a gate)

Cheney, "Let's talk about logging" — hygiene guidance, not enforcement. The
go-review Standards axis reads this; no rule here blocks a merge.

- **L1** Two levels suffice (Info/Debug); resist the urge to add Error/Warn
  (note: slog has Warn; the disagreement is stylistic — pick one and stay
  consistent).
- **L2** Never `log.Fatal` or `panic` in libraries — return errors; only the
  top-level handler decides to exit.
- **L3** Log once at the boundary — the handler logs; libraries annotate and
  return. Log-and-rethrow is the antipattern.
- **L4** No package-level logger globals; loggers are per-package, injectable,
  runtime-controllable.
- **L5** A "warning" is either info or error — decide which; warnings are
  information no one acts on.

Compatible with HARD rule 14 (no secrets in logs/errors).
