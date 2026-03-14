IMAGE_NAME ?= chatty-backend
TEST_IMAGE_NAME ?= chatty-backend-test

.PHONY: build run test-build test-unit test-smoke test-all

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker compose up --build

test-build:
	docker build -t $(TEST_IMAGE_NAME) -f Dockerfile.test .

test-unit: test-build
	docker run --rm -e TEST_TARGET=tests/unit $(TEST_IMAGE_NAME)

test-smoke: test-build
	docker run --rm -e TEST_TARGET=tests/smoke $(TEST_IMAGE_NAME)

test-all: test-build
	docker run --rm -e TEST_TARGET=tests $(TEST_IMAGE_NAME)
