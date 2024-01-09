MINITAILOR=docker-compose exec minitailor /root/app
TOKEN:=$(shell ./scripts/login)
GENERATED=charts
ENV?=local


.PHONY: apply
apply: generate/local-config
	$(call _run-containers)
	@${MINITAILOR} init
	# ${MINITAILOR} import -m /root/crm/charts/directory.cue
	${MINITAILOR} apply -m /root/crm/charts

.PHONY: import
import: generate/local-config
	@${MINITAILOR} import -m ./charts/seed/seed.cue -T http://localhost:8000/query

.PHONY: generate/local-config
generate/local-config:
	CUE_PACKAGE=tailor.build/crm tailorctl template generate -t ./template -o ./charts -f ./values.local.yaml

.PHONY: generate
generate:
	@tailorctl cue sync
	@mkdir -p ${GENERATED}
	cue eval -f -t ${ENV} template/gateway.cue -o ${GENERATED}/gateway.cue
	cue eval -f -t ${ENV} template/pipelines.cue -o ${GENERATED}/pipelines.cue
	cue eval -f -t ${ENV} template/tailordb.cue -o ${GENERATED}/tailordb.cue
	cue eval -f -t ${ENV} template/stateflow.cue -o ${GENERATED}/stateflow.cue


.PHONY: setup
setup:
	$(call _install_deps)

.PHONY: logs
logs:
	@tail -f ./minitailor.log | jq -R 'if test("\\{.*\\}"; "g") then (match("\\{.*\\}"; "g").string | fromjson) else {"message": .} end'

.PHONY: logs/error
logs/error:
	@tail -f ./minitailor.log | jq -R 'if test("\\{.*\\}"; "g") then (match("\\{.*\\}"; "g").string | fromjson) else {"message": .} end | select(.severity | test("ERROR|WARN"))?'

.PHONY: logs/raw
logs/raw:
	@tail -f ./minitailor.log

.PHONY: reset
reset:
	docker-compose down --volumes --remove-orphans
	rm -rf db/mongodb
	rm -rf db/postgres
	rm -rf charts
	rm -rf minitailor.log


.PHONY: cue/vet
cue/vet:
	@cd template
	@find ./charts -name '*.cue' -type f -maxdepth 3 -exec sh -c "echo 'cue vet {}'; cue vet -c {}" \;

.PHONY: cue/fmt
cue/fmt:
	@cd template
	@cue fmt ./...

define _install_deps
	brew install coreutils yq cue gh jq tailor-platform/tap/tailorctl
endef

define _run-containers
	@docker-compose up -d
	@mkdir -p tmp
	@curl -L --output ./tmp/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
	@chmod +x ./tmp/wait-for-it.sh
	@./tmp/wait-for-it.sh localhost:35432
	@./tmp/wait-for-it.sh localhost:27017
	@sleep 1
endef
