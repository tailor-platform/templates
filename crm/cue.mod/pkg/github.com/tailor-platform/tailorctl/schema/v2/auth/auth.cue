package auth

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"github.com/tailor-platform/tailorctl/schema/v2/secretmanager"
)

#Spec: {
	common.#WithKind
	common.#WithVersion
	common.#WithNamespace

	kind: common.#Auth
	idProviderConfigs: [...#IDProviderConfig]
	userProfileProvider:       string & !=""
	userProfileProviderConfig: [
					if (userProfileProviderConfig).kind == #UserProfileProviderType.TailorDB {#TailorDBProviderConfig},
	][0]
	if (userProfileProviderConfig).kind == #UserProfileProviderType.TailorDB {
		tailorDBProviderConfig: (userProfileProviderConfig)
	}
}

#IDProviderConfig: {
	name:   string & !=""
	config: [// see. https://cuetorials.com/patterns/switch/
		if (config).kind == #AuthType.OIDC {#OIDC},
		if (config).kind == #AuthType.SAML {#SAML},
	][0]
	if (config).kind == #AuthType.OIDC {
		oidcConfig: (config)
	}
	if (config).kind == #AuthType.SAML {
		samlConfig: (config)
	}
}

#AuthType: {
	OIDC: "OIDC"
	SAML: "SAML"
}

#OIDC: {
	kind:         #AuthType.OIDC
	clientID:     string
	clientSecret: secretmanager.#SecretValue
	providerURL:  string
}

#SAML: {
	kind:         #AuthType.SAML
	metadataURL:  string
	spCertBase64: secretmanager.#SecretValue
	spKeyBase64:  secretmanager.#SecretValue
}

#UserProfileProviderType: {
	TailorDB: "TAILORDB"
}

#TailorDBProviderConfig: {
	kind:          #UserProfileProviderType.TailorDB
	namespace:     string & !=""
	type:          string & !=""
	usernameField: string & !=""
	attributesFields: [...string] & !=null
}
