package settings

import (
	"tailor.build/template/environment"
)

adminInvoker: {
	AuthNamespace:   environment.#app.namespace
	MachineUserName: "admin-machine-user"
}
