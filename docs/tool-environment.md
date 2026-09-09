# 공통 작업 도구 환경

여러 프로젝트의 PDF 확인에 사용하는 Python 도구를 사용자 전용 가상환경에 설치한다. 프로젝트 자체의 실행 의존성은 각 프로젝트에서 관리한다.

## 설치된 도구

2026-09-09 기준:

| 도구 | 버전 | 용도 |
| --- | --- | --- |
| pypdf | 6.18.0 | PDF 페이지와 텍스트 읽기 |

환경 경로는 `~/.local/share/codex-tools/venv`이며, 설치 파일은 저장소에 포함하지 않는다. 버전은 [tool-requirements.txt](../config/tool-requirements.txt)에 기록한다.

## 기존 설치 확인

```bash
~/.local/share/codex-tools/venv/bin/python -m pip show pypdf
~/.local/share/codex-tools/venv/bin/python -m pip check
```

정상 동작하면 다시 설치하지 않는다. 다른 도구가 필요하면 먼저 `command -v <실행파일>`과 기존 환경을 확인한다.

## 새 컴퓨터에서 설치 또는 환경 복구

Python 3의 `venv` 기능이 있는 환경에서 다음 명령을 실행한다. 기존 환경이 정상이라면 실행할 필요가 없다.

```bash
python3 -m venv ~/.local/share/codex-tools/venv
~/.local/share/codex-tools/venv/bin/python -m pip install -r ~/projects/codex-guidelines/config/tool-requirements.txt
```

저장소 위치가 다르면 요구사항 파일 경로를 조정한다. 저장소를 복제하거나 pull하는 것만으로 도구가 설치되지는 않는다.

## PDF 읽기

과제 프로젝트의 루트에서 실행한다.

```bash
~/.local/share/codex-tools/venv/bin/python - <<'PY'
from pypdf import PdfReader

reader = PdfReader('docs/assignment-requirements.pdf')
for number, page in enumerate(reader.pages, start=1):
    print(f'--- {number}페이지 ---')
    print(page.extract_text() or '')
PY
```

이 명령은 텍스트 추출용이다. 스캔 이미지의 OCR이나 표·그림의 시각 확인은 별도 도구로 수행한다. 추가 도구가 필요해지면 기존 설치를 확인한 뒤 지속적인 설치 위치, 버전, 사용 방법을 이 문서에 기록한다.
