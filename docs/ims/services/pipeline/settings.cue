package settings

import (
	"tailor.build/template/services/auth"
)

adminInvoker: {
	AuthNamespace:   auth.Namespace
	MachineUserName: auth.MachineUsers[0].Name
}
