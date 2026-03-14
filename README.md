# chatty

Chatty Backend experimentation

## Requirements

- Docker (recent stable version)
- GNU Make

## Run the app

```bash
# Build the image chatty-backend:latest
make build

# Run the local server on http://localhost:8000
make run

# To see lovely docs in your browser:
# http://localhost:8000/docs
```

## Run tests

```bash
# Unit tests
make test-unit

# REST + Socket.IO smoke tests
make test-smoke

# Run all tests
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
