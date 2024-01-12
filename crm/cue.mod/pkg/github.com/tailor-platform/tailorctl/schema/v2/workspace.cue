package v2

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"github.com/tailor-platform/tailorctl/schema/v2/application"
	"github.com/tailor-platform/tailorctl/schema/v2/auth"
	"github.com/tailor-platform/tailorctl/schema/v2/connector"
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/ruleengine"
	"github.com/tailor-platform/tailorctl/schema/v2/stateflow"
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

#Workspace: {
	common.#WithKind
	kind: common.#KindWorkspace

	apps: [...application.#Spec]
	services: [...(auth.#Spec | connector.#Spec | pipeline.#Spec | ruleengine.#Spec | stateflow.#Spec | tailordb.#Spec)]

	auths: [ for x in services if x.kind == common.#Auth {x}]
	connectors: [ for x in services if x.kind == common.#Connector {x}]
	pipelines: [ for x in services if x.kind == common.#Pipeline {x}]
	ruleengines: [ for x in services if x.kind == common.#RuleEngine {x}]
	stateflows: [ for x in services if x.kind == common.#Stateflow {x}]
	tailordbs: [ for x in services if x.kind == common.#TailorDB {x}]
}
