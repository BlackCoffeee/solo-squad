#!/usr/bin/env bash
# Install Solo Squad skills for Cursor and/or Antigravity.
#
# Usage:
#   ./scripts/install.sh                              # Cursor (default), prompt lang if TTY
#   ./scripts/install.sh --platform cursor --lang id
#   ./scripts/install.sh --platform antigravity --lang en
#   ./scripts/install.sh --dry-run
#   SOLO_PLATFORM=antigravity SOLO_LANG=en ./scripts/install.sh
#   SOLO_SKILLS_DIR=/custom/path ./scripts/install.sh  # overrides platform path
#
# Removes legacy ponytail* folders (pre solo-ponytail rename)
# and solo-add-fitur (renamed to solo-add-feature).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILLS_SRC="${REPO_ROOT}/skills"
LOCALES_DIR="${REPO_ROOT}/locales"
APPLY_LOCALE="${SCRIPT_DIR}/apply-locale.py"

# Canonical install homes (tilde form used inside SKILL.md after rewrite)
CURSOR_SKILLS_TILDE="~/.cursor/skills"
ANTIGRAVITY_SKILLS_TILDE="~/.gemini/config/skills"

LEGACY_SKILLS=(
  ponytail ponytail-ultra ponytail-review ponytail-status
  solo-add-fitur
)

DRY_RUN=0
LANG="${SOLO_LANG:-}"
PLATFORM="${SOLO_PLATFORM:-}"
TARGET_DIR=""
SKILLS_TILDE=""
SKILLS_DIR_OVERRIDE=0

usage() {
  cat <<'EOF'
Install Solo Squad skills into Cursor and/or Antigravity.

Usage:
  ./scripts/install.sh [--platform cursor|antigravity] [--lang id|en] [--dry-run]

Options:
  --platform NAME   cursor (default) | antigravity
  --lang id|en      Skill description language (default: prompt or id)
  --dry-run         Show actions only
  -h, --help        Help

Environment:
  SOLO_PLATFORM=cursor|antigravity
  SOLO_LANG=id|en
  SOLO_SKILLS_DIR=/custom/path   # overrides default path for the platform

Default paths:
  cursor       → ~/.cursor/skills/
  antigravity  → ~/.gemini/config/skills/
EOF
}

log()  { printf '%s\n' "$*"; }
ok()   { printf '✓ %s\n' "$*"; }
err()  { printf '✗ %s\n' "$*" >&2; }

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --platform)
        [[ $# -ge 2 ]] || { err "--platform butuh cursor atau antigravity"; exit 2; }
        PLATFORM="$2"
        shift 2
        ;;
      --platform=*) PLATFORM="${1#*=}"; shift ;;
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

resolve_platform() {
  if [[ -z "$PLATFORM" ]]; then
    PLATFORM="cursor"
  fi
  case "$PLATFORM" in
    cursor|antigravity) ;;
    *)
      err "Platform tidak valid: $PLATFORM (pakai cursor atau antigravity)"
      exit 2
      ;;
  esac

  if [[ -n "${SOLO_SKILLS_DIR:-}" ]]; then
    TARGET_DIR="${SOLO_SKILLS_DIR}"
    SKILLS_DIR_OVERRIDE=1
    # Prefer tilde form when under $HOME for readable paths in SKILL.md
    if [[ "$TARGET_DIR" == "$HOME"/* ]]; then
      SKILLS_TILDE="~${TARGET_DIR#"$HOME"}"
    else
      SKILLS_TILDE="$TARGET_DIR"
    fi
    return 0
  fi

  case "$PLATFORM" in
    cursor)
      TARGET_DIR="${HOME}/.cursor/skills"
      SKILLS_TILDE="${CURSOR_SKILLS_TILDE}"
      ;;
    antigravity)
      TARGET_DIR="${HOME}/.gemini/config/skills"
      SKILLS_TILDE="${ANTIGRAVITY_SKILLS_TILDE}"
      ;;
  esac
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

# Repo SKILL.md sources use ~/.cursor/skills; rewrite after copy for other targets.
rewrite_skill_paths() {
  local dest="$1"
  local from="${CURSOR_SKILLS_TILDE}"
  local to="${SKILLS_TILDE}"

  [[ "$from" == "$to" ]] && return 0

  if [[ $DRY_RUN -eq 1 ]]; then
    log "[dry-run] rewrite ${from} → ${to} in ${dest}/**/*.md"
    return 0
  fi

  local f
  while IFS= read -r -d '' f; do
    # Portable in-place replace (macOS + Linux)
    if sed --version >/dev/null 2>&1; then
      sed -i "s|${from}|${to}|g" "$f"
    else
      sed -i '' "s|${from}|${to}|g" "$f"
    fi
  done < <(find "$dest" -type f -name '*.md' -print0)
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
    rewrite_skill_paths "$dest"
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

  rewrite_skill_paths "$dest"

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
  local platform_marker="${TARGET_DIR}/.solo-squad-platform"
  if [[ $DRY_RUN -eq 1 ]]; then
    log "[dry-run] echo ${LANG} > ${marker}"
    log "[dry-run] echo ${PLATFORM} > ${platform_marker}"
    return 0
  fi
  printf '%s\n' "$LANG" > "$marker"
  printf '%s\n' "$PLATFORM" > "$platform_marker"
}

finish_message() {
  case "$PLATFORM" in
    cursor)
      ok "Install selesai (19 solo-* skills, lang=${LANG}, platform=cursor). Restart Cursor → /solo-help"
      ;;
    antigravity)
      ok "Install selesai (19 solo-* skills, lang=${LANG}, platform=antigravity). Restart Antigravity / agy → /solo-help"
      log "Note: disable-model-invocation may be ignored on Antigravity; prefer explicit /solo-* slash commands."
      ;;
  esac
  log "Docs: docs/${LANG}/SOLO-SQUAD.md · PLATFORMS.md"
}

main() {
  parse_args "$@"
  resolve_platform
  resolve_lang

  [[ -d "$SKILLS_SRC" ]] || { err "skills/ tidak ditemukan"; exit 2; }
  [[ -f "$APPLY_LOCALE" ]] || { err "apply-locale.py tidak ditemukan"; exit 2; }
  [[ -f "${LOCALES_DIR}/descriptions.${LANG}.json" ]] || {
    err "Locale tidak ditemukan: descriptions.${LANG}.json"
    exit 2
  }

  log ""
  log "=== Solo Squad install (${PLATFORM}) ==="
  log "Language / Bahasa: ${LANG}"
  log "Source: ${SKILLS_SRC}"
  log "Target: ${TARGET_DIR}"
  if [[ $SKILLS_DIR_OVERRIDE -eq 1 ]]; then
    log "Path override: SOLO_SKILLS_DIR (platform label still=${PLATFORM})"
  fi
  if [[ "${SKILLS_TILDE}" != "${CURSOR_SKILLS_TILDE}" ]]; then
    log "SKILL.md paths: ${CURSOR_SKILLS_TILDE} → ${SKILLS_TILDE}"
  fi
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
    finish_message
  fi
}

main "$@"
