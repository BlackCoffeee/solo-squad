#!/usr/bin/env bash
# Audit skill Solo Squad: keamanan + diff bundled references vs upstream.
#
# Usage:
#   ./scripts/solo-skills-audit.sh           # audit keamanan + diff upstream
#   ./scripts/solo-skills-audit.sh --check   # audit keamanan saja (tanpa network)
#   ./scripts/solo-skills-audit.sh --hash    # SHA256 bundled vs upstream
#
# Exit codes: 0 = aman / sinkron, 1 = temuan / diff, 2 = error

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=reference-map.sh
source "${SCRIPT_DIR}/reference-map.sh"

REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
DEFAULT_SKILLS_DIR="${SOLO_SKILLS_DIR:-$HOME/.cursor/skills}"
# Prefer repo skills/ when auditing from clone (CI / pre-install check)
if [[ -z "${SOLO_SKILLS_DIR:-}" && -d "${REPO_ROOT}/skills" ]]; then
  SKILLS_DIR="${REPO_ROOT}/skills"
else
  SKILLS_DIR="${DEFAULT_SKILLS_DIR}"
fi
CACHE_DIR="${SOLO_CACHE_DIR:-/tmp/solo-skills-upstream-$$}"

MODE="diff"
FETCH=1

# Format: skill_name|ref_filename|upstream_url — see scripts/reference-map.sh

usage() {
  sed -n '2,9p' "$0"
  echo ""
  echo "Options:"
  echo "  --check     Audit keamanan lokal saja (tanpa fetch upstream)"
  echo "  --hash      Tampilkan SHA256 bundled vs upstream"
  echo "  --no-fetch  Pakai cache di \$SOLO_CACHE_DIR atau ~/.cache/solo-skills-upstream"
  echo "  -h, --help  Tampilkan bantuan"
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

parse_ref_entry() {
  local entry="$1"
  REF_SKILL="${entry%%|*}"
  local rest="${entry#*|}"
  REF_FILE="${rest%%|*}"
  REF_URL="${rest#*|}"
}

sha256_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    sha256sum "$1" | awk '{print $1}'
  fi
}

audit_file_security() {
  local label="$1" file="$2" refs_mode="${3:-0}"

  if [[ ! -f "$file" ]]; then
    warn "${label}: file tidak ditemukan — $file"
    return 1
  fi

  # Bundled community refs may contain benign HTML comment examples (e.g. Taste Skill)
  if [[ "$refs_mode" -eq 1 ]]; then
    if grep -qE 'ignore previous|system override|exfiltrat(e|ing) (the )?(user |chat |conversation |prompt )' "$file"; then
      warn "${label}: pola prompt-injection berbahaya terdeteksi"
      return 1
    fi
  else
    if grep -qE '<!--|ignore previous|system override|exfiltrat' "$file"; then
      warn "${label}: pola prompt-injection umum terdeteksi"
      return 1
    fi
  fi

  ok "${label}: tanpa pola injection berbahaya"
  return 0
}

