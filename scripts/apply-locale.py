#!/usr/bin/env python3
"""Apply locale-specific description to a Solo Squad SKILL.md frontmatter."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


def load_descriptions(locale_dir: Path, lang: str) -> dict[str, str]:
    path = locale_dir / f"descriptions.{lang}.json"
    if not path.is_file():
        raise FileNotFoundError(f"Locale file not found: {path}")
    with path.open(encoding="utf-8") as fh:
        data = json.load(fh)
    if not isinstance(data, dict):
        raise ValueError(f"Invalid locale JSON: {path}")
    return {str(k): str(v) for k, v in data.items()}


def patch_description(skill_md: Path, description: str) -> None:
    text = skill_md.read_text(encoding="utf-8")
    if not text.startswith("---"):
        raise ValueError(f"Missing YAML frontmatter: {skill_md}")

    parts = text.split("---", 2)
    if len(parts) < 3:
        raise ValueError(f"Invalid frontmatter: {skill_md}")

    front = parts[1]
    body = parts[2]

    folded = "\n".join(
        "  " + line if line else ""
        for line in description.replace("\r\n", "\n").split("\n")
    )
    new_desc = f"description: >\n{folded}\n"

    if re.search(r"^description:\s", front, flags=re.MULTILINE):
        front = re.sub(
            r"^description:\s(?:>|\|)?(?:\n(?:  .*\n|\s.*\n)*)?",
            new_desc,
            front,
            count=1,
            flags=re.MULTILINE,
        )
    else:
        front = front.rstrip("\n") + "\n" + new_desc

    skill_md.write_text(f"---{front}---{body}", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Apply Solo Squad skill locale")
    parser.add_argument("skill_dir", type=Path, help="Installed skill directory")
    parser.add_argument("--lang", choices=("id", "en"), required=True)
    parser.add_argument(
        "--locale-dir",
        type=Path,
        default=None,
        help="Path to locales/ (default: repo locales next to scripts/)",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent.parent
    locale_dir = args.locale_dir or (repo_root / "locales")
    skill_name = args.skill_dir.name

    descriptions = load_descriptions(locale_dir, args.lang)
    if skill_name not in descriptions:
        print(f"skip: no description for {skill_name}", file=sys.stderr)
        return 0

    skill_md = args.skill_dir / "SKILL.md"
    if not skill_md.is_file():
        print(f"error: missing {skill_md}", file=sys.stderr)
        return 1

    patch_description(skill_md, descriptions[skill_name])
    print(f"locale {args.lang}: {skill_name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
