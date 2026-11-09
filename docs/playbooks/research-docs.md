# Playbook: research & documentation

Provider route first, builtin fallback after the arrow.

1. **find-docs** (`vercel-labs:find-skills` → builtin web tools + catalog
   scan): current primary docs for any library/SDK/CLI question; never trust
   training data for API details.
2. **research** (`mp:research` → builtin web research): high-trust
   primary-source investigation, findings captured as a Markdown file in the
   repo.
3. **domain-modeling** (`mp:domain-modeling` → builtin GLOSSARY/ADR updates):
   record durable terminology.

Docs routing contract: OpenAI products → official OpenAI route; everything
else → Context7. See `skills/bak/references/documentation-routing.md`.
