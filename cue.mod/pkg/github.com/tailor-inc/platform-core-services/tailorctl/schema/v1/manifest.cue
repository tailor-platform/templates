package manifest

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:common"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/gateway/v1:gatewayv1"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/workflow/v1:workflowv1"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/stateflow/v1:stateflowv1"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/directory/v1:directoryv1"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/ruleengine/v1:ruleenginev1"
)

#KindTailorDB:  "tailordb"
#KindGateway:   "gateway"
#KindPipeline:  "pipeline"
#KindWorkflow:  "workflow"
#KindStateFlow: "stateflow"
#KindDirectory: "directory"
#KindRuleEngineRule: "ruleenginerule"
#KindRuleEngineFunction: "ruleenginefunction"
#KindDirectorySeed: "directoryseed"
#KindGraphqlSeed: "graphqlseed"

#SpecTailorDB: {
	namespace: tailordbv1.#Namespace
	manifests: [...tailordbv1.#Manifest]
}

#SpecGateway: gatewayv1.#Domain

#SpecPipeline: {
	namespace: pipelinev1.#Namespace
	manifest:  pipelinev1.#Manifests
}

#SpecWorkflow: workflowv1.#Activation
#SpecStateFlow: stateflowv1.#Namespace

#SpecDirectory: {
	id: common.#UUID
}

#SpecDirectorySeed: {
	id: common.#UUID
	roleClasses?: [...directoryv1.#RoleClass]
	policies?: [...directoryv1.#Policy]
	roles?: [...directoryv1.#Role]
	groups?: [...directoryv1.#Group]
	userTypes?: [...directoryv1.#UserType]
	users?: [...directoryv1.#User]
}

#SpecRuleEngineRule: ruleenginev1.#Rule
#SpecRuleEngineFunction: ruleenginev1.#Function

#SpecGraphqlSeed: {
	mutations: [...common.#GraphqlMutationSdl]
}

#TailorManifest: {
	version: "v1"
	kind:    #KindTailorDB | #KindGateway | #KindPipeline | #KindWorkflow | #KindStateFlow | #KindDirectory | #KindRuleEngineRule | #KindRuleEngineFunction | #KindDirectorySeed | #KindGraphqlSeed
	spec:    [
		if kind == #KindTailorDB { #SpecTailorDB },
		if kind == #KindGateway { #SpecGateway },
		if kind == #KindPipeline { #SpecPipeline },
		if kind == #KindWorkflow { #SpecWorkflow },
		if kind == #KindStateFlow { #SpecStateFlow },
		if kind == #KindDirectory { #SpecDirectory },
		if kind == #KindRuleEngineRule { #SpecRuleEngineRule },
		if kind == #KindRuleEngineFunction { #SpecRuleEngineFunction },
		if kind == #KindDirectorySeed { #SpecDirectorySeed },
		if kind == #KindGraphqlSeed { #SpecGraphqlSeed },
	][0]
}