security_audit() {
  local skill_name skill_dir skill_file ref_dir issues=0 ref_count

  log ""
  log "=== Audit keamanan Solo Squad ==="

  for skill_name in "${SOLO_SKILLS[@]}"; do
    skill_dir="${SKILLS_DIR}/${skill_name}"
    skill_file="${skill_dir}/SKILL.md"
    ref_dir="${skill_dir}/references"
    ref_count=0

    log ""
    log "--- ${skill_name} ---"

    if [[ ! -d "$skill_dir" ]]; then
      warn "Folder tidak ada: $skill_dir"
      issues=$((issues + 1))
      continue
    fi

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

    if find "$skill_dir" -type f \( -name '*.py' -o -name '*.sh' -o -name '*.js' -o -name '*.mjs' \) \
      ! -path '*/references/*' | grep -q .; then
      warn "Script executable di luar references/ — review manual"
      find "$skill_dir" -type f \( -name '*.py' -o -name '*.sh' -o -name '*.js' -o -name '*.mjs' \) \
        ! -path '*/references/*'
      issues=$((issues + 1))
    else
      ok "Tanpa script executable (root skill)"
    fi

    audit_file_security "SKILL.md" "$skill_file" || issues=$((issues + 1))

    if [[ -d "$ref_dir" ]]; then
      local ref_file
      for ref_file in "$ref_dir"/*.md; do
        [[ -f "$ref_file" ]] || continue
        audit_file_security "references/$(basename "$ref_file")" "$ref_file" 1 || issues=$((issues + 1))
        ref_count=$((ref_count + 1))
      done
      if [[ $ref_count -gt 0 ]]; then
        ok "references/: ${ref_count} file bundled"
      else
        warn "references/ kosong"
        issues=$((issues + 1))
      fi
    elif grep -q 'references/' "$skill_file"; then
      warn "Folder references/ tidak ada (SKILL.md mengharapkannya)"
      issues=$((issues + 1))
    else
      ok "Tanpa references/ (OK — skill standalone)"
    fi

    if grep -q 'references/' "$skill_file"; then
      ok "SKILL.md menyebut references/ (chaining OK)"
    fi
  done

  log ""
  if [[ $issues -eq 0 ]]; then
    ok "Audit keamanan Solo Squad: bersih (${#SOLO_SKILLS[@]} skill)"
    return 0
  fi
  warn "Audit keamanan: ${issues} temuan — review disarankan"
  return 1
}

fetch_upstream_refs() {
  local entry
  mkdir -p "$CACHE_DIR"
  for entry in "${REFERENCE_MAP[@]}"; do
    parse_ref_entry "$entry"
    local dest="${CACHE_DIR}/${REF_SKILL}--${REF_FILE}"
    if ! curl -fsSL "$REF_URL" -o "$dest"; then
      err "Gagal fetch: $REF_URL"
      return 1
    fi
  done
  ok "Upstream references di-cache: $CACHE_DIR"
}

diff_references() {
  local entry local_file upstream_file diffs=0

  log ""
  log "=== Diff bundled references vs upstream ==="

  for entry in "${REFERENCE_MAP[@]}"; do
    parse_ref_entry "$entry"
    local_file="${SKILLS_DIR}/${REF_SKILL}/references/${REF_FILE}"
    upstream_file="${CACHE_DIR}/${REF_SKILL}--${REF_FILE}"

    log ""
    log "--- ${REF_SKILL} / ${REF_FILE} ---"
    log "Upstream: $REF_URL"

    if [[ ! -f "$local_file" ]]; then
      warn "Bundled tidak ada: $local_file"
      diffs=$((diffs + 1))
      continue
    fi

    if [[ ! -f "$upstream_file" ]]; then
      err "Cache upstream tidak ada — jalankan tanpa --no-fetch"
      return 2
    fi

    local local_hash upstream_hash
    local_hash="$(sha256_file "$local_file")"
    upstream_hash="$(sha256_file "$upstream_file")"

    log "SHA256 bundled:  $local_hash"
    log "SHA256 upstream: $upstream_hash"

    if [[ "$local_hash" == "$upstream_hash" ]]; then
      ok "Identik dengan upstream"
      continue
    fi

    warn "Berbeda dari upstream (header bundled-for/custom OK)"
    diffs=$((diffs + 1))

    if [[ "$MODE" == "hash" ]]; then
      continue
    fi

    log ""
    log "Diff (upstream → bundled, max 40 baris):"
    diff -u "$upstream_file" "$local_file" | head -40 || true
    log "... (diff mungkin terpotong)"
  done

  log ""
  if [[ $diffs -eq 0 ]]; then
    ok "Semua bundled references sinkron dengan upstream"
    return 0
  fi
  warn "${diffs} reference berbeda — review jika tidak disengaja"
  log "Update: lihat SOLO-SQUAD.md → Update bundled references"
  return 1
}

cleanup() {
  if [[ "$CACHE_DIR" == /tmp/solo-skills-upstream-* ]] && [[ -d "$CACHE_DIR" ]]; then
    rm -rf "$CACHE_DIR"
  fi
}

main() {
  parse_args "$@"

  if [[ ! -d "$SKILLS_DIR" ]]; then
    err "Folder skill tidak ditemukan: $SKILLS_DIR"
    exit 2
  fi

  trap cleanup EXIT

  local exit_code=0

  security_audit || exit_code=1

  if [[ "$MODE" == "check" ]]; then
    exit "$exit_code"
  fi

  if [[ $FETCH -eq 1 ]]; then
    fetch_upstream_refs || exit 2
  else
    CACHE_DIR="${SOLO_CACHE_DIR:-$HOME/.cache/solo-skills-upstream}"
    if [[ ! -d "$CACHE_DIR" ]]; then
      err "Tidak ada cache. Jalankan tanpa --no-fetch dulu."
      exit 2
    fi
    warn "Memakai cache: $CACHE_DIR"
  fi

  diff_references || exit_code=1

  exit "$exit_code"
}

main "$@"
