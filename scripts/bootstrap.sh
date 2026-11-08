#!/usr/bin/env bash
# BAK bootstrap — install the BAK stack for one agent.
# Usage: bash scripts/bootstrap.sh [agent]   (agent: cursor | claude | codex)
# NEVER use `--all` (installs symlinks into dozens of agent dirs).

set -euo pipefail

AGENT="${1:-cursor}"

echo ">> Installing BAK router (this repo) for $AGENT ..."
npx skills@latest add aniqaqill/bad-agent-kid -g --skill bak --agent "$AGENT" -y

echo ">> Installing mattpocock/skills for $AGENT ..."
npx skills@latest add mattpocock/skills -g --skill '*' --agent "$AGENT" -y --full-depth

echo ">> Installing find-skills for $AGENT ..."
npx skills@latest add vercel-labs/skills -g --skill find-skills --agent "$AGENT" -y

echo ">> Installing chrome-devtools for $AGENT ..."
npx skills@latest add chromedevtools/chrome-devtools-mcp -g --agent "$AGENT" -y

echo "Done. Run: skills list   (or your agent's /skills) to verify."
