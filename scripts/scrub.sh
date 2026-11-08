#!/usr/bin/env bash
# Privacy-scrub gate — fails if personal literals leak into shippable files.
# Run: bash scripts/scrub.sh   (also runs in CI + prepublishOnly)
set -euo pipefail

cd "$(dirname "$0")/.."

BLOCKED_PATTERNS=(
  '/home/aniqaqil'
  '/mnt/c/Users/aniqa'
  'memory-vault'
  'aniqaqil@'
)

FAILED=0
for pattern in "${BLOCKED_PATTERNS[@]}"; do
  hits=$(grep -rn --exclude-dir=.git --exclude=scrub.sh --exclude=*.tar.gz "$pattern" . || true)
  if [ -n "$hits" ]; then
    echo "SCRUB FAIL: pattern '$pattern' found:"
    echo "$hits"
    FAILED=1
  fi
done

if [ "$FAILED" -ne 0 ]; then
  echo "Privacy-scrub gate failed. Replace literals with \$HOME or generic paths."
  exit 1
fi
echo "Privacy-scrub gate passed."
