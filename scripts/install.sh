#!/usr/bin/env bash
# Install Solo Squad skills into Cursor (~/.cursor/skills/).
#
# Usage:
#   ./scripts/install.sh                    # prompt language (id/en) if TTY
#   ./scripts/install.sh --lang id          # Indonesian descriptions
#   ./scripts/install.sh --lang en          # English descriptions
#   ./scripts/install.sh --dry-run
#   SOLO_LANG=en SOLO_SKILLS_DIR=~/.cursor/skills ./scripts/install.sh
#
# Removes legacy ponytail* folders (pre solo-ponytail rename)
# and solo-add-fitur (renamed to solo-add-feature).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILLS_SRC="${REPO_ROOT}/skills"
LOCALES_DIR="${REPO_ROOT}/locales"
TARGET_DIR="${SOLO_SKILLS_DIR:-${HOME}/.cursor/skills}"
APPLY_LOCALE="${SCRIPT_DIR}/apply-locale.py"

LEGACY_SKILLS=(
  ponytail ponytail-ultra ponytail-review ponytail-status
  solo-add-fitur
)

DRY_RUN=0
LANG="${SOLO_LANG:-}"

usage() {
  sed -n '2,12p' "$0"
  echo ""
  echo "Options:"
  echo "  --lang id|en  Skill description language (default: prompt or id)"
  echo "  --dry-run     Show actions only"
  echo "  -h, --help    Help"
  echo ""
  echo "Environment:"
  echo "  SOLO_LANG=id|en"
  echo "  SOLO_SKILLS_DIR=~/.cursor/skills"
}

log()  { printf '%s\n' "$*"; }
ok()   { printf '✓ %s\n' "$*"; }
err()  { printf '✗ %s\n' "$*" >&2; }

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang)
        [[ $# -ge 2 ]] || { err "--lang butuh id atau en"; exit 2; }
        LANG="$2"
        shift 2
        ;;
      --lang=*) LANG="${1#*=}"; shift ;;
      --dry-run) DRY_RUN=1; shift ;;
      -h|--help) usage; exit 0 ;;
      *) err "Opsi tidak dikenal: $1"; usage; exit 2 ;;
    esac
  done
}

resolve_lang() {
  if [[ -n "$LANG" ]]; then
    case "$LANG" in
      id|en) return 0 ;;
      *) err "Bahasa tidak valid: $LANG (pakai id atau en)"; exit 2 ;;
    esac
  fi

  if [[ -t 0 ]]; then
    log ""
    log "Pilih bahasa deskripsi skill / Choose skill description language:"
    log "  1) Indonesia (id)"
    log "  2) English (en)"
    printf "Pilihan / Choice [1]: "
    read -r choice || choice="1"
    case "${choice:-1}" in
      2|en|EN|english|English) LANG="en" ;;
      *) LANG="id" ;;
    esac
  else
    LANG="id"
  fi
}

install_skill() {
  local name="$1"
  local src="${SKILLS_SRC}/${name}"
  local dest="${TARGET_DIR}/${name}"

  if [[ ! -d "$src" ]]; then
    err "Skill tidak ada: $src"
    return 1
  fi

  if [[ $DRY_RUN -eq 1 ]]; then
    log "[dry-run] cp -R ${src} → ${dest}"
    log "[dry-run] apply-locale --lang ${LANG} ${dest}"
    if [[ "$name" == "solo-help" ]]; then
      log "[dry-run] cp solo-squad-help.${LANG}.md → ${dest}/references/solo-squad-help.md"
    fi
    return 0
  fi

  mkdir -p "$TARGET_DIR"
  rm -rf "$dest"
  cp -R "$src" "$dest"

  python3 "$APPLY_LOCALE" "$dest" --lang "$LANG" --locale-dir "$LOCALES_DIR"

  if [[ "$name" == "solo-help" ]]; then
    local help_ref="${src}/references/solo-squad-help.${LANG}.md"
    [[ -f "$help_ref" ]] || help_ref="${src}/references/solo-squad-help.id.md"
    cp "$help_ref" "${dest}/references/solo-squad-help.md"
  fi

  ok "Installed ${name} (${LANG})"
}

remove_legacy() {
  local name dest
  for name in "${LEGACY_SKILLS[@]}"; do
    dest="${TARGET_DIR}/${name}"
    [[ -d "$dest" ]] || continue
    if [[ $DRY_RUN -eq 1 ]]; then
      log "[dry-run] rm -rf ${dest}  (legacy)"
    else
      rm -rf "$dest"
      ok "Removed legacy ${name}"
    fi
  done
}

write_lang_marker() {
  local marker="${TARGET_DIR}/.solo-squad-lang"
  if [[ $DRY_RUN -eq 1 ]]; then
    log "[dry-run] echo ${LANG} > ${marker}"
    return 0
  fi
  printf '%s\n' "$LANG" > "$marker"
}

main() {
  parse_args "$@"
  resolve_lang

  [[ -d "$SKILLS_SRC" ]] || { err "skills/ tidak ditemukan"; exit 2; }
  [[ -f "$APPLY_LOCALE" ]] || { err "apply-locale.py tidak ditemukan"; exit 2; }
  [[ -f "${LOCALES_DIR}/descriptions.${LANG}.json" ]] || {
    err "Locale tidak ditemukan: descriptions.${LANG}.json"
    exit 2
  }

  log ""
  log "=== Solo Squad install (Cursor) ==="
  log "Language / Bahasa: ${LANG}"
  log "Source: ${SKILLS_SRC}"
  log "Target: ${TARGET_DIR}"
  log ""

  remove_legacy

  local name
  for name in "$SKILLS_SRC"/solo-*; do
    [[ -d "$name" ]] || continue
    install_skill "$(basename "$name")"
  done

  write_lang_marker

  log ""
  if [[ $DRY_RUN -eq 1 ]]; then
    log "Dry run selesai."
  else
    ok "Install selesai (19 solo-* skills, lang=${LANG}). Restart Cursor → /solo-help"
    log "Docs: docs/${LANG}/SOLO-SQUAD.md"
  fi
}

main "$@"
