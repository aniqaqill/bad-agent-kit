# SOLID / design lens (dave.cheney.net/2016/08/20/solid-go-design)

Name the violation in Cheney's vocabulary — never say "this is bad":

- Rigid — change forces cascade edits through unrelated packages
- Fragile — change breaks distant parts
- Immobile — can't be reused outside the current context
- Complex — more cognitive load than the job needs
- Verbose — more ceremony than information

Probes:
- Model the domain: sealed-interface state machines over scattered booleans
- One package = one responsibility; no common/utils catch-alls
- Consumer-defined narrow interfaces; accept interfaces, return structs
- Deep modules: hide complexity behind a small interface
- Dependency inversion: concrete wiring pushed up to main/top-level handlers;
  low-level layers return errors, never decide policy

Smell proxies (sensors, weak evidence): unused/unparam, gocyclo, funlen,
revive iface-*, `go list -deps` for the import graph.
