---
name: solo-ponytail-status
description: >
  Cek apakah mode Ponytail aktif di chat ini. Jawaban singkat: YA atau TIDAK.
  Pakai saat /solo-ponytail-status.
disable-model-invocation: true
license: MIT
---

# Solo Ponytail Status

Report whether **Ponytail persistent mode** is active in **this conversation**.

## Output (mandatory)

Reply with **exactly one word**, nothing else:

- `YA` — Ponytail mode is active
- `TIDAK` — Ponytail mode is not active

No explanation, no markdown, no punctuation — unless user explicitly asks for detail after the one-word answer.

## Rules for YA

Ponytail is **YA** if, in this chat history:

1. User invoked `/solo-ponytail`, `/solo-ponytail-ultra`, `/solo-ponytail lite`, `/solo-ponytail full`, or `/solo-ponytail ultra`, **or**
2. User combined `/solo-ponytail` with another skill (e.g. `/solo-backend /solo-ponytail`), **and**
3. User has **not** since said `stop solo-ponytail` or `normal mode`.

`/solo-ponytail-ultra` alone also counts as **YA**.

## Rules for TIDAK

**TIDAK** if:

- Ponytail was never invoked in this chat, or
- User said `stop solo-ponytail` / `normal mode` after invocation, or
- Only `/solo-ponytail-review` was used (one-shot review — not persistent mode), or
- Only Solo Squad skills without `/solo-ponytail` in the same turn.

## When unsure

If history is ambiguous, default **TIDAK**.

## Boundaries

Read-only status check — does not activate or deactivate Ponytail.
