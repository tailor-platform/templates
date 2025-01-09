MINITAILOR=docker compose exec -T minitailor minitailor
ENV?=dev
UUID:= $(shell uuidgen)
APP_NAME:=omakase-mo-ims

ifeq ($(ENV), local)
	export
	APP_HTTP_SCHEMA := http
	PLATFORM_URL := http://mini.tailor.tech:18090
	TAILOR_TOKEN := tpp_11111111111111111111111111111111
endif

.PHONY: apply
apply:
	$(call _cue_vet)
	tailorctl workspace apply -m ./workspace.cue -e $(ENV) -a

.PHONY: machine-token
machine-token:
	tailorctl workspace machineuser token -a ${APP_NAME}-$(ENV) -m admin-machine-user -f json

.PHONY: init
ifeq ($(ENV), local)
init:
	docker compose up -d
	tailorctl workspace create -r local --name ${APP_NAME}-${ENV}
	tailorctl manifest tidy
	ex +'sil! %s/{{UUID}}/'${UUID}'/g' -cwq environment/env.cue
else
init:
	tailorctl manifest tidy
	ex +'sil! %s/{{UUID}}/'${UUID}'/g' -cwq environment/env.cue
endif

.PHONY: app
app:
	tailorctl workspace app open -n ${APP_NAME}-${ENV}

.PHONY: reset
ifeq ($(ENV), local)
reset:
	docker compose down --volumes --remove-orphans
	rm -rf minitailor.log
else
reset:
endif

.PHONY: seed
seed:
	node ./seed.mjs  --ignore-existing

.PHONY: truncate
truncate:
	cue eval -t dev -c ./services/tailordb/tailordb.cue --out json | jq -r ".Types | map(.Name)[]" | xargs -I % tailorctl workspace service tailordb truncate -n ${APP_NAME}-${ENV} -t % -a

.PHONY: demo
demo:
	# Sync data from Shopify to Tailor
	curl -X POST https://eorml91yyckm67.m.pipedream.net
	# Generate demo orders in ShipStation
	# curl -d '{"test": "event"}' -H "Content-Type: application/json" https://eodwqfyoj7n88n1.m.pipedream.net
	# IMS
	node ./seed_demo.mjs --ignore-existing
	# MO
	# node ./seed.mjs --ignore-existing

.PHONY: setup
setup:
	pnpm i
	$(call _install_deps)

.PHONY: vet
vet:
	$(call _cue_vet)


define _cue_vet
	cue vet -t ${ENV} -c ./workspace.cue
endef

define _install_deps
	brew install coreutils yq cue gh tailor-platform/tap/tailorctl
endef


.PHONY: test
test:
	npm test $(shell pwd)/tests

.PHONY: gqlprint
gqlprint:
	rm -rf tmp/tailordb.json
	mkdir -p tmp
	cue eval -t dev ./services/tailordb/tailordb.cue -o tmp/tailordb.json
	npm run gqlprint -- --cue $(shell pwd)/tmp/tailordb.json --output $(shell pwd)/tmp/gqlouptut

.PHONY: generate-test-data
generate-test-data:
	node ../common/scripts/seed.mjs  --ignore-existing --generate-test-data=./tests/data --skip-prompts
