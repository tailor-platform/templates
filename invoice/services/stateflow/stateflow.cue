package stateflow

import (
	"github.com/tailor-platform/tailorctl/schema/v2/stateflow"
	"tailor.build/template/environment"
	role "tailor.build/template/seed/master"
)

stateflow.#Spec & {
	Namespace: environment.#app.namespace
	Admins: [role.#Roles.Admin.id]
}
