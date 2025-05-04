
IMAGE_NAME:=hadolint-action
YAMLLINT_VERSION:=0.34.0
HADOLINT_VERSION:=1.19.3
lint-dockerfile: ## Runs hadolint against application dockerfile
	@docker run --rm -v "$(PWD):/data" -w "/data" hadolint/hadolint hadolint Dockerfile

lint-yaml: ## Lints yaml configurations
	@docker run --rm -v "$(PWD):/yaml" pipelinecomponents/yamllint:$(YAMLLINT_VERSION) yamllint .

build: ## Builds the docker image
	@docker build . -t $(IMAGE_NAME)

test: build ## Runs a test in the image
	@docker run -i --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${PWD}:/test ghcr.io/googlecontainertools/container-structure-test:$(HADOLINT_VERSION) \
    test \
    --image $(IMAGE_NAME) \
    --config test/structure-tests.yaml

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := help
.PHONY: lint build test help
