# Current Documentation Routing

## OpenAI and Codex

Use `$openai-docs` and its official-source route for OpenAI products, APIs,
models, and Codex behavior. Do not send OpenAI product questions through
Context7 when the official Codex manual or OpenAI developer documentation owns
the answer.

## Other developer technologies

Use `$find-docs`, then use the `ctx7` CLI for every library, framework, SDK,
API, CLI tool, or cloud-service question, including syntax, configuration,
migrations, setup, library-specific debugging, and CLI usage.

Do not use Context7 for refactoring, scripts written from scratch, business
logic debugging, code review, or general programming concepts.

1. Resolve the official library name:

   ```bash
   npx ctx7@latest library <name> "<full user question>"
   ```

2. Select the best `/org/project` result by exact name, relevant description,
   snippet count, High/Medium source reputation, and benchmark score. Retry with
   an alternate official name or sharper query only when results are wrong.
3. Fetch the documentation:

   ```bash
   npx ctx7@latest docs <libraryId> "<full user question>"
   ```

Use `/org/project/version` for version-specific documentation. Resolve first
unless the user supplied a valid `/org/project` ID. Run at most three Context7
commands per question and never include secrets or credentials in queries.

Run Context7 outside the default sandbox. If an in-sandbox call reports DNS,
`ENOTFOUND`, host-resolution, or fetch failures, rerun that specific command
outside the sandbox. On quota errors, tell the user and suggest
`npx ctx7@latest login` or `CONTEXT7_API_KEY`; do not silently answer from model
memory.
