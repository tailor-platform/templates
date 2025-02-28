UUID:= $(shell uuidgen)
APP_NAME:=omakase-mo-ims

.PHONY: apply
apply:
	$(call _cue_vet)
	tailorctl workspace apply -m ./workspace.cue

.PHONY: machine-token
machine-token:
	tailorctl workspace machineuser token -a ${APP_NAME} -m admin-machine-user -f json

.PHONY: init
init:
	tailorctl manifest tidy
	ex +'sil! %s/{{UUID}}/'${UUID}'/g' -cwq environment/env.cue
	pnpm i

.PHONY: app
app:
	tailorctl workspace app open -n ${APP_NAME}

.PHONY: seed
seed:
	node ../common/scripts/seed.mjs --ignore-existing

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
	$(call _install_deps)

.PHONY: vet
vet:
	$(call _cue_vet)


define _cue_vet
	cue vet  -c ./workspace.cue
endef

define _install_deps
	brew install coreutils yq cue gh tailor-platform/tap/tailorctl
endef
