#!/usr/bin/env bash
# Update bundled references in repo skills/ from upstream URLs.
#
# Usage:
#   ./scripts/bundle-update.sh           # fetch all upstream refs
#   ./scripts/bundle-update.sh --dry-run # show URLs only
#
# Custom refs (solo-help, solo-dependabot) are not updated — edit manually.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILLS_DIR="${SOLO_SKILLS_DIR:-${REPO_ROOT}/skills}"

# shellcheck source=reference-map.sh
source "${SCRIPT_DIR}/reference-map.sh"

DRY_RUN=0

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run) DRY_RUN=1 ;;
      -h|--help)
        sed -n '2,8p' "$0"
        exit 0
        ;;
      *) echo "Opsi tidak dikenal: $1" >&2; exit 2 ;;
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

main() {
  parse_args "$@"

  if [[ ! -d "$SKILLS_DIR" ]]; then
    echo "skills/ tidak ditemukan: $SKILLS_DIR" >&2
    exit 2
  fi

  local entry dest
  for entry in "${REFERENCE_MAP[@]}"; do
    parse_ref_entry "$entry"
    dest="${SKILLS_DIR}/${REF_SKILL}/references/${REF_FILE}"
    mkdir -p "$(dirname "$dest")"

    if [[ $DRY_RUN -eq 1 ]]; then
      echo "would fetch: $REF_URL → $dest"
      continue
    fi

    echo "Fetching ${REF_SKILL}/${REF_FILE}..."
    if ! curl -fsSL "$REF_URL" -o "$dest"; then
      echo "Gagal: $REF_URL" >&2
      exit 1
    fi
  done

  echo "✓ Bundled references updated in ${SKILLS_DIR}"
  echo "  Jalankan: ./scripts/solo-skills-audit.sh --check"
}

main "$@"
