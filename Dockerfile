### Build stage: install deps and create project-local venv
FROM python:3.11-slim AS build

ARG POETRY_VERSION=2.2.0

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VERSION=${POETRY_VERSION} \
    POETRY_VIRTUALENVS_IN_PROJECT=true

RUN pip install --no-cache-dir "poetry==${POETRY_VERSION}"

WORKDIR /app

# Install dependencies first (better Docker layer caching)
COPY pyproject.toml poetry.lock ./

RUN poetry install --no-root --only main


### Runtime stage: slim image with only Python, deps and app
FROM python:3.11-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/src

WORKDIR /app

# Copy virtualenv from build image
COPY --from=build /app/.venv /app/.venv

# Copy application source from build context
COPY app/ .

EXPOSE 8000

# Run the ASGI app using the project virtualenv
CMD ["/app/.venv/bin/python", "run.py"]