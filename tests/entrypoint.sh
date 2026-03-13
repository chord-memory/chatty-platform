#!/bin/sh
set -e

# Only start the app if not running unit tests
if [ "$TEST_TARGET" != "tests/unit" ]; then
    echo "Starting FastAPI app for $TEST_TARGET..."
    /app/.venv/bin/python run.py &

    # Wait up to 30s for health endpoint
    for i in $(seq 1 60); do
        if curl -sf http://localhost:8000/ >/dev/null; then
            echo "API is up!"
            break
        fi
        sleep 0.5
    done
fi

# Run pytest for the selected test target
echo "Running pytest for $TEST_TARGET..."
/app/.venv/bin/python -m pytest -W ignore "$TEST_TARGET"