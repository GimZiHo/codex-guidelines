# codex-guidelines

여러 프로젝트에서 사용하는 개인 Codex 전역 지침을 관리합니다.

- `AGENTS.md`: 모든 프로젝트에 적용할 공통 작업 원칙
- [공통 도구 환경](docs/tool-environment.md): PDF 도구의 재사용 경로, 설치 목록과 복구 방법
- 각 프로젝트의 `AGENTS.md`: 해당 프로젝트만의 작업 규칙으로, 이 저장소와 독립적으로 관리

## 설치

이 저장소를 `~/projects/codex-guidelines`에 복제한 후 기본 Codex 홈에 연결합니다.

```bash
mkdir -p ~/.codex
ln -s ~/projects/codex-guidelines/AGENTS.md ~/.codex/AGENTS.md
```

기존 `~/.codex/AGENTS.md`가 있다면 내용을 먼저 비교·병합하고 보존한 후 연결합니다. 위 명령은 기존 파일을 덮어쓰지 않습니다. `CODEX_HOME`을 별도로 사용하는 환경에서는 해당 디렉터리에 연결합니다. `AGENTS.override.md`가 있으면 전역 AGENTS.md보다 우선하므로 함께 확인합니다.

연결 후 새 Codex 세션에서 적용된 지침을 확인합니다. 프로젝트의 AGENTS.md를 이 파일에 연결할 필요는 없습니다.

## 관리

공통 지침은 이 저장소에서 수정하고 커밋·푸시합니다. 다른 컴퓨터에서는 이 저장소를 복제하고 위 연결을 한 번 설정한 뒤, 변경 사항을 pull하여 반영합니다.

프로젝트별 지침은 각 프로젝트 저장소에서 수정하고 커밋합니다. 이 저장소에는 대화 기록, 세션 원본, 인증 정보는 저장하지 않습니다.

참고: [Codex AGENTS.md 공식 문서](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
