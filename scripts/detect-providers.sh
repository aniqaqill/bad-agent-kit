#!/usr/bin/env bash
# BAK provider detection — two-step proof: pinned (providers.toml) AND
# resolved on disk. Writes ~/.config/bak/providers.json (advisory only:
# detected-at + version + canonical path; never cached as truth across
# sessions — re-verified on any routed-skill resolve failure).
#
# Precedence per provider: explicit pin -> highest-version plugin install
# -> skills-dir copy. Report ONE canonical path; record shadow copies.
set -euo pipefail

BAK_DIR="$HOME/.config/bak"
OUT="$BAK_DIR/providers.json"
NOW="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
PROVIDERS_TOML="$(cd "$(dirname "$0")/.." && pwd)/manifest/providers.toml"

mkdir -p "$BAK_DIR"

# --- per-provider detection functions. Return 0 = present, 1 = absent. ----

detect_mattpocock() {
  # canonical: ~/.agents/skills (universal, editable)
  for s in tdd triage to-spec to-tickets handoff setup-matt-pocock-skills code-review; do
    if [ -f "$HOME/.agents/skills/$s/SKILL.md" ] || [ -f "$HOME/.claude/skills/$s/SKILL.md" ]; then
      return 0
    fi
  done
  # plugin-channel shadow copies (recorded, never canonical)
  ls "$HOME"/.claude/plugins/cache/*mattpocock*/ 2>/dev/null | grep -q . && { echo "shadow"; return 0; }
  ls "$HOME"/.codex/plugins/*mattpocock*/ 2>/dev/null | grep -q . && { echo "shadow"; return 0; }
  return 1
}

detect_pstack() {
  # plugin-channel ONLY. Marker signature: name=="pstack" AND skills/poteto-mode present.
  local best=""
  for f in "$HOME"/.cursor/plugins/*/.cursor-plugin/plugin.json \
           "$HOME"/.claude/plugins/cache/cursor-plugins/pstack/*/.claude-plugin/plugin.json \
           "$HOME"/.codex/plugins/*/plugin.json; do
    [ -f "$f" ] || continue
    if grep -q '"name"[[:space:]]*:[[:space:]]*"pstack"' "$f" 2>/dev/null; then
      d="$(dirname "$f")"
      [ -d "$d/skills/poteto-mode" ] && { best="$d"; break; }
    fi
  done
  if [ -n "$best" ]; then
    echo "$best"
    return 0
  fi
  # manual clone fallback (classified, never canonical)
  for d in "$HOME"/.agents/skills/poteto-mode "$HOME"/.claude/skills/poteto-mode "$HOME"/.cursor/skills/poteto-mode; do
    [ -d "$d" ] && { echo "manual-clone:$d"; return 0; }
  done
  return 1
}

# --- main ---

results=""
check_provider() {
  local id="$1" fn="$2"
  local out
  if out="$("$fn" 2>/dev/null)"; then
    local status="present" path="$out"
    [ -z "$path" ] && path="$HOME/.agents/skills"
    case "$out" in
      shadow*) status="shadow-copy"; path="plugin cache" ;;
      manual-clone:*) status="manual-clone"; path="${out#manual-clone:}" ;;
    esac
    results="$results{\"id\":\"$id\",\"status\":\"$status\",\"canonical_path\":\"$path\",\"detected_at\":\"$NOW\"},"
  else
    results="$results{\"id\":\"$id\",\"status\":\"absent\",\"canonical_path\":null,\"detected_at\":\"$NOW\"},"
  fi
}

# Only check providers pinned in providers.toml (skip builtin + comments).
while IFS= read -r line; do
  id="${line%% *}"
  case "$id" in
    mattpocock) check_provider mattpocock detect_mattpocock ;;
    pstack) check_provider pstack detect_pstack ;;
  esac
done < <(grep -vE '^\s*(#|$)' "$PROVIDERS_TOML")

printf '{"providers":[%s]}\n' "${results%,}" | python3 -m json.tool > "$OUT" 2>/dev/null || {
  printf '{"providers":[%s]}\n' "${results%,}" > "$OUT"
}

echo "Provider detection complete -> $OUT"
cat "$OUT"
