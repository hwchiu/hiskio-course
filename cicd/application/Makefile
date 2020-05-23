PHONY: build-image push-image

SERVER  =
REPO    ?=hwchiu/cicd-app
COMMIT  =${shell git rev-parse --short HEAD}
LOG     ="${shell git log -1 --pretty=%B}"
VERSION ?=${COMMIT}
TYPE    ?=KIND

build-image:
	docker build --build-arg HASH=${COMMIT} --build-arg LOG=${LOG} --tag ${SERVER}${REPO}:${VERSION} .
	docker image tag ${SERVER}${REPO}:${VERSION} ${SERVER}${REPO}:latest

push-image: build-image
	docker image push ${SERVER}${REPO}:${VERSION}
	docker image push ${SERVER}${REPO}:latest

yaml-lint:
	@echo "---------yamllint----------"
	yamllint yamls/
	yamllint kustomize/

docker-lint:
	@echo "---------docker lint----------"
	docker run --rm -i hadolint/hadolint < Dockerfile;

shellcheck:
	@echo "---------shell check----------"
	shellcheck entrypoint.sh

test: shellcheck docker-lint yaml-lint


k8s-yaml:
	@echo "---------kubectl dry-run -----------"
	kubectl --dry-run=server apply -f yamls/
bats:
	@echo "---------bats check-----------"
	sudo TYPE=${TYPE} bats -t tests/test.bats

k8s-test: bats k8s-yaml
