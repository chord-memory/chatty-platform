IMAGE_NAME ?= chatty-backend

.PHONY: build run test-unit test-smoke test-all

build:
	docker build -t $(IMAGE_NAME):local .

run: build
	docker run --rm -p 8000:8000 $(IMAGE_NAME)

test-unit:
	cd app && poetry install --with dev && poetry run pytest tests/unit -W ignore

test-smoke:
	cd app && poetry install --with dev && poetry run pytest tests/smoke -W ignore

test-all: test-unit test-smoke