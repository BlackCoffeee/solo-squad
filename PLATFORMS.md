# Platform support

Solo Squad targets the [Agent Skills](https://agentskills.io) open format (`SKILL.md` + optional `references/`).

## Supported today

| Platform | Status | Install path | Notes |
|----------|--------|--------------|-------|
| **Cursor (macOS / Linux / Windows)** | ✅ Primary | `~/.cursor/skills/` | `./scripts/install.sh` or `--platform cursor` — see [docs/id/SOLO-SQUAD.md](./docs/id/SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows) |
| **Antigravity (AGY / CLI / IDE)** | ✅ Supported | `~/.gemini/config/skills/` | `./scripts/install.sh --platform antigravity` |

### Install examples

```bash
# Cursor (default)
./scripts/install.sh --lang id

# Antigravity (global — works across AGY, AGY CLI, AGY IDE)
./scripts/install.sh --platform antigravity --lang id

# Custom target (any platform label)
SOLO_SKILLS_DIR=/custom/path ./scripts/install.sh --platform cursor
```

Installer behavior:

- Copies all `skills/solo-*` folders into the platform path
- Applies `--lang id|en` descriptions via `apply-locale.py`
- Rewrites `~/.cursor/skills` references inside installed `SKILL.md` files to the target path (needed for Antigravity)
- Writes `.solo-squad-lang` and `.solo-squad-platform` markers in the target dir

### Antigravity notes

- Preferred **global** path: `~/.gemini/config/skills/` (recognized by AGY, AGY CLI, and AGY IDE).
- Workspace-only alternative (not used by this installer): `<repo>/.agents/skills/`.
- Do **not** use `~/.agent/skills/` — outdated / incorrect for current Antigravity.
- `disable-model-invocation: true` is honored on Cursor; Antigravity may still auto-suggest skills from descriptions. Prefer explicit `/solo-*` slash commands.
- After install: restart Antigravity or relaunch `agy`, then `/solo-help`.

## Planned (not implemented yet)

| Platform | Likely path | Notes |
|----------|-------------|-------|
| VS Code / Copilot | `.github/skills/` or extension-specific | Adapter TBD |
| Gemini CLI | `~/.gemini/skills/` | Separate from Antigravity global config |
| Claude Code | `~/.claude/skills/` | Often compatible with minimal path changes |

## Design for portability

- **No Cursor-only syntax** in SKILL.md bodies where avoidable (repo sources keep Cursor paths; installer rewrites per platform)
- **`disable-model-invocation: true`** — on-demand activation where the host supports it
- **No executable `scripts/`** in skill roots — security + portability
- **Bundled `references/`** — progressive disclosure per agentskills.io

When adding a platform, prefer:

1. Path mapping in `scripts/install.sh` (`--platform <name>`)
2. Path table in this file
3. Platform-specific notes in README / docs

Contributions welcome via PR.
