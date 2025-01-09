package auth

import (
	"github.com/tailor-platform/tailorctl/schema/v2/auth"
)

auth.#Spec & {
	Namespace: string
	IdProviderConfigs: [auth.#IDProviderConfig]
	UserProfileProvider:       auth.#UserProfileProviderType.TailorDB
	UserProfileProviderConfig: auth.#TailorDBProviderConfig
	MachineUsers: [auth.#MachineUser]
}
