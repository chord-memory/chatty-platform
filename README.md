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

## Project Status

### Completed

- Dockerize (app & test runtimes)
- Makefile (for local & GitHub use)
- OpenAPI spec generation
- Observability pipeline (Prometheus + Grafana + docker-compose, FastAPI & Socket.IO metrics, dashboards)

### In Progress (EC2 production POC)

- IaC (Terraform: VPC, EC2, EBS, S3, IAM, Parameter Store, Elastic IP)
- GitHub CI/CD (PR: test-all + plan; deploy: build, push ECR, terraform apply via OIDC)
- GitHub restrictions (branch protection, require PRs & status checks via Terraform)
- Auth (API_KEY for app; basic auth for Prometheus; Grafana admin from secrets)
- CORS approach (local vs prod)
- Secrets management (Parameter Store in prod, .env locally)
- Caddy reverse proxy (HTTPS, /api, /grafana, /prometheus)
- Traffic generation script to validate (`generate_traffic.py` for local/prod)
- CloudWatch logs for prod containers

### To Do

- Add a DB migration tool (e.g. Alembic) for schema changes
- Migrate from SQLite to managed RDS for persistence
- Auto-scaling and load balancing
- Rolling deployments (zero-downtime releases)
- Cloud cost visibility and overview
- Operational alerting on API metrics, infrastructure health, and deployment failures (thresholds + notifications)
- User-based auth for the app (e.g. for a future frontend; current API_KEY header is service-level only)
- API versioning (e.g. /api/v1/...) for backward-compatible changes
- Client for the API (browser app, native app, or CLI — TBD)