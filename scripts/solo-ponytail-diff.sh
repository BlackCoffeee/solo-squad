#!/usr/bin/env bash
# Diff solo-ponytail skills vs upstream DietrichGebert/ponytail.
#
# Usage:
#   ./scripts/solo-ponytail-diff.sh           # audit + diff upstream
#   ./scripts/solo-ponytail-diff.sh --check   # audit lokal saja
#   ./scripts/solo-ponytail-diff.sh --hash    # SHA256 saja
#
# Exit codes: 0 = sinkron / aman, 1 = temuan, 2 = error

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=reference-map.sh
source "${SCRIPT_DIR}/reference-map.sh"

UPSTREAM_REPO="DietrichGebert/ponytail"
UPSTREAM_BRANCH="main"
UPSTREAM_BASE="https://raw.githubusercontent.com/${UPSTREAM_REPO}/${UPSTREAM_BRANCH}"

if [[ -z "${SOLO_SKILLS_DIR:-}" && -d "${REPO_ROOT}/skills" ]]; then
  SKILLS_DIR="${REPO_ROOT}/skills"
else
  SKILLS_DIR="${SOLO_SKILLS_DIR:-${HOME}/.cursor/skills}"
fi

CACHE_DIR="${PONYTAIL_CACHE_DIR:-/tmp/solo-ponytail-upstream-$$}"
MODE="diff"
FETCH=1

usage() {
  sed -n '2,9p' "$0"
  echo ""
  echo "Options:"
  echo "  --check     Audit keamanan lokal saja"
  echo "  --hash      SHA256 saja"
  echo "  --no-fetch  Pakai cache"
  echo "  -h, --help  Bantuan"
}

log()  { printf '%s\n' "$*"; }
warn() { printf '⚠ %s\n' "$*" >&2; }
err()  { printf '✗ %s\n' "$*" >&2; }
ok()   { printf '✓ %s\n' "$*"; }

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --check)    MODE="check"; FETCH=0 ;;
      --hash)     MODE="hash" ;;
      --no-fetch) FETCH=0 ;;
      -h|--help)  usage; exit 0 ;;
      *) err "Opsi tidak dikenal: $1"; usage; exit 2 ;;
    esac
    shift
  done
}

sha256_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    sha256sum "$1" | awk '{print $1}'
  fi
}

fetch_upstream() {
  mkdir -p "$CACHE_DIR"
  local pair local_name upstream_path url dest
  for pair in "${SOLO_PONYTAIL_UPSTREAM_MAP[@]}"; do
    local_name="${pair%%:*}"
    upstream_path="${pair#*:}"
    url="${UPSTREAM_BASE}/${upstream_path}"
    dest="${CACHE_DIR}/${local_name}.upstream.md"
    if ! curl -fsSL "$url" -o "$dest"; then
      err "Gagal fetch: $url"
      return 1
    fi
  done
  ok "Upstream di-cache: $CACHE_DIR"
}

security_audit_local() {
  local skill_dir skill_file issues=0 local_name
  log ""
  log "=== Audit solo-ponytail* ==="

  for skill_dir in "$SKILLS_DIR"/solo-ponytail*; do
    [[ -d "$skill_dir" ]] || continue
    skill_file="${skill_dir}/SKILL.md"
    local_name="$(basename "$skill_dir")"

    log ""
    log "--- ${local_name} ---"

    if [[ ! -f "$skill_file" ]]; then
      warn "SKILL.md tidak ditemukan"
      issues=$((issues + 1))
      continue
    fi

    if grep -q 'disable-model-invocation:[[:space:]]*true' "$skill_file"; then
      ok "disable-model-invocation: true"
    else
      warn "TIDAK ada disable-model-invocation: true"
      issues=$((issues + 1))
    fi

    if find "$skill_dir" -type f \( -name '*.py' -o -name '*.sh' -o -name '*.js' -o -name '*.mjs' \) | grep -q .; then
      warn "Script executable di folder skill"
      issues=$((issues + 1))
    else
      ok "Tanpa script executable"
    fi
  done

  log ""
  [[ $issues -eq 0 ]] && ok "Audit bersih" || warn "${issues} temuan"
  return $([[ $issues -eq 0 ]] && echo 0 || echo 1)
}

diff_skills() {
  local pair local_name upstream_path local_file upstream_file diffs=0

  log ""
  log "=== Diff vs ${UPSTREAM_REPO} ==="

  for pair in "${SOLO_PONYTAIL_UPSTREAM_MAP[@]}"; do
    local_name="${pair%%:*}"
    upstream_path="${pair#*:}"
    local_file="${SKILLS_DIR}/${local_name}/SKILL.md"
    upstream_file="${CACHE_DIR}/${local_name}.upstream.md"

    log ""
    log "--- ${local_name} ---"

    [[ -f "$local_file" ]] || { warn "Lokal tidak ada: $local_file"; diffs=$((diffs + 1)); continue; }
    [[ -f "$upstream_file" ]] || { err "Cache upstream tidak ada"; return 2; }

    if [[ "$(sha256_file "$local_file")" == "$(sha256_file "$upstream_file")" ]]; then
      ok "Identik dengan upstream"
    else
      warn "Berbeda dari upstream (adaptasi Solo Squad OK)"
      diffs=$((diffs + 1))
      [[ "$MODE" != "hash" ]] && diff -u "$upstream_file" "$local_file" | head -40 || true
    fi
  done

  log ""
  log "Local-only (tidak di-diff): ${SOLO_PONYTAIL_LOCAL_ONLY[*]}"
  [[ $diffs -eq 0 ]] && ok "Sinkron" || warn "${diffs} berbeda"
  return $([[ $diffs -eq 0 ]] && echo 0 || echo 1)
}

cleanup() {
  [[ "$CACHE_DIR" == /tmp/solo-ponytail-upstream-* ]] && [[ -d "$CACHE_DIR" ]] && rm -rf "$CACHE_DIR"
}

main() {
  parse_args "$@"
  [[ -d "$SKILLS_DIR" ]] || { err "Tidak ada: $SKILLS_DIR"; exit 2; }
  trap cleanup EXIT
  local exit_code=0
  security_audit_local || exit_code=1
  [[ "$MODE" == "check" ]] && exit "$exit_code"
  if [[ $FETCH -eq 1 ]]; then
    fetch_upstream || exit 2
  else
    CACHE_DIR="${PONYTAIL_CACHE_DIR:-$HOME/.cache/solo-ponytail-upstream}"
    [[ -d "$CACHE_DIR" ]] || { err "Tidak ada cache"; exit 2; }
  fi
  diff_skills || exit_code=1
  exit "$exit_code"
}

main "$@"
