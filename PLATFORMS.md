# Platform support

Solo Squad targets the [Agent Skills](https://agentskills.io) open format (`SKILL.md` + optional `references/`).

## Supported today

| Platform | Status | Install path | Notes |
|----------|--------|--------------|-------|
| **Cursor (macOS)** | ✅ Primary | `~/.cursor/skills/` | `./scripts/install.sh` — see [docs/id/SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows](./docs/id/SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows) |
| **Cursor (Linux)** | ✅ Primary | `~/.cursor/skills/` | Same script; requires `git` + `python3` |
| **Cursor (Windows)** | ✅ Primary | `%USERPROFILE%\.cursor\skills\` | Use **Git Bash** or **WSL** — installer is bash, not PowerShell |

## Planned (not implemented yet)

| Platform | Likely path | Notes |
|----------|-------------|-------|
| Antigravity CLI | `~/.agent/skills/` | Same SKILL.md format |
| VS Code / Copilot | `.github/skills/` or extension-specific | Adapter TBD |
| Gemini CLI | TBD | Follow Google agent skills docs |
| Claude Code | `~/.claude/skills/` | Often compatible with minimal path changes |

## Design for portability

- **No Cursor-only syntax** in SKILL.md bodies where avoidable
- **`disable-model-invocation: true`** — on-demand activation (portable concept)
- **No executable `scripts/`** in skill roots — security + portability
- **Bundled `references/`** — progressive disclosure per agentskills.io

When adding a platform, prefer:

1. `scripts/install.sh --platform <name>` flag
2. Path mapping table in this file
3. Platform-specific notes in README

Contributions welcome via PR.
