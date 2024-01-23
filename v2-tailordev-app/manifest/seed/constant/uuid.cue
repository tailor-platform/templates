package constant

import (
	uuidlib "uuid"
	"crypto/hmac"
)

Uuid: {
	#type:  string
	#value: string
	uuidlib.SHA1("43f107f1-e9c6-41d8-9b76-88efcb443d1e", hmac.Sign("SHA1", #type, #value))
}
