# Changelog

All notable changes to **Solo Squad** are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versioning follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [2.0.0] — 2026-07-13

Dual-platform release: **Cursor** and **Antigravity**.

### Added

- Dual-platform installer: `./scripts/install.sh --platform cursor|antigravity`
  - Cursor → `~/.cursor/skills/` (default, unchanged)
  - Antigravity → `~/.gemini/config/skills/` (global path for AGY / CLI / IDE)
- Installer rewrites `~/.cursor/skills` references inside installed skill markdown for Antigravity
- `.solo-squad-platform` marker written next to `.solo-squad-lang`
- Antigravity documented in [PLATFORMS.md](./PLATFORMS.md) and bilingual docs

### Changed

- [PLATFORMS.md](./PLATFORMS.md) — Antigravity marked supported; removed outdated `~/.agent/skills/` path
- Root and docs READMEs list Cursor + Antigravity as supported platforms

## [1.0.0] — 2026-07-09

First public release of Solo Squad for **Cursor**.

### Added

- **19** on-demand `/solo-*` skills:
  - Meta: `/solo-help`, `/solo-status`
  - Phase 0 / planning: `/solo-modernize`, `/solo-scout`, `/solo-add-feature`, `/solo-blueprint`
  - Build: `/solo-backend`, `/solo-frontend`, `/solo-ponytail`, `/solo-ponytail-ultra`, `/solo-ponytail-review`, `/solo-ponytail-status`
  - Quality & security: `/solo-test`, `/solo-review`, `/solo-security`, `/solo-pentest`, `/solo-dependabot`
  - Release: `/solo-ship`, `/solo-docs`
- Installer with language choice: `./scripts/install.sh --lang id|en`
- Bilingual skill descriptions (`locales/descriptions.{id,en}.json`) and help references
- Bilingual docs under `docs/id/` and `docs/en/` (full guide + README)
- Install notes for **macOS**, **Linux**, and **Windows** (Git Bash / WSL)
- Bundled community references (see [ATTRIBUTION.md](./ATTRIBUTION.md))
- Maintenance scripts: `bundle-update.sh`, `solo-skills-audit.sh`, `solo-ponytail-diff.sh`, `apply-locale.py`
- DietrichGebert/ponytail wired as `/solo-ponytail*` (on demand, no separate setup)

### Notes

- Skill **bodies** (agent instructions) stay in English; **descriptions** and help text follow install language.
- Cursor-first; other platforms are tracked in [PLATFORMS.md](./PLATFORMS.md), not part of 1.0.0.

[Unreleased]: https://github.com/BlackCoffeee/solo-squad/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/BlackCoffeee/solo-squad/releases/tag/v2.0.0
[1.0.0]: https://github.com/BlackCoffeee/solo-squad/releases/tag/v1.0.0
