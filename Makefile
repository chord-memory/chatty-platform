IMAGE_NAME ?= chatty-backend

.PHONY: build run test test-smoke test-all

build:
	docker build -t $(IMAGE_NAME) .

run: build
	docker run --rm -p 8000:8000 $(IMAGE_NAME)

test: build
	docker run --rm $(IMAGE_NAME) poetry run pytest -W ignore

test-smoke: build
	# Start the app inside the container, wait for it to be ready, then run smoke tests
	docker run --rm $(IMAGE_NAME) bash -c "poetry run python run.py & sleep 5 && poetry run pytest tests_smoke/smoke_test.py tests_smoke/smoke_socketio.py"

test-all: test test-smoke