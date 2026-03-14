# chatty

Chatty Backend experimentation

## Requirements

- Docker (recent stable version)
- GNU Make

## Run the app

```bash
# Start the full local environment (backend + Prometheus + Grafana)
make run
```

| Service    | URL                          |
|------------|------------------------------|
| Backend    | http://localhost:8000        |
| API docs   | http://localhost:8000/docs   |
| Prometheus | http://localhost:9090        |
| Grafana    | http://localhost:3000        |

Grafana default login: **admin / admin**

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
