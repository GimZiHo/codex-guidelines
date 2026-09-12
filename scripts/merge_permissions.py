#!/usr/bin/env python3
"""settings.json의 permissions에 권한 템플릿의 규칙을 병합한다.

기존 규칙과 다른 설정 항목은 보존하고, 템플릿에 있는 규칙 중 아직
없는 것만 각 목록(allow/ask/deny) 끝에 추가한다. 덮어쓰기 전에는
기존 파일을 <파일명>.bak.<타임스탬프>로 백업한다.
"""

import datetime
import json
import sys
from pathlib import Path

RULE_KEYS = ("allow", "ask", "deny")


def load_json(path: Path) -> dict:
    if not path.exists():
        return {}
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def main() -> int:
    if len(sys.argv) != 3:
        print(f"사용법: {sys.argv[0]} <settings.json 경로> <권한 템플릿 경로>", file=sys.stderr)
        return 2

    settings_path = Path(sys.argv[1])
    template_path = Path(sys.argv[2])

    template = load_json(template_path)
    template_permissions = template.get("permissions", {})

    settings = load_json(settings_path)
    settings.setdefault("permissions", {})

    added = {key: [] for key in RULE_KEYS}
    for key in RULE_KEYS:
        template_rules = template_permissions.get(key, [])
        if not template_rules:
            continue
        current_rules = settings["permissions"].setdefault(key, [])
        for rule in template_rules:
            if rule not in current_rules:
                current_rules.append(rule)
                added[key].append(rule)

    if not any(added.values()):
        print("추가할 권한 규칙이 없습니다 (이미 병합됨).")
        return 0

    if settings_path.exists():
        timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
        backup_path = settings_path.with_name(f"{settings_path.name}.bak.{timestamp}")
        backup_path.write_text(settings_path.read_text(encoding="utf-8"), encoding="utf-8")
        print(f"기존 파일 백업: {backup_path}")

    settings_path.parent.mkdir(parents=True, exist_ok=True)
    settings_path.write_text(json.dumps(settings, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    for key in RULE_KEYS:
        for rule in added[key]:
            print(f"추가함 [{key}]: {rule}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
