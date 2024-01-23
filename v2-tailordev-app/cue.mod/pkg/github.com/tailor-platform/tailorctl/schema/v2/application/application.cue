package application

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

#Spec: {
	common.#WithKind
	common.#WithVersion

	kind: common.#Application
	name: string & !=""
	cors: [...string]
	auth?: #Auth
	subgraphs: [...#Subgraph]
}

#Auth: {
	namespace:            string & !=""
	idProviderConfigName: string & !=""
}

#Subgraph: {
	type: common.#SubgraphType & !=""
	name: string & !=""
}
