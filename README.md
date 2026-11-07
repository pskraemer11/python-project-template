# Python project template

Reproducible Python 3.12 baseline for new repositories: ruff, pyright, pytest,
pip-audit, GitHub Actions, local Git hooks and the shared permission-guard
workflow.

## Quick start

1. Create a repository from this template (GitHub **Use this template**).
2. Rename `src/starter_app` and adjust `pyproject.toml`, `README.md` and
   `AGENTS.md` for the new project.
3. Install the pinned tools and run the checks:

   ```powershell
   python -m pip install -r requirements-ci.txt
   python -m ruff check .
   python -m ruff format --check .
   python -m pyright
   python -m pytest -q
   ```

4. Activate the local hooks once per clone:

   ```powershell
   pwsh -File .\scripts\enable-hooks.ps1
   ```

5. Push and confirm the four checks: `tests`, `actionlint`, `hook-regeln` and
   `permission-guard`.

## What is included

| Path                              | Purpose                                                         |
| --------------------------------- | --------------------------------------------------------------- |
| `pyproject.toml`                  | Ruff, pytest and pyright configuration                          |
| `requirements-ci.txt`             | Pinned check tools (ruff, pytest, pyright, pip-audit)           |
| `src/starter_app/`                | Minimal package; rename it for the new project                  |
| `tests/test_smoke.py`             | Smoke test; replace it with real tests                          |
| `.github/workflows/tests.yml`     | Lint, formatting, types, audit and tests on Ubuntu and Windows  |
| `.github/workflows/actionlint.yml` | Static check of the workflow files                              |
| `.github/workflows/hook-regeln.yml` | Secret and privacy scan for the push/PR range                  |
| `.github/workflows/permission-guard.yml` | Reusable permission-guard test suite                     |
| `.github/dependabot.yml`          | Weekly pip and GitHub Actions updates                           |
| `.githooks/`                      | commit-msg, pre-commit, pre-push and the test gate              |
| `scripts/enable-hooks.ps1`        | Sets `core.hooksPath` for the current clone                     |
| `tools/githooks-test/testrun.sh`  | Five behaviour probes for the pre-push hook                     |

## Local hooks

The hooks are not active by default; `core.hooksPath` is local Git
configuration. Run `scripts/enable-hooks.ps1` once per clone. `pre-commit`
checks staged changes (gitleaks, privacy guard) and runs the test gate when a
path matches `.githooks/test-gate.conf`; `pre-push` always runs the full gate.

The hook files are pinned to LF in `.gitattributes`; a CRLF shebang makes them
unusable.

## CI

The workflow set is the same baseline used in the other repositories:

- `tests`: ruff check, ruff format check, pyright, pip-audit, pytest.
- `actionlint`: checks `.github/workflows` for expression and context errors.
- `hook-regeln`: runs the same `.githooks/pre-push` used locally.
- `permission-guard`: calls the public reusable workflow
  `pskraemer11/permission-guard/.github/workflows/guard.yml@main`.

GitHub rulesets should require these four checks before merging and enable
secret scanning with push protection.

## License

MIT; see [LICENSE](LICENSE).
