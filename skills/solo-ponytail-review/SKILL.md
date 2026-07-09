---
name: solo-ponytail-review
description: >
  Review kode fokus over-engineering. Temukan yang bisa dihapus. Pakai saat
  /solo-ponytail-review.
disable-model-invocation: true
license: MIT
---

Review diffs for unnecessary complexity. One line per finding: location, what
to cut, what replaces it. The diff's best outcome is getting shorter.

Part of **Solo Squad** — command: `/solo-ponytail-review`.

## Format

`path:L..-L..: tag: finding`

Tags:

- `delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `native:` dependency or code doing what the platform already does. Name the feature.
- `yagni:` abstraction with one implementation, config nobody sets, layer with one caller.
- `shrink:` same logic, fewer lines. Show the shorter form.

## Examples

✅ `L12-38: stdlib: 27-line validator class. "@" in email, 1 line, real validation is the confirmation mail.`

✅ `L4: native: moment.js imported for one format call. Intl.DateTimeFormat, 0 deps.`

✅ `repo.py:L88: yagni: AbstractRepository with one implementation. Inline it until a second one exists.`

✅ `L52-71: delete: retry wrapper around an idempotent local call. Nothing replaces it.`

## Scoring

End with: `net: -N lines possible.`

If nothing to cut: `Lean already. Ship.` and stop.

## Boundaries

Scope: over-engineering only. Correctness, security, performance are out of scope.
Does not apply fixes, only lists them.
"stop solo-ponytail-review" / "normal mode": revert to verbose review style.

Upstream: [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) ponytail-review (adapted).
