package utils

import (
	uuidlib "uuid"
	"crypto/hmac"
	"tailor.build/template/environment"
)

uuid: {
	#type:  string
	#value: string
	uuidlib.SHA1(environment.#app.seed, hmac.Sign("SHA1", #type, #value))
}
