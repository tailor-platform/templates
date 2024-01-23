package workload

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

#WorkloadTypeWasm:    "wasm"
#WorkloadTypePython:  "python"
#WorkloadTypeRuby:    "ruby"

#WorkloadType: #WorkloadTypeWasm| #WorkloadTypePython | #WorkloadTypeRuby

#Spec: {
	common.#WithVersion
	common.#WithNamespace
	common.#WithKind

	kind: common.#Workload
	workloads: [...#Workload]
}

#Workload: {
	name: string
	description: string
	type: #WorkloadType
	source: string
}
