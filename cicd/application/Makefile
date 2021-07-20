.PHONY: build-image push-image helm kustomize native

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
	docker run --rm -i -v ${PWD}/.hadolint.yaml:/.config/hadolint.yaml hadolint/hadolint < Dockerfile;

shellcheck:
	@echo "---------shell check----------"
	shellcheck entrypoint.sh

test: shellcheck docker-lint yaml-lint


native:
	@echo "---------kubectl yaml check -----------"
	kubectl --dry-run=server apply -f yamls/

helm:
	@echo "---------helm yaml check -----------"
	helm install --dry-run --debug test helm
	helm template helm | kubectl apply --dry-run=server -f -

kustomize:
	@echo "---------kustomize yaml check -----------"
	@echo "--------- base -----------"
	kubectl --dry-run=server apply -k kustomize/base/
	@echo "--------- production -----------"
	kubectl --dry-run=server apply -k kustomize/overlays/production/
	@echo "--------- staging -----------"
	kubectl --dry-run=server apply -k kustomize/overlays/staging/

k8s-yaml: native helm kustomize

bats:
	@echo "---------bats check-----------"
	sudo TYPE=${TYPE} bats -t tests/test.bats

k8s-test: k8s-yaml  bats
