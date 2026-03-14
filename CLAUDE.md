# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Guidelines:
- Use Python 3.11
- Prefer async functions
- Do not introduce new frameworks
- Keep dependencies minimal
- Use docker-compose for local development
- Run `make test-all` before finishing tasks

## Commands

All commands assume you are in the repo root unless otherwise noted.

### Build & Run (Docker)
```bash
make build          # Build Docker image chatty-backend:local
make run            # Build and run on http://localhost:8000
```

### Run locally (without Docker)
```bash
cd app
poetry install --with dev
poetry run python run.py   # Starts uvicorn with hot reload on port 8000
```

### Tests
```bash
make test-unit      # Unit tests (Poetry)
make test-smoke     # REST + Socket.IO smoke tests (requires running server)
make test-all       # Both

# Run a single test file
cd app && poetry run pytest tests/unit/test_users.py -W ignore

# Run a specific test
cd app && poetry run pytest tests/unit/test_users.py::test_create_user -W ignore
```

Tests live outside the app package at `/tests/`, not in `app/tests/`. The `pyproject.toml` `testpaths` is `["tests"]` but tests are run via `cd app && poetry run pytest tests/...` which resolves relative to the `app/` directory.

API docs available at `http://localhost:8000/docs` when running.

## Architecture

This is a **FastAPI + Socket.IO** chat backend using SQLite (temporary/dev) and SQLAlchemy ORM.

### Key design patterns

- **`socketio_app`** (not `app`) is the ASGI entrypoint — it wraps the FastAPI `app` with the Socket.IO ASGI layer. `run.py` runs `chatty.main:socketio_app`.
- **Database resets on startup** — `main.py` drops and recreates all tables on every startup. This is intentional for the current experimental phase.
- The Socket.IO server (`sio`) is created in `main.py` and injected into the messages router via `messages.set_socketio_server(sio)`. When a message is POSTed via REST, the router emits a `new_message` Socket.IO event to the relevant chatroom room.
- **`BaseModel`** in `core/database.py` (not Pydantic's BaseModel) provides `id` (UUID string), `created_date`, and `last_updated_date` for all ORM models.

### Layer structure
- `models/` — SQLAlchemy ORM models (inherit from `core/database.py:BaseModel`)
- `schemas/` — Pydantic request/response models for OpenAPI
- `routers/` — FastAPI routers; each maps to a resource (`users`, `chatrooms`, `messages`, `chatroom_participants`)
- `core/` — database engine/session, structured logging (structlog), and request/error logging middleware

### Data model
`User` → sends → `Message` (in a `Chatroom`)
`ChatroomParticipant` — join table linking `User` ↔ `Chatroom`
`Message` supports threaded replies via `is_reply` + `parent_message_id` (self-referential FK)

### Code style (from `.cursor_rules`)
- Python: PEP 8, 88-char line length, double quotes, trailing commas
- Imports: stdlib → third-party → local
- All endpoints: `async def`, Pydantic request/response models, type hints required
- Routes: lowercase snake_case (e.g. `/chatroom-participants/{id}`)
- Docstrings: Google style (not required but preferred)

## Observability

- `/metrics` — Prometheus endpoint (via `prometheus_fastapi_instrumentator`): request latency, count, error rate, request/response size
- Custom Socket.IO metrics in `core/metrics.py` exposed through the same `/metrics` endpoint
- `prometheus/prometheus.yml` — scrapes the backend at `chatty-backend:8000`
- `grafana/provisioning/` — auto-provisions Prometheus datasource and dashboard loader
- `grafana/dashboards/` — dashboard JSON files (FastAPI + Socket.IO)

`make run` starts the full stack via `docker compose up --build`: backend on :8000, Prometheus on :9090, Grafana on :3000 (admin/admin).

## Directory conventions
- `.github/` — GitHub Actions and workflows
- `terraform/` — infrastructure as code
- `app/` — all application code
- `tests/` — test files
- `prometheus/` — Prometheus configuration
- `grafana/` — Grafana dashboards and provisioning
