# codex-guidelines

여러 프로젝트에서 사용하는 개인 Codex와 Claude Code 지침을 관리합니다.

- [AGENTS.md](AGENTS.md): Codex의 학습 중심 작업 관리 원칙
- [CLAUDE.md](CLAUDE.md): Claude Code의 구현·검증·의사결정 요청 규칙
- [공통 도구 환경](docs/tool-environment.md): PDF 도구의 재사용 경로, 설치 목록과 복구 방법
- [scripts/setup.sh](scripts/setup.sh): 전역 지침 연결과 권한 템플릿 병합을 자동화하는 스크립트
- 각 프로젝트의 `AGENTS.md`: 해당 프로젝트만의 작업 규칙으로, 이 저장소와 독립적으로 관리

## 설치

이 저장소를 `~/projects/codex-guidelines`에 복제한 후 아래 스크립트로 전역 연결과 권한 병합을 한 번에 처리합니다.

```bash
~/projects/codex-guidelines/scripts/setup.sh
```

이 스크립트는 다음을 수행합니다.

- `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md`를 이 저장소의 파일에 연결합니다. 대상 경로에 파일이 이미 있거나 다른 곳을 가리키는 심볼릭 링크가 있으면 덮어쓰지 않고 건너뛰며, 직접 비교·병합하도록 안내만 출력합니다.
- [권한 템플릿](config/claude-permissions.json)의 규칙을 `~/.claude/settings.json`에 병합합니다. 기존 설정 항목과 이미 있는 규칙은 그대로 두고, 템플릿에만 있는 규칙만 추가합니다. 실제로 변경할 내용이 있을 때만 원본을 `settings.json.bak.<시각>`으로 백업한 뒤 씁니다.

`CODEX_HOME`, `CLAUDE_CONFIG_DIR` 환경변수로 기본 경로(`~/.codex`, `~/.claude`)를 다른 컴퓨터의 실제 경로에 맞게 조정할 수 있습니다. `AGENTS.override.md`가 있으면 전역 AGENTS.md보다 우선하므로 별도로 확인합니다.

수동으로 연결하려면 아래처럼 각 파일을 개별 `ln -s`로 연결할 수도 있습니다.

```bash
mkdir -p ~/.codex ~/.claude
ln -s ~/projects/codex-guidelines/AGENTS.md ~/.codex/AGENTS.md
ln -s ~/projects/codex-guidelines/CLAUDE.md ~/.claude/CLAUDE.md
```

연결 후 새 Codex 세션과 Claude Code 세션(`/context`)에서 적용된 지침을 확인합니다. 프로젝트의 AGENTS.md를 이 파일에 연결할 필요는 없습니다.

## Claude Code 연결

Claude Code는 구현과 검증을, Codex는 작업 설계·검토·학습 문서 관리를 담당합니다. 두 전역 지침은 각각 관리하며 전체 내용을 서로 가져오지 않습니다.

이 연결은 지침을 공유하는 설정입니다. Codex의 Claude 자동 호출이나 질문 전달 기능을 설치하지는 않습니다. 현재는 작업 전달자가 지시와 결정을 전달하고, 구현 결과는 Git diff와 간단한 검증 보고로 확인합니다.

Codex가 Claude에게 구현을 위임할 때는 Claude가 직접 git을 다루지 않고, Codex가 결과를 검토한 뒤 커밋합니다. 위임 대상이 아닌 변경과 섞이지 않도록 작업트리를 확인·격리하는 절차는 [AGENTS.md](AGENTS.md)의 "Claude 위임 작업 격리"에서 관리합니다.

참고: [Claude Code 지침 공식 문서](https://code.claude.com/docs/en/memory)

사용자 권한은 [권한 설정 안내](docs/claude-permissions.md)와 [권한 템플릿](config/claude-permissions.json)에서 관리합니다. 이 템플릿은 기존 `~/.claude/settings.json`에 병합하며, 심볼릭 링크로 전체 설정을 대체하지 않습니다.

## 관리

공통 지침은 이 저장소에서 수정하고 커밋·푸시합니다. 다른 컴퓨터에서는 이 저장소를 복제하고 위 연결을 한 번 설정한 뒤, 변경 사항을 pull하여 반영합니다.

프로젝트별 지침은 각 프로젝트 저장소에서 수정하고 커밋합니다. 이 저장소에는 대화 기록, 세션 원본, 인증 정보는 저장하지 않습니다.

참고: [Codex AGENTS.md 공식 문서](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
