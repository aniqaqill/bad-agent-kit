#!/usr/bin/env bash
# BAK update — refresh all upstream skills for one agent, keep BAK itself.
# Usage: bash scripts/update.sh [agent]
set -euo pipefail

AGENT="${1:-cursor}"

echo ">> Updating upstream skills for $AGENT ..."
npx skills@latest update -g -y

echo ">> Refreshing BAK router from this repo ..."
npx skills@latest add aniqaqill/bad-agent-kit -g --skill bak --agent "$AGENT" -y

echo "Done."
