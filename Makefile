.PHONY: deps test build publish clean

venv: .venv
.venv:
	uv venv --allow-existing

deps: venv
	uv pip install -r pyproject.toml --extra dev

lint:
	uv run ruff check .

check: test
test: deps
	uv run pytest

build:
	uv build

publish: build
	uv publish
	uv run --with promclient_to_openapi --no-project -- python -c "import promclient_to_openapi"

clean:
	rm -rf .pytest_cache .ruff_cache .venv dist promclient_to_openapi.egg-info uv.lock
	find . -type d ! -name . -name __pycache__ -exec rm -r {} +
