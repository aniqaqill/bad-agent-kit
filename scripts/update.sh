#!/usr/bin/env bash
# BAK update — update BAK-owned skills; update ONLY pinned external providers
# the detector reports present, and only within their pinned ref.
# Usage: bash scripts/update.sh [agent]
set -euo pipefail

AGENT="${1:-cursor}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ">> Detecting providers ..."
bash "$SCRIPT_DIR/detect-providers.sh"

echo ">> Refreshing BAK-owned skills from this repo ..."
for s in bak go-plan go-tdd go-review babysit; do
  npx skills@latest add aniqaqill/bad-agent-kit -g --skill "$s" --agent "$AGENT" -y
done

echo ">> Updating detected external providers (pinned refs only) ..."
STATUS="$HOME/.config/bak/providers.json"
if [ -f "$STATUS" ]; then
  for id in mattpocock vercel-labs; do
    if python3 -c "
import json,sys
d=json.load(open('$STATUS'))
p=[x for x in d['providers'] if x['id']=='$id']
sys.exit(0 if p and p[0]['status']=='present' else 1)
"; then
      echo "  updating $id ..."
      npx skills@latest update -g -y --source "$id" 2>/dev/null || npx skills@latest add "$id" -g -y
    else
      echo "  skipped $id (not detected present)"
    fi
  done
else
  echo "  no detection state — skipping external updates (run bootstrap with --providers to install)."
fi

echo ">> Re-stat provider versions ..."
bash "$SCRIPT_DIR/detect-providers.sh"
echo "Done."
