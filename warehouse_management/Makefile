GENERATED=generated
UUID:= $(shell uuidgen)
APP_NAME:=warehouse-management

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
