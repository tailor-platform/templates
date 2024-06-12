package settings

import (
  "tailor.build/template/manifest/services/auth"
)

adminInvoker: {
	AuthNamespace: auth.Namespace
	MachineUserName : auth.MachineUsers[0].Name
}
