package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"github.com/tailor-platform/tailorctl/schema/v2/workload"
)

#Spec: {
	common.#WithKind
	common.#WithVersion
	common.#WithNamespace

	kind:        common.#Pipeline
	description: string | *""
	resolvers: [...#Resolver]
}

#Resolver: {
	name:        string & !=""
	description: string | *""
	inputs: [...#Field]
	response?:      #ResponseField
	operationType?: "query" | "mutation"
	authorization:  string & !=""
	preScript?:     string
	postScript?:    string
	pipelines: [...#Pipeline]
	invoker?: common.#UUID
	onError?: string
}

#OperationTypeGraphql:  "graphql"
#OperationTypeWorkload: "workload"

#GraphqlOperation: {
	kind:  #OperationTypeGraphql
	url:   string | *null
	query: string & !=""
}

#WorkloadOperation: {
	kind:         #OperationTypeWorkload
	workloadType: workload.#WorkloadType
	workloadName: string & !=""
}

#Operation: #WorkloadOperation | #GraphqlOperation

#Pipeline: {
	name:        string & !=""
	description: string | *""
	operation?:  [
			if (operation).kind == #OperationTypeGraphql {#GraphqlOperation},
			if (operation).kind == #OperationTypeWorkload {#WorkloadOperation},
	][0]
	operationType: 0 | 1 | 2 | *0

	if operation != _|_ {
		if (operation).kind == #OperationTypeGraphql {
			operationType:   1
			operationUrl:    operation.url
			operationSource: operation.query
		}
		if (operation).kind == #OperationTypeWorkload {
			operationType:         2
			operationSource:       operation.workloadName
			operationWorkloadType: operation.workloadType
		}
	}
	skipOperationOnError: bool | *false

	test?:           string
	preValidation?:  string
	preScript?:      string
	postScript?:     string
	postValidation?: string
	contextData?:    string
	forEach?:        string
}

#Field: {
	name:     string & !=""
	type:     #Type
	array:    bool | *false
	required: bool | *false
}

#ResponseField: {
	type:     #Type
	array:    bool | *false
	required: bool | *false
}

#Type: {
	kind:     string | *"UserDefined"
	name:     string & !=""
	required: bool | *false
	values?: [...string]
	fields?: [...#Field]
}
