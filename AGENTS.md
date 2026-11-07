# AGENTS.md – Python project template

Guidance for agents working in this repository.

## Overview

Standalone Python 3.12 project with a reproducible local and CI baseline. There
is no package to install and no service to run.

## Commands

```powershell
python -m ruff check .
python -m ruff format --check .
python -m pyright
python -m pytest -q
```

Tool versions are pinned in `requirements-ci.txt`; ruff additionally enforces
`required-version` from `pyproject.toml`. A missing tool is a finding, not a
reason to skip a check. `pytest` exit code 5 means "no tests collected" and is
not a pass.

## Git hooks

`.githooks/` contains the canonical `commit-msg`, `pre-commit` and `pre-push`
hooks (gitleaks secret scan, privacy guard, test gate). Activate them once per
clone:

```powershell
pwsh -File .\scripts\enable-hooks.ps1
```

`pre-commit` runs the test gate only when a staged path matches the prefixes in
`.githooks/test-gate.conf`; `pre-push` always runs the full gate. The hook files
are pinned to LF in `.gitattributes` — a CRLF shebang makes them unusable.

## Style

- Python 3.12, PEP 8, ruff with Bugbear, isort and pyupgrade.
- Changes stay small and task-scoped; no mass reformatting.
- Public functions get type hints and a docstring that explains the why.

## Tests

- `tests/` holds the pytest suite; artifacts go to `tests/artifacts/` (ignored).
- Behaviour changes need a focused test with an observable result.
- Windows-specific behaviour (paths, process calls) is verified on Windows, not
  only on Linux.

## Security

- API credentials come from the environment only; never write them to files.
- Do not add telemetry or network calls that the documented workflow does not
  need.
