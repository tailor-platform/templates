package stateflow

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

#Spec: {
	common.#WithVersion
	common.#WithNamespace
	common.#WithKind

	kind: common.#Stateflow
	admins: [...string]
}
