package constant

import (
	uuidlib "uuid"
	"crypto/hmac"
)

uuid: {
	#type:  string
	#value: string
	uuidlib.SHA1("{{ .Values.seed.key }}", hmac.Sign("SHA1", #type, #value))
}
