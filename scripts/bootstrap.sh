#!/usr/bin/env bash
# BAK bootstrap — install BAK-owned skills, then optionally external providers.
# Usage: bash scripts/bootstrap.sh [agent] [--providers mattpocock,pstack]
# Default: agent=cursor, providers=none (BAK works with zero external suites).
# NEVER use `--all` (installs symlinks into dozens of agent dirs).

set -euo pipefail

AGENT="cursor"
PROVIDERS=""

while [ $# -gt 0 ]; do
  case "$1" in
    --providers) PROVIDERS="${2:-}"; shift 2 ;;
    *) AGENT="$1"; shift ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo ">> Detecting installed providers ..."
bash "$SCRIPT_DIR/detect-providers.sh"

echo ">> Installing BAK-owned skills (always) for $AGENT ..."
npx skills@latest add aniqaqill/bad-agent-kit -g --skill bak --agent "$AGENT" -y
npx skills@latest add aniqaqill/bad-agent-kit -g --skill go-plan --agent "$AGENT" -y
npx skills@latest add aniqaqill/bad-agent-kit -g --skill go-tdd --agent "$AGENT" -y
npx skills@latest add aniqaqill/bad-agent-kit -g --skill go-review --agent "$AGENT" -y
npx skills@latest add aniqaqill/bad-agent-kit -g --skill babysit --agent "$AGENT" -y

install_provider() {
  case "$1" in
    mattpocock)
      echo ">> Installing provider mattpocock for $AGENT ..."
      npx skills@latest add mattpocock/skills -g --skill '*' --agent "$AGENT" -y --full-depth
      ;;
    pstack)
      echo ">> pstack is plugin-channel ONLY (no npx)."
      echo "   Install via: /add-plugin pstack   (Cursor)"
      echo "   or: /plugin marketplace add cursor/plugins && /plugin install pstack@cursor-plugins"
      echo "   Fallback: clone cursor/plugins to a pinned location and record the root."
      ;;
    *)
      echo "Skipped unknown provider: $1"
      ;;
  esac
}

if [ -n "$PROVIDERS" ]; then
  IFS=',' read -ra LIST <<< "$PROVIDERS"
  for p in "${LIST[@]}"; do install_provider "$p"; done
fi

echo ">> Re-detecting providers after install ..."
bash "$SCRIPT_DIR/detect-providers.sh"
echo "Done. BAK-owned skills installed for $AGENT; providers: ${PROVIDERS:-none}."
