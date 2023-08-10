package manifest

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:common"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/gateway/v1:gatewayv1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/workflow/v1:workflowv1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/stateflow/v1:stateflowv1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/authentication/v1:authenticationv1"
	"github.com/tailor-inc/platform-core-services/api/gen/go/ruleengine/v1:ruleenginev1"
)

#KindTailorDB:           "tailordb"
#KindGateway:            "gateway"
#KindPipeline:           "pipeline"
#KindWorkflow:           "workflow"
#KindStateFlow:          "stateflow"
#KindDirectory:          "directory"
#KindRuleEngineRule:     "ruleenginerule"
#KindRuleEngineFunction: "ruleenginefunction"
#KindAuthentication:     "authentication"
#KindDirectorySeed:      "directoryseed"
#KindGraphqlSeed:        "graphqlseed"

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

#SpecStateFlow: {
	namespace: stateflowv1.#Namespace
}

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

#SpecAuthentication: {
	namespace: authenticationv1.#Namespace
	attributes: [...authenticationv1.#Attribute]
}

#SpecRuleEngineRule:     ruleenginev1.#Rule
#SpecRuleEngineFunction: ruleenginev1.#Function

#ParallelNumber: >=0 & <=10
#SpecGraphqlSeed: {
	mutations: [...common.#GraphqlMutationSdl]
	parallel: #ParallelNumber | *1
}

#TailorManifest: {
	version: "v1"
	kind:    #KindTailorDB | #KindGateway | #KindPipeline | #KindWorkflow | #KindStateFlow | #KindDirectory | #KindRuleEngineRule | #KindRuleEngineFunction | #KindAuthentication | #KindDirectorySeed | #KindGraphqlSeed
	spec:    [
			if kind == #KindTailorDB {#SpecTailorDB},
			if kind == #KindGateway {#SpecGateway},
			if kind == #KindPipeline {#SpecPipeline},
			if kind == #KindWorkflow {#SpecWorkflow},
			if kind == #KindStateFlow {#SpecStateFlow},
			if kind == #KindDirectory {#SpecDirectory},
			if kind == #KindRuleEngineRule {#SpecRuleEngineRule},
			if kind == #KindRuleEngineFunction {#SpecRuleEngineFunction},
			if kind == #KindAuthentication {#SpecAuthentication},
			if kind == #KindDirectorySeed {#SpecDirectorySeed},
			if kind == #KindGraphqlSeed {#SpecGraphqlSeed},
	][0]
}
