FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VERSION=2.2.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "poetry==${POETRY_VERSION}"

WORKDIR /app

# Install dependencies first (better Docker layer caching)
COPY app/pyproject.toml ./

RUN poetry install --no-root --with dev

# Now copy the application source
COPY app/ .

EXPOSE 8000

# Run the ASGI app (Socket.IO + FastAPI) via the helper script
CMD ["poetry", "run", "python", "run.py"]