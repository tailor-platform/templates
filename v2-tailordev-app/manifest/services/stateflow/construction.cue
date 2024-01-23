package stateflow

import (
	"github.com/tailor-platform/tailorctl/schema/v2/stateflow"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/seed"
)

stateflow.#Spec & {
	namespace: "construction"
	admins: [seed.Roles.BountyHunter.id]
}
