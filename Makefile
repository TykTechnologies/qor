# Makefile

.PHONY: build-portal run-binary

go-mod:
	@echo "Preparing Go mod files..."
	@go mod tidy -v
	@go mod download -x
	@echo "Go mod files completed."

.PHONY: lint-install lint

lint-install:
	 @if ! command -v golangci-lint >/dev/null 2>&1; then \
        echo "golangci-lint is not installed, installing..."; \
        curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(shell go env GOPATH)/bin v1.53.3; \
    else \
        echo "golangci-lint is already installed"; \
    fi


lint: lint-install
	@golangci-lint run --out-format checkstyle --timeout=300s --max-issues-per-linter=0 --max-same-issues=0 --issues-exit-code=0  --new-from-rev=origin/master

.PHONY: test
test:
	@echo "Running tests with coverage..."
	@./bin/ci-tests.sh


