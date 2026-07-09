---
name: solo-status
description: >
  Cek skill Solo Squad mana yang masih aktif di chat ini. Pakai saat /solo-status.
disable-model-invocation: true
license: MIT
---

# Solo Status — Active Skills Check

Report which **Solo Squad skills are still active** in **this conversation**.

One-shot: answer once, then done. Does not activate or stop any skill.

## Step 0 — Language (optional)

If `~/.cursor/skills/.solo-squad-lang` exists and contains `en`, reply in English.
Otherwise reply in Indonesian (default).

## Which skills can stay active?

**Persistent** (stay on until stopped):

| Invoked as | Stop with |
|------------|-----------|
| `/solo-modernize` | `stop modernize` |
| `/solo-scout` | `stop scout` |
| `/solo-add-feature` | `stop add-feature` |
| `/solo-blueprint` | `stop blueprint` |
| `/solo-backend` | `stop solo-backend` |
| `/solo-frontend` | `stop solo-frontend` |
| `/solo-test` | `stop solo-test` |
| `/solo-review` | `stop solo-review` |
| `/solo-security` | `stop solo-security` |
| `/solo-pentest` | `stop solo-pentest` |
| `/solo-dependabot` | `stop solo-dependabot` |
| `/solo-ship` | `stop solo-ship` |
| `/solo-docs` | `stop solo-docs` |
| `/solo-ponytail`, `/solo-ponytail lite`, `/solo-ponytail full`, `/solo-ponytail ultra` | `stop solo-ponytail` |
| `/solo-ponytail-ultra` | `stop solo-ponytail` |

`normal mode` stops **all** persistent Solo Squad skills.

**One-shot** (never “active” after their reply — ignore for this report):

- `/solo-help`
- `/solo-status`
- `/solo-ponytail-status`
- `/solo-ponytail-review`

## How to decide

Scan **this chat history** only:

1. If the user said `normal mode` after the last skill invoke → **none active**.
2. A persistent skill is **active** if it was invoked (alone or combined, e.g. `/solo-backend /solo-ponytail`) and has **not** been stopped since with its stop phrase or `normal mode`.
3. `/solo-ponytail` and `/solo-ponytail-ultra` count as the same Ponytail mode for listing — show `/solo-ponytail` (or `/solo-ponytail-ultra` if that was the last Ponytail invoke).
4. If history is ambiguous → treat as **not active**.

## Output format

### Indonesian (default)

If none active:

```text
Tidak ada skill Solo Squad yang aktif di chat ini.
```

If some active — short list only:

```text
Aktif di chat ini:
- /solo-backend
- /solo-ponytail
```

Optional one-line footer (only if something is active):

```text
Matikan: stop [nama] · atau normal mode
```

### English

If none active:

```text
No Solo Squad skills are active in this chat.
```

If some active:

```text
Active in this chat:
- /solo-backend
- /solo-ponytail
```

Optional footer:

```text
Stop: stop [name] · or normal mode
```

## Do not

- Explain each skill
- Start implementing or reviewing code
- Activate or deactivate skills
- Invent skills that were never invoked

## Boundaries

Read-only status check. For the full catalog use `/solo-help`.
