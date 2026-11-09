#!/usr/bin/env bash
# Upstream path-existence check — fail loudly when a pinned skill path moved
# or was deleted upstream. Used by both the CI providers job and the local
# pre-push hook.
set -euo pipefail

cd "$(dirname "$0")/.."

FAILED=0
while IFS='|' read -r provider src path rest; do
  provider="${provider// /}"; src="${src// /}"; path="${path// /}"
  [ -z "$provider" ] && continue
  case "$provider" in
    mattpocock) repo="mattpocock/skills"; ref="main" ;;
    pstack) repo="cursor/plugins"; ref="main" ;;
    vercel-labs) repo="vercel-labs/skills"; ref="main" ;;
    chrome-devtools) repo="ChromeDevTools/chrome-devtools-mcp"; ref="main" ;;
    *) continue ;;
  esac
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "https://raw.githubusercontent.com/$repo/$ref/$path/SKILL.md")
  if [ "$code" != "200" ]; then
    echo "STALE PIN: $provider $path (HTTP $code)"
    FAILED=1
  fi
done < <(grep -vE '^\s*(#|$)' manifest/upstream-sources.txt | grep -v '^local:')

if [ "$FAILED" -ne 0 ]; then
  echo "Upstream path check failed — update manifest/upstream-sources.txt."
  exit 1
fi
echo "Upstream path check passed."
