# chatty
Chatty Backend experimentation

## Local Setup (Docker-based)

```bash
# Build the image (installs Python 3.11 + Poetry + deps inside the image)
make build

# Run the local server on http://localhost:8000
make run

# To see lovely docs in your browser:
# http://localhost:8000/docs
```

## Testing (via Docker)

```bash
# Unit / integration tests (pytest under Docker)
make test

# REST + Socket.IO smoke tests
make test-smoke

# Run all of the above
make test-all
```

# To Do / To Discuss:
- dockerize
- basic github actions
- OpenAPI spec generation
- CORS approach
- infra as code approach, incl implied terraform dependency graph
- CI/CD approach
- auth/authz approach
- db migration instrumentation
- config / env var management
- exposing service to front-end layer
- auto scaling, load testing, etc..
- cloud spend management
- general SDLC at this stage of maturity
