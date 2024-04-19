GENERATED=generated
UUID:= $(shell uuidgen)

.PHONY: apply
apply: generate
	$(call _cue_vet)
	tailorctl workspace apply -m ${GENERATED}/workspace.cue

.PHONY: machine-token
machine-token:
	tailorctl workspace machineuser token -a poso -m admin-machine-user -f json

.PHONY: init
init:
	tailorctl auth login
	tailorctl workspace create --name poso -r asia-northeast

.PHONY: app
app:
	tailorctl workspace app open -n poso

.PHONY: seed
seed:
	node ../common/scripts/seed.mjs --ignore-existing

.PHONY: setup
setup:
	pnpm i
	$(call _install_deps)

.PHONY: generate
generate:
	tailorctl manifest tidy
	ex +'sil! %s/{{UUID}}/'${UUID}'/g' -cwq environment/env.cue
	cue eval -f  manifest/workspace.cue -o ${GENERATED}/workspace.cue

.PHONY: vet
vet:
	$(call _cue_vet)

define _cue_vet
	cue vet  -c ./manifest/workspace.cue
endef

define _install_deps
	brew install coreutils yq cue gh tailor-platform/tap/tailorctl
endef
