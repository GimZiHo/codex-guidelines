#!/usr/bin/env bash
# 이 저장소의 지침 파일을 Codex/Claude Code 전역 설정 경로에 연결하고,
# 권한 템플릿을 ~/.claude/settings.json에 병합한다.
#
# 기존 파일이나 다른 대상을 가리키는 심볼릭 링크는 덮어쓰지 않고 건너뛴다.
# CODEX_HOME, CLAUDE_CONFIG_DIR 환경변수로 기본 경로(~/.codex, ~/.claude)를
# 조정할 수 있다.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
CLAUDE_CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

link_guideline() {
  local target="$1" source="$2"
  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ]; then
    if [ "$(readlink "$target")" = "$source" ]; then
      echo "이미 연결됨: $target -> $source"
    else
      echo "건너뜀: $target 이(가) 다른 대상을 가리킵니다 ($(readlink "$target")). 직접 확인하세요."
    fi
    return
  fi

  if [ -e "$target" ]; then
    echo "건너뜀: $target 파일이 이미 존재합니다. 내용을 비교·병합한 뒤 필요하면 직접 연결하세요."
    return
  fi

  ln -s "$source" "$target"
  echo "연결함: $target -> $source"
}

echo "== 지침 파일 연결 =="
link_guideline "$CODEX_HOME/AGENTS.md" "$REPO_ROOT/AGENTS.md"
link_guideline "$CLAUDE_CONFIG_DIR/CLAUDE.md" "$REPO_ROOT/CLAUDE.md"

echo
echo "== 권한 템플릿 병합 =="
if command -v python3 >/dev/null 2>&1; then
  python3 "$REPO_ROOT/scripts/merge_permissions.py" \
    "$CLAUDE_CONFIG_DIR/settings.json" \
    "$REPO_ROOT/config/claude-permissions.json"
else
  echo "python3을 찾을 수 없어 권한 병합을 건너뜁니다."
  echo "$REPO_ROOT/config/claude-permissions.json 내용을 $CLAUDE_CONFIG_DIR/settings.json에 직접 병합하세요."
fi
